Return-Path: <linux-kernel+bounces-576447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D0A70F64
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55AA3B9DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392C016132F;
	Wed, 26 Mar 2025 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ieucVopM"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E162E403
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959581; cv=none; b=C+77wGIJ5sRmGvFibW8pkmxF+B0UaXTx/kmR2qC+rgksh3lWyXtzOn4nNCNbaDBKmN3c/pc0c6053QGokD0rhjnbpiC4EaLcfTGKcStcrme1DpNCC9NH6xgQsPYBONJB7t9E3gVSoCeoWdoTXm582V1U+no6gCRYxNO6bbb5PuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959581; c=relaxed/simple;
	bh=RfYEVpFV77vQUZcEiqLW/wGhxmNFc+8zk8y1nmVLwa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyYREu7HB5peLEqQXm38yH1cGdoEoB5BSHPbKqlwvd27RpeXlS0EMC3uEvvLaPrOtCVn+OadORg3/cUeSKuvJwIm5NBUpIcpIur7RLT0tZmYKW4ZNDRNuhGhZvxOPwoe1xkLBOh02PGoWO2PrUigYIa83rTrqtjnsZdzqSgujG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ieucVopM; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301e05b90caso9890164a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742959579; x=1743564379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfIZvsvXpyObm/MeDnvF7J2nbF4JP/x/sNoYgG6zOmE=;
        b=ieucVopM2V82c5C33WJpIfTYJGd3371Jf5U/lqUycprkagMlSzPNQEdhbHY4JCNvQn
         w1W5apfKOUv5s0E5d041sRdyXwq8jdjOzliZkjmKSwCeLe3mpJeAZcaj6/EjTVQHJAhe
         AhZm2cwqRYVQVQIZkX65QhyPfxsvE6A9bFkYVBmwKebUxvhGbpph3Ph2Uag7Yd5e1Bub
         clr3BuD7jXGwuMrMFihdpAkJHZU7FThC26/OgOlYfDdDEXGlkmRqb0IKZYeFYy1eCQWz
         pbzFtjRFmZ1sihwVe4M5DyyshQy1UlxhFiZ6oZzHBjbugwmnY3C9fGkBk6DM15TxkZIn
         jx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742959579; x=1743564379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfIZvsvXpyObm/MeDnvF7J2nbF4JP/x/sNoYgG6zOmE=;
        b=ur5XItyKpViAYSUsjYciFfjxA+lDLI4RujrQuL9Styry10jKPMIXAjqcnLnR7Y2rK0
         F0iUL3H2Ptpe5pDu3rH02AJAevPd6WyoGgXb1pMiKzBpER8XV0RgptRS0snRHQyzx4B6
         5JxcMhs1y/HlGNmW35V1SAm/bBkjzlkoM6VOIvZtI3w8hb3BgPkpq3NqZgfzzEdaeX++
         akuHBu1FxNBeYIzg+ETL7jzK8GiXamswA7NUQGKvzskBKkbHX3tkrT7oEdmbr0IXfqgE
         gFxoB0kG371DROo4AcC/H55py+bU3ogPmoBYmvViV8tt0icg8iBJ5aneZN5hqTLQ1I0x
         3tCw==
X-Forwarded-Encrypted: i=1; AJvYcCXbYraKpstWt8xkkPQVGmy06DMI/n2c/WZN3+d3XiJ6qnCaHEH6hoxnRU4qYZTDqgUDr9moi1JfV5UbcDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3VVtpQ/fLh2R94bTHyARZhpIjEhhOJVYo86J75G8nv5iWuXD
	8/DtzCZ+nQxIwdJQHQOoPzM2dM/hdde7q9lqQ+JEWOFpWbhx75JmbfdwiDdAHVfyX5mnZ57Inea
	ExrEHTKf1mv65w4KmoVFhjPE2M4feNbMIR0wx4Q==
X-Gm-Gg: ASbGncuussj1tViwX5fCjdw0dIAbBIw2hBBO8KaEyKbwVAjTF0zB6sj36NSL1kgk4Ac
	Twmjz+PgNesXv0OCWgdUIFlfTCmvrPLVL7F/HQtm9W8BBhz4M/AHXtzLvifgNP8lCjNcyvEd6El
	UthYfLdbblVbjTpZbEqAJYUyh9FJXo48heCY/WE7k=
X-Google-Smtp-Source: AGHT+IESJp7bMb71tkEwSEqLlTExKVrqQjhhbFW5v0UB8BFvfnFaTdUzEAIGCTPbNRUOBYf4WDIquQovAJzJJAsBfdo=
X-Received: by 2002:a17:90b:540b:b0:2ff:52e1:c49f with SMTP id
 98e67ed59e1d1-3030fef7845mr25635283a91.26.1742959578594; Tue, 25 Mar 2025
 20:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325144252.27403-1-luxu.kernel@bytedance.com> <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
