Return-Path: <linux-kernel+bounces-396717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF29BD132
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7523A1F219D8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB94A14EC56;
	Tue,  5 Nov 2024 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gT1tRnBM"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449F13D881
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730822149; cv=none; b=lwuC0tJmM5Zwierh4bSklCK4SlVSx2A1ZBJCcVmaC2wL2zjJD75E3C8wF/f7CW1zY8/Ew/q/y7NMhtuG0mezh9aHOROxeiX7EHruABnT5ybAPAMap20/SfGPsY+j07gppXXD4PArGutG4kleMUGj1gH+62zTTK/wKZj5ejMcHHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730822149; c=relaxed/simple;
	bh=nWb1HOt8cRSpQY98hl5t7b6oucAdW5CbPshgvAQYbJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APFV+obqIq6Syd1rTU5GwS63c449qq9XDuLj3CHRYXP1VxDB1oWK6lDYobDB0j7Ok7r5XdmpZpODvr0vk9hE/rmuf0RjHuz3hRp9nZjdeONzALHXw8TuOcaUVS7z1RiYHaUYPovVMzD36Ik+Zhm1Y3GjrKvewvay3TWq1Gwq4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gT1tRnBM; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730822139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0EuUsdK8fEGUB6ZfmWdVcefFHr5cHk997POUTni/11k=;
	b=gT1tRnBMkjAbEq6crVfW4D3AojwyteAQ0nAj+U4HzVZwKuE8LJucqhoCHgRgDZX9IufDjr
	BxkPeIbO8K/nPaFjx4kkh4R+qIhR02SDqfkEMA26kvSX04zVHJv20LNEK44y7UIk06HWHE
	q89kw0pAwRJ3Gzxlo3UqYtcMv+03Gls=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	mingo@redhat.com,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com,
	tglx@linutronix.de,
	ytcoode@gmail.com,
	yuntao.wang@linux.dev
Subject: Re: [linus:master] [kexec]  816d334afa: Mem-Info
Date: Tue,  5 Nov 2024 23:55:19 +0800
Message-ID: <20241105155519.57530-1-yuntao.wang@linux.dev>
In-Reply-To: <ZyBRxoV6SVT2kIXu@MiWiFi-R3L-srv>
References: <ZyBRxoV6SVT2kIXu@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 29 Oct 2024 11:08:54 +0800, Baoquan He <bhe@redhat.com> wrote:

> Hi Yuntao,
> 
> On 10/23/24 at 04:30pm, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "Mem-Info" on:
> > 
> > commit: 816d334afa85c836080b41bb6238aea845615ad9 ("kexec: modify the meaning of the end parameter in kimage_is_destination_range()")
> 
> Can you check what happened with your patch?

Hi Baoquan,

Sorry for the late response, I missed this email.

This issue seems quite similar to the previous one:

https://lore.kernel.org/lkml/ZkcD9H0P8O7Me5Do@xpf.sh.intel.com/t/#u

Once again, I still could not figure out why this commit is causing this issue.

Could someone else please take a look?

Thanks in advance!
Yuntao
 
