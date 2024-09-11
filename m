Return-Path: <linux-kernel+bounces-325273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E9975744
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03081C22D7F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BB1AC42D;
	Wed, 11 Sep 2024 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hBlc+Jna"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA613D2B2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069013; cv=none; b=BW1GVkJskNPvCh15frAzaffDKsHx02b/+ewgVGh+9y284ROwAqNeIRi6Es+68giKNN8jwfjo5Le4wchpCbND5EecjNIdY+xOOuZTY82AawgDFI2DA53m/h+3jqNh+LHPGFYMtYGaWZR50OzpX0YRV/tnLH7aTGErKg7BxAT+HDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069013; c=relaxed/simple;
	bh=duZkB7OzdY1maYjWMUPDSDRbJnGB6Fkgvje/y+f4FiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fpcCgbx4xEQGNcDG8CPZ473hk0GEnCTYKmqIFjQw4CJAT32IZaWplqXkGvsGFUsXQ8loEtcqOXm2ZqRmAcx03Oe5CEmIsPucG+yVmx2hW3YkJPwDmv7dQgBFO16ybdwub1hSCpXClmQQ8jLziUJ4rLIuFSiEfNHWDyRSbOqWZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hBlc+Jna; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd93a6617so174911339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726069011; x=1726673811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZY8yVd07ExmC4dURcq6jHvr6f1VcZLSY5czQn/oqNDg=;
        b=hBlc+JnaN1NvOUtl4Mv9cHcbuZ6fJxdsvzFZ1PjJ6Jsm2VuPXhurIgxS9mrgoqDmHW
         +QW/cfQnfgpeCbuEiqwUkzyWwtNHxebJd19WK+Fp50saUXQxDWpgqLzYm0834mYZTbv0
         MA8B0Th1MZh0p5XSsiW10KNSfAWcYBddjc2kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726069011; x=1726673811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZY8yVd07ExmC4dURcq6jHvr6f1VcZLSY5czQn/oqNDg=;
        b=wwQsouR7RlbAedQMiZeJqdqTmeHRbk8Z0ELlIxliFj8hz5vh6NcjzS/Z6UddNR2f8r
         BdJj8/7g1iX9RbbQLgH7cG28eULmtXTFJDtthu1jUUBj7qJCI/jvk9oxywHsBx4/H3fw
         c8QM47dgsBpS18oS3TpNvIR/yc1E4vKXollSTtNGWMX4hmbf2tTMcssOxuC+at6jnykD
         wYNczPOQ9UcyMV7Embn2f5iHRFbUZ1SZHudz1FxL7MQCWxrRm2V07YuOIRhWQsEx7AFN
         wx32rRBTSN/wBhOCfJFqQrUOaEKEI6zWnNG7gOKKnz7YkwzNqPj5pCfZMtqylcAcT5wf
         4tpA==
X-Forwarded-Encrypted: i=1; AJvYcCWqfl0/dDhB7MtgweOwOrNTynQ+7qsXgu8aYrOkCxQEOwTmaQIP62kVntoUDTGlU0U/RQdPuZoKelP9wRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6suNaq1GQ9LpmeF7ffEaxyfNHaYns+nLrAhNOqKPzJtgF5bDi
	cqRFtGytDCSZx5w+dtEa8j1gJR8rofJLB2CUr3Fhyo1ygOSfjr8Wo6M+DHJRrVw=
X-Google-Smtp-Source: AGHT+IEA/TLwU/NYK0EOdgysz1P/i6GoXgtnxzEST4j5/9WBWQtBHCsSSruqekT2vigCfgBHXhbw/Q==
X-Received: by 2002:a05:6e02:1d87:b0:3a0:436a:5f99 with SMTP id e9e14a558f8ab-3a0576adea7mr124159755ab.21.1726069011103;
        Wed, 11 Sep 2024 08:36:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f433e66sm44449173.34.2024.09.11.08.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 08:36:50 -0700 (PDT)
Message-ID: <1c94b9bd-78d1-433a-959e-420a456bd40c@linuxfoundation.org>
Date: Wed, 11 Sep 2024 09:36:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: kselftest: Use strerror() on nolibc
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Willy Tarreau <w@1wt.eu>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Paul E. McKenney" <paulmck@kernel.org>, shuah@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240911044230.5914-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240911044230.5914-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 22:42, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Nolibc gained an implementation of strerror() recently.
> Use it and drop the ifndef.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/kselftest.h | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index e195ec156859..29fedf609611 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -373,15 +373,7 @@ static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg,
>   
>   static inline __noreturn void ksft_exit_fail_perror(const char *msg)
>   {
> -#ifndef NOLIBC
>   	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
> -#else
> -	/*
> -	 * nolibc doesn't provide strerror() and it seems
> -	 * inappropriate to add one, just print the errno.
> -	 */
> -	ksft_exit_fail_msg("%s: %d)\n", msg, errno);
> -#endif
>   }
>   
>   static inline __noreturn void ksft_exit_xfail(void)

Adding nolibc maintainers for review.

Willy and Thomas, please review.

thanks,
-- Shuah

