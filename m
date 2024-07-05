Return-Path: <linux-kernel+bounces-242788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7361B928D28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 19:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80521285A3D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C0016D4F8;
	Fri,  5 Jul 2024 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KmAuRrDB"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEBC14A62F
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720202009; cv=none; b=ke3nnUOFeK4lEHlel6r+Vw6Vh0I/gdsrcTracUaRq3lUNzENu8QERYd1LRA8RUTE/m87ZOaSX0EdUqXKGn5ECKvEHJ0Vdz+ZqlLEg/V+w5EEjidaJARol20QSWuDnKjyphkYG4fmIUTTXjk4sjUtHafpDXqGr0RCy1GMjhBSfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720202009; c=relaxed/simple;
	bh=uyFT9HitKgqEW01zxE70/QdEA0bRn6fCTZf+R820kl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW3a9URq6yTrPFDErMhcaCpe2wA/DEXCeiR/iVvRvIiZYzgmteCK7o+MaXzy9S1lLCjuURoWXtqZ2YNV1nWyVw72g7rkamLKlIUyN7oHW1hPsSW+LT3SeBhBNyW1joSqvuWnPwsK3BNlY39mZOveLyaOzTX7Ny+8g8EkaWSZwTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KmAuRrDB; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7f3c804daf7so8809939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 10:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720202007; x=1720806807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aOteYgqQJ+bgjXyE03h9KjUtRQZzhDobMs9njBVn+Zg=;
        b=KmAuRrDB6E0FJn4fIBGDp7OrKam+i3ix7Fujcgij5dGsjZTdFSyPXTbJS/SJJPU7lZ
         fVRk3c/VZhFMfTUYRdVD2DpOr51MGQxkpTWrSLqo86JIDzwaVFpxdkiGgcUJrPtZ+Hnl
         ZSOy70MW6XjadhCsPMvuI7+HU0eqvgJKA6y5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720202007; x=1720806807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOteYgqQJ+bgjXyE03h9KjUtRQZzhDobMs9njBVn+Zg=;
        b=j/otXWCtzyVnAkc/kFr9RHJc2UZ+bdWxceBUTe5kOlET8KIoZ/cC4CJVc2NEZIh8Ze
         101wOaL176Yc0Di30oeylgvZdiySWk4cdVhnPhf1t8uyvcMNS9HLZOd4Wk2iB+YuryAf
         C7EpPwMu7KD5Mo2Dbvbc0oBLDv6wkpBKKUrvtxtPBzKA5V6ZWX9Kt4/bIga4XHyRDP+x
         M40HNKucGbP4ezFb9bqGkXQqNy1H14wkrtVgmzc3BPuDkqqLpDL1I5LOhtDOxVxYL1N4
         jgDDejN6j3Irbm2bdwqDXw8l9FDIAmX5ttH3sAG9Bxj5ABz+nmhmSNYtqtkXrkL29O7r
         HMSw==
X-Forwarded-Encrypted: i=1; AJvYcCUhf9W+uYvZwyYG+4RMssoSRumWPxH3U4pAfDPFLcjE+bLGgsQrLXhRvGwdSrcPctpLoJux3paoKeyilmb6WGFc43KENNpcxVuunSdk
X-Gm-Message-State: AOJu0YzU4wfcxI61zDGel+Vu1wUJkkXtr8vh4Dy1DSRkVJudXO2iGke4
	oWDA6pZnGpMSeg0CZbg6nHohAoHkSRZkqUxsZQbInGkP7K1aIN+AgwCDkbWdbo8=
X-Google-Smtp-Source: AGHT+IHK4jmkVN706hYjIYQoimuJ3Ci3Gxn4jUrYR13K4WQUbZ0Trl+AvDCNQiX6/4Mz9j++jcnWfg==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-7f685d1fa0bmr38315939f.2.1720202007303;
        Fri, 05 Jul 2024 10:53:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f6375116c3sm333608239f.30.2024.07.05.10.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 10:53:27 -0700 (PDT)
Message-ID: <9b59fc84-2d78-4304-9f39-3a495e438af8@linuxfoundation.org>
Date: Fri, 5 Jul 2024 11:53:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] selftests/mm: remove partially duplicated "all:"
 target in Makefile
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Colin Ian King <colin.i.king@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240704023324.83564-1-jhubbard@nvidia.com>
 <20240704023324.83564-3-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240704023324.83564-3-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 20:33, John Hubbard wrote:
> There were a couple of errors here:
> 
> 1. TEST_GEN_PROGS was incorrectly prepending $(OUTPUT) to each program
> to be built. However, lib.mk already does that because it assumes "bare"
> program names are passed in, so this ended up creating
> $(OUTPUT)/$(OUTPUT)/file.c, which of course won't work as intended.
> 
> 2. lib.mk was included before TEST_GEN_PROGS was set, which led to
> lib.mk's "all:" target not seeing anything to rebuild.
> 
> So nothing worked, which caused the author to force things by creating
> an "all:" target locally--while still including ../lib.mk.
> 
> Fix all of this by including ../lib.mk at the right place, and removing
> the $(OUTPUT) prefix to the programs to be built, and removing the
> duplicate "all:" target.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Why does the summary say mm ?

  selftests/mm: remove partially duplicated "all:" target in Makefile

> ---
>   tools/testing/selftests/vDSO/Makefile | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index d53a4d8008f9..209ede5de208 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -1,16 +1,15 @@
>   # SPDX-License-Identifier: GPL-2.0
> -include ../lib.mk
> -
>   uname_M := $(shell uname -m 2>/dev/null || echo not)
>   ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>   
> -TEST_GEN_PROGS := $(OUTPUT)/vdso_test_gettimeofday $(OUTPUT)/vdso_test_getcpu
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_abi
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_clock_getres
> +TEST_GEN_PROGS := vdso_test_gettimeofday
> +TEST_GEN_PROGS += vdso_test_getcpu
> +TEST_GEN_PROGS += vdso_test_abi
> +TEST_GEN_PROGS += vdso_test_clock_getres
>   ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
> +TEST_GEN_PROGS += vdso_standalone_test_x86
>   endif
> -TEST_GEN_PROGS += $(OUTPUT)/vdso_test_correctness
> +TEST_GEN_PROGS += vdso_test_correctness
>   
>   CFLAGS := -std=gnu99
>   CFLAGS_vdso_standalone_test_x86 := -nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> @@ -19,7 +18,7 @@ ifeq ($(CONFIG_X86_32),y)
>   LDLIBS += -lgcc_s
>   endif
>   
> -all: $(TEST_GEN_PROGS)
> +include ../lib.mk
>   $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
>   $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
>   $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c


thanks,
-- Shuah

