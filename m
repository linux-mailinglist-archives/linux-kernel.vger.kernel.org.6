Return-Path: <linux-kernel+bounces-373718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 890C39A5AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CF5281920
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 06:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C5D1D04BB;
	Mon, 21 Oct 2024 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LPEV9dwF"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2953B15575F
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493135; cv=none; b=qJYOt4PQzq2tggycl0gvPAL0uSZOAfDpux8VHCqTmja3DlTXez0HlCSF6XZ5NT++0pY/9RvXNwv0el+6sRrtqlS20B5ZEYK4eOvfm0cNVzWBQRdI/u4pI7nnpeU2pR60Ohnuq68UHPvaiL9A1fwf9WO1FHUXJQS2B+Na7RzHj3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493135; c=relaxed/simple;
	bh=xreiY56lCew1NGsRGnAb6ELMwW3kJuBXQ0EKfeKjO0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRrN3COMWpM35CNZmuFegj1AwCjGqmm47twL4hhlxhEHo8HPvZG6eVSsf5UuY7jxTX5BD7ts0viEt8YeMYP7xvmMyvPZV2EK4OR0pY1kV54NRYe6grirpLzxKFGhDdGVlpQS2HzE0yq6YyV8SIE6t8ELAo0KA/zd+sSvB96aovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LPEV9dwF; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc22e6362so295144eaf.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1729493132; x=1730097932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFfz4pBXhPmkPLZ+Y2pEcUJL3NkrX4tf7jn81UWQ+lk=;
        b=LPEV9dwFzVDOZpfjVlkQo56Fs1fBPn9jURwp50ASOE6bL9wutwVnea7qDsuuDIornp
         CuBnUP9bbzXbpXxDbv6EJfZCElecRSKVpEc/qgQnuqE5Siw4iv25b/lMrGMm0tcPtWd4
         5rg1n6KL1/5wg+ThfGDlUJr4V8k/RNeBbFvlkmQvpPn8yiPiyKoideC5HETEISbxoKap
         eeKuIpHSU6MVDtc1VGp2GOozRAZvF8FdCVx6KpDEqo0thlsZf0p7OK9yCJkpTAWR8n2v
         u5ERvdxMbZyAKlEcTRXMIGtH0aC1qt7E/FGns+cOJjzovYV2K5OUrZxkoBWxDXfnwRiz
         OKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729493132; x=1730097932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CFfz4pBXhPmkPLZ+Y2pEcUJL3NkrX4tf7jn81UWQ+lk=;
        b=OMZGlytfZJnEr42BMZWAtGvfbjb1dFEZb6iVl465dVgFTdcEA+lht11ec3AoxVxYB9
         MbITmQcj+u82fAlflAxmzcV/sK/IOze+5SW1jlRGS5q6/g4wWbk9KCr7TcLZyVf6bxVK
         Wb99qUncfBMSFPMVPz4hujmB/LZFhfVK2mVgjYO6iOUkElh0ArxFWlEu9HWENNr1oxbt
         YZzi8NMk2Uo0tYW4z1e2cj8avnHHFNFYFgeX8X8B19utsD2hTSThOy90NEj/zZs0NEhm
         HHyE6hGRur97m7thCtJG8b8Aa/D9XVjr1kkOu9liwkDO3HeaCKNcRu3Ei4b/WkCn0ocq
         25pw==
X-Forwarded-Encrypted: i=1; AJvYcCWwfvJwKY4Vpj4hKu5XDFz9Dg33GHv9QnKuQqShOJJrjkT1/ma67VLgccWj3CY5REv4gUeE/cd90yzeEe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS4qu0btT17NPJns1hSZXYaoWZ6nlAtGn5/u2NeRWAtUXK6fUJ
	O8ALCwD2hyu82nzX7W3bdt3FN9v0TpZstKAZaBwolniMVZOt0WG0ooE3ilVEPm8noh0wpxNPMwm
	kWSOoRL/U+M/mudqKrBkVL7X9PidnOGeoZzQjNA==
X-Google-Smtp-Source: AGHT+IHkWkcHdT5DdeVMSrPXb/6gesNmbseDkgI2CbS77LtrEjkte5ZlyuuYYfHzjmSdDiMbJA9/m0Uxn3N1YAlwi8A=
X-Received: by 2002:a05:6820:1ad1:b0:5eb:758c:fa64 with SMTP id
 006d021491bc7-5eb8b5514b5mr7734392eaf.4.1729493132141; Sun, 20 Oct 2024
 23:45:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094705.71775-1-cuiyunhui@bytedance.com>
 <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr> <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
 <c05e09d0-d996-4712-a6e5-ef77f1f2ff0a@ghiti.fr>
