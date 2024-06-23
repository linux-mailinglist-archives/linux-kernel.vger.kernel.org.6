Return-Path: <linux-kernel+bounces-226019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B3913924
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554BA1F21BC8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896BE6A342;
	Sun, 23 Jun 2024 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oj78JHi6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73A92D052
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 09:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719133825; cv=none; b=FhKrsmI11IROzqADUwoF7xlI7GQXpH0CMO6MyTCYsQ8bHzvwCLS1iZsYUAGROTk/yPFEdhqhY2gDadTpKsq6EJDR4NZLAwWUwv3tcpbpnuqsPykcSozrIuPNHeHSzMsl1dgv1aDYQkJqsLGs+rgc0VzGhAb+Dg57Z8CL5j7cITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719133825; c=relaxed/simple;
	bh=IJerKaND2PDmpGc/JHeycwUPLP3nyXvoGxo19PJ82xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+qOUFOqYX+DzsySnj8WLPTqlq82dMDbj0tZbdJTshvz7aA9+Xz4BS8Q72DRJBHbRfyc9mg9rpD4BJuZd0zoG0goCJVfSspfRcQPajin80TiznUIcmiT2fB4suhx1H68SVZiXJMkYUFPlZeIL1wiTbeHe5rv6kwEjtC3ibjGB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oj78JHi6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94617C2BD10;
	Sun, 23 Jun 2024 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719133825;
	bh=IJerKaND2PDmpGc/JHeycwUPLP3nyXvoGxo19PJ82xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oj78JHi6tiZufakq7Vw+6mRNykWp/G6u9780AuMZicHG0qHEOUOQ1JSM5FWVALTWj
	 4C2nyFia8/QGRpCcy454y1t3ai8frPICO1rCXvo9nQvhqzCfvpEAcrMvMz+1PBrax1
	 /EYlc/4+YZgtCqFzSifLhNFyWivmvg4Iu6jfivIgnO84Zjf64zEfQUne8EX9zq4KPv
	 jPVY+PUHs0+xuFO65JpIRVKO61VJvW9QUaqNq1Q7bCUPecMKct+o7pTTwPW8UcpYCB
	 L/Dp2bH7+/Ro2kmDurYC00gHh+l/NzVfPgm9sjinhD4sRG95L4PxrySJiLFkm8ZxfD
	 OpRyNsmqAwRfw==
Date: Sun, 23 Jun 2024 12:08:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: yunhui cui <cuiyunhui@bytedance.com>, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
	akpm@linux-foundation.org, bhe@redhat.com, dawei.li@shingroup.cn,
	jszhang@kernel.org, namcao@linutronix.de, bjorn@rivosinc.com,
	vishal.moola@gmail.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: cmdline: Add support for 'memmap'
 parameter
Message-ID: <Znfl8NDWmL1NFANn@kernel.org>
References: <20240618120842.15159-1-cuiyunhui@bytedance.com>
 <ZnTRbptoowL+1GOP@ghost>
 <CAEEQ3wnNZJviirqWCAG7mXsbynC+=Gq5q4jh6b4yamm8cnzMAw@mail.gmail.com>
 <ZnTvArAQpfCm10tc@ghost>
 <CAEEQ3w=6EZMFsH2y7efZsX00CzytyMu+Be_RT8CicejMB6qAJA@mail.gmail.com>
 <ZnUgLZow2ODPH7vp@ghost>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZnUgLZow2ODPH7vp@ghost>

On Thu, Jun 20, 2024 at 11:39:41PM -0700, Charlie Jenkins wrote:
> On Fri, Jun 21, 2024 at 02:02:18PM +0800, yunhui cui wrote:
> > Hi Charlie，
> > 
> > On Fri, Jun 21, 2024 at 11:10 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > >
> > > On Fri, Jun 21, 2024 at 10:08:39AM +0800, yunhui cui wrote:
> > > > Hi Charlie,
> > > >
> > > > On Fri, Jun 21, 2024 at 9:03 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 08:08:42PM +0800, Yunhui Cui wrote:
> > > > > > Implement support for parsing 'memmap' kernel command line parameter.
> > > > > >
> > > > > > This patch covers parsing of the following two formats for 'memmap'
> > > > > > parameter values:
> > > > > >
> > > > > > - nn[KMG]@ss[KMG]
> > > > > > - nn[KMG]$ss[KMG]
> > > > > >
> > > > > > ([KMG] = K M or G (kilo, mega, giga))
> > > > > >
> > > > > > These two allowed formats for parameter value are already documented
> > > > > > in file kernel-parameters.txt in Documentation/admin-guide folder.
> > > > > > Some architectures already support them, but Mips did not prior to

