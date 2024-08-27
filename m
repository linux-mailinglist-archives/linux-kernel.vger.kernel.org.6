Return-Path: <linux-kernel+bounces-303983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B2B9617F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900581F24662
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CB41D2F72;
	Tue, 27 Aug 2024 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OR5KQZqD"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39077117
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724786808; cv=none; b=HNgzLNSnPYw2inlPWFRyUlyTo+IxcDbRtlqJJ9p+4qQUNEpnqunHNI3q/XKEri7f4t6Q6DIcaO1VBrJ12YHIby0jDn9eXVlKXFnQpEwk+mh7s8Ok/rGXrBI7Bt7TWEc0cb0+89cGkVWa2/uCbw4paMT87H0CyU9YWqm6MCfiFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724786808; c=relaxed/simple;
	bh=lKH6nWcXihMLmsyieu9h1t6M3a3w9zMg4VLq2VpVMdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hfOddIHGhVaElCwxMtO856eNOY+c5tOiyg0eRhdGEbmqdjpcyFAmgswkovj3X2HxecPkY7sJC24Cw5FxREXrhYfTrQWU/He9MS7Knu4uCscrETo/n3w8pZGBkugooxLLDhjeRpl0E6N9ldR9N7Vhmp1qRa401KuuQiWywtNh6Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OR5KQZqD; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-844f1c1d0c8so759450241.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724786803; x=1725391603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHOyUE8iY/6Scs/W5U/CSdZ3JZ5DHLQy5vTA2vOVtz0=;
        b=OR5KQZqDicuDSI3ombAUhhFBZrvoYlCMATn0l4721ueqVSLMP8e4E0XlCx+mt7PH6R
         gxfwV2D3frF1ywXxNUouiTOv83tS/JZNeog+UGASHlKBNStUgDup1mswWF2iZM+4YWva
         axU2x5nxRSnUhXUN4otDcRaA7ppT69mMZ1wak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724786803; x=1725391603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHOyUE8iY/6Scs/W5U/CSdZ3JZ5DHLQy5vTA2vOVtz0=;
        b=VRAMhnaRbaWHNPNdSQxg0ixbXTQHTdpzZwg+Hw+UEmL8uatfTAIV9aHnWaTCuyCjHU
         o83CedGFOtFBK2u7CSlM8kDcMpynvQIG+ZpmcQIcEMzUh5qtgoD0iqZnFySMdP+/A5d7
         aYMX3oySpPgBimFMVV8VRP3wGnRXxdkOc9Uz5FZ5v4x+JEp36J+JiC9Xwv8cndYQLTjT
         VVGYF5Fx5KKdyme8DEViJA47GgmE98WDP6FGw6eVKLkZSFUz3luwwtD7s+bW93S0MNPu
         Gwh2Z1YVta2SsWU68k3DVQdbYdE5h9VqYFuUSciELf7cAnJRLFt3dpthjgHaQL/4p/Oq
         ElhA==
X-Forwarded-Encrypted: i=1; AJvYcCVzwGs6pHTv+qHde3mwkTjaUTljkvldxJvgOnvDDREeFCmH6HmLQV/DE00VmHNijyLXG4QRK21wQWeYSe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV364bTc4775SjfDuBg+Gu6S5+1dPYF12JeoFthqXOUG74UQrL
	OgUbkTXiZKmG1jMHgedd/oCnLDN+5Sakd8AYOSgrEXiWbYoa4DuSbmKWNVIexCuafJ6BmlWtAr0
	=
X-Google-Smtp-Source: AGHT+IHqbSoKEB5etLw5mlfmlYX4iUSn5pIu/HQRunNPIyNOqnNH+phbBY6WrgW2VODgs9XgJcuyRg==
X-Received: by 2002:a05:6102:c07:b0:493:d4e7:4ea7 with SMTP id ada2fe7eead31-498f46f01c9mr16072003137.19.1724786803195;
        Tue, 27 Aug 2024 12:26:43 -0700 (PDT)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com. [209.85.222.172])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db09a7sm58994996d6.95.2024.08.27.12.26.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 12:26:41 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1e0ff6871so379731885a.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:26:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGlUiXN0ur+7aD5/M2Hb5FdtZ2oGyTG6GDju54o1XyRBkmN8ACf7PtxGfNINtqo+udw6ohTcIzyjGBgS4=@vger.kernel.org
