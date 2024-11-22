Return-Path: <linux-kernel+bounces-418394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119569D612B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BD63B22D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EAD1DE2CB;
	Fri, 22 Nov 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0sl82Qh"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E15148FF3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288503; cv=none; b=ELOXe0/J1cR5e76+fZBO/LeFuFIbzn1iLQJLRpe5WX3/wpM3LY6bWaA9hoRlNLk54nwbnlI4161gnxEGAWvkqo0RxwZEnSvxPlZy55rvdxBqN9wOPqcBhicgf29W5MiGdSG82vtgG8E2jD3Ru8sY614xsVhaSe+FEK8qEsfKK34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288503; c=relaxed/simple;
	bh=G4ZWYFmDGGCQIedY71/8GZGdAfKcnsuVFa5JVn99a40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4X5ojLrdtCh/5Q3q+uHQVa6c1jU7CnDpvFrpGlJ2mvrSC0nSxr5e3fWiFCCMF6jC9gxUANOHcjB1jfnQITZTH+tdRZjbFXH/pPHWE2y+u1w6SqgO2u+RIMd9NRIkjQ/eJQ+DP15Pk0TK+8B/EoTmJ/ieksYzyrKeA2VJO3V64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0sl82Qh; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso78240939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732288500; x=1732893300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmBxC4X0qWTi2jB3Mdi9nSIUH+PS6n9GSNvglpxej84=;
        b=d0sl82QhPnq84etKN05j5uIcVQ0fDAtllmUo3ENl6LHqc/FE29FuxkudCbEzHXaOLM
         SqfYgvVMwCmhCihB1tE4trzsr/522vvpr77e+qPZ7YYl4Eob17aV7Ea/Pa0+BFB126J3
         ZEan1Yo/R3EMd1RW3CYQAHlHwdDD8oCmh8aJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288500; x=1732893300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmBxC4X0qWTi2jB3Mdi9nSIUH+PS6n9GSNvglpxej84=;
        b=B4cOq0mzwwd+Pw5dhYNqnd+hRCuZMzilzCnhL3IsS0O+bFo1pv9/5W61mKKlKEJfUO
         8xK6+W3FrUlZJ+gNSH0CkR5zp6N0rsRIxxNIDOarIWTPaMbZDxh+WR0rLDcVglbtMzuq
         PaE6NxXh31WpFLfgyM8sbWdaAXkXHD55NPl5wauk3VuX81ZD8cgpQXHG2BGRETqu5PV7
         Oj9EPN2TN/4yVdjTBlObiHR1GWRjkr0S0RMbpNZ6RkGDKyBdqz3TX4THhD+pBsp3V+Ch
         mf2EIYD2hGGNFAoypFw/EctLUfD/zqLSRSheSkiFddy3logN2EkmIIoTw951Ym02Q8Gr
         ftJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmwI8CiVQauPssdQyA0RsCjYKJHZjH9mVhfC1LK/U5HVXuwrzqtkO5J1yJ7oTwYFZVAGl+nWh2IDHLxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK65aFSt8yUz9piBG3Rz0sM3LigPR7msVdB91W6A5MWQvVV9bh
	puarxrXJOduErBGxUqyS1/XqquoGdkx2GgoUcmfIXpuewC6Lml4l/wYCoxCPaWY=
X-Gm-Gg: ASbGncuQM5rRYWJa7pg61eIC3K1lfU8WrK3xxIrN8ATsFkpjjo93yVpGAiG2flQvywH
	G8TqFSuH61ot+d/Oe3A2getagEx1pKQFETyPLWy6hhZOXxasOZP2SkXfiOsRZBsJiM+WGzC/Pwl
	JgNstuAi42hxZwf802qUbZLMtpisDXbJ9HEpRQgLGVq2WaIQ08OnB8lLl7kqg/seSkWHNljUzQM
	5hKaIt8kd3Wuvkpq7WXLNPDMj+n0B7Cs4sL5XQIes8T5yP0xQQl5waNXFg8QA==
X-Google-Smtp-Source: AGHT+IHy5Cwa3AA3W2fNjldnU0Ki3uW2K71uWzdXCbgAWsASPCmhOBROw7+r3q6xtya9E03fAwzWCw==
X-Received: by 2002:a05:6602:3c6:b0:83b:47:8d5 with SMTP id ca18e2360f4ac-83ecdc538d9mr370017639f.3.1732288500377;
        Fri, 22 Nov 2024 07:15:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe1a0e2sm640295173.7.2024.11.22.07.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:14:59 -0800 (PST)
