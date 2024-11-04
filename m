Return-Path: <linux-kernel+bounces-394843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799CE9BB4BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD3B28150F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284401B0F3E;
	Mon,  4 Nov 2024 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIoNPESM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5EF1EEE6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730723822; cv=none; b=SLi9bNJ7gJu8+qDnDwcaNTOhriFxhKP2ovbG1Ceq7Xnk5DIgDWc5s8eza7wlXatDVTVaIOW499qVvs2qRAZYEf0a8GPnzW1qr1eTULQ9koCDAQRruNo+ZuXWBObUWcDe338aoYDqpE27+m4PBSTaFv6GyB40vAAoye+o3hiusVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730723822; c=relaxed/simple;
	bh=nLWE9sFVDVOjzuEBMNNb0uNRdOfbGi5OLuEP7/e1xxU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pA5PWGBehMaS+mtq51PjHqIVhjnuShiQ4GUMotpxocb4gJME95pIP4sztcyn7QuW0lKFoSlFEdhEfcyAz9PtR0lrLnW5sys+Y1J+rI08JM7cRuGbC10jhJ8K2n9aZZGjlRLH2o7wM4bE7PT4yTUdIz/zsAtqkportvw1bVT+DYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIoNPESM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730723819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=26+eaKXWg4Y9nMtwbzpW9FIPSBQ2pc5B5u1eYdeG7dw=;
	b=dIoNPESMwbOgWNUJeR/aGtHuUsaV8bP5nwN1j0990RyGx6zE8ll2c54MLILeH1ZSUPtxwh
	y2fZ7HCZIgi3/0wJiKWtcOH1xZ1n1e26FRmkdZgAc0Dx5N07eHGUmnca7Z1VMmS2FvCI2+
	5JxcVNvgkhlzChsEOlYUGFr2NyhNtPo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-7Q0aYaUCNSqFCSY-6GxhVw-1; Mon,
 04 Nov 2024 07:36:54 -0500
X-MC-Unique: 7Q0aYaUCNSqFCSY-6GxhVw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8AB3119560B0;
	Mon,  4 Nov 2024 12:36:50 +0000 (UTC)
Received: from oldenburg3.str.redhat.com (unknown [10.39.194.82])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 081651956052;
	Mon,  4 Nov 2024 12:36:45 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>,  Thomas
 Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Darren Hart
 <dvhart@infradead.org>,  Davidlohr Bueso <dave@stgolabs.net>,  Arnd
 Bergmann <arnd@arndb.de>,  sonicadvance1@gmail.com,
  linux-kernel@vger.kernel.org,  kernel-dev@igalia.com,
  linux-api@vger.kernel.org,  Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v2 0/3] futex: Create set_robust_list2
In-Reply-To: <20241104113240.GB24862@noisy.programming.kicks-ass.net> (Peter
	Zijlstra's message of "Mon, 4 Nov 2024 12:32:40 +0100")
References: <20241101162147.284993-1-andrealmeid@igalia.com>
	<87ldy170x9.fsf@oldenburg.str.redhat.com>
	<20241104113240.GB24862@noisy.programming.kicks-ass.net>
Date: Mon, 04 Nov 2024 13:36:43 +0100
Message-ID: <87jzdjxjj8.fsf@oldenburg3.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

* Peter Zijlstra:

> On Sat, Nov 02, 2024 at 10:58:42PM +0100, Florian Weimer wrote:
>
>> QEMU hints towards further problems (in linux-user/syscall.c):
>> 
>>     case TARGET_NR_set_robust_list:
>>     case TARGET_NR_get_robust_list:
>>         /* The ABI for supporting robust futexes has userspace pass
>>          * the kernel a pointer to a linked list which is updated by
>>          * userspace after the syscall; the list is walked by the kernel
>>          * when the thread exits. Since the linked list in QEMU guest
>>          * memory isn't a valid linked list for the host and we have
>>          * no way to reliably intercept the thread-death event, we can't
>>          * support these. Silently return ENOSYS so that guest userspace
>>          * falls back to a non-robust futex implementation (which should
>>          * be OK except in the corner case of the guest crashing while
>>          * holding a mutex that is shared with another process via
>>          * shared memory).
>>          */
>>         return -TARGET_ENOSYS;
>
> I don't think we can sanely fix that. Can't QEMU track the robust thing
> itself and use waitpid() to discover the thread is gone and fudge things
> from there?

There are race conditions with munmap, I think, and they probably get a
lot of worse if QEMU does that.

See Rich Felker's bug report:

| The corruption is performed by the kernel when it walks the robust
| list. The basic situation is the same as in PR #13690, except that
| here there's actually a potential write to the memory rather than just
| a read.
| 
| The sequence of events leading to corruption goes like this:
| 
| 1. Thread A unlocks the process-shared, robust mutex and is preempted
|    after the mutex is removed from the robust list and atomically
|    unlocked, but before it's removed from the list_op_pending field of
|    the robust list header.
| 
| 2. Thread B locks the mutex, and, knowing by program logic that it's
|    the last user of the mutex, unlocks and unmaps it, allocates/maps
|    something else that gets assigned the same address as the shared mutex
|    mapping, and then exits.
| 
| 3. The kernel destroys the process, which involves walking each
|   thread's robust list and processing each thread's list_op_pending
|   field of the robust list header. Since thread A has a list_op_pending
|   pointing at the address previously occupied by the mutex, the kernel
|   obliviously "unlocks the mutex" by writing a 0 to the address and
|   futex-waking it. However, the kernel has instead overwritten part of
|   whatever mapping thread A created. If this is private memory it
|   (probably) doesn't matter since the process is ending anyway (but are
|   there race conditions where this can be seen?). If this is shared
|   memory or a shared file mapping, however, the kernel corrupts it.
| 
| I suspect the race is difficult to hit since thread A has to get
| preempted at exactly the wrong time AND thread B has to do a fair
| amount of work without thread A getting scheduled again. So I'm not
| sure how much luck we'd have getting a test case.


<https://sourceware.org/bugzilla/show_bug.cgi?id=14485#c3>

We also have a silent unlocking failure because userspace does not know
about ROBUST_LIST_LIMIT:

  Bug 19089 - Robust mutexes do not take ROBUST_LIST_LIMIT into account
  <https://sourceware.org/bugzilla/show_bug.cgi?id=19089>

(I think we may have discussed this one before, and you may have
suggested to just hard-code 2048 in userspace because the constant is
not expected to change.)

So the in-mutex linked list has quite a few problems even outside of
emulation. 8-(

Thanks,
Florian


