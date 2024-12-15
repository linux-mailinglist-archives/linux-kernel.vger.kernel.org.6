Return-Path: <linux-kernel+bounces-446264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0099F21FF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 04:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944E67A086D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16A8BFF;
	Sun, 15 Dec 2024 03:03:36 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7E819
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734231815; cv=none; b=DMnZBwLieaGWn1kEcA3QvKzNvMPYAA4r4aDpCtEMdrbFVLJ2S+sKxZmn9jwoIBY4MdN2J2ei1FL9O4WzClrM2cg/NOyFAYsV3yJiBCoy4e+OuLZersdj4t8O5J/fEaW/ALjBGlBRgKGyYOhSbXL/qMlvLG1yK2O+tLEcBmEOehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734231815; c=relaxed/simple;
	bh=oOUWIYLx0wtohDKk/KKApcKdwrbZdKySl68YoKdoSnU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlIKaK+LbGlvJZlrrN3wIaBOPwd0OY3rJYbYx/sj+tpASWdNe/gUB0kWNVNfRJxqzVT/1ZzZFTmQ5Alt0xbfC1iKa5L1ROBO8GRJkMvIJ+CcOOtCM7A9cfjupgXlSRlIabnEGovvy3UxS0lqOClIE/JXIQgZm/yc5yaC4dXU4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E75C4CED4;
	Sun, 15 Dec 2024 03:03:34 +0000 (UTC)
Date: Sat, 14 Dec 2024 22:04:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Al Viro
 <viro@zeniv.linux.org.uk>, Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] ftrace: Fixes for v6.13
Message-ID: <20241214220403.03a8f5d0@gandalf.local.home>
In-Reply-To: <CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
References: <20241214182138.4e7984a2@batman.local.home>
	<CAHk-=wgyWEbWa9k5=z4LxY1hx0Pxqf5TQQC_BKme_+DrzGufKw@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Dec 2024 16:37:39 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, 14 Dec 2024 at 15:21, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > - Fix output of trace when hashing a pointer is disabled  
> 
> Christ.
> 
> I'm looking at this, and my reaction is literally "tracing is doing
> crazy things AGAIN".
> 
> This stuff is full of crazy special cases for things that should never
> be done in the first place.
> 
> And - surprise surprise - it was buggy in odd ways as a result.
> 
> If I read the code right, this hacky code literally only catches stale
> strings, but also has some *insane* code to do "text_delta" to
> '%p[sS]' printouts.
> 
> And I see how it does that
> 
>                 text_delta = iter->tr->text_delta;
> 
> but I don't actually see where 'text_delta' would ever actually get
> set.  Where does tr->text_delta ever get set to anything but zero?

It gets set by the persistent ring buffer code, via a call to
ring_buffer_last_boot_delta(). It's the delta between pointers from the
previous kernel boot up and the current kernel boot up. Without it, you
don't get function names in your function traces from the last boot. That
is, instead of having this:

              <idle>-0       [003] d.h2.   156.462395: __rcu_read_lock <-cpu_emergency_disable_virtualization
              <idle>-0       [003] d.h2.   156.462396: vmx_emergency_disable_virtualization_cpu <-cpu_emergency_disable_virtualization
              <idle>-0       [003] d.h2.   156.462396: __rcu_read_unlock <-__sysvec_reboot
              <idle>-0       [003] d.h2.   156.462397: stop_this_cpu <-__sysvec_reboot
              <idle>-0       [003] d.h2.   156.462397: set_cpu_online <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462397: disable_local_APIC <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462398: clear_local_APIC <-disable_local_APIC
              <idle>-0       [003] d.h2.   156.462574: mcheck_cpu_clear <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462575: mce_intel_feature_clear <-stop_this_cpu
              <idle>-0       [003] d.h2.   156.462575: lmce_supported <-mce_intel_feature_clear

You get this:

              <idle>-0       [003] d.h2.   156.462395: 0xffffffff9a1e3194 <-0xffffffff9a0f655e
              <idle>-0       [003] d.h2.   156.462396: 0xffffffff9a0a1d24 <-0xffffffff9a0f656f
              <idle>-0       [003] d.h2.   156.462396: 0xffffffff9a1e6bc4 <-0xffffffff9a0f7323
              <idle>-0       [003] d.h2.   156.462397: 0xffffffff9a0d12b4 <-0xffffffff9a0f732a
              <idle>-0       [003] d.h2.   156.462397: 0xffffffff9a1458d4 <-0xffffffff9a0d12e2
              <idle>-0       [003] d.h2.   156.462397: 0xffffffff9a0faed4 <-0xffffffff9a0d12e7
              <idle>-0       [003] d.h2.   156.462398: 0xffffffff9a0faaf4 <-0xffffffff9a0faef2
              <idle>-0       [003] d.h2.   156.462574: 0xffffffff9a0e3444 <-0xffffffff9a0d12ef
              <idle>-0       [003] d.h2.   156.462575: 0xffffffff9a0e4964 <-0xffffffff9a0d12ef
              <idle>-0       [003] d.h2.   156.462575: 0xffffffff9a0e3fb0 <-0xffffffff9a0e496f

Due to KASLR.

> 
> That code should be *removed*. It seems to be there entirely as a
> sanity check, and when the sanity check itself is buggy, you don't try
> to fix it, you remove the whole crazy garbage.
> 
> What makes '%s' so special in trace formats that it merits this
> horrible hackery?
> 
> What makes 'text_delta' at all sane, never mind where it even gets set?
> 
> And why should we maintain that horrible hackery and make it worse?
> 
> This code shows a complete lack of taste. This needs extreme
> crapectomy, not some alleged "fix".
> 
> If "people use stale pointers for '%s' and we actually care" is a real
> issue, we could very possibly teach vsnprintf() about that. The code
> already has a "check_pointer()" thing for just NULL pointer magic
> printouts.

The check code was added because I was sick and tired of fixing bugs in
trace events. People would use the TRACE_EVENT() TP_printk() like a normal
printk with things like:

  TP_fast_assign(
      __entry->ipv6 = ptr_to_ipv6;
  )

  TP_printk("ipv6=%pI6", __entry->ipv6)


This is very buggy. Because the ipv6 pointer is added to the ring buffer at
the time of the trace event was triggered, but that "ipv6=%pI6" is executed
when the user reads the trace. Which can be minutes, hours, days, even
months later! In other words, it will read a pointer that has long been
freed.

With the check, instead it doesn't crash the kernel, but issues a nasty
WARN_ON() (as it is a bug in the kernel) and then reads the value using
safe mechanisms and injects into the trace "[UNSAFE-MEMORY]" by the pointer.

I haven't seen this bug show up again since I added that. That's because
developers see the warning when they add the buggy trace event, and it is
fixed before it ever reaches you.

Should I move that protection from the tracing code into vsnprintf()?

-- Steve

