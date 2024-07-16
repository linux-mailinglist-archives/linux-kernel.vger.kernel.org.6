Return-Path: <linux-kernel+bounces-253596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BC7932390
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD4F1C22680
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CC198A29;
	Tue, 16 Jul 2024 10:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT7XVbXh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D3F6AC0;
	Tue, 16 Jul 2024 10:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124365; cv=none; b=OmllaC+NEpJ4ZSIPYPDcz2rbxvHjwIMcCmnOwjXQ4X/gYYPxnGqCqiuj30wLG2Twxx4E7jCOQoTM5UJqC9BGdHw+jlB39PAogqYuQUb+zF11+DRi28GqjfevBdJMIfkyuSPSdfbygsMj1pmOg0Vgafa2NH25TDvKdSNDhHTOar0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124365; c=relaxed/simple;
	bh=7Je4r6J/rVt1cCSpGFSMPBTnFBFUP3kwG5lk3jKrJfA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=U5qvyGMDamjRwkINxYExMhw6tHb8ljenvePQdmaNMy+Rv5zftGCGr21ijc8iRyVK1dWNcqBayvqjsPNuE0mc5jN2w5l6qIWVFE2bCu7qK4rtmPNo8rTK+FHET2X3qyZdvO6MLyJcez86BCaf3JG63TW9Sl4EQYhldSSKcdK3SwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT7XVbXh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721124364; x=1752660364;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7Je4r6J/rVt1cCSpGFSMPBTnFBFUP3kwG5lk3jKrJfA=;
  b=iT7XVbXh+qxVlXvLaF3+bAjsv050sHt4RqHteTUDi5oYFdy/XACj/7Ne
   DdgPqYVdDuHUaGLtpq6FLSeq6g/GiQmExkqG75d7psOEX86UV04pyoN9F
   Fc5bcTK+hyEa9dNuJQBdJjW6+pze8iQqctn7r9tTGtSUsYd98QXQu5q/+
   MX9lm33s9tGXVozOjNhKPPpFok9Azo4wZtP96BN1aBPtFUa1EGr+J3JAx
   eU7Sm9Zb8iSGGidtLfgsPvUgBoOSIkBqcqba3Zbv+ya+7mqkkyo72B3MF
   +4cSQg18qlEo2xcy9UsrcgFcNC2exa1lYDNWb5WLieuVf85GJ4UghqjAA
   A==;
X-CSE-ConnectionGUID: nvVysU/yS76CmwG0yNSdfA==
X-CSE-MsgGUID: 5zVIpd/bSmipVWV7lm7+zA==
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="18704562"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="18704562"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:06:03 -0700
X-CSE-ConnectionGUID: /p3ltqYCT4W0EIObD9DgaA==
X-CSE-MsgGUID: 36xaE1h/R+C70hzmtNV6Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="54798937"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.133])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2024 03:06:01 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 16 Jul 2024 13:05:57 +0300 (EEST)
To: Dan Carpenter <dan.carpenter@linaro.org>
cc: Tero Kristo <tero.kristo@linux.intel.com>, 
    Hans de Goede <hdegoede@redhat.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] platform/x86/intel/tpmi/plr: Fix output in
 plr_print_bits()
In-Reply-To: <b0084e70-4144-445a-9b89-fb19f6b8336a@stanley.mountain>
Message-ID: <9c74d6ac-56e4-a79b-6d05-705a17561a3d@linux.intel.com>
References: <b0084e70-4144-445a-9b89-fb19f6b8336a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jul 2024, Dan Carpenter wrote:

> Smatch complains that 'str' can be used without being initialized:
> 
>     drivers/platform/x86/intel/intel_plr_tpmi.c:178 plr_print_bits()
>     error: uninitialized symbol 'str'.
> 
> In this loop, we iterate over all the set bits and print the name of the
> bit.  The intention is that if there is a bit which is between 0-31 we
> look for the name in the first array plr_coarse_reasons[] which has 10
> elements.  If the bit is in the 32-63 range we look for it in the
> plr_fine_reasons[] array which has 30 elements.  If the bit is in the
> invalid ranges, 10-31 or 62-63, then we should print "UNKNOWN(%d)".
> 
> The problem is that 'str' needs to be initialized at the start of each
> iteration, otherwise if we can't find the string then instead of printing
> "UNKNOWN(%d)", we will re-print whatever the previous bit was.
> 
> Fixes: 9e9397a41b7b ("platform/x86/intel/tpmi/plr: Add support for the plr mailbox")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: initialize str at the start of each iteration

Thanks for the update, I've applied this fix now (will go along with the 
for-next PR to Linus).

-- 
 i.

> 
>  drivers/platform/x86/intel/intel_plr_tpmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/intel_plr_tpmi.c b/drivers/platform/x86/intel/intel_plr_tpmi.c
> index c1aa52c23d25..69ace6a629bc 100644
> --- a/drivers/platform/x86/intel/intel_plr_tpmi.c
> +++ b/drivers/platform/x86/intel/intel_plr_tpmi.c
> @@ -162,10 +162,11 @@ static int plr_clear_cpu_status(struct tpmi_plr_die *plr_die, int cpu)
>  static void plr_print_bits(struct seq_file *s, u64 val, int bits)
>  {
>  	const unsigned long mask[] = { BITMAP_FROM_U64(val) };
> -	const char *str;
>  	int bit, index;
>  
>  	for_each_set_bit(bit, mask, bits) {
> +		const char *str = NULL;
> +
>  		if (bit < PLR_COARSE_REASON_BITS) {
>  			if (bit < ARRAY_SIZE(plr_coarse_reasons))
>  				str = plr_coarse_reasons[bit];
> 


