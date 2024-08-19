Return-Path: <linux-kernel+bounces-291838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3599B9567D3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE072835C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151315E5BE;
	Mon, 19 Aug 2024 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKZ7IzIH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE9B155337
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062043; cv=none; b=u2zzHD8GeIPawQkVK40ghiVPIsHyNBXjF2QHMhnyZpDVlAWS5IqAVI6c/v+0n9L93u2UGesWpOoKXyZK23664HfZBQJuTY5XJIbV5nDN9FYeWGBHKxHSkUUV6NCBJYo0/Vy28nLD1zl8X0T/PwKqSw4OcUQR/5wpGtzQ+AA8+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062043; c=relaxed/simple;
	bh=OTZqu9i8iFAKDxGxV/EGk1joxUnibpwyhSnuvyz/Glo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=szCPBhcC63sHvY8aX5CQPeRSoGaI2Zt+GiagsiZkOPyTZv5wYeO4rCy9Z8g19rlKV3PqYD/iuyKA2Sa0o+nJJd6QqmZbwbB0FNQ479+x++crdbBqZEBPFneGAA4uBb2FceFMG94ZYGsuwEYdVlJz6wX4nOYwXaAdNKKfMJ8vELA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DKZ7IzIH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724062039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EysrvIUMNy8xKCLx+ThI/nbWm4SjR6GBQthz7OLg1Ks=;
	b=DKZ7IzIH80RWKjeubPZt5Xi75Yf6Dxi1DWx/EGE+bMIZc3B3N+Eo5wPPj9TCNJVNeOrC67
	+kq+eDP6kyulkjU7IPZKPI23SUUrFURGKu2rV0VJEkwwDMNZGcW1CA84UiqUUD7TVsLvwU
	RkecomOoJIWcg9CnsgkviZg04+nIq8E=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-jfLZpQn-OWuHml5UiBLxRg-1; Mon, 19 Aug 2024 06:07:18 -0400
X-MC-Unique: jfLZpQn-OWuHml5UiBLxRg-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f0276170f9so32520701fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724062037; x=1724666837;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EysrvIUMNy8xKCLx+ThI/nbWm4SjR6GBQthz7OLg1Ks=;
        b=qMpOBxZ1oJQW1LUvQIcTAsq4DxsTkr0YUN7JOG1KxxKbv/liVwoav/CQT6xTVRA+3U
         tsqfHWVEMXNtLNjeyGpRyQlLOyRH0hZxaTGT5E2hc/ha9niwlPlRcGFxi4uXqMjMs+ey
         XhzyhN5DIEgvsJHbJDo8EgNdvpuc1spRu8SUq9TK/rs+EMTPGBOxMRN7OIK++0odxRHe
         DS5t9Dy/yHnHHZ4ulZ2Oyiqr1674xHv31+boCkrbwf3qG6uBkrXjfQKK3l7gNPAeDV39
         6yw/StfVXkBQkcKoYWov9uNERIDMKF7eWIBxI4k1IsvRZXvHtZDEIlwAb0kfctQV8KuQ
         FjIg==
X-Forwarded-Encrypted: i=1; AJvYcCVGPUgNt2N0t9Ve9Rx0JTD72d+z2xPoNn7Iyuqsgg2JE7Jiil5M6L1g6o+0EzYZiXsITd9ZOzqns2oYBM3SV1lrYVOTomNyJfjVP8pV
X-Gm-Message-State: AOJu0YxOzYMlClPv3x5QaQSa5mVLy1z9FVZijoRoEDIj1pzyx69Nf6Ul
	whXVAyzdUz+FIBSfva+xaw6y1z9E2WgBMjWUtdI/cbNYG0QcCFQ6gVTaVKBAcdHbqLWx8CCUQ0q
	isCLtowEq099EnQRG//ReBEa6qFCVNKSCTOGm0UoX4hYj19lFPVLDFx3xpF2rfw==
