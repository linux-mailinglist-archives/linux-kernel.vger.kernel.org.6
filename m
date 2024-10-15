Return-Path: <linux-kernel+bounces-366197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A1199F211
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E39B21582
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8A1CB9EB;
	Tue, 15 Oct 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FeIOaSIW"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AC1E282B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007793; cv=none; b=H6IRASTU04HgeOPCBuW2trP+nIlwO++h2WI+fFxOoPNFYqMCFRSf6gs/Ph7lZwnceheKOZG8U3MUnFmWbK3Qs78yy1NGHd53SkGBD46trCLT+e51JzJGAjnai01aKK8Mribpo8oIcFy8m+tUik1tFRTy+OaiUhM3cwfNinTQFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007793; c=relaxed/simple;
	bh=SZmQQEvzj1sK3lrhencXT1UrXomSJOeFE0GoLWS9yl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ9hKEDnbhTHTnBZVs35JrNUa8Px7N5XfZLUGJGLJUavLwv2T/0OyoB/EO66PGjMcmjvlEFh7OBqHrJoqrwF/JdOF7GvPnBSX5UdMc9Rm6gq6j+rGq1nNuCn+MD6E4qOWnx7v2G0uvdFhxuJlQEIXgBNVEZMxxqxFRkIoy81yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FeIOaSIW; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-835453714e5so247434639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 08:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729007790; x=1729612590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ajj3sR+OG/fmXMK7n9QfmmmRJDyO3mKj7b+icSfBwGM=;
        b=FeIOaSIWVAZT4KYWVKLxeE+qB6H8zvOzn0GJODrXbGyO3SnkvOP1E/tiAWcE9dlK4c
         9wJb20J8l77tLuRLDBWWW2GKf+9tiSRUt7We7qvg6QAKr6s05Pv2vtQNY2UqIVbS2KB2
         23F5m288V1D/fs+HsSU/Bd98DSmVyTUfRtHtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007790; x=1729612590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajj3sR+OG/fmXMK7n9QfmmmRJDyO3mKj7b+icSfBwGM=;
        b=MI9XM/Bkmz73Z/Bpfw/0XpVGi06YaHZ50oqv81zCB3p3s98iMSQiV8Nq/HD9QFtq71
         Ms7YUYkTEx1zoajUJln+XehGgO6Dfn4VUaxYK3jWa7o+95SQiUGRHh7hNJEe/Sm6IEqy
         dZX3TEz//Wm9nHlGSH26n+WX0Yehhdp/w3L2JsTX+gnA9V0Pbjt1PsXVJXGv1RORykWl
         A5F5/OuI3476G8YtA0DiWylJSeA1PAE3L0KyVQGZrfnKxyihzyTzNW5MXcD73sFPSEG7
         D2Hv43LvQVJZjwSa4UMiJasb7y+E4ZbW7iAr/LNdBD31B7Nma5E2GTbOaubGZjiRtmKw
         X/dw==
X-Gm-Message-State: AOJu0YxZlPunS/Ulzt+1gZ9pJLYEhrNP6hhHghNS784HC2Dp+ULm4dkt
	PQ0xKic1hYUpSw436Mv3Xpi8+wVWnGewmyyDSU7k1ifWg4kU49+p4RyGroNLZdU=
X-Google-Smtp-Source: AGHT+IHYoTPL3iz4k8vJd7tepn9pdJV/a5fIUVmq3xceu+F7hF09Pe5IS83gz3y88kzvBDJ62eMmRA==
X-Received: by 2002:a05:6602:6213:b0:83a:712a:6aeb with SMTP id ca18e2360f4ac-83a712a8524mr914309839f.14.1729007790234;
        Tue, 15 Oct 2024 08:56:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbecc6a612sm373480173.162.2024.10.15.08.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 08:56:29 -0700 (PDT)
Message-ID: <6dfa4266-bbe7-4c30-a3ee-1ff5a4b28221@linuxfoundation.org>
Date: Tue, 15 Oct 2024 09:56:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] selftests: ignore output files and clean them in
 Makefile
To: Li Zhijian <lizhijian@fujitsu.com>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015010817.453539-1-lizhijian@fujitsu.com>
 <20241015010817.453539-3-lizhijian@fujitsu.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015010817.453539-3-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/24 19:08, Li Zhijian wrote:
> After `make run_tests`, the git status complains:
> Untracked files:
>      (use "git add <file>..." to include in what will be committed)
>          cpufreq/cpufreq_selftest.dmesg_cpufreq.txt
>          cpufreq/cpufreq_selftest.dmesg_full.txt
>          cpufreq/cpufreq_selftest.txt
>          zram/err.log
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   tools/testing/selftests/cpufreq/.gitignore | 1 +
>   tools/testing/selftests/cpufreq/Makefile   | 1 +
>   tools/testing/selftests/zram/.gitignore    | 1 +

Same comment here - two separate patches and include
key people to the email recipients.

>   3 files changed, 3 insertions(+)
>   create mode 100644 tools/testing/selftests/cpufreq/.gitignore
>   create mode 100644 tools/testing/selftests/zram/.gitignore
> 
> diff --git a/tools/testing/selftests/cpufreq/.gitignore b/tools/testing/selftests/cpufreq/.gitignore
> new file mode 100644
> index 000000000000..f684d27f5d91
> --- /dev/null
> +++ b/tools/testing/selftests/cpufreq/.gitignore
> @@ -0,0 +1 @@
> +cpufreq_selftest.*
> diff --git a/tools/testing/selftests/cpufreq/Makefile b/tools/testing/selftests/cpufreq/Makefile
> index c86ca8342222..9b2ccb10b0cf 100644
> --- a/tools/testing/selftests/cpufreq/Makefile
> +++ b/tools/testing/selftests/cpufreq/Makefile
> @@ -3,6 +3,7 @@ all:
>   
>   TEST_PROGS := main.sh
>   TEST_FILES := cpu.sh cpufreq.sh governor.sh module.sh special-tests.sh
> +EXTRA_CLEAN := cpufreq_selftest.dmesg_cpufreq.txt cpufreq_selftest.dmesg_full.txt cpufreq_selftest.txt
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/zram/.gitignore b/tools/testing/selftests/zram/.gitignore
> new file mode 100644
> index 000000000000..b4a2cb6fafa6
> --- /dev/null
> +++ b/tools/testing/selftests/zram/.gitignore
> @@ -0,0 +1 @@
> +err.log

thanks,
-- Shuah

