Return-Path: <linux-kernel+bounces-361924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE299AEFF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 01:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920AE286CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 23:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758E61D1E61;
	Fri, 11 Oct 2024 23:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cml+EH3Z"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E4198A1B
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687646; cv=none; b=IkFSIvf2SWnVp3RqKoy0ztcRHaG9LYa01lPu1Frb/bVywox6+2kyzi9U7najRs2syupx1sYAG67i1zjHiAZNOO3xdS4NV+6NKUkkd2LnvY84bT5GR6X7FUOW6CWeGpFSSqpiu+w2RSYbJGOLA0GO7bQduJ3EKfdCltu2om88jCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687646; c=relaxed/simple;
	bh=X3bWSeZTnOc7MAGzLkXIcsbWyQNpl5VHwrJcbNUK1gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL4YeEdoVdFgV7VfG3o07bF9yPxZz++lY84z3M2A+TEhnk/J9yIKHNDIYLZRHkj+nvP6koVF8PsmjPiJZ8E+clLu78BdMY2Of0MyxHMDF66TjNZ0CX3yp8bxXoH2gjy0DvFxTefBbd5edPE7WxmBrUhAFv2Mi3UsdUVM1EaLhb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cml+EH3Z; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-836f1b47cdfso88410039f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728687643; x=1729292443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G5NifOOd36N6AdmfZ9L3pQ43h2cP6xrBPCX/Z1jtyYg=;
        b=Cml+EH3Zk7eIPftCEB2WfgOsmyGjVzE6bXegE7D8fLctRcvQhooAS1qbQXU2ywgalm
         Ju61zra7z15/YxyTRO1k1bWrHB9LCGUB17eaMG14zCOZVemKvWJrtDqt1nLRCNNWS5M9
         LqBKh+Q9nnXq2k5LlPjRG3e1D1vbWfFPbTJTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728687643; x=1729292443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G5NifOOd36N6AdmfZ9L3pQ43h2cP6xrBPCX/Z1jtyYg=;
        b=hr3Z7Oh4e5fVVDP2cib879Tab0IkblvBjZRSM2D6pmksXAACxbRCoI7hY9P9vjP+tn
         D9ztWpOKKYcqL4mnSKI31DYI92ZUr+ntqz8Tp6jn7eY8P/8fTJxfqaLknQp7DO6VaPEH
         03DXocadlTJY3J8R5JYSs6bvG+Rqg4ds69/E9MxfeZ/q6oAgVHJvEpyUumj3l07cTK0D
         0YZW9N/vqKiPnQz9JTrjqQ5jXLCrkTMHFwTZU8OmDrt7z6PKB+mL58OBSZ2zw8mw/31K
         N+9ZOdEAgCF3LlK5RnKse43Zc97u15J8VqlrQxWOVrtSsnzaDK5KMb6AU4QijJoy12Xt
         Oytg==
X-Gm-Message-State: AOJu0YyNHbtmH4YMEng0mvgH529ucubKKY8Rd4A7CeudNgUpIgffz4NJ
	1nT4KvGIIYHKBLR5Yf2RxQ0/7rvhghj27l8bzAjagbDeVn6iDycE4O3al3m8s3w=
X-Google-Smtp-Source: AGHT+IFEcyoXbqU+16RY6ik4nYc4ZIBFu6kUHHy/pTQc27WlEIC6PZiuhbH/pQpiplX19mTm6syTng==
X-Received: by 2002:a92:c241:0:b0:3a2:91f:497b with SMTP id e9e14a558f8ab-3a3b5fa76f0mr40556545ab.13.1728687643360;
        Fri, 11 Oct 2024 16:00:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3afdb3688sm9148835ab.28.2024.10.11.16.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 16:00:42 -0700 (PDT)
Message-ID: <87492b3f-84d1-426f-ad71-7784a1c1dfc3@linuxfoundation.org>
Date: Fri, 11 Oct 2024 17:00:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: timers: Remove unneeded semicolon
To: Chen Ni <nichen@iscas.ac.cn>, jstultz@google.com, tglx@linutronix.de,
 sboyd@kernel.org, anna-maria@linutronix.de, frederic@kernel.org,
 shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241010073707.4038081-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241010073707.4038081-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/10/24 01:37, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>   tools/testing/selftests/timers/set-timer-lat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
> index 5365e9ae61c3..7a1a2382538c 100644
> --- a/tools/testing/selftests/timers/set-timer-lat.c
> +++ b/tools/testing/selftests/timers/set-timer-lat.c
> @@ -79,7 +79,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   

Looks good to me.

John, I will apply this for next of you are okay with it.

Also I noticed clockstring() is defined in multiple tests.
Any thoughts on removing the duplicates and adding it to
a header file? This will add a dependency on another source
file, but might be good to remove the duplicate code.

thanks,
-- Shuah

