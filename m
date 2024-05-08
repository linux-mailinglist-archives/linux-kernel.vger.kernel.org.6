Return-Path: <linux-kernel+bounces-173537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638698C01E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8A0281B83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0411112A16C;
	Wed,  8 May 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rm6ALsVE"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D712881C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185432; cv=none; b=umGOAk5byzPUSd/2SHzSgQoXkFNW0Dt959nK4SItMch83C8O+mL4F8qiOCaFeq2F0XtHml0u0yI4wpHbi6WUxYWRxfEJnIRvH8n/ncsJ7t4RgwXXspjxJf3SbaL9/iwhN27xVbuk5I/12tHe5rhWEdmkIc9pYlcBe0zpIwNIo+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185432; c=relaxed/simple;
	bh=LALlFwOWTUd2XSFgFgwKb1A89IlaNVHQcrhML21oaak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSKZ8iXEqrSuK/9JDYe17pvlukWyFeE6R8XJfXLvu0lg0BPuWMhn3+wme+74oH4nImmtMGySK/oAQDFjWmrEKCPmA7UcYjXC8HF5dxYKIzcXhKjiZM2c4bd12EzdgCvtls73ZECEu3N5NESZgNV1MSYHwU4i3mkHz98ZGxaoSl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rm6ALsVE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b33d011e5dso782018a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 09:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715185430; x=1715790230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9PR0H5Ma0VdvfQv9vA6DsIGHDUPuZqqFaaGm/DimjM=;
        b=rm6ALsVEUBA5vlThf+LLOrFRqDPL0plouypTYD4j64Z/QVUGal3dpFMQKGTm5iiBXJ
         Cjj9KHkvnA2zi0gV2/7tsQbmMoaNQ/kMtOEpT9/O5smSSigdP9JgM/t7bBAvIGfCeljN
         hT6NHi0YiegEs5t3LYDiz3N835D0w4uBD9fdmu6WZrnVjrhX2i1pc4eKsEF+B9NrNUKt
         00MpDlfIO89Xs0Fqja43FdjcHbEw+Z6vz7AUYnYmEYnbJTIxm4+zDF4NOG5Mhy2JSUlN
         70kIzrt6hVBHMum4Xwp/JgjSph7iyxRZjwjRVrGKKhcInxPXgq/KmANBhS1oBg3QmukT
         khTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715185430; x=1715790230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q9PR0H5Ma0VdvfQv9vA6DsIGHDUPuZqqFaaGm/DimjM=;
        b=DMx8fXjVjS34hSNBZUXRLPabSGjskaCRqX4UL/7a+LQKeg2n4zsPsaJxzcwzQD+yzs
         oWhZMtT10VQ2KMgHxmDpgjeY6ttLauvNT201d2mjipzxsH2W4PrBv52gh1wSk/mH3LCL
         DIAN1bttCyhChLOGwTr51zn4eAAXxqiHCuNL+uaxqhMmf9ffWFkH1rJDmlpYOxdp3Von
         8lrjPGHoE+IsrSJ2GQSdwQgeckIe1s6le6RmiWgg0gDzBtYKAEeauedDYWLHrCmW4pSs
         HWuOifZH2ZTyAi/ySAV+so4ty1U0Tas6BPELtGsK1WHfDF16jPVJ19fKoLm6AVODGgCR
         uz6w==
X-Forwarded-Encrypted: i=1; AJvYcCU+RrnU0/GBx8wVn1T2AmaU+MpTEpCaivZwYjD99bMSaR1HmtSMGsqFiVbJiPVZZFbUGklGVufKTc05NXO7fYZjQKPH8K6q9RO/xphA
X-Gm-Message-State: AOJu0YxHHxGsdnrXyDpH0vsGgmipsIyj21504MDjV9AReYdW9Y4bmy5K
	7rMY8Z2q/Yrw43/M4gfMf4y6oRlZjNGsH39UQ7OqzAL9Ph22S2v/maLmX5RHMO5VZeC4b6lV15o
	LcxOLEYH406MsOqRAEwLES+V3SukOvpoy/4WVMA==
