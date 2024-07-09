Return-Path: <linux-kernel+bounces-246773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B97792C67C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359351C224E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C6218563C;
	Tue,  9 Jul 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKgVVo53"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438307E765
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566922; cv=none; b=VLZzMB0HnkiMAtgmeJeiWiclKe9lH9ldNdOJRlIhn7PbJDaWHoqV+E5ZYPxJw+rxFCWQeYv96EiN1ifYBKVwg+vOKqxbdssC/hjcGFhhCEvdU21oDrClx8H+Cy0I0mbjZWNonWJmkPE8JftC1jacqrgGqZOYA/Xi0kZmECMXkB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566922; c=relaxed/simple;
	bh=xdCnr56OuqPlvWKQlDFwlk443RCYNdLU+1M4K1ccl6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvR9/jNyKOJdnS0F9B6JZFb8AQBN/T6diXrRErpo2XGwsMa5NndVHKZqsAukspgs3U6QjB4ZLvHGjIq7wkCtOq4JslsbwJKdCAEQa/Mb/jHjMSlUtHJM73p5PplrWNUK34XO1YLUxYFXIz26aQmgaDRQ4klDbhQRJyVq4yWUmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKgVVo53; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7f7e24bac14so12362739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720566920; x=1721171720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlgU1fdu7thu5cfqXl2G2BTvQ4EnATZJ3QFE+8p9PZw=;
        b=GKgVVo53i9NPRUXUAteKBqPCLAQF7oSqI9h8ACc5MDNZe6JnGafKW2ZJysdhKUBr+R
         qvQj1hn0oSPKqGXsSTUAJNV0qQsB4ePFClkZkx81G1hcdA27yKBSr1ngmADWsxKyRrD+
         TTa7ciqeCjVvr+hoywbXeyMFJd7Xp2f+QHih4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720566920; x=1721171720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlgU1fdu7thu5cfqXl2G2BTvQ4EnATZJ3QFE+8p9PZw=;
        b=xDOw6J5Cwk+kM4o8iqn1KJZEgFX8XFU8ysi5Wl+DVZPxBFPWcDxgafBCH7cGkzRPSg
         j1SSQeXXH/xqF5WKT0jwwUUeZDbRIMW4JNSZEn3yx9iARSY/t/2Mc394gjRA+JOnQZ7I
         roAgmJUjnBBn91NkTowKV2h8NX1SYpmP4FN+/VGe1aP3Og26/PoqNkx1O6CSCVQ3gjgu
         WF/y5EGwAzGc2K2hXQcqP6Ie22Ge2I88suk4A7Z1OJIqusvQtPH1zP1AcwLB5xExVWY7
         EazuzQd1jF2tMY5qVHuTYyVtfHBMn+wutKbdJfzT1BwWH7o1i+PNvZIA7YoXc9W5x1uI
         zVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb2W0UHIZj+gM0T4bMmOkX8zsdyhj5fv1hSQC8628yt2Olc/Z2MDZMLQve0ZYBYUCJ4+qC8Y4/AR05QL0NBT2urs2h4UTQOSt0TbT5
X-Gm-Message-State: AOJu0YyiG6dL3j+QwhYYT64VvaxVCEG6/8B3EY7pobC4fg+DM7vwsUem
	sSZgCu6mxAXk/EncMAaZ7vijtz40eE4lBzlzzhHEGxr4bMzc2XgFn8adM7lSatY=
X-Google-Smtp-Source: AGHT+IFVDdAds7MWO8IlspwtWaVh7rNNP2ClDNoot6td8R2fz9nyj/+vsj68PO2yV6pnSbmjFiF+mA==
X-Received: by 2002:a92:cdac:0:b0:38b:3d5c:bcb0 with SMTP id e9e14a558f8ab-38b3d5ccb9amr28429655ab.0.1720566920286;
        Tue, 09 Jul 2024 16:15:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4be43493sm6384255ab.71.2024.07.09.16.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 16:15:19 -0700 (PDT)
Message-ID: <4bc3373a-6afc-497d-aed8-c6cd138df46d@linuxfoundation.org>
Date: Tue, 9 Jul 2024 17:15:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] kselftests: vdso: vdso_test_clock_getres: conform
 test to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
 <20240610054129.1527389-2-usama.anjum@collabora.com>
 <7b020209-3b20-48f4-92fb-099d80aee625@linuxfoundation.org>
 <87e6beea-4618-4a5c-a883-42ef64a2d584@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87e6beea-4618-4a5c-a883-42ef64a2d584@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 02:17, Muhammad Usama Anjum wrote:
> On 6/12/24 1:32 AM, Shuah Khan wrote:
>> On 6/9/24 23:41, Muhammad Usama Anjum wrote:
>>> Conform the layout, informational and status messages to TAP. No
>>> functional change is intended other than the layout of output messages.
>>> Use kselftest_harness.h to conform to TAP as the number of tests depend
>>> on the available options at build time. The kselftest_harness makes the
>>
>>
>> How does converting to kselftest_harness help with available options ay
>> build time? Can you explain?
>>
>> I am not seeing any value in converting this test to the harness? I want
>> to see a better justification.
> 
> Before:
> ./vdso_test_clock_getres
> clock_id: CLOCK_REALTIME [PASS]
> clock_id: CLOCK_BOOTTIME [PASS]
> clock_id: CLOCK_TAI [PASS]
> clock_id: CLOCK_REALTIME_COARSE [PASS]
> clock_id: CLOCK_MONOTONIC [PASS]
> clock_id: CLOCK_MONOTONIC_RAW [PASS]
> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
> 
> Here is the output of the test before this patch. The test output test
> names and if they are passed or failed. It doesn't output information
> related to error when it occurs. I wanted to convert it to standard format
> by using kselftest.h where we can get the error related information as
> well. But as the number of tests depend on how many of CLOCK_BOOTTIME,
> CLOCK_TAI etc are defined, static counting is difficult. Test harness is
> best suited for this. Output:
> 
> ./vdso_test_clock_getres

The reason I don't want to take this patch is if you run the test
using the recommended method:

make -C tools/testing/selftests/vDSO/ run_tests you will get the
TAP output because lib.mk runtests framework takes care of this.

or

make kselftest TARGETS=vDSO will do the same.

Please don't send TAP conversions for individual runs. You will
start seeing duplicate TAP output which will make it unreadable.

Run the test using make -C or make kselftest TARGETS before
investing time to concert to TAP. I am not going to take TAP
conversions patches if make -C or make kselftest TARGETS
shows TAP.

thanks,
-- Shuah


