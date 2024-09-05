Return-Path: <linux-kernel+bounces-317501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6896DF2E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96ED1F2424C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2C19EEBF;
	Thu,  5 Sep 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hwgKkTyW"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9D4AEF5
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725552512; cv=none; b=Wjl9GtKJwbhO0LHL8mPB0wkiar37vr+hFky7TWKHOsfKpcJO6tHKDtr6J26QmJjjAMiosuTO+Rm2bsmXwVeQsr9C3IV4HhotzsK1XXY+N1xf62N43m9IeDSK8iHmex9vM2c7+DxM8ogmexylxvDvfTHR5rQ+3C/vDKZJIBh+dHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725552512; c=relaxed/simple;
	bh=cuduEfejvKDdkbF8x7hNIMS7Tne31cgqmqyWhN0+h+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYtc88dfUbqeshuDvNElXXJjUOpvFS7mnDWtmnLfXe1QRVqGMaHGJgEROi5V2VcTa0xa6UYXypkx6vwKuP3znoi8CFt46XuYyqKjgSO9H0sqLV4NVFE7ioQisDHe/owH4X3yREnwM4LaQsMIJqkYDTxZVH3KYYDTo6qNqcSnQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hwgKkTyW; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5dd43ab0458so602559eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725552509; x=1726157309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/WCYr1JbYjj0ZMzhtqR6ayRKYajzzVLnjoTs1Mi4yE=;
        b=hwgKkTyW23VpeyAsBgbt2OczXe5oeqUNQ5Q9B7pA/zB9pbTj2D0x9f9SSrgVXZAk0A
         MH5JAjyiqUukIksCkTWq1syZCBzrx7SsoIN8iNWVtkgk424vCS4evwQDbekI8yZV7Qjb
         zvbRoGovMS+8Jpx6BBy0PD39yMyrCopiiy+tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725552509; x=1726157309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f/WCYr1JbYjj0ZMzhtqR6ayRKYajzzVLnjoTs1Mi4yE=;
        b=ZtkwQu8Q7Qvyg2ThyxBwkR63dC5KwSV6GGGK9pdMSjI9+bvdBf5sciRnBcAj1RZlya
         nsAxkfh/l6ppXR/fLNo2sr46mvWikgfdYnJM40q/sVgXoT98HSCLkc74/f5pfg+J97ot
         SSqhyMH3tjspR5ggoxB18NkulgVaAWalUhWwaGZNSSz76FSpGa3D/FbglB2njmIsEEBg
         ZGrCojTlONJLze8Kn4SJSai7D3m7Wvd+h8DoTKbhOE7XJyWjF1sSssh0YFFWMCRq78sa
         KZcgjyTDUGIYJAnACtOcFwjHFdPS6/IZMnM9tcoVJK5U3Ph69UddF5Qd94drLGf07wNW
         bG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT1RVlaTkMYyuGei+v97dyf4NjHqRERGTm8vAzOaSsW4WSE1Xa7SWf4Wz93KdFYCYcuh0QrN8oRFJ0Fq4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3FsDJ4N2ptgtvsV8TCq+X6b65Z6Z5GMfB7f6ynnRhLEqyqvsR
	j4Rg3fOEOW/syuw4Jz75MdJUcp2JfTDiXQbDcgGXY1czUM79v9rSZLgsFnZUFwQ=
X-Google-Smtp-Source: AGHT+IFWxPDKxw2DoJfRGTnmYYeDt0CbjxRedAwDovAPjSfmRBCSdw/D2Db1EVj5oCOC5Fs2eM2amA==
X-Received: by 2002:a05:6870:331e:b0:25e:7a1:ea8f with SMTP id 586e51a60fabf-277d06c897amr16978310fac.47.1725552508933;
        Thu, 05 Sep 2024 09:08:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2e935a3sm3742992173.108.2024.09.05.09.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:08:27 -0700 (PDT)
Message-ID: <f22bc072-c8b0-405f-a4e6-da6213350c1a@linuxfoundation.org>
Date: Thu, 5 Sep 2024 10:08:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Date: Remove unused macro
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, shuah@kernel.org
Cc: jstultz@google.com, tglx@linutronix.de, anna-maria@linutronix.de,
 frederic@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240905085230.48438-1-zhangjiao2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240905085230.48438-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 02:52, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> This macro NSEC_PER_SEC is never referenced in the code.
> Just remove it.

Is this duplicate patch?

I think I commented on your patch on futex - include how
you found the problem in change logs. Also you have to
include subsystem prefix in the subject line:

selftests/timers: Remove unused NSEC_PER_SEC macro

I see another patch with similar problems from you.
Refer to submitting patches document in the kernel
repo.

> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/timers/change_skew.c | 3 ---
>   1 file changed, 3 deletions(-)
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

thanks,
-- Shuah

