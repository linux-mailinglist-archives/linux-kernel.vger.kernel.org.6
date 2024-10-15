Return-Path: <linux-kernel+bounces-365541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 181CB99E3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EBA1F237F5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686941E4110;
	Tue, 15 Oct 2024 10:28:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30641E3DC1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 10:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728988131; cv=none; b=B/v9fvbObsMOcQj4oPzVLsbtgeJm68WXFcCNaTn0PE1QwKoKegJapet0Y5rzlfUXYVv6BmIH/rh5FJ/0cmlJJCdabuSIOkYoyYeACZKmrElvMPusat+WhDye2sEngw9rOXK2ats9eMTGqB4N2Wyi2SdShOnUY8fsk7gkeomWMlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728988131; c=relaxed/simple;
	bh=MVIT2QHvSMocs7OLgNlG0SRuI3Y8nqW8V9Sgkq7MZ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcDi+v0WyJXN9LmOWnTEvNm17fNFDU+uFqwnTrVcVz0S+N8bU6nosMfd9a1Vt6kgClFhvQmMgcy7f/+3EM+/wgWRita8EAe1D9qs7HLQF6Xien+ZH1NHRDp3lBVfLij67XMKIpGUpxyXu0FBRjNbvqlNdIRU8C6blWb4ILk12pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEBFA1007;
	Tue, 15 Oct 2024 03:29:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05F963F71E;
	Tue, 15 Oct 2024 03:28:45 -0700 (PDT)
Date: Tue, 15 Oct 2024 11:28:41 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	Antonio Borneo <antonio.borneo@foss.st.com>
Subject: Re: Crash on armv7-a using KASAN
Message-ID: <Zw5D2aTkkUVOK89g@J2N7QTR9R3>
References: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1a1d062-f3a2-4d05-9836-3b098de9db6d@foss.st.com>

On Mon, Oct 14, 2024 at 03:19:49PM +0200, Clement LE GOFFIC wrote:
> Hello,

Hi,

I think what's happening here is that when switching from prev to next
in the scheduler, we switch to next's mm before we actually switch to
next's register state, and there's a transient window where prev is
executed using next's mm. AFAICT we don't map prev's KASAN stack shadow
into next's mm anywhere, and so inlined KASAN_STACK checks recursively
fault on this until we switch to the overflow stack.

More details on that below.

Linus, are you able to look into this?

