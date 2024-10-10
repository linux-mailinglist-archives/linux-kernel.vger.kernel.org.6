Return-Path: <linux-kernel+bounces-358724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BE09982D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317B51C229ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898A1BD4E0;
	Thu, 10 Oct 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rP4ng+oP"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750C191F62
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553978; cv=none; b=ay9SlUpwyTApiRdVo0tvwntpnaUOzsLQP2k6V9JN+gVCuKoN17r93ozTzg0JbnsI8Lge2SCiXOEI7eISU07HhgSIR3Ymg0hU2JjSqerPy8juPLQOZYxWeo3KjcDwf/y/UXjelmopb/dBmSNfeeEtQJeaFVUsNiIMv9CBXcuO4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553978; c=relaxed/simple;
	bh=aR/od7u1Dm0L0Askk5LTo4Dg9qcC5Z7NUkiE7B1SAOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=In7ntLiF2v9vkuqa9vmAzfw7HV0t1O04FlFBx8D4Q6MDG2yxsdEYEbZTAdpsImPQQOiMeUX01b6ybM5YlGxhMu4SyBQykikIerceOrq+iYCDQ7kb2TyOUAWPa+kbsX4Lgy3rkXeV5nlkGerWGW/JSsUWiiIgEgrUY9oaYbLSV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rP4ng+oP; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9963e47b69so115854666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1728553975; x=1729158775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=40jcWFUFi0Oxb77A5Qmw+6hx6Ee/l4XlcgBsvUfMoMI=;
        b=rP4ng+oPD0u2B3qdAe5EpJ170oqHVt1uypV1gQHuBQ1/fFwUFGbBYAoH4VigrbhvZ4
         b/MKz6LyoIAljMDhRiCOeD07Jkn7a31nFuX5dIQcxDZeBksgtU7Vg8XaR0jfg0nRA03Y
         aScZr+q+/gsziN9ljcKmgvei1BITqKtoE/giM6xY8uEnwpSWvASmxytf5AOs9A6qL4/O
         PcB9tOTVbNSAaug0/yEk5nTF1iq7XdF/lHl2F1Qeg7bXqmOAvITKeDR5wzxc2GdD023W
         kswsTvCFPCTlDavbtTLHUOivKp1MQqTZbNLj034oW34GBE4fWFmA6yi/pJZMGW91lkt5
         acTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728553975; x=1729158775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=40jcWFUFi0Oxb77A5Qmw+6hx6Ee/l4XlcgBsvUfMoMI=;
        b=QJGUxRvftk4Lcej4gFGu1RGW4wBVUv6qf2/GGQEWugjlzg9A0BFWTWZ9hup/3u/5wC
         eIs/6juUCwK7EdVjKsG3rJwTW2ZdMrTVJupOF/m0LvfU438w16PKRqC5WRrAApcPuNsM
         h6DOtEuo0bEA0OjZ0V4nr9kAYygtJWUy+zRgF5A2JfZI0mkvTYQOkSbCt+nnhb37GX/h
         WZFVRVT1GLwmwkba+VZh+9C3qCwXsMljG018FPXZc5Yk2JglOM8Pnxv97aLCYFI1u+cg
         xifRzDNbP0JrclWKApUZ95HQYJbyja6x5gM1kUgvkwXWDBMue+xK5H8RmOcwdnzZFP4u
         JLhA==
X-Forwarded-Encrypted: i=1; AJvYcCWeQwxr4tY8ODB7ZH3xtJY7a78mt5iryBdp88OXvY25WvLV1KrnKerWi02qHkkUJidYa9bOivacqM2U+Cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjQJvcJZ1pKmrIXMnNjw085vtgCx/8w5bvopYFYLB2IEGsX6hG
	OIedMQyamVd+pzcxgeCjGiFSe9GavSLunmlBqDNJd7FYj5WQwWNt5iIge9We5QI=
X-Google-Smtp-Source: AGHT+IHGpgFAaHxId5Yu05QYCpBK0KheH6IwCDZNQtW0JlFbclcqU+qgTj7MahEzfh9iuoNu+rHtpQ==
X-Received: by 2002:a17:907:1c8c:b0:a99:4698:cc5a with SMTP id a640c23a62f3a-a999e8ca4e9mr286372166b.47.1728553974406;
        Thu, 10 Oct 2024 02:52:54 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.23])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80dc524sm65297566b.148.2024.10.10.02.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:52:53 -0700 (PDT)
