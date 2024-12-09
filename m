Return-Path: <linux-kernel+bounces-437352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 202B79E921E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6872826BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F221A92A;
	Mon,  9 Dec 2024 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Pec9Koej"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9D121A925
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743545; cv=none; b=EBQlkLFhbBHfkQiUzNtqRZZv7QyVDyz15fmrlb+3OFUOphhVOkdWYB2yQKxhoG5kPlu4p1s94sHm7jaw4LuDL3bGV9QIavICQKlOJjUmuwOlYqXHi7XiX55SyZsJWS2N97pQBAzBzQdZ0ECRj1gSMv2/5InxGo11lqHXvJt45+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743545; c=relaxed/simple;
	bh=7ma5kxZ2IObSDEvr0gHsRZCRNDM4KRnzNLDF0yKcYOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7j11e3ZAdsf87iU2+DF5ukv0/CrrNjHQQMn/ZRN+olQ4OX0vMT1Qo1s6nKPL55AKrDnLvS/Ed02xOm+6lOyWdls5Y4lG4ndgl4cJewR7EXscoAeebWeGg3dg+C9b5GLe9UOCXYAyaLpiUzfJJ5gq66zMPmRFhDClqE+dqiUhOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Pec9Koej; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-725db141410so1057061b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 03:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733743543; x=1734348343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHA4rrhpw4mCY6t+0KbwKHvWRS59L5Y67TgqrsNDQ+Y=;
        b=Pec9Koeji9NymIuMlSNqAFwraETlzJiv0nw6V37fvg16yQN3+9h1h29NcUYZqw+5P0
         BSeaBVUYjIHwrXbwtDTciq+F2jWV+lrK0jsBtTdMeMe51Omo8bHC21UHdHljStfXz0zc
         PpK/2KB7AvFzDCIh2qasqWYP2CjmeirvWyH2Y1VMV/ic0vwa+S6m/KZqKLlKJgSTuZaD
         bYXFUnrkLKg682x/FjcH8NlMRnIZalRq5QtqJakEV3EEjrEnsNSXeETqQF0N9RiUwwJx
         uD2623Cub+IUPylJLsyIaJyMgk49ejZXnHg7wDLJgwvsBzHwfpJVs3yMAIJUtq77EnoF
         mcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733743543; x=1734348343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHA4rrhpw4mCY6t+0KbwKHvWRS59L5Y67TgqrsNDQ+Y=;
        b=CmoNt+E9nh1OvQZnPrhr0lq0Lkan63MU38DUdw/tBl129fBOIZjPFmINlE69/uxZ2g
         K16apqhLTBXwalz6dNZz9YMy61lcq+dQB15SYrSlvnYYpyeaX4lSmlTpZBXsn1UHGbDu
         Gqc/VhkCBzAFv26LmBMUUcpXchylIqVAAsWuqfbOG6gfO/JYHNuzxg7G3XfPSD786I48
         OZKBLLl007E6ojKWGxjFze9OJDr78E0fUjIpzp0pwJLqw7H+6QAXe1X7G353GOFetnW1
         Z6yqU5ilf8aLGvF3AAKIvQA2FHaHPLQ9zMtxqKnV5Ged5vMEYTTdoKHU5K9rS1vVvPhO
         fW8w==
X-Forwarded-Encrypted: i=1; AJvYcCWCFVt2BGHDCMhcuaERFj21VjwwPxoCsT9aa0xbq5kgws+jNZttC+LI51UuyuENaHyEWjs2UfkxRD0XPJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBs0bq00WlZXfhxpLT78t+LsM4FrTpwjCtK3s87IeemnYA6A/3
	WmWePC/ppblgoRsODVaA4N77BbipC26wakgefePyEdXq86szElixgu4VBMx2HYIB3lOr6vykvFp
	YHjhi351p6wJWFjdp8iuIPSftJRIvKV8ZHna0xw==
X-Gm-Gg: ASbGncupnLT9eW0DUKOt2PyZuaavNswVd5yr6gxpnIZ6YBVYVs2DA73HM/I0E5cljAP
	34y0pOOBwQ4LeDaV8au+q2C6yHvZhdPjQGdEM+VLHZoUF
X-Google-Smtp-Source: AGHT+IG8bMdzF45gcwEEZOjAJoVHDLPDa6nJ81G1ZY5gzgAVgddnasKv7aHmuriiRk3f+tGQFELcJ98uM8ovGQvjKJg=
X-Received: by 2002:a05:6a21:999c:b0:1e1:a716:3157 with SMTP id
 adf61e73a8af0-1e1b1ad1142mr49912637.17.1733743542812; Mon, 09 Dec 2024
 03:25:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209095113.41154-1-luxu.kernel@bytedance.com> <87v7vtw234.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87v7vtw234.fsf@all.your.base.are.belong.to.us>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 9 Dec 2024 19:25:32 +0800
