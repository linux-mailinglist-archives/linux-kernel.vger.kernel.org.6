Return-Path: <linux-kernel+bounces-423953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6669DAEAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFA2165584
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0DD202F92;
	Wed, 27 Nov 2024 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T54OfFsu"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128D200B95
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741020; cv=none; b=uRBXMjmIKhh6VUYmhVTrfm0uwOpcKDdsXVEjsrhijgeiRZQa0lghCtHdt/teZfXqiFWgauzIY1ArVTRU0dA3y9s8sRlaDCZNgSiidQq991pRHbBodsqd+OXJwT2qlP3lk9br/rciQJ493eOCOWkt9IGyrrjSNzjH5fdjSYzOzAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741020; c=relaxed/simple;
	bh=r+RoTo5J6nLOhM3VtnIsWJC19xzClak7aHPvKpdFM7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nV9Gy4n+zfAyV58dgf9DBp2mv41RW1JZboQPgu4T861EpMBCB/YWYAzyb+YNPSCUdPBRO4S2hm+/M+/zAIcD2W4S6Zjx/HGom5rcq66Qgnp/XHm5PHp8VFlXSCA8qqz9WuvVyZBsjJ8DR/N8tux8x8Msn5btiD2VjLE7NKILWpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T54OfFsu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a0fd9778so818455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732741016; x=1733345816; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7U9hOswjkTlIu0eHpVW8cvTyEAZU1a4KzVLqKR0PK0E=;
        b=T54OfFsu1CXi4yy2IhuWtAmRamzIfF2whrQlEdnWfWgVg7nAMnaF699kCVz+1AQHif
         N+iWBkn6ISr4KolYyDmOKycMeUu6OFIMLqVaQae6vJJ5BTay1NR+N5wUM+iMB8u6C4jQ
         JmlNoO7q9ZjmBpYECCdOBSjztaCKKZAJnCuWZYvyd9Ia8J0Bkl7HhvL5/7hF/9NlXi+Z
         HUpJhv2fEMRMNgm7zl7ewLwjhe6ybaDGMptjEI8U5x7o2VJO2P5e/++NQbuWS3Db/UFi
         MHRzqTPk47//efTvI0h4MCrhLP+i4HOZirWoebYSvzVc+hNBwHTDcRWLFGJlBP/fD2AD
         jNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732741016; x=1733345816;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7U9hOswjkTlIu0eHpVW8cvTyEAZU1a4KzVLqKR0PK0E=;
        b=gVOnyN/W+eIGClj8aXpFXtn3a3JCddQkiX2Yix0wM8G64bdzmchsiyYhB+yLcblDY4
         +zKmv+JWSaUeu7FS72Ksn3M6EaLeVCCpq7GyHpTFEVAzh/3pbBnN5lU7PViOuttkOi/t
         ppmxOj6NfAk5HOf91m+uY97FY4EVSiTWgW0n9Ednk6OoNHixb++jkJCSSMDd8oNLUqAM
         c3eSkQD7Kr7ZqJkl+eMWIXyhOdpYPeMxVmgE4hE3Ql39AB0VL0UBe+smUp2d7FFvXu5t
         v+WHL6aWP3R5smXylwj/zxWvmzmE6cisBVUu/oP/0Q1wBscbZfF/OQf3TofIMern+v5g
         W+ag==
X-Forwarded-Encrypted: i=1; AJvYcCUP6R8lES5fQk04G8A5iUX5dCtAFhY2AiAqb3By2JmdVbFwRcpqg8PxGGWHToBVahQNLg0j+bKQEzN17Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Xgo/Xd0qXLdzKzL7xbT7h9Dx71Uoo3pM560bK0Ki/DWr/I1o
	vOzseUADaSRJ62du6utMW2H7hZGT2MBpZALFJnUH4dH0KPifORoO6Da6yzVr3e0=
