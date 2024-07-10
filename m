Return-Path: <linux-kernel+bounces-248240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D828492DA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 23:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66C8CB23897
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3918712A16D;
	Wed, 10 Jul 2024 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K7GuTBHk"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8739FCF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720645282; cv=none; b=HaaOt6xjVrwvrFbVLvs5r1ZthRUkFJNmhNJ5JMFqPfDXHRXINstQJLPubCy1zOUs9zxnLjhK/aEDdEHiZvLeV/1PrJ3sK2Zw5JqzMOja/LUca0ygGx23NGBzJHgfN9uUh/AQmhlbNKKRDEJ9hNALY9CSUCKMZ8XwcY3Y9mnAv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720645282; c=relaxed/simple;
	bh=YPDmmNoAUyXwZHXSht6VtzUcGLW+qpswXPd+aTbq5ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF5vUHTz7V3QypB+2QXo/RBGAnlCzdGD0ywVH4VpEN/CKdaHE/i0KbxfEKwsH4gxU6d5IdHNFmM1UCwK9FBI+6lFCf2xQ6I7H9Y+z2xgWJ+++ScYNqC9qoWneBChUY8rtFiMS4bByR6qTC7OhftyWYSJM0+S6Lplgr6u3BfxmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K7GuTBHk; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-804bc63afe2so1024339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720645280; x=1721250080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FkmU4c0f3mtYkwmFpfIN45QWoWLCvMlQ38MMmzJf92U=;
        b=K7GuTBHkVCeQUSh0C2a/WqJGBRY4cK9DW15NyX7HvqZQJ7mvQ40+cXtS7ULDrsQaux
         61tZI6u98GGLay+7exNS7K3ecckPywvxZoQiC3WiGVQNf60XZI/aLEtPnyL/IwIrPyfK
         D8uOhxlEzKJVLkyyb013m3lu83GmW2ZAPAYco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720645280; x=1721250080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FkmU4c0f3mtYkwmFpfIN45QWoWLCvMlQ38MMmzJf92U=;
        b=EtWVzYgLcWzjMZxjsl/p4R4CWbGbU7QM3G4M58x4vm3RsxQdOhwCV2c//VKSNG7akC
         jP9DrPt3HFESxnfVjygqiAffsSeJ9jS70wHb63ZlSFdrF9FbU72vBXxBFSJDULraTo4R
         wkUMwd6guRR3rImtaDYcZSCE0i8kHae4lZLNC7O3yIvS/EKJd2gsxD3GhV+UXQyrGnLv
         fKb8B9cIBCT/WlTRWNoev2voyg4ZVkC9aO1FlS6VsLoxoEzZf7NeuvD5PFu7TZv2QPYp
         wZ5D6CVywMibJHP4P2sAWETmkzVEssNp7YYPCWsv6k5Rne3sW+3x7VD5YauUkFKCOPgW
         CPbA==
X-Forwarded-Encrypted: i=1; AJvYcCXYDzme1DRwl+2EFEp3R2xTYsoY2G0aXtoyYbR/U6DEiJst8cgDlTs4U/+KFxuuK9WrrzOyPh/F1WKCFXfThXrG4XwZLyXxlPBmAvZJ
X-Gm-Message-State: AOJu0YwiugTjr5AwmQarx59cxeFx618URd5z80OmhYLRAYE5JTNYBIPY
	e3GfS9RPD9sD37l1rXERQ3XVNglt6iMTLnKqsYzr6o1BdmiEAJFi/I22zUdL42Q=
X-Google-Smtp-Source: AGHT+IEMIw9ChT8Chrl80uN4BKJnJvv472LLG6KXSZMG/KiVRYehpKZ3nU8JHUAAO4irZmzBbux4MA==
X-Received: by 2002:a05:6602:6199:b0:7f3:d3ed:1ca3 with SMTP id ca18e2360f4ac-80001930275mr817986139f.1.1720645279844;
        Wed, 10 Jul 2024 14:01:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1c1385esm1388311173.150.2024.07.10.14.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 14:01:19 -0700 (PDT)
Message-ID: <561a35cc-4b66-4755-8662-805f870471e4@linuxfoundation.org>
Date: Wed, 10 Jul 2024 15:01:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests:Fix printf format string in kselftest_harness.h
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710032813.3782-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710032813.3782-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 21:28, Zhu Jun wrote:
> '%u' in format string requires 'unsigned int' in __wait_for_test()
> but the argument type is 'signed int'.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/kselftest_harness.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index b634969cbb6f..dbbbcc6c04ee 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1084,7 +1084,7 @@ void __wait_for_test(struct __test_metadata *t)
>   		}
>   	} else {
>   		fprintf(TH_LOG_STREAM,
> -			"# %s: Test ended in some other way [%u]\n",
> +			"# %s: Test ended in some other way [%d]\n",
>   			t->name,
>   			status);
>   	}

The change is fine. I do want to see you find the problem in the
changelog.

thanks,
-- Shuah


