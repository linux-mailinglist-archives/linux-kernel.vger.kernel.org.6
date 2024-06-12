Return-Path: <linux-kernel+bounces-211162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96566904DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F33E1C237D6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EE16C869;
	Wed, 12 Jun 2024 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDsExB5Y"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009C1374FF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 08:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180240; cv=none; b=OrcEd8PVCC3EV7Gj+dXTLnzzBbuvZLQpod9JXBPeiM8yon1C/2vSkqZKMiLD85Bf1SXvtccWOc5cN+C3SVJqyzQ2orBSYo00ReSJtYsKMsTwN7/bo46g9O7E9VSzvqZXw8y5pFcks9t0bdO0Pew+0Kzc8t9fiptuljfYuQJayrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180240; c=relaxed/simple;
	bh=U5uNvHS69lCKbbn1iZNtuiFVn2kNjwqGMxKmhaX5vQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqCvkEJojn4DGkq/6kx+9VYQIQeOli0tZcDKWPd7fDzcySMzXnJTqxgCorvaPHUGlGoZEtmXIMB5y5TdV4/Za6qBaoxpUdbIn0KUh235Nw+LM6Ax0608ItS1dTWhcK9myQb22Jny2OVD2SwWfCywCGOJGI9Is/bCj6eNnkahbBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDsExB5Y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57c76497cefso4618025a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 01:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718180236; x=1718785036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQ4G6myfP3vBwmqu9HwXBrJWyWvPJyXart3WuYGLxPk=;
        b=jDsExB5YvMxp6xmn+5Kkt16pNiqs9PXzRGQe9FD6L1np2zye5FWBmRuEIu5pczEdQ0
         xX5G30szP6etrKv0xv2GfRKCH4fOwY+IlO9PF6wIhgwpMLmMOdweZSXIzWG3ZyCbCcx8
         rq1Mox/mNmzQ9zDDwY2zD6abKIP6V4DMOvB53/QeT6Fo1AZnhJte4GkenMcqGU1yxFJY
         hmi47EMeUx/UFRWNWDbWEWoPkyzDNGy5Keb8i64/wwIeWHA8lV04uN3o8F2TlHleTxsc
         tx++IS+AVHCy0C+HcIOwxYOtgOTZP6jkbYavPzH7NKom0KSbWeyY+axnzO+8BR+u0d2j
         Capg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718180236; x=1718785036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQ4G6myfP3vBwmqu9HwXBrJWyWvPJyXart3WuYGLxPk=;
        b=CZvqIaKKoHvHqKxEsB9EwOepxs+09jcIMHCwkGACR0uW9Cgkuc3IFOy1bUEX85QKUo
         hfajMFcZnbJ12o/7xyNEfAEYxZzpkHkVnvO3vvDUpQ2FLKzrw5BHVhlHq2MctQqsZ92V
         d9iE00vy0QxGk1a12mwI5wCQfnvEUXpth0PKwVrK2S/9o576vWcw9uX7iZ2tcBfyEZYE
         J9F5JebJd/nhHwizmG8NOom32r5wVhWSIu295+PgRQlN8sgMRCX0ACfrwCLo3K4yAY2B
         EP9JUiVK+tApZ5zguqc43MURX3cBtNhrnjgfCy5lDDUicgLgyCGeoHM2a8YIwBHjoG82
         +bng==
X-Forwarded-Encrypted: i=1; AJvYcCUQYuGKnEB4Ep5z0w/In73zOf0Y4Blnt+rFDFzT9a2iVw/zSHy87miLNtiAnAUzsB+5+oTdSl9in0cJQkoRkb37zSAAgiqt5PRXsbZF
X-Gm-Message-State: AOJu0Yw7xOdAcOAebJaqErWEtTTXtHbzBFGzF46iToJUT287zx9jZBOa
	mkhRIV8CyoUJmtO8WbzC5Gv+ncONiCXCI4eqx2Y9XbUGmzQ3MaOC
