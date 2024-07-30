Return-Path: <linux-kernel+bounces-268054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E4941FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DC12860F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83391AA3E5;
	Tue, 30 Jul 2024 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="w/qJ8cQO"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120241AA3E3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364549; cv=none; b=JWZXAcXFmuR0V5EJIilAVJdblLH6hq1MPjoKbR4KF3PzwG5vu6igFc9rZvU+khHxXNNaWeFA7MtmDTkPzYtn2eTdYmlS9gnLVVXadYqlxMuyLwCA580w8HZhIevkzc9749zMmroTbPjghQ0SmPD3pQZPsMKBdMyJJmGRsYsLIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364549; c=relaxed/simple;
	bh=hh/cBleZJOsWUH8vzsoB/PRC8XpcVu/stVwnQDE+4EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ih0b8ThPq6xeEdu9Pmp0X17aVX8ImR6kX0iDjT9DMapcgCA/A2WI0cAK/SOzVwsvC3Sbtr9OE7yiLtIP/cv8WAF51rbFK0w+cyQ6x6q3CIsxFkQrlnBv0K+PCX1KQHFpS2IbBYRGVbxu6Ua9HeBN9G+qhwydq5sdKPoDxQxYulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=w/qJ8cQO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb7344ed8cso902344a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722364545; x=1722969345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kLY8aLuTpH0ccT5fj2RNXznkisReQvF9sCnpTZVCea8=;
        b=w/qJ8cQOxWINlZ1lgrXskQIMdCZHv4PZbbwI3NJpn//lnCH1NWqpGMt7SQk3s0fKNo
         K/v4nw2y5McPQvJWlolxEa7g7dcVPyKniw3imgZ2n9GqP4tu07WRAsMcrf1M/7VivHKS
         OV1DTnchfm3b7yYUHJVDKqu2UuNcNjatoG3Derg2rmgeSBlGSFQIIUDcX2iEXowAymiZ
         fib6sigAYySeOP8fXpuqa3wUFcV9qZL1/q9bTlKvEhwUW8W9gurMtQBE9UrM2T0HQuX+
         Zf0SbqjrlJCHaBtKRe8nz7xYnM9PuW1Wlvde61sMwAX8H0O50oyD7NbFhn+EtDZk6BFc
         s/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364545; x=1722969345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLY8aLuTpH0ccT5fj2RNXznkisReQvF9sCnpTZVCea8=;
        b=czwKYe2Wmh2aeEeGd/FG26w85W1fjbCtcVfDitfht6Kr4lYHncMwA79Vc9V5L0kulq
         Ll83jT6yIFsNCmL/2Tn87Z09l6iypBvgbwdxdKLzQ2A6H1AvIJfre8bpt/Pt6rgFZP7k
         HurFVNFUgZj8r8kxcozr68dOp/iNw/cIoeLtRZkWQPSqLSCglYUaKPxDu8xQIX8TyaCa
         +eP7KRbWvTltRHY7a/LpRBsf4ce1LqZEC25b09vtEOKn1WFLMdVC0aB68W+wJ/bfhycN
         OZUY4xTPC/seSoonNND/lDcdEKW6fGC1AI1qd+t9O9Sq66CG3j1J/Dq8MbAdYiqE8mns
         9XLw==
X-Gm-Message-State: AOJu0YxSImpd7dQbDoLKCh9ih0fFifrVGG0tIDLB79Ie7jeBo3n3Brjz
	xNsweU60iXdcbf39sc/pWrcAyvow8DI9XF2vBVFzHNPAIzOFzEj+tKo9v7Ewu8L/cWSKz/9nV38
	h
X-Google-Smtp-Source: AGHT+IHGbsy7CCshx9DBoyrEoVbMr0gi/Oz+mnvFb7zVuzl7oXbn0RNQYodkfnhq5e9J+zKwaks9lw==
X-Received: by 2002:a17:90a:fd97:b0:2c9:863c:604 with SMTP id 98e67ed59e1d1-2cf2632a0a7mr13112500a91.3.1722364544857;
        Tue, 30 Jul 2024 11:35:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cf28ca1058sm11003830a91.31.2024.07.30.11.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:35:44 -0700 (PDT)
Message-ID: <3f65bfad-bd04-4651-bbe3-e2b1925f1a13@kernel.dk>
Date: Tue, 30 Jul 2024 12:35:43 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <63e7adbf-0eb8-4d59-ae7a-689b9d9f69b4@kernel.dk>
 <5963cdad-40be-4278-a84e-2a804334e77c@roeck-us.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5963cdad-40be-4278-a84e-2a804334e77c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/30/24 12:22 PM, Guenter Roeck wrote:
> On 7/30/24 10:20, Jens Axboe wrote:
>> On 7/30/24 11:04 AM, Guenter Roeck wrote:
>>> On Mon, Jul 29, 2024 at 08:29:20AM -0700, Guenter Roeck wrote:
>>>> On Sun, Jul 28, 2024 at 02:40:01PM -0700, Linus Torvalds wrote:
>>>>> The merge window felt pretty normal, and the stats all look pretty
>>>>> normal too. I was expecting things to be quieter because of summer
>>>>> vacations, but that (still) doesn't actually seem to have been the
>>>>> case.
>>>>>
>>>>> There's 12k+ regular commits (and another 850 merge commits), so as
>>>>> always the summary of this all is just my merge log. The diffstats are
>>>>> also (once again) dominated by some big hardware descriptions (another
>>>>> AMD GPU register dump accounts for ~45% of the lines in the diff, and
>>>>> some more perf event JSON descriptor files account for another 5%).
>>>>>
>>>>> But if you ignore those HW dumps, the diff too looks perfectly
>>>>> regular: drivers account for a bit over half (even when not counting
>>>>> the AMD register description noise). The rest is roughly one third
>>>>> architecture updates (lots of it is dts files, so I guess I could have
>>>>> lumped that in with "more hw descriptor tables"), one third tooling
>>>>> and documentation, and one third "core kernel" (filesystems,
>>>>> networking, VM and kernel). Very roughly.
>>>>>
>>>>> If you want more details, you should get the git tree, and then narrow
>>>>> things down based on interests.
>>>>>
>>>>
>>>> Build results:
>>>>     total: 158 pass: 139 fail: 19
>>>> Failed builds:
>>> ...
>>>>     i386:q35:pentium3:defconfig:pae:nosmp:net=ne2k_pci:initrd
>>>
>>> This failure bisects to commit 0256994887d7 ("Merge tag
>>> 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux"). I have no
>>> idea why that would be the case, but it is easy to reproduce. Maybe it is
>>> coincidental. Either case, copying Jens in case he has an idea.
>>
>> I can take a look, but please post some details on what is actually
>> being run here so I can attempt to reproduce it. I looked at your
>> initial email too, and there's a link in there to:
>>
>> https://kerneltests.org/builders
>>
>> but I'm still not sure what's being run.
>>
> 
> Please see http://server.roeck-us.net/qemu/x86-nosmp/

Works fine for me on current master, boots and run self tests and
then shuts down. Tried it 5 times now.

axboe@r7625 ~/g/linux-vm (master)> qemu-system-i386 --version
QEMU emulator version 8.2.4 (Debian 1:8.2.4+ds-1)
Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers

Then tried 6.11-rc1 10 times in a loop, and also didn't see any failures.

I then switched to using gcc-11 as that seems to be what you are using,
and them it does indeed bomb during boot. Funky. I'll check the post
branch and see if it's anything from there.

-- 
Jens Axboe



