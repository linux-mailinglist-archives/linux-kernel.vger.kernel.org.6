Return-Path: <linux-kernel+bounces-404416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A189C437F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386832843DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10521A707E;
	Mon, 11 Nov 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G/Zr5TEO"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEDA1A4E77
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345900; cv=none; b=FRNnXU2pZGcGtaQDEaIYCvwhLHFntb2X7ZgKBfmk9buHyRRaextxAUOp8pc7mKaQAe5vM9SksUm6mUDb0bTnzO5vXVnE4U3JgMwizlVZebCw4MVhGNbX9RoXr2YILqZJ9pLttmeRtMRZSKn1NoofDzvSC/vQbf7DbPyPUzIQR30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345900; c=relaxed/simple;
	bh=+bsSX+Ra+NomURtV4l48KCn7neeBpILpjUckN375Gyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gARWvgMpYGQtpPMQeab8cwrvUwVPo81Yekloivsl7fdnlGOrCsHTA3IL+QzPkN/Fv7wivy/Bz+tEGKvVghzOT5ZXzYQlhCqabI5+rvFm6xmH5vpCmJKNEIEjQ3ifRInvRkprOtezaL/ner0VvvgU/zuI73M/QRv6SSiIaCBUXig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G/Zr5TEO; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c913aso8242393e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1731345895; x=1731950695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn3wlhPcjYAmpGIs9KYtyq4CcNrw701MWptcU9EAyJw=;
        b=G/Zr5TEO47ifms4u3ZzpqE7T0BShZjKFQeL3BebLzSn5VSvO0eKczad67up3AU5F6G
         8B/pKxG3mAxX6WakvSCeH4GUsD1T1NoV4dud8Snc6WVUc9sN4GnChvxYHXo1jZ0OT2dC
         XuaWnkKfvmHh/6qXPAE6aOhGk3XNFgbJUGLzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731345895; x=1731950695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn3wlhPcjYAmpGIs9KYtyq4CcNrw701MWptcU9EAyJw=;
        b=ZproQyDmiu3S6qnuKPYs4A1hrxfXRy+ytgSV3NJ/6WFJ5HYU4miy559c3V0nzW8ikU
         NiVc6Rgq3HyajG+/wOdPg9vEvuvr2RrqrN7sBMQdL8vYTMp1LU8bqK4SibgseGGtFjbR
         PShfNAAzMEfWDEiYp/E7h1QnRvtgIUN/zho1WjW77jNuXU5LvzZXaVqNgHg+amF+mYOz
         Mzvq1DI88KHSdrUp9LWX1P90HlMeADLBi8M3s+kOk2Ha0H/60er06rbQYSaJeFNjaf3g
         voMrGOlrz8cro90xLdeKB66nbLz/k8zfJOCwBXEJiNCVK8ggDPyZ0h3UIEwnAzs7bHI9
         3Rdg==
X-Forwarded-Encrypted: i=1; AJvYcCWqD21KvDsZCwYmdS06+b9mjxS83MmQNSnFO8IS3luseGABn8mZja7V9b4E2KvOdthrft/CUvVxVZ6PP8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhozu7nU0YCKCaobLP2tppkJwDHezfTK+1e4zJPTKtDakWiCbR
	uinkCAjyRyP+EFtEcTCdk/ueKx3UR94D62lpXlrL6xMDZ81VnrR0m+oarPRLDNTXzmGnHa/h9tp
	IhA==
X-Google-Smtp-Source: AGHT+IGD5lj8gCAqmSMJEcD5OkGIR6Fg1Rt5RQv9CHfGf/I2/OXkRDrINe1TARrM6e1G0vWVGkHXIA==
X-Received: by 2002:a05:6512:33c6:b0:539:e88f:2398 with SMTP id 2adb3069b0e04-53d862ee21emr5301899e87.39.1731345895450;
        Mon, 11 Nov 2024 09:24:55 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826af015sm1628530e87.259.2024.11.11.09.24.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 09:24:54 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f72c913aso8242320e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 09:24:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOzg/wBVZTBK196NCh7WjqJFfzxfAbPP4VDGKIkrv3hha8fyAB4H8YttzxmKCitvIGgp+AaEfRNo081BQ=@vger.kernel.org
