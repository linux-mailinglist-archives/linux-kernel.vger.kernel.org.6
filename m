Return-Path: <linux-kernel+bounces-263185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40D93D24D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFCEB20EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64D17A592;
	Fri, 26 Jul 2024 11:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="VrfUdBW7"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14061EF01
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993508; cv=none; b=NhILfMhCx5/WxlfVAeHtHdtqdCL+xIWkFaRGNiwPW1FXncRkJTlJ0gIPgkmKoIi+JiQtKF9imCWatDPRk6+SH5HiUOwtiVKSG1wx63l7k/RztEXe7QccG39sVPeZz3l+At4op4iAa5BGuLu849PL2X6izsQmLEiXrE2zlq0Qcro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993508; c=relaxed/simple;
	bh=6AkwrgRLG5W/CxJyM98Ta25bwmSU/41BBpT0AJ8d5JE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwhVuP4iqMNNV5fEyMHecO3SsnBCc0IBqf7nrmsI69EiK0ZEDM+x6is3/4/OGeuY6bILJMvVus7ovawQ3p1etdaTKWjpzAtA9+WT/Z0H00rA8TGxv8t38fSyMODcOnO8bKmzjqGU/FeQ3eiFwzHzRjGY9lYTEtVwLWkWF4MEEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=VrfUdBW7; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5c6661bca43so539069eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1721993506; x=1722598306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmk1JjA2Ls4g+KyqSuHumcBghaFAtTT2atg+wkKZS7s=;
        b=VrfUdBW7HEijbnLFBEmsUfYgB3xZ5iIVY2FwQBxvrVLDJ6FRHbvIBB8L5P05cz1jwW
         E4uX2ixiqXbYRh0D6d8kfli5kBJMA1wie84o2Dwla2edGWtQdg3rrXCf92t9K7sQuV4W
         RFE/ij0mDAdJIfep9CKTbw5aId/YZn16gG8gEA4QfgoeCZUrinAzpOCAPWtgJgXImGXH
         9Zoi1FZ+/nWag3JOaTyLoEbuEu/f92TfzbuuD7cuzrs0ZNAB+GsMPcjXoypjNuz8pwLr
         NQ7Y5fNDT2REX1OIsTZTfDjNeJzMuLF+6fSRlMF6EGFR+4g1Jy0utpInplPTRyz1rqsE
         yoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721993506; x=1722598306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kmk1JjA2Ls4g+KyqSuHumcBghaFAtTT2atg+wkKZS7s=;
        b=YqxxUIOMGPo0ZzmuaOG4ows7smaHiZr2kmNI3t4znOnNN0HjmgZInaKkvEKNjM+PGG
         FP1EyOMk5Bb+L39tw6No/Kf9x/fG5qkQau+yynWcDzDGGMSi9nofbkEY1MPpFoz103oe
         tnFx166HzXEYQFMpjHxKej5A0GpW2sDCTB1EDENOcqzPum8aZyKul5EPwCISYOYkQaBI
         X7T3rmKN1IPVLi1PfqTYpxh3xmDCX6NKsXk2utyUuI8PIdEYLCMjNHdIPAF2YfTxFqMh
         g+k3swcmZQkQCHQwVACDd2VLFfkZLFEyY5eQJtwMMnu7bq9uTUCDsZrJoeDm2tJUzXCE
         0q+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9NI8Xq3kotUAzNV+mkWgQN0S0/nIW2boPcjs0TwDhlfJ99KdA8oMRdMX3p0GGtQ3BjGv498qlehodppUBqbAEY9wqWfeKRxf1OkBq
X-Gm-Message-State: AOJu0Ywm9uYsmk4TeQMOFi2CGG5Ya5IkRRP2QWH3CwbcqTY0occd2l8W
	fqMkKUD10eDxHYlmj/tPCWQpEqjH//oiNQn1Lev27FF8AvQBDEUiNJSUgqWkCkOsXK5uXTPe8x8
	dl81YP+IeCLJrzIN2t8LvBOf3g6oh7XJIR/Y6Ww==
