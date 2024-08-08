Return-Path: <linux-kernel+bounces-280093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E6D94C592
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED4D1F233DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32DD15665D;
	Thu,  8 Aug 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SzF8wMFQ"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4E155A25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148416; cv=none; b=D9R++EfrENeDtH4f/YCJi6CQUXPwDio9s0bL8K5qqtxXrjBk6+K/byEci1x96lOmV/BH/O9lu8fer/TYOvTB57hsdQJjPDf1R5XvzJld4v5M0y+TendZE9F110Uop8qgVOOX9zM6BFeDmW9nQ01OoaVZ+B4tuTPXoqlr8RsUJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148416; c=relaxed/simple;
	bh=gHdxTsBtC1FIJogjoVgR3K+UeVWvV8guUElH9Mm/MW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF79fozCkMJ+zITRPAZiFCfugVhQ68M8XeOMmPQswvig6NDKSp/oleRkO/GzOjvBauAtjyBJ3SAjhzGpIoY1gS1lcyw7FDFh9oWXkdtqwTiRMdYzXpzeuVIb3TfWsO64+RKcExeqS9yx6mnUxXpwXqVcFRpVCkP1UqhtjHhobXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SzF8wMFQ; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39b37b63810so888065ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 13:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723148413; x=1723753213; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uodkGzl7xHW+w1GEEv07TFHRhIpJPmXbKVPEvtQ8oGg=;
        b=SzF8wMFQ5x5a/ygUBZWwhwKoLXC4b/YGunQbxr/Uljsqyw5DyA/m8Yf7Un1BU6iDgu
         ++/gW7YCIAsw4wfpLIUZc+qeLYqfG2YSWRgQ8Y/0VSOdGFOKbSdV4WytnW3OxBRn+UVb
         mgaV1duLlpb3WG2rXqMOMce9VGyNWtp/ZPJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723148413; x=1723753213;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uodkGzl7xHW+w1GEEv07TFHRhIpJPmXbKVPEvtQ8oGg=;
        b=fqEJaG9hHI7uPNn5Bw5VKu3sZv8SlyQBOyS9pjVbA68R2Qb6yoF3ZCEY8gZGwHp5hP
         4ZSMXx5VPH65EfIhLvDjO9wdBj25j/a9Fvf0im3xARVE8Ppt6jNpwgzTkApmZMU7eNpB
         JeVIOO0kn+TBTNzVqiNLjlyZAYnyof49EkDF1puRswNTwEP5sKfwDy8NrmHYXHB6EI9J
         TtsweQatR8Ppypvifp6N7zjAzvc+R73/20GJfD5DFU8n8Eu4pj/aBLODZnqwYZrW7ZkI
         mG1ZgxYy/B/nDsAuEXJa0OP8pTQs6Kc0Mz9P0+wxH9kBaxxfy6y2fe/iFKDKtCcfgQcv
         hZHw==
X-Forwarded-Encrypted: i=1; AJvYcCXFPcSxUQS4aFPXE7eX7H8ySQLkgs0SsXc4ROIP8CFhKhYnon3eW2Ikax7yl6xg6ehEMykE8+A34HgvIGXvvwPQrT4dzdiXuuwdeMx6
X-Gm-Message-State: AOJu0YyigHRVhdQCl6106SiMhmxl5nAkCpdXTk9gxwGAm5KNoK3LsTrL
	4X05YlXEoJVucxqRv3FS4Mkwz9K6RzlLhp182uMgrcwjEZfBrX26LaOW7v1wtrY=
X-Google-Smtp-Source: AGHT+IGeZKWpSvKjenukKSxuGMC3BC23H76EZqgIHLKrtcd11bSET6k/4D2jaLgGi/w8x0PBwnl8uw==
X-Received: by 2002:a05:6e02:1ca4:b0:39a:eba6:69f8 with SMTP id e9e14a558f8ab-39b5ed2e20dmr22609595ab.3.1723148413344;
        Thu, 08 Aug 2024 13:20:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca69620c69sm120466173.145.2024.08.08.13.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 13:20:12 -0700 (PDT)
Message-ID: <3a10db7a-d276-42ce-b050-8867aa3dc69c@linuxfoundation.org>
Date: Thu, 8 Aug 2024 14:20:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/rseq/Makefile: fix relative rpath usage
To: Eugene Syromiatnikov <esyr@redhat.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Artem Savkov <asavkov@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240808151335.GA5495@asgard.redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240808151335.GA5495@asgard.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/24 09:13, Eugene Syromiatnikov wrote:
> The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> relative to current working directory and not the executable directory,
> which will lead in incorrect resolution when the test executables are run
> from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> to the directory in which the executables reside, which is supposedly
> the desired behaviour.
> 
> Discovered by the /usr/lib/rpm/check-rpaths script[1][2] that checks
> for insecure RPATH/RUNPATH[3], such as containing relative directories,
> during an attempt to package BPF selftests for later use in CI:
> 
>      ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]
> 
> [1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
> [2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
> [3] https://cwe.mitre.org/data/definitions/426.html
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
>   tools/testing/selftests/rseq/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb58..27544a67d6f0 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -6,7 +6,7 @@ endif
>   
>   top_srcdir = ../../../..
>   
> -CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=./ \
> +CFLAGS += -O2 -Wall -g -I./ $(KHDR_INCLUDES) -L$(OUTPUT) -Wl,-rpath=\$$ORIGIN/ \
>   	  $(CLANG_FLAGS) -I$(top_srcdir)/tools/include
>   LDLIBS += -lpthread -ldl
>   

Wouldn't make sense to fix fix this in selftests main Makefile
instead of changing the all the test makefiles

Same comment on all other files. It would be easier to send
these as series - please mentioned the tests run as well
after this change.

thanks,
-- Shuah


