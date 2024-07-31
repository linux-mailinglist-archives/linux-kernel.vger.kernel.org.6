Return-Path: <linux-kernel+bounces-268960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F1942BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2A1F21B3F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D1A1AAE20;
	Wed, 31 Jul 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z35eQKaE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22DD1A8C0B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722420513; cv=none; b=c5016vwKA6NbOmpJ1t7kA18zIE4EwqZmH3xVuvYLDyGA3TRPBy+DBOz2NI7ncABq9qeGNsxBFtHLfjawvOwgzLHLwAbKSWLICWnDRTCDvjy9jNYaONR6wCCGhiuM1k4tkTSNT5xb7udEu+MIoxM69RNFiIDSyI2nABFTyLl7BRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722420513; c=relaxed/simple;
	bh=VfhxbFRl+BG/Sa7wjKV+KHziPw2TtlYFc7Jr7qm3zHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/tVJ8obINWf5coAHqAocjAvVbUu+B9dDGezc2QeuR7vmR60BhAWUu0nqgbi2V/2RGAWnwH68SiU2d/bb3ggQ3cSiZT2TV05ppiHC0flAyoAvywFBKJsBEkdPjntlRpGbck7sqZOHy2dNoVG674LogaEHd0ALm0w8vGEPzn4NG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z35eQKaE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so8348625e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722420510; x=1723025310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w5C3Fs7RfQOfTL3CPVuKhp+TlqAOyBUF7xiHspn7ajk=;
        b=Z35eQKaEIXkRtRA7xlPeu3AetU/VmCstZYLQd0Mha2koB6UwJs35n+dIrYPho5xgEw
         BCi17nmPm9S+98ZpXyUlH30ckw6M1Cm3I2kbsJ8TajMeMY7xReeF+CjyB5Up1QJvdXnL
         fPapuu0uQtITbXVgff+p84illW/Q/wOety3MXFRdJDYW3Ou2/UKEF3Wht3GRkUuvyF32
         AuVxsKronQm/7bTGq/oFCJ6c+azww6V3g1g0ZZ2gp51qfLENkD3iy+sWAziB+Fqpmhl/
         uZiRZMRbBu4KIM5tArxmTEnrSBNFUGHPHP9By1ONYDoYB75cYqXTVb9icINyCGIXl87T
         7U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722420510; x=1723025310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w5C3Fs7RfQOfTL3CPVuKhp+TlqAOyBUF7xiHspn7ajk=;
        b=iyYRt2byqHP0BsFiFOE6wCPLdiFr7q8Ps9b/0MhjSZlq0R2tHmrlAbTxklSN4NXnXK
         PGR2HJa0oWhQoZNItE1awvvQuIfGS3wM9+6MGD8EvQKlVKofzT+rwwhmmLYzOAs3IH4y
         MspOj5kB6l9sxfXsYY2WnOanQi+cxROu0F1wPAz8MTMRnK79BDR/2u1uT73YVRz78OHO
         lBOg12irn5pMgGTopDCCUMUbtIDBsmkK0WWSnNwcKznqN+J7l2Yv3N8dhfBrgTNkFAbx
         VEBuLSiQoZsFyZxJbeDpyr3iz1ci+yurGt2ZYW+V65+t7GnB8//uHnnuNBE5mwx6cgUH
         x3BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXHZy9ClqmForneg8/J9nWwefYmL7MMCgikTJGFTbKpQYBPkcZ162Ei70FND0ImWky6TRMlh+dVkk/1qfwVbEeMhipJZcCfRyAmzwY
X-Gm-Message-State: AOJu0Yxhd89/mhjI94IVkQGbWb24oEK+nwAGxWrXp1/fjHP/XdLLBETB
	qWaT4bh97OhcR/pSwEDtQdGBANYXu9zlVlM0yUlDUiaE1PmvGmOHU5+e5O7JeFA=
X-Google-Smtp-Source: AGHT+IFaMSAK62na1im8GG0hveleO0frKhkFCNiWMxnYb4zivcEU9chV/KAM+65nyNSMQztbR+qFCg==
X-Received: by 2002:a05:6512:48d3:b0:52e:be1f:bf8b with SMTP id 2adb3069b0e04-5309b2b6e10mr8464133e87.47.1722420509581;
        Wed, 31 Jul 2024 03:08:29 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4282babaa2esm15925465e9.25.2024.07.31.03.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 03:08:29 -0700 (PDT)
Message-ID: <b0bd35b2-25f0-4968-853e-6369cabae307@linaro.org>
Date: Wed, 31 Jul 2024 12:08:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] thermal: trip: Avoid skipping trips in
 thermal_zone_set_trips()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Lukasz Luba <lukasz.luba@arm.com>
References: <12509184.O9o76ZdvQC@rjwysocki.net>
 <4448b729-5998-440c-939e-08e719070ac5@linaro.org>
 <CAJZ5v0iAd18d3_o8i74ao9tg=JPXhBZ29wMiYBd8xS64B7wGsA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iAd18d3_o8i74ao9tg=JPXhBZ29wMiYBd8xS64B7wGsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2024 18:46, Rafael J. Wysocki wrote:
> On Tue, Jul 30, 2024 at 4:57 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 30/07/2024 16:41, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Say there are 3 trip points A, B, C sorted in ascending temperature
>>> order with no hysteresis.  If the zone temerature is exactly equal to
>>> B, thermal_zone_set_trips() will set the boundaries to A and C and the
>>> hardware will not catch any crossing of B (either way) until either A
>>> or C is crossed and the boundaries are changed.
>>
>> When the temperature is B, an interrupt fired which led to the
>> thermal_zone_update() and in turn it calls thermal_zone_set_trips()
>>
>> As the current temperature is equal to trip B, it makes sense to set A
>> and C, as B has been processes when handling the thermal trips right
>> before calling thermal_zone_set_trips()
> 
> So say that A, B and C are active trips and the thermal zone uses the
> Bang-bang governor.  Say that each trip point has a fan associated
> with it, so that every time it is crossed on the way up, the fan
> should be turned on, and every time it is crossed on the way down, the
> fan should be turned off.  Denote these fans as f_A, f_B, and f_C,
> respectively.
> 
> Say the initial thermal zone temperature is below A, so the initial
> thermal_zone_set_trips() interval is {-INT_MAX, A}.  The zone
> temperature starts to rise and A is reached, so an interrupt triggers.
> __thermal_zone_device_update() runs and it sees that the zone
> temperature is equal to A, so thermal_zone_set_trips() sets the new
> interval to {-INT_MAX, B} and f_A is turned on.
> 
> Say the zone temperature is still rising, despite f_A being on, and B
> is reached.   __thermal_zone_device_update() runs and it sees that the
> zone temperature is equal to B, so thermal_zone_set_trips() sets the
> new interval to {A, C} and f_B is turned on.
> 
> Say the temperature rises somewhat above B, but does not reach C and
> starts to fall down.  B is crossed on the way down, so f_B should be
> turned off, but nothing happens, because an interrupt will only
> trigger when A is reached.
> 
>> I'm failing to understand the issue you describe
> 
> I hope the above helps.

Yes, I understand now. This is really specific when it is with active 
trip points, so passive delay is not involved.

Thanks for the clarification


>> Were you able to reproduce the issue with emul_temp ?
> 
> I haven't tried, but I'm sure I'd be able to reproduce it.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


