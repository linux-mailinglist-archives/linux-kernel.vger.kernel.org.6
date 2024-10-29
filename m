Return-Path: <linux-kernel+bounces-386230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490299B40BC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 04:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4800B1C21F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 03:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882101F429A;
	Tue, 29 Oct 2024 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UTY/g8Gr"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09BC2B9A8
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171104; cv=none; b=N8PjcImmU2jyb8Gw7144H2JBCOkjEql2nTgG1/SLZH7M+Ln7CiYbQJPXc641a0wHcKhx4GOv0zIJ3CyzSUw+HftZNEjD8yFV3vaRCuTGgmqUoCXTfOkUgYEP2lb0Vt7+4D1Gih8LCV3zgvoUr+2PjCAvH14yQc9KmFcq+5NiXPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171104; c=relaxed/simple;
	bh=fH/88ZvyiR1jphSwX3iJgOsnQ8FDAdrYNtzPIADpeZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOqRBZJBjEJJNcLkwwS803ncL0VG8AAUzzTUYZ4WBZ87ndi+CnUEYD/jmWoCXsvTccaXBbSVmv1GUhtLURE1h5ucUkuZviaHz3BWi9V6dl1uP2MOfOdqvHWuuuwBEnXkfIQ/uTv8+3UuOD584IbjcRLieqwUW+sPfwQj98W66iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UTY/g8Gr; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5eb67d926c4so2225782eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730171100; x=1730775900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A2tft79wpE62sdOkLmNApc2SIWGv4sutFtEvIY/+Wg=;
        b=UTY/g8Gr7lit0dr8kxdfHfGN0Oj0WsuPtPZedyBhTKYuUrfyskHb2Pdj/A0JhkKZUs
         A6a4zPxblNDmSSABu/R12UJXjiHbq/s+/1DcTVn00k8BOJ6/wx6PbYtawz/8NDPxa7bj
         nfTvl0vedqGy0nN2Dn7TLkJqrbD+wcPwpAs2pBYUfXSE8Wdu9+OrIEvIEqGa3hzvJi3s
         BlH4Ppk0Th0Ck+ap8sW0vLOKM0tIaxcnG34yEyaYI7XvdtspoJ3bWZypRNmYpX8Xg1Zy
         vR39tnafNRglPEQM+rOcIayYRPPgOPa3TRqrg2B4e8cXDjtNC5wKyJJYkej7TppWREzD
         mMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730171100; x=1730775900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A2tft79wpE62sdOkLmNApc2SIWGv4sutFtEvIY/+Wg=;
        b=BmaeK3JG5PDWjuAcAhfVt34vFRCRvH+Q/xcf3uDuuPMJZvR3XBxqOpIdvWOIGEfAFk
         quOd7GOdcCAVPAK8cBGeIydBb4tbmuMSWbPNkU7etaSg1s9Ew5Knph4QVy4eLNqgHOBn
         8IWXSNa08MEYlPEtdElgFssihhH5ezKmV51IAOLiG2nVPmuaJ8v8pJvG8f9UtKxLfVkL
         aQ9gOX/Ws5NTrfppDJdz/IEfoB5xiJQhEZMBXpg1Fl9aG/VBuZo5/AJwxCQegmrm/aNE
         E0AycwfyHONQf249lbpQHNDlvXL+dgbc+vXG0VsHi/a0nSUkwqUJWBwkmXHhNY1KqX4A
         TOhA==
X-Forwarded-Encrypted: i=1; AJvYcCV7pgCxZPe6Ypc38aqrHgBELi/6+nMnPOBQ+GgBMv+Ir3vwDGkKjgUtVnGGFESMldHKGGDfHosoK+MYdyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFDtl20O6vaICbk6uopnZ00jinLwiHUSJIsIWnKbBKKdNkWtS
	gCvv6JH56gLIwLDEq+ff6Ju2pxzFW3qPMes0DzGpIx5RwzVf6s28FVoQLwNh0DaYrkt4tbrzrOd
	kvOYKTThlap0lFSBHJh6XgZ9Z+RPQTM2wPRWObg==
X-Google-Smtp-Source: AGHT+IErtbcsrymXWEaip1yynRYw6vCJBZzHwiX3vSDoI8pgRYDYd6qMS5wZKThDnvKbL0LQFF9TpCf52Zss7vNzT6A=
X-Received: by 2002:a4a:db48:0:b0:5eb:5396:7896 with SMTP id
 006d021491bc7-5ec54ad7388mr399745eaf.4.1730171100497; Mon, 28 Oct 2024
 20:05:00 -0700 (PDT)
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
In-Reply-To: <CAHVXubjDhM6NEF6uf981Y2fNA1Dw=Bu_SNtpso6P1=3Np6BUDw@mail.gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 29 Oct 2024 11:04:49 +0800
Message-ID: <CAEEQ3wndPwdaNrJZaqqrbyMBeWTVnV3m8KEehdijtTfXWjuYsw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, punit.agrawal@bytedance.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, sunilvl@ventanamicro.com, 
	ajones@ventanamicro.com, jeeheng.sia@starfivetech.com, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,