Message-ID: <1c733190-bd46-43d0-8f3d-62e0ed5fde42@tuxon.dev>
Date: Thu, 10 Oct 2024 12:52:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] dt-bindings: rtc: renesas,rzg3s-rtc: Document
 the Renesas RTCA-3 IP
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alexandre.belloni@bootlin.com,
 magnus.damm@gmail.com, p.zabel@pengutronix.de,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240830130218.3377060-1-claudiu.beznea.uj@bp.renesas.com>
 <20240830130218.3377060-6-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWeGC_N3-XF29+UUR43OGJKqVNNHs042J8HRuNpiD=vOg@mail.gmail.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <CAMuHMdWeGC_N3-XF29+UUR43OGJKqVNNHs042J8HRuNpiD=vOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Geert,

On 10.10.2024 12:29, Geert Uytterhoeven wrote:
> Hi Claudiu,
> 
> On Fri, Aug 30, 2024 at 3:02 PM Claudiu <claudiu.beznea@tuxon.dev> wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Document the RTC IP (RTCA-3) available on the Renesas RZ/G3S SoC.
>> The RTC IP available on Renesas RZ/V2H is almost identical with the
>> one found on Renesas RZ/G3S (it misses the time capture functionality
>> which is not yet implemented on proposed driver). For this, added also a
>> generic compatible that will be used at the moment as fallback for both
>> RZ/G3S and RZ/V2H.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - added RTC bus clock, reset and power-domain; it has been detected
>>   by reverse engineering that RTC and VBATTB clock, reset and power
>>   domain are shared; HW manual doesn't mention it
>> - updated example with these and with assigned-clock properties
>>   needed to configure the VBATTCLK MUX with proper parent
>> - updated example section with dt-bindings/clock/r9a08g045-cpg.h
>>   and dt-bindings/clock/r9a08g045-vbattb.h includes
>> - for all these, dropped Conor's Rb tag
> 
> Thanks for the update!
> 
> Sorry for chiming in late, but this RTCA-3 block seems to be a
> derivative of the RTC blocks found on older SuperH SoCs, and on RZ/A1
> and RZ/A2 ARM SoCs.  Differences are found in (lack of)
> 100/1000-year-count parts and the Year Alarm Enable Register, and in
> some control register bits.

At a 1st look it seems so, yes. I was inclined at the beginning to just use
the rtc-sh but the RZ/G3S HW manual mentions a lot of restrictions that
need to be followed when configuring the IP. Because of these restrictions
I chose to have a different driver. Otherwise the rtc-sh would have become
way too complication as far as I can tell.

From these restriction I can mention:
- wait for 2*1/64 periods when configuring the alarm
- from HW manual: When the RCR1 register is modified,
 check that all the
  bits have been updated before proceeding to the next processing
- from HW manual: section 22.6.4. Notes on writing to and
  reading from registers) after writing to count registers, alarm
  registers, year alarm enable register, bits RCR2.AADJE, AADJP,
  and HR24 register, we need to do 3 empty reads before being
  able to fetch the registers content.
- updates to RCR2.START need to be checked before continuing (note 2 from
  HW manual on RCR2 register: After writing to this bit, confirm that its
  value has actually changed before proceeding with further processing)
- there are many bits that are synchronized w/ count source and need to be
  checked before proceeding (when setting it up).
- According to HW manual (section 22.4.2. Clock and count mode setting
  procedure) we need to wait at least 6 cycles of the 32KHz clock after
  clock was enabled.
- According to HW manual (section 22.3.19. RTC Control
  Register 2) when set 24 hours mode this needs to be done separate from
  stop operation.
- According to HW manual (section 22.6.3. Notes on writing to and reading
  from registers) after reset we need to wait 6 clock cycles before
  writing to RTC registers.
- According to HW manual (section 22.6.4. Notes on writing to and reading
  from registers) we need to wait 1/128 seconds while the clock is
  operating (RCR2.START bit = 1) to be able to read the counters after a
  return from reset.
- and there are other restrictions

Thank you,
Claudiu Beznea

> 
> The SuperH and RZ/A1 variant is supported by drivers/rtc/rtc-sh.c;
> DT bindings for the latter are found in
> Documentation/devicetree/bindings/rtc/renesas,sh-rtc.yaml.
> 
> (My first guess was that RTC-A1 is used on RZ/A1, RTC-A2 on RZ/A2,
>  and RTC-A3 on RZ/A3, but apparently RZ/A3UL does not have an RTC...
>  Oh well, at least it is used on later RZ series SoCs...)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

