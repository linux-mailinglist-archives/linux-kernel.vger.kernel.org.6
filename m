Return-Path: <linux-kernel+bounces-243089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB6929173
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1B1F226BF
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20823741;
	Sat,  6 Jul 2024 07:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="obBieLA1"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDFC22EE4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720250703; cv=none; b=R5mdCoiVEPgr+VJ6zYTZeTSP3ECV9kvSgD/+lg4j+lVFFffEauZnHoE243xSWaVyD6l4+xqwUdDfj6rDy3tlyBHMz1P4z5BvPEd1PrfN/zxqAnDj6mEdlPDcCFec166gyKuzCtXfuRFWZMTGyQZfHmL5XqdRhFTGr0+YmS0RJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720250703; c=relaxed/simple;
	bh=/DdiIPqa5tH2kZOOu8nmRlttA0monFsAOUcUN1HldhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lra0q7eh8PXlcmH1uwESFzi09BdimsLI+UsxkP85+Df9tVz9pBtKWsTnVSMCg32BIh7bdlLbrENND0r79GkDGwr6kvN1AUm7O5nr+r46XvZTzcuJGO7hQ04+jtAmMev8dmI3enz0Q5CckN97pqRdi6G+wafCFPmQP2pSZy8u/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=obBieLA1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xGdheUenmNwaEUYa4vrPZFuS1XhkjyAUWG8jCK6KoFk=; b=obBieLA10y5E1PGhDlfuxRwHe1
	b2ESR8lkpbR6xR8rGWwrOEB3tVql+s4JNBR53t+Snao2UNtM/NKN57qvGguWHIVYgQB6U4UiwTFuT
	VNAfk7o7kHowCdlxpNw2VO5bT8JMFGF3j8lwubFxjMyRD/nt/nY5Q043BfMlt+oOLJCUw75hvzZb0
	boGwAb+573aC2NlbyYY4eDqtmc4NF+SrV1aTznHrujx8Nl7HTEy31sJZFZp2EXM0Hqd+p7dM+nWpx
	XIs3KN9ee11CL1/ROH+8K1njh8lnzYPQ1Lmpl/MUypk4W8NWmpxPX8MQKYJSR74jUEMeKa8945zvF
	/YmugySg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35736)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sPzmh-000106-08;
	Sat, 06 Jul 2024 08:24:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sPzmi-0005rV-3D; Sat, 06 Jul 2024 08:24:40 +0100
Date: Sat, 6 Jul 2024 08:24:39 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: wanglinhui <wanglinhui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	wangfangpeng1@huawei.com, zhangxun38@huawei.com,
	yangzhuohao1@huawei.com
Subject: Re: [PATCH] ARM: Fix "external abort on non-linefetch" kernel panic
 caused by userspace
