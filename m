Return-Path: <linux-kernel+bounces-429554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF799E1DBC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C11165BD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABDD1F12E3;
	Tue,  3 Dec 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eLK82GYF"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA642192D98
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233068; cv=none; b=BT9Cxxhpu2Qg+DEh++Nwj7eZpHuzaVQENhq3dVWOH3onWc2PVGj3OsCmQ+zvVjp7cuh8EbAZ2ARZkDL1HIniObDjSb6zwUq4mb4ZGZ+z4L/gw1CWWWBnJH9LiYupZpxdNv/gJ22vuPqpBV7S6ptMJ8poF8FyLRQg2doQ/wxtCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233068; c=relaxed/simple;
	bh=nzH92nJMwxGrFHn6mrsWuBiTnG/8/csX90XmUCZdckE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULkCMfrnRfuxC8UwNEHN8dq9FwJECOk/mzHYsHdkrS6vrtuu2WEHzHAS/0aTtYgZY6jPhI5XIZfqVdckdCr8FWZhA44sG2u8IUcsQgfw7hDXw2lP7t82EgoLhhrM2QPcaaKhjldPwN+2CAeWlH/FOZpeM1Ung8wO2wSwmKmtChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eLK82GYF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so2433669a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 05:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733233066; x=1733837866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkDSy/og10q+Zv9hHO6LOGn9F3ogfIv993ECev/acMM=;
        b=eLK82GYFC6xEH69VLDgpW47nwrNhxz2m/SBnWNyWwYAyGQE/apK1Oo63UP9F6aUSRc
         QhB+WG1z5mYnc4rLOK1n+fvjAQufPRYYNmxy2ek4RJMLkJxMpR+xnKk2xCHV1rTuEc3Z
         b9xvkvuSt+JmaUYOuxvuE/0uKJAz6ji5w/mkMSTS5XOrSJxkrGqw72wZ3QeA1p/GV14C
         ZvnJIn+5kf/SIaGjX4leNcesLjoAlfkIA48dbfoLdrb9sGbpV3wWjap4g/hqKWD8fv8v
         Vn7/Bm/EObU0f62e2Up29ZciopJaXu0TKXIa8PQDvO/zvYjjnh47d43WeBxBlRE4qUby
         IfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233066; x=1733837866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkDSy/og10q+Zv9hHO6LOGn9F3ogfIv993ECev/acMM=;
        b=TP8AY8ET7MsbdKXV4FkEFXe6mLJh6NXNI/L7VqEb15VmczEw6ZiwDGQ7QXALFoHyyT
         wkWHXdYrrLmGf/XtRgHXmeR5nQX4jJrkP80S5WHnGrYr+Y9kkQrWlaReV3+txZl96vpP
         jo/dYdBA6B3ysrnQwHEzRRsQyWIJb4GCW8FAl/qilCs6FW6PXyGXcrjDlsKA9iCUA+AI
         TW9jXvRzWagn+MBD/WIypuF51Wly2fPC3B+Lp4zPwzA1rbk7qr7QAqMdw3kj/ubZufqB
         Nns7wnBT9C2cdV9XMBMfv8KsAW5GnvaBrwd3Lvp4Ua1q3Kq0EvAZU4+3wtaNTra84RBV
         Fzpg==
X-Forwarded-Encrypted: i=1; AJvYcCX3KDWEZJZVEJ1PO0t2R8lqxW6NDy3eLqCc4ErX34pIajs9JtCu4ZBpmn877aJcE3IZoRC6QBHD1nqly7g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy33cJyF+1k+O9Sx4PNeadfAfwaiDxGmnXeFQyL7oMg64a/2KU/
	VeHa8uG5feHsQVzkFJb6imaWka9fMlyegMrlWKtJErzk7qNSmPuOm54Ne4xDZCkOq+g3BdBfTKW
	XLs5oOt2NzCrAZZPAktpClaUzau+8D92MXsXCRQ==
