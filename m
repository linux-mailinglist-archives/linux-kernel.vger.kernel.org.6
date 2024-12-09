Return-Path: <linux-kernel+bounces-437377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49A9E9272
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A232854DC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E00D2236EF;
	Mon,  9 Dec 2024 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLhtsUlS"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191B221DBB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743884; cv=none; b=BL7jRpGP9fM8Wr9hVGkQkJtbHN1e62Sq8l5u1lPdTJU33MxObQlROYjGT5565Xo0U/Cs/Lf1Bfr9WWXmJuCVal7e49aQHN8kc3kToKRqOYTXAyEQMn2E2YxeiBIHKgNs9p/GfMYvFfnO11pfPwE5CeMfGND3ujh5eQpsdaq5vLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743884; c=relaxed/simple;
	bh=w+9M6lMhuDHQ/Aq2QLl945gB5rcJkuf7b58pQ/lwEF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWJkIIF3JQcFDAYdj3yNg+Bm743+042Ui8y9e8su1JnVLscS9AkA+zGBn7Ogc8VrVIBl/e71KRpHEMtMkWhZguRJ8Rf0717PCAFgD/Oe1RoNbLj69iPj0QDNHnqttMnf/xTaLBgQ0IsOY613hi3F/IUl8H+OeITRlIvi2OFuL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLhtsUlS; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-467540980c9so19196301cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733743882; x=1734348682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uv059c/gl9yEVwmaE22LugFlYT0Oq+b13AMGJcZXSIs=;
        b=PLhtsUlSOE2kmmWLgcwsvwICIZy+5sDJh0DTaYbNF4mgDSxSb0l43ddkF1vWAe1v66
         n0/cAd86hFPhOKwjPXLAbbmkcxfpcpK7FeuhhqTde9V8lZSj+qkeg0abhLkhhGNMKGVj
         /oTkO8Kh8GkV/1lsGZr4KrhWDgnWSspSyxLafpTkud69ZkfKn1Z5jPBXanRK7XrxNAf+
         SKTJ7T9qbxlLtMynRLtunF/oyVfUmyb57EnwaB0Pv6I9s4d/T8m5JgLtVPQpUttcUffL
         Idg2d6NpsbNVnwdubrUnq6JdNdnphlpi5f86jwuoEI2D8ax8WAlzri+1wSGjNhXETS4/
         kkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743882; x=1734348682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uv059c/gl9yEVwmaE22LugFlYT0Oq+b13AMGJcZXSIs=;
        b=TEViM6cYpKA7vAEExYv7OpLTxQygHJ+0lp/aDTPBqrTTktC6og5TpOSlt1g8TakLUT
         hxnGVuIEKn2uRPmpCWgFWiRsLDb7eqk/JxWAsciXE2TFVilGssTLqybfMRw348iJAgQR
         T0GAPYZtjxlxY7oUTgFxQca+xTU+PZFSnIIbKnsoIxM3JtMEcK81sLF6RRoq5mCcIptV
         Bxv/8e/ZOdP1EeazBIWoVAmBaaH9Fv4qL91lN383c4dlipAc5biTsfkM0loESy6qxFZ+
         iT5AEdqk2s/Sno0+6ZVfg58QPzkC5LiOZB+4LpDvJLpZv6HUGjYHaUXJ4c9tmB6io0xw
         PFFA==
X-Forwarded-Encrypted: i=1; AJvYcCUjeX32smXGqhwQ5f1p7aH+dOfwc2+98ITmG50fMrE82l3pSU+lTmscQMV9NeQM+gLAiYRxHoLaVORTKgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzts7vPG8wRgCir0K0pL6nlZJXiz1Jg2tQ1dObc+OVpKKqBloLE
	/P+7iYBcRdyCveW0Wk/erM0MuXjevzS7nA2liL0/Sy9ptPFDN4Fs0b3Sj2hKW5vkWh5fXaN9rZf
	B0z2h8hQOqHQNkdy5NWVlDqPnkpI=
X-Gm-Gg: ASbGncuGo7O/EMGxpuMzc8xw+F7EIkltWaTm4e8H8gOnh9pVGM7sMSfwbdIs/euF4Xl
	wbt/O09Jm3xcRtV9mn09Khtxv2bFSYpg=
X-Google-Smtp-Source: AGHT+IHzwwk5VzRE+bAS7irOdqZiT8NZLGj5VPzm62ZlvJpVIkcX47OELAY/49XpLxkla+ZJlVsQC9Ywwb6FCaGRwOI=
X-Received: by 2002:a05:622a:4a1a:b0:467:681c:425f with SMTP id
 d75a77b69052e-467681c44famr43464881cf.4.1733743881821; Mon, 09 Dec 2024
 03:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209095113.41154-1-luxu.kernel@bytedance.com>
 <87v7vtw234.fsf@all.your.base.are.belong.to.us> <CAPYmKFtq4zT4Jk0QyGnZacQJ=6JY-kgQuiGYrbjsfDE+r36QBA@mail.gmail.com>
In-Reply-To: <CAPYmKFtq4zT4Jk0QyGnZacQJ=6JY-kgQuiGYrbjsfDE+r36QBA@mail.gmail.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date: Mon, 9 Dec 2024 12:31:10 +0100
Message-ID: <CAJ+HfNhYb9wNJ5m7-VEo1=FdRJ_h4fBYm2YqS+q=T6xrth2sSA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] riscv: mm: Fix the out of bound issue
 of vmemmap address
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, alexghiti@rivosinc.com, 
	bjorn@rivosinc.com, lihangjing@bytedance.com, xieyongji@bytedance.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 9 Dec 2024 at 12:25, Xu Lu <luxu.kernel@bytedance.com> wrote:
