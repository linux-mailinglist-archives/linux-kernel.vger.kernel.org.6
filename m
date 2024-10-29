Return-Path: <linux-kernel+bounces-387693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F659B54C2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088BB1C22906
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF04208227;
	Tue, 29 Oct 2024 21:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUZhBL4E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C5F20721D;
	Tue, 29 Oct 2024 21:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236377; cv=none; b=NdT2SIb8pCLuwCUwx3M0uwPdKan3zrFEp3Dx78Vq5KWSWJqUL/IbeJO4UMt8QmTfjKSlx8TdJa4kVy52cOxOKJq01nAxFkzAcAk6Uv7ts7TQTo57t6gthYS+oU30UDYsgLD5tiwBg6uslEMmBr5y1WdyjHrejxTaOhaGMxjfBtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236377; c=relaxed/simple;
	bh=pnnz6YJDVpo+3JTcic1igBBQy1GhxvWeinL48k0cWgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbbTxAuNQhQlO7VHPDTfPGu3eIIQ9F4WJ6FbLKLzN8Tq0zQJzN3n1r9EpADrsVE3ONflFjX8hNYwX665nnsQ0uZwZ6TlYIRKlebiVxsgt2xT5T+fQAPzdOx1PB9kZPhMFNL+bJyhkTKW5dONO/7+xjeFZy02tAY6IcjVOSBp7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUZhBL4E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C15C4CECD;
	Tue, 29 Oct 2024 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730236376;
	bh=pnnz6YJDVpo+3JTcic1igBBQy1GhxvWeinL48k0cWgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUZhBL4Eo3t4GUDy8k/WDYtsR5ehOcnR/VJnQfb1OvD4VB0Av8XmoyDPfz3cHXYNz
	 Fz1hggskdcR7K5jHLtN6N0mC8Wk3uLs7ZUtUGqhcRH4WcMBt0Wpq6XwqB0/2/4A/s/
	 fy/YYEl3m74LzW5ZWglWkkH0qFkxQJXDLRWUaoTiGk1v0FPf4uxGDFoWiCJ5WHFpsO
	 8PC7VjP9ivr4WT4ZHOVUWgGd5YohSWix2WqAYYxGbnu11ZvFfbNb1GgdVmGW8MpuZk
	 lIYyvY0WhtEHh3Izc1t+SqqQWhGo1buejpUmmTQzTfCcwLb0216ZVoQdodEGRlw8kI
	 qz8guzvURO6lw==
Date: Tue, 29 Oct 2024 14:12:54 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: naveen@kernel.org, anil.s.keshavamurthy@intel.com, davem@davemloft.net,
	kees@kernel.org, gustavoars@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/3] kprobes: Annotate structs with __counted_by()
Message-ID: <20241029211254.GA4146593@thelio-3990X>
References: <20240813115334.3922580-1-ruanjinjie@huawei.com>
 <20240813115334.3922580-2-ruanjinjie@huawei.com>
 <20241022205557.GA3004519@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022205557.GA3004519@thelio-3990X>

