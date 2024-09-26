Return-Path: <linux-kernel+bounces-340404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10569872E9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4597F1F2594A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A18D347B4;
	Thu, 26 Sep 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kI3Tbl71"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0F145FE5
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 11:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727350609; cv=none; b=YsPLz00rR1J92XYwUfPza077B450usEz+il8IDmNrydsO4vg6Po2OH5YFT11/AFWhGCkzNNvhxCEmiGDyeK1oYDWzGfUMUZaChhI4xlXRCQkjcR3lVcHMLpB5vacSxSMFlqk6knqLMWCUQ0Ysh8ur+XVp+CwvySEs1Wg8KEMzdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727350609; c=relaxed/simple;
	bh=fHmYhOAmYa508Jm4yd6j89kvwHkQ+TbtMfwycE9dsHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGaAZVo05eJI5jq2CTZoElxPMbD4JF0VL9zDJ6UfCCzxi+G7l/rUlLvN2pXormwSQUpNMwsrMjgmfLeAlmWXKVDLN4b7ljbQX2zzgWsmmFPFfdtXR5dn9wqTyviAoU7y27gAJhcZ/sts7CnX3l7yMcudYMasOtCLWHFXi33ybDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kI3Tbl71; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727350607; x=1758886607;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=fHmYhOAmYa508Jm4yd6j89kvwHkQ+TbtMfwycE9dsHw=;
  b=kI3Tbl71v10Yf/x1Erq3XXoppcTrQ+niRfvATwsbTNbP7jY2FNYfG5WS
   udhzDNqdDZaGvQcQVF3q6W/7+NUhQzitwyUAgSkt4IzitpivK4dh/m5Pa
   uYFwEEgR+byVdS7yCdDrxxuiXhLAMvsLd7g1DZI+/pqkuC4FaGf4+e1wg
   iqpo8mz27TKE1NK2oV7ebsWX/d13Fd7flO6RMpdq+pIFRMuUpbsr2/MXI
   ipLDaZR+Clfb+9eeMOaWOVV3kVXHbwYUbL5iFv/IYvDznoeegDoLxclcZ
   f6NIDXxCsK95INGveJ5Vn8+C48ZGt7FhGi4jT7p+IaqbQYnvvxVeg/mOE
   Q==;
X-CSE-ConnectionGUID: yL0HR4FuS8662lqbh969dQ==
X-CSE-MsgGUID: 6ONZWWf6RxWl9+tZ8BVf/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="25909219"
X-IronPort-AV: E=Sophos;i="6.10,155,1719903600"; 
   d="scan'208";a="25909219"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 04:36:37 -0700
X-CSE-ConnectionGUID: OF0SFb4CTNeLg+IWLALe1Q==
X-CSE-MsgGUID: vHqYSLSyT86pLvfGX93fFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76485613"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 04:36:34 -0700
Date: Thu, 26 Sep 2024 14:37:01 +0300
From: Imre Deak <imre.deak@intel.com>
To: Benjamin Hoefs <bendhoefs@gmail.com>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
	airlied@gmail.com, simona@ffwll.ch, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i915: Fix HBLANK Expansion Quirk Causing Modeset Failure
 on Dell WD19TB Dock at 3440x1440@100Hz
Message-ID: <ZvVHXbK2Swxpjehy@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20240926002533.10153-2-bendhoefs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926002533.10153-2-bendhoefs@gmail.com>

On Wed, Sep 25, 2024 at 07:25:34PM -0500, Benjamin Hoefs wrote:
> Hello,
> 
> I am using a Dell WD19TB dock with a 3440x1440 monitor. Using it at
> 100Hz used to work but recently I tried it again and discovered it no longer
> did, specifically the modeset seems to silently fail with no error message in
> userspace utilities like kscreen-doctor and xrandr and no output in dmesg.
> I found the problematic commit using git bisect to be
> 55eaef164174480df6827edeac15620f3cbcd52b "Handle the Synaptics HBlank
> expansion quirk".
> 
> I found the issue to be the hblank_expasion_quirk_needs_dsc function which uses
> the following comparison in the current kernel tree:
> 
> if (mode_hblank_period_ns(adjusted_mode) > hblank_limit)
> 	return false;
> 
> with hblank_limit being earlier set as
> 
> int hblank_limit = is_uhbr_sink ? 500 : 300;
> 
> However, my monitor's HBLANK period in the 3440x1440@100Hz mode is
> exactly 300 ns as verified by this printk immediately before the
> problematic comparison.
> 
> printk(KERN_INFO "Hello, kernel world! %i\n",
> 	mode_hblank_period_ns(adjusted_mode));
> [   38.429839] Hello, kernel world! 300
> 
> With the attached change the modeset works as expected at 100Hz. Would it be
> acceptable to modify the comparison from > to >= here?
> 
> I'll do my best to provide any additional details you may need although
> that printk and '=' sign is the only kernel code I've written, so my best may
> not be great :).
> 
> Signed-off-by: Benjamin D. Hoefs <bendhoefs@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_dp_mst.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> index 15541932b809..052c5a67df93 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
> @@ -446,7 +446,7 @@ hblank_expansion_quirk_needs_dsc(const struct intel_connector *connector,
>  	if (is_uhbr_sink && !drm_dp_is_uhbr_rate(limits->max_rate))
>  		return false;
>  
> -	if (mode_hblank_period_ns(adjusted_mode) > hblank_limit)
> +	if (mode_hblank_period_ns(adjusted_mode) >= hblank_limit)
>  		return false;

Disabling DSC this way could make another mode with the same hblank
period not work. This mode would require DSC in any case if there is a
link BW limitation, so would need to check why DSC is failing. Could you
open a ticket at:

https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/new

attaching a dmesg log booting with drm.debug=0x15e?

Thanks,
Imre

>  
>  	return true;
> -- 
> 2.46.2
> 

