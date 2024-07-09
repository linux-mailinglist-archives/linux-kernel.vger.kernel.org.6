Return-Path: <linux-kernel+bounces-246571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D38692C3AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FC21F239A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05C3182A4C;
	Tue,  9 Jul 2024 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HTtQSZVJ"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBDD180059
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 19:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552037; cv=none; b=BQ+1PnisBpubFMtGWgiUpPKMdvOu9xsTdVEoMGIALuJq7H1FVbadQ/YztNA65dVr1gYLEzNZURTaMGQX7qX3UUpVkbyaQMuWcwZXHWyXazQI0NXgqHPduNtRfEv3jACNRUdQmwp71k2pc53IKC7hcbwfICs2O1G7o3+W4/Qr+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552037; c=relaxed/simple;
	bh=WXaDUSer1JeKpTsguBNZfMDkgjQaVnYvPPrgYNXt9Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWa0+GL15pI7ypHl5S9cNUv+wUsBorSY2dctOM6vtGm0M/X53+sVzmfhCfcemeAxJ9y+yg3FivAP2Z0XAv5JhOn8llXZB4332fGYHYwnNTRPtuxCeZqu/Yy5aAafMxL0K4v0fj+AdFg2zhRu2cpOUQHqGgl1CEykI9UVAZHAA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HTtQSZVJ; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7eeecebb313so21016939f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 12:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720552034; x=1721156834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LLDDHSbnn2NLMgl2QCrOLZUDA51mpDhgOIgigd+xu94=;
        b=HTtQSZVJ5XUWXYqi7T5tgCynynDlI2XFpr/26qIGBncVmeCh6asOobwNmS1zt+tM+W
         L7rYc0G+ZL/BLxz4BP/cCrCVD3xiTHIO3AfsRjWD3tAdFqlk28S4h3LBmSTPHQXf2CUP
         /92B1Cfd8Fwxs/hEsXA8XVn+yxoeXk5cnJpF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720552034; x=1721156834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LLDDHSbnn2NLMgl2QCrOLZUDA51mpDhgOIgigd+xu94=;
        b=Qdr0CA1bNyXDeDPpurvTpd58MpeZBoieYiSzILnk134MFfp8MFG4EnFX/72pkRZTuc
         L28T/eE8jv3wrIS1qieznV8flx9y65H8pqW3eGD8EQxGhRAS5WejqRDsev5tyarnZKTj
         +Dd3ytfl5ulvcbQfOukm5kD4brAOV0AnV4v8yAx539VXw+iL4Y75jYZB/uinuZYH18sJ
         VC5542d8ntQOa9jx9bZNX0lGYNPlE1cAEz5ORfK3gBM9Oco624DafNssNn6iA2e68Awv
         1UcJPJvAYE4wn4fa/F46Fny1t5ccciei/Y1ZAOTMqnXDCU41GBLW8e939Q04EuRdvPFX
         0euA==
X-Forwarded-Encrypted: i=1; AJvYcCVcV/moN8F3hzxFgHK9P6mz6/VlR3gaQC7ZCthajoa+32WSMeSuXSUIH4U14EM/gXdmXVBTFkLuDyvOdtXFCV+BtcGVdcJkapax5ZTp
X-Gm-Message-State: AOJu0YygewQvjrQIc+3H/VFpUoaxQ1/bLg73l5ARjVztvM2CfLhIfitP
	0ncJa8i3+hZnGLAvXS2LkTHII0bBQoMppDC35gMo3r0C37MPBjWwtTg8KrNT8Z8=
X-Google-Smtp-Source: AGHT+IENiOsKcIna/f3mRvugF36IMwmpCnRhZ9tM0YYxJXeBBmTvMn2hHy+f1Cuni3zz30X2KQSCAA==
X-Received: by 2002:a05:6602:6103:b0:7f3:9dd3:15b2 with SMTP id ca18e2360f4ac-7fff92c5be4mr375342739f.0.1720552034605;
        Tue, 09 Jul 2024 12:07:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ffea4712d2sm66026739f.27.2024.07.09.12.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 12:07:14 -0700 (PDT)
Message-ID: <aeb63fb8-d966-4aab-ad5f-aa62219048db@linuxfoundation.org>
Date: Tue, 9 Jul 2024 13:07:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] selftests/breakpoints:Remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: angquan21@gmail.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240709094443.3648-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240709094443.3648-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/9/24 03:44, Zhu Jun wrote:
> This variable is never referenced in the code, just remove them.
> 

Please add information on how this problem was found. If you used a
tool, include which tool and warning from the tool.

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
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

thanks,
-- Shuah

