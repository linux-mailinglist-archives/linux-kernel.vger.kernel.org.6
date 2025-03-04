Return-Path: <linux-kernel+bounces-545572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F2A4EEBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFC361711E5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF8725FA19;
	Tue,  4 Mar 2025 20:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AmmCzl6c"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224025F794
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741121299; cv=none; b=bGi2aCHIJn/9+GyNnNc9xP1UT2LOUmEXIPPhsXgiAtIkun0awgQzZ8jU28e4faXnuimRsZtqRimtgdYWlASbO8MLyuk3LM4glGYsLRjaqeYGT1nsX/Fy8sUCgG5cBFb/fJKUE/uxyEvI72MOlDMFghje1JNvjEGEK0Fy94i4DoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741121299; c=relaxed/simple;
	bh=2zNBeSe7MrOdfvsSebD553aXAcmttFdsby/sZvd5TF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc0ZQ6rFiRnsUM1v5LwcOlpo4OqTFErd2lY/lA0TFEC6ZFPkH12l1FIKii1GOXBOnMVVkgrvNVvdJZTSqGhDPtP0CMzCFwnVfBtEY9uuHPovQz7o5eFSJohNyinaa6orxP6t465WG9XF/O4UD9WJSMdr0Zq5N94TAcSE1NiwVrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AmmCzl6c; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-548409cd2a8so6259036e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741121295; x=1741726095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/oAPJle7igvkCOj9wNSaohLqS/9lmDq/1xSw1olJhfs=;
        b=AmmCzl6cmjlwKdoJ68mpTiV+K7jYQtKycEp5lKxLjefFboXtd1szoMVfEnuMHa97rT
         ketr0HIh6e1J8VCHnEV3Y4blfLe9PQfUGB7jAlhjBZPKIueqiGWi5nlS7TyN3auO9kPA
         D/oHsvf/EYrm2zQQZRk3UVbRsDm9nackw2h9ADWypHjYPdQRzkzuZ0yoqQDlI8ZqlLkA
         e0VloOFerC3MCmbxxm+C1IEbM4/A37g9P41lGHn3rAIFXs25uqbiUMuHFu7Z02JP4TIl
         sJ5WSsOtjndUM/z4zwl2SeHs10knXuRvGagixOdHUNmYtAm1J+vwOb1tn0N2flFB9104
         jKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741121295; x=1741726095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oAPJle7igvkCOj9wNSaohLqS/9lmDq/1xSw1olJhfs=;
        b=nhQqJ+8oDAaCPby8Y1pz/QGec5EarB1eSLoXuuGPPK9Phh/Cvn7dd2mGIqERrQvBkr
         OOpxm2Awb7YtR9OE/71X/FysARbacGxtAa8Ktchh/HzGzN100HLLdghhnH05u92xwg9+
         TAqtLSONHiIiwlvrPH60JUgnF1gRi63TGvd+BbcQK3fSliI1QhL7TvE58+Aqf+MrNaJT
         V2u1WYMhUjzcoZj21aP4TAIsUOhmMx3d4Ez8x6trADWhvbKZo8KfDIWA0P/SXBQYlO2H
         IEqdSMPFmfvaDAmb3M38IzZokl6TYrOzuDTx6JELzDGp6pzBOi86BEgE2cWbJ6jTvI0G
         z2ng==
X-Forwarded-Encrypted: i=1; AJvYcCUSg/KgUsdENw3yowq5bKYH7fuVm7kiMtgmqYDvBsVEBVeM7Ue5al+I4+Tte1dHBtaDU+XDX+ROGH+SuqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOzcs3yCKIXedExK1beFOMH4xkVzRuq93flpX/kv1z6N37AGgT
	ZIT1Yr9+mXlwv6OWTVBQz91HaOzD+vqXROweQB1nIk+4rMPImG2Dz6r1o25cij8=
X-Gm-Gg: ASbGnct1PniF175mMEyGaAn7ef3C4/G6LVIAbdhX+NAL7Y3XIiPywmLKRQfEHjaRTjv
	HL7y25EUlmNRGrJfKYbIRfhz7pulpJxWD4dL0mIpPjhdQ/7L2fLHQYvxQJtv3IaUZrGbNAOFP1b
	31fgNXhB/G+AKLTHG3NC7KHf6TMEKlsRtIOkhF+E+iwT5Qz1/P0uiv5ujcGm0KlFuhzW0ZkH987
	SRphhoXQAvSMxcsCC5bWHyyLY8b3/aXDbkSc520hwsxM9qdZK0a9nyNumOEgYo2nwh02GS80ELq
	k/E8ObDGBFrNCygDgn1GeZxI0hIau1lWXGXDUtj8JfaN2rccDwZDooyxumd5SGsyLIpWQAOWS0g
	00L1EwPLdZw306R+sxMKKt/gF
X-Google-Smtp-Source: AGHT+IH5VMC586i36hYasuRbMAJ6daWnnollvxQ5ODQDmTBEMUXbbXzEafbSoZ2SOMQnxMX8oAh9Jg==
X-Received: by 2002:a05:6512:304e:b0:545:e19:ba24 with SMTP id 2adb3069b0e04-5497d37e371mr237109e87.48.1741121294899;
        Tue, 04 Mar 2025 12:48:14 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549443be587sm1667436e87.177.2025.03.04.12.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:48:13 -0800 (PST)
