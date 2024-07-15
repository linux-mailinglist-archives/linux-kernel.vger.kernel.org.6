Return-Path: <linux-kernel+bounces-252764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603E9317DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00152283B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0003DF5B;
	Mon, 15 Jul 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eiHrgqHk"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C60BA4D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721058616; cv=none; b=mnEvHe5gEtcv7sO/2n7K2XrzlBg0oRRD6bLCLHVGRWQIRJQdVMMBu8cGqPPeyauS2R2blAnQJfSPHgxXzX8cQoRhD1LVwig20RpK6x313ivcsIRqYED34/PJJhqbTSbqyoghx/iPw7Wt5XTgNI5pdg0RsX0n9uUi5P9MgQXRPe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721058616; c=relaxed/simple;
	bh=D+WM+Q2pslyNhAZlHLHHJb3Kl8DybRlsl8NJ4ZQOPaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UyYIdKw9adiSxSpJy7ytJwkjWZ5lleWp//dY8EGXFzvVMmGnVJG2hxXZACbdQY7TyaxtffKtcN5dezVkk5KRc2lm5GVPkpAnmGPsZUyYLOoBZESf/mfENrREVrlDQn0aM5Q6nDH5BDoxy/q0to9sQK5dQelB99n+Mz1PJH17ALU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eiHrgqHk; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-375f6841f01so2104665ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721058614; x=1721663414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0nad82qrN1uDDEOfj5+pku7SPG9T4YbXiguvPskHZI=;
        b=eiHrgqHk4SeJnMo4gIXeuekjgD9DnLDOQC6XiE0URrYfus8ieVusZYY3u6ZfraWKYU
         4T9pAzI3o+Pn61xPC6ncMj2c5JvbIK6w3t/9/Emu6No2vgknnM1RpgIOvfs/WGEfIEBX
         8Qof7gK3AvXKuSn+bNCDdWFvE0zyx28TheWFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721058614; x=1721663414;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0nad82qrN1uDDEOfj5+pku7SPG9T4YbXiguvPskHZI=;
        b=ZV8lN0X4wnvrzsaQTFRuopDVyC9rIYho/k8JarYWL2M9bODC0YAfMrIVkYIXGNp0ie
         30X0b04TlmrbXngNppEGsM6MKSSsD0SmSUs9NzhZxolmYfoHId7sh/fALvCdTkPAVzTm
         WTKBnWQpsN8UJJS7aExr3lQyioFwcy+d3FxGgFnk0fsclW6BouY63w9HjmpAiS3HV+F1
         P3GQuYALy1wr9I055Pgj1h1Kqx5dPZi6RtT1TV46ECAzSBsD1MgO5ANOmQQXj9y9e0Pz
         A5N6L9mMo5hZJD3k6t7C10dxoaorvmOfv+fKSw22eWRHcGY0E+Y8R+POj4VgVuccsap+
         P/UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV//59J7bWBDl5cXgSGw3HguLGhB3/8nOaAxzxIVYkE7t+yD+3k2qirUAEwi/ZOAbVchvv9oIIO8KxHzrSihSPanDlxEvT3zAW5kRuV
X-Gm-Message-State: AOJu0YyHASRfZj9YNPUC9D2l25GFKilhz6m/y8mRjvqGAigG/yg/5m9+
	z1RZZQTdxq88hxJIa6im95rifrUoUWxmKOotfTwSTa2dJrPuoH6/Rpnm9RUe/CiRCik2Bq6eU5U
	t
X-Google-Smtp-Source: AGHT+IE8y9fEAKQk4PXP47LGeWaQE3wKutcs9bw3I1NKfhhWAjDib0QSph6K7btIEPgaaDI+GoiNiA==
X-Received: by 2002:a5d:9905:0:b0:7f9:3fd9:cbd with SMTP id ca18e2360f4ac-81541b0f8a9mr10482239f.0.1721058613916;
        Mon, 15 Jul 2024 08:50:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c1e1c2fa36sm1247434173.150.2024.07.15.08.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 08:50:13 -0700 (PDT)
Message-ID: <5cccbde4-b296-4759-9ae4-bf1b65f24c5b@linuxfoundation.org>
Date: Mon, 15 Jul 2024 09:50:12 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nolibc for 6.11-rc1
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <acffd5b1-36a8-4336-9b94-aec50b3d6e5b@t-8ch.de>
 <1678fb84-40f6-4656-ae4e-e31bf5b0ecd9@paulmck-laptop>
 <231d9568-37e1-4df2-bd06-ea35303450c6@paulmck-laptop>
 <ee43b1d5-3339-4a1c-9bac-c0d48f22167c@t-8ch.de>
 <138b249a-8402-4a79-8c08-45bb9d888dc5@paulmck-laptop>
 <fdf4c2b8-dab7-40f0-a595-fd4f2108964e@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fdf4c2b8-dab7-40f0-a595-fd4f2108964e@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/15/24 01:00, Thomas Weißschuh wrote:
> On 2024-07-14 09:44:55+0000, Paul E. McKenney wrote:
>> On Sun, Jul 14, 2024 at 10:09:13AM +0200, Thomas Weißschuh wrote:
>>> On 2024-07-12 20:16:13+0000, Paul E. McKenney wrote:
>>>> On Sun, Jun 30, 2024 at 09:06:39AM -0700, Paul E. McKenney wrote:
>>>>> On Sat, Jun 29, 2024 at 01:04:08PM +0200, Thomas Weißschuh wrote:
>>>>>> Hi Paul,
>>>>>>
>>>>>> The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:
>>>>>>
>>>>>>    Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git tags/nolibc-20240629-for-6.11-1
>>>>>>
>>>>>> for you to fetch changes up to 6ca8f2e20bd1ced8a7cd12b3ae4b1ceca85cfc2b:
>>>>>>
>>>>>>    selftests: kselftest: also use strerror() on nolibc (2024-06-29 09:44:58 +0200)
>>>>>
>>>>> Hearing no objections, I have pulled this in so that it will appear
>>>>> in the next -next.  Here are the test results:
>>>>>
>>>>> make run:
>>>>> 195 test(s): 195 passed,   0 skipped,   0 failed => status: success
>>>>>
>>>>> make run-user:
>>>>> 195 test(s): 193 passed,   2 skipped,   0 failed => status: warning
>>>>>
>>>>> So looks good to me!
>>>
>>> For testing you can use "./run-tests.sh -m [user | system]" to run the
>>> tests on all supported architectures via QEMU.
>>>
>>> (On the first run you can use "-p" to download the toolchains)
>>
>> Thank you for the info!
>>
>> My near-term plan is that I do a smoke test on x86 (or whatever I am
>> running), and let you guys cover the various architectures.  Longer
>> term, I might get more into cross-architecture work.
> 

Thank for fielding this time. Next one in on me.

> I'll try to remember to add the full testreport for future
> pullrequests, too.
> 

Thanks - that will be great.

I run the nolibc tests before I send PR - I also compare to see if my
results match with yours.

thanks,
-- Shuah




