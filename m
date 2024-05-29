Return-Path: <linux-kernel+bounces-194612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAEC8D3EE5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 21:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 457AE2838BC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8166517B404;
	Wed, 29 May 2024 19:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i/SF2/nb"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8115B13E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011036; cv=none; b=BCXeAz0d+t+SZYJgYjBsmmBnwBX4fwg6kC48bxWViJU5ZVivnoi7Ks7lt8ocuJQwarAjsN9/s5H5EBNW6mhSOSKMnWHh0tdfYWddQUdKnbV5GxdYSD50al91tqN5E0wte47A6rQENX/sr8JCI+DavIrgwiaafcDC+lClNns40t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011036; c=relaxed/simple;
	bh=rbhu2ib/XGwYGFkI1NObBN7OwJKwg7X91DunIKl8pfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3lzH2vLBeSLLD6FdAN5luWolduBG1SXhEYmIOCNOYoAJhxBt9gJigSxscWbvRvlHMK1e/7gzceg8quSzkHAlq8O1dceiGKSZVI/BknXtE/okbL6sAbk96imdKtqgut8de+z/9rFfXrdXLyW/Tyk4ARdaPf3afoIXrqKQXvCJ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=i/SF2/nb; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7e8e7b01257so1670739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1717011034; x=1717615834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O/S0KVWXFmOHVQryZxavE2DQTw/tgGX43OLxqtR+UFI=;
        b=i/SF2/nb//5u8Nge/gcITjzV50QCExCpqS/r/fIFoKuAXiKAxaGTCo0GCOeyGkYPzU
         0TXStnDNglPAFIErHEqrAcIGCANbKcAQSlGJ+2JqzHgfQBkmvxJDEcGh1rqrrd9tzbD7
         44pRe2zvN6trQONb5/cyxOy4MAz+DBrGJG05PHtPXt2cPhR6qf0wIkbYDiJ9txqNXprK
         jeKKIKsRaOTE790Moaui313bMpGiYJKomCnGguLdSEEXS98+10Gm5jvHI2fjMXwReQze
         IN8swmkUD07OXE5Q5bj3xotBBLa3wSlQGoI24gRqIbI6orxzryCt9s5ZgIheo/UJCTbz
         0TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717011034; x=1717615834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/S0KVWXFmOHVQryZxavE2DQTw/tgGX43OLxqtR+UFI=;
        b=jVxt4yG3PU8ekMPSKcQfjvKPgacCtqZttmhEvKLGQuU3oRr74+78+htpNK7ro8As/Y
         JarqGX3YJfAacAz8HW5+Gmqpyp8ybYz/9dlZpWiSJICIc0NsyxwaHHwvhPVYJ2kd9bKG
         BX69cjuYIpTUzeyf+LoZI2on4Pi7QMjSRxwrLQcuF8gIPij8EawqN3fHI78R0ns956w5
         ulRHmzUoAVwpV6cfbqWe6ypofiAEq+OQmTTumYlfmvOpN+nWN8MzZvXguVFZTDUMCQhb
         g0qlD/FvGQVEkc/UboSEoVDD0qBpoY31Y+kUtx/kj63JTvoawKdinoAfcZx+H/C7E7ep
         +h8A==
X-Forwarded-Encrypted: i=1; AJvYcCUaLgU7BPZrsSkOxtlXGpENCARd1qbtvQD5WIP+qUL24YbchNx1AmSc0p4Zkcmbj4x32nLwVEzsjznP2h4XsYhFslSKPJ3eahVsxdTt
X-Gm-Message-State: AOJu0YwhsEoXCPOu8R1VOCvgCg2SMV9Cb4BeTTO/vhxGiXKar1GC0Hu1
	YTyX5vCDIqpIggpvYY4QbjoZ94bXryhF8tct8f0VFMIue264wLktxlVBiXdWbRw=
X-Google-Smtp-Source: AGHT+IGH/6KegzkUgys9rBPlGXzDuwuB6PvXzY3NlqpGylyoIeQBRNeVmq/3xNj56KnkqbTgj17LXA==
X-Received: by 2002:a5d:9304:0:b0:7de:cd12:ed2d with SMTP id ca18e2360f4ac-7e8c461533emr1764314239f.3.1717011034379;
        Wed, 29 May 2024 12:30:34 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.197])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7e903e0b783sm263170539f.4.2024.05.29.12.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 12:30:34 -0700 (PDT)
Message-ID: <f18a74a5-330e-402a-93ca-5552faf00e7e@sifive.com>
Date: Wed, 29 May 2024 14:30:31 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] riscv: dts: starfive: Enable Bluetooth on JH7100
 boards
To: Andreas Schwab <schwab@linux-m68k.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Emil Renner Berthing <kernel@esmil.dk>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
References: <20240508111604.887466-1-emil.renner.berthing@canonical.com>
 <87wmo2nmee.fsf@linux-m68k.org>
 <CAJM55Z-F6N6ua5LoqyMFogDtLp=FaRPoDv4osXFDMjR1b8r9nw@mail.gmail.com>
 <87zfsy102h.fsf@igel.home>
 <CAJM55Z8Ce1i==pSUj0z4T2y71g713-675mAYQP5qSN5Euz=rLQ@mail.gmail.com>
 <878qzsbona.fsf@igel.home>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <878qzsbona.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andreas,

On 2024-05-29 10:53 AM, Andreas Schwab wrote:
> On Mai 29 2024, Emil Renner Berthing wrote:
> 
>> Oddly it doesn't work on my Starlight board either. I was thinking the firmware
>> might set up pinconf differently, but comparing
>>
>>   /sys/kernel/debug/pinctrl/11910000.pinctrl-pinctrl-starfive/pinconf-pins
>>
>> on the two boards shows no differences. I've also not been able to spot any
>> differences in how the AP6236 module is connected in the schematics for the two
>> boards, so not really sure how to proceed.
> 
> I see no difference between Starlight and Visionfive boards, both fail
> the same way.
> 
> I also see that sometimes the firmware greeting from brcmfmac occurs
> _after_ the timeout error from hci0:
> 
> # journalctl -b -2 | grep -e brcmf_c_preinit_dcmds -e hci0:
> May 16 12:01:54 beaglev kernel: Bluetooth: hci0: command 0x1001 tx timeout
> May 16 12:01:54 beaglev kernel: Bluetooth: hci0: BCM: Reading local version info failed (-110)
> May 16 12:01:54 beaglev kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM43430/1 wl0: Mar 30 2021 01:12:21 version 7.45.98.118 (7d96287 CY) FWID 01-32059766
> 
> Is this perhaps a race with the firmware loading?

brcmfmac is the WiFi driver. The WiFi and Bluetooth parts of the module are
functionally independent -- different drivers, different firmware, different DT
nodes. So the brcmfmac line is not relevant to debugging Bluetooth issues.

If the Bluetooth part has some dependency (pinconf, reset pin, clock, regulator,
etc.), then such dependency must be declared specifically for the Bluetooth in
the DT. Those seem to be correct, so maybe the issue is the maximum UART
frequency, if the signal integrity is marginal. Have you tried reducing that?

Regards,
Samuel