Message-ID: <ZojxN5iOHhGAt3A5@shell.armlinux.org.uk>
References: <20240706032005.122654-1-wanglinhui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706032005.122654-1-wanglinhui@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Jul 06, 2024 at 11:20:05AM +0800, wanglinhui wrote:
> 0x16800000 is a peripheral physical address that supports only
> 4-byte-aligned access.
> 
> Use /dev/mem to enable the user space to access 0x16800000. Then userspace
> unexpectedly tried to read four bytes from 0x16800001 (actually access
> its virtual address), which caused the kernel to trigger an
> "external abort on non-linefetch" panic:
> 
>   Unhandled fault: external abort on non-linefetch (0x1018) at 0x0100129b
>   [0100129b] *pgd=85038831, *pte=16801703, *ppte=16801e33
>   Internal error: : 1018 [#1] SMP ARM
>   ...
>   CPU: 2 PID: xxxx Comm: xxxx Tainted: G           O      5.10.0 #1
>   Hardware name: Hisilicon A9
>   PC is at do_alignment_ldrstr+0xb8/0x100
>   LR is at 0xc1f203fc
>   psr: 200f0313
>   sp : c7081ed4  ip : 00000008  fp : 00000011
>   r10: b42250c8  r9 : c7081f0c  r8 : c7081fb0
>   r7 : 0100129b  r6 : 00000004  r5 : 00000000  r4 : e5908000
>   r3 : 00000000  r2 : c7081f0c  r1 : 200f0210  r0 : 0100129b
>   Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>   Control: 1ac5387d  Table: 82c3c04a  DAC: 55555555
>   Process LcnNCoreTask (pid: 4049, stack limit = 0x14066b0e)
>   Call trace:
>     do_alignment_ldrstr
>     --do_alignment
>     ----do_DataAbort
>     ------__dabt_usr
> 
> It triggers a data abort exception twice. The first time occurs when
> an unaligned address is accessed in user mode. The second time occurs
> when the peripheral address is actually accessed in kernel mode,
> and it crashes the kernel. However, the code location for the second
> data abort is as follows:
> 
>   ```
>   #define __get8_unaligned_check(ins, val, addr, err) \
>   	__asm__(\
>    ARM("1: "ins" %1, [%2], #1\n") \ <-- Second data abort is triggered here
>    THUMB("1: "ins" %1, [%2]\n") \
>    THUMB(" add %2, %2, #1\n") \
>   	"2:\n" \
>   	" .pushsection .text.fixup,\"ax\"\n" \
>   ```
> 
> It is an exception table entry that can be fixed up.
> 
> There is another test that indicates that
> "external abort on non-linefetch" needs to be fixed up.
> 
> Similarly, use /dev/mem to map 0x16800000 to the user space.
> Pass 0x16800001 (actually passes its virtual address) to the
> kernel via the write() system call and write 1 byte.
> It also causes the kernel to trigger an
> "external abort on non-linefetch" panic:
> 
>   Unhandled fault: external abort on non-linefetch (0x1018) at 0xb6f95000
>   [b6f95000] *pgd=83fb6831, *pte=16800783, *ppte=16800e33
>   Internal error: : 1018 [#1] SMP ARM
>   ...
>   CPU: 1 PID: xxxx Comm: xxxx Tainted: G           O      5.10.0 #1
>   Hardware name: Hisilicon A9
>   PC is at __get_user_1+0x14/0x20
>   LR is at iov_iter_fault_in_readable+0x7c/0x198
>   psr: 800b0213
>   sp : c195be18  ip : 00000001  fp : c35a2478
>   r10: c06b5260  r9 : 00000000  r8 : c356fee0
>   r7 : ffffe000  r6 : b6f95000  r5 : 00000001  r4 : c195bf10
>   r3 : b6f95000  r2 : f7f95000  r1 : beffffff  r0 : b6f95000
>   Call trace looks like:
>     __get_user_1
>     --iov_iter_fault_in_readable
>     ----generic_perform_write
>     ------__generic_file_write_iter
>     --------generic_file_write_iter
> 
> The location of the instruction that triggers the data abort
> is as follows:
>   ```
>   ENTRY(__get_user_1)
>   	check_uaccess r0, 1, r1, r2, __get_user_bad
>   1: TUSER(ldrb) r2, [r0] <-- Data abort is triggered here
>   	mov r0, #0
>   	ret lr
>   ENDPROC(__get_user_1)
>   _ASM_NOKPROBE(__get_user_1)
>   ```
> It is also an exception table entry that can be fixed up.
> 
> Address passed in from user space should not crash the kernel.
> Therefore, fixup_exception() is added to fix up such exception.

NAK because:

1) you're using /dev/mem which requires privileges - you're holding
   the gun, pointing it at your foot.

2) you're performing an unaligned access to a device which is
   architecturally not permitted - you're pulling the trigger.

It's not surprising that the result is you've shot yourself in the
foot!

If you access /dev/mem, then you need to know what you're doing and
you must access it according to the requirements of the memory space
you are accessing, otherwise undefined behaviour will occur - not
only architecturally, but also by the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

