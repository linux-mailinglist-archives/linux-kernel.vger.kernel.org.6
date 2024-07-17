Return-Path: <linux-kernel+bounces-254826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27207933839
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 09:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EB7B20E1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 07:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD01CF8A;
	Wed, 17 Jul 2024 07:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="d6dtaHYJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741FD1CAB9
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721202470; cv=none; b=VMSdkvAf8KMoloq1tDrgVhMDVKLusJ0bNvZnt0RizzS54fpHClVrS/wGfCYVcsE0xvaBrDt/jcoceNAKHr2v2q2bRZL8OaQD5bUkxfiT7VFmNT/kWuo8P0DNXvY0zUXR9koI13RHSRytrsbSWm+C9UTv7TpQE8v2c/HjRt0+Uj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721202470; c=relaxed/simple;
	bh=DqERjfqol+hKxZVExBS4af6VbJF00Z/314k2yNE8fOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AHmMFWt2vnvi6cHp+bWTXm53ODkO+1+GiFuXV0yNoQ7xWS/uybgCOm56Pt4fDEZ+rCTMnGnoUsinaxdfEjprWykVvKg/ojUSu8zKexP74PvcLggAYxm+DfVG+j+H0jNBgTjDpgMvR2ZJ+XVzynErGgL6iZBiYO2mDxLMW2EjJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=d6dtaHYJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f535e82so44268175e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1721202467; x=1721807267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvQ7mUcEDAkd5SXE13W2JsLBSq8CV9Djj3677zFvYx4=;
        b=d6dtaHYJDruA0yJnEx6uLb/H9NVzERAS4Dmr85qHL9YeEN1J1zY227+X+Rrxo5MSHV
         YLxCmNfORxuXDfcE+nbsJBdIe531IFk9pQRAT8A1uhUZieGdVLAKlbUuC4BFvjTWmj9b
         jT7wdOBvMnzry0UkcP1AsmqhV2m94i+uqUTvakcPyKWgvUB0GNrKV0cfB/U5Bq2MClKY
         st4571GR0OuInyMNGiFuqswXNxF4VwSLR5Ok78+qVl0MW9SfpsgmKWq/5qonmSJfnKPr
         9VAESMebyXbs1MhWeNjOmUeBBjSHnSyYHnlbjdPhp/k/LIvg53m9b721MuDK7KrxcKo6
         L+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721202467; x=1721807267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvQ7mUcEDAkd5SXE13W2JsLBSq8CV9Djj3677zFvYx4=;
        b=Kj26RV5ptmFSfJFAsRnugafqB/tvjyopHXgP4nLMi/YtNytWJ0ikvpIOjivAEtjF9B
         ZwpGEbtZzm2UnqAAyccg+FPX6Bx6gkn5QiITPFFGUuwjsNnHWHI5t7eRUnCOP4XeTanc
         ETxHcpNuFJeg3ZPFyj11Gr7n9lyTNXKvBeeQVo6ozXQs3YOLso+MGTu6ExMW+zrAOS91
         lHyq7YgbCXwy0jVC+4xcyYRl6dSNn4GTILfh33RLbSNcu5x5NZ8rgkZXXTUiyQMYn3fr
         87/oxxyW5Y/KkFNAW8FyvS0ls1qGFt7bgaC+5Q/VQ1s9Q3E2q8a0X3oFXUmQcKh7POLR
         Wzow==
X-Forwarded-Encrypted: i=1; AJvYcCU+4v/YDF9PqTM2+bSCmcwBwuf2z2i87vKKc72vuelFEcEV3Z3EvLN1Ipu9JYEEsTTHrtY2ep6vo122f4dpx2RKHX/Id8cgKJnbBTJK
X-Gm-Message-State: AOJu0YzoNo2UtwzHv1OD7zMNqdXxx8zraZmQ1Rj7BHB51cjJR3T8NQ5Z
	N074hyaOM57/14jmB9ChKZV+oR8cpWSjYmxAWM6SkgXm5n1L+BgH0XymQqnRVC4=
X-Google-Smtp-Source: AGHT+IEGuVvZ44case4QSyMvRj6cX5xkzPcx+lS4rYQA4fq/bF4ojc304lVV4+Qj7wTa26bO8bS1UA==
X-Received: by 2002:a05:600c:1d8c:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-427c2cbdd5fmr7701125e9.21.1721202466683;
        Wed, 17 Jul 2024 00:47:46 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a5e9a809sm160194035e9.28.2024.07.17.00.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 00:47:46 -0700 (PDT)
Message-ID: <7d99171f-746c-4eea-bf3e-d8f3954e4d8f@tuxon.dev>
Date: Wed, 17 Jul 2024 10:47:45 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] mfd: renesas-vbattb: Add a MFD driver for the
 Renesas VBATTB IP
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, lee@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, alexandre.belloni@bootlin.com,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240716103025.1198495-1-claudiu.beznea.uj@bp.renesas.com>
 <20240716103025.1198495-3-claudiu.beznea.uj@bp.renesas.com>
 <b7457ae3-b8f3-4b16-9a21-090d99a97e48@kernel.org>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b7457ae3-b8f3-4b16-9a21-090d99a97e48@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Krzysztof,

On 16.07.2024 22:29, Krzysztof Kozlowski wrote:
> On 16/07/2024 12:30, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Renesas VBATTB IP has logic to control the RTC clock, tamper detection
>> and a small 128B memory. Add a MFD driver to do the basic initialization
>> of the VBATTB IP for the inner components to work.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
> 
> 
>> +
>> +static struct platform_driver vbattb_driver = {
>> +	.probe = vbattb_probe,
>> +	.remove_new = vbattb_remove,
>> +	.driver = {
>> +		.name = "renesas-vbattb",
>> +		.of_match_table = vbattb_match,
>> +	},
>> +};
>> +module_platform_driver(vbattb_driver);
>> +
>> +MODULE_ALIAS("platform:renesas-vbattb");
> 
> You should not need MODULE_ALIAS() in normal cases. If you need it,
> usually it means your device ID table is wrong (e.g. misses either
> entries or MODULE_DEVICE_TABLE()). MODULE_ALIAS() is not a substitute
> for incomplete ID table.

It's not needed. I took another driver as reference and missed to removed
it from here in the end.

Thank  you for your review,
Claudiu Beznea


> 
> 
>> +MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
>> +MODULE_DESCRIPTION("Renesas VBATTB driver");
>> +MODULE_LICENSE("GPL");
> 
> Best regards,
> Krzysztof
> 

