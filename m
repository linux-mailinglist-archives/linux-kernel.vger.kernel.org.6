Return-Path: <linux-kernel+bounces-267073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 420F4940C10
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654821C23FF9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF51940AB;
	Tue, 30 Jul 2024 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="LDb71Y39"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC48192B95
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329070; cv=none; b=p4uTb84hWmmc08HeH6FOAIIbdGMls1qbkCDf2dMQ9cgbZMiA8EuEHc7U875Ohlz9va5ekrqhkfmFe5bCo6NO8jnyF7CtJEvTsj+Yi1ZRkuNC+0+nWuWU65xPElA8BGyI1EOsU8qdrR5m1rpquQqotBwkH5R9wL18UyKXNH0L1yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329070; c=relaxed/simple;
	bh=girO8SirVrS7ocnLdlEMu5cN0kRXGiIxT73VNwbmPKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm9q/JOaXNtXXoyk5TWWFICKMX7LknlVe92EiNLfVNplfy66I7hPxRc+AwYgXHY/naFH9PdebF9zbEsQ8crRbyf3gKj1XqfxrftIwq6Sit0kFJyvHsMPZ5XcqxWu/u4S/FfVeT//nVhhkymExVIHtZo2iuBJNCp65MMMIcDS3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=LDb71Y39; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1d42da3f7so270386485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722329068; x=1722933868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9Z8X5Ur6Rsa6ibm6mJESwNAG5xBw8yZz7oNWy7yEQ0=;
        b=LDb71Y39UN5ArFiYecEHH299z/zrnIpMMjil89K+Z6tLXyHkastbg8uOROsMxDa8dl
         R3Larhf5Gj3T43tri4QTm8iKvTCqZAZSrLlNsVWo8eTWrriYsihUyeI3uofUznzjrxKt
         B1W+sNOrzR+txwknuia+rUdGZVid896uqcAzBOMXr3KcHRGVb2FnrIzBqMaYMT1XY81T
         x+jPy6RWRHhA7dU7SvJ48XsCWde64YQW2pplSdgb7w9TEykr1LTeMSv8OdE61dTccKrJ
         w8xdGKrWt/tDgZ9KZ7yZEmgfui9z7wfD+v4oLbIFihQw48D73kBNdd1y9NSkFzns8CCD
         qJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722329068; x=1722933868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9Z8X5Ur6Rsa6ibm6mJESwNAG5xBw8yZz7oNWy7yEQ0=;
        b=cBnskKQscHesWFCze/YiShIbhJOpHsI8gV+Gu8k+NBa0/dTBeJW4hG5GvLHHCA0Kd9
         lBGAWsoZHdBSccU9iAV90T+hKchXcZttMMZ4ntCrTZITz0KEdTlijJXXUxkq92vSuxZU
         ctWQW9yDEiQaeMXiospE2tpbL9xGDIv9t+pjCNKtTLWe338C4DY+XK8d1AS5R3MOOR0J
         fCLzW9xrp554q9twwDA57NtD4yV3Zu8By1mOXCmSAfxKDUwL8TqKiVgXa+rxiP6ofUdS
         P8KUQi2ftJYRn5S3TQqtAyVRtjbmoDx4IbmUrkbgTF8QpKzOSWNb8SCU5IWwVKvehrVZ
         7v9w==
X-Forwarded-Encrypted: i=1; AJvYcCWmgS+UilusX2L2uQDRCB7pz8chE+YOdzLkK83RDDp/h0sHpmXSbxLAymYEUzoVh1yGgzUoMJisyjNoVC3cbwnEktcubtikEgWbMNpg
X-Gm-Message-State: AOJu0Yw6BCTaC/4R17Ab/PrSLK+kJkQ/N5Rbt3pWFxJKdGTsclxba1za
	JlNKhinxrYMbwpwGaXY4tju235YrgBEavCIYprVo1DBJcHNUoug6hfzdgiEiGgtmDFlaNVzzY7X
	PX4O/ccKLvZT6vZEMth5gZGTcYhuvLND5BTWU4A==
X-Google-Smtp-Source: AGHT+IF6pSDZRcuI8UOjMmmGb/r5CZ13qlBfJEvjHj524MWPSKJ+lHN8ZSGpcY+epryewRGd3voPyD3rfCPugLFzS04=
X-Received: by 2002:a05:620a:28d2:b0:79d:5565:5120 with SMTP id
 af79cd13be357-7a1e526aee0mr1325025085a.34.1722329067673; Tue, 30 Jul 2024
 01:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702102637.9074-1-mchitale@ventanamicro.com> <mhng-38c26ef6-8d45-4dd1-9c3a-f71f34f1ef81@palmer-ri-x1c9>
