Return-Path: <linux-kernel+bounces-370086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E99A2748
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F103B221D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF991DED44;
	Thu, 17 Oct 2024 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HI8ATAdk"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07F111AD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179838; cv=none; b=rrxCENXnki/P9rPaVyiaJSOLwvBQVXrJGlnQR/uq7ctQ5RGNJrjF62agGW2yp7Zmbg0Qm4Ng5Oa2/029DL1fOcBUjKxcX7bGgsI+XQSIiVmUfp5G7E9FUrqA2fi0reWVRIYLRLHdfqrNER9Y+vuj+pa7JdUdASvw8HfJqqHbHFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179838; c=relaxed/simple;
	bh=utfjfPeHwxg2ZkIgiCPxWkeetoe7r6m/ZjpNGiYWtbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqvu1oD8PCEpg/tSl35BTeN58K8nFraHuzA6dJlRGpGOENeUkbU9Ep4Xf2iu9lQrikFa5VbTOiSiDeaY1hFsJLFYU/NrNqKVFcOQzGBIzkoqHBF65Hbo2PTfryNQ6IFlg6PGJlfCAc2SkfUcr8s6sjPbVf0Xyf40bCMWGsYKLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HI8ATAdk; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3bd664ebaso4017215ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729179833; x=1729784633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N2TLRyPiVkwRPOD0VHQUjyER2asTM1IMsaE3PwZ1ReU=;
        b=HI8ATAdk8ekRK+bI0akMzAsUD6BLMv5yNy4OrlKTnYPXCySThD4Ja1catV2AQZp5wl
         jweD0OiONv9PXiFT0hH+KRDSBrwYUTx9FCz46Q/XhxlF3C9Mi9kOZSszwTjynbfoAwOf
         ytCon6prm51yRxeoal4+ef108fJep0/IwRvzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729179833; x=1729784633;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N2TLRyPiVkwRPOD0VHQUjyER2asTM1IMsaE3PwZ1ReU=;
        b=UJNKWRKlsNjRT+8H5o4gbmT09PWOUjHoqXvWDNWW0Zmd0osZy+g6g/DL7Z+yGZYRv8
         HWJXmbgvL/ZtrHuXFmVjc1U+Xr1gfyDzDztdJr9rRBeSl/WhGAtwS84Or3ifaQpc5fYr
         +W1exzDj2oyNyjQzzGABXQUZR94PLRIRTACjImg04iqCdDTvHecxFxfFPqc6+QE7SnH6
         F8o9GkzgmrTmNFf0ru3a6oGRHG5OVQCRcIKesWyyqBoyfYAHBfQ8bw2/wuUzlktdRfrT
         Xax3RNUyq2+WsaHAP9zpxFxzPM0Ubu/bgA1TvZ80X07f57qwvu5zBVOgUbB5GFhy2WwB
         WsZw==
X-Forwarded-Encrypted: i=1; AJvYcCX/OnPKgKZD57hLMGgCzVZOfyFn+F63nqJR2+0C6jNmEUJzBdGgaEqswamkmhSI5LOA0WBxmqitCpFt3j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzUmXzBocRtayZpv1daYcFNMT+Km9DjNHMopDjUrloVOM23rhC
	JaF5mXLlE/NFWknlf33ycMaR7cgB554sNaCqIyAf2C0RhB/I8dkh4vqtNQ3cUS4=
X-Google-Smtp-Source: AGHT+IEZp6wBEKaSOqa1wms4hZzU3RSefNxrdR8NAhHCfaTD7AXl8cVaxR0cdU1fbru8TXzbANus3w==
X-Received: by 2002:a05:6e02:1fec:b0:3a0:9244:191d with SMTP id e9e14a558f8ab-3a3dc4eee80mr79026895ab.16.1729179832979;
        Thu, 17 Oct 2024 08:43:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d714ed00sm14221635ab.53.2024.10.17.08.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:43:52 -0700 (PDT)
Message-ID: <c5411c4e-ade7-4d9f-9b01-2ac4ad42bbbd@linuxfoundation.org>
Date: Thu, 17 Oct 2024 09:43:51 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/2] selftests:timers: remove unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, anna-maria@linutronix.de
Cc: frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241017062737.98466-1-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241017062737.98466-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 00:27, Jiapeng Chong wrote:
> No functional modification involved.

Please include the report details in the change log
> 
> ./tools/testing/selftests/timers/nanosleep.c:63:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11407
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/testing/selftests/timers/nanosleep.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
> index 252c6308c569..36f9b97f232a 100644
> --- a/tools/testing/selftests/timers/nanosleep.c
> +++ b/tools/testing/selftests/timers/nanosleep.c
> @@ -60,7 +60,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   

thanks,
-- Shuah

