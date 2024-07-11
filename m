Return-Path: <linux-kernel+bounces-248630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E22D92DFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C171C20F99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664238003F;
	Thu, 11 Jul 2024 06:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hfBz5QKz"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26D1C14
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678567; cv=none; b=IGokyidwbDm2FmFVBQQ0n8GgSmal2jpl0runpe+bIfEtmjnSWWcdhD1HJhrlnrZYdn8ZLmdYR6LGVhjAjlMM7gergYkym7H/TXC235DCvxqUJJuxvnpRJdWDdSsqFG6QgAW4tnBFeEd9djy7GPhxXvjaAPb+C8N3MSKLRi8Kpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678567; c=relaxed/simple;
	bh=jvveVlKWELb8NtmeFjvGPsVxSb64R1UNpmmHgG6uzus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX8yb8KwZTEV0UyR2yLalxQFMPvgxvL1k2nSvla2UIU3SzECcpJrFW13aKB5OqCe01rnKbUd+R3q21SY58VlvXe7anB8iGhRBEeA8E/OpJGHbuC9/V1k8tSTY+YYj33h8rSOvl0toBPcXT4rFgEqiPR8b8Tyx2BUWhPhn69m2UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hfBz5QKz; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e43dda1edso340367fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1720678564; x=1721283364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ0Z6cXb98EmZGcIFWsfHRThtuJvf+uWp8pRo+TY/1M=;
        b=hfBz5QKzIpaVm3C3VjJ6JgtkGIavMRg9D0BLpixVsObs0Mtx8Zl2WSmeoDnFOj7Yof
         3EqOdnkWgif9MM73Ak7a2nAlHtpU1hhlpgYuJQrv1VvA0OvnOzrqy0XweZdWA7H5iHtX
         2STLjPZkG5fg67Is3acGqPMf5+x7Cd1ZqzB4MorTtpgmEPHJJ2IyyxGyEGClyA3bCt4e
         ZTUQZ/7NymN21wjdXnb6WTUtSnV1ar0j0eLX0ekaH4yc+cGUwwF0Zp5pFOk3M8PG/F6C
         jIYkOqDHE9NrgJKDCBg9HpLo7NqKpd44HFHCdYEsN4JeZW+QEnGco/mApairMYvYRqvP
         1fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678564; x=1721283364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ0Z6cXb98EmZGcIFWsfHRThtuJvf+uWp8pRo+TY/1M=;
        b=trTuDsIP5egMI4i6BwI3CE2qLiLrpMytXUof1Py805vsbTLGxSihii7KnfeyBhk7B4
         1v0xYbPmWZJCrNuzK2aFjMASP8hL6D1HhWHsbicI8Xa4cRB3ckQanTC98s103dNsHmqf
         P9SC/pSv7+Gkw7O2lzoc4Pd93uPD0l0A4xxYpIsaWrnRWLUlixLRBuEQWvuLKACkAtf0
         XR9fvcpiSgxTfxGWQL2AV4lHl2ArIJSN+xqGeO4+p3/qX+krnhi5pTKQ5cJaTd75u5rr
         O5mImwpSXaIxJy/JPYUSAhRCamyyXehsUEKRfxYBrvI+XU8ZnGJsMoIhetyv6ck3kVqQ
         Dryw==
X-Forwarded-Encrypted: i=1; AJvYcCW4IyQlbR08/RtJ8W7HGVkprIlls1W0cuIptZfzAVny7r3Ug1LFq0U3z40rRL9mQt4wryBt/gY5hu+JJeSeP46ohBfYmrzbIdUrHN2U
X-Gm-Message-State: AOJu0YxnsXpku6VwtmT79YtDC2kjWaZfz8zywoSqxoGLBVQEWc+FXsSx
	WBm7FBIHLCVcM8FaOcPHZ578/7Hjb0Yj8R6+6RvCsgD9xVJM4ufUSEqiTWPyzQVTLqdwHl3ItCj
	LYwOsZ/7e2o3r8WoWfjf4PcjPo3aVLzxtm0tGEw==
X-Google-Smtp-Source: AGHT+IFdwET1pfCBi86eQx2wfXA9P6KMkAOby2PoYjCaq7p8/aLek5mXIrMth+KJtj8hMDuMaQsDPFvTWwx1YSGKb34=
X-Received: by 2002:a05:6870:96a0:b0:254:a810:cdf with SMTP id
 586e51a60fabf-25eae7a4562mr6653938fac.13.1720678564625; Wed, 10 Jul 2024
 23:16:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624123739.43604-1-cuiyunhui@bytedance.com> <ZoXEmryf8RuLMZWN@ghost>
In-Reply-To: <ZoXEmryf8RuLMZWN@ghost>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Thu, 11 Jul 2024 14:15:53 +0800
Message-ID: <CAEEQ3wmc6ftb_pTh3eG7Rnwkg4rRy8gzSqWQ2nPh_Aw5ZoBKdA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] RISC-V: cmdline: Add support for
 'memmap' parameter
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: rppt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alexghiti@rivosinc.com, akpm@linux-foundation.org, 
	bhe@redhat.com, dawei.li@shingroup.cn, jszhang@kernel.org, 
	namcao@linutronix.de, chenjiahao16@huawei.com, bjorn@rivosinc.com, 
	vishal.moola@gmail.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, punit.agrawal@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add punit in the loop.


On Thu, Jul 4, 2024 at 5:37=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
>
> On Mon, Jun 24, 2024 at 08:37:39PM +0800, Yunhui Cui wrote:
> > Add parsing of 'memmap' to use or reserve a specific region of memory.
> >
> > Implement the following memmap variants:
> > - memmap=3Dnn[KMG]@ss[KMG]: force usage of a specific region of memory;
> > - memmap=3Dnn[KMG]$ss[KMG]: mark specified memory as reserved;
> >
> > Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> > ---
> >  arch/riscv/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 46 insertions(+)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index e3405e4b99af..8e1d93ae5cb2 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -208,6 +208,52 @@ static int __init early_mem(char *p)
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
>
> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
>

Thanks,
Yunhui

