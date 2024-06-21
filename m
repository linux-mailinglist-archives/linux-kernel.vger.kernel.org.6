Return-Path: <linux-kernel+bounces-223947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C84911ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95BE1F238F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321F1422A6;
	Fri, 21 Jun 2024 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FInjDK6y"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F517BB9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718949752; cv=none; b=hnyD0aK10gmEqRuJ/ltmfVzqjRXz2VTbGUkxvHTDjbKgc+jjOqHXwm0tiZRrRWdeNG8c8nadQt/0/tSX1o5Nx3Tu6rBn8Kzk2MyVLs5Iy4sj9VapokcWSViUU3CQEfoOwVPWX9auXVGcaA49qitNbAjLKFPDlvn1z5cbBd4WIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718949752; c=relaxed/simple;
	bh=ByzNlL6Roaae8ESRTJromBbL7u0/0LJ5b98qtXhQ8xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dE/leppQEp8ayFWOHT3Q/VOPltNt5+fThAfCE8jlq6O3+gaotrvLfTBBOGvAGX9+yMbgqDiG03uy6c9k4Kpp173H0heJewTrw9CMe9Nbl9btz2KsMRSF8iTya8xqiQjltdEoU5UqmxfP1cFcFY89pvcqZ5bNJmyNfwGroeVr1TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FInjDK6y; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d229baccc4so898663b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718949750; x=1719554550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HxD6aiQRHkMqcdxegyZAEnOJyWypP6FV0HkREBx3Ho=;
        b=FInjDK6y7FSkBRGh9+YSLqNoGDT4ypqKpV7Tsb9V1DikbN+lWiL6HaiYosm15+j+4t
         0MPTNqQwMulZFUEgZhIxYRHfQQMcwyJojs+kZNvwPbFfzM0hvItfMLvURawfzb9PT5jN
         g/Fsf6VYDbOY2JTVlnEEKcIC7QipXkRKxjBlnNBxV58CBE+IaLai6D9C5pwskuoH20ip
         RmAXZut1R1cPCjhDu6OoAqBjfTb/Vt+NjNA0vN7K3Y31m0rGRIi2YSb3fe5tRoEOqUHi
         VOElZPnN89lqKBMalJX2XMG9GJrTvtD0mHfBWcQXbdYUhA+TcQEeEjwcE0wl+ryTsT6+
         6L/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718949750; x=1719554550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0HxD6aiQRHkMqcdxegyZAEnOJyWypP6FV0HkREBx3Ho=;
        b=OVnqocSNXqN8a1Ynlz7FvmRWuQB+grQ9XNYbsmpFkIUGqV8nAKu2JE2tGhZt5vKEk9
         MaSCd3+Yepzh48rFfi0xTzaeveEDcRCKd17QyR7LWzbJAynt4eXWEdcAdENGE2s7RsRV
         V/BIXxDpz0WK1YtVBvEHvfLaiiRtnDGE42tOk1GGlI2pIv86oF1c+t9BklJ6MfZ5bRrs
         XKCQ7KhR1UYO/gZgmmj3Al4eMJQKK7czUXOayGnRne5cVG+B6vyOgXiUxYKbYxsy8ohf
         +soagVba4d6G9J0/erXmV7FwTTLdRFXGbGdxlcYmZM7mrpRjEJj5bsnEWFU62AjnDMum
         QeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVNDcQaKKKVUSjZX9ra194odNMZOQMN++5XDZ51WvVH4670+6sk6IBVB5FuU0ziqT7oAZsIrq1hqvVhTWcZGNyPv+rfdZodIByeFu5
X-Gm-Message-State: AOJu0YyWUKun26623hXT3Xg6cD/SlxSmgwt+INrS+6AFd4/567yChvhT
	Dc+SadcKoC/7zsqTWXTwS6bZtC99VL9doDsXiCs0JrA0hU0etSK1dRjWYA/RCaSvhJyXe+ynRn/
	29dEbpGsmQd4FAGMxuyD+7B0xWiHshkJ4SrmapA==
X-Google-Smtp-Source: AGHT+IH3Tt5BVU8ULxGsm/RJPS3eckiZMRRDqh733Kfp6RT5sXNEsu7b3QvzZ8mhpuOUNM+FhYbIB6ZbOWWHFY5Aesg=
X-Received: by 2002:a05:6871:1cc:b0:255:d15:5acf with SMTP id
 586e51a60fabf-25c94d05a09mr8925908fac.36.1718949749951; Thu, 20 Jun 2024
 23:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618120842.15159-1-cuiyunhui@bytedance.com>
 <ZnTRbptoowL+1GOP@ghost> <CAEEQ3wnNZJviirqWCAG7mXsbynC+=Gq5q4jh6b4yamm8cnzMAw@mail.gmail.com>
 <ZnTvArAQpfCm10tc@ghost>
In-Reply-To: <ZnTvArAQpfCm10tc@ghost>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 21 Jun 2024 14:02:18 +0800
Message-ID: <CAEEQ3w=6EZMFsH2y7efZsX00CzytyMu+Be_RT8CicejMB6qAJA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: cmdline: Add support for 'memmap' parameter
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, dawei.li@shingroup.cn, jszhang@kernel.org, 
	namcao@linutronix.de, bjorn@rivosinc.com, vishal.moola@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie=EF=BC=8C

