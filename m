Return-Path: <linux-kernel+bounces-263558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD693D7AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147F3B23B04
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677B417CA16;
	Fri, 26 Jul 2024 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TqwiDsSl"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0198718AEA
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015165; cv=none; b=lqWoG1JMO+PCf+oP2fjlEb7rQDEW3YkipY5daa8hTTtYwFeS3JCvb29IJD9NEb096NHENjycpFbvgMJvMUsJqd64F+EMmlfkGOyGDXs/c7C2HZz9GQ6YhC9ZcVasVZM6+A3NEM5qy4pjYAT5uKB1SLF7UcfdKc0ggoFyIXuZ65k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015165; c=relaxed/simple;
	bh=xGHmK9gWGUp0gHCFdD6XGO+i8NLts1NPaIMeFMTYSnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s87qgxX4XyUbWdwZhX7vmIVfAQTisASl5plHgcaCli/SB4CzXLCaKolBYDV8ocvZEJcGm3Vpi8f6lCbelE60lbsRn4GSjwATChVOt99i2qhzcijaA7nGurXXXyKtV6tasrQH09FUksz6p7llwnJz7HLRc4UxT9ks/JOhioqt9wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TqwiDsSl; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-810ca166fd4so10644139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722015163; x=1722619963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k4GinbwCPpupZoTNERMGOO+CrpcJ/xxlN9pDIVPEVvg=;
        b=TqwiDsSlxmH0txvSaWHWJOkHSM4D+3xUOftZRUZVCpH/lXyGx5TwNHR7+XAfM4tg6t
         FxqfXp+62k8AuKXQjNz86BiFzbnhzDaO1iifmlAAgxr1Ef8yTfWLuOlbBzCOa3asDWXf
         r8WS1/G6awfnmx0bBDR19vyv2psBnELROmW60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722015163; x=1722619963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k4GinbwCPpupZoTNERMGOO+CrpcJ/xxlN9pDIVPEVvg=;
        b=hJH4YlXdMmL4GvBwCVW63kVBarTRfGFEMTSldD321+A744Ql3Hyl67Wl8pqQAQavHZ
         OJv6t2gtkEqnedWHIA39BXQaC0ejikS7Eo+5EWAsjbFl1BOHZQKnrWqKQECJW8wIdXHC
         odn9drGD6BBtfH9XTMWrbb9luj6vFpDppGu/lAB5b1A6fWsNk9dCHXrRHpDqZBhJFVOM
         rHokjzKABmm0wjUiwSh7HiInfeIda3pZO35IE6srdwITp+DsGGHO1eWI8QWh1MsBulvx
         Wq6b74c1+6dYWWaaibHTElVq3AsM55o+H1+VCm9X5EfmE+8+gsxoQv+rZ66A++TOlAuS
         0O7w==
X-Forwarded-Encrypted: i=1; AJvYcCVsram2t+PGmODb8J/DEy6sq+hPo4/SUnFLPnBcRaSt9tztLbwMCPPJgdOw1cmN5vcv3Rbr/ElqqEl+Vv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDijN1lgWOQ7wC+OhD+XehBW6iRq0veRiNndr+iKXJcI6dUcdl
	Gq93JibskDfjzJHNXAZvkriXOvGAOQZKQT7cqoQSiAKscQDkwZtipHIk5aapt7rgg5WiTyrCgfE
	f
X-Google-Smtp-Source: AGHT+IHbRT3iZRW+Jej5kqYMWBksmgKgeIxN4ONjndWGY3FhrB7Ej8wWWEhyyeycHxTk96AcFxZGNg==
X-Received: by 2002:a5e:8342:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-81f8f3a5894mr144339139f.0.1722015163088;
        Fri, 26 Jul 2024 10:32:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7d7fee0csm118731839f.43.2024.07.26.10.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:32:42 -0700 (PDT)
Message-ID: <3e3d94d5-2a7f-4c05-b4ce-c6c8ca4e1186@linuxfoundation.org>
Date: Fri, 26 Jul 2024 11:32:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tools/testing:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, zhang.lyra@gmail.com
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240726023241.17295-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 20:32, Zhu Jun wrote:
> The format specifier in fprintf is "%u", that "%u" should use
> unsigned int type instead.the problem is discovered by reading code.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   v1->v2:
>   	modify commit info add how to find the problem in the log
>   v2->v3:
>   	Seems this can use macro WTERMSIG like those above usage, rather than
>   	changing the print format.
>   v3->v4:
>   	Now the commit summary doesn't match the change you are making.
> 	 Also WTERMSIG() is incorrect for this conditional code path.
> 	 See comments below in the code path.
> 
> 	 I would leave the v2 code intact. How are you testing this change?
> 	 Please include the details in the change log.

I am asking you to send the v2 change with updated change log
to show how this change is tested.

> v4->v5:
> 	Compile the kernel for testing using make

Running make isn't sufficient - please verify running the tests
making sure there are no regressions. Since you are changing the
harness, you want to make sure this change You are changing the
harness.

> 
> 
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index e05ac8261046..675b8f43e148 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -910,7 +910,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		.sa_flags = SA_SIGINFO,
>   	};
>   	struct sigaction saved_action;
> -	int status;
> +	unsigned int status;

I am asking you to send the v2 change with updated change log
to show how this change is tested.
		fprintf(TH_LOG_STREAM,
-			"# %s: Test ended in some other way [%u]\n",
+			"# %s: Test ended in some other way [%d]\n",
  			t->name,

%d makes sense here in this message.

thanks,
-- Shuah