X-Received: by 2002:a2e:a9a0:0:b0:2f3:cabc:6158 with SMTP id 38308e7fff4ca-2f3cabc61b1mr52175261fa.11.1724062036877;
        Mon, 19 Aug 2024 03:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTmhw3ITrEcIYKIb9VYX/r0K+S8SOMAw2LuUQxopyVE1WDUaUhvcIikl2IOIXVop8d3wWtIg==
X-Received: by 2002:a2e:a9a0:0:b0:2f3:cabc:6158 with SMTP id 38308e7fff4ca-2f3cabc61b1mr52174991fa.11.1724062036210;
        Mon, 19 Aug 2024 03:07:16 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfa4f1sm5371237a12.43.2024.08.19.03.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 03:07:15 -0700 (PDT)
Message-ID: <4012a5af-c575-4c83-857b-2e922c3cd1de@redhat.com>
Date: Mon, 19 Aug 2024 12:07:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] platform/x86: intel/pmc: Remove unused param idx from
 pmc_for_each_mode()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Xi Pardee <xi.pardee@linux.intel.com>,
 Rajvi Jingar <rajvi.jingar@linux.intel.com>,
 Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
 David E Box <david.e.box@intel.com>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kane Chen <kane.chen@intel.com>, =?UTF-8?Q?Marek_Ma=C5=9Blanka?=
 <mmaslanka@google.com>
