Return-Path: <linux-kernel+bounces-362735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8DD99B8CA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 10:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4332820E2
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 08:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFCC13AA2E;
	Sun, 13 Oct 2024 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tULugrmy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC36335D3;
	Sun, 13 Oct 2024 08:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728807696; cv=none; b=k4/BjzXa8zlH2pTwBA8RR81N/bJa+oR4qv+ywH//kk2TWWOKrua20bqXxZL7gSPsEl3fjiO6Xwk0BqPv5CfGjbhIZc6jEZ9MzS0HIcy8ZU8WkSExqH86yBYdhTJJEuWoDBRUBh18ZksNYD29eAtD1Zhs37DiV6LsePAcG/28Boc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728807696; c=relaxed/simple;
	bh=axLE1xiN/UJraVdsbL227+KygpaRBx8zh/1+7kBzHtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZnXDR9lHuGGyonJhvpgtrie1UgA3PSZwA3xpfBN8wg65g9hdlAFM5jxNJngmgTj3BNGbAjPB74PIN6aQYYJMTdS/schf6d8cIAtswQ8PR4cO/MI0vk8NhmejKasahdxjGqgkI66P2dx0dBq5owz0OhGQSBuSDEFmpWJO7oiEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tULugrmy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7DDC4CEC5;
	Sun, 13 Oct 2024 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728807695;
	bh=axLE1xiN/UJraVdsbL227+KygpaRBx8zh/1+7kBzHtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tULugrmyy2c91yQJWjaBjHXqphYG/JvCX5o6kz6uVZ9/fCV6HwEPz8SuQgJzDUq5n
	 kxV0HdtXAKAFfmvUvZdgQZMP0unvXMRCEnlyS1H3JQDZ5ossIIaf2Eh/Nt9pL4A4fs
	 UgxKSMuMKcaccm8geMjYnMSohGCn8RKZBpgaQDbot9RbMkW0GDRRTO33pSpl/x1ym0
	 dQuemnzjAiXPC/0mLG1oT+1A/aZ61lYeZndqRDYWKybQ8BBsLJUN0uOrlEeKnU9yp5
	 FWC9VLWLI9drpamlPLmTprJP5YlRHBN3xN5RHu8q3+QwHPmEl5AZGNADKSg4N+YSpq
	 BHkDzwCRuBmaA==
Date: Sun, 13 Oct 2024 11:17:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [x86/module] 6661cae1aa:
 WARNING:at_arch/x86/mm/pat/set_memory.c:#__cpa_process_fault
Message-ID: <ZwuCLKivIJkB7aza@kernel.org>
References: <202410111408.8fe6f604-lkp@intel.com>
 <ZwkjPKKxRKUoJuOE@kernel.org>
 <73d5a6ed-da3c-448e-8cf8-6abb59cb2c36@intel.com>
 <ZwlG9NENb3GWT8Ea@kernel.org>
 <f2af0c30-c7d7-472d-9aa3-ffa311b2e777@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2af0c30-c7d7-472d-9aa3-ffa311b2e777@intel.com>

On Fri, Oct 11, 2024 at 09:30:33AM -0700, Dave Hansen wrote:
> On 10/11/24 08:40, Mike Rapoport wrote:
> > On Fri, Oct 11, 2024 at 07:00:01AM -0700, Dave Hansen wrote:
> >> On 10/11/24 06:08, Mike Rapoport wrote:
> >>> This patch disables ROX caches on 32-bit, it should fix the issue.
> >> While I'm not going to shed a tear for 32-bit, what's the actual
> >> compatibility issue with 32-bit?
> > From the stack trace it looks like execmem tries to update the direct map
> > for highmem memory, and cpa is not happy about it.
> 
> First of all, if it's a highmem problem, shouldn't the check be for
> CONFIG_HIGHMEM and not on 32-bit vs. 64-bit?  We do have non-highmem
> 32-bit configs.

32 bit also does not have ARCH_HUGE_VMALLOC and execmem cache will be
anyway populated with 4k pages, so I don't see why it would be useful on 32
bit all.
 
> Also, where did the highmem come from?  All of the execmem allocations
> look like they're some variant of PAGE_KERNEL, but no __GFP_HIGHMEM.

Despite that execmem allocations are PAGE_KERNEL, __vmalloc_area_node()
implicitly adds __GFP_HIGHMEM for !DMA allocations.

cpa->vaddr = 0 here:

[    8.161035][   T98] CPA: called for zero pte. vaddr = 0 cpa->vaddr = 0

means that page_address() returned NULL which can happen only for highmem
pages.

set_direct_map_valid_noflush()
	__set_pages_np()
		unsigned long tempaddr = (unsigned long) page_address(page);
		struct cpa_data cpa = { .vaddr = &tempaddr,
		...

		__change_page_attr_set_clr(&cpa, 1);
	

-- 
Sincerely yours,
Mike.

