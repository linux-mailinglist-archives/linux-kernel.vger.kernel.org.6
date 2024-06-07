Return-Path: <linux-kernel+bounces-206691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FDD900CC8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 22:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66BCB2343D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF56E61B;
	Fri,  7 Jun 2024 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLN5hlVU"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0847E1CABF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791398; cv=none; b=tGRX42iJByLxAyBkiFRKmcKQEUGhVDFZjayPulU3LpZ8VZMkUwB9N7JeRLV/0P7/jedRdtEswgPxfqvJ4CfFjonmbzREFf9jZ/8FY3IxCflGBJQEvuPDcVWYjv+1jNDW4Jz83/LEyNPvtgaJHCHFMrQ14IeoakAja4A2tX9pN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791398; c=relaxed/simple;
	bh=94dQIEaXbShYcCUD2VZwQZfWzDfpId6SaEJtAerUUDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqw4MpPLqzz13sMKArXiyYKp8n/hL406KTDIU1I+KBrHGaqK/KKLW4IoNzxfHm9xSOnn3vOv63FLs+aL3nM380tpnFOKTHBNFMrb6T0UksBnFUMzZjldtjwrSlatcmghfibqjtug/27rjNAoXVyIdFi+fEZ2V0SrzdXTWW1cuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLN5hlVU; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3737b3c6411so1575865ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717791396; x=1718396196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96rEQbBFraOtroPGskwQv9wJ6BgYJkFe+xf7ykDOFvM=;
        b=gLN5hlVUsLfYAhKpEQyKwtcsjfdR5CSgnOYfNG7hZ6HC1QEwJwcWQGlXI0fgPYaKSU
         4g0RPRvkyFavddKUYdAYm/yp4FXfyj5Y0YoHWwvj7TRqA6xA9hPhnt1VKj2i0SphXvZi
         3mRgcsTRo/wlIe5BlEdvxtRsXVXUMjXeI/wMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791396; x=1718396196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96rEQbBFraOtroPGskwQv9wJ6BgYJkFe+xf7ykDOFvM=;
        b=MdukM5io5WlEE0+J7TW/XVHZD2yhSNVixKwa4Eo14y5j+IjVMUkibkU4tNgfvJDzjs
         LNV2RWIAqILrW+8ZhkUPksWJcSqqoryEOz/z/W07ofmJYTNkwrMtYdMmLdklsB29NIav
         PyZPnJiIMDzeB67Vtd3gbXj2JU/8T72ZzCEvwq3WwJ+49K2NCFkDJ367eaK9uYoBDVOU
         wVYVvuwTA+4zr+ExIOBpeZXrp2jDTwjntCHVw0P+GWG9w9rv53j1jVvxqFwwzLDY0cCl
         w+8/K8ov05hNuDxOmRbTqaOxheEOETBUtFu8yoeE9IWKd9PkBNesj3+I/xq+bfo3eNjK
         yHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0fUk7GtCrO2Hpd+99dYWdmRZAON2U/ikE+JGes5GZwwm2+ojcRyAe7drPXAkh3BFCSmookb+ijTxxUPx7XcHpKm16ahXVEukGBmTF
X-Gm-Message-State: AOJu0YyLfdNG40UbNzRxT3D5YJ1USkDy0aY58nTxYV+Z564OZKJa/+gL
	ZbJyg+4ocUprOLqjRpYRdy9zJPSWillb+r3eDLKM88EkTeJgvuxD0lfWEqCwwdY=
X-Google-Smtp-Source: AGHT+IGWuRP8uOeTBdfHQ4EtimpCODHyKWkg57vDi+SJtc+P1tHb2l9ZmD9GDO5yRdRZlSt99OBjFQ==
X-Received: by 2002:a05:6602:256c:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7eb6a6ec94dmr106967639f.2.1717791396021;
        Fri, 07 Jun 2024 13:16:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a224cdd2sm1001756173.57.2024.06.07.13.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:16:35 -0700 (PDT)
Message-ID: <62de4c57-1296-4fd3-8072-ebbb939bee47@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:16:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] kselftests: vdso: conform tests to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529072454.2522495-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 01:24, Muhammad Usama Anjum wrote:
> Conform individual tests to TAP output. One patch conform one test. With
> this series, all vDSO tests become TAP conformant.
> 
> Muhammad Usama Anjum (4):
>    kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
>    kselftests: vdso: vdso_test_correctness: conform test to TAP output
>    kselftests: vdso: vdso_test_getcpu: conform test to TAP output
>    kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output
> 
>   .../selftests/vDSO/vdso_test_clock_getres.c   |  68 ++++----
>   .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
>   .../testing/selftests/vDSO/vdso_test_getcpu.c |  16 +-
>   .../selftests/vDSO/vdso_test_gettimeofday.c   |  23 +--
>   4 files changed, 126 insertions(+), 127 deletions(-)
> 

Sounds like this series is converting the test to kselftest_harness
and the commit message doesn't mention that.

I like to see the commit message match the change being made.

thanks,
-- Shuah

