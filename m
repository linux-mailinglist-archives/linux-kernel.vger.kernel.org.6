Return-Path: <linux-kernel+bounces-392881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A649B993B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A951C2138F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ABB1CB526;
	Fri,  1 Nov 2024 20:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niM06EDN"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05951D0F49
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491942; cv=none; b=iji0BGrppn1ex9aib7ThQD+65P0tr0RrZffUbKgxLY+/m94ILTcHe68Bv89EZiEJJw6U2V1HLSf0xNPwNux1zOJgAlH33YTljZhoiQyqd0+EBN6WfYTYGWbjWaRjgautCTCIkAeZrHBsujSZaRjDUjogbcV65DvEJrXH25XCSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491942; c=relaxed/simple;
	bh=MHj4DImzV/7znfvEEKeMnBjLODeAePJxKUUMhQEC3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RT9W7burjJTjqqAvs/XGwIbSIsFf4Ihe8qnMj3pX9Z6txweg6qoedkalf6/G0awOA3K5wm8JNc+scYbHs8UWsE3kxHmeEFelJKXZpL/l40s/LDQ1M8EoIwLm8iAuffEk7OU3NbphMEiNqRjOUiumK8pdzVi4H5d+Jr87RmbL0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niM06EDN; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539ebb5a20aso2489618e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730491939; x=1731096739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRuudTPNmMwLHY1n1kU3xhjTGMpQc0UfbLasNRVgYtU=;
        b=niM06EDNM4K1vx9bSOrabn254eQc5wVp+kPDEBIUUZIvKuyhi38UMwexSOo2+l9Q54
         G96sI3TLtl5Gf4aEpfzS7Bc7RvvnYnra5DJ5FqoYpoGvErnoIS8fz4FrGBM/cAU3OfKn
         GCq06ETu9FFo+7hS7NXZ/s04MzsTDV2QJ/COo0s6o+HADgCl+9zowBJs385buMVMS1fY
         GIFPf2kvkEv6WL6MC46fCE3o40eQBzVTtTc02t/8mmYtrQ1zdx2/Y4BP51MVgqDtbQsG
         tys0MXC5a2h1SJURyg8xajsHScW2H8SLTS8hPCP+qUz+PmGwyXyy7yH6UZNXXeEz5lWq
         Ctsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491939; x=1731096739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRuudTPNmMwLHY1n1kU3xhjTGMpQc0UfbLasNRVgYtU=;
        b=iUCgtY4QJeR9tITOv7w7ZVuSAP3kFPi6BkM+gkWQ0hkjafendvinOp+Ogk18WeuDRw
         R6hG+P6A3wmQLl41911OngkeDR24uEvsQ8E+qpJDynF+vwhtsarZ4efeZQ80RY4r/ho0
         kPlo7/HIDMDpK2ZybIvk8LBk73ugAsb8VmoeK1D4HUYB54nTlNQBy9XVmsSOEY4uLSdC
         E/Zanc4cOJrk7pb2fbJpKPuzM5pKDfhbYj5Dv46tqNum+ymRaynmA/KDN5/JWL5w+hJm
         P8NePTl6qmYyk4flxXSsJmU3Lr5c8RinSX1U2EwFwJJKVXSuBMxtK6MPTC0cteYtfLmG
         39dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPsN27BD9otvn7/rmJQuhYEvAY1lXhDbjLL/7q8fpYmV7Gc0xBkgDNdAFmvXWH8eG92pHQJvB8IdXJlBw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9mdOZjGOSUzPKFUY3+VjUKiCrmpsDqG8I/OhB1GBIpd4ce7Rc
	ljfvdOE94sPAkqtCg1Ydvc1DF2odj+aZmJYregug9maV816iXO/DY4/j8ECS5AE=
X-Google-Smtp-Source: AGHT+IGIvW5ByRLM9GHWvfJdsh1B2I5joze+CQnZ10eSEsQVXQNXZharaJdv+roZF+ZF+jW9UKOllQ==
X-Received: by 2002:a05:6512:3d21:b0:53c:7363:90c with SMTP id 2adb3069b0e04-53d65df7d34mr2770112e87.35.1730491938782;
        Fri, 01 Nov 2024 13:12:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bcce3d9sm656782e87.161.2024.11.01.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:12:18 -0700 (PDT)
Date: Fri, 1 Nov 2024 22:12:16 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Imre Deak <imre.deak@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
	Danilo Krummrich <dakr@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 1/4] drm/dp: Add helper to set LTTPRs in transparent
 mode
Message-ID: <skyowhfl2qoaaoa4gyj5mf4j3nlznmtc6l5b3oicopmc5u5nxb@f3i2iif3r6ya>
References: <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-0-cafbb9855f40@linaro.org>
 <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-1-cafbb9855f40@linaro.org>
 <ZyPxLpykHkO9Xx_R@ideak-desk.fi.intel.com>
 <87msijjol6.fsf@intel.com>
 <ZyTbDELVW5vqFoMS@ideak-desk.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyTbDELVW5vqFoMS@ideak-desk.fi.intel.com>

