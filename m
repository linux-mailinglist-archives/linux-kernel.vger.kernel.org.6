Return-Path: <linux-kernel+bounces-181021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF2F8C7644
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 14:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDFD1C21C76
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AF2149001;
	Thu, 16 May 2024 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWQTAXFD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF04147C84
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715862172; cv=none; b=L+XRn3izuNp7mqD/kKCsadoPRFP0vLCroKEAsCPpueUCio28GjPwTrnrG0VKqsE3fYKbsgyXY3Rtf4TzchIlwQBH/nnOA3uVi8UfiH+XjEQuf7cLVh7iWHP0+Ksc/OygWFjZLCBfRGnjgBwJU1PKL+ObicG/watosNrb/IDVQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715862172; c=relaxed/simple;
	bh=FeVRRioalwdYWa9mJNxvXj/LYL0k8V1HPUc3F3PbLXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWR2Jpxp/fLZ7dWn1p39q0ElkHlXul4Bgl2461gTgJRwgwdvmxCMzaXCPpkCEGzyyjN7kTgCfpWPlA9H3J0CVghjk4kXoNNRiudxgzHTuU9pKhxyyqTl3upEesghgcHNTfR95NgRJ26KWcEy0gdE0xWvY/zQjxaQhxBSJXc0A/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWQTAXFD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b4aa87e01aso101917a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715862170; x=1716466970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEJR8hPJpPEfgFXU9E3SX+q8sQ52F164lqvG9VHNrco=;
        b=MWQTAXFDc3yptcis28kcn9XCBQz9Jc8ReZxCS3kKj5kADOIVwHK4UJ6E2l+Wj7KQFG
         WQ/51ZPhdR+wU/1z6veFsVTFmavxGPIBZV6a3nG6N0f4QO3b5SnWR4043eNqWMdV1r5l
         UoUXJlIbtTuxRsQtPhFI3ppcu0b1TpnPrdyZ3Eq9FAO8ThqXDppf82H70/ZQ22UMQDMS
         1UYFZzM2QX1a7C1lZiUzgNuU3ub1i4Rpct2lYsTIgYFYJZ6nvYmSJpG/FBsx2puwcPw9
         stMZXo8tevzowzDogHoMbf2gwh6D5GlHnIw+VBYXUlxJwTPkM8k7tTp/2P+4hLf+Dxdz
         KmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715862170; x=1716466970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEJR8hPJpPEfgFXU9E3SX+q8sQ52F164lqvG9VHNrco=;
        b=qIsvE81dX52XLMj37A5mIJNiBx5iSxarIUYHxFXmUyPfz+q5W0VuwYND/2pXPts+7W
         dnM1CfHo1y1dDdDDH4e1Z3+lq890mKFiBpvujLRjxw6eGOVftAFQCOLvdJ3fw4+v4/NM
         wT2jYzFthsdeLlueh7Jh89K4gEKoT7DGYTwMnTgs0CycYSu8+kyDrswcAgRZ3bzh0zuu
         7Nxnlaz9PZLD9/PwnNpDBTmzzmyNc0HbafBSOPtkP2bWC8qNBKnzs4KwbqryFZ/6fc2k
         iv1G19SSrchK0h7q2AZb9BWwfB/XwaW7+i8cIfEY+G5ggSEJBqxvgCmdpmrbH8C7wxSS
         EG2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaXEGAYbmWmxA8mgP3uHAogEzvsqKow8pRNHrWN/9n+trcErT0/a8mniO9cHjgFNS4i5FDNMG7nY3sflakLgT5yZcmIyOYKrNjYu06
X-Gm-Message-State: AOJu0YyD418kma72U66Vc0B6GXsUDpkohA/Mn8sGx4mbCzUOGP3HyT3n
	LQU5DOMChglEVKudBbNMgJwWNBeT5bR/4ifV99Fpkxp8zZT+5CE7Rmres91R+bxwuWLoykMJIwt
	C4tNxoyJUGxWbJb6SFenKqt0OAFg=
X-Google-Smtp-Source: AGHT+IF9iM23m/7qaTv229g3fOJAhMCwN+Gu+QDSppNoB2gwTzxDO8SQ1wawIp9cnlsSpY4+8c5gKhNm9D6D6btwuRA=
X-Received: by 2002:a17:90a:bb09:b0:2ae:78cd:59fe with SMTP id
 98e67ed59e1d1-2b6ccd7fc30mr16639459a91.31.1715862169944; Thu, 16 May 2024
 05:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516101006.2388767-1-victor.liu@nxp.com>
In-Reply-To: <20240516101006.2388767-1-victor.liu@nxp.com>
From: Adam Ford <aford173@gmail.com>
Date: Thu, 16 May 2024 07:22:38 -0500
Message-ID: <CAHCN7xKiVYPfvu1h0Nz2sRCt=P2zfdS1aMdU=LAeptNv0JbfJw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: Exit interrupt handling when necessary
To: Liu Ying <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, biju.das.jz@bp.renesas.com, 
	dmitry.baryshkov@linaro.org, u.kleine-koenig@pengutronix.de, 
	jani.nikula@intel.com, bli@bang-olufsen.dk, sui.jingfeng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:01=E2=80=AFAM Liu Ying <victor.liu@nxp.com> wrote=
:
>
> Commit f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> fails to consider the case where adv7511->i2c_main->irq is zero, i.e.,
> no interrupt requested at all.

Sorry about that.

>
> Without interrupt, adv7511_wait_for_edid() could return -EIO sometimes,
> because it polls adv7511->edid_read flag by calling adv7511_irq_process()
> a few times, but adv7511_irq_process() happens to refuse to handle
> interrupt by returning -ENODATA.  Hence, EDID retrieval fails randomly.
>
> Fix the issue by checking adv7511->i2c_main->irq before exiting interrupt
> handling from adv7511_irq_process().
>
> Fixes: f3d9683346d6 ("drm/bridge: adv7511: Allow IRQ to share GPIO pins")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Acked-by:  Adam Ford <aford173@gmail.com>

> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/d=
rm/bridge/adv7511/adv7511_drv.c
> index 6089b0bb9321..2074fa3c1b7b 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> @@ -479,7 +479,8 @@ static int adv7511_irq_process(struct adv7511 *adv751=
1, bool process_hpd)
>                 return ret;
>
>         /* If there is no IRQ to handle, exit indicating no IRQ data */
> -       if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
> +       if (adv7511->i2c_main->irq &&
> +           !(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
>             !(irq1 & ADV7511_INT1_DDC_ERROR))
>                 return -ENODATA;
>
> --
> 2.37.1
>

