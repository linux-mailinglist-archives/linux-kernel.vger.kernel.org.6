Return-Path: <linux-kernel+bounces-371205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041629A37EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 940E7282887
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B218C34C;
	Fri, 18 Oct 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HheCNWsE"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530122905
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729238499; cv=none; b=Zz8sSFK+i0qz3O2lUONlp4hwyT5YEp+7EINTCZ+W7muLXAf0AMOC2H/WBTRsmLwKkg2HU7ypTXqBgP0lh++iOFE1fQ6r3F5aYSu8UqGXmdfkpGJDfM+N/sLyO2dysAZ8i9fEGiwSnV04jIrATUlmMw0HTUTM0Cq6V+YzK08oZZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729238499; c=relaxed/simple;
	bh=8ovph5y0A23XzSJBvL9GdMOf0/7jPqTKDtM0IsGcR04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OFSzYAn+zNd7eqEfK5q8dEt65MKkXqw8O4uK4pb9YmCHuAwoyCPwWvPaMoWaAnFtmMSg6MN2VBhk6UuhWAFTjpCizsf9K8zp+HQNZ7V0H6xyxgceDF1tv4OyODY1YANMdy8mgtgQuMHprthaxWWIticZnswxa5i8J+vGUZ6wVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HheCNWsE; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43158625112so16947805e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729238494; x=1729843294; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2lTz8l1UclVPCITrywV/lum/6C9QLLRs5jdJuEPb+bA=;
        b=HheCNWsEEcR2QY+Fns/2oe4lZOjqrKJHVhcOYRx0qRiws67NRgYJPgnK5/3yMuS5ye
         0XlWbiOhFH1jAKEfxhXfHHSSlHa5dxazV5kCdyriQRh/NWND1DX2Sw2wV+1K8I1GtQUn
         n6F8E1hsSt+PYkuZBQX+IJn7P+8YmrNIDAITeo6ivPysrc4mNJpDe6oXZGdMSRSay+Tp
         Bd/wq6SSLS0t2FLBbes8HrRVhSFGR0lNprqTRBN9MPuMDDbsFQwFKNixtkSS7rZPYQTC
         y1uI6spFLwLK00LIlCAF2/yImo9yC0KARnlojp9l5VDxfm5Cy51MxHCwb3WUcepRst/f
         ypsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729238494; x=1729843294;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lTz8l1UclVPCITrywV/lum/6C9QLLRs5jdJuEPb+bA=;
        b=H++FBUkcqPcVPCQC+Pt8T6vDF4lo1hNiqY5m1ieZmkjPavggQpc6M4YeQ2AYbbvRXM
         62ZK6Kq0wwLa8E55BkDe57tLTwWQCnGQAgqjn7HB2eHzQsSl2x7n8Sb5Z6vJZ1TEk7AE
         H8GQSx4aTeAsB3lzQlyqQyYZGO4N82RYrS2LO2foN97csABgBiEemNmVGWcm31+v+cPu
         q5kKYQLl+b7RW8YLPqXmKOtxB6a0iLr9fVjakvU7PB4GrHnPmxqKjnmqz3bdxKrqzBL0
         c5br/Bb4/05WDjS3UqQRFYKsw8D4peTjBaGrRqXbl97EGiONxE2sr/M4L0cijVYEFDxg
         E6kg==
X-Forwarded-Encrypted: i=1; AJvYcCUFiAoomxpHX5UdWonwU+ocrBcmsygh91pDBVUFyIy27UNpEbuxXqvuEBsB/vgCKpFhvy5kdL/vKCnm8bY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAC6ZBCdW+yisVz3CnRFOvPJQZ6MxUviiwZNzoYYqTiLJMZM29
	gKZeDjeuH6JaNiC+0KRsv7mSLgw4lzu3/ml0nx1+lnZIuFqkFvIjTYEATHktGig=
