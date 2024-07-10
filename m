Return-Path: <linux-kernel+bounces-247905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C6C92D626
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24346B27CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0A194A77;
	Wed, 10 Jul 2024 16:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hu6QIg/U"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBEB1922FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628315; cv=none; b=hsyWEXWHRvuHokIV02Fs6q4+WRkIPv9OVxP4wsBRsAXJNO3wRJq6Bf5XFml99oi23zmkNODxlwHz4Ea78A+1s/wMQq08/ssG3V87N9IJgg4vNzrNyLvPzEbsgAqZy/S15PUeMcTCxp3fGdwPQZ3+jm56NyNtXICVnXX2b+CKurw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628315; c=relaxed/simple;
	bh=BhiEz3XFYdvcAqXpz81szUnwQYJeZRV0ML/HN1ZAXHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTigEVihA5dCfYEmkYGSDs0b6vNhRUPGZKV9A0/T94Njm1lT4C06XNXQFWOZ0NQu49Xy365GT0EDcdtQVOJeTG3l+8N0gjXcbyv1XMGVZ2WXdq+MulOHLL1BcR6uIDc280UuHSCvB5ciccXHzwNdRSHtOYYEzEAN//P59cL2NVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hu6QIg/U; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-389cb8f18beso1873295ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720628312; x=1721233112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHljrcvv9xSR6a4aB4WFPaWjB6HUnBki1i7whrGubyc=;
        b=hu6QIg/UnqjOfZ6SBbnyk3sKHteFjhN8Mq4k7ndimv70mPgHTtfiABY62Bd5noGrZl
         2bPOOH6dX7lATJn4RqfF+ZPPgWO7u5OzzTPTThKob/rHlFZUnvCVMIFBKMOJTolgRZF+
         LkZZHHUebfhAxxG6gAI2kcBYJ8oPmNetCaN0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720628312; x=1721233112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iHljrcvv9xSR6a4aB4WFPaWjB6HUnBki1i7whrGubyc=;
        b=ZQDvnRu4lE1GzIg98nrr5RU9Vjj9Vr0plPhFvMwtmOpsoN08WRIz6E7Bv/yBJ+esai
         H+vhFL9I1fax02uDFe/FIcj0S5cmHpJch7ZjrzoUU2aYe3a/NjHcvibTuzB/maRSylv5
         AdHOVJHw4l316X2CEK769OXphcY517/OpVLVLwalhGwSKlOfwi0AY8rJkUlX54SMhcN9
         p/GUxV1tRN3Mz8Jbb7pJQfeJcWqb5giC+p+ROc/Izqda31SHPB8yz9M0xVCT1F4jM93/
         VpeAUNGkWVYsZlaKOLM11eTktM7omXR4BEr0sHiWktFdpOY1gpetSB0T8bI45ajj9Wo6
         UL7A==
X-Forwarded-Encrypted: i=1; AJvYcCUmrvaFvqVIfToEKzughUSkYPdci1UdLqGvH+Vx5JG9K3QA2oSTei9y+rh8TVX3CtFwE+S30ecX/Nn+i2fpeOxWnI7c6LiRzdoXEcYL
X-Gm-Message-State: AOJu0YyMv0sTOgQRlxVr9LatV6dB00geVrE06BLJUeiVlEMbrSTcURJX
	UgurgdGkXQ33QSWgvx5B2TIMcEUo9IOmbX4YdcvQQobGLWa94l8LTQfEgg27CuU=
X-Google-Smtp-Source: AGHT+IHKIgwOJ6lvY3g0u6pV5cXN6BCyOe9NGCIkSlkJ1vMuQ+Me50O5EtJflkRnIAhB21NE8sOl5g==
X-Received: by 2002:a92:d5cc:0:b0:375:a4f9:e701 with SMTP id e9e14a558f8ab-38a5a740bb1mr57234205ab.3.1720628312572;
        Wed, 10 Jul 2024 09:18:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4964bcdcsm10336285ab.34.2024.07.10.09.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 09:18:32 -0700 (PDT)
Message-ID: <6d82fa16-ed2e-41f1-a466-c752032b6f68@linuxfoundation.org>
Date: Wed, 10 Jul 2024 10:18:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: openat2: don't print total number of tests and
 then skip
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksa Sarai <cyphar@cyphar.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240522214647.3568788-1-usama.anjum@collabora.com>
 <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>
 <20240701.085146-junky.rubs.mossy.crews-uyuNIdHgWxb@cyphar.com>
 <148d4c61-b60a-401f-96ee-b0291bcf87b3@collabora.com>
 <c0007f80-d44b-42fa-afd4-fdaeb3b89f70@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <c0007f80-d44b-42fa-afd4-fdaeb3b89f70@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 03:33, Muhammad Usama Anjum wrote:
> Hi Shuah,
> 
> Can you take the patch as is or by removing following from this patch:
> 
> -	if (geteuid() != 0)
> +	if (geteuid())

As Aleksa mentioned, geteuid() != 0 is preferred.

> 
> On 7/2/24 12:02 PM, Muhammad Usama Anjum wrote:
>> On 7/1/24 2:14 PM, Aleksa Sarai wrote:
>>> On 2024-07-01, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>>>> Adding more people for review
>>>>
>>>> On 5/23/24 2:46 AM, Muhammad Usama Anjum wrote:
>>>>> Don't print that 88 sub-tests are going to be executed. But then skip.
>>>>> The error is printed that executed test was only 1 while 88 should have
>>>>> run:
>>>>>
>>>>> Old output:
>>>>>    TAP version 13
>>>>>    1..88
>>>>>    ok 2 # SKIP all tests require euid == 0
>>>>>    # Planned tests != run tests (88 != 1)
>>>>>    # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
>>>>>
>>>>> New and correct output:
>>>>>    TAP version 13
>>>>>    1..0 # SKIP all tests require euid == 0

I think having total number tell you how many tests are there.
I don't this this is good change.

thanks,
-- Shuah