X-Received: by 2002:a05:6214:4613:b0:6c3:33b1:20d0 with SMTP id
 6a1803df08f44-6c333b121f9mr15126336d6.53.1724786801089; Tue, 27 Aug 2024
 12:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824084422.202946-1-tejasvipin76@gmail.com>
In-Reply-To: <20240824084422.202946-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 27 Aug 2024 12:26:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VO+OTpMi0B=jzPkQLnof0r-amNVe_YzuXfBEjTvOE45Q@mail.gmail.com>
Message-ID: <CAD=FV=VO+OTpMi0B=jzPkQLnof0r-amNVe_YzuXfBEjTvOE45Q@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: novatek-nt35950: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
	quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 24, 2024 at 1:44=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> +static void nt35950_set_cmd2_page(struct mipi_dsi_multi_context *dsi_ctx=
,
> +                                 struct nt35950 *nt, u8 page)
>  {
>         const u8 mauc_cmd2_page[] =3D { MCS_CMD_MAUCCTR, 0x55, 0xaa, 0x52=
,
>                                       0x08, page };
> -       int ret;
>
> -       ret =3D mipi_dsi_dcs_write_buffer(nt->dsi[0], mauc_cmd2_page,
> +       mipi_dsi_dcs_write_buffer_multi(dsi_ctx, mauc_cmd2_page,
>                                         ARRAY_SIZE(mauc_cmd2_page));
> -       if (ret < 0)
> -               return ret;
> +       if (dsi_ctx->accum_err)
> +               return;
>
>         nt->last_page =3D page;
> -       return 0;

nit: It's a style choice, but I personally would have changed the above to =
just:

if (!dsi_ctx->accum_err)
  nt->last_page =3D page;


> @@ -284,109 +258,68 @@ static int nt35950_on(struct nt35950 *nt)
>  {
>         const struct nt35950_panel_mode *mode_data =3D nt->desc->mode_dat=
a;
>         struct mipi_dsi_device *dsi =3D nt->dsi[0];
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
>         nt->cur_mode =3D nt35950_get_current_mode(nt);
>         nt->dsi[0]->mode_flags |=3D MIPI_DSI_MODE_LPM;
>         nt->dsi[1]->mode_flags |=3D MIPI_DSI_MODE_LPM;
>
> -       ret =3D nt35950_set_cmd2_page(nt, 0);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D nt35950_set_data_compression(nt, mode_data[nt->cur_mode].=
compression);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D nt35950_set_scale_mode(nt, mode_data[nt->cur_mode].scaler=
_mode);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D nt35950_set_scaler(nt, mode_data[nt->cur_mode].scaler_on)=
;
> -       if (ret < 0)
> -               return ret;
> +       nt35950_set_cmd2_page(&dsi_ctx, nt, 0);
> +       nt35950_set_data_compression(&dsi_ctx, nt, mode_data[nt->cur_mode=
].compression);
> +       nt35950_set_scale_mode(&dsi_ctx, mode_data[nt->cur_mode].scaler_m=
ode);
> +       nt35950_set_scaler(&dsi_ctx, mode_data[nt->cur_mode].scaler_on);
> +       nt35950_set_dispout(&dsi_ctx, nt);
>
> -       ret =3D nt35950_set_dispout(nt);
> -       if (ret < 0)
> -               return ret;
> -
> -       ret =3D mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLA=
NK);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set tear on: %d\n", ret);
> -               return ret;
> -       }
> -
> -       ret =3D mipi_dsi_dcs_set_tear_scanline(dsi, 0);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set tear scanline: %d\n", ret);
> -               return ret;
> -       }
> +       mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_V=
BLANK);
> +       mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx, 0);
>
>         /* CMD2 Page 1 */
> -       ret =3D nt35950_set_cmd2_page(nt, 1);
> -       if (ret < 0)
> -               return ret;
> +       nt35950_set_cmd2_page(&dsi_ctx, nt, 1);
>
>         /* Unknown command */
> -       mipi_dsi_dcs_write_seq(dsi, 0xd4, 0x88, 0x88);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xd4, 0x88, 0x88);
>
>         /* CMD2 Page 7 */
> -       ret =3D nt35950_set_cmd2_page(nt, 7);
> -       if (ret < 0)
> -               return ret;
> +       nt35950_set_cmd2_page(&dsi_ctx, nt, 7);
>
>         /* Enable SubPixel Rendering */
> -       mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_EN, 0x01);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_PARAM_SPR_EN, 0x01);
>
>         /* SPR Mode: YYG Rainbow-RGB */
> -       mipi_dsi_dcs_write_seq(dsi, MCS_PARAM_SPR_MODE, MCS_SPR_MODE_YYG_=
RAINBOW_RGB);
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MCS_PARAM_SPR_MODE,
> +                                    MCS_SPR_MODE_YYG_RAINBOW_RGB);
>
>         /* CMD3 */
> -       ret =3D nt35950_inject_black_image(nt);
> -       if (ret < 0)
> -               return ret;
> +       nt35950_inject_black_image(&dsi_ctx);
> +       mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
>
> -       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> -       if (ret < 0)
> -               return ret;
> -       msleep(120);
> -
> -       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> -       if (ret < 0)
> -               return ret;
> -       msleep(120);
> +       mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 120);
>
>         nt->dsi[0]->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>         nt->dsi[1]->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
>
> -       return 0;
> +       return dsi_ctx.accum_err;

