Return-Path: <linux-kernel+bounces-426521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A469DF45F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 02:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEB3B211D4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 01:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA7B665;
	Sun,  1 Dec 2024 01:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6rq2SxE"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7447494;
	Sun,  1 Dec 2024 01:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733017723; cv=none; b=JYZ6hHXJ2fWKb2+h24WxE9y2LNafc9PznJmxyLtXpnd0mSPb1v9yO0/qc3EozGXQmjx0Xea0f54+0LCR2+zkp/WS5YS9Kt9w3ZRuzm5xRd2gtZpXiDCmvtPHEgYnEZpzTPN04DmasYVDb8NsNeamUxi8An+8LUvacdz9ptAD3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733017723; c=relaxed/simple;
	bh=pHfRH4Ecn1vw3+tR8nxlPZC8y7ty2oeAEbB8n+ynOfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw+WyuYNh7nM4snfYj6X8zJlBoFAW8cBZw3oYcPcfIadxLJVjVNvFgi2+WhvyDmEoYnpfZuUPGnhNfw76wDrI8KIt/Qj1imp+q1i/Hj2Cu/UPT0Aki5n7DIAgZjDqHFOq+bknct5SW2znCh7L3CASG4LULmARB0T+E5oh3YEXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6rq2SxE; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724f383c5bfso2293338b3a.1;
        Sat, 30 Nov 2024 17:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733017721; x=1733622521; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=og0xKAxL559d+qRruRz7WQP6LUEOG7PmoTfo4EUcMBE=;
        b=W6rq2SxEK7buYMNuC4JugJuh+AirWpCAMRzgO/RFM0ORofflUAM/uqQB5V93uYsHlW
         TrA5cQIvG4ipIjDKeoBqZ9U3COgsskvs9Z3nCYZ2IHwq4MXRfZ11cGWQatMeiFvv6F+e
         SOl7pXkW+6w7G4Gb+XbnLngtndh9/ggCHKFaxxJQ2qPu8VSuJIzMLkwOHaji1Ku70GYx
         6pk6BS9KHT6Tz6GWpczml9T34qewUcZwQduWlS7oIdPBT4S9uFparIzsIw06/oJLTD4v
         TzZ1+0458SbQH9I6GSqlNfSb0yOuNXXRhfNo3m0r0hDMpW4viAunr3YiU9BViKmUuav1
         G3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733017721; x=1733622521;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=og0xKAxL559d+qRruRz7WQP6LUEOG7PmoTfo4EUcMBE=;
        b=h20peRqYnY6YzKJ7ukuT3r4/urNPo30XDLNEEjJJ7wRaS0Hr8tU5EuFdtlU+bAQ2lK
         znpEB4iLiG0rSqgdOxhPhhrNYj4FEhenKUTnkGXc8rztAt/Ygy4aH+1MZVwjY3PG9c0o
         zvTDyHG+wzvpLWr/liVNib2LlkaS4UQk4llRGRpRb8sr/+EAvL4FhwQRSr9c7JehXuTK
         IDfwvdYZkCpj/084AJozH3qzFhNCEXtHUzplL9maSlqexqyTFajAQUyfQkR84gG1BsAJ
         OZBdzo4MzjEXqYTc0Zgtes9RgfzMVT7mCxAuuatmEh+zJjx+tA84zJ4F5JKcMAa5G+sR
         EPig==
X-Forwarded-Encrypted: i=1; AJvYcCUYH88PeEp0HPsmRJhG1aVicdU5Rum5gUwTPwXVEuuerq7sEw+7GwLewWmmIht9ERBlyDt+rX3O6qlKOPs=@vger.kernel.org, AJvYcCVUoDE44hz2RmmAe+V0CC5owUcpgWL/UsbI/wMy/t4TG1eET6roWGst0T37FVSq3nBDuoJfjK5yOwU=@vger.kernel.org, AJvYcCXoryPp05O6qgMBy0J3iZDU5f/8b5YKiyjTIC1BIdCTVlAPcpXoKSy5Ags7LaFgUvdIejq5YBipSy6hcDrm@vger.kernel.org
X-Gm-Message-State: AOJu0YxExgj2UrVxtFkNhSvxjJ1EzFa4CgCgr2XPYWicenwJI0ExivdB
	EtrJsEbbcdmgPy6tA6geJ0qPcz+NgUqqX3pVF8nECeSP6S6Kt3Lu7ufTqA==
