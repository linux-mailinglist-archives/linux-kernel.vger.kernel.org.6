Return-Path: <linux-kernel+bounces-223804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA11F91184C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 04:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022CE1C21E32
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0D8289A;
	Fri, 21 Jun 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PIq5jSFE"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAB537FF
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935733; cv=none; b=i3w/zY8lw475kTwZrQtDSB86p/uESIB7o9r4IdQAuzPmyCMhaK9VchNCzre9rUIy1CsFOz0Y6fayxVnK+x+xCk/gsFiMBgxdYxSAJ1NN8I2XSeXRt6Nw59pDnlfHS5VKgSOqayDHSFYkmqSfGIBcokRLOIOu7YczuAoy0Q4yG80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935733; c=relaxed/simple;
	bh=BkH9lIaUKQs08VQMXDsELgUS9LjBD191jy+SOfhvFM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UuFbEVdGZq73NllpFSa39kf3QdDvnQ4hMh9MYkdrMUtVvendz/FUxklX2Q9aOUibwGnW8xCxyLuYIQt0LoPg0hUQk3y+3PAhDYHKQeyy84Jblcb+H8341darD1usTN6aSVC0d7lZzxjwmgqYSOevgLxlQTGASs4p2PCCZ6XqBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PIq5jSFE; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24542b8607fso820243fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1718935730; x=1719540530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKHVf5IAv5fN3fGfXBrQejN5prpjdEw0Fb3fapPXfKc=;
        b=PIq5jSFE3YfWzj72v+pWZFPVSpwkX9xX9CmhLkn5zrTpCtCoF5HHlGX8p0tG98BZ/O
         a94fBjroaAOpMF5C7gq/fa1t/CjY2/V9Gws0zi8PWmQp6gkaMwPsuCuHregYi5Mi7x1e
         IB6F77OSGyyhggPy7vpy//94zzHYSCWloHwTLeIPorrBDM7jsWuZKfU3Q51MRSjApvJ7
         CxO/1jI01NSj/vslLnTnK9skQZDVQ00YVXIAHSkAABcCTlJ5gLHSiq5lIah/CI/AEg98
         OvR7Bq7M/IAo6DXKeqSBmzjGKqUWXzV3J4/Of0SGGNWM3QWPHXttmlffYaJyjLuGurmH
         cPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718935730; x=1719540530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKHVf5IAv5fN3fGfXBrQejN5prpjdEw0Fb3fapPXfKc=;
        b=Qv6OmHAvA5WtdNGQlbTN/F0a5kCQuJQ7RMTTgS8qx/3I+vQwmqO6EUrBp52DEdyJty
         8Fjzje8E9rR+uAL3PrWvyws2VnayMVl9caykWMFLD48NeKgIAvJLyYGQVK46yPE3eeFZ
         F+0QR/Ktc2D2rLv9ym3ba2sP575QN2gTg6UkndF0bcVjrzgTI3d8mNZtkUTHGSD1Llvw
         EQyXbuhC0wkrvcPghrWbyyFTC2rnRPY6xAP5XpX+1zbZkT1LJTepD0D5X7Xtvh6q0IDs
         SEsdqEqVJNvJbAOeqYyce7rkS1yVAWhstnmr01r+3Xo60rrX5+yUeAS9loWkeMYaKWIP
         RSrw==
X-Forwarded-Encrypted: i=1; AJvYcCXGTUqURjYsIYL3QOCbv9W0nw8Y20ynMB2USkyxHY2mlG7nPjUyciB6Y2LwGvmUl8pGtXMchNwnzRb87jLm5byfTsoPGe9T+PPv0DDM
X-Gm-Message-State: AOJu0YyTibk+V1r/oYGoMEAqC/wob3fqBEegm8nS1+FxRJiDzSB1DCe8
	o/vjH/aP+IIrWQHPYLWqN/Ak3+EzS5pXlS2BNhrIL5MnfQ+Y1GgtTtMKr89pKDGTtYZFaUak8dv
	qlQKHrJu+cAJORhPZZx0df6b+dgqfqbZvcIPi2w==
X-Google-Smtp-Source: AGHT+IECgLoaflkXNVtka+xSdqP8Qc/KUUW3ZAbjdmA8w+k2t80RcpIMkU5Juafrz2qc1WHhqvN0NCvxJ25udhahph0=
X-Received: by 2002:a05:6871:1cc:b0:24f:c241:4d16 with SMTP id
 586e51a60fabf-25c94db1ab3mr8430114fac.50.1718935730446; Thu, 20 Jun 2024
 19:08:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618120842.15159-1-cuiyunhui@bytedance.com> <ZnTRbptoowL+1GOP@ghost>
