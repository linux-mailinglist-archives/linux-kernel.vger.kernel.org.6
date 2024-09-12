Return-Path: <linux-kernel+bounces-326935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 282D2976EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5ED21F2167C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187A1A0BF6;
	Thu, 12 Sep 2024 16:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GROl4hub"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED45187350
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158683; cv=none; b=DeppBPmRXmlRGqtHs8pCgDel3s232ugWViV7pfhCRYSG/PuG4yYCzQgYZlFKQJiYPccVQStVdsdI+alnHZpWzRb8WhAs5XYKkwi1TcOk2n10IiVqY+P8ogQQA3AQYjvaMY6iDc04+duzTvT7iPYpTei9QD6ZY+O1HBfMy+yYopg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158683; c=relaxed/simple;
	bh=W+J1FMH3tHI+6OFtsSQZ3Juup+l/59W1qlpH8qCoJNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iftgzMZF+khpxVhCDoiMG5rsXlEIiqEi+qTvcYXr0OGfC1+ZkEUjfAZ9Ccy9n913rkD5x6J77BTGRVyyw79MXKbLynxw076WGZ+KV5pxkUJP0lCYDUtehcLM1FX+55/HmEYqL/Fskzc2DFq7114bPW+LiFiUmGYoY3n1al9sebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GROl4hub; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82d07f32eeaso56004939f.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726158680; x=1726763480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ige0hospoSC0I0mXPH/sPi2U7TWVYcFeY8Oc0s0Dk6E=;
        b=GROl4hubFy4Jum5Zpf2oKrD3+bY7J59mjSW+KZ2M99t35ziqEchP3iX0wZ2EHdpkic
         A3Fi/3Sq9u34SwCSmcCe8Y2ijuKx3N0dFCo8QRNqVTKXMfcwIYf5rWRvGFP3pCgIzL9o
         /kbdlsPpAp7bt9EjsZeV0wGYS0d2AqlcSOD+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158680; x=1726763480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ige0hospoSC0I0mXPH/sPi2U7TWVYcFeY8Oc0s0Dk6E=;
        b=ed8V2vBGX0C/mjtftGE9xjOPc8FpWm9uTPbRYOQSekgEog9IS51EjWls2INSM6Z/vb
         m+/6DGiVJ7vQq4two9ds9t5M0MF4EeusV0AeFhUgKY+f3ZmjWi4g58n03g79SM+i8Y6Y
         VkZkRNlK/Lz5dT20Yh8+tj/RDhhHvhXVZKvtzWoCHMtdpbFq+VlAk+vvuZM7YxWMlDbG
         /JlVlqx5l7NoQIn1YXvPnwvpdqa5geZZna8yjnZl6FdCDygsmDih5D5STzVWKhO3nNau
         wnqd9eizRqg+ydjO+w84mtc/AwWV5rL2xoqFBALZTF5zZ2obgGdWD1qACO0wCo+qZuEQ
         djXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXszaRCZAqML3KLYVF3JJfEwWaa0WdWv86MTdSP5TRSmDPYJzaP34oXJKiPNeW/26/VIf7z8hqQ3uNi95E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVqxkNXVKrkDY8+Pp7az9ZENtKdtMyi8dILfUdyDdThojAjaIw
	sJ7n116fFkk0bTjzxF23ENegWwuHHF3N8HuIFOoYp2FjV7PJDl6QAw9iTRYCDRI=
X-Google-Smtp-Source: AGHT+IG1giQTOPVkzv0dnvg8e+wyJNeH79IfT3UNXNJqA2LVrGdANRo2yN/y8lncZQFAguOo8CmmMQ==
X-Received: by 2002:a05:6602:3fd1:b0:82c:fdc2:e25a with SMTP id ca18e2360f4ac-82d3761cb5bmr5180739f.0.1726158680478;
        Thu, 12 Sep 2024 09:31:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f8dac37sm674341173.133.2024.09.12.09.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:31:20 -0700 (PDT)
Message-ID: <5785527a-b259-42ba-989e-978d2e72ff35@linuxfoundation.org>
Date: Thu, 12 Sep 2024 10:31:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH for-next] pm: cpupower: rename raw_pylibcpupower.i
To: Min-Hua Chen <minhuadotchen@gmail.com>, Thomas Renninger
 <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912125030.19809-1-minhuadotchen@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912125030.19809-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 06:50, Min-Hua Chen wrote:
> This RFC patch is actually bug report. All *.i file will be
> removed by 'make mrproper', including raw_pylibcpupower.i, added
> by commit: 338f490e07bc ("pm:cpupower: Add SWIG bindings files for libcpupower")
> 
> We can reproduce the error by performing the following command:
> cd linux-next
> make mrproper
> cd tools/power/cpupower/bindings/python
> make
> 
> We will get an error message:
> make: *** No rule to make target 'raw_pylibcpupower.i', needed by 'raw_pylibcpupower_wrap.c'.  Stop.
> 
> Renaming the raw_pylibcpupower.i is just a workaround to fix the
> issue above.

I need a non-rfc patch for this. Please send a proper patch
I can pull in once John has a chance to review this.

> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>   tools/power/cpupower/bindings/python/Makefile                 | 4 ++--
>   .../python/{raw_pylibcpupower.i => raw_pylibcpupower.if}      | 0
>   2 files changed, 2 insertions(+), 2 deletions(-)
>   rename tools/power/cpupower/bindings/python/{raw_pylibcpupower.i => raw_pylibcpupower.if} (100%)
> 
> diff --git a/tools/power/cpupower/bindings/python/Makefile b/tools/power/cpupower/bindings/python/Makefile
> index dc09c5b66ead..de872a1b80d3 100644
> --- a/tools/power/cpupower/bindings/python/Makefile
> +++ b/tools/power/cpupower/bindings/python/Makefile
> @@ -20,13 +20,13 @@ _raw_pylibcpupower.so: raw_pylibcpupower_wrap.o
>   raw_pylibcpupower_wrap.o: raw_pylibcpupower_wrap.c
>   	$(CC) -fPIC -c raw_pylibcpupower_wrap.c $(PY_INCLUDE)
>   
> -raw_pylibcpupower_wrap.c: raw_pylibcpupower.i
> +raw_pylibcpupower_wrap.c: raw_pylibcpupower.if
>   ifeq ($(HAVE_SWIG),0)
>   	$(error "swig was not found. Make sure you have it installed and in the PATH to generate the bindings.")
>   else ifeq ($(HAVE_PYCONFIG),0)
>   	$(error "python-config was not found. Make sure you have it installed and in the PATH to generate the bindings.")
>   endif
> -	swig -python raw_pylibcpupower.i
> +	swig -python raw_pylibcpupower.if
>   
>   # Will only clean the bindings folder; will not clean the actual cpupower folder
>   clean:
> diff --git a/tools/power/cpupower/bindings/python/raw_pylibcpupower.i b/tools/power/cpupower/bindings/python/raw_pylibcpupower.if
> similarity index 100%
> rename from tools/power/cpupower/bindings/python/raw_pylibcpupower.i
> rename to tools/power/cpupower/bindings/python/raw_pylibcpupower.if

thanks,
-- Shuah