>
> Hi Bj=C3=B6rn,
>
> Thanks for your comment. Is it OK to introduce the new and unused
> variable 'vmemmap_start_pfn' when CONFIG_SPARSEMEM_VMEMMAP is
> disabled?

The declaration, yes. Definition, no!


Cheers,
Bj=C3=B6rn

> On Mon, Dec 9, 2024 at 7:03=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
> >
> > Minor nits below; Too many ifdefs.
> >
> > Xu Lu <luxu.kernel@bytedance.com> writes:
> >
> > > In sparse vmemmap model, the virtual address of vmemmap is calculated=
 as:
> > > ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
> > > And the struct page's va can be calculated with an offset:
> > > (vmemmap + (pfn)).
> > >
> > > However, when initializing struct pages, kernel actually starts from =
the
> > > first page from the same section that phys_ram_base belongs to. If th=
e
> > > first page's physical address is not (phys_ram_base >> PAGE_SHIFT), t=
hen
> > > we get an va below VMEMMAP_START when calculating va for it's struct =
page.
> > >
> > > For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000=
, the
> > > first page in the same section is actually pfn 0x80000. During
> > > init_unavailable_range(), we will initialize struct page for pfn 0x80=
000
> > > with virtual address ((struct page *)VMEMMAP_START - 0x2000), which i=
s
> > > below VMEMMAP_START as well as PCI_IO_END.
> > >
> > > This commit fixes this bug by introducing a new variable
> > > 'vmemmap_start_pfn' which is aligned with memory section size and usi=
ng
> > > it to calculate vmemmap address instead of phys_ram_base.
> > >
> > > Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix"=
)
> > > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > > ---
> > >  arch/riscv/include/asm/page.h    |  4 ++++
> > >  arch/riscv/include/asm/pgtable.h |  4 +++-
> > >  arch/riscv/mm/init.c             | 18 ++++++++++++++++++
> > >  3 files changed, 25 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/p=
age.h
> > > index 71aabc5c6713..a1be1adcfb85 100644
> > > --- a/arch/riscv/include/asm/page.h
> > > +++ b/arch/riscv/include/asm/page.h
> > > @@ -123,6 +123,10 @@ struct kernel_mapping {
> > >  extern struct kernel_mapping kernel_map;
> > >  extern phys_addr_t phys_ram_base;
> > >
> > > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >
> > Not needed, and should be removed.
> >
> > > +extern unsigned long vmemmap_start_pfn;
> > > +#endif
> > > +
> > >  #define is_kernel_mapping(x) \
> > >       ((x) >=3D kernel_map.virt_addr && (x) < (kernel_map.virt_addr +=
 kernel_map.size))
> > >
> > > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/as=
m/pgtable.h
> > > index d4e99eef90ac..e2dbd4b9a686 100644
> > > --- a/arch/riscv/include/asm/pgtable.h
> > > +++ b/arch/riscv/include/asm/pgtable.h
> > > @@ -87,7 +87,9 @@
> > >   * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if ker=
nel
> > >   * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
> > >   */
> > > -#define vmemmap              ((struct page *)VMEMMAP_START - (phys_r=
am_base >> PAGE_SHIFT))
> > > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >
> > Dito, please remove.
> >
> > > +#define vmemmap              ((struct page *)VMEMMAP_START - vmemmap=
_start_pfn)
> > > +#endif
> > >
> > >  #define PCI_IO_SIZE      SZ_16M
> > >  #define PCI_IO_END       VMEMMAP_START
> > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > index 0e8c20adcd98..e7c52d647f50 100644
> > > --- a/arch/riscv/mm/init.c
> > > +++ b/arch/riscv/mm/init.c
> > > @@ -32,6 +32,9 @@
> > >  #include <asm/numa.h>
> > >  #include <asm/pgtable.h>
> > >  #include <asm/sections.h>
> > > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >
> > Not needed, please remove.
> >
> > > +#include <asm/sparsemem.h>
> > > +#endif
> > >  #include <asm/soc.h>
> > >  #include <asm/tlbflush.h>
> > >
> > > @@ -62,6 +65,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
> > >  phys_addr_t phys_ram_base __ro_after_init;
> > >  EXPORT_SYMBOL(phys_ram_base);
> > >
> > > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > > +#define VMEMMAP_ADDR_ALIGN   (1ULL << SECTION_SIZE_BITS)
> > > +
> > > +unsigned long vmemmap_start_pfn __ro_after_init;
> > > +EXPORT_SYMBOL(vmemmap_start_pfn);
> > > +#endif
> > > +
> > >  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
> > >                                                       __page_aligned_=
bss;
> > >  EXPORT_SYMBOL(empty_zero_page);
> > > @@ -243,6 +253,11 @@ static void __init setup_bootmem(void)
> > >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > >               phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> > >
> > > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > > +     if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > > +             vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMMAP=
_ADDR_ALIGN) >> PAGE_SHIFT;
> > > +#endif
> > > +
> >
> > Please fold this into the if-statement above, e.g.:
> >   |         if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
> >   |                 phys_ram_base =3D memblock_start_of_DRAM() & PMD_MA=
SK;
> >   | #if defined(CONFIG_SPARSEMEM_VMEMMAP)
> >   |                 vmemmap_start_pfn =3D round_down(phys_ram_base, VME=
MMAP_ADDR_ALIGN) >> PAGE_SHIFT;
> >   | #endif
> >   |         }
> >
> >
> > Bj=C3=B6rn
>
> Best Regards,
>
> Xu Lu

