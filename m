Return-Path: <linux-kernel+bounces-268081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC029942021
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA4D1C20CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C118C90C;
	Tue, 30 Jul 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="F5vmT3s3"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE5C1AA3F6
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722365704; cv=none; b=ZKdIM78SobXC1dOr95tKEXVEmaonMd+pW6Fg/cak5p9rfIw/JnGxtvTRni7uJlWEFjGq6uOAhFmhokAgC8PPNJB66eZPEc37TAULSS/pWo2URBO9yS8pHXQ5OV+SnT9HI+TrOWBdvIamWSJAk5V1DwvFZM6B0GPsSnQ1lSlVCXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722365704; c=relaxed/simple;
	bh=D6XK+MkXe4vSuFdneTto5My6pUrb1NhewSPXD7ICrLk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KHb3lovfcllDSqDESgqoZ5RHNEakKu5o/V0IzNpJ3vJGSSYP4uZUvRiZ0bhZeF0h/91q8IVmH/QaGGii5KyMvi1+D+2MMYXDoTdDxBisoPYAy/HHJ3CAdngUU3BKBGOYB+VA0VwXix/WSQ+5w3DH8gVc701mJVVUkAnShmH9h50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=F5vmT3s3; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc4b03fca0so2934315ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 11:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1722365700; x=1722970500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UWZrz0GTTBtVx+qj8RLYBvZn4vPsV/d3sE0GhBIu0gA=;
        b=F5vmT3s3x6choYQ/vh1/WuUgLbzNapaZuSKWlS9BNT8g12x4n/AQLcKOFmOs+dpQFh
         U+LkZRDjd6x0gqTu1QToML5jt7zVUEZ0ZO5McwmyutO++r2iWy/pOJDoMvX5vI/worFO
         2j83nsj8PmCo8lzqF+L5uP0d91H2WuvLZLssp/9OZfFKljNH+ScsDAMs+q2/1gIENVYN
         ZkU1QeEDSi5eU1GrNfPTqk/s0YnduuQoBY3kycwotZhGMZvyIroLcHZK7GXuwfXAwcLE
         5beQjOG9gwvfmPThq1dfkcYcrdgVv9Jt1OvhXXUM5LqrD7Ng+AyES0+M84RLm4cPaW1l
         H7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722365700; x=1722970500;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWZrz0GTTBtVx+qj8RLYBvZn4vPsV/d3sE0GhBIu0gA=;
        b=fMf3fw2ytiHCvsRN0uJ4l0TuvupWejNykkb3DwfG8X1kwBUuqr+8w87m14t0WDDsze
         ort1wgaEf0ox54GTjVAkkr7YXofRXsjUbiwVsWolvBUy2wRjjd6KHMxCxXamlNLLgSJ1
         KaI6cJLhiMjrEDKr8dOGkoQgvLPB8+CLTlTQVyhmbSAqbfkgAx1/OZtYAQHwJ9dA+mm7
         J3k4YK+n8o4PlR1irfOFYEClA7hLX0t2i0c3HbpioVxFfiImyRIJas+IKVDIHXkb8rqB
         WlpCkns/OyUFH3lT13eU70ZMxk/GfUWtTw3ukGxZRj3WDXuzSdAhkxBua/+2wawxgyoi
         Ik3Q==
X-Gm-Message-State: AOJu0YxpnrrgwnFDm/B91k5AJ2AGzgRmsdlzJn+VLzHqVEGF/ydNOel1
	72q+FMhyfoM7zcDJDlw+mXp+wm0xdsPzzfSpVv/vsbY4rqT7SNR2PLOQ9S3xrP8=
X-Google-Smtp-Source: AGHT+IG6BPYC2ppBcM9hDozr25lCPvFecGj3JJ/GmzwdQ7lbXbaIq/ub4rBWzKik1JYHmkIFX7PK+Q==
X-Received: by 2002:a17:902:e542:b0:1fd:d7a7:a88d with SMTP id d9443c01a7336-1fed6d24609mr123875495ad.11.1722365700362;
        Tue, 30 Jul 2024 11:55:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ee4d16sm105445805ad.146.2024.07.30.11.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 11:54:59 -0700 (PDT)
