Return-Path: <linux-kernel+bounces-394183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F59BAB8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D451FB207E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4609166315;
	Mon,  4 Nov 2024 03:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Fwfphuvm"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1026FC5
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730691843; cv=none; b=l2NLccgisJG7F3Myw/QZvir93nRHBFX1Yfd3FlDr1uUElQMMg4nImEymDyIdnglxnKeo9PiSguJLX/wCv8d7v71+bXjAfvbn41meuSEbrgjFB5NErBY8sMZLViL6w6N57KVaXRIdzpXnGhb0RKUuj1HFXqDl8p0ikmKNWghax7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730691843; c=relaxed/simple;
	bh=9afnJS2KFZr4sbmLW5RL86v/mIjAMzUoYwzkYt0C4SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwAyyMsaLpqpPWmMRfnWVcb7LK6y7mXZ2g6Kbp0hhel+1IdpP0f5KxYulx4Ss0wSeQ4tUz0/+LYqH+ChSSv69sFkLRKwQd5dQdR1ml5V136Gqels8ktuZYbUgqGlrs6qEIZEqhBmPMH4JMdIaUZNe4SkR2AcX3Yztn5JaJf3RDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Fwfphuvm; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5daa93677e1so1905220eaf.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 19:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730691840; x=1731296640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4fakRh8sye3jPEox0UlPU/qvi+CwkqRNh/HcEuMyoc=;
        b=FwfphuvmMx3oQeiN4STiGHDopkahffolzbQ7ZOPPhylmxDBIVkckp3EQOG7fI6l8em
         IWZ/VRsnPB82X7Eiv6juFnDJ3bsX5Xoog4QOFZwzMW1IxQ7HsKxkqpt311T0ouchl2Jd
         +hTnUUIOFk//nMWC2kozMCk7/LkkBRoIokRsMEmLNgQMw9yNjjnWj3EStJm3Huyb6DFE
         E9PGxYWIVXtQJGUy30EliIpmH+bIyuQeMVWTdRTx4kIaBF6LI7Rib5bUzm+UWuZT6IAt
         LZoutVAEgAlYm7W39teOx+pSaUPaKs/HPXdU4hXUeMjULQ2XBX2JwagjvZYY1LY4ue87
         B7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730691840; x=1731296640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i4fakRh8sye3jPEox0UlPU/qvi+CwkqRNh/HcEuMyoc=;
        b=jX6oYyWX1LFs2S0+9Kl6fx68sJclh+EY7omGXFYPA96RrNVBSetqZYlNz/jcDIouAM
         vAx8+tjm8lK7EOG7Liaa5ktgMKG+ZmAFVZ+1vB4Q9ueg/07QgzyOLnGVYtB/ClcyjVKn
         e25smzxv7obOb3CZcOXjrF9J1CaMMp5ymVIo6JTzTJ9QLrWtwOzD/ZLXqyezWeV1N2+9
         Y9GDX3xFi4xXDZyxOHiALwoXKT+5bFd8WOURgtYY+a1ehTH5oelUF2tsUWczn1EL2cXt
         urcxjDYpVERfY3rY4X+XJ+09oqmmPGqLnY5762OYMP2Zq7wnEkmZuzWjdE/oKl9mZeUY
         Fw6A==
X-Forwarded-Encrypted: i=1; AJvYcCXwsg6IgTnUKgsCsr0rhN70tQL+9YuIDdIdrltWbgAjAmlQvQLwnJWXYofwuNyRffQssJVaEzjy6TTv6ng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yE9LCWyVt/wtcIA2bRrupEeVhtywBVw5j8cNDAxrBAF8wTz9
	RC4M+iVsjLY8Lnb9k51v/xOHMmaFd3tdg3klqynIQbP/MsVKkqRZ7VyTuSMm7rkA5/UudKSnGtt
	WGGUFgXLmqIR9P0sm+p0lyU+vwnwOlAVTmdr7RQ==