> Thanks
> Baoquan
> 
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master      c2ee9f594da826bea183ed14f2cc029c719bf4da]
> > [test failed on linux-next/master 7436324ebd147598f940dde1335b7979dbccc339]
> > 
> > in testcase: trinity
> > version: 
> > with following parameters:
> > 
> > 	runtime: 600s
> > 
> > 
> > 
> > config: x86_64-randconfig-r032-20220801
> > compiler: gcc-12
> > test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > we observed the issue happen randomly but keep clean on parent
> > 
> > 
> > 5c28913ed04b29ef 816d334afa85c836080b41bb623
> > ---------------- ---------------------------
> >        fail:runs  %reproduction    fail:runs
> >            |             |             |
> >            :100         41%          41:100   dmesg.Mem-Info
> > 
> > 
> > and from below Call Trace, seems be related to changes in 816d334afa. FYI
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202410231602.fecf96df-lkp@intel.com
> > 
> > 
> > 
> > [  183.284967][ T2438] trinity-c2: page allocation failure: order:1, mode:0x10cc0(GFP_KERNEL|__GFP_NORETRY), nodemask=(null),cpuset=/,mems_allowed=0
> > [  183.287021][ T2438] CPU: 0 PID: 2438 Comm: trinity-c2 Not tainted 6.7.0-rc4-00178-g816d334afa85 #1
> > [  183.288291][ T2438] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  183.289719][ T2438] Call Trace:
> > [  183.290202][ T2438]  <TASK>
> > [ 183.290556][ T2438] dump_stack_lvl (lib/dump_stack.c:107) 
> > [ 183.291233][ T2438] dump_stack (lib/dump_stack.c:114) 
> > [ 183.291773][ T2438] warn_alloc (mm/page_alloc.c:3391) 
> > [ 183.292370][ T2438] ? zone_watermark_ok_safe (mm/page_alloc.c:3370) 
> > [ 183.293136][ T2438] ? get_page_from_freelist (mm/page_alloc.c:3513) 
> > [ 183.293882][ T2438] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
> > [ 183.294602][ T2438] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4423) 
> > [ 183.295385][ T2438] __alloc_pages_slowpath+0x17d2/0x1b00 
> > [ 183.296285][ T2438] ? __zone_watermark_ok (mm/page_alloc.c:2968) 
> > [ 183.297011][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
> > [ 183.297719][ T2438] ? warn_alloc (mm/page_alloc.c:4041) 
> > [ 183.298306][ T2438] ? get_page_from_freelist (include/linux/mmzone.h:1651 mm/page_alloc.c:3187) 
> > [ 183.299017][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
> > [ 183.299639][ T2438] __alloc_pages (mm/page_alloc.c:4581) 
> > [ 183.300162][ T2438] ? asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:645) 
> > [ 183.300851][ T2438] ? __alloc_pages_slowpath+0x1b00/0x1b00 
> > [ 183.301627][ T2438] ? kimage_alloc_pages (arch/x86/include/asm/bitops.h:55 (discriminator 3) include/asm-generic/bitops/instrumented-atomic.h:29 (discriminator 3) include/linux/page-flags.h:492 (discriminator 3) kernel/kexec_core.c:303 (discriminator 3)) 
> > [ 183.302230][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
> > [ 183.302840][ T2438] kimage_alloc_pages (include/linux/gfp.h:238 include/linux/gfp.h:261 include/linux/gfp.h:274 kernel/kexec_core.c:295) 
> > [ 183.303436][ T2438] kimage_alloc_control_pages (kernel/kexec_core.c:369 kernel/kexec_core.c:480) 
> > [ 183.304126][ T2438] ? kimage_free_page_list (kernel/kexec_core.c:475) 
> > [ 183.304774][ T2438] kimage_alloc_init (kernel/kexec.c:63) 
> > [ 183.305362][ T2438] do_kexec_load (kernel/kexec.c:125) 
> > [ 183.305910][ T2438] ? kimage_alloc_init (kernel/kexec.c:89) 
> > [ 183.306496][ T2438] ? ftrace_likely_update (arch/x86/include/asm/smap.h:56 kernel/trace/trace_branch.c:229) 
> > [ 183.307107][ T2438] __x64_sys_kexec_load (kernel/kexec.c:255 kernel/kexec.c:235 kernel/kexec.c:235) 
> > [ 183.307750][ T2438] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
> > [ 183.308284][ T2438] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
> > [  183.308968][ T2438] RIP: 0033:0x463519
> > [ 183.309465][ T2438] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db 59 00 00 c3 66 2e 0f 1f 84 00 00 00 00
> > All code
> > ========
> >    0:	00 f3                	add    %dh,%bl
> >    2:	c3                   	ret
> >    3:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
> >    a:	00 00 00 
> >    d:	0f 1f 40 00          	nopl   0x0(%rax)
> >   11:	48 89 f8             	mov    %rdi,%rax
> >   14:	48 89 f7             	mov    %rsi,%rdi
> >   17:	48 89 d6             	mov    %rdx,%rsi
> >   1a:	48 89 ca             	mov    %rcx,%rdx
> >   1d:	4d 89 c2             	mov    %r8,%r10
> >   20:	4d 89 c8             	mov    %r9,%r8
> >   23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
> >   28:	0f 05                	syscall
> >   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
> >   30:	0f 83 db 59 00 00    	jae    0x5a11
> >   36:	c3                   	ret
> >   37:	66                   	data16
> >   38:	2e                   	cs
> >   39:	0f                   	.byte 0xf
> >   3a:	1f                   	(bad)
> >   3b:	84 00                	test   %al,(%rax)
> >   3d:	00 00                	add    %al,(%rax)
> > 	...
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
> >    6:	0f 83 db 59 00 00    	jae    0x59e7
> >    c:	c3                   	ret
> >    d:	66                   	data16
> >    e:	2e                   	cs
> >    f:	0f                   	.byte 0xf
> >   10:	1f                   	(bad)
> >   11:	84 00                	test   %al,(%rax)
> >   13:	00 00                	add    %al,(%rax)
> > 	...
> > [  183.312022][ T2438] RSP: 002b:00007ffe4d586468 EFLAGS: 00000246 ORIG_RAX: 00000000000000f6
> > [  183.313222][ T2438] RAX: ffffffffffffffda RBX: 00000000000000f6 RCX: 0000000000463519
> > [  183.314330][ T2438] RDX: 00007f3d966eb000 RSI: 0000000000000001 RDI: 00007f3d966e9000
> > [  183.315440][ T2438] RBP: 00007f3d97011000 R08: 0000000000000051 R09: 0000000000001000
> > [  183.316561][ T2438] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
> > [  183.317678][ T2438] R13: 00007f3d97011058 R14: 000000000109a850 R15: 00007f3d97011000
> > [  183.318855][ T2438]  </TASK>
> > [  183.324046][ T2438] Mem-Info:
> > [  183.324538][ T2438] active_anon:5181 inactive_anon:9601 isolated_anon:0
> > [  183.324538][ T2438]  active_file:0 inactive_file:0 isolated_file:0
> > [  183.324538][ T2438]  unevictable:85008 dirty:0 writeback:0
> > [  183.324538][ T2438]  slab_reclaimable:24508 slab_unreclaimable:111403
> > [  183.324538][ T2438]  mapped:11081 shmem:7595 pagetables:757
> > [  183.324538][ T2438]  sec_pagetables:0 bounce:0
> > [  183.324538][ T2438]  kernel_misc_reclaimable:0
> > [  183.324538][ T2438]  free:22807 free_pcp:846 free_cma:0
> > [  183.365634][ T2438] Node 0 active_anon:20724kB inactive_anon:38404kB active_file:0kB inactive_file:0kB unevictable:340032kB isolated(anon):0kB isolated(file):0kB mapped:44324kB dirty:0kB writeback:0kB shmem:30380kB writeback_tmp:0kB kernel_stack:3776kB pagetables:3028kB sec_pagetables:0kB all_unreclaimable? yes
> > [  183.369581][ T2438] DMA free:15296kB boost:0kB min:16kB low:28kB high:40kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > [  183.373381][ T2438] lowmem_reserve[]: 0 2813 13774 13774
> > [  183.374261][ T2438] DMA32 free:46624kB boost:0kB min:3064kB low:5944kB high:8824kB reserved_highatomic:0KB active_anon:8kB inactive_anon:2888kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:3129216kB managed:2958668kB mlocked:0kB bounce:0kB free_pcp:2712kB local_pcp:996kB free_cma:0kB
> > [  183.378286][ T2438] lowmem_reserve[]: 0 0 10961 10961
> > [  183.379256][ T2438] Normal free:42560kB boost:4096kB min:16040kB low:27264kB high:38488kB reserved_highatomic:4096KB active_anon:20716kB inactive_anon:35516kB active_file:0kB inactive_file:0kB unevictable:340032kB writepending:0kB present:13631488kB managed:11224244kB mlocked:392kB bounce:0kB free_pcp:492kB local_pcp:464kB free_cma:0kB
> > [  183.383570][ T2438] lowmem_reserve[]: 0 0 0 0
> > [  183.384357][ T2438] DMA: 0*4kB 0*8kB 0*16kB 0*32kB 1*64kB (U) 1*128kB (U) 1*256kB (U) 1*512kB (U) 0*1024kB 1*2048kB (U) 3*4096kB (M) = 15296kB
> > [  183.386517][ T2438] DMA32: 80*4kB (UME) 4*8kB (M) 4*16kB (ME) 6*32kB (UME) 3*64kB (UME) 4*128kB (UM) 3*256kB (UME) 5*512kB (UM) 5*1024kB (M) 2*2048kB (ME) 8*4096kB (M) = 46624kB
> > [  183.389206][ T2438] Normal: 524*4kB (UMEH) 445*8kB (UME) 410*16kB (UME) 382*32kB (UMEH) 154*64kB (UME) 41*128kB (U) 8*256kB (U) 1*512kB (U) 0*1024kB 0*2048kB 0*4096kB = 42104kB
> > [  183.391793][ T2438] 92505 total pagecache pages
> > [  183.392602][ T2438] 0 pages in swap cache
> > [  183.393232][ T2438] Free swap  = 0kB
> > [  183.393819][ T2438] Total swap = 0kB
> > [  183.394352][ T2438] 4194174 pages RAM
> > [  183.394916][ T2438] 0 pages HighMem/MovableOnly
> > [  183.395645][ T2438] 644606 pages reserved
> > [  183.396135][ T2438] 0 pages cma reserved
> > 
> > 
> > 
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241023/202410231602.fecf96df-lkp@intel.com
> > 
> > 
> > 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> > 

