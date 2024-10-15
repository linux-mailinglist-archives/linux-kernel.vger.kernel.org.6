Return-Path: <linux-kernel+bounces-366176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 899B399F1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34049B23108
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454F01DD0D8;
	Tue, 15 Oct 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GiXQec4K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jFaXijGn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E131CB9FE
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729006968; cv=none; b=gKrTPKmtVneIGdyRM8MUaBNvVTAb3X/7SlpkrOCNEQa9m2NpJxhggXjT6WIhJCDSmtGnTgTndBgwFzmoHHfkscNWrC3UMpwPJIp26j2wV795me7+q62cwB0h3XRj+Rzz9jF8HzknixZPR4d2FV/CCU4crlH0HVU0O8VlNUEjlro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729006968; c=relaxed/simple;
	bh=G3MFX9mj2ANIrBYL+YVGkiPYcuC11b5OglCcC7hA+Kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jjdGv7XK/ia/GAJJcmyomkiHuqcMU0CxrbtaFr8XTn/iWdx5M5sTEMguwf7DLttGT/TLLljLLu2GgcVadGGmoB5WzouUnwTi0Q+tvWBHjWPWSDwfgH4KsZDAdb1VUJJwDi4xF016kzeyuVmKonu8DoZfbYevCPbvGxdCGQgr+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GiXQec4K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jFaXijGn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729006965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H/4jrpzEyuEt3kkgW2rzE95+U5CN+zHY8J92IEceQs=;
	b=GiXQec4KIUemYmVODSScu73AVombrDmG8VUbAJKZShgmdIAdcfs2J+YVBKJKYi3RZcc+bC
	qHkUKgdfbIxUBbXweF6uq8x83c2lLLOesPzggE0g5GDfw9UoJF2QfNzPSqo/4fO+i9wPhw
	Ts3KTs88ILz55bFF+T/uXspaK++r2xVEEdPnwiVKWwZzT+PrkK2N2o4WPiS+o5+U3fQNW6
	bzy2MveXPXQ7EgKejHvPAQUIem/p9bMRaCX8SAQoB0gZ3qKt+NsQqtuHFx2R5rYoUpBTiT
	1yPHZQx7q61zLq8Jq130AQq6Tf6yALBVtegj7ah1ElyUf0MkI2USS926DT4HiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729006965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H/4jrpzEyuEt3kkgW2rzE95+U5CN+zHY8J92IEceQs=;
	b=jFaXijGnUW7agtJYmEaw7GIwMRCW0DOWvFkos7ahgGegcTj32/ZgxAMlBgYwFQBmcqrGzr
	q05ZtNoF7tAtDBBg==
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, jialong.yang@shingroup.cn,
 luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH 6/7] powerpc/entry: factout irqentry-state
In-Reply-To: <E6FB8D32FAAFC3BE+20241012035621.1245-8-luming.yu@shingroup.cn>
References: <20241012035621.1245-3-luming.yu@shingroup.cn>
 <E6FB8D32FAAFC3BE+20241012035621.1245-8-luming.yu@shingroup.cn>
Date: Tue, 15 Oct 2024 17:42:45 +0200
Message-ID: <87ed4he5je.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Oct 12 2024 at 11:56, Luming Yu wrote:

> To have lowlevel paca.h include high level entry-common.h cause
> include file dependency mess. Split irqentry-state.h to have
> the irqentry_state.h can be included in low level paca.h

What's the rationale for this?

> Signed-off-by: Luming Yu <luming.yu@shingroup.cn>
> ---
>  arch/powerpc/include/asm/paca.h |  2 ++
>  arch/powerpc/kernel/interrupt.c |  2 ++
>  include/linux/entry-common.h    | 24 ------------------------
>  include/linux/irqentry-state.h  | 28 ++++++++++++++++++++++++++++

This is not how it works. Split the include file in a first step and
then make changes to the PPC side.

> diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
> index d95ab85f96ba..6521171469f2 100644
> --- a/include/linux/entry-common.h
> +++ b/include/linux/entry-common.h
> @@ -352,30 +352,6 @@ void irqentry_enter_from_user_mode(struct pt_regs *regs);
>   */
>  void irqentry_exit_to_user_mode(struct pt_regs *regs);
>  
> -#ifndef irqentry_state
> -/**
> - * struct irqentry_state - Opaque object for exception state storage
> - * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
> - *            exit path has to invoke ct_irq_exit().
> - * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
> - *           lockdep state is restored correctly on exit from nmi.
> - *
> - * This opaque object is filled in by the irqentry_*_enter() functions and
> - * must be passed back into the corresponding irqentry_*_exit() functions
> - * when the exception is complete.
> - *
> - * Callers of irqentry_*_[enter|exit]() must consider this structure opaque
> - * and all members private.  Descriptions of the members are provided to aid in
> - * the maintenance of the irqentry_*() functions.
> - */
> -typedef struct irqentry_state {
> -	union {
> -		bool	exit_rcu;
> -		bool	lockdep;
> -	};
> -} irqentry_state_t;
> -#endif
> -
>  /**
>   * irqentry_enter - Handle state tracking on ordinary interrupt entries
>   * @regs:	Pointer to pt_regs of interrupted context
> diff --git a/include/linux/irqentry-state.h b/include/linux/irqentry-state.h
> new file mode 100644
> index 000000000000..d4ddeb1c6ab6
> --- /dev/null
> +++ b/include/linux/irqentry-state.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_IRQENTRYCOMMON_H
> +#define __LINUX_IRQENTRYCOMMON_H

The guards reflect the header file name and are not randomly chosen strings.

But aside of that. How is any of this supposed to compile?

You move the typedef into a separate header and then nothing (except
powerpc) includes it. Oh well.

Thanks,

        tglx

