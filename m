Return-Path: <linux-kernel+bounces-538097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5729A49490
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23211709EC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218141F30A2;
	Fri, 28 Feb 2025 09:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IqZpkCik"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6061CD214;
	Fri, 28 Feb 2025 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740734146; cv=none; b=JZRiPUjSHXN6yFxN9WyQH+kxeydceit1vNMehPH1ijPnPJ+FUL91HZXwio+VErmYuxx8s8a616rthlHj9elynmqzsCnSsPrDlTnK2l7CyEtjB9wEhxk9CHxXVFGqwb4DBgbu+wMh4G1wFbMFYQGRyCAJoWAIS4WDOtJ4KcLDYEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740734146; c=relaxed/simple;
	bh=7ynQIG89tk72mF8+K4muFYlbFTzMdlvZIa+I7Ot8dSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3JsNNSG5O2u/gZj+6ShD2hRxgp0xd24trPycRt4X9fMsssEzFMQmcJxqL7J0aGSwUuOcemxc6rAgCFI9nbXVrLEFZgaoR97eu9hgKBJMNrdHRQ3nbd2mT/vCZuN9k1sJBv6hdXojiRTbHAJ3W2u+v5hKteWsozDyfzb8j2Ibwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IqZpkCik; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cB35Okk/LZLTRaud+8VfNe7sW2ClAebE6k/ZVM5yI70=; b=IqZpkCikYWsV4Pyi2iwhO6Wwtd
	Rw38VXGTQyNVFDi2Fa6FiHfLmQL52AYP1sWq2aWLXfGpdVK35RrhDcq27WSHw/tXErbqazY9aZrHq
	T4AGkGwKvDV/3j2QT3D/3YnLmnoAb/yx8zQjQWVgzIwXpzVA2ZxxW9tVUosy/UWEPnja6sNNDSZ6j
	OhVuKbWzrIp0BWgDd+wtYE76WAxfa417vvoGwJ+OAPJ1P/Gr0KjBapbC7K8ZCtkgbEwrrsXtSA183
	JCchIHkIwK1ApzzGRcWNu2WKH3Iy4fw62jothpLhIoSeEzcl0wlv/24dGVfS3ULAaV/i5eoqgqpW6
	5Cjnn6eg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tnwSz-00000001aBc-43fU;
	Fri, 28 Feb 2025 09:15:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 891EC300780; Fri, 28 Feb 2025 10:15:32 +0100 (CET)
Date: Fri, 28 Feb 2025 10:15:32 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH] x86/locking: Remove semicolon from "lock" prefix
Message-ID: <20250228091532.GD5880@noisy.programming.kicks-ass.net>
References: <20250228085149.2478245-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228085149.2478245-1-ubizjak@gmail.com>

On Fri, Feb 28, 2025 at 09:51:15AM +0100, Uros Bizjak wrote:
> Minimum version of binutils required to compile the kernel is 2.25.
> This version correctly handles the "lock" prefix, so it is possible
> to remove the semicolon, which was used to support ancient versions
> of GNU as.
> 
> Due to the semicolon, the compiler considers "lock; insn" as two
> separate instructions. Removing the semicolon makes asm length
> calculations more accurate, consequently making scheduling and
> inlining decisions of the compiler more accurate.
> 
> Removing the semicolon also enables assembler checks involving lock
> prefix. Trying to assemble e.g. "lock andl %eax, %ebx" results in:
> 
>   Error: expecting lockable instruction after `lock'
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Ah, I always wondered why that ; was there.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