On Fri, Jun 21, 2024 at 11:10=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.=
com> wrote:
>
> On Fri, Jun 21, 2024 at 10:08:39AM +0800, yunhui cui wrote:
> > Hi Charlie,
> >
> > On Fri, Jun 21, 2024 at 9:03=E2=80=AFAM Charlie Jenkins <charlie@rivosi=
nc.com> wrote:
> > >
> > > On Tue, Jun 18, 2024 at 08:08:42PM +0800, Yunhui Cui wrote:
> > > > Implement support for parsing 'memmap' kernel command line paramete=
r.
> > > >
> > > > This patch covers parsing of the following two formats for 'memmap'
> > > > parameter values:
> > > >
> > > > - nn[KMG]@ss[KMG]
> > > > - nn[KMG]$ss[KMG]
> > > >
> > > > ([KMG] =3D K M or G (kilo, mega, giga))
> > > >
> > > > These two allowed formats for parameter value are already documente=
d
> > > > in file kernel-parameters.txt in Documentation/admin-guide folder.
> > > > Some architectures already support them, but Mips did not prior to
> > >
> > > Copy-paste from a Mips patch? Should say riscv :)
> > >
> > > It looks like this code is duplicated from xtensa and is effectively =
the
> > > same as mips. Can this code be placed in a generic file so that the c=
ode
> > > can be shared between mips, riscv, and xtensa -- maybe a new config t=
hat
> > > gets selected by mips/riscv/xtensa?
> >
> > Yeah, that's actually what I was thinking. Which general file do you
> > think would be more suitable to put it in?
>
> I am not sure the best place to put it. What do you think about
> mm/memblock.c next to the "memblock" early param?

Is it inappropriate to put it in memblock? The implementation of mips
is different from that of xtensa, and early_mem is also distributed in
various archs, so we still put memmap in riscv/, and then I will
modify the commit log.
What do you think?

>
> >
> > > - Charlie
> > >
> > > > this patch.
> > > >
> > > > Excerpt from Documentation/admin-guide/kernel-parameters.txt:
> > > >
> > > > memmap=3Dnn[KMG]@ss[KMG]
> > > > [KNL] Force usage of a specific region of memory.
> > > > Region of memory to be used is from ss to ss+nn.
> > > >
> > > > memmap=3Dnn[KMG]$ss[KMG]
> > > > Mark specific memory as reserved.
> > > > Region of memory to be reserved is from ss to ss+nn.
> > > > Example: Exclude memory from 0x18690000-0x1869ffff
> > > > memmap=3D64K$0x18690000
> > > > or
> > > > memmap=3D0x10000$0x18690000
> > > >
> > > > There is no need to update this documentation file with respect to
> > > > this patch.
> > > >
> > > > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > > > ---
> > > >  arch/riscv/mm/init.c | 50 ++++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 50 insertions(+)
> > > >
> > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > index e3405e4b99af..7be7ec3092ad 100644
> > > > --- a/arch/riscv/mm/init.c
> > > > +++ b/arch/riscv/mm/init.c
> > > > @@ -208,6 +208,56 @@ static int __init early_mem(char *p)
> > > >  }
> > > >  early_param("mem", early_mem);
> > > >
> > > > +static void __init parse_memmap_one(char *p)
> > > > +{
> > > > +     char *oldp;
> > > > +     unsigned long start_at, mem_size;
> > > > +
> > > > +     if (!p)
> > > > +             return;
> > > > +
> > > > +     oldp =3D p;
> > > > +     mem_size =3D memparse(p, &p);
> > > > +     if (p =3D=3D oldp)
> > > > +             return;
> > > > +
> > > > +     switch (*p) {
> > > > +     case '@':
> > > > +             start_at =3D memparse(p + 1, &p);
> > > > +             memblock_add(start_at, mem_size);
> > > > +             break;
> > > > +
> > > > +     case '$':
> > > > +             start_at =3D memparse(p + 1, &p);
> > > > +             memblock_reserve(start_at, mem_size);
> > > > +             break;
> > > > +
> > > > +     case 0:
> > > > +             memblock_reserve(mem_size, -mem_size);
> > > > +             break;
> > > > +
> > > > +     default:
> > > > +             pr_warn("Unrecognized memmap syntax: %s\n", p);
> > > > +             break;
> > > > +     }
> > > > +}
> > > > +
> > > > +static int __init parse_memmap_opt(char *str)
> > > > +{
> > > > +     while (str) {
> > > > +             char *k =3D strchr(str, ',');
> > > > +
> > > > +             if (k)
> > > > +                     *k++ =3D 0;
> > > > +
> > > > +             parse_memmap_one(str);
> > > > +             str =3D k;
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +early_param("memmap", parse_memmap_opt);
> > > > +
> > > >  static void __init setup_bootmem(void)
> > > >  {
> > > >       phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> > > > --
> > > > 2.20.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > Thanks,
> > Yunhui

Thanks,
Yunhui

