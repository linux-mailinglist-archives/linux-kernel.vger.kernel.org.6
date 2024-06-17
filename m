Return-Path: <linux-kernel+bounces-217342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC4D90AE87
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA02F1C2402B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F142B198A2A;
	Mon, 17 Jun 2024 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RuHcGjA8"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BED9197A7E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718629212; cv=none; b=aBfuRRGpUe/ImHWuD86NGUkTuCDr+ej/DlEffVj4pyBNdGdPg9Aw8nbjkbK4gqJguRePR4I560pJ1VQdheqJLhbeMaKn5BmLrsKkBg+W/vDXHv5eZmLNanotBFh1UdNb5wnNl0b5EmaLPNdzVjzCfMgkYoqzLU0os+nBxmfNP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718629212; c=relaxed/simple;
	bh=h+3wKgmRX4zJZb2H8gWBKRoeMkJ/WRPwq29c2VXU9Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr8+YaJWJY7gow3N4Fyygqt1rdzzF8vyKhV2yw2Ex+AnkM109/76VDMy7Odw7BEuyHD/aTDpqIPmux4g7ssfINrkFhBDTPsQpsaXLUnuY3O3+Na9lwJbsISZfikJPRl0rMgl9q31xebXW4Fv8UwEaHvQwJS5CA2mWr0iSmJalqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RuHcGjA8; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f8d0a1e500so3233440a34.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718629208; x=1719234008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46zSmqD3K+3c/eVUF/duMfr7ptrzqcpK4Q9s/Mtw+rI=;
        b=RuHcGjA8TFzzdjDEkzLIMO7XssqnRmxLoXYasC4qLH7UzwwI9rsZuVlQEsp9BsUps9
         OEyp1MeWHzcmCT9p6m/rIWB8/eIjYRBx88zN5f41HFXoAj+o7YxdcjwQfKMximvYYZE0
         k7ezwQuDuFQXuBy6ar5gZWh4iEJglyfqURJLuWlXvmxlwWzkgli4c5kJhY4UGfuPtHix
         nAgUV7niBCnpJKtS5WGnPgHMMymIDv11wiRkkTwPwpVSpcZ+MrGCItecoCKzKS8TLFov
         F3CcgNS2C57ruhhsJp+I7uEuK4Yd3Sc2Y8Ktdz9pxVVnds9xB00jPv/G716aaP6r2fTX
         4nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718629208; x=1719234008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46zSmqD3K+3c/eVUF/duMfr7ptrzqcpK4Q9s/Mtw+rI=;
        b=MENa1sluDYP5OVB3L62sGGUD8g3ZN/R6vQwfb+Jg0+UJ4sjjQo5bBoErGYUu0zO88+
         o49x7PTa7NhGFOnMKUl8h4aZuHeQM+g31E0r8ltECJooJ4Arebm+dZaLBcKjL0ytPgUE
         6KRHwDbKXL86TXJxPFVCz5D1qXXBaoTZ3iA8diq3QTtEtMOx0Z8wamXj+7svSJ1rFlhK
         U9L8tzteq2RT9A8qcPBUEMfRR7aWqi/TF0gH/CXWqUIbFXnDflqMydz44O0hHgyY1g+R
         3D5EvDdasB57rOWCbuaePoxpgHL7C6UCHGIeR4M18hP3RK1jVmnSP0JOL8477FELxPPm
         KyWg==
X-Forwarded-Encrypted: i=1; AJvYcCWZZ+POyMBeDiHlXj/lChLBJdm3on7v0yZXRNchSosUUJShGhqY3dGXS2ieMjuXu/DmLi4xSP7NRuCOAvorBHfkgAI0RGnTibizDUdP
X-Gm-Message-State: AOJu0Yxqpw4wQ28tjCSHaLlIYAFkOQQo1xqLmdrNlNpttkS7hYXF6vgI
	T9zn4+ORrJD9Yb1QrdecxMVUWfqB7L7HIq2rr2rb6yzNTjQCbnjSr4sJbyRLLQPT0foEFG5+B2n
	z6cIAUYzPOHAAUTMh0l50AXNmp12EvpJNw+X+rg==
X-Google-Smtp-Source: AGHT+IHsNyUY/qarXvooq9ynIKp95jpjsz6YkpPDRb/NSBM/IJmvJSy6eAGghbyK8AYhLF+R8aQIRjyQLfKHpRcsUbs=
X-Received: by 2002:a05:6870:718a:b0:24f:dad3:97c with SMTP id
 586e51a60fabf-25842b1e8e7mr10850521fac.46.1718629208466; Mon, 17 Jun 2024
 06:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240523111322.19243-1-cuiyunhui@bytedance.com>
 <20240523111322.19243-3-cuiyunhui@bytedance.com> <CAEEQ3wnE+8FXXf76zapqNnC5vruoR9C-y0qjjFw47cHYP57MmQ@mail.gmail.com>
 <CAEEQ3w==wueTSDvEtJe+t7jamH2ERxta4uPLUFVwX2ueRLJ3Bw@mail.gmail.com> <ZmLohXMgGrIvL7s7@sunil-laptop>
In-Reply-To: <ZmLohXMgGrIvL7s7@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 17 Jun 2024 20:59:57 +0800
Message-ID: <CAEEQ3wkCkvNMd5QKcZkvxygoJ2HK+g=cQqag0re+HkE9R2Y4sA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH RESEND v5 3/3] RISC-V: Select ACPI PPTT drivers
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com, 
	james.morse@arm.com, jeremy.linton@arm.com, Jonathan.Cameron@huawei.com, 
	pierre.gondois@arm.com, sudeep.holla@arm.com, tiantao6@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Fri, Jun 7, 2024 at 7:01=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com>=
 wrote:
>
> Hi Yunhui,
>
> On Fri, Jun 07, 2024 at 04:44:36PM +0800, yunhui cui wrote:
> > Hi Sunilvl,
> >
> >
> > On Mon, May 27, 2024 at 8:51=E2=80=AFPM yunhui cui <cuiyunhui@bytedance=
.com> wrote:
> > >
> > > Hi Palmer,
> > >
> > > Gentle ping ...
> > >
> > > On Thu, May 23, 2024 at 7:13=E2=80=AFPM Yunhui Cui <cuiyunhui@bytedan=
ce.com> wrote:
> > > >
> > > > After adding ACPI support to populate_cache_leaves(), RISC-V can bu=
ild
> > > > cacheinfo through the ACPI PPTT table, thus enabling the ACPI_PPTT
> > > > configuration.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>
> > > > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > ---
> > > >  arch/riscv/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index f961449ca077..a9ebecd72052 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -14,6 +14,7 @@ config RISCV
> > > >         def_bool y
> > > >         select ACPI_GENERIC_GSI if ACPI
> > > >         select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> > > > +       select ACPI_PPTT if ACPI
> NIT: I would add this prior to ACPI_REDUCED_HARDWARE_ONLY.

Okay, I will update it on v6.

>
> > > >         select ARCH_DMA_DEFAULT_COHERENT
> > > >         select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MI=
GRATION
> > > >         select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
> > > > --
> > > > 2.20.1
> > > >
> > >
> > > Thanks,
> > > Yunhui
> >
> > Could you please review or ack this patchset again? Palmer did not resp=
ond.
> >
> > Link:
> > https://lore.kernel.org/linux-riscv/20240523111322.19243-3-cuiyunhui@by=
tedance.com/T/
> >
> My bad, I was under the impression that I had Acked already. The series
> looks good to me except the nit above.
>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
>
> Thanks,
> Sunil

Thanks,
Yunhui

