Return-Path: <linux-kernel+bounces-319413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C3E96FC49
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 611A31C23272
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC81D4611;
	Fri,  6 Sep 2024 19:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D/arF1Ov"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53E514B956
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651651; cv=none; b=admGqd1SZ/iA1yLeS3ixygPj9Lk35SuNxNRsOVegl8Mo1DvhdLEX4knqwEyLyrbT/Q3s0Xh78df2STv+S2Dz+1pzKnd40quFCo0U823OW0s9r/LP5PqwT+v17gfSmM82iYa5o/Vt1qzQ2houmXVbqLQcCNqYYlpHyh8VYnpcgh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651651; c=relaxed/simple;
	bh=jhViSLXMJzrHPVOesOXvpd9HoIZaRS2+UFztELHhZaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez89u+L7ZUrO7TxxzNryj1fn49sN5nNKaDsYeJ+K32efMI38Vv808D7GNW1Vvjn4gRAY1lDFNeseErHCO9qJb1HpwgaGWzFtk8KRbMYkyPzwR0xifo3x4w7wq3jdHc9Le6LAkmyja0Kv9uUhE8Dw8fpcx+Xgc4WhTUPE4d3k01M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D/arF1Ov; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d885019558so1852647a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725651648; x=1726256448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrEsjy45YRnX+PymgGFi2pgFxGDhRIIg2mDvIP2KwAo=;
        b=D/arF1OvqMMuV6JbYzw9tFmCNULMRXnqj7tEfmuWraNk/BnQpeqZ/OUCOdfnrqD9SZ
         Pm55jPAs/X9VAGxZsHEbKN7KQLAzOd93cX3hvSMSn1mIVfKubcXvYOJe9aT7g8gVLNJu
         Gu+1r/twQmR52om2Ic9lf/cvUf9Lk7c2XsqN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651648; x=1726256448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrEsjy45YRnX+PymgGFi2pgFxGDhRIIg2mDvIP2KwAo=;
        b=wXMIKBSolBTJw5CSH8NoIGhtdRJy7VyVY6MpkSNlyfkwOaqnC+ZST1TxT10SZn7r45
         Kba8qE5p6zjAl7dxN02x80UOSM1ZX2zTOknrqpF75Y7bUO2gTDts03lHnA+xjlsmzdA1
         fdRqW72fZH0UAY08enOZ5ixNv7MsBmcSU0D1q1JPVXYiYhEN+bU3k1lw3Mvahy5R7IXs
         KfW564TW7vGf2e93kXrsqnTl29q224Y2rn/d/KnmVX1EdKvd/ppbl9v38lG0apzy+jwD
         uJaWZOFrGz2Y4M8hrcJGpovNDOkOTkCJiV+wtmRgEgvIOsDvQw1NObvoKs5ewM8k7QJ0
         lz5A==
X-Forwarded-Encrypted: i=1; AJvYcCWjC+Iv/+l1LMMynjx3HrdtWr7yoLcl7pGUIA2PxteljuGezckf9af2Zv2H0YusG5QaTgk66AHXcov4X38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYptI1b5JaHQ9YEps7cu3lCDUnDDJYSWNm4/P0Bw1lwxV+yem
	2hrOHay+lmd2XVUxaAbndFETHjeXYRXhSYdSIpK07nrSMpZcE/YmAy/VO5ItJYw=
X-Google-Smtp-Source: AGHT+IHsEpJceWyiBJkzlj6FZMYa/abknsI9SBsUlsfx0t8W8s3I0dKVunW6uE926QUodgwTTe1XGQ==
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id 98e67ed59e1d1-2dad517f7afmr4069198a91.29.1725651647783;
        Fri, 06 Sep 2024 12:40:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0843a9sm1995011a91.42.2024.09.06.12.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 12:40:47 -0700 (PDT)
Message-ID: <b84546c4-374a-457f-94ee-509db6fd0044@linuxfoundation.org>
Date: Fri, 6 Sep 2024 13:40:46 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/timers: Remove unused NSEC_PER_SEC macro
To: John Stultz <jstultz@google.com>
Cc: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, anna-maria@linutronix.de,
 frederic@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, tglx@linutronix.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240906025259.3822-1-zhangjiao2@cmss.chinamobile.com>
 <49d07daa-622f-4c04-9d00-221f8abfb4f3@linuxfoundation.org>
 <CANDhNCqZitCt2ffrbEKKJtuVJPNAw8y_BdoZ3iu_5BhH1j2b+g@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CANDhNCqZitCt2ffrbEKKJtuVJPNAw8y_BdoZ3iu_5BhH1j2b+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/24 11:02, John Stultz wrote:
> On Fri, Sep 6, 2024 at 7:29 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>> On 9/5/24 20:52, zhangjiao2 wrote:
>>> diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
>>> index c8e6bffe4e0a..83450145fe65 100644
>>> --- a/tools/testing/selftests/timers/skew_consistency.c
>>> +++ b/tools/testing/selftests/timers/skew_consistency.c
>>> @@ -36,8 +36,6 @@
>>>    #include <sys/wait.h>
>>>    #include "../kselftest.h"
>>>
>>> -#define NSEC_PER_SEC 1000000000LL
>>> -
>>>    int main(int argc, char **argv)
>>>    {
>>>        struct timex tx;
>>
>> This looks good to me.
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> John, I can pick this up with if you are okay with this change.
> 
> No objection from me, if you're ok with the commit.
> Acked-by: John Stultz <jstultz@google.com>
> 
> thanks
> -john


Thank you. Applied linux-kselftest next for Linux 6.12-rc1.

thanks,
-- Shuah

