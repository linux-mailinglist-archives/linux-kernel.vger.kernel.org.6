Return-Path: <linux-kernel+bounces-207495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F8B90180A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 21:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6A80B20C4B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 19:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7923B1EB2F;
	Sun,  9 Jun 2024 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fl5Xmsyv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9U6iJImJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8D18B14
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717961980; cv=none; b=U7uG4MgvoZmwqU3FkCaV4JIFBek/aacJa9D+Yyygyf+6o0lWc3MOW5PQQsGesLxf8ffky9jnQywHyq4P5m/bx3Z6H3Hy9to4HCCbTXvH3Cvn+qc1WXZtyPafdDHIwgutFrA+uHKHwZQDIWBIOGSAlaiBO7GBznvFjhoZIBXUu5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717961980; c=relaxed/simple;
	bh=PF3CrvfyXaGB0c5lGzsdke4GDTxdv2fBwbBjFVgEGVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGePZGhDM8qJO4bDqiRRm54AFL/sPKvSUyDgdrnF42xBhBppGUPCAqmRXLLiPMNofp+e+zHVhtr1R+qXzMKOKIZxZ5mI91nQMysxIrHVy410nrY/Q8sZOkvDJASnFGhwMDW6BJgV1MK6h8ky1QU9RSeiMkAJBvQQh5W7JtVYORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fl5Xmsyv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9U6iJImJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717961977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFyBvCVieTrz4RR4wN7GisbpaYT1BWStA4X8EnrWXkI=;
	b=Fl5XmsyvepZfhoWkHUI9uUqJEf5PKVrb0k2ulGqSoP6PZJVbr/nDJJiHtO+rCt0XFCOw5t
	ZdZGKxtGReICJZ3fFU8Uzm3iolTTK2N3ow7CCjwdbCK4mlg8eGkAgjan/lssFnLXn91r14
	PeS/EJ+8ePKg7fLcIWJCT9T/RwjoOpR1ziVNJXjJKd0xvSd1T/TE6DIX/d97fuQ9g7pnbB
	nPx/jDyWq1yyRjH8NNiMcp9/cYF6yk0InnchhicymIw1c93zXeGIYmDlcYojgBSjUOZ49+
	P036/UTdxsWz/7p9Ay6x/3fA1COwlh17/gjT/nWa1wS3d+AAbKQ08dQ2QSviMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717961977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFyBvCVieTrz4RR4wN7GisbpaYT1BWStA4X8EnrWXkI=;
	b=9U6iJImJ9YHj6t4L+XlyDIIG7puesZiaVuXtx1T8yTq4xpe9/UJHY+V5yan1I1+vwotM8V
	rHPD8gYacRtDJ4Aw==
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Sam Sun <samsun1006219@gmail.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, syzkaller-bugs@googlegroups.com, peterz@infradead.org,
 jpoimboe@kernel.org, jbaron@akamai.com, ardb@kernel.org, mingo@redhat.com,
 Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
 hpa@zytor.com, xrivendell7@gmail.com, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [Linux kernel bug] WARNING in static_key_slow_inc_cpuslocked
In-Reply-To: <87h6e2xdg1.ffs@tglx>
References: <20240609090431.3af238bc@gandalf.local.home>
 <87o78axlbm.ffs@tglx> <20240609102530.0a292b07@rorschach.local.home>
 <87le3exfx2.ffs@tglx> <87h6e2xdg1.ffs@tglx>
Date: Sun, 09 Jun 2024 21:39:36 +0200
Message-ID: <87ed95ykg7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 09 2024 at 18:56, Thomas Gleixner wrote:

> On Sun, Jun 09 2024 at 18:02, Thomas Gleixner wrote:
>> On Sun, Jun 09 2024 at 10:25, Steven Rostedt wrote:
>> Well the bug is there to detect inconsistency and that clearly works :)
>>
>> But I clearly can't read, because the jump label operations are
>> serialized via jump_label_mutex. Hrm...
>
> Ok. Now I found if for real. It's in the jump label core:
>
> CPU0                            CPU1
>
> static_key_slow_dec()
>  static_key_slow_try_dec()
>
>    key->enabled == 1
>    val = atomic_fetch_add_unless(&key->enabled, -1, 1);
>    if (val == 1)
>    	return false;
>
>    jump_label_lock();
>    if (atomic_dec_and_test(&key->enabled)) {
>       --> key->enabled == 0
>       __jump_label_update()
>
>                                 static_key_slow_dec()
>                                  static_key_slow_try_dec()
>
>                                     key->enabled == 0
>                                     val = atomic_fetch_add_unless(&key->enabled, -1, 1);
>
>                                     --> key->enabled == -1 <- FAIL
>
> static_key_slow_try_dec() is buggy. It needs similar logic as
> static_key_slow_try_inc() to work correctly.
>
> It's not only the 0, key->enabled can be -1 when the other CPU is in the
> slow path of enabling it.
>
> I'll send a patch after testing it.

That's fixable, but it does not cure all of it.

set_attr_rdpmc() really needs serialization otherwise it can end up with
unbalanced operations.

CPU0                                    CPU1

x86_pmu.attr_rdpmc == 0

if (val != x86_pmu.attr_rdpmc) {
   if (val == 0)
   	...
   else if (x86_pmu.attr_rdpmc == 0)
     static_branch_dec(&rdpmc_never_available_key);

                                        if (val != x86_pmu.attr_rdpmc) {
                                           if (val == 0)
                                              	...
                                            else if (x86_pmu.attr_rdpmc == 0)
                               FAIL --->        static_branch_dec(&rdpmc_never_available_key);

No?

