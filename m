Return-Path: <linux-kernel+bounces-403555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE829C3723
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E651C21433
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3F014AD3F;
	Mon, 11 Nov 2024 03:47:52 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.65.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF513B59E
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 03:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.65.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296872; cv=none; b=YFb8rPfVnGjSgzdUfLTqaF61ivG30Fk94i1Ifm+JscRQ2BoToEC0TgGdqFDW4V9FoilmxDDagamX8UqP4K2leXn60om39MMpfC/QsMgN5dcj2jtmVicTwiT2f5LCVgHHFCXwio/ejzEwxEWnLcC7aJqUozon13kGWkfGVM6FRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296872; c=relaxed/simple;
	bh=bUO7X+CrpUqgX1U8seACf8y18XwTevFwGL+WXOdLRik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIUDrom4qcnUgzjUSnvQMjZpiBAF0aENXx43pNb0AqVd+UL204ruLNohY9Bctdn+6qpRmNWIqHjH6/9dYBGVm6VbCt7oR2dFBDUxpacs+RhnI2Qj/UZsOVU88yw1tDb5X254ZQ/Sl5O1Plfs4kih0Ae4qxeu8OvzxPO2XjqswlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=114.132.65.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtpsz7t1731296770ta4mx0a
X-QQ-Originating-IP: bvxLK2njrzRzAdvQrDBCWRhLpLWS/ywWpzJe1RbKcOY=
Received: from HX09040029.powercore.com.cn ( [116.233.136.127])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Nov 2024 11:46:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17304001754305010295
Date: Mon, 11 Nov 2024 11:45:58 +0800
From: Luming Yu <luming.yu@shingroup.cn>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	luming.yu@gmail.com
Subject: Re: [PATCH 6/7] powerpc/entry: factout irqentry-state
Message-ID: <31612651FF6E56AB+ZzF99uEvysXekBf0@HX09040029.powercore.com.cn>
References: <20241012035621.1245-3-luming.yu@shingroup.cn>
 <E6FB8D32FAAFC3BE+20241012035621.1245-8-luming.yu@shingroup.cn>
 <87ed4he5je.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed4he5je.ffs@tglx>
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NvWYEgjCCjcVZHLRkYpt647SHZtglcXoAbdXjeFXPlvudxoO6OruGBpj
	U6+NfW0ArGZUM35C2I+D0UpU6llKn276+TF6emKF4A1Xt14yfKZN8F5vhK1kjWjiyXgdFf1
	pxpYcpld2o800vUmmxLWtrptrQytP/diYfnRS/arKWpP/O6zUq9DR3nlMIqR3/gN2ikFEpo
	Lec57SwB6ZF/onIyGZE0a/j/S3MsJMpgisNiX6VLQEEydlPLBLLu7974WEDJLdOo0Pma/Yl
	uxF2LLJDQca7UuGtZxO+Z6XquWxJwarlbaWyvsIJYEG3NwJuBAytSuY686Ad4ID4ITTURgZ
	8b1D6aVeERilaTMLhz1YypZ7v94tardUfe72s2S9GEs7a4hLTaPbiv9sl0V84tvyTx39sgX
	ZLbgkK4cny3gyzndJb9664WyPTnPTSxEc2RU44eBsrvP4jLBMBFmLhgOeeofGSXbzHXVlwu
	fndjUhuQzAnTBlucKYRoUx4Z34tdePYrGix2AxEXOD4KTUxeQNQO5VS72OYWLtbxXtuox/a
	342m1ZV6oumMBfCdtxYZzN2g1Ve7OMrx6ZqAjdNCrejki8K8l8c/Vu77BRDMp1cfQ19htbu
	2ax7Ef/UVCv6ftLhyhpQWQm67tpYqcIzudvhYHtUm/NBxKAfAzmDvzdxA+fWbYwSa+kM/GE
	TfW/u0EJ9t1JH69zG3G6GzWYU6aokXOZqdzvvIAs6WzS8c2uSeh53nRHdeuWYbkZJZ+D22k
	RvZ//emH0lgJ8jyn8QV89k7QS4GRMWG3nzBU07FJqC0Xax/f5EKFxdwd8SEVb/ubls49iql
	iKfj44eIiCu1bD/oISuPvLQKaXXZIeOpOmUDrqvvSAo42He7O+gAidavViolIHGZTRcHBZ5
	A7IX6jLkDKwOjX+72uF4qvTK7JXBPp/mtMosNZFdTBpOxISjoA8BKt8U0vkWQWcmTTPRFZc
	ob44KpWlWC4TT5HRr/wLB0ozB0pACBI8KPH26EIiHSd2mih/MxcUS+IGFO6+MGd2LJyw=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

On Tue, Oct 15, 2024 at 05:42:45PM +0200, Thomas Gleixner wrote:
> On Sat, Oct 12 2024 at 11:56, Luming Yu wrote:
> 
> > To have lowlevel paca.h include high level entry-common.h cause
> > include file dependency mess. Split irqentry-state.h to have
> > the irqentry_state.h can be included in low level paca.h
> 
> What's the rationale for this?
> 
> > Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> > ---
> >  arch/powerpc/include/asm/paca.h |  2 ++
> >  arch/powerpc/kernel/interrupt.c |  2 ++
> >  include/linux/entry-common.h    | 24 ------------------------
> >  include/linux/irqentry-state.h  | 28 ++++++++++++++++++++++++++++
> 
> This is not how it works. Split the include file in a first step and
> then make changes to the PPC side.
> 
> > diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> > index d95ab85f96ba..6521171469f2 100644
> > --- a/include/linux/entry-common.h
> > +++ b/include/linux/entry-common.h
> > @@ -352,30 +352,6 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
> >   */
> >  void irqentry_exit_to_user_mode(struct pt_regs *regs);
> >  
> > -#ifndef irqentry_state
> > -/**
> > - * struct irqentry_state - Opaque object for exception state storage
> > - * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
> > - *            exit path has to invoke ct_irq_exit().
> > - * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
> > - *           lockdep state is restored correctly on exit from nmi.
> > - *
> > - * This opaque object is filled in by the irqentry_*_enter() functions and
> > - * must be passed back into the corresponding irqentry_*_exit() functions
> > - * when the exception is complete.
> > - *
> > - * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
> > - * and all members private.  Descriptions of the members are provided to aid in
> > - * the maintenance of the irqentry_*() functions.
> > - */
> > -typedef struct irqentry_state {
> > -	union {
> > -		bool	exit_rcu;
> > -		bool	lockdep;
> > -	};
> > -} irqentry_state_t;
> > -#endif
> > -
> >  /**
> >   * irqentry_enter - Handle state tracking on ordinary interrupt entries
> >   * @regs:	Pointer to pt_regs of interrupted context
> > diff --git a/include/linux/irqentry-state.h b/include/linux/irqentry-state.h
> > new file mode 100644
> > index 000000000000..d4ddeb1c6ab6
> > --- /dev/null
> > +++ b/include/linux/irqentry-state.h
> > @@ -0,0 +1,28 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __LINUX_IRQENTRYCOMMON_H
> > +#define __LINUX_IRQENTRYCOMMON_H
> 
> The guards reflect the header file name and are not randomly chosen strings.
> 
> But aside of that. How is any of this supposed to compile?
> 
> You move the typedef into a separate header and then nothing (except
> powerpc) includes it. Oh well.
thanks for review, I will fix it in V3.
> 
> Thanks,
> 
>         tglx
> 


