Return-Path: <linux-kernel+bounces-208765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6932A9028E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19EB8284CB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DE12F397;
	Mon, 10 Jun 2024 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yZzLfl6/"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B7E156E4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718045318; cv=none; b=Sro/Ir2lHmCkxI+tuNsLcnvbbuyD6mjjlFQf/zCxit3o20YDi7uyzkMpEF/44Qou/uuZYoYTO05atpTzjKmLnN5jCShrdri57rMz/gq40Gk/fW4yvRnO5UQf5vWk0m7kWOuh5jUB/yqOd4ts4J3f55psJjGFUAywDq0VBr0m2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718045318; c=relaxed/simple;
	bh=uwH3l4n/N5erM0poSH/fMhqelMaa5SHGi2i3looQLt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qHMa2awi4Wi5edUlfKQic1WXkudKyenk7j8NPOAZpL6B2LbFIoR8Hq0V9OcuFPXEPewbZ+D/lHmgW8O0yZZRQRSHTGiLlqBTEo6A9FZB1qyP3cKvMCL6nYZRR383ehKQ/U5v1r7Gh96oQn2xWmQTtSPUVVfvFFe1jxWRNI5+Ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yZzLfl6/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c315b569c8so257573a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718045315; x=1718650115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1zkxMfHh2XP11CPVX//08KVDgqqC8nwRqfn9/6C548=;
        b=yZzLfl6/y+qfEX8AxiFpbnQ3ZbGhBNnsS+aeCwI80kJK6ByXjehqZ7FwpKfVv7vk/t
         1EDrBGbJU4yWaD4kKANKXwEZI+mfCT06FSobPOy5GGq/477k8b5wyxh8ZTApu6fLVDNj
         D8Z6p6Oms+LcREij126JxVlITvr+8BJN2sDYuwDKpZTIyA3NuqwCDKJMj2WcWs+pqCwP
         3fWKGS4s8POjvnsqC8VwA3URsd+3Su8wsxfggXgXzX1WWLkdvUvnhjJMOs8Y8QogKuin
         04ZqmYjRu0soQ7Bbi8Rq04rF0M5pMxx/PJJ2lUIKPTws16Ybr9091w5ZQkiO8CzJWwTF
         sJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718045315; x=1718650115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1zkxMfHh2XP11CPVX//08KVDgqqC8nwRqfn9/6C548=;
        b=Mp0UEW45tfeFDmDudlko1HxIMbBNF+Efhld71TQM+OnOOaebXzhLU+xGqz/Y5GUEEm
         5XINMSvrHHEYbHRqcbqarVW+bHz3O8N5Qb1LWZbEuVONT0nQaixtaUqH75h1GN4ggmFq
         ANY5e8ox5srazv+A6XVgCCK9MY1v69tQPKKrnq3MZcubTnTjTPlXdx96/bj32wb9ZACF
         4KFiKxEy4KQ20lIXG94OmDPuXd8z5Wj0sTPlkixLMw8OSX0N7EJ2tilrhuNDTrItQjBQ
         lLqq42NJGh/TxfU1mCgQu3okQ0lgNG7bjY0ShWFeaWhYd1jEsdTZQdiDbEW1TIxgcCU4
         sxzA==
X-Forwarded-Encrypted: i=1; AJvYcCWq/glTr0xZmdYOvSwZjJdRkoPqLiAJdve9jHy9kp67gqJOBjMJiQJTdRH5/3JdLAMGHI5gIrhl9e+ivsLzershRPZWShLgkMQHz+eg
X-Gm-Message-State: AOJu0YwUsolI+f0YgGzL/pM1G15SwEi/BSJ5/LVmRuKHkbgwhI9CUWeZ
	Uitco54NnJJ+BL6nCDYy+na75vad8w6qlsn2u0EVbB6UNvlDAkS0BPz1HeZz98/ThzO7wywKHn2
	FUSUrQdKqjPQNX5Wq7cfQlyOWLZWCAMv3BCqeYw==
