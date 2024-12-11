Return-Path: <linux-kernel+bounces-441033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 631E09EC86F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D13188A53D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 09:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0252210D9;
	Wed, 11 Dec 2024 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qx3FIU2M"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC542210C1
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908102; cv=none; b=J0v2QRnFgYNerr5YQ/Npr/qsRppkWAW1tWPRVOnoi0VsVeMdD19S8MPqaLUAHQJAyVwEcYJaFPUxQHdG4c+WaDrcLs5FSrVBKMW1lGHWizM+aMM+y644940qsdvYiZl2HADXDAob+1Pd+/DNaIqEkB1HHKSMWXuXX/4F7XwvKCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908102; c=relaxed/simple;
	bh=8KcG0PSp4Zd5AJaH+m5TKuZ6ibsN9T1JllDw7Qy17tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHjLLPsAaOvXP7qnRgfs++4UjrvWMtuAMCwmOVziFwL1HzjSOpFsjVUvaoCFX44untYTHf7o0F3SuvuVuL5uY25CR8r8BIRYaqCKxHNIpWA9LjZVWKOfmD228gjLqEIG05TeqaJ+pKHknBwgUF/SJ5yg/xh8ugQfDDxljEXJUZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qx3FIU2M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso2423145e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 01:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733908099; x=1734512899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sOc5WY2rc/xEm+sPKHyC8DvQOWTsoRLRqyloQEsY77A=;
        b=qx3FIU2Mh1nXV6/JM9SY80jMQuBjfTTcKf7rmMeguk8NLm7BT6QhM98EkMFPvpu0fA
         JseMvJm1e80tosnL4oZt8GAH66wZnCpEHAlK4UMhgbUp2LcKlryMvIpEBYLVE6zDbfBp
         gjAWTmuDqPV6z9j1VmRdOnlcoW12Q6aa7mWGF0UUWorudD5Rwl8P01Qna1uPrV0kHLld
         ihV2d8ZudhGQpomGquLfUlacwm3FJVBV/JoWlQWWDZVHmqXFDtzD0tqO0djib9YxBO7y
         5c2Q5zW2oXTG5Vdr98Je1F5ckPZ5UQop34g8jMNWzaz/UaqfvVDDEKpvIiFoc08T8DKN
         To1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908099; x=1734512899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOc5WY2rc/xEm+sPKHyC8DvQOWTsoRLRqyloQEsY77A=;
        b=xOb5WfMXvv0Ht7YlHWz5qlN8Z+oUOtDObF7Dl1Um3iVuGwhh/rb76iG0a+YR2iiRgL
         q0pRQITm3hKENNQOl8UsNu7h5LtjDGGZDotBKBBVJ6EqpSkZlMiP38lIntJashlH8/1H
         wn/IUn0lh0H0r/tzHIK64G5lDu+AurxKSo5Vz3f80VUUFRG95pHjmGKQwcdtVs2hRntJ
         AUyJASNOX9ULXTbTuEehc9J1lfd5V9kv0pnAw12BhFf1zrei2k1OiEc9q27H1mvOOX2x
         PrnBCsGFN2ZnZZ4X8CCNBbrQa00PNv837LZnIyYBe+mSK4ZlegT9SFVOBN/DwLfe7aiC
         sutA==
X-Forwarded-Encrypted: i=1; AJvYcCUPU8mtYcICD+wUUsCC3GtE67hMRAYcyAZIxllM7nLH4gw3bphh9fJCucDE/225hIGeDBE2VN2D8QltmVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzoMNBbB8BIGMttNQjO8L4/1XGNqHgQnmD0Qvfmu2rCHP5WNj6
	ME55MZGRE2Y2drZKQeap/kEgcKfRb+Je5ohaey0xzrjfw/vB/pv5E3pgCmEdjx4=
X-Gm-Gg: ASbGncuecmC11OgapOXOfU2es4nI24H0Qf5o7OokqoslhfGQ74R0J2xxosJ6WYekbI3
	qaJUC/9QuYDp9sEuWf9gYVzAQ1jCErtPCvjwDR9prj3ERsQwnpXJ0uk7PJp8ybvmoxUyFivM2jK
	dj55Kfmqi82IzKq0K4YDYESrSmGEnHpzRD467HcJzZabuN0Jn9hs+G7M6HTcrmOCmSDGn2l8ljF
	grVZjodMRUVPAwqn9Iax4/R39sStaxOz9GmKuGpZ5lfM0Ev50H4
X-Google-Smtp-Source: AGHT+IFWF72VEAOuphKHQ5dyzcCPjXpafd4+8begHjj7RZTqVLd3ZvocSIjkzAv1tDYNowU12sH8Hw==
X-Received: by 2002:a05:600c:3b11:b0:434:fa73:a906 with SMTP id 5b1f17b1804b1-4361c5c4e21mr11693265e9.4.1733908098781;
        Wed, 11 Dec 2024 01:08:18 -0800 (PST)
