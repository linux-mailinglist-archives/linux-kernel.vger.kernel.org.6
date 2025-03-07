Return-Path: <linux-kernel+bounces-550576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF7A56169
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F071894803
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F5B1A239A;
	Fri,  7 Mar 2025 07:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NBpNOax/"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871D19CC0E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331040; cv=none; b=UDS8OSZ9cGMSBsW9E29qMNoPPB53Pn3baXHWsXMq8iUP8R3fU5j8pww1HmDfB6btXaRrtx+q5vV62QbgoX02uDAX8kY5ai8kHQ8HT3T+5y/8AwbBFdigSbZpr0wNQMtjTGAb106VIDe941x9FJq759SnfqbG2qowlOUljFLh1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331040; c=relaxed/simple;
	bh=8nAP95098N8VvC8hTlm0/7kaa5VzZNLWpFxVGQC8zIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OdnbvJCdZc7f38WWl/QW41mRjKtEzPqq7M2ruV3uultfj2hZ1IR5EL9us7fD3keSqx6WwujGpmwS6HerRwuQ62WEYmbfDBl1t4/GSBBEPvh5kB0U2s1ExMFUCPNVf3I6kINY31AjH8pUpsGEHqsUwdXECuJdmOczpCsDpX3E/EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NBpNOax/; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-549662705ffso1670010e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741331037; x=1741935837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8LoLRLGkxYV0alNGYR4F1xsTkZ1FzcA8kkUjGyENl4=;
        b=NBpNOax/CZHtsObwQ+j9vkhKb73k8QXBUXREtiC78ss0qZSbHFhODQIDFK8TpN4Gb7
         SDzBNR9toP7ylsS5y1BJBldZcrbQu84d7HK8HoMUOJsT9j8yBZOaiNEoXRruv4cxAkOb
         Jni4ggK+sBXSovS2MnKggxUT0w79wHRVl77bewo8rL9BDP0sWFphrRxVEdrHHkeic+ml
         tAWYAS9JZPfe9g0ta1Ta0kwdfxZcnrHCu5scbsc8E6YPfR8iZ9920SgU34vS/ywgYPjW
         bubUv7rD3HcK6UbBDyaU1RJJ4svI3zPMFfra3cy6x1jAD3g9ty8nyLrdyiDdzqgxx1A4
         dg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741331037; x=1741935837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d8LoLRLGkxYV0alNGYR4F1xsTkZ1FzcA8kkUjGyENl4=;
        b=uqy7brcYy0u42jHZboaAj1HIm6NRXKnIm5vy3CUjZ2W7nJpwG4JGJRK44OEb6JNIvJ
         YLonOg+Nr+CI+NMEEQX2YPDaO+XwWKE+ss+cuTTNs45eLP1M7FAHgbCdUYE54tTlyDwl
         mnDDwXEKZ1oDFLv4mHU6wb6cEtXnWAHdfRtazmRdnmPMg4Aow0mWawm7uUAzoJlx4dVC
         Bs3G9cBrwLPByN1rVll3hur1bAHzGg8Ten3sxJQFG48ry0xdbomtT/nJD7o7pK0IxBnh
         peeogcMip5ZvEERSZ2GKUbTtjNR4qNdC/ZvDVpSTvFPaYBZmyIWyW8R96zWXxJR9vwrl
         FKfg==
X-Forwarded-Encrypted: i=1; AJvYcCU8ekegHhun97ATTMHpXOPpHOzFleGHZSdEZffzkHeDIOIXrVMrZTWQIO31TMiAIoHpVe6Uv8lRh4cNUrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFNpvUKes8SJe9eM0SMKYXwhLxvkOgHaUnuNFGCTFXm74rGkn
	v2qwkfpFcr2GNkeDQAnaN7ONrIYPKGZY+tbEY69+liuPaaoVyx7Fx0MQdz2BknZTqfuIk5+4lEs
	cjFViebo9QDm3YCG6NV5w+pRqSOp8NDWzPlXKrw==
X-Gm-Gg: ASbGncvV2FQ8bDEh/VejcCFpEIW6t4p63QRxCisaj2vacWMMXC/snpcw9cqrINzL4AN
	70qs9TLQA+x/dgBVGo1k6eZVKgI3UFKeQ/Tu8Q83iY9oCqFsSf5ZtDM8ZswY1ElaDJYM3PAOSlQ
	taQERHQ9qDKbLEnmL7HOfrxdY0p8uZaAnd7l4H2G5TWAGFWh1+USf7NGz1
X-Google-Smtp-Source: AGHT+IGLPbU3KJLosa62LrFtSyjSM1FYRo5hnluiTpHzUxw8rr6zT37TRHuDWK6vB1cV68vxHCUY1m2s2IV4pZHIHLY=
X-Received: by 2002:a05:6512:281b:b0:545:2f0d:8836 with SMTP id
 2adb3069b0e04-54990eaae1amr630800e87.40.1741331036524; Thu, 06 Mar 2025
 23:03:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220-gpio-set-retval-v2-0-bc4cfd38dae3@linaro.org>
 <20250220-gpio-set-retval-v2-1-bc4cfd38dae3@linaro.org> <174130146134.987559.8662566490718210141.b4-ty@kernel.org>
In-Reply-To: <174130146134.987559.8662566490718210141.b4-ty@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 7 Mar 2025 08:03:45 +0100
X-Gm-Features: AQ5f1JrsRCTzGeQkxb8NcRBJre4S54OYANop1Qs9itP8zmv8yOQ5lBl5rfQBlgo
Message-ID: <CAMRc=MdQcxtXMUCt00=JbGY47cMMWcW8=r3-ZrMKjQkViqnxvA@mail.gmail.com>
Subject: Re: (subset) [PATCH v2 01/15] leds: aw200xx: don't use return with
 gpiod_set_value() variants
To: Lee Jones <lee@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Keerthy <j-keerthy@ti.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pwm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Pavel Machek <pavel@kernel.org>, 
	linux-leds@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 11:51=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Thu, 20 Feb 2025 10:56:58 +0100, Bartosz Golaszewski wrote:
> > While gpiod_set_value() currently returns void, it will soon be convert=
ed
> > to return an integer instead. Don't do `return gpiod_set...`.
> >
> >
>
> Applied, thanks!
>
> [01/15] leds: aw200xx: don't use return with gpiod_set_value() variants
>         commit: 5d5e2a6f15a6c5e0c431c1388fd90e14b448da1e
>

Hi Lee!

Can you please drop it from your tree? You acked v1 of this patch
after I had already sent v2 (this patch remained unchanged) folded
into a respin of the bigger GPIO series that had triggered build bots
to point this issue out in the first place. I picked the entire series
up and this commit is already in next as
129fdfe25ac513018d5fe85b0c493025193ef19f.

Thanks,
Bartosz

