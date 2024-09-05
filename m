Return-Path: <linux-kernel+bounces-316979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D41396D7D4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F92843DB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA70E19A28F;
	Thu,  5 Sep 2024 12:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKATcCSX"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90692185956
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537769; cv=none; b=FfKhDzfoN1u7XVddISKvx3tF+kovsOVVhbBrmsSblVY4TzRGaFfPL13isFzHdTKjM6J+BADAXS2mp7ZQh77EuFhzm2sn5Tc7+KAZg/eH/+7S3AjHOISeVrzS4Eg1PFMs4ax8K05PiKsGJES5sNeuJXgYSey6kx2aA9l2E3Kj4bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537769; c=relaxed/simple;
	bh=FdZ0jvcTm6qdRghVa6/rDEbrOM7BcTY2Fkhih/+By5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiwE13DI3y1sfu3tFGRoKKRSeKmOVWXClyqD4lD3Uv6j0G6XVFjz1behjWVVSKtVYOvD2g2Rte7xhcV3/aITQdaNPv1d+ru3c3F0v7KsdhPQY6Uj+Z8tg7em0bI6/r+BnGlMprvzQUCTPhW78czyLGVAwpbU+c5M1ECRtz/BRak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKATcCSX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f3f163e379so12665751fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725537766; x=1726142566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owg9PN0820vhtvJ0PetsJXvFAPnMfxkZt3lB+CdO01o=;
        b=eKATcCSXiVWtWFrRoaZ6mHF+leTV+omSrJgwEICtXO/h6xzp9Y09/OSCCS7SLFXQeb
         NhshVjaV4dfIIb0/Xw2ZbXnCZDw80jI67zhHPeOWRT+TbgOa6oZXLpfJK+kY74lQZjDL
         7UZ8K4PqiGH6PYaLrq4mOTr2HMyVzAmaUNbFuItS1Ez9H9s421+v5RzCFzMSG7Cs5zzC
         lgELn19deXSxn3puV8yGliWHCL3EkGwK4A/7Is5TNHnAFU8xBmzV9QjTOMezRZM7NJsb
         Uf2RWuXxkYNVaGYMmhCDzOVcda3QBxw3tKUiRQo+C2nR7H3ktP/0MEwsjj4l+SFrE22b
         5hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725537766; x=1726142566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Owg9PN0820vhtvJ0PetsJXvFAPnMfxkZt3lB+CdO01o=;
        b=gvCnuKuFKIDZVT0DNOorRyvkLg2QxVfeSiwlpHDQRpeyUiod9IAXG4hzepvBjhihGP
         rkVYAl/v3iIjGBT2Zyec1aQ0TPcDf6rgvoHagkGeRWXbyK/mf3XImA05TmgHHfoF4qFd
         3D6ZJMp+kyADxhMdxNr0hQpzXi8XIeWaPrh5vaazHYiunA8UqDwAANxuw3uOdeBiliiu
         9uYwyDIsUwUwXJIoKPc2yNAJha0F7VqeITb7yGurRAwjeQJCTJHlPD7bJYxQbzAtfKxU
         wRGmgRbuk8iXB21aUcJij8tukX8b7V1hFMCX+F2u5LLNF3okJy3wJiYZXpIOvSHUZbIB
         yhJA==
X-Forwarded-Encrypted: i=1; AJvYcCXWZdA8XZuZH0aK0KtE15rpFFHm5tAcjkLoTI7MSB/SuXnkjTlvuFmtAcmBw4rVwvyst4SigOe2Az6Rir0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMZClvooT1Y7OjuF5ljsrbM858NUnPs+KXmvOHKbYdf6FGt06
	F8PwWWzqpIxlLlChsRs9cj4u+Mp7yfRedXiUb7Xfxq3qsp1PgPNz6pjyP+4P9ELpdOR36ieu1MT
	D8xnqGokTeIKeEDa4t+unn8Y1Cak=
X-Google-Smtp-Source: AGHT+IHgD4OUiyVVqxS4KDXz5elURqmJviRH2SJ6gh52cTLpIUJDTqqUL1SWQy4LxDBNIcW5+S+NVP0/ZwTjDgEFDQY=
X-Received: by 2002:a05:651c:220e:b0:2f3:e2fd:aae0 with SMTP id
 38308e7fff4ca-2f6105c4b9cmr230298991fa.6.1725537764712; Thu, 05 Sep 2024
 05:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
In-Reply-To: <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Sep 2024 14:02:33 +0200
Message-ID: <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	WANG Xuerui <kernel@xen0n.name>, Xi Ruoyao <xry111@xry111.site>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 1:47=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org> =
wrote:
>
> Hi, Uros,
>
> On Thu, Sep 5, 2024 at 2:54=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wr=
ote:
> >
> > _percpu_read() and _percpu_write() macros call __percpu_read()
> > and __percpu_write() static inline functions that result in a single
> > assembly instruction. Percpu infrastructure expects its leaf
> > definitions to encode the size of their percpu variable, so the patch
> > merges asm clauses from the static inline function into the
> > corresponding leaf macros.
> >
> > The secondary effect of this change is to avoid explicit __percpu
> > function arguments. Currently, __percpu macro is defined in
> > include/linux/compiler_types.h, but with proposed patch [1],
> > __percpu definition will need macros from include/asm-generic/percpu.h,
> > creating forward dependency loop.
> >
> > The proposed solution is the same as x86 architecture uses.

> > +#define _percpu_read(size, _pcp)                                      =
 \
> > +({                                                                    =
 \
> > +       unsigned long __pcp_ret;                                       =
 \
> > +                                                                      =
 \
> > +       __asm__ __volatile__(                                          =
 \
> > +               __pcpu_op_##size("ldx") "%[ret], $r21, %[ptr]   \n"    =
 \
> > +               : [ret] "=3D&r"(__pcp_ret)                             =
   \
> > +               : [ptr] "r"(&(_pcp))                                   =
 \
> > +               : "memory");                                           =
 \
> > +       (typeof(_pcp))__pcp_ret;                                       =
 \
> > +})
> > +
> > +#define __pcpu_cast_1(val)     (((unsigned long) val) & 0xff)
> If the input value is less than 0xff, then "& 0xff" is meaningless, if
> the input value is more than 0xff, this conversion still cannot give a
> correct result for the caller. So I think for all sizes it is enough
> to just use "((unsigned long) val)".

This part is used to force unsigned extension, otherwise the compiler
will use sign-extension of the possibly signed variable.

Uros.

