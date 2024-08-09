Return-Path: <linux-kernel+bounces-281270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C779F94D4F9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0221F2433C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6EF200A9;
	Fri,  9 Aug 2024 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTp6fDN1"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8638FA6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222103; cv=none; b=LdYyDoMXB/325PiCB7PeCWaP3S0OS1cPVGtyqRPrPIIf+vdV6OK10vCUrzygQ+l6wstfFsOrtIFxdtsWCgMGRuTKDnMIxa31y7i3J4MJybi5r7abCHmAoy2INDuf7mFK+dBEQOG7paS4+1bEFaxyXw8P8W2t4XP/ezKDYdO9x8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222103; c=relaxed/simple;
	bh=DV24Qth48BZmZMiflU4Rk1Xti/jR+zRd72sjOu5E2no=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CDhbalTl5i0K/4+co/TEKq35aDUgbLPP9gwRiMwfJK9t/NpJbXMS/FPnaHOMv1OYRZBbsKDvSN2KKs34YVjhMPWcYYsl4Kdcnf3cOCYTIoQVb+Q4G4KSPlnDd10/ib4AA6nXW7f843VIqt0n881SL08X2immeiN5Om0+Q7LFKxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTp6fDN1; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39b37e5f8fdso1084455ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 09:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723222101; x=1723826901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIBS2fiq1eabJ4IYCoixxVdAtJaZLZJZMFj7PGFDm3c=;
        b=dTp6fDN19CEDWhGpEnSiaWVC9pelPOYpKhF3VYf4qJ+nDreec5pZi+4cY+gM0runoK
         OIrZqUkzx6srTNQFgrskoPgp7j1cd1SH5P9j1/5/8WzHiF6SJeHHgqlrq24Np3fR/emF
         dmT6LUjEs3qXcStlPfYpkNxXaZ1mqBLFRV5qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723222101; x=1723826901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIBS2fiq1eabJ4IYCoixxVdAtJaZLZJZMFj7PGFDm3c=;
        b=nssflltRlM3JuLKIqp99Ul7rRNEfIgyq35Y8+wSdNCL0uG3Oj23z9Ao96NKQ58emw3
         iJQAx8donBMiO+z67utXaV44UfmneyKITyvWD3vpxJ9eB7WbRm7eMU2ATtcxdTX6gkxf
         ++flTE4EiAm/fghMBG+kI7DVSPWv/8pMCSCIFHQgiZIhpCGhFpq0HbrfSO2Foyqf1lTg
         ZKcQWztjLmBL+nhBy4recG6ZBRqsJ0XKi80yYMRZGqLCsAhkcHI2bXdzv7FIqVLdY153
         88LbHTaedd6IkohTGvd3OigkvV+CKkMH/uetxzHmbqeyw92TRy/IlM1ced09aVHhItGZ
         kW4w==
X-Forwarded-Encrypted: i=1; AJvYcCV0WGaMpcGnitajoZEJgitvS8J5dtFfbrBIvlYAyK9HKWrW5AGHraKui9utBFf8KgOOPFU/c4iS67letVpG06xdFosD3awFKOCorvei
X-Gm-Message-State: AOJu0YxpYX57ZEguVjOusliNt9Wsfa+Qw4cex8ZakHfpuRv7W2zG1vWO
	ydHhct8LLw/O3L3V9tQCHQZpenjRaqTJ3tEXwhxaOcv8NpzB5VNJe18b6VLBQUA=
X-Google-Smtp-Source: AGHT+IEPtXUbZewJJPbHdH3NNNItqquYGOjjEuRG2n0DfjjJa+ymgUHQYn2ADond5MgNHtrhIJmfAA==
X-Received: by 2002:a05:6e02:2193:b0:39a:eac8:9be8 with SMTP id e9e14a558f8ab-39b7a40deb6mr15291675ab.1.1723222101188;
        Fri, 09 Aug 2024 09:48:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20a9ab7fsm65210735ab.6.2024.08.09.09.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 09:48:19 -0700 (PDT)
Message-ID: <cbb133f7-c447-4fc3-96e3-74952bb2bf44@linuxfoundation.org>
Date: Fri, 9 Aug 2024 10:48:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: memfd_secret: don't build memfd_secret test on
 unsupported arches
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Mike Rapoport <rppt@kernel.org>
Cc: kernel@collabora.com, stable@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240809075642.403247-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240809075642.403247-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 01:56, Muhammad Usama Anjum wrote:
> [1] mentions that memfd_secret is only supported on arm64, riscv, x86
> and x86_64 for now. It doesn't support other architectures. I found the
> build error on arm and decided to send the fix as it was creating noise
> on KernelCI. Hence I'm adding condition that memfd_secret should only be
> compiled on supported architectures.

Good find. Please include the build error in the commit log.
  
> 
> Also check in run_vmtests script if memfd_secret binary is present
> before executing it.
> 
> [1] https://lore.kernel.org/all/20210518072034.31572-7-rppt@kernel.org/
> Cc: stable@vger.kernel.org
> Fixes: 76fe17ef588a ("secretmem: test: add basic selftest for memfd_secret(2)")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/Makefile       | 2 ++
>   tools/testing/selftests/mm/run_vmtests.sh | 3 +++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 1a83b70e84535..4ea188be0588a 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -53,7 +53,9 @@ TEST_GEN_FILES += madv_populate
>   TEST_GEN_FILES += map_fixed_noreplace
>   TEST_GEN_FILES += map_hugetlb
>   TEST_GEN_FILES += map_populate
> +ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
>   TEST_GEN_FILES += memfd_secret
> +endif
>   TEST_GEN_FILES += migration
>   TEST_GEN_FILES += mkdirty
>   TEST_GEN_FILES += mlock-random-test
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index 03ac4f2e1cce6..36045edb10dea 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -374,8 +374,11 @@ CATEGORY="hmm" run_test bash ./test_hmm.sh smoke
>   # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
>   CATEGORY="madv_populate" run_test ./madv_populate
>   
> +if [ -x ./memfd_secret ]
> +then
>   (echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
>   CATEGORY="memfd_secret" run_test ./memfd_secret
> +fi
>   
>   # KSM KSM_MERGE_TIME_HUGE_PAGES test with size of 100
>   CATEGORY="ksm" run_test ./ksm_tests -H -s 100
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