X-Google-Smtp-Source: AGHT+IGBy6VZxEdF6cbSLt6ZlKOXJu423/i8aKL4dzbh+nLx8RnrXexnJssaOg3HPDyzDxqJnqu3KJgm5ET48MCaFWo=
X-Received: by 2002:a17:90a:fa01:b0:2c3:792:a649 with SMTP id
 98e67ed59e1d1-2c30792a75amr2976706a91.2.1718045315113; Mon, 10 Jun 2024
 11:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716578450.git.tjeznach@rivosinc.com> <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com> <20240610174934.GM791043@ziepe.ca>
In-Reply-To: <20240610174934.GM791043@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 10 Jun 2024 11:48:23 -0700
Message-ID: <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>
Subject: Re: [PATCH v6 5/7] iommu/riscv: Device directory management.
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zong Li <zong.li@sifive.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jim Shu <jim.shu@sifive.com>, 
	Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 10:49=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wro=
te:
>
> On Fri, May 31, 2024 at 02:25:15PM +0800, Zong Li wrote:
>
> > > +static void riscv_iommu_iodir_update(struct riscv_iommu_device *iomm=
u,
> > > +                                    struct device *dev, u64 fsc, u64=
 ta)
> > > +{
> > > +       struct iommu_fwspec *fwspec =3D dev_iommu_fwspec_get(dev);
> > > +       struct riscv_iommu_dc *dc;
> > > +       u64 tc;
> > > +       int i;
> > > +
> > > +       /* Device context invalidation ignored for now. */
> > > +
> > > +       /*
> > > +        * For device context with DC_TC_PDTV =3D 0, translation attr=
ibutes valid bit
> > > +        * is stored as DC_TC_V bit (both sharing the same location a=
t BIT(0)).
> > > +        */
> > > +       for (i =3D 0; i < fwspec->num_ids; i++) {
> > > +               dc =3D riscv_iommu_get_dc(iommu, fwspec->ids[i]);
> > > +               tc =3D READ_ONCE(dc->tc);
> > > +               tc |=3D ta & RISCV_IOMMU_DC_TC_V;
> > > +
> > > +               WRITE_ONCE(dc->fsc, fsc);
> > > +               WRITE_ONCE(dc->ta, ta & RISCV_IOMMU_PC_TA_PSCID);
> > > +               /* Update device context, write TC.V as the last step=
. */
> > > +               dma_wmb();
> > > +               WRITE_ONCE(dc->tc, tc);
> > > +       }
> >
> > Does it make sense to invalidate the DDTE after we update the DDTE in
> > memory? This behavior will affect the nested IOMMU mechanism. The VMM
> > has to catch the event of a DDTE update from the guest and then
> > eventually go into the host IOMMU driver to configure the IOMMU
> > hardware.
>
> Right, this is why I asked about negative caching.
>
> The VMMs are a prime example of negative caching, in something like
> the SMMU implementation the VMM will cache the V=3D0 STE until they see
> an invalidation.
>
> Driving the VMM shadowing/caching entirely off of the standard
> invalidation mechanism is so much better than any other option.
>
> IMHO you should have the RISCV spec revised to allow negative caching
> in any invalidated data structure to permit the typical VMM design
> driven off of shadowing triggered by invalidation commands.
>
> Once the spec permits negative caching then the software would have to
> invalidate after going V=3D0 -> V=3D1.
>
> Jason

Allowing negative cacheing by the spec (e.g. for VMM use cases) and
documenting required invalidation sequences would definitely help
here. I'm hesitating adding IODIR.INVAL that is not required by the
spec [1], but this is something that can be controlled by a
capabilities/feature bit once added to the specification or based on
VID:DID of the emulated Risc-V IOMMU.

Another option to consider for VMM is to utilize the WARL property of
DDTP, and provide fixed location of the single level DDTP, pointing to
MMIO region, where DDTE updates will result in vmm exit / fault
handler. This will likely not be as efficient as IODIR.INVAL issued
for any DDTE updates.

[1] https://github.com/riscv-non-isa/riscv-iommu/blob/main/src/iommu_data_s=
tructures.adoc#caching-in-memory-data-structures

- Tomasz

