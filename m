Return-Path: <linux-kernel+bounces-226752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD96914315
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927E2B21350
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856793A1BA;
	Mon, 24 Jun 2024 07:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QaLpZfjB"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552602EAF7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 07:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719212596; cv=none; b=nmDm5fbY6H22JT6dpU97/09k+nowu/sxh7GcStb6E1ajYgK2obSu1dochLpxrO4WF1MXhvWiI9zZQTGSP3j1WeZo9bHwHhlAwT3JihBQZy7G5UuDzE8Q2x5oTr9Io/IIc8So3pT/1M3dtSlHUpOhgRjpE7P94Ef0ynD2oHuIIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719212596; c=relaxed/simple;
	bh=pL8yZo8v5PjzbxSmeKOeCvmB5j5lHAxtpjhhCTT405M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSOLBEDnoxII1qUvHNl3EaaP2Ajp8kjCSdoBloZeKisZOqGRUdTEdzHGnIMqL39V+G95kIdaoG6blH03vjE6XoATpX2z2Mbids0PN8P6fnpbGvy9Gma7rqgc33tzBYYwc0cvtKZazY4dsR1enGttIK9FbzMy5uruDhrdLuvyz3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QaLpZfjB; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-254aec5a084so2321504fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 00:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719212593; x=1719817393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hus/Z8kWfB3zHpzLYZI2dy5Pgo4m4TR8rM+wRIiJmBY=;
        b=QaLpZfjBm9XduronS4mLzHjTg5ZaNZZ2odg6OZMuchl8leUXOxkYIShTAACQ/sZzSM
         m86OPGSkzpwoGkInOqq2/xzNqLArKWi1iR5o4cO6x8zAhcF1ym29z+X+gapye6v/D390
         +mmGFQr/6wD7J8K+mELCZ0MGyDbQEHiFtH3IcWZ/EeZ/4HYZKzMKIn0lEdPGTCt8Vo9J
         JpoOwOM0k8kROUj9gi7FajyiUrRkpE+Vi8UbQH/T6oggB1rFYAdZH3Gfsmj6fMPdRz8D
         gILuqmCIu8uKPybrDVAe2dWpsdjezp/f/RIT/+7MaQX3zfnqkeaBjgt7PlIJFzRv5AYN
         2ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719212593; x=1719817393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hus/Z8kWfB3zHpzLYZI2dy5Pgo4m4TR8rM+wRIiJmBY=;
        b=S/pfJTJ5pcik1cKTlpp2upqRo78lVB2iSdmqU6KYg+hcDLn7a8NCy2YBLD32dQHKik
         jRGfO4KwWtzoJxKYKah2kBcyhpYEOIAxhxsPnRs78ouH/IkT+SfoLLwy9+UuL+5FeEGK
         fomYKKAE/G8J3iKPVaLvXBAZOm2zlTdd5kW/ZSOOU+z67JSE0WLXyYVfWjjqBwscQqiZ
         ZgO/thI+5uV2bieMTJt/6Qqm5VX9z5TYMBWEF9lNUn90lJtAGlCnLzTcn2xO3yLYXexZ
         2aMeqLteB/WJ6Z0CwbWhCYCVWZwjJ7XYUSsYk+R+kAQi4h8NZlT38d3nW0vZitAG6i7F
         jq8g==
X-Forwarded-Encrypted: i=1; AJvYcCVVMYoG9/61RpQ0G8eGkUd7mXDahhNpg77SIcpPW9CwuWi6i1qRkJLxGjELzbnqkI6IoVYZIjOFMQ2J1VWvc/7GRb8l/VVPaAprbUhK
X-Gm-Message-State: AOJu0YzLVeYgjY0TqKoxke7HedgK4njU3qtAOBTUN6bgw6aveK3ciLlZ
	oHvK18Bq4K5oeDNREYXbiYHJxGZnza37TKfjh2P2TqZiFsHQh+YqOT3kR6XdMiFvTd41QoajlYf
	IbMGotmxIV5Xo5Ot5EzKVDfCsfXra1CkCaF7tYw==