> I have detected a kernel crash in latest kernel on armv7-a when Kasan is
> enabled.
> Git bisect points to Ard commit from 2021 :
> b6506981f880 ARM: unwind: support unwinding across multiple stacks
> ardb@kernel.org
> 
> This part of code is outside my expertise and I'm unable to propose a fix.
> Below there is a simple way to replicate the crash inside qemu.
> The offending commit is a preliminary patch of a series aimed at managing
> multiple stacks.
> The crash log from the offending commit differs with the crash log from
> latest kernel due to the extra patches in the mentioned series.
> 
> Step to reproduce :
> 1. Ensure `qemu-system-arm` and `arm-none-eabi-gcc` are installed on your
> system
> 
> 2. Get a filesystem. I found a Debian installer filesystem (publicly
> available):
> $> wget http://ftp.us.debian.org/debian/dists/stable/main/installer-armhf/current/images/cdrom/initrd.gz
> 
> 3. Configure and build the kernel with KASAN enabled:
> $> echo 'CONFIG_KASAN=y' > arch/arm/configs/fragment-kasan.config
> $> make ARCH=arm CROSS_COMPILE=arm-none-eabi- vexpress_defconfig
> fragment-kasan.config
> $> make ARCH=arm CROSS_COMPILE=arm-none-eabi- -j16 all
> 
> 4. Run the kernel in QEMU:
> $> qemu-system-arm -kernel arch/arm/boot/zImage -machine vexpress-a15 -dtb
> arch/arm/boot/dts/arm/vexpress-v2p-ca15-tc1.dtb -append "console=ttyAMA0"
> -initrd initrd.gz -m 512 -smp 2
> 
> 5. When the "Select a language" menu appears, press ESC, in the new menu
> select "Execute a shell", then "Continue"
> 
> 6. The crash may appear directly during boot. If not, you can stress the
> system with syscalls by running ten or more executions in parallel of:
> $> find /usr/ -type f -exec grep randomStringToSearch {} \;&
> 
> 7. Wait for a kernel crash.
> 
> Thank you for looking into this issue. Please let me know if you need any
> further information.
> 
> Best regards,
> 
> Clément Le Goffic
> 
> NB: Two kernel crash dumps are following each other.
> 
> Crash log with recent kernel (v6.12-rc3) :
> 
> ~ # Insufficient stack space to handle exception!
> Task stack:     [0xac000000..0xac004000]
> IRQ stack:      [0xa0808000..0xa080c000]
> Overflow stack: [0x82964000..0x82965000]
> Internal error: kernel stack overflow: 0 [#1] SMP ARM
> Modules linked in:
> CPU: 1 UID: 0 PID: 1678 Comm: grep Not tainted 6.12.0-rc3 #2
> Hardware name: ARM-Versatile Express
> PC is at do_translation_fault+0x30/0x2b0
> LR is at do_DataAbort+0x74/0x1dc
> pc : [<80125920>]    lr : [<80125c14>]    psr: 200f0193
> sp : ac000008  ip : 00000051  fp : ac003d54
> r10: ac003d20  r9 : 82412640  r8 : 00000005
> r7 : ac000068  r6 : 7480002b  r5 : ac000068  r4 : 7480002b
> r3 : 74800015  r2 : ac000068  r1 : 00000005  r0 : ac0000a8
> Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 88a8406a  DAC: 00000051

[...]

>  __dabt_svc from do_translation_fault+0x30/0x2b0
>  do_translation_fault from do_DataAbort+0x74/0x1dc
>  do_DataAbort from __dabt_svc+0x4c/0x80
> Exception stack(0xac003ad8 to 0xac003b20)
> 3ac0:                                                       ac003bc8
> 00000005
> 3ae0: ac003b88 74800779 7480078f ac003b88 7480078f ac003b88 00000005
> 82412640
> 3b00: ac003d20 ac003d54 00000051 ac003b28 80125c14 80125920 200f0193
> ffffffff
>  __dabt_svc from do_translation_fault+0x30/0x2b0
>  do_translation_fault from do_DataAbort+0x74/0x1dc
>  do_DataAbort from __dabt_svc+0x4c/0x80
> Exception stack(0xac003b88 to 0xac003bd0)
> 3b80:                   ac003c78 00000805 ac003c38 7480078f 74800798
> ac003c38
> 3ba0: 74800798 ac003c38 00000805 82412640 ac003d20 ac003d54 00000051
> ac003bd8
> 3bc0: 80125c14 80125920 200f0193 ffffffff
>  __dabt_svc from do_translation_fault+0x30/0x2b0
>  do_translation_fault from do_DataAbort+0x74/0x1dc
>  do_DataAbort from __dabt_svc+0x4c/0x80

The above frames are the same; whatever the kernel is accessing at
do_translation_fault+0x30 is causing this to go recursive...

I can reproduce this, pretty easily, with a similar enough trace, though
faddr2line isn't happy to give me a line number. The relevant asm is:

| 801272d8 <do_translation_fault>:
| 801272d8:       e92d4ff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, lr}
| 801272dc:       e30f3fff        movw    r3, #65535      @ 0xffff
| 801272e0:       e3463edf        movt    r3, #28383      @ 0x6edf
| 801272e4:       e24dd00c        sub     sp, sp, #12
| 801272e8:       e1500003        cmp     r0, r3
| 801272ec:       9a00008b        bls     80127520 <do_translation_fault+0x248>
| 801272f0:       e1a04000        mov     r4, r0
| 801272f4:       e2820040        add     r0, r2, #64     @ 0x40
| 801272f8:       e1a05002        mov     r5, r2
| 801272fc:       e1a07001        mov     r7, r1
| 80127300:       e1a031a0        lsr     r3, r0, #3
| 80127304:       e283345f        add     r3, r3, #1593835520     @ 0x5f000000
| 80127308:       e1d320d0        ldrsb   r2, [r3]

... with the LDRSB at 80127308 being the faulting instruction.

It looks like that's an access of the shadow, given 0x5f000000 is a shadow
offset per arch/arm/Kconfig:

