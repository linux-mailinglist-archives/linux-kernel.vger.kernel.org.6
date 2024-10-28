Return-Path: <linux-kernel+bounces-385055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D729B31D1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1547E1C21AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 13:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6281DBB19;
	Mon, 28 Oct 2024 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SgdcUdAb"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948EC1DA636
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730122657; cv=none; b=RmjO1+G4YOsUI1DAtdvYIBIk4ezp3YwvX1vAu8xoWRrxFfrhFFmKTxVrG1XcSqq0KBxnUoIpQxKOHJSpGixVVlVzM462atOBKsA5+70l6G5MzrvK1B7D2EJ4lUe+XhUg/UVsp21TSnPRDUMPXCyECpoIFq0jpWabgPh8OIlKzrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730122657; c=relaxed/simple;
	bh=vVx6XMiYb8HLq1y+1ShTB5CrlpQoAxw0tuJt9+Ueq4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPKYpZPx47RB8i3OlndfrDVCdcFLDMwtqUlHcs7tpfffijtpXf8aPhN+KEX5iRIsZWB8spZBdWoZE8PwDWNEVsvpWHV1bDbJMdC3o1GTyNaDb+kyWI0ytWHWMXenotCJG3qQ3WsiluCwiMQC8B5hrJpWho0sFrHBmr8oZT4RooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SgdcUdAb; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99cc265e0aso668149666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730122653; x=1730727453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKnGNMIDsuMU9Ms+olL4fIosxiXCEslH59WZ857jYhs=;
        b=SgdcUdAbPiJzS+aVVOTUpEtlyIRtU6kdudkZH1oSqG+8GPLZSqY3q4brIDuGQgCFYd
         gXRja3Hea7jFapcFk5tUV2SCmwpZWiH5FHUYZOST33Nvyl0Al921ibOGi7n4jGiFhOw1
         Z3Kwz7oYybhMEN3yVDh1sm0C3Tsuu1yaIYh7KWwE96NClWQOKW9Ap7FbadptE4FXEtoK
         pPt+kietQSqVSgLuRyEBhtZR0gLdxRC0B1DHKDH1piKokokrMwF+KPJ5oGo+K57W+com
         fkDZdTHLIXtXxOjanNyPmrAWlxpZT/LJ+Lw+P4CJHA0Um6lRQ+o7Qr6m3bH6W+66Z3cx
         4xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730122653; x=1730727453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKnGNMIDsuMU9Ms+olL4fIosxiXCEslH59WZ857jYhs=;
        b=uek0FrE/FPnA5/596ZwPx3HzcaYDzHkwXNKMWKoIUd3ZyRQiSZ+n2E/OUp863/jA+G
         FCEaDSUBgVE1SN5MAMkNihFSd1ceSlfEXw+12NVePXgleYg/yLeAxlcnojkMMXCFNeCD
         j+7bmDCu9d8lVj7BNc2uuYrvl1gUN+6hzn/gRQA3ahCXKmne2WoDb7SkqRIp2qpBJB1E
         H1CfRK2b5DnHRbrbT0Px4atbrwkor7UjL9cBbOYpda1lBgOwpwmDYWrmEHIVZRv0g/3u
         NDMX2ixYn2NhCR08cL/VbOziU+A/gBMANBDL6UwfB0NKubKQT6czQa1VRsyw0FfmXLfg
         2UIw==
X-Forwarded-Encrypted: i=1; AJvYcCVFn+u0mX8u7EIZ1PeaNyjceFT+BCnJ3Ro2csSr0MKMmkiFGSut6/lBCY2Y9QQDtUVReF3UxKwXqDkcj1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyusNST+pYBpI5C4zBUrTX8THZAi/t/DUgtbheE2ld/UeoyvYo
	2dTcLOOjisJVVs3uy5zuTGn6YSPzeS/mqNyuRT0nUsJ0HL4zgjCGI7CDl02MW+DGxu9ys2dQajO
	hWvGXML1LbJLzVTwBqq7VF1M4YabVX9JDDRKAYA==
X-Google-Smtp-Source: AGHT+IHhEyOkOcA9tpqWTp6QFCG6rAyKXtMOIkse/RvH7hBaOyRskSxnafS6xuPyA1ddYLA/p40Sx9Z0PiDa68pUkcI=
X-Received: by 2002:a17:907:8688:b0:a9a:3013:2ea1 with SMTP id
 a640c23a62f3a-a9de5d6fa2amr800203066b.1.1730122652741; Mon, 28 Oct 2024
 06:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
 <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr> <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
 <c05e09d0-d996-4712-a6e5-ef77f1f2ff0a@ghiti.fr> <CAEEQ3wmw8B_cOs54H4Z8e2QTGyeE2cAYQwDRyk7KgUUKTFhZ-g@mail.gmail.com>
