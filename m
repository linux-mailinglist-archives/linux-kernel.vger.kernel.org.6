Return-Path: <linux-kernel+bounces-424735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B88C69DB8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27999B20757
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CEA1A9B4A;
	Thu, 28 Nov 2024 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SdW4dOF0"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0D31A29A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800804; cv=none; b=QjkUk9pFZbEGtxDfeUE/cOqclKX7CYtOkD55sMwDJIRg2km8HD0DXJrLMnV4ky6I2wu8NxWuboqLCwEyDo4FSnBp1vQhDiC5ZwxymgFqUca3murVksBFEkMlThQ4V75pCDFM9t3XbMgG5OmT6BfiwQU5u43oiA23NB4X8Wd0qtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800804; c=relaxed/simple;
	bh=PjLyi71hJ+wl65ox0a4Xn1LoN5tr4uIfT5gZ+kJDbBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knOi7l+qSKjqt0jVRn2/10FYOqqBjJmqwSd4+0DDT4mSvREngnQQmoUFpFeiTV+9Nd2g6wGqoSHoFr4nD9t0g2OwT9Rxa3qnb/NWLJkycfBoQ3JLPmB1Xi2XOvj35KgblsCPgeb7+4kKpkpDLRf5mWGGmUX7nwC/Re1/eXtIkj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SdW4dOF0; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434acf1f9abso7434055e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732800800; x=1733405600; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmgFSpEV/joPPiUmtOBENMot4M1WgXF/FvOd2XyYmN4=;
        b=SdW4dOF0KGtcZSilfPOngLu3gu7WMh+deQUQZ6Xo9ezysvjQDtUZ/87cf7Rs84b2lK
         HIVd0P2Zar94M7rdaW38YwQTIYFLBXLZxwgxpGtC5a3tXKZBS+KtDrFmbtqm6nT/l0Mx
         d1JO8xt5Bh+5a1A0dgk8ncnGCBUILydG4mdIL6EHW/z4R67iWZHJtnjsOEpiswI2B/zK
         ++0F7Vd9mrPKQZ58qXEC5DQkS5o1P+23TtxQXTWas0TVC40XKUMKLiiTIAwt881LDw6L
         YuNX6qFdVD8aOxj9jc1Sca76/ofDYjaMmwm2iiw/Anc6LlfJ+4LLK8REoregG6wCLJM7
         cyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732800800; x=1733405600;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmgFSpEV/joPPiUmtOBENMot4M1WgXF/FvOd2XyYmN4=;
        b=bX2ugJW2RUETkQpFfsUFqpGxb/IKg6Eb9ABDbz1xUASXrQDZ8IQjuQazy8oBmWltYm
         qiy6qUz7cdTPWRFGpmGeU3CHnib93297EYB4BRqnzrKKTicSneyU3NcQKalnYeYlFBpN
         2LmDSKGgVz6GxHwbHzaVX4CsBoLX54rRN8lqTuBwdgHDuQvUgJLDZJFyg+BTBeVCfOeD
         I3d6u+qj7Wr2O3Dy1JwBvcx8q3XGNUz9VPgD9/bW+BgZFcB5F/O9FexMoSQIxdgc/S5I
         IszVxHk+9jSFim1Rc4+tMBP5laWVT/xJ0gUTJwIq4U7DRlL16tQUWHqnYOxDc/wn721t
         qIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXA/5g6XM+Y6+bkKNfdVs+fFV3og+xF8efT7OQOWLvp4vshH1jBoU5ot5NbS3njCv8IqRfzIYJfWyCK+EI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD7ohwbUL8aIhwEbhnBVG6DTanHhgvR1AB4nrITjFfIcoTEW6Z
	jSDETlQXymZg8R+MMBvbMsMg5e9KfhDCYUVYZb4vQT9rxukmFok4Ge5cSuFrEcA=