X-Google-Smtp-Source: AGHT+IHowkm8L0BkrzUoIWvagpjJDW4Ncnx46v2FYMoNot193/y7DqBbyROpepcuBrQbrXR+mtmlJN0Iz7kR9DOqDoE=
X-Received: by 2002:a05:6820:310b:b0:5ed:f849:51dd with SMTP id
 006d021491bc7-5edf8495895mr4072347eaf.8.1730691839815; Sun, 03 Nov 2024
 19:43:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
 <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr> <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
 <c05e09d0-d996-4712-a6e5-ef77f1f2ff0a@ghiti.fr> <CAEEQ3wmw8B_cOs54H4Z8e2QTGyeE2cAYQwDRyk7KgUUKTFhZ-g@mail.gmail.com>
 <CAHVXubjDhM6NEF6uf981Y2fNA1Dw=Bu_SNtpso6P1=3Np6BUDw@mail.gmail.com>
 <CAEEQ3wndPwdaNrJZaqqrbyMBeWTVnV3m8KEehdijtTfXWjuYsw@mail.gmail.com> <ZyBfvfvyry6Wb89H@sunil-laptop>
In-Reply-To: <ZyBfvfvyry6Wb89H@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 4 Nov 2024 11:43:48 +0800
Message-ID: <CAEEQ3wkwUx1ySYRXZZP3vO2r5+1zd1PqFrUidkU11tnnzR+MnQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>, punit.agrawal@bytedance.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	ajones@ventanamicro.com, jeeheng.sia@starfivetech.com, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil, Alex

On Tue, Oct 29, 2024 at 12:08=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> On Tue, Oct 29, 2024 at 11:04:49AM +0800, yunhui cui wrote:
> > Hi Alex,
> >
> >
> > On Mon, Oct 28, 2024 at 9:37=E2=80=AFPM Alexandre Ghiti <alexghiti@rivo=
sinc.com> wrote:
> > >
> > > Hi Yunhui,
> > >
> > > Sorry for the late reply, I was on vacation last week.
> > >
> > > On Mon, Oct 21, 2024 at 8:45=E2=80=AFAM yunhui cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > Hi Alex,
> > > >
> > > > On Mon, Oct 14, 2024 at 9:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti=
.fr> wrote:
> > > > >
> > > > > On 14/10/2024 14:30, yunhui cui wrote:
> > > > > > Hi Alex,
> > > > > >
> > > > > > On Mon, Oct 14, 2024 at 8:12=E2=80=AFPM Alexandre Ghiti <alex@g=
hiti.fr> wrote:
> > > > > >> Hi Yunhui,
> > > > > >>
> > > > > >> On 14/10/2024 11:47, Yunhui Cui wrote:
> > > > > >>> When SVPBMT is enabled, __acpi_map_table() will directly acce=
ss the
> > > > > >>> data in DDR through the IO attribute, rather than through har=
dware
> > > > > >>> cache consistency, resulting in incorrect data in the obtaine=
d ACPI
> > > > > >>> table.
> > > > > >>>
> > > > > >>> The log: ACPI: [ACPI:0x18] Invalid zero length.
> > > > > >>>
> > > > > >>> We do not assume whether the bootloader flushes or not. We sh=
ould
> > > > > >>> access in a cacheable way instead of maintaining cache consis=
tency
> > > > > >>> by software.
> > > > > >>>
> > > > > >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > > >>> ---
> > > > > >>>    arch/riscv/kernel/acpi.c | 2 +-
> > > > > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >>>
> > > > > >>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acp=
i.c
> > > > > >>> index 6e0d333f57e5..3177c9af8764 100644
> > > > > >>> --- a/arch/riscv/kernel/acpi.c
> > > > > >>> +++ b/arch/riscv/kernel/acpi.c
> > > > > >>> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(uns=
igned long phys, unsigned long size)
> > > > > >>>        if (!size)
> > > > > >>>                return NULL;
> > > > > >>>
> > > > > >>> -     return early_ioremap(phys, size);
> > > > > >>> +     return early_memremap(phys, size);
> > > > > >>>    }
> > > > > >>>
> > > > > >>>    void __init __acpi_unmap_table(void __iomem *map, unsigned=
 long size)