In-Reply-To: <ZnTRbptoowL+1GOP@ghost>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Fri, 21 Jun 2024 10:08:39 +0800
Message-ID: <CAEEQ3wnNZJviirqWCAG7mXsbynC+=Gq5q4jh6b4yamm8cnzMAw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: cmdline: Add support for 'memmap' parameter
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alexghiti@rivosinc.com, akpm@linux-foundation.org, bhe@redhat.com, 
	rppt@kernel.org, dawei.li@shingroup.cn, jszhang@kernel.org, 
	namcao@linutronix.de, chenjiahao16@huawei.com, bjorn@rivosinc.com, 
	vishal.moola@gmail.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Charlie,

On Fri, Jun 21, 2024 at 9:03=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Tue, Jun 18, 2024 at 08:08:42PM +0800, Yunhui Cui wrote:
> > Implement support for parsing 'memmap' kernel command line parameter.
> >
> > This patch covers parsing of the following two formats for 'memmap'
> > parameter values:
> >
> > - nn[KMG]@ss[KMG]
> > - nn[KMG]$ss[KMG]
> >
> > ([KMG] =3D K M or G (kilo, mega, giga))
> >
> > These two allowed formats for parameter value are already documented
> > in file kernel-parameters.txt in Documentation/admin-guide folder.
> > Some architectures already support them, but Mips did not prior to
>
> Copy-paste from a Mips patch? Should say riscv :)
>
> It looks like this code is duplicated from xtensa and is effectively the
> same as mips. Can this code be placed in a generic file so that the code
> can be shared between mips, riscv, and xtensa -- maybe a new config that
> gets selected by mips/riscv/xtensa?

Yeah, that's actually what I was thinking. Which general file do you
think would be more suitable to put it in?

> - Charlie
>
> > this patch.
> >
> > Excerpt from Documentation/admin-guide/kernel-parameters.txt:
> >
> > memmap=3Dnn[KMG]@ss[KMG]
> > [KNL] Force usage of a specific region of memory.
> > Region of memory to be used is from ss to ss+nn.
> >
> > memmap=3Dnn[KMG]$ss[KMG]
> > Mark specific memory as reserved.
> > Region of memory to be reserved is from ss to ss+nn.
> > Example: Exclude memory from 0x18690000-0x1869ffff
> > memmap=3D64K$0x18690000
> > or
> > memmap=3D0x10000$0x18690000
> >
> > There is no need to update this documentation file with respect to
> > this patch.
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/mm/init.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index e3405e4b99af..7be7ec3092ad 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -208,6 +208,56 @@ static int __init early_mem(char *p)
> >  }
> >  early_param("mem", early_mem);
> >
> > +static void __init parse_memmap_one(char *p)
> > +{
> > +     char *oldp;
> > +     unsigned long start_at, mem_size;
> > +
> > +     if (!p)
> > +             return;
> > +
> > +     oldp =3D p;
> > +     mem_size =3D memparse(p, &p);
> > +     if (p =3D=3D oldp)
> > +             return;
> > +
> > +     switch (*p) {
> > +     case '@':
> > +             start_at =3D memparse(p + 1, &p);
> > +             memblock_add(start_at, mem_size);
> > +             break;
> > +
> > +     case '$':
> > +             start_at =3D memparse(p + 1, &p);
> > +             memblock_reserve(start_at, mem_size);
> > +             break;
> > +
> > +     case 0:
> > +             memblock_reserve(mem_size, -mem_size);
> > +             break;
> > +
> > +     default:
> > +             pr_warn("Unrecognized memmap syntax: %s\n", p);
> > +             break;
> > +     }
> > +}
> > +
> > +static int __init parse_memmap_opt(char *str)
> > +{
> > +     while (str) {
> > +             char *k =3D strchr(str, ',');
> > +
> > +             if (k)
> > +                     *k++ =3D 0;
> > +
> > +             parse_memmap_one(str);
> > +             str =3D k;
> > +     }
> > +
> > +     return 0;
> > +}
> > +early_param("memmap", parse_memmap_opt);
> > +
> >  static void __init setup_bootmem(void)
> >  {
> >       phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Yunhui