I think you only want to clear "MIPI_DSI_MODE_LPM" if there was no
error, right? That matches the old code. So you'd want:

if (dsi_ctx.accum_err)
  return dsi_ctx.accum_err;

nt->dsi[0]->mode_flags &=3D ~MIPI_DSI_MODE_LPM;
nt->dsi[1]->mode_flags &=3D ~MIPI_DSI_MODE_LPM;

return 0;


>  static int nt35950_off(struct nt35950 *nt)
>  {
> -       struct device *dev =3D &nt->dsi[0]->dev;
> -       int ret;
> +       struct mipi_dsi_device *dsi =3D nt->dsi[0];
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D dsi };
>
> -       ret =3D mipi_dsi_dcs_set_display_off(nt->dsi[0]);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to set display off: %d\n", ret);
> -               goto set_lpm;
> -       }
> -       usleep_range(10000, 11000);
> +       mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> +       mipi_dsi_usleep_range(&dsi_ctx, 10000, 11000);
>
> -       ret =3D mipi_dsi_dcs_enter_sleep_mode(nt->dsi[0]);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to enter sleep mode: %d\n", ret);
> -               goto set_lpm;
> -       }
> -       msleep(150);
> +       mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +       mipi_dsi_msleep(&dsi_ctx, 150);
>
> -set_lpm:
> -       nt->dsi[0]->mode_flags |=3D MIPI_DSI_MODE_LPM;
> -       nt->dsi[1]->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +       if (dsi_ctx.accum_err) {
> +               nt->dsi[0]->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +               nt->dsi[1]->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +       }

I'm pretty sure you want to set MIPI_DSI_MODE_LPM _unconditionally,
right? The old code would set it in both error and non-error cases I
think.


> @@ -452,10 +384,8 @@ static int nt35950_prepare(struct drm_panel *panel)
>         nt35950_reset(nt);
>
>         ret =3D nt35950_on(nt);
> -       if (ret < 0) {
> -               dev_err(dev, "Failed to initialize panel: %d\n", ret);
> +       if (ret < 0)
>                 goto end;
> -       }

I'd just get rid of the "if" test since "end" is next anyway. Given
that there's no error message it seems silly to have the "if" test
now.


> @@ -469,12 +399,8 @@ static int nt35950_prepare(struct drm_panel *panel)
>  static int nt35950_unprepare(struct drm_panel *panel)
>  {
>         struct nt35950 *nt =3D to_nt35950(panel);
> -       struct device *dev =3D &nt->dsi[0]->dev;
> -       int ret;
>
> -       ret =3D nt35950_off(nt);
> -       if (ret < 0)
> -               dev_err(dev, "Failed to deinitialize panel: %d\n", ret);
> +       nt35950_off(nt);

This is the only caller of nt35950_off() and you no longer check the
return code, so you can just make nt35950_off() void, right?

