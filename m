Return-Path: <linux-kernel+bounces-367396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4269A01BA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8ED61C20A77
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CA5193408;
	Wed, 16 Oct 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sOwQ1ZIt"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF518DF7F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061402; cv=none; b=qx6JVwljRRN71PsyCMnfYWt/kmP2Bnowojpfn0bZJZKu+TMC9v8MKWIdUoM5BEVUdqZu7fNHALpTDA6D8MaxKrIlOGboOGOS7VBLSj2n2vaggYYs9BdDyHNvP5PGxvnUOKpJcsUtjjbPXM4EFXTNqdO5gGsO1vK0und8aCft6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061402; c=relaxed/simple;
	bh=rRhNbgxDbHoTGblJsjtteoTssjVJ96IBqykNoFh/vww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WjWyFTLG8h2ZGfU4TNhQng1l5j9qVLzj4L/TsTXreyGe/Rma4mxButEDpa4BudEk7m5Vucklg1J/t6/C3DGkIqI2iquDAUKJBmyrHDolAkNi4ykCKW+I4ti1Tnlz/t7PAxiD77Yg3UP+cTBgN2IVLq6GoCL/ogliYiqW/IGeWow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sOwQ1ZIt; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83541f580b6so241706839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061399; x=1729666199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuvWiWzGwPfPen/TP7UxW2wIuKmmBLuM/D7bBxMmtuI=;
        b=sOwQ1ZItWCZAn9nlgm1krlr0DIaiMJBzONHKi7CZpZBiUHAitC/h4wI0NeB+To6+Aw
         3aMpqwDbuGTJy95z7xGFkYi0xPlTTuOvd6P2OHPV2P3WGVXH3GfGBekxkmpz3iK0fAhs
         38KamMhdepWydZ30j7Ph3/LMI1x4IX8GTEVid7n57gNHxHFMvPIJubg3Lbvm1HZo0sN+
         rThEGXfcCLH/Xxa0eKw/jMHNf22xUP72TNwgYO/tK9o0afaGGw11FK/HnUBpEqGTbvIq
         EVqm9tefe3Pl0NegROJ93dZY7pywIEtOOX2MCmwICDx/dOuQJ1pGVETSxX+traficapw
         714g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061399; x=1729666199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuvWiWzGwPfPen/TP7UxW2wIuKmmBLuM/D7bBxMmtuI=;
        b=IUaiYNKxfXr15F7Uv3OLF4+ET/TIrhoJNy+hvahUNLHt0GWKKMcj57rsgyjUxrgl4m
         JpQmg8ygXX9/LOIThiO98AfO2eVHq1aWFLblE8X1jUjtphSUPCUCRKfdk9tFwYafGkFE
         aO16E9hnYJkPmUWD6cMFuEloQlpPFdHCtTI/YEIuX/ipLfMYAXE4yX17qMrP8mDa3sQq
         Mbt08xLrrUkgyAZzQ29YBBy4RxH4qDMpujxvxf9dTnqA4z75V+g909gZSrAWS6GYibbq
         X84zA4qFasmmnRRzbhrTBSXtpgsTUscdCBjAuJRJUJcwn61RQDrytwR4bkpIsdCBCUlQ
         NR5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUw3NnDBrLJkm7n0UfiY/OMchT7YI8rAfh/95B40loDUxDJiWcLId8SsbNrxMnWFf44aJv98TLE+pDnEUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwyXIQ1L4oRSsx5P+BzP0TfKLcAgPSD6pUSphZlmghQBbuKpQa
	5n3HlhcaU/0dP0ZIh73LSSzmmFMrazJzmSGlLtSm9bS5eKM1X+VjjHWw+bHl4bD2FoERCTcL74g
	8zZ99NwpzC2FhQf4fJ2H8EiddLk8Ysv+baSdsNw==
X-Google-Smtp-Source: AGHT+IFNJEtM2qSm9Q8EfSRdRlQdHW4tYyXrD+ovJ8ZHMJJ/SIGchnJLPemWmR8X+ZItdkgt/8/Gty81UCalEdYkjjw=
X-Received: by 2002:a05:6e02:1a4f:b0:3a3:b254:ca2c with SMTP id
 e9e14a558f8ab-3a3bce11c80mr131491775ab.25.1729061399011; Tue, 15 Oct 2024
 23:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1728579958.git.tjeznach@rivosinc.com> <6916f5308478013c7b4cda77403c1e9aa9982384.1728579958.git.tjeznach@rivosinc.com>
 <20241015085814.GB19110@willie-the-truck>
