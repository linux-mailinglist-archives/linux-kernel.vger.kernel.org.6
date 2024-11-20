Return-Path: <linux-kernel+bounces-416127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671E9D4099
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF28282548
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40947153BEE;
	Wed, 20 Nov 2024 16:55:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778C3146D57
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121710; cv=none; b=AwaAECjL3iMA/ObTG0RujIK7IRegMr4Xi2KekDBDwvejh81DvlJVxmmQQ2iy9QvhRXZ0AxEpNH098XFcHT7RBCI0hRFbiMSm5nzp09aeaIlKF+pLbQyd2LzRhnN/vV1iSK0KrtjBFPCMfF0lasS14DlnWJt6BkFvu6JI87ayVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121710; c=relaxed/simple;
	bh=q+tle++Qrkq5T2n4gB+GAFWKdVGxJE71vijQfY4KJYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDJT0BoYAuXvBx8VEb3YnOsMnmf8xVOI/uBeO4wDEJevByOKP2jobmC58f24SB5pdlaT82NwZTdgolKO3ThgOa9tYXwf26IxHueUA+D/Zcvh28idwmdNHVvaDdcoZN2+a0wpD97sSx+adqcEVbpqMOyOkKnLRqDyWOLqC8ONeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B5C1480;
	Wed, 20 Nov 2024 08:55:37 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B813F66E;
	Wed, 20 Nov 2024 08:55:06 -0800 (PST)
Message-ID: <bb01b83a-32cb-4efe-b9d6-06a4cf138b3b@arm.com>
Date: Wed, 20 Nov 2024 16:55:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/arm-cmn: Fix arm_cmn_node_to_xp()
To: Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Stephane Eranian <eranian@google.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org
References: <20241120164110.266297-1-namhyung@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241120164110.266297-1-namhyung@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 4:41 pm, Namhyung Kim wrote:
> The portid_bits and deviceid_bits for XP type nodes are set in the
> arm_cmn_discover() and it's copied to others in arm_cmn_init_dtcs().
> But to get the XP from a node in the arm_cmn_init_dtcs(), it needs
> the {port,device}id_bits.
> 
> This makes arm-cmn PMU failing to count events on my setup.  What we
> need is the number of bits in total which is known by the cmn config.

Hmm, what about just moving the assignment to a point where it actually
makes more sense anyway?

Cheers,
Robin.

----->8-----
diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 397a46410f7c..30506c43776f 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2178,8 +2178,6 @@ static int arm_cmn_init_dtcs(struct arm_cmn *cmn)
  			continue;
  
  		xp = arm_cmn_node_to_xp(cmn, dn);
-		dn->portid_bits = xp->portid_bits;
-		dn->deviceid_bits = xp->deviceid_bits;
  		dn->dtc = xp->dtc;
  		dn->dtm = xp->dtm;
  		if (cmn->multi_dtm)
@@ -2420,6 +2418,8 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
  			}
  
  			arm_cmn_init_node_info(cmn, reg & CMN_CHILD_NODE_ADDR, dn);
+			dn->portid_bits = xp->portid_bits;
+			dn->deviceid_bits = xp->deviceid_bits;
  
  			switch (dn->type) {
  			case CMN_TYPE_DTC:

