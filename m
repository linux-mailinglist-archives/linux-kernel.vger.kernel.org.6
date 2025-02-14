Return-Path: <linux-kernel+bounces-514457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E38A3573C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 07:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91F71891F96
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 06:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76241E1C2B;
	Fri, 14 Feb 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpQ3el9J"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D11714D0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515150; cv=none; b=jGKEDesPMGJ5KYHwP386q7AwfepUoYoBPvhOwBYMx8aE0rdg6Py0qQmFoX/ffEAVVvwciwDNDLJpK580DqmlAaYOrdftPaxnGpaF4cyYgfa93RXhimJP7FotcQEG2wqmlFaMAYhh4jGS63FNVF9834kVMJSSnr3LBpPHXzIHgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515150; c=relaxed/simple;
	bh=wM4tKt7wnAjL5plOI4BRiyB+09XoZe0tKNq0DJSi+xg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UErYUsN5vojO/CBs0McrIgUg7bocwlADDczzoy3DFV4m25JJpbBNpWy966mVBtAYzvve7jEP+M6a9RSqlazsIDjlmLepFVBZmM6AntsJXoIPOXkI+SPKPGBGL3U4o1DHS/9RU1srYNwhuZNUrv9AQ1ndHPqGfE/Q4K7+nPXNIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YpQ3el9J; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso254655166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739515147; x=1740119947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n0sU8UuAz6zX29kmBzzz54CB+mIZrBU5m5rlPw1QPe4=;
        b=YpQ3el9JyDtytDF1ggQ59bMI/wJQEtgyGxBm3ugSRebGJwOkMKScLcV/ZPTLNdfGKZ
         X4HhcHT3UXlhmo6XJUAiAz5tu5Jvnc754r781IrG7fQEHRkNJ+pf833Awa7TCZetbO1n
         WnWKWI6Q/OMDO+toSnncco1gCpHsfSwbAtCZra3BGDF/yS9c1gCPxmdON0fQ7aBIXjFZ
         eS6u4h8pTNHBp4qKoNWRrEsClILIytW9miaBkEyyhaRdcxBYZVl/RFSf06Ras5CYs8QR
         b4I1rOP7WvCA8uoI3dqm1j6LZUMI7mG86gwsoukeXcrqQcRTeL18ijBiwO6057QgcH85
         TzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739515147; x=1740119947;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0sU8UuAz6zX29kmBzzz54CB+mIZrBU5m5rlPw1QPe4=;
        b=iG7bl6zFUsTb6M3cv1CepFPA+muSQRRF9eCPSKJ5n7Ujqe0UG7yaiUKqdxzbeDcOkL
         7rW8jnvw5Y4ND79dvstYe8QWg7atttKJNR1caWeft5IQ4lwX0ThQ6Mhqn3PWbIF2RaMg
         uroNcNCZ4wtNQQzAYFE84K71iyXaetrH/2EwoweNR0wq6wcbj4MtLdvR5Fisjz6gxzAa
         SS8pmvE19/t5U50jeRrWKVDMTIpO7Do4Af8C8/oE5QhdLIgLNqc3oKabRVo9DImOhS12
         +K0fUmjaCllZJEGUftDZ0DCThk5E/D5fJDJOt2knC1SmKh1vQcTfMJ9gLq6Aa9qDv6gy
         pieg==
X-Forwarded-Encrypted: i=1; AJvYcCU6F2o5ROlZ3qQxHgVBOzjVZx8T0x1tGR2rnaW/Kcry4cyPypvAJBmus2j49SRSa0HXQKIfVq6vbRux1oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyooojUb17GCGUX71fxODjvqtOIrelyhBDocAqlpDA4yzbYZTwY
	LM7YwX+xh2hSgvz9YsEVeWwH/vIl4IAMJpEmnU+mcttLqqCCSkVSXVHgNmxHxuQ=
X-Gm-Gg: ASbGncuG5l3Ffxa86NogrdfzxNsDbax0kq3NcQQ1yFF3XBHuiomJuQXNuJvegncJv+4
	pHJGsDHuYTpZuL9FhragqQ22cxASXFXT4x1jzTZC9AXgSOJ+kIu4PkXBni4vyBILXM2diMNOEv9
	7jYDe9PYW3OjZYQg1A+M4k9w7B9DYv47DnJzIxJNRcwYjzmyUobrDqBWsPoxhhOpIAwwo26JUk6
	DDRt4xIS7LyBPnScMD65qBdK1mLY5FzFX+hkkm+zGJyCkGTnqQHC1hCODWdRni3YOKtWjdX/qGj
	Apl2Li5NxNxMdYW44NwKZ+vD
X-Google-Smtp-Source: AGHT+IF1d6cYVnJi5xW59uL3+6NvNiwx8uIujRV1yuXHWDc54Fra2mr4R1Bhi8JKR7ZMNqzyULR9og==
X-Received: by 2002:a17:907:d26:b0:ab7:da56:af95 with SMTP id a640c23a62f3a-ab7f336e7b4mr907392566b.2.1739515146641;
        Thu, 13 Feb 2025 22:39:06 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53231f36sm276066166b.33.2025.02.13.22.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:39:06 -0800 (PST)
Message-ID: <cf0a5ab5-265f-4429-8c11-8b669f00bc70@linaro.org>
Date: Fri, 14 Feb 2025 06:39:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Denzeel Oliva <wachiturroxd150@gmail.com>
Cc: andi.shyti@kernel.org, broonie@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
 <20250213204044.660-3-wachiturroxd150@gmail.com>
 <CAPLW+4nJVf0raJ-O3u6uUteBi--N5xGwvzXp7cHqbkdMJ8gCSQ@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAPLW+4nJVf0raJ-O3u6uUteBi--N5xGwvzXp7cHqbkdMJ8gCSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Sam,

On 2/14/25 12:08 AM, Sam Protsenko wrote:
> On Thu, Feb 13, 2025 at 2:41 PM Denzeel Oliva <wachiturroxd150@gmail.com> wrote:
>>
>> Exynos990 uses the same version of USI SPI (v2.1) as the GS101.
>> Removed fifo_lvl_mask and rx_lvl_offset, and changed to the new data
>> configuration port.
>>
>> The difference from other new port configuration data is that fifo_depth
>> is only specified in fifo-depth in DT.
>>
> 
> In the code below I can see this bit:
> 
>     /* If not specified in DT, defaults to 64 */
>     .fifo_depth     = 64,
> 
> Is that intentional or is it some leftover that was meant to be
> removed before the submission? From s3c64xx_spi_probe() it looks like
> the "fifo-depth" DT property is ignored if .fifo_depth is set in the
> port_config:

fifo-depth in port config is intended for IPs where all their instances
use the same FIFO depth. fifo-depth from DT is ignored because the
compatible knows better than what developers may in DT in this case, it
is intentional.

> 
>     if (sdd->port_conf->fifo_depth)
>         sdd->fifo_depth = sdd->port_conf->fifo_depth;
>     else if (of_property_read_u32(pdev->dev.of_node, "fifo-depth",
> &sdd->fifo_depth))
>         sdd->fifo_depth = FIFO_DEPTH(sdd);
> 
> Btw, wouldn't it be reasonable to flip this probe() code the other way

No, please. IPs that have instances with different FIFO depths shall
rely only on DT to specify their FIFO depths.

Cheers,
ta