X-Google-Smtp-Source: AGHT+IGvPfPntSm/3Bto2qo4lI9AXdvO3Bew6FS2Yq3n8hvJGd9oEEOgF1uuOwWL92xMEZYtBtPacNHYm21W/2FzE+w=
X-Received: by 2002:a05:6358:280e:b0:1aa:bad6:2ba7 with SMTP id
 e5c5f4694b2df-1acfb99ed34mr636036055d.25.1721993505839; Fri, 26 Jul 2024
 04:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TkgKVivuaLFLILPY-n3iZo_8KF-daKdqdu-0_e0HP-5Ar_8DALDeNWog2suwWKjX7eomcbGET0KZe7DlzdhK2YM6CbLbeKeFZr-MJzJMtw0=@proton.me>
 <CAPj87rPwJ-vRTsjM1rWRj1gyjbJM_ryrkTiPRBF3ZF1D7TVDYw@mail.gmail.com> <PGDz1uKmBh2U_yB-ut5xcahPHdmxgrIRAwALnJzsEHFuYssmMhQUz8jbHpEyUDBMjVbmQCjlP3K4gbzw3zZ53HhXUsXufBb5YzptnC58aeQ=@proton.me>
In-Reply-To: <PGDz1uKmBh2U_yB-ut5xcahPHdmxgrIRAwALnJzsEHFuYssmMhQUz8jbHpEyUDBMjVbmQCjlP3K4gbzw3zZ53HhXUsXufBb5YzptnC58aeQ=@proton.me>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 26 Jul 2024 12:31:34 +0100
Message-ID: <CAPj87rOM=j0zmuWL9frGKV1xzPbJrk=Q9ip7F_HAPYnbCqPouw@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip/drm: vop2: add support for gamma LUT
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: "airlied@gmail.com" <airlied@gmail.com>, "andy.yan@rock-chips.com" <andy.yan@rock-chips.com>, 
	"daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "heiko@sntech.de" <heiko@sntech.de>, 
	"hjc@rock-chips.com" <hjc@rock-chips.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de" <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"

Hi Piotr,

On Thu, 25 Jul 2024 at 20:06, Piotr Zalewski <pZ010001011111@proton.me> wrote:
> I based my patch on how gamma LUT is handled in VOP. There, in atomic
> enable, gamma LUT write takes places at the end too, after the mutex was
> already first-time unlocked. I understand the concept of DRM atomic state
> updates and what you wrote makes sense.

Yeah, no problem - the old VOP1 code is clearly incorrect here. I'm
glad you can improve VOP2. :)

>  static void vop2_dither_setup(struct drm_crtc *crtc, u32 *dsp_ctrl)
> @@ -2152,6 +2127,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>
>         vop2_post_config(crtc);
>
> +       if (crtc->state->gamma_lut)
> +               vop2_crtc_gamma_set(vop2, crtc, old_state, &dsp_ctrl);

I think this call should be unconditional, so that we correctly
program LUT_DIS if there is no LUT set up during enable.

> @@ -2599,8 +2575,17 @@ static void vop2_crtc_atomic_begin(struct drm_crtc *crtc,
>         vop2_setup_alpha(vp);
>         vop2_setup_dly_for_windows(vop2);
>
> -       if (crtc_state->color_mgmt_changed && !crtc_state->active_changed)
> -               vop2_crtc_gamma_set(vop2, crtc, old_crtc_state);
> +       if (crtc_state->color_mgmt_changed && !crtc_state->active_changed) {
> +               u32 dsp_ctrl = vop2_vp_read(vp, RK3568_VP_DSP_CTRL);;
> +
> +               vop2_lock(vop2);
> +
> +               vop2_crtc_gamma_set(vop2, crtc, old_crtc_state, &dsp_ctrl);
> +
> +               vop2_vp_write(vp, RK3568_VP_DSP_CTRL, dsp_ctrl);
> +               vop2_cfg_done(vp);
> +               vop2_unlock(vop2);
> +       }

Calling lock/set/write/done/unlock here seems like an anti-pattern;
the cfg_done is already written in atomic_flush, so at least that part
is not necessary.

On platforms like RK3588, it looks like the new LUT can just be
written directly from atomic_begin without needing to program
DSP_CTRL, take locks, or synchronise against anything, so that should
be an easy straight-line path.

On platforms like RK3568, it would probably be better to set
mode_changed when the colour management configuration changes. That
will give you a good point to synchronise the cross-VOP dependencies
(i.e. claim or release the shared LUT when it is being
enabled/disabled), and also a hint to userspace that it is not going
to be a seamless transition as the LUT is disabled, programmed, then
re-enabled.

I think this would end up in a net reduction of LoC as well as a net
reduction of code weirdness.

Cheers,
Daniel

