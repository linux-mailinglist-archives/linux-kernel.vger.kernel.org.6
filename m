Return-Path: <linux-kernel+bounces-441392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D09ECDB0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E18E163311
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DBF236906;
	Wed, 11 Dec 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="We7Ro6Qp"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D61F381AA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733925209; cv=none; b=pgBM6aV8yGNKVt6pPu0yDc6AmBUBzGI29QeCI8PrOHhyyQ1QdAqHWaheKVIhflbYAjFiqBYPepefY9ZGH35jVLoLOH5BzUIM4WvhaeO47sVmPiLRqyAz+RMDv2Rg/0jtskwAH5be+YgyZr29BGwDR+gIUaTIQEx5+TGl8le6tm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733925209; c=relaxed/simple;
	bh=YSdh0Mm0FonlMgaa3imnf9PPReZOary7MqBo29RKeZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPhdqLhNWo1KMiB9q6R06E1ziz+CBlkgvi0tZOXZvQ9p53GBNtB6ow+qd9Z8wPwEeXK0OEk7Y48AMuebhL6ZOnTy1qKRljYtl2BsFuE49+fgqcThbFDsEfOA7CN9j70boa5Shtrk5TW0mzFngz8De8rTC7lHqB6+dpKn23G77uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=We7Ro6Qp; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so9226863a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733925205; x=1734530005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2JAQ94DgwmZTsFqQuFhEr5XjtlJo5Liq/MWFSbEP7oQ=;
        b=We7Ro6QpXdFqx1EZCLNk/BGMGe7KhGl6PAlNriTd27U4td+pcYwIjAR39eWjr3fQV3
         hbwqiaKicF/joN8+62DAYg8Wf9/MURxT8V6z8bGdUlL0iV0Y0xNXupuRo9OjB3QYbfXB
         csYSDW2tU10Y1v8TLomFlX/NG62h5wyDlxRXMB8/GWwUj6vIlZrublRxbyO8JQNTZs1M
         OcPBeDjVKdSmVLyG3jFTn0n0XIj0HAlr/ZL0YbhyX4t0B5HGjOtgCwRfE8wv4qfhgf1p
         XHhWsm3/GVeyw5+QUaPsEKGZ4IfFzeXu8dZNVG5Z9qY2DOR51vj1yLn1M/mVxfIyXI4X
         sg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733925205; x=1734530005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JAQ94DgwmZTsFqQuFhEr5XjtlJo5Liq/MWFSbEP7oQ=;
        b=fxdTGs0RmW7goi2uRASDOERsU+az9f6P4wtc/iC+U6cyhOyPfiwqpDBkyVbwC3IjCS
         uLPzFbuutdEypyMwsZiftTygEnyhL82jz3+f1oqaBWzgG0oeUA86xFAhV1Jvuf1qq6gN
         5thnib8vGZQXC8h59idhUdbXSBji/L7TVs/H7sPnPNfpHpja9O4X/87fIvtVUxg/bp/b
         jC3IV62fjJCQxaCxdT9vbmrnzUxv3pZpT+4x2ZnZeVQ/Ls4SW1RGd9/0/9G0idY9ZWqC
         IVVs2u+V4/P0vpIbOk2AY4TlEfTviU7sjE9YM2UbxM80GQbPhAiTHhv+isxUZCR4tr4z
         Otsg==
X-Forwarded-Encrypted: i=1; AJvYcCW1cLxdehm2EkCSMNt31kklgNXVlOdtf/mBVbJ8IANEv+sr3+Yk1a0tEwnRKClDHYciFgteMKYbr+2+wsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEoTsJGLPok98G3FFRBSwA+8VQ+H4wXLSGOqRCQ30JcVukObPU
	fi79VH3z2Qk/ihalHOwQM6XOfq+JZ1IzQPPXYtoztH0u/z+pvuVocZi+Mj95NeM=
X-Gm-Gg: ASbGncv/Qhn+BovLQH8KbJxvoR/mKPD0HXy8AHlv5xJwVrVz0zZS9VqkUTfvDdko2ZW
	xtuu8wMiryXKzuvd1bsx+++GWaL78NOLiFmwI+dLX0ow+ny8989l/JFQOywZfvbBkt5OFLuc474
	GQNQEN2uCTLz87Oi1vsGhWNrzaEK8fKcusSKDnCIEfmr30RH5Eb1qYPUu9qyAmPuLX+7H/VePA+
	XFNzSI/hs9m30nxvA5UDUZsD+8HNGh3+6xTL22/MirjByCo9Gpz9tEwlPtxrFs=
X-Google-Smtp-Source: AGHT+IHhR+q/yjOR8fMgpp+HvsWmN+ncd/5Lo5Mk+pkPGE0cvah/TqVw4ZywcOYOxY2cukLaXrgmug==
X-Received: by 2002:a17:906:b3a1:b0:aa6:75e1:186c with SMTP id a640c23a62f3a-aa6b1505cf0mr213318566b.50.1733925205362;
        Wed, 11 Dec 2024 05:53:25 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa653d1df95sm682900766b.98.2024.12.11.05.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:53:24 -0800 (PST)
Message-ID: <5e7d316d-2e13-436d-8474-48411e2a12d9@tuxon.dev>
Date: Wed, 11 Dec 2024 15:53:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] arm64: dts: renesas: r9a08g045: Add ADC node
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
 <20241206111337.726244-15-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdVMQr9RhG7v32vQeSrepmdh2VdzzwF5obJUpdGNotGV7Q@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdVMQr9RhG7v32vQeSrepmdh2VdzzwF5obJUpdGNotGV7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 11.12.2024 15:27, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Dec 6, 2024 at 12:14 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add the device tree node for the ADC IP available on the Renesas RZ/G3S
>> SoC.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Thanks for your patch!
> 
>> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
>> @@ -87,6 +87,59 @@ rtc: rtc@1004ec00 {
>>                         status = "disabled";
>>                 };
>>
>> +               adc: adc@10058000 {
>> +                       compatible = "renesas,r9a08g045-adc";
>> +                       reg = <0 0x10058000 0 0x400>;
> 
> Table 5.1 ("Detailed Address Space") says the size is 4 KiB.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.14, with the above fixed.

Thank you!

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

