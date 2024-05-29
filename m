Return-Path: <linux-kernel+bounces-194741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033758D4144
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 00:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E9C1F2352C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E1915D5A8;
	Wed, 29 May 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JuzAeCsu"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C845415B11E
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717021223; cv=none; b=SaDF5580iDEia37MjAZ2qwwZ2xZelWLKpVmjvY1jsl5REOPZpZGbOBj84disuzSgQu5Ejzx4fP+yAReJ8wUg1zRrsAKm6Jkf2V2yNXVvFCQzmn70ZkkBguewsaLZ+INo//91w6yOsnl5lpXcHDykxPNN12bP4vv8Em3Dp//YRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717021223; c=relaxed/simple;
	bh=mMYi9aNUDo4Cxz3n7+bIVIuoJAd5/aBAYiNtOR+lnT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbmryvzQ/DsJW0oQ5/Ysd4LUFtWzHCt4f74iV7HvOXJs9uB9iKbQPChuua9cJawSK1lbYj8dN7wF/kjgnhhrt09fblANm8IHhRat2kMkcdhSGPa0BNOzYxARBX9eEOYBgQd5rvcJHRnR9VesGE/pcW9L1I07B1oodFqmbX9xktk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JuzAeCsu; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7e24bcce578so1904139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717021221; x=1717626021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqIyzvTkeA6zlhgHopIt1eourCo8hQ0gEK3kB/MiNgM=;
        b=JuzAeCsuj9OuMjzaIQmeHxptLmjXLQnJUJqOYFj4Ptj9FcSXtSR8oW1qX/V+RcxMDs
         KDrYNo7bN/mcEalVoszmkuWs8fYSvpB34Yul5TjotOQxf9IL895Ekv0KJOfks1SVN9s9
         eChywa+O+MGwoO/YKatFbn/K6OH4MENUi2OGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717021221; x=1717626021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqIyzvTkeA6zlhgHopIt1eourCo8hQ0gEK3kB/MiNgM=;
        b=qaxoK/qZmM/GvhA9tqZsvaJqR4ZFYRGDcZ5veG+sbh+8XxJB1jQotiPOiAh6gdPcFM
         4yoKsG9reQb8eJbORgv1+1HpFYtHe7rypUTcvdCTYD+aDwPeNVefdmA0NskYEC/jmIuP
         GaDMzjB2vxROAYFc1A7yKHGOIQRSkvP7eD8s0dNZKRwDo2vtAzn0RO7BSmQT/uRniXho
         ldCqqufr8aMVJIcsKDzmmHpJffMMT5vP4T3QdgR+C8LvvLcBJQ6RSrLB8ItAIM5XI2KF
         yuQX2zaNmSAJKs+syLKGzql28SxlmZnCWj2poOKuVGvslOjg5EIFKgagVXy9kiQlpR+E
         en4w==
X-Gm-Message-State: AOJu0Yxszkf7JNLUWHr7jwvtg/5t5BoQk2mY+XxGqU+RWYO6Xx22x+Sh
	hWQnIcvP8TZoGcE12uNN4N2eF313xKB1yDCtkJ2ifGfcya4EpgAi2fyW91iZfieYaec2z3eeEvc
	2
X-Google-Smtp-Source: AGHT+IGN1oWI90wrMEiMI6sGuVOqtYT1CiAEw2A2euoSlGnG87X1DOMKyfYSgfTF8XB61Cyt02Mi1g==
X-Received: by 2002:a05:6602:8:b0:7de:e04b:42c3 with SMTP id ca18e2360f4ac-7eaf5b6efddmr43687839f.0.1717021221086;
        Wed, 29 May 2024 15:20:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b0bd61001fsm2138635173.125.2024.05.29.15.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 15:20:20 -0700 (PDT)
Message-ID: <c2eec7d1-27c3-4089-beea-168d19062aaf@linuxfoundation.org>
Date: Wed, 29 May 2024 16:20:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/openat2: Fix build warnings on ppc64
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>
References: <20240521030325.58095-1-mpe@ellerman.id.au>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240521030325.58095-1-mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/20/24 21:03, Michael Ellerman wrote:
> Fix warnings like:
> 
>    openat2_test.c: In function ‘test_openat2_flags’:
>    openat2_test.c:303:73: warning: format ‘%llX’ expects argument of type
>    ‘long long unsigned int’, but argument 5 has type ‘__u64’ {aka ‘long
>    unsigned int’} [-Wformat=]
> 
> By switching to unsigned long long for u64 for ppc64 builds.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   tools/testing/selftests/openat2/openat2_test.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 9024754530b2..5790ab446527 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -5,6 +5,7 @@
>    */
>   
>   #define _GNU_SOURCE
> +#define __SANE_USERSPACE_TYPES__ // Use ll64
>   #include <fcntl.h>
>   #include <sched.h>
>   #include <sys/stat.h>

Applied to linux-kselftest fixes for the next rc.

Michael, If you want to take this through, let me know, I can drop this.

thanks,
-- Shuah

