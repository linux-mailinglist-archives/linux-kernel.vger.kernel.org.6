Return-Path: <linux-kernel+bounces-296521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA2895ABB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8567C28347B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB2200DB;
	Thu, 22 Aug 2024 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PD/izATi"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DC01CD3F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 03:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295838; cv=none; b=K+/vehQQPbZ21yC2YvT8RBsGeJWVftbo0naElwD4syOKyZu41yf/YQF6AwMiZDr1gTOxJhNxtb/QSPaPiEWCOyZthyg+EeOvNjAz3SDDXqayZKtjzdIQ9xO2+gsIoh5Ly2bPt34UR+gLSOaLmXYPpO8YN+S/FjzEu2a91ljtBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295838; c=relaxed/simple;
	bh=2LPG/IslZN06cbBK/YdK57m2GNu2UjglTKoBwajffeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL6j8ASZuzcT0l0ga/WgUCcgqEVUdF7Jo/LdSyxoy+zYEPW1AFOl0+3XSqwu+Hp0bSKt+laGAJnOyLHD14j8QwWpXXNvSJNcjDS+mP7EwlwtESwJPcOWVO7cZZdQGQMFMcf99OVdhGdTXq+9KWiYJsLgYNzu2EQL9ab7YkHkUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PD/izATi; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7093ba310b0so166117a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 20:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1724295835; x=1724900635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aWQNCvXdOAof/cUwKugkwOsCdNc//NybuZ2r7xMcKFM=;
        b=PD/izATiCKB1mZBDTaU+N9pyAKEW3u4iOTONpyXyWqulnENAm4A2u3knMEpZ/Cnl1t
         fuROGJPmA9dlH6/qQ5p11Uq7dBuMYMHh0gMhgdMikihASn1JoXOdH73RZaHToejB3Czk
         lA8nFS4WH/b0HKNCysB1GYfjDVvzeW0gM1B7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724295835; x=1724900635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aWQNCvXdOAof/cUwKugkwOsCdNc//NybuZ2r7xMcKFM=;
        b=KjAm1wRH5dlc0mljQJLzY58Y2H7LVo0jzio2g7Slz4cih2Esz+p8Ju2PJ0Q1dCfonH
         BCMOTGPThJc+75AxoAxdGYZM4lAgCTNMPEgjQlI9bbZNoBTkY2x1uW2/blTYQe9+l7cI
         8DH37zhyaR5K5FtDhF8JEk9QyaeNYA1iPp5ivLv7paYOqvEA27n4LByuZfJU+R7gSo8O
         Q/1coKjv4IWv/S8CGQRLhTsmo4GVHS0wTQ0tg4Y8MM7zJbHhcfCoL288bq1O+MuNdA75
         t6MB1wgzR501cOQV5tvl0oZLbDc/qd7YHpzEIZqdMPibca8WxNrDlDKi7Cm7Y2dO9wo4
         6V6A==
X-Forwarded-Encrypted: i=1; AJvYcCX/NApCUIHe4yhNwhA9Ck9nCWE8cMHPCUCYp413WHdnjjgSpLmSHaqdT3buLIP2F9rEhCG2dLFP2vh4wjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwppUaEFN29UEjBixK0JiSAtZ+qd2Gca7NjBvSe7+JbKbipEWvh
	Q0iciVyiMripG2FCpeQl/pnHsdAXaDJiZA5zaoi3E6v8Hivg2q2JbMQ5MgkjO7s=
X-Google-Smtp-Source: AGHT+IEql6VqPfz66pY2JjscwwWqrCsNLSe456gugTBAUQFnfOPHdSwIjtSuBuOQYl2b4QoHSCUuTA==
X-Received: by 2002:a05:6830:6e02:b0:70d:edad:8635 with SMTP id 46e09a7af769-70df8873633mr5522595a34.31.1724295835498;
        Wed, 21 Aug 2024 20:03:55 -0700 (PDT)
Received: from [172.20.0.208] ([218.188.70.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143432eda2sm365664b3a.187.2024.08.21.20.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 20:03:55 -0700 (PDT)
Message-ID: <1ac911c2-9d9c-4408-8697-1e90b3ae3e8d@linuxfoundation.org>
Date: Wed, 21 Aug 2024 21:03:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240821061523.2650568-1-dev.jain@arm.com>
 <20240821061523.2650568-2-dev.jain@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240821061523.2650568-2-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/24 00:15, Dev Jain wrote:
> Rename sigaltstack to signal, and rename the existing test to
> sigaltstack.c.

Can you elaborate on the benefits if renaming the test?

Also you have such a good information in the cover-letter for this
patch - it would be good to include it in the change log for this
one or the new test.

The new test itself is good. I don't understand the value of renaming.
I can see the problems due to not being able to fix stables if the
existing test needs fixing. If there are good reasons for renaming,
I am all for it.
> 
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/Makefile                                | 2 +-
>   tools/testing/selftests/{sigaltstack => signal}/.gitignore      | 2 +-
>   tools/testing/selftests/{sigaltstack => signal}/Makefile        | 2 +-
>   .../selftests/{sigaltstack => signal}/current_stack_pointer.h   | 0
>   .../selftests/{sigaltstack/sas.c => signal/sigaltstack.c}       | 0
>   5 files changed, 3 insertions(+), 3 deletions(-)
>   rename tools/testing/selftests/{sigaltstack => signal}/.gitignore (76%)
>   rename tools/testing/selftests/{sigaltstack => signal}/Makefile (72%)
>   rename tools/testing/selftests/{sigaltstack => signal}/current_stack_pointer.h (100%)
>   rename tools/testing/selftests/{sigaltstack/sas.c => signal/sigaltstack.c} (100%)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index bc8fe9e8f7f2..edbe30fb3304 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -87,7 +87,7 @@ TARGETS += rtc
>   TARGETS += rust
>   TARGETS += seccomp
>   TARGETS += sgx
> -TARGETS += sigaltstack
> +TARGETS += signal
>   TARGETS += size
>   TARGETS += sparc64
>   TARGETS += splice
> diff --git a/tools/testing/selftests/sigaltstack/.gitignore b/tools/testing/selftests/signal/.gitignore
> similarity index 76%
> rename from tools/testing/selftests/sigaltstack/.gitignore
> rename to tools/testing/selftests/signal/.gitignore
> index 50a19a8888ce..98a7bbc4f325 100644
> --- a/tools/testing/selftests/sigaltstack/.gitignore
> +++ b/tools/testing/selftests/signal/.gitignore
> @@ -1,2 +1,2 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -sas
> +sigaltstack
> diff --git a/tools/testing/selftests/sigaltstack/Makefile b/tools/testing/selftests/signal/Makefile
> similarity index 72%
> rename from tools/testing/selftests/sigaltstack/Makefile
> rename to tools/testing/selftests/signal/Makefile
> index 3e96d5d47036..dd6be992fd81 100644
> --- a/tools/testing/selftests/sigaltstack/Makefile
> +++ b/tools/testing/selftests/signal/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   CFLAGS = -Wall
> -TEST_GEN_PROGS = sas
> +TEST_GEN_PROGS = sigaltstack
>   
>   include ../lib.mk
>   
> diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/signal/current_stack_pointer.h
> similarity index 100%
> rename from tools/testing/selftests/sigaltstack/current_stack_pointer.h
> rename to tools/testing/selftests/signal/current_stack_pointer.h
> diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/signal/sigaltstack.c
> similarity index 100%
> rename from tools/testing/selftests/sigaltstack/sas.c
> rename to tools/testing/selftests/signal/sigaltstack.c

thanks,
-- Shuah


