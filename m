Return-Path: <linux-kernel+bounces-382148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E59B0A14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D257284A7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D007189916;
	Fri, 25 Oct 2024 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UxtQfRyh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF8165EF8
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729874234; cv=none; b=srzRD7C6o2wDJxdZ+UUPhSHrqNGpbxQYZvM9Qg8fvAcg4vh2S8e9a4H6oeI0lH6BGT1A8svvVmhRK0SwZYLWVggFm1I/d6P7dM+sQH3vgcvW3OC1SJ0dcpBYjPNcHfaI/UaRG0EYTjDZHLuR0zz4mCMgfUR97Hr4yLJgudo7sz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729874234; c=relaxed/simple;
	bh=ySdcD7Me/PWPRhlRCagk1hkwrdCnc7x3yE8lgZoAf1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s93LIq2QjbsXOZCMS/FO785lOmF1iDIc0cHVZ2ZcOO5l8VZddlqSD319xmy098YCYrPXV54/LlINFKko20rjBYs0h+LiS6WDE2yf9DdefEII/c8VPiWBDa+P2P5RElHRakYtUru4TPQk27Hzob7g7PsgPN5M+9O2MlaEkj1eClc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UxtQfRyh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so2650506e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729874230; x=1730479030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOEn92bswQiIh6B0O753YjxjbgH7xEMK7FXjbHm+E6k=;
        b=UxtQfRyhEp7MOsqbdK2UxjKMrefGswVyOdgaaY5+3wrjLHweM+KiubZ1bjtDstHMJk
         Kjda71OHwPpKgpf41yB/ewf9NzXbQuqQ8w+kj8bAOo73FdES75urJB0dmlYUcl0CJrVi
         POXRBi+PuFx4binM2HgEXdpcNX0+vv5j+XhDMcOrrt7bSBPRDnNBpshhDptw9fpOVK+L
         JRLlgmM6TtihouwznEc+29KAhf8kKVZRHndj/rC0n+WJGDuFh4lqNfN5dpNOXajmqGWX
         iwx+cISyl9E6Uz2gsnpfdDBlU17ASeuAh4dV1oCL5EKZqnOupDILv/yX5J03rcUgEmP+
         4b6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874230; x=1730479030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOEn92bswQiIh6B0O753YjxjbgH7xEMK7FXjbHm+E6k=;
        b=ss9/QHvydIserjk89AwEpd25rxWpLrjXdwkz849AQd/Z5k+mOlgWrxVFGaZQuvgaCO
         6L2EAIJpfXeZKhILKRzhY+ylDSmR2hN2HOEuxP4wuh7vt96qWx0z9ee4z7fILrrWCYci
         7G22P8KO7laZUjdm/9ujBhhbmjBokUXLDjcahfEaoXolanF75n5dllVJ2QLJGZ1uPXAb
         cJ4vJf0qOyHnfRbEkpMsg/FPcP9dP5UFYAdR44K8FNz0Lt7+grAxV8KwHF91Kzqm78/i
         zuJm0ZI+3UsuJSdDWSy/PhPHilHrwqA0Kfy6s0BRm1zrvMFc+BbxQFcYy7hm33Q0bvav
         pG9w==
X-Forwarded-Encrypted: i=1; AJvYcCWZIFrF7eg1osfqoC7WoMpZ9CQgBwvOEf+Flr3CogyraRmNG6qfjMx/nZcax8C8Qkrc+dAd55FJQ13o7ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNp5ilOJ9p63bfyRkXB9IHEsXuQ825C+Fe5SVQlkYoHbtbIV/
	6BSm/YBBQorLLJtdYJ02E3Wj/m48Z6ptUJxlSrxmwJF+XP7bgiXAUbWttEKg4nj9nzeW1nDOzWk
	jQnNKW/BsNSR0cvi5X82rKQjL8x9G3bR1sZqAmA==
X-Google-Smtp-Source: AGHT+IHHe9pruRyF7p97JeWtRJklETd8ZL5WPfRry1VxSwNI6KCKvzhRBrSC7ttvxAMUZC3k8UOafWSQ0/P+03f3fPo=
X-Received: by 2002:a05:6512:689:b0:539:f995:5b00 with SMTP id
 2adb3069b0e04-53b23dcb17bmr3714961e87.7.1729874230297; Fri, 25 Oct 2024
 09:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729738189.git.jahau@rocketmail.com> <bef462116190c26e6339cd58240773f035efcca9.1729738189.git.jahau@rocketmail.com>
