Return-Path: <linux-kernel+bounces-227106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7B891486A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 993522858BD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D3F13A86D;
	Mon, 24 Jun 2024 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b="Dg6Ci7B0"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02813A3F7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228046; cv=none; b=CWpXW5qdmjGfUw4S9QBSmCPJHAWv2Ir6B1CjIyecuGCpz8ycRJE5Z6H2xIVVu5Dwh/tOSOoNSArdUeb4RZtxwyiQE/rs8DXKHMysxxg7JlcnDnP8uXq+fuJEE85pYHrQkcUiw5kGxSgGhLDb0pLuzKIqFk7WTAEppGrcFzbOOVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228046; c=relaxed/simple;
	bh=bLWyKxXed6TxcPWMzJmgRv1yVOV6FjX72aRic/mmSxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bUhOUIzj8HCpq3/D/MYPlYWAP2jp8IG/gnNNkIlvbUtD9y04UGucY5e/jvfQusGLHiVs7CWryDIbozE6HwJAFK/InXAjJTv2d+GxmJdTXk2hgVxoYwOlqMK8gMaE3pMNOliSfuhMdPwL/SLSJYydDVsnSL8vcSzIK3TrB9TRqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com; spf=pass smtp.mailfrom=codasip.com; dkim=pass (2048-bit key) header.d=codasip.com header.i=@codasip.com header.b=Dg6Ci7B0; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=codasip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codasip.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80d61a602f2so1081883241.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codasip.com; s=google; t=1719228043; x=1719832843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CebjfQcICTC2ehOPFFSI5t/n5NXCYxjUfHiS7ip+IE=;
        b=Dg6Ci7B0sM7UB/uTGOtImFYkiul1Yj+g2Qtar77D/VnWXeNnyspSL+3mKKJ43252jv
         Ko5/3EHhzJD87Pzt/Ny+geZWoPSMWJps+pEmLeuSqLv4tihx2z8I8xzdHwZHUvtgCzvq
         rrpnX4fgflbAlX1BwhbnHENTftHcteAEKu+6Eyb8fO0XIc3AhXt6hNQKxG6FMr9EwGTg
         agTbEr23nwQKYPnNE6f0OwyLi5GWmIbQgyeC5r2FdEa4Ej6xEFblW9ttrtKN1pPkAVz6
         /Z+UmVaaV7ZBwQr+86NBQ57fbMoCyfqBa+70FB2ePNiKISkxwfZPwwJydQ5MPCCE1XfE
         mYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719228043; x=1719832843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CebjfQcICTC2ehOPFFSI5t/n5NXCYxjUfHiS7ip+IE=;
        b=qKrB36PLXGEy/jQHWFg/R/BDa6uJYmnjguTZ8tDdnfvULBBti6sfXrfgdb8+VSdy3R
         fD6B/eXsVuGrQxMdEKrFAEtUoXUqhZpHFZS503I+MRHS64WZa7sttqyCKXjttu9MQXli
         PPaElwe6ogzlYvSeUL6PHME1ZZGon/1G+ywkevKSiil0j7P+nh9Hjb3aKFMdHHLOEKUu
         dRMcuzK5n5KgsWUrQlOaCaYd3p9/zCz8tzmNmcYhairETZorBxW/G+2BI9sdYixyadzG
         Uzy+KAuUB3qk9u+cFdni42wQWSFvFep3z0/AAuHCWEQxlGCjOyzPlzKLozX9ER2G7Oix
         qjag==
X-Forwarded-Encrypted: i=1; AJvYcCUAgmiazGOkac8l6lxZrzMUoAXMi+tr2jdLFk0z0Tv6EDS3b5g9EUWh0W00pCiHrQjTP12/Q0eZinPf5TCNApfGc53uJ4hCuTMeZdNq
X-Gm-Message-State: AOJu0Yw+RPcVZR/cFZpmYoKOIXJczwZzU0l3cRzrNm21oKP9BxSr6/YT
	unTV69HPFxwhSukiu7+YgE+a89GKPaovjYIRxkAUcoD35fgpmml0vAOou1ecDOFlVHf3yCclYlJ
	2dm2SMzXrhaMdULGKEBRMHWnBQOk0PcI0pkglWg==
X-Google-Smtp-Source: AGHT+IET8NF2a5rS5SYaxeFwsPSTXXFCNtdrgGLaiJ3SzoA3n8XB3ur3K8lgi3SR3i5wHQb03phEHaCTER1d95gE3gU=
X-Received: by 2002:a05:6102:5487:b0:48f:5a71:6bcf with SMTP id
 ada2fe7eead31-48f5a716d1fmr2926274137.17.1719228042938; Mon, 24 Jun 2024
 04:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240622114217.2158495-1-stuart.menefy@codasip.com> <bdfbed9b-ea04-4415-8416-d6e9d0a643a3@ghiti.fr>
