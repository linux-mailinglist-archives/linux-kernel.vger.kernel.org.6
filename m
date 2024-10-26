Return-Path: <linux-kernel+bounces-383301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4DD9B19BF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 18:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B81B215F2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A801386B4;
	Sat, 26 Oct 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvHrisCF"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8711C683;
	Sat, 26 Oct 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729959571; cv=none; b=DtmyG6GDKqaaXGudXOKYwCtU20o7uL+n1tsgqc4NRxNtYTE3aBSiU5WJZ51ugfoLTB2hInmCaf4xEdvOQblUoMv+EQWkUMX5il/TQadWq0bK8Hs2qoeRHCmp55I1xQ/yDLwryYRBEdTeKMEdvtJcl3GKbWi3/ZlWyguCgGhreKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729959571; c=relaxed/simple;
	bh=6WXSbDd8/2iqGUxHI6IagOpABfD2dhVATMNxOgLfm5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJXA4ekMc0UFFbHZYlUXc8Um25WEJ7AB1EW3NDDVTAsV//qEGHYuggxhC2xrC9uFyGtUiOXrwrLFk2HOJUDYs46NTxVlJU2A6BjVDza7JRBBR/LLseGPaQPNOkoKkdx+jGy3krhmfWHh3/2nS5Wg7DBwJbQHA9yDFQ8nI2D9gFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvHrisCF; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e34a089cd3so2398136a91.3;
        Sat, 26 Oct 2024 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729959568; x=1730564368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=d27LVMRC35Im6Du3NXlx1OnGlU4pZy04qYszTFFJ5FY=;
        b=BvHrisCFEhBo4yhgXkbgQG30VWSb1kFnU/2dGB9Ugr1P8XM6B1nrW0KCPFfYxv2bOY
         7EItsPKE6s9GUK7mrODATSRcMObV0frJiFPAFbeubNRFUlJHgK6J21s7JzRaVoLTLj6a
         4CxndCTVy/KjoJWhoBV6EsRXxgRlFFmSc1H+r4ti3aXH//0DTQnwBHfUDsMhw3CZbqKn
         SSYnS/1VomsZRB5BMKH6fr66xFIcVvlHHpniWj70ZL4gRAF9HFkg1t6p2fKnRR7ZVwma
         2YiqRqtHoUIBDdOdmCZqQVBHwT7gY9U8FUgzjVqWlT4WiOhel92+6EyR30u4pWPcd4xn
         LuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729959568; x=1730564368;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d27LVMRC35Im6Du3NXlx1OnGlU4pZy04qYszTFFJ5FY=;
        b=jNlzZxw7GnxzNyXaNi4Z2mHvJ7cxf9cB/G8hNWzuTYMeDHD4X+poa1Wf+Os3g0wjeK
         DWE21AIeJ65xLS65rkaxAhXdhjRox47Bpk9+NFLapwOFIj8FuI/FyUXOs58Pn2E8o5th
         Q+HFa9+uxix5cSWJ/T7Q5n+4rrKef9Zv2/PjT791eDe6fnP1p61SPqk49JzpJx5lrHHg
         9byEsE2WB9Uj2aVx9SPsXHLa/VEYuU515EQnYa9arYQ8vBMDKQApVxUj8/uL9O0gk45P
         4IX9FycQSc1TGjDmEX2+FDSb0YEvIIgafIFKtnHXzgxUvlA+QsiTqt7yOk5f5SOYf0iz
         PHaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZ5wb9qksZ0pBVsmc9X96K5mjGk+V6IMfZjH/CWKvZV9Ay/lwrDBix2bpZgmaMDYgRRqaHSOI4sCLH@vger.kernel.org, AJvYcCWKoH0pxahaeae86tWJYhT+FyAWAPuKg5OookO6UFTO9fEfwclg6wzXEgySEOvuGEWcFRmDfukoqVDWUpW5@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ip2W3d2UXvfWJ+zxpCs1kecPpbhWlqVtfhg1BxdW0qcFcO3C
	BPFW2bGYjZe0SNH2I06luGGhup/gQlBHhsXWMrIOU2mPqb+qKbZIaRQscA==
X-Google-Smtp-Source: AGHT+IGJiShM1/KWt0cQM6SdXIbLRnOZleVf2DVbook1H2awWBcFOJ9WNQiflG7kRve48QCuQBTbog==
X-Received: by 2002:a17:90a:7c06:b0:2e2:a828:2982 with SMTP id 98e67ed59e1d1-2e8f11ba073mr3921571a91.38.1729959567795;
        Sat, 26 Oct 2024 09:19:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e573421sm5647615a91.42.2024.10.26.09.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2024 09:19:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <baf87ae4-b9fe-4b6f-b4bb-16fb66492224@roeck-us.net>
Date: Sat, 26 Oct 2024 09:19:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hwmon: (pwm-fan) add option to leave fan on
 shutdown
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
References: <20241026080535.444903-1-akinobu.mita@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241026080535.444903-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/26/24 01:05, Akinobu Mita wrote:
> I sent these patches a long time ago, but I didn't cc them to the DT list,
> so the DT bindings changes weren't reviewed.
> 
> There have been a lot of changes to pwm-fan since then, and I've updated
> the patch, so please review again.
> 

What changed ? Where is the change log ?

Guenter

> Akinobu Mita (2):
>    hwmon: (pwm-fan) add option to leave fan on shutdown
>    dt-bindings: hwmon: pwm-fan: add retain-state-shutdown property
> 
>   Documentation/devicetree/bindings/hwmon/pwm-fan.yaml | 4 ++++
>   drivers/hwmon/pwm-fan.c                              | 6 +++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 


