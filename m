Return-Path: <linux-kernel+bounces-215184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077F908F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 17:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67C7B2BC13
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 15:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2AC16C691;
	Fri, 14 Jun 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JEFUOk64"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11840145B07
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718380211; cv=none; b=SU4lZy6XecZYE+ymplyacv3CFjU+KhIDP9lPgcZ7zLNS2a9mjPNm6qBEgrajLvTTySjnu0qWYJXKzI3y1ujWlV4DYiH4T1akqkIgS6UM2ia0hENzoUirmRqGt0QCbqoXOYUng4FzqcfUkc7xNiWg+a5weivBWOsNXf2S3A8JC2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718380211; c=relaxed/simple;
	bh=Of89akR2CMY7eKqsbXy1fnKj5CKC+LPr7lSvKGw04Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIupm1BwON26jSGKw6nMjxISpKEhyRWQUwbuFSaTVEiIAilzVufAy27pggAOQTX8a3NyI2d7f2gDMUMXhbYbJQW274bmWpjl0xLmOeLi/8Q1cZNyxz1kdC3zLy4/KLXG0OyzdNNctBdiBokEvS2OFmJToeMtPcy6/epCUib5Wvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JEFUOk64; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7eb8889a0baso11500339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718380209; x=1718985009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leswT/yscKTO7Z6a2Wo4H81HBTQclZtl7oZCfZGayWM=;
        b=JEFUOk64Xehez37N8Ti+kOaFFa9DgSD7wBfgcPUjejHu4TsQm/SjvO3cjT5LcSZ1sG
         uexAbovOukDc2l2/xKJ4npb9p1ufMB5fWGv5vMfqOSQoBDWhfgQeWYtAQWEj8NY1mTHR
         ENN1fVISWmorYKmRkbCdxlD+h91reH7b+UG6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718380209; x=1718985009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leswT/yscKTO7Z6a2Wo4H81HBTQclZtl7oZCfZGayWM=;
        b=GvyE6eoH5KxAFcw2LdeRAm24jBPiME5orTJo8uQlUg/LEwHziMQCk/kuj/jU42ReGI
         aVAAxU/MJkEFAkXsvWO6hCM0jsWb5pBvqx6v61CxQw7uQL6FCdAApUVzkuqktqGl8e62
         fZAjzgTya08Xu+CgetSmRTY2Zr0brLJfkvjNXvXN/jAWXlquVwbFIAGiubCQElcyqquP
         B8I7rnVWLH+pG9tu1jpFdclQNome/ZMFHY9I7/BDEOXBgcpn53H6L0cuPBvPt2gdEqpq
         kSjBfzv3YvVTo5w9Qb15gscy4CsN2ovCwHkzZwtF8JcyvX2NCsbQrjeCiI3H5f1teMCP
         4rbA==
X-Forwarded-Encrypted: i=1; AJvYcCWOo6rUoHYGabcYBXXr5ZvgYUVil4VgJL8z8EVRF7Sij2shLkHRKRrBOUvggeb3elC111sqfgq9vq3prQSG9f5+6tVlIVIP2h/kJcJA
X-Gm-Message-State: AOJu0YzbuuBvn/D3LHyNLA2B/7zMjWh4sukWgctxkmLQJYKm0hGpDTqC
	OmiCa8fP6I6Bfndj3yVOijY8Q/KdteN4fx1a1xghYw6JU4snFmGQv0IdWl8moy0=
X-Google-Smtp-Source: AGHT+IED3HSMfmB9vnuFFL8MFycsr72SN22gD5z+fwYlkLvh2hJe5W48P0uXhfkKYgekiV4qCO0SEg==
X-Received: by 2002:a6b:6b16:0:b0:7eb:730b:f0c2 with SMTP id ca18e2360f4ac-7ebeaef9959mr278165839f.0.1718380208121;
        Fri, 14 Jun 2024 08:50:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b956915c17sm979497173.43.2024.06.14.08.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 08:50:07 -0700 (PDT)
Message-ID: <90e61842-e933-4d6f-a3b5-c802382fe96a@linuxfoundation.org>
Date: Fri, 14 Jun 2024 09:50:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] usercopy: Convert test_user_copy to KUnit test
To: Kees Cook <kees@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Vitor Massaru Iha <vitor@massaru.org>,
 Ivan Orlov <ivan.orlov0322@gmail.com>, David Gow <davidgow@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-hardening@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240612195412.make.760-kees@kernel.org>
 <20240612195921.2685842-2-kees@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240612195921.2685842-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 13:59, Kees Cook wrote:
> Convert the runtime tests of hardened usercopy to standard KUnit tests.
> 
> Additionally disable usercopy_test_invalid() for systems with separate
> address spaces (or no MMU) since it's not sensible to test for address
> confusion there (e.g. m68k).
> 
> Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> Link: https://lore.kernel.org/r/20200721174654.72132-1-vitor@massaru.org
> Tested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>   MAINTAINERS                                |   1 +
>   lib/Kconfig.debug                          |  21 +-
>   lib/Makefile                               |   2 +-
>   lib/{test_user_copy.c => usercopy_kunit.c} | 282 ++++++++++-----------
>   4 files changed, 151 insertions(+), 155 deletions(-)
>   rename lib/{test_user_copy.c => usercopy_kunit.c} (46%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8754ac2c259d..0cd171ec6010 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11962,6 +11962,7 @@ F:	arch/*/configs/hardening.config
>   F:	include/linux/overflow.h
>   F:	include/linux/randomize_kstack.h
>   F:	kernel/configs/hardening.config
> +F:	lib/usercopy_kunit.c
>   F:	mm/usercopy.c
>   K:	\b(add|choose)_random_kstack_offset\b
>   K:	\b__check_(object_size|heap_object)\b
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 59b6765d86b8..561e346f5cb0 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2505,18 +2505,6 @@ config TEST_VMALLOC
>   
>   	  If unsure, say N.
>   
> -config TEST_USER_COPY
> -	tristate "Test user/kernel boundary protections"
> -	depends on m
> -	help
> -	  This builds the "test_user_copy" module that runs sanity checks
> -	  on the copy_to/from_user infrastructure, making sure basic
> -	  user/kernel boundary testing is working. If it fails to load,
> -	  a regression has been detected in the user/kernel memory boundary
> -	  protections.
> -
> -	  If unsure, say N.
> -
>   config TEST_BPF
>   	tristate "Test BPF filter functionality"
>   	depends on m && NET
> @@ -2814,6 +2802,15 @@ config SIPHASH_KUNIT_TEST
>   	  This is intended to help people writing architecture-specific
>   	  optimized versions.  If unsure, say N.
>   
> +config USERCOPY_KUNIT_TEST
> +	tristate "KUnit Test for user/kernel boundary protections"
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds the "usercopy_kunit" module that runs sanity checks
> +	  on the copy_to/from_user infrastructure, making sure basic
> +	  user/kernel boundary testing is working.
> +

Please carry the following line forward as well to be complete assuming
it is relevant.

If unsure, say N.

thanks,
-- Shuah


