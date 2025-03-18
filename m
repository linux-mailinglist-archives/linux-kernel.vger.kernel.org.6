Return-Path: <linux-kernel+bounces-565739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B481A66E59
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC1A3A55D0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00B91EB5F5;
	Tue, 18 Mar 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNzKZ/6e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAA2749C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286887; cv=none; b=LtoVNVn9xMuD8VtNKddCh/nekc2AzkK+o227GKD08xhRIxNn0UddIVJje9JjCxpYqATKQNO+qTvxtk6tAHpw6axtGzpjHeQcuH7ADtrYGE6Xc3r1gWZXY9AzcH+3lgYbW96Kf5Smfsqc0rg+XDV/t5Yg/lOs1pPaZFWHXgwDJRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286887; c=relaxed/simple;
	bh=DjN+afDglTdHkoGMwUPO7LH68Pieph+l4aJYL2cdGvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUg6EzE77HIkBFCUdzzwQQZjIDNnnsHcm0U2YHDRHWg+qngIUyxFhQmpWtJQIsh/RuS3JLFVl0hvvmC880YhkCJokB/xJKNauALw3QII+FV2Tq4d40cvtGtB2LX/RVkfkCAU5bbcD1hAGoAIpdHN3mfCtVZ19HyJ1MUTU2o8NPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNzKZ/6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4CDCC4CEDD;
	Tue, 18 Mar 2025 08:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742286886;
	bh=DjN+afDglTdHkoGMwUPO7LH68Pieph+l4aJYL2cdGvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNzKZ/6eqnj9SlR5UDUbqR5KFkr5+Rngrj5iQ4sMylzc64xejPnOVpiBCITP/LQqO
	 slzJGUuiQ0M4d/qgH+JRYRaVsAINTx2jrBdB5GY4j8vAuw/470YiyOKvo+boDffA7W
	 /8OuEDwukp2sjeS/9yz2dleZ364dfXSIYQ73dB/p3c/Xinm4Y8oXurtptEL2jwHFrp
	 VHixFinNtv0S2AE4eM2FB/zte3fHlOC9XXfhNnG3qJ5E6zm6vtR+OO4tTLSlrHlReG
	 vBqlpknfiycRP65XwnpjP660N1TIBMh44yukhCLgXaVxvzNFSmoG/Plu1lo8vMB5uU
	 MS4isP6d76rfA==
Date: Tue, 18 Mar 2025 09:34:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 5/5] x86/cpuid: Use u32 in instead of uint32_t in
 <asm/cpuid/api.h>
Message-ID: <Z9kwIYrOwO8nOpAE@gmail.com>
References: <20250317221824.3738853-1-mingo@kernel.org>
 <20250317221824.3738853-6-mingo@kernel.org>
 <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7920c2c-1051-4674-994c-d1b681cf7988@zytor.com>


* Xin Li <xin@zytor.com> wrote:

> On 3/17/2025 3:18 PM, Ingo Molnar wrote:
> > Use u32 instead of uint32_t in hypervisor_cpuid_base().
> > 
> > Yes, I realize uint32_t is used in Xen code et al, but this is
> > a core x86 architecture header and we should standardize on the
> 
> no "we", right?

That's a stupid rule, I don't know where it came from, and I never 
enforced it. It's not in Documentation/process/coding-style.rst.

Linus doesn't use this pointless rule of 'pronoun avoidance' in 
changelogs either:

  00a7d39898c8 ("fs/pipe: add simpler helpers for common cases")

  https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=00a7d39898c8010bfd5ff62af31ca5db34421b38  

    It turns out that we don't have _that_ many places that access these
                      ^^
    fields directly and were affected, but we have more than we strictly
                                           ^^                ^^
    should have, because our low-level helper functions have been designed
    to have intimate knowledge of how the pipes work.
    
    And as a result, that random noise of direct 'pipe->head' and
    'pipe->tail' accesses makes it harder to pinpoint any actual potential
    problem spots remaining.
    
    For example, we didn't have a "is the pipe full" helper function, but
                 ^^
    instead had a "given these pipe buffer indexes and this pipe size, is
    the pipe full".  That's because some low-level pipe code does actually
    want that much more complicated interface.

In changelogs 'we' when used as a generic personal pronoun means the 
kernel and the kernel community in general. It's a perfectly fine 
grammatical construct.

Thanks,

	Ingo

