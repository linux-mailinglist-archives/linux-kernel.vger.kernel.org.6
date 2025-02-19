Return-Path: <linux-kernel+bounces-521997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9A2A3C4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F5B3B04A2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCD61FDE26;
	Wed, 19 Feb 2025 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoKy3zm0"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E8D1EB1B7
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981755; cv=none; b=pFQ8ilKAc+HeoXfVuFaZ7KEsthwFxI+fYVrikA8Hz1zvl5C5fuJvC9q9kwth+gBs0e8T8AycdTLXu0/OQvdYEc0iNy6QTz2E9FFBQROZ4gbOMcA5otSnHof8uhNsjZEaR4zdOsTEGVxRFyy0Rp8ZpTB+YV6f18mfI5ErKlSMO9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981755; c=relaxed/simple;
	bh=jYP3oUxOykgszQEZALo7cXOu9zDyqHi75sgn9lMVd8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LnkZin0leUwpmgxP3EoOy0VrF9IzI/J482bTgQR55OFkpmAKmkEwhSVWeNmaz3+rDJcrfoLPh+CiCFWISK+hqm1/kcCggPcujKCIqF+rq6snS+0fziCHu7OIz4pWy/y/EOEugW223A6EMWxNMtw6eguJpay5qJ1RtBiSeRlbeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoKy3zm0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e04861e7a6so7153430a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981751; x=1740586551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h89HTe/tN0B10+LNl92cdXHG46JoxeywocoM5Bh9DWc=;
        b=NoKy3zm0rYeRNrEmxrEpvL7/Q9TuUVep2la9SgPOmI/Y3pL+UFWSjFFJkbctCscZJ2
         S5ocIMHUqwBHky9gWoGfF3BI+GU1QdVEY9zuJuFWiAS9s8bVUi4TI65qZGvNqjfVnMsI
         sk0x8YXtG0x+ebmMKcbTGSAzLD3nl71LiyLX7QNY1IaIwL1Go8RYNvFXQm7T/VKpN3OY
         E45Z2ZYvDnUil2f1LWSa8DQSdBx+kIZtzfmwHKQiDfO51X1sYXI8hs810QEt1dLMP8iG
         Yq+TiuorteRTMHX9ZXsSLSkara+0jJgngdaIlFiu+fE6L3du9g320oAUy7nVl9e2wQog
         tiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981751; x=1740586551;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h89HTe/tN0B10+LNl92cdXHG46JoxeywocoM5Bh9DWc=;
        b=h/pkC9AYUEBlOpi14LrKR0BjuhXW33TBHcwN1FUf5/f5azfTW91IDt1BDxvPUjusgq
         DHvz3iifZbW2ibQoVH6WE7SmieizhIzQSTbW5noDJN0diYwsE6j/LfNQtiLwkgh0PDTk
         zEbiLIkwVsW6RGUr2vi7mcaP0l2M/gMvN2QiQqCoMh0pj61C+/Cv54UWViegc+5YoIJy
         a4Rzhb3Qm6teLT3HJZ1wBJJPnPsfDHjuS2yCTwS1DqG+aDDgPJA3s7D4Nt0EvI8BQUpB
         F7/SlKhaamLcHyOzTihgxXZSU7p8T4hSJ3DOatZWwFQoYtWONvxEIDwtYX2Alk7xzL5y
         VBVg==
X-Forwarded-Encrypted: i=1; AJvYcCX3c2AJm2wat4Z2fOdwFyvmlmJdfiWGBQyuX+d3ygpf8h8YIG3xzUDA+UZK5waS9jZfJ3DUi6xup+3LvF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fhbAdtmZarIbqDBacO8hXG4Kg8xbKrDtL3qR5M3xmQR4YS+N
	MiqEvfEPDTXTOIDH4JgvhyhJCW1QF7DIJ+nJKq2NSZVMDkZjPZYZEw4ZnvmasH0=
X-Gm-Gg: ASbGncvyw88MuXg1MuR353C+lSSQ67Wr6X+jAsoabneCOYLXlLHJexnyuTB2Yr+d++0
	gyqNdxlDmJ10WMpcHg9/4o1lxieHq8KPrq+TPkRg/fIIHOSMjOSnzi/i/JsxV6KkTGiVj22sBYr
	Z9VSR09/lC67ie8bP5AWVnFGz/lfadSfkfAg5CkOcwB9ORmTkPWJe8KrqOKTkvb/1iHia5I5QsY
	fvR60wFgs6TgF5XKkbfRuz9q1HxOEbBrCVVX1aaGONDlB+9fruo5mlWgHlDrJwTuhuwRq7xz/8n
	/bfkMXGpzYA9FiFc+J9nJlw=
X-Google-Smtp-Source: AGHT+IFiFYqo71zXgrKVNjvpkw6kSC58U3/FltEHaZdAEiHjs1T3I77KF/UZNliKfKxYH2d2UsL+vA==
X-Received: by 2002:a17:906:3118:b0:ab7:da56:af9f with SMTP id a640c23a62f3a-abb711c3de7mr1770699866b.49.1739981751230;
        Wed, 19 Feb 2025 08:15:51 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb94e4d0adsm687953066b.56.2025.02.19.08.15.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 08:15:50 -0800 (PST)
Message-ID: <b9b14a25-675e-4e3f-afcc-e82d5ed740a7@tuxon.dev>
Date: Wed, 19 Feb 2025 18:15:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 0/5] phy: renesas: rcar-gen3-usb2: Fixes for Renesas
 RZ/G3S
To: yoshihiro.shimoda.uh@renesas.com, vkoul@kernel.org, kishon@kernel.org,
 horms+renesas@verge.net.au, fabrizio.castro@bp.renesas.com, robh@kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding reference to the missing series (see below).

On 19.02.2025 18:07, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series add fixes for the Renesas USB2 PHY driver identified while
> working on the Renesas RZ/G3S USB support. These changes are
> needed for the upcomming RZ/G3S USB support (especially for the
> power management support).
> 
> Series (with [1] on top) was tested on Renesas RZ/G3S with consecutive
> unbind/bind and data transfer tests before/after the unbind/bind.
> 
> The unbind/bind was also tested on the devices with the following
> device trees but w/o checking the data transfer (as I only had
> remote access w/o USB devices connected):
> - r8a7742-iwg21d-q7.dts
> - r8a7743-iwg20d-q7.dts
> - r8a7744-iwg20d-q7.dts
> - r8a7745-iwg22d-sodimm.dts
> - r8a77470-iwg23s-sbc.dts
> - r8a774a1-hihope-rzg2m-ex.dts
> - r8a774b1-hihope-rzg2n-ex.dts
> - r8a774e1-hihope-rzg2h-ex.dts
> - r9a07g043u11-smarc.dts
> - r9a07g044c2-smarc.dts
> - r9a07g044l2-smarc.dts
> - r9a07g054l2-smarc.dts
> - r9a07g043f01-smarc.dts
> 
> Please give it a try also on your devices with [1] on top as well.
> 
> Thank you,
> Claudiu Beznea

[1]
https://lore.kernel.org/all/20250219161239.1751756-1-claudiu.beznea.uj@bp.renesas.com

> 
> Claudiu Beznea (5):
>   phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
>   phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
>   phy: renesas: rcar-gen3-usb2: Lock around hardware registers and
>     driver data
>   phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
>   phy: renesas: rcar-gen3-usb2: Set timing registers only once
> 
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 134 +++++++++++++----------
>  1 file changed, 74 insertions(+), 60 deletions(-)
> 


