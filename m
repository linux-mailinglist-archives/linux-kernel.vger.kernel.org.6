Return-Path: <linux-kernel+bounces-434301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306C9E6498
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9D9169F31
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578351865FA;
	Fri,  6 Dec 2024 03:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S7GbuEp5"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20B41C77
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 03:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454694; cv=none; b=ZM28WNcD4/EOKAj8w5I9pDXCHtPowNIE0P5j6jzAHIViEBQ9OuYUmh0uQ70GhXtk5DjLPLZbb39sz4gnsajulzVUWKnGe56MIEIjKsEl6D5tws+KEoXirqZn5J5pOX/EXh1gyFdM7y1bS8zWBXfzrr+Yk8SroTayPokxxp//uGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454694; c=relaxed/simple;
	bh=Z4J7TkCwX7hDU1Qu/rRgqv+dTbzMJN55S6FBRGCH+wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuaLeMn/KV7pUqEHoNZuApQTPUu0bNJ6jsg9ygGEOBgxhJbNOvE9F9HPHIlx1+fQ084nVlPZN5a15nBZD5UUFkZM4sFgr/vJVAjQlr85bR+ZtK+CjwSdbSVUVlnuhhj8R8+E2t4SmmoBzNHh0yzChWrITTVb91Du3UcBsfLkrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S7GbuEp5; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef6af22ea8so303861a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 19:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733454690; x=1734059490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPtELaheiEZ50gSakyGhUgUYd2EpF+2rxS7HLuOc52o=;
        b=S7GbuEp5hskuC1/b1tfbsAwkJXbY63sHJXqxNzXSpKKRrTKWf/WNkCRIOnVbh+2ary
         ONotlP1XHUQ6+g6s4/UWlI29y3k0HjFyHD74/4uE58/c2dF9/7+PtK0GoVWSxNhcwFTK
         9PXhMptCLH62kcGolcX5asT5iYxT2//oGfpzzliUNkEysWm7PFqE8ghR3tu/UccX/Usu
         NxU/vH5ex4VowUsUi2xfCx49/DddlzTQTGQDuH9Wl7ET37wfv2vIk38CZYmk38hoS6Kd
         SW1syDcr+K1H0pF9nB9p70VW79sSC5nLf1hJJ/hC1nFF0SN8mSaWy29rHUg0onIjkiOB
         iw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733454690; x=1734059490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vPtELaheiEZ50gSakyGhUgUYd2EpF+2rxS7HLuOc52o=;
        b=hCwnBzPdQ5WUwxpIoBPWu8DuFPTfykphmIatr1at82LWXeuvRbPaNrKAx3AQ9oIuND
         L9JqkUYXEWW/f6cV7+M7NSiy1vUs8LCi//oXK9Dt5Z73D/sn5XlzF0glGx+KXZQDraNj
         M+Vx/R8/T6eUcPLJUyt8dgtZTjw1+3lvHSEdO8VPgxC7u+WuVbFC3rWoyHETCh7Ss/R5
         MZxPgt+lvGkma+KSMjqVFjAdUzryUiDCNI9x0prg27BbppLJ8idY5+wo18HQxVBnIxcN
         9VMs3BSpTr13Nbq3vufXuxTsLp8UF/K3c3l4oyW3VOqooR6tcYUzVuO0LhRi1mPsmFrl
         TqJg==
X-Forwarded-Encrypted: i=1; AJvYcCUloMUXio482/fB62DeZrUqCVs7gF+rFv9ATLhaxlr59R+0JockDv0BR46WJnNWRLEw65XQJkoBuBdUwbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycUA9xZO2UkWbaXjF/w8xMq/4Qn18OuaLSQ5CXEjY+mAOXrGlj
	1vmfKfk2aGN5J2WSKOxPnttuJwV1wTAv6PwSKfo5T9UcjMNaRtcKOzjY/iAVhk6oPFhz9Pgv26r
	eM18G7CQ/gcXQ/dQqmUO+/db6GP5NNxw5dHE7vg==
X-Gm-Gg: ASbGnct8f5sjRHMXvdxFqzWNLefn5PU/7Oq8Pm0r6KQQ3AR36FHiikSskDp1ZsiLNgc
	mvNq1iPaWYsDAqkeiP/lTxp5KBBASUL0fnuZatguzIMz3
X-Google-Smtp-Source: AGHT+IHV0/FTNpzXCB+SWhNxGQqOyiwBlyuuQ4ZUGS/dKk13G8i2+s+EFfOF0h8AXMfdA7fqW2w35m8OZih68Z2b3+Q=
X-Received: by 2002:a17:90b:524e:b0:2ee:f1e3:fd21 with SMTP id
 98e67ed59e1d1-2ef6aaeedffmr2341974a91.25.1733454690511; Thu, 05 Dec 2024
 19:11:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203144954.91731-1-luxu.kernel@bytedance.com> <edba44ad-a4b6-473d-a175-142ea49add1c@ghiti.fr>
