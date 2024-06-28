Return-Path: <linux-kernel+bounces-234507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95C191C779
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEEE2827AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683B07711A;
	Fri, 28 Jun 2024 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eauw6lqb"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418ACBA53
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607628; cv=none; b=MhgG4GRinXCdHEwwfJL7xstHwitW+X+3Y8Qioltx8p2mI0HFw3pTGfbSiqU6qxh0J/gBby55uSzRCEK/LXkGlqnc893RkVMbzUlkgoUY7jLWkjSgVSBpoGCfAoUkubQIrFZlW7o2AV2xJl53r7gQj1F2a1bgCsshio0Sx+YxF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607628; c=relaxed/simple;
	bh=Jb7mKXaAYVuB/4EKR0Fr/gT6mE/i4tP53/+kgnh7LHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Be7JPy8cnfUJvqkbaet+hU5pvhl+4ApsWLAVgzuRsoA3/GGocppn5KH3QW+joNizKZoUtWXoUHLpMHYh+fjDVb8zO29vHO6UDyXUdPtPlVJTc6FUh7W90ZXCed6Aulq6OpY+hdQ2gzlIobe6pLB8pbfSYNOGToByjaDAKfjC+T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eauw6lqb; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3772749962dso693215ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607626; x=1720212426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qhHtiTqQ+z7E3AhoOR3qMD5WdYC0t8JoAfk16HBLnGU=;
        b=Eauw6lqbgg+qVPaP+m2WooPAh9cogLkJO2hTd7mHmbW1urtnkZJrxXf9JUw2XrWuFq
         Xr3YihAjxjyLdpvRCXtjx0FdmRbbCeV/yHxWx3gAgW478ZOA3RYmDQoSsJBQkIFcoCYw
         jtsKiPumyDW/8VWAeS0TPFMfqScQ3S4sl0eG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607626; x=1720212426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qhHtiTqQ+z7E3AhoOR3qMD5WdYC0t8JoAfk16HBLnGU=;
        b=RFYdPEdEuBeyJboyC0H+sB+K+iblvNwTwGLNJrMF85verNtS0B8ZTQTYauldEds68w
         WyLoAWaXskgahlzAanfWO3xPNbx6bghy5gInoBv5PlsMCnVjt6HNXmKwQESHcPNFsyxk
         ZRPSlFFLQgWOFQO8hMDbSjxssTDnEX4GJW62xkODLi+Tg9Ay8v/Iod32v5p5QUu+nZWx
         M6BvwoB5k7fVzOmSaOPRLPK3AARPgu1eghaTXiZ9QIHXiQJ7LcWmdwbmXmALujpLVRGL
         vfuvO09rgyTSIqhhaNuEefrAHDLe0MujR8iCtMb/T75l6vcKRrJKVgvlBhRRyoxWb2SX
         cs9g==
X-Forwarded-Encrypted: i=1; AJvYcCUZkw8T6aaxKFvJ6pXE8SLXoffCQxfmxjtYMMleD0P31+wRey5VP3yOo/BzKWwCaMALVlrDTDYNi7lhXtg/GKRz+wr90SsSS1TDRI68
X-Gm-Message-State: AOJu0YxU7Y8Tbglrf2Kyz2cCXG/21qLbdJYpmPXClxnd694TUvFW2Y2f
	iSd+xIH+t0xIrmP9HvwNqraV6pbjKkXA9RGzHmHnH4dAf7oeYw0cRZ3wNmn/qW8=
X-Google-Smtp-Source: AGHT+IH1+SWc0NKfOYJvpd8tQQbkp2GXyhvPN6LfHnbWHhu/jSABWnvhN55JWn8alHmEiAhfJUOn7A==
X-Received: by 2002:a05:6e02:1583:b0:376:408f:585b with SMTP id e9e14a558f8ab-376408f5927mr198443125ab.1.1719607626394;
        Fri, 28 Jun 2024 13:47:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad22cb699sm5855235ab.12.2024.06.28.13.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:47:05 -0700 (PDT)
Message-ID: <da8ceb50-91a4-4b6b-92fd-fae78dc49812@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:47:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cpupower: Add 'help' target to the 'debug/kernel'
 subproject makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-2-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-2-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'debug/kernel' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/debug/kernel/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/kernel/Makefile b/tools/power/cpupower/debug/kernel/Makefile
> index 7b5c43684be1..9e4522a42c6b 100644
> --- a/tools/power/cpupower/debug/kernel/Makefile
> +++ b/tools/power/cpupower/debug/kernel/Makefile
> @@ -21,3 +21,15 @@ install: default
>   	/sbin/depmod -a
>   
>   all:	default
> +
> +help:
> +	@echo  'Build targets:'
> +	@echo  '  all		  - Default target. Could be omitted. Builds "cpufreq-test_tsc"'
> +	@echo  '                    kernel module against the running kernel if the "CONFIG_X86_TSC"'
> +	@echo  '                    kernel config parameter is enabled. Puts the built module'
> +	@echo  '                    to the current dir'
> +	@echo  '  install	  - Install previously built "cpufreq-test_tsc.ko" module'
> +	@echo  '                    to the running kernel "modules" dir'
> +	@echo  ''
> +	@echo  'Clean targets:'
> +	@echo  '  clean		  - Clean "cpufreq-test_tsc" module build artifacts'
> 

I don't see a value in adding this - these are common targets and
nothing new about them.

thanks,
-- Shuah

