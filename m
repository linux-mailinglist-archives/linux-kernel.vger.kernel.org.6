Return-Path: <linux-kernel+bounces-566716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 851B1A67BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 19:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C141A3BB56B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3B7211A0C;
	Tue, 18 Mar 2025 18:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HogBgfUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183B6169AE6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 18:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321076; cv=none; b=iYE3iDtHAuf0wooYcKv/FATfjHWMdUFWKkTjjy+CNMqdB/5JTxVqf3hGMdb0ssPp9m5agHq0KPvI18ej6FwkZgyehS3TgL1z62feFVA1zmu1fSngIYKCsd40WNQyPTTlV4wfiP57clYVwQXNj14C7yNZYYhTwGqYXkk5VYDJQrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321076; c=relaxed/simple;
	bh=maNKmg0A+Z6mydVQMG3bAPxqFjR26T+JDGfjw8XJ5No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nO7LA5eunAfDNBsClfQpyvI+6qdQY/T8Lk3TgtvEsSXARGnvvA8BoGsVV2DsNa3oWt2ZO66JQlu0f349YEBCvyD1ZZSDVGYuosQ7d3dpj8V22N/oSlOL08lddiiA+9p6femARg15ulafMYNat55ce+alIoEv7dDtnq3ycFE5iFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HogBgfUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6168C4CEE3;
	Tue, 18 Mar 2025 18:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742321075;
	bh=maNKmg0A+Z6mydVQMG3bAPxqFjR26T+JDGfjw8XJ5No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HogBgfUNRy0B/iap7Qac2iaD3NNM+j+kV7T8NYiy/d3+URx8VimcbevF8KLXBjSn3
	 nUrxpqJ6pyoN1jX3VDytYc1MG6a/RKJHaUpupuu1DM1GxeSBSLKMbOra3rujZYBnis
	 K6gQk74TUMAv57Nq2wcPFtRrAE/6IZW5jpndQDyS10EPm7bH/9LVl0kO4Cv4iqSNQc
	 flIy17PXc1TU4yHJTT5ejJTk0f60UBVezvzo49TK7iU7RS8jvkBQ3nTwPvaBGwL5uZ
	 nT4vIC03WIbjI+i4LSmLk0ZuGoDt/vqvv8CtvhKOFXTVsdY294lcFtJa0EWnWtapqE
	 B0hRxaSHgkCNQ==
Date: Tue, 18 Mar 2025 19:04:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and
 <asm/cpuid/api.h> and clean them up
Message-ID: <Z9m1rtmlk1PxGIQA@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A417EE0-8DF3-4C6E-A7E9-9EE6705282F1@zytor.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

> It would be nice to get rid of the bleacherous use of *eax and *ecx 
> as input-output operands. The use of four separate pointers is just 
> barely tolerable because the compiler can remove them when the asm is 
> inlined.

So we have a nice structure of:

 struct cpuid_regs {
         u32 eax;
         u32 ebx;
         u32 ecx;
         u32 edx;
 };

So instead of:

 static inline void cpuid_count(unsigned int op, int count,
                               unsigned int *eax, unsigned int *ebx,
                               unsigned int *ecx, unsigned int *edx)

... we could have:

 static inline void cpuid_count(unsigned int op, int count, struct cpuid_regs *cregs)

or so?

plus we could implement the main CPUID call as:

 static inline void native_cpuid(struct cpuid_regs *cregs)
 {
        /* ecx is often an input as well as an output. */
        asm volatile("cpuid"
            : "=a" (cregs->eax),
              "=b" (cregs->ebx),
              "=c" (cregs->ecx),
              "=d" (cregs->edx)
            : "0" (cregs->eax), "2" (cregs->ecx)
            : "memory");
 }

and thus we give the asm() statement only a single pointer in essence, 
'cregs'?

Or do you mean something else?

Thanks,

	Ingo