On Mon, Oct 28, 2024 at 9:37=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> Hi Yunhui,
>
> Sorry for the late reply, I was on vacation last week.
>
> On Mon, Oct 21, 2024 at 8:45=E2=80=AFAM yunhui cui <cuiyunhui@bytedance.c=
om> wrote:
> >
> > Hi Alex,
> >
> > On Mon, Oct 14, 2024 at 9:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> > >
> > > On 14/10/2024 14:30, yunhui cui wrote:
> > > > Hi Alex,
> > > >
> > > > On Mon, Oct 14, 2024 at 8:12=E2=80=AFPM Alexandre Ghiti <alex@ghiti=
.fr> wrote:
> > > >> Hi Yunhui,
> > > >>
> > > >> On 14/10/2024 11:47, Yunhui Cui wrote:
> > > >>> When SVPBMT is enabled, __acpi_map_table() will directly access t=
he
> > > >>> data in DDR through the IO attribute, rather than through hardwar=
e
> > > >>> cache consistency, resulting in incorrect data in the obtained AC=
PI
> > > >>> table.
> > > >>>
> > > >>> The log: ACPI: [ACPI:0x18] Invalid zero length.
> > > >>>
> > > >>> We do not assume whether the bootloader flushes or not. We should
> > > >>> access in a cacheable way instead of maintaining cache consistenc=
y
> > > >>> by software.
> > > >>>
> > > >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > >>> ---
> > > >>>    arch/riscv/kernel/acpi.c | 2 +-
> > > >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>>
> > > >>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > > >>> index 6e0d333f57e5..3177c9af8764 100644
> > > >>> --- a/arch/riscv/kernel/acpi.c
> > > >>> +++ b/arch/riscv/kernel/acpi.c
> > > >>> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigne=
d long phys, unsigned long size)
> > > >>>        if (!size)
> > > >>>                return NULL;
> > > >>>
> > > >>> -     return early_ioremap(phys, size);
> > > >>> +     return early_memremap(phys, size);
> > > >>>    }
> > > >>>
> > > >>>    void __init __acpi_unmap_table(void __iomem *map, unsigned lon=
g size)
> > > >>
> > > >> It makes sense to me since with this, we don't have to care about =
how
> > > >> the firmware mapped the table. And it mimics all other architectur=
es
> > > >> (arm64, loongarch and x86).
> > > >>
> > > >> Here is the corresponding fixes tag:
> > > >>
> > > >> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in
> > > >> different address space")
> > > >>
> > > >> With the corresponding fix in __acpi_unmap_table() as pointed by S=
unil,
> > > >> you can add:
> > > >>
> > > >> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > > >>
> > > >> And regarding the sparse error, I don't see any other architecture
> > > >> casting to __iomem, so maybe that's not necessary anymore?
> > > > OK. I will make the changes in v2. Regarding the sparse error, I wi=
ll
> > > > use another patch specifically to solve it. Is that okay?
> > >
> > >
> > > If the second patch only consists in casting, I would not use another
> > > patch since the patch 2 would fix something introduced in patch 1.
> > >
> > > But if patch 2 is more complicated,  it may make sense to do as you
> > > suggest, the goal is to merge patch 1 asap.
> >
> > Regarding patch 2, I executed "make & make install" for sparse of the
> > riscv arch. I "git cloned" from
> > https://github.com/ConchuOD/sparse.git.
> > Then when compiling the kernel, the following error was reported:
> >
> > cd /data00/cyh/linux-next/
> > make defconfig
> > cp .config build-riscv64/
> >
> > make O=3Dbuild-riscv64/ C=3D1 W=3D1 arch/riscv/kernel/ drivers/acpi/
> > drivers/mailbox/ -j
> > make[1]: Entering directory '/data00/cyh/linux-next/build-riscv64'
> >   GEN     Makefile
> >   CC      scripts/mod/empty.o
> >   CC      scripts/mod/devicetable-offsets.s
> >   CHECK   ../scripts/mod/empty.c
> > invalid argument to '-march': '_zicsr_zifencei'
> >
> > make[3]: *** [../scripts/Makefile.build:229: scripts/mod/empty.o] Error=
 1
> > make[3]: *** Deleting file 'scripts/mod/empty.o'
> > make[3]: *** Waiting for unfinished jobs....
> > make[2]: *** [/data00/cyh/linux-next/Makefile:1215: prepare0] Error 2
> > make[1]: *** [/data00/cyh/linux-next/Makefile:224: __sub-make] Error 2
> >
> > Do you know the solution?
>
> In case you did not find the solution yet, I would say that your
> toolchain is too old.
>
> Let me know if I can help,
It may not be a problem of an old compiler. The version of the
compiler I am using is 13.2.
It is a problem with sparse. When running "sparse --arch=3Driscv
-march=3Drv64imac_zicsr_zifencei scripts/mod/empty.c", there is an
invalid argument for '-march': '_zicsr_zifencei'.

>
> Thanks,
>
> Alex
>
> >
> > >
> > > Thanks!
> > >
> > > Alex
> > >
> > >
> > > >
> > > >> Thanks,
> > > >>
> > > >> Alex
> > > >>
> > > >>
> > > > Thanks,
> > > > Yunhui
> >
> > Thanks,
> > Yunhui

Thanks,
Yunhui

