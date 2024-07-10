Return-Path: <linux-kernel+bounces-247865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1476C92D5BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A099B243F0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74451195F17;
	Wed, 10 Jul 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKNTv/kB"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F571922C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627653; cv=none; b=PyHTSRBX8raYMzvnX1j5RqsIsMsr1OLfrVdAKvdSAoj1/1wE4T8rJlcEETAR52rVBKAcSFOxpwn49dnZNjUYsTcZHVmdLuj57mKjRxE3yx9UAS+zZepROI3JcXIZlPpo/u5+/WZQaII8AFSYqt1/dciQT6Rmy2aeQySCTgkWTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627653; c=relaxed/simple;
	bh=PldZFf1DYVh6TpKO21NogJ4U+Og52dZrfLHR4m7G7So=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgY2nOCG5DG6QNiWJ7S32A+qjlEirU+G7rgTUcE0lcmgS3YdKkSm5YV9b960NI9HHl669osfOVDqzATKjuRT8E1EYDrLkexKZNdsALBssadHbW3ufnVQ6ApaYReTcHslX0MKTEfELdHxe+ij+xm1l8Gqb5g9YJF52rQxdSw5rr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKNTv/kB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7f7e24bac14so15726139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627650; x=1721232450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4twbxw2J4G69WNgVFZ3IS6Gan/GzlIJYjtUjczPK17c=;
        b=hKNTv/kB6xeUG5GIYUjyQGf5Lu8nuJz/MqZ5JtAx+oDXDa2+r46rD4ygrcJQ28Vk2s
         PqmxoPBEZpLXKJj++VrpkWCeda81JP4LDOjqE+ZXaep6xErq0XQteNiV0eb93BcWELX+
         R40ugbnrEWS2WA8h2Q6+B0zX8EsWqNc8DkqHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627650; x=1721232450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4twbxw2J4G69WNgVFZ3IS6Gan/GzlIJYjtUjczPK17c=;
        b=D/wVmVjIuO4jwg4gXU54+f9H3PhGH2RCu2gf8t4u/OS1ZIyn+MDzQ708ZbtgL0aP5d
         hIUJB5QoKUTk8coaN4xKOwhIsXSGxIcMTnUJyO+NRWIK6BT3O3ha3/LETyuxnZbIRvHh
         elgo79ghNA8kkqwEYMoqsWgkhukFdZfZICvyb20uvYRUGo93SqxNo0hCsz6cPJzOZZlj
         8cZcjFcQbb1lpb+dwrlYlyrBf0wyCE0oxjJT1KxA+KFum6wUTKq61LZGiPmvD1ys//CR
         8evwCA2CTXXk2zEbBYneswsIkKfp/BSFrrt2FQ7RuS2OIBbnkeYo187tLONGjd7hGCHz
         zuug==
X-Forwarded-Encrypted: i=1; AJvYcCVViNLe62zeN6EqWH/cgYwWBXZhwkWChPrZ2J3gAGnQk0cT07xWXXiQEGhKUuEpNcvKnh4S9c2vX+5T9srKUUjrSIiRvHiAhHHjPo/G
X-Gm-Message-State: AOJu0YwTJj/oKKWJWwP6ZnRVJ+srxKl8XV2lWdhPC5OgBdfLp8VpVykw
	b1a/FbvWhL2Fx3PTm7ve4oldpIw5rTvdnGUxwMCI5XacuTYhMWhF/q6x6S8Sh/Y=
X-Google-Smtp-Source: AGHT+IEldwufc2Sxsle8c/cT0PCeq897Fwu514Zizte187NwmlrZ5oP7uDXPdKzvq06ZDsiIkiofSQ==
X-Received: by 2002:a5d:93c4:0:b0:7f9:89a2:b846 with SMTP id ca18e2360f4ac-806e1fc1460mr1156639f.2.1720627649728;
        Wed, 10 Jul 2024 09:07:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c0b1bf7b7esm1202110173.114.2024.07.10.09.07.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:07:29 -0700 (PDT)
Message-ID: <7521837f-72ba-4558-b1df-77aec2c5f5f1@linuxfoundation.org>
Date: Wed, 10 Jul 2024 10:07:28 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/memfd:Fix a resource leak
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org,
 akpm@linux-foundation.org
Cc: cyphar@cyphar.com, jeffxu@google.com, sauravshah.31@gmail.com,
 gthelen@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240710073351.6479-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710073351.6479-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 01:33, Zhu Jun wrote:
>  From a good programming practice perspective, especially in more
> complex programs, explicitly freeing allocated memory is a good habit.
> 

The change looks good to me, however can you elaborate more on what
kind of leak your fixing here?

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/memfd/memfd_test.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 95af2d78fd31..f842a4aeb47d 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -661,9 +661,11 @@ static void mfd_assert_grow_write(int fd)
>   	l = pwrite(fd, buf, mfd_def_size * 8, 0);
>   	if (l != (mfd_def_size * 8)) {
>   		printf("pwrite() failed: %m\n");
> +		free(buf);
>   		abort();
>   	}
>   
> +	free(buf);
>   	mfd_assert_size(fd, mfd_def_size * 8);
>   }
>   
> @@ -685,8 +687,11 @@ static void mfd_fail_grow_write(int fd)
>   	l = pwrite(fd, buf, mfd_def_size * 8, 0);
>   	if (l == (mfd_def_size * 8)) {
>   		printf("pwrite() didn't fail as expected\n");
> +		free(buf);
>   		abort();
>   	}
> +
> +	free(buf);
>   }
>   
>   static void mfd_assert_mode(int fd, int mode)
> @@ -771,9 +776,11 @@ static pid_t spawn_thread(unsigned int flags, int (*fn)(void *), void *arg)
>   	pid = clone(fn, stack + STACK_SIZE, SIGCHLD | flags, arg);
>   	if (pid < 0) {
>   		printf("clone() failed: %m\n");
> +		free(stack);
>   		abort();
>   	}
>   
> +	free(stack);
>   	return pid;
>   }
>   

thanks,
-- Shuah

