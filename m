Return-Path: <linux-kernel+bounces-267891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCC5941968
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651C5284872
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0003183CDA;
	Tue, 30 Jul 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="MbWuQbYB"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F431A6199
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357110; cv=none; b=RLNmVQkJfX9tmnNogHoqY7L0bSW5KxJvy7Kb8i4v0oQijCVsqu1EvzPFDh/JyHbQnJHWVbA3IlnevS6SsCycrqTwMDObaKBEDEuhuza4L3gAYGsh5sZ5BOQUD3LpKyCgfAG0Uc0NQ0KGo7eEBi9xychq7FfpmM3xC8KTknZliHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357110; c=relaxed/simple;
	bh=C4eh0fmTz0+252ic1Rz388oLSSyUr4bpLJf+JQixmUA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=YLXimntQeWsj7kDXVHMc/YoyESdFC2UrFqfXZk3IaIhxuultDaD3SSOh2p3wOsYGfiblS6MHcw/HcEBfDO1FPggzQLWmL/57QWc19/P/j9pJVauu7o6vrgfgDSp1YifkJ9Oz+pci1vcCnhyY4D7ZkiL/FHsvGrw8mIEcB7jXHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=MbWuQbYB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39ae90034bdso19881075ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1722357106; x=1722961906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNBJvcFevwmgBZA9//H4dblcQszt8ZqZ+jbcb4XqUhA=;
        b=MbWuQbYBuEaEn5At2enlSy9kxprcU/x71Lq+xbNfcNXGjo2qM4i2LJU1WFq63HnlOX
         croWrmESKwADhXypNl5Q6yECRdVc2JdzdR9v4P9UuI1qUgAWCU/8DIaMYlb1BSS32K44
         4ZWumJp9aObz1a0WX+ftVaKh19u2g3ZoJQ4N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722357106; x=1722961906;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNBJvcFevwmgBZA9//H4dblcQszt8ZqZ+jbcb4XqUhA=;
        b=pOqQQE33cuzVbc6+e32yq3/OBfPTbjVEk8ar8TZKy13o4WfkeL/TtwruTWdeTntglA
         h+4Z/YxRAiuIGvBaZ7qXPpZ4LtDB4fOg5/mzykqRe7h+KXXyTVYMOWwORnuYJx9SrrU9
         9ZcAshWjcsUPOGHkq4mgr7ZNZZZvV1FY4ucEwIoY6Q+bCis9TvZooM9WsgboH7vBzXud
         fft56w7vFWb/BnOhYDrQa1Li5O5w1P0xHg7sTo4c8FFgJvX9qS+9DDSTOD5etWoO3mRC
         1nW0wxMtZtEu7+mvjhMr2lQbrgEANjSsLie01iLyWqBWNUCsf1maF1O3MwuDMMVZ62PC
         Axxw==
X-Forwarded-Encrypted: i=1; AJvYcCVaw9VVAGv2lcDCdmibqV7zrWRNZviLVClD4zC8+mWXBZoIjs/vvHaTMD9q+0M7fTYgOytmtSXTkEyY8PJudt4UJHe78k5cripJD2sO
X-Gm-Message-State: AOJu0YzDABPs2AKWwqigHpKJibwlOM0mY8jbBLBkHy/kqqqtejGGQgv2
	nz42bNlDqvOdfqlJLtLt9OtxmVPU2g7ydDaPqwJO6xprvt4KOupcBHsuplk7tQ==
X-Google-Smtp-Source: AGHT+IEHkfnVgoIPIizd+q5uKxNaKPx3+5xQ2nPzwl2AgH3Q91Fem7hTqlgzJdUkSyc28QiVHZJZTw==
X-Received: by 2002:a05:6e02:20ea:b0:380:f340:ad66 with SMTP id e9e14a558f8ab-39aec42d8e9mr143720905ab.26.1722357106157;
        Tue, 30 Jul 2024 09:31:46 -0700 (PDT)
Received: from [10.211.55.3] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-39a22e7e79fsm48336615ab.4.2024.07.30.09.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 09:31:45 -0700 (PDT)
Message-ID: <3f987064-c955-4554-81fa-03b21dfa51e8@ieee.org>
Date: Tue, 30 Jul 2024 11:31:44 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: MAINTAINERS: Demote Qualcomm IPA to
 "maintained"
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240730104016.22103-1-krzysztof.kozlowski@linaro.org>
 <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
In-Reply-To: <31f49da0-403c-40af-b61b-8e05f5b343e8@ieee.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/30/24 11:29 AM, Alex Elder wrote:
> On 7/30/24 5:40 AM, Krzysztof Kozlowski wrote:
>> To the best of my knowledge, Alex Elder is not being paid to support
>> Qualcomm IPA networking drivers, so drop the status from "supported" to
>> "maintained".
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> I hadn't thought much about the distinction, and it might not
> make a lot of difference right now.  But it's true I'm not
> being *paid* to maintain the IPA driver (but will continue).
> 
> Acked-by: Alex Elder <elder@kernel.org>

Oh, and to be clear, please keep it "Maintained" and not
"Odd Fixes".

					-Alex


> 
> 
>> ---
>>
>> ... or maybe this should be Odd Fixes?
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 43e7668aacb0..f1c80c9fc213 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18452,7 +18452,7 @@ F:    drivers/usb/misc/qcom_eud.c
>>   QCOM IPA DRIVER
>>   M:    Alex Elder <elder@kernel.org>
>>   L:    netdev@vger.kernel.org
>> -S:    Supported
>> +S:    Maintained
>>   F:    drivers/net/ipa/
>>   QEMU MACHINE EMULATOR AND VIRTUALIZER SUPPORT
> 


