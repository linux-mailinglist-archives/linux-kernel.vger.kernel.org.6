Return-Path: <linux-kernel+bounces-336120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6792097EF73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF360B21C91
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745A419E99C;
	Mon, 23 Sep 2024 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPu9a5dn"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CF719E995
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109887; cv=none; b=PSBWJBZJjVcWSr2sx6y8vitIK99iaDmP7C3l9Gu2KIu3PI/VekUPiWukRrHUZmsQDHy34iY+aVvfCa3c37CxPDFvIGDjqafXehMW+Yy9fsYB075lx6K0L/xmnHWQ5qmL/c36O295NHzjn6HcZ5SMafagmyVzjxwtvtcgkaQoYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109887; c=relaxed/simple;
	bh=jIzpwkBvohPZ42RJk7QZSzfZGSTG+zibn9cWdNgkWoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THTajqif1BY33jzwL3+RgEsVkVh/eZWbeBpUojRo/LTfeloXPOZpQdFbL1lQTjcKcP6Y4ley6xIuL7NxxgTbQPQRYU+kWVVjD78NkkibjhVMM+eSsZEiM/nwoaM0JXQXDe8QeqIASSBfCxeSlkwRj4Au8N4V+fbV0y8Z9wUXrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPu9a5dn; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39f49600297so16664285ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727109885; x=1727714685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gjDcu1qjAZXv0N7bHIy/5adY2cLrLfFMbmRWe9h7RCA=;
        b=aPu9a5dnInwWtxAExvIrXjHp0SgjGa+76XCYsAzod/b560stbR1JIWEwWEqUlHZVRS
         JlIGQUx/tL9H+mGrYA2ZaD/NYSCkh+rX50pSnzoe3HciTDXzgKffPCYrVo95rRMzLy1s
         WDU2VEou9kIkHyGp6gxV+srxYf6RfMc3j8N50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109885; x=1727714685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjDcu1qjAZXv0N7bHIy/5adY2cLrLfFMbmRWe9h7RCA=;
        b=gU/0taCcdAUoAhYsK5ZeWoULT80MxOFXier/7yzJfOkmvEZstgmTl/Vndv1c5vzPX2
         YNZT+JU6g6PMAissSVtf54xZMtD4tCdEAT8tsvsslBXnQQTGGHmvG1UdV1TADiQnaIjd
         ZpQVyqIKBf/bIUEBECPkKthUCAn6q0vtK3f2JAZPV62xnwbHsEt1XwFG4bnKn1D22ELW
         1vMzuqlD9kzlIycAaJR93a4oj8jmNogi6RI0mh+3S2UEEUR+ZQ+MoQxujjPXks+gAdU3
         7ilMLARFMeWtNFBzN1/pXwrC4iA3hDEB0VCrVm1a7QipWTxWtcT5wfyiR1WVjdy9aY+5
         UnAA==
X-Forwarded-Encrypted: i=1; AJvYcCUYRL9ztCdUMTTtEOdDnVlPVc5lcw1lpg3ZXQd25qKCoTVK+onqQg4P/XGBvCf0kwM6Te3FazWyG+h3GXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyzbV7LKdmpLA99Vymdw8KeXyxwAle04sJ1bPeX4yMJSGPwzf
	IEuPQgA44Eczxp2FYdLwad6XRXUOxSKeUVGtUYDUbBsMz7GE2gqL1OVrJoLO9YQ=
X-Google-Smtp-Source: AGHT+IFeE7PSHtYTy6cCbJSWJ5DjlBn+o1h78m0KFuLtOxLv7/WV1afXrTm5YCgUpVC62dLJGRMTmg==
X-Received: by 2002:a05:6e02:1a67:b0:3a0:451b:ade3 with SMTP id e9e14a558f8ab-3a0c8c9e4e6mr103481185ab.10.1727109885323;
        Mon, 23 Sep 2024 09:44:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed597dfsm5222919173.166.2024.09.23.09.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:44:44 -0700 (PDT)
Message-ID: <6e71e7e2-5b69-488d-b3fc-e547d6b4b042@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:44:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] damon: access_memory_even: remove unused variables
To: Ba Jing <bajing@cmss.chinamobile.com>, sj@kernel.org
Cc: shuah@kernel.org, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240903034300.10443-1-bajing@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 21:43, Ba Jing wrote:
> These variables are never referenced in the code, just remove it.

remove them?

Add details on how you found this problem in the commit log.
Send v2 with these changes.

> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/damon/access_memory_even.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/damon/access_memory_even.c b/tools/testing/selftests/damon/access_memory_even.c
> index 3be121487432..a9f4e9aaf3a9 100644
> --- a/tools/testing/selftests/damon/access_memory_even.c
> +++ b/tools/testing/selftests/damon/access_memory_even.c
> @@ -14,10 +14,8 @@
>   int main(int argc, char *argv[])
>   {
>   	char **regions;
> -	clock_t start_clock;
>   	int nr_regions;
>   	int sz_region;
> -	int access_time_ms;
>   	int i;
>   
>   	if (argc != 3) {

With these changes:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

