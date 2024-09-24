Return-Path: <linux-kernel+bounces-337237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C398475D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BCCD1F25AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867BD1A7ADD;
	Tue, 24 Sep 2024 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5lXrRy2"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681381B85D5;
	Tue, 24 Sep 2024 14:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727187170; cv=none; b=imPY8T3C2cR/oCjLvacQ7AHxAfi+Wtr0krdjgMYtcVhU7OenXusnU3jJEFfwxbSfB9l/ThWBcF2jHUF+zb0ksXnAIsE2d2uXmc4qfFTHy4P3HRStiFQSRcbzwBddwXXAuIpJ8PBPMrqoU06CmjObpSmTtwv1UCh6eKjEbqGbYN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727187170; c=relaxed/simple;
	bh=xyfowOHiEDqCfBloZHe3hwp/gEHjhYwjqE4eiXF9ORc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViPeW6krp8p6ErxpOPOU04XGVWLWLxpvJ8fJbzzUAhr7nwRE4IiukXhIUGf55jcKbVFPKk56cTk8pgOg43J/8KheinAPZJjZuv2u/NX9v8vvWxk0mc0E48Cx1+PKcGus4P8lNNSlN9ADRxko7mfh7547mwyZXp+5usAzoF3DeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5lXrRy2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2053a0bd0a6so55710275ad.3;
        Tue, 24 Sep 2024 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727187169; x=1727791969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bPbiRFS9zXZwC8VbAnxGDNIDjjRTnnzFjhlcu1Cr8wk=;
        b=G5lXrRy2GPy9ThQyooLsF9xzQNwXFDLq0COFkXPo4l0DdTxv0yeziHT2ZetSzYstc6
         A/pf5sP7kvnliqsQ4Au9gOaqyYVzIPOdRmFxDr+C+lTdoYER2QuKVq2SeoNukdisxK4N
         k0X/8kbKcAZocKCGdupfCrZ/LeOYs4cO8GrXPmGtld2OMa24mjknTkcjdPsDW2O7Y2Qy
         ubCPm76B9spkNw0MP7O6IId9SM+ebebQ2LD+lH/9UGSTh+NwsS6E1s7QzKpkGxdFGsHu
         T0D1rpJJ8QLxuyCiyk+sGADqUVRNOACUtTJmBf001CHLlIaHw8VNJtxRYAo37U2o4eR3
         DqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727187169; x=1727791969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPbiRFS9zXZwC8VbAnxGDNIDjjRTnnzFjhlcu1Cr8wk=;
        b=sq4PeoiJMZC/Skr8cVC4ebi4Q9TqDT767qYrXGNHsgYoElBG2bok2jziSlIgfYA9eq
         AZcSrd62F0yKXa0++70DDjOgk31APk/4hVc1IjAGoqqLRic+waLKijDI66CWhYXCCm1q
         0kF3h37W3AdYnMSwK0wGN9RF+z1bCN3CbP3MU+XsYNmXGiwO9k36LT2gNXqGeBeD7CQo
         KMLy8uj6QrG4BKGmPd7Fv5KcBPxfGgfPSt0TIe9IlSQHTYPCZTwDbH9ADSimWUWWTgay
         5YXY83TOzbdcJaOYs4Mducd7Sd6KB3nwOGN22WY1HucGo7m4EpY81KXop/qt82ey/ewN
         c2tg==
X-Forwarded-Encrypted: i=1; AJvYcCVK+QNMO+t152RYWyDETiruk2540ljG2APdzCeAS9frFAoUP8bWTW+szz92ThnkGTVS/c6QL04lYM9JUAwi@vger.kernel.org, AJvYcCXUOIOMozEC2O12ZF2GII8WEzk3b9Na5+6H2eVc8hTcIaLgNz6BJQZPwFlvmv4VfGm+Ym5txq5dW9qluw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeaqC4v8te9Mfc3mSnP4+hR/maYTMiP4KGAxqE5O9600MhyBe7
	6Ey8jrxq5+108Hj7ILFWe0rOK6+rDfZ4H12g9wquJgHg8FPaKdjA
X-Google-Smtp-Source: AGHT+IEbbHpOG5yBupGAdt2U5c12BJH85FyBrYiHr+9w0lrMO3yW4EUcFfBJ0TRpOHUzor8H4lmVhQ==
X-Received: by 2002:a17:903:2341:b0:202:3a78:5d8a with SMTP id d9443c01a7336-208d8306edbmr207583365ad.8.1727187168563;
        Tue, 24 Sep 2024 07:12:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20af1857fb9sm10824265ad.271.2024.09.24.07.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:12:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0aaed899-9001-4355-bcca-17855576a928@roeck-us.net>
Date: Tue, 24 Sep 2024 07:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (max6639) : Add DT support
To: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240628115451.4169902-1-naresh.solanki@9elements.com>
 <349543e5-21b2-4725-9b33-1fcb4ae124f6@roeck-us.net>
 <CABqG17hpqFG-PeyENXnGn9k7V2goBP+k6BtSURoMM7DgXtxWmA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABqG17hpqFG-PeyENXnGn9k7V2goBP+k6BtSURoMM7DgXtxWmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/24 02:29, Naresh Solanki wrote:
> Hi Guenter,
> 
> Sorry for the late reply,
> 
> On Fri, 28 Jun 2024 at 20:30, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/28/24 04:54, Naresh Solanki wrote:
>>> Remove platform data & add devicetree support.
>>>
>>
>> Unless I am missing something, this doesn't just add devicetree support,
>> it actually _mandates_ devicetree support. There are no defaults.
>> That is not acceptable.
> I agree with you. It is best to have some defaults & then overwrite
> based on DT properties.
> But in that case we would have to assume that all fans are enabled
> irrespective of their hardware connections in the schematics(example
> fan_enable).
> 
> I'm not sure if that is fine. But if you feel that is alright then
> I'll rewrite the driver to assume
> everything is enabled with default values.

That would still be a functional change, or am I missing something ?
It would overwrite any configuration written by a BIOS/ROMMON.

Guenter


