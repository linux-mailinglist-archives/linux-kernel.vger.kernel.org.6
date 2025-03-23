Return-Path: <linux-kernel+bounces-572884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD67A6CFD6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4090188C3E1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 15:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1420E6F099;
	Sun, 23 Mar 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JwLKJA8a"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DE8BF8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742742891; cv=none; b=pWTrv4EQIJD63bjLAOdzw4E80A12Q1r9OHOl5BPf54vTm9uekS0lU6a5hk86dldKWWJvdfbbPJFaeKLUdEVco5ZXlFdFKfBfWr6OSFBc9yZc1ltRYPVwrnapdmBtYaoQZeGR6ckgGlLA/zjPVrqIfTr0ZhQGaUWRWtxUdPaTC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742742891; c=relaxed/simple;
	bh=cPvB1HBjOG1aRVliKZB82wNmbxJ/w364kxn7jlVUqew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eSmuhN1pElsDqhPL4WrKTcn21GlccyLXpxXOia5tkGdvFlZh9afz7vnbnx22sPQK9NxaXMMgi0+ro2EewlbXEGE2eoS42sD85OLkNOfShyt4/quP6WdkuaXH6/QpHjW8Xj2YoKUhZKvP10hw8N6lz5+MInRp0PLVxYEdbKV3bd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JwLKJA8a; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZLKV83rfVz9sT3;
	Sun, 23 Mar 2025 16:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1742742880;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBsTzwGiRDku+XW5xJyCrZPqEaEEKsEk9cFTk493Hzo=;
	b=JwLKJA8aUEQ9pBwmlYR97zs6DigYm+VfLsRqyVo3ldiDF7iCyOpBbXvcItye1tqt+3XOLb
	G22atEJalOzmq32Q1ZQQgxxCOTM/42qtMeXK0SvyVklbysLK7K5tBWfycm1QFV8tJuDNb1
	aaFbm/jjweW6oop3Dtd34HFqNGUYkKHEH6BVlPUq3BoNOUHVLndzLSBb/FVcpvGgjXVZfK
	3DHzMMlWz0D4/PY6jIQbtU1O/REUCaXmUuQMllLl48UIn9qRqpTrxG5dNSbzY8Rnf+gcJ1
	DSkOkoWbtAg7lhPwDVgVP0G6JhlB45Qn/G0LgJjTOjHJruohcEq3QP+tCdHIrQ==
Message-ID: <b67fad41-3849-446e-8982-1485f42e61eb@mailbox.org>
Date: Sun, 23 Mar 2025 16:14:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arch/x86: Add an option to build the kernel with
 '-march=native' on x86-64
To: Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20250321142859.13889-1-torvic9@mailbox.org>
 <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
Content-Language: en-US
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9cdf7bf03641be610fe
X-MBO-RS-META: axe7cye6wtwjr5jggougx956ao7whhx1



On 3/22/25 12:40, Arnd Bergmann wrote:
> On Fri, Mar 21, 2025, at 15:28, Tor Vic wrote:
>> Add a 'native' option that allows users to build an optimized kernel for
>> their local machine (i.e. the machine which is used to build the kernel)
>> by passing '-march=native' to the CFLAGS.
>>
>> The idea comes from Linus' reply to Arnd's initial proposal in [1].
>>
>> This patch is based on Arnd's x86 cleanup series, which is now in -tip [2].
> 
> Thanks for having another look at this and for including the
> benchmarks. I ended up dropping this bit of my series because
> there were too many open questions around things like
> reproducible builds, but there is clearly a demand for having
> this included.
> 
>>        hackbench (lower is better):
>>        102.27 --> 99.50                         (-2.709 %)
>>
>>    - stress-ng, bogoops, average of 3 15-second runs:
>>        fork:
>>        111'744 --> 115'509                      (+3.397 %)
>>        bsearch:
>>        7'211 --> 7'436                          (+3.120 %)
>>        vm:
>>        1'442'256 --> 1'486'615                  (+3.076 %)
> 
> 3% in userspace benchmarks does seem significant enough to
> spend more time on seeing what exactly made the difference
> here, and possibly including it as separate options.
> 
>> +ifdef CONFIG_NATIVE_CPU
>> +        KBUILD_CFLAGS += -march=native
>> +        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
>> +else
>>           KBUILD_CFLAGS += -march=x86-64 -mtune=generic
>>           KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
>> +endif
> 
> I assume that the difference here is that -march=native on
> your machine gets turned into -march=skylake, which then turns
> on both additional instructions and a different instruction
> scheduler.
> 
> Are you able to quickly run the same tests again using
> just one of the two?
> 
> a) -march=x86-64 -mtune=skylake
> b) -march=skylake -mtune=generic
> 

I ran the tests on Zen2 (znver2), but this time the kernel was built 
with clang-20+lto (the skylake tests were with gcc-14).

It turned out that with '-march=native', there is almost no difference 
compared to '-march=x86-64'.
All results are within +0.8% and -0.6%, most of which are probably 
noise. Hackbench, stress-ng fork and xz compression seem to profit the 
most from 'native'.

The vmlinux image is 0.03% bigger with 'native'.

I guess that 'native' can be somewhat useful on some architectures, but 
not on all...

As for your question to run with both '-march' and '-mtune', I'm sorry, 
but I didn't have the time just yet.


>      Arnd