X-Google-Smtp-Source: AGHT+IE1ORNwhEJz9xcQatVNoa2I81qe/opkAq14DSskHVsG4ALLMZ8WWonbxzoRgSdJ/Sj4jh6h/2w3Ymhhfh56Nec=
X-Received: by 2002:a05:6870:7b4c:b0:258:42be:ce5e with SMTP id
 586e51a60fabf-25d016c196emr4851607fac.16.1719212593253; Mon, 24 Jun 2024
 00:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618120842.15159-1-cuiyunhui@bytedance.com>
 <ZnTRbptoowL+1GOP@ghost> <CAEEQ3wnNZJviirqWCAG7mXsbynC+=Gq5q4jh6b4yamm8cnzMAw@mail.gmail.com>
 <ZnTvArAQpfCm10tc@ghost> <CAEEQ3w=6EZMFsH2y7efZsX00CzytyMu+Be_RT8CicejMB6qAJA@mail.gmail.com>
 <ZnUgLZow2ODPH7vp@ghost> <Znfl8NDWmL1NFANn@kernel.org>
In-Reply-To: <Znfl8NDWmL1NFANn@kernel.org>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Mon, 24 Jun 2024 15:03:02 +0800
Message-ID: <CAEEQ3w=YYyUdR3CRMv6+nURv3_kMf+dC3UGqv-UNsmxpVzmoWw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] RISC-V: cmdline: Add support for 'memmap' parameter
To: Mike Rapoport <rppt@kernel.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alexghiti@rivosinc.com, akpm@linux-foundation.org, 
	bhe@redhat.com, dawei.li@shingroup.cn, jszhang@kernel.org, 
	namcao@linutronix.de, bjorn@rivosinc.com, vishal.moola@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

On Sun, Jun 23, 2024 at 5:10=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Thu, Jun 20, 2024 at 11:39:41PM -0700, Charlie Jenkins wrote:
> > On Fri, Jun 21, 2024 at 02:02:18PM +0800, yunhui cui wrote:
> > > Hi Charlie=EF=BC=8C
> > >
> > > On Fri, Jun 21, 2024 at 11:10=E2=80=AFAM Charlie Jenkins <charlie@riv=
osinc.com> wrote:
> > > >
> > > > On Fri, Jun 21, 2024 at 10:08:39AM +0800, yunhui cui wrote:
> > > > > Hi Charlie,
> > > > >
> > > > > On Fri, Jun 21, 2024 at 9:03=E2=80=AFAM Charlie Jenkins <charlie@=
rivosinc.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 18, 2024 at 08:08:42PM +0800, Yunhui Cui wrote:
> > > > > > > Implement support for parsing 'memmap' kernel command line pa=
rameter.
> > > > > > >
> > > > > > > This patch covers parsing of the following two formats for 'm=
emmap'
> > > > > > > parameter values:
> > > > > > >
> > > > > > > - nn[KMG]@ss[KMG]
> > > > > > > - nn[KMG]$ss[KMG]
> > > > > > >
> > > > > > > ([KMG] =3D K M or G (kilo, mega, giga))
> > > > > > >
> > > > > > > These two allowed formats for parameter value are already doc=
umented
> > > > > > > in file kernel-parameters.txt in Documentation/admin-guide fo=
lder.
> > > > > > > Some architectures already support them, but Mips did not pri=
or to
>
> I believe you should add RISCV to the list of supported architectures for
> these options.

Okay, I will update it on v2.

>
> > > > > > Copy-paste from a Mips patch? Should say riscv :)
> > > > > >
> > > > > > It looks like this code is duplicated from xtensa and is effect=
ively the
> > > > > > same as mips. Can this code be placed in a generic file so that=
 the code