| 1052 config KASAN_SHADOW_OFFSET
| 1053         hex
| 1054         depends on KASAN
| 1055         default 0x1f000000 if PAGE_OFFSET=0x40000000
| 1056         default 0x5f000000 if PAGE_OFFSET=0x80000000
| 1057         default 0x9f000000 if PAGE_OFFSET=0xC0000000
| 1058         default 0x8f000000 if PAGE_OFFSET=0xB0000000
| 1059         default 0xffffffff

Using addr2line on that address gives me:

| do_translation_fault
| /home/mark/src/linux/arch/arm/mm/fault.c:477

... with the nearby context being:

| 474         if (addr < TASK_SIZE)
| 475                 return do_page_fault(addr, fsr, regs);
| 476 
| 477         if (user_mode(regs))
| 478                 goto bad_area;

... so it looks like a shadow access for 'regs' is faulting. Looking at the
asm, that appears to be the case; with the redundant asm removed it clearly
calculates a shadow address for the argument in r2 (which is 'regs').

| 801272f4:       e2820040        add     r0, r2, #64     @ 0x40
| 80127300:       e1a031a0        lsr     r3, r0, #3
| 80127304:       e283345f        add     r3, r3, #1593835520     @ 0x5f000000
| 80127308:       e1d320d0        ldrsb   r2, [r3]

... so evidently the KASAN shadow for the stack is not mapped at this point for
some reason, but when we get to the overflow stack all is well.

> Exception stack(0xac003c38 to 0xac003c80)
> 3c20:                                                       9ab7bb00
> 8652c000
> 3c40: f1f1f1f1 f3f3f304 833bc800 9ab7bb00 83850900 833bcc88 9ab7bb00
> 74800798
> 3c60: ac003d20 ac003d54 00000000 ac003c88 81dceb28 801e7c40 600f0093
> ffffffff
>  __dabt_svc from mm_cid_get+0x5c/0x668
>  mm_cid_get from __schedule+0xcb4/0x23a4

The initial fault was taken from mm_cid_get+0x5c. In my compiled version I see
this from mm_cid_get+0x60/0x61c, where the relevant asm is:

