Return-Path: <linux-kernel+bounces-176301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1258C2DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 01:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA37B236B1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 23:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF96172BDA;
	Fri, 10 May 2024 23:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lWfYjjT/"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B22D28F3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 23:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715384503; cv=none; b=grI8FCSfGZEX5VX1fsL9a2rHeYM63CJFBityBOuTiiIJfdnpTgU/ete56WKuA1PiPyJLRn/KiaQd3IbtXIC8EWRmciimgOYUoNhAFIgs0Og1EVpQnTt65bQ3MshkAw11A/KfN+5ipnnPBUIPZiyOviWIm3XCfrCmivN/ujDRAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715384503; c=relaxed/simple;
	bh=tdd3mEPr8R8mB7AxgVNrZK4bwy+sTsONs5ChPMw/qCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJ8pqJ/Gl6KH/LJLqWgqAeFFDrBCEFKcOJflRal3QwyLGBjuVamXhWMMLh5p15l3MglkhJGdkrlBHP6RZHnUlw67tOwUGqEDISUA5lzqzKK7IZnnJP86PCOcCjXMjGzwkHeZ3S1I43bGTJVTCIUKq8+O/tgWf92GuM4paA//2f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lWfYjjT/; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f0ecec6411so641694a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715384500; x=1715989300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUDP9S9qW3rGQGeBPladTmxRNiWuw5gzHHPdJQsB0VM=;
        b=lWfYjjT/BE73CGro5YAr4xPnpx+M42ETkBGnrNJDgdBQ+rkJDfeqrRSkLuitu9GRQK
         lxboBnz3c4Fhk9wU5evN8BmrEd0sqiPNS0abCVttEbSkUbgie91a3yk5cBD+2nPFRQ4e
         KUb0FjnFESdU+840DpLpTPMPjSZturBvEC5yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715384500; x=1715989300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUDP9S9qW3rGQGeBPladTmxRNiWuw5gzHHPdJQsB0VM=;
        b=ruIYldwxwdxX4YijszH5QjEAvGf5fyOBQZ+Hwt+eRrSbztzVMk6UOhZQBORkM7tst5
         hmwYooaMvxmvhIBAdKY03BkxkxJbOTxSHsXXRxVFDxr3sdIGgIsRuNhfRkxpPCnfFb0I
         aDrN+3Hb5YzKcv7jrTJ9oIkPMn5Yu7bAU8b+wRDyPlVItKvP9wx92x8DlTbIywDGB3t+
         jTSl8NIF5O5gQCKhYd8KatJhT1+CE1+DZ1nMhDTryQ1VA/bH8MjvxPuYd2y8ar6hzNIK
         Rt1hiEdBP3i6g5tuj0juLO1gUrhp9XKmUSL9oQf5WrCQlrDhTFRH4MxbWVFISztZN/ye
         V7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXYWCRqKQy3dSH0NOBeYheUnhPwx4xnplSqQsaZzguBRaW2MBetgMdOs7tGtvvTsvhtpkKiWPmK3IFrjMQR0yRpI3En9xszkH6TogfI
X-Gm-Message-State: AOJu0YyDi58ku1chMzQmyahcpacFe5vzoCCDyisagvvRXLChKhFGdWWi
	nHz6ykL0ugpcusyW76ODc8e0CYkM/XdkuWwwTrxGzjIMGWtKZpHrVofQr/c7fkNtMc24W1qCLFs
	=
X-Google-Smtp-Source: AGHT+IFCt4R0dIec+QMvwty/khY4Z5DWYFxoMBLL8JgwW0oAI/0QVgwIYbx0Cp+vyAlFo+QsDDdUcQ==
X-Received: by 2002:a05:6358:9046:b0:186:1abe:611e with SMTP id e5c5f4694b2df-193bd2f82e8mr436857955d.30.1715384499869;
        Fri, 10 May 2024 16:41:39 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63411346dc1sm3144410a12.83.2024.05.10.16.41.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 16:41:39 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1ec76185c0fso31025ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 16:41:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXSz0f+xPyz65wWQSQ0McWUKKGyFVsqlMTq4lk4CcLW9f8AyT12UY89iKDRnSy2bj7/99sbUjRmcO7bSq1Q0ljvtjK7/6GN8cUdXC8f
X-Received: by 2002:a05:622a:1f13:b0:43d:fce9:684f with SMTP id
 d75a77b69052e-43e094d0423mr1201921cf.10.1715384182762; Fri, 10 May 2024
 16:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507144821.12275-1-johan+linaro@kernel.org> <20240507144821.12275-5-johan+linaro@kernel.org>
