Return-Path: <linux-kernel+bounces-355741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ECD995647
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BC41F26984
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454320CCEF;
	Tue,  8 Oct 2024 18:17:00 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6061E0DEF
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411420; cv=none; b=q+YalNLy/l7lmi4sv+x/YRPBMt6hCcbRbQeIcF6GT63A1kuO+Tn5JAnOSQcp0dyDIanK/g8ZpFwS6pGVT5CeO7Gjw5CsVDnEimDzK5jlppnMfcvoduVKZ+XNZDDVH0eLuM89IQW2cvEaKhPtQfW9X0XaUvStkLl6rlCfQI5Af9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411420; c=relaxed/simple;
	bh=FdJh+eWwVUKcL+l64mIZ4oy6x8ebxWu+9Tnhw9K8wBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n8C5zcoU8ZJ74dOzkDrsPNo/p4hotd1IrNo1LH2KZUgc7bwuWSiGzuqa6vrkNtxwsYh9udFrDvc/PhovOOP0TU1FkSum8PgggoiDdMbJrZn0BmaBnvmwXDylKvtWcdIaB+70stT4cbge/34z5rXNlo+RBHcdGhRftZjRk4NFQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1349BC4CEC7;
	Tue,  8 Oct 2024 18:16:58 +0000 (UTC)
Date: Tue, 8 Oct 2024 14:17:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mike Rapoport <mike.rapoport@gmail.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: Re: reserve_mem command line option causing a reboot but not by the
 kernel
Message-ID: <20241008141702.31bae0ee@gandalf.local.home>
In-Reply-To: <20241008132259.52a5f274@gandalf.local.home>
References: <20241006133233.32c8708c@rorschach.local.home>
	<20241008132259.52a5f274@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 13:22:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> It appears that grub does indeed search for "mem=" (without looking for
> something before it) in the kernel command line.
> 
>   https://github.com/jezze/grub-legacy/blob/master/stage2/boot.c#L275
> 
> Thus, "reserve_mem=" (or any other "mem=" option) cannot be used with legacy
> grub installs :-p

But it only looks at the first instance of "mem=". So I added "testmem=16G"
to the command line (giving lots of memory to fool grub, and the kernel
fixes it after the decompression) before the "reserve_mem", and now I can
use "reserve_mem" on this test box (and it preserves the memory across
boots!).

           <...>-2378    [000] dN.1.   124.665568: clear_local_APIC <-disable_local_APIC
           <...>-2378    [000] dN.1.   124.665569: mcheck_cpu_clear <-native_stop_other_cpus
           <...>-2378    [000] dN.1.   124.665569: mce_intel_feature_clear <-native_stop_other_cpus
           <...>-2378    [000] dN.1.   124.665569: lmce_supported <-mce_intel_feature_clear
           <...>-2378    [000] dN.1.   124.665570: lapic_shutdown <-native_machine_shutdown
           <...>-2378    [000] dN.1.   124.665570: clear_local_APIC <-lapic_shutdown
           <...>-2378    [000] dN.1.   124.665570: restore_boot_irq_mode <-native_machine_shutdown
           <...>-2378    [000] dN.1.   124.665571: native_restore_boot_irq_mode <-native_machine_shutdown
           <...>-2378    [000] dN.1.   124.665571: disconnect_bsp_APIC <-native_machine_shutdown
           <...>-2378    [000] dN.1.   124.665572: hpet_disable <-native_machine_shutdown
           <...>-2378    [000] dN.1.   124.665572: iommu_shutdown_noop <-native_machine_shutdown
           <...>-2378    [000] dN.1.   124.665572: native_machine_emergency_restart <-__do_sys_reboot
           <...>-2378    [000] dN.1.   124.665572: tboot_shutdown <-native_machine_emergency_restart
           <...>-2378    [000] dN.1.   124.665573: machine_real_restart <-native_machine_emergency_restart
           <...>-2378    [000] dN.1.   124.665573: _raw_spin_lock <-machine_real_restart
           <...>-2378    [000] dN.1.   124.665574: preempt_count_add <-_raw_spin_lock
           <...>-2378    [000] dN.2.   124.665574: rtc_cmos_write <-machine_real_restart
           <...>-2378    [000] dN.2.   124.665576: _raw_spin_unlock <-machine_real_restart
           <...>-2378    [000] dN.2.   124.665577: preempt_count_sub <-_raw_spin_unlock
           <...>-2378    [000] dN.1.   124.665577: load_trampoline_pgtable <-machine_real_restart
           <...>-2378    [000] dN.1.   124.665578: __flush_tlb_all <-machine_real_restart
           <...>-2378    [000] dN.1.   124.665578: native_flush_tlb_global <-__flush_tlb_all

But this machine did find a bug in the code where I need to send out a fix for.

-- Steve

