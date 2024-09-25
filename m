Return-Path: <linux-kernel+bounces-339339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DF7986383
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27E91F253E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFC17BB33;
	Wed, 25 Sep 2024 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cmTBwm4Q"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F54D26AE6
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727277645; cv=none; b=OUoUne74ziUqJn21ptEzMrjtCvONlx3s6K/nuSXB04fPoN37TUXSGpgSWScxHuJjrj4dOPoFkZmiSuYKiZeWsnDzRG8VWYopBN1h/XJb5RXz/BG+JaghA7fiUr4DB6eGMOPCE1Z0QiaxhEF6yqgnFYF7C5PHs3a5bsm+BrRQy9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727277645; c=relaxed/simple;
	bh=XaGEPxm13ZPyb7M9Q1SxZsnROr0WKNhOw8TakKeNanc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl/LpC6xvo0FOcvlYB7Z5mAekvP+R/2mJcnsGSYqu2Yw5woY2tiJzNR2ebxtTNSDefTbOCF93cK1++09xM2etM8SICSjKHKOJgJ68O+5d1YLCRxB8nxjihHThiyil6HEwbzMtoPrfEs+KdmGRwFZS34WRlJqPjT2ixEQN59QSDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cmTBwm4Q; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-39f52e60a19so37104955ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727277643; x=1727882443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85DZ/vgxOYbmSudD4vwdiq4BSHmbhOCjGRMKG9Chzlc=;
        b=cmTBwm4QjYC0OpsBiWzmKtOGMeY5dZCrNEyHslDjeG9Tf0UTxuGfh9JhjnUKA4dYJa
         JI07+hv7IbGj9fG8LNGy8CGcWEn/sAPdprchPd5BP+gN/yoS2FceMaRfAfSuz51b8BGJ
         7OyO882acxdmZywihWyz8zS+qmrvKzel3hVGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727277643; x=1727882443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85DZ/vgxOYbmSudD4vwdiq4BSHmbhOCjGRMKG9Chzlc=;
        b=pdsBCzatd8EbMEG7HrlKFhW56LEubC/bWk5FUR3971gEYiOFe/C738QORCztRdKl3K
         YrbX9gcLGyVn7wLT7VknhErSWocxhfuJFS/2DHGKBtC08ey2ctNhedl0nsEYmm/QhDsY
         s1HRQOspW7eNc7XMG4UKvCRn2HoYP902h/Y2xPCPTK43apZ/7eaORWcBz1d2fWwWTMI2
         rcNO4sT7jJOdWp0764U1Kw4F0c15QTvwDX5e2p9zsftp+p52KDWSL7K/WNc1HUsABx7d
         eHvTHNka4rfZt6Blp65385YpF51x7JeoiRM0fqR84Q+IKHoR8uget1QmXOPikT0m4Fho
         EjZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8g5+6QXnHqn/CazUP2PWjUqSE7wLPx3l99L7tM2dJaA2g2xe7y/R6pBAHSkqM2pwFUZz6tr1/HcqPTjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXnGccSie4h1TN6gCtud6LV+Uvvk+K4Fhi8dtWHru6cgmaBYa
	W4OpxymADy9B4fE++6SzfR7pzt3QwXZNB2i5/1aubzFh9GND4hKE0Ss76Ebk1tY=
X-Google-Smtp-Source: AGHT+IFI7DFenmcYY8kh9TfP8aJOyHdE3yc7uSvC+foon1IBV/U2ir7CEi9In42oU480kpPYgX+Sgw==
X-Received: by 2002:a05:6e02:164d:b0:3a0:9ec4:92b6 with SMTP id e9e14a558f8ab-3a26d78ef1bmr31918605ab.15.1727277642685;
        Wed, 25 Sep 2024 08:20:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a1a56daabasm11293495ab.39.2024.09.25.08.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 08:20:42 -0700 (PDT)
Message-ID: <b0647b67-5cba-4e42-9d42-d12ba2aa2174@linuxfoundation.org>
Date: Wed, 25 Sep 2024 09:20:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests: timers: Remove local NSEC_PER_SEC and
 USEC_PER_SEC defines
To: John Stultz <jstultz@google.com>
Cc: tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1727191485.git.skhan@linuxfoundation.org>
 <f797bc704d8eb03234a3447c77fa7b704339f89a.1727191485.git.skhan@linuxfoundation.org>
 <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCpsEQL+S8gadXMjvbE-6r8c6owzz+_DhN6JAVqQ8Hg=_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/24 17:59, John Stultz wrote:
> On Tue, Sep 24, 2024 at 8:57 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> Remove local NSEC_PER_SEC and USEC_PER_SEC defines. Pick them up from
>> include/vdso/time64.h. This requires -I $(top_srcdir) to the timers
>> Makefile to include the include/vdso/time64.h.
>>
>> posix_timers test names the defines NSECS_PER_SEC and USECS_PER_SEC.
>> Include the include/vdso/time64.h and change NSECS_PER_SEC and
>> USECS_PER_SEC references to NSEC_PER_SEC and USEC_PER_SEC respectively.
> 
> Nit: You got the last bit switched there. This patch changes local
> NSEC_PER_SEC to the upstream defined NSECS_PER_SEC.

I think what IO have is correct. posix_timers defines them as NSECS_PER_SEC
and USECS_PER_SEC and the header file doesn't have the extra S. It could
use rephrasing thought to make it clear.

Is it okay to fix this when I apply the patch or would you like me to send v2?

> 
> Overall no objection from me. I've always pushed to have the tests be
> mostly self-contained so they can be built outside of the kernel
> source, but at this point the current kselftest.h dependencies means
> it already takes some work, so this isn't introducing an undue
> hardship.
> 

Yes. At this point it would be hard to build it outside. DO you think
these defines can be part of uapi?
  
> Other then the nit,
>    Acked-by: John Stultz <jstultz@google.com>
> 
>> diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
>> index 205b76a4abb4..cb9a30f54662 100644
>> --- a/tools/testing/selftests/timers/adjtick.c
>> +++ b/tools/testing/selftests/timers/adjtick.c
>> @@ -22,14 +22,12 @@
>>   #include <sys/time.h>
>>   #include <sys/timex.h>
>>   #include <time.h>
>> +#include <include/vdso/time64.h>
>>
>>   #include "../kselftest.h"
>>
>>   #define CLOCK_MONOTONIC_RAW    4
> 
> I suspect CLOCK_MONOTONIC_RAW (and the other clockid definitions)
> could be similarly removed here as well in a future patch?

Yes. It could be cleaned up. I will send a patch in for this.

thanks,
-- Shuah

