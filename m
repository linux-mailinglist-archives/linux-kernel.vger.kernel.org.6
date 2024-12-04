Return-Path: <linux-kernel+bounces-431901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5419E427C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30DC2869CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B620E6E8;
	Wed,  4 Dec 2024 17:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ld6Td65x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ua3Ta0mj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6144F20DD49;
	Wed,  4 Dec 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332639; cv=none; b=cwTWI5ARGrzw3swa3+Qc1qKgD9PximAcv9tUKwIiWbV31fUMRYU0jc+q5tWAevpGKFhR3geaZ6/kBDxQjcylA2GdjP5Q2+nazT0OUu+3cyqyT6pt666C/0JgwLExwZdKjKZmt63wTMtzzjOpkh9BVjXmF1/WW9KdrtQZyn/6MhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332639; c=relaxed/simple;
	bh=9/J1gfAIEWZdCSHyW3NuUHJbyQfNYoyuXJA8Vk0K6Rg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jbhnjG5eBCeyUfaqfdYmQNjSlO/f+sc4y3A5lqchGKkn0wfGJX/4EI+73VSh/QhaRpfYTB2ABOrYhb3mzwrFvI3i5fJrOpZUSFxRxl02kn8WWZKq7JGvJRx6KbfzOS7XTEHAt5agFocw2qNpgB/aYHtMPg8JGfaYaKRfram1Qbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ld6Td65x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ua3Ta0mj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733332634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bR12mYTCVt9lsWKT3SDULoA7WMEUW8vFVe8mlZKDaeE=;
	b=ld6Td65xLsEtdVlO3ZjpBtH/x22Dgk4clFXI8XVHu//dKt4BohTD35suF50hY/txb+Y7RT
	H/QZ1mje3G4qZ7aahtKdrQK8HSfpeHICt0hvuP/tM0zo5Nr+qO46859YiFZ8H16ccY86GW
	TsWrE+bhknYrWiZzqzYAAq++UdO8srpIEFzjH5WyeiISXpDsyPTw2SjewGDfsFCm/tDcs9
	GT7L5vMtz9ShqslwWAItH3thHQvnC8xleAiQuoaTCdJcrroYWHoCVso17fwYm5KxOCCgRX
	72Kvwvl0NRS9tDCMJ2XfUrgBUGwwOODQPVQP+4qR8325nXKX8/+BH7D71vz92Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733332634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bR12mYTCVt9lsWKT3SDULoA7WMEUW8vFVe8mlZKDaeE=;
	b=ua3Ta0mj4fEKqHrgrvq3dJQRsTGMP0VJjxSJkkTYLMMmgahPHj0kizF9mj5bBTQ7+ZH2N4
	F5thgyHJ+6x/7VBw==
To: Petr Mladek <pmladek@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 surenb@google.com, kernel-team@android.com, linux-kernel@vger.kernel.org,
 Linux Embedded <linux-embedded@vger.kernel.org>
Subject: Re: [PATCH v2] printk: Improve memory usage logging during boot
In-Reply-To: <Z07SnoKSwHQ_y2j2@pathway.suse.cz>
References: <20240930184826.3595221-1-isaacmanjarres@google.com>
 <ZvwZV5MDlQYGJv9N@pathway.suse.cz>
 <CAMuHMdX_r05iUFw6-Jj8Utry5bHdE6=U46uB4Za1NTsdZOuOMw@mail.gmail.com>
 <Z07SnoKSwHQ_y2j2@pathway.suse.cz>
Date: Wed, 04 Dec 2024 18:23:13 +0106
Message-ID: <84y10vz7ty.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2024-12-03, Petr Mladek <pmladek@suse.com> wrote:
> On Sun 2024-12-01 12:40:13, Geert Uytterhoeven wrote:
>> Isn't this kernel log message bookkeeping becoming a bit too excessive?
>> E.g. on a small system:
>> 
>>     printk: log buffer data + meta data: 65536 + 204800 = 270336 bytes
>> 
>> Why is the meta data that big (> 3*log buffer)?
>> 
>>     #define PRB_AVGBITS 5    /* 32 character average length */
>> 
>>     unsigned int descs_count = log_buf_len >> PRB_AVGBITS;
>>     meta_data_size = descs_count * (sizeof(struct prb_desc) +
>> sizeof(struct printk_info));
>> 
>>     struct prb_data_blk_lpos {
>>             unsigned long   begin;
>>             unsigned long   next;
>>     };
>> 
>>     struct prb_desc {
>>             atomic_long_t                   state_var;
>>             struct prb_data_blk_lpos        text_blk_lpos;
>>     };
>>
>> i.e. 12 bytes on 32-bit, 24 bytes on 64-bit.
>
> I am afraid that we could not do much about the size of this part.
> All the variables are important parts of the lockless machinery.