On Fri, Nov 01, 2024 at 03:43:40PM +0200, Imre Deak wrote:
> On Fri, Nov 01, 2024 at 11:22:13AM +0200, Jani Nikula wrote:
> > On Thu, 31 Oct 2024, Imre Deak <imre.deak@intel.com> wrote:
> > > On Thu, Oct 31, 2024 at 05:12:45PM +0200, Abel Vesa wrote:
> > >> According to the DisplayPort standard, LTTPRs have two operating
> > >> modes:
> > >>  - non-transparent - it replies to DPCD LTTPR field specific AUX
> > >>    requests, while passes through all other AUX requests
> > >>  - transparent - it passes through all AUX requests.
> > >> 
> > >> Switching between this two modes is done by the DPTX by issuing
> > >> an AUX write to the DPCD PHY_REPEATER_MODE register.
> > >> 
> > >> Add a generic helper that allows switching between these modes.
> > >> 
> > >> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > >> ---
> > >>  drivers/gpu/drm/display/drm_dp_helper.c | 17 +++++++++++++++++
> > >>  include/drm/display/drm_dp_helper.h     |  1 +
> > >>  2 files changed, 18 insertions(+)
> > >> 
> > >> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> > >> index 6ee51003de3ce616c3a52653c2f1979ad7658e21..38d612345986ad54b42228902ea718a089d169c4 100644
> > >> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> > >> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> > >> @@ -2694,6 +2694,23 @@ int drm_dp_lttpr_max_link_rate(const u8 caps[DP_LTTPR_COMMON_CAP_SIZE])
> > >>  }
> > >>  EXPORT_SYMBOL(drm_dp_lttpr_max_link_rate);
> > >>  
> > >> +/**
> > >> + * drm_dp_lttpr_set_transparent_mode - set the LTTPR in transparent mode
> > >> + * @aux: DisplayPort AUX channel
> > >> + * @enable: Enable or disable transparent mode
> > >> + *
> > >> + * Returns 0 on success or a negative error code on failure.
> > >
> > > Should be "Returns 1 on success".
> > 
> > But is that a sensible return value?
> 
> It matches what the function returns, but yes, would make more sense to
> fix the return value instead to be 0 in case of success.

I think returning 0 is better in case of this function.

> 
> > >
> > >> + */
> > >> +
> > 
> > Superfluous newline.
> > 
> > >> +int drm_dp_lttpr_set_transparent_mode(struct drm_dp_aux *aux, bool enable)
> > >> +{
> > >> +	u8 val = enable ? DP_PHY_REPEATER_MODE_TRANSPARENT :
> > >> +			  DP_PHY_REPEATER_MODE_NON_TRANSPARENT;
> > >> +
> > >> +	return drm_dp_dpcd_writeb(aux, DP_PHY_REPEATER_MODE, val);
> > >> +}
> > >> +EXPORT_SYMBOL(drm_dp_lttpr_set_transparent_mode);
> > >> +
> > >>  /**
> > >>   * drm_dp_lttpr_max_lane_count - get the maximum lane count supported by all LTTPRs
> > >>   * @caps: LTTPR common capabilities
> > >> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> > >> index 279624833ea9259809428162f4e845654359f8c9..8821ab2d36b0e04d38ccbdddcb703b34de7ed680 100644
> > >> --- a/include/drm/display/drm_dp_helper.h
> > >> +++ b/include/drm/display/drm_dp_helper.h
> > >> @@ -625,6 +625,7 @@ int drm_dp_read_lttpr_phy_caps(struct drm_dp_aux *aux,
> > >>  			       u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
> > >>  int drm_dp_lttpr_count(const u8 cap[DP_LTTPR_COMMON_CAP_SIZE]);
> > >>  int drm_dp_lttpr_max_link_rate(const u8 caps[DP_LTTPR_COMMON_CAP_SIZE]);
> > >> +int drm_dp_lttpr_set_transparent_mode(struct drm_dp_aux *aux, bool enable);
> > >>  int drm_dp_lttpr_max_lane_count(const u8 caps[DP_LTTPR_COMMON_CAP_SIZE]);
> > >>  bool drm_dp_lttpr_voltage_swing_level_3_supported(const u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
> > >>  bool drm_dp_lttpr_pre_emphasis_level_3_supported(const u8 caps[DP_LTTPR_PHY_CAP_SIZE]);
> > >> 
> > >> -- 
> > >> 2.34.1
> > >> 
> > 
> > -- 
> > Jani Nikula, Intel

-- 
With best wishes
Dmitry

