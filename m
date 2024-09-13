Return-Path: <linux-kernel+bounces-327477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC7977679
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E5BD1C24297
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E895F4A3E;
	Fri, 13 Sep 2024 01:42:23 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E13FE4
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726191743; cv=none; b=P+IX112tmUcijUpZrQI8Nyv5w2YpVouS3VcgpxnI7QvIVP3Ar8WQgjWxRf9TfoM7e50q5u6FD+g0WtVV9gwMsaC7/HbB88FnoIiSSu6XD8Z77vOUMu/magTniqrIQ7nqVcjl1gSbay4k5ANhxJr3ZzEHpL94pVWyrqdCabu+heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726191743; c=relaxed/simple;
	bh=BVBPAKskZ2e4xhJDy2mkhR5EOL7VIVzmaqEZVTE+tEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soUdgbdwxOqXZQQhw61pD5Zd41kovhBYlvbvvTd8JvhyUp9YZuM7c17zg49kw+Ek5qchVx20C1tJC3TKdSxaJWhQ0+ivcz0MopvK9bXGNiOaElbKV93bJghQIs2e6/69IkA97xYZ83nBOEuYOLiD6e1gQbpwyAKk0fT/Qbk/Zik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz10t1726191665tzs1mm
X-QQ-Originating-IP: ntUUR5HCbH45R31EnJtFXoJQJMPf/PsHyejSfRzk1nE=
Received: from HX09040029.powercore.com.cn ( [180.171.104.254])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 09:40:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6794888667536814964
Date: Fri, 13 Sep 2024 09:40:29 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, jialong.yang@shingroup.cn,
	luming.yu@gmail.com
Subject: Re: [PATCH 1/2] powerpc/entry: convert to common and generic entry
Message-ID: <153FD6B5CE4F97D9+ZuOYDQ-iHIIwJjbh@HX09040029.powercore.com.cn>
References: <B4ABABEA5F13B86A+20240912082500.1469-1-luming.yu@shingroup.cn>
 <fc509bcd-5ca0-4dc2-962e-766a01cbe4fb@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc509bcd-5ca0-4dc2-962e-766a01cbe4fb@csgroup.eu>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1

On Thu, Sep 12, 2024 at 12:23:29PM +0200, Christophe Leroy wrote:
> 
> 
> Le 12/09/2024 à 10:24, Luming Yu a écrit :
> > From: Yu Luming <luming.yu@gmail.com>
> > 
> > convert powerpc entry code in syscall and fault to use syscall_work
> > and irqentry_state as well as common calls from generic entry infrastructure.
> > 
> > Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> > ---
> >   arch/powerpc/Kconfig                   | 1 +
> >   arch/powerpc/include/asm/hw_irq.h      | 5 +++++
> >   arch/powerpc/include/asm/processor.h   | 6 ++++++
> >   arch/powerpc/include/asm/syscall.h     | 5 +++++
> >   arch/powerpc/include/asm/thread_info.h | 1 +
> >   arch/powerpc/kernel/syscall.c          | 6 +++++-
> >   arch/powerpc/mm/fault.c                | 5 +++++
> >   7 files changed, 28 insertions(+), 1 deletion(-)
> 
> There is another build problem:
> 
>   CC      kernel/entry/common.o
> kernel/entry/common.c: In function 'irqentry_exit':
> kernel/entry/common.c:335:21: error: implicit declaration of function
> 'regs_irqs_disabled'; did you mean 'raw_irqs_disabled'?
> [-Werror=implicit-function-declaration]
>   335 |         } else if (!regs_irqs_disabled(regs)) {
>       |                     ^~~~~~~~~~~~~~~~~~
>       |                     raw_irqs_disabled
> 
> 
> You have put regs_irqs_disabled() in a section dedicated to PPC64, so it
> fails on PPC32.
> 
> 
> After fixing this problem and providing an empty asm/entry-common.h it is
> now possible to build the kernel. But that's not enough, the board is stuck
> after:
> 
> ...
> [    2.871391] Freeing unused kernel image (initmem) memory: 1228K
> [    2.877990] Run /init as init process

Thanks for these questions. :-)
I haven't gotten chance to run it in ppc32 qemu.
the common syscall trace enter lost this hunk
-       if (!is_32bit_task())
-               audit_syscall_entry(regs->gpr[0], regs->gpr[3], regs->gpr[4],
-                                   regs->gpr[5], regs->gpr[6]);
-       else
-               audit_syscall_entry(regs->gpr[0],
-                                   regs->gpr[3] & 0xffffffff,
-                                   regs->gpr[4] & 0xffffffff,
-                                   regs->gpr[5] & 0xffffffff,
-                                   regs->gpr[6] & 0xffffffff);
which I don't understand whether we need a arch callbacks for it.

Before I sent out the RFC patch set, the very limited compile and boot test goes well with a ppc64 qemu VM. Surely, there will be a lot of test, debug and following up patch set update that is necessary to make it a complete convert.

And the patch set should really be re-named to RFC and v1. 

Cheers  

> 
> 
> Christophe
> 


