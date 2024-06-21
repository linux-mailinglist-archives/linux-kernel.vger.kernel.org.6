Return-Path: <linux-kernel+bounces-225235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61011912DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E891C21662
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B40317BB28;
	Fri, 21 Jun 2024 19:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFGoFt+M"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D717BB09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998439; cv=none; b=bw9TMABQPtjiAIDneUwdJ3KD5hGmNz/3uVfL6xTRwzbsn0Il3MURxVv2UhP0BXCRSxzPxlq4PHKPPO/GzyUeKh+P1Nika/0zBuSsT5G/TMz3NJOths+G0BllGAIrGHHOpZMYMaRTx51vdgWf8c8LbE3sYaDAY+dh1EsVbaciHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998439; c=relaxed/simple;
	bh=TVeaGZGL7PhWYDFTzE/VkEzyRHYSQdt5HbkfHA3+FWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdzRcO08g+MuFza3V5lhx66audrj6DozfvDTRBpj9B1TqqnLD4TZcmOQlpjXZIQZkD7M4Fo/hsc7Oy7mKBQgchLdaD7xlIDe2M6eY+CnlmLxlLLUCocT6DALlkbvK5VGMSmldo5TDkedplsjvCKxSfvDknXMY8nnjNwE8/JNEJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFGoFt+M; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-443580f290dso451351cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 12:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718998437; x=1719603237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nDGM5BfE4nBzMNctKXy8FB1ab1trnMB0GkxkRe1UUc=;
        b=tFGoFt+MNrMRrE1niEkptGD7iOQ25XI6t0mQouqCu2fUfiueosmAhV74St9dvw2TGi
         NKzKuxhq5nwrWRVesY+ksBOI+5A4wyhQwdviIO9Hs/AFkw0Uu5craHX0bXfEpWGXqVbp
         7JJnP2n6DQi2kLRCha3mCmeGkPdjaB+a1QZmnezgele7+3O64AnjMRMjg2pb0Yfy1drh
         jR1oeLVDTT5iSmVAdFJrEhQGtWLhra+jCEA3/dkGSTvuk39XbM6jVpOhz8+Ku8otojl2
         K5SpucVzVF967lWOKD1ta3QxUKGgPezJ3aD4nqExtW8d/GMtCXVheUqwnyuveq2XpPSH
         0kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718998437; x=1719603237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nDGM5BfE4nBzMNctKXy8FB1ab1trnMB0GkxkRe1UUc=;
        b=ueKIpiOqqqpLvcv8Q+O6lvJe6j5t6HGxlR36HkHAq6U+WexKuRaG0toqYyoPSAic8D
         eEJViQKH0QUja0XiLcDUuJ7+gRri+VYRmOTDzDoHwcrdI6vTgnWJjE0WhI6fIUc+P5iM
         5avGhliNJq01HPKYNr1q+0Bvnx/hvFpP7NNV1QcB8O0hTjwtjNHZyXbOMMoNzbBsMVU3
         1AuC/H8p7PUG+dv0ePO996CRnDWB5uSXLwWWU+aUnez3y3D2KxxySQRNgX5ihbyD1jvt
         sxYOX+1BSQisP5DAgR/MBPgXSCl7w4jd5IvgmsKqpzR/LZKSUc0zONxIHPrn+qQ9pwLi
         /CFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkyOUOoK0dR+5tr02AWF+VeH7VbLqCm2RbXoY3xt5tOJVu5EvIPAHOiqelCWFzpX4ykRd3VLGvJWTcBlxDFVA3WgvxBSSp3uMzXXNi
X-Gm-Message-State: AOJu0YyotooKtUwYZjVFm+Iavw21OxiYiXEEHAFOySmifTtoj3sOzd9t
	hAA5jX22DJB8ACzXJWnaw95ZAlf6xHaUBill5mexw1q5GotH/yo32CVeWkLTy4eeSOYkmCR3nMB
	WjlsPh3qXGHUI3X5E/Ovu7mHeactZkH9U23lI
X-Google-Smtp-Source: AGHT+IFKHeWXsrcarZ99HrTif/DeNk5RsxsZB9FIwbEmo1+KbBeOQrbwcbUobI8IcpYZWtf/8bWvMvgMlUUgnZ+ODWo=
X-Received: by 2002:a05:622a:15c6:b0:441:4920:1fc4 with SMTP id
 d75a77b69052e-444ce34a72emr91451cf.28.1718998436717; Fri, 21 Jun 2024
 12:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620080509.18504-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240620080509.18504-4-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240620080509.18504-4-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 21 Jun 2024 12:33:45 -0700
