Return-Path: <linux-kernel+bounces-222920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F39109F4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCBE28447C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9628F1AF6BF;
	Thu, 20 Jun 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MkgwPz8g"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C91AED4D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897765; cv=none; b=kH5i/xy1xWDrXvAoTTJEUrvh5B5ppMBH6GGgr7nDjBJmZ7KBWV51fan3pExTKhBMDH2ow6uIHZGT/kR6l0wF7Wwg9Q6FHndvWPrRjmEEjbRubj4FBMVOuEXdrmQCz6lY1nogVK+YlcwSBgchYimHO+9KB5uLw9Ye7OhBWoGxX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897765; c=relaxed/simple;
	bh=Jsw9X1mHuaFL5XYgTd4SOQKZZ10HagZI1CBz7jCDX2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hpF99pLFhjkZy9wf0R8sDQqGroDOvsLchQn2AkC5pi9QYmsGGwQn3zo2Jz6i+aB6o/JjCFwBtsjz1YxIl12Pk12l2YdedPQryD+mbnxvJU2mjtGYiCuJfp3pyJ//odD2vkgPOGnfGzQeVJGTfxxFziCkJ3zmvTuBQPIr4iiXhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MkgwPz8g; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-375f6841f01so502265ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 08:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718897761; x=1719502561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6W4tJANgLoO4iUCI9w+RyNcvDtbjH3tRJtS/qipMcM=;
        b=MkgwPz8gJTeLdxXXadrp1ZEnfVAOpLCa5nqiAN+g9VZ5pAuTqeDloP6BdhxweLN63s
         sdHg6zk7GG/te9CCtvKA1m2nefOlo5IfUz6N9p2q2fwEv7MOK1xnJceUuSvqhnClsnpE
         Vci9RaKAcZ6jg00gZddGxSJrxlzog9BPDYVbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718897761; x=1719502561;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6W4tJANgLoO4iUCI9w+RyNcvDtbjH3tRJtS/qipMcM=;
        b=kNvHaSq7SDRECrlw81k0AiJc8xZXFV/ley7e9Hpw1IBw331jiZu2vQmlJdDcNjUEP9
         Yc2BzOONrm+nY6VdwlQPArnJxpVMaWH6QK1C7fn4F/5fIhl7bAE4WG8tQ5oo6dO9MeNw
         /65ZbP9fBYqyu7WlfeudXhYEN8x2FJDPqMU8EbLsH/0e8iLy99ru4c+2PFvQJrid6x1j
         g4Xt+s9RjB4QQ1i45cG7fLZOazhIrs0b8zR3YmrDBn0EYVzClyaMkBHjbmHy5HaGFKYU
         5RLcFxroAUJeOH6013gPaI0yefxv1j3FyVz+gNGOH57Ywolnz7o3y/I7o+sgKWQLj3EE
         T9/g==
X-Forwarded-Encrypted: i=1; AJvYcCWaMrMvBeFL6K27XnGNtdTLNJ3ZGPGxpl56BeRalcsPXZxYXpqeXNAQCrmEhLpi3pGh7U2EKIuCmxpXQO1fso0l7RXE9irpP0W5WYO/
X-Gm-Message-State: AOJu0Yz3eGDa3y/cpBN903ypU2WDIWYtrM2H9gBY4bNnnIpw1BuJzbgf
	o5srhnL+/vNw6ed/rwRCL7hVESOpfv9mB6rNycTvYkIgpF4sbYmrz9vXjbLX4qm4oXSKV3CUbA5
	G
X-Google-Smtp-Source: AGHT+IE62fY5IaJWHSKcQBB3+r71W1tXrEigfYnuO0ExhF/a0NGR86ugEoobZwFQM7KAWijR2k3MtQ==
X-Received: by 2002:a05:6602:19c7:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7f13ee8ac50mr617369139f.2.1718897761047;
        Thu, 20 Jun 2024 08:36:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b9568de15esm4521709173.21.2024.06.20.08.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 08:36:00 -0700 (PDT)
Message-ID: <65598c9b-984a-4bbd-98dc-fb15792ce1cf@linuxfoundation.org>
Date: Thu, 20 Jun 2024 09:36:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: Change the var type of the 'monitor' subcommand
 display mode
To: Roman Storozhenko <romeusmeister@gmail.com>,
 Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240619-change-mode-type-v1-1-31e7e45028f0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/19/24 01:54, Roman Storozhenko wrote:
> There is a type 'enum operation_mode_e' contains the display modes of
> the 'monitor' subcommand. This type isn't used though, instead the
> variable 'mode' is of a simple 'int' type.
> Change 'mode' variable type from 'int' to 'enum operation_mode_e' in
> order to improve compiler type checking.
> 
> Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> ---
> Built and tested this with different monitor cmdline params. Everything
> works as expected, that is nothing changed and no regressions
> encountered.

This above belongs in the change log. There is no need to add
throw away things for patches in general unless there is a reason
to such as v1 to v2 changes.

> ---
>   tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> index 075e766ff1f3..f746099b5dac 100644
> --- a/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> +++ b/tools/power/cpupower/utils/idle_monitor/cpupower-monitor.c
> @@ -35,7 +35,7 @@ static unsigned int avail_monitors;
>   static char *progname;
>   
>   enum operation_mode_e { list = 1, show, show_all };
> -static int mode;
> +static enum operation_mode_e mode;
>   static int interval = 1;
>   static char *show_monitors_param;
>   static struct cpupower_topology cpu_top;
> 
> ---
> base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
> change-id: 20240619-change-mode-type-e8de8430ccca
> 
> Best regards,

thanks,
-- Shuah



