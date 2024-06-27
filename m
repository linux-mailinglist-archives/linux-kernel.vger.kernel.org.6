Return-Path: <linux-kernel+bounces-232761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CE091AE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30C51C216CD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A421019A2A8;
	Thu, 27 Jun 2024 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LTDrlDZb"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FA19A287
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719509395; cv=none; b=krkiT2rlgsFaPna0k2qM1yNz5CD4iYiocH8eBjYxYkjCxSciF95U7tPuRFJQydU7NYzNIqliFGdll2HHBjJWtN+8mIHa2VI6UPbMJvbY8VMqaHPa2tzZ3eAuTeYEAw2uK3+3tNnwa7Q9CBPphdLqglD7XZLS+ayi9MtNs4S8CBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719509395; c=relaxed/simple;
	bh=zWsElhqpj4fMB+iLijGBpbu+QyUcM22M9Gs8UsyVQ+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfQ/mtnvqNzO23hy3djtQt2WkqWRwF0jM/D2PG1m+encsNuv42QTTWFfdOA3fVY+Md8BQqgq+DDiU+1jMrcxeK9G9wo9vQlOaxPWCQ7GjXbUHnMbQtLhnFks2I4HINEYcmr1apk9RXr1indtU/Zd2sBto0KyOOf3CF29ZDnWV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LTDrlDZb; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7f3d614419bso4104239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1719509393; x=1720114193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TE7XfWBRNZhzVuyF1wDQxkJAMsIzL6P4kt13AjBK80I=;
        b=LTDrlDZbYAUGwe0++UQvffpkWM2BTpjWdp2i7Y/GzEdHk+EQUTT3lnv7hEwXE4OWI4
         br7xEs4erwWPXVaCBFZ1mD2MVFKf7bOtbhHi58HHLupWL/XxXfS/BF7LUhOvdj2Vy1uI
         htMGZBx0l15VJMLG1Er4xdEPcsSMDF3je2Xr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719509393; x=1720114193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TE7XfWBRNZhzVuyF1wDQxkJAMsIzL6P4kt13AjBK80I=;
        b=tour5GFZFjjeCmX8rOw6yz72SEOe7APgRX/NYRSi3wCcFbzv/LDVxbI+KUtULuPcS2
         gOYbYZalrL+Fm3bPiPmSEaR9JhrNYHZJ5to7J4Q04S8rBA/2adCdSi4/PoHn5d+KfNEc
         ipuKUstXAWfrMyjUR28gH/EJwznC5esWDLZ+a1/NEXhw+STnym8PZIWdUV8TdI6hPwQg
         +Q3xQrBYLsf1i9kPozDQOTTgI9lBRujcuEup1gPyzXbXPnFeXy9b8hpFYbsBktoJySnQ
         NG+LVpVtr4+p2DW9VJvMu5QHGf/OLdrMviwQdXg94rXl9V0oOwS2holIEb2ZyNEe+eqg
         aC8w==
X-Forwarded-Encrypted: i=1; AJvYcCWkj/JHvIhQ/RuofudFdQzPLGuDX5BN3CwzkxUD3QIzfU9/1Rmw7WexQkvS2QyogEv4OZk1H526T4OY7XBqte/M0464YiaTSPnZz28y
X-Gm-Message-State: AOJu0Ywpo/h1Tcbv5oeh0U6PTUPqihF+A45Tef3+OtqJljTvEvkgKmdo
	jRLXAePpRkEmFlJNv4PgscnU2jm62zKi91U0u+a5oFdUDLaDRp0MNad0GFvEyf0=
X-Google-Smtp-Source: AGHT+IGuv22TRRCkg0w93q8TXiGPUGSAq+F4m8yDrb26yLn3ifVMjUoHjcL8Je5l13wqAxyS4FmOOg==
X-Received: by 2002:a05:6e02:4b2:b0:379:2b4d:d5de with SMTP id e9e14a558f8ab-3792b4dd9cdmr38555345ab.2.1719509393382;
        Thu, 27 Jun 2024 10:29:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad4370c46sm10305ab.64.2024.06.27.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:29:53 -0700 (PDT)
Message-ID: <8b040e83-5eda-4b59-96a9-d76cb4f80d70@linuxfoundation.org>
Date: Thu, 27 Jun 2024 11:29:52 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/capabilities: Fix possible file leak in
 copy_fromat_to
To: Ma Ke <make24@iscas.ac.cn>, shuah@kernel.org, usama.anjum@collabora.com,
 swarupkotikalapudi@gmail.com, amer.shanawany@gmail.com, kees@kernel.org,
 akpm@linux-foundation.org, luto@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240627015732.2974078-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240627015732.2974078-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/24 19:57, Ma Ke wrote:
> The open() function returns -1 on error. openat() and open() initialize
> 'from' and 'to', and only 'from' validated with 'if' statement. If the
> initialization of variable 'to' fails, we should better check the value
> of 'to' and close 'from' to avoid possible file leak. Improve the checking
> of 'from' additionally.
> 
> Fixes: 32ae976ed3b5 ("selftests/capabilities: Add tests for capability evolution")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch according to suggestions;
> - found by customized static analysis tool.

Care to give more details on this customized static analysis
tool?

> ---
>   tools/testing/selftests/capabilities/test_execve.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
> index 47bad7ddc5bc..6406ab6aa1f5 100644
> --- a/tools/testing/selftests/capabilities/test_execve.c
> +++ b/tools/testing/selftests/capabilities/test_execve.c
> @@ -145,10 +145,14 @@ static void chdir_to_tmpfs(void)
>   static void copy_fromat_to(int fromfd, const char *fromname, const char *toname)
>   {
>   	int from = openat(fromfd, fromname, O_RDONLY);
> -	if (from == -1)
> +	if (from < 0)
>   		ksft_exit_fail_msg("open copy source - %s\n", strerror(errno));
>   
>   	int to = open(toname, O_CREAT | O_WRONLY | O_EXCL, 0700);
> +	if (to < 0) {
> +		close(from);
> +		ksft_exit_fail_msg("open copy destination - %s\n", strerror(errno));
> +	}
>   
>   	while (true) {
>   		char buf[4096];

thanks,
-- Shuah


