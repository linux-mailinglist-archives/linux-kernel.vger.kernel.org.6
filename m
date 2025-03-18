Return-Path: <linux-kernel+bounces-566938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D079A67E99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347FB7AD0CC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4951F9A91;
	Tue, 18 Mar 2025 21:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b="BogtIbFx"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22C31DDC30
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 21:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742332921; cv=none; b=iU46K/oDWVGkXS0qJfiLVqpMWsRNQwTmydBnCNgVdhlWy2GiYZ0mlLLzbZeQylko5Or302YcKG4l6/KFrztp+xUCMCCgo+pUpkoCMhGCrMQU+Pn8y9okl3BFWGTo8HeI6GGnhl+wwaNrrOPexK+dcPsn0kFy0hDQrGeWp4dT2gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742332921; c=relaxed/simple;
	bh=UbriOW/G9dO2oX3E78VLJWlhyyuFgHeEcWqNyYrdOm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z0HaGYXG7R7EFdT6RCKwvnzcNZO5h94EYqjnFKjjuzhIkLnWLekEoUizuzEAcFuvRQtSm18d1EI/V7JB2y1SeCci00jpPG9ZI2sXkYqnbEZicBQowPkyFom+p28Gza/fOXEwoq0uzzWdKm3Qs8DSWy1fry7KeG4nujLYYqRqPEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com; spf=pass smtp.mailfrom=iencinas.com; dkim=pass (2048-bit key) header.d=iencinas.com header.i=@iencinas.com header.b=BogtIbFx; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iencinas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iencinas.com
Message-ID: <fd13d2e0-1ed2-4b63-ab3a-4cb650b45a2c@iencinas.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iencinas.com;
	s=key1; t=1742332916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3rVL5NtPGOGj2V0UQUWJI5zHq/89EL1iqRC9ONnsRs=;
	b=BogtIbFxY3ByXLndkvBLuYYF+rC0s7Q6G1xe/ZGMhc1132STkbDpxq7iEL6zQAgQ3t4vxz
	9u2tvxNE0sWk/4ZWLNIi1RWXFmi5u+GONQu++I1ldXrPWkt9MAeqXUHGbHVdddYNUZNBp9
	V452Ejwn9BcI3phw0/Z8yu80NeEbfm5U9agsl+csARaq9/pacXYeBnfrrLwZL3vAWbrW/v
	S0cR9PpOXIGGGo+EM1BoSn3BK12Mi90QPmBBZe35gHx7yyaOpqAIjziZRkHq681LfBiqhE
	iO0XIC89Jk3VkX7P4ONo8nlW4oBVHUUUbzjORucaXsDQBJjsmIilGR+6rQuq3A==
Date: Tue, 18 Mar 2025 22:21:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] 9p/trans_fd: mark concurrent read and writes to
 p9_conn->err
To: Ignacio Encinas Rubio <ignacio.encinas@semidynamics.com>,
 Dominique Martinet <asmadeus@codewreck.org>
Cc: linux-kernel-mentees@lists.linux.dev, v9fs@lists.linux.dev,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
References: <20250313-p9_conn_err_benign_data_race-v2-1-0bb9f45f6bb2@iencinas.com>
 <Z9dBfEf0naCsNrNv@codewreck.org>
 <0807e0cc-457b-49bd-bce5-a961ad7f0ffb@semidynamics.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ignacio Encinas Rubio <ignacio@iencinas.com>
In-Reply-To: <0807e0cc-457b-49bd-bce5-a961ad7f0ffb@semidynamics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Trimming CC to avoid spamming people (I hope that's ok)

Hello Dominique!

On 17/3/25 18:01, Ignacio Encinas Rubio wrote:
> On 16/3/25 22:24, Dominique Martinet wrote:
>> There's this access out of the lock so perhaps this should look like
>> this instead (with or without the READ_ONCE)
>>
>> +       err = READ_ONCE(m->err);
>> +       if (err < 0) {
>>                 spin_unlock(&m->req_lock);
>> -               return m->err;
>> +               return err;
> 
> Oops, this is embarrassing... Thanks for catching it.
> 
>> Anyway, m->err is only written exactly once so it doesn't matter the
>> least in practice, 
> 
> I think this one deserves a fix, I disagree :)
> 
>> and it looks like gcc generates exactly the same
>> thing (... even if I make that `return READ_ONCE(m->err)` which
>> surprises me a bit..), so this is just yak shaving.
> 
> This is weird... I'll double check because it shouldn't generate the
> same code as far as I know.

I had a bit of time to check this. I understood you said that (A)

	err = READ_ONCE(m->err);
	if (err < 0) {
		spin_unlock(&m->req_lock);
		return READ_ONCE(m->err);
	}

compiles to the same thing as (B)

	err = READ_ONCE(m->err);
	if (err < 0) {
		spin_unlock(&m->req_lock);
		return err;
	}

if you didn't say this, just ignore this email :). With gcc (GCC) 
14.2.1 20250110 (Red Hat 14.2.1-7) I'm seeing a difference:

``` (A)
movl	40(%rbx), %eax	# MEM[(const volatile int *)ts_13 + 40B], _14
# net/9p/trans_fd.c:679: 	if (err < 0) {
testl	%eax, %eax	# _14
js	.L323	#,

[...]

.L323:
# ./include/linux/spinlock.h:391: 	raw_spin_unlock(&lock->rlock);
	movq	%r12, %rdi	# _21,
	call	_raw_spin_unlock	#
# net/9p/trans_fd.c:681: 		return READ_ONCE(m->err);
	movl	40(%rbx), %eax	# MEM[(const volatile int *)ts_13 + 40B], <retval>
# net/9p/trans_fd.c:697: }
	popq	%rbx	#
	popq	%rbp	#
	popq	%r12	#
	jmp	__x86_return_thunk
```

``` (B)
movl	40(%rbx), %r12d	# MEM[(const volatile int *)ts_13 + 40B], <retval>
# net/9p/trans_fd.c:679: 	if (err < 0) {
testl	%r12d, %r12d	# <retval>
js	.L323	#,

[...]

.L323:
# ./include/linux/spinlock.h:391: 	raw_spin_unlock(&lock->rlock);
	movq	%r13, %rdi	# _20,
	call	_raw_spin_unlock	#
# net/9p/trans_fd.c:697: }
	movl	%r12d, %eax	# <retval>,
	popq	%rbx	#
	popq	%rbp	#
	popq	%r12	#
	popq	%r13	#
	jmp	__x86_return_thunk
```

(A) performs another memory read after the spinlock has been unlocked
while (B) reuses the value from the register. If you're using an old GCC
it might have bugs. I can't recall where exactly but I have seen links
to GCC bugs regarding this issues somewhere (LWN posts or kernel docs?)

To get the assembly I just got the command from .trans_fd.o.cmd and 
added "-S -fverbose-asm" (I can't really read x86 assembly)