X-Google-Smtp-Source: AGHT+IGG2VOIinHtS5GnaEwxWHkBdndt57JbFMCF8GT0Evb8OyYBWNqOAOJa/aA98QEZ3bfiqYVpMobFkZtcNX1hB0w=
X-Received: by 2002:a17:90a:e396:b0:2b6:208c:2aee with SMTP id
 98e67ed59e1d1-2b65fe18df9mr188527a91.20.1715185429807; Wed, 08 May 2024
 09:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1714494653.git.tjeznach@rivosinc.com> <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
 <20240501145621.GD1723318@ziepe.ca> <CAH2o1u63GjMnYrfa8W-c1hdp+TAA0R-FyxXM4dEiFF+KEGWwbA@mail.gmail.com>
 <20240503181059.GC901876@ziepe.ca> <CAH2o1u7av8zMucB2sKxBOZtd1eqEC4Qmgin=8VQ03pWbQdZUUg@mail.gmail.com>
 <20240505154639.GD901876@ziepe.ca> <CAH2o1u6g87nt=S7id-O43PubR=GaOLj-vmk7+OdTiY=Kw1BU5A@mail.gmail.com>
 <20240507165156.GH4718@ziepe.ca>
In-Reply-To: <20240507165156.GH4718@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Wed, 8 May 2024 09:23:37 -0700
Message-ID: <CAH2o1u7tu2NrbFs0g8y4iUdAUYUEN=O_H4C+O_LmwbuZS-zeqw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 9:51=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Mon, May 06, 2024 at 07:22:07PM -0700, Tomasz Jeznach wrote:
> > On Sun, May 5, 2024 at 8:46=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> w=
rote:
> > >
> > > On Fri, May 03, 2024 at 12:44:09PM -0700, Tomasz Jeznach wrote:
> > > > > For detach I think yes:
> > > > >
> > > > >    Inv CPU                                   Detach CPU
> > > > >
> > > > >   write io_pte                               Update device descri=
ptor
> > > > >   rcu_read_lock
> > > > >     list_for_each
> > > > >       <make invalidation command>            <make description in=
v cmd>
> > > > >       dma_wmb()                              dma_wmb()
> > > > >       <doorbell>                             <cmd doorbell>
> > > > >   rcu_read_unlock
> > > > >                                              list_del_rcu()
> > > > >                                              <wipe ASID>
> > > > >
> > > > > In this case I think we never miss an invalidation, the list_del =
is
> > > > > always after the HW has been fully fenced, so I don't think we ca=
n
> > > > > have any issue. Maybe a suprious invalidation if the ASID gets
> > > > > re-used, but who cares.
> > > > >
> > > > > Attach is different..
> > > > >
> > > > >    Inv CPU                                   Attach CPU
> > > > >
> > > > >   write io_pte
> > > > >   rcu_read_lock
> > > > >     list_for_each // empty
> > > > >                                              list_add_rcu()
> > > > >                                              Update device descri=
ptor
> > > > >                                              <make description in=
v cmd>
> > > > >                                              dma_wmb()
> > > > >                                              <cmd doorbell>
> > > > >   rcu_read_unlock
> > > > >
> > > > > As above shows we can "miss" an invalidation. The issue is narrow=
, the
> > > > > io_pte could still be sitting in write buffers in "Inv CPU" and n=
ot
> > > > > yet globally visiable. "Attach CPU" could get the device descript=
or
> > > > > installed in the IOMMU and the IOMMU could walk an io_pte that is=
 in
> > > > > the old state. Effectively this is because there is no release/ac=
quire
> > > > > barrier passing the io_pte store from the Inv CPU to the Attach C=
PU to the
> > > > > IOMMU.
> > > > >
> > > > > It seems like it should be solvable somehow:
> > > > >  1) Inv CPU releases all the io ptes
> > > > >  2) Attach CPU acquires the io ptes before updating the DDT
> > > > >  3) Inv CPU acquires the RCU list in such a way that either attac=
h
> > > > >     CPU will acquire the io_pte or inv CPU will acquire the RCU l=
ist.
> > > > >  4) Either invalidation works or we release the new iopte to the =
SMMU
> > > > >     and don't need it.
> > > > >
> > > > > But #3 is a really weird statement. smb_mb() on both sides may do=
 the
