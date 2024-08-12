Return-Path: <linux-kernel+bounces-283897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9901794FA15
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A4BB216B7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B34199380;
	Mon, 12 Aug 2024 22:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BUgTwgi5"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860E91304B0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723503592; cv=none; b=NfjQbqN7s/o1U7+pDj+c0sIbAHqmzpYaAKEEQvWtuhy+ltxU3mE9FoII1wlfPf+A2/h0rVZU/cEID+KCdcc5oout39NTkOYcyPqetga5yT/pBYaaEoREZkbDlDO810A30NIJgDHntTv6C8PbPEN/+H3RvdBytL3Z7MnttjJbRbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723503592; c=relaxed/simple;
	bh=sufvHmxxUMwSSo40IIFlWXzd/zpVheYm4x4sDtjVVN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVfaIwvrbhmNBN9eYXNhFz5jsih1Unz0x+UdFxpXpi9iP+OskJ0ZYDnbQdjnsjOOkAnvOhgAutfcvs//Ieyytsabx5/yVJ38w/rnR6tJaadBEvgCHdnGIIPWh9QIMtluOTxdWBOLR0BbsdpY6MxXMD4IG4n9xYzTA5ElVRLzHDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BUgTwgi5; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70968db52d0so5135377a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723503587; x=1724108387; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ENm0R32ljVSLiP588ivQL+EpMS161fFo6/+DPyhWgc=;
        b=BUgTwgi5oBANweuoX6LF5nkdTEhAC1DRHDPEavHqxC7WLlI98UuRfPMNH3c/dTHpJB
         qRVxUfnAtNEXAj9SrPYft5lr4wF9ExZOjFK9LvMINHTt8lhNzTIEYDZ9Guq0nQJpy8z1
         CmbnR0GgXWiXoP0ZiRo3voc/ZVOH81C0sz8ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723503587; x=1724108387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ENm0R32ljVSLiP588ivQL+EpMS161fFo6/+DPyhWgc=;
        b=TkAnouhrxa8tiX3u3alFdfWdcQ7kOt8W/Xz0XNQuH22K3cAKopD54dL+hwO6T03/gg
         wZ8V8PcfgCb6rkEWW9smYOcVbvN6axxhbwilJOJ4MB6XNI7ZYIcKULcnuDdsdbFba2gs
         Ez5bsyNhT8LxQe0TWgp87gsMULp72Gfn3rU19h/jhL8Cgl6D9JJv2xVNHX1aloHPeE6W
         ES+x3+IKBPl4ztMwvzbLfr4UYzr+5w7GL0aYvBMyRpsgJsa9zv8p+zHLzQ+G+w32EhRb
         u8gFQfO96WEQStVfFG/4AZ238DTvmWRN1b0ZjvaKDf5qiMk1VlO8QDL12FrtPGVGUTqQ
         cJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXayDLHr1Q+vGWucRGev6rBHF4WPZNNEi3Dk8O5yJYnl+IHaCVmA9qkAn2DSBAZqfjtpUa50uO9l6jpM6qyBLjl7u/8oLeAzl48peqX
X-Gm-Message-State: AOJu0YxPebGHuLFA6yWc1bu4Hj6pj2Ej2fDMy+mxRkZJAVbj3nW42DiI
	iUIbwxji1mjIYhXgBra73tR1zp2R5MJkAUlfOJ4p5mNl1bsyc4wRQSdKZa06J+vEZocuNUyOJac
	=
X-Google-Smtp-Source: AGHT+IGAABIdZgaR8kE4FmmJtpKWGtHPwlDS2umIVo4WFAQlc4J6qz3IzRORfRXUdvv2GHoAbbMvwQ==
X-Received: by 2002:a05:6830:369a:b0:709:39c0:1b21 with SMTP id 46e09a7af769-70c939c00f5mr2181283a34.34.1723503587531;
        Mon, 12 Aug 2024 15:59:47 -0700 (PDT)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com. [209.85.210.54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70c7b890aebsm1565054a34.76.2024.08.12.15.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 15:59:46 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-70968db52d0so5135327a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:59:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/whYByERB7PB6WaUq8MXaGcXhc3lXISpQv5aX6e9Q2yVW8sGirUTZ16vFR3DmIVPrvLx6lgP0znLGEoN4NZt2Sy24Omcyl1C72AzE
X-Received: by 2002:a05:6358:430e:b0:19f:4c1b:f0f8 with SMTP id
 e5c5f4694b2df-1b19d2e6507mr253084955d.24.1723503585569; Mon, 12 Aug 2024
 15:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810045404.188146-1-tejasvipin76@gmail.com> <20240810045404.188146-3-tejasvipin76@gmail.com>
In-Reply-To: <20240810045404.188146-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 12 Aug 2024 15:59:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPX+q9wVO4h2P_4JASoFeAozLP5uDqAXj7fxZe4woj9w@mail.gmail.com>
Message-ID: <CAD=FV=XPX+q9wVO4h2P_4JASoFeAozLP5uDqAXj7fxZe4woj9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panel: jdi-fhd-r63452: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 9, 2024 at 9:55=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> @@ -41,79 +41,41 @@ static void jdi_fhd_r63452_reset(struct jdi_fhd_r6345=
2 *ctx)
>  static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
>         dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
>
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
> -       mipi_dsi_generic_write_seq(dsi, 0xec,
> -                                  0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x=
0b, 0x0b,
> -                                  0x13, 0x15, 0x68, 0x0b, 0xb5);
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
> +                                        0x64, 0xdc, 0xec, 0x3b, 0x52, 0x=
00, 0x0b, 0x0b,
> +                                        0x13, 0x15, 0x68, 0x0b, 0xb5);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
>
> -       ret =3D mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLA=
NK);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set tear on: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_V=
BLANK);
>
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_ADDRESS_MODE, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_ADDRESS_MODE,=
 0x00);
