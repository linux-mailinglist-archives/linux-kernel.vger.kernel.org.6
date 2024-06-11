Return-Path: <linux-kernel+bounces-209167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DE902E2C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8111F23021
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAEAB673;
	Tue, 11 Jun 2024 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="lHUN7OiI"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31175661
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071247; cv=none; b=BEev54P/epFt1aqzLZK36I6uvByXFjPLnJeN2QfyKLSgxmnxaE1dnqWNmewFnb+mpNqZ7Fo2JguhotgS5/fkTEmwRmEXXCglAxRvFP6paKT3d7Fn6SrDW6LX6wkqVQjER41mp52nJ/TNaofOlKPB10p04kKgrnk13S0fcQ10ovs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071247; c=relaxed/simple;
	bh=+DSf+TQt/ykv0XritXEDrZm1XQB4nWMsT88cdtUciK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUFLWzH3ebfsyUFdyeyTiamISY/kA5U1swRqG13exKbZocU4zuwciXLxMclbzFYQ9PssyPkG+KjP/zMBngp8y8DCklh3fgyM8TxuLKjWV1nMqVRZaNhYwdQi8BeWCOIQ2QOfRkZFNIf3vB9mjkJZnAh8bchXSN9zKwwgqujdkUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=lHUN7OiI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c19bba897bso4161812a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1718071245; x=1718676045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DSf+TQt/ykv0XritXEDrZm1XQB4nWMsT88cdtUciK4=;
        b=lHUN7OiIIYLra2o+vI//EAgcxdKhKdA0sNjputGNmY0MWDVyftbRczZYO6Qgu9YA7r
         m+cwItEMs5vzR8QK4BpEgRtEGlnkPz4F2SsOsVsCi51OS7wD4C/kPjdb+ID+2FVgI3gv
         Y41LZaPxo8Hq4Asbwypc0IhX5X/IZiViy21IOtVGt4jeAtxQVgBWG+2mktUsVfUR5v8S
         oO1Ab9Hmqy3fSithVorbhaMw/whBzGqs8MM9IZBUfsgDZYEokCEP4jYDsWZy4pwhSPoe
         OTmKOAWhGlPAf8/IGxNAx1Xz4d6BG/PtQ3GNr5zP8CcBNTTc6nm5TeKFJXh9ystGvXmA
         7tQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718071245; x=1718676045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+DSf+TQt/ykv0XritXEDrZm1XQB4nWMsT88cdtUciK4=;
        b=vqSUJM3Q3AIvzH2PXlgFnaLeKgFNNamzJEaYb3W+ve96aMV62uW3S4J0DVV9Y0cD0V
         Ivi6YDXze6GP85daAtoGtT9aCWPol91FdlAoY5RFOrmGzy+WjmlvtpMepflzGXGVByhi
         GOCY1befGcHZmi+iln1fyqlJi767g8se7zbssaZiFfv7iB7vIsa7Tid4uDbgH0B6EZf/
         BGZ8XvdJYdtiy50Fi03oCxvnf8rvIaHCsBDnbZgB8Bb6Wze10q83V9/54zFFF3Cull4t
         ymjsrT3SIrFdvxuhbr1mTnWW7jKGFrWjjG30IEMZ3L7e7egwh0z6HbLWUH0PXZot/I0f
         Lyzw==
X-Forwarded-Encrypted: i=1; AJvYcCUG93kEYXx/yoZX9XnTPHfjzakPvXPi70ofHYEGG7APHPN0fg1i/4YZQQOQfTq5HeBXhYja39K0mr3LI2ULOJ7zSwNJhXBFWy99nf1R
X-Gm-Message-State: AOJu0Yxocoz4QcQUbp7A0/j4U3L5WAQDbdMrp97EYmpLWYcLDG89+Sbx
	c1jS8D9BXmz7ofPSj7hlubFClKEGki+56eaP90FqPQN4//M1eaqUe2vcaHPe8Jykqv6NiU3HEC1
	7XqFm5dwv09te6sYMudkKid7q0QrEmszSldnmxg==