In-Reply-To: <20241015085814.GB19110@willie-the-truck>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 15 Oct 2024 23:49:48 -0700
Message-ID: <CAH2o1u5YLDuMNAy573ZrxS+Z8qqc0y1W9QoLyJ7P=AwcQ8LsxA@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] iommu/riscv: Command and fault queue support
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:58=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Oct 10, 2024 at 12:48:09PM -0700, Tomasz Jeznach wrote:
> > Introduce device command submission and fault reporting queues,
> > as described in Chapter 3.1 and 3.2 of the RISC-V IOMMU Architecture
> > Specification.
> >
> > Command and fault queues are instantiated in contiguous system memory
> > local to IOMMU device domain, or mapped from fixed I/O space provided
> > by the hardware implementation. Detection of the location and maximum
> > allowed size of the queue utilize WARL properties of queue base control
> > register. Driver implementation will try to allocate up to 128KB of
> > system memory, while respecting hardware supported maximum queue size.
> >
> > Interrupts allocation is based on interrupt vectors availability and
> > distributed to all queues in simple round-robin fashion. For hardware
> > Implementation with fixed event type to interrupt vector assignment
> > IVEC WARL property is used to discover such mappings.
> >
> > Address translation, command and queue fault handling in this change
> > is limited to simple fault reporting without taking any action.
> >
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Zong Li <zong.li@sifive.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
> >  drivers/iommu/riscv/iommu-bits.h |  75 +++++
> >  drivers/iommu/riscv/iommu.c      | 507 ++++++++++++++++++++++++++++++-
> >  drivers/iommu/riscv/iommu.h      |  21 ++
> >  3 files changed, 601 insertions(+), 2 deletions(-)
>
> [...]
>
> > +/* Enqueue an entry and wait to be processed if timeout_us > 0
> > + *
> > + * Error handling for IOMMU hardware not responding in reasonable time
> > + * will be added as separate patch series along with other RAS feature=
s.
> > + * For now, only report hardware failure and continue.
> > + */
> > +static unsigned int riscv_iommu_queue_send(struct riscv_iommu_queue *q=
ueue,
> > +                                        void *entry, size_t entry_size=
)
> > +{
> > +     unsigned int prod;
> > +     unsigned int head;
> > +     unsigned int tail;
> > +     unsigned long flags;
> > +
> > +     /* Do not preempt submission flow. */
> > +     local_irq_save(flags);
> > +
> > +     /* 1. Allocate some space in the queue */
> > +     prod =3D atomic_inc_return(&queue->prod) - 1;
> > +     head =3D atomic_read(&queue->head);
> > +
> > +     /* 2. Wait for space availability. */
> > +     if ((prod - head) > queue->mask) {
> > +             if (readx_poll_timeout(atomic_read, &queue->head,
> > +                                    head, (prod - head) < queue->mask,
> > +                                    0, RISCV_IOMMU_QUEUE_TIMEOUT))
> > +                     goto err_busy;
> > +     } else if ((prod - head) =3D=3D queue->mask) {
> > +             const unsigned int last =3D Q_ITEM(queue, head);
> > +
> > +             if (riscv_iommu_readl_timeout(queue->iommu, Q_HEAD(queue)=
, head,
> > +                                           !(head & ~queue->mask) && h=
ead !=3D last,
> > +                                           0, RISCV_IOMMU_QUEUE_TIMEOU=
T))
> > +                     goto err_busy;
> > +             atomic_add((head - last) & queue->mask, &queue->head);
> > +     }
> > +
> > +     /* 3. Store entry in the ring buffer. */
> > +     memcpy(queue->base + Q_ITEM(queue, prod) * entry_size, entry, ent=
ry_size);
> > +
> > +     /* 4. Wait for all previous entries to be ready */
> > +     if (readx_poll_timeout(atomic_read, &queue->tail, tail, prod =3D=
=3D tail,
> > +                            0, RISCV_IOMMU_QUEUE_TIMEOUT))
> > +             goto err_busy;
> > +
> > +     /* 5. Complete submission and restore local interrupts */
> > +     dma_wmb();
> > +     riscv_iommu_writel(queue->iommu, Q_TAIL(queue), Q_ITEM(queue, pro=
d + 1));
>
> Please explain why a dma_wmb() is sufficient to order the memcpy() stores
> before the tail update.
>

Thanks, comment added in v10

> > +     atomic_inc(&queue->tail);
>
> I think this can be reordered before the relaxed MMIO write to tail,
> causing other CPUs to exit their polling early.
>

Very valid point, thank you! Should be fixed in v10

Best,
- Tomasz

> Will

