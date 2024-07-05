Return-Path: <linux-kernel+bounces-242139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227BA92842D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93DE1B233D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BA145FEA;
	Fri,  5 Jul 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vg7Gnau4"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815DF13C809
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 08:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720169560; cv=none; b=OA0Hyjm1Bs98sRVGMMRcwDaVi0AI4ORp9SMg6AWJIW81Dv4Jc6xo4ZAj/iJM5MgBPsr4jK+7qMJb/dkqpWDXFhTMr3ztcKkn4dFmZ28y3Onj1OvOvNh20x72cSxlsDwnFZxT4i4EufVD6WrxxeS3a2qQBc45/0ZFCN5OF4gVg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720169560; c=relaxed/simple;
	bh=nN7bsChoKD+VcXCEBRcLG7JH8o73GTocHnqeU92nWaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PALhGkMV66i5H1ulyhMeXj4s6mFD6niRU2xqjMO/XovNy0Y4P690WNMetTBMTRFUrThWVvEQlJ91V3p8+cULhac3W+LwuwNIn7boKBR45dVtPXZ0r4YhDDYufI9T6X58qVAOlCrefut3faSGJjFemJHaMNHxF+UTVkWUuIsNSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vg7Gnau4; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ee77db6f97so19448351fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720169557; x=1720774357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tm8BTCx8h7cfKJSdK68vXadL7NHJYI5R7P++Unzvos4=;
        b=vg7Gnau4B7aeRV4B91DU+9LD65EBJ+OgP94cwEFPb8thm0VGtqMEEUi+zSWhI5pS9F
         GGg4GNP1MOJ4DDT1k3eT3nE548SAKWBqXTn7HVP4jIAdG+B9QJj6c4h9qjeI/jw4t3aj
         6gmXdVyB+LTZd7A20tvo3QuHUcWjY935HllqKVgHxdplvugTUwyMMOEvBzMYp69JvdQE
         KTTsUJfmcOoTb3W27gfZsRqc4I4IbyN0EcbTuXzHHxjemk2ZkO2tMQfN7O1RIi4h2qXo
         XDRgvrZDKWgcIudZDGLUraeAB9JcRDD872J2NW8YaVsPpj8bR1cbEk359fmZ3zIdY+L+
         QZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720169557; x=1720774357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tm8BTCx8h7cfKJSdK68vXadL7NHJYI5R7P++Unzvos4=;
        b=MesyQvR/Agvgg7RB1D9WQlZoplsxGe36zI3syg9TxSjlbYssIQaAcA74EvwAU/lROx
         MhbKB+u8KYK999APUEHhZIv7z+KFE40WZ5uG+iLgL9uXEHI0QoOPqgWwS7+o49qVQGG/
         09ZacOGS62CPb8SNdyeKYblS+tVDaKHUeqAuQJ1m8C4UphQdasbdnY8Qlk+7HA3VfkAp
         02Vm8tgFv11YexTLlXmcj/8c67tElJwg5p6V2WxJssOh/MKOZEUyCxjtt0a7KMH9y58n
         qQc15ibqD61MR/oe9TGBPLQbwE9z2g/xoE4YJz77uqEmJIGP0sqCH9sdfeK/jAqfM0sa
         rWOQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2CkV5LFtuOs7mCejmw5Ma2nzgwB9Jf4XUJhStO4rBHYq5Lj/m/KK837+0hhbbgAu1OhL+2871EpI8n1JY/EH2OlR3HNI6KIMLdvXa
X-Gm-Message-State: AOJu0YxcAWwEBbUCgwFyocFuPM0iv9zqQ/nEl/U9QQvM9lP15MwZAa4z
	/qcYInGq1r4UkX/NCd6kcZEKLemnCQ9KPxzuyoQubweRW6d+DH0n216JZOJbrkKdzEbjwArcF0S
	tmSNGRCvM0DB8gxMQ2iF4OgQAwbVqvkisAmnDGQ==
X-Google-Smtp-Source: AGHT+IEyStM8bjx9bavuGPC5GSUaOWfxD2PnzW5v4/QvDQ8yynppqbpSFxWdpusnNU1frPjGzXjLFnAHphiwhd3Laxk=
X-Received: by 2002:a2e:9515:0:b0:2ec:5843:2fb8 with SMTP id
 38308e7fff4ca-2ee8ee0e795mr32501771fa.42.1720169556609; Fri, 05 Jul 2024
 01:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZoWXwYtwgJIxi-hD@google.com>
In-Reply-To: <ZoWXwYtwgJIxi-hD@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 5 Jul 2024 10:52:25 +0200
Message-ID: <CACRpkdY2S+G+u88P3x8emeq3-hEiRP89VbwM2TyRBd956Ro9BQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: add polarity quirk for TSC2005
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:26=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:


> DTS for Nokia N900 incorrectly specifies "active high" polarity for
> the reset line, while the chip documentation actually specifies it as
> "active low".  In the past the driver fudged gpiod API and inverted
> the logic internally, but it was changed in d0d89493bff8.
>
> Fixes: d0d89493bff8 ("Input: tsc2004/5 - switch to using generic device p=
roperties")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> OTOH if this was indeed broken, then it was broken for ~7 years
> (d0d89493bff8 went in 4.11-rc1), so maybe the best way is not to worry
> about compatibility with old DTS, update
> arch/arm/boot/dts/ti/omap/omap3-n900.dts in the tree and call it a day.

I think anybody using the n900 wll be updating DTS and kernel in tandem
so yeah. But I think it's nice that we do both since you anyway made
the patch, it doesn't hurt.

Yours,
Linus Walleij

