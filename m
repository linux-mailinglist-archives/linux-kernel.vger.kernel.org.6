Return-Path: <linux-kernel+bounces-407137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E739C694B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20472B2246C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848E5176AB6;
	Wed, 13 Nov 2024 06:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lf5+YECR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wxF+elyi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80553176233
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731479510; cv=none; b=bjk0GeM4n+GzaoBSq85IUCNeJCvbOhQxcRYNZK0GIFWt73P9hfucRCIs3n31MPef8K1xYMZETrhuyoqaUPyDvQEbxlYzBOI60ltuIT2jJjwh/NL3L/kBBYtQpSB5MCOSPAA2XmKKGydQJbGwbzgwzpNbg9OGCTySWUVV9YzI/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731479510; c=relaxed/simple;
	bh=v0XF+lYS+9ubCtSKTZBWWPEP+fc3CIroquOLJiZDNIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ncTYJIZPKLUILY2vo782UTsqwDOqH6Dgb+2nzSJf98NCXVwEpIYc8wsi+lrVQEfXtsiTtowS2LZNCBcrfV4gAO9zKhssD2gwL8NyVdjQMeNBJIwLGM/efRT6AUEs9jfxBZ6VbVZ4JWcuk5ipk5V+W5IJl7c7h64JhbJuFcqMahA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lf5+YECR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wxF+elyi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731479507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqZhmAG1L077yh5N5u/H+QRagaLDjkn8sqSvH2ojehk=;
	b=lf5+YECRGgtEoM+xnRNgzLn0YzhbuOn5DArNAEuXuWuhciWKTtcYvIVnQLWneKUbkHnaKQ
	Ab/WHZ+TVXbgBIBgsq3UhPWJ+BjlvfHC+t0vpwVHdzAJlc3+Sn0ohVU8zcLx7B/V0rTG+n
	sq4FjAfggzDp0oKxOZx1bY3icXyK0C4yx0spdepdpOq85klzlqJrxlt3cw3sm6BRRhOy3Y
	xhsflm90GJSAMt1U+RJ3ijvrI71zJxUWg+TOU9DDtwlT4O8aGKU3lanSM3ed4bMA9XE2s5
	iWVlt6w4TgNVch0iHDIecSdWjZ3099dl1g2KF1OOE6JxqKKg+n83NZ0O+0VVDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731479507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LqZhmAG1L077yh5N5u/H+QRagaLDjkn8sqSvH2ojehk=;
	b=wxF+elyirMFbITdWGSKVOXYlQlv+QcvHIvUYgpeAnldZjg6/z3+i03gb0sBYjhhuQWmNbv
	223s2y2YLXU4ueCA==
To: Luming Yu <luming.yu@shingroup.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 christophe.leroy@csgroup.eu, luming.yu@gmail.com
Cc: Luming Yu <luming.yu@shingroup.cn>
Subject: Re: [PATCH v2 6/8] powerpc/entry: factout irqentry-state
In-Reply-To: <972B4AF8B9EDF3C0+20241111031934.1579-12-luming.yu@shingroup.cn>
References: <20241111031934.1579-2-luming.yu@shingroup.cn>
 <972B4AF8B9EDF3C0+20241111031934.1579-12-luming.yu@shingroup.cn>
Date: Wed, 13 Nov 2024 07:32:02 +0100
Message-ID: <87a5e3myot.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 11 2024 at 11:19, Luming Yu wrote:

factout?

> To have lowlevel paca.h include high level entry-common.h cause
> include file dependency mess.

That's not a technical explanation which explains which problem this
patch is trying to solve.

> Split irqentry-state.h to have the irqentry_state.h can be included in
> low level paca.h

That's not what the patch actually does. It does two things:

    1) Split the generic header file

    2) Change the PowerPC code.

That's not how it works. See Documentation/process ...

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

How is this supposed to compile on any architecture which uses the
generic entry code?

Thanks,

        tglx

