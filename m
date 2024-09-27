Return-Path: <linux-kernel+bounces-341648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7790C9882FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 13:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAE81C2137C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F95188A19;
	Fri, 27 Sep 2024 11:04:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E48939AD6;
	Fri, 27 Sep 2024 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727435048; cv=none; b=n6zEw32TEaJVKcRUvzzS3blD0ttDFGrvGaBk7DSyp2iLEH7FZegyYehbqQCiWy4qKAwgczbUfOMjO796APbAUcVodXm5IoL7ouw4W8/Ntr4f9DfnnpuGBkTRrlLKEyxO2rr8KIE3IFbGZXB90GnLdSx77uPspuDVISZHlbO4mVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727435048; c=relaxed/simple;
	bh=Y4rcvCDAdeYvUPe4nn9t94GcJUqUTEe/gAfLrq1/GM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPOP1dm2OAWrMOKxVdYdGL3R0/kShQnNFEUUohjsERX0xo+bLsn0Cl+fclRua44DJ1hFaQ1Pab8pH8F838Fiv4LjStcYHO7Lu9g0I6fWrAdLWN0Y1wOQqi/OjiG17mzEhIaMQDkv8uBA02n/wZzGffN3cKLAxxSh0ntt5N35bRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BFFC4CEC4;
	Fri, 27 Sep 2024 11:04:06 +0000 (UTC)
Date: Fri, 27 Sep 2024 12:04:04 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>, Andrew <quark@disroot.org>
Subject: Re: [regression] segfault in Qt apps running on Linux kernel 6.10.8
 ARM with LPAE
Message-ID: <ZvaRJK8GQR7GYHnZ@arm.com>
References: <bf8288c9-13a1-47f0-9842-3b8eff37ef65@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf8288c9-13a1-47f0-9842-3b8eff37ef65@leemhuis.info>

On Wed, Sep 25, 2024 at 02:23:35PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Catalin, Linus, I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by a change of yours:
> 
> 7af5b901e84743 ("ARM: 9358/2: Implement PAN for LPAE by TTBR0 page table
> walks disablement") [v6.10-rc1]
> 
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to write this mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=219247 :
> 
> > Trying to run LxQt on a Chromebook XE303C12 with Devuan 4 and Linux
> > kernel 6.10.8 results in a segmentation fault (for LxQt). There are
> > no such problems with Linux kernel 6.9.12 or earlier. With Linux
> > kernel 6.10.8 it is possible to run Xfce4, but trying to run for
> > example Kate ends in a segmentation fault. Mesa 20.3.5, patched for
> > partial hardware acceleration, preserves this acceleration in Xfce4.
> > The mpv works using acceleration regardless of the Linux kernel
> > version. dmesg does not give anything significantly new compared to
> > previous kernel version.
> 
> See the ticket for more details and the bisection log. The reporter is CCed.

I had a quick look and the fault seems to be a level 2 translation fault
while in user space (code 0x206). I can't tell whether the fault address
is valid and we just messed up the pairing of user access enable/disable
or something else happened. Having TTBCR.PD0 == 1 does lead to
translation faults, though not sure what the DFSR register says. Anyway,
normally I'd expect do_page_fault() to get stuck in a continuous fault
loop if the vma was valid rather than end up with SIGSEGV.

Andrew, could you please share the .config file you have, maybe attach
it to the bugzilla report? Also, could you try the kernel with
CONFIG_CPU_TTBR0_PAN disabled without any patches reverted?

Another thing to try is invalidate the TLBs before returning to user,
just in case those TTBCR bits are cached in the TLB in a way we did not
envisage. Untested diff below:

----------------8<--------------------------------
diff --git a/arch/arm/include/asm/uaccess-asm.h b/arch/arm/include/asm/uaccess-asm.h
index 4bccd895d954..c00b400b7f4d 100644
--- a/arch/arm/include/asm/uaccess-asm.h
+++ b/arch/arm/include/asm/uaccess-asm.h
@@ -91,6 +91,9 @@
 	bic	\tmp, \tmp, #TTBCR_EPD0 | TTBCR_T0SZ_MASK
 	bic	\tmp, \tmp, #TTBCR_A1
 	mcr	p15, 0, \tmp, c2, c0, 2		@ write TTBCR
+	isb
+	mcr	p15, 0, \tmp, c8, c7, 0		@ invalidate TLBs
+	dsb
 	.if	\isb
 	instr_sync
 	.endif
----------------8<--------------------------------

Thanks.

-- 
Catalin