X-Google-Smtp-Source: AGHT+IGDkXmRRBnRxsp9c/nQ3lTWNTikvHm0j5gHCsEnCHiP+nAyR9HIQRd+8X3xc+5htjMP6BRC9Q==
X-Received: by 2002:a5d:4e49:0:b0:37d:3301:9891 with SMTP id ffacd0b85a97d-37ea2164d8bmr1069922f8f.17.1729238494519;
        Fri, 18 Oct 2024 01:01:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:83e:5234:8493:ff24? ([2a05:6e02:10a5:e010:83e:5234:8493:ff24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf140718sm1212564f8f.112.2024.10.18.01.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 01:01:34 -0700 (PDT)
Message-ID: <f1035052-f35f-426c-862b-72401f3cd23c@baylibre.com>
Date: Fri, 18 Oct 2024 10:01:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] irqchip: Kconfig: Added module build support for
 the TI interrupt aggregator
To: Andrew Davis <afd@ti.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vishalm@ti.com, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kevin Hilman <khilman@baylibre.com>, Nicolas Frayer <nfrayer@baylibre.com>
References: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
 <20241016-timodules-v3-2-fa71091ade98@baylibre.com>
 <0c2ae869-d04f-481d-b770-ec54f4d2e658@ti.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <0c2ae869-d04f-481d-b770-ec54f4d2e658@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 16/10/2024 à 15:48, Andrew Davis a écrit :
> On 10/16/24 4:41 AM, Guillaume La Roque wrote:
>> From: Nicolas Frayer <nfrayer@baylibre.com>
>>
>> Added module build support in Kconfig for the TI SCI interrupt 
>> aggregator
>> driver. The driver's default build is built-in and it also depends on
>> ARCH_K3 as the driver uses some 64 bit ops and should only be built
>> for 64 bit platforms.
>>
>> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   arch/arm64/Kconfig.platforms      | 1 -
>>   drivers/irqchip/Kconfig           | 5 +++--
>>   drivers/irqchip/irq-ti-sci-inta.c | 1 +
>>   3 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> index 393845a3ae5c..9dea47decfbd 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -135,7 +135,6 @@ config ARCH_K3
>>       select SOC_TI
>>       select TI_MESSAGE_MANAGER
>>       select TI_SCI_PROTOCOL
>> -    select TI_SCI_INTA_IRQCHIP
>>       select TI_K3_SOCINFO
>>       help
>>         This enables support for Texas Instruments' K3 multicore SoC
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index a958731404e9..9646322345e4 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -544,10 +544,11 @@ config TI_SCI_INTR_IRQCHIP
>>         TI System Controller, say Y here. Otherwise, say N.
>>     config TI_SCI_INTA_IRQCHIP
>> -    bool
>> -    depends on TI_SCI_PROTOCOL
>> +    tristate "TI SCI INTA Interrupt Controller"
>> +    depends on ARCH_K3 && TI_SCI_PROTOCOL
>
> You can still compile test, just gate it on 64BIT (or ARM64 if those
> 64bit ops are only available on ARM64).
>
> depends on ARCH_K3 || (COMPILE_TEST && ARM64)
>
> BTW, the last time this was posted the feedback was that if this
> was compiled as a module we might have issues with dependent drivers
> not having this IRQ ready as it may be loaded later. I think this
> would only cause probe defers if the drivers are well behaving, but
> something to double check.


we already use this patch in android kernel mainline and 6.6 without 
issue to load all drivers.

i will try with your yocto sdk before post v4 to confirm it's still OK.

Guillaume

>
> Andrew
>
>>       select IRQ_DOMAIN_HIERARCHY
>>       select TI_SCI_INTA_MSI_DOMAIN
>> +    default ARCH_K3
>>       help
>>         This enables the irqchip driver support for K3 Interrupt 
>> aggregator
>>         over TI System Control Interface available on some new TI's 
>> SoCs.
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c 
>> b/drivers/irqchip/irq-ti-sci-inta.c
>> index b83f5cbab123..a887efba262c 100644
>> --- a/drivers/irqchip/irq-ti-sci-inta.c
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -743,3 +743,4 @@ 
>> module_platform_driver(ti_sci_inta_irq_domain_driver);
>>     MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
>>   MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI 
>> protocol");
>> +MODULE_LICENSE("GPL");
>>


