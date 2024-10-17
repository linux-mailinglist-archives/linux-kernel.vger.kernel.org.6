Return-Path: <linux-kernel+bounces-370091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF979A273D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6514A1F21277
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 15:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0711DD537;
	Thu, 17 Oct 2024 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a2puW260"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485B1DED40
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179938; cv=none; b=d/MBlmxLMYTvBPn+rcomA6urqEyrcSmwnF8zURtyWA28oyYIPQJPS+I/N9fZynVxNHtvF+amhb/tRBefnvg4mS1dI5UrZFxyFn57nB84cwTS7LnLDps/i2mcv7cxdUMdfoFI4jDrLovapof5J6Tj1Jwe5/Fe9u+8VDx2nd0K9L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179938; c=relaxed/simple;
	bh=Tf/9FF4ryDOCGk5Axz8hHeCv34zmpcWdeQwBFbKecTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dg7ucO94vq5KK4hpdDP1+8hNrTzcbZB7Zudzc6HQs9EqvU1xmfgzSED9JLDrupnZ0cpiLil1KCejukyRAP2Qw966fy3NrjY7e9sguZ15S3ckGrUxWbumv7fk8KAX579judz+ydqAkDS9nXbwaG3SztYBDWPcQRrkqh+IR99Ey1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a2puW260; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-83aae6aba1aso44207339f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729179932; x=1729784732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wgzc6Tanx1j/oxduWDX4CPi0S2/TOLRwOCCY8Sr81rI=;
        b=a2puW260RAPyUTbwvnQBTFS8k+7SL8+YSTbERYkWp3lOAHe54+CEt8jwcuUbGYYfNA
         lAHK5l2WMjQJJpYZJbtlOpUzpFN9HN2nj0Sq21Feap4LtS0KnxaVQjXw1fGFxzxI4xx4
         LmLJ9pw++S2/b5CeuNnS7ISZ6chnNKZyo1xG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729179932; x=1729784732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgzc6Tanx1j/oxduWDX4CPi0S2/TOLRwOCCY8Sr81rI=;
        b=mIiFfkZVvrAIW1UjpFsQZr5KD7QAPLAWdg/EcaXnEFy+pjgGJzJAkiyGns6gg4k2Oq
         Hpo2YXeIMPrwAYsa5ZlvLLcoYubYkmkktORW8CXqNfgyjy1OXgPKEeTUXlypvdXnW4vK
         Yvjfvke7mEQVNMMwr6mZcfSWi6t7v7QnZHd/BS8AbMbMeG6Jwg55GLp+cJCmoa8PBoLN
         OE7PRktbyenzYnS4K9x9Nu/aubMFpurTTYITQCdrMz7H5pCGLW/ypZWLMO/3cugnvEli
         sLqeFJ9XCwtjLGUkrHaOpIAp4ZA9073Rh6/hWt1mgHRaYvL1FfOPb3dR6NkvlJDaTDEp
         oIaw==
X-Forwarded-Encrypted: i=1; AJvYcCU2R+bie5wLDl8F83mu0X/NdksPUO7GaWlVRRetlnu2SEXWBt1SIyu74wDYRPvpWvqaxTyVjjVYJ16pacA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2icw4roGfofp1NgV+w1A9ql/+0LGzCT+2XV7IntZmhZ3K/1ID
	hBlXrGwBez5bn9EHHl69WgLX59No9Vvj3k0dmxdsd1UjCzd4qlkgoNxrgJQ5mJ0=
X-Google-Smtp-Source: AGHT+IEBeL+uRYHNmHyvAAgibrTgO3SnP5KZI8eJYAGY0+BnOezh/JDiKtJTlMw9i/w2YOgMrBrqrg==
X-Received: by 2002:a05:6602:6416:b0:83a:af06:4ae3 with SMTP id ca18e2360f4ac-83aaf064b4emr264500439f.0.1729179931909;
        Thu, 17 Oct 2024 08:45:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec95e8edsm1414082173.9.2024.10.17.08.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:45:31 -0700 (PDT)
Message-ID: <01c1aed5-af19-4636-9ef6-ff519841e421@linuxfoundation.org>
Date: Thu, 17 Oct 2024 09:45:30 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/2] selftests:timers: remove unneeded semicolon
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, anna-maria@linutronix.de
Cc: frederic@kernel.org, tglx@linutronix.de, jstultz@google.com,
 sboyd@kernel.org, shuah@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241017062737.98466-1-jiapeng.chong@linux.alibaba.com>
 <20241017062737.98466-2-jiapeng.chong@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241017062737.98466-2-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 00:27, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./tools/testing/selftests/timers/nsleep-lat.c:62:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11406
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/testing/selftests/timers/nsleep-lat.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
> index de23dc0c9f97..6f7f7d682439 100644
> --- a/tools/testing/selftests/timers/nsleep-lat.c
> +++ b/tools/testing/selftests/timers/nsleep-lat.c
> @@ -59,7 +59,7 @@ char *clockstring(int clockid)
>   		return "CLOCK_BOOTTIME_ALARM";
>   	case CLOCK_TAI:
>   		return "CLOCK_TAI";
> -	};
> +	}
>   	return "UNKNOWN_CLOCKID";
>   }
>   

This is the same change. same comment on this one too.
I am working on deleting the duplicate code and there
is no need to make these changes.

thanks,
-- Shuah