X-Gm-Gg: ASbGncvHgIOE6DxmhURrYmKIjGxFwlemuBFMVnLnWFELHW5iq6NX0pSS/qniNHeEKFY
	uVhRLUedRut4njyGN7It7P5f8y47UHBtVAbBQrQjiMJGw
X-Google-Smtp-Source: AGHT+IFmL3luaw1fnUdkh1ethVTZLBB6zltFLUW1aXb5eColAWRa6bIo8F/gj0oAA0w7i3i8cjizJlLYIm1495p+Zcw=
X-Received: by 2002:a17:90b:3907:b0:2ee:fc08:1bc1 with SMTP id
 98e67ed59e1d1-2ef01275b48mr3480962a91.37.1733233065824; Tue, 03 Dec 2024
 05:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202101601.48284-1-luxu.kernel@bytedance.com> <871pypq942.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <871pypq942.fsf@all.your.base.are.belong.to.us>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Tue, 3 Dec 2024 21:37:35 +0800
Message-ID: <CAPYmKFvoEwec7NfMyaf=oO9jQz2o9Bvebunh=cvbNO_ESOnk5A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: mm: Fix alignment of phys_ram_base
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	lihangjing@bytedance.com, xieyongji@bytedance.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 7:50=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.=
org> wrote:
>
> Xu Lu <luxu.kernel@bytedance.com> writes:
>
> > This commit fixes the alignment of phys_ram_base in RISC-V.
> >
> > In sparse vmemmap model, the virtual address of vmemmap is calculated a=
s:
> > '(struct page *)VMEMMAP_START - (phys_ram_base >> PAGE_SHIFT)'.
> > And the struct page's va can be calculated with an offset:
> > 'vmemmap + (pfn)'.
> >
> > However, when initializing struct pages, kernel actually starts from th=
e
> > first page from the same section that phys_ram_base belongs to. If the
> > first page's physical address is not 'phys_ram_base >> PAGE_SHIFT', the=
n
> > we get an va below VMEMMAP_START when calculating va for it's struct pa=
ge.
>
> Nice catch! I managed to reproduce this on a hacked qemu virt machine.
>
> > For example, if phys_ram_base starts from 0x82000000 with pfn 0x82000, =
the
> > first page in the same section is actually pfn 0x80000. During
> > init_unavailage_range, we will initialize struct page for pfn 0x80000
>
> "init_unavailable_range()" spelling for greppability.
>
> > with virtual address '(struct page *)VMEMMAP_START - 0x2000', which is
> > below VMEMMAP_START as well as PCI_IO_END.
> >
> > This commit fixes this bug by aligning phys_ram_base with SECTION_SIZE.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
>
> Please add a fixes tag.

Roger that.

>
> > ---
> >  arch/riscv/mm/init.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 0e8c20adcd98..9866de267b74 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -59,6 +59,8 @@ EXPORT_SYMBOL(pgtable_l4_enabled);
> >  EXPORT_SYMBOL(pgtable_l5_enabled);
> >  #endif
> >
> > +#define RISCV_MEMSTART_ALIGN (1UL << SECTION_SIZE_BITS)
> > +
> >  phys_addr_t phys_ram_base __ro_after_init;
> >  EXPORT_SYMBOL(phys_ram_base);
> >
> > @@ -241,7 +243,8 @@ static void __init setup_bootmem(void)
> >        * at worst, we map the linear mapping with PMD mappings.
> >        */
> >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > -             phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
> > +             phys_ram_base =3D round_down(memblock_start_of_DRAM(),
> > +                                        RISCV_MEMSTART_ALIGN);
>
> No need to wrap this line. Also, is the RISCV_MEMSTART_ALIGN define
> really needed?

Maybe it is not so friendly to FLATMEM model if we always align
phys_ram_base with SECTION_SIZE.
I will refine the code and send again later.

>
> The kernel test robot had some build issues as well!
>
>
> Bj=C3=B6rn

