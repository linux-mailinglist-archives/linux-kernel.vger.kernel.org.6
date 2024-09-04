Return-Path: <linux-kernel+bounces-315588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5843796C483
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 18:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D7F28708B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662FF1E0B91;
	Wed,  4 Sep 2024 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkFcD23U"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3971DA312
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469083; cv=none; b=Ff241zNz+zSXPV1h0Bsid8fnwuLVMbBbXoCmqWuj2nhGvDW6nXb8gngpRoMitGZ5Jn0OMSRriv9s5qYMswoner+JsJfP9kH1E7MigyQLZG0sCR0nM2TJlo/TTJP09EWaETSc9GMQMo4dsIWBW1tR5DDrgOyXqNDt9cJvzHH108A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469083; c=relaxed/simple;
	bh=DHk7r5GSnoed1W++EtjusnzMP6hLR27PO9RzULp6bSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uER3D45J9UhAQZtls/8naedD8IAhGKrALzep4fYNxPx/XV66IzgQvz0Grk8Pv1yaL0+0HPIg/I+b1SCGgOGZ9YGUeVyfI1Pqh1/BN0bCRsw7pf+pi1Ge9OHzcGhHUEpOHxyWmo2AZF/3cVSYXZYQ2nD05Sm4ZCem+JAdjv9fodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkFcD23U; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82a2c93cdcbso208146339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725469081; x=1726073881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BjtNV9LGdeLrtx3HjEExZXdynW3SKUo8isfkGbW18w=;
        b=ZkFcD23UbQmzz56uVLwtGxEHqJfsEKAJRpCWsxNDhRNdGoNnHDInBWcvgMStkvqqLT
         vGWHvPbAGp2HCi/w80ULULzJkO3fTfUqfCeNldUZoTDwBz2CXBEWvzma8bFTFV2PWWWD
         fvt+6idUpOVYO8yWVj1fr2FxZD/3fQVQ670tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469081; x=1726073881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BjtNV9LGdeLrtx3HjEExZXdynW3SKUo8isfkGbW18w=;
        b=kJtlNIECfI7tXBRNafcywaxzeqQCkpVcuLClfMLlhvciDROMsoQTY3mwrotmzOBdSd
         LkVXpAYMs0O7de7X9Ci+cYxaeva23crUO5aZd81CkZF2jHGdJy1EtTHstGOByOfPW8nD
         Qc1ZFpC/+einL2gNqrt/lCzNoe9hLybCPbzBS3BBO2LgTSFE6BcTm+QVF7++YhOhfpPO
         +0smwtVR3BWWpczr3w2NymmxRtQ0gN5AXMeFkvXeHTYYyzorreqicvmMQ1b8xFvNRVax
         j2hNpB110rAI25ZqvGeZQe5ukXW/N3BmWeow1ujORwom7Qh/SKUvCCV99qHqMSi+ll2v
         VF8A==
X-Forwarded-Encrypted: i=1; AJvYcCVyancdpvj6d1lp4ZAihSRznXkMLP0s4KMnPIVfhgqgKlCj16RKkJ2+Ft+c1lY/Jxr6xJjJZcDjGb88OjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHQ2dlW8cS1Bh1D43m4+fLb3Gja5aHLCUJG056F8roEBT71es7
	fRm1I+Y6HD4lVdF0NkCU6vceug21ad+PrmadVhRLp6gFiFvcEyeKmA1r2ApxbsCMHrrME/YFc3f
	k
X-Google-Smtp-Source: AGHT+IEHnyuMkq3vfvdpdQdsRFrPuM9MRgs0smmPFDdJYEnrA9a3L7tXs+vVEffdLBBwcn6VDhmJcw==
X-Received: by 2002:a05:6e02:160e:b0:382:64d9:1cba with SMTP id e9e14a558f8ab-39f4f55f3d9mr173243655ab.19.1725469080917;
        Wed, 04 Sep 2024 09:58:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39f3afaf411sm37860525ab.20.2024.09.04.09.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 09:58:00 -0700 (PDT)
Message-ID: <3b7316db-42e6-488c-affb-297b33e08bf6@linuxfoundation.org>
Date: Wed, 4 Sep 2024 10:57:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: futex: Fix missing free in main
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, tglx@linutronix.de
Cc: mingo@redhat.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240904025559.7356-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240904025559.7356-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/3/24 20:55, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> Free string allocated by asprintf().

How did you find this problem? Include the details in
the change log - The tool and output from the tool.

> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/futex/functional/futex_requeue_pi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> index 215c6cb539b4..fb2dab46087f 100644
> --- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> +++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
> @@ -416,5 +416,8 @@ int main(int argc, char *argv[])
>   	ret = unit_test(broadcast, locked, owner, timeout_ns);
>   
>   	print_result(test_name, ret);
> +	if (strlen(test_name) > strlen(TEST_NAME))
> +		free(test_name);

Why not set a flag to determine if test_name needs freeing
instead of calling strlen() twice?

> +
>   	return ret;
>   }

thanks,
-- Shuah

