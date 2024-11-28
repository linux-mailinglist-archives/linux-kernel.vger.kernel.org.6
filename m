Return-Path: <linux-kernel+bounces-424836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C69DBA09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC7162F73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43E31B654E;
	Thu, 28 Nov 2024 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zqn3Uhkg"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2601B6CFC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 15:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732806370; cv=none; b=PSmpksHKtHFPuNtnynDo/2lpyS5fZZSKHWDk/xGFeUP6eFk79KDtghrhUTPo32mK3xYN4SXt4Xl3mx73kz1K9fQXHYKuUFE6B1TajnlmRfjfGi1Os95p4/HloXwai7UEU251LtOQLXgaf0YPomsub0Odf+GmNUU60Z8OphRLDM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732806370; c=relaxed/simple;
	bh=a6/nS/LAkmkFczhCXDlE23aLgYtYNdlVnoTtS3chYXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksR5cvNlSSleqAXReff1F2Lmy3wDwy3iaNQU5oA7aIID4S2V/0NTQEw7O75z6xd7TZZNeXTVoZ605pNB5rbnIsRkgl2IUtW4bAjyk2KslfKiiTrpDCmrM4TtcI94lrgO4MJIlLEsFBYhNfV/u2kBC2zr7vaaG8pjEQ/3gTGvNPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zqn3Uhkg; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-382378f359dso689958f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 07:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732806366; x=1733411166; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgMI2XaAkzSEk7PCM+/3QfgY6sh/m9iqNd+K6a7QDCs=;
        b=Zqn3UhkgR/hBZLtimVKhnKXJsSiRw53txRqrsKFI0r5u8BdbYeMV6iCnE1d2c5ynX8
         E01Oim7V5nFJWlQ4/zanWPa7KeJNeQGuiqoVTv2JhyyUQCDLzf5y88udwQr04fS1XuS2
         6YKlcMUqHltu61kyMDI8zmv4Qb//uQkKvwb7Y9sgNOlDIZAFBxSeL6B4MQrZUpR6C0KA
         tcc6dzk3yDHX7pndQ/+YNddipjGiiVUepyCOVDMmdtUM8Yir2UzsGQL/Nij3pF5bXSlr
         WvCzicyuC4yhmUEs55B2nDkua2odcBldj2AmGtwMAcbNqSbHh3rHJ+Ze20Kk87a4tjkW
         28gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732806366; x=1733411166;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgMI2XaAkzSEk7PCM+/3QfgY6sh/m9iqNd+K6a7QDCs=;
        b=um3EPZjBmE4/HLN2LKWfHiAwz0kvgUiN+hzwuaFKxvYHdQDENQ3zW0Srs+cjFKaYt1
         4lChk0OvAVTIrDBKRVlKHGukrB3NPM+G0Z/yZUnF5kUQoN6a0jhZ7MDKKPfmYlF9RqO3
         +LlemQYKSNEgBT3SAzXMesqIBdaMT4ee2GJZ4+Ctfrm/ZIMdxoo74nwjnlXQ0iRd62on
         ehGeLNnniVzfT45DPQAMgV106ffrEEnBZqDERUvtCFDJKzb8qvnUoBeZUUB+eYcbGxNI
         3pZwE9BaEHH/ni1hwQ/EBGZthhQ0I2wrWDdC3kR58dEVYATGa/nBHnJ3iMLyWU3iVchF
         gVZg==
X-Forwarded-Encrypted: i=1; AJvYcCXk8c1a4gffntFAK3uTOqdsNZGBbvLk0xnOPiI07zxxZg2qaGGEGNRUSlBnwEn/pk2RJ24KYiKDpo3McM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytCsmJqCWR9CXpsUwZKAtuePoc/gKFcyFnXJJ9GmZFwHyF46U
	giof//vH5qkz8xp753q8497jAgG2q4FyFnjFQAyk7inJNNlSjGo5oa8DJwjjok8=
