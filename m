Return-Path: <linux-kernel+bounces-366221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284E899F25E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF79A1F220E8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 16:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569F1F6681;
	Tue, 15 Oct 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B6rtfej7"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E751E6DEE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729008661; cv=none; b=KV1b1qh+loby8AwCUjZhP9ew1GlPtpj8BS5PobTceLcFR4EkWfSidNWM7Bw98YLARwYwkLN/NlNj2tJ6VJUMXij/WaRNhkj9AuIsMlS5bgYq1R3D+XbzsqiKn/aKj7jKeMb6AMotKZTDJ/I6epw1OktuzGmfwMDkMOVzXB2QSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729008661; c=relaxed/simple;
	bh=4RbcfayKdnKH3L3jPRMwL0MZm90eH3B5hNj6Rkwgj1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGfTbFNi1V4SFzV1AdksJYlnUYDM6SxR+btShugFoAgSQvmyvmMNK3FYhrferjQXVDdGRWSBl/b86jFRpneVrvmYSI1aJEsAFx79buB0uhkqKD/PUZBerupZJagnIuAt5dUQGykAR9J3mh9Nw7nYHIUzHpITOyIRGUJ6XE0SGYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B6rtfej7; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8354c496c90so189523839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729008657; x=1729613457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UnmsgX2S26Coo2y0EAeBt15/nTOUhtLVYSc0LBXy8PU=;
        b=B6rtfej7Sj6TrWQX4nU0+X6V10tIVXB9Dx8Tim7t3xHLfm0pAFj+nqsALKHeMZJz3Y
         DXcW/N8sYsVYHAFu7d2yo5PGtuXmEYrF9eNO3NzTBFul9T4VSNl5XTf4U3hZKoz2Sc4Y
         wn8sC1VoaXT0zQXtaTEu1Vu74X4VP27geCivI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729008657; x=1729613457;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnmsgX2S26Coo2y0EAeBt15/nTOUhtLVYSc0LBXy8PU=;
        b=n80v+z67MaIMCs+Nm87O2frCXXvEOxFgP7CyHr0aECySt0Hq0+G5+agykWxRxNWuBH
         mGoA2HcGRY+2hJqBB0zyb88spL0Dxd7Hc2YeAZhozUA1giOphLHxhBCC7+bdNG/ZbvgS
         qUClL027IQkN509xcP6H7kX7u2Pt1Jr7JvZHz6sCHiL34tPkWZc5zGAyu57fWQfEScHH
         ucDAOTrKZUOglXsgbtCh4vOeS+nzZVuxAxZ8hPfQzf1hRYhAtwpRfuRpvXYJ1LFyQz01
         QsRp6vF9tG/l2F99/NpMoy5F3xNrDZg+eJhUYNOOmThtXTNMs/XpLQF4nokKK8rGXhCi
         TOoA==
X-Forwarded-Encrypted: i=1; AJvYcCUDc0FRZwgXVpxSQdJHdPkHnVL1kAhIggsSRIKMeNpRHdlryYX5qBv2qjTnge+7pqu+j+0a7i7oHB3q4SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww3hWS/MQze1K3OICsXfeDZ4NzX670AA7qxSqfppupvveqA78J
	ErEebTdn7nB8wuAuR5fErAAfpazAgKtS4l+ZBMJ0ByZi0NgfaPunK0IXq6+OUJm5svZhYX8/qV7
	n
X-Google-Smtp-Source: AGHT+IHEnL+EgYGO8lX6dxU/xMmZOk3FtuBB48kIhLw61o4UybSaO0l3EEGWCUwwVU4D9lkw4wAa1A==
X-Received: by 2002:a05:6602:1503:b0:82b:40f:63c6 with SMTP id ca18e2360f4ac-83a64d161a3mr1402302339f.4.1729008657256;
        Tue, 15 Oct 2024 09:10:57 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9b0e8esm384747173.49.2024.10.15.09.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 09:10:56 -0700 (PDT)
Message-ID: <5a90f092-6836-421c-b25c-2ef5b5233655@linuxfoundation.org>
Date: Tue, 15 Oct 2024 10:10:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2][next] Bluetooth: btintel_pcie: Remove structually
 deadcode
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, marcel@holtmann.org,
 luiz.dentz@gmail.com, kernel-janitors@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241015045843.20134-1-everestkc@everestkc.com.np>
 <8a4a8915-d59a-407d-9f93-f047370cca62@stanley.mountain>
 <43eff9c9-9a23-46ac-9015-dbee35562848@linuxfoundation.org>
 <CAEO-vhFO9-htOazTzUKA_xMS8S+a5MAZpOi40GPF38m66a+89A@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAEO-vhFO9-htOazTzUKA_xMS8S+a5MAZpOi40GPF38m66a+89A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 10:08, Everest K.C. wrote:
> On Tue, Oct 15, 2024 at 10:01 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> Hi Shuah,
>> On 10/15/24 03:48, Dan Carpenter wrote:
>>> The subject has a typo.  s/structually/structurally/
>>>
>>>> The intel bluetooth module was successfully built after the change
>>>> without any errors.
>>>>
>>>
>>> Delete this sentence.  It should just be assumed that changes don't break the
>>> build.  You can put that code isn't tested under the --- cut off line, if you
>>> want to put a warning message.  But we don't need this in the permanent git log.
> 
> Should I remove the line that says the module was successfully built
> after the change,
> as Dan suggested ?

Yes - please.

> 
>>>
>>>> This issue was reported by Coverity Scan.
>>>> https://scan7.scan.coverity.com/#/project-view/51525/11354?selectedIssue=1600709
>>
>> Restating what I said in your other coverity patch, include
>> the coverity warning. This link requires login and no use
>> for people who don't have coverity account.
> 
> The coverity scan dashboard no longer has the issue. So,I don't have
> access to the coverity
> warning.

Remove this from the log in that case.

> 
>> In the future don't include link that require login in the
>> commit logs.
> Got it.
>>>>
>>>> Fixes: 5ea625845b0f ("Bluetooth: btintel_pcie: Add handshake between driver and firmware")
>>>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>>>> ---
>>>     ^^^
>>> Cut off line.
>>>
>>> regards,
>>> dan carpenter
>>>
>>

thanks,
-- Shuah