Message-ID: <93d96c99-4712-4054-a36f-3c65c80ab3f8@linuxfoundation.org>
Date: Fri, 22 Nov 2024 08:14:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kselftest] fix single bpf test
To: Jiayuan Chen <mrpre@163.com>, linux-kselftest@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: song@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
 ast@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241118140608.53524-1-mrpre@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241118140608.53524-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 07:06, Jiayuan Chen wrote:
> Currently, when testing a certain target in selftests, executing the
> command 'make TARGETS=XX -C tools/testing/selftests' succeeds for non-BPF,
> but a similar command fails for BPF:
> '''
> make TARGETS=bpf -C tools/testing/selftests
> 
> make: Entering directory '/linux-kselftest/tools/testing/selftests'
> make: *** [Makefile:197: all] Error 1
> make: Leaving directory '/linux-kselftest/tools/testing/selftests'
> '''
> 
> The reason is that the previous commit:
> commit 7a6eb7c34a78 ("selftests: Skip BPF seftests by default")
> led to the default filtering of bpf in TARGETS which make TARGETS empty.
> That commit also mentioned that building BPF tests requires external
> commands to run. This caused target like 'bpf' or 'sched_ext' defined
> in SKIP_TARGETS to need an additional specification of SKIP_TARGETS as
> empty to avoid skipping it, for example:
> '''
> make TARGETS=bpf SKIP_TARGETS="" -C tools/testing/selftests
> '''
> 
> If special steps are required to execute certain test, it is extremely
> unfair. We need a fairer way to treat different test targets.
> 

Note: Adding Mark, author for commit 7a6eb7c34a78 to the thread

The reason we did this was bpf test depends on newer versions
of LLVM tool chain.

A better solution would be to check for compile time dependencies in
bpf Makefile and check run-time dependencies from bpf test or a wrapper
script invoked from run_tests to the skip the test if test can't run.

I would like to see us go that route over addressing this problem
with SKIP_TARGETS solution.

The commit 7a6eb7c34a78 went in 4 years ago? DO we have a better
story for the LLVM tool chain to get rid of skipping bpf and sched_ext?

Running make -C tools/testing/selftests/bpf/ gave me the following error.
Does this mean we still can't include bpf in default run?

make -C tools/testing/selftests/bpf/
make: Entering directory '/linux/linux_6.12/tools/testing/selftests/bpf'

Auto-detecting system features:
...                                    llvm: [ OFF ]


   GEN     /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
libbpf: failed to find '.BTF' ELF section in /linux/linux_6.12/vmlinux
Error: failed to load BTF from /linux/linux_6.12/vmlinux: No data available
make[1]: *** [Makefile:209: /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h] Error 195
make[1]: *** Deleting file '/linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h'
make: *** [Makefile:369: /linux/linux_6.12/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make: Leaving directory '/linux/linux_6.12/tools/testing/selftests/bpf'

> This commit provider a way: If a user has specified a single TARGETS,
> it indicates an expectation to run the specified target, and thus the
> object should not be skipped.
> 
> Another way is to change TARGETS to DEFAULT_TARGETS in the Makefile and
> then check if the user specified TARGETS and decide whether filter or not,
> though this approach requires too many modifications.
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>   tools/testing/selftests/Makefile | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 363d031a16f7..d76c1781ec09 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -116,7 +116,7 @@ TARGETS += vDSO
>   TARGETS += mm
>   TARGETS += x86
>   TARGETS += zram
> -#Please keep the TARGETS list alphabetically sorted
> +# Please keep the TARGETS list alphabetically sorted
>   # Run "make quicktest=1 run_tests" or
>   # "make quicktest=1 kselftest" from top level Makefile
>   
> @@ -132,12 +132,15 @@ endif
>   
>   # User can optionally provide a TARGETS skiplist. By default we skip
>   # targets using BPF since it has cutting edge build time dependencies
> -# which require more effort to install.
> +# If user provide custom TARGETS, we just ignore SKIP_TARGETS so that
> +# user can easy to test single target which defined in SKIP_TARGETS
>   SKIP_TARGETS ?= bpf sched_ext
>   ifneq ($(SKIP_TARGETS),)
> +ifneq ($(words $(TARGETS)), 1)
>   	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
>   	override TARGETS := $(TMP)
>   endif
> +endif
>   
>   # User can set FORCE_TARGETS to 1 to require all targets to be successfully
>   # built; make will fail if any of the targets cannot be built. If
> 
> base-commit: 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1

thanks,
-- Shuah

