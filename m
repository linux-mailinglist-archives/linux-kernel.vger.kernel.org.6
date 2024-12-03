Return-Path: <linux-kernel+bounces-429336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396F9E1AB2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F111604DD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCAD1DE8AA;
	Tue,  3 Dec 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xlPDDe/G"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E281E3DCA
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224546; cv=none; b=pgEzG5s5TK3qNTAx3+vF8c/YEK/ZpnsSL17UXIUhWsv0oI66ym7az+7G5Vy7/AfH2/WA1+J4rthZ0uO95X3Xpnz4v/KGIkRF8oXWG7dNZd+aNjJejUhG4tHJZnoa0p0P6Uf71CveQuO7FZlDvw+QCtpGiEKoprCrWiKx4LYjTfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224546; c=relaxed/simple;
	bh=R3ynFlOFilzuAWCe4vj8v7PjXKKFesSQ307O+xSJrjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o5bgqit+Lq2wLYWW0QxbZ70tibqT6usHguNA86y3qO9CW2ixEjrOgdOAKoCENH0eekVLpExOQzPX9rqTCquKXMfrCR1o9NUzxr4WyULJhffy0AtXdvm2bKEDlG8QwssqEo+BsJq77ZlbchYlPMgFX2zTmVcIyoVRh/lPs1T0fA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xlPDDe/G; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a9f2da82so46995305e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 03:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733224542; x=1733829342; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pnArlX2bydGAe9JBj0W2EkNJm96HMGuKHkhrpz/xxnU=;
        b=xlPDDe/GFzqKnGNzc4LmWR/7rSFn7xUYhOrmwjoHzJ3uS2c6RnMKZNIFuKA+nE1S4a
         vG7EyKwidaVls1zIh3iKvSNfZPUXfu44pg/O9qC69BFMiX9Kg0XQ09Qchjr2AORSUXzB
         7eSXeWFugMtL1AIbr2MFnk9RylBHMKdQincrbUfBAlr0gK0P5qebc2uRpYq8AeloC0wG
         xQDZQJC3ICzla1YHMkrKWXiYQ1cT3uAiyPbcYYsjK6k2aILxvFA1vM2lPvXdIvHVCIWI
         G8Y4VA5cYG3q2II+zhFrwaZVQYbkbQRCZRvITwu02LSSSNmMp2Y5/mfUud+Y4B2LcNSa
         Z68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733224542; x=1733829342;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnArlX2bydGAe9JBj0W2EkNJm96HMGuKHkhrpz/xxnU=;
        b=WnLoNK+gt4a0VyDh/kFsWx1L4PohE/w8wthbAf0+zwFlSBaNRg6KdIO3vX7+3cciCA
         AtSy7XUXD11jwUwktUmvcGvDVYs9cUUeX1UWOjToWuWhl5fjAr7QVUh9sB0kT2r2HEdx
         Hl+cMTWa4XlPTLfd3DHbo/ss+i12VmYaBK68WGu3CP+QAyG4PIvYTRoOHCaT8Tt/Gx6m
         UNfnInjapR1AidmRk/8CZ0MhdTHGHIpn//dLU+NdusjH1uMJ1g7p6G/nEV4eNT9RASXS
         LIVFtCAspmDsKT5F0ZH9/BDsuBi1DMyI/UkSpZ0Z0GQdVXvnlX9nhQtUoHKHzOS7A78K
         q1AA==
X-Forwarded-Encrypted: i=1; AJvYcCXBkMzXuxFhoLB8HaIwYMyT7aaYonacmaf6nDjIZ9cbzfRSdfY9Y41XSdC3nRtqBUUC1roz+6Xx9vW90Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztKZariGktAQXkqJLwawNUU/nGS+dT+xHnLmJ3GL8jXeWgxFRH
	ysaCKZIZz9DW838LAcsEt5hrs0S/9/Rdi43bks+LBeyDvCBMNY/DZG6VQC6XH4nzArzwiXBT4cw
	qtk4=
X-Gm-Gg: ASbGnctkdQJgSdZBKtn2ilpynAwiCi6V5NS916gyFlMBq/IbgNDZFuaZt161cz7wm+9
	qFgON1NwgceM5AnZSKuatV4JI5Bc3eZAYWwaYsZ+gMrVEatuaj8C6HypcOh4GQp1PyFQzeWxDBo
	FiECuB9dtYJqw3yErjIsBmahyNt4vzuYQkaSCpUY9FNcS6f/F32N5uxHc+lrnfAxA2lpOz4M7XA
	KV440sAk13UFR1lrNg15VqHoujpr2XtqcIpyufr/LVRyM/rzg==
