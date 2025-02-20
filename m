Return-Path: <linux-kernel+bounces-524820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C4A3E781
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD5719C428F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E195D2139D4;
	Thu, 20 Feb 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KPzLH7iV"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402831EE003
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740090449; cv=none; b=sOLmbSp9wdd/4K7GxfGu62t2UzkWhhDuDr4LugyatVFuE9wCpw4rsbZm1sVaW2hjnZVZsQEdRk3HhNQ8vNlUh1tSJNkJ60r8UuNmnEQACN4Uo1KnF5VNHOCX2+REaB0mrYwsUDN6iXGFwOEJG7ym9G+H8dqt7oSi4VvzTDqIw34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740090449; c=relaxed/simple;
	bh=Wwlx+PMNjFVQG+p5LgCwO5bEhpwUj2L8Wcxf+n7/TkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZaEzAY6ck2itUtnCLxVIUjCD03MHptjZb0KIElpq6PCrrJ4zV3/syuiPeCU26atosUnOm1K0RUUaBswLHv2m7vhYW8/8sHh/IhZrOPEv7QqWJRNb67Z1rh3Q7c9ZaBEfGpGTguBHBHikn6q8hQl2j/4XJjVy/h5cQC8V45ocXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KPzLH7iV; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2bc52407b78so550201fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740090446; x=1740695246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pCESArWTseHQGpGv7tpeQqcnGXM7p2OA6JgdrilOIUE=;
        b=KPzLH7iVYauwnVWpKAzd8c+gRI8jqXjZVAi9CYURZRm+LzfNpuJXNW3mUISQNVvHOq
         KKfd9kbCYUQN9B/ikEQDVVHzAWI7XV+nyHXbosauAIf1U81o4h4NMdQDvGfaw0NkA/6N
         zCed+5cfix5tupuIhaXHF5xB4CYKiNY/HZlZPr0o/MgrJN/xTr0x8KVCdLaiBKfhwGWB
         iE92+aMeJp7PJruw2cyqy5xyPGQkphC8QDpqcW2Uj6Wk9gV4B6aC8uVT1nzkhaC7OBXV
         eDX1Aah/as5lKXknbKr87J8IYW4w86yHgKBGzXW2gKME+buUA8mhSEOl+XvRRRAzfhXa
         MGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740090446; x=1740695246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pCESArWTseHQGpGv7tpeQqcnGXM7p2OA6JgdrilOIUE=;
        b=pdysWIAQhkB1VFEyY0EUKtHSTK6O3SG0y9no2AEA2lbnQrlE5Mr+W8H7pC/v9cy1Li
         KYpVukbiGZaGuTidl4mPwaLYc0gHwCPz+jqTMpj2MjPkxME7JKnsoKgjMc3UCaDOdqP3
         bDWX6Avk+PMMUyoLZVdGq+u+OvLCiRUCDvRRtK0yPhHvGK032v1TukirzG4OY83u1eHw
         eqRZerDc5qM71zgsU+F970HjNRyiNEuRleGCWBwCijbpAYNn/X6CLwBTSU2OA0On+Wuc
         i7Z8fCJwSzlVGE+hA1ABhsd62OfPZtoLmY3XUL/4zGjMiXmQi99rGySWSt0iF9zQ8lX8
         QTkA==
X-Forwarded-Encrypted: i=1; AJvYcCUl9z9ndTQHRul5nab/abswTrfvSwy/kNTO0EdEmO500Ob97moQwuJBtxRplTLRpvt8OGWAQriC+StaUjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEe2Rstav0db9W8Waj8Q5CiUaV9PKIsDVqwVvfDaGUMsdWvGFr
	HywN5cnmoVJE8Vn1sna5w+Jq/Na9PKzVGFmE5EpMYg+6+PeyoPU4apgIIn7XYbA=
X-Gm-Gg: ASbGncsxemmYc8p88KpsSoHoT4LvuAuT8XXvEbPCM10T1mDkQAfRtHXUNm0e89eI4UV
	gfJ3PuucLatulOeaEw7M5auyeOUF21jwQOhkciZ8eC+lcDsPiEVvQ/7zYzaMym3/FgqWZUshDcp
	2XXhViSUGW3LkvsVQKpurPwKoVBq4MTfmtc++gZWQKfoPVt9b3CMJHAkb2NTdKJ22zw53E/sts+
	ElQ4G3sw1p0nfW+fvNlRYdGrRhtkG/MPV8RB2aYu965qDYjvZ/IxCvbWvuBOyTmWLGssvQwBsVI
	/ltZpoYHgGZ8WG0Bi5vXHaOFiM+KhrrhbQ0xb9kgSn3ZeGnO6q9n
X-Google-Smtp-Source: AGHT+IEZpgJbx9x8Shte5+BRZ16avAvT1+wdr0Mi+ErzsXsYe5ooaU2WYdYSImpsg2NCEWK5B0Iz2g==
X-Received: by 2002:a05:6870:6b97:b0:2b8:ec17:66e9 with SMTP id 586e51a60fabf-2bd50cdbd64mr746258fac.11.1740090446165;
        Thu, 20 Feb 2025 14:27:26 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548878adsm6600768fac.17.2025.02.20.14.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 14:27:24 -0800 (PST)
Message-ID: <7c5e2364-038b-48a8-ad67-3cf0f2fd2be3@baylibre.com>
Date: Thu, 20 Feb 2025 16:27:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller
 support
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sergiu Cuciurean
 <sergiu.cuciurean@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
 <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
 <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CACRpkdaSY7WH191makzPcZqLd-vBsC_f6yagWzBa65MrC+pjKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/19/25 2:34 PM, Linus Walleij wrote:
> Hi Jonathan/Sergiu,
> 
> thanks for your patch!
> 
> On Wed, Feb 12, 2025 at 7:20 PM Jonathan Santos
> <Jonathan.Santos@analog.com> wrote:
> 
>> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>>
>> The AD7768-1 has the ability to control other local hardware (such as gain
>> stages),to power down other blocks in the signal chain, or read local
>> status signals over the SPI interface.
>>
>> This change exports the AD7768-1's four gpios and makes them accessible
>> at an upper layer.
>>
>> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> 
> Is it not possible to use the gpio regmap library in this driver
> like we do in drivers/iio/addac/stx104.c?
> 
> It cuts down the code size of simple GPIO chips on random
> chips quite a lot.
> 
> Yours,
> Linus Walleij

I think the answer is "no" since we need to hold a conditional lock
while accessing registers. Namely: iio_device_claim_direct_mode()/
iio_device_release_direct_mode().

Unless we add some extra stuff to the gpio regmap implementation to
add optional callbacks to call these. Which could be worth it given
that quite a few ADCs provide GPIOs like this.