X-Received: by 2002:a05:6512:e88:b0:539:fb49:c47a with SMTP id
 2adb3069b0e04-53d862be63fmr7008281e87.4.1731345893812; Mon, 11 Nov 2024
 09:24:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111075000.111509-1-charles.goodix@gmail.com> <20241111075000.111509-3-charles.goodix@gmail.com>
In-Reply-To: <20241111075000.111509-3-charles.goodix@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Nov 2024 09:24:39 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WKU2Wwfwg1EACYgJtUKJjYH2OOQn6ELXbBK=B-jzbTZQ@mail.gmail.com>
Message-ID: <CAD=FV=WKU2Wwfwg1EACYgJtUKJjYH2OOQn6ELXbBK=B-jzbTZQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] HID: hid-goodix: Add OF supports
To: Charles Wang <charles.goodix@gmail.com>
Cc: robh@kernel.org, krzk@kernel.org, hbarnor@chromium.org, 
	conor.dooley@microchip.com, dmitry.torokhov@gmail.com, jikos@kernel.org, 
	bentiss@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 10, 2024 at 11:50=E2=80=AFPM Charles Wang <charles.goodix@gmail=
.com> wrote:
>
> This patch introduces the following changes:
> - Adds OF match table.
> - Hardcodes hid-report-addr in the driver rather than fetching it
>   from the device property.
>
> Signed-off-by: Charles Wang <charles.goodix@gmail.com>
> ---
>  drivers/hid/hid-goodix-spi.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hid/hid-goodix-spi.c b/drivers/hid/hid-goodix-spi.c
> index 6ae2300a6..80c0288a3 100644
> --- a/drivers/hid/hid-goodix-spi.c
> +++ b/drivers/hid/hid-goodix-spi.c
> @@ -20,6 +20,7 @@
>  #define GOODIX_HID_REPORT_DESC_ADDR    0x105AA
>  #define GOODIX_HID_SIGN_ADDR           0x10D32
>  #define GOODIX_HID_CMD_ADDR            0x10364
> +#define GOODIX_HID_REPORT_ADDR         0x22C8C
>
>  #define GOODIX_HID_GET_REPORT_CMD      0x02
>  #define GOODIX_HID_SET_REPORT_CMD      0x03
> @@ -701,12 +702,7 @@ static int goodix_spi_probe(struct spi_device *spi)
>                 return dev_err_probe(dev, PTR_ERR(ts->reset_gpio),
>                                      "failed to request reset gpio\n");
>
> -       error =3D device_property_read_u32(dev, "goodix,hid-report-addr",
> -                                        &ts->hid_report_addr);
> -       if (error)
> -               return dev_err_probe(dev, error,
> -                                    "failed get hid report addr\n");
> -
> +       ts->hid_report_addr =3D GOODIX_HID_REPORT_ADDR;
>         error =3D goodix_dev_confirm(ts);
>         if (error)
>                 return error;
> @@ -790,6 +786,14 @@ static const struct acpi_device_id goodix_spi_acpi_m=
atch[] =3D {
>  MODULE_DEVICE_TABLE(acpi, goodix_spi_acpi_match);
>  #endif
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id goodix_spi_of_match[] =3D {
> +       { .compatible =3D "goodix,gt7986u-spifw", },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, goodix_spi_of_match);
> +#endif
> +
>  static const struct spi_device_id goodix_spi_ids[] =3D {
>         { "gt7986u" },
>         { },
> @@ -800,6 +804,7 @@ static struct spi_driver goodix_spi_driver =3D {
>         .driver =3D {
>                 .name =3D "goodix-spi-hid",
>                 .acpi_match_table =3D ACPI_PTR(goodix_spi_acpi_match),
> +               .of_match_table =3D of_match_ptr(goodix_spi_of_match),

I can never quite remember what the current preference is in regards
to "OF" tables (whether to use #ifdef like you've done or mark them
`__maybe_unused`), so maybe someone will request you change it. ...but
IMO what you have is fine and looks to be properly guarded with
of_match_ptr(). As far as I'm concerned, this patch looks OK.

Oh, I guess the one "nit" is that I would have put "spi" in the
subject, making it "HID: hid-goodix-spi: Add OF supports". It might be
worth sending a v5 for that (after waiting a day or two) unless a
maintainer tells you not to.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

