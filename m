Return-Path: <linux-kernel+bounces-418406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CA39D6149
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F201602E6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F172309BF;
	Fri, 22 Nov 2024 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HkfIhy1o"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F5DBA20
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732289114; cv=none; b=lQz8xsbcdw0TWV0z9msHCv201MZZ5AvNwS40jtIMjzIi261KUjIyk+FbE9rf9FAlYQMUtyu/6/p1q4lMTVkGkKU5ZrQPnd//EKYblWImEkEmoaZDpIE/laL++1JS5z7C9YpOz+W2SJtCKFQ9Gxy6VimotsFlinVh15cgDsg1hxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732289114; c=relaxed/simple;
	bh=/bnLshJmEV4MPcg91F8j6GOVZmzPqEWSyF1bcltcB4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrBPZzSMuD0ta15VnMlzN0cOmS4p+y3MEJZS/lTg78aPCcxqBjJD8nOkL87YVuNAe7ID+t7dOPoF7Ht7B3BhWDnEFZEuK0vQ414v/4H1ybxG1hGdtSLnaJcZbodxVmh/MSrM/EKFDuQE4fV5jwE+G4YOslpaCXG1uu0G/9MstD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HkfIhy1o; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-83ab21c26f1so81955839f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732289111; x=1732893911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzZjmHz6Lik1P76qmlDec9sFLc/914Bp6Hi3thjoP34=;
        b=HkfIhy1oRHskI5LYcdt2Vc+CR80u6c1c4HaDen6PS0QdxCVqNdmwBYWErJLD0Im5o1
         kXHCUDSjBIn7/cO/1si2BTFMTeFjoty4hfxJHjxQ/ZB+5G5ZE4JLA5FHjOyYHaNuLoNN
         oc3IGHoBYp9jftyMd7dfmrXeIBX991YQJfR8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732289111; x=1732893911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TzZjmHz6Lik1P76qmlDec9sFLc/914Bp6Hi3thjoP34=;
        b=T5ewQych5xqtFTobiqCz91hd3DloW1xGRyn+Ozi4A7RQytOdJLaer4LYR6+VQzWZzw
         Mh/ce+1wsBPHBNMtGxaQVYQbuC2okndYY+8c8YCEmfSs9yNR2sXDPfLl7yruQfTBE6eO
         KEdllyU/NunK6dBaCYp4zioeXJcxaYdt5a6JBQaZlLG+HWAGnc/DGZDcWmOwdGnIrCex
         WHee6xnAOjus6IzPmd1afPncwf1eDIIas1Avx3Uy6xAtB5AllxVsgFLKI+e073p+qbNI
         FFW5gNeje0D7ySdTWD6OauZKiQDZlENeYq6NTTgSC7Z0izzlH4W+5a9nKEHXz1rX2DuF
         aOZg==
X-Forwarded-Encrypted: i=1; AJvYcCU1QswjXv+IJc/pDxaPHY8XdyCHwRkoV/9pW+f+bSusCGogOv9ahRBsOkvH92VzpGl+weVYc244nnmLJtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxypYJmfDrmvo3C5YcTSLOPxNs2J5QXFuFi+SXP1mSFkGUxHfg9
	C/ia3REajH3qOGpWmMFQQlLw7yw9PiKpst3HrkmhO1cRBXzf2xq4Yjw3owXeoIk=
X-Gm-Gg: ASbGncvALH5kwF8nZ7PKaTTJjVUQ/6EtH5nbmWbZfnWzhhspJrtoGEq6Ex3zWjzoOQv
	sehdPDTLKAegxRqaGP233sO7egwV1M/u0RuuFoNJL4e1T1f43pEFMN9mLLUlEUkC4PuuaTmCZgf
	zPDQZnXEGc7OBSNYBV5rLUBYv5asyiyfIbui0TYwsUcZkv6885Rq51y/jJwmSRHnP/Dt8PIXwPP
	ZMdqgEEtHQTndQdfQBNeibjSCpi+O5d73eLFN2xqO9Iko+1ceywwD3cBzbkIQ==
X-Google-Smtp-Source: AGHT+IEbeFhLeHOa+M9VWijBvVZO/OOQ+i5cO/H2e/h5vhnGK+GZB4XUNixY772E2i0huamZEkjdyQ==
X-Received: by 2002:a05:6602:168d:b0:82d:754:5026 with SMTP id ca18e2360f4ac-83ecdc5cd72mr384779039f.4.1732289111219;
        Fri, 22 Nov 2024 07:25:11 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83ecd417fa8sm48955639f.44.2024.11.22.07.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:25:10 -0800 (PST)
Message-ID: <9d35ba5e-179e-4aef-b973-ad615489cfa4@linuxfoundation.org>
Date: Fri, 22 Nov 2024 08:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pm: cpupower: Makefile: Fix cross compilation
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Peng Fan <peng.fan@nxp.com>,
 "open list:CPU POWER MONITORING SUBSYSTEM" <linux-pm@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241121044353.1753244-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241121044353.1753244-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/24 21:43, Florian Fainelli wrote:
> After f79473ed9220 ("pm: cpupower: Makefile: Allow overriding
> cross-compiling env params") we would fail to cross compile cpupower in
> buildroot which uses the recipe at [1] where only the CROSS variable is
> being set.
> 
> The issue here is the use of the lazy evaluation for all variables: CC,
> LD, AR, STRIP, RANLIB, rather than just CROSS.
> 
> [1]:
> https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-cpupower.mk.in
> 
> Fixes: f79473ed9220 ("pm: cpupower: Makefile: Allow overriding cross-compiling env params")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Change-Id: Id98f2c648c82c08044b7281714bc6a8e921629ad
> ---
>   tools/power/cpupower/Makefile | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
> index 175004ce44b2..96bb1e5f3970 100644
> --- a/tools/power/cpupower/Makefile
> +++ b/tools/power/cpupower/Makefile
> @@ -87,11 +87,11 @@ INSTALL_SCRIPT = ${INSTALL} -m 644
>   # to something more interesting, like "arm-linux-".  If you want
>   # to compile vs uClibc, that can be done here as well.
>   CROSS ?= #/usr/i386-linux-uclibc/usr/bin/i386-uclibc-
> -CC ?= $(CROSS)gcc
> -LD ?= $(CROSS)gcc
> -AR ?= $(CROSS)ar
> -STRIP ?= $(CROSS)strip
> -RANLIB ?= $(CROSS)ranlib
> +CC = $(CROSS)gcc
> +LD = $(CROSS)gcc
> +AR = $(CROSS)ar
> +STRIP = $(CROSS)strip
> +RANLIB = $(CROSS)ranlib
>   HOSTCC = gcc
>   MKDIR = mkdir
>   

Thank you for the patch. I will apply this once the merge window
closes.

thanks,
-- Shuah