In-Reply-To: <CAEEQ3wmw8B_cOs54H4Z8e2QTGyeE2cAYQwDRyk7KgUUKTFhZ-g@mail.gmail.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Mon, 28 Oct 2024 14:37:21 +0100
Message-ID: <CAHVXubjDhM6NEF6uf981Y2fNA1Dw=Bu_SNtpso6P1=3Np6BUDw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, sunilvl@ventanamicro.com, 
	ajones@ventanamicro.com, jeeheng.sia@starfivetech.com, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yunhui,

Sorry for the late reply, I was on vacation last week.

On Mon, Oct 21, 2024 at 8:45=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.com=
> wrote:
>
> Hi Alex,
>
> On Mon, Oct 14, 2024 at 9:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> w=
rote:
> >
> > On 14/10/2024 14:30, yunhui cui wrote:
> > > Hi Alex,
> > >
> > > On Mon, Oct 14, 2024 at 8:12=E2=80=AFPM Alexandre Ghiti <alex@ghiti.f=
r> wrote:
> > >> Hi Yunhui,
> > >>
> > >> On 14/10/2024 11:47, Yunhui Cui wrote:
> > >>> When SVPBMT is enabled, __acpi_map_table() will directly access the
> > >>> data in DDR through the IO attribute, rather than through hardware
> > >>> cache consistency, resulting in incorrect data in the obtained ACPI
> > >>> table.
> > >>>
> > >>> The log: ACPI: [ACPI:0x18] Invalid zero length.
> > >>>
> > >>> We do not assume whether the bootloader flushes or not. We should
> > >>> access in a cacheable way instead of maintaining cache consistency
> > >>> by software.
> > >>>
> > >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > >>> ---
> > >>>    arch/riscv/kernel/acpi.c | 2 +-
> > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > >>> index 6e0d333f57e5..3177c9af8764 100644
> > >>> --- a/arch/riscv/kernel/acpi.c
> > >>> +++ b/arch/riscv/kernel/acpi.c
> > >>> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned =
long phys, unsigned long size)
> > >>>        if (!size)
> > >>>                return NULL;
> > >>>
> > >>> -     return early_ioremap(phys, size);
> > >>> +     return early_memremap(phys, size);
> > >>>    }
> > >>>
> > >>>    void __init __acpi_unmap_table(void __iomem *map, unsigned long =
size)
> > >>
> > >> It makes sense to me since with this, we don't have to care about ho=
w
> > >> the firmware mapped the table. And it mimics all other architectures
> > >> (arm64, loongarch and x86).
> > >>
> > >> Here is the corresponding fixes tag:
> > >>
> > >> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in
> > >> different address space")
> > >>
> > >> With the corresponding fix in __acpi_unmap_table() as pointed by Sun=
il,
> > >> you can add:
> > >>
> > >> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > >>
> > >> And regarding the sparse error, I don't see any other architecture
> > >> casting to __iomem, so maybe that's not necessary anymore?
> > > OK. I will make the changes in v2. Regarding the sparse error, I will
> > > use another patch specifically to solve it. Is that okay?
> >
> >
> > If the second patch only consists in casting, I would not use another
> > patch since the patch 2 would fix something introduced in patch 1.
> >
> > But if patch 2 is more complicated,  it may make sense to do as you
> > suggest, the goal is to merge patch 1 asap.
>
> Regarding patch 2, I executed "make & make install" for sparse of the
> riscv arch. I "git cloned" from
> https://github.com/ConchuOD/sparse.git.
> Then when compiling the kernel, the following error was reported:
>
> cd /data00/cyh/linux-next/
> make defconfig
> cp .config build-riscv64/
>
> make O=3Dbuild-riscv64/ C=3D1 W=3D1 arch/riscv/kernel/ drivers/acpi/
> drivers/mailbox/ -j
> make[1]: Entering directory '/data00/cyh/linux-next/build-riscv64'
>   GEN     Makefile
>   CC      scripts/mod/empty.o
>   CC      scripts/mod/devicetable-offsets.s
>   CHECK   ../scripts/mod/empty.c
> invalid argument to '-march': '_zicsr_zifencei'
>
> make[3]: *** [../scripts/Makefile.build:229: scripts/mod/empty.o] Error 1
> make[3]: *** Deleting file 'scripts/mod/empty.o'
> make[3]: *** Waiting for unfinished jobs....
> make[2]: *** [/data00/cyh/linux-next/Makefile:1215: prepare0] Error 2
> make[1]: *** [/data00/cyh/linux-next/Makefile:224: __sub-make] Error 2
>
> Do you know the solution?

In case you did not find the solution yet, I would say that your
toolchain is too old.

Let me know if I can help,

Thanks,

Alex

>
> >
> > Thanks!
> >
> > Alex
> >
> >
> > >
> > >> Thanks,
> > >>
> > >> Alex
> > >>
> > >>
> > > Thanks,
> > > Yunhui
>
> Thanks,
> Yunhui

