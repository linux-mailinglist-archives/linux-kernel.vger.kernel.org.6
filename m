Return-Path: <linux-kernel+bounces-297367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB6F95B6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 15:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970A4285DA4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725B91CB30C;
	Thu, 22 Aug 2024 13:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="vvZmI5sD"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7931CB15A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724333857; cv=none; b=ZSzjoDthZWYHH8XxGb1F1Amtp4/2G0lzCPTXuMNaIfP2iuIA3K2yormx7/VUdDSQoxGsziQ8xafpFGMg9QEOw3EwTvkgEdQ8wikiV0p2trLZcFcFbXKgIRmz2pKlMe6oAQId/49iBtCBZ9rFIquu9n9JjbCF8hUzfwlv28FABds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724333857; c=relaxed/simple;
	bh=v1rSeR8i+sWTwBuxHCVloyGguMhC6uu8Pc9d8Vnn258=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjov5dT05cah+mbneGl3ZlXGlwejlBrxyuwTEL6DYiw6NFsPVo4nEHNJw07huVLDY+r60zLFWtKaGPghoSK/5xj3l60h7YUkZOPSux/w9FBsBY7ULMRQF0PG+uQ8y706w1T1t76nqUmkfo0QLJCeH0C7Zj5tltVj7lChRI2lUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=vvZmI5sD; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fe9cf83c7so4645501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1724333850; x=1724938650; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rswM7QGAHtp0ghFKUTXDUkfXVNYViqJAOnezLxFhV0=;
        b=vvZmI5sD/GFonC70F2Fw/iDW86AHxxHrRSZP5MIWS6pOL/HBVFn1uB9kEEKLy1q7N1
         1KY1Oe44u/4L0IanI6+UX068GGbou8KcvHi1efd9oHIDOBw4IGxHhtVVaHLV7DwJvo7Y
         xzqNYJOVEkNhEg9M1UX+PhrAMxpzHER1cCPwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724333850; x=1724938650;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rswM7QGAHtp0ghFKUTXDUkfXVNYViqJAOnezLxFhV0=;
        b=UEzHullv1JkdFA//BqPnMz9dunSOu2N06lUIiUfjfAe/Rsb3j8WDqS6PixFYiHUD5o
         JXZWg0u1A2dwfoA/ct+eZoWy7Hgw3WPus2Jia+5C67mImgXoH46E5ORD8JuVaBVjuDmH
         OKqoG4tUDeQYyMi5JS+1ikssSwZW3c6SHizeSZ43Aku2FXTSU2QKRw/JLc+DVU54x4lx
         fDj/kjuQrJk/OEDsp6MWJ7lmqICok2fxIjtgesWsX1Yxvarc6nxcamo7THUTGHzyRpmm
         agcXWC1JSN3qxcSORm60kYVJg1AUNUSWtPtUd72eIKWmxEdQlcJ7FJYnGtguKWl0YYey
         iGWw==
X-Forwarded-Encrypted: i=1; AJvYcCWPiGiUQcNvJMI2JvyAKW48Q/CoirS9z6cjlfJ+hIFOhtSNYEqCvo58ipkbTHvnn3Rz72ggVXK5vKBeNc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+HMjqAo5rGzYLkZWGxx57MgWE76BIWqGLakzafMqnw/LvJcQ
	5s4PAPqWY+/YBO1TPDhRsTJRVF4tktOCuiC7iJrv9xAQYlnv/csvkOR7i5BstHw=
X-Google-Smtp-Source: AGHT+IHIlIw8La6k2o1y+Bzyy38u4yu5X4WaSdCNBB2djrs44lbCyI0aVDv3xqVnLA4AlVZ99dgbDA==
X-Received: by 2002:a05:622a:5c8f:b0:44f:e12e:300a with SMTP id d75a77b69052e-454ff78fe6fmr20475971cf.12.1724333848554;
        Thu, 22 Aug 2024 06:37:28 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe196a57sm6783391cf.70.2024.08.22.06.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:37:26 -0700 (PDT)
Date: Thu, 22 Aug 2024 13:37:26 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, tj@kernel.org, void@manifault.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] sched: Prepare for sched_ext
Message-ID: <20240822133726.GA1397288@google.com>
References: <20240813222548.049744955@infradead.org>
 <CAJWu+oqUSOUrro-Rk-Bg7P6PyCWGKRZVT5i4Bi36XpRRFumL5w@mail.gmail.com>
 <CAJWu+opjcGs8vs9=NcgSU_nuWZE+z73rMaOO7s7OX_=AHvSOiQ@mail.gmail.com>
 <CAJWu+opPO18zgQZPDqPkALXqU4Tn=ohPPDM=jmdpL=z1J=PJhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJWu+opPO18zgQZPDqPkALXqU4Tn=ohPPDM=jmdpL=z1J=PJhA@mail.gmail.com>

On Thu, Aug 22, 2024 at 09:15:36AM -0400, Joel Fernandes wrote:
> On Thu, Aug 22, 2024 at 8:58 AM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Wed, Aug 21, 2024 at 5:41 PM Joel Fernandes <joelaf@google.com> wrote:
> > >
> > > On Tue, Aug 13, 2024 at 6:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > These patches apply on top of the EEVDF series (queue/sched/core), which
> > > > re-arranges the fair pick_task() functions to make them state invariant such
> > > > that they can easily be restarted upon picking (and dequeueing) a delayed task.
> > > >
> > > > This same is required to push (the final) put_prev_task() beyond pick_task(),
> > > > like we do for sched_core already.
> > > >
> > > > This in turn is done to prepare for sched_ext, which wants a final callback to
> > > > be in possesion of the next task, such that it can tell if the context switch
> > > > will leave the sched_class.
> > > >
> > > > As such, this all re-arranges the current order of:
> > > >
> > > >   put_prev_task(rq, prev);
> > > >   next = pick_next_task(rq); /* implies set_next_task(.first=true); */
> > > >
> > > > to sometihng like:
> > > >
> > > >   next = pick_task(rq)
> > > >   if (next != prev) {
> > > >     put_prev_task(rq, prev, next);
> > > >     set_next_task(rq, next, true);
> > > >   }
> > > >
> > > > The patches do a fair bit of cleaning up. Notably a bunch of sched_core stuff
> > > > -- Joel, could you please test this stuff, because the self-tests we have are
> > > > hardly adequate.
> > > >
> > > > The EEVDF stuff was supposed to be merged already, but since Valentin seems to
> > > > be doing a read-through, I figured I'd give him a little extra time. A complete
> > > > set can be found at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/prep
> > > >
> > >
> > > So I booted queue.git sched/core branch on a newish Chromebook (after
> > > applying 700 patches for making it boot and spending 2 days on it
> > > since we boot old kernels -- I wasn't joking when I said I would carve
> > > some time up for you this week :P).
> > >
> > > With sched/core , it boots fine with core scheduling disabled, but
> > > when core scheduling is enabled I am getting hard hangs and
> > > occasionally get to the login screen if I'm lucky. So there's
> > > definitely something wonky in sched/core branch and core sched.
> > > I could not get a trace or logs yet, since once it hangs I have to
> > > hard power off.
> > >
> > > I could bissect it tomorrow though since it looks like a manageable
> > > set of patches on 6.11-rc1.  Or did you already figure out the issue?
> > >
> > > I am based on:
> > > commit aef6987d89544d63a47753cf3741cabff0b5574c
> > > Author: Peter Zijlstra <peterz@infradead.org>
> > > Date:   Thu Jun 20 13:16:49 2024 +0200
> > >
> > >     sched/eevdf: Propagate min_slice up the cgroup hierarchy
> >
> > One of these 29 in sched/core broke core-scheduling, causes hangs.
> > Haven't narrowed it down to which. Not much time today. Will probably
> > try to collect some logs.
> > https://hastebin.com/share/uqubojiqiy.yaml
> >
> > Also I realized I should apply the 9 in this set too. But very least
> > it appears the above 29 broke core-sched vs bissection, probably the
> > delayed-dequeue or task-pick rework?
> >
> > I will try the sched/prep branch now, which has the 9 in this set too..
> 
> Same issue with sched/prep which has these 9. Looks like it hung on rq
> lock Picked up a dmesg this time:
> 
> [   13.856485] Hardware name: Google XXXXXX
> [   13.856487] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
> 
> [   13.856496] RSP: 0018:ffff91d90253b9b8 EFLAGS: 00000046
[...]
> [   13.856508] PKRU: 55555554
> [   13.856508] Call Trace:
> [   13.856512]  <NMI>
> [   13.856516]  ? nmi_cpu_backtrace+0x101/0x130
> [   13.856521]  ? nmi_cpu_backtrace_handler+0x11/0x20
> [   13.856524]  ? nmi_handle+0x59/0x160
> [   13.856526]  ? queued_spin_lock_slowpath+0x140/0x260
> [   13.856528]  ? default_do_nmi+0x46/0x110
> [   13.856530]  ? exc_nmi+0xb1/0x110
> [   13.856532]  ? end_repeat_nmi+0xf/0x53
> [   13.856534]  ? queued_spin_lock_slowpath+0x140/0x260
> [   13.856535]  ? queued_spin_lock_slowpath+0x140/0x260
> [   13.856537]  ? queued_spin_lock_slowpath+0x140/0x260
> [   13.856538]  </NMI>
> [   13.856539]  <TASK>
> [   13.856540]  raw_spin_rq_lock_nested+0x4c/0x80
> [   13.856543]  sched_balance_rq+0x15ff/0x1860
> [   13.856548]  sched_balance_newidle+0x193/0x390
> [   13.856550]  balance_fair+0x25/0x40
> [   13.856553]  __schedule+0x899/0x1110
> [   13.856555]  ? timerqueue_add+0x86/0xa0
> [   13.856558]  ? hrtimer_start_range_ns+0x225/0x2f0
> [   13.856560]  schedule+0x5e/0x90
> [   13.856562]  schedule_hrtimeout_range_clock+0xc2/0x130
> [   13.856564]  ? __pfx_hrtimer_wakeup+0x10/0x10
> [   13.856566]  do_epoll_wait+0x627/0x6b0
> [   13.856571]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
> [   13.856574]  __x64_sys_epoll_wait+0x50/0x80
> [   13.856577]  do_syscall_64+0x6a/0xe0
> [   13.856580]  ? clear_bhb_loop+0x45/0xa0

Here is the full dmesg, I have to switch gears to something else now and did
not see anything obvious causing this, but hopefully this helps. Happy to
bissect it down at a later time as well.