Message-ID: <CAPYmKFtq4zT4Jk0QyGnZacQJ=6JY-kgQuiGYrbjsfDE+r36QBA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] riscv: mm: Fix the out of bound issue
 of vmemmap address
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, alexghiti@rivosinc.com, 
	bjorn@rivosinc.com, lihangjing@bytedance.com, xieyongji@bytedance.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bj=C3=B6rn,

Thanks for your comment. Is it OK to introduce the new and unused
variable 'vmemmap_start_pfn' when CONFIG_SPARSEMEM_VMEMMAP is
disabled?

On Mon, Dec 9, 2024 at 7:03=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Minor nits below; Too many ifdefs.
>
> Xu Lu <luxu.kernel@bytedance.com> writes:
>
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
> > This commit fixes this bug by introducing a new variable
> > 'vmemmap_start_pfn' which is aligned with memory section size and using
> > it to calculate vmemmap address instead of phys_ram_base.
> >
> > Fixes: a11dd49dcb93 ("riscv: Sparse-Memory/vmemmap out-of-bounds fix")
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > ---
> >  arch/riscv/include/asm/page.h    |  4 ++++
> >  arch/riscv/include/asm/pgtable.h |  4 +++-
> >  arch/riscv/mm/init.c             | 18 ++++++++++++++++++
> >  3 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pag=
e.h
> > index 71aabc5c6713..a1be1adcfb85 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -123,6 +123,10 @@ struct kernel_mapping {
> >  extern struct kernel_mapping kernel_map;
> >  extern phys_addr_t phys_ram_base;
> >
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>
> Not needed, and should be removed.
>
> > +extern unsigned long vmemmap_start_pfn;
> > +#endif
> > +
> >  #define is_kernel_mapping(x) \
> >       ((x) >=3D kernel_map.virt_addr && (x) < (kernel_map.virt_addr + k=
ernel_map.size))
> >
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/=
pgtable.h
> > index d4e99eef90ac..e2dbd4b9a686 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -87,7 +87,9 @@
> >   * Define vmemmap for pfn_to_page & page_to_pfn calls. Needed if kerne=
l
> >   * is configured with CONFIG_SPARSEMEM_VMEMMAP enabled.
> >   */
> > -#define vmemmap              ((struct page *)VMEMMAP_START - (phys_ram=
_base >> PAGE_SHIFT))
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>
> Dito, please remove.
>
> > +#define vmemmap              ((struct page *)VMEMMAP_START - vmemmap_s=
tart_pfn)
> > +#endif
> >
> >  #define PCI_IO_SIZE      SZ_16M
> >  #define PCI_IO_END       VMEMMAP_START
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 0e8c20adcd98..e7c52d647f50 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -32,6 +32,9 @@
> >  #include <asm/numa.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/sections.h>
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>
> Not needed, please remove.
>
> > +#include <asm/sparsemem.h>
> > +#endif
> >  #include <asm/soc.h>
> >  #include <asm/tlbflush.h>
> >
> > @@ -62,6 +65,13 @@ EXPORT_SYMBOL(pgtable_l5_enabled);
> >  phys_addr_t phys_ram_base __ro_after_init;
> >  EXPORT_SYMBOL(phys_ram_base);
> >
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +#define VMEMMAP_ADDR_ALIGN   (1ULL << SECTION_SIZE_BITS)
> > +
> > +unsigned long vmemmap_start_pfn __ro_after_init;
> > +EXPORT_SYMBOL(vmemmap_start_pfn);
> > +#endif
> > +
> >  unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
> >                                                       __page_aligned_bs=
s;
> >  EXPORT_SYMBOL(empty_zero_page);
> > @@ -243,6 +253,11 @@ static void __init setup_bootmem(void)
> >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> >               phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> >
> > +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> > +     if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > +             vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMMAP_A=
DDR_ALIGN) >> PAGE_SHIFT;
> > +#endif
> > +
>
> Please fold this into the if-statement above, e.g.:
>   |         if (!IS_ENABLED(CONFIG_XIP_KERNEL)) {
>   |                 phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK=
;
>   | #if defined(CONFIG_SPARSEMEM_VMEMMAP)
>   |                 vmemmap_start_pfn =3D round_down(phys_ram_base, VMEMM=
AP_ADDR_ALIGN) >> PAGE_SHIFT;
>   | #endif
>   |         }
>
>
> Bj=C3=B6rn

Best Regards,

Xu Lu

