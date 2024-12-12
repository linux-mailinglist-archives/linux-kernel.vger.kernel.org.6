Return-Path: <linux-kernel+bounces-443450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE79EF13B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 17:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546851891D5E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F305A23024C;
	Thu, 12 Dec 2024 16:18:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF625223C72
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 16:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020339; cv=none; b=JshzdAVBq3r8NpBiTZiKxelxS73D5KkM/MHoGXoozu1CN+MaWr6MBXEDDkPFumcvsehghiUUkoy5wt/ZpqW/LMHSXTKwYvCKip+psyQJlUKcXT2ytEXryt9uIthrc3mTVuw9uso29+6CORA61wDWWNmzzC7Sf3WggMMUnSFok4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020339; c=relaxed/simple;
	bh=5c7Thk0s2GLVsuYuxXKDLRhgu+GqakS3na9Aepn3uS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F19aLnDT/dbKcvxZgN4/D1wvUf2L3PITedmjsYZAAfXD2IVbaeJjCL8ngqzr/+8rYf+sw0WCfzgTww63kzD+stNm2WmmH3FxNFa6Elli0cE1fSWd7VjcBfkbqyQizP+4jhKXTMwXfz8yKnvAYrM4JNnkk1tThRRIKY4xwzxQxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F3F01762;
	Thu, 12 Dec 2024 08:19:25 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.41])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3235F3F720;
	Thu, 12 Dec 2024 08:18:56 -0800 (PST)
Date: Thu, 12 Dec 2024 16:18:53 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Zeng Heng <zengheng4@huawei.com>
Cc: james.morse@arm.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, jonathan.cameron@huawei.com,
	xiexiuqi@huawei.com
Subject: Re: [RFC PATCH mpam mpam/snapshot/v6.12-rc1 v3 4/5] arm_mpam:
 Automatically synchronize the configuration of all sub-monitoring groups
Message-ID: <Z1sM7TMK+BHQEwgI@e133380.arm.com>
References: <20241207092136.2488426-1-zengheng4@huawei.com>
 <20241207092136.2488426-5-zengheng4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207092136.2488426-5-zengheng4@huawei.com>

Hi,

On Sat, Dec 07, 2024 at 05:21:35PM +0800, Zeng Heng wrote:
> After the system expands the narrow-partid feature and statically assigns
> all (req)PARTIDs to each control group, the following scenarios require
> configuration synchronization operations:
> 
>   1. MSCs that support narrow-partid need to establish a mapping between
>      reqPARTID and intPARTID after creating a new monitoring group.
>   2. MSCs that do not support narrow-partid need to synchronize the
>      configuration of sub-monitoring groups after users update the control
>      group configuration.
> 
> In __write_config(), we synchronize a control group's configuration to each
> sub-monitoring group.
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> ---
>  drivers/platform/arm64/mpam/mpam_devices.c  | 25 ++++++++++++++++++---
>  drivers/platform/arm64/mpam/mpam_internal.h |  3 +++
>  drivers/platform/arm64/mpam/mpam_resctrl.c  | 10 ++++++++-
>  3 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 781c9146718d..91c5849f76e3 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -1544,6 +1544,7 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>  	u32 pri_val = 0;
>  	u16 cmax = MPAMCFG_CMAX_CMAX;
>  	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
> +	u16 intpartid = req2intpartid(partid);
>  	struct mpam_msc *msc = ris->vmsc->msc;
>  	struct mpam_props *rprops = &ris->props;
>  	u16 dspri = GENMASK(rprops->dspri_wd, 0);
> @@ -1554,8 +1555,14 @@ static void mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>  
>  	if (mpam_has_feature(mpam_feat_partid_nrw, rprops)) {
>  		mpam_write_partsel_reg(msc, INTPARTID,
> -				       MPAMCFG_INTPARTID_INTERNAL | partid);
> -		__mpam_intpart_sel(ris->ris_idx, partid, msc);
> +				       MPAMCFG_INTPARTID_INTERNAL |
> +				       intpartid);
> +
> +		/* Already finish mapping reqPARTID to intPARTID */
> +		if (partid != intpartid)
> +			goto out;
> +
> +		__mpam_intpart_sel(ris->ris_idx, intpartid, msc);
>  	}
>  
>  	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {

[...]

> @@ -3072,9 +3080,20 @@ struct mpam_write_config_arg {
>  
>  static int __write_config(void *arg)
>  {
> +	int closid_num = resctrl_arch_get_num_closid(NULL);
>  	struct mpam_write_config_arg *c = arg;
> +	u32 reqpartid, req_idx;
> +
> +	WARN_ON(c->partid >= closid_num);
>  
> -	mpam_reprogram_ris_partid(c->ris, c->partid, &c->comp->cfg[c->partid]);
> +	/* Synchronize the configuration to each sub-monitoring group. */
> +	for (req_idx = 0; req_idx < get_num_reqpartid_per_closid();
> +	     req_idx++) {
> +		reqpartid = req_idx * closid_num + c->partid;
> +
> +		mpam_reprogram_ris_partid(c->ris, reqpartid,
> +					 &c->comp->cfg[c->partid]);
> +	}
>  
>  	return 0;
>  }

I haven't decided whether this iteration belongs here or in
mpam_resctrl.c.

Your approach looks like it should work; I do it in
resctrl_arch_update_one() instead [1], but I think the approaches are
pretty much equivalent -- but let me know if you have any thoughts on
it.

[...]

Cheers
---Dave


[1] [RFC PATCH 4/6] arm_mpam: Introduce flexible CLOSID/RMID translation
https://lore.kernel.org/lkml/20241212154000.330467-5-Dave.Martin@arm.com/

