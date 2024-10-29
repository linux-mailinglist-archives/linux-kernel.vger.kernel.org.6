Return-Path: <linux-kernel+bounces-386282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D39B417D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 05:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19101F22DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C861FF7C2;
	Tue, 29 Oct 2024 04:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Cw7CQCaa"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF65AFC0B
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730174925; cv=none; b=SCQnFdQfmxIK9e01h1/a4+DC/Xou3DUEaDEBOu3kjmiAPa4Fo5G/hEIdsrFD3JHtwHAmEwXXLKYKCu/jX+kKTzIp7gg/OHotI62H969iJ8lT7t4lO1SxXtP4BG268ueJqkiFTycHjchs0a02D7rc7OpkIOJRguUKHP9w4rNU/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730174925; c=relaxed/simple;
	bh=jiXBEhpofDzY1TxqpvsXY47FcaDhFB81dY6MrocbiDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RoQom7EzFceR4VtVfShcXNor5owYTpQuuFFd4/gCerVi3O6+8ucuCkNmdw4eWHTESe0cYMmbexPkWR34Xz4fRgA9Bwe0B8iYed/IZoFboJXvGtCudGAIx9O8wpi2GBe0ZgrmYBYz9ewKq8uYEcL2f2Y4QPN5lirLwcGtJ9J2Kps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Cw7CQCaa; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c97c7852e8so7109576a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 21:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1730174921; x=1730779721; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gIIEo7y7oCt4veQqo+0XfxoZ69cq65MS/cK+YlFnMn0=;
        b=Cw7CQCaa8oGiwWQpHhoUDI1PDQXEzXCUn+liHU1RfsPtiK9QbDEvzMLvGu4BZ17GNP
         119z2zle6VgBUxYUxbnfxCKroaZbY5SReO1EN0mmUtWj5uAbTkgnNLvrUsFI3P49Apnl
         mB9p3XiruKeHyOy1B3CqKqvyRPXyq6i/2Ymm1W5Va/LtGG2wKg0B59mKR3UhnUWQXPNC
         yzdRnWZ7TT6I2nkiWMvoVWLGaVrD6+98DFKv4Zoeo5lUyZ9RJCkVBI1WcLjKvgqlESr7
         tgy1gi4U+hfi0+0dJXx4v5uOQNprfJSIdEqG95gOM7Vi0BeOgsr9h0rGns26+bXFUDEV
         1S/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730174921; x=1730779721;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIIEo7y7oCt4veQqo+0XfxoZ69cq65MS/cK+YlFnMn0=;
        b=W9tWoBGmcVMMtdhThee5oDx5q/RQme/9AMaTqFXHP8cie7p9ccdipRfCvPkDq0E+nT
         /H4Z2QYFFQmiCCngJfJ+t2Ate2m6uGBR4EAmJKwZ5R3VAuY5PJYN8wcJOqT2lkU/IpDV
         zI/WvUbuMpzBKsTlIs+iF+f3L+t7HoqAa+ccC8++2DknQH9xQoaRzAT7sBTn5GT3j23k
         ehVg+pQ5wZXqSZTe6CYlpP7tmeph4NSWnb+97btlAkoBF2vkMQQDzfXqeQ+Is2wpl2pE
         9hh7gcuPvIJFN/m7NBOpkl7BGBgr0v5B5R93wHxmUzWkkjXrt4jAXwjVEX/MakHbqV8F
         SIEA==
X-Forwarded-Encrypted: i=1; AJvYcCWa2ZIrN7rAjLkKvI5vZQJdZyVm6nYizJwvMzdAaUQUHtGNa3/J2LIX7su0/f7/h2zbYYn/hx11KTX6yb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5N2dD/BbvWyWHDd/m3Q5rTQbiNPzlELoOincKwbUGGoPjffIq
	iiAcYZsFbsr9kV/3AiqChftkG3+DEDyw64+56ytdJLm4OfKPD6TBgZEemAwdExQ=
X-Google-Smtp-Source: AGHT+IFl3f8KVc1QRaQ2b6/c/hH/WJWqrVw7vV+N8eWlNKsh/eF1g5HhOvtGRdGadtFj+TtWOqb8Gg==
X-Received: by 2002:a17:907:9712:b0:a9a:55de:11f4 with SMTP id a640c23a62f3a-a9de6191f51mr1030052066b.54.1730174920767;
        Mon, 28 Oct 2024 21:08:40 -0700 (PDT)
Received: from sunil-laptop ([106.51.196.223])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62580b1sm3573211a12.15.2024.10.28.21.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 21:08:39 -0700 (PDT)
Date: Tue, 29 Oct 2024 09:38:29 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Alexandre Ghiti <alex@ghiti.fr>, punit.agrawal@bytedance.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	ajones@ventanamicro.com, jeeheng.sia@starfivetech.com,
	haibo1.xu@intel.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to
 early_memremap
Message-ID: <ZyBfvfvyry6Wb89H@sunil-laptop>
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
 <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr>
 <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
 <c05e09d0-d996-4712-a6e5-ef77f1f2ff0a@ghiti.fr>
 <CAEEQ3wmw8B_cOs54H4Z8e2QTGyeE2cAYQwDRyk7KgUUKTFhZ-g@mail.gmail.com>
 <CAHVXubjDhM6NEF6uf981Y2fNA1Dw=Bu_SNtpso6P1=3Np6BUDw@mail.gmail.com>
 <CAEEQ3wndPwdaNrJZaqqrbyMBeWTVnV3m8KEehdijtTfXWjuYsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wndPwdaNrJZaqqrbyMBeWTVnV3m8KEehdijtTfXWjuYsw@mail.gmail.com>

