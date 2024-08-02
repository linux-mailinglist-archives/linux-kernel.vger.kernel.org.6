Return-Path: <linux-kernel+bounces-272389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE24945B1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612741F246B3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04951C0DF1;
	Fri,  2 Aug 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DdPprZmy"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE51DAC69
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591361; cv=none; b=azOmWigRS1iRPJBagYvGgYgmop2CGXzKLBfWn7Pr/AVrRtXGRsrrpNtetnOS+xR425Ch0n5OHpd5Yt0IshfICgbTez+tTXJtqwv73SKZnYAIkO/986aAd77tEXbSvKLWP87reNKXvULnrC1E2pSikIyRdK+9CQ07W7V1vnscoVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591361; c=relaxed/simple;
	bh=dGZMGcHUtm9nJXfSiS/hGY6mS7HzGlEUMK0ytOf8QLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICA8Kc7fHihdB6YzEMxT+xiR/60hvjNDUGIHttGjWNtcoWcBw4QyAU/+o8R1OfPyZdjDMwv39N6SMNEssqlXa+Yu3gaE+9Mtc1dDLEOfl3fkX0YpiqTMzdEorpUbH39iX8cVIwG8Lltz1pnb3YW6q7ZfxRWHSSTaSu1ax/4tygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DdPprZmy; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i6UGt9w6oVjdke1onFK4SKyphZpyTcfgA6/77jk/y8A=; b=DdPprZmyua1EKfU+9mBdlaeUa4
	9v7jjEGk3pvKPdaB/1Qo0joYnwohLGxpUlrzJFSZl9qzp+yzq14GyRv13m6WEA3q2vNtOiXY4Ea3R
	3Lo9YiVSgHX5d+kmeSqL9rczz0XI0BaHp45NzSX0oYCmT0RQdDDCwkeRqeF6MJxVvpSX6sp59/pFI
	Jd7M2DhX6Iis4HeM+HSpzaFjp+4j6hc+h4k7PAWT+whYJfKC60lqKp4zf1ueZKldjibKrQ2a5rJb/
	WVqf8JjxciBtYva7DjCO+W7Iwm9oDBhslpkd2CcR1/I/hZxdUkT5DGtyeENpipaTeck6BaD1C0s8K
	K+dvOuxA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZohV-00000005g0A-0dvL;
	Fri, 02 Aug 2024 09:35:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 80CD330049D; Fri,  2 Aug 2024 11:35:52 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:35:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [FYI] objtool: =?utf-8?B?LmV4cG9ydF9z?= =?utf-8?B?eW1ib2zigKY6?=
 data relocation to !ENDBR: stpcpy
Message-ID: <20240802093552.GG39708@noisy.programming.kicks-ass.net>
References: <20240801152836.xOJc9iaY@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801152836.xOJc9iaY@linutronix.de>

On Thu, Aug 01, 2024 at 05:28:36PM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> defconfig on x86-64 with gcc-14 I get this:
> | vmlinux.o: warning: objtool: .export_symbol+0x26980: data relocation to !ENDBR: stpcpy+0x0
> 
> objdump ->
> 
> | 0000000000000110 <stpcpy>:
> |  110:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
> |  117:   00 00 00 00 
> |  11b:   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> |  120:   f3 0f 1e fa             endbr64
> 
> okay, no endbr64 on entry label.
> 
> | $ make lib/string.s
> ->
> |         .type   stpcpy, @function
> | stpcpy:
> |         .p2align 5
> |         endbr64
> | .L30:
> | # lib/string.c:193:  while ((*dest++ = *src++) != '\0')
> |         movzbl  (%rsi), %eax    # MEM[(const char *)src_8 + -1B], _1
> 
> an alignment request after the function label before endbr64 which gets
> expanded into NOP_11+NOP_5.
> I don't see this with gcc-13.
> Reported as https://gcc.gnu.org/PR116174

Fun, thanks for tracking that down!

