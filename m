Return-Path: <linux-kernel+bounces-247852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FFF92D591
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101A22894B4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65483194AF8;
	Wed, 10 Jul 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nzgwyhwa"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76D194AEE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627130; cv=none; b=okHv0mDa2wu3FTS6eJnfbYrmLN1EYanM/DHeCzka0PvPg+94NiVXPE0u+k8s81EEGKuAVFU5rfAhC+97YvrIgJq1fqopBbGD9t+URHSvp0bVtN0J1UGmoHvB6AwPWAPtJDBMOOUicOXu2sLdYk1/eT2g9LlOL1j+kHIpZC2jHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627130; c=relaxed/simple;
	bh=glBPvWkFzLQfz8TsVq9rjy/MlGkv6G8RoVIA3mtxWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SXA5/GYActg/QYRR7nLswyMQXZXvAq77k7lVXRn1ciwsSzHMA2+KPkdBzN4cyo4ygpqYlotVaNqzxDI35o6pWXD1Ejc35nSWESwQC68N8Puxq7CYiMlQTHwruc+7679gS2S+FpeC8lHKNW1sMwxm8NTmkBW2Q0VSRcp7XYpyp6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nzgwyhwa; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-375f6841f01so2653105ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627127; x=1721231927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGy2kaPZRr3hHhlJ6VMkV6cbieMFPeP7bwQHrR7G1rM=;
        b=Nzgwyhwa7F6UlS6mYoiE3ZpGLib3s4vnLgvfhseIV4prncIiVFzPesiP0XAPptQNIq
         zLOSjpZQfaZk28IQgpqR/f5Ww1yxIi3LW6tpwOHB1se1JjpEFcJCmK/8CJsvNELnBv4r
         n4mWrVBf5PWcNX3ARwdVQ+0/flTyeF1aECJMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627127; x=1721231927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGy2kaPZRr3hHhlJ6VMkV6cbieMFPeP7bwQHrR7G1rM=;
        b=oBj5aBkEGH0Hk82H/KgkfWay1X8GpGvDwTGlk8u/kjwHNS54WW/vemFEt7ck5jqgE7
         FfV8EjVHhjYToUHPqDGIDXBl9BH99JXd9enktGOWWPTBS4ze8Iews4eR3vc8TGFTPDR8
         q6gSgLM0pRjZ3fAXSrFzGC9f9rfj/sCtCGPNh+B8lUME1TMMPoRcLPow5GmTAeshH/0q
         7+C3cYrj2+/Cd0Vvlu81eX5lwr5Bs/wEnQtnkEs6R9sWt/rUDaqodXzsn9Yvzd2VukUD
         N1MgsVeWh4Y5hub8qEahJVtr7m4V2ImgU5/buf970FS/86yhCdyiaPSHxOe+yobbEZOj
         KUHg==
X-Forwarded-Encrypted: i=1; AJvYcCXIZC+n177YoDN3ZRzAjLLweYOnycPwmYFH6/TU4GVL2+RuwX4p8472o1QYcyhH6/nNJfM9lojIpxwMHe/vLJhBm7qb4sfEISLpdWY8
X-Gm-Message-State: AOJu0Yxsvta5KeONq4+IuasxKbyCJ7+KWJsdI0z4gEMjyi0f94qIbbtr
	3LPlx0a097VVp3ELopX3931EdkXBBlWwt+izgBroLuSEahlqFpsu00Rmft1Xv/sJG2zjanm5kMO
	r
X-Google-Smtp-Source: AGHT+IEgwRKV9JwE1SccNSo0JaXpaHOih6A9ET3LUZTOXD99a4Jq1dI6/XLx3p/8L3bMkmdBqFqAHw==
X-Received: by 2002:a05:6e02:1066:b0:382:774e:a820 with SMTP id e9e14a558f8ab-38a54366279mr62388965ab.0.1720627127323;
        Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4b870e83sm10117595ab.55.2024.07.10.08.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
Message-ID: <a3b43a5b-0e32-4ab0-a387-cf58b76525eb@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:58:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma:remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: chenxiang66@hisilicon.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 00:57, Zhu Jun wrote:
> The variable are never referenced in the code, just remove it
> that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 3fcea00961c0..c91b485ca99a 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -33,7 +33,6 @@ int main(int argc, char **argv)
>   	int granule = 1;
>   
>   	int cmd = DMA_MAP_BENCHMARK;
> -	char *p;
>   
>   	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
>   		switch (opt) {

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