X-Gm-Gg: ASbGnctIiNml/C4dz0O9nK5Nzx9+5JmPgl8AJTyH/SI5HpdZYrHGdv8w4tlWDdgeEmB
	1+1on74Ih5A9dk05G7g+ukgUTXUb+2BfYrHMUylzWK8pWunHC42v6YR4/YSNqQjcD8j3avLf1EU
	RwT5MjFwMNo3NV6jOUj8/b8SKsA7YSOOBR6O5bMjGL3/Nnj8vL5z1xZD6QPf1wt6SLWeXPhOkfH
	iOB5x9dHhL4AkK9Ijco+m4SOlVZG+yOawtTxUrkIDcfXEoOceipNv5/SlE4Gv5k/WmZfV2H7cXG
	eSSQEPzLMBHrFyc6S/Jt25E=
X-Google-Smtp-Source: AGHT+IFxwalVNBSI4x+49VrLerz4nhU+5cgmJA1iPtpB45swsE132SMN6oirGZ9ItFAF4Br9UtgvzA==
X-Received: by 2002:a17:90b:1dc7:b0:2ea:853b:276d with SMTP id 98e67ed59e1d1-2ee08fca57fmr25883558a91.17.1733017720626;
        Sat, 30 Nov 2024 17:48:40 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee45ec551asm4509105a91.16.2024.11.30.17.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 17:48:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64783a84-5f21-4c33-b74b-5e6d79107c33@roeck-us.net>
Date: Sat, 30 Nov 2024 17:48:38 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hwmon: (asus-ec-sensors) add TUF GAMING X670E PLUS
To: Li XingYang <yanhuoguifan@gmail.com>
Cc: eugene.shalygin@gmail.com, corbet@lwn.net, jdelvare@suse.com,
 linux-doc@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <CAB95QAROXwFPZB8gSkz0-thPtuzWkhAHmbqEy2QBg4fMmx7NKQ@mail.gmail.com>
 <20241130144733.51627-1-yanhuoguifan@gmail.com>
 <d8e00909-a946-4ce4-811d-ac968bc54c7b@roeck-us.net>
 <Z0u5QWzWSXGUTUO0@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z0u5QWzWSXGUTUO0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/30/24 17:17, Li XingYang wrote:
[ ... ]
>> Please do not send new revisions of a patch as response of an older
>> series, and please always provide a change log.
>>
> Sorry, I cannot fully understand this meaning.
> Should I use the new version of the patch to reply to the old version of
> the patch instead of responding to the questions raised

If you send new revisions of a patch or patch series as reply to older
versions of that patch series, it may get lost because it is not identified
as updated patch but as reply to an older patch or patch series. Also see
"Explicit In-Reply-To headers" in Documentation/process/submitting-patches.rst

[ ... ]
>> This is an unrelated change. It affects other boards of the same family.
>> It needs to be a separate patch, it needs to be explained, and it needs to
>> get some confirmation that it works on the other boards of the same series.
>>
>> Thanks,
>> Guenter
> I found that in the LibreHardwareMonitor project,
> the registers used by Amd600 to operate FanCPUOpt are described:
> https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/blob/master/LibreHardwareMonitorLib/Hardware/Motherboard/Lpc/EC/EmbeddedController.cs
> BoardFamily.Amd600, new Dictionary<ECSensor, EmbeddedControllerSource>
> {
> { ECSensor.FanCPUOpt,  new EmbeddedControllerSource("CPU Optional Fan", SensorType.Fan, 0x00b0, 2) },
> }
> 
> I think this is suitable for the AMD 600 motherboard, and it does work on my motherboard as well.

That makes sense, but it is still unrelated to this patch and, worse,
not even mentioned in the patch description. See "Separate your changes"
in Documentation/process/submitting-patches.rst.

Guenter


