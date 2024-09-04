Return-Path: <linux-kernel+bounces-315313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC096C0F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7E51F256BB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492B855898;
	Wed,  4 Sep 2024 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2dOE8ISe"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873129402
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460887; cv=none; b=TXwewp2X4GnRj7djoRk1m8cMY99XS+qQMyw08/+iPhL46AZMcx6/yENxqBAuMg+e3W2WNb51wnjCO+YPEYqr9Wot66yekfz40+h4+301uKamzXO9CFK/giy7DulGHOlVote1nBcIP2ydQdnWEE5X0bgWdqnHl6NKH+d/8z4AYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460887; c=relaxed/simple;
	bh=QsoiBIlY5fZHSFFseob58kSJCOBoA+xfc/JewguzvSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njgk68XiDsjYG2dBtSyfJh0dkrKdA9fAWvt7eyZI95BFp3aY5VMcIyZKhmqr7qnfqbnisFZ69D8gNhHEND315tizBeHtEPY1EHl3Xoi1uygJiRHKo5ImfuzfrdZCg2YU8oKhI2YURgBdDQS45Tid1ZmMmjBUxcWTa1MGFeCSsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2dOE8ISe; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82a763b2752so42263139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725460885; x=1726065685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RXQdPNjznThS55SoKBxE1jPBvpgimicFhtjQoqRbVPA=;
        b=2dOE8ISeZxpatO5pDhLVqfvmwc89u7O1rQ8B10P39K0hvA/rwSMrkNn6ndLQuN/GBZ
         Tp5rXevgi1p1rnzbFpRmJW/d1jjz1UvnVxWMu+0ms+zlpp+4o/Q4xM/EWfOOisV5A2yP
         YPsHApB0OU3zdwZLWWDFOnHjDY4cbzuPuhEdEy8UUmFzaINVz19ARijOt7BlitG4eG4w
         dTTf+Vf8yqB+Y1BmjzAip4GPs5KlwpwBFGWItu1glieueDZnq7gncQBjsle3qGtpH8MP
         ZAuPjCZUQVhQj0WlCYX9q5We/6I8HP4wVBbAv7K6Pg/p68nUGM0ERi8yI16mVzafjrSt
         0Iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725460885; x=1726065685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RXQdPNjznThS55SoKBxE1jPBvpgimicFhtjQoqRbVPA=;
        b=sowVwAwytJzyVBkE2f8NRTKLKtT4sPTiyM4DHKcbb/cKAULgqhNuJMedWJcmKdfE7v
         z2tL+ybe5JvnVgiI58AY6pe7wd/oM2KTfiRRxJldnMF+uMKEnI9iRMi09aTzOKwJs3jY
         AvPin3JZilnHyPxWPAEAo4Md5hroxtRTJfGHz2trhAUY/QzNVazcjcfIUoR4yFeEA7Ml
         Gaejn5cmS29PYZMTptspwLg0sfTT+dfIJE36QMgwUm+qAyBUtwWjQXRXFwO4+A16V1gJ
         tFuGomuG65UwsynNMPiFK1OMM4bi9KTBQVGIXhYpTL7EIr1tfO8UK7A8ucP7QAS7Dcfq
         3U+A==
X-Gm-Message-State: AOJu0Yx4opbdM2DCoVme9QVvA5kCsc0WS3d7+mju/DsE5kg5McxVj9rJ
	EdQIBva4DH/YlqHOwiMMAMLr3jPO8wh5ITZH1zeQ5WLCnGRoJaclBXI2YzX69LE=
X-Google-Smtp-Source: AGHT+IFtNNepWqxfhG4gj6mW2WuRrLr+vFs64hmX/njL/jgwaCmTHHnVZUtzGz4EpgZ4MiTestMQQQ==
X-Received: by 2002:a05:6e02:1fe6:b0:39d:3043:1f2f with SMTP id e9e14a558f8ab-39f4f697b3bmr175887095ab.14.1725460884735;
        Wed, 04 Sep 2024 07:41:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de7b11sm3078950173.70.2024.09.04.07.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 07:41:24 -0700 (PDT)
Message-ID: <30eeae06-0d8a-4968-ba57-d723162a0782@kernel.dk>
Date: Wed, 4 Sep 2024 08:41:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, rafael@kernel.org,
 daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240904142841.GL4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240904142841.GL4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 8:28 AM, Peter Zijlstra wrote:
> On Mon, Aug 19, 2024 at 09:39:45AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> This is v6 of the patchset where the current in_iowait state is split
>> into two parts:
>>
>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>    in terms of sleep and wakeup latencies.
>> 2) The above, and also accounted as such in the iowait stats.
>>
>> The current ->in_iowait covers both, this series splits it into two types
>> of state so that each can be controlled seperately.
> 
> Yeah, but *WHY* !?!? I have some vague memories from last time around,
> but patches should really keep this information.

To decouple the frequency boost on short waits from the accounting side,
as lots of tooling equates iowait time with busy time and reports it as
such. Yeah that's garbage and a reporting issue, but decades of
education hasn't really improved on that. We should've dumped iowait
once we moved away from 1-2 processor system or had preemptible kernels,
but alas we did not and here we are in 2024.

>> Patches 1..3 are prep patches, changing the type of
>> task_struct->nr_iowait and adding helpers to manipulate the iowait counts.
>>
>> Patch 4 does the actual splitting.
>>
>> This has been sitting for a while, would be nice to get this queued up
>> for 6.12. Comments welcome!
> 
> Ufff, and all this because menu-governor does something insane :-(
> 
> Rafael, why can't we simply remove this from menu? All the nr_iowait*()
> users are basically broken and I would much rather fix broken rather
> than work around broken like this.
> 
> That is, from where I'm sitting this all makes the io-wait situation far
> worse instead of better.

IMHO what we need is a way to propagate expected wait times for a
sleeper. Right now iowait serves this purpose in a very crude way, in
that it doesn't really tell you the expected wait, just that it's a
short one.

If we simply remove iowait frequency boosting, then we'll have big
regressions particularly for low/sync storage IO.

-- 
Jens Axboe