Message-ID: <d7c7bf83-245a-4426-8ba1-f1841a28568c@kernel.dk>
Date: Tue, 30 Jul 2024 12:54:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.11-rc1
From: Jens Axboe <axboe@kernel.dk>
To: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <63e7adbf-0eb8-4d59-ae7a-689b9d9f69b4@kernel.dk>
 <5963cdad-40be-4278-a84e-2a804334e77c@roeck-us.net>
 <3f65bfad-bd04-4651-bbe3-e2b1925f1a13@kernel.dk>
Content-Language: en-US
In-Reply-To: <3f65bfad-bd04-4651-bbe3-e2b1925f1a13@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/30/24 12:35 PM, Jens Axboe wrote:
> On 7/30/24 12:22 PM, Guenter Roeck wrote:
>> On 7/30/24 10:20, Jens Axboe wrote:
>>> On 7/30/24 11:04 AM, Guenter Roeck wrote:
>>>> On Mon, Jul 29, 2024 at 08:29:20AM -0700, Guenter Roeck wrote:
>>>>> On Sun, Jul 28, 2024 at 02:40:01PM -0700, Linus Torvalds wrote:
>>>>>> The merge window felt pretty normal, and the stats all look pretty
>>>>>> normal too. I was expecting things to be quieter because of summer
>>>>>> vacations, but that (still) doesn't actually seem to have been the
>>>>>> case.
>>>>>>
>>>>>> There's 12k+ regular commits (and another 850 merge commits), so as
>>>>>> always the summary of this all is just my merge log. The diffstats are
>>>>>> also (once again) dominated by some big hardware descriptions (another
>>>>>> AMD GPU register dump accounts for ~45% of the lines in the diff, and
>>>>>> some more perf event JSON descriptor files account for another 5%).
>>>>>>
>>>>>> But if you ignore those HW dumps, the diff too looks perfectly
>>>>>> regular: drivers account for a bit over half (even when not counting
>>>>>> the AMD register description noise). The rest is roughly one third
>>>>>> architecture updates (lots of it is dts files, so I guess I could have
>>>>>> lumped that in with "more hw descriptor tables"), one third tooling
>>>>>> and documentation, and one third "core kernel" (filesystems,
>>>>>> networking, VM and kernel). Very roughly.
>>>>>>
>>>>>> If you want more details, you should get the git tree, and then narrow
>>>>>> things down based on interests.
>>>>>>
>>>>>
>>>>> Build results:
>>>>>     total: 158 pass: 139 fail: 19
>>>>> Failed builds:
>>>> ...
>>>>>     i386:q35:pentium3:defconfig:pae:nosmp:net=ne2k_pci:initrd
>>>>
>>>> This failure bisects to commit 0256994887d7 ("Merge tag
>>>> 'for-6.11/block-post-20240722' of git://git.kernel.dk/linux"). I have no
>>>> idea why that would be the case, but it is easy to reproduce. Maybe it is
>>>> coincidental. Either case, copying Jens in case he has an idea.
>>>
>>> I can take a look, but please post some details on what is actually
>>> being run here so I can attempt to reproduce it. I looked at your
>>> initial email too, and there's a link in there to:
>>>
>>> https://kerneltests.org/builders
>>>
>>> but I'm still not sure what's being run.
>>>
>>
>> Please see http://server.roeck-us.net/qemu/x86-nosmp/
> 
> Works fine for me on current master, boots and run self tests and
> then shuts down. Tried it 5 times now.
> 
> axboe@r7625 ~/g/linux-vm (master)> qemu-system-i386 --version
> QEMU emulator version 8.2.4 (Debian 1:8.2.4+ds-1)
> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> 
> Then tried 6.11-rc1 10 times in a loop, and also didn't see any failures.
> 
> I then switched to using gcc-11 as that seems to be what you are using,
> and them it does indeed bomb during boot. Funky. I'll check the post
> branch and see if it's anything from there.

I can fully revert that for-6.11/block-post merge and it still crashes
in the same way for me. So don't believe that's the culprit. It
consistently crashes with a double fault when starting cryptomgr, so
that may be a clue.

FWIW, if I disable KFENCE, then it boots just fine with gcc-11. Or if I
use gcc 13 or 14 it works just fine regardless of whether KFENCE is set
or not.

-- 
Jens Axboe


