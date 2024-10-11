Return-Path: <linux-kernel+bounces-361431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD10599A81E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5E51C21F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 15:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103C196DA4;
	Fri, 11 Oct 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUhyI3rR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D814A188CB1;
	Fri, 11 Oct 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661459; cv=none; b=Z/d4Bg4TDL3mGSZcdXbK89xpNRCBsMXgiKLU3rlbGuV1q6LdjxSyDw84iMmBO/vwrXCEpIvOF60wbDb4WkRJqs3zRClDp3yxLLHM17gYi9nPp2/H99Rk5rM8LMc9CvQMiPYYlfMoE48KLg6dD2v+vA1lxypQgL++hAik86nFLog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661459; c=relaxed/simple;
	bh=sXty7ZbtksBSz1exHU2CbDqu59M0E4xIlq58x6+VjGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YeWWV1JflnHNyegQOFpLLtWWDZN/MCB+mzgWU3lj/ZnBD+FX4YKfyjAap7zS3Zbpdy1hQ4HWbOpZNnZVKzHTpK4k+OlqnHOHWTsWVx2h+lTpsqkoLT2G1AJia9UOji2BNKCHOamOcruzwfO3Vk7c+tpxI0zsR37P5wkHYucudAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUhyI3rR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B8BC4CECE;
	Fri, 11 Oct 2024 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661459;
	bh=sXty7ZbtksBSz1exHU2CbDqu59M0E4xIlq58x6+VjGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUhyI3rRROr1y9If9WROKeSEPDwdL7k5oM9jxEtMZWeIqai2cBNAU/2UbXWyzSuOk
	 t8/yP2jYJHXsvnrQXaSshHMtt9lM7oRiWdgkRzjDGAHmmu0J8xKK+DtckimPz/Uv9Y
	 bx7xtUhjs1x/xBwtGcaAwK10rsOoSgve+QWdTzZnbvYNctX1cA3DE35jk/eY5BOPXj
	 DZLBjaRNrABTph6Iy97QP5uH1atR5loE1QJFME34LBtNXqxVzs1ahSbWtvILVYAWkO
	 YsLsXyUQp1cbpyGdH7DnEsvyyKR+VXhwokQJmK1boA0WlfGlA/9nCTtq6Md2ZIKFOi
	 +HiqzmcVXGTQw==
Date: Fri, 11 Oct 2024 18:40:36 +0300
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
Message-ID: <ZwlG9NENb3GWT8Ea@kernel.org>
References: <202410111408.8fe6f604-lkp@intel.com>
 <ZwkjPKKxRKUoJuOE@kernel.org>
 <73d5a6ed-da3c-448e-8cf8-6abb59cb2c36@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73d5a6ed-da3c-448e-8cf8-6abb59cb2c36@intel.com>

On Fri, Oct 11, 2024 at 07:00:01AM -0700, Dave Hansen wrote:
> On 10/11/24 06:08, Mike Rapoport wrote:
> > This patch disables ROX caches on 32-bit, it should fix the issue.
> 
> While I'm not going to shed a tear for 32-bit, what's the actual
> compatibility issue with 32-bit?

From the stack trace it looks like execmem tries to update the direct map
for highmem memory, and cpa is not happy about it.

-- 
Sincerely yours,
Mike.