> > > > > >>
> > > > > >> It makes sense to me since with this, we don't have to care ab=
out how
> > > > > >> the firmware mapped the table. And it mimics all other archite=
ctures
> > > > > >> (arm64, loongarch and x86).
> > > > > >>
> > > > > >> Here is the corresponding fixes tag:
> > > > > >>
> > > > > >> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers=
 in
> > > > > >> different address space")
> > > > > >>
> > > > > >> With the corresponding fix in __acpi_unmap_table() as pointed =
by Sunil,
> > > > > >> you can add:
> > > > > >>
> > > > > >> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > > > >>
> > > > > >> And regarding the sparse error, I don't see any other architec=
ture
> > > > > >> casting to __iomem, so maybe that's not necessary anymore?
> > > > > > OK. I will make the changes in v2. Regarding the sparse error, =
I will
> > > > > > use another patch specifically to solve it. Is that okay?
> > > > >
> > > > >
> > > > > If the second patch only consists in casting, I would not use ano=
ther
> > > > > patch since the patch 2 would fix something introduced in patch 1=
.
> > > > >
> > > > > But if patch 2 is more complicated,  it may make sense to do as y=
ou
> > > > > suggest, the goal is to merge patch 1 asap.
> > > >
> > > > Regarding patch 2, I executed "make & make install" for sparse of t=
he
> > > > riscv arch. I "git cloned" from
> > > > https://github.com/ConchuOD/sparse.git.
> > > > Then when compiling the kernel, the following error was reported:
> > > >
> > > > cd /data00/cyh/linux-next/
> > > > make defconfig
> > > > cp .config build-riscv64/
> > > >
> > > > make O=3Dbuild-riscv64/ C=3D1 W=3D1 arch/riscv/kernel/ drivers/acpi=
/
> > > > drivers/mailbox/ -j
> > > > make[1]: Entering directory '/data00/cyh/linux-next/build-riscv64'
> > > >   GEN     Makefile
> > > >   CC      scripts/mod/empty.o
> > > >   CC      scripts/mod/devicetable-offsets.s
> > > >   CHECK   ../scripts/mod/empty.c
> > > > invalid argument to '-march': '_zicsr_zifencei'
> > > >
> > > > make[3]: *** [../scripts/Makefile.build:229: scripts/mod/empty.o] E=
rror 1
> > > > make[3]: *** Deleting file 'scripts/mod/empty.o'
> > > > make[3]: *** Waiting for unfinished jobs....
> > > > make[2]: *** [/data00/cyh/linux-next/Makefile:1215: prepare0] Error=
 2
> > > > make[1]: *** [/data00/cyh/linux-next/Makefile:224: __sub-make] Erro=
r 2
> > > >
> > > > Do you know the solution?
> > >
> > > In case you did not find the solution yet, I would say that your
> > > toolchain is too old.
> > >
> > > Let me know if I can help,
> > It may not be a problem of an old compiler. The version of the
> > compiler I am using is 13.2.
> > It is a problem with sparse. When running "sparse --arch=3Driscv
> > -march=3Drv64imac_zicsr_zifencei scripts/mod/empty.c", there is an
> > invalid argument for '-march': '_zicsr_zifencei'.
> >
> Hi Yunhui,
>
> I think you need latest sparse. I remember building sparse from latest
> sources to avoid this error.
>
> https://www.kernel.org/doc/html/v4.11/dev-tools/sparse.html
>
> Thanks,
> Sunil

Thank you for your suggestions on sparse. The patch has been sent to
the community. Please refer to:
https://lore.kernel.org/linux-arm-kernel/20241031112030.72647-1-cuiyunhui@b=
ytedance.com/T/.


Thanks,
Yunhui

