Return-Path: <linux-kernel+bounces-346916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC6A98CB02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 965C01F249BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E576522F;
	Wed,  2 Oct 2024 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WOazpArh"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAE91C2E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727834272; cv=none; b=VCyN3eFC8qgL9xJlHizje7B+UOqKjYVW8RB3crxxqwc9E2pchThIVVf/DqD/Uks4rhAo0nGoHkC6jY3GvH/Z1PNm0VQatTvei7DzMgteV1UaZZLs5ojOXeAZg92RXew1An7UAIZ/RedPDsU5iqhBqrX2FPYT7/+i3DOsnR8SOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727834272; c=relaxed/simple;
	bh=lqIy58jUFE66gkWebfC5SpCWr+keHiZaGLqO2RKV+JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPMWhuCv0slCsFUVaGejdLRzkvtv0CBdjD0yyBznyRyBPhG6FmJjkexOKi1dhh7U0pcrsLIm1cx2LGNUwvF072tbYTJvZ6g5g3ffReePzaRpuMB93BpdL/t4rZVrOE2GwJLn8oWK9UWWCJVxGUaSHXut4y/1x7TtwDNqfQzNHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WOazpArh; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e039889ca0so3493730b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1727834270; x=1728439070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdJOFRftMX7616HFUeMGMx6C5isLo6aifjc5ABN1D+Y=;
        b=WOazpArh+XHtaq0DG1YdIIzb1myyG+IRGFqL3H7TaK4+qY5d3qHBf3Q1l5HuD9RLFK
         AWi5XCaGlMCTwhNmKF83S3Jy4fO9sBqHKZ+/JcfYHr22OnNCBPzDv6ptfn/U9vDOhrr7
         Ippl+xHC6Rg/VY5Waqxc8n6n94DTcbNu55RCHKj9Iddh9YQpvDqh/evCMicryBz2Bhlh
         Px0VKUkU2xj7WZv1OaugLRi9YoKPIi1YOKSZ/rgcDH/71tmzNU/d0TElCuZJHiwGJtLQ
         FSDvu8hJGmcsMsvQS6VI0bbxfuToicVBhoqt+To7rRqqmUC6aHqiEnuggCdvZNhGvb6+
         4ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727834270; x=1728439070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdJOFRftMX7616HFUeMGMx6C5isLo6aifjc5ABN1D+Y=;
        b=cieie07APDfgosuYTLYb8UJgB4EUm6MdwcXU4yhfXbIqcNFyTiMw75YFLW3dBi5lwc
         pCF6cZUN9W5XUD/45V9FJ6rAjP7ybztM3qyTiwaE1IqUd0ACWvHpBJ7n70TZNW4p0yS8
         HOeiWQFM0+LhWJfwO/iyLVkx+yEXmLJpoq9h1bNFpGFbvBHWQTSELVxg7jHdV+OQ/iYw
         DJSIdazFk/ubE7WJFuse9TfuebiscIth/FF7XfB+MnoJcr0Lqj15xv+c3he7AzYMAP+A
         z9GZnbJP6pEEBanKcFZhbOSXGLUfikD13FCwak6ia0Otn4wpGtCUeHyERJuhzcceXKCx
         kKWw==
X-Forwarded-Encrypted: i=1; AJvYcCUqR0I9gUhjDnPDX0t0syDQhtzEBvbUcRFIt7PXzLaDS5GVXUiFk3551JIBMD+ziMZTiPPkfJxcLOuOnqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAkPumohdQ0tpFIkOaZw69LHBl+3U4RR30McKClH1/gr7QSOU
	2eosT2fIGXt+fUKxMpNhR83MnPXELIxqgOAucKdki1JE8oOoJ9XcdyMXZ4pzSY/YOCMOcduA/ex
	jvMbj0NO/JMxeuqvOZM3FWOxiBpfWmYk/2rK15g==
X-Google-Smtp-Source: AGHT+IHQGLzYJ6BtLhCBkZjzGUX5xoLdK554JSlc8yaQgfMSODKE8d1tGFCYqKy/4Ph0iKu71Skz8tmC30X4F+/DkYc=
X-Received: by 2002:a05:6808:15a1:b0:3e3:9e3f:d0f9 with SMTP id
 5614622812f47-3e3b40fb92fmr1625297b6e.11.1727834270326; Tue, 01 Oct 2024
 18:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926065422.226518-1-nick.hu@sifive.com> <20240926065422.226518-2-nick.hu@sifive.com>
 <20240926-b96b7164b51b0be0c732235b@orel> <CAKddAkCJt5t_WyMuwSMb8qE4LHWy8GZ4QWZy6ViJvx-p5YBfuQ@mail.gmail.com>