In-Reply-To: <bef462116190c26e6339cd58240773f035efcca9.1729738189.git.jahau@rocketmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 25 Oct 2024 18:36:59 +0200
Message-ID: <CACRpkdY6w1LmKP+69TDRLJCszPpz_XAM_uoe8oC07MH-9ALAig@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm/panel: samsung-s6e88a0-ams427ap24: Add initial driver
To: Jakob Hauser <jahau@rocketmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakob,

thanks for your patch!

On Thu, Oct 24, 2024 at 5:18=E2=80=AFAM Jakob Hauser <jahau@rocketmail.com>=
 wrote:

> This initial part of the panel driver was mostly generated by the
> "linux-mdss-dsi-panel-driver-generator" tool [1], reading downstream
> Android kernel file "dsi_panel_S6E88A0_AMS427AP24_qhd_octa_video.dtsi" [2=
].
>
> On top of the generic output of the tool, there were a couple of changes
> applied:
> - Added mipi_dsi_dcs_set_display_on() to function s6e88a0_ams427ap24_on()=
,
>   otherwise the display does not show up.
> - In functions s6e88a0_ams427ap24_on() and s6e88a0_ams427ap24_off()
>   changed DSI commands to multi context and used "accum_err" returns.
> - In functions s6e88a0_ams427ap24_on() and s6e88a0_ams427ap24_off() repla=
ced
>   msleep() by mipi_dsi_msleep().
> - The function s6e88a0_ams427ap24_get_modes() was changed to make use of
>   drm_connector_helper_get_modes_fixed(). This also required to include
>   drm/drm_probe_helper.h.
> - In function s6e88a0_ams427ap24_probe() registring the regulators was ch=
anged
>   to devm_regulator_bulk_get_const(). This required to change supplies in=
 struct
>   s6e88a0_ams427ap24 to a pointer.
> - Removed bool "prepared" from struct s6e88a0_ams427ap24 and according pa=
rts in
>   functions s6e88a0_ams427ap24_prepare() and s6e88a0_ams427ap24_unprepare=
().
>
> [1] https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-gener=
ator
> [2] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/d=
rivers/video/msm/mdss/samsung/S6E88A0_AMS427AP24/dsi_panel_S6E88A0_AMS427AP=
24_qhd_octa_video.dtsi
>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Nice job on this driver so far!

> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/of.h>

Why do you need this include? .of_match_table is part of
<linux/driver.h>

> +static int s6e88a0_ams427ap24_on(struct s6e88a0_ams427ap24 *ctx)
> +{
> +       struct mipi_dsi_device *dsi =3D ctx->dsi;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
> +
> +       dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a);

Can we provide #defines for at least some of this magic?
See other drivers for a very good idea of what some of them mean.
panel-samsung-s6d27a1.c:#define S6D27A1_PASSWD_L2       0xF0    /*
Password Command for Level 2 Control */
panel-samsung-s6d7aa0.c:#define MCS_PASSWD1             0xf0

> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0x5a, 0x5a);

panel-samsung-s6d7aa0.c:#define MCS_PASSWD3             0xfc

> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x11);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfd, 0x11);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x13);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfd, 0x18);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb0, 0x02);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb8, 0x30);
(...)
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 20);
> +
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf1, 0x5a, 0x5a);

panel-samsung-s6d7aa0.c:#define MCS_PASSWD2             0xf1

> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcc, 0x4c);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf2, 0x03, 0x0d);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf1, 0xa5, 0xa5);

panel-samsung-s6d7aa0.c:#define MCS_PASSWD2             0xf1
Send in the reverse password: disable access.

> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xca,
> +                                    0x01, 0x00, 0x01, 0x00, 0x01, 0x00, =
0x80,
> +                                    0x80, 0x80, 0x80, 0x80, 0x80, 0x80, =
0x80,
> +                                    0x80, 0x80, 0x80, 0x80, 0x80, 0x80, =
0x80,
> +                                    0x80, 0x80, 0x80, 0x80, 0x80, 0x80, =
0x80,
> +                                    0x80, 0x80, 0x00, 0x00, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb2,
> +                                    0x40, 0x08, 0x20, 0x00, 0x08);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0x28, 0x0b);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf7, 0x03);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xfc, 0xa5, 0xa5);

Send in the reverse password: disable access.

A bit of #defines and comments would make it much more clear what
is going on.

Yours,
Linus Walleij

