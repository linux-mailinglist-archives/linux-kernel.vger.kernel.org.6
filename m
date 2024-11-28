Return-Path: <linux-kernel+bounces-424813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269029DB9CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE87B21D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15211B0F28;
	Thu, 28 Nov 2024 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w7AxO7S7"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDD1B0F01
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804798; cv=none; b=sY6jQi03khHejjvSdjGWpBm9SGMVi+oUenL2ZJhOxKtRSKO+x2IrRtXH7I9nQmRGtB7FoKQHABtlACHzk80LxOTqs9ypBUwSODdRYmG5V9+YYaz3q0wN00+RNX8LEMv6u3qetDpiZxP+YDH1fEuWp8qng8j1pcwPxABbUOVmx+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804798; c=relaxed/simple;
	bh=0/pq2JHTPBtY1nMwm3NEMavei1AJiDpMsWbM9c6UYws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfZZ3iMKW2YTR4Er1JHv/cg9q5f1A0vF+7rWHMNcSLUT5meCzvo2xCAlzQVwpRp4ewRpWskAI0xRiKZWTC/YzXJ6JlsHm/SMVmvxikgbcck5beNg+ClMfich8VTLBnerdVBSfCsipB00k5XBQhQJEzTYojQJkv+LGlXUcWXQYbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w7AxO7S7; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434a1833367so5595345e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732804794; x=1733409594; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9T03i0gzxNbf0agsZ7Lvsc1uFwXMAZb0xxRBoFTc9Q=;
        b=w7AxO7S7XPl9p2YMR+61++9iScAM6MGkUvNt9gDKPzRTF3dGNB5uB0KHibk0w4EsWz
         B7wRJ44w/DWILRS8ik5dDa1eM8khfScTBxKyistzMfYHGO2enMUUIRMd9towz4QN10EH
         0Hce2HXR7J+j9YGhYp8/IiS880yi0OL09dvXltJRfZzciOxKsZT+wimvsBY2bAYtmDkc
         6w7KVKL9E2YNB3GsE3B8n9cRD6UI3HJbTCnW+fC4oAafFGFK+7CWK3pp1SsxKYRS86Hw
         qXFlNp9/Vak48DxA6eaGtBOVe6TUakjVQ5QIMKafzkrWk1r9W4fdZ5dUQ8JAYB8EKI16
         Zy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732804794; x=1733409594;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9T03i0gzxNbf0agsZ7Lvsc1uFwXMAZb0xxRBoFTc9Q=;
        b=sRS771qypvhc4QM257HlURSb9ZSKkTK0Ft7USsgOniGR9bxs8KW1GHpaBmHHPPnLs5
         IYGeSvQ8R3BYyyCHlcRH8IgnBDc5hsyGsXWy8L7kQLm1ZaOCCFJ66Ap0T/Fryvu/Moep
         c4mJxSmqC5bkGg7YabLnDXChIqUrip8aWsR5AnnG5r6r7kxMYNoNbKPXLrAXVJ39TtDC
         1t+1Uk+gFc15R1oaOQZyw9x+QRUna7oZn0SWxjBBmAcMmxysii+isF7XsZesGIKlglQN
         VPlv9wYgaVH0Vk4vS7kDp/YjfsV6hcq4WNTUCaqw4jRRSF+GH8js4Y2xuSXcv1R6Crok
         1khA==
X-Forwarded-Encrypted: i=1; AJvYcCVQS1p6obnCnlNkHzoRjTlNC+gtWBxS1IptgvFv7fDZKvVPCmWcDU8rY0Zl82xD03TQO1gQRn2Snc7CFrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFdpKj/jDxDEe87f0j4TH9KjEJYdfmQJe2fdKDicQdC90O46ky
	P1FCo6MmJI4xPcb9Qz6LrKkspFJRbfhk32vIZvQfJllWQq9J1ciLrTQ6YuHEX2A=
X-Gm-Gg: ASbGncvPSGDGk68oyiPgZyMI6349D8BLlvIkg3369ge3t4sqDSAkYkMmso5z66+4VMx
	VkLCYqo8GPdyOlmYd5syqVlB6MxT5v7pEvN0a5nJVWaIgtPvq7uhEMZfyTIE7CQkFu6EVB+kVzz
	a2+W5EQBCjwkOXLtBJhEgwr42zPjnVzSgyq4W7uZO1uwPE2w/D6u1N0eoDSZ/MzGdZugJnPjRfN
	O0tbP7plQhgq3xur/MaTVjMjLFjLnRNXvQJY30/KwwScQg88g==
X-Google-Smtp-Source: AGHT+IEfrnXry/a2J249x05WOVDUYdJwm8BHrIV6ctpYLw6UOC+tPaq9w6TaP7uwmtjWNU3Zv+M13w==
X-Received: by 2002:a05:600c:4fc9:b0:431:5226:1633 with SMTP id 5b1f17b1804b1-434afba0023mr30871715e9.6.1732804794064;
        Thu, 28 Nov 2024 06:39:54 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b89d:29e9:7047:2d6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd802e0sm1792177f8f.105.2024.11.28.06.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 06:39:53 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Neil Armstrong" <neil.armstrong@linaro.org>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Stephen Boyd" <sboyd@kernel.org>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  "Mark Brown" <broonie@kernel.org>
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com> (Arnd
	Bergmann's message of "Thu, 28 Nov 2024 15:11:56 +0100")
References: <20241127-clk-audio-fix-rst-missing-v1-1-9f9d0ab98fce@baylibre.com>
	<12f29978-c8ce-4bee-a447-dcd086eb936d@app.fastmail.com>
	<1ja5dk2y5l.fsf@starbuckisacylon.baylibre.com>
	<f8de4a2a-776f-4c10-b75e-e845bcc38dde@app.fastmail.com>
	<1j4j3r32ld.fsf@starbuckisacylon.baylibre.com>
	<306b0b30-5a32-4c7c-86b4-57d50e2307e8@app.fastmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 28 Nov 2024 15:39:52 +0100
Message-ID: <1jy1131kxz.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 28 Nov 2024 at 15:11, "Arnd Bergmann" <arnd@arndb.de> wrote:

>> All clk, pinctrl or regulator are used by other driver yes, this one as
>> well, sure.
>>
>> What special about this on is that it is an auxiliary bus driver.
>> It is directly instantiated by another driver. That's where
>> it differs. The axg-audio clock driver instantiate the auxiliary reset,
>> it does not use it, which is why it makes sense for it to select the
>> driver.
>
> Can you explain the logic behind this design? It seems that the
> entire problem here is the split into more drivers than it
> should be. It's common for clk drivers to also act as a
> reset driver, and my impression here is that you were trying
> too hard to split out the reset functionality into file
> in drivers/reset/ rather than to have it in drivers/clk/.
>
> Could you perhaps move the contents of
> drivers/reset/amlogic/reset-meson-aux.c into
> drivers/clk/meson/axg-audio.c, and change the exported
> symbol to a static function? This would still require
> a dependency on the exported meson_reset_toggle_ops,
> but that feels like a more natural interface here,
> since it's just a library module.

That's what we originally had. Reset implemented in clock.
I was specically asked to move the reset part in reset using
aux drivers.

https://lore.kernel.org/r/e3a85852b911fdf16dd9ae158f42b3ef.sboyd@kernel.org

Eventually that will happen for the rest of the reset implemented
under drivers/clk/meson.

It allows to make some code common between the platform reset
drivers and the aux ones. It also ease maintainance for both
Stephen and Philipp.

>
>      Arnd

-- 
Jerome

