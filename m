Return-Path: <linux-kernel+bounces-262042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E393BFE6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B99C61C21861
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5C198E6C;
	Thu, 25 Jul 2024 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b="Xvk95EJ/"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C97212B95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 10:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721903353; cv=none; b=MGD28099HnJprI/rD8+CTMvcMZg9PmBb5g8TG30iA/kz1ga8Webd2IF06UxQXSH+I2PV/dkiSwEZjojXB1VJpysymbnY8SBIWGFrpsKiGsRLFckfZfgPdHQdXagQ0wvf9uUCzOnzo6DjnXShDoJ9u90fuMAsgGxyOz2Zkc7Kvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721903353; c=relaxed/simple;
	bh=WUvxAzvvRSp5BS4Q5MdLqhcVXiemgVMV06daqZpMWwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKfTBYLqP3FwWqdrIPHsZl3wvRY+BtgE5Fug0Orygdu9zcVo2D+ptgIz9cW7DjTMxH/syd86LsrOlUUQAhyEGIeXHFq3nWGQbkUbz7YLlDjmyApnweYbKH2u6a2p83TH8jfXlVizk5DQBR306FmiLe1nYQamp37Z9voO2R7e2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=none smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar-org.20230601.gappssmtp.com header.i=@fooishbar-org.20230601.gappssmtp.com header.b=Xvk95EJ/; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fooishbar.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b798e07246so5276796d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20230601.gappssmtp.com; s=20230601; t=1721903350; x=1722508150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lqNON2XzzicgPcrb/MJYjLlf4KFN0gRBiFSG0lWMClg=;
        b=Xvk95EJ/Tmtdr6POjblk+zbyq107ZInUSWMIpvPIeY8QN6RBOL9lUDaOhFSFs9/GLt
         BKzsToLmyYHTUoSx2wmj1nSVDBrsmTV88hihC6NGwVWf5UFjTEarCg3ylpqCWu2iqcPM
         PUMdV/CwmlSFR5D2eIqAf1hd6tmDFLzrQGTdQH7m6TcYsvjQC9eP5xZGbh/yXMMuV80d
         +cA/SpsucBvY7DXvjeJkUZ9UkDD1aLf9e4zCtjw43OSj4QBrBf4sHYi2jIHTJa4j0Ndj
         Z9vGOWezKccdTjWqE48sbUklvptVRv8wBCWodJxTa9QlzSe25sWVpwHRmyJMQ1igd5G8
         9uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721903350; x=1722508150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lqNON2XzzicgPcrb/MJYjLlf4KFN0gRBiFSG0lWMClg=;
        b=il6t8FFD8iT9ZwaE/pSu5a+2RfNvtSy2eBcvjwTn0C+QsynOFa+zrujSJbQFDPDnE7
         i0uB3BZPTWT9jViWLlh9JTreO0jiY24xDUrbFl43skXOvBUpjNU4cF1bWod5JUNP9E+o
         lYynFuRfM+aIVyq311DzAaYPNwlaLv3fbgsnWzm2Wpg/n0sLV3zzrD8Nol2/Kcy0/gfe
         gFepQypMhcTfQwvzlF4jpJcGswZ9RNCJGwYjD11u64ftXiioyuDlPZxKQVa2HXfOn2e+
         umR3SWqUT0OicZuws02FNZTx3r0e/Am6qY+FRgnGYn8p3JH6uLmBiS27z/oCtxOMx1B1
         y2Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVW0OyJkR9BfpZ4Q2MSnFpj1E90fD9LIKtyQ//6Ze8cC7d5qpBg4Q6MJMSJMBe5YnsIIhKsk/seknpJQ+D6EW7PPdUOdfgRPFfiHhwB
X-Gm-Message-State: AOJu0YwDO10KYz45sWqok6hZo6r3LGEF9yH0NC+GhvGu/tYGHudDTwn4
	Or53YAAt0mZTZmHRExF+W8ShbVL9Q/MpC1/uhpUz9XsiNc9n5yQrsRsFB8BXwiDDJIAjTq3aJKA
	ymzfoyIk+bxhJ4F0CBdyIAvSg+ktFrcDBvWM/s+T5r0H4E5323Z8=
X-Google-Smtp-Source: AGHT+IH58fYzPz2za1A4wbM/RxniQBXqyWW1aq5VxWvoCjFUwdMxzQTEFxAC6/D8edl0M5w58o3zWa9AamOI0NUg0xw=
X-Received: by 2002:a05:6214:230c:b0:6b5:a4f6:daa2 with SMTP id
 6a1803df08f44-6bb406fcd47mr14595366d6.17.1721903350287; Thu, 25 Jul 2024
 03:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TkgKVivuaLFLILPY-n3iZo_8KF-daKdqdu-0_e0HP-5Ar_8DALDeNWog2suwWKjX7eomcbGET0KZe7DlzdhK2YM6CbLbeKeFZr-MJzJMtw0=@proton.me>
In-Reply-To: <TkgKVivuaLFLILPY-n3iZo_8KF-daKdqdu-0_e0HP-5Ar_8DALDeNWog2suwWKjX7eomcbGET0KZe7DlzdhK2YM6CbLbeKeFZr-MJzJMtw0=@proton.me>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 25 Jul 2024 11:28:58 +0100
Message-ID: <CAPj87rPwJ-vRTsjM1rWRj1gyjbJM_ryrkTiPRBF3ZF1D7TVDYw@mail.gmail.com>
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

On Wed, 24 Jul 2024 at 23:06, Piotr Zalewski <pZ010001011111@proton.me> wrote:
> Add support for gamma LUT in VOP2 driver. The implementation is based on
> the one found in VOP driver and modified to be compatible with VOP2. Blue
> and red channels in gamma LUT register write were swapped with respect to
> how gamma LUT values are written in VOP. Write of the current video port id
> to VOP2_SYS_LUT_PORT_SEL register was added before the write of DSP_LUT_EN
> bit. Gamma size is set and drm color management is enabled for each video
> port's CRTC except ones which have no associated device. Tested on RK3566
> (Pinetab2).

Thanks a lot for doing this!

> +static void vop2_crtc_gamma_set(struct vop2 *vop2, struct drm_crtc *crtc,
> +                               struct drm_crtc_state *old_state)
> +{
> +       [...]
> +
> +       vop2_lock(vop2);
> +       vop2_crtc_write_gamma_lut(vop2, crtc);
> +       vop2_writel(vp->vop2, RK3568_LUT_PORT_SEL, vp->id);
> +
> +       vop2_vp_dsp_lut_enable(vp);
> +
> +       vop2_cfg_done(vp);
> +       vop2_unlock(vop2);
> +}
>
> @@ -2060,6 +2159,9 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>         drm_crtc_vblank_on(crtc);
>
>         vop2_unlock(vop2);
> +
> +       if (crtc->state->gamma_lut)
> +               vop2_crtc_gamma_set(vop2, crtc, old_state);
>  }

In the atomic_enable callback, we are already holding the VOP lock,
and waiting to set cfg_done etc - we then do it all over again here.
This should all be atomic, so that we configure the LUT whilst doing
the setup, and then only call cfg_done once, to avoid showing the user
intermediate states which only later converge on the desired final
state.

Cheers,
Daniel

