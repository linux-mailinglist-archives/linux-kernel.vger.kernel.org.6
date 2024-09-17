Return-Path: <linux-kernel+bounces-331408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ED797AC80
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D45151F23964
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1114F126;
	Tue, 17 Sep 2024 07:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILvyiLcg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87E17C9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726559972; cv=none; b=dFLkBqIzkbBQC2Zc2BjAfb4bClgktL/fiXw0HYjh8Shd3QvSdfiey+heiGanjulalfNOtZGnxD/1ZB1qSvZo+JoqFJGt3wx63hr6aaz1Gyvof5ZiwgBeN+e4D2fYGYteV/WXGRiRv39rNbAtYbzKwz0743F+eOoLkWbYWW3uigU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726559972; c=relaxed/simple;
	bh=UG8LqdzeXSaEAAFcyA5nqjSctWoPpzwU0FOM7G9g5X4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UfTMUiYJiZ3sVj+1nF+JoAuPziqyNPiG+xJx9ArZRSUWCdZ0fd6Az/1+m/odaUe9Eadt6uWuHrkXv8OrJVtmjDRvYcjGpVodpW76AfKRMVwcYOd0WBQM1NY1o7hfw+R9IylJVRbhHYieAILPDL1ZJHkY3G4AREjOnkY/qV/GnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILvyiLcg; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726559969; x=1758095969;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=UG8LqdzeXSaEAAFcyA5nqjSctWoPpzwU0FOM7G9g5X4=;
  b=ILvyiLcgpkH0T7H1KJT6VjLZ/K8rXPXU3QxMOYb/X6zOZn7/BW81RkrX
   1E+iAesQEXMEKDq3+/CNcm8WlbI4b+DRtS811ZnaqjKVEhzqvQxkNivTi
   JDtsVDQwpU+VMvqqYO1AE9gEeSsAD7ZKf5eiphBmr+oZNwAR0rpFqoHtn
   +k7XC6DRyv4OhTEpvMxNtdm/9IhVWKiY/mcsFgYAcQARozlGKyw9vPMwA
   7B3mOgW6Sih4N+Hf2DLuzrTrVelwsqY4JztW9668/0cEzTRhr7taCNPaB
   xy/mGiXCdvjlzdbxb48OHc2GUV+WXyt4b4RKmJnmJuJZtBLbrMYg2cwvl
   w==;
X-CSE-ConnectionGUID: Bd5XU7XURju444tLs2Ywrw==
X-CSE-MsgGUID: ahbX3quuTIuj+1uywEwn7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25284037"
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="25284037"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 00:59:29 -0700
X-CSE-ConnectionGUID: XzjX9IC0RTq85FgSLV0w9Q==
X-CSE-MsgGUID: R45W4e/RRbaeFeboDkwYMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,235,1719903600"; 
   d="scan'208";a="69211784"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.246.102])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2024 00:59:25 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>,
 gustavo.sousa@intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net, airlied@gmail.com,
 daniel@ffwll.ch
Cc: skhan@linuxfoundation.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/cx0: Set power state to ready only on owned
 PHY lanes
In-Reply-To: <20240916180137.9203-1-vamsikrishna.brahmajosyula@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240916180137.9203-1-vamsikrishna.brahmajosyula@gmail.com>
Date: Tue, 17 Sep 2024 10:59:22 +0300
Message-ID: <87h6aed82t.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, 16 Sep 2024, Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com> wrote:
> In DP alt mode, when pin assignment is D, only one PHY lane is owned
> by the display. intel_cx0pll_enable currently performs a power cycle
> ready on both the lanes in all cases.
>
> Address the todo to perfom power state ready on owned lanes.
>
> Tested on Meteor Lake-P [Intel Arc Graphics] with DP alt mode.
>
> v1 -> v2: Address comments from Gustavo Sousa

Please briefly describe the actual change. This does not help at all.

BR,
Jani.

>
> Signed-off-by: Vamsi Krishna Brahmajosyula <vamsikrishna.brahmajosyula@gmail.com>
> ---
>  drivers/gpu/drm/i915/display/intel_cx0_phy.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
> index 4a6c3040ca15..cbed53d3b250 100644
> --- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
> +++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
> @@ -2934,6 +2934,7 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
>  	enum phy phy = intel_encoder_to_phy(encoder);
>  	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
>  	bool lane_reversal = dig_port->saved_port_bits & DDI_BUF_PORT_REVERSAL;
> +	u8 owned_lane_mask = intel_cx0_get_owned_lane_mask(encoder);
>  	u8 maxpclk_lane = lane_reversal ? INTEL_CX0_LANE1 :
>  					  INTEL_CX0_LANE0;
>  	intel_wakeref_t wakeref = intel_cx0_phy_transaction_begin(encoder);
> @@ -2948,10 +2949,9 @@ static void intel_cx0pll_enable(struct intel_encoder *encoder,
>  	intel_cx0_phy_lane_reset(encoder, lane_reversal);
>  
>  	/*
> -	 * 3. Change Phy power state to Ready.
> -	 * TODO: For DP alt mode use only one lane.
> +	 * 3. Change Phy power state to Ready on owned lanes.
>  	 */
> -	intel_cx0_powerdown_change_sequence(encoder, INTEL_CX0_BOTH_LANES,
> +	intel_cx0_powerdown_change_sequence(encoder, owned_lane_mask,
>  					    CX0_P2_STATE_READY);
>  
>  	/*
>
> base-commit: ad060dbbcfcfcba624ef1a75e1d71365a98b86d8

-- 
Jani Nikula, Intel