> > > > > > can be shared between mips, riscv, and xtensa -- maybe a new co=
nfig that
> > > > > > gets selected by mips/riscv/xtensa?
> > > > >
> > > > > Yeah, that's actually what I was thinking. Which general file do =
you
> > > > > think would be more suitable to put it in?
> > > >
> > > > I am not sure the best place to put it. What do you think about
> > > > mm/memblock.c next to the "memblock" early param?
> > >
> > > Is it inappropriate to put it in memblock? The implementation of mips
> > > is different from that of xtensa, and early_mem is also distributed i=
n
> > > various archs, so we still put memmap in riscv/, and then I will
> > > modify the commit log.
> > > What do you think?
> >
> > The mips implementation is very close to being the same, but I am not
> > sure if the differences would prevent standardization. xtensa and now
> > riscv would have identical implementations though so a generic memmap
> > implementation could be only applied to those two archs.
>
> The memmap=3D is generally a hack to workaround issues with how firmware
> describes memory to the kernel so in a way it belongs to arch/ code.
>
> mips and xtensa already have different views on how this should be treate=
d,
> not mentioning x86 that handles memmap=3D on e820 level rather than with
> memblock.

OK, let's continue to put it in arch/.

>
> > > > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > > > index e3405e4b99af..7be7ec3092ad 100644
> > > > > > > --- a/arch/riscv/mm/init.c
> > > > > > > +++ b/arch/riscv/mm/init.c
> > > > > > > @@ -208,6 +208,56 @@ static int __init early_mem(char *p)
> > > > > > >  }
> > > > > > >  early_param("mem", early_mem);
> > > > > > >
> > > > > > > +static void __init parse_memmap_one(char *p)
> > > > > > > +{
> > > > > > > +     char *oldp;
> > > > > > > +     unsigned long start_at, mem_size;
> > > > > > > +
> > > > > > > +     if (!p)
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     oldp =3D p;
> > > > > > > +     mem_size =3D memparse(p, &p);
> > > > > > > +     if (p =3D=3D oldp)
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     switch (*p) {
> > > > > > > +     case '@':
> > > > > > > +             start_at =3D memparse(p + 1, &p);
> > > > > > > +             memblock_add(start_at, mem_size);
> > > > > > > +             break;
> > > > > > > +
> > > > > > > +     case '$':
> > > > > > > +             start_at =3D memparse(p + 1, &p);
> > > > > > > +             memblock_reserve(start_at, mem_size);
>
> This will add a region to memblock.reserved, but if there is no memory
> there this information won't be available after boot, e.g. there won't be
> struct pages with PG_Reserved for this region.
> Is this your intention?

Yeah, we should use memmap to reserve in the known memory range.

>
> > > > > > > +             break;
> > > > > > > +
> > > > > > > +     case 0:
> > > > > > > +             memblock_reserve(mem_size, -mem_size);
>
> This corresponds to the case memmap=3Dnn[KMG] and it is not documented in
> kernel-parameters.txt.
>
> Not sure it's needed at all as the same result can be achieved with
> memmap=3Dnn[KMG]$0.

OK, just use case '$', because memblock_reserve() converts size to unsigned=
.

>
> > > > > > > +             break;
> > > > > > > +
> > > > > > > +     default:
> > > > > > > +             pr_warn("Unrecognized memmap syntax: %s\n", p);
> > > > > > > +             break;
> > > > > > > +     }
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int __init parse_memmap_opt(char *str)
> > > > > > > +{
> > > > > > > +     while (str) {
> > > > > > > +             char *k =3D strchr(str, ',');
> > > > > > > +
> > > > > > > +             if (k)
> > > > > > > +                     *k++ =3D 0;
> > > > > > > +
> > > > > > > +             parse_memmap_one(str);
> > > > > > > +             str =3D k;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +early_param("memmap", parse_memmap_opt);
> > > > > > > +
> > > > > > >  static void __init setup_bootmem(void)
> > > > > > >  {
> > > > > > >       phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> > > > > > > --
> > > > > > > 2.20.1
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > linux-riscv mailing list
> > > > > > > linux-riscv@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > > > >
> > > > > Thanks,
> > > > > Yunhui
> > >
> > > Thanks,
> > > Yunhui
>
> --
> Sincerely yours,
> Mike.

Thanks,
Yunhui

