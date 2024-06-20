Return-Path: <linux-kernel+bounces-222868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638609108E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202A7282820
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585DF1AE08E;
	Thu, 20 Jun 2024 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WGPd4LA2"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EB21E497
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894918; cv=none; b=I/LsP1xTJ8FyEdozSzUy2piTcWj1ml2jOdDTZ4/E1vgR27mLlapFHe5Em/gLUugqrU+vRtYG1yjbhNBS9SVoqMP74DrtPnbBh+HwuGtvhpHdIdRdMOV+3Mh6zj0YEV1QFQ6DeQi7fLfi5eymoZTvmPp9+MkkfB4zH0pvxHOCqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894918; c=relaxed/simple;
	bh=/Wm3uCFNxxpaDu9OmErHmGzmSW9I4J4chK2X8weJtHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAyyvIR+LgoFdcFdzEJg73fQ7BZfD+Q+1qET3virv5WEPvCpWSX9T3CeyvXimd5UYL2TMEL/M7pTuLCiKoFFEiRYykN7Ej7n6fpn9c9JFJaSP1RITo3fcV8WEvVJ8VmztZe/VerkKxUD0BiqeJ2/bVsgboMBXXMoVzcDxMzg1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WGPd4LA2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7955ddc6516so62386585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718894914; x=1719499714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udPUwwxJTUp+1+518tML1rd5QFoFHAkCj7rsrE7xC+c=;
        b=WGPd4LA27dLdcc03XP4kDgygnufxfWI6Gn5c4cEjY6ukT0gLWeXaM17XmmvUdENp7e
         gPZpzAqNIcRNwJINBIxMCIqp7egAsdIDtpBptEAC5U7mcnGrSF2xt4iEyw8fJsgWFzQ8
         UC6y0LsHp+ilJjAKaq5jyD7BZvZ+OQ12WEKJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718894914; x=1719499714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udPUwwxJTUp+1+518tML1rd5QFoFHAkCj7rsrE7xC+c=;
        b=LbbIii2jScTN3ltp79Wb2RI79y6BElRo9cUh9bvNl5s2y+BkvkD1yBe7y83wh9i/h+
         RcnD35KfMdI1RckwaoidGgW/JmYnLouk0w3jd2DLzskSs/4BKRbCOMXgRmvmLlkzT460
         Cppjy8KMMhKpZ/ua1fr/TZWlAUftux9B/EmPEHXNsNxn5YQozoqnJtropu+/9puR+s5t
         Jd7rH44n1SRu/SHPglSqQVBfYwzTjFzJTnJ9Syu9kaUKpUDxC/PkFkJoeJLlsQgsxHlx
         ZY2zGfFMW2L3rsGJ18tk2WAi48EoJ+OJbkUYA/ube8JpGDDtdQYFvrS2075DH7w+nTob
         79pw==
X-Forwarded-Encrypted: i=1; AJvYcCXdVKDmQFE7UdSOJzpQvSYkTZ3zWt63C76OZKZOlZIlXn/0hpB6pY+66ED5TPuEHLW0PjikfcnNLPh0RwndSXw6pZ5jiFBGvJRo8EsR
X-Gm-Message-State: AOJu0YzVv2YOTuMU9r0+KmN/gyBCoLjZ9fpWhlN4TSSA4FMhpTJfWmnV
	eVcVuNxRNwjOZ0IkKanLY2W1xSrgaplffq2FDdAMnSwpsVX0HNoUv8SJloslHCIUQh2wRSpS9AM
	=
X-Google-Smtp-Source: AGHT+IF0uJ8sFZO7k8ZQuRJg7Wp8bALcMpZxHUSfbDWCjjlghQzpGoev946G03Iu/21OjdvBYuE+Ng==
X-Received: by 2002:a05:620a:29c8:b0:794:ee2e:c8ff with SMTP id af79cd13be357-79bb3ed27f9mr600106285a.49.1718894914145;
        Thu, 20 Jun 2024 07:48:34 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798b73fb4dcsm695401285a.100.2024.06.20.07.48.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:48:33 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-443586c2091so872861cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:48:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsxMsrxgZ3FA3YoQC7va2btgk1RCKPWqcqG1GFwWPU4ZEFU+xwYYzLdusl2ftLJPruPdu+9oVQT2NwvkzsV+SOklaZd0enapiV5uV2