I believe you should add RISCV to the list of supported architectures for
these options.

> > > > > Copy-paste from a Mips patch? Should say riscv :)
> > > > >
> > > > > It looks like this code is duplicated from xtensa and is effectively the
> > > > > same as mips. Can this code be placed in a generic file so that the code
> > > > > can be shared between mips, riscv, and xtensa -- maybe a new config that
> > > > > gets selected by mips/riscv/xtensa?
> > > >
> > > > Yeah, that's actually what I was thinking. Which general file do you
> > > > think would be more suitable to put it in?
> > >
> > > I am not sure the best place to put it. What do you think about
> > > mm/memblock.c next to the "memblock" early param?
> > 
> > Is it inappropriate to put it in memblock? The implementation of mips
> > is different from that of xtensa, and early_mem is also distributed in
> > various archs, so we still put memmap in riscv/, and then I will
> > modify the commit log.
> > What do you think?
> 
> The mips implementation is very close to being the same, but I am not
> sure if the differences would prevent standardization. xtensa and now
> riscv would have identical implementations though so a generic memmap
> implementation could be only applied to those two archs.

The memmap= is generally a hack to workaround issues with how firmware
describes memory to the kernel so in a way it belongs to arch/ code.

mips and xtensa already have different views on how this should be treated,
not mentioning x86 that handles memmap= on e820 level rather than with
memblock.

> > > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > > index e3405e4b99af..7be7ec3092ad 100644
> > > > > > --- a/arch/riscv/mm/init.c
> > > > > > +++ b/arch/riscv/mm/init.c
> > > > > > @@ -208,6 +208,56 @@ static int __init early_mem(char *p)
> > > > > >  }
> > > > > >  early_param("mem", early_mem);
> > > > > >
> > > > > > +static void __init parse_memmap_one(char *p)
> > > > > > +{
> > > > > > +     char *oldp;
> > > > > > +     unsigned long start_at, mem_size;
> > > > > > +
> > > > > > +     if (!p)
> > > > > > +             return;
> > > > > > +
> > > > > > +     oldp = p;
> > > > > > +     mem_size = memparse(p, &p);
> > > > > > +     if (p == oldp)
> > > > > > +             return;
> > > > > > +
> > > > > > +     switch (*p) {
> > > > > > +     case '@':
> > > > > > +             start_at = memparse(p + 1, &p);
> > > > > > +             memblock_add(start_at, mem_size);
> > > > > > +             break;
> > > > > > +
> > > > > > +     case '$':
> > > > > > +             start_at = memparse(p + 1, &p);
> > > > > > +             memblock_reserve(start_at, mem_size);

This will add a region to memblock.reserved, but if there is no memory
there this information won't be available after boot, e.g. there won't be
struct pages with PG_Reserved for this region.
Is this your intention?

> > > > > > +             break;
> > > > > > +
> > > > > > +     case 0:
> > > > > > +             memblock_reserve(mem_size, -mem_size);

This corresponds to the case memmap=nn[KMG] and it is not documented in
kernel-parameters.txt.

Not sure it's needed at all as the same result can be achieved with
memmap=nn[KMG]$0.

> > > > > > +             break;
> > > > > > +
> > > > > > +     default:
> > > > > > +             pr_warn("Unrecognized memmap syntax: %s\n", p);
> > > > > > +             break;
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +static int __init parse_memmap_opt(char *str)
> > > > > > +{
> > > > > > +     while (str) {
> > > > > > +             char *k = strchr(str, ',');
> > > > > > +
> > > > > > +             if (k)
> > > > > > +                     *k++ = 0;
> > > > > > +
> > > > > > +             parse_memmap_one(str);
> > > > > > +             str = k;
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +early_param("memmap", parse_memmap_opt);
> > > > > > +
> > > > > >  static void __init setup_bootmem(void)
> > > > > >  {
> > > > > >       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> > > > > > --
> > > > > > 2.20.1
> > > > > >
> > > > > >
> > > > > > _______________________________________________
> > > > > > linux-riscv mailing list
> > > > > > linux-riscv@lists.infradead.org
> > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > >
> > > > Thanks,
> > > > Yunhui
> > 
> > Thanks,
> > Yunhui

-- 
Sincerely yours,
Mike.

