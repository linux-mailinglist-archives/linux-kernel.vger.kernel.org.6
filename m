Return-Path: <linux-kernel+bounces-343510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D245E989BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0571F21E93
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7FE166307;
	Mon, 30 Sep 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFxsZCR1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4546444;
	Mon, 30 Sep 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682539; cv=none; b=jSeBKmXJseqJHOW2F5qhbIF5RdD9HpWhWGjUqGYoJcFpiMznFXvg33zHDdS9D/XvLck6TfaihJPP/QRgHybYH5NZEeSaHcujuKT2EnEw3aLgavOQZnYzLcDyukbPDW2/MxgEDTu7KDEYLj3xFOzKB1fMkMJw5BI+QJ+26zxlXKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682539; c=relaxed/simple;
	bh=zvzbxn+mDopH60Mg8MZIR09IClL8g+7ALytdl8oKYhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qNhd0rnEZSMMb4zbrwlpAEThUWLTKmUMY019CxS9OShg8p1AbrySwzDV3lOVA3iK6/b/v6bGbwXn/g7qzdEsbP0TO274wzmQZFTT0lMceHTRG2R3PQCjnwpIYx+vQuY9X3WEcw9/SpNWS7QAq4/8VEcxGDlgCFJMQXH+FsOz2L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFxsZCR1; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727682538; x=1759218538;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=zvzbxn+mDopH60Mg8MZIR09IClL8g+7ALytdl8oKYhA=;
  b=SFxsZCR15Pd1BydibTuQVB48JNwGQjasDY5/luddq6+hq60Tfua+WkyU
   GhjetdiNeoU3j/oH1Oh+MsL/9XLEz/y7vJpEsFkZJZu7/MgQdb6Tuossm
   QMwnbyYUIB2ognLkBqzITphW7Q7UuSb9cd3yoPlvcej+zvbCs+4DLvZl/
   VFl2fWv+DcxbTLB2h+X1TMuFtoNVfkLY3W4k38yKF9xWqaebHZnrgrgTR
   juFIodYny8x4q6uz9Px2m+hnbFiGR1SXPc2mfpN9C0P21J/ODvnBRiygZ
   0kIvEtzrcdj2UPtrxVV/7VueYOlm/xRX/VROTrplBjrLvCmrplCgEKWDa
   g==;
X-CSE-ConnectionGUID: 0Cc1FeVyQNWdZ5VGh4NjXw==
X-CSE-MsgGUID: phFkhAEERdKiy0fqPQws6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="52169359"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="52169359"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:48:57 -0700
X-CSE-ConnectionGUID: O4A1Vo/LSOKMYlzFkVkL/g==
X-CSE-MsgGUID: 7hVfw1pkS5e4+GPyCYIeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78172226"
Received: from mklonows-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.93])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 00:48:53 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/backlight: Remove a useless kstrdup_const()
In-Reply-To: <3b3d3af8739e3016f3f80df0aa85b3c06230a385.1727533674.git.christophe.jaillet@wanadoo.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <3b3d3af8739e3016f3f80df0aa85b3c06230a385.1727533674.git.christophe.jaillet@wanadoo.fr>
Date: Mon, 30 Sep 2024 10:48:40 +0300
Message-ID: <875xqdy42v.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 28 Sep 2024, Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> "name" is allocated and freed in intel_backlight_device_register().
> The initial allocation just duplicates "intel_backlight".
>
> Later, if a device with this name has already been registered, another
> dynamically generated one is allocated using kasprintf().
>
> So at the end of the function, when "name" is freed, it can point either to
> the initial static literal "intel_backlight" or to the kasprintf()'ed one.
>
> So kfree_const() is used.
>
> However, when built as a module, kstrdup_const() and kfree_const() don't
> work as one would expect and are just plain kstrdup() and kfree().
>
>
> Slightly change the logic and introduce a new variable to hold the
> address returned by kasprintf() should it be used.
>
> This saves a memory allocation/free and avoids these _const functions,
> which names can be confusing when used with code built as module.

Okay, I'd rather revert your earlier commit 379b63e7e682
("drm/i915/display: Save a few bytes of memory in
intel_backlight_device_register()") than add this.

The code simplicity is much more important than saving a few bytes.

BR,
Jani.



>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>
> For the records, this patch is a clean-up effort related to discussions at:
>   - https://lore.kernel.org/all/ZvHurCYlCoi1ZTCX@skv.local/
>   - https://lore.kernel.org/all/20240924050937.697118-1-senozhatsky@chromium.org/
> ---
>  drivers/gpu/drm/i915/display/intel_backlight.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
> index 9e05745d797d..bf7686aa044f 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -914,9 +914,9 @@ int intel_backlight_device_register(struct intel_connector *connector)
>  {
>  	struct drm_i915_private *i915 = to_i915(connector->base.dev);
>  	struct intel_panel *panel = &connector->panel;
> +	const char *name, *new_name = NULL;
>  	struct backlight_properties props;
>  	struct backlight_device *bd;
> -	const char *name;
>  	int ret = 0;
>  
>  	if (WARN_ON(panel->backlight.device))
> @@ -949,10 +949,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
>  	else
>  		props.power = BACKLIGHT_POWER_OFF;
>  
> -	name = kstrdup_const("intel_backlight", GFP_KERNEL);
> -	if (!name)
> -		return -ENOMEM;
> -
> +	name = "intel_backlight";
>  	bd = backlight_device_get_by_name(name);
>  	if (bd) {
>  		put_device(&bd->dev);
> @@ -963,11 +960,11 @@ int intel_backlight_device_register(struct intel_connector *connector)
>  		 * compatibility. Use unique names for subsequent backlight devices as a
>  		 * fallback when the default name already exists.
>  		 */
> -		kfree_const(name);
> -		name = kasprintf(GFP_KERNEL, "card%d-%s-backlight",
> -				 i915->drm.primary->index, connector->base.name);
> -		if (!name)
> +		new_name = kasprintf(GFP_KERNEL, "card%d-%s-backlight",
> +				     i915->drm.primary->index, connector->base.name);
> +		if (!new_name)
>  			return -ENOMEM;
> +		name = new_name;
>  	}
>  	bd = backlight_device_register(name, connector->base.kdev, connector,
>  				       &intel_backlight_device_ops, &props);
> @@ -987,7 +984,7 @@ int intel_backlight_device_register(struct intel_connector *connector)
>  		    connector->base.base.id, connector->base.name, name);
>  
>  out:
> -	kfree_const(name);
> +	kfree(new_name);
>  
>  	return ret;
>  }

-- 
Jani Nikula, Intel