Received: from linaro.org ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d2637sm220870775e9.2.2024.12.11.01.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:08:18 -0800 (PST)
Date: Wed, 11 Dec 2024 11:08:16 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH RFC 4/4] drm/msm/dp: Add support for LTTPR handling
Message-ID: <Z1lWgDk6vzbx4ew7@linaro.org>
References: <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-0-cafbb9855f40@linaro.org>
 <20241031-drm-dp-msm-add-lttpr-transparent-mode-set-v1-4-cafbb9855f40@linaro.org>
 <6lpeexb5menpwrzcnmr367x4lmhvzyovhdybn54mnwk55ieehy@mos4oso67boo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6lpeexb5menpwrzcnmr367x4lmhvzyovhdybn54mnwk55ieehy@mos4oso67boo>

On 24-10-31 18:54:25, Dmitry Baryshkov wrote:
> On Thu, Oct 31, 2024 at 05:12:48PM +0200, Abel Vesa wrote:
> > Link Training Tunable PHY Repeaters (LTTPRs) are defined in DisplayPort
> > 1.4a specification. As the name suggests, these PHY repeaters are
> > capable of adjusting their output for link training purposes.
> > 
> > The msm DP driver is currently lacking any handling of LTTPRs.
> > This means that if at least one LTTPR is found between DPTX and DPRX,
> > the link training would fail if that LTTPR was not already configured
> > in transparent mode.
> 
> It might be nice to mention what is the transparent mode, especially for
> those who do not have the standard at hand.

Sorry for the late reply.

Will do in the next version.

> 
> > The section 3.6.6.1 from the DisplayPort v2.0 specification mandates
> > that before link training with the LTTPR is started, the DPTX may place
> > the LTTPR in non-transparent mode by first switching to transparent mode
> > and then to non-transparent mode. This operation seems to be needed only
> > on first link training and doesn't need to be done again until device is
> > unplugged.
> > 
> > It has been observed on a few X Elite-based platforms which have
> > such LTTPRs in their board design that the DPTX needs to follow the
> > procedure described above in order for the link training to be successful.
> > 
> > So add support for reading the LTTPR DPCD caps to figure out the number
> > of such LTTPRs first. Then, for platforms (or Type-C dongles) that have
> > at least one such an LTTPR, set its operation mode to transparent mode
> > first and then to non-transparent, just like the mentioned section of
> > the specification mandates.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/gpu/drm/msm/dp/dp_display.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> > index f01980b0888a40b719d3958cb96c6341feada077..5d3d318d7b87ce3bf567d8b7435931d8e087f713 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -107,6 +107,8 @@ struct dp_display_private {
> >  	struct dp_event event_list[DP_EVENT_Q_MAX];
> >  	spinlock_t event_lock;
> >  
> > +	u8 lttpr_caps[DP_LTTPR_COMMON_CAP_SIZE];
> > +
> >  	bool wide_bus_supported;
> >  
> >  	struct dp_audio *audio;
> > @@ -367,12 +369,35 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
> >  	return 0;
> >  }
> >  
> > +static void dp_display_lttpr_init(struct dp_display_private *dp)
> > +{
> > +	int lttpr_count;
> > +
> > +	if (drm_dp_read_lttpr_common_caps(dp->aux, dp->panel->dpcd,
> > +					  dp->lttpr_caps))
> > +		return;
> > +
> > +	lttpr_count = drm_dp_lttpr_count(dp->lttpr_caps);
> > +
> > +	if (lttpr_count) {
> > +		drm_dp_lttpr_set_transparent_mode(dp->aux, true);
> > +
> > +		if (lttpr_count > 0) {
> > +			if (drm_dp_lttpr_set_transparent_mode(dp->aux, false) != 1)
> > +				drm_dp_lttpr_set_transparent_mode(dp->aux, true);
> > +		}
> > +	}
> > +}
> > +
> >  static int dp_display_process_hpd_high(struct dp_display_private *dp)
> >  {
> >  	struct drm_connector *connector = dp->dp_display.connector;
> >  	const struct drm_display_info *info = &connector->display_info;
> >  	int rc = 0;
> >  
> > +	if (!dp->dp_display.is_edp)
> > +		dp_display_lttpr_init(dp);
> 
> Why is it limited to non-eDP cases only.

In case of eDP, I don't think that there will ever by a case that will
need an LTTPR in between the eDP PHY and the actual panel. It just
doesn't make sense.

IIUC, the LTTPRs, since are Training Tunnable capable, they help when
the physical link between the PHY and the sink can differ based on
different dongles and cables. This is obviously not applicable to eDP.

> 
> > +
> >  	rc = dp_panel_read_sink_caps(dp->panel, connector);
> >  	if (rc)
> >  		goto end;
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> With best wishes
> Dmitry

