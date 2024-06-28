Return-Path: <linux-kernel+bounces-234508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9B591C77C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 22:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9F11F234A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 20:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3D458AB9;
	Fri, 28 Jun 2024 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cj/f1HVx"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9398FBA53
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719607643; cv=none; b=kQCtNt8lpDgU2HpM/FFVGI5eeg9CsJXupByD02u6U7bivC2Gvf5GnhKkp59nszyDfEFzmToU2O65TMvZXJs0YDUTlGx4AgLnyhudWpRLfbMBb0sBWRvzjNJHD6Lee4p1F1DK2iDkNPMqi2A6H5oEbRWxpmqHsZHYYBcn8F5mSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719607643; c=relaxed/simple;
	bh=s44Et0ooy1BwV1wiuAthBqIcBlMZAPLGSgVzR8S+DTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbHguxNPstPujI893ucWQ56JFF+P65tGlrsgBnm2fUJI2wcniloxJVI25D31j5AEuLhqpYdcImI3H40oLCDdFjFqFHdJzHeC0967Qxzus90qzBNQAHrPsXtmYzB2DuBC/aZDwQmAj+LHFHZUX60yzed4EXa9c3uEuz3oVbEa3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cj/f1HVx; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7f3ce5b48f2so2120939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 13:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719607641; x=1720212441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ElFfL+9fsVftY7dbtRQDE0n67mXXjumfiDFLoKzxmKA=;
        b=cj/f1HVx56rsaZqysKz6dVMx6+wLuB+a3AqXcI35oIMauqLZ7AHD/qI0h18C4KJprU
         rAyieEkXpXyzV4HlSJneX95qCQD2trLvsbXNisPd4hmhyxbKjhlUr6EDaR2He7QqT4AN
         zr1qSF8wKCWNIGhUFOt1yC867wQgbzhGfy9G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719607641; x=1720212441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ElFfL+9fsVftY7dbtRQDE0n67mXXjumfiDFLoKzxmKA=;
        b=DALFZxzgsYjZCKJiJ1rT76s4KkrT9r/l+4CU9LDyUkIF2QCie3ZQr1hxAhdI27k024
         sBdX0JJt7EffgQOZVgpqcZqzplyS/lS5qBuOZzou4KO0+T+rfw8vqDwlbWOPauuVKDFu
         RWqjcFiSVJrhdJgLVom2REr/ar9n9s/Bjghc7+f8RQI6SzmC6SWLEgd5U5g8FnijzY5x
         CjPez4a9qMvS5slwcR5DSQ0tgo9IXQv6GhOvAzhKsOmRKujPMxXiVtIWS39Q4kCyxHRA
         VzWZ3CA1E1c4+XOkItfXcgL06uMekYlDyVhHdrTdSoNAi0EbWo2eqQGpKe3ZoUKuUWE7
         7Vyw==
X-Forwarded-Encrypted: i=1; AJvYcCW3qUptetDzwUeQ2ECROZp4FsvPkT6pbBei1vq1/mtS/olzSXF3FUUnGMpVNEZwtzgk+YzB6sYeNXBRGdwDJU3tRZXeYa27WtAdNR6U
X-Gm-Message-State: AOJu0YwK7kKxlJspJWaeQ/B7k1yawhjlkVnRIKTJWjYsdanyuXd+aeFq
	jqh+HRmnIDloLiWBP1mGAI/mMTeC0m+E/3i+VgnmnOEqMW9XYtl4mXZymUTm23U=
X-Google-Smtp-Source: AGHT+IGGLgOnM8KW/v8/yG6HDfxdCoco0NQRTG38bTNVCxdVf4hkcTIQxPG+L7frOd/AFnVLVzva1w==
X-Received: by 2002:a05:6602:25d7:b0:7eb:66a5:d1c with SMTP id ca18e2360f4ac-7f39c44f029mr1784451439f.0.1719607640795;
        Fri, 28 Jun 2024 13:47:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4bb73bb37e8sm719417173.3.2024.06.28.13.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 13:47:20 -0700 (PDT)
Message-ID: <9962b32a-068f-400d-923c-bd388691656d@linuxfoundation.org>
Date: Fri, 28 Jun 2024 14:47:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] cpupower: Add 'help' target to the 'debug/x86_64'
 subproject makefile
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240623-make_help_rest-v1-0-4bd3fd51064b@gmail.com>
 <20240623-make_help_rest-v1-3-4bd3fd51064b@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240623-make_help_rest-v1-3-4bd3fd51064b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/24 13:19, Roman Storozhenko wrote:
> Add 'help' target, describing all user-available targets, to the
> 'debug/x86_64' subproject makefile.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
>   tools/power/cpupower/debug/x86_64/Makefile | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tools/power/cpupower/debug/x86_64/Makefile b/tools/power/cpupower/debug/x86_64/Makefile
> index b1b6c43644e7..4b35b2474182 100644
> --- a/tools/power/cpupower/debug/x86_64/Makefile
> +++ b/tools/power/cpupower/debug/x86_64/Makefile
> @@ -28,4 +28,16 @@ install:
>   	$(INSTALL) $(OUTPUT)centrino-decode $(DESTDIR)${bindir}
>   	$(INSTALL) $(OUTPUT)powernow-k8-decode $(DESTDIR)${bindir}
>   
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
> +
>   .PHONY: all default clean install
> 

I don't see a value in adding this - these are common targets and
nothing new about them.

thanks,
-- Shuah