The descriptor array is one source of wasted space. It ensures there are
enough descriptors so that the text_ring can be fully maximized for an
average record text length of 32. However, looking at
/sys/kernel/debug/printk/index/vmlinux and running some basic tests, it
seems the average text length is >=45 (usually around 55). That means at
least 30% of the descriptor space is not in use, which is roughtly 5% of
the total memory used by all ringbuffer components.

For example, for CONFIG_LOG_BUF_SHIFT=13, the amount of wasted desc_ring
space is about 1.8KiB. (The total memory usage of the ringbuffer is
36KiB.)

However, if we bump the expected average size to 64, there will not be
enough descriptors, leading to wasted text_ring buffer space. (The
expected size must be a power of 2 due to the ID wrapping algorithm.)

>>     #define PRINTK_INFO_SUBSYSTEM_LEN       16
>>     #define PRINTK_INFO_DEVICE_LEN          48
>> 
>>     struct dev_printk_info {
>>             char subsystem[PRINTK_INFO_SUBSYSTEM_LEN];
>>             char device[PRINTK_INFO_DEVICE_LEN];
>>     };
>
> This is probably the lowest hanging fruit.

Yes, the info array is also a source of wasted space. This was known at
the time when we discussed [0] introducing this array. Many records do
not even use the dev_printk_info fields. (A running system seems to use
them more often than a booting system.) However, the 64 bytes is
currently quite large. During some testing I typically saw 70% of the
dev_printk_info text space for valid descriptors unused.

I typically saw dev_printk_info averages of:

- 5 bytes for SUBSYSTEM
- 12 bytes for DEVICE

However, this problem is compounded by the descriptor array issue I
mentioned at the beginning. The reason is that there is a 1:1
relationship between descriptors and dev_printk_info structs. So if 30%
of the descriptors are invalid, then that adds an additional waste of
30% totally unused dev_printk_info structs.

For example, for CONFIG_LOG_BUF_SHIFT=13, that represents a total of
13KiB wasted space in the info array (36% of the total memory usage).

> It should be possible to write these dev_printk-specific metadata into
> the data buffer a more efficient way and only for records created by
> dev_printk().
>
> It would require adding "dict_len" into "struct printk_info"
> and reserving space for both "text_len" and "dict_len".
>
> We bundled it into the metadata because these are metadata.
> We wanted to keep the design as clean as possible. We focused
> mainly on the stability and maintainability of the code.
> And it was really challenging to get it all working.

I think keeping it bundled in the meta data is correct. But if those
text arrays could be allocated from a text ring, then the space could be
used efficiently.

I am not recommending that we add the dict_ring back. It was
considerably more complex. But perhaps we could use the text_ring for
these allocations as well. It may even have the benefit that the
"average text size" becomes >=64, which would also help with the first
wasted item I mentioned.

>>     struct printk_info {
>>             u64     seq;            /* sequence number */
>
> I do not recal the details. But I think that we need to
> explicitely store the 64-bit "seq" number in the metadata
> because of the lockless algoritm. It helps to solve
> problems with wrapping of the counter in
> "atomic_long_t state_var".

Yes. I could not figure out a way to safely update a @log_first_seq to
represent the first sequence available in the ringbuffer. (The
complexity involves both writers and readers seeing appropriate sequence
values.) If that could be done somehow, that would save another 2KiB
(for CONFIG_LOG_BUF_SHIFT=13).

In summary...

I think the only quick fix we could do immediately is reduce
PRINTK_INFO_DEVICE_LEN. On my various test machines, I never encountered
anything above 25. Perhaps reducing it from 48 to 32? That would
immediately reclaim 11% (4KiB for CONFIG_LOG_BUF_SHIFT=13) and it would
not require any changes to the various crash/dump tools.

In the longer term we may want to consider using the text ring for
additional device/subsystem string allocation. This would only require
changes to crash/dump tools that provide the device/subsystem
information.

In addition, if low-memory single CPU systems are am important target,
we might be better off implementing a
CONFIG_PRINTK_RINGBUFFER_TINY. Implementing a lockless ringbuffer for a
single CPU is trivial (in comparison) and would not require all the
management abstractions. If it used the same printk_ringbuffer API it
could be a simple drop-in replacement.

John Ogness

[0] https://lore.kernel.org/lkml/20200904124530.GB20558@alley

