Return-Path: <linux-kernel+bounces-205129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2F8FF7BE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BBA286647
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C888BFC0A;
	Thu,  6 Jun 2024 22:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Au9P+D8l"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927313DB8A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713684; cv=none; b=SUY+UuTObYtrqA/NFCptoZlA9GzKAHzR0Ow2K+vgLU6/MvzrfbQQCYr7ciNAWX+m5Ha28UTbUpNsQrBxPlJihzvfTC3619REJKv/rLSH/fXBkWe7HAA2KyCAYe+NoHQGPBwsQkzFBodfmbyMCBd9cxma008/vVtjYopTdmIdo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713684; c=relaxed/simple;
	bh=zxcSda9gU+HzNUpNd0mmDETx9ck9BJ1lS0ujOJFIF/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE3tl3vAWCErqZ+DhyRxxsKuI0xiTIB9WdPOLwgmGFuzbwkVXxThV6JaMGVbtwlBtvAVOiIWBdVAsyYqd9AEVJeg/TeqS2SCcm982MaNIJ7hVOzWkw/3fQHshv/tNKw/Xp5mDAcMm+/GIup8jKLuIhkrUNb4TS1CeQwGj/YeoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Au9P+D8l; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5b97f09cde3so176500eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 15:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717713680; x=1718318480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fu83QXOMrXhByeadwJGN5pkmUocyBJK3IGgFCoxU680=;
        b=Au9P+D8lFjz2Jx2LpI+xclxnrIa8k3adfBkzhuEn0TD//MUw+n/qW0xxfV1bo1oJg6
         zxpu4OVncTez2u7Q+K2t3tt3Oksg8FJClekWkF/M36xRv5M3E1hT3r/LIyp///Q207ze
         w9B8qPxz29Yragn1M97waNonQL3dEgU1TJM1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717713680; x=1718318480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fu83QXOMrXhByeadwJGN5pkmUocyBJK3IGgFCoxU680=;
        b=bgdJkN8q09HJIKX+W0oe1irmqxCwMqfsTO7NzFm0nMTM1fezSfPp/xGtBxuMqjmoYS
         Sz/Xb2dK+hl3Q+SfqTMGtdsCtmlqoA8UGV2jdyvlcck/nVL5SFKH47ONUgw8BOoajBUm
         zS00XRkppOPDJkRBosXQwBcfIJC7frtxRNkM6T4JM1E9+6AELvwRSXbBoQg3kTNXcIyD
         cQpbJ8uUes2wCJMcIUgKyx2vtnCPkzDfGY7eaRUh+tNcoQx01CUszVARe+YDTIiNF6NK
         guzInCulaOTTQIwPQDcrfdSYacq5tHF8C9V9brgZhKVFc++qdggQxNzyzDEgeTLcPpEX
         PzsA==
X-Forwarded-Encrypted: i=1; AJvYcCViOV45dQcIgDOiNUDzQ+4A30ErZet7o/cHH6RxqvqhC9MNJpVXrskZu16so/c6atxAgs+NfFmKeEvGW+Ghz8tgnS+9USgi9HPHeiac
X-Gm-Message-State: AOJu0YwGdRkrjB1jmIifh8RS/mDJIlaK4+X0Kz4ARj05E20p0EB+KS0P
	Al3tnWUrjKjRZJw458GAvtPcQ4R9uaLipMUevHakTSUcpKQl3fgiFDQkejuJYW0=
X-Google-Smtp-Source: AGHT+IFGczxipoctZnUp0jr1WE80vjoihITpV0Krs3FTVt+NHekgF5mGTIuEb5D0jWCijTVoZAhqNw==
X-Received: by 2002:a05:6871:3a13:b0:24f:cabc:4fa3 with SMTP id 586e51a60fabf-25463e7c2cdmr928272fac.0.1717713680050;
        Thu, 06 Jun 2024 15:41:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25448043150sm584518fac.39.2024.06.06.15.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 15:41:19 -0700 (PDT)
Message-ID: <be032a65-e61b-40e0-a982-cb622ccca548@linuxfoundation.org>
Date: Thu, 6 Jun 2024 16:41:18 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: seccomp: fix format-zero-length warnings
To: Amer Al Shanawany <amer.shanawany@gmail.com>, Kees Cook
 <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 kernel test robot <lkp@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240603115447.30279-1-amer.shanawany@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240603115447.30279-1-amer.shanawany@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/3/24 05:54, Amer Al Shanawany wrote:
> seccomp_benchmark.c:197:24: warning: zero-length gnu_printf format
>   string [-Wformat-zero-length]
>    197 |         ksft_print_msg("");
>        |                        ^~
> seccomp_benchmark.c:202:24: warning: zero-length gnu_printf format
>   string [-Wformat-zero-length]
>    202 |         ksft_print_msg("");
>        |                        ^~
> seccomp_benchmark.c:204:24: warning: zero-length gnu_printf format
>   string [-Wformat-zero-length]
>    204 |         ksft_print_msg("");
>        |                        ^~
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312260235.Uj5ug8K9-lkp@intel.com/
> Signed-off-by: Amer Al Shanawany <amer.shanawany@gmail.com>
> ---
>   tools/testing/selftests/seccomp/seccomp_benchmark.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_benchmark.c b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> index b83099160fbc..ed04b89de9c6 100644
> --- a/tools/testing/selftests/seccomp/seccomp_benchmark.c
> +++ b/tools/testing/selftests/seccomp/seccomp_benchmark.c
> @@ -194,14 +194,14 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(7);
>   
>   	ksft_print_msg("Running on:\n");
> -	ksft_print_msg("");
> +	ksft_print_msg(" ");

Why not delete this all together?

>   	system("uname -a");
>   
>   	ksft_print_msg("Current BPF sysctl settings:\n");
>   	/* Avoid using "sysctl" which may not be installed. */
> -	ksft_print_msg("");
> +	ksft_print_msg(" ");

Why not delete this all together?

>   	system("grep -H . /proc/sys/net/core/bpf_jit_enable");
> -	ksft_print_msg("");
> +	ksft_print_msg(" ");

Why not delete this all together?

>   	system("grep -H . /proc/sys/net/core/bpf_jit_harden");
>   
>   	affinity();

thanks,
-- Shuah