References: <20240806083047.1562-1-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240806083047.1562-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/6/24 10:30 AM, Ilpo Järvinen wrote:
> pmc_for_each_mode() takes i (index) variable name as a parameter but
> the loop index is not used by any of the callers. Make the index
> variable internal to pmc_for_each_mode().
> 
> This also changes the loop logic such that ->lpm_en_modes[] is never
> read beyond num_lpm_modes.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
>  drivers/platform/x86/intel/pmc/core.c       | 18 +++++++-----------
>  drivers/platform/x86/intel/pmc/core.h       | 10 ++++++----
>  drivers/platform/x86/intel/pmc/core_ssram.c |  4 ++--
>  3 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/pmc/core.c b/drivers/platform/x86/intel/pmc/core.c
> index 01ae71c6df59..0e88a89a236a 100644
> --- a/drivers/platform/x86/intel/pmc/core.c
> +++ b/drivers/platform/x86/intel/pmc/core.c
> @@ -728,12 +728,11 @@ static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	const int lpm_adj_x2 = pmc->map->lpm_res_counter_step_x2;
>  	u32 offset = pmc->map->lpm_residency_offset;
> -	unsigned int i;
>  	int mode;
>  
>  	seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
>  
> -	pmc_for_each_mode(i, mode, pmcdev) {
> +	pmc_for_each_mode(mode, pmcdev) {
>  		seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
>  			   adjust_lpm_residency(pmc, offset + (4 * mode), lpm_adj_x2));
>  	}
> @@ -787,11 +786,10 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>  static void pmc_core_substate_req_header_show(struct seq_file *s, int pmc_index)
>  {
>  	struct pmc_dev *pmcdev = s->private;
> -	unsigned int i;
>  	int mode;
>  
>  	seq_printf(s, "%30s |", "Element");
> -	pmc_for_each_mode(i, mode, pmcdev)
> +	pmc_for_each_mode(mode, pmcdev)
>  		seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
>  
>  	seq_printf(s, " %9s |\n", "Status");
> @@ -833,14 +831,14 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  			u32 req_mask = 0;
>  			u32 lpm_status;
>  			const struct pmc_bit_map *map;
> -			int mode, idx, i, len = 32;
> +			int mode, i, len = 32;
>  
>  			/*
>  			 * Capture the requirements and create a mask so that we only
>  			 * show an element if it's required for at least one of the
>  			 * enabled low power modes
>  			 */
> -			pmc_for_each_mode(idx, mode, pmcdev)
> +			pmc_for_each_mode(mode, pmcdev)
>  				req_mask |= lpm_req_regs[mp + (mode * num_maps)];
>  
>  			/* Get the last latched status for this map */
> @@ -863,7 +861,7 @@ static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
>  				seq_printf(s, "pmc%d: %26s |", pmc_index, map[i].name);
>  
>  				/* Loop over the enabled states and display if required */
> -				pmc_for_each_mode(idx, mode, pmcdev) {
> +				pmc_for_each_mode(mode, pmcdev) {
>  					bool required = lpm_req_regs[mp + (mode * num_maps)] &
>  							bit_mask;
>  					seq_printf(s, " %9s |", required ? "Required" : " ");
> @@ -925,7 +923,6 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>  {
>  	struct pmc_dev *pmcdev = s->private;
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
> -	unsigned int idx;
>  	bool c10;
>  	u32 reg;
>  	int mode;
> @@ -939,7 +936,7 @@ static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void *unused)
>  		c10 = true;
>  	}
>  
> -	pmc_for_each_mode(idx, mode, pmcdev) {
> +	pmc_for_each_mode(mode, pmcdev) {
>  		if ((BIT(mode) & reg) && !c10)
>  			seq_printf(s, " [%s]", pmc_lpm_modes[mode]);
>  		else
> @@ -960,7 +957,6 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
>  	struct pmc *pmc = pmcdev->pmcs[PMC_IDX_MAIN];
>  	bool clear = false, c10 = false;
>  	unsigned char buf[8];
> -	unsigned int idx;
>  	int m, mode;
>  	u32 reg;
>  
> @@ -979,7 +975,7 @@ static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
>  	mode = sysfs_match_string(pmc_lpm_modes, buf);
>  
>  	/* Check string matches enabled mode */
> -	pmc_for_each_mode(idx, m, pmcdev)
> +	pmc_for_each_mode(m, pmcdev)
>  		if (mode == m)
>  			break;
>  
> diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
> index ea04de7eb9e8..c8851f128adc 100644
> --- a/drivers/platform/x86/intel/pmc/core.h
> +++ b/drivers/platform/x86/intel/pmc/core.h
> @@ -604,10 +604,12 @@ int lnl_core_init(struct pmc_dev *pmcdev);
>  void cnl_suspend(struct pmc_dev *pmcdev);
>  int cnl_resume(struct pmc_dev *pmcdev);
>  
> -#define pmc_for_each_mode(i, mode, pmcdev)		\
> -	for (i = 0, mode = pmcdev->lpm_en_modes[i];	\
> -	     i < pmcdev->num_lpm_modes;			\
> -	     i++, mode = pmcdev->lpm_en_modes[i])
> +#define pmc_for_each_mode(mode, pmcdev)						\
> +	for (unsigned int __i = 0, __cond;					\
> +	     __cond = __i < (pmcdev)->num_lpm_modes,				\
> +	     __cond && ((mode) = (pmcdev)->lpm_en_modes[__i]),			\
> +	     __cond;								\
> +	     __i++)
>  
>  #define DEFINE_PMC_CORE_ATTR_WRITE(__name)				\
>  static int __name ## _open(struct inode *inode, struct file *file)	\
> diff --git a/drivers/platform/x86/intel/pmc/core_ssram.c b/drivers/platform/x86/intel/pmc/core_ssram.c
> index 1bde86c54eb9..9eea5118653b 100644
> --- a/drivers/platform/x86/intel/pmc/core_ssram.c
> +++ b/drivers/platform/x86/intel/pmc/core_ssram.c
> @@ -45,7 +45,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
>  	struct telem_endpoint *ep;
>  	const u8 *lpm_indices;
>  	int num_maps, mode_offset = 0;
> -	int ret, mode, i;
> +	int ret, mode;
>  	int lpm_size;
>  	u32 guid;
>  
> @@ -116,7 +116,7 @@ static int pmc_core_get_lpm_req(struct pmc_dev *pmcdev, struct pmc *pmc)
>  	 *
>  	 */
>  	mode_offset = LPM_HEADER_OFFSET + LPM_MODE_OFFSET;
> -	pmc_for_each_mode(i, mode, pmcdev) {
> +	pmc_for_each_mode(mode, pmcdev) {
>  		u32 *req_offset = pmc->lpm_req_regs + (mode * num_maps);
>  		int m;
>  