> > > > > job??
> > > > >
> > > >
> > > > Actual attach sequence is slightly different.
> > > >
> > > >  Inv CPU                            Attach CPU
> > > >
> > > >  write io_pte
> > > >   rcu_read_lock
> > > >     list_for_each // empty
> > > >                                     list_add_rcu()
> > > >                                     IOTLB.INVAL(PSCID)
> > > >                                     <make description inv cmd>
> > > >                                     dma_wmb()
> > > >                                     <cmd doorbell>
> > > >  rcu_read_unlock
> > > >
> > > > I've tried to cover this case with riscv_iommu_iotlb_inval() called
> > > > before the attached domain is visible to the device.
> > >
> > > That invalidation shouldn't do anything. If this is the first attach
> > > of a PSCID then the PSCID had better already be empty, it won't becom=
e
> > > non-empty until the DDT entry is installed.
> > >
> > > And if it is the second attach then the Inv CPU is already taking car=
e
> > > of things, no need to invalidate at all.
> > >
> > > Regardless, there is still a theortical race that the IOPTEs haven't
> > > been made visible yet because there is still no synchronization with
> > > the CPU writing them.
> > >
> > > So, I don't think this solves any problem. I belive you need the
> > > appropriate kind of CPU barrier here instead of an invalidation.
> > >
> >
> > Yes. There was a small, but still plausible race w/ IOPTEs visibility
> > to the IOMMU.
> > For v5 I'm adding two barriers to the inval/detach flow, I believe
> > should cover it.
> >
> > 1) In riscv_iommu_iotlb_inval() unconditional dma_wmb() to make any
> > pending writes to PTEs visible to the IOMMU device. This should cover
> > the case when list_add_rcu() update is not yet visible in the
> > _iotlb_inval() sequence, for the first time the domain is attached to
> > the IOMMU.
> >
> >   Inv CPU                                    Attach CPU
> >   write io_pte
> >   dma_wmb (1)
> >   rcu_read_lock
> >     list_for_each // empty                   list_add_rcu()
> >                                              smp_wmb (2)
> >                                              Update device descriptor
> >                                              <make description inv cmd>
> >                                              // PTEs are visible to the=
 HW (*1)
> >                                              dma_wmb()
> >                                              <cmd doorbell>
> >   rcu_read_unlock
> >
> > 2) In riscv_iommu_bond_link() write memory barrier to ensure list
> > update is visible before IOMMU descriptor update. If stale data has
> > been fetched by the HW, inval CPU will run iotlb-invalidation
> > sequence. There is a possibility that IOMMU will fetch correct PTEs
> > and will receive unnecessary IOTLB inval, but I don't think anyone
> > would care.
> >
> >   Inv CPU                                    Attach CPU
> >   write io_pte                               list_add_rcu()
> >                                              smp_wmb (2)
> >                                              Update device descriptor
> >                                              <make description inv cmd>
> >                                              // HW might fetch stale PT=
Es
> >                                              dma_wmb()
> >                                              <cmd doorbell>
> >   dma_wmb (1)
> >   rcu_read_lock
> >     list_for_each // non-empty (*2)
> >       <make iotlb inval cmd>
> >       dma_wmb()
> >       <cmd doorbell>
> >   rcu_read_unlock
> >
> > 3) I've also updated riscv_iommu_bond_unlink() to wipe the PSCID cache
> > on the last domain unlink from the IOMMU.
> >
> > Thank you for pointing this out. Let me know if that makes sense.
>
> I'm not an expert in barriers, but I think you need the more expensive
> "mb" in both cases.
>
> The inv side is both releasing the write and acquiring the list
> read. IIRC READ_ONCE is not a full acquire?
>
> The Attach side is both releasing the list_add_rcu() and acquiring the
> iopte.
>
> rcu is still a benefit, there is no cache line sharing and there is
> only one full barrier, not two, like a spinlock.
>
> And a big fat comment in both sides explaining this :)
>

I'm not an expert in barriers as well, but I've checked offline with one ;)

And the conclusion is that we need FENCE W,W (or stronger) on the
attach side, and FENCE RW,RW in the invalidation sequence.  Hardware
access to PTE/DC is sequential, with implied FENCE R,R barriers.

As 'attach' sequence is a rare event anyway, I'll go on "mb" on both
sides, as suggested.
Unless there are other opinions on that I'll update barriers to match
this conclusion and try to capture in long comment for bond / inval /
attach synchronization assumptions.

Jason, thanks again for pointing this out.


> Jason

Best,
- Tomasz

