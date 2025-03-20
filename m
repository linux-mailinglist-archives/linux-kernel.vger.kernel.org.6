Return-Path: <linux-kernel+bounces-569541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8923A6A456
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 11:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19FD3BB278
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 10:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233DD224AEB;
	Thu, 20 Mar 2025 10:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXd7gcY1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF9224AED
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 10:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468282; cv=none; b=kXPo5tJ86MDt5Dj23imiye23WJcXQERVLolO+03wvfdy/PXXucDW2Tuo2kIHEISLb4MBaTOvn0B1inpBexItdKbLnXWJTu32DPOcJ2sIXTJme6wcUxlqbxwmy7TSXKdMwbTXAA+CZkrsF9OC4D1mso+LqxO5f+/Z4o30c4s6ccA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468282; c=relaxed/simple;
	bh=mnCdFNNc8O0nJ3xevXKvsTOw3IypSnnSGWOzyc+CHu0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NaElIuGnAu6c1chKe49dhAAcOw4QLnCJQScsLB1DZuOiOUlbjNApg0/3YnbCJH+3qrdQnUGXjXIzloD7dxI97B70Ptp7kCtE8/kAGMCdKn+JAPq8OxNQxWSvFd+heLcEbyeEXpjSpsA7sn0MLoF9NvyK1wex8C5wayoqUj9D51M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXd7gcY1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742468281; x=1774004281;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=mnCdFNNc8O0nJ3xevXKvsTOw3IypSnnSGWOzyc+CHu0=;
  b=mXd7gcY1u6RUiEP5UmY2VbHLbfwcblmWZceh0bOmDf9QY/jY5gHgajhH
   Axl1cTcv7fbiP5YKnjOZcqnAYRdVD8LtvhJwX1ZldpLRqDubXjmQkd4NM
   cCMTtKIDQW7yPluhs3SnPjs6lGWspPpgZ5dgqd60sTApBXGh6CInl5cmI
   ZGSx6dz2yuCsVKXUYnDMOqgJZmbAen7WZGBnF1S5alBf3x7wnIUYciocK
   iiuqsVSG7SF7QB3ACxQsedsBS5F1GjO42aVAcNrhJS4H74FI3jw4ZRtHv
   amMdf/9eeidFURJxCdOZMTPYVUc3M/oG3fOordpTs7gWQXebYdDodqxxD
   A==;
X-CSE-ConnectionGUID: 5A9pxbXvTASKTg6mDUq2xQ==
X-CSE-MsgGUID: WeiaWyjjQo2WciTd2huXzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43803893"
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="43803893"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:58:01 -0700
X-CSE-ConnectionGUID: WW44s1EFTFelcycxDyXBHQ==
X-CSE-MsgGUID: iBrD/9cIS6m9dNJZxJ4b8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,261,1736841600"; 
   d="scan'208";a="128150859"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 03:57:58 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Lu Yao <yaolu@kylinos.cn>, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Lu Yao <yaolu@kylinos.cn>
Subject: Re: [PATCH] drm/i915/display: add audio dis/enable when connector
 hotplug
In-Reply-To: <20250318070435.347383-1-yaolu@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20250318070435.347383-1-yaolu@kylinos.cn>
Date: Thu, 20 Mar 2025 12:57:55 +0200
Message-ID: <87cyecc6ks.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 18 Mar 2025, Lu Yao <yaolu@kylinos.cn> wrote:
> Now audio enable/disable depends on an atomic commit, it doesn't make
> sence. For wayland, there will trigering an atomic commit, so it
> works well. But for Xorg using modesetting, there won't. In this
> case, unplug the HDMI/DP and the audio jack event is not triggered,
> resulting in still having a HDMI/DP audio output choice.

As it is, the implementation is not acceptable, but with this
description I also don't understand the problem.

Please file a bug at [1], attach dmesg from boot exhibiting the problem.

BR,
Jani.

[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html

> Signed-off-by: Lu Yao <yaolu@kylinos.cn>
> ---
>  drivers/gpu/drm/i915/display/intel_hotplug.c | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> ---
> Test hardware:
>   CPU: i5-12500
>   GPU: UHD Graphics 770
>
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
> index 3adc791d3776..332d6e1a99cd 100644
> --- a/drivers/gpu/drm/i915/display/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
> @@ -32,6 +32,7 @@
>  #include "intel_display_types.h"
>  #include "intel_hotplug.h"
>  #include "intel_hotplug_irq.h"
> +#include "intel_audio.h"
>  
>  /**
>   * DOC: Hotplug
> @@ -415,6 +416,35 @@ void intel_hpd_trigger_irq(struct intel_digital_port *dig_port)
>  	queue_work(i915->display.hotplug.dp_wq, &i915->display.hotplug.dig_port_work);
>  }
>  
> +/*
> + * when connector hotplug state changed, audio need changed too.
> + */
> +static void i915_audio_hotplug(struct intel_connector *connector)
> +{
> +	struct drm_crtc *crtc;
> +	struct drm_device *dev = connector->base.dev;
> +
> +	drm_for_each_crtc(crtc, dev) {
> +		if (connector->base.state->crtc == crtc) {
> +			struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
> +			struct intel_crtc_state *pipe_config =
> +				to_intel_crtc_state(intel_crtc->base.state);
> +			struct intel_encoder *encoder =
> +				intel_attached_encoder(connector);
> +
> +			if (pipe_config && pipe_config->has_audio) {
> +				if (connector->base.status == connector_status_disconnected)
> +					intel_audio_codec_disable(encoder, pipe_config,
> +								  connector->base.state);
> +				else if (connector->base.status == connector_status_connected)
> +					intel_audio_codec_enable(encoder, pipe_config,
> +								 connector->base.state);
> +			}
> +			break;
> +		}
> +	}
> +}
> +
>  /*
>   * Handle hotplug events outside the interrupt handler proper.
>   */
> @@ -487,6 +517,7 @@ static void i915_hotplug_work_func(struct work_struct *work)
>  					drm_connector_get(&connector->base);
>  					first_changed_connector = &connector->base;
>  				}
> +				i915_audio_hotplug(connector);
>  				break;
>  			case INTEL_HOTPLUG_RETRY:
>  				retry |= hpd_bit;

-- 
Jani Nikula, Intel