X-Gm-Gg: ASbGncvnn5exN8zkJNJt9N+b2vF6DMpPbXA3qzsdCS/KM1uC5sm69N/103hGNEIXlLp
	Jrbu4n0T6OcOZrHLbv5+CMZlA/qrmN6GqP/hLLvqOMfYZ3/ShIHwJiJM4+IYLbqmWYQej1ouZ1I
	U8TPWaub4mXmcqxYKIBsYUdxTrMmPZTwSywfzxmmswyEl6laZ6LfaoFDbl+MPirEzXiXtDW1yPj
	CXZ1VjRS/lDkWQr30DWzpepPuqea5QZeGKetsRESIMtxiISAw==
X-Google-Smtp-Source: AGHT+IF9mEC2PpHHSEE4f/UbbHmSaSloRZU6SDyajUiQ4Pk9pvlFm1bVlT9XTXNm/2ABjv1LiTOqoQ==
X-Received: by 2002:a05:600c:4e8a:b0:42c:b52b:4335 with SMTP id 5b1f17b1804b1-434a9dc3e80mr49302555e9.10.1732741016193;
        Wed, 27 Nov 2024 12:56:56 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:cc06:8990:4fb8:28e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0d9bc91sm493395e9.9.2024.11.27.12.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:56:54 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Stephen Boyd" <sboyd@kernel.org>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com> (Arnd
	Bergmann's message of "Wed, 27 Nov 2024 20:30:07 +0100")
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
	<12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 27 Nov 2024 21:56:54 +0100
Message-ID: <1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed 27 Nov 2024 at 20:30, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Wed, Nov 27, 2024, at 19:47, Jerome Brunet wrote:
>> Depending on RESET_MESON_AUX result in axg-audio support being turned
>> off by default for the users of arm64 defconfig, which is kind of a
>> regression for them.
>>
>> RESET_MESON_AUX is not in directly the defconfig, so depending on it turn
>> COMMON_CLK_AXG_AUDIO off. The clock provided by this module are
>> necessary for every axg audio devices. Those are now deferring.
>>
>> Select RESET_MESON_AUX rather than just depending on it.
>> With this, the audio subsystem of the affected platform should probe
>> correctly again
>>
>> Cc: Mark Brown <broonie@kernel.org>
>> Fixes: 681ed497d676 ("clk: amlogic: axg-audio: fix Kconfig dependency 
>> on RESET_MESON_AUX")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>
>
> febb5d7348ff07c2da0cb5fd41d2ad2607e5bd5d..ea16bfde0df2d7bfebb041161f6b96bbb35003ed 
>> 100644
>> --- a/drivers/clk/meson/Kconfig
>> +++ b/drivers/clk/meson/Kconfig
>> @@ -106,7 +106,7 @@ config COMMON_CLK_AXG_AUDIO
>>  	select COMMON_CLK_MESON_SCLK_DIV
>>  	select COMMON_CLK_MESON_CLKC_UTILS
>>  	select REGMAP_MMIO
>> -	depends on RESET_MESON_AUX
>> +	select RESET_MESON_AUX
>>  	help
>>  	  Support for the audio clock controller on AmLogic A113D devices,
>>  	  aka axg, Say Y if you want audio subsystem to work.
>
> You should generally not 'select' a symbol from another
> subsystem, as this risks introducing dependency loops,
> and missing dependencies.

I do understand that one needs to be careful with that sort of things
but I don't think this is happening here.

>
> It looks like RESET_MESON_AUX is a user-visible symbol,
> so you can simply ask users to turn it on, and add it to
> the defconfig.

That would work yes but It's really something a user should not be
concerned with. I can follow-up with another change to remove the user
visibilty of RESET_MESON_AUX. It is always going to be something
requested by another driver.

>
> I also see some silliness going on in the
> include/soc/amlogic/reset-meson-aux.h, which has a
> non-working 'static inline' definition of the exported
> function. Before my fix, that would have caused the
> problem auf a non-working audio driver.

If by 'silliness' you mean there is symbol definition for when
RESET_MESON_AUX is disabled, indeed I guess that could go away.

Thanks for pointing it out.

>
>       Arnd

-- 
Jerome

