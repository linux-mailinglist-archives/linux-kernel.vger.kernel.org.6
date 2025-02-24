Return-Path: <linux-kernel+bounces-529364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779C7A4235B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40711899B81
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B94B18C03D;
	Mon, 24 Feb 2025 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMR9ZyF5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825532629F;
	Mon, 24 Feb 2025 14:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407819; cv=none; b=DMCHXKXmgcUC0fgs2hyyGmJJiCml1inyHAh1XXqWDyynrDVoVfdPKYmYrbb0UJflGFtdy+B8p3rl8Wi15Fvv07LpN3XbTz5dBQRqrb1hN4ts6yjrm/JykVKFkJs706FocPkLUToQF9CULAgaaY2qBhWKMDcSj5oKSTvxLrLA25w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407819; c=relaxed/simple;
	bh=ZPkqFHkfpEEXBvv/JiiAXJD73VY1MQPjnfI68AzNmMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7AMyIuI5fRanzd7OIL+A/VQ94kmsJ9JyZX9S0reG8ia6odXxQiJw1N9kUKcnE8XiY8pv317dnmwGTfvrZuX7zEmYr16kfN4yGaKc7eFY2yoeh5wNwgVwsUr3Vu9gKuvtw08a1I9XAoRaFnoYPARXVCBFvgI05zLveINtf6FeD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMR9ZyF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36ADC4CEE6;
	Mon, 24 Feb 2025 14:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740407819;
	bh=ZPkqFHkfpEEXBvv/JiiAXJD73VY1MQPjnfI68AzNmMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMR9ZyF51+gCTr5O6+tVcp768/JhJHldAdQMuQdHABvUY7CdUug/Ab1wT3ObgQGAC
	 7NzdY7UbKVP+eM8BgNncEZMMwXw3Wso7TJk0q2VyeryHtrjfnrTE2e5UNcbDKvPLhE
	 5rK+17rtGXNWyA/lMLkVwP2uxrzQbGpoqpM86P+xp+fCHrb56wfT+YG6s+mEWHlMq7
	 +kkYVhJASr3nwSzp8WJx6sGZ3GtEKDCIWteAIxOWx0XP2wkAbG4nWMVBfM/fSU2Vi1
	 69Xel5I0sX2/L5q0XRAaPHw5kaC8vo10XnIAcPaeS8jvBssTAmWVUTy3s4cxy0sDjX
	 NCx7zo+hSuMbw==
Date: Mon, 24 Feb 2025 16:36:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>, James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
	kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v4 12/14] x86: Add KHO support
Message-ID: <Z7yD9g1AgtUUfKr0@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
 <20250206132754.2596694-13-rppt@kernel.org>
 <20250224071355.xsl2dbupda4dhfzl@master>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224071355.xsl2dbupda4dhfzl@master>

On Mon, Feb 24, 2025 at 07:13:55AM +0000, Wei Yang wrote:
> On Thu, Feb 06, 2025 at 03:27:52PM +0200, Mike Rapoport wrote:
> >From: Alexander Graf <graf@amazon.com>
> [...]
> >diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> >index 82b96ed9890a..0b81cd70b02a 100644
> >--- a/arch/x86/kernel/e820.c
> >+++ b/arch/x86/kernel/e820.c
> >@@ -1329,6 +1329,24 @@ void __init e820__memblock_setup(void)
> > 		memblock_add(entry->addr, entry->size);
> > 	}
> > 
> >+	/*
> >+	 * At this point with KHO we only allocate from scratch memory.
> >+	 * At the same time, we configure memblock to only allow
> >+	 * allocations from memory below ISA_END_ADDRESS which is not
> >+	 * a natural scratch region, because Linux ignores memory below
> >+	 * ISA_END_ADDRESS at runtime. Beside very few (if any) early
> >+	 * allocations, we must allocate real-mode trapoline below
> >+	 * ISA_END_ADDRESS.
> >+	 *
> >+	 * To make sure that we can actually perform allocations during
> >+	 * this phase, let's mark memory below ISA_END_ADDRESS as scratch
> >+	 * so we can allocate from there in a scratch-only world.
> >+	 *
> >+	 * After real mode trampoline is allocated, we clear scratch
> >+	 * marking from the memory below ISA_END_ADDRESS
> >+	 */
> >+	memblock_mark_kho_scratch(0, ISA_END_ADDRESS);
> >+
> 
> At the beginning of e820__memblock_setup() we call memblock_allow_resize(),
> which means during adding memory region it could double the array. And the
> memory used here is from some region just added.

There are large KHO scratch areas that will be used for most allocations.
Marking the memory below ISA_END_ADDRESS as KHO scratch is required to
satisfy allocations that explicitly limit the allocation to ISA_END_ADDRESS,
e.g the real time trampoline.
 
> But with KHO, I am afraid it would fail?
> 
> > 	/* Throw away partial pages: */
> > 	memblock_trim_memory(PAGE_SIZE);
> > 
> 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.

