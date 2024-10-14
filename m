Return-Path: <linux-kernel+bounces-364031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE499CA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7721F23515
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEBC1A4F15;
	Mon, 14 Oct 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PI6vn7Z2"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244201A4E78
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909060; cv=none; b=pL7K3EpnVLcosdEgo3gJI436reJLvqbM1Kq85hdhi6jh2FloTI+K9UGET/FkseUZSgG+eeVXX5g46w5m/MHevZZJUsHNX1taGx9N4CYtw9svrFUoYuFTKGzHDKYsIWih1Myl46O7MN/8yb0s7Z7EzzMFlktKHc4d9LDYjfoH59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909060; c=relaxed/simple;
	bh=NdF/5r0agiNUSk0MNGtvhS9SAxDitoqJk2Nx3MyBmuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljT2S0ZCkjzQcOmMXoIz98QmA/Er18C/SEIkVjwnQ+8FhTKZDUJwq4ddmhweBJdFLsf7ypUfl47N3WHBq6zogBpPwzUlF0KjE6Gvbx/Pm627mCxZ/8wc8Ua5irG3uD+dvJSAEEQXcRcvZY0rs/Gqm3+0Am7qVH+5lhquCzCWcxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PI6vn7Z2; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5e9876999a9so2055342eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728909057; x=1729513857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CGFfT/mM9dZiLWl4lLHcQIHCYREyp/vrqKgD4lxV88=;
        b=PI6vn7Z2qOQXI34JkyXi/yX7hU4NKo0K4qT5pHJvO+tQ5ixzgu0YTROm6b+mG7peOw
         39Ec85CmsZRgcMGs6WMoIPdYtLHw33XOUrkWyobrE8xygg02++C3QG1ElwNWOXvanhfi
         jdEeGxTzExg1R+y7WVRjNMyxp68NdTv8QHPDtMaUNQ+ZP58I2o9LeU7gbEswaj5b2wNs
         XP+ck0MUZlB8wSIfyzv6/m3xksM/C2ky1gMfUzizxLcEbOkqysGoHjctf1piaWFNKIK7
         GFb90+MCHloxnUzRvRr0VWu4KV7RGRZnQB6RD6IcTdd9YK7tWZEa0FRloSK1hrcqvdeg
         owJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728909057; x=1729513857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CGFfT/mM9dZiLWl4lLHcQIHCYREyp/vrqKgD4lxV88=;
        b=QiYETrIimnRN7lN6Q6pitkWP9HbPtxzwvQvnSHPEaaiZ13n3LlfO6dhOwRYSyPewnQ
         QPFuSnxTRFyQKctYAG8NKzgZyuMXi3X45wyFrRi3Bu2TnJsyR+MBwwOSpXuw99RHXAuL
         vFKi9GhJwHLsJ2rkZsOKXEh5BmaZkmxRfBpTSI29JVXUhIDP17weybNaBSAv899jvXI6
         Q8nZhEKXdhzhhOf02EhEWCzpneZHwk6a+os0V4e4rk9ocCzR2NS6N7UBdZg+E9lZMtId
         60MpGkQiWPlDH1azPnyCWaG2kmEWrDcm12+ftewEOxV+mNQNA5nGBqZJpQYcrl8543RZ
         um2w==
X-Forwarded-Encrypted: i=1; AJvYcCW8lZRMcVzzM7/KyxX3asVjS+eGkhbdjPr9nIBE5mRlS0inVb8BqBXXZ4wBjhI7T0tcJBq+qfu8WpZQyII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJcIyMaCOb8eSE5H4snLthEpxRCZGt4RhhnUb4yvkCEUF6WuLZ
	H5Ewl/Zqq4wZ0GCpOEA5W1lO6/Ph1mIaxvT0Bc+oRcvmIx3f2XsGFWfMZ26YO1yCcZPadKQzUJG
	USnvu3nsX86wG9vlkf3Iw5MxqAX+j3CiCJxbvFg==
X-Google-Smtp-Source: AGHT+IHtPh/Wy5LDyoZaAbVy1b9YjnnlqFTXd+qK8W+k5kyPdk/Ov9fQAgwC+yPEyuQlptCVmmm4ihtg5TWIt6z6GFk=
X-Received: by 2002:a05:6820:22a1:b0:5e1:ba38:86e7 with SMTP id
 006d021491bc7-5eb1a1b39ebmr4116768eaf.5.1728909057240; Mon, 14 Oct 2024
 05:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014094705.71775-1-cuiyunhui@bytedance.com> <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr>
In-Reply-To: <d39e4832-50f3-4fc8-ba95-a2d6eefa5abe@ghiti.fr>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 14 Oct 2024 20:30:46 +0800
Message-ID: <CAEEQ3wk6K52RdCat+L91KvfNVkxbj1-3zxjubkn9xy89wK_-bA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: ACPI: fix early_ioremap to early_memremap
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: punit.agrawal@bytedance.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, sunilvl@ventanamicro.com, ajones@ventanamicro.com, 
	alexghiti@rivosinc.com, jeeheng.sia@starfivetech.com, haibo1.xu@intel.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Mon, Oct 14, 2024 at 8:12=E2=80=AFPM Alexandre Ghiti <alex@ghiti.fr> wro=
te:
>
> Hi Yunhui,
>
> On 14/10/2024 11:47, Yunhui Cui wrote:
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
> >   arch/riscv/kernel/acpi.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
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
> >   }
> >
> >   void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
>
>
> It makes sense to me since with this, we don't have to care about how
> the firmware mapped the table. And it mimics all other architectures
> (arm64, loongarch and x86).
>
> Here is the corresponding fixes tag:
>
> Fixes: 3b426d4b5b14 ("RISC-V: ACPI : Fix for usage of pointers in
> different address space")
>
> With the corresponding fix in __acpi_unmap_table() as pointed by Sunil,
> you can add:
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>
> And regarding the sparse error, I don't see any other architecture
> casting to __iomem, so maybe that's not necessary anymore?

OK. I will make the changes in v2. Regarding the sparse error, I will
use another patch specifically to solve it. Is that okay?

>
> Thanks,
>
> Alex
>
>

Thanks,
Yunhui

