Return-Path: <linux-kernel+bounces-571987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E826CA6C50C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725113AE967
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 21:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC8F231A37;
	Fri, 21 Mar 2025 21:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="urekzMMt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZS5gE+V"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066422652E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742592160; cv=none; b=FaHQgHCmJ6sZwd4ljwNMz4r/nfCIQ9PG/XdknjE86U+JNdpTF7T+gQaLXi2vI5MDL6/snBSgYcOOZ9UZZ9ku6+TV/w5rWaja/RFi4p+T9raMqdkmiR2oHUu2tPYYMqo2VStxv5ER5X3NR8NM2p3zIh8Yyn6j1AGdsK9szbQPLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742592160; c=relaxed/simple;
	bh=MLoEPj1DotaiblARy+HIv8f7Oy71CnrchBnjpKyGesU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XtMAJeh9l1uyQC8Vo5m2yhTma7dsC5mIMdTffikSf5fnKl6GKOOsut3GZo0Difh1wJbm1myR1M5k+/mdXGnW6OKJ7g9w5LTtw2a9eWsiXTW4pHR5ih2ubS+GrWVCv4Y43wD83RU8pqqKyg9FqHCTZCVeJ1HfK06DKaSWGTJ8egk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=urekzMMt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZS5gE+V; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742592157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oNseWKuGBEgshNs5P0talv9xg+inN17z1K2AF90QsY=;
	b=urekzMMtfA3kTy822lbKa4nufWzR1OXLr8MKXehncBoDdm+XaFkjEu7bTZMYsxv8ltVwoi
	lvGqR9Z+4hyzbhRh4AC896uxdlwHvHw0veohERNmwzCmdAQ04k4q/CHT/60zHV4CdzuzTA
	n6YkpC/n1jRVZjiX3ycpakTyHVyDhKkoHtGemUXzU9umIyUgY056GYou5iCqFHnXf8FjpT
	MXxRYQ9tHrj/Lojkqh8tvOra2HYQEqECrVf9+ATCAHPRq5ctBn54mBq/86YWqdn1cU6oNr
	KT/foI3j5FKmu9mdRZ04kF+JZgKJ/qOzzln5uAjmxECTHSDiRZ7wmLllDx7eaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742592157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oNseWKuGBEgshNs5P0talv9xg+inN17z1K2AF90QsY=;
	b=EZS5gE+VsWIJ5vRL3eP5Jndiht64acIE4ql10QAAbAlD7H53yy7I4AqzDTceNhmWCpRnL1
	9Xun/0Uq9tAy9gAQ==
To: Charlie Jenkins <charlie@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Huacai
 Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Peter
 Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, Charlie Jenkins <charlie@rivosinc.com>
Subject: Re: [PATCH v6 0/4] entry: Move ret_from_fork() to C and inline
 syscall_exit_to_user_mode()
In-Reply-To: <20250320-riscv_optimize_entry-v6-0-63e187e26041@rivosinc.com>
References: <20250320-riscv_optimize_entry-v6-0-63e187e26041@rivosinc.com>
Date: Fri, 21 Mar 2025 22:22:36 +0100
Message-ID: <87frj613kz.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 20 2025 at 10:29, Charlie Jenkins wrote:
> Similar to commit 221a164035fd ("entry: Move
> syscall_enter_from_user_mode() to header file"), move
> syscall_exit_to_user_mode() to the header file as well.
>
> Testing was done with the byte-unixbench [1] syscall benchmark (which
> calls getpid) and QEMU. On riscv I measured a 7.09246% improvement, on
> x86 a 2.98843% improvement, on loongarch a 6.07954% improvement, and on
> s390 a 11.1328% improvement.
>
> The Intel bot also reported "kernel test robot noticed a 1.9%
> improvement of stress-ng.seek.ops_per_sec" [2]
>
> Since this is on QEMU, I know these numbers are not perfect, but they
> show a trend of general improvement across all architectures that use
> the generic entry code.

This looks sane now. I've bookmarked it as post-merge window material.

Thanks,

        tglx