Message-ID: <CAD=FV=UTtE1UjxtMWOxTWNb9S_FSt=oTOhRJpVFAzD=MjB83QA@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] drm/panel: jd9365da: Support for kd101ne3-40ti
 MIPI-DSI panel.
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 20, 2024 at 1:05=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> @@ -31,6 +31,15 @@ struct jadard_panel_desc {
>         enum mipi_dsi_pixel_format format;
>         const struct jadard_init_cmd *init_cmds;
>         u32 num_init_cmds;
> +       bool lp11_before_reset;
> +       bool reset_before_power_off_vcioo;
> +       unsigned int vcioo_to_lp11_delay;
> +       unsigned int lp11_to_reset_delay;
> +       unsigned int exit_sleep_to_display_on_delay;
> +       unsigned int display_on_delay;
> +       unsigned int backlight_off_to_display_off_delay;
> +       unsigned int display_off_to_enter_sleep_delay;
> +       unsigned int enter_sleep_to_reset_down_delay;

If the above delays are in milliseconds please add a "_ms" suffix to
the variables.

It's also surprising to me that you need all these extra delays /
boolean options if this is really the same underlying chipset. Any
idea why they didn't need it?


> @@ -53,6 +62,7 @@ static int jadard_enable(struct drm_panel *panel)
>         struct device *dev =3D panel->dev;
>         struct jadard *jadard =3D panel_to_jadard(panel);
>         struct mipi_dsi_device *dsi =3D jadard->dsi;
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
>         int err;
>
>         msleep(120);
> @@ -61,10 +71,16 @@ static int jadard_enable(struct drm_panel *panel)
>         if (err < 0)
>                 DRM_DEV_ERROR(dev, "failed to exit sleep mode ret =3D %d\=
n", err);
>
> +       if (jadard->desc->exit_sleep_to_display_on_delay)
> +               mipi_dsi_msleep(dsi_ctx, jadard->desc->exit_sleep_to_disp=
lay_on_delay);

mipi_dsi_msleep() is really only useful if you're using it between a
whole bunch of other "_multi" functions. If you just have a simple
"msleep()" then just call "msleep()".

...but really you should be transitioning the function to just use
more "_multi" functions since they exist for the other functions
called here. In other words, this function should look something like:

mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
if (...)
  mipi_dsi_msleep(...)

mipi_dsi_dcs_set_display_on_multi

if (...)
  mipi_dsi_msleep(...)

return dsi_ctx.accum_err;

I would also note that you seem to be missing commit 66055636a146
("drm/mipi-dsi: fix handling of ctx in mipi_dsi_msleep"), which
changes the first argument of mipi_dsi_msleep() to be a pointer.


> @@ -72,16 +88,26 @@ static int jadard_disable(struct drm_panel *panel)
>  {
>         struct device *dev =3D panel->dev;
>         struct jadard *jadard =3D panel_to_jadard(panel);
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
>         int ret;
>
> +       if (jadard->desc->backlight_off_to_display_off_delay)
> +               mipi_dsi_msleep(dsi_ctx, jadard->desc->backlight_off_to_d=
isplay_off_delay);
> +
>         ret =3D mipi_dsi_dcs_set_display_off(jadard->dsi);

Similar comments here to the enable function. Use more _multi which
then makes mipi_dsi_msleep() make sense.


> @@ -100,6 +127,20 @@ static int jadard_prepare(struct drm_panel *panel)
>         if (ret)
>                 return ret;
>
> +       if (jadard->desc->vcioo_to_lp11_delay)
> +               mipi_dsi_msleep(dsi_ctx, jadard->desc->vcioo_to_lp11_dela=
y);
> +
> +       if (jadard->desc->lp11_before_reset) {
> +               ret =3D mipi_dsi_dcs_nop(jadard->dsi);
> +               if (ret)
> +                       return ret;
> +
> +               usleep_range(1000, 2000);

Why do you need this extra sleep. For any panel that needs it can't
the "lp11_to_reset_delay" just be increased by 1ms?


> @@ -582,6 +628,233 @@ static const struct jadard_panel_desc cz101b4001_de=
sc =3D {
>         .num_init_cmds =3D ARRAY_SIZE(cz101b4001_init_cmds),
>  };
>
> +static const struct jadard_init_cmd kingdisplay_kd101ne3_init_cmds[] =3D=
 {
> +       { .data =3D { 0xe0, 0x00 } },
> +       { .data =3D { 0xe1, 0x93 } },
> +       { .data =3D { 0xe2, 0x65 } },
> +       { .data =3D { 0xe3, 0xf8 } },

As mentioned in my reply to patch #1, please don't add new panels that
use the table-based approach. Before adding your new panel to this
driver have a patch that transitions it to a per-panel init() function
that uses mipi_dsi_dcs_write_seq_multi().