X-Google-Smtp-Source: AGHT+IFaEf66/Vg3vZYbnuRls+xXc/YHx5d34274xkIrynnlPOHBe1Yws9C0iL9BtwTmDzbsneqNZTkOP1VlcYJjqz4=
X-Received: by 2002:a17:90a:12c2:b0:2c2:5341:7ed6 with SMTP id
 98e67ed59e1d1-2c2bcc5a26emr10217116a91.38.1718071245048; Mon, 10 Jun 2024
 19:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716578450.git.tjeznach@rivosinc.com> <e18ec8ac169ae7f76e9044c26d0768e6469bad19.1716578450.git.tjeznach@rivosinc.com>
 <CANXhq0p4gERQeROSCSKqxnRZq9-fGfmROGV8JZyqFaenNpnsLA@mail.gmail.com>
 <20240610174934.GM791043@ziepe.ca> <CAH2o1u4c6ttUWTb1zrc8DScDMuDJJYR-tTHCPYW_3FV4uuQDtA@mail.gmail.com>
 <20240610222051.GO791043@ziepe.ca>
In-Reply-To: <20240610222051.GO791043@ziepe.ca>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Mon, 10 Jun 2024 19:00:34 -0700
Message-ID: <CAH2o1u7X2zu42ZYA9wBe4bmCXN9v+d6j9vo5DMifJA3BUew91w@mail.gmail.com>
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

On Mon, Jun 10, 2024 at 3:20=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrot=
e:
>
> On Mon, Jun 10, 2024 at 11:48:23AM -0700, Tomasz Jeznach wrote:
> > > Right, this is why I asked about negative caching.
> > >
> > > The VMMs are a prime example of negative caching, in something like
> > > the SMMU implementation the VMM will cache the V=3D0 STE until they s=
ee
> > > an invalidation.
> > >
> > > Driving the VMM shadowing/caching entirely off of the standard
> > > invalidation mechanism is so much better than any other option.
> > >
> > > IMHO you should have the RISCV spec revised to allow negative caching
> > > in any invalidated data structure to permit the typical VMM design
> > > driven off of shadowing triggered by invalidation commands.
> > >
> > > Once the spec permits negative caching then the software would have t=
o
> > > invalidate after going V=3D0 -> V=3D1.
> > >
> > > Jason
> >
> > Allowing negative cacheing by the spec (e.g. for VMM use cases) and
> > documenting required invalidation sequences would definitely help
> > here.
>
> Yes, you probably should really do that.
>
> > I'm hesitating adding IODIR.INVAL that is not required by the
> > spec [1],
>
> If you expect to rapidly revise the spec then you should add it right
> now so that all SW implementations that exist are
> conforming. Otherwise you'll have compatability problems when you come
> to implement nesting.
>
> Obviously the VMM can't rely on a negative caching technique unless
> the spec says it can.
>
> > but this is something that can be controlled by a
> > capabilities/feature bit once added to the specification or based on
> > VID:DID of the emulated Risc-V IOMMU.
>
> I'm not sure it really can. Once you start shipping SW people will run
> it in a VM and the VMM will have to forever work without negative
> caching.
>
> My strong advice is to not expect the VMM trap random pages in guest
> memory, that is a huge mess to implement and will delay your VMM side.
>
> > Another option to consider for VMM is to utilize the WARL property of
> > DDTP, and provide fixed location of the single level DDTP, pointing to
> > MMIO region, where DDTE updates will result in vmm exit / fault
> > handler. This will likely not be as efficient as IODIR.INVAL issued
> > for any DDTE updates.
>
> I don't know what all those things mean, but if you mean to have the
> VMM supply faulting MMIO space that the VM is forced to put the DDTE
> table into, then that would be better. It is still quite abnormal from
> the VMM side..
>
> My strong advice is to fix this. It is trivial to add the negative
> caching language to the spec and will cause insignificant extra work
> in this driver.
>
> The gains on at least the ease of VMM implementation and architectural
> similarity to other arches are well worth the effort. Otherwise I fear
> it will be a struggle to get nesting support completed :(
>
> Jason
>

Thanks for the comments, it definitely makes sense.

We will revise the wording in the RISC-V IOMMU spec to note that
certain implementations may require invalidating commands to be issued
when making DDT entries valid, and device tree / ACPI may be used to
report such requirement.

For now, I'll change the implementation to assume negative caching for
DDTE and will follow up with device tree / driver updates to make the
invalidation optional when revised specifications will be available.

Best,
- Tomasz

> --
> You received this message because you are subscribed to the Google Groups=
 "linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux+unsubscribe@rivosinc.com.
> To view this discussion on the web visit https://groups.google.com/a/rivo=
sinc.com/d/msgid/linux/20240610222051.GO791043%40ziepe.ca.
> For more options, visit https://groups.google.com/a/rivosinc.com/d/optout=
.

