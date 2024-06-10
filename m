Return-Path: <linux-kernel+bounces-208023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7CD901F78
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0702823E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C378279B84;
	Mon, 10 Jun 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0w9U/G0w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DkfvpsZJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63E32C190
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015658; cv=none; b=GgjwPubNuZYfCx4u51bYQ484OGe2xFYe7YFrcSnbK5bSGLQ22fXPTuIEHBk6H3tEheC2J1PxUbvcyR0lZYVFRyFgwlp6oTqaJVako2IVxNHsCZ4P951vKjMZ7yW7PBLhqXCR8YGpE1gBlupitj2d/LnrW7tCd2/umVuvtrWhPIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015658; c=relaxed/simple;
	bh=GgPF/kNWNWiUXah1his2cVQzKbjr5QQj/Znn9RugYT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Et2Ku7y8P624o9MNs3lmKm2wLUhfQuzyLjorJhQoAwbc2L+vO1mA7f3LHU2dtC/PXy5cSe95vTqrwBSK914XPZDKidOVo2RdomdMjK5CK4jkcRCX6dkmCcgkq2y/4L1P5Sm3eIqBDZ4Ly1RHFOANluUtMmx1htEx3UZ6t/rZo5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0w9U/G0w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DkfvpsZJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718015654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRkx/5RwMgFbzf1uUBRE8Tiy4K15zukz3Dkd3L3xoLM=;
	b=0w9U/G0wimfijjdKv8E/+itfH4XuYpCZ3bz7C4liI41Zij8X5jfS/+WCBS5tTas0Ih5DWJ
	qih5WjxbEl0ntA5cl10Luf9/ka25zUColy2oUK2/Q6JXvZJ/sgKa1dTq1s7Zh/N65dJ9sH
	HvLrj//g6ntSCI5iS5U4D3/aTMfojpQDjMm/A7sh0f9cTysNFS7JS61PDzYNTpYLOVVNZt
	Io5nRPZzkLsjmX1mvCLlAbVU/wWvD4K/yi736LridoN0Zg8wV+F20hsXGXsc0xeGD7zmo4
	EMGaCysTz6fsxiAPnyjuQ3eGhg7BDEtTs/s4+NPgDc4kNp9Y37+yxC2MXL5RkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718015654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRkx/5RwMgFbzf1uUBRE8Tiy4K15zukz3Dkd3L3xoLM=;
	b=DkfvpsZJ+vDRqy4Ly9cqY5TKh9zU5gzWjQ8zB3QhnliSMiOlvYQkfdzWSwQNzz9TH7bI/s
	qd133NcdNxAw2sAg==
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sam Sun <samsun1006219@gmail.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 syzkaller-bugs@googlegroups.com, jpoimboe@kernel.org, jbaron@akamai.com,
 ardb@kernel.org, mingo@redhat.com, Borislav Petkov <bp@alien8.de>,
 dave.hansen@linux.intel.com, hpa@zytor.com, xrivendell7@gmail.com, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
In-Reply-To: <20240610064651.GS8774@noisy.programming.kicks-ass.net>
References: <20240609090431.3af238bc@gandalf.local.home>
 <87o78axlbm.ffs@tglx> <20240609102530.0a292b07@rorschach.local.home>
 <87le3exfx2.ffs@tglx> <87h6e2xdg1.ffs@tglx>
 <20240610064651.GS8774@noisy.programming.kicks-ass.net>
Date: Mon, 10 Jun 2024 12:34:14 +0200
Message-ID: <87bk49xf15.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jun 10 2024 at 08:46, Peter Zijlstra wrote:
> On Sun, Jun 09, 2024 at 06:56:14PM +0200, Thomas Gleixner wrote:
>
>> Ok. Now I found if for real. It's in the jump label core:
>> 
>> CPU0                            CPU1
>> 
>> static_key_slow_dec()
>>  static_key_slow_try_dec()
>> 
>>    key->enabled == 1
>>    val = atomic_fetch_add_unless(&key->enabled, -1, 1);
>>    if (val == 1)
>>    	return false;
>> 
>>    jump_label_lock();
>>    if (atomic_dec_and_test(&key->enabled)) {
>>       --> key->enabled == 0
>>       __jump_label_update()
>> 
>>                                 static_key_slow_dec()
>>                                  static_key_slow_try_dec()
>> 
>>                                     key->enabled == 0
>>                                     val = atomic_fetch_add_unless(&key->enabled, -1, 1);
>> 
>>                                     --> key->enabled == -1 <- FAIL
>> 
>> static_key_slow_try_dec() is buggy. It needs similar logic as
>> static_key_slow_try_inc() to work correctly.
>> 
>> It's not only the 0, key->enabled can be -1 when the other CPU is in the
>> slow path of enabling it.
>
> Well, the -1 thing is in the 0->1 path, that is, the very first enabler.
>
> That *should* not race with a disabler. If it does, there is external
> confusion. (As I think the follow up email shows..)

Right, but all of this is too fragile. Let me send out those patches.

