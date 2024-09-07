Return-Path: <linux-kernel+bounces-319802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DAE97026A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 15:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CEE1B22A7F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 13:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8982515CD42;
	Sat,  7 Sep 2024 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxdBIR/g"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6FF15884A;
	Sat,  7 Sep 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725716205; cv=none; b=rpkdsIWeQbxcVToa7xTcmAsScLSjeprlkCdhjkVtmwfD/Sboovhi1wUNUj1ywzQql8dOSQKUWuIu/0hxRQ/sYlP7MIaLPoDPBjreM+74AIjKGg67JGzuqoSSogfaD+J+2TEsh1QDAefudy84admTvx424G8ws6NplORUuW6UXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725716205; c=relaxed/simple;
	bh=QDAeMKDXx+8hSe+M0x6iS7yh4oBXpRy19ch8PrVqUUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3Jual4//VbrmzwR8zk1x+E36yaXYZz9wSWoTb8oghwyAs58/nPnoRT7oC01X624MrIqg40lUu6/WbQr6OkZ1YwUZB0bOSSLgAkmiOf0P+KYgR5lMzWpFFR5wU0UHvYwD/4PjT/4JEQ67HeDcQrRBgCrk7QUrANjeJLYCU4fZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxdBIR/g; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d873dc644dso2195863a91.3;
        Sat, 07 Sep 2024 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725716202; x=1726321002; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUTavBQ5qrHlQPm4dvfhw3yJpsNd8pyOFUFPgqrOJVE=;
        b=lxdBIR/gHrT6/47FnqnBS1210EFMhPL9wLE1Wgql589fQ5/S3Q34YMt5R76a0TmLcK
         hRp2gCeK9bjAqPH59yHfgF07xLkQcfqU7nsOmoHZRTm1j/pkgSi6HUaziCJCqWeCb9y6
         54bpVM80DdncokM3egUXsQwMJqrK7ICQgg3iyE6HZjsZTmMMbcyazO6Vd5R8mL+OE9S3
         lUQ25WZKOV4rsSMBOqijhiV+12dsDSD0vT1v8INxxM/RODwJz5beAZvdOIYix6n2HR6k
         ozZx0NZv4gJ+pyzvv6vzCgde6IHpBGrOEC2ab/ULTB/M5pzj+Dc478WKedExpsS806CK
         CcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725716202; x=1726321002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUTavBQ5qrHlQPm4dvfhw3yJpsNd8pyOFUFPgqrOJVE=;
        b=wGT+8E1K1bETru4FL/1S/JFotOXroaiNwbAbZERTABHdSay8e63THTnSldI60JQV/g
         yn4SFpDzzIrp2QuK7aRU2yZUqwgYRGsSinGJ/XmBjfj0jjU0wg0gK7REcIIhd1RELlen
         9/2Z8AEzSlhudyJW7Mewgwkc1S7RgKzZEc8X/80drmIC4EnZIn37zOyjG4tTYzIPdK5f
         AR5Z/yhi3A4VH2rcu07qTiDJYg9K9CbNFe25OaLVr0s3B5subIE9suGtezNhWzzQCjm2
         6xtkmPMl0A1CLZJ/CDSBe7mxx2v39el6VuzjUDWRSV63w4WPs+gUO0x1MOcTL1/Fp9qe
         LOwA==
X-Forwarded-Encrypted: i=1; AJvYcCULpP3BJRQCBsWdaqVvACkeOxAsgJTq+He5eebPeRFosBEb9xwt/hZtMSBZtLssUnGQhZkWNWzV3eXoLL0k@vger.kernel.org, AJvYcCWyzG/fdNVpTXDrvieM+N6KzSPWD9fAqQPr9NX7dissxpRY/ZGLajDSfv9W8CuHSHr+9BxH9sWc9SwF9b6yFVg4mDY=@vger.kernel.org, AJvYcCXS6aMOL1kIFFFrktzDD3Vbgmp+qqhL3NQHSa9FHLde0C414ligaCir0DxLM/wFyodLIneUcocP3lktSXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmua+y+BUusUGIuZcbGpaqiE8BVSFq+H5vKX0Weu4xd+eNNFNj
	AA1qsWPjxQv9M5PpjtjTwkHMKDd1biWHnicXeJBq2RAuoN9KEz9hu3UdUG0Uvw8=
X-Google-Smtp-Source: AGHT+IHDd6iQwUYAcG/97d9xepIXpXTiP9NBsHNofcF74jxr+3FjbR3kilNRA1s6jBVgx9qHN1vkwg==
X-Received: by 2002:a17:90b:4b4a:b0:2d8:d098:4f31 with SMTP id 98e67ed59e1d1-2dafcf1c7f5mr2670367a91.17.1725716201718;
        Sat, 07 Sep 2024 06:36:41 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db04136b71sm1251865a91.12.2024.09.07.06.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2024 06:36:41 -0700 (PDT)
Message-ID: <d5d06aaa-ab93-47c3-b7c5-ad8dd3ca66f2@gmail.com>
Date: Sat, 7 Sep 2024 21:36:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tty: serial: samsung: Fix serial rx on Apple A7-A9
 SoCs
Content-Language: en-MW
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: asahi@lists.linux.dev
References: <20240907111431.2970-1-towinchenmi@gmail.com>
 <20240907111431.2970-3-towinchenmi@gmail.com>
 <3596ef82-b2a4-40a0-8a66-575e26c386d9@kernel.org>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <3596ef82-b2a4-40a0-8a66-575e26c386d9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/9/2024 20:55, Krzysztof Kozlowski wrote:
> On 07/09/2024 13:06, Nick Chan wrote:
>>  
>> diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
>> index 1672cf0810ef..849d502d348d 100644
>> --- a/include/linux/serial_s3c.h
>> +++ b/include/linux/serial_s3c.h
>> @@ -246,24 +246,28 @@
>>  				 S5PV210_UFCON_TXTRIG4 |	\
>>  				 S5PV210_UFCON_RXTRIG4)
>>  
>> -#define APPLE_S5L_UCON_RXTO_ENA		9
>> -#define APPLE_S5L_UCON_RXTHRESH_ENA	12
>> -#define APPLE_S5L_UCON_TXTHRESH_ENA	13
>> -#define APPLE_S5L_UCON_RXTO_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_ENA)
>> -#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
>> -#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK	(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_RXTO_ENA			9
>> +#define APPLE_S5L_UCON_RXTO_LEGACY_ENA		11
>> +#define APPLE_S5L_UCON_RXTHRESH_ENA		12
>> +#define APPLE_S5L_UCON_TXTHRESH_ENA		13
>> +#define APPLE_S5L_UCON_RXTO_ENA_MSK		(1 << APPLE_S5L_UCON_RXTO_ENA)
>> +#define APPLE_S5L_UCON_RXTO_LEGACY_ENA_MSK	(1 << APPLE_S5L_UCON_RXTO_LEGACY_ENA)
>> +#define APPLE_S5L_UCON_RXTHRESH_ENA_MSK		(1 << APPLE_S5L_UCON_RXTHRESH_ENA)
>> +#define APPLE_S5L_UCON_TXTHRESH_ENA_MSK		(1 << APPLE_S5L_UCON_TXTHRESH_ENA)
> 
> Use BIT() for new entries. You can also convert the earlier defines to
> BIT() in separate patches.
Acked. Version 2 will change APPLE_S5L_* entries to use BIT(), and then
add the new
entries with BIT().

> 
>>  
> 
> Best regards,
> Krzysztof
> 

Nick Chan

