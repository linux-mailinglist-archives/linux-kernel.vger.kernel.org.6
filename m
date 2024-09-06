Return-Path: <linux-kernel+bounces-319029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A117C96F6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 16:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD98D1C23F31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A1F1D0DC0;
	Fri,  6 Sep 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ShhvpNBQ"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CB1D0940
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725632958; cv=none; b=o84bFxPHJFkvMaHJ0Kb/JIpsDUTMsVTtOFa8ePnfpf1z8rzsqAiHxNAoJ9yj+WMD5saF/Q2QpqzIgqc5K05WDkS7OMHQ1vhXcX9R0+ffNQpzKYK/RA7V1NP7qjPQ+/LnuiTWzNGu+tPNg3tTeBBKiohhEj3R1s/VAC2jAfNU26s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725632958; c=relaxed/simple;
	bh=Z7uwbWLL3gVBlQlRiNwnnYcNEC9uqFop/zsrlqxRwpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHY8j/2yszJjylrEV63W3QKkn8m4c38gg2Ok0l58ABAle3a78uJhOssqYj/+TottEokDikek706hgAwPLfa3GjvZb9wuCl/OVvPTv5Jqyzhx/huk6uOoal8RZfkKsrG/uBOOxtdocFszNS4x2ryq9wYMB9m29QLkxlqqhiFHo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ShhvpNBQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-715cc93694fso1822136b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 07:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725632956; x=1726237756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UwL0oqyE5031Tq289lAQ9RGIe66Rsgl972Tt73uO9Q=;
        b=ShhvpNBQYiuYEC4lnkGWreDRRlaX4Wg9+42DBTYUSkecFoP7k1oF66xeTklBB/v4Pz
         ksNAP4PlLApqVj9dRVu265YBf4LVIK5vbxs552Aq6FIXrEg8gShvDWbWHlqkL9D/jlOB
         n0j7dE1qXOtru/hsqbc03m1tPF6dn7JzGFNmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725632956; x=1726237756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UwL0oqyE5031Tq289lAQ9RGIe66Rsgl972Tt73uO9Q=;
        b=Z3Py+YGe6ICc1KKgkn5UbIbsiM6Dk1sGOhBz33mcnaZL4Y3G2MoNWOsravXSme9I29
         b9YzAy7cN1dq9nfDpIouioo1SUmMj+98vPuNBrDmgReZCWxr/2VivyC4HBzVRclMGvQ1
         S4Sj0cC70J4+2QjfbXIh+g4khpbH8fZdyQEyz+RQe8XTxYDuDpOXFjVt2vJ/vVzvu6XT
         F3omMdOHxICDTxlwf/IDHEejgA2Q8uvOGCQrceLCBe10i/tDN1UX+ZUgJyYWk+deYrP/
         3Oxxgahu6AVM4DN19ySyoA4T9pio16KTstU9SLuB8+l1c9B/LGB1Az0KDWqVliaKWaoy
         WIdg==
X-Forwarded-Encrypted: i=1; AJvYcCXU48fsjM1wBxIpN2GFLyxqUCli5DdI9gzeW7pXhhCjL9PMWy19NIMbPMezTRpCalQ6Pvc8aYIAcu0+pAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAh5gv955+RpiYQ3EyG5GP0TgMTlwu60lcPYN670WezBiPZayJ
	cQPMLnju9TltecOXP4Iqfh6KpmXhj2ejU/czMMkxWmsa8K7geE9jeBtCpeve+o8=
X-Google-Smtp-Source: AGHT+IGSzBGpMso7huTcEfzmj5vM49oojE2pcaTzBsLBUDADFxzjmFOeHYF0bYrNLu3H6+9i0zZ0EQ==
X-Received: by 2002:a05:6a00:4b53:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-718d5dec32fmr3353574b3a.3.1725632955887;
        Fri, 06 Sep 2024 07:29:15 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71782eb5352sm3904280b3a.154.2024.09.06.07.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 07:29:15 -0700 (PDT)
Message-ID: <49d07daa-622f-4c04-9d00-221f8abfb4f3@linuxfoundation.org>
Date: Fri, 6 Sep 2024 08:29:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/timers: Remove unused NSEC_PER_SEC macro
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, jstultz@google.com
Cc: anna-maria@linutronix.de, frederic@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tglx@linutronix.de, Shuah Khan <skhan@linuxfoundation.org>
References: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 20:52, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> By readind the code, I found the macro NSEC_PER_SEC

reading

> is never referenced in the code. Just remove it.
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Running checkpatch can catch spelling errors.

> ---
> v1->v2:
> 	Put together files with similar problems
> 
>   tools/testing/selftests/timers/change_skew.c      | 3 ---
>   tools/testing/selftests/timers/skew_consistency.c | 2 --
>   2 files changed, 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
> index 4421cd562c24..18e794a46c23 100644
> --- a/tools/testing/selftests/timers/change_skew.c
> +++ b/tools/testing/selftests/timers/change_skew.c
> @@ -30,9 +30,6 @@
>   #include <time.h>
>   #include "../kselftest.h"
>   
> -#define NSEC_PER_SEC 1000000000LL
> -
> -
>   int change_skew_test(int ppm)
>   {
>   	struct timex tx;
> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
> index c8e6bffe4e0a..83450145fe65 100644
> --- a/tools/testing/selftests/timers/skew_consistency.c
> +++ b/tools/testing/selftests/timers/skew_consistency.c
> @@ -36,8 +36,6 @@
>   #include <sys/wait.h>
>   #include "../kselftest.h"
>   
> -#define NSEC_PER_SEC 1000000000LL
> -
>   int main(int argc, char **argv)
>   {
>   	struct timex tx;

This looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

John, I can pick this up with if you are okay with this change.

thanks,
-- Shuah