In-Reply-To: <CAKddAkCJt5t_WyMuwSMb8qE4LHWy8GZ4QWZy6ViJvx-p5YBfuQ@mail.gmail.com>
From: Nick Hu <nick.hu@sifive.com>
Date: Wed, 2 Oct 2024 09:57:39 +0800
Message-ID: <CAKddAkBupSkxWF2hmTDZOvD+-cXeQK8NrUFAz6t3_tXaZZ=fZA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] riscv: Add csr_read/write_hi_lo support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Anup Patel <anup@brainfault.org>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Atish Patra <atishp@rivosinc.com>, 
	Samuel Ortiz <sameo@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems like my last mail didn't send out successfully.

On Wed, Oct 2, 2024 at 9:52=E2=80=AFAM Nick Hu <nick.hu@sifive.com> wrote:
>
> Hi Andrew
>
> On Thu, Sep 26, 2024 at 3:59=E2=80=AFPM Andrew Jones <ajones@ventanamicro=
.com> wrote:
>>
>> On Thu, Sep 26, 2024 at 02:54:16PM GMT, Nick Hu wrote:
>> > In RV32, we may have the need to read both low 32 bit and high 32 bit =
of
>> > the CSR. Therefore adding the csr_read_hi_lo() and csr_write_hi_lo() t=
o
>> > support such case.
>> >
>> > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
>> > Suggested-by: Zong Li <zong.li@sifive.com>
>> > Signed-off-by: Nick Hu <nick.hu@sifive.com>
>> > ---
>> >  arch/riscv/include/asm/csr.h | 22 ++++++++++++++++++++++
>> >  1 file changed, 22 insertions(+)
>> >
>> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr=
.h
>> > index 25966995da04..54198284eb22 100644
>> > --- a/arch/riscv/include/asm/csr.h
>> > +++ b/arch/riscv/include/asm/csr.h
>> > @@ -501,6 +501,17 @@
>> >       __v;                                                    \
>> >  })
>> >
>> > +#if __riscv_xlen < 64
>> > +#define csr_read_hi_lo(csr)                                  \
>> > +({                                                           \
>> > +     u32 hi =3D csr_read(csr##H);                              \
>> > +     u32 lo =3D csr_read(csr);                                 \
>> > +     lo | ((u64)hi << 32);                                   \
>> > +})
>> > +#else
>> > +#define csr_read_hi_lo       csr_read
>> > +#endif
>> > +
>> >  #define csr_write(csr, val)                                  \
>> >  ({                                                           \
>> >       unsigned long __v =3D (unsigned long)(val);               \
>> > @@ -509,6 +520,17 @@
>> >                             : "memory");                      \
>> >  })
>> >
>> > +#if __riscv_xlen < 64
>> > +#define csr_write_hi_lo(csr, val)                            \
>> > +({                                                           \
>> > +     u64 _v =3D (u64)(val);                                    \
>> > +     csr_write(csr##H, (_v) >> 32);                          \
>> > +     csr_write(csr, (_v));                                   \
>> > +})
>> > +#else
>> > +#define csr_write_hi_lo      csr_write
>> > +#endif
>> > +
>> >  #define csr_read_set(csr, val)                                       =
\
>> >  ({                                                           \
>> >       unsigned long __v =3D (unsigned long)(val);               \
>> > --
>> > 2.34.1
>> >
>>
>> I know I suggested this, but I'm having second thoughts. The nice thing
>> about the
>>
>>  csr_write(CSR, ...);
>>  if (__riscv_xlen < 64)
>>     csr_write(CSRH, ...);
>>
>> pattern is that it matches the spec. With this helper we'll have
>>
>>  csr_write_hi_lo(CSR, ...);
>>
>> for both rv32 and rv64. That looks odd for rv64 and hides the hi registe=
r
>> access for rv32.
>>
>> We could avoid the oddness of the helper's name for rv64 if we instead
>> added csr_write32 and csr_write64 which do the right things, but that
>> still hides the hi register access for rv32. Hiding the hi register
>> access is probably fine, though, since we can be pretty certain that
>> the spec will rarely, if ever, deviate from naming high registers with
>> the H suffix and/or not keep the upper bits compatible.
>>
>> In summary, I think I'm in favor of just dropping this patch, keeping
>> the noisy, but explicit, pattern. Or, if the consensus is to add
>> helpers, then I'd rather have all csr_<op>32/64 helpers. Then, code
>> would match the spec by choosing the right helper based on the width
>> of the CSR being accessed, when the CSR has an explicit width, or still
>> use the current helpers for xlen-wide CSRs.
>>
>> Thanks,
>> drew
>
Sure I'll drop the patch in the next version


Regards,
Nick