X-Gm-Gg: ASbGnctjcR7QwMwuTYFIs2kBg0B9bmVAc6PtOVG1ACQ9lClzXMaIlerwBiXfwia9e3g
	KwHCsLK5Kca9dDyBr0+dojOXbXX9O5ptQfHGexT+UiouFecMGjfUdymO+BKzdjPXsVP8IWZ2TOU
	HRQ3Ubzq0Qzns+emNZgqy1KBL1PfScHKdldTkLyUchz4WjZ3tqh7xGzEoFk5jC4b46YVQpK64JZ
	oBAnjvtt39RGYSOReFn7G+zj27EJN5Rs0t4p7zW0adBu0Rfag==
X-Google-Smtp-Source: AGHT+IFCQOlNDI8ArzCZ2jGZrEopkwYDeCZvjEQAGp3/JK0gSJIUVVZoGTxQH/hrEMSp6P2HzE11Pw==
X-Received: by 2002:a5d:64cb:0:b0:382:4978:2aaf with SMTP id ffacd0b85a97d-385c6edc515mr5523043f8f.57.1732806365996;
        Thu, 28 Nov 2024 07:06:05 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b89d:29e9:7047:2d6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd2dba8sm1893959f8f.1.2024.11.28.07.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 07:06:05 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Stephen Boyd" <sboyd@kernel.org>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com> (Arnd
	Bergmann's message of "Thu, 28 Nov 2024 15:51:28 +0100")
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
	<12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
	<1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
	<f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
	<1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
	<306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
	<1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
	<c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 28 Nov 2024 16:06:05 +0100
Message-ID: <1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 28 Nov 2024 at 15:51, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Nov 28, 2024, at 15:39, Jerome Brunet wrote:
>> On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:
>>
>>>> All clk, pinctrl or regulator are used by other driver yes, this one as
>>>> well, sure.
>>>>
>>>> What special about this on is that it is an auxiliary bus driver.
>>>> It is directly instantiated by another driver. That's where
>>>> it differs. The axg-audio clock driver instantiate the auxiliary reset,
>>>> it does not use it, which is why it makes sense for it to select the
>>>> driver.
>>>
>>> Can you explain the logic behind this design? It seems that the
>>> entire problem here is the split into more drivers than it
>>> should be. It's common for clk drivers to also act as a
>>> reset driver, and my impression here is that you were trying
>>> too hard to split out the reset functionality into file
>>> in drivers/reset/ rather than to have it in drivers/clk/.
>>>
>>> Could you perhaps move the contents of
>>> drivers/reset/amlogic/reset-meson-aux.c into
>>> drivers/clk/meson/axg-audio.c, and change the exported
>>> symbol to a static function? This would still require
>>> a dependency on the exported meson_reset_toggle_ops,
>>> but that feels like a more natural interface here,
>>> since it's just a library module.
>>
>> That's what we originally had. Reset implemented in clock.
>> I was specically asked to move the reset part in reset using
>> aux drivers.
>>
>> https://lore.kernel.org/r/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org
>>
>> Eventually that will happen for the rest of the reset implemented
>> under drivers/clk/meson.
>>
>> It allows to make some code common between the platform reset
>> drivers and the aux ones. It also ease maintainance for both
>> Stephen and Philipp.
>
> I don't understand how this helps: the entire point of using
> an auxiliary device is to separate the lifetime rules of
> the different bits, but by doing the creation of the device
> in the same file as the implementation, you are not taking
> advantage of that at all, but instead get the complexity of
> a link-time dependency in addition to a lot of extra code
> for dealing with the additional device.

My initial rework had the creation in clock (note: that is why I
initially used 'imply', and forgot to update when the creation moved to
reset).

I was asked to move the creation in reset:
https://lore.kernel.org/r/217a785212d7c1a5b504c6040b3636e6.sboyd@kernel.org

We are deviating a bit from the initial regression reported by Mark.
Is Ok with you to proceed with that fix and then continue this discussion
?

>
>      Arnd

-- 
Jerome

