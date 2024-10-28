Return-Path: <linux-kernel+bounces-385145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4B9B331C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808131C21E29
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB571DD0F3;
	Mon, 28 Oct 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u0f1ndXY"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A141DACA9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125000; cv=none; b=TOUg92cQ7k8JTTsYPD4g9i+/8RV6HdivNyrPY3rJZ4ytc7buMn3MKNRgOZTicKLBMrMr51woxEkbOyniKkZjwXZMs40CauGmYC54K+0IYv2wfBvs38fxa3PIalK9VUzkRoaPYPFCHdq+VkX0F+P9/pG3FfQwph8BTtJnqJn5x9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125000; c=relaxed/simple;
	bh=Z/1tooQXxbcK4lVGwo/4bZ6ga1NIJM4QYTPFDM9Mo3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iC0H7viymlJVsfK3Vd05HDQhYZo1iKjo+Opnno+7Iiy+ZmUS3FKL6cBaC83M5qpZyQB1r4ZLgQfvxhOvQ6fOvnzSDM6ivH5IN9zUmkW3PIIkBrzTjz2i6PetQ5BHN7EoO9D/MC+fAE539Mq0DphI1zb3tTgRj2twuggG0AyrMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u0f1ndXY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37f52925fc8so3115395f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730124996; x=1730729796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quqfrl+ntrh5+Sv/MCcmT5/a0XinSFOWiABW7uGEUZM=;
        b=u0f1ndXYwhLC6eiCBEqmAgakM+GGinhRHxTXsaCoIpZHM9yOE5XR0CCs4iw1yTJfK7
         eoBtPtHlaPUwaIR2b2k2G4TVc4fBWQbvu5n8dHvi97cO80/1aqMSxmxcvTBscgoArp66
         qWRV7cHaGwBirI9mPPiHkXw6w2CRL2xq/fb2EBdKdg+ndI9o3gkLBU3Vh4Ozyhh2UDnr
         +UIoI+bnXuOjg109K7SqgRo75PRq1vMVwrI+HuBYN1OVB9HK5a9kMOVwzRJBzqvIDp7u
         4M0/bqGSFjSoHjtiMNIIXaaY0XcPoezQQKVluKLZtASq0rZPOUSGVVmjgnNIaMb2wvqY
         mIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124996; x=1730729796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quqfrl+ntrh5+Sv/MCcmT5/a0XinSFOWiABW7uGEUZM=;
        b=RlquOdmnb/xE+XPvZVNR6LXuNB+yCJwRt/O5YsPnmyW0SLJ63ofXjWH2+hqB3GsEYS
         uGxT+c3zjzA3P4OhVXdJ7DH68YJwNaQVxT4JUNI1jCf3ytqT0KeRqVkuPfAhOAZJKMJJ
         VBCMf8ULkOTxg9ZTV1V1MR+FGDKHw0T74x0jabuqgJAj2rvAAPoCi5+XlKEIkOcuoKtR
         S58Ap/t1aNfrkDjqcCdTqeR5VzqZcw4/SLh5J/1RBlnLzJu4hh+0EbjCx1vSyR6O+Ufc
         695lc+5g/SobYNRT3u1gdBM+cFrshUfUhCTCOA77iRu4SUxr2B246hjFltKbd08LZ/Ep
         Wktw==
X-Forwarded-Encrypted: i=1; AJvYcCVcthLTZihI5q6EtByDZRdrgF+grCDU03x77SPldWitKR64b09bTTQcHnkvyF3posxwavYVvOnZk5zXAZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCrmZQkBTAB4JhpCt/iVxKyoQyWM8uSgEv9D4NvLLNVfqXW6l
	NfN2XnNwRy1vbWqbcA+6926pCnSNbbT+7KLQlyQ2d7rmbGGSqYtbH2i7rO8NKxw=
X-Google-Smtp-Source: AGHT+IEZY+k0aXn5tfgk7XRpaz73GX3fpQstWkbVAp4n6D3wdTEULhrWgfBHQTYZF4C9BVFIPagq6Q==
X-Received: by 2002:a5d:4748:0:b0:37d:51bc:3229 with SMTP id ffacd0b85a97d-3806120b1b0mr4859262f8f.51.1730124996070;
        Mon, 28 Oct 2024 07:16:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b1cc0asm9715947f8f.10.2024.10.28.07.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 07:16:35 -0700 (PDT)
Message-ID: <4f4572c2-8436-41a6-8c8d-4811da8231b1@linaro.org>
Date: Mon, 28 Oct 2024 15:16:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] clocksource: move System Tick Counter from
 'arch/mips/ralink'
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 linux-mips@vger.kernel.org
Cc: tglx@linutronix.de, tsbogend@alpha.franken.de, john@phrozen.org,
 linux-kernel@vger.kernel.org, yangshiji66@outlook.com
References: <20240920075306.704665-1-sergio.paracuellos@gmail.com>
 <CAMhs-H-ChXQSZ_6EBiTKtD7ve2j2QsVvgVm0B5O1O7BfGwKFmQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAMhs-H-ChXQSZ_6EBiTKtD7ve2j2QsVvgVm0B5O1O7BfGwKFmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2024 15:14, Sergio Paracuellos wrote:
> On Fri, Sep 20, 2024 at 9:53 AM Sergio Paracuellos
> <sergio.paracuellos@gmail.com> wrote:
>>
>> Hi Daniel,
>>
>> System Tick Counter is present in RT3352 and MT7620 Ralink SoCs. This driver has
>> been in 'arch/mips/ralink' from the beggining and can be easily moved into a more
>> accurate place in 'drivers/clocksource' folder. This makes easier to enable it
>> for compile test targets as well as reduce LOC in architecture specific folders.
>> Bindings are already mainlined and can be located here [0].
>>
>> Thanks in advance for your time.
>>
>> Best regards,
>>     Sergio Paracuellos
>>
>> [0]: https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/timer/ralink,cevt-systick.yaml
>>
>> Sergio Paracuellos (2):
>>    clocksource: Add Ralink System Tick Counter driver
>>    MIPS: ralink: remove System Tick Counter driver
>>
>>   arch/mips/ralink/Kconfig                              |  7 -------
>>   arch/mips/ralink/Makefile                             |  2 --
>>   drivers/clocksource/Kconfig                           | 10 ++++++++++
>>   drivers/clocksource/Makefile                          |  1 +
>>   .../clocksource/timer-ralink.c                        | 11 ++++-------
>>   5 files changed, 15 insertions(+), 16 deletions(-)
>>   rename arch/mips/ralink/cevt-rt3352.c => drivers/clocksource/timer-ralink.c (91%)
> 
> Gentle ping on this patch series :-)

I'm on it


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