In-Reply-To: <bdfbed9b-ea04-4415-8416-d6e9d0a643a3@ghiti.fr>
From: Stuart Menefy <stuart.menefy@codasip.com>
Date: Mon, 24 Jun 2024 12:20:32 +0100
Message-ID: <CALEZRWE4PD2zADF1sVj++XkUan14SfDdugjse695gPqSorLgag@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fix linear mapping checks for non-contiguous
 memory regions
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, David McKay <david.mckay@codasip.com>, 
	Palmer Dabbelt <palmerdabbelt@google.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 8:29=E2=80=AFAM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
>
> On 22/06/2024 13:42, Stuart Menefy wrote:
> > The RISC-V kernel already has checks to ensure that memory which would
> > lie outside of the linear mapping is not used. However those checks
> > use memory_limit, which is used to implement the mem=3D kernel command
> > line option (to limit the total amount of memory, not its address
> > range). When memory is made up of two or more non-contiguous memory
> > banks this check is incorrect.
> >
> > Two changes are made here:
> >   - add a call in setup_bootmem() to memblock_cap_memory_range() which
> >     will cause any memory which falls outside the linear mapping to be
> >     removed from the memory regions.
> >   - remove the check in create_linear_mapping_page_table() which was
> >     intended to remove memory which is outside the liner mapping based
> >     on memory_limit, as it is no longer needed. Note a check for
> >     mapping more memory than memory_limit (to implement mem=3D) is
> >     unnecessary because of the existing call to
> >     memblock_enforce_memory_limit().
> >
> > This issue was seen when booting on a SV39 platform with two memory
> > banks:
> >    0x00,80000000 1GiB
> >    0x20,00000000 32GiB
> > This memory range is 158GiB from top to bottom, but the linear mapping
> > is limited to 128GiB, so the lower block of RAM will be mapped at
> > PAGE_OFFSET, and the upper block straddles the top of the linear
> > mapping.
> >
> > This causes the following Oops:
> > [    0.000000] Linux version 6.10.0-rc2-gd3b8dd5b51dd-dirty (stuart.men=
efy@codasip.com) (riscv64-codasip-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binut=
ils) 2.41.0.20231213) #20 SMP Sat Jun 22 11:34:22 BST 2024
> > [    0.000000] memblock_add: [0x0000000080000000-0x00000000bfffffff] ea=
rly_init_dt_add_memory_arch+0x4a/0x52
> > [    0.000000] memblock_add: [0x0000002000000000-0x00000027ffffffff] ea=
rly_init_dt_add_memory_arch+0x4a/0x52
> > ...
> > [    0.000000] memblock_alloc_try_nid: 23724 bytes align=3D0x8 nid=3D-1=
 from=3D0x0000000000000000 max_addr=3D0x0000000000000000 early_init_dt_allo=
