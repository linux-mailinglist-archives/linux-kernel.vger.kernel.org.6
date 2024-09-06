Return-Path: <linux-kernel+bounces-318027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1C996E753
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D7CB23CAC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7971BDCF;
	Fri,  6 Sep 2024 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikKqfWZb"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A884B11CAF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 01:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725586533; cv=none; b=J5iEYTuQ/tYUbBxlNyeP//f8UBnBnnfyI9dWvL4Tq9KTkEqjoG1qZiWd1KBRSLnfYWup34gTPFLwii2fRCEjTrv/pxYzDXZXcs1GKx38Me/dr+lcZ9QHbCYzIZsaik/bdWZ99WFrrmccyPukJA/gA9t7l7EwwNqy6q0GuuSHyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725586533; c=relaxed/simple;
	bh=tLDL+A9viQ1nAY8oe/yvXuYMz/gZ/yRpA38oxxwuROI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WJBp0L6iFmB108ZOlkj7viuxcYAWP7VFygYtCffFrn6GjXqNNbLLqyqhswOBNfx26b6A5Qd32Yd576UHr5ZIh1CDFROnixXOphZbGng5Itxy8JVdPUiU4Hut/KIFGjnOQj7zKTU8AE3/xhXWfeyY6LlLlKS4tairsNNTDWA8BP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikKqfWZb; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e1972a9622so934277eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 18:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725586531; x=1726191331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMgbS41L4QCYKYzW6bBuy48fjTdOYZvxaDewb5mrAAA=;
        b=ikKqfWZbbuHmVVvmeGXxdfxHturQjkQhqGJvZAgf6Oa4G7A3RGDy/rXxJS8tRXjRpN
         8MZb2FouGNr4RWIe+VZThHoSiTRcnxzwXzO1r2mqtDzz1ibAgVN+AREx7EZz+vGry+rK
         1D2Ej1V9+f7WJUgV6dzvoaBiNx6j3Sky8TdluPC1Hf80Hb6FfZTgrOi6a/12jRkzTCGV
         KFvnSkbnWfUSR5ECThvcuBQ7UUu7mP37ayVqtj19NBP653QOmkigiB2lhBq2DTvSHG6V
         5ddSEM1IkuE42U1sKK5lhA9YklR0VycZWs0k5Aa7N1WDtIpcPQjSlDih7hAQp60uutsQ
         YpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725586531; x=1726191331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMgbS41L4QCYKYzW6bBuy48fjTdOYZvxaDewb5mrAAA=;
        b=HFpW7ZFm0VGPaLbX708gl39FHnECYPxquw+djA6C/FzZT2nHtSQRk60y54ugZlQ9Rl
         DRjOhkKVCXn80pYVYvwgRxRQwfp7osFR5YYkqMPBDv+chM9JcvLvhHWIgvoEYvB6qNYI
         umgQbucArMdCbk1ZSkkHYenOAevilU2+4cji9pbuZrfx+2MSLJeOHh5VUHPf1e4pGEDJ
         /JX51RiYKgzSslmi7f+5nX/apRAJEGDF+kOXVM+BRxm1U0DJg9mrOw1VltQAhYTR+4yX
         3HINJzLNbd8VhcXZ6NPWWUPYE6MX9SrCQRsKuUWFG4t6M/L6MxC1b9fQzFB90rR/bx4W
         jSLg==
X-Forwarded-Encrypted: i=1; AJvYcCVNXmdkzyRW2JSB3wyafVUxJEd5yYsFtvMB5IGgQSedU1MzQeSrJ3HII/dqNAlfG4QIJ0dGrLc+bT11YXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mBW/vPdlGIzV8dIy0OrvgTFaC2RWWbs0olwQLOae/VaFYVlm
	zwA98f0hm/Sp2ykaqdyAspm/FP5XyGYuZm0FIEXjVR1bhtY1Ic5GnNztUbDnbYibPcYFckGdVzW
	aOvQxRD8QM6qgRbO4MemsDGltYZCEq9hE
X-Google-Smtp-Source: AGHT+IHfjCIHKFZIUvkTEZAvNmlhTTwAGrLTVFkuFCCz9tZ6BL6/rVTGbLGzacJbVMCXomf+S2cSsB2RvS+nLTAMdmo=
X-Received: by 2002:a05:6871:826:b0:27b:6ffd:bfd0 with SMTP id
 586e51a60fabf-27b6ffdc42bmr4273089fac.17.1725586530530; Thu, 05 Sep 2024
 18:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816101912.1049329-1-zhangchunyan@iscas.ac.cn> <665dee3c-1833-49c9-88d1-9f92475dbb59@ghiti.fr>
In-Reply-To: <665dee3c-1833-49c9-88d1-9f92475dbb59@ghiti.fr>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Fri, 6 Sep 2024 09:34:53 +0800
Message-ID: <CAAfSe-uyHNmMU97ZtsSYpUDw4shPx+v32tCY3j3vu2dweOCppA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Remove unused GENERATING_ASM_OFFSETS
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Aug 2024 at 20:30, Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Chunyan,
>
> On 16/08/2024 12:19, Chunyan Zhang wrote:
> > The macro is not used in the current version of kernel, it looks like
> > can be removed to avoid a build warning:
> >
> > ../arch/riscv/kernel/asm-offsets.c: At top level:
> > ../arch/riscv/kernel/asm-offsets.c:7: warning: macro "GENERATING_ASM_OFFSETS" is not used [-Wunused-macros]
> >      7 | #define GENERATING_ASM_OFFSETS
>
> So this warning never shows up in a "normal" kernel compilation, but it
> happens when using W=2 (with quite a lot of other warnings).
>
> This unused define indeed seems completely useless, I guess not all
> unused defines fall into this category and we should be careful when
> removing them, but for this one it makes sense so:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

I think this should be ready to be merged.

Palmer, would you please pick this up to your tree? Or I can resend
the patch if that's more convenient for you.

Thanks,
Chunyan

>
> Thanks,
>
> Alex
>
>
> >
> > Fixes: 9639a44394b9 ("RISC-V: Provide a cleaner raw_smp_processor_id()")
> > Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
> > ---
> >   arch/riscv/kernel/asm-offsets.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> > index b09ca5f944f7..cb09f0c4f62c 100644
> > --- a/arch/riscv/kernel/asm-offsets.c
> > +++ b/arch/riscv/kernel/asm-offsets.c
> > @@ -4,8 +4,6 @@
> >    * Copyright (C) 2017 SiFive
> >    */
> >
> > -#define GENERATING_ASM_OFFSETS
> > -
> >   #include <linux/kbuild.h>
> >   #include <linux/mm.h>
> >   #include <linux/sched.h>