X-Google-Smtp-Source: AGHT+IHabF2/5hhN0SNhuSiOH/2ahAqKAmJaD0WRpMmZfJ7nynhfzGJ+1abIPgwybAteyJ+8XXoBPw==
X-Received: by 2002:a50:d490:0:b0:57a:33a5:9b78 with SMTP id 4fb4d7f45d1cf-57ca97936demr888891a12.34.1718180235665;
        Wed, 12 Jun 2024 01:17:15 -0700 (PDT)
Received: from gmail.com (1F2EF20A.nat.pool.telekom.hu. [31.46.242.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c81d8d79bsm5005561a12.45.2024.06.12.01.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 01:17:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 12 Jun 2024 10:17:12 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-kernel@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <dave@sr71.net>, Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH 3/9] x86/fpu: Make task_struct::thread constant size
Message-ID: <ZmlZiHVF8w09mExw@gmail.com>
References: <20240608073134.264210-1-mingo@kernel.org>
 <20240608073134.264210-4-mingo@kernel.org>
 <20240610211350.GA1613053@thelio-3990X>
 <20240611124145.GA26798@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="H29q6/41zZ4M0tch"
Content-Disposition: inline
In-Reply-To: <20240611124145.GA26798@redhat.com>


--H29q6/41zZ4M0tch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Oleg Nesterov <oleg@redhat.com> wrote:

> I don't think this can explain the problem reported by Nathan, but.
> 
> On 06/08, Ingo Molnar wrote:
> >
> > +static struct fpu x86_init_fpu __read_mostly;
> > +
> >  static void __init fpu__init_system_early_generic(void)
> >  {
> > +	int this_cpu = smp_processor_id();
> > +
> > +	fpstate_reset(&x86_init_fpu);
> > +	current->thread.fpu = &x86_init_fpu;
> 
> OK,
> 
> > +	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
> > +	x86_init_fpu.last_cpu = this_cpu;
> 
> Why? I think it should do
> 
> 	x86_init_fpu.last_cpu = -1;
> 	set_thread_flag(TIF_NEED_FPU_LOAD);
> 
> And the next patch should kill x86_init_fpu altogether, but keep
> TIF_NEED_FPU_LOAD. It should be never cleared if PF_KTHREAD.

So I applied the patch further below on top of:

   4f4a9b399357 x86/fpu: Make task_struct::thread constant size

And Nathan's 32-bit kernel testcase [but running with 1 CPU to simplify it] 
still crashes in a similar fashion in the (first?) modprobe instance with a 
bad FPU state exception:

  x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
  x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
  x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
  x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
  x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
  [...]

  netconsole: network logging started
  cfg80211: Loading compiled-in X.509 certificates for regulatory database
  ------------[ cut here ]------------
  Bad FPU state detected at restore_fpregs_from_fpstate+0x38/0x6c, reinitializing FPU registers.
  WARNING: CPU: 0 PID: 60 at arch/x86/mm/extable.c:127 fixup_exception+0x41e/0x45c
  Modules linked in:
  CPU: 0 PID: 60 Comm: modprobe Not tainted 6.10.0-rc2-00003-g4f4a9b399357-dirty #39
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  ...

... and the kernel goes down shortly afterwards - full crashlog attached.

What am I missing?

Thanks,

	Ingo  

===================>

 arch/x86/kernel/fpu/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 4e8d37b5a90b..8f912f564fb1 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -75,12 +75,11 @@ static struct fpu x86_init_fpu __read_mostly;
 
 static void __init fpu__init_system_early_generic(void)
 {
-	int this_cpu = smp_processor_id();
-
 	fpstate_reset(&x86_init_fpu);
 	current->thread.fpu = &x86_init_fpu;
-	per_cpu(fpu_fpregs_owner_ctx, this_cpu) = &x86_init_fpu;
-	x86_init_fpu.last_cpu = this_cpu;
+
+	x86_init_fpu.last_cpu = -1;
+	set_thread_flag(TIF_NEED_FPU_LOAD);
 
 	if (!boot_cpu_has(X86_FEATURE_CPUID) &&
 	    !test_bit(X86_FEATURE_FPU, (unsigned long *)cpu_caps_cleared)) {

--H29q6/41zZ4M0tch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="crash.log"

Linux version 6.10.0-rc2-00003-g4f4a9b399357-dirty (mingo@kepler) (gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #39 SMP PREEMPT_DYNAMIC Wed Jun 12 10:10:53 CEST 2024
BIOS-provided physical RAM map:
BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
BIOS-e820: [mem 0x0000000000100000-0x000000001ffdffff] usable
BIOS-e820: [mem 0x000000001ffe0000-0x000000001fffffff] reserved
BIOS-e820: [mem 0x00000000b0000000-0x00000000bfffffff] reserved
BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
**********************************************************
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**                                                      **
** This system shows unhashed kernel memory addresses   **
** via the console, logs, and other interfaces. This    **
** might reduce the security of your system.            **
**                                                      **
** If you see this message and you are not debugging    **
** the kernel, report this immediately to your system   **
** administrator!                                       **
**                                                      **
**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
**********************************************************
earlycon: uart8250 at I/O port 0x3f8 (options '')
printk: legacy bootconsole [uart8250] enabled
Notice: NX (Execute Disable) protection cannot be enabled: non-PAE kernel!
APIC: Static calls initialized
SMBIOS 3.0.0 present.
DMI: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
DMI: Memory slots populated: 1/1
Hypervisor detected: KVM
kvm-clock: Using msrs 4b564d01 and 4b564d00
kvm-clock: using sched offset of 243836685 cycles
clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
tsc: Detected 4010.116 MHz processor
last_pfn = 0x1ffe0 max_arch_pfn = 0x100000
MTRR map: 4 entries (3 fixed + 1 variable; max 19), built from 8 variable MTRRs
x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
found SMP MP-table at [mem 0x000f5480-0x000f548f]
RAMDISK: [mem 0x1fabd000-0x1ffdffff]
ACPI: Early table checksum verification disabled
ACPI: RSDP 0x00000000000F52C0 000014 (v00 BOCHS )
ACPI: RSDT 0x000000001FFE228B 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACP 0x000000001FFE2083 0000F4 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: DSDT 0x000000001FFE0040 002043 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: FACS 0x000000001FFE0000 000040
ACPI: APIC 0x000000001FFE2177 000078 (v03 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: HPET 0x000000001FFE21EF 000038 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: MCFG 0x000000001FFE2227 00003C (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: WAET 0x000000001FFE2263 000028 (v01 BOCHS  BXPC     00000001 BXPC 00000001)
ACPI: Reserving FACP table memory at [mem 0x1ffe2083-0x1ffe2176]
ACPI: Reserving DSDT table memory at [mem 0x1ffe0040-0x1ffe2082]
ACPI: Reserving FACS table memory at [mem 0x1ffe0000-0x1ffe003f]
ACPI: Reserving APIC table memory at [mem 0x1ffe2177-0x1ffe21ee]
ACPI: Reserving HPET table memory at [mem 0x1ffe21ef-0x1ffe2226]
ACPI: Reserving MCFG table memory at [mem 0x1ffe2227-0x1ffe2262]
ACPI: Reserving WAET table memory at [mem 0x1ffe2263-0x1ffe228a]
0MB HIGHMEM available.
511MB LOWMEM available.
  mapped low ram: 0 - 1ffe0000
  low ram: 0 - 1ffe0000
Zone ranges:
  DMA      [mem 0x0000000000001000-0x0000000000ffffff]
  Normal   [mem 0x0000000001000000-0x000000001ffdffff]
  HighMem  empty
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000000001000-0x000000000009efff]
  node   0: [mem 0x0000000000100000-0x000000001ffdffff]
Initmem setup node 0 [mem 0x0000000000001000-0x000000001ffdffff]
On node 0, zone DMA: 1 pages in unavailable ranges
On node 0, zone DMA: 97 pages in unavailable ranges
ACPI: PM-Timer IO Port: 0x608
ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
ACPI: Using ACPI (MADT) for SMP configuration information
TSC deadline timer available
CPU topo: Max. logical packages:   1
CPU topo: Max. logical dies:       1
CPU topo: Max. dies per package:   1
CPU topo: Max. threads per core:   1
CPU topo: Num. cores per package:     1
CPU topo: Num. threads per package:   1
CPU topo: Allowing 1 present CPUs plus 0 hotplug CPUs
kvm-guest: APIC: eoi() replaced with kvm_guest_apic_eoi_write()
PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
PM: hibernation: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000effff]
PM: hibernation: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[mem 0x20000000-0xafffffff] available for PCI devices
Booting paravirtualized kernel on KVM
clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
setup_percpu: NR_CPUS:8 nr_cpumask_bits:1 nr_cpu_ids:1 nr_node_ids:1
percpu: Embedded 32 pages/cpu s101428 r0 d29644 u131072
Kernel command line: no_hash_pointers console=ttyS0 earlycon=uart8250,io,0x3f8
random: crng init done
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 130942
mem auto-init: stack:all(zero), heap alloc:off, heap free:off, mlocked free:off
Initializing HighMem for node 0 (00000000:00000000)
Checking if this processor honours the WP bit even in supervisor mode...Ok.
Memory: 490028K/523768K available (14430K kernel code, 2069K rwdata, 4928K rodata, 848K init, 556K bss, 33740K reserved, 0K cma-reserved, 0K highmem)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
trace event string verifier disabled
Dynamic Preempt: voluntary
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU event tracing is enabled.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
	Trampoline variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
rcu: srcu_init: Setting srcu_struct sizes based on contention.
Console: colour *CGA 80x25
printk: legacy console [ttyS0] enabled
printk: legacy console [ttyS0] enabled
printk: legacy bootconsole [uart8250] disabled
printk: legacy bootconsole [uart8250] disabled
ACPI: Core revision 20240322
APIC: Switch to symmetric I/O mode setup
clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x39cdb139b23, max_idle_ns: 440795315175 ns
Calibrating delay loop (skipped) preset value.. 8020.23 BogoMIPS (lpj=4010116)
x86/cpu: User Mode Instruction Prevention (UMIP) activated
Last level iTLB entries: 4KB 512, 2MB 255, 4MB 127
Last level dTLB entries: 4KB 512, 2MB 255, 4MB 127, 1GB 0
Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Spectre V2 : Mitigation: Retpolines
Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
Spectre V2 : Enabling Speculation Barrier for firmware calls
RETBleed: Vulnerable
Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
Speculative Return Stack Overflow: IBPB-extending microcode not applied!
Speculative Return Stack Overflow: WARNING: See https://kernel.org/doc/html/latest/admin-guide/hw-vuln/srso.html for mitigation options.
Speculative Return Stack Overflow: WARNING: kernel not compiled with MITIGATION_SRSO.
Speculative Return Stack Overflow: Vulnerable: No microcode
x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
Freeing SMP alternatives memory: 48K
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=capability,selinux
SELinux:  Initializing.
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
smpboot: CPU0: AMD Ryzen Threadripper 3970X 32-Core Processor (family: 0x17, model: 0x31, stepping: 0x0)
Performance Events: Fam17h+ core perfctr, AMD PMU driver.
... version:                0
... bit width:              48
... generic registers:      6
... value mask:             0000ffffffffffff
... max period:             00007fffffffffff
... fixed-purpose events:   0
... event mask:             000000000000003f
signal: max sigframe size: 1760
rcu: Hierarchical SRCU implementation.
rcu: 	Max phase no-delay instances is 400.
smp: Bringing up secondary CPUs ...
smp: Brought up 1 node, 1 CPU
smpboot: Total of 1 processors activated (8020.23 BogoMIPS)
devtmpfs: initialized
clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
futex hash table entries: 256 (order: 1, 8192 bytes, linear)
PM: RTC time: 08:11:04, date: 2024-06-12
NET: Registered PF_NETLINK/PF_ROUTE protocol family
audit: initializing netlink subsys (disabled)
thermal_sys: Registered thermal governor 'step_wise'
thermal_sys: Registered thermal governor 'user_space'
audit: type=2000 audit(1718179864.319:1): state=initialized audit_enabled=0 res=1
cpuidle: using governor menu
PCI: ECAM [mem 0xb0000000-0xbfffffff] (base 0xb0000000) for domain 0000 [bus 00-ff]
PCI: ECAM [mem 0xb0000000-0xbfffffff] reserved as E820 entry
PCI: Using ECAM for extended config space
PCI: Using configuration type 1 for base access
kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
HugeTLB: registered 4.00 MiB page size, pre-allocated 0 pages
HugeTLB: 0 KiB vmemmap can be freed for a 4.00 MiB page
ACPI: Added _OSI(Module Device)
ACPI: Added _OSI(Processor Device)
ACPI: Added _OSI(3.0 _SCP Extensions)
ACPI: Added _OSI(Processor Aggregator Device)
ACPI: 1 ACPI AML tables successfully acquired and loaded
ACPI: _OSC evaluation for CPUs failed, trying _PDC
ACPI: Interpreter enabled
ACPI: PM: (supports S0 S3 S4 S5)
ACPI: Using IOAPIC for interrupt routing
PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
PCI: Using E820 reservations for host bridge windows
ACPI: Enabled 2 GPEs in block 00 to 3F
ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
acpi PNP0A08:00: _OSC: platform does not support [LTR]
acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability]
acpi resource window ([0x100000000-0x8ffffffff] ignored, not CPU addressable)
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: root bus resource [mem 0x20000000-0xafffffff window]
pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
pci_bus 0000:00: root bus resource [bus 00-ff]
pci 0000:00:00.0: [8086:29c0] type 00 class 0x060000 conventional PCI endpoint
pci 0000:00:1f.0: [8086:2918] type 00 class 0x060100 conventional PCI endpoint
pci 0000:00:1f.0: quirk: [io  0x0600-0x067f] claimed by ICH6 ACPI/GPIO/TCO
pci 0000:00:1f.2: [8086:2922] type 00 class 0x010601 conventional PCI endpoint
pci 0000:00:1f.2: BAR 4 [io  0xc040-0xc05f]
pci 0000:00:1f.2: BAR 5 [mem 0xfebff000-0xfebfffff]
pci 0000:00:1f.3: [8086:2930] type 00 class 0x0c0500 conventional PCI endpoint
pci 0000:00:1f.3: BAR 4 [io  0x0700-0x073f]
ACPI: PCI: Interrupt link LNKA configured for IRQ 10
ACPI: PCI: Interrupt link LNKB configured for IRQ 10
ACPI: PCI: Interrupt link LNKC configured for IRQ 11
ACPI: PCI: Interrupt link LNKD configured for IRQ 11
ACPI: PCI: Interrupt link LNKE configured for IRQ 10
ACPI: PCI: Interrupt link LNKF configured for IRQ 10
ACPI: PCI: Interrupt link LNKG configured for IRQ 11
ACPI: PCI: Interrupt link LNKH configured for IRQ 11
ACPI: PCI: Interrupt link GSIA configured for IRQ 16
ACPI: PCI: Interrupt link GSIB configured for IRQ 17
ACPI: PCI: Interrupt link GSIC configured for IRQ 18
ACPI: PCI: Interrupt link GSID configured for IRQ 19
ACPI: PCI: Interrupt link GSIE configured for IRQ 20
ACPI: PCI: Interrupt link GSIF configured for IRQ 21
ACPI: PCI: Interrupt link GSIG configured for IRQ 22
ACPI: PCI: Interrupt link GSIH configured for IRQ 23
iommu: Default domain type: Translated
iommu: DMA domain TLB invalidation policy: lazy mode
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
Advanced Linux Sound Architecture Driver Initialized.
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
PCI: Using ACPI for IRQ routing
vgaarb: loaded
clocksource: Switched to clocksource kvm-clock
VFS: Disk quotas dquot_6.6.0
VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
pnp: PnP ACPI init
system 00:04: [mem 0xb0000000-0xbfffffff window] has been reserved
pnp: PnP ACPI: found 5 devices
clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
NET: Registered PF_INET protocol family
IP idents hash table entries: 8192 (order: 4, 65536 bytes, linear)
tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes, linear)
Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
TCP bind hash table entries: 4096 (order: 4, 65536 bytes, linear)
TCP: Hash tables configured (established 4096 bind 4096)
UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
UDP-Lite hash table entries: 256 (order: 1, 8192 bytes, linear)
NET: Registered PF_UNIX/PF_LOCAL protocol family
RPC: Registered named UNIX socket transport module.
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp-with-tls transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
pci_bus 0000:00: resource 7 [mem 0x20000000-0xafffffff window]
pci_bus 0000:00: resource 8 [mem 0xc0000000-0xfebfffff window]
PCI: CLS 0 bytes, default 64
Unpacking initramfs...
clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x39cdb139b23, max_idle_ns: 440795315175 ns
Initialise system trusted keyrings
workingset: timestamp_bits=30 max_order=17 bucket_order=0
Freeing initrd memory: 5260K
NFS: Registering the id_resolver key type
Key type id_resolver registered
Key type id_legacy registered
9p: Installing v9fs 9p2000 file system support
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
io scheduler mq-deadline registered
io scheduler kyber registered
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: button: Power Button [PWRF]
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
hpet_acpi_add: no address or irqs in _CRS
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
ACPI: bus type drm_connector registered
loop: module loaded
ACPI: \_SB_.GSIA: Enabled at IRQ 16
ahci 0000:00:1f.2: AHCI vers 0001.0000, 32 command slots, 1.5 Gbps, SATA mode
ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
ahci 0000:00:1f.2: flags: 64bit ncq only 
scsi host0: ahci
scsi host1: ahci
scsi host2: ahci
scsi host3: ahci
scsi host4: ahci
scsi host5: ahci
ata1: SATA max UDMA/133 abar m4096@0xfebff000 port 0xfebff100 irq 24 lpm-pol 0
ata2: SATA max UDMA/133 abar m4096@0xfebff000 port 0xfebff180 irq 24 lpm-pol 0
ata3: SATA max UDMA/133 abar m4096@0xfebff000 port 0xfebff200 irq 24 lpm-pol 0
ata4: SATA max UDMA/133 abar m4096@0xfebff000 port 0xfebff280 irq 24 lpm-pol 0
ata5: SATA max UDMA/133 abar m4096@0xfebff000 port 0xfebff300 irq 24 lpm-pol 0
ata6: SATA max UDMA/133 abar m4096@0xfebff000 port 0xfebff380 irq 24 lpm-pol 0
e100: Intel(R) PRO/100 Network Driver
e100: Copyright(c) 1999-2006 Intel Corporation
e1000: Intel(R) PRO/1000 Network Driver
e1000: Copyright (c) 1999-2006 Intel Corporation.
e1000e: Intel(R) PRO/1000 Network Driver
e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
sky2: driver version 1.30
usbcore: registered new interface driver usblp
usbcore: registered new interface driver usb-storage
i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
rtc_cmos 00:03: RTC can wake from S4
rtc_cmos 00:03: registered as rtc0
rtc_cmos 00:03: alarms up to one day, y3k, 242 bytes nvram
i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
i2c i2c-0: Memory type 0x07 not supported yet, not instantiating SPD
amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled
hid: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
Initializing XFRM netlink socket
NET: Registered PF_INET6 protocol family
Segment Routing with IPv6
In-situ OAM (IOAM) with IPv6
sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
NET: Registered PF_PACKET protocol family
9pnet: Installing 9P2000 support
Key type dns_resolver registered
IPI shorthand broadcast: enabled
registered taskstats version 1
Loading compiled-in X.509 certificates
PM:   Magic number: 12:364:169
printk: legacy console [netcon0] enabled
netconsole: network logging started
cfg80211: Loading compiled-in X.509 certificates for regulatory database
------------[ cut here ]------------
Bad FPU state detected at restore_fpregs_from_fpstate+0x38/0x6c, reinitializing FPU registers.
WARNING: CPU: 0 PID: 60 at arch/x86/mm/extable.c:127 fixup_exception+0x41e/0x45c
Modules linked in:
CPU: 0 PID: 60 Comm: modprobe Not tainted 6.10.0-rc2-00003-g4f4a9b399357-dirty #39
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
EIP: fixup_exception+0x41e/0x45c
Code: e8 cb c0 00 00 0f 0b eb cb 0f 0b ba 4c e9 ff cb eb b6 b2 01 88 15 16 bf ec cb 89 44 24 04 c7 04 24 b8 3a bb cb e8 a6 c0 00 00 <0f> 0b e9 ee fd ff ff 8d b4 26 00 00 00 00 0f 0b ba 4c e9 ff cb e9
EAX: 0000005e EBX: cbce53f0 ECX: 00000000 EDX: cbdd606c
ESI: c1ce5ef0 EDI: 0000000d EBP: c1ce5e58 ESP: c1ce5dd8
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010086
CR0: 80050033 CR2: bff85b6b CR3: 01840000 CR4: 00350ed0
Call Trace:
 ? show_regs+0x4d/0x54
 ? fixup_exception+0x41e/0x45c
 ? __warn+0x84/0x150
 ? fixup_exception+0x41e/0x45c
 ? fixup_exception+0x41e/0x45c
 ? report_bug+0x186/0x1b0
 ? exc_overflow+0x50/0x50
 ? handle_bug+0x2d/0x50
 ? exc_invalid_op+0x1b/0x70
 ? console_unlock+0x53/0xc4
 ? handle_exception+0x14b/0x14b
 ? exc_overflow+0x50/0x50
 ? fixup_exception+0x41e/0x45c
 ? exc_overflow+0x50/0x50
 ? fixup_exception+0x41e/0x45c
 ? restore_fpregs_from_fpstate+0x38/0x6c
 ? _get_random_bytes+0x65/0x190
 ? mt_find+0xd1/0x458
 ? exc_bounds+0xac/0xac
 exc_general_protection+0x97/0x358
 ? randomize_page+0x37/0x54
 ? exc_bounds+0xac/0xac
 handle_exception+0x14b/0x14b
EIP: restore_fpregs_from_fpstate+0x38/0x6c
Code: 7d fc 89 ca eb 09 cc cc cc db e2 0f 77 db 03 3e 8d 74 26 00 8b 3d ec 31 c6 cb 8b 0d e8 31 c6 cb 21 fa 8d 7b 40 21 c8 0f c7 1f <8b> 5d f8 8b 7d fc 89 ec 5d c3 66 90 3e 8d 74 26 00 0f ae 4b 40 8b
EAX: 00000007 EBX: c1ccdc60 ECX: 00000007 EDX: 00000000
ESI: c1ccdc20 EDI: c1ccdca0 EBP: c1ce5f54 ESP: c1ce5f4c
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
 ? exc_bounds+0xac/0xac
 ? exc_bounds+0xac/0xac
 ? restore_fpregs_from_fpstate+0x35/0x6c
 switch_fpu_return+0x49/0xd0
 syscall_exit_to_user_mode+0x181/0x1a8
 ? call_usermodehelper_exec_async+0xbe/0x1ac
 ? call_usermodehelper+0x8c/0x8c
 ret_from_fork+0x23/0x44
 ? call_usermodehelper+0x8c/0x8c
 ret_from_fork_asm+0x12/0x18
 entry_INT80_32+0x108/0x108
EIP: 0xb7f3b087
Code: Unable to access opcode bytes at 0xb7f3b05d.
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 ESP: bff85a70
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 007b EFLAGS: 00000200
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 60 at arch/x86/kernel/fpu/xstate.h:195 save_fpregs_to_fpstate+0x98/0xa4
Modules linked in:
CPU: 0 PID: 60 Comm: modprobe Tainted: G        W          6.10.0-rc2-00003-g4f4a9b399357-dirty #39
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
EIP: save_fpregs_to_fpstate+0x98/0xa4
Code: 2e 8d b4 26 00 00 00 00 66 90 8b 40 08 dd 70 40 9b 8b 43 08 dd 60 40 8b 5d f8 8b 7d fc 89 ec 5d c3 2e 8d b4 26 00 00 00 00 90 <0f> 0b eb 96 8d 74 26 00 0f 0b eb 82 55 89 e5 83 ec 0c 89 5d fc 89
EAX: 00000007 EBX: c1ccdc20 ECX: c1ccdc60 EDX: 00000000
ESI: c1ccd400 EDI: fffffff2 EBP: c10efb2c ESP: c10efb24
DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010082
CR0: 80050033 CR2: b7f3b05d CR3: 01840000 CR4: 00350ed0
Call Trace:
---[ end trace 0000000000000000 ]---
modprobe (60) used greatest stack depth: 5836 bytes left
Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
cfg80211: failed to load regulatory.db
Unstable clock detected, switching default tracing clock to "global"
If you want to keep using the local clock, then add:
  "trace_clock=local"
on the kernel command line
ALSA device list:
  No soundcards found.
ata6: SATA link down (SStatus 0 SControl 300)
ata4: SATA link down (SStatus 0 SControl 300)
ata2: SATA link down (SStatus 0 SControl 300)
ata1: SATA link down (SStatus 0 SControl 300)
ata3: SATA link down (SStatus 0 SControl 300)
ata5: SATA link down (SStatus 0 SControl 300)
Freeing unused kernel image (initmem) memory: 848K
Write protecting kernel text and read-only data: 19360k
Run /init as init process
init[1] bad frame in 32bit sigreturn frame:bfb9d86c ip:b7ee4517 sp:bfb9df20 orax:ffffffff in libuClibc-1.0.42.so[18517,b7edf000+52000]
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
CPU: 0 PID: 1 Comm: init Tainted: G        W          6.10.0-rc2-00003-g4f4a9b399357-dirty #39
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 dump_stack_lvl+0x21/0x60
 dump_stack+0x12/0x18
 panic+0x2ab/0x2d0
 do_exit+0x885/0x9e0
 ? __switch_to_asm+0xdd/0xf0
 do_group_exit+0x24/0x74
 get_signal+0xa1f/0xa20
 ? __switch_to_asm+0x53/0xf0
 ? __switch_to_asm+0x4d/0xf0
 ? finish_task_switch.isra.0+0x79/0x254
 ? __switch_to_asm+0x41/0xf0
 arch_do_signal_or_restart+0x30/0x1f0
 syscall_exit_to_user_mode+0xbf/0x1a8
 do_int80_syscall_32+0x8d/0x14c
 entry_INT80_32+0x108/0x108
EIP: 0xb7ee4517
Code: c8 ff c3 56 53 8b 44 24 0c e8 39 ce ff ff 81 c3 59 67 08 00 8b 4c 24 10 8b 54 24 14 8b 74 24 18 53 89 c3 b8 72 00 00 00 cd 80 <5b> 3d 00 f0 ff ff 76 0e 8b 93 dc 02 00 00 f7 d8 65 89 02 83 c8 ff
EAX: 00000000 EBX: ffffffff ECX: bfb9df88 EDX: 00000000
ESI: 00000000 EDI: 00529a4c EBP: 00000001 ESP: bfb9df20
DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
Kernel Offset: disabled
---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
/home/mingo/qemu/i386/run-image-i386.sh: line 15: 2538063 Killed                  qemu-system-i386 -display none -nodefaults -M q35 -d unimp,guest_errors -append 'console=ttyS0 earlycon=uart8250,io,0x3f8' -kernel arch/x86/boot/bzImage -initrd $DIR/x86-rootfs.cpio -cpu host -enable-kvm -m 512m -smp 1 -serial mon:stdio

--H29q6/41zZ4M0tch--

