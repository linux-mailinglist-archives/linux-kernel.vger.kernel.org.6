Return-Path: <linux-kernel+bounces-263674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253593D8F3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D367FB218FF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F494D8A9;
	Fri, 26 Jul 2024 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TStDRQ0u"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C15588E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021896; cv=none; b=ov8SKMSLDvbnKkHTr3VudQGIXG/AomR9Y8Y45k1ofj6KAhnXJ4o0FemMqLrYeka6MjtqnBOQHn+V9GmccBf7EonfCvR9M6hFHKw+lHv+7TJkM6ecmL7JFG7tmI4UZ/hi83ObzISO7bb20q64h5XLLq2hxdU8BmINWR9NtLe1e0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021896; c=relaxed/simple;
	bh=0rldXxTm42IMY5pZAkh4BHK0b1KE3f0no1736ppFpW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMmap7ScLaKBrr6yJPEpeoJYWc9+4Ag8g7KlztffuzVMuFCPrJygPuHpmaYwZIy3CjvLkVrbK/QjASg8mWn+C1K28H9fJM3659Ixiwrj4TUwZoIcc7h9GW+GY4ytP10FIQNCNaPl5aBfhbfCpyOYpv1Q576pph25zMVU//34RIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TStDRQ0u; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-396d327b05cso377885ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 12:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722021893; x=1722626693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8bPjvgxcg0NQqkD2IayRMVzQ8xyFyTCFKfJZrOpROk=;
        b=TStDRQ0uco8P/jTSpfDovOU+ytgxZ5DNLtPJXtFmPj0z76OxKrfVndQoW9VQEq9ls1
         qHtvGBoe/w1q5z8qoc2j5N+xuguAntstqarMShUVaNQQ1YsO09SMbpr9/6TJowoeHAoc
         zAoXr04HuFKpa7CzLXaEelq+LO6EYFYD/CgWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021893; x=1722626693;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8bPjvgxcg0NQqkD2IayRMVzQ8xyFyTCFKfJZrOpROk=;
        b=GVsh56ZCOifPlGvmgPnmoYYDE954Zpte4/XMnPfgXsRzUyrvTmibMuK+AcE+n3AvWV
         I1mF76R45rkUqYTHy3zzmdqXX366EhLhcyyrhDEW2QDQNvPDO62glvg2O6MfQdZXAybK
         SMieb1NOODaFXE5B6hOA3asr/OS/1w6D1bXIJs7ORoB3cl9k+TtQswLlzXa9D3FUzpDd
         ApJshJkfUbbR2yBUq5M6lLX44pEdCRYtxCt2AmeVBF2jAtAgy3fp6tCYhUg7IYwtEjBS
         Y2YO7plP89oeMftUrQ7O73qMeytOFs5sqKGR3FEX+6Up8Rm4WLqGOAkOJmtFMA6COCsl
         6pog==
X-Forwarded-Encrypted: i=1; AJvYcCWVy8dgP8JC/2GnV9+DARmtBvmFpB3YfqmWJFJM5Nril+uwtytQMU7kEkeZr8DIXmF85Lrtfa1VF4DBy90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ms5hC2igv+CyttiTuLrupFwmUWWMiixhQTytdA13PoDCMiOG
	dMcRthckukA2Chjiil0ATvRGfQlvGpngMr0gCjIT//+2hmHMaHHeihBMMeHFwJ4=
X-Google-Smtp-Source: AGHT+IEpNVO685ix7hRt+JN/Kvx7SoZErJW5kTfbGwQ732dbBX2Lhszk8tucKhAxc2dRcxJz9qjwEg==
X-Received: by 2002:a05:6e02:1c42:b0:383:297a:bdfb with SMTP id e9e14a558f8ab-39a22cc31b2mr43392525ab.2.1722021893473;
        Fri, 26 Jul 2024 12:24:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e974efsm16428515ab.19.2024.07.26.12.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:24:53 -0700 (PDT)
Message-ID: <21671af5-94fe-48bd-a32e-d7f6204563f1@linuxfoundation.org>
Date: Fri, 26 Jul 2024 13:24:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kees@kernel.org,
 David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240726110658.2281070-3-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/26/24 05:06, Muhammad Usama Anjum wrote:
> Rename module to bitmap_kunit and rename the configuration option
> compliant with kunit framework.
> 
> Cc: kees@kernel.org
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   MAINTAINERS                           |  2 +-
>   lib/Kconfig.debug                     | 15 ++++++++-------
>   lib/Makefile                          |  2 +-
>   lib/{test_bitmap.c => bitmap_kunit.c} |  0
>   4 files changed, 10 insertions(+), 9 deletions(-)
>   rename lib/{test_bitmap.c => bitmap_kunit.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12b870712da4a..289b727344d64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3814,13 +3814,13 @@ F:	include/linux/find.h
>   F:	include/linux/nodemask.h
>   F:	include/linux/nodemask_types.h
>   F:	include/vdso/bits.h
> +F:	lib/bitmap_kunit.c
>   F:	lib/bitmap-str.c
>   F:	lib/bitmap.c
>   F:	lib/cpumask.c
>   F:	lib/cpumask_kunit.c
>   F:	lib/find_bit.c
>   F:	lib/find_bit_benchmark.c
> -F:	lib/test_bitmap.c
>   F:	tools/include/linux/bitfield.h
>   F:	tools/include/linux/bitmap.h
>   F:	tools/include/linux/bits.h
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a30c03a661726..6bb02990a73e7 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2420,13 +2420,6 @@ config TEST_PRINTF
>   config TEST_SCANF
>   	tristate "Test scanf() family of functions at runtime"
>   
> -config TEST_BITMAP
> -	tristate "Test bitmap_*() family of functions at runtime"
> -	help
> -	  Enable this option to test the bitmap functions at boot.
> -
> -	  If unsure, say N.
> -

This change will take away the ability to run bitmap tests during
boot on a non-kunit kernel.

Nack on this change. I wan to see all tests that are being removed
from lib because they have been converted - also it doesn't make
sense to convert some tests like this one that add the ability test
during boot.

thanks,
-- Shuah

