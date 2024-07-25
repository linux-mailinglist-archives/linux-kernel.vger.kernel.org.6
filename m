Return-Path: <linux-kernel+bounces-262371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A393C622
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BA4628213E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4763E19D091;
	Thu, 25 Jul 2024 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NHvVHMO6"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191312D03B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721919934; cv=none; b=PEAP3YdPWah7QeXw/z60MwI4zZPPyB1LKs9gmQB29nY2QNztJPApifFyM0gJzVQnbYWiWTlexujl0/6VGsm9wJOMf76mjA0xrwtAlGzGm8KpUZCVEk3SIBzMYCK7ba4FGuGYq7qohpgPYOe5qx7wYviVUOF/+nsZ8ep2I40+YZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721919934; c=relaxed/simple;
	bh=nwqay9Yzc9V/MdcskLBTA8LUyLT1NESrwzti7d4cEZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHKhYn1z5vbrB6xs/wXUqQR5vcaVFgtRKbBz8+HL4ivVA24auNWnFcQUy//oKg5dQu4hvXrvXbpVt2VzbPzVOkoDM5gIvWXWjYSN8lQPv1338aNn9O6RgQvfvJqdvuJM34DmIdB5A4e56VJP7ntI/NgVQDN3xaGADuB4WEfgkuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NHvVHMO6; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-812796ac793so1695339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721919932; x=1722524732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BvyOYhnjKhkMcy56pvbeVq9X+bXBEVFjavfRZVHgAl0=;
        b=NHvVHMO6EsuObX9eSJa0Wr0M23he8b8pAQ1+vLbFUejxbWaXdqsGaXdAebBJ1oWavJ
         NzVwTkpIt+jwX4xKlAbtCx29vpcTvsVD16G2LJlL/d2R7LFaKxSgYYLN6FQ8gUQgNEAW
         k0BjFab3LxsVt7ZSfg93unOQ8Hy6pw7HivpKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721919932; x=1722524732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BvyOYhnjKhkMcy56pvbeVq9X+bXBEVFjavfRZVHgAl0=;
        b=dz6AJbtisSgRE8Sr4Yjn3uyNKITJdlCQ1Ik8EOOLMvDQl6NvX8MlFWZNNgIdlupO5t
         QzQa8Q6ts5QppfjUiK2wG+aovKNhFLTHi6rg6uOrbx5+h9DSXHi+0fykqRT68jzMNZbc
         BYPTqCKpXgSyClO61n/Sm1eI3pZxVv8elx+JNcZGg8C5bC//LfxRhv1eBsJQ9jzQpHI3
         ADQzlK/RgQ+4/bPfy+TR12ujsI6xfuctMAbDNab+oyfJXsl0DJvSY4nyF3tJqYvcr1dg
         FovjJosv63iUpPcPO2BPlsOdl0T/41qy8notNR9hX+42dg3b9fLF+HBOYLrXxyK0kBOC
         TOng==
X-Forwarded-Encrypted: i=1; AJvYcCWJr+M+OyHTGXjrDs9wxFLR7ce7ueeE2wnQwFvx8xJdP/QUt9cFj/DEy3f2wlRnXkjAARNw/LaTNKOoJhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3MiP4ZdtRKtvraaMxPeW7yOVe+llOJc5HQqRzedQ4g23qEdt
	j32gW1eRvQ7av7Q/NT9ka8IwffO5jFyeBVRdKlr/wNBSK9jVCGS/Op0kcnjPvodSV/TQxHOmH1Z
	V
X-Google-Smtp-Source: AGHT+IFLdCEnuQWY5ReTzoOOPS5jvp18TA2fpDMWDgGVkRl6Jlmv4BH8fa8DGo9D8rxZVrJxNHXW6Q==
X-Received: by 2002:a05:6e02:219b:b0:38e:cde9:cc86 with SMTP id e9e14a558f8ab-39a22d3271amr19643215ab.4.1721919932155;
        Thu, 25 Jul 2024 08:05:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faa83a0sm359387173.55.2024.07.25.08.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 08:05:31 -0700 (PDT)
Message-ID: <edd26914-9394-40d4-824f-203c7d4e3833@linuxfoundation.org>
Date: Thu, 25 Jul 2024 09:05:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tools/testing:Fix the wrong format specifier
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, zhang.lyra@gmail.com
Cc: shuah@kernel.org, kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240725023401.13365-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240725023401.13365-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/24/24 20:34, Zhu Jun wrote:
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

This change is different from what the subject line says and
what was in your v2. Also you didn't tell me how you tested
this.

Sorry I have to nack this patch.

thanks,
-- Shuah

