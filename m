Return-Path: <linux-kernel+bounces-364376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE6D99D3D8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB401F23BED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 15:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637A1AC427;
	Mon, 14 Oct 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUQHaFJn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402524C3D0;
	Mon, 14 Oct 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920884; cv=none; b=pl6h1qPzAzl57wEthyuVJDDWigJbWcLIfVrwti0iT+aonIbQ7AV5B86W+oqspOeP409W549IVCTLDyEePWIxDiZqUejo4Hm6GYen7Rj6sjrwCoGGojhsRoc+EJgWTkgbHpjg21IBKlUUipt9b5mM4XfeXFfIVfDgzK3Po9W2VyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920884; c=relaxed/simple;
	bh=GzsUoUiNhKTK3YdZrXtW8NdzWqv5iw1PoH3sAqDorsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbGPgC9JZzsmalKcn7xaig+vG17o7lyVJMfHan5CT1WQsKOGt0nwV4Fu6gNxBou9ZvXgHozsnW91NSOXBALdk9W9EltzLnMrn/VwhhtNEJSzTuO2zcvZu26JMkBbbsGa0gY1IYuAkirmVOyMdPoTB3g3aufIveKcwoiXFBr2p0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUQHaFJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419EEC4CEC3;
	Mon, 14 Oct 2024 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728920883;
	bh=GzsUoUiNhKTK3YdZrXtW8NdzWqv5iw1PoH3sAqDorsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUQHaFJnfl8GocRbvMKCm2pNSv4Zu1bSbud4/N4HypWJBIeqQYnzf2PpU6r14SWJz
	 kW0SPc8Te5lh8jX/vrd/yPGkY4O9IPCtqas2cbjJAxkHccC9gToBtC15aJ3e0yU5Mf
	 7p43gdpyB7n8IetfqbLFmpJewplOl7Y2MyvxbGm8nFwIoeIgoVrvwH+ApvH9UPOZCm
	 Wgz45tCNiMdnSTaVNdfJa5iX3UL/V7PMDulmRjuyBtyIKNN2lIHxkmyQsSvfraLxVA
	 K7q9QhV55XUcVhUJRx96J38FC/HiNvETBOo8/ffBfDu2wnnu8YIG0lolI/vpmRonFb
	 TP90mzUwaH44w==
Date: Mon, 14 Oct 2024 18:44:14 +0300
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
Message-ID: <Zw08TviEUyTpy8N5@kernel.org>
References: <202410111408.8fe6f604-lkp@intel.com>
 <ZwkjPKKxRKUoJuOE@kernel.org>
 <73d5a6ed-da3c-448e-8cf8-6abb59cb2c36@intel.com>
 <ZwlG9NENb3GWT8Ea@kernel.org>
 <f2af0c30-c7d7-472d-9aa3-ffa311b2e777@intel.com>
 <ZwuCLKivIJkB7aza@kernel.org>
 <fa91d82c-1b7b-46ab-ab8d-0161b08e29a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa91d82c-1b7b-46ab-ab8d-0161b08e29a9@intel.com>

On Mon, Oct 14, 2024 at 08:27:36AM -0700, Dave Hansen wrote:
> On 10/13/24 01:17, Mike Rapoport wrote:
> > On Fri, Oct 11, 2024 at 09:30:33AM -0700, Dave Hansen wrote:
> >> On 10/11/24 08:40, Mike Rapoport wrote:
> >>> On Fri, Oct 11, 2024 at 07:00:01AM -0700, Dave Hansen wrote:
> >>>> On 10/11/24 06:08, Mike Rapoport wrote:
> >>>>> This patch disables ROX caches on 32-bit, it should fix the issue.
> >>>> While I'm not going to shed a tear for 32-bit, what's the actual
> >>>> compatibility issue with 32-bit?
> >>> From the stack trace it looks like execmem tries to update the direct map
> >>> for highmem memory, and cpa is not happy about it.
> >>
> >> First of all, if it's a highmem problem, shouldn't the check be for
> >> CONFIG_HIGHMEM and not on 32-bit vs. 64-bit?  We do have non-highmem
> >> 32-bit configs.
> > 
> > 32 bit also does not have ARCH_HUGE_VMALLOC and execmem cache will be
> > anyway populated with 4k pages, so I don't see why it would be useful on 32
> > bit all.
> 
> It's not really about making it _available_ to 32-bit, but making sure
> that we're actually doing the check against the right feature and in the
> right way.
> 
> To me, it seems like execmem itself should be excluding all HIGHMEM=y
> builds or _maybe_ all 32-bit builds because execmem has the built-in
> assumption that vmalloc memory is in the direct map.

I presume you mean execmem cache here, as execmem in general should work
everywhere.

After discussion with Christoph about how to define
execmem_fill_trapping_insns(), I'm going to add a Kconfig opt-in option
that will guard the entire execmem cache implementation and have it
selected by x86_64.
 
-- 
Sincerely yours,
Mike.