X-Received: by 2002:a05:622a:4e0e:b0:444:ba78:c32c with SMTP id
 d75a77b69052e-444ba78c41fmr1825571cf.11.1718894912548; Thu, 20 Jun 2024
 07:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619033351.230929-1-tejasvipin76@gmail.com>
In-Reply-To: <20240619033351.230929-1-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 20 Jun 2024 07:48:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WtL-Dq1gfdhmmHVJhWijE8pusKzf-x5TRe9a2KkXCcwg@mail.gmail.com>
Message-ID: <CAD=FV=WtL-Dq1gfdhmmHVJhWijE8pusKzf-x5TRe9a2KkXCcwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 18, 2024 at 8:34=E2=80=AFPM Tejas Vipin <tejasvipin76@gmail.com=
> wrote:
>
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi: Introduce
> mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> raydium rm692e5 panel.

It should be noted in the patch notes that as part of this patch there
is a small functionality change which is arguably a bugfix.
Specifically if some of the initialization commands in
rm692e5_prepare() fail we'll now properly power the panel back off.

IMO it's not a big enough deal to add a "Fixes" line since it's
unlikely anyone is actually hitting this. If you want to add a Fixes
tag (or someone else feels strongly that there should be one), the
right way would probably to make this a 2-patch series and have _just_
the bugfix first and then have the conversion be a no-op.


> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
> Changes in v2:
>     - Change rm692e5_on to return void and take mipi_dsi_multi_context
>       as an argument.
>     - Remove unnecessary warnings.
>     - More efficient error handling in rm692e5_prepare
>
> v1: https://lore.kernel.org/all/20240615093758.65431-1-tejasvipin76@gmail=
.com/
> ---
>  drivers/gpu/drm/panel/panel-raydium-rm692e5.c | 237 ++++++++----------
>  1 file changed, 99 insertions(+), 138 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c b/drivers/gpu/=
drm/panel/panel-raydium-rm692e5.c
> index 21d97f6b8a2f..9936bda61af2 100644
> --- a/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> +++ b/drivers/gpu/drm/panel/panel-raydium-rm692e5.c
> @@ -40,176 +40,137 @@ static void rm692e5_reset(struct rm692e5_panel *ctx=
)
>         usleep_range(10000, 11000);
>  }
>
> -static int rm692e5_on(struct rm692e5_panel *ctx)
> +static void rm692e5_on(struct mipi_dsi_multi_context *dsi_ctx)
>  {
> -       struct mipi_dsi_device *dsi =3D ctx->dsi;
> -       struct device *dev =3D &dsi->dev;
> -       int ret;
> +       dsi_ctx->dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;
> +
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x41);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd6, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x16);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x8a, 0x87);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x71);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x82, 0x01);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc6, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc7, 0x2c);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc8, 0x64);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc9, 0x3c);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xca, 0x80);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xcb, 0x02);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xcc, 0x02);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x38);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x13);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf4);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x00, 0xff);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x01, 0xff);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x02, 0xcf);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x03, 0xbc);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x04, 0xb9);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x05, 0x99);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x06, 0x02);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x07, 0x0a);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x08, 0xe0);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x09, 0x4c);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0a, 0xeb);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0b, 0xe8);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0c, 0x32);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0x07);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf4);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0d, 0xc0);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0e, 0xff);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x0f, 0xff);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x10, 0x33);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x11, 0x6f);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x12, 0x6e);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x13, 0xa6);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x14, 0x80);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x15, 0x02);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x16, 0x38);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x17, 0xd3);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x3a);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x19, 0xba);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1a, 0xcc);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1b, 0x01);
> +
> +       mipi_dsi_dcs_nop_multi(dsi_ctx);
> +
> +       mipi_dsi_msleep(dsi_ctx, 32);
> +
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x38);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x18, 0x13);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xd1);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd3, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd0, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd2, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xd4, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xb4, 0x01);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0xf9);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x00, 0xaf);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x1d, 0x37);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x44, 0x0a, 0x7b);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfe, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xfa, 0x01);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0xc2, 0x08);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x35, 0x00);
> +       mipi_dsi_generic_write_seq_multi(dsi_ctx, 0x51, 0x05, 0x42);
> +
> +       mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
> +       mipi_dsi_msleep(dsi_ctx, 100);
> +       mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
>

nit: Delete the extra blank line above so there's not a blank like
before the closing brace of the function.

Hopefully you can post a v3 with the blank line removed and adjust the
commit message. Then feel free to add:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

