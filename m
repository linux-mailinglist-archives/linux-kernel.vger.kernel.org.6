Return-Path: <linux-kernel+bounces-424902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94C9DBAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 17:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E19EB20D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BD01B85C2;
	Thu, 28 Nov 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dvfMj4CR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9E3232
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809774; cv=none; b=I6yEY5wJB39QvDL0qh1yw75lz3XvD5e72u3WLQnEa2Ey3o8bhKpyXI7G964jNcPdxdscORiSt0l0tRx1q7igwCW4PSzdywubYSnhLbRVoyEg4ggMJOP2LGfpSBIMZe+MxZvIUkfkWPbbMzU9K8aObRDuNtVUaivFrFFZnocXVD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809774; c=relaxed/simple;
	bh=BUgI6q4HJb2tfnAV79BpnK2T+75hJlvnbgr/WBvkzZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pf2lARwqO1v+9Z1ZIEg1kFysk9u3FgXDsL98wtKKe/3ejM01UrrHPkhtOWVv4U0kEh3pBwn3//nmeeY2sWWiHnrRfBHbdzuy2AFkW+Wu/dqqbRgCvBOuTkWcEBQOZ+LIb5B2jPc8owlixpE6nzc4QMecGgCwyrslhX+utr+TJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dvfMj4CR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434ab938e37so6332495e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 08:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732809771; x=1733414571; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cd3HIAbz5teig6mZhMhVwVj28VKONXEVKeEO3RfXUec=;
        b=dvfMj4CR9Jngq/FAyB8FITuAKiuxerDbor06NvIatyMm/ss+jLV0Q7+lmB1VgS38pg
         2d91w0HVwZapLiRJiX+Lqy4Z2PFyhFQByejMsixceR/BWQBhLZQVuHfJkAVp5cGL/zgx
         BtGlDgYrKVSFV7rfv/c6RlSLg8B0wGGLs92QmlZsNord3SYo2wSOCVg0taeRjwL1ijKD
         bb7M3ypZg30tcgIpN9lu1LAmNaloHPgNJCipd03WpjtvolVPmpj7Tm3F4/tQHv/pO8wN
         a+3LeBOYLvbPhtwv6157f8pnfrk2U80YY/CUpCoHTETX5RInGBsU2rvyZAvqNfYJPhSl
         /zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732809771; x=1733414571;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd3HIAbz5teig6mZhMhVwVj28VKONXEVKeEO3RfXUec=;
        b=H3jaSh113WiMUwrmAedevkDhIWxoyZd67Gy9SLRMqwsoTYy+df77JYI5TmsNy2XrV4
         XRI83SSohmj6kQzT4vsoZHDU7FgEqEr9e88gu8mlhSSjigqplTxfMlPT099eWmTWj8/K
         cC9Gw3UK/TNUy3cy8taoRXtmveXN0mOdN7pZTPa8rX/DZF+0i3jrsMn7Dqm5Lwbse5eg
         2C2qu/g5kiBT7gWu2GEJj7roPR5cNgwroS/4PY4U5PHDLqnKtQAzJCayySOEX1gMs9fy
         /9cmxLXwAiWid/4V0g2uY/UP8LvcbbbKQbMsonRuCLXlt/QllW64a/LfvCamUooGOqV8
         jNiw==
X-Forwarded-Encrypted: i=1; AJvYcCWHfO7akmkNDqw/jmi124ztgaP/rutYfImU+tDGaLkrAoJu2XMnDkqtE86wykpFqlbKchLNziq+zFKj3xQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcxyr7QzgIwNIiPGzjLcj8vJanmTtlKFbc8ILWfQx7hcofHHyL
	XAdNHapnWy9DWxgYaCvJkc80D6ob8NKWqaa5ThDlO0HLKf+tWgg7JH0dXZ3edHo=
X-Gm-Gg: ASbGncvCjN47TOJrEjMG75C17I/REtwJ4+Vu97RctOV3GT0W3XuINMVUT7AO9dZCAlO
	5Yd9/j8G/KaRDlRqEhTCa0r3iUDjTu6gLQem5/B8X2r53LNIwR1vCn4OlA5dEJ2OfINtME4/ipv
	ouo8j+CYtqEwsQ1nrlERnuFy17ROtuOLZNZ5elmsOMt0dBfOcpmoHtpCWVlFTTFKSbD16JHYFLZ
	d+StwhYBSi9oceHSWP3mhcyIHZ0JU1PCpvZIismsxZbRYB/JA==
X-Google-Smtp-Source: AGHT+IF8jksfRql7w6do+0ni/UEA23LaMmjUdkNNHCmXy6TaBrSlXrzm1NoY8e4VxzZ9r/opidqFLg==
X-Received: by 2002:a05:600c:1e24:b0:434:a1d3:a30f with SMTP id 5b1f17b1804b1-434a9dbb946mr72027945e9.6.1732809769260;
        Thu, 28 Nov 2024 08:02:49 -0800 (PST)
Received: from localhost ([2a01:e0a:3c5:5fb1:b89d:29e9:7047:2d6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5285sm57355845e9.40.2024.11.28.08.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 08:02:48 -0800 (PST)
From: Jerome Brunet <jbrunet@baylibre.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Mark Brown" <broonie@kernel.org>,  "Neil Armstrong"
 <neil.armstrong@linaro.org>,  "Michael Turquette"
 <mturquette@baylibre.com>,  "Stephen Boyd" <sboyd@kernel.org>,  "Kevin
 Hilman" <khilman@baylibre.com>,  "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>,  linux-amlogic@lists.infradead.org,
  linux-clk@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: amlogic: axg-audio: select RESET_MESON_AUX
In-Reply-To: <22f0ec0b-889f-4588-91fe-764a45870f25@app.fastmail.com> (Arnd
	Bergmann's message of "Thu, 28 Nov 2024 16:57:05 +0100")
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
	<30cd9a80-e9d8-4387-ad28-451f7f95637d@sirena.org.uk>
	<22f0ec0b-889f-4588-91fe-764a45870f25@app.fastmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 28 Nov 2024 17:02:48 +0100
Message-ID: <1jbjxz1h3r.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu 28 Nov 2024 at 16:57, "Arnd Bergmann" <arnd@arndb.de> wrote:

> On Thu, Nov 28, 2024, at 16:52, Mark Brown wrote:
>> On Thu, Nov 28, 2024 at 04:34:46PM +0100, Arnd Bergmann wrote:
>>> On Thu, Nov 28, 2024, at 16:06, Jerome Brunet wrote:
>>> > We are deviating a bit from the initial regression reported by Mark.
>>> > Is Ok with you to proceed with that fix and then continue this discussion
>>> > ?
>>
>>> I really don't want to see those stray 'select' statements
>>> in there, as that leave very little incentive for anyone to
>>> fix it properly.
>>
>> One option would be to get a change in defconfig for -rc1 and then deal
>> with moving things about later.  I would very much like to have these
>
> That sounds ok to me.

With a change in the defconfig, the reset aux driver that needs fixing will
start being used, whereas it won't be if a revert is applied

Fixing the driver will be a lot simpler if it is not used yet.


>
>        Arnd

-- 
Jerome

