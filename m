Return-Path: <linux-kernel+bounces-333635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7897CBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DFB28614A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AE819F499;
	Thu, 19 Sep 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gmVUCZL/"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF4190477
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760438; cv=none; b=YdbSqAZZjhoH3WoX9SbGYYNbhG6GJdiK6iW9HycyHvzq4AccKwYrsQPFjhVfQ5FeTy5g3Xc32txgaVn+KTBIWIu5llVhvfDmGtTMKsIk+BLMywb2ttyAznW4ob/HV07mQaXawVTEFMQLOGxW4dtDP93QhCtVTyz1AMLYOvmU8zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760438; c=relaxed/simple;
	bh=S3jjB0JagbvuniWc1hw9aCEL9jm9m5aL8JTzByVY7z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcS5a6iHP+Pnm9ZVpKdWvdt+18sh4QzkGYy/wt8fV5M5GrX3XL5RLseymxXBnSUjtXNiVOAq/AVtZipJ2ljLhnmTwwAJrACi24AvENgKgsyt+EdD9ulYmdsOBitKya/d+MtYF840YJ+yO3q95zSKuAznz9zEvPka2mtSSb2cJlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gmVUCZL/; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39f54079599so3486735ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726760436; x=1727365236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6IkoMJd+OMOnoOk1pWpZJ8ZHHOuA8WqT9BG/0ux6KK0=;
        b=gmVUCZL/6+73L7V9VMmIqtpNHYjVSPZV4wdorlblu/MZBA5URCV3046xqheT467Tp6
         m9T2v3P/JDx6lf8YR6NWue4ayCEEWZUKCudkflaW/L2xWjGWqYaGIp/rb7Kv0rRsrZpC
         KFozYHbUDt7L7nKVY+9IzyhrTXTqYWLX9pQA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726760436; x=1727365236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IkoMJd+OMOnoOk1pWpZJ8ZHHOuA8WqT9BG/0ux6KK0=;
        b=KlZwyuKct6brXRS3P47pFMDNfOnhU5SGEyXlmlVblRVoqq010i0+Qdd/gMdqYt2LNn
         +TUIMvKJWC+9tK9OZiF/mNIFWTLj7RaV5OQSnNnRRsmXxTfxagjCTnHlEpOpDsZCXfIr
         H78TaC2VNEcLwL/r/ZpYwqD4oQB57j40Rr/pyDqv63tpBm3YbuM2btYNtFtlhysVQwio
         TmXyHKKYd8WcMtbEnsgRPsQbMwnmZVsIFgLQNCYxi4HBbYPK9MQV+OzEWJi7cKmA4YT2
         e7NH4VpgjKRheMsr9vg2vBrbhbbnlEd7RjsNQVkGscEk3s8DjYMZ/ttP6dqdkF6Lq+nV
         e1JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAj70GGDAL+akeiWqb1BDzMSsv2zFUeMDGqdTnT+CDobwkHD+G6eluQdbBCRLDHTfoAjyPDM4gzAp/Jr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPr8PYFBhTBZSeV/8g7p2hsRrKing008G62MeOlpyMGslTgI5
	YSwNwAyOvubc6bT8PW8EdfZ2iiH201ZtfRN6/dzyda2tCBj+2LR6PqqAWZ8rXKg=
X-Google-Smtp-Source: AGHT+IEruDLQIz1NbajtnHH4BV/rIOv+kAftxwqCcOt/bshhGMnNettNJhh5yGcETaa2+wV+mG0peQ==
X-Received: by 2002:a05:6e02:1a4a:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-3a0bef3865dmr30043455ab.1.1726760436231;
        Thu, 19 Sep 2024 08:40:36 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed1904dsm3089529173.108.2024.09.19.08.40.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:40:35 -0700 (PDT)
Message-ID: <7caf7242-1ca4-462a-b3d0-627258df3f1b@linuxfoundation.org>
Date: Thu, 19 Sep 2024 09:40:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/alsa: add silent flag to reduce noise
To: Abdul Rahim <abdul.rahim@myyahoo.com>, perex@perex.cz, tiwai@suse.com,
 broonie@kernel.org, shuah@kernel.org
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240915234131.61962-2-abdul.rahim.ref@myyahoo.com>
 <20240915234131.61962-2-abdul.rahim@myyahoo.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240915234131.61962-2-abdul.rahim@myyahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/15/24 17:41, Abdul Rahim wrote:
> When ALSA is not installed on the users system, the error:
> 
> "Package alsa was not found in the pkg-config search path.
> Perhaps you should add the directory containing `alsa.pc'
> to the PKG_CONFIG_PATH environment variable
> Package 'alsa', required by 'virtual:world', not found"
> 

extra line?

> is printed 3 times, which generates unnecessary noise.
> Hence, Remove unnecessary noise using `--silence-errors` on LDLIBS
> assignment, so the message is printed only once.

I would say this message is alerting the user that the package is missing.
Why would you want to delete it?

> 
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>   tools/testing/selftests/alsa/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
> index 25be68025290..cd022fc869fb 100644
> --- a/tools/testing/selftests/alsa/Makefile
> +++ b/tools/testing/selftests/alsa/Makefile
> @@ -2,7 +2,7 @@
>   #
>   
>   CFLAGS += $(shell pkg-config --cflags alsa) $(KHDR_INCLUDES)
> -LDLIBS += $(shell pkg-config --libs alsa)
> +LDLIBS += $(shell pkg-config --silence-errors --libs alsa)
>   ifeq ($(LDLIBS),)
>   LDLIBS += -lasound
>   endif


thanks,
-- Shuah

