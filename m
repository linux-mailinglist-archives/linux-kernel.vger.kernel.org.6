Return-Path: <linux-kernel+bounces-364028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DEA99CA19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67133283CF4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1061A071C;
	Mon, 14 Oct 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZF/Zi0XD"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDE98F64
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908969; cv=none; b=WhM1a6bO31jjtDYdAOZNMf9Svpj2xmr044oJNp5M83o245WybBK/KaZ6HzDGZIq2akHNHOj+17F5MB0CQ3sh1/cXhVD8gTPYTYh60tTy00PlQgITiue+NvrrUxb7z71UBTRlYLB5QBaCAthw4ovPfnu/zmXfQyJzp+q9Ay7pQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908969; c=relaxed/simple;
	bh=4r71UHV8kVFGGnENUKb5J9J81MjyUqvzqmiNZoXIQj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfyRZ0RycpeIClrIh/lYi1qAa6bZtI4nw3r96gBD5H3qB1XOiroRjVB3emicR0IHNN+ycoh6/afoupvqhOzBtq+4NChtxaN5HKGD6qd6HMGfO9AgdUqLJZzTR99YJ3123eaFV61V9yOpOe/fmBd2JZoxugKqNbDSGR0bAPsETRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZF/Zi0XD; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e5b5715607so2145974eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728908967; x=1729513767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obYwGkvze5brDSPVKwCxBn24HUjtTBUUJpgF04yDya0=;
        b=ZF/Zi0XDS71zc7KG8Nf5IlePwoRVnUutJWkC8ie7UKaET+C+3QGMgnOef7W9mPePHo
         kBku+f9LVsbE5ucpLJcoDXExNLsJ5/5Agj0fT4p6Ybdb/Uu+dC9Aa2qig2z6w0P8Jayi
         hVKrN2dql7yy/wFa+kR4k+Tqhc+JYKSaqROizXHxuwk/PLeRWz4JmBaC+apZ5zVYX408
         TDpvCwD2crb4UEsFwaTFFpUmi3I2zoPvBIdUlQRX3wAfAe1Gx1K3fO+MqsCAl0qYsYoo
         QBZC4pi8G3DGIhkHXWJV5mf+UJlBiFF6EW7Q6iPPeFGsEjSJZccj7WonprflLfCZpJFj
         tdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728908967; x=1729513767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=obYwGkvze5brDSPVKwCxBn24HUjtTBUUJpgF04yDya0=;
        b=mQgq1bjiD/q2Y08/+qn9XH7xX+8qdPuou9QMkDrgkImWzDqBYLmjljmJCA0FkOCc8x
         HI2BiVD1BWJ+V+YybaOR35rqsgjErQMnTD51EZTB2ISu6NxI0UYYF3HhtrMK9Yf0kKYb
         8xYJ5hfUTkfZ503AMyy5XzbnM+5rJjhYc/8ZqvkTDULIvScPSYSbDjodIKyQqRFnVoZr
         AlHwIMS1agWiT4ShgDErXpkgYt0K9M9L6teisyEHHIsaSfzKm+fQpZWYFdIhLNMQIoI5
         T45VzRHQWqBjOUQncf07DKLt6iyN6ENPGNd56uxVn37iM7Tu5sofm32r40zhj8iZuY6w
         FlCA==
X-Forwarded-Encrypted: i=1; AJvYcCUZtmZ33R50Cdmptw9mUWN26EoNiALon+ORUo34R0ISl+gJSlDJs7tLZN5q3sQpEDq7Gs/iDRgegHHYzJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuquHgT7HJ/I/xdqmMpioRtpXsI91ORiAUIzj2v7DAxJUPhM4
	lxSEnfNbMJHX35wPgPtnwzVDzLTowyvxi4CX9wMWw0L3ooOTsAWjEsQrb6UUXmuIujmXWqQSdba
	5KIcXfHmuTdjYR9juiHeHE8ZCmxeB9hn0lxXL6g==
X-Google-Smtp-Source: AGHT+IGquwzzJq3TSHzHDk59BGV7hfB4VOx7ysqUP6B9j2bTJgjryU0p6MgswYU9kQMvvdQq5iI60yybmFuLgD4vqBo=
X-Received: by 2002:a05:6820:1ac6:b0:5d6:ab0:b9a6 with SMTP id
 006d021491bc7-5eb18d8d9eamr5308659eaf.4.1728908966736; Mon, 14 Oct 2024
 05:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094705.71775-1-cuiyunhui@bytedance.com> <Zw0B6_k7ejVtBTRC@sunil-laptop>
In-Reply-To: <Zw0B6_k7ejVtBTRC@sunil-laptop>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 14 Oct 2024 20:29:15 +0800
Message-ID: <CAEEQ3wnZaTnUDgKr3tTmD0q=G118u4RReiShNAfxScxiOcKqmg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, ajones@ventanamicro.com, alexghiti@rivosinc.com, 
	jeeheng.sia@starfivetech.com, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sunil,

On Mon, Oct 14, 2024 at 7:35=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> Hi Yunhui,
> On Mon, Oct 14, 2024 at 05:47:05PM +0800, Yunhui Cui wrote:
> > When SVPBMT is enabled, __acpi_map_table() will directly access the
> > data in DDR through the IO attribute, rather than through hardware
> > cache consistency, resulting in incorrect data in the obtained ACPI
> > table.
> >
> > The log: ACPI: [ACPI:0x18] Invalid zero length.
> >
> > We do not assume whether the bootloader flushes or not. We should
> > access in a cacheable way instead of maintaining cache consistency
> > by software.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/kernel/acpi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
> > index 6e0d333f57e5..3177c9af8764 100644
> > --- a/arch/riscv/kernel/acpi.c
> > +++ b/arch/riscv/kernel/acpi.c
> > @@ -210,7 +210,7 @@ void __init __iomem *__acpi_map_table(unsigned long=
 phys, unsigned long size)
> >       if (!size)
> >               return NULL;
> >
> > -     return early_ioremap(phys, size);
> > +     return early_memremap(phys, size);
> >  }
> >
> I think __acpi_unmap_table() also needs similar change. You might need
> to typecast to suppress the sparse error [1] then.

OK. I will make the changes in v2. Regarding the sparse error, I will
use another patch specifically to solve it. Is that okay?

>
> [1] - https://lore.kernel.org/oe-kbuild-all/202305201427.I7QhPjNW-lkp@int=
el.com/#r
>
> Thanks,
> Sunil

Thanks,
Yunhui

