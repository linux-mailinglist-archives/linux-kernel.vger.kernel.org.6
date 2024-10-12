Return-Path: <linux-kernel+bounces-362637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BF199B782
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 00:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C26AB21936
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 22:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1319ABDE;
	Sat, 12 Oct 2024 22:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Kxzo/CVS"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820171494BF
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 22:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728772992; cv=none; b=XobIVahvfQ6ePunm+YG3NjCtjAefJRBY/7uC3l7RFSWUSkzFOYOS+07CkltdG313Qd1mVqpYnThBIA9F3Skg+d7rN8KEtx/z98mqa09TpmlwroVt4b9pmOg65J28HWS0ZVxqfWR74+wqlqOPdn3IDnrsXDu8r9/IZk+ZCG65arg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728772992; c=relaxed/simple;
	bh=vu81XBmL9RoFyP+iq4NTOOQ6F29O6jfKJPpLfCmtZDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Psr7JK5kdxERWs17VmNZr/VjOGi274/R+ILV0+VEq1M+t03maebqTCQ2crDkdgEReIa0OqSv6vEz25+O9rm9ihbOyJ0RqApw1/xUnBkIyLtOGgALRnsEz2Jy+uuOF0vfFp5ISRnCKbdo7IvKZ+L3BgL5awbxgS4ozJrYkvj+3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=Kxzo/CVS; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1728772981;
	bh=aMGbghwnz6f2ekOrWybL74lgFWW4ACIGttVUQsI9xVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kxzo/CVSpoifzUJwORR/gNXilmBNq7W/BZ7tPqHMpnUUhGiSiorRyeCleJMlYMgSP
	 0Bb4vQIGROoGLpI5u4AbwGi/svfTDx/fB2cPI5xC5wxCyK0afIxQ7c4BB51kaT1zQV
	 jT/rm1B/7HNDW9UD3oNoxztGqiO9OmPQ4/Zknb8prMPBhNgsr5qOUSwW6w0RbozmIk
	 cmqOmSg5wkzO2ZcO/G5HIXMQB9GWxwRSn8DseqsOEfWcke7xpQzLWbUjyxwQsGsov9
	 x+mtz+T3XalBaJBoJ+flS6Rcruz2KxhTAwyHEOAYj8GWDaMglWssrfTxrR16lGsoaQ
	 RKK0NTgMpymww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XQz6B15bkz4wb7;
	Sun, 13 Oct 2024 09:42:57 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Ankur Arora
 <ankur.a.arora@oracle.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
 paulmck@kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 7/7] powerpc: add support for PREEMPT_LAZY
In-Reply-To: <9f0dcdc6-121d-48a7-8abe-b2ce7acd0cdb@linux.ibm.com>
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-8-ankur.a.arora@oracle.com>
 <20241010072221.48wfFV7I@linutronix.de> <87jzef7rsx.fsf@oracle.com>
 <9f0dcdc6-121d-48a7-8abe-b2ce7acd0cdb@linux.ibm.com>
Date: Sun, 13 Oct 2024 09:42:56 +1100
Message-ID: <87o73p54en.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shrikanth Hegde <sshegde@linux.ibm.com> writes:
> On 10/10/24 23:40, Ankur Arora wrote:
>> 
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> 
>>> On 2024-10-09 09:54:11 [-0700], Ankur Arora wrote:
>>>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>>
>>>> Add PowerPC arch support for PREEMPT_LAZY by defining LAZY bits.
>> 
...
>>>> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
>>>> index 6ebca2996f18..ae7793dae763 100644
>>>> --- a/arch/powerpc/include/asm/thread_info.h
>>>> +++ b/arch/powerpc/include/asm/thread_info.h
>>>> @@ -117,11 +117,14 @@ void arch_setup_new_exec(void);
>>>>   #endif
>>>>   #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
>>>>   #define TIF_32BIT		20	/* 32 bit binary */
>>>> +#define TIF_NEED_RESCHED_LAZY	21	/* Lazy rescheduling */
>>>
>>> I don't see any of the bits being used in assembly anymore.
>>> If you group the _TIF_USER_WORK_MASK bits it a single 16 bit block then
>>> the compiler could issue a single andi.
>
> That's a good find. since by default powerpc uses 4 byte fixed ISA, 
> compiler would generate extra code for _TIF_USER_WORK_MASK. Looked at 
> the objdump. It indeed does.
>
> I see that value 9 isn't being used. It was last used for TIF_NOHZ which 
> is removed now. That value could be used for RESCHED_LAZY. Using that 
> value i see the code generated is similar to what we have now.
>
> +mpe

Yep, 9 looks good.

I don't think it *really* matters that it's a single andi. on modern
CPUs, but seeing as bit 9 is free we may as well use it.

cheers

