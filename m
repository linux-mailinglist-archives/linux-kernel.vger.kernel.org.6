Return-Path: <linux-kernel+bounces-247837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C861A92D548
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD291F22C91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9E194A51;
	Wed, 10 Jul 2024 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DaI26Pqp"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF4194A45
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626454; cv=none; b=tv8KZ9tZPBS3mwicYL2pPr7AdE1ptKnfsLbHxrjXiR+GB7f73IddgMep58WbrvdPfQuPIG/yrWzJIXJutFzszIAsaYK1M7s1SBZiMFwCDvdBPhsWAVys0VIPs3QfuLLyu2j0EgNs0f3WbTDs4AvyQWar6Y1X1UwZzAq/P1VKqrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626454; c=relaxed/simple;
	bh=kG9dLLSFH8CXDk+Ls/0m9m2fd+gLAdP+lh1KYL8btS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4uwgmaazhdU8xVz2vKCP3DXLFIoaNmrtUiFgV3rZkg33AvbZcFR4RHKIrVKnmr/VqzZ9b5frjAVKdzJ1qrSqCR1jA/ZBlcRQcFqtoLfCMWxvVyAEPFU/nw8Ij9vcY35XLTeyi+p3Kojw8BvR5p5lGEAwZQ1F/4/Fpv79HLcewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DaI26Pqp; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-38c64d2b3d8so374565ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720626452; x=1721231252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UixdOlCZpFc/O/lvDyEP3bThmhSxi0Uf3gr538tQvp4=;
        b=DaI26PqpeEah229RUBaSAL3tt20B4rF0ZHT3kA0+jjsnoeLyYjvEDAPS39nqvzPOT7
         jpX9lJ8GdDo38umSFEiHyzJmeDl4ZgOCz7JadN/GbmPYu2CZyIoYIGjpu16NtyKKW0U7
         9wKEaMJlcEC+vDP1r3xyMIQOSMSZPjOowOx4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720626452; x=1721231252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UixdOlCZpFc/O/lvDyEP3bThmhSxi0Uf3gr538tQvp4=;
        b=RvJa2ASupTbdjaRkQ5RsTEPyIxVcPcsuXLBFuGUiUv7y3ddOxGWxHtE0b9Jj4exOmA
         +o9wRg3wwJGL9OX+Knp5Txl7efcIKc/XsfYa4QdgVOKQFjaxWpH123SFtKRUWpR1Kgxf
         no3YVeXzzd+ULevx39anG0a1zpiMsCDOebDYII2uLvlIthLbwf9CLw3cww/dMj/ne+/M
         B1hK3znOgFsxoFXei+DuCUm76bansmqvhtPSCGEZCeVMkbzzi1zaAf00Bm92IAAUG/GT
         EnChABMj2162rUzvDcPm3/EO2H+ckRnywcNIUisjt2v4C+gLskqQcX2st21d9mxBYS7X
         IdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8vDiMwujvMekljRDS16W3o3jo/ovsd8Jr3M/fb2vz/mrxLKYni7t74wjP2n4BCIcxyR2O/M6jBhZs4de2L+fo8IDrbqPLdcxF0C3/
X-Gm-Message-State: AOJu0YyZ0QhJJYc9Ur/LAtj9Z6RWCYGD9ZAjP8VA27I9UavqSU6YE6cU
	HVovixdq1089qCk+vcFNhnCTgb2+5P1uHfrHOTuEJIzmSoFPLNV3KugOUz94ijg=
X-Google-Smtp-Source: AGHT+IHb8ETZgIZxVXQW2biS/YZKyo9pPMakuJfqHoicz5z8oRteqsbLGXlD3Ujwx0e3VAWfuXzn8A==
X-Received: by 2002:a05:6e02:f90:b0:382:56bd:dfb8 with SMTP id e9e14a558f8ab-38a56e1130amr58069495ab.1.1720626452024;
        Wed, 10 Jul 2024 08:47:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a49c1e578sm10175225ab.44.2024.07.10.08.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:47:31 -0700 (PDT)
Message-ID: <10a36c82-3c74-4fc3-abce-b2fe81956d37@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/breakpoints:Add return value in main
 function
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710021605.2900-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710021605.2900-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 20:16, Zhu Jun wrote:
> Main function return value is int type, so add return
> value in the end that this problem was discovered by reading the code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes in v2:
>   - modify commit info
> 
>   tools/testing/selftests/breakpoints/step_after_suspend_test.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index dfec31fb9b30..b473131fce3e 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -166,7 +166,7 @@ int main(int argc, char **argv)
>   	bool succeeded = true;
>   	unsigned int tests = 0;
>   	cpu_set_t available_cpus;
> -	int err;
> +	int err = 0;
>   	int cpu;
>   
>   	ksft_print_header();
> @@ -222,4 +222,6 @@ int main(int argc, char **argv)
>   		ksft_exit_pass();
>   	else
>   		ksft_exit_fail();
> +
> +	return err;
>   }

Unless this is causing a compile error or warning - there is
no need to make this change.

thanks,
-- Shuah

