Return-Path: <linux-kernel+bounces-234458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB491C6E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172302848B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365D2770F0;
	Fri, 28 Jun 2024 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hETK/qhs"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BFC757FD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604528; cv=none; b=deS7jQLJPEDYBQKPD5UWdCrbHBvRlw7nVXwpmpuUeun4B91sGg2fcWgQ6c7JMCSxurNUHhPjBknL4BVNTn+ytph42OV7zeENRLpfwIoLp2eUplOVK8WCtOG0MzZYq9Fy7htxmOqpr4WrR2N5m67qKAlN7t4pqZbfnkBdl5rReak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604528; c=relaxed/simple;
	bh=LeF6+VIbsZR4AZNnzSW7q90MGWi7owkHEiFGjX3ZIZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OiY/TNHhMlYjv3pK38/b0KzGygnjqZrDXyEfaQaU99g4bsDCGWSdMyIXwLu3tFLtOfkNnW4tLPtttE7DrP3AkQfcvI8PFeKoLVc3MZxDVof4sx5tilDF0MSDPUoEPaT/PUc+mgossn6W1hDBWbGjh66aEwligIvYGtuTtgyd5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hETK/qhs; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3762c172d99so603945ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719604525; x=1720209325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIV6yJjX8GB41D6fmmUZ7FkjneyetoEI+QshUrjZeMs=;
        b=hETK/qhsd1TrEIRlHCnTyWW5DqQLiqHYPx2AgOZ6cfgOr/QSRDW+cYkku2BbRsLAvc
         hRXf04Xh4qHRNupvGncCc4gbjAvDPBLP3F0Ae48cb1WDXEPKbuLWhbCd9URRe3pWN0ev
         57EM1LJMURQYK+Voc05VAY2EbLFce+z44lyjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719604525; x=1720209325;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIV6yJjX8GB41D6fmmUZ7FkjneyetoEI+QshUrjZeMs=;
        b=dsrFZKIcVX+iYtdI8jzOUTFclYXBQdAbblMdBryGU4mPg8tr4s0LRKev7wDyOeZt5Q
         nHp04oKzHP/05VJAzm446O0v7TrddvHh3tX37bdM0LJBoc2Uwh/u+xXbwjB6oBEXU1/Z
         0CwkcVRjfbZUlR/WqatT45XBCS/UMrHelYnzkSvWhXfCXY3n0T0WJ0fob66db7bRpzLz
         C6uhe3RkUTe1ZPKrZwvcqRROUgdW5PA1WsJxkkDp8yB0FyrgPz1ZIeXzpmoAZaCpnZA1
         QPbgS8aHqz+GDm2NN/ybh7IzzyvgZwFF9WVxEEBwTjtWvoz09GRAXV5BVAJKtdwpV4UK
         opMw==
X-Forwarded-Encrypted: i=1; AJvYcCXAWBSUbEFmMNrKRCXIpJEukZeLR71tVpMobCC0d9ejsyVLwCUbD0PxE9Ecrwcd4SPj1WBXvRsdZql3qVijbmHJyJ/U8t3b7XvIxW4b
X-Gm-Message-State: AOJu0YydQC2ybx7Xe0g2QEvQG9goFV3gFOgEpvH8a6EAxNa37iNNtpBH
	wexO+VNziRhDC7/CJt4cvWv7cLa9gp2UE6UgHKMXcM7CupYKD00XioNA8Q7Dx5R5q/iqpd5YYam
	s
X-Google-Smtp-Source: AGHT+IFz9Lf6O9yuRq0VsVMlK9RemhcCia+W9fPEx+U6wQpkhZkPBYq+Qo+rrlbwCfPjinAaSIg7mw==
X-Received: by 2002:a05:6602:3fca:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-7f39dd12493mr2254867939f.2.1719604525171;
        Fri, 28 Jun 2024 12:55:25 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb3a32sm683825173.13.2024.06.28.12.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 12:55:24 -0700 (PDT)
Message-ID: <88d70179-1a7b-4960-ab1d-55652a7822bc@linuxfoundation.org>
Date: Fri, 28 Jun 2024 13:55:24 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] cpupower: Add 'help' target to the 'bench' subproject
 makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-1-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-1-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'bench' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/bench/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/bench/Makefile b/tools/power/cpupower/bench/Makefile
> index a4b902f9e1c4..81c862297782 100644
> --- a/tools/power/cpupower/bench/Makefile
> +++ b/tools/power/cpupower/bench/Makefile
> @@ -41,3 +41,15 @@ install: $(OUTPUT)cpufreq-bench
>   clean:
>   	rm -f $(OUTPUT)*.o
>   	rm -f $(OUTPUT)cpufreq-bench
> +
> +help:
> +	@echo  'Build targets:'
> +	@echo  '  all		  - Default target. Could be omitted. Put build artifacts'
> +	@echo  '                    to "O" cmdline option dir (default: current dir)'
> +	@echo  '  install	  - Install previously built project files from the output'
> +	@echo  '                    dir defined by "O" cmdline option (default: current dir)'
> +	@echo  '                    to the install dir  defined by "DESTDIR" cmdline'
> +	@echo  ''
> +	@echo  'Clean targets:'
> +	@echo  '  clean		  - Clean build artifacts from the dir defined by "O" cmdline'
> +	@echo  '                    option (default: current dir)'
> 

Is this help message necessary if bench can't be built standalone?

cpupower: Disable direct build of the 'bench' subproject
https://patchwork.kernel.org/project/linux-pm/patch/20240626-fix_bench_compilation-v1-1-d039bd5fa551@gmail.com/

thanks,
-- Shuah

