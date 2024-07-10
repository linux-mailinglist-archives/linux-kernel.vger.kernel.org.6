Return-Path: <linux-kernel+bounces-247849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A17892D585
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F3041C218E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AD194A5C;
	Wed, 10 Jul 2024 15:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OD7ZnHFq"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A03194A59
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627016; cv=none; b=QBj+Yp9ybccWEYBBuHU6fTIw7gZEQF31ghrjle4blxvrAna/XmZ89zgAU4gjWX0WKnxIaLL1uH1QvAvll9+w6w+poqaRwkb+H3O/vV+510GG0/v33KZDh/b2x3NRVxL3jxWjlnoY3DTQZJDafwiSPQKdzYY13GVCXsqPhm2LQ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627016; c=relaxed/simple;
	bh=JJbrd/SAXQmG1te/lqb4KxyAONESrRs5fEKrCQIBTnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctmKsXVYv/oEfRapcHxVnNVlbMrtKNSt9Pg0M1I/wa4P8wweEYjhWCm/FWLhtlrKRdYbqaTnAhJVlkx1pLle+mfJipUaxQoQ/RLsIX8R6xZ2FOmbIPCJ0JDOOUDBA8rucAKLjAeB2V0mEZVzZM9rWzWeH20EXDkzAjqJMthcS00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OD7ZnHFq; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-389cb8f18beso1847635ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627014; x=1721231814; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VERdU1qedh1l6GdB7M2mTLj4O6X+fYd5WvsHYcPRDpk=;
        b=OD7ZnHFqKGzN+Uyd+JQP/hHvvZPH1PaadFyiFUexeHbeloEJGv+RnVJmU5Whc/r8Hr
         +XsomoyIHpPG3dwtXG8vl8nLN/Z/gBF0/ovz1C55Fijda6G7zDsef/WhSCc2ESuhR2wo
         ro2Dg2H3c0Hu8UfR9vt8sQKTaNmQugKtvH2ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627014; x=1721231814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VERdU1qedh1l6GdB7M2mTLj4O6X+fYd5WvsHYcPRDpk=;
        b=QpsbUIGJY3cICTtfTwkyZ8AtXomKBWZEyt5yX6A/etbdf36mGq4jVWrXV4NLUGL9Kv
         NsytRQR3SbkgJBObg19HI6lDSwbAuzGx4Llx9wjjJ1pVRfC5R1bXu/9mp0AFi0Ofz8SW
         OCC+r3vwLBtMf6WnkzMp0ezub2jBoIgKXitfSlIHBG4w1w89Ch41EEE45azvwPz95jpz
         O0DsZBG61Vrg2BroZJM3jMxoeMGGp5E4BHWU5rCnmMaY6vQYpyRa48leXWKNjiOFdGWl
         eU/abyYjOKIc+emW+GRrA5PE2qbzKtkT390QVxyIqbay6zqRqtY5N41oNtYbpYvgO0Oq
         UMKw==
X-Forwarded-Encrypted: i=1; AJvYcCXV+XX/pD4goZFDQFq4wS3pVCFp0kSf5xVjmdIKmpMFudf5CKpalMfKWy4u8axK+wiP5pFjNB+70JC6F6Tn62KBJtIaObeV9OdkA9B2
X-Gm-Message-State: AOJu0Yy+Bp12IAGce1vQxdPKL4mn+KBoP4L8OijjCXDMUd27a+6uNyFR
	RJpspotrgCZyg0yKxwol2nqwr5AqFwEV/dXwuRnLY4gd3/ngB3nTfLUbOpN8XZM5nnZDqmhDL6j
	9
X-Google-Smtp-Source: AGHT+IHg/yspDQjdmkEKcTdfBZHi8HL6V6VKME/ltM73JgpK9pD4RTHubfradQsoa23jOALtcvaZxQ==
X-Received: by 2002:a05:6602:6103:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-80004dea088mr660879239f.2.1720627014247;
        Wed, 10 Jul 2024 08:56:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1b5c781sm1196507173.76.2024.07.10.08.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:56:53 -0700 (PDT)
Message-ID: <7f6f9c8e-8bed-458d-92cc-32b68c68ef21@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:56:53 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/breakpoints:Remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710021136.2753-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710021136.2753-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 20:11, Zhu Jun wrote:
> This variable is never referenced in the code, just remove them
> that this problem was discovered by reading the code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
> Changes in v2:
>   - modify commit info
> 
>   tools/testing/selftests/breakpoints/step_after_suspend_test.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/breakpoints/step_after_suspend_test.c b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> index b8703c499d28..dfec31fb9b30 100644
> --- a/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> +++ b/tools/testing/selftests/breakpoints/step_after_suspend_test.c
> @@ -130,7 +130,6 @@ int run_test(int cpu)
>   void suspend(void)
>   {
>   	int power_state_fd;
> -	struct sigevent event = {};
>   	int timerfd;
>   	int err;
>   	struct itimerspec spec = {};

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