On Tue, Oct 22, 2024 at 01:56:01PM -0700, Nathan Chancellor wrote:
> Hi,
> 
> On Tue, Aug 13, 2024 at 07:53:32PM +0800, Jinjie Ruan wrote:
> > Add the __counted_by compiler attribute to the flexible array member
> > stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> > ---
> >  kernel/kprobes.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index da59c68df841..e6f7b0d3b29c 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -92,7 +92,7 @@ struct kprobe_insn_page {
> >  	struct kprobe_insn_cache *cache;
> >  	int nused;
> >  	int ngarbage;
> > -	char slot_used[];
> > +	char slot_used[] __counted_by(nused);
> >  };
> >  
> >  #define KPROBE_INSN_PAGE_SIZE(slots)			\
> > -- 
> > 2.34.1
> > 
> 
> This change was not properly tested. In next-20241022, where this
> changes appears as commit 0888460c9050 ("kprobes: Annotate structs with
> __counted_by()"), I get a fortify failure because ->nused is initialized
> after the call to memset(). For example, with Debian's powerpc64le
> configuration (which is just the first configuration I happened to see
> this warning in, I don't think it is architecture specific):
> 
>   $ curl -LSso .config https://github.com/nathanchance/llvm-kernel-testing/raw/096eeab130a9077206d3ddd6f0c6e39187113869/configs/debian/powerpc64le.config
> 
>   $ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- LLVM=1 olddefconfig zImage.epapr
> 
>   $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20230707-182910/ppc64le-rootfs.cpio.zst | zstd -d >rootfs.cpio
> 
>   $ qemu-system-ppc64 \
>       -display none \
>       -nodefaults \
>       -device ipmi-bmc-sim,id=bmc0 \
>       -device isa-ipmi-bt,bmc=bmc0,irq=10 \
>       -machine powernv \
>       -kernel arch/powerpc/boot/zImage.epapr \
>       -initrd rootfs.cpio \
>       -m 2G \
>       -serial mon:stdio
>   ...
>   [    0.000000] Linux version 6.12.0-rc4-next-20241022 (nathan@n3-xlarge-x86) (ClangBuiltLinux clang version 19.1.2 (https://github.com/llvm/llvm-project.git 7ba7d8e2f7b6445b60679da826210cdde29eaf8b), ClangBuiltLinux LLD 19.1.2 (https://github.com/llvm/llvm-project.git 7ba7d8e2f7b6445b60679da826210cdde29eaf8b)) #1 SMP Tue Oct 22 20:24:37 UTC 2024
>   ...
>   [    0.138628] ------------[ cut here ]------------
>   [    0.138816] memset: detected buffer overflow: 512 byte write of buffer size 0
>   [    0.140141] WARNING: CPU: 0 PID: 1 at lib/string_helpers.c:1033 __fortify_report+0x60/0x80
>   [    0.142208] Modules linked in:
>   [    0.142722] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc4-next-20241022 #1
>   [    0.143379] Hardware name: IBM PowerNV (emulated by qemu) POWER10 0x801200 opal:v7.1 PowerNV
>   [    0.143810] NIP:  c000000000900920 LR: c00000000090091c CTR: 0000000000000000
>   [    0.144098] REGS: c000000002acf290 TRAP: 0700   Not tainted  (6.12.0-rc4-next-20241022)
>   [    0.144457] MSR:  9000000002029033 <SF,HV,VEC,EE,ME,IR,DR,RI,LE>  CR: 24800280  XER: 00000000
>   [    0.145048] CFAR: c00000000014e414 IRQMASK: 0
>   [    0.145048] GPR00: c00000000090091c c000000002acf530 c0000000017bf0e0 0000000000000041
>   [    0.145048] GPR04: c0000000025911f8 c0000000ffffefff 0000000000000003 0000000000000001
>   [    0.145048] GPR08: 0000000000000003 0000000000000004 0000000000000000 9000000002001033
>   [    0.145048] GPR12: 0000000000800000 c00000000289e000 c000000000010eb8 0000000000000000
>   [    0.145048] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>   [    0.145048] GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000027fba70
>   [    0.145048] GPR24: 61c8864680b583eb 0000000000000000 0000000000001000 0000000000000000
>   [    0.145048] GPR28: c000000002a83400 c00000000262de68 c00000000262de30 c000000002acf5b0
>   [    0.147696] NIP [c000000000900920] __fortify_report+0x60/0x80
>   [    0.147934] LR [c00000000090091c] __fortify_report+0x5c/0x80
>   [    0.148277] Call Trace:
>   [    0.148465] [c000000002acf530] [c00000000090091c] __fortify_report+0x5c/0x80 (unreliable)
>   [    0.148855] [c000000002acf590] [c000000000900958] __fortify_panic+0x18/0x40
>   [    0.149133] [c000000002acf5b0] [c0000000002e3508] __get_insn_slot+0x308/0x320
>   [    0.149413] [c000000002acf620] [c0000000000586c4] arch_prepare_kprobe+0x1e4/0x270
>   [    0.149699] [c000000002acf6b0] [c0000000002e496c] register_kprobe+0x4cc/0x8e0
>   [    0.149975] [c000000002acf930] [c0000000020154ac] arch_init_kprobes+0x30/0x54
>   [    0.150262] [c000000002acf960] [c0000000020411bc] init_kprobes+0x80/0x120
>   [    0.150524] [c000000002acf9d0] [c000000000010630] do_one_initcall+0x120/0x3e0
>   [    0.150798] [c000000002acfd50] [c000000002005cb8] do_pre_smp_initcalls+0x70/0x114
>   [    0.151082] [c000000002acfd90] [c000000002005b70] kernel_init_freeable+0x14c/0x224
>   [    0.151365] [c000000002acfde0] [c000000000010eec] kernel_init+0x3c/0x250
>   [    0.151622] [c000000002acfe50] [c00000000000de3c] ret_from_kernel_user_thread+0x14/0x1c
>   [    0.151935] --- interrupt: 0 at 0x0
>   [    0.152433] Code: 3cc2fffc 70630001 3c62ffa0 78841f48 38c6f388 38636489 7c86202a 3cc2ff9c 38c62f30 7cc8305e 4b84d9e1 60000000 <0fe00000> 38210060 e8010010 7c0803a6
>   [    0.153155] ---[ end trace 0000000000000000 ]---
>   ...
> 
> Even if the current ->nused assignment is moved before the call to
> memset(), the failure still occurs because 1 is clearly wrong for the
> size of memset(), which is 512 bytes for this configuration. Could this
> instance of memset() be avoided by using kzalloc() for the kip
> allocation? Could also take the opportunity to use struct_size(). The
> following diff fixes this issue for me but I did not do any further
> testing. If this does not work for some reason and there is no other
> obvious solution, I think this change should be reverted.

Ping? I still see this on next-20241029. I can also reproduce it with a
tip of tree GCC.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 98d71a5acb72..6adb0cc4e45c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -95,10 +95,6 @@ struct kprobe_insn_page {
>  	char slot_used[] __counted_by(nused);
>  };
>  
> -#define KPROBE_INSN_PAGE_SIZE(slots)			\
> -	(offsetof(struct kprobe_insn_page, slot_used) +	\
> -	 (sizeof(char) * (slots)))
> -
>  static int slots_per_page(struct kprobe_insn_cache *c)
>  {
>  	return PAGE_SIZE/(c->insn_size * sizeof(kprobe_opcode_t));
> @@ -175,7 +171,7 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
>  		goto retry;
>  
>  	/* All out of space.  Need to allocate a new page. */
> -	kip = kmalloc(KPROBE_INSN_PAGE_SIZE(slots_per_page(c)), GFP_KERNEL);
> +	kip = kzalloc(struct_size(kip, slot_used, slots_per_page(c)), GFP_KERNEL);
>  	if (!kip)
>  		goto out;
>  
> @@ -185,10 +181,8 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
>  		goto out;
>  	}
>  	INIT_LIST_HEAD(&kip->list);
> -	memset(kip->slot_used, SLOT_CLEAN, slots_per_page(c));
> -	kip->slot_used[0] = SLOT_USED;
>  	kip->nused = 1;
> -	kip->ngarbage = 0;
> +	kip->slot_used[0] = SLOT_USED;
>  	kip->cache = c;
>  	list_add_rcu(&kip->list, &c->pages);
>  	slot = kip->insns;