On Tue, Oct 29, 2024 at 11:04:49AM +0800, yunhui cui wrote:
> Hi Alex,
> 
> 
> On Mon, Oct 28, 2024 at 9:37 PM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
> >
> > Hi Yunhui,
> >
> > Sorry for the late reply, I was on vacation last week.
> >
> > On Mon, Oct 21, 2024 at 8:45 AM yunhui cui <cuiyunhui@bytedance.com> wrote:
> > >
> > > Hi Alex,
> > >
> > > On Mon, Oct 14, 2024 at 9:01 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > > >
> > > > On 14/10/2024 14:30, yunhui cui wrote:
> > > > > Hi Alex,
> > > > >
> > > > > On Mon, Oct 14, 2024 at 8:12 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > > > >> Hi Yunhui,
> > > > >>
> > > > >> On 14/10/2024 11:47, Yunhui Cui wrote:
> > > > >>> When SVPBMT is enabled, __acpi_map_table() will directly access the
> > > > >>> data in DDR through the IO attribute, rather than through hardware
> > > > >>> cache consistency, resulting in incorrect data in the obtained ACPI
> > > > >>> table.
> > > > >>>
> > > > >>> The log: ACPI: [ACPI:0x18] Invalid zero length.
> > > > >>>
> > > > >>> We do not assume whether the bootloader flushes or not. We should
> > > > >>> access in a cacheable way instead of maintaining cache consistency
> > > > >>> by software.
> > > > >>>
> > > > >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > >>> ---
> > > > >>>    arch/riscv/kernel/acpi.c | 2 +-
> > > > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >>>
> > > > >>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > > >>> index 6e0d333f57e5..3177c9af8764 100644
> > > > >>> --- a/arch/riscv/kernel/acpi.c
> > > > >>> +++ b/arch/riscv/kernel/acpi.c
> > > > >>> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
> > > > >>>        if (!size)
> > > > >>>                return NULL;
> > > > >>>
> > > > >>> -     return early_ioremap(phys, size);
> > > > >>> +     return early_memremap(phys, size);
> > > > >>>    }
> > > > >>>
> > > > >>>    void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
> > > > >>
> > > > >> It makes sense to me since with this, we don't have to care about how
> > > > >> the firmware mapped the table. And it mimics all other architectures
> > > > >> (arm64, loongarch and x86).
> > > > >>
> > > > >> Here is the corresponding fixes tag:
> > > > >>
> > > > >> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in
> > > > >> different address space")
> > > > >>
> > > > >> With the corresponding fix in __acpi_unmap_table() as pointed by Sunil,
> > > > >> you can add:
> > > > >>
> > > > >> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > >>
> > > > >> And regarding the sparse error, I don't see any other architecture
> > > > >> casting to __iomem, so maybe that's not necessary anymore?
> > > > > OK. I will make the changes in v2. Regarding the sparse error, I will
> > > > > use another patch specifically to solve it. Is that okay?
> > > >
> > > >
> > > > If the second patch only consists in casting, I would not use another
> > > > patch since the patch 2 would fix something introduced in patch 1.
> > > >
> > > > But if patch 2 is more complicated,  it may make sense to do as you
> > > > suggest, the goal is to merge patch 1 asap.
> > >
> > > Regarding patch 2, I executed "make & make install" for sparse of the
> > > riscv arch. I "git cloned" from
> > > https://github.com/ConchuOD/sparse.git.
> > > Then when compiling the kernel, the following error was reported:
> > >
> > > cd /data00/cyh/linux-next/
> > > make defconfig
> > > cp .config build-riscv64/
> > >
> > > make O=build-riscv64/ C=1 W=1 arch/riscv/kernel/ drivers/acpi/
> > > drivers/mailbox/ -j
> > > make[1]: Entering directory '/data00/cyh/linux-next/build-riscv64'
> > >   GEN     Makefile
> > >   CC      scripts/mod/empty.o
> > >   CC      scripts/mod/devicetable-offsets.s
> > >   CHECK   ../scripts/mod/empty.c
> > > invalid argument to '-march': '_zicsr_zifencei'
> > >
> > > make[3]: *** [../scripts/Makefile.build:229: scripts/mod/empty.o] Error 1
> > > make[3]: *** Deleting file 'scripts/mod/empty.o'
> > > make[3]: *** Waiting for unfinished jobs....
> > > make[2]: *** [/data00/cyh/linux-next/Makefile:1215: prepare0] Error 2
> > > make[1]: *** [/data00/cyh/linux-next/Makefile:224: __sub-make] Error 2
> > >
> > > Do you know the solution?
> >
> > In case you did not find the solution yet, I would say that your
> > toolchain is too old.
> >
> > Let me know if I can help,
> It may not be a problem of an old compiler. The version of the
> compiler I am using is 13.2.
> It is a problem with sparse. When running "sparse --arch=riscv
> -march=rv64imac_zicsr_zifencei scripts/mod/empty.c", there is an
> invalid argument for '-march': '_zicsr_zifencei'.
> 
Hi Yunhui,

I think you need latest sparse. I remember building sparse from latest
sources to avoid this error.

https://www.kernel.org/doc/html/v4.11/dev-tools/sparse.html

Thanks,
Sunil