[    0.000000] Linux version 6.11.0-rc1-gf98706d6143f (cros-kernel@chromium.org) (Chromium OS 18.0_pre510928-r39 clang version 18.0.0 (/mnt/host/source/src/third_party/llvm-project 82e851a407c52d65ce65e7aa58453127e67d42a0), LLD 18.0.0) #1 SMP PREEMPT_DYNAMIC Thu, 22 Aug 2024 13:04:28 +0000
[    0.000000] Command line: cros_secure console= loglevel=7 init=/sbin/init cros_secure drm.trace=0x106 root=PARTUUID=22150a52-b7d1-7848-a7e2-747ea0d77e09/PARTNROFF=1 rootwait ro dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none ro 1,0 6963200 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6963200 alg=sha256 root_hexdigest=1c6bc9438536d678b00aca2e520fccf2dd95a2eaf21d97d0c4c9200054759421 salt=13de743b9ddd627880edee57ad1774f2ea877c66bb701fe1b400ecc8118e7669" noinitrd cros_debug vt.global_cursor_default=0 kern_guid=22150a52-b7d1-7848-a7e2-747ea0d77e09 cros_lsb_release_hash=s5GKpcK6uecZpC6FDefrOf3WONO4+PfU/qPF4n1BctQ= add_efi_memmap noresume i915.modeset=1 ramoops.ecc=1 tpm_tis.force=0 intel_pmc_core.warn_on_s0ix_failures=1 i915.enable_guc=3 i915.enable_dc=4 xdomain=0 swiotlb=65536 intel_iommu=on i915.enable_psr=1
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000] x86/tme: enabled by BIOS
[    0.000000] x86/mktme: BIOS enabled: x86_phys_bits reduced by 4
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007686efff] usable
[    0.000000] BIOS-e820: [mem 0x000000007686f000-0x00000000803fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000f9ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fb000000-0x00000000fb000fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe00ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed87fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed90000-0x00000000fed92fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feda0000-0x00000000feda1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fedc0000-0x00000000feddffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000027fbfffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] SMBIOS 3.0 present.
[    0.000000] DMI: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[    0.000000] DMI: Memory slots populated: 8/8
[    0.000000] tsc: Detected 2100.000 MHz processor
[    0.000000] tsc: Detected 2112.000 MHz TSC
[    0.000012] last_pfn = 0x27fc00 max_arch_pfn = 0x400000000
[    0.000015] MTRR map: 8 entries (3 fixed + 5 variable; max 23), built from 10 variable MTRRs
[    0.000017] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000285] last_pfn = 0x7686f max_arch_pfn = 0x400000000
[    0.004588] Using GB pages for direct mapping
[    0.004589] Incomplete global flushes, disabling PCID
[    0.004690] ACPI: Early table checksum verification disabled
[    0.004693] ACPI: RSDP 0x00000000000F0000 000024 (v02 COREv4)
[    0.004696] ACPI: XSDT 0x00000000768800E0 000064 (v01 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004701] ACPI: FACP 0x0000000076885440 000114 (v06 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004705] ACPI: DSDT 0x0000000076880280 0051B3 (v02 COREv4 COREBOOT 20110725 INTL 20210331)
[    0.004707] ACPI: FACS 0x0000000076880240 000040
[    0.004708] ACPI: FACS 0x0000000076880240 000040
[    0.004710] ACPI: SSDT 0x0000000076885560 0062FB (v02 COREv4 COREBOOT 0000002A CORE 20210331)
[    0.004712] ACPI: MCFG 0x000000007688B860 00003C (v01 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004713] ACPI: TPM2 0x000000007688B8A0 00004C (v04 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004715] ACPI: APIC 0x000000007688B8F0 0000D2 (v03 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004717] ACPI: DMAR 0x000000007688B9D0 0000A0 (v01 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004718] ACPI: DBG2 0x000000007688BA70 000054 (v00 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004720] ACPI: HPET 0x000000007688BAD0 000038 (v01 COREv4 COREBOOT 00000000 CORE 20210331)
[    0.004721] ACPI: Reserving FACP table memory at [mem 0x76885440-0x76885553]
[    0.004723] ACPI: Reserving DSDT table memory at [mem 0x76880280-0x76885432]
[    0.004723] ACPI: Reserving FACS table memory at [mem 0x76880240-0x7688027f]
[    0.004724] ACPI: Reserving FACS table memory at [mem 0x76880240-0x7688027f]
[    0.004724] ACPI: Reserving SSDT table memory at [mem 0x76885560-0x7688b85a]
[    0.004725] ACPI: Reserving MCFG table memory at [mem 0x7688b860-0x7688b89b]
[    0.004725] ACPI: Reserving TPM2 table memory at [mem 0x7688b8a0-0x7688b8eb]
[    0.004726] ACPI: Reserving APIC table memory at [mem 0x7688b8f0-0x7688b9c1]
[    0.004726] ACPI: Reserving DMAR table memory at [mem 0x7688b9d0-0x7688ba6f]
[    0.004727] ACPI: Reserving DBG2 table memory at [mem 0x7688ba70-0x7688bac3]
[    0.004727] ACPI: Reserving HPET table memory at [mem 0x7688bad0-0x7688bb07]
[    0.004779] Zone ranges:
[    0.004780]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.004782]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.004783]   Normal   [mem 0x0000000100000000-0x000000027fbfffff]
[    0.004784] Movable zone start for each node
[    0.004785] Early memory node ranges
[    0.004785]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.004786]   node   0: [mem 0x0000000000100000-0x000000007686efff]
[    0.004787]   node   0: [mem 0x0000000100000000-0x000000027fbfffff]
[    0.004788] Initmem setup node 0 [mem 0x0000000000001000-0x000000027fbfffff]
[    0.004792] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.004815] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.020948] On node 0, zone Normal: 6033 pages in unavailable ranges
[    0.020963] On node 0, zone Normal: 1024 pages in unavailable ranges
[    0.021017] Reserving Intel graphics memory at [mem 0x7c800000-0x803fffff]
[    0.021647] ACPI: PM-Timer IO Port: 0x1808
[    0.021657] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.021778] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.021780] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.021782] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.021785] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.021786] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.021790] TSC deadline timer available
[    0.021793] CPU topo: Max. logical packages:   1
[    0.021794] CPU topo: Max. logical dies:       1
[    0.021794] CPU topo: Max. dies per package:   1
[    0.021797] CPU topo: Max. threads per core:   2
[    0.021798] CPU topo: Num. cores per package:    12
[    0.021799] CPU topo: Num. threads per package:  16
[    0.021800] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.021808] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.021809] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.021810] PM: hibernation: Registered nosave memory: [mem 0x7686f000-0x803fffff]
[    0.021811] PM: hibernation: Registered nosave memory: [mem 0x80400000-0xbfffffff]
[    0.021811] PM: hibernation: Registered nosave memory: [mem 0xc0000000-0xcfffffff]
[    0.021812] PM: hibernation: Registered nosave memory: [mem 0xd0000000-0xf7ffffff]
[    0.021812] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xf9ffffff]
[    0.021813] PM: hibernation: Registered nosave memory: [mem 0xfa000000-0xfaffffff]
[    0.021813] PM: hibernation: Registered nosave memory: [mem 0xfb000000-0xfb000fff]
[    0.021813] PM: hibernation: Registered nosave memory: [mem 0xfb001000-0xfdffffff]
[    0.021814] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe00ffff]
[    0.021814] PM: hibernation: Registered nosave memory: [mem 0xfe010000-0xfed7ffff]
[    0.021815] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed87fff]
[    0.021815] PM: hibernation: Registered nosave memory: [mem 0xfed88000-0xfed8ffff]
[    0.021815] PM: hibernation: Registered nosave memory: [mem 0xfed90000-0xfed92fff]
[    0.021816] PM: hibernation: Registered nosave memory: [mem 0xfed93000-0xfed9ffff]
[    0.021816] PM: hibernation: Registered nosave memory: [mem 0xfeda0000-0xfeda1fff]
[    0.021817] PM: hibernation: Registered nosave memory: [mem 0xfeda2000-0xfedbffff]
[    0.021817] PM: hibernation: Registered nosave memory: [mem 0xfedc0000-0xfeddffff]
[    0.021817] PM: hibernation: Registered nosave memory: [mem 0xfede0000-0xffffffff]
[    0.021819] [mem 0x80400000-0xbfffffff] available for PCI devices
[    0.021823] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.026699] setup_percpu: NR_CPUS:24 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.027280] percpu: Embedded 57 pages/cpu s196376 r8192 d28904 u262144
[    0.027297] Kernel command line: cros_secure console= loglevel=7 init=/sbin/init cros_secure drm.trace=0x106 root=PARTUUID=22150a52-b7d1-7848-a7e2-747ea0d77e09/PARTNROFF=1 rootwait ro dm_verity.error_behavior=3 dm_verity.max_bios=-1 dm_verity.dev_wait=0 dm="1 vroot none ro 1,0 6963200 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6963200 alg=sha256 root_hexdigest=1c6bc9438536d678b00aca2e520fccf2dd95a2eaf21d97d0c4c9200054759421 salt=13de743b9ddd627880edee57ad1774f2ea877c66bb701fe1b400ecc8118e7669" noinitrd cros_debug vt.global_cursor_default=0 kern_guid=22150a52-b7d1-7848-a7e2-747ea0d77e09 cros_lsb_release_hash=s5GKpcK6uecZpC6FDefrOf3WONO4+PfU/qPF4n1BctQ= add_efi_memmap noresume i915.modeset=1 ramoops.ecc=1 tpm_tis.force=0 intel_pmc_core.warn_on_s0ix_failures=1 i915.enable_guc=3 i915.enable_dc=4 xdomain=0 swiotlb=65536 intel_iommu=on i915.enable_psr=1
[    0.027438] Setting dangerous option i915.enable_guc - tainting kernel
[    0.027442] Setting dangerous option i915.enable_dc - tainting kernel
[    0.027461] DMAR: IOMMU enabled
[    0.027465] Setting dangerous option i915.enable_psr - tainting kernel
[    0.027467] Unknown kernel command line parameters "cros_secure cros_debug dm=1 vroot none ro 1,0 6963200 verity payload=ROOT_DEV hashtree=HASH_DEV hashstart=6963200 alg=sha256 root_hexdigest=1c6bc9438536d678b00aca2e520fccf2dd95a2eaf21d97d0c4c9200054759421 salt=13de743b9ddd627880edee57ad1774f2ea877c66bb701fe1b400ecc8118e7669 cros_lsb_release_hash=s5GKpcK6uecZpC6FDefrOf3WONO4+PfU/qPF4n1BctQ= xdomain=0", will be passed to user space.
[    0.027480] random: crng init done
[    0.028468] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    0.028919] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.029033] Built 1 zonelists, mobility grouping on.  Total pages: 2057230
[    0.029333] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.029342] software IO TLB: area num 16.
[    0.073418] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.073453] ftrace: allocating 60832 entries in 238 pages
[    0.073609] ftrace: allocated 238 pages with 6 groups
[    0.073662] Dynamic Preempt: full
[    0.073713] rcu: Preemptible hierarchical RCU implementation.
[    0.073713] rcu: 	RCU restricting CPUs from NR_CPUS=24 to nr_cpu_ids=16.
[    0.073714] 	Trampoline variant of Tasks RCU enabled.
[    0.073715] 	Rude variant of Tasks RCU enabled.
[    0.073715] 	Tracing variant of Tasks RCU enabled.
[    0.073716] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.073716] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.073727] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.073729] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.073730] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.075644] NR_IRQS: 4352, nr_irqs: 2184, preallocated irqs: 16
[    0.076080] rcu: 	Offload RCU callbacks from CPUs: 0-15.
[    0.076082] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.076672] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.076864] ACPI: Core revision 20240322
[    0.076904] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.076904] APIC: Switch to symmetric I/O mode setup
[    0.076906] DMAR: Host address width 46
[    0.076907] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.076910] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 9c0000c40660462 ecap 29a08f0505e
[    0.076912] DMAR: DRHD base: 0x000000fed92000 flags: 0x0
[    0.076915] DMAR: dmar1: reg_base_addr fed92000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.076916] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.076919] DMAR: dmar2: reg_base_addr fed91000 ver 5:0 cap 8d2008c40660462 ecap f050da
[    0.076921] DMAR: RMRR base: 0x0000007c000000 end: 0x000000803fffff
[    0.076922] DMAR: IOMMU feature pi_support inconsistent
[    0.076923] DMAR: IOMMU feature pi_support inconsistent
[    0.076924] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 2
[    0.076925] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.076925] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.082226] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.082229] x2apic enabled
[    0.082323] APIC: Switched APIC routing to: cluster x2apic
[    0.096870] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x1e71785e5dd, max_idle_ns: 440795244814 ns
[    0.096880] Calibrating delay loop (skipped), value calculated using timer frequency.. 4224.00 BogoMIPS (lpj=2112000)
[    0.096936] CPU0: Thermal monitoring enabled (TM1)
[    0.096938] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.097049] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.097050] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.097054] process: using mwait in idle threads
[    0.097055] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.097060] Spectre V2 : Spectre BHI mitigation: SW BHB clearing on syscall and VM exit
[    0.097061] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.097062] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.097062] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.097065] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.097069] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.097070] Register File Data Sampling: Vulnerable: No microcode
[    0.097080] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.097081] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.097081] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.097082] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.097082] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.097084] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.097084] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.097085] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.097085] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.097875] Freeing SMP alternatives memory: 44K
[    0.097875] pid_max: default: 32768 minimum: 301
[    0.097875] LSM: initializing lsm=capability,landlock,yama,loadpin,safesetid,chromiumos,selinux,bpf
[    0.097875] landlock: Up and running.
[    0.097875] Yama: becoming mindful.
[    0.097875] LoadPin: ready to pin (currently enforcing)
[    0.097875] Chromium OS LSM: enabled
[    0.097875] SELinux:  Initializing.
[    0.097875] LSM support for eBPF active
[    0.097875] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.097875] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
[    0.097875] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i5-1250P (family: 0x6, model: 0x9a, stepping: 0x2)
[    0.097875] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.097875] core: cpu_core PMU driver: 
[    0.097875] ... version:                5
[    0.097875] ... bit width:              48
[    0.097875] ... generic registers:      8
[    0.097875] ... value mask:             0000ffffffffffff
[    0.097875] ... max period:             00007fffffffffff
[    0.097875] ... fixed-purpose events:   4
[    0.097875] ... event mask:             0001000f000000ff
[    0.097875] signal: max sigframe size: 3632
[    0.097875] Estimated ratio of average max frequency by base frequency (times 1024): 1852
[    0.097875] rcu: Hierarchical SRCU implementation.
[    0.097875] rcu: 	Max phase no-delay instances is 400.
[    0.097875] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.097875] smp: Bringing up secondary CPUs ...
[    0.097875] smpboot: x86: Booting SMP configuration:
[    0.097875] .... node  #0, CPUs:        #2  #4  #6
[    0.098902] psi: inconsistent task state! task=48:kworker/8:0H cpu=0 psi_flags=4 clear=0 set=4
[    0.098980]   #8  #9 #10 #11 #12 #13 #14 #15
[    0.021288] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.021288] ... version:                5
[    0.021288] ... bit width:              48
[    0.021288] ... generic registers:      6
[    0.021288] ... value mask:             0000ffffffffffff
[    0.021288] ... max period:             00007fffffffffff
[    0.021288] ... fixed-purpose events:   3
[    0.021288] ... event mask:             000000070000003f
[    0.135045]   #1  #3  #5  #7
[    0.152936] smp: Brought up 1 node, 16 CPUs
[    0.152936] smpboot: Total of 16 processors activated (67584.00 BogoMIPS)
[    0.153966] Memory: 7885484K/8228920K available (18432K kernel code, 2564K rwdata, 16028K rodata, 3080K init, 2408K bss, 327840K reserved, 0K cma-reserved)
[    0.154281] devtmpfs: initialized
[    0.154998] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.155033] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.155085] pinctrl core: initialized pinctrl subsystem
[    0.155623] PM: RTC time: 13:10:20, date: 2024-08-22
[    0.156117] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.156270] audit: initializing netlink subsys (disabled)
[    0.156273] audit: type=2000 audit(1724332220.059:1): state=initialized audit_enabled=0 res=1
[    0.156273] thermal_sys: Registered thermal governor 'step_wise'
[    0.156273] thermal_sys: Registered thermal governor 'user_space'
[    0.156273] cpuidle: using governor ladder
[    0.156273] cpuidle: using governor menu
[    0.156273] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.156273] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for domain 0000 [bus 00-ff]
[    0.156273] PCI: Using configuration type 1 for base access
[    0.157009] cryptd: max_cpu_qlen set to 1000
[    0.157009] ACPI: Added _OSI(Module Device)
[    0.157009] ACPI: Added _OSI(Processor Device)
[    0.157009] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.157009] ACPI: Added _OSI(Processor Aggregator Device)
[    0.159575] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.164970] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.164976] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.165237] ACPI: EC: EC started
[    0.165238] ACPI: EC: interrupt blocked
[    0.168030] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.168032] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.168034] ACPI: Interpreter enabled
[    0.168049] ACPI: PM: (supports S0 S3 S4 S5)
[    0.168051] ACPI: Using IOAPIC for interrupt routing
[    0.168078] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.168079] PCI: Using E820 reservations for host bridge windows
[    0.168250] ACPI: Enabled 2 GPEs in block 00 to 7F
[    0.170405] ACPI: \_SB_.PCI0.I2C2.CAM0.PRIC: New power resource
[    0.170516] ACPI: \_SB_.PCI0.I2C3.H010.PR00: New power resource
[    0.489877] ACPI: \_SB_.PCI0.TBT0: New power resource
[    0.489877] ACPI: \_SB_.PCI0.TBT1: New power resource
[    0.489877] ACPI: \_SB_.PCI0.D3C_: New power resource
[    0.517260] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.517265] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    0.517277] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
[    0.517303] acpi PNP0A08:00: host bridge window [mem 0x27fc00000-0x3fffffffffff window] ([0x40000000000-0x3fffffffffff] ignored, not CPU addressable)
[    0.517950] PCI host bridge to bus 0000:00
[    0.517952] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.517953] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.517955] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]
[    0.517956] pci_bus 0000:00: root bus resource [mem 0x80400000-0xdfffffff window]
[    0.517956] pci_bus 0000:00: root bus resource [mem 0x27fc00000-0x3ffffffffff window]
[    0.517957] pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
[    0.517958] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed47fff window]
[    0.517959] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.518031] pci 0000:00:00.0: [8086:4621] type 00 class 0x060000 conventional PCI endpoint
[    0.518368] pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.518375] pci 0000:00:02.0: BAR 0 [mem 0x81000000-0x81ffffff 64bit]
[    0.518381] pci 0000:00:02.0: BAR 2 [mem 0x90000000-0x9fffffff 64bit pref]
[    0.518385] pci 0000:00:02.0: BAR 4 [io  0x1000-0x103f]
[    0.518398] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.518400] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.518426] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.518427] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.518431] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.518432] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.518494] pci 0000:00:04.0: [8086:461d] type 00 class 0x118000 conventional PCI endpoint
[    0.518508] pci 0000:00:04.0: BAR 0 [mem 0x80680000-0x8069ffff 64bit]
[    0.518595] pci 0000:00:05.0: [8086:465d] type 00 class 0x048000 PCIe Root Complex Integrated Endpoint
[    0.518603] pci 0000:00:05.0: BAR 0 [mem 0x82000000-0x82ffffff 64bit]
[    0.518620] pci 0000:00:05.0: enabling Extended Tags
[    0.518625] pci 0000:00:05.0: DMAR: Passthrough IOMMU for integrated Intel IPU
[    0.518674] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCIe Root Port
[    0.518689] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.518692] pci 0000:00:06.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.518739] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.518924] pci 0000:00:07.0: [8086:466e] type 01 class 0x060400 PCIe Root Port
[    0.518944] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[    0.518947] pci 0000:00:07.0:   bridge window [io  0x2000-0x3fff]
[    0.518949] pci 0000:00:07.0:   bridge window [mem 0x83000000-0x8f1fffff]
[    0.518956] pci 0000:00:07.0:   bridge window [mem 0x27fc00000-0x29bbfffff 64bit pref]
[    0.519015] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.519117] pci 0000:00:07.1: [8086:463f] type 01 class 0x060400 PCIe Root Port
[    0.519137] pci 0000:00:07.1: PCI bridge to [bus 2d-57]
[    0.519140] pci 0000:00:07.1:   bridge window [io  0x4000-0x5fff]
[    0.519142] pci 0000:00:07.1:   bridge window [mem 0xa0000000-0xac1fffff]
[    0.519149] pci 0000:00:07.1:   bridge window [mem 0x29bc00000-0x2b7bfffff 64bit pref]
[    0.519207] pci 0000:00:07.1: PME# supported from D0 D3hot D3cold
[    0.519310] pci 0000:00:07.2: [8086:462f] type 01 class 0x060400 PCIe Root Port
[    0.519330] pci 0000:00:07.2: PCI bridge to [bus 58-82]
[    0.519332] pci 0000:00:07.2:   bridge window [io  0x6000-0x7fff]
[    0.519334] pci 0000:00:07.2:   bridge window [mem 0xac200000-0xb83fffff]
[    0.519341] pci 0000:00:07.2:   bridge window [mem 0x2b7c00000-0x2d3bfffff 64bit pref]
[    0.519399] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
[    0.519587] pci 0000:00:08.0: [8086:464f] type 00 class 0x088000 conventional PCI endpoint
[    0.519595] pci 0000:00:08.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.519741] pci 0000:00:0d.0: [8086:461e] type 00 class 0x0c0330 conventional PCI endpoint
[    0.519750] pci 0000:00:0d.0: BAR 0 [mem 0x806a0000-0x806affff 64bit]
[    0.519790] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.519876] pci 0000:00:0d.2: [8086:463e] type 00 class 0x0c0340 conventional PCI endpoint
[    0.519886] pci 0000:00:0d.2: BAR 0 [mem 0x80600000-0x8063ffff 64bit]
[    0.519893] pci 0000:00:0d.2: BAR 2 [mem 0x806cc000-0x806ccfff 64bit]
[    0.519923] pci 0000:00:0d.2: supports D1 D2
[    0.519924] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.519963] pci 0000:00:0d.3: [8086:466d] type 00 class 0x0c0340 conventional PCI endpoint
[    0.519973] pci 0000:00:0d.3: BAR 0 [mem 0x80640000-0x8067ffff 64bit]
[    0.519980] pci 0000:00:0d.3: BAR 2 [mem 0x806cd000-0x806cdfff 64bit]
[    0.520010] pci 0000:00:0d.3: supports D1 D2
[    0.520010] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.520252] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 conventional PCI endpoint
[    0.520273] pci 0000:00:14.0: BAR 0 [mem 0x806b0000-0x806bffff 64bit]
[    0.520362] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.520461] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 conventional PCI endpoint
[    0.520484] pci 0000:00:14.2: BAR 0 [mem 0x806c0000-0x806c3fff 64bit]
[    0.520500] pci 0000:00:14.2: BAR 2 [mem 0x806ce000-0x806cefff 64bit]
[    0.520739] pci 0000:00:14.3: [8086:51f0] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.520764] pci 0000:00:14.3: BAR 0 [mem 0x806c4000-0x806c7fff 64bit]
[    0.520980] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.521216] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 conventional PCI endpoint
[    0.521242] pci 0000:00:15.0: BAR 0 [mem 0x806cf000-0x806cffff 64bit]
[    0.521475] pci 0000:00:15.1: [8086:51e9] type 00 class 0x0c8000 conventional PCI endpoint
[    0.521507] pci 0000:00:15.1: BAR 0 [mem 0x806d0000-0x806d0fff 64bit]
[    0.521684] pci 0000:00:15.2: [8086:51ea] type 00 class 0x0c8000 conventional PCI endpoint
[    0.521708] pci 0000:00:15.2: BAR 0 [mem 0x806d1000-0x806d1fff 64bit]
[    0.521882] pci 0000:00:15.3: [8086:51eb] type 00 class 0x0c8000 conventional PCI endpoint
[    0.521912] pci 0000:00:15.3: BAR 0 [mem 0x806d2000-0x806d2fff 64bit]
[    0.522135] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000 conventional PCI endpoint
[    0.522161] pci 0000:00:16.0: BAR 0 [mem 0x806d3000-0x806d3fff 64bit]
[    0.522265] pci 0000:00:16.0: PME# supported from D3hot
[    0.522498] pci 0000:00:19.0: [8086:51c5] type 00 class 0x0c8000 conventional PCI endpoint
[    0.522526] pci 0000:00:19.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.522694] pci 0000:00:19.1: [8086:51c6] type 00 class 0x0c8000 conventional PCI endpoint
[    0.522719] pci 0000:00:19.1: BAR 0 [mem 0x806d4000-0x806d4fff 64bit]
[    0.523053] pci 0000:00:1e.0: [8086:51a8] type 00 class 0x078000 conventional PCI endpoint
[    0.523077] pci 0000:00:1e.0: BAR 0 [mem 0xfe03e000-0xfe03efff 64bit]
[    0.523290] pci 0000:00:1e.3: [8086:51ab] type 00 class 0x0c8000 conventional PCI endpoint
[    0.523316] pci 0000:00:1e.3: BAR 0 [mem 0x806d5000-0x806d5fff 64bit]
[    0.523534] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 conventional PCI endpoint
[    0.523774] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040100 conventional PCI endpoint
[    0.523836] pci 0000:00:1f.3: BAR 0 [mem 0x806c8000-0x806cbfff 64bit]
[    0.523931] pci 0000:00:1f.3: BAR 4 [mem 0x80500000-0x805fffff 64bit]
[    0.524076] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.524209] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 conventional PCI endpoint
[    0.524228] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.524390] pci 0000:01:00.0: [15b7:5009] type 00 class 0x010802 PCIe Endpoint
[    0.524405] pci 0000:01:00.0: BAR 0 [mem 0x80400000-0x80403fff 64bit]
[    0.524427] pci 0000:01:00.0: BAR 4 [mem 0x80404000-0x804040ff 64bit]
[    0.524599] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.524636] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[    0.524669] pci 0000:00:07.1: PCI bridge to [bus 2d-57]
[    0.524703] pci 0000:00:07.2: PCI bridge to [bus 58-82]
[    0.525873] ACPI Error: AE_NOT_FOUND, While resolving a named reference package element - \NULL (20240322/dspkginit-438)
[    0.525880] Low-power S0 idle used by default for system suspend
[    0.527389] ACPI: EC: interrupt unblocked
[    0.527390] ACPI: EC: event unblocked
[    0.527876] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.527876] ACPI: EC: GPE=0x6e
[    0.527876] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
[    0.527876] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
[    0.528955] iommu: Default domain type: Translated
[    0.528955] iommu: DMA domain TLB invalidation policy: lazy mode
[    0.528957] SCSI subsystem initialized
[    0.528966] ACPI: bus type USB registered
[    0.528966] usbcore: registered new interface driver usbfs
[    0.528966] usbcore: registered new interface driver hub
[    0.528966] usbcore: registered new device driver usb
[    0.528966] mc: Linux media interface: v0.10
[    0.528966] videodev: Linux video capture interface: v2.00
[    0.528966] Advanced Linux Sound Architecture Driver Initialized.
[    0.529071] PCI: Using ACPI for IRQ routing
[    0.599171] clocksource: Switched to clocksource tsc-early
[    0.599171] VFS: Disk quotas dquot_6.6.0
[    0.599171] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.599171] pnp: PnP ACPI init
[    0.599220] pnp 00:00: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    0.599269] system 00:00: [mem 0xfedc0000-0xfeddffff] has been reserved
[    0.599271] system 00:00: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    0.599272] system 00:00: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    0.599274] system 00:00: [mem 0xfed90000-0xfed93fff] could not be reserved
[    0.599275] system 00:00: [mem 0xfe000000-0xffffffff] could not be reserved
[    0.599276] system 00:00: [mem 0xf8000000-0xf9ffffff] has been reserved
[    0.599277] system 00:00: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.599278] system 00:00: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.599327] system 00:01: [mem 0xfed00000-0xfed003ff] has been reserved
[    0.599358] system 00:02: [io  0x1800-0x18fe] has been reserved
[    0.599401] system 00:04: [io  0x0900-0x09fe] has been reserved
[    0.599428] system 00:05: [io  0x0200] has been reserved
[    0.599430] system 00:05: [io  0x0204] has been reserved
[    0.599431] system 00:05: [io  0x0800-0x087f] has been reserved
[    0.599432] system 00:05: [io  0x0880-0x08ff] has been reserved
[    0.602469] pnp: PnP ACPI: found 7 devices
[    0.607356] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.607454] NET: Registered PF_INET protocol family
[    0.607619] IP idents hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.620913] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.620940] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.620981] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.621306] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    0.621402] TCP: Hash tables configured (established 65536 bind 65536)
[    0.621459] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.621484] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
[    0.621546] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.621576] pci 0000:00:02.0: VF BAR 2 [mem 0x2e0000000-0x3bfffffff 64bit pref]: assigned
[    0.621584] pci 0000:00:02.0: VF BAR 0 [mem 0x2d4000000-0x2daffffff 64bit]: assigned
[    0.621587] pci 0000:00:08.0: BAR 0 [mem 0x2d3c00000-0x2d3c00fff 64bit]: assigned
[    0.621592] pci 0000:00:19.0: BAR 0 [mem 0x2d3c01000-0x2d3c01fff 64bit]: assigned
[    0.621617] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.621620] pci 0000:00:06.0:   bridge window [mem 0x80400000-0x804fffff]
[    0.621624] pci 0000:00:07.0: PCI bridge to [bus 02-2c]
[    0.621626] pci 0000:00:07.0:   bridge window [io  0x2000-0x3fff]
[    0.621629] pci 0000:00:07.0:   bridge window [mem 0x83000000-0x8f1fffff]
[    0.621632] pci 0000:00:07.0:   bridge window [mem 0x27fc00000-0x29bbfffff 64bit pref]
[    0.621635] pci 0000:00:07.1: PCI bridge to [bus 2d-57]
[    0.621637] pci 0000:00:07.1:   bridge window [io  0x4000-0x5fff]
[    0.621640] pci 0000:00:07.1:   bridge window [mem 0xa0000000-0xac1fffff]
[    0.621642] pci 0000:00:07.1:   bridge window [mem 0x29bc00000-0x2b7bfffff 64bit pref]
[    0.621646] pci 0000:00:07.2: PCI bridge to [bus 58-82]
[    0.621648] pci 0000:00:07.2:   bridge window [io  0x6000-0x7fff]
[    0.621651] pci 0000:00:07.2:   bridge window [mem 0xac200000-0xb83fffff]
[    0.621653] pci 0000:00:07.2:   bridge window [mem 0x2b7c00000-0x2d3bfffff 64bit pref]
[    0.621658] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.621660] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.621661] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000fffff window]
[    0.621662] pci_bus 0000:00: resource 7 [mem 0x80400000-0xdfffffff window]
[    0.621663] pci_bus 0000:00: resource 8 [mem 0x27fc00000-0x3ffffffffff window]
[    0.621665] pci_bus 0000:00: resource 9 [mem 0xfc800000-0xfe7fffff window]
[    0.621666] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed47fff window]
[    0.621667] pci_bus 0000:01: resource 1 [mem 0x80400000-0x804fffff]
[    0.621668] pci_bus 0000:02: resource 0 [io  0x2000-0x3fff]
[    0.621669] pci_bus 0000:02: resource 1 [mem 0x83000000-0x8f1fffff]
[    0.621670] pci_bus 0000:02: resource 2 [mem 0x27fc00000-0x29bbfffff 64bit pref]
[    0.621671] pci_bus 0000:2d: resource 0 [io  0x4000-0x5fff]
[    0.621672] pci_bus 0000:2d: resource 1 [mem 0xa0000000-0xac1fffff]
[    0.621673] pci_bus 0000:2d: resource 2 [mem 0x29bc00000-0x2b7bfffff 64bit pref]
[    0.621674] pci_bus 0000:58: resource 0 [io  0x6000-0x7fff]
[    0.621674] pci_bus 0000:58: resource 1 [mem 0xac200000-0xb83fffff]
[    0.621675] pci_bus 0000:58: resource 2 [mem 0x2b7c00000-0x2d3bfffff 64bit pref]
[    0.622366] PCI: CLS 64 bytes, default 64
[    0.622491] DMAR: No ATSR found
[    0.622492] DMAR: No SATC found
[    0.622494] DMAR: IOMMU feature fl1gp_support inconsistent
[    0.622495] DMAR: IOMMU feature pgsel_inv inconsistent
[    0.622495] DMAR: IOMMU feature nwfs inconsistent
[    0.622496] DMAR: IOMMU feature dit inconsistent
[    0.622496] DMAR: IOMMU feature sc_support inconsistent
[    0.622497] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    0.622499] DMAR: dmar1: Using Queued invalidation
[    0.622502] DMAR: dmar0: Using Queued invalidation
[    0.622504] DMAR: dmar2: Using Queued invalidation
[    0.622732] pci 0000:00:05.0: Adding to iommu group 0
[    0.622767] pci 0000:00:02.0: Adding to iommu group 1
[    0.623239] pci 0000:00:00.0: Adding to iommu group 2
[    0.623248] pci 0000:00:04.0: Adding to iommu group 3
[    0.623259] pci 0000:00:06.0: Adding to iommu group 4
[    0.623269] pci 0000:00:07.0: Adding to iommu group 5
[    0.623278] pci 0000:00:07.1: Adding to iommu group 6
[    0.623294] pci 0000:00:07.2: Adding to iommu group 7
[    0.623303] pci 0000:00:08.0: Adding to iommu group 8
[    0.623321] pci 0000:00:0d.0: Adding to iommu group 9
[    0.623334] pci 0000:00:0d.2: Adding to iommu group 9
[    0.623345] pci 0000:00:0d.3: Adding to iommu group 9
[    0.623360] pci 0000:00:14.0: Adding to iommu group 10
[    0.623369] pci 0000:00:14.2: Adding to iommu group 10
[    0.623377] pci 0000:00:14.3: Adding to iommu group 11
[    0.623398] pci 0000:00:15.0: Adding to iommu group 12
[    0.623408] pci 0000:00:15.1: Adding to iommu group 12
[    0.623417] pci 0000:00:15.2: Adding to iommu group 12
[    0.623427] pci 0000:00:15.3: Adding to iommu group 12
[    0.623438] pci 0000:00:16.0: Adding to iommu group 13
[    0.623452] pci 0000:00:19.0: Adding to iommu group 14
[    0.623462] pci 0000:00:19.1: Adding to iommu group 14
[    0.623476] pci 0000:00:1e.0: Adding to iommu group 15
[    0.623486] pci 0000:00:1e.3: Adding to iommu group 15
[    0.623503] pci 0000:00:1f.0: Adding to iommu group 16
[    0.623513] pci 0000:00:1f.3: Adding to iommu group 16
[    0.623523] pci 0000:00:1f.5: Adding to iommu group 16
[    0.623533] pci 0000:01:00.0: Adding to iommu group 17
[    0.625320] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    0.625323] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.625324] software IO TLB: mapped [mem 0x000000006e86f000-0x000000007686f000] (128MB)
[    0.625338] ACPI: bus type thunderbolt registered
[    0.625364] pci 0000:00:0d.2: attach allowed to drvr thunderbolt [internal device]
[    0.729130] pci 0000:00:0d.3: attach allowed to drvr thunderbolt [internal device]
[    0.836723] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    0.836727] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    0.836727] RAPL PMU: hw unit of domain package 2^-14 Joules
[    0.836728] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    0.836729] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    0.840506] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1e71785e5dd, max_idle_ns: 440795244814 ns
[    0.840530] clocksource: Switched to clocksource tsc
[    0.842517] Initialise system trusted keyrings
[    0.842576] workingset: timestamp_bits=62 max_order=21 bucket_order=0
[    0.842707] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.851357] Key type asymmetric registered
[    0.851360] Asymmetric key parser 'x509' registered
[    0.851387] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    0.851445] io scheduler mq-deadline registered
[    0.851446] io scheduler kyber registered
[    0.851457] io scheduler bfq registered
[    0.859272] pci 0000:00:06.0: attach allowed to drvr pcieport [internal device]
[    0.859442] pcieport 0000:00:06.0: can't derive routing for PCI INT D
[    0.859444] pcieport 0000:00:06.0: PCI INT D: no GSI
[    0.859519] pcieport 0000:00:06.0: PME: Signaling with IRQ 155
[    0.859609] pcieport 0000:00:06.0: AER: enabled with IRQ 155
[    0.859652] pci 0000:00:07.0: attach allowed to drvr pcieport [internal device]
[    0.859842] pcieport 0000:00:07.0: PME: Signaling with IRQ 156
[    0.859929] pcieport 0000:00:07.0: AER: enabled with IRQ 156
[    0.859943] pcieport 0000:00:07.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.860049] pci 0000:00:07.1: attach allowed to drvr pcieport [internal device]
[    0.860223] pcieport 0000:00:07.1: PME: Signaling with IRQ 157
[    0.860308] pcieport 0000:00:07.1: AER: enabled with IRQ 157
[    0.860323] pcieport 0000:00:07.1: pciehp: Slot #4 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.860414] pci 0000:00:07.2: attach allowed to drvr pcieport [internal device]
[    0.860585] pcieport 0000:00:07.2: PME: Signaling with IRQ 158
[    0.860631] pcieport 0000:00:07.2: AER: enabled with IRQ 158
[    0.860644] pcieport 0000:00:07.2: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    0.862704] ACPI: AC: AC Adapter [AC] (on-line)
[    0.862749] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:02/PNP0C09:00/PNP0C0D:00/input/input0
[    0.863350] ACPI: button: Lid Switch [LID0]
[    0.863395] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[    0.864310] ACPI: button: Power Button [PWRF]
[    0.866615] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.868576] hpet_acpi_add: no address or irqs in _CRS
[    0.868605] Non-volatile memory driver v1.3
[    0.869165] ACPI: bus type drm_connector registered
[    0.869664] pci 0000:00:02.0: attach allowed to drvr i915 [internal device]
[    0.870233] i915 0000:00:02.0: [drm] Found ALDERLAKE_P (device ID 46a6) display version 13.00
[    0.872379] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    0.872422] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    0.925599] i915 0000:00:02.0: Direct firmware load for i915/adlp_dmc.bin failed with error -2
[    0.925609] i915 0000:00:02.0: Direct firmware load for i915/adlp_dmc_ver2_16.bin failed with error -2
[    0.925610] i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/adlp_dmc.bin (-ENOENT). Disabling runtime power management.
[    0.925611] i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
[    0.944553] ACPI: battery: Slot [BAT0] (battery present)
[    1.001102] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin (0.0.0) is recommended, but only i915/tgl_huc_7.9.3.bin (7.9.3) was found
[    1.001105] i915 0000:00:02.0: [drm] GT0: Consider updating your linux-firmware pkg or downloading from https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[    1.004042] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.13.1
[    1.004045] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc_7.9.3.bin version 7.9.3
[    1.017635] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[    1.020190] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    1.020191] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    1.020720] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    1.021610] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[    1.032391] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 0
[    1.032621] usbcore: registered new interface driver udl
[    1.035103] loop: module loaded
[    1.035115] lkdtm: No crash points registered, enable through debugfs
[    1.035127] pci 0000:00:16.0: attach allowed to drvr mei_me [internal device]
[    1.035153] usbcore: registered new interface driver rtsx_usb
[    1.035186] pci 0000:00:15.0: attach allowed to drvr intel-lpss [internal device]
[    1.035700] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    1.038253] pci 0000:00:15.1: attach allowed to drvr intel-lpss [internal device]
[    1.038609] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    1.041710] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops 0xffffffff9311b4d0)
[    1.042993] cr50_i2c i2c-GOOG0005:00: cr50 TPM 2.0 (i2c 0x50 irq 77 id 0x28)
[    1.320442] pci 0000:00:15.2: attach allowed to drvr intel-lpss [internal device]
[    1.320772] idma64 idma64.2: Found Intel integrated DMA 64-bit
[    1.324884] pci 0000:00:15.3: attach allowed to drvr intel-lpss [internal device]
[    1.325151] idma64 idma64.3: Found Intel integrated DMA 64-bit
[    1.329113] pci 0000:00:19.0: attach allowed to drvr intel-lpss [internal device]
[    1.341357] intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
[    1.341708] idma64 idma64.4: Found Intel integrated DMA 64-bit
[    1.345476] pci 0000:00:19.1: attach allowed to drvr intel-lpss [internal device]
[    1.345684] idma64 idma64.5: Found Intel integrated DMA 64-bit
[    1.349783] pci 0000:00:1e.0: attach allowed to drvr intel-lpss [internal device]
[    1.350016] idma64 idma64.6: Found Intel integrated DMA 64-bit
[    1.350348] dw-apb-uart.6: ttyS0 at MMIO 0xfe03e000 (irq = 22, base_baud = 114825) is a 16550A
[    1.350509] pci 0000:00:1e.3: attach allowed to drvr intel-lpss [internal device]
[    1.363196] idma64 idma64.7: Found Intel integrated DMA 64-bit
[    1.368837] pci 0000:01:00.0: attach allowed to drvr nvme [internal device]
[    1.368863] SPI driver spidev has no spi_device_id for rohm,bh2228fv
[    1.368917] PPP generic driver version 2.4.2
[    1.369118] PPP MPPE Compression module registered
[    1.369241] pci 0000:00:0d.0: attach allowed to drvr xhci_hcd [internal device]
[    1.369268] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.369399] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[    1.370482] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.370662] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.370741] nvme nvme0: pci function 0000:01:00.0
[    1.370772] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    1.370773] xhci_hcd 0000:00:0d.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.370795] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.370797] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.370797] usb usb1: Product: xHCI Host Controller
[    1.370798] usb usb1: Manufacturer: Linux 6.11.0-rc1-gf98706d6143f xhci-hcd
[    1.370799] usb usb1: SerialNumber: 0000:00:0d.0
[    1.370944] hub 1-0:1.0: USB hub found
[    1.370953] hub 1-0:1.0: 1 port detected
[    1.371000] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.371001] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.371002] usb usb2: Product: xHCI Host Controller
[    1.371002] usb usb2: Manufacturer: Linux 6.11.0-rc1-gf98706d6143f xhci-hcd
[    1.371003] usb usb2: SerialNumber: 0000:00:0d.0
[    1.371085] hub 2-0:1.0: USB hub found
[    1.371089] hub 2-0:1.0: 3 ports detected
[    1.371154] pci 0000:00:14.0: attach allowed to drvr xhci_hcd [internal device]
[    1.371319] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.371402] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    1.372601] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
[    1.372937] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.373051] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    1.373053] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.373091] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.373092] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.373093] usb usb3: Product: xHCI Host Controller
[    1.373093] usb usb3: Manufacturer: Linux 6.11.0-rc1-gf98706d6143f xhci-hcd
[    1.373094] usb usb3: SerialNumber: 0000:00:14.0
[    1.373183] hub 3-0:1.0: USB hub found
[    1.373218] hub 3-0:1.0: 12 ports detected
[    1.373482] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.373483] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.373483] usb usb4: Product: xHCI Host Controller
[    1.373484] usb usb4: Manufacturer: Linux 6.11.0-rc1-gf98706d6143f xhci-hcd
[    1.373484] usb usb4: SerialNumber: 0000:00:14.0
[    1.373565] hub 4-0:1.0: USB hub found
[    1.373601] hub 4-0:1.0: 4 ports detected
[    1.373708] usbcore: registered new interface driver cdc_acm
[    1.373709] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    1.373867] usbcore: registered new interface driver uas
[    1.373878] usbcore: registered new interface driver usb-storage
[    1.373882] usbcore: registered new interface driver ums-realtek
[    1.373909] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.373910] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.376458] nvme nvme0: 16/0/0 default/read/poll queues
[    1.376815] i8042: Warning: Keylock active
[    1.377138] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.377782] rtc_cmos 00:03: RTC can wake from S4
[    1.380044] rtc_cmos 00:03: registered as rtc0
[    1.380096] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram
[    1.380109] i2c_dev: i2c /dev entries driver
[    1.381077]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
[    1.381822] Consider using thermal netlink events interface
[    1.385055] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input2
[    1.389051] pci 0000:00:04.0: attach allowed to drvr proc_thermal_pci [internal device]
[    1.389193] intel_rapl_common: Found RAPL domain package
[    1.391490] iTCO_vendor_support: vendor-support=0
[    1.391633] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    1.391761] device-mapper: verity-chromeos: dm-verity-chromeos registered
[    1.391764] intel_pstate: Intel P-state driver initializing
[    1.395041] intel_pstate: HWP enabled
[    1.395057] sdhci: Secure Digital Host Controller Interface driver
[    1.395058] sdhci: Copyright(c) Pierre Ossman
[    1.395438] efivars: Registered efivars operations
[    1.395440] gsmi version 1.0 loaded
[    1.395704] hid: raw HID events driver (C) Jiri Kosina
[    1.395769] usbcore: registered new interface driver usbhid
[    1.395769] usbhid: USB HID core driver
[    1.395893] intel_pmc_core INT33A1:00:  initialized
[    1.395943] intel_telemetry_core Init
[    1.396187] chromeos ramoops using acpi device.
[    1.397324] pstore: Using crash dump compression: deflate
[    1.397328] printk: legacy console [ramoops-1] enabled
[    1.397826] pstore: Registered ramoops as persistent store backend
[    1.397829] ramoops: using 0x100000@0x768ac000, ecc: 0
[    1.398167] spi_master spi0: will run message pump with realtime priority
[    1.403800] cros-ec-dev cros-ec-dev.2.auto: CrOS Fingerprint MCU detected
[    1.405988] ACPI: battery: new extension: cros-charge-control.7.auto
[    1.407230] cros-ec-spi spi-PRP0001:02: Chrome EC device registered
[    1.412256] cros_ec_lpcs GOOG0004:00: Chrome EC device registered
[    1.414777] intel_rapl_msr: PL4 support detected.
[    1.414803] intel_rapl_common: Found RAPL domain package
[    1.414807] intel_rapl_common: Found RAPL domain core
[    1.414809] intel_rapl_common: Found RAPL domain uncore
[    1.414812] intel_rapl_common: Found RAPL domain psys
[    1.416223] GACT probability NOT on
[    1.416262] xt_time: kernel timezone is -0000
[    1.416317] Initializing XFRM netlink socket
[    1.416344] NET: Registered PF_INET6 protocol family
[    1.417869] Segment Routing with IPv6
[    1.417876] In-situ OAM (IOAM) with IPv6
[    1.417904] NET: Registered PF_PACKET protocol family
[    1.417907] NET: Registered PF_KEY protocol family
[    1.418035] NET: Registered PF_VSOCK protocol family
[    1.420839] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.421596] microcode: Current revision: 0x00000309
[    1.422226] IPI shorthand broadcast: enabled
[    1.422692] AES CTR mode by8 optimization enabled
[    1.424331] sched_clock: Marking stable (1404001140, 20288451)->(1454789675, -30500084)
[    1.424668] registered taskstats version 1
[    1.424780] Loading compiled-in X.509 certificates
[    1.425829] Key type .fscrypt registered
[    1.425831] Key type fscrypt-provisioning registered
[    1.427192] Key type encrypted registered
[    1.441881] input: cros_ec_buttons as /devices/pci0000:00/0000:00:1f.0/PNP0C09:00/GOOG0004:00/GOOG0007:00/input/input3
[    1.442109] PM:   Magic number: 4:660:180
[    1.442695] input: PRP0001:01 as /devices/pci0000:00/0000:00:15.3/PRP0001:01/input/input4
[    1.442793] device-mapper: init: waiting for all devices to be available before creating mapped devices
[    1.490596] i2c_hid_acpi i2c-ELAN90FC:00: i2c_hid_get_input: IRQ triggered but there's no data
[    1.497458] input: ELAN90FC:00 04F3:2FDB as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-16/i2c-ELAN90FC:00/0018:04F3:2FDB.0001/input/input5
[    1.497523] input: ELAN90FC:00 04F3:2FDB UNKNOWN as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-16/i2c-ELAN90FC:00/0018:04F3:2FDB.0001/input/input6
[    1.497586] input: ELAN90FC:00 04F3:2FDB UNKNOWN as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-16/i2c-ELAN90FC:00/0018:04F3:2FDB.0001/input/input7
[    1.497674] input: ELAN90FC:00 04F3:2FDB Stylus as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-16/i2c-ELAN90FC:00/0018:04F3:2FDB.0001/input/input8
[    1.497707] input: ELAN90FC:00 04F3:2FDB UNKNOWN as /devices/pci0000:00/0000:00:15.3/i2c_designware.3/i2c-16/i2c-ELAN90FC:00/0018:04F3:2FDB.0001/input/input9
[    1.497776] hid-multitouch 0018:04F3:2FDB.0001: input,hidraw0: I2C HID v1.00 Device [ELAN90FC:00 04F3:2FDB] on i2c-ELAN90FC:00
[    1.556495] input: PNP0C50:00 06CB:CE92 Touchpad as /devices/pci0000:00/0000:00:19.1/i2c_designware.5/i2c-18/i2c-PNP0C50:00/0018:06CB:CE92.0002/input/input12
[    1.556782] hid-multitouch 0018:06CB:CE92.0002: input,hidraw1: I2C HID v1.00 Device [PNP0C50:00 06CB:CE92] on i2c-PNP0C50:00
[    1.558914] device-mapper: table: 254:0: verity: Data device lookup failed (-EPERM)
[    1.558920] device-mapper: ioctl: error adding target to table
[    1.569615] clk: Disabling unused clocks
[    1.569772] ALSA device list:
[    1.569774]   No soundcards found.
[    1.569786] Warning: unable to open an initial console.
[    1.580864] EXT4-fs (nvme0n1p3): mounting ext2 file system using the ext4 subsystem
[    1.582231] EXT4-fs (nvme0n1p3): mounted filesystem 00000000-0000-0000-0000-000000000000 ro without journal. Quota mode: none.
[    1.582274] VFS: Mounted root (ext2 filesystem) readonly on device 259:3.
[    1.582718] devtmpfs: mounted
[    1.594614] Freeing unused kernel image (initmem) memory: 3080K
[    1.594630] Write protecting the kernel read-only data: 34816k
[    1.595209] Freeing unused kernel image (rodata/data gap) memory: 356K
[    1.595217] Run /sbin/init as init process
[    1.610350] usb 3-9: new high-speed USB device number 2 using xhci_hcd
[    1.620059] audit: type=1404 audit(1724332221.521:2): enforcing=1 old_enforcing=0 auid=4294967295 ses=4294967295 enabled=1 old-enabled=1 lsm=selinux res=1
[    1.649946] SELinux:  Permission bpf in class capability2 not defined in policy.
[    1.649958] SELinux:  Permission checkpoint_restore in class capability2 not defined in policy.
[    1.649963] SELinux:  Permission bpf in class cap2_userns not defined in policy.
[    1.649965] SELinux:  Permission checkpoint_restore in class cap2_userns not defined in policy.
[    1.649978] SELinux:  Class mctp_socket not defined in policy.
[    1.649982] SELinux:  Class io_uring not defined in policy.
[    1.649984] SELinux:  Class user_namespace not defined in policy.
[    1.649986] SELinux: the above unknown classes and permissions will be denied
[    1.651233] SELinux:  policy capability network_peer_controls=1
[    1.651236] SELinux:  policy capability open_perms=1
[    1.651238] SELinux:  policy capability extended_socket_class=1
[    1.651240] SELinux:  policy capability always_check_network=0
[    1.651241] SELinux:  policy capability cgroup_seclabel=0
[    1.651243] SELinux:  policy capability nnp_nosuid_transition=1
[    1.651244] SELinux:  policy capability genfs_seclabel_symlinks=0
[    1.651246] SELinux:  policy capability ioctl_skip_cloexec=0
[    1.651247] SELinux:  policy capability userspace_initial_context=0
[    1.665862] audit: type=1403 audit(1724332221.567:3): auid=4294967295 ses=4294967295 lsm=selinux res=1
[    1.708054] chromeos_acpi GOOG0016:00: truncating sysfs content for VDAT
[    1.714607] SELinux:  Context u:object_r:cros_run_pvm_opt:s0 is not valid (left unmapped).
[    1.714652] SELinux:  Context u:object_r:cros_run_pvm_opt_pita:s0 is not valid (left unmapped).
[    1.717499] audit: type=1400 audit(1724332221.619:4): avc:  granted  { execute } for  pid=227 comm="sh" name="crash_reporter" dev="nvme0n1p3" ino=41226 scontext=u:r:cros_init_scripts:s0 tcontext=u:object_r:cros_crash_reporter_exec:s0 tclass=file
[    1.737756] usb 3-9: New USB device found, idVendor=0781, idProduct=5530, bcdDevice= 1.00
[    1.737763] usb 3-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    1.737765] usb 3-9: Product: Cruzer
[    1.737767] usb 3-9: Manufacturer: SanDisk
[    1.737769] usb 3-9: SerialNumber: 4C530000290318202594
[    1.738890] usb-storage 3-9:1.0: USB Mass Storage device detected
[    1.739637] scsi host0: usb-storage 3-9:1.0
[    1.795264] init: early-failure main process (229) terminated with status 124
[    1.815107] loop0: detected capacity change from 0 to 2056
[    1.818586] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[    1.838677] usb 2-1: New USB device found, idVendor=0bda, idProduct=8153, bcdDevice=30.00
[    1.838705] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    1.838708] usb 2-1: Product: USB 10/100/1000 LAN
[    1.838710] usb 2-1: Manufacturer: Realtek
[    1.838712] usb 2-1: SerialNumber: 00CC3F
[    1.841043] udevd[250]: Starting version 249
[    1.851400] LoadPin: nvme0n1p3 (259:3): writable
[    1.851409] LoadPin: security-policy pinned obj="/opt/google/dlc/_trusted_verity_digests" pid=247 cmdline="chromeos_startup"
[    1.853331] usb 3-10: new full-speed USB device number 3 using xhci_hcd
[    1.878284] usbcore: registered new device driver r8152-cfgselector
[    1.982575] usb 3-10: New USB device found, idVendor=8087, idProduct=0033, bcdDevice= 0.00
[    1.982592] usb 3-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.994443] r8152-cfgselector 2-1: reset SuperSpeed USB device number 2 using xhci_hcd
[    2.065350] r8152 2-1:1.0 eth0: v1.12.13
[    2.065380] usbcore: registered new interface driver r8152
[    2.067723] usbcore: registered new interface driver cdc_ether
[    2.068238] usbcore: registered new interface driver r8153_ecm
[    2.091187] udevd[265]: Using default interface naming scheme 'v249'.
[    2.113201] Bluetooth: bt_init() Core ver 2.22
[    2.113233] NET: Registered PF_BLUETOOTH protocol family
[    2.113235] Bluetooth: bt_init() HCI device and connection manager initialized
[    2.113239] Bluetooth: hci_sock_init() HCI socket layer initialized
[    2.113241] Bluetooth: l2cap_init_sockets() L2CAP socket layer initialized
[    2.113246] Bluetooth: sco_init() SCO socket layer initialized
[    2.117513] EXT4-fs (dm-4): recovery complete
[    2.117539] frecon[362]: Frecon using drm driver i915, version 1.6, date(0), desc(Intel Graphics) using atomic
[    2.117547] EXT4-fs (dm-4): mounted filesystem 720b2b90-e0c4-4a2c-bac3-2af416c4ab87 r/w with ordered data mode. Quota mode: journalled.
[    2.118286] EXT4-fs (nvme0n1p8): mounted filesystem 66dd706d-ed0e-48a9-8499-814d72b6ad4e ro without journal. Quota mode: none.
[    2.120416] usbcore: registered new interface driver btusb
[    2.122133] Bluetooth: btintel_version_info_tlv() hci0: Device revision is 0
[    2.122148] Bluetooth: btintel_version_info_tlv() hci0: Secure boot is enabled
[    2.122155] Bluetooth: btintel_version_info_tlv() hci0: OTP lock is enabled
[    2.122161] Bluetooth: btintel_version_info_tlv() hci0: API lock is enabled
[    2.122166] Bluetooth: btintel_version_info_tlv() hci0: Debug lock is disabled
[    2.122171] Bluetooth: btintel_version_info_tlv() hci0: Minimum firmware build 1 week 10 2014
[    2.122178] Bluetooth: btintel_version_info_tlv() hci0: Bootloader timestamp 2019.40 buildtype 1 build 38
[    2.122190] Bluetooth: btintel_set_dsm_reset_method() hci0: No support for _PRR ACPI method
[    2.124199] Bluetooth: btintel_prepare_fw_download_tlv() hci0: Found device firmware: intel/ibt-0040-0041.sfi
[    2.124252] Bluetooth: btintel_firmware_version() hci0: Boot Address: 0x100800
[    2.124259] Bluetooth: btintel_firmware_version() hci0: Firmware Version: 63-28.24
[    2.136356] frecon[362]: Unable to send display ownership DBus message to Chrome DisplayService: DBus not initialized
[    2.141514] EXT4-fs (dm-4): re-mounted 720b2b90-e0c4-4a2c-bac3-2af416c4ab87 r/w. Quota mode: journalled.
[    2.276057] ERROR chromeos_startup: [platform.cc(421)] lstat() of "/mnt/stateful_partition/mount_encrypted_failed" failed: No such file or directory (2)
[    2.556582] EXT4-fs (dm-6): mounted filesystem f3083a60-02e3-4f6a-8167-00676bb1449a r/w with ordered data mode. Quota mode: none.
[    2.638405] audit: type=1400 audit(1724332222.540:5): avc:  granted  { execute } for  pid=417 comm="chromeos_startu" name="crash_reporter" dev="nvme0n1p3" ino=41226 scontext=u:r:chromeos_startup:s0 tcontext=u:object_r:cros_crash_reporter_exec:s0 tclass=file
[    2.657974] SELinux:  Context u:object_r:cros_modemfwd_file:s0 is not valid (left unmapped).
[    2.680049] ERROR chromeos_startup: [platform.cc(1047)] open: /var/empty: No such file or directory (2)
[    2.753579] scsi 0:0:0:0: Direct-Access     SanDisk  Cruzer           1.00 PQ: 0 ANSI: 6
[    2.755409] sd 0:0:0:0: [sda] 120225792 512-byte logical blocks: (61.6 GB/57.3 GiB)
[    2.755734] sd 0:0:0:0: [sda] Write Protect is off
[    2.756126] sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
[    2.771828] GPT:partition_entry_array_crc32 values don't match: 0xf64eccaf != 0x4ef39755
[    2.771833] GPT:Primary header thinks Alt. header is not at the end of the disk.
[    2.771836] GPT:23085224 != 120225791
[    2.771838] GPT:Alternate GPT header not at the end of the disk.
[    2.771840] GPT:23085224 != 120225791
[    2.771842] GPT: Use GNU Parted to correct GPT errors.
[    2.771851]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12
[    2.772223] sd 0:0:0:0: [sda] Attached SCSI removable disk
[    2.773087] WARNING chromeos_startup: [stateful_mount.cc(482)] Failed to read from /mnt/stateful_partition/.update_available: No such file or directory (2)
[    2.776539] EXT4-fs (dm-4): re-mounted 720b2b90-e0c4-4a2c-bac3-2af416c4ab87 r/w. Quota mode: journalled.
[    2.839964] frecon[362]: DBUS initialized.
[    2.854927] ACPI: battery: [Firmware Bug]: (dis)charge rate invalid.
[    2.856591] loop1: detected capacity change from 0 to 261160
[    2.863114] init: bluetoothd pre-start process (579) terminated with status 1
[    2.943427] init: node_exporter main process (945) terminated with status 126
[    2.943444] init: node_exporter main process ended, respawning
[    2.956199] init: node_exporter main process (992) terminated with status 126
[    2.956216] init: node_exporter main process ended, respawning
[    2.958656] init: node_exporter main process (1013) terminated with status 126
[    2.958666] init: node_exporter main process ended, respawning
[    2.961324] init: node_exporter main process (1048) terminated with status 126
[    2.961337] init: node_exporter respawning too fast, stopped
[    2.966402] Intel(R) Wireless WiFi driver for Linux
[    2.966455] pci 0000:00:14.3: attach allowed to drvr iwlwifi [internal device]
[    2.970756] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80400 wfpm id 0x80000020
[    2.970803] iwlwifi 0000:00:14.3: PCI dev 51f0/0094, rev=0x370, rfid=0x2010d000
[    2.970807] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz
[    2.981964] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.42
[    2.982523] iwlwifi 0000:00:14.3: loaded firmware version 89.23bfe245.0 so-a0-gf-a0-89.ucode op_mode iwlmvm
[    2.987138] pps_core: LinuxPPS API ver. 1 registered
[    2.987145] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    2.991296] PTP clock support registered
[    3.215902] loop2: detected capacity change from 0 to 194160
[    3.231711] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    3.231762] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    3.231823] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    3.231832] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    3.232217] iwlwifi 0000:00:14.3: loaded PNVM version 0579d284
[    3.233249] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[    3.248227] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[    3.318996] iwlwifi 0000:00:14.3: base HW address: 84:14:4d:8a:4a:9e
[    3.344220] udevd[290]: Using default interface naming scheme 'v249'.
[    3.518102] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    3.518166] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    3.518225] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    3.518234] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    3.519626] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 5
[    3.609394] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 0
[    3.611616] traps: set_wifi_transm[1708] trap int3 ip:7f340f58ea84 sp:7fff7da6f270 error:0 in libbase-core.so[18ea84,7f340f400000+318000]
[    3.774003] loop3: detected capacity change from 0 to 103560
[   13.856420] watchdog: Watchdog detected hard LOCKUP on cpu 12
[   13.856432] Modules linked in: iwlmvm mac80211 ptp pps_core hid_rmi rmi_core iio_trig_sysfs iwlwifi cros_ec_sensors cros_ec_lid_angle xt_state cros_ec_sensors_core industrialio_triggered_buffer kfifo_buf xt_conntrack nf_conntrack industrialio cfg80211 cros_ec_sensorhub btusb btbcm btintel btrtl btmtk bluetooth r8153_ecm cdc_ether usbnet r8152 mii joydev
[   13.856464] Sending NMI from CPU 11 to CPUs 12:
[   13.856474] NMI backtrace for cpu 12
[   13.856480] CPU: 12 UID: 201 PID: 524 Comm: dbus-daemon Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.856484] Tainted: [U]=USER
[   13.856485] Hardware name: Google XXXXXXXXX
[   13.856487] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
[   13.856494] Code: c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 <eb> f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 8b
[   13.856496] RSP: 0018:ffff91d90253b9b8 EFLAGS: 00000046
[   13.856498] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f37b2f6c0
[   13.856499] RDX: ffff8b4f37b80000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.856500] RBP: ffff91d90253b9d8 R08: 0000000000000002 R09: ffff8b4dc2bbc3c0
[   13.856501] R10: 0000000000000005 R11: 0000000000000005 R12: ffff8b4f37b00000
[   13.856502] R13: 0000000000000000 R14: 0000000000340000 R15: 0000000000340000
[   13.856504] FS:  0000788e7f133c40(0000) GS:ffff8b4f37b00000(0000) knlGS:0000000000000000
[   13.856505] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.856507] CR2: 00005a4901a073f8 CR3: 00000001131b2000 CR4: 0000000000750ef0
[   13.856508] PKRU: 55555554
[   13.856508] Call Trace:
[   13.856512]  <NMI>
[   13.856516]  ? nmi_cpu_backtrace+0x101/0x130
[   13.856521]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.856524]  ? nmi_handle+0x59/0x160
[   13.856526]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856528]  ? default_do_nmi+0x46/0x110
[   13.856530]  ? exc_nmi+0xb1/0x110
[   13.856532]  ? end_repeat_nmi+0xf/0x53
[   13.856534]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856535]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856537]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.856538]  </NMI>
[   13.856539]  <TASK>
[   13.856540]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.856543]  sched_balance_rq+0x15ff/0x1860
[   13.856548]  sched_balance_newidle+0x193/0x390
[   13.856550]  balance_fair+0x25/0x40
[   13.856553]  __schedule+0x899/0x1110
[   13.856555]  ? timerqueue_add+0x86/0xa0
[   13.856558]  ? hrtimer_start_range_ns+0x225/0x2f0
[   13.856560]  schedule+0x5e/0x90
[   13.856562]  schedule_hrtimeout_range_clock+0xc2/0x130
[   13.856564]  ? __pfx_hrtimer_wakeup+0x10/0x10
[   13.856566]  do_epoll_wait+0x627/0x6b0
[   13.856571]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[   13.856574]  __x64_sys_epoll_wait+0x50/0x80
[   13.856577]  do_syscall_64+0x6a/0xe0
[   13.856580]  ? clear_bhb_loop+0x45/0xa0
[   13.856581]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.856585] RIP: 0033:0x788e7f2d3403
[   13.856588] Code: 8b 15 19 ba 0b 00 f7 d8 64 89 02 b8 ff ff ff ff eb b8 0f 1f 44 00 00 80 3d 01 40 0c 00 00 41 89 ca 74 14 b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 55 48 89 e5 48 83 ec 20 89
[   13.856589] RSP: 002b:00007ffc622161a8 EFLAGS: 00000202 ORIG_RAX: 00000000000000e8
[   13.856591] RAX: ffffffffffffffda RBX: 00007ffc62216560 RCX: 0000788e7f2d3403
[   13.856592] RDX: 0000000000000040 RSI: 00007ffc622161b0 RDI: 0000000000000003
[   13.856593] RBP: 00007ffc622164e0 R08: 0000000000006168 R09: 00000000000b6c2a
[   13.856594] R10: 0000000000006168 R11: 0000000000000202 R12: 0000000000000040
[   13.856595] R13: 00005b573157c810 R14: 00007ffc622161b0 R15: 0000000000006168
[   13.856596]  </TASK>
[   13.857470] NMI backtrace for cpu 11
[   13.857543] CPU: 11 UID: 1000 PID: 1906 Comm: chrome Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.857548] Tainted: [U]=USER
[   13.857550] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.857553] Call Trace:
[   13.857557]  <IRQ>
[   13.857560]  dump_stack_lvl+0x40/0xb0
[   13.857567]  nmi_cpu_backtrace+0xe9/0x130
[   13.857571]  ? __pfx_nmi_raise_cpu_backtrace+0x10/0x10
[   13.857575]  nmi_trigger_cpumask_backtrace+0x6a/0x100
[   13.857580]  watchdog_hardlockup_check+0x179/0x210
[   13.857585]  watchdog_timer_fn+0x5f/0x2a0
[   13.857588]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   13.857592]  __hrtimer_run_queues+0xc8/0x250
[   13.857596]  hrtimer_interrupt+0xf7/0x210
[   13.857599]  __sysvec_apic_timer_interrupt+0x48/0x130
[   13.857604]  sysvec_apic_timer_interrupt+0x73/0x90
[   13.857608]  </IRQ>
[   13.857610]  <TASK>
[   13.857612]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   13.857616] RIP: 0010:smp_call_function_many_cond+0x33c/0x4e0
[   13.857621] Code: 25 ff ff ff 00 74 34 f3 48 0f bc c8 83 f9 17 77 2a 49 8b 06 89 ca 48 8b 14 d5 e0 b9 8e 93 f7 44 02 08 01 00 00 00 74 0c f3 90 <8b> 74 10 08 40 f6 c6 01 75 f4 ff c1 83 f9 18 72 b7 65 48 8b 04 25
[   13.857624] RSP: 0000:ffff91d904653c90 EFLAGS: 00000202
[   13.857627] RAX: 0000000000033940 RBX: 0000000000000003 RCX: 0000000000000008
[   13.857630] RDX: ffff8b4f37a00000 RSI: 0000000000000011 RDI: 0000000000000001
[   13.857632] RBP: ffff91d904653d10 R08: ffffffff91efe030 R09: 000000000000000b
[   13.857635] R10: ffffffff9424a540 R11: ffffffff91efd800 R12: ffffffff91efd800
[   13.857637] R13: 0000000000000008 R14: ffff8b4f37aefac0 R15: 0000000000000202
[   13.857639]  ? __pfx_flush_tlb_func+0x10/0x10
[   13.857643]  ? __pfx_flush_tlb_func+0x10/0x10
[   13.857646]  ? __pfx_tlb_is_not_lazy+0x10/0x10
[   13.857650]  ? __pfx_flush_tlb_func+0x10/0x10
[   13.857653]  on_each_cpu_cond_mask+0x21/0x40
[   13.857656]  flush_tlb_mm_range+0xde/0x140
[   13.857659]  ptep_clear_flush+0x3f/0x50
[   13.857665]  do_wp_page+0x963/0xae0
[   13.857669]  handle_mm_fault+0x75c/0x8e0
[   13.857672]  exc_page_fault+0x1e5/0x6a0
[   13.857676]  asm_exc_page_fault+0x22/0x30
[   13.857680] RIP: 0033:0x55a61bcc1012
[   13.857684] Code: 82 81 f8 64 48 8b 04 25 28 00 00 00 48 3b 45 f0 75 0a 48 89 d8 48 83 c4 28 5b 5d c3 e8 27 df 08 07 8b 05 39 78 03 08 8d 48 01 <89> 0d 30 78 03 08 85 c0 7e 01 c3 55 48 89 e5 53 50 48 8d 3d 26 40
[   13.857686] RSP: 002b:00007fff49204d58 EFLAGS: 00010206
[   13.857689] RAX: 0000000000000000 RBX: 00007fff49204dd0 RCX: 0000000000000001
[   13.857691] RDX: 0000000000000001 RSI: 000029a8006201e0 RDI: 000029a8006201e0
[   13.857694] RBP: 00007fff49204d70 R08: 000029ac00027288 R09: 000029a80061c400
[   13.857696] R10: 0000000000000001 R11: 0000000000000000 R12: 000029ac0001e9c0
[   13.857698] R13: 000029ac00022f80 R14: 00007fff49204dd0 R15: 000055a61880600c
[   13.857701]  </TASK>
[   13.857703] Sending NMI from CPU 11 to CPUs 0-10,13-15:
[   13.857708] NMI backtrace for cpu 7
[   13.857712] CPU: 7 UID: 0 PID: 0 Comm: swapper/7 Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.857715] Tainted: [U]=USER
[   13.857716] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.857717] RIP: 0010:queued_spin_lock_slowpath+0x155/0x260
[   13.857721] Code: d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 eb f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 <8b> 03 66 85 c0 75 f7 89 c6 81 e6 00 00 ff ff 44 39 f6 75 0b be 01
[   13.857722] RSP: 0018:ffff91d900478c78 EFLAGS: 00000002
[   13.857724] RAX: 0000000000200101 RBX: ffff8b4dc0059800 RCX: ffff8b4f379ef6c0
[   13.857725] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8b4dc0059800
[   13.857726] RBP: ffff91d900478c98 R08: 00000000000ed119 R09: ffffffff949feba0
[   13.857727] R10: 0000000000000000 R11: ffffffff92132e40 R12: ffff8b4f379c0000
[   13.857728] R13: ffff8b4dc0059800 R14: 0000000000200000 R15: 0000000000200000
[   13.857729] FS:  0000000000000000(0000) GS:ffff8b4f379c0000(0000) knlGS:0000000000000000
[   13.857731] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.857732] CR2: 0000577a47e86c08 CR3: 0000000110d24000 CR4: 0000000000750ef0
[   13.857733] PKRU: 55555554
[   13.857734] Call Trace:
[   13.857736]  <NMI>
[   13.857737]  ? nmi_cpu_backtrace+0x101/0x130
[   13.857740]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.857743]  ? nmi_handle+0x59/0x160
[   13.857745]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.857747]  ? default_do_nmi+0x46/0x110
[   13.857749]  ? exc_nmi+0xb1/0x110
[   13.857750]  ? end_repeat_nmi+0xf/0x53
[   13.857752]  ? __pfx_mempool_free_slab+0x10/0x10
[   13.857756]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.857757]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.857759]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.857761]  </NMI>
[   13.857762]  <IRQ>
[   13.857763]  __queue_work+0x198/0x3d0
[   13.857766]  queue_work_on+0x88/0xa0
[   13.857768]  clone_endio+0x9c/0x190
[   13.857773]  clone_endio+0x9c/0x190
[   13.857775]  clone_endio+0x9c/0x190
[   13.857778]  blk_mq_end_request_batch+0x100/0x450
[   13.857782]  nvme_irq+0x4d/0x70
[   13.857786]  ? __pfx_nvme_pci_complete_batch+0x10/0x10
[   13.857788]  __handle_irq_event_percpu+0x4b/0x1b0
[   13.857793]  handle_irq_event_percpu+0x14/0x40
[   13.857795]  handle_irq_event+0x36/0x60
[   13.857798]  handle_edge_irq+0x9b/0x190
[   13.857801]  __common_interrupt+0x3f/0xb0
[   13.857804]  common_interrupt+0x85/0xa0
[   13.857806]  </IRQ>
[   13.857806]  <TASK>
[   13.857807]  asm_common_interrupt+0x22/0x40
[   13.857809] RIP: 0010:cpuidle_enter_state+0x141/0x250
[   13.857812] Code: 95 f5 ff ff 49 89 c5 8b 73 04 bf ff ff ff ff e8 a5 91 c8 ff 31 ff e8 fe 24 20 ff 45 84 ff 74 05 e8 f4 91 c8 ff fb 44 8b 7d c4 <45> 85 ff 78 55 44 89 f9 48 6b f1 68 49 8b 54 36 48 4c 2b 6d b0 4c
[   13.857813] RSP: 0018:ffff91d90010be60 EFLAGS: 00000246
[   13.857814] RAX: ffff8b4f379c0000 RBX: ffffb1d8ffbe9980 RCX: 00000000fa3bc2ab
[   13.857815] RDX: 0000000000000001 RSI: 0000000000000007 RDI: 0000000000000000
[   13.857816] RBP: ffff91d90010beb0 R08: 0000000000000000 R09: 0000000000000000
[   13.857817] R10: 0000000000000000 R11: ffffffff92d7e920 R12: 0000000000000001
[   13.857818] R13: 00000000fa3bc2ab R14: ffffffff941c0588 R15: 0000000000000001
[   13.857819]  ? __pfx_intel_idle+0x10/0x10
[   13.857823]  cpuidle_enter+0x2c/0x40
[   13.857826]  do_idle+0x173/0x200
[   13.857829]  cpu_startup_entry+0x2a/0x30
[   13.857830]  start_secondary+0x97/0xa0
[   13.857833]  common_startup_64+0x13e/0x147
[   13.857836]  </TASK>
[   13.857837] NMI backtrace for cpu 3
[   13.857839] CPU: 3 UID: 1000 PID: 1871 Comm: chrome Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.857842] Tainted: [U]=USER
[   13.857843] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.857843] RIP: 0010:queued_spin_lock_slowpath+0x6f/0x260
[   13.857846] Code: 77 3f 31 c0 f0 0f ba 2b 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff ff 23 0b 09 d1 81 f9 00 01 00 00 73 17 85 c9 75 04 eb 07 f3 90 <80> 3b 00 75 f9 66 c7 03 01 00 e9 1a 01 00 00 84 c0 75 04 c6 43 01
[   13.857848] RSP: 0018:ffff91d90242bad8 EFLAGS: 00000002
[   13.857849] RAX: 0000000000000000 RBX: ffff8b4ddc7395e0 RCX: 0000000000000001
[   13.857850] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8b4ddc7395e0
[   13.857851] RBP: ffff91d90242baf8 R08: 0000000000000000 R09: 0000000000000000
[   13.857852] R10: 0000000000000018 R11: ffffffff92234ab0 R12: 0000000000000003
[   13.857852] R13: ffff8b4ddc7395e0 R14: 0000000000000000 R15: 0000000000000001
[   13.857853] FS:  00007cf3cee99400(0000) GS:ffff8b4f378c0000(0000) knlGS:0000000000000000
[   13.857854] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.857855] CR2: 000055a6205a26ce CR3: 0000000123214000 CR4: 0000000000750ef0
[   13.857856] PKRU: 55555558
[   13.857857] Call Trace:
[   13.857858]  <NMI>
[   13.857859]  ? nmi_cpu_backtrace+0x101/0x130
[   13.857862]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.857863]  ? nmi_handle+0x59/0x160
[   13.857865]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.857866]  ? default_do_nmi+0x46/0x110
[   13.857868]  ? exc_nmi+0xb1/0x110
[   13.857869]  ? end_repeat_nmi+0xf/0x53
[   13.857871]  ? __pfx_ep_poll_callback+0x10/0x10
[   13.857873]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.857875]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.857877]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.857878]  </NMI>
[   13.857878]  <TASK>
[   13.857879]  _raw_spin_lock_irqsave+0x65/0x70
[   13.857881]  __wake_up_common_lock+0x28/0x70
[   13.857884]  ep_poll_callback+0x199/0x250
[   13.857886]  __wake_up_common+0x4e/0x80
[   13.857888]  eventfd_write+0x19a/0x1f0
[   13.857891]  ? security_file_permission+0x2e/0x50
[   13.857894]  vfs_write+0x106/0x3c0
[   13.857897]  ? percpu_counter_add_batch+0x53/0x90
[   13.857900]  ? __fget_files+0x9e/0xc0
[   13.857903]  ksys_write+0x71/0xe0
[   13.857905]  do_syscall_64+0x6a/0xe0
[   13.857908]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.857909]  ? do_syscall_64+0x76/0xe0
[   13.857911]  ? __pte_offset_map+0x1d/0xf0
[   13.857914]  ? handle_mm_fault+0x6f3/0x8e0
[   13.857916]  ? exc_page_fault+0x202/0x6a0
[   13.857918]  ? clear_bhb_loop+0x45/0xa0
[   13.857919]  ? clear_bhb_loop+0x45/0xa0
[   13.857920]  ? clear_bhb_loop+0x45/0xa0
[   13.857921]  ? clear_bhb_loop+0x45/0xa0
[   13.857922]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.857924] RIP: 0033:0x7cf3cf6362ad
[   13.857926] Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 a8 dc f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 ff dc f8 ff 48 8b
[   13.857927] RSP: 002b:00007fff49204060 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[   13.857928] RAX: ffffffffffffffda RBX: 000029a800431800 RCX: 00007cf3cf6362ad
[   13.857929] RDX: 0000000000000008 RSI: 00007fff49204090 RDI: 0000000000000018
[   13.857930] RBP: 00007fff49204080 R08: 0000000000000000 R09: 0000000000000000
[   13.857930] R10: 0000000000000000 R11: 0000000000000293 R12: 000029a8004a65a8
[   13.857931] R13: 000055a622f6a108 R14: 00007fff49204090 R15: 0000000000000000
[   13.857933]  </TASK>
[   13.857933] NMI backtrace for cpu 2
[   13.857935] CPU: 2 UID: 0 PID: 0 Comm: swapper/2 Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.857937] Tainted: [U]=USER
[   13.857937] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.857938] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
[   13.857940] Code: c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 <eb> f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 8b
[   13.857941] RSP: 0000:ffff91d9000e3ce8 EFLAGS: 00000046
[   13.857942] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f378af6c0
[   13.857943] RDX: ffff8b4f37b40000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.857943] RBP: ffff91d9000e3d08 R08: 0000000000000010 R09: 0000000000000070
[   13.857944] R10: 00000000e57a81b4 R11: ffffffff91f7a810 R12: ffff8b4f37880000
[   13.857945] R13: ffff8b4f3792e880 R14: 00000000000c0000 R15: 00000000000c0000
[   13.857946] FS:  0000000000000000(0000) GS:ffff8b4f37880000(0000) knlGS:0000000000000000
[   13.857947] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.857948] CR2: 00007e6df525f380 CR3: 00000001408a4000 CR4: 0000000000750ef0
[   13.857949] PKRU: 55555554
[   13.857949] Call Trace:
[   13.857950]  <NMI>
[   13.857951]  ? nmi_cpu_backtrace+0x101/0x130
[   13.857953]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.857955]  ? nmi_handle+0x59/0x160
[   13.857956]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.857958]  ? default_do_nmi+0x46/0x110
[   13.857959]  ? exc_nmi+0xb1/0x110
[   13.857961]  ? end_repeat_nmi+0xf/0x53
[   13.857962]  ? __pfx_task_is_throttled_fair+0x10/0x10
[   13.857964]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.857965]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.857967]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.857969]  </NMI>
[   13.857969]  <TASK>
[   13.857970]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.857972]  double_rq_lock+0x82/0xa0
[   13.857973]  sched_core_balance+0x144/0x420
[   13.857977]  finish_task_switch+0x1a1/0x2d0
[   13.857979]  __schedule+0x511/0x1110
[   13.857982]  schedule_idle+0x20/0x40
[   13.857983]  do_idle+0x1c9/0x200
[   13.857985]  cpu_startup_entry+0x2a/0x30
[   13.857986]  start_secondary+0x97/0xa0
[   13.857987]  common_startup_64+0x13e/0x147
[   13.857990]  </TASK>
[   13.857990] NMI backtrace for cpu 0
[   13.857993] CPU: 0 UID: 0 PID: 1960 Comm: heartd Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.857996] Tainted: [U]=USER
[   13.857996] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.857997] RIP: 0010:queued_spin_lock_slowpath+0x155/0x260
[   13.858000] Code: d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 eb f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 <8b> 03 66 85 c0 75 f7 89 c6 81 e6 00 00 ff ff 44 39 f6 75 0b be 01
[   13.858001] RSP: 0018:ffff91d902433ab8 EFLAGS: 00000002
[   13.858002] RAX: 0000000000040101 RBX: ffff8b4f378ae880 RCX: ffff8b4f3782f6c0
[   13.858003] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8b4f378ae880
[   13.858004] RBP: ffff91d902433ad8 R08: ffff8b4dc184e300 R09: 0000000000000002
[   13.858005] R10: 0000000000000000 R11: ffffffff91f79200 R12: ffff8b4f37800000
[   13.858006] R13: ffff8b4f378ae880 R14: 0000000000040000 R15: 0000000000040000
[   13.858007] FS:  00007cea2fb3a8c0(0000) GS:ffff8b4f37800000(0000) knlGS:0000000000000000
[   13.858008] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858009] CR2: 00007ffc207eeff8 CR3: 0000000101822000 CR4: 0000000000750ef0
[   13.858010] PKRU: 55555554
[   13.858010] Call Trace:
[   13.858011]  <NMI>
[   13.858012]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858015]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858017]  ? nmi_handle+0x59/0x160
[   13.858018]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858020]  ? default_do_nmi+0x46/0x110
[   13.858021]  ? exc_nmi+0xb1/0x110
[   13.858022]  ? end_repeat_nmi+0xf/0x53
[   13.858024]  ? __pfx_select_task_rq_fair+0x10/0x10
[   13.858026]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858028]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858029]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858031]  </NMI>
[   13.858031]  <TASK>
[   13.858032]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858033]  try_to_wake_up+0x32d/0x680
[   13.858036]  kick_pool+0xb9/0x120
[   13.858038]  __queue_work+0x2cf/0x3d0
[   13.858039]  queue_work_on+0x88/0xa0
[   13.858041]  unix_release_sock+0x2b0/0x310
[   13.858044]  unix_release+0x34/0x50
[   13.858045]  __sock_release+0x43/0xd0
[   13.858048]  sock_close+0x15/0x20
[   13.858051]  __fput+0x96/0x2c0
[   13.858053]  __se_sys_close+0x3c/0x80
[   13.858055]  do_syscall_64+0x6a/0xe0
[   13.858057]  ? put_user_ifreq+0x49/0x70
[   13.858059]  ? sock_do_ioctl+0xc8/0x100
[   13.858061]  ? auditd_test_task+0x3d/0x50
[   13.858063]  ? audit_reset_context+0x1ea/0x250
[   13.858066]  ? syscall_exit_work+0xcc/0x130
[   13.858067]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.858069]  ? do_syscall_64+0x76/0xe0
[   13.858072]  ? exc_page_fault+0x202/0x6a0
[   13.858073]  ? clear_bhb_loop+0x45/0xa0
[   13.858074]  ? clear_bhb_loop+0x45/0xa0
[   13.858075]  ? clear_bhb_loop+0x45/0xa0
[   13.858076]  ? clear_bhb_loop+0x45/0xa0
[   13.858078]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858080] RIP: 0033:0x7cea2f5e6960
[   13.858082] Code: ff ff e9 3a ff ff ff b8 ff ff ff ff e9 30 ff ff ff e8 24 15 02 00 0f 1f 40 00 80 3d a1 5a 0d 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 40 c3 0f 1f 80 00 00 00 00 55 48 89 e5 48 83
[   13.858083] RSP: 002b:00007ffc207f1948 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   13.858085] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007cea2f5e6960
[   13.858085] RDX: 00007ffc207f1960 RSI: 0000000000008914 RDI: 0000000000000004
[   13.858086] RBP: 00007ffc207f19b0 R08: 0000000000000000 R09: 00005a9aeaa4d3a0
[   13.858087] R10: 0000000000044000 R11: 0000000000000202 R12: 00007ffc207f1ea8
[   13.858088] R13: 0000000000000001 R14: 0000000000000000 R15: 00007ffc207f1960
[   13.858089]  </TASK>
[   13.858090] NMI backtrace for cpu 4
[   13.858092] CPU: 4 UID: 1000 PID: 1880 Comm: Chrome_ChildIOT Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858095] Tainted: [U]=USER
[   13.858095] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858096] RIP: 0010:queued_spin_lock_slowpath+0x6f/0x260
[   13.858099] Code: 77 3f 31 c0 f0 0f ba 2b 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff ff 23 0b 09 d1 81 f9 00 01 00 00 73 17 85 c9 75 04 eb 07 f3 90 <80> 3b 00 75 f9 66 c7 03 01 00 e9 1a 01 00 00 84 c0 75 04 c6 43 01
[   13.858100] RSP: 0018:ffff91d9045f38d0 EFLAGS: 00000002
[   13.858102] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: 0000000000000001
[   13.858103] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8b4f3792e880
[   13.858104] RBP: ffff91d9045f38f0 R08: 00000000ffffffff R09: 0000000000000000
[   13.858104] R10: 0000000000000017 R11: ffff91d9045f3ae8 R12: ffff8b4ddc7395c0
[   13.858105] R13: ffff8b4ddc739610 R14: ffff8b4f3792e880 R15: ffff8b4ddc739620
[   13.858106] FS:  00007cf3c82006c0(0000) GS:ffff8b4f37900000(0000) knlGS:0000000000000000
[   13.858107] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858108] CR2: 000029a800abe000 CR3: 0000000123214000 CR4: 0000000000750ef0
[   13.858109] PKRU: 55555558
[   13.858110] Call Trace:
[   13.858111]  <NMI>
[   13.858112]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858114]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858116]  ? nmi_handle+0x59/0x160
[   13.858117]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858119]  ? default_do_nmi+0x46/0x110
[   13.858120]  ? exc_nmi+0xb1/0x110
[   13.858122]  ? end_repeat_nmi+0xf/0x53
[   13.858123]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858125]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858127]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858128]  </NMI>
[   13.858129]  <TASK>
[   13.858129]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858131]  __schedule+0x96/0x1110
[   13.858133]  ? __alloc_skb+0xe5/0x160
[   13.858136]  schedule+0x5e/0x90
[   13.858137]  schedule_hrtimeout_range_clock+0xee/0x130
[   13.858139]  ? __fget_files+0x9e/0xc0
[   13.858141]  do_epoll_wait+0x627/0x6b0
[   13.858144]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[   13.858146]  ? __audit_syscall_entry+0xcb/0x160
[   13.858148]  __x64_sys_epoll_wait+0x50/0x80
[   13.858150]  do_syscall_64+0x6a/0xe0
[   13.858153]  ? auditd_test_task+0x3d/0x50
[   13.858156]  ? audit_reset_context+0x1ea/0x250
[   13.858157]  ? syscall_exit_work+0xcc/0x130
[   13.858159]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.858161]  ? do_syscall_64+0x76/0xe0
[   13.858163]  ? __sys_sendto+0x12d/0x170
[   13.858166]  ? sock_poll+0xb6/0xd0
[   13.858167]  ? ep_done_scan+0xc7/0x110
[   13.858169]  ? do_epoll_wait+0x673/0x6b0
[   13.858172]  ? auditd_test_task+0x3d/0x50
[   13.858174]  ? audit_reset_context+0x1ea/0x250
[   13.858176]  ? syscall_exit_work+0xcc/0x130
[   13.858177]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.858179]  ? clear_bhb_loop+0x45/0xa0
[   13.858180]  ? clear_bhb_loop+0x45/0xa0
[   13.858181]  ? clear_bhb_loop+0x45/0xa0
[   13.858182]  ? clear_bhb_loop+0x45/0xa0
[   13.858183]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858185] RIP: 0033:0x7cf3cf648442
[   13.858186] Code: 89 55 f8 48 89 75 f0 89 7d fc 89 4d ec e8 16 bb f7 ff 44 8b 55 ec 8b 55 f8 41 89 c0 48 8b 75 f0 8b 7d fc b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 89 45 fc e8 6b bb f7 ff 8b 45 fc
[   13.858187] RSP: 002b:00007cf3c81fdd80 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
[   13.858189] RAX: ffffffffffffffda RBX: 000029a8004a6300 RCX: 00007cf3cf648442
[   13.858190] RDX: 0000000000000010 RSI: 00007cf3c81fde80 RDI: 0000000000000017
[   13.858190] RBP: 00007cf3c81fdda0 R08: 0000000000000000 R09: 7fffffffffffffff
[   13.858191] R10: 00000000ffffffff R11: 0000000000000293 R12: fffffffc00000000
[   13.858192] R13: 000029a800431800 R14: 000029a8004a63f0 R15: 00007cf3c81fde80
[   13.858194]  </TASK>
[   13.858194] NMI backtrace for cpu 5
[   13.858196] CPU: 5 UID: 0 PID: 0 Comm: swapper/5 Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858198] Tainted: [U]=USER
[   13.858198] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858199] RIP: 0010:sched_core_find+0x3f/0xa0
[   13.858202] Code: c0 74 6a 49 89 f6 31 db b9 ff ff ff ff 31 d2 4c 39 70 18 0f 92 c2 0f 47 d1 31 f6 85 d2 40 0f 9e c6 48 0f 44 d8 48 8b 44 f0 08 <48> 85 c0 75 de 48 85 db 74 39 48 8b 43 f8 48 81 c3 48 fd ff ff 4c
[   13.858203] RSP: 0000:ffff91d9000fbd38 EFLAGS: 00000046
[   13.858204] RAX: ffff8b4dd3cbb438 RBX: ffff8b4dd3cbb438 RCX: 00000000ffffffff
[   13.858205] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8b4f3792e880
[   13.858206] RBP: ffff91d9000fbd48 R08: 0000000000000010 R09: 0000000000000070
[   13.858207] R10: 00000000e443624e R11: ffffffff91f72210 R12: ffff8b4dc35768d8
[   13.858207] R13: ffff8b4f3792e880 R14: ffff8b4dc35768d8 R15: ffff8b4dc18b0120
[   13.858208] FS:  0000000000000000(0000) GS:ffff8b4f37940000(0000) knlGS:0000000000000000
[   13.858209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858210] CR2: 0000295402aeb080 CR3: 00000001132fe000 CR4: 0000000000750ef0
[   13.858211] PKRU: 55555554
[   13.858211] Call Trace:
[   13.858212]  <NMI>
[   13.858213]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858216]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858217]  ? nmi_handle+0x59/0x160
[   13.858218]  ? sched_core_find+0x3f/0xa0
[   13.858220]  ? default_do_nmi+0x46/0x110
[   13.858222]  ? exc_nmi+0xb1/0x110
[   13.858223]  ? end_repeat_nmi+0xf/0x53
[   13.858224]  ? __pfx_sched_core_balance+0x10/0x10
[   13.858227]  ? sched_core_find+0x3f/0xa0
[   13.858228]  ? sched_core_find+0x3f/0xa0
[   13.858230]  ? sched_core_find+0x3f/0xa0
[   13.858232]  </NMI>
[   13.858232]  <TASK>
[   13.858233]  sched_core_balance+0x17a/0x420
[   13.858235]  finish_task_switch+0x1a1/0x2d0
[   13.858237]  __schedule+0x511/0x1110
[   13.858239]  ? sched_ttwu_pending+0x11c/0x180
[   13.858241]  schedule_idle+0x20/0x40
[   13.858243]  do_idle+0x1c9/0x200
[   13.858244]  cpu_startup_entry+0x2a/0x30
[   13.858246]  start_secondary+0x97/0xa0
[   13.858247]  common_startup_64+0x13e/0x147
[   13.858249]  </TASK>
[   13.858250] NMI backtrace for cpu 1
[   13.858251] CPU: 1 UID: 0 PID: 1986 Comm: keyctl Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858253] Tainted: [U]=USER
[   13.858254] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858255] RIP: 0010:queued_spin_lock_slowpath+0x6f/0x260
[   13.858256] Code: 77 3f 31 c0 f0 0f ba 2b 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff ff 23 0b 09 d1 81 f9 00 01 00 00 73 17 85 c9 75 04 eb 07 f3 90 <80> 3b 00 75 f9 66 c7 03 01 00 e9 1a 01 00 00 84 c0 75 04 c6 43 01
[   13.858257] RSP: 0018:ffff91d904703700 EFLAGS: 00000002
[   13.858258] RAX: 0000000000000000 RBX: ffff8b4dc0059800 RCX: 0000000000000001
[   13.858259] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8b4dc0059800
[   13.858260] RBP: ffff91d904703720 R08: 0000000000000060 R09: ffff8b4ddc652300
[   13.858260] R10: 0000000000000000 R11: ffffffff92108520 R12: ffff8b4dc0050c00
[   13.858261] R13: ffff8b4dc0059800 R14: ffff8b4dc0196600 R15: 000000000000002f
[   13.858262] FS:  00007e4891cc4740(0000) GS:ffff8b4f37840000(0000) knlGS:0000000000000000
[   13.858263] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858264] CR2: 00007e4891d204db CR3: 000000011f1bc000 CR4: 0000000000750ef0
[   13.858265] PKRU: 55555554
[   13.858265] Call Trace:
[   13.858266]  <NMI>
[   13.858267]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858269]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858271]  ? nmi_handle+0x59/0x160
[   13.858272]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858274]  ? default_do_nmi+0x46/0x110
[   13.858275]  ? exc_nmi+0xb1/0x110
[   13.858277]  ? end_repeat_nmi+0xf/0x53
[   13.858278]  ? __pfx_bpf_lsm_kernel_module_request+0x10/0x10
[   13.858281]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858283]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858284]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858286]  </NMI>
[   13.858286]  <TASK>
[   13.858287]  __queue_work+0x198/0x3d0
[   13.858288]  queue_work_on+0x88/0xa0
[   13.858290]  call_usermodehelper_exec+0x112/0x180
[   13.858292]  __request_module+0x1f3/0x280
[   13.858295]  crypto_alg_mod_lookup+0x6e/0x210
[   13.858298]  crypto_alloc_tfm_node+0x52/0xd0
[   13.858301]  public_key_verify_signature+0xe8/0x280
[   13.858305]  x509_check_for_self_signed+0x54/0xd0
[   13.858307]  x509_cert_parse+0x1aa/0x210
[   13.858309]  x509_key_preparse+0x26/0x230
[   13.858310]  ? avc_has_perm+0xbf/0xd0
[   13.858312]  asymmetric_key_preparse+0x48/0x80
[   13.858314]  __key_create_or_update+0x17a/0x4a0
[   13.858318]  key_create_or_update+0x13/0x20
[   13.858319]  __se_sys_add_key+0x18c/0x210
[   13.858322]  ? syscall_trace_enter+0x14a/0x150
[   13.858323]  do_syscall_64+0x6a/0xe0
[   13.858325]  ? do_syscall_64+0x76/0xe0
[   13.858327]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.858329]  ? do_syscall_64+0x76/0xe0
[   13.858331]  ? do_pte_missing+0x127/0xc00
[   13.858333]  ? __pte_offset_map+0x1d/0xf0
[   13.858336]  ? handle_mm_fault+0x6f3/0x8e0
[   13.858338]  ? exc_page_fault+0x202/0x6a0
[   13.858339]  ? clear_bhb_loop+0x45/0xa0
[   13.858340]  ? clear_bhb_loop+0x45/0xa0
[   13.858341]  ? clear_bhb_loop+0x45/0xa0
[   13.858342]  ? clear_bhb_loop+0x45/0xa0
[   13.858344]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858346] RIP: 0033:0x7e4891dbed39
[   13.858347] Code: 5b 41 5c 5d c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d af 40 0c 00 f7 d8 64 89 01 48
[   13.858348] RSP: 002b:00007fff9419d028 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
[   13.858349] RAX: ffffffffffffffda RBX: 00007fff9419d038 RCX: 00007e4891dbed39
[   13.858350] RDX: 00005c1eab9182d0 RSI: 00007fff9419df13 RDI: 00007fff9419df08
[   13.858351] RBP: 00007fff9419d060 R08: 000000000cde79f5 R09: 00000000000005cc
[   13.858352] R10: 00000000000005cc R11: 0000000000000246 R12: 00007fff9419d200
[   13.858353] R13: 00005c1eab911a0d R14: 00005c1eab9182d0 R15: 00000000000005cc
[   13.858354]  </TASK>
[   13.858355] NMI backtrace for cpu 8
[   13.858357] CPU: 8 UID: 1000 PID: 1923 Comm: Chrome_ChildIOT Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858361] Tainted: [U]=USER
[   13.858361] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858362] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
[   13.858366] Code: c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 <eb> f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 8b
[   13.858367] RSP: 0018:ffff91d902cdf908 EFLAGS: 00000046
[   13.858369] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f37a2f6c0
[   13.858370] RDX: ffff8b4f37a40000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.858371] RBP: ffff91d902cdf928 R08: 0000000000000002 R09: ffff8b4dc2bbc3c0
[   13.858371] R10: 0000000000000005 R11: 0000000000000005 R12: ffff8b4f37a00000
[   13.858372] R13: 0000000000000000 R14: 0000000000240000 R15: 0000000000240000
[   13.858373] FS:  00007cf3c78006c0(0000) GS:ffff8b4f37a00000(0000) knlGS:0000000000000000
[   13.858375] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858376] CR2: 000055a614c5c0a0 CR3: 000000010abd2000 CR4: 0000000000750ef0
[   13.858377] PKRU: 55555558
[   13.858377] Call Trace:
[   13.858378]  <NMI>
[   13.858379]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858382]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858384]  ? nmi_handle+0x59/0x160
[   13.858386]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858387]  ? default_do_nmi+0x46/0x110
[   13.858389]  ? exc_nmi+0xb1/0x110
[   13.858390]  ? end_repeat_nmi+0xf/0x53
[   13.858392]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858394]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858395]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858396]  </NMI>
[   13.858397]  <TASK>
[   13.858397]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858399]  sched_balance_rq+0x15ff/0x1860
[   13.858404]  sched_balance_newidle+0x193/0x390
[   13.858405]  balance_fair+0x25/0x40
[   13.858407]  __schedule+0x899/0x1110
[   13.858409]  ? audit_reset_context+0x1ea/0x250
[   13.858411]  schedule+0x5e/0x90
[   13.858413]  schedule_hrtimeout_range_clock+0xee/0x130
[   13.858415]  ? __fget_files+0x9e/0xc0
[   13.858417]  do_epoll_wait+0x627/0x6b0
[   13.858420]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[   13.858422]  ? __audit_syscall_entry+0xcb/0x160
[   13.858424]  __x64_sys_epoll_wait+0x50/0x80
[   13.858426]  do_syscall_64+0x6a/0xe0
[   13.858429]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.858431]  ? do_syscall_64+0x76/0xe0
[   13.858433]  ? exc_page_fault+0x202/0x6a0
[   13.858435]  ? clear_bhb_loop+0x45/0xa0
[   13.858436]  ? clear_bhb_loop+0x45/0xa0
[   13.858437]  ? clear_bhb_loop+0x45/0xa0
[   13.858437]  ? clear_bhb_loop+0x45/0xa0
[   13.858438]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858441] RIP: 0033:0x7cf3cf648442
[   13.858443] Code: 89 55 f8 48 89 75 f0 89 7d fc 89 4d ec e8 16 bb f7 ff 44 8b 55 ec 8b 55 f8 41 89 c0 48 8b 75 f0 8b 7d fc b8 e8 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2e 44 89 c7 89 45 fc e8 6b bb f7 ff 8b 45 fc
[   13.858444] RSP: 002b:00007cf3c77fdd80 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8
[   13.858446] RAX: ffffffffffffffda RBX: 000029ac00061600 RCX: 00007cf3cf648442
[   13.858447] RDX: 0000000000000010 RSI: 00007cf3c77fde80 RDI: 0000000000000018
[   13.858448] RBP: 00007cf3c77fdda0 R08: 0000000000000000 R09: 7fffffffffffffff
[   13.858449] R10: 00000000ffffffff R11: 0000000000000293 R12: fffffffc00000000
[   13.858449] R13: 000029ac0004dc00 R14: 000029ac00061770 R15: 00007cf3c77fde80
[   13.858451]  </TASK>
[   13.858451] NMI backtrace for cpu 6
[   13.858453] CPU: 6 UID: 0 PID: 1964 Comm: chromeos-cleanu Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858456] Tainted: [U]=USER
[   13.858456] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858457] RIP: 0010:queued_spin_lock_slowpath+0x6f/0x260
[   13.858460] Code: 77 3f 31 c0 f0 0f ba 2b 08 0f 92 c0 89 c2 c1 e2 08 b9 ff 00 ff ff 23 0b 09 d1 81 f9 00 01 00 00 73 17 85 c9 75 04 eb 07 f3 90 <80> 3b 00 75 f9 66 c7 03 01 00 e9 1a 01 00 00 84 c0 75 04 c6 43 01
[   13.858461] RSP: 0018:ffff91d9047bb420 EFLAGS: 00000002
[   13.858462] RAX: 0000000000000000 RBX: ffff8b4f378ae880 RCX: 0000000000000001
[   13.858463] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8b4f378ae880
[   13.858463] RBP: ffff91d9047bb440 R08: 0000000000000002 R09: ffff8b4dc2bd8180
[   13.858464] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[   13.858465] R13: 0000000000000000 R14: ffff8b4f378ae880 R15: ffff8b4f378ae880
[   13.858466] FS:  0000790e9425c740(0000) GS:ffff8b4f37980000(0000) knlGS:0000000000000000
[   13.858467] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858468] CR2: 00005c28ae176528 CR3: 000000011f1da000 CR4: 0000000000750ef0
[   13.858469] PKRU: 55555554
[   13.858470] Call Trace:
[   13.858471]  <NMI>
[   13.858472]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858475]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858476]  ? nmi_handle+0x59/0x160
[   13.858478]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858480]  ? default_do_nmi+0x46/0x110
[   13.858481]  ? exc_nmi+0xb1/0x110
[   13.858483]  ? end_repeat_nmi+0xf/0x53
[   13.858485]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858487]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858488]  ? queued_spin_lock_slowpath+0x6f/0x260
[   13.858490]  </NMI>
[   13.858490]  <TASK>
[   13.858491]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858493]  sched_balance_rq+0xf06/0x1860
[   13.858498]  sched_balance_newidle+0x193/0x390
[   13.858501]  balance_fair+0x25/0x40
[   13.858503]  __schedule+0x899/0x1110
[   13.858504]  ? __blk_flush_plug+0xdf/0x130
[   13.858507]  schedule+0x5e/0x90
[   13.858509]  io_schedule+0x16/0x40
[   13.858511]  folio_wait_bit_common+0x1cb/0x280
[   13.858513]  ? __pfx_wake_page_function+0x10/0x10
[   13.858515]  filemap_get_pages+0x351/0x5e0
[   13.858517]  ? context_struct_compute_av+0x3bc/0x5a0
[   13.858521]  filemap_read+0xfe/0x370
[   13.858523]  ? xattr_find_entry+0x3c/0x110
[   13.858526]  vfs_read+0x290/0x2e0
[   13.858529]  ksys_read+0x71/0xe0
[   13.858531]  do_syscall_64+0x6a/0xe0
[   13.858533]  ? get_page_from_freelist+0x1585/0x15c0
[   13.858537]  ? __pte_offset_map+0x1d/0xf0
[   13.858540]  ? __pte_offset_map_lock+0xac/0x130
[   13.858541]  ? __folio_mod_stat+0x34/0x80
[   13.858543]  ? folio_add_lru+0x5a/0x80
[   13.858545]  ? do_pte_missing+0xab4/0xc00
[   13.858547]  ? handle_mm_fault+0x6f3/0x8e0
[   13.858550]  ? exc_page_fault+0x202/0x6a0
[   13.858552]  ? clear_bhb_loop+0x45/0xa0
[   13.858553]  ? clear_bhb_loop+0x45/0xa0
[   13.858554]  ? clear_bhb_loop+0x45/0xa0
[   13.858555]  ? clear_bhb_loop+0x45/0xa0
[   13.858556]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858559] RIP: 0033:0x790e9434d1cd
[   13.858561] Code: 31 c0 e9 d6 fe ff ff 55 48 8d 3d c6 0a 0a 00 48 89 e5 e8 c6 1c 02 00 66 0f 1f 44 00 00 80 3d 31 62 0d 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 53 c3 66 2e 0f 1f 84 00 00 00 00 00 55 48 89
[   13.858563] RSP: 002b:00007ffca90f5a98 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   13.858564] RAX: ffffffffffffffda RBX: 00000000ffffff7f RCX: 0000790e9434d1cd
[   13.858565] RDX: 0000000000002000 RSI: 00005c28ae174520 RDI: 000000000000000b
[   13.858566] RBP: 00007ffca90f5ad0 R08: 00005c28ae174520 R09: 0000000000000000
[   13.858567] R10: 0000000000000000 R11: 0000000000000246 R12: 00005c288b1780f0
[   13.858568] R13: 00005c288b177d50 R14: 00005c28ae174520 R15: 00005c288b164471
[   13.858569]  </TASK>
[   13.858570] NMI backtrace for cpu 13
[   13.858573] CPU: 13 UID: 228 PID: 1313 Comm: inotify_reader Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858576] Tainted: [U]=USER
[   13.858576] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858577] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
[   13.858581] Code: c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 <eb> f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 8b
[   13.858582] RSP: 0018:ffff91d9029df600 EFLAGS: 00000046
[   13.858583] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f37b6f6c0
[   13.858585] RDX: ffff8b4f37bc0000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.858585] RBP: ffff91d9029df620 R08: 0000000000000002 R09: ffff8b4dc2bbc3c0
[   13.858586] R10: 0000000000000005 R11: 0000000000000005 R12: ffff8b4f37b40000
[   13.858587] R13: 0000000000000000 R14: 0000000000380000 R15: 0000000000380000
[   13.858588] FS:  00007975866006c0(0000) GS:ffff8b4f37b40000(0000) knlGS:0000000000000000
[   13.858589] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858590] CR2: 00007a1abe02f018 CR3: 000000011c75e000 CR4: 0000000000750ef0
[   13.858591] PKRU: 55555554
[   13.858592] Call Trace:
[   13.858593]  <NMI>
[   13.858594]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858598]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858600]  ? nmi_handle+0x59/0x160
[   13.858601]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858603]  ? default_do_nmi+0x46/0x110
[   13.858604]  ? exc_nmi+0xb1/0x110
[   13.858606]  ? end_repeat_nmi+0xf/0x53
[   13.858608]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858609]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858611]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858612]  </NMI>
[   13.858612]  <TASK>
[   13.858613]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858615]  sched_balance_rq+0x15ff/0x1860
[   13.858618]  ? enqueue_hrtimer+0x3e/0xa0
[   13.858621]  sched_balance_newidle+0x193/0x390
[   13.858623]  balance_fair+0x25/0x40
[   13.858625]  __schedule+0x899/0x1110
[   13.858626]  ? remove_wait_queue+0x17/0x60
[   13.858628]  schedule+0x5e/0x90
[   13.858630]  schedule_hrtimeout_range_clock+0xee/0x130
[   13.858631]  poll_schedule_timeout+0x39/0x50
[   13.858635]  do_sys_poll+0x456/0x540
[   13.858637]  ? inotify_read+0x28f/0x300
[   13.858640]  ? __pfx_pollwake+0x10/0x10
[   13.858643]  __se_sys_poll+0x70/0x100
[   13.858646]  do_syscall_64+0x6a/0xe0
[   13.858649]  ? exc_page_fault+0x202/0x6a0
[   13.858650]  ? clear_bhb_loop+0x45/0xa0
[   13.858652]  ? clear_bhb_loop+0x45/0xa0
[   13.858653]  ? clear_bhb_loop+0x45/0xa0
[   13.858653]  ? clear_bhb_loop+0x45/0xa0
[   13.858654]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858657] RIP: 0033:0x79758700e54d
[   13.858658] Code: e5 48 83 ec 20 89 55 ec 48 89 75 f0 48 89 7d f8 e8 08 9a f8 ff 8b 55 ec 48 8b 75 f0 41 89 c0 48 8b 7d f8 b8 07 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 44 89 c7 89 45 f8 e8 60 9a f8 ff 8b 45 f8
[   13.858659] RSP: 002b:00007975865ffb70 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
[   13.858661] RAX: ffffffffffffffda RBX: 00007975865ffc0c RCX: 000079758700e54d
[   13.858662] RDX: 00000000ffffffff RSI: 0000000000000001 RDI: 00007975865ffc58
[   13.858663] RBP: 00007975865ffb90 R08: 0000000000000000 R09: 0000797580000be0
[   13.858664] R10: 1196db1ff71083e5 R11: 0000000000000293 R12: 0000797587d32558
[   13.858664] R13: 0000000000000020 R14: 0000797587d32501 R15: 0000797580000be0
[   13.858666]  </TASK>
[   13.858666] NMI backtrace for cpu 9
[   13.858669] CPU: 9 UID: 1000 PID: 1735 Comm: Chrome_IOThread Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858672] Tainted: [U]=USER
[   13.858673] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858674] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
[   13.858677] Code: c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 <eb> f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 8b
[   13.858679] RSP: 0018:ffff91d902aef9c8 EFLAGS: 00000046
[   13.858680] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f37a6f6c0
[   13.858681] RDX: ffff8b4f37a80000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.858682] RBP: ffff91d902aef9e8 R08: 0000000000000000 R09: ffff8b4dc2ac3500
[   13.858683] R10: 0000000000000019 R11: ffffffff922354e0 R12: ffff8b4f37a40000
[   13.858684] R13: 0000000000000000 R14: 0000000000280000 R15: 0000000000280000
[   13.858685] FS:  0000784f2b0006c0(0000) GS:ffff8b4f37a40000(0000) knlGS:0000000000000000
[   13.858686] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858687] CR2: 00001e14000cd000 CR3: 00000001132fe000 CR4: 0000000000750ef0
[   13.858688] PKRU: 55555554
[   13.858688] Call Trace:
[   13.858689]  <NMI>
[   13.858690]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858693]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858695]  ? nmi_handle+0x59/0x160
[   13.858697]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858699]  ? default_do_nmi+0x46/0x110
[   13.858700]  ? exc_nmi+0xb1/0x110
[   13.858702]  ? end_repeat_nmi+0xf/0x53
[   13.858703]  ? __pfx_ep_autoremove_wake_function+0x10/0x10
[   13.858706]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858707]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858709]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858710]  </NMI>
[   13.858711]  <TASK>
[   13.858711]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858713]  __task_rq_lock+0x32/0xd0
[   13.858715]  try_to_wake_up+0x89/0x680
[   13.858717]  ep_autoremove_wake_function+0x12/0x50
[   13.858719]  __wake_up_common+0x4e/0x80
[   13.858721]  __wake_up_common_lock+0x40/0x70
[   13.858723]  ep_poll_callback+0x199/0x250
[   13.858726]  __wake_up_common+0x4e/0x80
[   13.858727]  __wake_up_common_lock+0x40/0x70
[   13.858729]  sock_def_readable+0x42/0xc0
[   13.858731]  unix_stream_sendmsg+0x2dc/0x410
[   13.858733]  __sock_sendmsg+0x9e/0xc0
[   13.858735]  __sys_sendto+0x117/0x170
[   13.858739]  __x64_sys_sendto+0x26/0x30
[   13.858741]  do_syscall_64+0x6a/0xe0
[   13.858743]  ? do_syscall_64+0x76/0xe0
[   13.858745]  ? do_syscall_64+0x76/0xe0
[   13.858747]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.858749]  ? do_syscall_64+0x76/0xe0
[   13.858751]  ? irq_exit_rcu+0x4f/0x90
[   13.858753]  ? clear_bhb_loop+0x45/0xa0
[   13.858754]  ? clear_bhb_loop+0x45/0xa0
[   13.858755]  ? clear_bhb_loop+0x45/0xa0
[   13.858756]  ? clear_bhb_loop+0x45/0xa0
[   13.858757]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.858759] RIP: 0033:0x784f367c4f34
[   13.858761] Code: 89 7d e8 89 4d d4 e8 2b a0 f7 ff 44 8b 55 d4 48 8b 55 d8 45 31 c9 41 89 c4 48 8b 75 e0 8b 7d e8 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 34 44 89 e7 48 89 45 e8 e8 78 a0 f7 ff 48 8b
[   13.858762] RSP: 002b:0000784f2affce20 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   13.858764] RAX: ffffffffffffffda RBX: 0000000000000097 RCX: 0000784f367c4f34
[   13.858765] RDX: 0000000000000090 RSI: 00002954014790c0 RDI: 0000000000000097
[   13.858766] RBP: 0000784f2affce50 R08: 0000000000000000 R09: 0000000000000000
[   13.858766] R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000000
[   13.858767] R13: 0000000000000000 R14: 0000295401428c80 R15: 000055d151370220
[   13.858768]  </TASK>
[   13.858769] NMI backtrace for cpu 10
[   13.858769] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.060 msecs
[   13.858772] CPU: 10 UID: 0 PID: 373 Comm: kworker/u65:1 Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858776] Tainted: [U]=USER
[   13.858776] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858778] Workqueue: hci0 hci_rx_work [bluetooth]
[   13.858806] RIP: 0010:queued_spin_lock_slowpath+0x155/0x260
[   13.858809] Code: d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 eb f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 <8b> 03 66 85 c0 75 f7 89 c6 81 e6 00 00 ff ff 44 39 f6 75 0b be 01
[   13.858810] RSP: 0018:ffff91d9020f7bf8 EFLAGS: 00000002
[   13.858812] RAX: 00000000000c0101 RBX: ffff8b4f3792e880 RCX: ffff8b4f37aaf6c0
[   13.858813] RDX: 0000000000000000 RSI: 0000000000000101 RDI: ffff8b4f3792e880
[   13.858814] RBP: ffff91d9020f7c18 R08: ffff8b4dc1a81080 R09: 0000000000000004
[   13.858815] R10: ffff8b4dc2ab2900 R11: ffffffff91f79200 R12: ffff8b4f37a80000
[   13.858816] R13: 000000000000000b R14: 00000000002c0000 R15: 00000000002c0000
[   13.858817] FS:  0000000000000000(0000) GS:ffff8b4f37a80000(0000) knlGS:0000000000000000
[   13.858818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858819] CR2: 000029a8004ad100 CR3: 000000011fe0a000 CR4: 0000000000750ef0
[   13.858820] PKRU: 55555554
[   13.858821] Call Trace:
[   13.858822]  <NMI>
[   13.858823]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858826]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858828]  ? nmi_handle+0x59/0x160
[   13.858830]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858831]  ? default_do_nmi+0x46/0x110
[   13.858833]  ? exc_nmi+0xb1/0x110
[   13.858834]  ? end_repeat_nmi+0xf/0x53
[   13.858836]  ? __pfx_select_task_rq_fair+0x10/0x10
[   13.858838]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858840]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858841]  ? queued_spin_lock_slowpath+0x155/0x260
[   13.858842]  </NMI>
[   13.858843]  <TASK>
[   13.858843]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858845]  __task_rq_lock+0x32/0xd0
[   13.858847]  try_to_wake_up+0x63b/0x680
[   13.858849]  autoremove_wake_function+0x12/0x50
[   13.858851]  __wake_up_common+0x4e/0x80
[   13.858853]  __wake_up_common_lock+0x40/0x70
[   13.858855]  hci_event_packet+0x47a/0x4d0 [bluetooth 5843bc75f790d8b831f875f6e8e6260664f5dcd8]
[   13.858872]  ? __pfx_hci_cmd_complete_evt+0x10/0x10 [bluetooth 5843bc75f790d8b831f875f6e8e6260664f5dcd8]
[   13.858887]  ? __pfx_hci_cmd_sync_complete+0x10/0x10 [bluetooth 5843bc75f790d8b831f875f6e8e6260664f5dcd8]
[   13.858902]  hci_rx_work+0x1d4/0x4d0 [bluetooth 5843bc75f790d8b831f875f6e8e6260664f5dcd8]
[   13.858917]  process_scheduled_works+0x1fc/0x440
[   13.858920]  worker_thread+0x1c7/0x290
[   13.858922]  kthread+0xee/0x110
[   13.858924]  ? __pfx_worker_thread+0x10/0x10
[   13.858926]  ? __pfx_kthread+0x10/0x10
[   13.858928]  ret_from_fork+0x38/0x50
[   13.858931]  ? __pfx_kthread+0x10/0x10
[   13.858932]  ret_from_fork_asm+0x1a/0x30
[   13.858935]  </TASK>
[   13.858936] NMI backtrace for cpu 14
[   13.858936] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.226 msecs
[   13.858939] CPU: 14 UID: 251 PID: 890 Comm: trunksd Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.858942] Tainted: [U]=USER
[   13.858942] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.858944] RIP: 0010:queued_spin_lock_slowpath+0x140/0x260
[   13.858947] Code: c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 83 79 08 00 75 04 f3 90 <eb> f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb 06 31 d2 eb 02 f3 90 8b
[   13.858949] RSP: 0018:ffff91d902453600 EFLAGS: 00000046
[   13.858950] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f37baf6c0
[   13.858952] RDX: ffff8b4f37a00000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.858952] RBP: ffff91d902453620 R08: 0000000000000002 R09: ffff8b4dc2bbc3c0
[   13.858953] R10: 0000000000000005 R11: 0000000000000005 R12: ffff8b4f37b80000
[   13.858954] R13: 0000000000000000 R14: 00000000003c0000 R15: 00000000003c0000
[   13.858955] FS:  00007f0e938006c0(0000) GS:ffff8b4f37b80000(0000) knlGS:0000000000000000
[   13.858957] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.858958] CR2: 00007ab2a88f5000 CR3: 000000011f036000 CR4: 0000000000750ef0
[   13.858959] PKRU: 55555554
[   13.858959] Call Trace:
[   13.858960]  <NMI>
[   13.858961]  ? nmi_cpu_backtrace+0x101/0x130
[   13.858964]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.858966]  ? nmi_handle+0x59/0x160
[   13.858968]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858970]  ? default_do_nmi+0x46/0x110
[   13.858971]  ? exc_nmi+0xb1/0x110
[   13.858973]  ? end_repeat_nmi+0xf/0x53
[   13.858974]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858976]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858978]  ? queued_spin_lock_slowpath+0x140/0x260
[   13.858979]  </NMI>
[   13.858979]  <TASK>
[   13.858980]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.858982]  sched_balance_rq+0x15ff/0x1860
[   13.858984]  ? sched_balance_rq+0x536/0x1860
[   13.858988]  sched_balance_newidle+0x193/0x390
[   13.858990]  balance_fair+0x25/0x40
[   13.858991]  __schedule+0x899/0x1110
[   13.858993]  ? internal_add_timer+0x40/0x70
[   13.858996]  ? __mod_timer+0x1f9/0x2c0
[   13.858997]  schedule+0x5e/0x90
[   13.858999]  schedule_timeout+0x8f/0x100
[   13.859000]  ? __pfx_process_timeout+0x10/0x10
[   13.859002]  wait_for_completion_timeout+0x80/0xf0
[   13.859004]  i2c_dw_xfer+0x2e4/0x450
[   13.859007]  ? __timer_delete_sync+0x32/0x50
[   13.859009]  ? schedule_timeout+0x99/0x100
[   13.859010]  __i2c_transfer+0x254/0x480
[   13.859013]  ? wait_for_completion_timeout+0xc0/0xf0
[   13.859015]  tpm_cr50_i2c_transfer_message+0x2f/0x90
[   13.859019]  tpm_cr50_i2c_read+0xa7/0xe0
[   13.859021]  tpm_cr50_i2c_get_burst_and_status+0x67/0xf0
[   13.859023]  tpm_cr50_i2c_tis_send+0xa8/0x1f0
[   13.859024]  tpm_transmit+0xbd/0x330
[   13.859027]  tpm_dev_transmit+0x69/0xc0
[   13.859029]  tpm_common_write+0x10d/0x1b0
[   13.859030]  vfs_write+0x106/0x3c0
[   13.859032]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.859034]  ? __fget_files+0x9e/0xc0
[   13.859036]  ksys_write+0x71/0xe0
[   13.859038]  do_syscall_64+0x6a/0xe0
[   13.859040]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.859042]  ? do_syscall_64+0x76/0xe0
[   13.859044]  ? syscall_exit_to_user_mode+0xba/0x110
[   13.859046]  ? clear_bhb_loop+0x45/0xa0
[   13.859047]  ? clear_bhb_loop+0x45/0xa0
[   13.859048]  ? clear_bhb_loop+0x45/0xa0
[   13.859049]  ? clear_bhb_loop+0x45/0xa0
[   13.859050]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.859052] RIP: 0033:0x7f0e947282ad
[   13.859054] Code: e5 48 83 ec 20 48 89 55 e8 48 89 75 f0 89 7d f8 e8 a8 dc f8 ff 48 8b 55 e8 48 8b 75 f0 41 89 c0 8b 7d f8 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 ff dc f8 ff 48 8b
[   13.859055] RSP: 002b:00007f0e937fdfc0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[   13.859057] RAX: ffffffffffffffda RBX: 00007f0e937ff3f0 RCX: 00007f0e947282ad
[   13.859058] RDX: 0000000000000016 RSI: 00007f0e937ff3f1 RDI: 0000000000000004
[   13.859059] RBP: 00007f0e937fdfe0 R08: 0000000000000000 R09: 00007f0e937ff277
[   13.859059] R10: 000000000000002c R11: 0000000000000293 R12: 00007f0e93800508
[   13.859060] R13: 00007f0e937ff430 R14: 00007f0e937ff3f1 R15: 00005c154be7f860
[   13.859061]  </TASK>
[   13.859062] NMI backtrace for cpu 15
[   13.859062] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.353 msecs
[   13.859064] CPU: 15 UID: 228 PID: 1213 Comm: powerd Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.859068] Tainted: [U]=USER
[   13.859068] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.859069] RIP: 0010:queued_spin_lock_slowpath+0x138/0x260
[   13.859073] Code: 85 c0 74 3d 0f b7 c0 89 c2 c1 ea 02 83 e0 03 48 c1 e0 04 48 c7 c6 f8 ff ff ff 48 8b 94 d6 e0 b9 8e 93 48 89 8c 10 c0 f6 02 00 <83> 79 08 00 75 04 f3 90 eb f6 48 8b 11 48 85 d2 74 05 0f 0d 0a eb
[   13.859074] RSP: 0018:ffff91d9029a75e0 EFLAGS: 00000046
[   13.859075] RAX: 0000000000000000 RBX: ffff8b4f3792e880 RCX: ffff8b4f37bef6c0
[   13.859076] RDX: ffff8b4f37b00000 RSI: fffffffffffffff8 RDI: ffff8b4f3792e880
[   13.859077] RBP: ffff91d9029a7600 R08: 0000000000000002 R09: ffff8b4dc2bbc3c0
[   13.859078] R10: 0000000000000005 R11: 0000000000000005 R12: ffff8b4f37bc0000
[   13.859079] R13: 0000000000000000 R14: 0000000000400000 R15: 0000000000400000
[   13.859080] FS:  000079758680e380(0000) GS:ffff8b4f37bc0000(0000) knlGS:0000000000000000
[   13.859081] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.859082] CR2: 00007975867fb2a8 CR3: 000000011c75e000 CR4: 0000000000750ef0
[   13.859083] PKRU: 55555554
[   13.859083] Call Trace:
[   13.859085]  <NMI>
[   13.859085]  ? nmi_cpu_backtrace+0x101/0x130
[   13.859088]  ? nmi_cpu_backtrace_handler+0x11/0x20
[   13.859090]  ? nmi_handle+0x59/0x160
[   13.859092]  ? queued_spin_lock_slowpath+0x138/0x260
[   13.859093]  ? default_do_nmi+0x46/0x110
[   13.859095]  ? exc_nmi+0xb1/0x110
[   13.859096]  ? end_repeat_nmi+0xf/0x53
[   13.859098]  ? queued_spin_lock_slowpath+0x138/0x260
[   13.859099]  ? queued_spin_lock_slowpath+0x138/0x260
[   13.859101]  ? queued_spin_lock_slowpath+0x138/0x260
[   13.859102]  </NMI>
[   13.859103]  <TASK>
[   13.859103]  raw_spin_rq_lock_nested+0x4c/0x80
[   13.859105]  sched_balance_rq+0x15ff/0x1860
[   13.859109]  sched_balance_newidle+0x193/0x390
[   13.859111]  balance_fair+0x25/0x40
[   13.859113]  __schedule+0x899/0x1110
[   13.859114]  ? timerqueue_add+0x86/0xa0
[   13.859117]  ? hrtimer_start_range_ns+0x225/0x2f0
[   13.859118]  schedule+0x5e/0x90
[   13.859120]  schedule_hrtimeout_range_clock+0xc2/0x130
[   13.859121]  ? __pfx_hrtimer_wakeup+0x10/0x10
[   13.859123]  poll_schedule_timeout+0x39/0x50
[   13.859125]  do_sys_poll+0x456/0x540
[   13.859129]  ? __pfx_pollwake+0x10/0x10
[   13.859132]  __se_sys_poll+0x70/0x100
[   13.859134]  do_syscall_64+0x6a/0xe0
[   13.859137]  ? exc_page_fault+0x202/0x6a0
[   13.859139]  ? clear_bhb_loop+0x45/0xa0
[   13.859140]  ? clear_bhb_loop+0x45/0xa0
[   13.859141]  ? clear_bhb_loop+0x45/0xa0
[   13.859141]  ? clear_bhb_loop+0x45/0xa0
[   13.859142]  entry_SYSCALL_64_after_hwframe+0x71/0x79
[   13.859145] RIP: 0033:0x79758700e54d
[   13.859146] Code: e5 48 83 ec 20 89 55 ec 48 89 75 f0 48 89 7d f8 e8 08 9a f8 ff 8b 55 ec 48 8b 75 f0 41 89 c0 48 8b 7d f8 b8 07 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 2b 44 89 c7 89 45 f8 e8 60 9a f8 ff 8b 45 f8
[   13.859147] RSP: 002b:00007fff3c887bb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000007
[   13.859148] RAX: ffffffffffffffda RBX: 00005a9d12e10270 RCX: 000079758700e54d
[   13.859149] RDX: 0000000000001388 RSI: 0000000000000001 RDI: 00007fff3c887be8
[   13.859150] RBP: 00007fff3c887bd0 R08: 0000000000000000 R09: 0000000000000000
[   13.859151] R10: 00000000307c7ab4 R11: 0000000000000293 R12: 0000000000001388
[   13.859152] R13: 00007fff3c887be8 R14: 0000000000000006 R15: 0000000000001388
[   13.859153]  </TASK>
[   13.859154] INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.445 msecs
[   13.859707] Kernel panic - not syncing: Hard LOCKUP
[   13.860709] CPU: 11 UID: 1000 PID: 1906 Comm: chrome Tainted: G     U             6.11.0-rc1-gf98706d6143f #1 81cb23e540eaf624ddfa1fedbb424f372f28936e
[   13.860713] Tainted: [U]=USER
[   13.860715] Hardware name: Google XXXX/XXXX, BIOS Google_XXXX.14373.0.0 12/01/2021
[   13.860717] Call Trace:
[   13.860719]  <IRQ>
[   13.860721]  dump_stack_lvl+0x40/0xb0
[   13.860725]  panic+0x10f/0x2b0
[   13.860729]  nmi_panic+0x2b/0x40
[   13.860734]  watchdog_hardlockup_check+0x1a2/0x210
[   13.860737]  watchdog_timer_fn+0x5f/0x2a0
[   13.860740]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   13.860743]  __hrtimer_run_queues+0xc8/0x250
[   13.860746]  hrtimer_interrupt+0xf7/0x210
[   13.860748]  __sysvec_apic_timer_interrupt+0x48/0x130
[   13.860752]  sysvec_apic_timer_interrupt+0x73/0x90
[   13.860756]  </IRQ>
[   13.860757]  <TASK>
[   13.860759]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   13.860763] RIP: 0010:smp_call_function_many_cond+0x33c/0x4e0
[   13.860766] Code: 25 ff ff ff 00 74 34 f3 48 0f bc c8 83 f9 17 77 2a 49 8b 06 89 ca 48 8b 14 d5 e0 b9 8e 93 f7 44 02 08 01 00 00 00 74 0c f3 90 <8b> 74 10 08 40 f6 c6 01 75 f4 ff c1 83 f9 18 72 b7 65 48 8b 04 25
[   13.860769] RSP: 0000:ffff91d904653c90 EFLAGS: 00000202
[   13.860771] RAX: 0000000000033940 RBX: 0000000000000003 RCX: 0000000000000008
[   13.860774] RDX: ffff8b4f37a00000 RSI: 0000000000000011 RDI: 0000000000000001
[   13.860776] RBP: ffff91d904653d10 R08: ffffffff91efe030 R09: 000000000000000b
[   13.860778] R10: ffffffff9424a540 R11: ffffffff91efd800 R12: ffffffff91efd800
[   13.860780] R13: 0000000000000008 R14: ffff8b4f37aefac0 R15: 0000000000000202
[   13.860783]  ? __pfx_flush_tlb_func+0x10/0x10
[   13.860785]  ? __pfx_flush_tlb_func+0x10/0x10
[   13.860788]  ? __pfx_tlb_is_not_lazy+0x10/0x10
[   13.860791]  ? __pfx_flush_tlb_func+0x10/0x10
[   13.860794]  on_each_cpu_cond_mask+0x21/0x40
[   13.860797]  flush_tlb_mm_range+0xde/0x140
[   13.860800]  ptep_clear_flush+0x3f/0x50
[   13.860804]  do_wp_page+0x963/0xae0
[   13.860806]  handle_mm_fault+0x75c/0x8e0
[   13.860809]  exc_page_fault+0x1e5/0x6a0
[   13.860813]  asm_exc_page_fault+0x22/0x30
[   13.860816] RIP: 0033:0x55a61bcc1012
[   13.860818] Code: 82 81 f8 64 48 8b 04 25 28 00 00 00 48 3b 45 f0 75 0a 48 89 d8 48 83 c4 28 5b 5d c3 e8 27 df 08 07 8b 05 39 78 03 08 8d 48 01 <89> 0d 30 78 03 08 85 c0 7e 01 c3 55 48 89 e5 53 50 48 8d 3d 26 40
[   13.860821] RSP: 002b:00007fff49204d58 EFLAGS: 00010206
[   13.860824] RAX: 0000000000000000 RBX: 00007fff49204dd0 RCX: 0000000000000001
[   13.860826] RDX: 0000000000000001 RSI: 000029a8006201e0 RDI: 000029a8006201e0
[   13.860828] RBP: 00007fff49204d70 R08: 000029ac00027288 R09: 000029a80061c400
[   13.860830] R10: 0000000000000001 R11: 0000000000000000 R12: 000029ac0001e9c0
[   13.860832] R13: 000029ac00022f80 R14: 00007fff49204dd0 R15: 000055a61880600c
[   13.860835]  </TASK>
[   14.928548] Shutting down cpus with NMI
[   14.928562] Kernel Offset: 0x10e00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   14.931576] gsmi: Log Shutdown Reason 0x02

