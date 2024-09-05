Return-Path: <linux-kernel+bounces-317001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1CC96D81B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D69A1C22D40
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9A819AA56;
	Thu,  5 Sep 2024 12:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HR75CUyv"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1201993B2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538604; cv=none; b=HPb3bEgJUIat+QBtEVZW1ZJQkGZx1dGRgPdpklRlL11vaigvYMpBj5R5NkZuYWVuxmB03LIfVVm3yGAAEwpzFHUy8vta/IM5VNGVn2oecf/AcEbJZIlExsXH8uETm/rAtlBSEofFaRsI+bBcfXsF49RNonowXzBWsjLmJxBDR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538604; c=relaxed/simple;
	bh=KD8p4UhTHUqwQtVUz3/tFmO44HYAqdvhbKFkBoyuz64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCuT2xdZf+tnlcCx6Z+U4yJrplA0SDvliEqEIXwKXVkUFbjhmpyFCvhd/bK9/5PCktlx2JNl7v5zp39MNSVr7SfbZHCqW8Q/DpBve8izTXLZP5X5BGZ14Rzkf7yjwvFd0FJmVZJR3IBNIC1uQ8j4AA3WUbC6GY42kBzEEbsUjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HR75CUyv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f4f8742138so8159601fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538600; x=1726143400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UivlO5wUcpBoNAynGGCP4zi8/QvQcG9yj0l4MCKkP24=;
        b=HR75CUyvpIZgleISPpWdsK3mlNlXoUIFg3ooi+gSzv/lyjIwdIxzUqNxHaEwxCESel
         mZSJ1r8Sx4X7RxdOxT9C2xfV7LiFEzplG/1TzVMJbJ/03MBBA6uAw6pOB7Kqoqbuj7US
         Iw/v8qeCPspTzDITqnjCFAhjcu/bphDadRmZMzWJ53CRY/5AWoEztKpSaX9LGw0+orwS
         497/LfiDFQVf8vwfB5kFfbChRqSteHlqyxyLQa6hB1EIZWiJPHKOWU1BJChla/wrVyVK
         qdSFt6KefZWzKMC+rN46U2ctsNPxkMFnZejic3mJ+N9pGNAjBq1J62R5izVuf9vm+ZF3
         bf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538600; x=1726143400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UivlO5wUcpBoNAynGGCP4zi8/QvQcG9yj0l4MCKkP24=;
        b=dhwLNmGLvhfGM/u27ZRUJzYvcjnzYmcGCFO1hFJO0ExfdnL79uVYJfDJXIB7USCwQw
         xvqTWdc4xyqDFz6V6uuOSMFZVPJZi/rgyXkk4GbuLdgpScMybOFWdExjWzr0fHgsosI1
         eWTx7YReBRhFo37N2U4zvCy/JiUU6v71YQqWHdV/aZWqkkKI86tBqiJQn5nzG+mAiy9e
         I+J8WGONWh/9KpxZRWbOcReuNUQpttkv39n/STOa4WwBa5m8NrZwtoIIEisIZzV99Hsq
         EaPugV51gqcJWrALWXz3+U9xIWZlPvnU6SyqZeGQxysrcq5Cq7ojV6iwf07NItoknQFx
         tunQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXtN8hEyW/kraSA0jUnpuvue1082M1D22aHX3VtO60U3537TsiJzbOqkePVE2a20Hmjm4gl07PTmFBJzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSDYeoBmsuxSrvU7JZyhrVsufpu51FZX6FxCHVsO6Qh2fmS6+
	4GfCAiluaKqE06b4Ao348uM7SXIeIv4AfH0qNI3VMzOyASC93A7C7lnzQ9ZwS4lTEVM4DGnW1no
	xP1ls7rF47Uk6dKWzl9VIeykDQyQ=
X-Google-Smtp-Source: AGHT+IGqaLiRNSXFrvzb03GvKWEeiTccQCMt9QDXdoVUjj6YXV2fNmfC2Xep1qIcAudNF+zKdsrdA8Y1wNtOs5zjxHM=
X-Received: by 2002:a2e:5149:0:b0:2f6:5f7b:e5cf with SMTP id
 38308e7fff4ca-2f65f7be62emr26204141fa.14.1725538599354; Thu, 05 Sep 2024
 05:16:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065438.802898-1-ubizjak@gmail.com> <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
 <CAFULd4Z4QzS0J_BztD7jDSNwoXM2vF9PWNX5eJBrQZsUbu-gJQ@mail.gmail.com> <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site>
In-Reply-To: <361bf35ccf308d2fbce14f69f156cb42eef0f095.camel@xry111.site>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 5 Sep 2024 14:16:28 +0200
Message-ID: <CAFULd4ZqD2L=B5YfKjGR4s0mOM-fABb5+83Z5KfmX0YRaxWw-A@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and _percpu_write()
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:09=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> On Thu, 2024-09-05 at 14:02 +0200, Uros Bizjak wrote:
> > > If the input value is less than 0xff, then "& 0xff" is meaningless, i=
f
> > > the input value is more than 0xff, this conversion still cannot give =
a
> > > correct result for the caller. So I think for all sizes it is enough
> > > to just use "((unsigned long) val)".
> >
> > This part is used to force unsigned extension, otherwise the compiler
> > will use sign-extension of the possibly signed variable.
>
> It's not relevant.  For example when size is 2 __pcpu_op_##size("stx")
> is expanded to stx.h, and stx.h only stores the lower 16 bits of a
> register into MEM[r21 + ptr], the high bits are ignored anyway.
>
> Thus we can just have
>
> +#define _percpu_write(size, _pcp, _val)                                 =
       \
> +do {                                                                   \
> +       if (0) {                                                        \
> +               typeof(_pcp) pto_tmp__;                                 \
> +               pto_tmp__ =3D (_val);                                    =
 \
> +               (void)pto_tmp__;                                        \
> +       }                                                               \
> +       __asm__ __volatile__(                                           \
> +               __pcpu_op_##size("stx") "%[val], $r21, %[ptr]   \n"     \
> +               :                                                       \
> +               : [val] "r"(_val), [ptr] "r"(&(_pcp))           \
> +               : "memory");                                            \
> +} while (0)

Nice, the less code, the better. If it works for loongson target, then
we don't need this paranoia.

I just played safe and took the approach that x86 took.

Uros.

