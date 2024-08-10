Return-Path: <linux-kernel+bounces-281896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F894DCB6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7513B213C9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA862158208;
	Sat, 10 Aug 2024 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="itbOHIYM"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C83617552
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723292305; cv=none; b=Qr9YsqH21EpuHyJLo4ApAy6H/syofXNXUQqXAhNl1kmRQM/vbi1av9AF907L2r8RCo30RnBvzUPH6frpUDxzhhTCDjvjyddGCIaCqqbeDF2a9dWq96XKJajmMIdkJMaJu/o5gFm97xRWu2/Nw/0fod95mlLS6RaQ3LzcxvDs8zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723292305; c=relaxed/simple;
	bh=WkmX8fGcv6PIa4LDH1SLOOEunxJb5+L3yfIy5+VbKWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jk1EwAjU5MX1uba8qyVYzt7pPEHXt2bxLjUJ/5YPl7pLn8Hm861KJHtjLMQAajyCZwncU906oZN3XlhTcMRxpS8jIRWZkSZaBo4yKRiL9jGPC/RMnKXASRoluEWBwcbMPihvcTRAPMEsqc0tSt8AnSQa23Ut3Ub2LokR0AZtcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=itbOHIYM; arc=none smtp.client-ip=51.81.211.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1723291950;
	bh=WkmX8fGcv6PIa4LDH1SLOOEunxJb5+L3yfIy5+VbKWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=itbOHIYMi3UcjqVEkWzHO6dg8jLz5CK/bWwBHeH6be5FZZ1i8WikhVKucYs85GL/s
	 gKinXVg1wRKr/7tjZZ7liwernGIAgbiG/55MFSi6rvGsbJ2ln3FsfFcCxyBXJjDkBv
	 AFCuIDuICFk4tCNeVw8S4X9TJY60r03UiX4Mjp+UydVLizDYr+z06H9FI/vS3LGzpI
	 xiHgMXgseIMHwZRyquAzX1tZFgj3vQZrZSiuHRx/PQQ6pQv/1Mpwo+fbUoSzpV8Dsc
	 CDgmz6K6eTu5PxZ3LUYeEGSoFdaB3lBnA4Ccjgb46OSStQ7g/2veBRTE7E54bt+5ty
	 NBMXahiuTgmsg==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.223])
	by gnuweeb.org (Postfix) with ESMTPSA id 15CDE24C579;
	Sat, 10 Aug 2024 19:12:28 +0700 (WIB)
Date: Sat, 10 Aug 2024 19:12:25 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tools/nolibc: x86_64: wrap asm functions in functions
Message-ID: <ZrdZKcQ1SClUHWa1@biznet-home.integral.gnuweeb.org>
References: <20240810-nolibc-lto-v1-0-a86e514c7fc1@weissschuh.net>
 <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810-nolibc-lto-v1-3-a86e514c7fc1@weissschuh.net>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Sat, Aug 10, 2024 at 12:54:46PM +0200, Thomas Weißschuh wrote:
> +__attribute__((weak,unused,section(".text.nolibc_memmove")))
> +__nolibc_naked __no_stack_protector
> +void *memmove(void *dst __attribute__((unused)),
> +	      const void *src __attribute__((unused)),
> +	      size_t len __attribute__((unused)))
> +{
> +	__asm__ volatile (
> +		"movq %rdx, %rcx\n\t"
> +		"movq %rdi, %rax\n\t"
> +		"movq %rdi, %rdx\n\t"
> +		"subq %rsi, %rdx\n\t"
> +		"cmpq %rcx, %rdx\n\t"
> +		"jb   .Lbackward_copy\n\t"
> +		"rep movsb\n\t"
> +		"retq\n"
> +		".Lbackward_copy:"
> +		"leaq -1(%rdi, %rcx, 1), %rdi\n\t"
> +		"leaq -1(%rsi, %rcx, 1), %rsi\n\t"
> +		"std\n\t"
> +		"rep movsb\n\t"
> +		"cld\n\t"
> +		"retq\n"
> +	);
> +	__nolibc_naked_epilogue();
> +}

NAK for this patch.

This approach appears highly dangerous, particularly when the compiler
inlines the call. When using inline assembly within a function, it's
crucial to define proper constraints and a clobber list to ensure the
arguments are correctly bound to the inline assembly.

Moreover, as it stands, there is no indication to the compiler that the
inline assembly modifies registers such as %rax, %rdi, %rsi, %rdx, %rcx,
or "memory", which could lead to unpredictable behavior.

Unfortunately, I can't spend more time on this right now as I'm
currently traveling. I'll get back to it later when I'm in transit.

-- 
Ammar Faizi


