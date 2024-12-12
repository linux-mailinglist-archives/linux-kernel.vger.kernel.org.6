Return-Path: <linux-kernel+bounces-443449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4489EF17D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB791777F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5819F22F395;
	Thu, 12 Dec 2024 16:18:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B7B22EA18
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020298; cv=none; b=hv3rm5HbcjJY3QGfvT534zokOq0AzKB0rPkdF6bl6sqd2CYXskBoApwUGucNsQhyA0gzfXEnithBPDicXpPNzhy8odWMUU1tJ60gLQfhDrUZxSWujatvZTpZbdd0OBcYZsCCT4amo3lec8NMRf2sb3Mkl9eeYsEjEekmaQ8E1bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020298; c=relaxed/simple;
	bh=/gXX1kJT4JZRBkCiY3wZbxrFb2bugjozg/ReCcZugdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiL7bjPjhQhKjBxmk2twu4Tq3VRwq5BeYdjfUYvimcDt7EHM8zofhdZm283o6WddB07MX2wH452ozH17ZXVWv/I+dOKsjppJToBrAtOHXTJmZIPD4paTtVJIXvkypD3IeXWTVRwXPofivaNbw3VeEX7beBq+Uwx419cqSGm4mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7CAE1762;
	Thu, 12 Dec 2024 08:18:43 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AF873F720;
	Thu, 12 Dec 2024 08:18:14 -0800 (PST)
Date: Thu, 12 Dec 2024 16:18:12 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: james.morse@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
	xiexiuqi@huawei.com
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 2/5] arm_mpam: Read
 monitor value with new closid/rmid pair
Message-ID: <Z1sMxKM9o6lAiZGr@e133380.arm.com>
References: <20241207092136.2488426-1-zengheng4@huawei.com>
 <20241207092136.2488426-3-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241207092136.2488426-3-zengheng4@huawei.com>

Hi,

On Sat, Dec 07, 2024 at 05:21:33PM +0800, Zeng Heng wrote:
> The MPAM driver statically assigns all reqPARTIDs to respective intPARTIDs.
> For the new rmid allocation strategy, it will check if there is an
> available rmid of any reqPARTID which belongs to the input closid, not just
> the rmids belonging to the closid.
> 
> For a mixture of MSCs system, for MSCs that do not support narrow-partid,
> we use the PARTIDs exceeding the number of closids as reqPARTIDs for
> expanding the monitoring groups.
> 
> In order to keep the existing resctrl API interface, the rmid contains both
> req_idx and PMG information instead of PMG only under the MPAM driver. The
> req_idx represents the req_idx-th sub-monitoring group under the control
> group. The new rmid would be like:
> 
>     rmid = (req_idx << shift | pmg).
> 
> The mapping relationships between each group's closid/rmid and the
> respective MSCs' intPARTID/reqPARTID/PARTID are illustrated:
> 
> n - Indicates the total number of intPARTIDs
> m - Indicates the number of reqPARTIDs per intPARTID
> 
> P - Partition group (control group)
> M - Monitoring group
> 
> Group closid rmid.req_idx (req)PARTID      MSCs with narrow-partid  MSCs without narrow-partid
> P1    0      -            0                   intPARTID_1              PARTID_1
> M1_1  0      0            0                       ├── reqPARTID_1_1       ├── PARTID_1_1
> M1_2  0      1            0+n                     ├── reqPARTID_1_2       ├── PARTID_1_2
> M1_3  0      2            0+n*2                   ├── reqPARTID_1_3       ├── PARTID_1_3
>  ...                                              ├── ...                 ├── ...
> M1_m  0      (m-1)        0+n*(m-1)               └── reqPARTID_1_m       └── PARTID_1_m
> 
> P2    1      -            1                   intPARTID_2              PARTID_2
> M2_1  1      0            1                       ├── reqPARTID_2_1       ├── PARTID_2_1
> M2_2  1      1            1+n                     ├── reqPARTID_2_2       ├── PARTID_2_2
> M2_3  1      2            1+n*2                   ├── reqPARTID_2_3       ├── PARTID_2_3
>  ...                                              ├── ...                 ├── ...
> M2_m  1      (m-1)        1+n*(m-1)               └── reqPARTID_2_m       └── PARTID_2_m
> 
> Pn    (n-1)  -            (n-1)               intPARTID_n              PARTID_n
> Mn_1  (n-1)  0            (n-1)                   ├── reqPARTID_n_1       ├── PARTID_n_1
> Mn_2  (n-1)  1            (n-1)+n                 ├── reqPARTID_n_2       ├── PARTID_n_2
> Mn_3  (n-1)  2            (n-1)+n*2               ├── reqPARTID_n_3       ├── PARTID_n_3
>  ...                                              ├── ...                 ├── ...
> Mn_m  (n-1)  (m-1)        (n-1)+n*(m-1) = n*m-1   └── reqPARTID_n_m       └── PARTID_n_m
> 
> Based on the example provided, the conversion relationship between
> closid/rmid and (req)PARTID/PMG is:
> 
>     (req)PARTID = (rmid.req_idx * n) + closid,
>     PMG = rmid.pmg.

It seemed more natural to me for the PARTIDs assigned to a particular
CLOSID to be consecutively numbered (see [1]), though it works either
way.

Otherwise, the approach makes sense.

[...]

Cheers
---Dave


[1] [RFC PATCH 4/6] arm_mpam: Introduce flexible CLOSID/RMID translation
https://lore.kernel.org/lkml/20241212154000.330467-5-Dave.Martin@arm.com/