In-Reply-To: <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 26 Mar 2025 11:26:07 +0800
X-Gm-Features: AQ5f1Jo0368Hu_uIx_F-VQxmteASeA53lS4ajgOXrFsQ3icn84Q0MxG88EP36ck
Message-ID: <CAPYmKFtAWNz7nCDDD7rjGeV2fRBgy5Kt6KR60pEyXAM=bb7r4g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32
 bit I/O bus platform
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, alex@ghiti.fr, lihangjing@bytedance.com, 
	xieyongji@bytedance.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> Is such a platform conformant to the specification?

We have talked about this before [1]. I think the IOMMU spec does not
mandate the implementation of 8-byte access functionality. The related
sentences are listed below:

"The 8-byte IOMMU registers are defined in such a way that software
can perform two individual 4-byte accesses, or hardware can perform
two independent 4-byte transactions resulting from an 8-byte access,
to the high and low halves of the register, in that order, as long as
the register semantics, with regard to side-effects, are respected
between the two software accesses, or two hardware transactions,
respectively."

"Registers that are 64-bit wide may be accessed using either a 32-bit
or a 64-bit access."

> Either way, why is this a static build-time configuration choice rather t=
han a dynamic run-time choice based on the FDT / ACPI tables / some other p=
latform probing method?

I did not find available field in RIMT table to describe it. So maybe
adding a new config is faster.

[1] https://www.uwsg.indiana.edu/hypermail/linux/kernel/2408.3/03968.html

Best Regards,

Xu Lu

On Wed, Mar 26, 2025 at 2:51=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 25 Mar 2025, at 14:42, Xu Lu <luxu.kernel@bytedance.com> wrote:
> >
> > Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
> > splitting 8-byte access into 4-byte transactions for hardware platform
> > whose I/O bus limits access to 4-byte transfers.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
>
> Is such a platform conformant to the specification? Either way, why is
> this a static build-time configuration choice rather than a dynamic
> run-time choice based on the FDT / ACPI tables / some other platform
> probing method?
>
> Jess
>
> > ---
> > drivers/iommu/riscv/Kconfig |  9 +++++++++
> > drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
> > 2 files changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> > index c071816f59a6..b7c9ea22d969 100644
> > --- a/drivers/iommu/riscv/Kconfig
> > +++ b/drivers/iommu/riscv/Kconfig
> > @@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
> > def_bool y if RISCV_IOMMU && PCI_MSI
> > help
> >  Support for the PCIe implementation of RISC-V IOMMU architecture.
> > +
> > +config RISCV_IOMMU_32BIT
> > + bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
> > + depends on RISCV_IOMMU
> > + default n
> > + help
> > +  Support hardware platform whose I/O bus limits access to 4-byte
> > +  transfers. When enabled, all accesses to IOMMU registers will be
> > +  split into 4-byte accesses.
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 46df79dd5495..0e3552a8142d 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -14,6 +14,10 @@
> > #include <linux/iommu.h>
> > #include <linux/types.h>
> > #include <linux/iopoll.h>
> > +#ifdef CONFIG_RISCV_IOMMU_32BIT
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#endif
> >
> > #include "iommu-bits.h"
> >
> > @@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> > #define riscv_iommu_readl(iommu, addr) \
> > readl_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readq(iommu, addr) \
> > - readq_relaxed((iommu)->reg + (addr))
> > -
> > #define riscv_iommu_writel(iommu, addr, val) \
> > writel_relaxed((val), (iommu)->reg + (addr))
> >
> > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > + readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> > +   delay_us, timeout_us)
> > +
> > +#ifndef CONFIG_RISCV_IOMMU_32BIT
> > +#define riscv_iommu_readq(iommu, addr) \
> > + readq_relaxed((iommu)->reg + (addr))
> > +
> > #define riscv_iommu_writeq(iommu, addr, val) \
> > writeq_relaxed((val), (iommu)->reg + (addr))
> >
> > #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, tim=
eout_us) \
> > readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
> >   delay_us, timeout_us)
> > +#else /* CONFIG_RISCV_IOMMU_32BIT */
> > +#define riscv_iommu_readq(iommu, addr) \
> > + hi_lo_readq_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > - readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > + ((addr =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> > + lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> > + hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
> > +
> > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > + readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, c=
ond, \
> >   delay_us, timeout_us)
> > +#endif /* CONFIG_RISCV_IOMMU_32BIT */
> >
> > #endif
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>