Date: Tue, 4 Mar 2025 22:48:12 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, quic_abhinavk@quicinc.com, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Simona Vetter <simona.vetter@ffwll.ch>, 
	quic_ebharadw@quicinc.com, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v6 03/14] drm/msm/dpu: switch RM to use crtc_id rather
 than enc_id for allocation
Message-ID: <cqpqtuh2tztdhsg3nrvxnobxmsytsxthcd5wybiuzyefurkme2@hvv5zjiqczyb>
References: <20250214-concurrent-wb-v6-0-a44c293cf422@quicinc.com>
 <20250214-concurrent-wb-v6-3-a44c293cf422@quicinc.com>
 <se4b4kzp3vej4b6albecdc2t65ueiuba4kidutwvrv2rcfyjwr@e62fn225jwcr>
 <8c727bd6-94f1-4ee3-9bf3-793899038895@quicinc.com>
 <da6e2hygdv6ewdr5hqeks2ocsxwvfvozby4b53unk5ckyqvu7t@wh3y4jnucapl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6e2hygdv6ewdr5hqeks2ocsxwvfvozby4b53unk5ckyqvu7t@wh3y4jnucapl>

On Tue, Mar 04, 2025 at 01:43:09AM +0200, Dmitry Baryshkov wrote:
> On Mon, Mar 03, 2025 at 10:45:19AM -0800, Jessica Zhang wrote:
> > 
> > 
> > On 2/27/2025 7:07 AM, Dmitry Baryshkov wrote:
> > > On Fri, Feb 14, 2025 at 04:14:26PM -0800, Jessica Zhang wrote:
> > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > 
> > > > Up to now the driver has been using encoder to allocate hardware
> > > > resources. Switch it to use CRTC id in preparation for the next step.
> > > > 
> > > > Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> > > > ---
> > > > Changes in v6:
> > > > - Drop duplicate cstate initialization code and unnecessary memset
> > > > Changes in v5:
> > > > - Reordered to prevent breaking CI and upon partial application
> > > > 
> > > > Changes in v4 (due to rebase):
> > > > - moved *_get_assigned_resources() changes for DSPP and LM from
> > > >    encoder *_virt_atomic_mode_set() to *_assign_crtc_resources()
> > > > ---
> > > >   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  18 +--
> > > >   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  10 +-
> > > >   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h     |  12 +-
> > > >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c      | 189 ++++++++++++++--------------
> > > >   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h      |   7 +-
> > > >   5 files changed, 110 insertions(+), 126 deletions(-)
> > > 
> > > This commit breaks several tests in CI:
> > > - sc7180-trogdor-kingoftown:
> > >    - kms_cursor_crc@cursor-dpms
> > >    - kms_pipe_crc_basic@disable-crc-after-crtc
> > > - sc7180-trogdor-lazor-limozeen
> > >    - kms_cursor_crc@cursor-dpms
> > >    - kms_pipe_crc_basic@disable-crc-after-crtc
> > 
> > Hey Dmitry,
> > 
> > Thanks for catching this. Looks like this was exposed due to a recent IGT
> > uprev that included  dc2d7fb4f978 ("lib/igt_kms: move setting
> > DRM_CLIENT_CAP_WRITEBACK_CONNECTORS to kms_writeback").
> > 
> > The issue itself is that when DPMS is toggled, it is possible for RM to
> > reserve new HW resources but skip the atomic_enable() due to the checks here
> > [1]. This means that the change in HW block reservation won't be propagated
> > to encoder if DPMS is set to off.
> 
> Could you possibly clarify this. What is the state change that causes
> the issue (describe CRTC / connectors / encoders and active / enabled
> state). Why does the issue manifest only after switching to the CRTC id
> for resource allocation (the tests run successfully before this patch,
> i.e. with the resource allocation being moved to CRTC, but using the
> encoder ID for allocation).
> 
> Note, the CRTC won't re-allocate resources if
> drm_atomic_crtc_needs_modeset() is not true. So I'm not sure how can we
> end up in a situation when the resources are reallocated _and_ we need
> to raise the mode_changed flag.

I'm going to apply the following fixup on top of your series (to the
previous patch), fixing the DPMS issue. It makes all SC7180 tests pass
in CI.

 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index ba5c60296e17..10653bd52885 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1373,7 +1373,8 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 
 	bool needs_dirtyfb = dpu_crtc_needs_dirtyfb(crtc_state);
 
-	if (drm_atomic_crtc_needs_modeset(crtc_state)) {
+	/* don't reallocate resources if only ACTIVE has beeen changed */
+	if (crtc_state->mode_changed || crtc_state->connectors_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
-- 
2.39.5


> 
> > I've posted a fix for this here [2].
> > 
> > Thanks,
> > 
> > Jessica Zhang
> > 
> > [1] https://elixir.bootlin.com/linux/v6.14-rc4/source/drivers/gpu/drm/drm_atomic_helper.c#L1502
> > [2] https://patchwork.freedesktop.org/series/145735/
> > 
> > > 
> > > Corresponding pipeline is available at [1]
> > > 
> > > As I had to rebase your changes on top of msm-next, corresponding tree
> > > is available at [2]. It might be possible that the regression is
> > > introduced by my rebase.
> > > 
> > > [1] https://gitlab.freedesktop.org/drm/msm/-/pipelines/1374165
> > > 
> > > [2] https://gitlab.freedesktop.org/lumag/msm/-/commits/msm-next-lumag-cwb
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry
> > 
> 
> -- 
> With best wishes
> Dmitry

-- 
With best wishes
Dmitry