X-Google-Smtp-Source: AGHT+IGLi/Q8mLP5TxaLwquvOT8BJfU6gorpDiNg0XMpRNl3txBjcplK3PZhkhWKuplXxiUTh5hsVw==
X-Received: by 2002:a05:600c:4fc3:b0:434:a805:1939 with SMTP id 5b1f17b1804b1-434d0a1f0d9mr15164335e9.33.1733224542524;
        Tue, 03 Dec 2024 03:15:42 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:7f8d:3a10:1eea:52e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e86f5dd2sm9131526f8f.18.2024.12.03.03.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 03:15:41 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,  Neil Armstrong
 <neil.armstrong@linaro.org>,  Michael Turquette <mturquette@baylibre.com>,
  Kevin Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org> (Stephen
	Boyd's message of "Mon, 02 Dec 2024 18:53:30 -0800")
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
	<12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
	<1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
	<f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
	<1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
	<306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
	<1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
	<c06317c6-b2b2-4b6d-96e4-0c2cfc6846de@app.fastmail.com>
	<1jplmf1jqa.fsf@starbuckisacylon.baylibre.com>
	<ce67e512-a15b-4482-8194-b917096f4eeb@app.fastmail.com>
	<df0a53ee859e450d84e81547099f5f36.sboyd@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 03 Dec 2024 12:15:41 +0100
Message-ID: <1jr06pkof6.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 02 Dec 2024 at 18:53, Stephen Boyd <sboyd@kernel.org> wrote:

> Happy Thanksgiving!
>
> Quoting Arnd Bergmann (2024-11-28 07:34:46)
>> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
>> > On Thu 28 Nov 2024 at 15:51, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> >> On Thu, Nov 28, 2024, at 15:39, Jerome Brunet wrote:
>> >>> On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> >>> Eventually that will happen for the rest of the reset implemented
>> >>> under drivers/clk/meson.
>> >>>
>> >>> It allows to make some code common between the platform reset
>> >>> drivers and the aux ones. It also ease maintainance for both
>> >>> Stephen and Philipp.
>> >>
>> >> I don't understand how this helps: the entire point of using
>> >> an auxiliary device is to separate the lifetime rules of
>> >> the different bits, but by doing the creation of the device
>> >> in the same file as the implementation, you are not taking
>> >> advantage of that at all, but instead get the complexity of
>> >> a link-time dependency in addition to a lot of extra code
>> >> for dealing with the additional device.
>> >
>> > My initial rework had the creation in clock (note: that is why I
>> > initially used 'imply', and forgot to update when the creation moved to
>> > reset).
>> >
>> > I was asked to move the creation in reset:
>> > https://lore.kernel.org/r/217a785212d7c1a5b504c6040b3636e6.sboyd@kernel.org
>> >
>> > We are deviating a bit from the initial regression reported by Mark.
>> > Is Ok with you to proceed with that fix and then continue this discussion
>> > ?
>> 
>> I really don't want to see those stray 'select' statements
>> in there, as that leave very little incentive for anyone to
>> fix it properly.
>> 
>> It sounds like Stephen gave you bad advice for how it should
>> be structured, so my best suggestion would be to move the
>> the problem (and the reset driver) back into his subsystem
>> and leave only a simple 'select RESET_CONTROLLER'.
>> 
>> From the message you cited, I think Stephen had the right
>> intentions ("so that the clk and reset drivers are decoupled"),
>> but the end result did not actually do what he intended
>> even if you did what he asked for.
>> 
>> Stephen, can you please take a look here and see if you
>> have a better idea for either decoupling the two drivers
>> enough to avoid the link time dependency, or to reintegrate
>> the reset controller code into the clk driver and avoid
>> the complexity?
>
> I think the best approach is to add the reset auxilary device with a
> function that creates the auxiliary device directly by string name and
> does nothing else. Maybe we can have some helper in the auxiliary
> layer that does that all for us, because it's quite a bit of boiler
> plate that we need to write over and over again. Something like:
>
>   int devm_auxiliary_device_create(struct device *parent, const char *name)
>
> that does the whole kzalloc() + ida dance that
> devm_meson_rst_aux_register() is doing today and wraps it all up so that
> the device is removed when the parent driver unbinds. Then this clk
> driver can register the reset device with a single call and not need to
> do anything besides select AUXILIARY_BUS.

I think this is fairly close to what I proposed in the inital RFC, but
generic instead of specific.

I suspect the the generic path is likely to trigger more discussion.
I'd like to be able to finish this migration, instead of leaving half
finished like it is now.

May I add back the boiler plate code in drivers/clk/meson, similar to
what was proposed in the RFC [1] and propose the generic implementation
in parallel ? It will just be a matter of switching when/if it is approved.

[1] https://lore.kernel.org/r/20240516150842.705844-9-jbrunet@baylibre.com

> The regmap can be acquired
> from the parent device in the auxiliary driver probe with
> dev_get_regmap(adev->parent).

Did not think about that, I'll check, Thanks

-- 
Jerome