In-Reply-To: <c05e09d0-d996-4712-a6e5-ef77f1f2ff0a@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 21 Oct 2024 14:45:20 +0800
Message-ID: <CAEEQ3wmw8B_cOs54H4Z8e2QTGyeE2cAYQwDRyk7KgUUKTFhZ-g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, sunilvl@ventanamicro.com, ajones@ventanamicro.com, 
	alexghiti@rivosinc.com, jeeheng.sia@starfivetech.com, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Mon, Oct 14, 2024 at 9:01=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> On 14/10/2024 14:30, yunhui cui wrote:
> > Hi Alex,
> >
> > On Mon, Oct 14, 2024 at 8:12=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr>=
 wrote:
> >> Hi Yunhui,
> >>
> >> On 14/10/2024 11:47, Yunhui Cui wrote:
> >>> When SVPBMT is enabled, __acpi_map_table() will directly access the
> >>> data in DDR through the IO attribute, rather than through hardware
> >>> cache consistency, resulting in incorrect data in the obtained ACPI
> >>> table.
> >>>
> >>> The log: ACPI: [ACPI:0x18] Invalid zero length.
> >>>
> >>> We do not assume whether the bootloader flushes or not. We should
> >>> access in a cacheable way instead of maintaining cache consistency
> >>> by software.
> >>>
> >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>> ---
> >>>    arch/riscv/kernel/acpi.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> >>> index 6e0d333f57e5..3177c9af8764 100644
> >>> --- a/arch/riscv/kernel/acpi.c
> >>> +++ b/arch/riscv/kernel/acpi.c
> >>> @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned lo=
ng phys, unsigned long size)
> >>>        if (!size)
> >>>                return NULL;
> >>>
> >>> -     return early_ioremap(phys, size);
> >>> +     return early_memremap(phys, size);
> >>>    }
> >>>
> >>>    void __init __acpi_unmap_table(void __iomem *map, unsigned long si=
ze)
> >>
> >> It makes sense to me since with this, we don't have to care about how
> >> the firmware mapped the table. And it mimics all other architectures
> >> (arm64, loongarch and x86).
> >>
> >> Here is the corresponding fixes tag:
> >>
> >> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in
> >> different address space")
> >>
> >> With the corresponding fix in __acpi_unmap_table() as pointed by Sunil=
,
> >> you can add:
> >>
> >> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >>
> >> And regarding the sparse error, I don't see any other architecture
> >> casting to __iomem, so maybe that's not necessary anymore?
> > OK. I will make the changes in v2. Regarding the sparse error, I will
> > use another patch specifically to solve it. Is that okay?
>
>
> If the second patch only consists in casting, I would not use another
> patch since the patch 2 would fix something introduced in patch 1.
>
> But if patch 2 is more complicated,  it may make sense to do as you
> suggest, the goal is to merge patch 1 asap.

Regarding patch 2, I executed "make & make install" for sparse of the
riscv arch. I "git cloned" from
https://github.com/ConchuOD/sparse.git.
Then when compiling the kernel, the following error was reported:

cd /data00/cyh/linux-next/
make defconfig
cp .config build-riscv64/

make O=3Dbuild-riscv64/ C=3D1 W=3D1 arch/riscv/kernel/ drivers/acpi/
drivers/mailbox/ -j
make[1]: Entering directory '/data00/cyh/linux-next/build-riscv64'
  GEN     Makefile
  CC      scripts/mod/empty.o
  CC      scripts/mod/devicetable-offsets.s
  CHECK   ../scripts/mod/empty.c
invalid argument to '-march': '_zicsr_zifencei'

make[3]: *** [../scripts/Makefile.build:229: scripts/mod/empty.o] Error 1
make[3]: *** Deleting file 'scripts/mod/empty.o'
make[3]: *** Waiting for unfinished jobs....
make[2]: *** [/data00/cyh/linux-next/Makefile:1215: prepare0] Error 2
make[1]: *** [/data00/cyh/linux-next/Makefile:224: __sub-make] Error 2

Do you know the solution?

>
> Thanks!
>
> Alex
>
>
> >
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> > Thanks,
> > Yunhui

Thanks,
Yunhui