In-Reply-To: <mhng-38c26ef6-8d45-4dd1-9c3a-f71f34f1ef81@palmer-ri-x1c9>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Tue, 30 Jul 2024 14:13:52 +0530
Message-ID: <CAN37VV6DMpsRWnH-1tN2AfT8HXbEFh2We4Yw0XYkuCNvF75o4w@mail.gmail.com>
Subject: Re: [PATCH v8] riscv: mm: Add support for Svinval extension
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, alexghiti@rivosinc.com, 
	samuel.holland@sifive.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 8:20=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Tue, 02 Jul 2024 03:26:37 PDT (-0700), mchitale@ventanamicro.com wrote=
:
> > The Svinval extension splits SFENCE.VMA instruction into finer-grained
> > invalidation and ordering operations and is mandatory for RVA23S64 prof=
ile.
> > When Svinval is enabled the local_flush_tlb_range_threshold_asid functi=
on
> > should use the following sequence to optimize the tlb flushes instead o=
f
>
> Do you have any performance numbers for the optimization?  As per here
> <https://lore.kernel.org/all/mhng-f799bd2b-7f22-4c03-bdb2-903fa3b5d508@pa=
lmer-ri-x1c9a/>.

No, currently there are no numbers available for comparison but the
rationale for the optimization is described in the spec. The extension
is mandatory for the RVA23S64 profile but any platform that doesn't
support this extension will not be impacted as the code executes only
if the svinval extension is enabled at the boot up.
>
> > a simple sfence.vma:
> >
> > sfence.w.inval
> > svinval.vma
> >   .
> >   .
> > svinval.vma
> > sfence.inval.ir
> >
> > The maximum number of consecutive svinval.vma instructions that
> > can be executed in local_flush_tlb_range_threshold_asid function
> > is limited to 64. This is required to avoid soft lockups and the
> > approach is similar to that used in arm64.
> >
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> > Changes in v8:
> > - Fix line wrap
> > - Add RB tag
> >
> > Changes in v7:
> > - Use existing svinval macros in the insn-def.h
> > - Rename local_sinval_vma_asid to local_sinval_vma
> >
> > Changes in v6:
> > - Rebase on latest torvalds/master
> >
> > Changes in v5:
> > - Reduce tlb flush threshold to 64
> > - Improve implementation of local_flush_tlb* functions
> >
> > Changes in v4:
> > - Rebase and refactor as per latest changes on torvalds/master
> > - Drop patch 1 in the series
> >
> > Changes in v3:
> > - Fix incorrect vma used for sinval instructions
> > - Use unified static key mechanism for svinval
> > - Rebased on torvalds/master
> >
> > Changes in v2:
> > - Rebased on 5.18-rc3
> > - update riscv_fill_hwcap to probe Svinval extension
> >
> >  arch/riscv/mm/tlbflush.c | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index 9b6e86ce3867..782147a63f3b 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -6,6 +6,27 @@
> >  #include <linux/hugetlb.h>
> >  #include <asm/sbi.h>
> >  #include <asm/mmu_context.h>
> > +#include <asm/cpufeature.h>
> > +
> > +#define has_svinval()        riscv_has_extension_unlikely(RISCV_ISA_EX=
T_SVINVAL)
> > +
> > +static inline void local_sfence_inval_ir(void)
> > +{
> > +     asm volatile(SFENCE_INVAL_IR() ::: "memory");
> > +}
> > +
> > +static inline void local_sfence_w_inval(void)
> > +{
> > +     asm volatile(SFENCE_W_INVAL() ::: "memory");
> > +}
> > +
> > +static inline void local_sinval_vma(unsigned long vma, unsigned long a=
sid)
> > +{
> > +     if (asid !=3D FLUSH_TLB_NO_ASID)
> > +             asm volatile(SINVAL_VMA(%0, %1) : : "r" (vma), "r" (asid)=
 : "memory");
> > +     else
> > +             asm volatile(SINVAL_VMA(%0, zero) : : "r" (vma) : "memory=
");
> > +}
> >
> >  /*
> >   * Flush entire TLB if number of entries to be flushed is greater
> > @@ -26,6 +47,16 @@ static void local_flush_tlb_range_threshold_asid(uns=
igned long start,
> >               return;
> >       }
> >
> > +     if (has_svinval()) {
> > +             local_sfence_w_inval();
> > +             for (i =3D 0; i < nr_ptes_in_range; ++i) {
> > +                     local_sinval_vma(start, asid);
> > +                     start +=3D stride;
> > +             }
> > +             local_sfence_inval_ir();
> > +             return;
> > +     }
> > +
> >       for (i =3D 0; i < nr_ptes_in_range; ++i) {
> >               local_flush_tlb_page_asid(start, asid);
> >               start +=3D stride;