>
> -       ret =3D mipi_dsi_dcs_set_pixel_format(dsi, 0x77);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set pixel format: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx, 0x77);
> +       mipi_dsi_dcs_set_column_address_multi(&dsi_ctx, 0x0000, 0x0437);
> +       mipi_dsi_dcs_set_page_address_multi(&dsi_ctx, 0x0000, 0x077f);
> +       mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0x0000);
> +       mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx, 0x00ff);
>
> -       ret =3D mipi_dsi_dcs_set_column_address(dsi, 0x0000, 0x0437);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set column address: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_CONTROL_DIS=
PLAY, 0x24);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE,=
 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_CABC_MIN_BRIG=
HTNESS, 0x00);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
>
> -       ret =3D mipi_dsi_dcs_set_page_address(dsi, 0x0000, 0x077f);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set page address: %d\n", ret);
> -               return ret;
> -       }
> -
> -       ret =3D mipi_dsi_dcs_set_tear_scanline(dsi, 0x0000);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set tear scanline: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 20);
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 80);
>
> -       ret =3D mipi_dsi_dcs_set_display_brightness(dsi, 0x00ff);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display brightness: %d\n", re=
t);
> -               return ret;
> -       }
> -
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x24)=
;
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
> -       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, 0x0=
0);
> -       mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
> -
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display on: %d\n", ret);
> -               return ret;
> -       }
> -       msleep(20);
> -
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> -               return ret;
> -       }
> -       msleep(80);
> -
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x04);
> -       mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xc8, 0x11);
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x04);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x84, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xc8, 0x11);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
>
>         return 0;

Whoops! Not "return 0". "return dsi_ctx.accum_err".


> @@ -121,31 +83,22 @@ static int jdi_fhd_r63452_on(struct jdi_fhd_r63452 *=
ctx)
>  static int jdi_fhd_r63452_off(struct jdi_fhd_r63452 *ctx)
>  {
>         struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
>         dsi->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x00);
> -       mipi_dsi_generic_write_seq(dsi, 0xd6, 0x01);
> -       mipi_dsi_generic_write_seq(dsi, 0xec,
> -                                  0x64, 0xdc, 0xec, 0x3b, 0x52, 0x00, 0x=
0b, 0x0b,
> -                                  0x13, 0x15, 0x68, 0x0b, 0x95);
> -       mipi_dsi_generic_write_seq(dsi, 0xb0, 0x03);
> -
> -       ret =3D mipi_dsi_dcs_set_display_off(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display off: %d\n", ret);
> -               return ret;
> -       }
> -       usleep_range(2000, 3000);
> -
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(dsi);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> -               return ret;
> -       }
> -       msleep(120);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x00);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xd6, 0x01);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xec,
> +                                        0x64, 0xdc, 0xec, 0x3b, 0x52, 0x=
00, 0x0b, 0x0b,
> +                                        0x13, 0x15, 0x68, 0x0b, 0x95);
> +       mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xb0, 0x03);
> +
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +       if (!dsi_ctx.accum_err)
> +               usleep_range(2000, 3000);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
>
>         return 0;

Whoops! Not "return 0". "return dsi_ctx.accum_err".

Aside from that, this looks really nice to me. The code is much more
succinct and I bet much smaller.

FWIW, I won't insist, but I wouldn't object to this patch also fixing
the callers of jdi_fhd_r63452_on() and jdi_fhd_r63452_off() so that
they no longer print error messages since the _multi functions are
always chatty and thus they're just extra double-prints. If you do
this, jdi_fhd_r63452_off() could actually be a function that returned
"void". ...then you might want to add a comment saying why
jdi_fhd_r63452_unprepare() doesn't pass on any errors. That would be
something like "NOTE: even if sending one of the poweroff commands
failed, we won't return an error here. While the panel won't have been
cleanly turned off at least we've asserted the reset signal so it
should be safe to power it back on again later". ...or something like
that.