In-Reply-To: <20240507144821.12275-5-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 10 May 2024 16:36:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V59t_tZ9Xk=uhbgOdTRYLKu+kZt8cpaksTkJo+D4yt8Q@mail.gmail.com>
Message-ID: <CAD=FV=V59t_tZ9Xk=uhbgOdTRYLKu+kZt8cpaksTkJo+D4yt8Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] HID: i2c-hid: elan: fix reset suspend current leakage
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 7:48=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> @@ -40,17 +41,17 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *o=
ps)
>                 container_of(ops, struct i2c_hid_of_elan, ops);
>         int ret;
>
> +       gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);

Could probably use a comment above it saying that this is important
when we have "no_reset_on_power_off" and doesn't do anything bad when
we don't so we can just do it unconditionally.


> +
>         if (ihid_elan->vcc33) {
>                 ret =3D regulator_enable(ihid_elan->vcc33);
>                 if (ret)
> -                       return ret;
> +                       goto err_deassert_reset;
>         }
>
>         ret =3D regulator_enable(ihid_elan->vccio);
> -       if (ret) {
> -               regulator_disable(ihid_elan->vcc33);
> -               return ret;
> -       }
> +       if (ret)
> +               goto err_disable_vcc33;
>
>         if (ihid_elan->chip_data->post_power_delay_ms)
>                 msleep(ihid_elan->chip_data->post_power_delay_ms);
> @@ -60,6 +61,15 @@ static int elan_i2c_hid_power_up(struct i2chid_ops *op=
s)
>                 msleep(ihid_elan->chip_data->post_gpio_reset_on_delay_ms)=
;
>
>         return 0;
> +
> +err_disable_vcc33:
> +       if (ihid_elan->vcc33)
> +               regulator_disable(ihid_elan->vcc33);
> +err_deassert_reset:
> +       if (ihid_elan->no_reset_on_power_off)
> +               gpiod_set_value_cansleep(ihid_elan->reset_gpio, 0);

Small nit about the error label: it sounds as if when you go here you
_will_ deassert reset when in actuality you might or might not
(depending on no_reset_on_power_off). Personally I prefer to label
error jumps based on things I've done instead of things that the error
jump needs to do, so you could call them "err_enabled_vcc33" and
"err_asserted_reset"...

I don't feel that strongly about it, though, so if you love the label
you have then no need to change it.


> @@ -67,7 +77,14 @@ static void elan_i2c_hid_power_down(struct i2chid_ops =
*ops)
>         struct i2c_hid_of_elan *ihid_elan =3D
>                 container_of(ops, struct i2c_hid_of_elan, ops);
>
> -       gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> +       /*
> +        * Do not assert reset when the hardware allows for it to remain
> +        * deasserted regardless of the state of the (shared) power suppl=
y to
> +        * avoid wasting power when the supply is left on.
> +        */
> +       if (!ihid_elan->no_reset_on_power_off)
> +               gpiod_set_value_cansleep(ihid_elan->reset_gpio, 1);
> +
>         if (ihid_elan->chip_data->post_gpio_reset_off_delay_ms)
>                 msleep(ihid_elan->chip_data->post_gpio_reset_off_delay_ms=
);

Shouldn't  the above two lines be inside the "if
(!ihid_elan->no_reset_on_power_off)" test? If you're not setting the
reset GPIO then you don't need to do the delay, right?


> @@ -79,6 +96,7 @@ static void elan_i2c_hid_power_down(struct i2chid_ops *=
ops)
>  static int i2c_hid_of_elan_probe(struct i2c_client *client)
>  {
>         struct i2c_hid_of_elan *ihid_elan;
> +       int ret;
>
>         ihid_elan =3D devm_kzalloc(&client->dev, sizeof(*ihid_elan), GFP_=
KERNEL);
>         if (!ihid_elan)
> @@ -93,21 +111,38 @@ static int i2c_hid_of_elan_probe(struct i2c_client *=
client)
>         if (IS_ERR(ihid_elan->reset_gpio))
>                 return PTR_ERR(ihid_elan->reset_gpio);
>
> +       ihid_elan->no_reset_on_power_off =3D of_property_read_bool(client=
->dev.of_node,
> +                                               "no-reset-on-power-off");

Personally, I'd rather you query for the property before you request
the GPIO and then request the GPIO in the "powered off" state just to
keep everything in the most consistent state possible.


-Doug

