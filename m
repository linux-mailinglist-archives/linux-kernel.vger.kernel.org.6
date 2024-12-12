Return-Path: <linux-kernel+bounces-443448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 842ED9EF12B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3321886B9B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204AE22EA00;
	Thu, 12 Dec 2024 16:18:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD0D21766D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020287; cv=none; b=ryLR09oMLN5vSgqGi4N8YRoBu8eOtetvXbPVp7AAIzY5Qs+N0vBCFBSyi5E276cgCMqTRRT2khDJ9JhohyBQvYlGuxxNqDhN6FvD6jRHQIBwzSUUua0gZcAorxbqGIkLVEBjE2+n/gPeIuPYoExHHAmeB6ZZENNulnO+PtkymE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020287; c=relaxed/simple;
	bh=xgevdLwGTNobjsQOMjR47GjZl2x6LSdkJTVXoShkNrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNSsAcUj8LehKzWKcpU1MlUyEVKwG2L5Ex2yeJPWa56yAEQ/JlV4O1QwyUFr+CKI728ty/b2Lk3x9vfzwxbZKuN9QGT+ltGnIfwnXMyigyLhfrybppYa+kbuYfnZQpzT549m9w18VJla2CjtoEXGyZ08nCDr9njVRxriRVW6ph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A6081764;
	Thu, 12 Dec 2024 08:18:28 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B6213F720;
	Thu, 12 Dec 2024 08:17:59 -0800 (PST)
Date: Thu, 12 Dec 2024 16:17:56 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: james.morse@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
	xiexiuqi@huawei.com
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 0/5] arm_mpam:
 Introduce the Narrow-PARTID feature for MPAM driver
Message-ID: <Z1sMtF9bvw5NZOC6@e133380.arm.com>
References: <20241207092136.2488426-1-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207092136.2488426-1-zengheng4@huawei.com>

Hi,

On Sat, Dec 07, 2024 at 05:21:31PM +0800, Zeng Heng wrote:
> The patch set is applied for mpam/snapshot/v6.12-rc1 branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> repository.
> 
> The narrow-partid feature in MPAM allows for a more efficient use of
> PARTIDs by enabling a many-to-one mapping of reqpartids (requested PARTIDs)
> to intpartids (internal PARTIDs). This mapping reduces the number of unique
> PARTIDs needed, thus allowing more tasks or processes to be monitored and
> managed with the available resources.
> 
> For a mixture of MSCs system, for MSCs that do not support narrow-partid,
> we use the PARTIDs exceeding the number of closids as reqPARTIDs for
> expanding the monitoring groups.

Mixed systems still seem not to be handled completely by this series?

You do cope with the scenario where some MSCs support Narrowing and
some do not, but there is still the problem of incompatible controls.

If a non-Narrowing MSC has controls that are not of the "partition
bitmap" type, then splitting a resctrl control group across multiple
PARTIDs is going to change the hardware regulation behaviour.  There
does not seem to be any way to work around this be programming
different control values (for example).  So, there may be over- or
under-allocation of resources compared with what the user requests in
resctrlfs.

So, I think there is still a need to check which controls are present,
and either disable the use of non-identity intPARTID<->reqPARTID
mappings if incompatible controls are present (or don't expose those
controls to resctrl).

(If you were not trying to address this issue yet then that is not a
problem for an RFC, but it is best to be clear about the
limitations...)

> In order to keep the existing resctrl API interface, the rmid contains both
> req_idx and PMG information instead of PMG only under the MPAM driver. The
> req_idx represents the req_idx-th sub-monitoring group under the control
> group. The new rmid would be like:
> 
>     rmid = (req_idx << shift | pmg).
> 
> The new conversion relationship between closid/rmid and (req)PARTID/PMG is:
> 
>     (req)PARTID = (rmid.req_idx * n) + closid,
>     PMG = rmid.pmg.
> 
> Each intPARTID has m reqPARTIDs, which are used to expand the number of
> monitoring groups under the control group. Therefore, the number of
> monitoring groups is no longer limited by the range of MPAM PMG, which
> enhances the extensibility of the system's monitoring capabilities.
> 
> ---
> Compared with v1:
>   - Rebase this patch set on latest MPAM driver of the v6.12-rc1 branch.
> 
> Compared with v2:
>   - Refactor closid/rmid pair translation
>   - Simplify the logic of synchronize configuration
>   - Remove reqPARTID pool
> ---

This approach looks reasonable overall, and in this version the changes
do seem to be better localised in the mpam_resctrl.c glue code now.

I had also been working on a similar approach, so I have posted it for
comparison [1] -- though the two approaches are doing pretty much the
same thing, some details differ.

(Note, I have not addressed PARTID Narrowing at all yet; however,
I think more thought is needed for that.)


Note: Are there bisection issues with some of the patches in the
series?  It looks like not all of the ID conversions are applied in the
same patch, so I'm wondering whether strange behaviour may be seen at
the intermediate commits.

Cheers
---Dave


[1] [RFC PATCH 0/6] Introduce flexible CLOSID/RMID translation
https://lore.kernel.org/lkml/20241212154000.330467-1-Dave.Martin@arm.com/

