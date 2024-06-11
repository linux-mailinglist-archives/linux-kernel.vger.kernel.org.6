Return-Path: <linux-kernel+bounces-210553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186AD90457B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6972828BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743B143746;
	Tue, 11 Jun 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OhCWsTCx"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B92628D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136245; cv=none; b=aTEAo/F4fXuqLpscrQnBnDGUR6jqIQbQi+Gc6uD8sKU92tNxEKrHxEWPFfyQI1CohQX/sHkCwYXSLM12NH9QdYyuKuDbvYMIE4uQk9VnL0M29jkoydI/w3a922XvMf9Lguiack56e0ZMLLoV5tzcP4Uw51+PkUmMfbbfCba8koQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136245; c=relaxed/simple;
	bh=qRN2EUOQ2JcU8HCwMJeszwscoPyFg4yGd3WyI3IuH9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXCFFFXr7u0ny+j68gFmo0SfHj8jon4yWXkZ0wSa4SyqgGkOAVPr9KuA0jb3pdyiMb5Fd0Bmi4yQTimJc0OKAp0J1jA6cZWYTSlWP34GbT5jKxQue8CZbAMzJDyvC5/uUuJfO10t0emuQlApuHrdUiCAPBxXxogstKLLBpnScQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OhCWsTCx; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc1261f45so4673776e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718136240; x=1718741040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n98poQy5aGF7ac0QxK3qC5mrpVCVT/V+RCk+zSOR6o=;
        b=OhCWsTCxWTItqda0wsiH/epnV/xNs5zexgivvDBv9Qs/WidM0zcgFojvNru0T0DHvz
         qumuvPpnStLBAnhpM6ANVNTj9Jvzxpa/axpj8RLnwF+Te5mC8/u6V29RyeYBWyKCShKN
         2HkOaF6uG9/0MKuhN4cYSdvOI/UL4rBoZgSQ0ahS2FCc7zhM/I5T4mHDryOIr8f9PM8K
         Bg/ILyGfUYyE+B6N1ju135d1zTFC6X569XfF2CqHWD1WDY7DC8erviRxQIJW5XCeZg9S
         mRlCOv3UYGocT2FrCUHELBOV4h5ejacwrow8rilo4Kne/qjsdZ0vwCrTuP+2Gc3ufcsG
         ylPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718136240; x=1718741040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n98poQy5aGF7ac0QxK3qC5mrpVCVT/V+RCk+zSOR6o=;
        b=Kw/NOPewK0pRn1QwZGlzKEI06HLQOhr2ipK3vGOyJXhcqMhvWqOeDumqgJQ53n9nYS
         Zl2EUaySS3YBTlTxyT6DH5iqXbj1sn3Et/E+IOdl06f35F+TRyj+g6nMoHUOOTXv+ZAC
         tR8CliLhvbckVfVznRGQn3xzYrRKgs3egaSoktIVXqjV5vSJtDv9YvTfjHx89eTUawm8
         fAherncVdy7eVvdO1b6v+xfX7bdZmBoG9lu99HfnYIRfHTM9Y7JagWZ32wsTM5RQvlMw
         qM/RC8cN4jvxGXRZ2MSXuOx/vLcx6WGoF4EQz2zfEGUT6uoOc3G1xpssGD05Z/aOM6ie
         scWw==
X-Forwarded-Encrypted: i=1; AJvYcCWZicgcXqCvtIlhW1C2XmZDEcD9jt1wEruV2phaWFRu0rHqmE7tZcnddoZwWoq/+LU/rIkn70HcTE1oBzh/nY+MFYzSmWBvXk7rDmlA
X-Gm-Message-State: AOJu0YyJRnZIOs1WUrTMpA1rIEKx9xT2qR4VQOmrQTd/3FYNK+19zuMl
	9CbahXHb3A4feECB7/+WKZovEnH8WPboiTTFhQ4HKUJWKupINa2nbobW4SnXzYvcsN2A+BqgH6/
	WOcwlGjIw5ex7lYawYnVtQnxvZaSYXEsOh7ynSw==
X-Google-Smtp-Source: AGHT+IH/676DYtzrAxdlEhyttoUICnDM9pTxaR4uZAEP9AfETJc0j6gT8wiY7wLbTSTMXHgLlsaivegqk9f0xTZQfTY=
X-Received: by 2002:ac2:5b50:0:b0:52b:c29e:4c50 with SMTP id
 2adb3069b0e04-52bc29e4cadmr6508395e87.43.1718136240422; Tue, 11 Jun 2024
 13:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610112700.80819-1-wsa+renesas@sang-engineering.com> <20240610112700.80819-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240610112700.80819-2-wsa+renesas@sang-engineering.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Jun 2024 22:03:49 +0200
Message-ID: <CAMRc=MfZ11U+kAh1+K=DxtJ=QL+cY7Q_sBN4sQDF-RNgjpV0QA@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] gpio: add sloppy logic analyzer using polling
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Linus Walleij <linus.walleij@linaro.org>, Kent Gibson <warthog618@gmail.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 1:27=E2=80=AFPM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This is a sloppy logic analyzer using GPIOs. It comes with a script to
> isolate a CPU for polling. While this is definitely not a production
> level analyzer, it can be a helpful first view when remote debugging.
> Read the documentation for details.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---

I really dislike drivers being called in an ambiguous way like
"simple" or - in this case "sloppy". I understand why it is - in fact
- sloppy but can we call it anything else? Like
"gpio-logic-analyzer.c"?

> +Setup
> +=3D=3D=3D=3D=3D
> +
> +Your kernel must have CONFIG_DEBUG_FS and CONFIG_CPUSETS enabled. Ideall=
y, your
> +runtime environment does not utilize cpusets otherwise, then isolation o=
f a CPU
> +core is easiest. If you do need cpusets, check that helper script for th=
e
> +sloppy logic analyzer does not interfere with your other settings.
> +
> +Tell the kernel which GPIOs are used as probes. For a Device Tree based =
system,
> +you need to use the following bindings. Because these bindings are only =
for
> +debugging, there is no official schema::
> +
> +    i2c-analyzer {
> +            compatible =3D "gpio-sloppy-logic-analyzer";
> +            probe-gpios =3D <&gpio6 21 GPIO_OPEN_DRAIN>, <&gpio6 4 GPIO_=
OPEN_DRAIN>;
> +            probe-names =3D "SCL", "SDA";
> +    };
> +
> +Note that you must provide a name for every GPIO specified. Currently a
> +maximum of 8 probes are supported. 32 are likely possible but are not
> +implemented yet.
> +

What happens on non-DT systems? Can you still create an analyzer in a
different way? Can I maybe interest you in configfs for the purpose of
device configuration like what gpio-sim and the upcoming gpio-virtuser
does?

Bart

