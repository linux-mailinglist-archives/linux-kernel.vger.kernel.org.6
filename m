Return-Path: <linux-kernel+bounces-257519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D7B937B2E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23071C21C52
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D091146585;
	Fri, 19 Jul 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PIPqtdqI"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188A7145FF4
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721407249; cv=none; b=LrlBsM7IngGE1kVAhIE7MyBj4hhc0rYbPix9Ao3MNEkzh7McSt4v1zwAeYP9HymvcTBwF/rDUxB49Qzla1K0dLzp6fIaGUzGVHlFl9mGyeL3CmaPmpMbSYZ+5LeMiae5ciwEiOwk9nSh790Ssy+Y9X5P1TnT5gfKjgHSq4ujbMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721407249; c=relaxed/simple;
	bh=KudrRUmsxMvKCQV4i8wyzYeY65FnFpwKhaoFkFBDhJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nlefuplgYiUqAz6c4sAlwBBPyheDoAcwKnzD7opp+9TwMgaxpKIvMrwum5M3mKZkELxt4kdsmqrawh8JRqGvE9+PwDGxJCyo6om8ONGUgyWj/jjrME81Z75oN5ZTBGQ22GsCu3GSzzaDcGesX0SgbIRbRA2C73bQqVlSUwelbEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PIPqtdqI; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-804bc63afe2so9614939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721407247; x=1722012047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUVPkIYnRSgT8B0c+qK6jydiuc8GVJVQqbsYt4DVIKU=;
        b=PIPqtdqINjqfKzVtA/wqeMN5TBoo+JoFMUPq2aVgKDXrsNDFUcdJpTkxepLuuEM0Co
         +nIlB7BoKJaZug8WgO3x0eQi6PFs+312wy6I19T4hYz4C3Cr+0Y/z6RGWhf1BgavLZqi
         ee/3MLW2r38cVJZQiEXU5Co2zI99HAJXeN2bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721407247; x=1722012047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUVPkIYnRSgT8B0c+qK6jydiuc8GVJVQqbsYt4DVIKU=;
        b=M4HCtwoxAtsMkcScKROgMBEV5xrpLmI+VTb0MQCEUQJYyH2KrvYdym0F87YLLt66mK
         icJAPyEQTwJMzujLtAOR3q4rMK0kwcXWF9QZvJvrH9lALgKtRwo0JcVJdb2DimuE/GIN
         4UqKCKvTOhqHQnU+kCs0sRKo14EMmXxAyW/mibX2HQjHQ1B3olHJM5FGuRxHAlJ/uN6Z
         +bRxX+1GpuBrwlC9Pbkj+d3p77WSumVdmYxhKNO+GLNccCfWLfQwYbalAk3vHQxgaOrV
         mBCqmmcpNRZRwB4d/AyKy1/KOcACxF+SeZ8Ff2IFdcymjFn2i/mZ++1Tzy1lGMn5+Vw1
         scPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+f6D98gCi1RJUvo0FArg97dD96qKAnEkIoiBRbiVQsBDctun7MTQRH+5+1avg/o0LeXmvMo7+CWD9x3niXICGRANmY4sADmNz5cKA
X-Gm-Message-State: AOJu0YxVBVXILPmizDp1ISI1olDLy5/imsGaqhIeDSpVOidyDmcUEGdD
	JrlVHA0E49BWs9XsteTZFpaWTLHyJEDTbgyjwJ6+dOxdIRUixe8LvMKjOIn2vu4=
X-Google-Smtp-Source: AGHT+IG2bPp6ViogdgM8RoPbzjqSqGQtdTTcKNMf4jiu3HHo9MSqNp+frnbk9LMTyer6MQWkqVPC1Q==
X-Received: by 2002:a5e:890f:0:b0:7f9:3fd9:cbd with SMTP id ca18e2360f4ac-81aa223c98amr35894339f.0.1721407247126;
        Fri, 19 Jul 2024 09:40:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c2343d50c1sm386196173.149.2024.07.19.09.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 09:40:46 -0700 (PDT)
Message-ID: <9cf7f693-bc6a-415b-99c3-f6c59b871c4f@linuxfoundation.org>
Date: Fri, 19 Jul 2024 10:40:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting
 of pass/fail tests
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, "Chang S . Bae" <chang.seok.bae@intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240712073045.110014-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240712073045.110014-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/24 01:30, Muhammad Usama Anjum wrote:
> Use kselftest wrapper to mark tests pass/fail instead of manually
> counting.

You care combining two changes in the patch.

This is needed to return correct exit status. This also
> improves readability and mainability.

Spelling - "mainability" - checkpatch would have helped you
catch this.

The change to return the correct error fine and but not the
change thaT ADDS DUPLICATE tap header.

> 


> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/x86/vdso_restorer.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
> index fe99f24341554..8e173d71291f6 100644
> --- a/tools/testing/selftests/x86/vdso_restorer.c
> +++ b/tools/testing/selftests/x86/vdso_restorer.c
> @@ -21,6 +21,7 @@
>   #include <unistd.h>
>   #include <syscall.h>
>   #include <sys/syscall.h>
> +#include "../kselftest.h"
>   
>   /* Open-code this -- the headers are too messy to easily use them. */
>   struct real_sigaction {
> @@ -44,9 +45,10 @@ static void handler_without_siginfo(int sig)
>   
>   int main()
>   {
> -	int nerrs = 0;
>   	struct real_sigaction sa;
>   
> +	ksft_print_header();

The problem with adding this header here is when
make kselftest TARGETS=vDSO is run there will be
duplicate TAP 13 headers.


> +
>   	void *vdso = dlopen("linux-vdso.so.1",
>   			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
>   	if (!vdso)
> @@ -57,6 +59,8 @@ int main()
>   		return 0;
>   	}
>   
> +	ksft_set_plan(2);
> +
>   	memset(&sa, 0, sizeof(sa));
>   	sa.handler = handler_with_siginfo;
>   	sa.flags = SA_SIGINFO;
> @@ -69,12 +73,7 @@ int main()
>   
>   	raise(SIGUSR1);
>   
> -	if (handler_called) {
> -		printf("[OK]\tSA_SIGINFO handler returned successfully\n");
> -	} else {
> -		printf("[FAIL]\tSA_SIGINFO handler was not called\n");
> -		nerrs++;
> -	}
> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>   
>   	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
>   
> @@ -86,10 +85,5 @@ int main()
>   
>   	raise(SIGUSR1);
>   
> -	if (handler_called) {
> -		printf("[OK]\t!SA_SIGINFO handler returned successfully\n");
> -	} else {
> -		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
> -		nerrs++;
> -	}
> +	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
>   }

thanks,
-- Shuah

