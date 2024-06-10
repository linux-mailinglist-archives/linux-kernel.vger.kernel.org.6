Return-Path: <linux-kernel+bounces-208903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8E902A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24AB1C2173F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3B453373;
	Mon, 10 Jun 2024 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nU497WuI"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934C4D8BA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718053896; cv=none; b=oZXh6vPRFCwqa8J+E0zFACi99Kn1DJru2H2MVP4C9Pgxf9piM8WZwwmYes/utE07t0LbniuXs3YA+We6ThIEwVnkAgI8XzKuc8buDOx8HJSV5/vmxq8sWBVFEE/d2HDq9ewns3iVxrsTd8DAzYILBQ4fsspwehVO9tVzQOhUg7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718053896; c=relaxed/simple;
	bh=dHfq/Y8UJm8GbkHmEQXODyizeDi9XIeLkMTzcTcIpkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NTtJfykMejv+OIm9jwhXrP1Wm/+C+A44YbMRtFAukzn33T4AsNSQAFDHo/G1wP+IW2zMdLo25Z2WHrJqNnx+AIB+l0FA8Lgi0m4KntajWXRVpYTrU17Jo7EoX2otGATifSyVWg8BhIeWjSqpfkv8WTgChKge5BBeHdeL0oICnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nU497WuI; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6c4926bf9bbso259416a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 14:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718053894; x=1718658694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=atjVVvhqJGVBGQeQC15VPPq3ZmuONR7VOIjSThozUfs=;
        b=nU497WuIcZ71I1UJ0FearPWvRCfOLd13aaggzt4XOOvyJ5cTehWu4Qa9wtrXYY2aQx
         1MdxWelzbZFd2ZIKA6wfUN4CALtYwjl3ExKevPFTduU0in61Q2n+dwNtBRi1GD8Swdrn
         l/LKu+Kxvr+WMOHP0Y9RrXhjuAXK417G4qW/Y+FtnaWKEmveS6ML0Cfw0QPkjEYiAQv9
         la0jRJXlHVqbDAdaBZ5bPoVAfOOcmdLHqWhwj0UzbOueke21IQU/eihAn/dlsSOSvndN
         vkzh7B/rmg9xng2PZdJMms1jiTLgT+ET7Zm/1BL4bFu+nq+NK07LtxDeOwCQCTAvyS6z
         vcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718053894; x=1718658694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=atjVVvhqJGVBGQeQC15VPPq3ZmuONR7VOIjSThozUfs=;
        b=Vxmbxsc0vuON9uUnLabO3IZ9yeKXmAjhWXUC+Vd1g82y8AaeNqivyfO9jNZTZNR6/P
         BhA97u/AYcx3yRLW4AeidVsG/oAxL4rfjYHpuGXu2qpwHR2WN0VQcJiTQcCDzskz9WbA
         DbPkjnoh8OJpBlw85EjNB+x0MR3XuhSlkEwgphN0fJhJZRb283mw1s/VUiIv7I2eXaWH
         EuuPyL85LCmj4saPIzUYQt575R0P1vVHP8mlcK+g24oFkQ+5TKGkwUii4UqM4F/txEpv
         V3mY+W7dWP/0yq/BjtvA35vFwiaZkHqCMfyzU9uhxswkR+pbX89qnulXa56yiHoA28Hb
         chEA==
X-Forwarded-Encrypted: i=1; AJvYcCXCqQSH8CW1ONO//SXuysaILf4srMEgN3sAv+EGMmxqgJvPxfeFaigPKiffdnTWjxwA3ptRLvmpXwKbL6tZ1GqtqHqLWuqWbtoxFZe7
X-Gm-Message-State: AOJu0Yxzu0akPTm/xZdmLCDizFAbj8Uml0+mdf4rLIANP2+0FLI1S+wi
	F99srV5JbilDCFUwZLqHujq0E3R91g6I6wFIwjMln8mVHm39sy8pPYYq2I2JFxd65TAYXMu7Y31
	BHV5dOWUkz9cZONUWxwzBHKPUKxTuMGKIU8nwEQ==
X-Google-Smtp-Source: AGHT+IGchpbaicHoHxCHYTOkBWbMZo1yhnrL8jazakPLDq3AVxHuApmXC5MJskUmy1m+m4dJ2ZJiSm2/UdJlr5SLmnI=
X-Received: by 2002:a17:90a:5785:b0:2c2:9591:342c with SMTP id
 98e67ed59e1d1-2c2bcac2c65mr9210122a91.3.1718053894451; Mon, 10 Jun 2024
 14:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1717612298.git.tjeznach@rivosinc.com> <422f66285da1b164466b223f83d7f06564968f09.1717612299.git.tjeznach@rivosinc.com>
 <20240610-3cd1ba07c1b488a451dd7ddd@orel>
In-Reply-To: <20240610-3cd1ba07c1b488a451dd7ddd@orel>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 10 Jun 2024 14:11:23 -0700
Message-ID: <CAH2o1u6Yav1i=EUX-a4XY4OLtU5RvshHU5ffGE99mgSTrqmN2w@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] iommu/riscv: Command and fault queue support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Nick Kossifidis <mick@ics.forth.gr>, Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 4:06=E2=80=AFAM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Wed, Jun 05, 2024 at 12:57:48PM GMT, Tomasz Jeznach wrote:
> ...
> > +static int riscv_iommu_queue_alloc(struct riscv_iommu_device *iommu,
> > +                                struct riscv_iommu_queue *queue,
> > +                                size_t entry_size)
> > +{
> > +     unsigned int logsz;
> > +     u64 qb, rb;
> > +
> > +     /*
> > +      * Use WARL base register property to discover maximum allowed
> > +      * number of entries and optional fixed IO address for queue loca=
tion.
> > +      */
> > +     riscv_iommu_writeq(iommu, queue->qbr, RISCV_IOMMU_QUEUE_LOG2SZ_FI=
ELD);
> > +     qb =3D riscv_iommu_readq(iommu, queue->qbr);
> > +
> > +     /*
> > +      * Calculate and verify hardware supported queue length, as repor=
ted
> > +      * by the field LOG2SZ, where max queue length is equal to 2^(LOG=
2SZ + 1).
> > +      * Update queue size based on hardware supported value.
> > +      */
> > +     logsz =3D ilog2(queue->mask);
> > +     if (logsz > FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb))
> > +             logsz =3D FIELD_GET(RISCV_IOMMU_QUEUE_LOG2SZ_FIELD, qb);
> > +
> > +     /*
> > +      * Use WARL base register property to discover an optional fixed =
IO
> > +      * address for queue ring buffer location. Otherwise allocate con=
tiguous
> > +      * system memory.
> > +      */
> > +     if (FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb)) {
> > +             const size_t queue_size =3D entry_size << (logsz + 1);
> > +
> > +             queue->phys =3D ppn_to_phys(FIELD_GET(RISCV_IOMMU_PPN_FIE=
LD, qb));
>
> Shouldn't this be something like
>
>   FIELD_GET(RISCV_IOMMU_PPN_FIELD, qb) << PAGE_SHIFT
>
> ppn_to_phys() assumes the ppn it's converting to be shifted up by 10, but
> FIELD_GET has shifted it down to zero.
>

Good catch. It should be pfn_to_phys(). Fixed & verified on IOMMU with
queue ring buffers in fixed memory location.

Thanks,
- Tomasz

> Thanks,
> drew