c_memory_arch+0x1e/0x48
> > [    0.000000] memblock_reserve: [0x00000027ffff5350-0x00000027ffffaffb=
] memblock_alloc_range_nid+0xb8/0x132
> > [    0.000000] Unable to handle kernel paging request at virtual addres=
s fffffffe7fff5350
> > [    0.000000] Oops [#1]
> > [    0.000000] Modules linked in:
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 6.10.0-rc2-gd3b8=
dd5b51dd-dirty #20
> > [    0.000000] Hardware name: codasip,a70x (DT)
> > [    0.000000] epc : __memset+0x8c/0x104
> > [    0.000000]  ra : memblock_alloc_try_nid+0x74/0x84
> > [    0.000000] epc : ffffffff805e88c8 ra : ffffffff806148f6 sp : ffffff=
ff80e03d50
> > [    0.000000]  gp : ffffffff80ec4158 tp : ffffffff80e0bec0 t0 : ffffff=
fe7fff52f8
> > [    0.000000]  t1 : 00000027ffffb000 t2 : 5f6b636f6c626d65 s0 : ffffff=
ff80e03d90
> > [    0.000000]  s1 : 0000000000005cac a0 : fffffffe7fff5350 a1 : 000000=
0000000000
> > [    0.000000]  a2 : 0000000000005cac a3 : fffffffe7fffaff8 a4 : 000000=
000000002c
> > [    0.000000]  a5 : ffffffff805e88c8 a6 : 0000000000005cac a7 : 000000=
0000000030
> > [    0.000000]  s2 : fffffffe7fff5350 s3 : ffffffffffffffff s4 : 000000=
0000000000
> > [    0.000000]  s5 : ffffffff8062347e s6 : 0000000000000000 s7 : 000000=
0000000001
> > [    0.000000]  s8 : 0000000000002000 s9 : 00000000800226d0 s10: 000000=
0000000000
> > [    0.000000]  s11: 0000000000000000 t3 : ffffffff8080a928 t4 : ffffff=
ff8080a928
> > [    0.000000]  t5 : ffffffff8080a928 t6 : ffffffff8080a940
> > [    0.000000] status: 0000000200000100 badaddr: fffffffe7fff5350 cause=
: 000000000000000f
> > [    0.000000] [<ffffffff805e88c8>] __memset+0x8c/0x104
> > [    0.000000] [<ffffffff8062349c>] early_init_dt_alloc_memory_arch+0x1=
e/0x48
> > [    0.000000] [<ffffffff8043e892>] __unflatten_device_tree+0x52/0x114
> > [    0.000000] [<ffffffff8062441e>] unflatten_device_tree+0x9e/0xb8
> > [    0.000000] [<ffffffff806046fe>] setup_arch+0xd4/0x5bc
> > [    0.000000] [<ffffffff806007aa>] start_kernel+0x76/0x81a
> > [    0.000000] Code: b823 02b2 bc23 02b2 b023 04b2 b423 04b2 b823 04b2 =
(bc23) 04b2
> > [    0.000000] ---[ end trace 0000000000000000 ]---
> > [    0.000000] Kernel panic - not syncing: Attempted to kill the idle t=
ask!
> > [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill t=
he idle task! ]---
> >
> > The problem is that memblock (unaware that some physical memory cannot
> > be used) has allocated memory from the top of memory but which is
> > outside the linear mapping region.
> >
> > Signed-off-by: Stuart Menefy <stuart.menefy@codasip.com>
> > Fixes: c99127c45248 ("riscv: Make sure the linear mapping does not use =
the kernel mapping")
> > Reviewed-by: David McKay <david.mckay@codasip.com>
> >
> > ---
> >   arch/riscv/mm/init.c | 15 +++++++++++----
> >   1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index e3405e4b99af..7e25606f858a 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -233,8 +233,6 @@ static void __init setup_bootmem(void)
> >        */
> >       memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> >
> > -     phys_ram_end =3D memblock_end_of_DRAM();
> > -
> >       /*
> >        * Make sure we align the start of the memory on a PMD boundary s=
o that
> >        * at worst, we map the linear mapping with PMD mappings.
> > @@ -249,6 +247,16 @@ static void __init setup_bootmem(void)
> >       if (IS_ENABLED(CONFIG_64BIT) && IS_ENABLED(CONFIG_MMU))
> >               kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
> >
> > +     /*
> > +      * The size of the linear page mapping may restrict the amount of
> > +      * usable RAM.
> > +      */
> > +     if (IS_ENABLED(CONFIG_64BIT)) {
> > +             max_mapped_addr =3D __pa(PAGE_OFFSET) + KERN_VIRT_SIZE;
>
>
> This is only true for sv39 once the following patch lands
> https://lore.kernel.org/linux-riscv/20240514133614.87813-1-alexghiti@rivo=
sinc.com/

Hi Alex

I've seen this problem whether your patch has been applied or not.

> Otherwise, sv39 is "weirdly" restricted to 124GB. You mention in the
> changelog that the linear mapping size is limited to 128GB, does that
> mean you tested your patch on top this one ^? If so, would you mind
> adding a Tested-by to it? Otherwise, would you mind testing on top of it
> :) ?

I've tested in both cases, so I'll add a Tested-by.

Note that to actually use 128GiB on Sv39 systems yet another patch is
needed which I'll also post.

> I'll see with Palmer, but maybe we can't take both patches to -fixes.

All three patches address different issues, so I think it would be safe to
take them in any combination. However I understand the reluctance
when making changes in this area.

Thanks

Stuart


>
> You can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> Thanks,
>
> Alex
>
>
> > +             memblock_cap_memory_range(phys_ram_base,
> > +                                       max_mapped_addr - phys_ram_base=
);
> > +     }
> > +
> >       /*
> >        * Reserve physical address space that would be mapped to virtual
> >        * addresses greater than (void *)(-PAGE_SIZE) because:
> > @@ -265,6 +273,7 @@ static void __init setup_bootmem(void)
> >               memblock_reserve(max_mapped_addr, (phys_addr_t)-max_mappe=
d_addr);
> >       }
> >
> > +     phys_ram_end =3D memblock_end_of_DRAM();
> >       min_low_pfn =3D PFN_UP(phys_ram_base);
> >       max_low_pfn =3D max_pfn =3D PFN_DOWN(phys_ram_end);
> >       high_memory =3D (void *)(__va(PFN_PHYS(max_low_pfn)));
> > @@ -1289,8 +1298,6 @@ static void __init create_linear_mapping_page_tab=
le(void)
> >               if (start <=3D __pa(PAGE_OFFSET) &&
> >                   __pa(PAGE_OFFSET) < end)
> >                       start =3D __pa(PAGE_OFFSET);
> > -             if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
> > -                     end =3D __pa(PAGE_OFFSET) + memory_limit;
> >
> >               create_linear_mapping_range(start, end, 0);
> >       }