In-Reply-To: <edba44ad-a4b6-473d-a175-142ea49add1c@ghiti.fr>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 6 Dec 2024 11:11:19 +0800
Message-ID: <CAPYmKFtAAZkY-v7Oat4dXYnm6zCcReMnDdFo3qcqtqhj1wv8eg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] riscv: mm: Fix alignment of phys_ram_base
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, bjorn@rivosinc.com, lihangjing@bytedance.com, 
	xieyongji@bytedance.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Thu, Dec 5, 2024 at 10:34=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Xu,
>
> On 03/12/2024 15:49, Xu Lu wrote:
> > This commit fixes the alignment of phys_ram_base in RISC-V.
> >
> > In sparse vmemmap model, the virtual address of vmemmap is calculated a=
s:
> > ((struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)).
> > And the struct page's va can be calculated with an offset:
> > (vmemmap + (pfn)).
> >
> > However, when initializing struct pages, kernel actually starts from th=
e
> > first page from the same section that phys_ram_base belongs to. If the
> > first page's physical address is not (phys_ram_base >> PAGE_SHIFT), the=
n
> > we get an va below VMEMMAP_START when calculating va for it's struct pa=
ge.
> >
> > For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, =
the
> > first page in the same section is actually pfn 0x80000. During
> > init_unavailable_range(), we will initialize struct page for pfn 0x8000=
0
> > with virtual address ((struct page *)VMEMMAP_START - 0x2000), which is
> > below VMEMMAP_START as well as PCI_IO_END.
> >
> > This commit fixes this bug by aligning phys_ram_base with SECTION_SIZE.
> >
> > Fixes: c3bcc65d4d2e ("riscv: Start of DRAM should at least be aligned o=
n PMD size for the direct mapping")
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >   arch/riscv/mm/init.c | 15 ++++++++++++++-
> >   1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 0e8c20adcd98..974cafa7c85e 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -33,6 +33,9 @@
> >   #include <asm/pgtable.h>
> >   #include <asm/sections.h>
> >   #include <asm/soc.h>
> > +#ifdef CONFIG_SPARSEMEM
> > +#include <asm/sparsemem.h>
> > +#endif
> >   #include <asm/tlbflush.h>
> >
> >   #include "../kernel/head.h"
> > @@ -59,6 +62,12 @@ EXPORT_SYMBOL(pgtable_l4_enabled);
> >   EXPORT_SYMBOL(pgtable_l5_enabled);
> >   #endif
> >
> > +#ifdef CONFIG_SPARSEMEM
> > +#define RISCV_MEMSTART_ALIGN (1UL << SECTION_SIZE_BITS)
> > +#else
> > +#define RISCV_MEMSTART_ALIGN PMD_SIZE
> > +#endif
> > +
> >   phys_addr_t phys_ram_base __ro_after_init;
> >   EXPORT_SYMBOL(phys_ram_base);
> >
> > @@ -239,9 +248,13 @@ static void __init setup_bootmem(void)
> >       /*
> >        * Make sure we align the start of the memory on a PMD boundary s=
o that
> >        * at worst, we map the linear mapping with PMD mappings.
> > +      *
> > +      * Also, make sure we align the start of the memory on a SECTION =
boundary
> > +      * when CONFIG_SPARSEMEM_VMEMMAP is enabled to ensure the correct=
ness of
> > +      * pfn_to_page().
> >        */
> >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > -             phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> > +             phys_ram_base =3D round_down(memblock_start_of_DRAM(), RI=
SCV_MEMSTART_ALIGN);
> >
> >       /*
> >        * In 64-bit, any use of __va/__pa before this point is wrong as =
we
>
>
> That's a good catch indeed. But I'm wondering if it would be more
> correct to fix the macro vmemmap instead of phys_ram_base since
> phys_ram_base is supposed to hold the real base of the system memory,
> which would be wrong with your patch. I mean something like that instead
> (or similar, I haven't tested):
>
> #define vmemmap         ((struct page *)VMEMMAP_START -
> (round_down(memblock_start_of_DRAM(), RISCV_MEMSTART_ALIGN) >> PAGE_SHIFT=
))

Thanks for your comment.

Good idea. I have thought about this. But I wasn't sure if it's OK to
introduce extra calculation whenever pfn_to_page() and page_to_pfn()
is called. So I referred to ARM which aligns memstart_addr with
SECTION size too and then made a similar modification.

If it is not appropriate to change the semantics of phys_ram_base, how
about introducing a new variable vmemmap_start_addr and use it to
calculate vmemmap:

#define vmemmap         ((struct page *)VMEMMAP_START -
(vmemmap_start_addr >> PAGE_SHIFT))

Best Regards,

Xu Lu

>
> And the fixes tag should be:
>
> Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
>
> Thanks,
>
> Alex
>

