Return-Path: <linux-kernel+bounces-555037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F4BA5A4BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468501676CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CAF1DF248;
	Mon, 10 Mar 2025 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z7fDzV+G"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBB1DF265
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741637892; cv=none; b=b7dl6/bcMODZxrpRyl6IwaRR2pMyoG6yp+65hRDEi69Upi5afYI/v+n3ws3S2XyIlxzL1F7Fc4B7T2A5hTKc0h4UABG+2nXiodNHL1dSMqHhaMDaRBHvDFWppG3ZasTP5g8X60ZZoGaLO859w8U9z4l/2Y1I6QK4kpx+/XEYTy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741637892; c=relaxed/simple;
	bh=EL25rNL51TXTvxkbPCKINtP+7+2cd264OtWDnAl9qwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZ7GRxEx/JIhD/igK9dp43hZQUejuzMrqUis2eG03wGiVFKs6kKKirTUN1xuEj4J2fokAAdNAyxAuQgGHOUf/PtkEwyG2xfgIHPfkBJlD4Ir5dhvMclvO9aaH4Uv7IbhQHWNTrwPU36PMOVFgylKLEIXBY7nJWj0ph72iqB0zv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z7fDzV+G; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bfed67e08so27022871fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741637888; x=1742242688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Na0+//dCirkAQ9ySuY1KKDPsWyMmAsRZj0GKZr2mXwM=;
        b=z7fDzV+GgUCsalA5GHaGQUloUUrUk3VZ7Xodudvt6c9C7iZrZZpd0p2HFZxO2IAtq3
         KkqcQ93M7irvtEC2L7GQHFXSWrz0d9IiDAYhs2TpR/DZps5F4y3RRnCnjvSBsWwZm7qx
         lfLCMDWV1gq5j/yCAELSIAwi04ZCuhxyn5gScZuy0Lrd5MXcOlHVQ63yV3d8hvpPqQQu
         FOhUJKoaNKNSujpyKe1BPgJnwVsG7x7HBFsofYv4CO9EFLGxc6ndLgdK+oTAoBLeDemW
         gK5bVzsjXBL7kelIyENWfc4vF7Vrz9DM9rQXalpa7oGcqFmprfuvf8IJ/6ed/JkuUTk/
         B28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741637888; x=1742242688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Na0+//dCirkAQ9ySuY1KKDPsWyMmAsRZj0GKZr2mXwM=;
        b=mcWlbAUvkXgmTS6DFy3D125TVRqt5C+MGa4ysfLqQNdGzkIQOtM2YTAB4hZLHSDv3v
         5gvL4WId6b4Tpa2iaFFHMARIF3WytoGhAnqoYmh9551WgOhujHY+954C8A7crNhIWaX9
         Nzll2Msn6Z9yqhoXHY8jsE/oD5QftgBCb4N4RWPga0dEJmUH0nYH9FUUo2zv3uQFaH7D
         r4lLDzKWOW+n7f7Om0HFC+NcGn8lD3j75d3iW8SnJqVp1JhakL5ibHknVGUM0RuM3BAT
         mDRQaJ4Pk2pEHTcmjO86Sfk6RyaTsT1n3KCHT2tRYWYiTVcUC+BwVLvXbrIpV0tvF09r
         sC+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlntSSfbZiRCzuYMzg3EZ4be7DkrianlFR+8AR8f2B3MVxnrzOEm+tRQMh4bsANBFHvqCTsn83mF2QAU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CxmP/U7xxl0KbQ5zHMQZ/i39whfDHyDm69zRdECvk47/gbau
	CHqLzhWzapT4HLyFuSCMicZQb2hLUdrfoZH2H+XDF1Xj8eM2HzNesK27IHfm9ew=
X-Gm-Gg: ASbGncvbb6OsOfiWVfBDlZrmjET1jFjdu/o5KhkCnyUsXsi0Nitu5ypyPZ25epzIVcA
	VgvFCRcCLlaEQCVNSjpEzA3bqGbsc9Wa20KybL74fJoqPI9UAFl3jUgfUu+2Bp3E+7YoDF0ysau
	PkPQ8vXJChAIxNRg7w6gl63k2rB/qfaB4nE3FN+4RdzXK+kcb6OzH4THhNPg4Vtk65qbqZnROnQ
	vQaK/3Buq2MhW6Q+k/vuHlQVJ26k1yPa1qC5HIKiMQMRTMyLBFG36/wDKAosgY6ykQgIGFcR/YH
	RoqUkCDN1/B4n5seW15NCtiOmvhXQ/75+tXvcw02HNUt9PB+9ZQeKbJdjrEFp0OoX2oOnOmeKxa
	jR8kGiqJCdexXx/AzhHwtlho+
X-Google-Smtp-Source: AGHT+IHcA7kOtf3sam4WAbu1ps2qyynLobUE0HG0axG5MF7JuYSDH5Zq3T6DIc7mWO7eWXCbFWGVLA==
X-Received: by 2002:a05:651c:3c3:b0:30b:c569:4665 with SMTP id 38308e7fff4ca-30bf46468dcmr39513851fa.29.1741637888405;
        Mon, 10 Mar 2025 13:18:08 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bef40f9cdsm16595941fa.48.2025.03.10.13.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:18:07 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:18:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org
Subject: Re: [PATCH 3/4] drm/vc4: use new helper to get ACR values
Message-ID: <esgb42dyhpjixm62tfk2nfzdiygnfn4bcwq4zn7rhydmt4np2q@7v77p7kveb4e>
References: <20250309-drm-hdmi-acr-v1-0-bb9c242f4d4b@linaro.org>
 <20250309-drm-hdmi-acr-v1-3-bb9c242f4d4b@linaro.org>
 <20250310-invisible-married-firefly-945c84@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310-invisible-married-firefly-945c84@houat>

On Mon, Mar 10, 2025 at 03:51:53PM +0100, Maxime Ripard wrote:
> On Sun, Mar 09, 2025 at 10:13:58AM +0200, Dmitry Baryshkov wrote:
> > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > 
> > Use drm_hdmi_acr_get_n_cts() helper instead of calculating N and CTS
> > values in the VC4 driver.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  drivers/gpu/drm/vc4/vc4_hdmi.c | 10 +++-------
> >  drivers/gpu/drm/vc4/vc4_hdmi.h |  7 +++++++
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> > 

> > diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
> > index e3d989ca302b72533c374dfa3fd0d5bd7fe64a82..0a775dbfe99d45521f3d0a2016555aefa81d7934 100644
> > --- a/drivers/gpu/drm/vc4/vc4_hdmi.h
> > +++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
> > @@ -211,6 +211,13 @@ struct vc4_hdmi {
> >  	 * KMS hooks. Protected by @mutex.
> >  	 */
> >  	enum hdmi_colorspace output_format;
> > +
> > +	/**
> > +	 * @tmds_char_rate: Copy of
> > +	 * @drm_connector_state.hdmi.tmds_char_rate for use outside of
> > +	 * KMS hooks. Protected by @mutex.
> > +	 */
> > +	unsigned long long tmds_char_rate;
> >  };
> 
> This should be in drm_connector_hdmi if it's useful

That would mean bringing the state to a non-state structure on the
framework level. Is it fine from your POV? Is it also fine to use
drm_connector.mutex for protecting this? Or should we be using something
like drm_connector_hdmi.infoframes.mutex (maybe after moving it from
.infoframes to the top level)?

-- 
With best wishes
Dmitry

