Return-Path: <linux-kernel+bounces-282057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F9594DF3C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 01:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DCB1C20B40
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12445143883;
	Sat, 10 Aug 2024 23:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dui8VF4r"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F0B1370;
	Sat, 10 Aug 2024 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723332213; cv=none; b=Hv5XVeeU49ATZjAaFJV7oztYh72dgz2G9k68xr80Jf6Hf+ocZ/w8IS3n7Dps+aq3m8UH8gb3IpObJxlXKKtIxzzVcl5TXTJuuFsMi8sKXkb8FvWJoib0xLTYKflh0oZ2GS1HLR6v+VweyzLb9z56qbnCR2H1S5CAAA4ZoA84h9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723332213; c=relaxed/simple;
	bh=8x/4BAzgBy+Z525erO8Dx6lrQPJUvjoVl/OBSwO84G0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwNPNCMlmXc9JSWfrYH5ggCSB6FerCxLF/Ibhmh0ck1J9e0GreWu2ns7XyqgZOTFo6C1kNMhPS/zXCkDvQBopFmthJuB/dTl9Z3us3KK1avCAPJPDVw2FDEbBrNTqamo0kR8Qmjz+nDxDSXFvaJHh36udfqG2kv/02OlPVpBwgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dui8VF4r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ad02501c3so406606266b.2;
        Sat, 10 Aug 2024 16:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723332209; x=1723937009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=maa/cnPjxVZZnXA/kZaSCf1M+tAAW9uKRTzieR0VU8U=;
        b=Dui8VF4rBPYVf8gR5lxVAVe38PO3qLwubqftwdCUGVBhx3u7cs3LY5DV8y7Rieq/YF
         ZqwA/zBRtEkjBsP0dbv41kpT1Ni7zAY/zkKnK1fNt9oo/4k5/bNbEh1bd7KxyamsF5pG
         uEWyyDmFnTi8H3JpROF3XF1l08qRL+cZ0hOwdxkTzqns9TtuBiiNvc5uRR7rdS+JlNFx
         aZaHijMlq2FM3F+vaPOFlS8yME67869KkjMXxLcxoBO1LEAd9eblocLBwl5eLzRFuNO3
         FUywaIptbLHSpBo2E3y9EWNJd9Ti36P6HSof+nwkQ5AtBYvpsXQcmbATOZ+uVIwniVs3
         3OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723332209; x=1723937009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=maa/cnPjxVZZnXA/kZaSCf1M+tAAW9uKRTzieR0VU8U=;
        b=UVF69vNINqrPxLwuo8b47mKzyhTBHVOMZexXt+hvtBO4s1NjJjwyrHnaayrZy0JjJC
         cst4m6P5piP3iZ2NhlbNK3TJJoXW/bRJ17P2JHt4O0mwD1U6XsYNpg/o0Ro2NVA+YRa/
         VnHs5DT2JiksxtVXbfXnzS14j4pY+3uNRp3TYR0JPEu/oTMqPvIkONRgD3qVSNJwPcEw
         zDSnB3sSjDta5YUieUVmjWE2XpCoCFrtVxTpJmqetem07ga07x9C+ARffVuOD8W5gBTU
         f/84yuugNKFbmCKnC6gPx6+7iSkGNDprsnXbEkMzQ99/XXEVLrQ1DmCtYSclqBElZWAQ
         yuQA==
X-Forwarded-Encrypted: i=1; AJvYcCWyan5Ncl2+P7Ib0vV+ka8z5systXVWZHuZdYe6pS84nsRARea/BmR9jEj2OMqFfWFWmBNdyiD59GgmoT4lRvraD/xkRWWaDqE7jVwwCdszYBysrOqOukauGrQNitHTCdyZi0AWdQkiouQ=
X-Gm-Message-State: AOJu0YynEuH+4YmOQfFYG2HT2fzjQE5omWDTEUp07DuDlqqLM+EMIti+
	EHJ9hT1k+c2bscD9JXcyuIbgRq0cH1nncAVgV2101/Dx9lVFtfP9
X-Google-Smtp-Source: AGHT+IGPnLj7xdNXn21eaH4JRwopcpgOSWElYWSTAV0U5hGmGZW9t2N4bG12G2mbEGMH7Te+sWXY6A==
X-Received: by 2002:a17:907:802:b0:a7a:9ca6:524 with SMTP id a640c23a62f3a-a80aa55a33fmr474255966b.14.1723332208783;
        Sat, 10 Aug 2024 16:23:28 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb2437bcsm102710666b.209.2024.08.10.16.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Aug 2024 16:23:28 -0700 (PDT)
Message-ID: <5fe4c524-ced6-4666-b8fe-ab95c8d1cff1@gmail.com>
Date: Sun, 11 Aug 2024 01:23:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hwmon: Add thermal sensor driver for Surface
 Aggregator Module
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, Hans de Goede <hdegoede@redhat.com>,
 Ivor Wanders <ivor@iwanders.net>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240810214748.425520-1-luzmaximilian@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20240810214748.425520-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/10/24 11:47 PM, Maximilian Luz wrote:

[...]

> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index e4d9a035a57a..5ac9ce8fa0a9 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -2080,6 +2080,17 @@ config SENSORS_SURFACE_FAN
>   
>   	  Select M or Y here, if you want to be able to read the fan's speed.
>   
> +config SENSORS_SURFACE_TEMP
> +	tristate "Microsoft Surface Thermal Sensor Driver"
> +	depends on SURFACE_AGGREGATOR
> +	select SURFACE_AGGREGATOR_BUS

It seems that for some reason, this creates a recurrence in Kconfig. I should
have properly build-tested this before sending it in, sorry. I'll switch to
"depends on" for now as there seem to be more changes required to make
"select" work.

Best regards,
Max