X-Gm-Gg: ASbGnculgz/X+qL0BYRL0FfQ93AoIKM3qyvd0+/BrzoC9nn8bIGgN2eW23e8BmaEN+I
	1p6oWBcuxFWjch/QlN8BK+QMQdS4ITWZYTM8x9CMPtILImjzFtWqMlmqnWoiXdVwoMgnIV0rt9m
	9pL0aw1vMt4nlLvhij/EvNTreSO6cK5xQ+0pa6/Q+iOVjfI2sTEfcUhYmMunqShuCeNRw+vMCSe
	WuVK5h+0vR3mnrss+lajzLkUBVsFjjckiwO9z9t+jWKpVk5Rg==
X-Google-Smtp-Source: AGHT+IGrMdn+38U9uolOFNk+mS2Fm4W0jJARLcSQoHOhr2LuU6616dbNhFwztnrfvkaZnx6NZ9uZrw==
X-Received: by 2002:a05:600c:1d8d:b0:434:a902:4168 with SMTP id 5b1f17b1804b1-434a9dd00d3mr68710925e9.18.1732800799856;
        Thu, 28 Nov 2024 05:33:19 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b89d:29e9:7047:2d6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bee2sm22577455e9.1.2024.11.28.05.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:33:19 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Stephen Boyd" <sboyd@kernel.org>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 27 Nov 2024 22:23:52 +0100")
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
	<12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
	<1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
	<f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 28 Nov 2024 14:33:18 +0100
Message-ID: <1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 27 Nov 2024 at 22:23, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Nov 27, 2024, at 21:56, Jerome Brunet wrote:
>> On Wed 27 Nov 2024 at 20:30, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>>
>>> It looks like RESET_MESON_AUX is a user-visible symbol,
>>> so you can simply ask users to turn it on, and add it to
>>> the defconfig.
>>
>> That would work yes but It's really something a user should not be
>> concerned with. I can follow-up with another change to remove the user
>> visibilty of RESET_MESON_AUX. It is always going to be something
>> requested by another driver.
>
> But that's true for all reset drivers, each one of them is
> only useful because it's going to be used by another driver,
> same for clk, pinctrl, regulator, ...
>

All clk, pinctrl or regulator are used by other driver yes, this one as
well, sure.

What special about this on is that it is an auxiliary bus driver.
It is directly instantiated by another driver. That's where
it differs. The axg-audio clock driver instantiate the auxiliary reset,
it does not use it, which is why it makes sense for it to select the
driver.

I agree that in such case I should not have added prompt for that
symbol. I'd be happy to fix that mistake in the coming cycle.

> All other reset drivers are user-visible, with 'default, so for
> consistency I think it's best to keep it that way, and
> just add a 'default ARCH_MESON' the same way we have for many
> other reset drivers:

Same consistency remark applies to the clock Kconfig patched here, which
select the drivers they directly need and I'd like to keep consistency
here too.

Also 'default ARCH_MESON' does not accurately reflect when the driver is
needed, it will turn on the driver in configuration where it is not
necessarily needed, making it more difficult to trim the configuration
down without intimate knowledge of the problem.

ATM, RESET_MESON_AUX is only needed if COMMON_CLK_AXG_AUDIO is enabled.
Isn't it what select is all about ?

>
> diff --git a/drivers/reset/amlogic/Kconfig b/drivers/reset/amlogic/Kconfig
> index 3bee9fd60269..c02edc1b51aa 100644
> --- a/drivers/reset/amlogic/Kconfig
> +++ b/drivers/reset/amlogic/Kconfig
> @@ -14,6 +14,7 @@ config RESET_MESON
>  config RESET_MESON_AUX
>         tristate "Meson Reset Auxiliary Driver"
>         depends on ARCH_MESON || COMPILE_TEST
> +       default ARCH_MESON
>         select AUXILIARY_BUS
>         select RESET_MESON_COMMON
>         help
>
> The only bit that's special here is the exported symbol,
> but that is handled by the dependency.
>
>>> I also see some silliness going on in the
>>> include/soc/amlogic/reset-meson-aux.h, which has a
>>> non-working 'static inline' definition of the exported
>>> function. Before my fix, that would have caused the
>>> problem auf a non-working audio driver.
>>
>> If by 'silliness' you mean there is symbol definition for when
>> RESET_MESON_AUX is disabled, indeed I guess that could go away.
>
> Yes, that's what I meant.
>
>       Arnd

-- 
Jerome