| 801ead54 <mm_cid_get>:
| 801ead54:       e92d4ff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, lr}
| 801ead58:       e3082ab3        movw    r2, #35507      @ 0x8ab3
| 801ead5c:       e34421b5        movt    r2, #16821      @ 0x41b5
| 801ead60:       e28db020        add     fp, sp, #32
| 801ead64:       e24dd0a4        sub     sp, sp, #164    @ 0xa4
| 801ead68:       e24b3024        sub     r3, fp, #36     @ 0x24
| 801ead6c:       e3c3a01f        bic     sl, r3, #31
| 801ead70:       e1a08000        mov     r8, r0
| 801ead74:       e24a3060        sub     r3, sl, #96     @ 0x60
| 801ead78:       e50b10ac        str     r1, [fp, #-172] @ 0xffffff54
| 801ead7c:       e1a091a3        lsr     r9, r3, #3
| 801ead80:       e50a2060        str     r2, [sl, #-96]  @ 0xffffffa0
| 801ead84:       e289c45f        add     ip, r9, #1593835520     @ 0x5f000000
| 801ead88:       e30b2f38        movw    r2, #48952      @ 0xbf38
| 801ead8c:       e3482216        movt    r2, #33302      @ 0x8216
| 801ead90:       e50bc0b0        str     ip, [fp, #-176] @ 0xffffff50
| 801ead94:       e30f31f1        movw    r3, #61937      @ 0xf1f1
| 801ead98:       e34f31f1        movt    r3, #61937      @ 0xf1f1
| 801ead9c:       e50a205c        str     r2, [sl, #-92]  @ 0xffffffa4
| 801eada0:       e30a2d54        movw    r2, #44372      @ 0xad54
| 801eada4:       e348201e        movt    r2, #32798      @ 0x801e
| 801eada8:       e50a2058        str     r2, [sl, #-88]  @ 0xffffffa8
| 801eadac:       e2812064        add     r2, r1, #100    @ 0x64
| 801eadb0:       e50b20c4        str     r2, [fp, #-196] @ 0xffffff3c
| 801eadb4:       e58c3000        str     r3, [ip]

... with the STR at 801eadb4 being the faulting instruction, and that also
appears to be a faulting KASAN shadow access given ip has that same 0x5f000000
offset.

Per addr2line, that's:

| mm_cid_get
| /home/mark/src/linux/kernel/sched/sched.h:3691

Where the surrounding context is:

| 3690 static inline int mm_cid_get(struct rq *rq, struct mm_struct *mm)
| 3691 {
| 3692         struct mm_cid __percpu *pcpu_cid = mm->pcpu_cid;
| 3693         struct cpumask *cpumask;
| 3694         int cid;
| 3695 
| 3696         lockdep_assert_rq_held(rq);
| 3697         cpumask = mm_cidmask(mm);
| 3698         cid = __this_cpu_read(pcpu_cid->cid);

Where IIUC that caller is switch_mm_cid(), which has:

| 3760         if (next->mm_cid_active)
| 3761                 next->last_mm_cid = next->mm_cid = mm_cid_get(rq, next->mm);

Removing the redundant instructions, the important sequence is:

| 801ead54 <mm_cid_get>:
| 801ead54:       e92d4ff0        push    {r4, r5, r6, r7, r8, r9, sl, fp, lr}
| 801ead60:       e28db020        add     fp, sp, #32
| 801ead68:       e24b3024        sub     r3, fp, #36     @ 0x24
| 801ead6c:       e3c3a01f        bic     sl, r3, #31
| 801ead74:       e24a3060        sub     r3, sl, #96     @ 0x60
| 801ead7c:       e1a091a3        lsr     r9, r3, #3
| 801ead84:       e289c45f        add     ip, r9, #1593835520     @ 0x5f000000
| 801ead94:       e30f31f1        movw    r3, #61937      @ 0xf1f1
| 801ead98:       e34f31f1        movt    r3, #61937      @ 0xf1f1
| 801eadb4:       e58c3000        str     r3, [ip]

... where IIUC it's initialising the stack shadow for local variables.

So again, it looks like the KASAN shadow for the stack is not mapped...

It looks like this is called under context_switch(), where we do:

	/* switch_mm_cid() requires the memory barriers above. */
	switch_mm_cid(rq, prev, next);

	prepare_lock_switch(rq, next, rf);

	/* Here we just switch the register state and the stack. */
	switch_to(prev, next, prev);
	barrier();

... so we're using the new task's mm, but still executing in the context of the
old task (and using its stack). I suspect the new task's mm doesn't have the
old task's stack shadow mapped in, and AFAICT we don't map that in explicitly
anywhere before we switch to the new mm.

Linus, can you look into that?

[...]

> Crash log with kernel at offending commit (b6506981f880):
> 
> 8<--- cut here ---
> Unable to handle kernel NULL pointer dereference at virtual address 00000012
> [00000012] *pgd=00000000
> Internal error: Oops: 5 [#1] SMP ARM
> Modules linked in:
> CPU: 1 PID: 1641 Comm: find Tainted: G    B             5.16.0-rc1+ #1
> Hardware name: ARM-Versatile Express
> PC is at __read_once_word_nocheck+0x0/0x8
> LR is at unwind_frame+0x3f8/0x874

This looks to be a distinct issue; it looks like we explicitly access an offset
from NULL, and this looks like it'd be fp->pc.

There have been a number of fixes since commit b6506981f880, and this might be
one of those which has been fixed already.

Mark.

> pc : [<80112b48>]    lr : [<80112ffc>]    psr: 60000113
> sp : 82d67998  ip : 801cff34  fp : 810cc2cc
> r10: 00000001  r9 : 00000000  r8 : 82d67aa0
> r7 : 00000483  r6 : 00000016  r5 : 82d67a10  r4 : 00000012
> r3 : 00000000  r2 : 00000083  r1 : 00000010  r0 : 00000012
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> Control: 10c5387d  Table: 888c806a  DAC: 00000051
> Register r0 information: non-paged memory
> Register r1 information: zero-size pointer
> Register r2 information: non-paged memory
> Register r3 information: NULL pointer
> Register r4 information: non-paged memory
> Register r5 information: non-slab/vmalloc memory
> Register r6 information: non-paged memory
> Register r7 information: non-paged memory
> Register r8 information: non-slab/vmalloc memory
> Register r9 information: NULL pointer
> Register r10 information: non-paged memory
> Register r11 information: non-slab/vmalloc memory
> Register r12 information: non-slab/vmalloc memory
> Process find (pid: 1641, stack limit = 0xf7b89a2f)
> Stack: (0x82d67998 to 0x82d68000)
> 7980:                                                       00004000
> 00000012
> 79a0: 82d67adc 82d67ae0 82d67ae8 824fbd40 6f5acf3c ffffc000 82d67ae4
> 00000000
> 79c0: 00000001 82d67e74 00000000 80359e68 00002c8b 00002c8b 00000400
> 000003f7
> 79e0: 41b58ab3 80fd9554 80112c04 00000000 00000001 00000005 00000000
> 00000000
> 7a00: 824fbd40 00000000 824fbd40 00000000 00000003 824fbd40 82d67f40
> 6f5acfdc
> 7a20: 824fc3bc 6e86ea3c 0000000b 0000001e 00000051 00000012 8033d154
> 00000000
> 7a40: 810c9e28 80100060 00000078 1d5cffa2 00000000 82d67b80 82d67c50
> 6f5acf54
> 7a60: 00000008 824fbd40 82d67c50 82d67ce0 00000001 801808cc 00002c8b
> ffffc000
> 7a80: 82d67bac 00000000 008002a9 80112bd0 810cbb48 82d67bfc 810c9e28
> 80100060
> 7aa0: 41b58ab3 1d5cffa2 80180650 824fbd40 6f5acf64 824fbd40 00000000
> 00000000
> 7ac0: 801c51d8 000000c8 82d67afc 8010dc54 82d67b40 00000000 00000000
> 0000001e
> 7ae0: 82d67ec8 8033d154 80c4d2ac 1d5cffa2 0000000b 82d67b80 83158080
> 801cffb8
> 7b00: 00000000 00000000 000030ef 000030ef 00000400 0000033b 0000273d
> 0000000c
> 7b20: 41b58ab3 80fe3f84 801cff34 00000005 00000000 00000000 82d67c64
> 00000000
> 7b40: 00000009 00000040 82d67b98 00000001 6ee00000 82d67fa8 80100060
> 00000000
> 7b60: 41b58ab3 80fd9554 80112c04 1d5cffa2 00000000 824fbd40 0000003c
> 1d5cffa2
> 7b80: 00000000 83158004 00000800 83158000 81897700 80322d6c 8032466c
> 80323150
> 7ba0: 8032165c 801c51d8 8010132c 80134788 80100b10 80c4d2ac 80c4d2ac
> 00000000
> 7bc0: 0000b6ee 80194ae0 00003000 00000001 8117bc80 0000000c 00000001
> 00002954
> 7be0: 80d2a4e0 00000000 00000000 81245940 0000294d 801bf3c8 6f5acf84
> 00000001
> 7c00: 9a9b6388 82d67d80 00000070 0000001d 0000753f 81245180 81245180
> 00002954
> 7c20: 81245188 81430b24 9a9bd3c0 00000000 81430b24 801c3ce4 00000cc0
> 00000012
> 7c40: 9a9bd430 00000003 801948f4 00000001 00000000 80d2a2e0 00002954
> 80d2a320
> 7c60: 81430b24 9a9bd400 8142af20 801c3ee8 00000000 9a9b6388 00000000
> 00000000
> 7c80: 00000020 9a9bd3c0 9a9bd3c0 81245180 00000000 81245184 9a9bd3cc
> 83158000
> 7ca0: 9ec54b00 8032466c 00000000 80323150 83158000 81897700 801c51d8
> 9ec54b00
> 7cc0: 8144eb80 81245180 824fbd44 8032165c 60000113 80c558d4 00000000
> 81245180
> 7ce0: 81245940 81245940 824fbd40 00000001 8142af84 82d67d80 81245180
> 801c51d8
> 7d00: 00000000 818adf2c 818adf00 80181b10 0000000a 00000000 8142af80
> 00000000
> 7d20: 81206ccc 9a9bd400 824fbf54 81430b24 6f5acfac 824fbd48 8142ad80
> 82d67dc0
> 7d40: 9a9bd424 8143efe0 812070e4 9a9bd448 9a9bd3c0 00000001 00000000
> fffffffb
> 7d60: 41b58ab3 80fe3708 801c4df4 801da208 824fbd40 00000016 00000000
> 9a9c0200
> 7d80: 84847ba0 81a025a0 00000007 00000000 9a9c0200 00091069 00048834
> 00000000
> 7da0: 81896980 801cfe54 4f512b00 9a9c0200 00000016 00989680 00000000
> 00000001
> 7dc0: 19841000 801ebfd0 00000000 822ce180 00000000 1d5cffa2 81894800
> 812050a4
> 7de0: 00000002 00000009 8142a7c0 00000002 824fbd40 81175380 824fbd44
> 8010132c
> 7e00: 0000001b 824fbd40 00000100 19841000 81205080 81175358 0000000a
> 801a454c
> 7e20: 811752d0 8117b840 8117b840 ffffb03e 81205d00 00404040 824fbf54
> 80d143c0
> 7e40: 0000000b 81446da0 19841000 82d67e68 82d67eac 824fc3bc 824fbd40
> 0000000b
> 7e60: 0000001e 80134788 80c4d2ac 60000013 ffffffff 80100b10 824fbd40
> 00000000
> 7e80: 824fbd40 00000000 00000003 824fbd40 82d67f40 6f5acfdc 824fc3bc
> 6e86ea3c
> 7ea0: 0000000b 0000001e 00000051 82d67ec8 8033d154 80c4d2ac 60000013
> ffffffff
> 7ec0: 00000051 8033d144 00000000 6ecff000 00000000 802e8b20 82be3400
> 00100000
> 7ee0: 41b58ab3 80ff5ed8 8033d0a0 0006edff 822ce180 00000000 6ee00000
> 82be3400
> 7f00: 6e86e4f8 82be3444 00000001 8285f000 8285f008 82be3400 822ce1a8
> 80197c9c
> 7f20: 8285f000 822ce180 00000001 8033e988 6edfffff 822ce184 00000cc0
> 824fbd40
> 7f40: 824fbf54 1d5cffa2 824fbd40 8285f000 82305500 ffffff9c 6e86e4f8
> 8033f418
> 7f60: 00000000 0000000b 0000001e 6e86e4f8 6e86ea3c 6e86e4f8 0000000b
> 80100284
> 7f80: 824fbd40 0000000b 0000001e 803409d4 00000000 6e86e4f8 0000000b
> 66cf7360
> 7fa0: 00000001 80100060 66cf7360 00000001 6e86e470 6e86e4f8 6e86ea3c
> 70657267
> 7fc0: 66cf7360 00000001 6e86e4f8 0000000b 6e86ea3c 00000000 6e86ebd0
> 0000001e
> 7fe0: 6e86e47e 6e86e46c 66c68cf5 66c68758 80000030 6e86e470 00000000
> 00000000
> [<80112b48>] (__read_once_word_nocheck) from [<80112ffc>]
> (unwind_frame+0x3f8/0x874)
> [<80112ffc>] (unwind_frame) from [<8010dc54>] (__save_stack_trace+0x70/0x94)
> [<8010dc54>] (__save_stack_trace) from [<801cffb8>]
> (stack_trace_save+0x84/0xac)
> [<801cffb8>] (stack_trace_save) from [<80322d6c>]
> (kasan_set_track+0x2c/0x58)
> [<80322d6c>] (kasan_set_track) from [<8032466c>]
> (kasan_set_free_info+0x20/0x34)
> [<8032466c>] (kasan_set_free_info) from [<80323150>]
> (__kasan_slab_free+0xdc/0x108)
> [<80323150>] (__kasan_slab_free) from [<8032165c>]
> (kmem_cache_free+0x80/0x304)
> [<8032165c>] (kmem_cache_free) from [<801c51d8>] (rcu_core+0x3e4/0xc1c)
> [<801c51d8>] (rcu_core) from [<8010132c>] (__do_softirq+0x17c/0x4dc)
> [<8010132c>] (__do_softirq) from [<80134788>] (irq_exit+0xb4/0xfc)
> [<80134788>] (irq_exit) from [<80100b10>] (__irq_svc+0x50/0x68)
> Exception stack(0x82d67e78 to 0x82d67ec0)
> 7e60:                                                       824fbd40
> 00000000
> 7e80: 824fbd40 00000000 00000003 824fbd40 82d67f40 6f5acfdc 824fc3bc
> 6e86ea3c
> 7ea0: 0000000b 0000001e 00000051 82d67ec8 8033d154 80c4d2ac 60000013
> ffffffff
> [<80100b10>] (__irq_svc) from [<80c4d2ac>] (__cond_resched+0x0/0x64)
> 

