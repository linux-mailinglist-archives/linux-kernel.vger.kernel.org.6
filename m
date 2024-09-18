Return-Path: <linux-kernel+bounces-332235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C863E97B713
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351CA1F22730
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8B135417;
	Wed, 18 Sep 2024 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JdJW0cTy"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136A2B658
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726630040; cv=none; b=srpMQgIPv25MQ88LLCLTeOrY59H9/MRovrqSWQat2IXGtx0Xo1TKoBDo+8qGhOMBeplSbUzh8S9Jxgm1A1w1rCQhBF2ks3LQri7Rr56AZIoa5dM8XtnBF8rOyqR2UHi2MExM8qj/YeMob8/9Ma+HxNoe+QCK0vZ+PyIPQpzo09Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726630040; c=relaxed/simple;
	bh=X2VFSOzw5sWNKx3ZtFgiEIRTlQnV8b18MWp0/ja7qeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYjx6hz1jlThRPTXtRHPrX7J3z9ytKTEv8BCVbcBrw8hwJUQv+4SuplT6oGP6QKsIQS7kySN2FnAthgeY0KqOviSXILIXRbvR1KvA7HC2OykZ0864kNPJUAS5buXAVtlx3dJOAL9e5Mc3w8cxDUqkUGiTH9w0xwPswtQbtpXi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JdJW0cTy; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-710e1a47b40so1266417a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1726630037; x=1727234837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TYbvktLigUAMTePHROfk7Jv5OlFqQlOacIqWxghUJRY=;
        b=JdJW0cTy3DBY87xjhwAf771UiFEI1/LnHcv8VrFguUUoL4SDoOEAOFkB8eJgiJwUfW
         KcZISOPLEgPuqPgewR/o7CViBfoUy+tzEcQG9mCsiFgtYFxFNpHlw5kCWgVm7Q/GB5OV
         0v7ODdZHfPeovuigG64BBaa+R3x9Gg4ZAJK69VxYfMm1EWd3FVKU59v+eKkR/q0/Rv5g
         Yk0KHtMMvtsch0hk1mzyhPf/p4QrnGCt++41Sft7sIshdIeCdKbfdhZuVDtj0ltUuJ8w
         cWXcrdkcKq0Rmcx6jI45KrFkcR1aG+eeINsmahoYE7nh3AL1ENCA7HjemtcfstQFJ3nP
         t3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726630037; x=1727234837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TYbvktLigUAMTePHROfk7Jv5OlFqQlOacIqWxghUJRY=;
        b=DnFLtSYOIJT4Yh+hZcXVjkGYE3Ri+d2JyZBkzOeaKCVQF2Pt0x3Fl1YsuWx3upJLUj
         KSA1dkhz1SuDwvBpJnI9DniVjZLUa4A4NRfjsQ2iqnEx7n0W5eQvfnQ2xVDMzq3kfH99
         GnsiDhR/HKUAhe6WyB6ZGDHiFM9h40IN+KfGImGKC0LCfKFuIU5Wwo7nhtqXULZbLp0o
         PxJBpYqtQg3jgwmUxwSBYQpE63+BSaQbEcnrfYU5Kmq4/6z5Hq2gkkDp43gWUyuGgB9+
         +L0NeOnRU3pxYVfzEmF1WKWpItLVAPkLLWzkegre3oydyjJfeY8e4UNL4MkAH6Tq04Nb
         WfiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY5LnOByY+jx9Qe/OW7UW9XzND9XAj9p9UqrpJX9MhbvrR4qjP7yYuPWahoBc/jfAXvO6WNjpeD8WL1wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxH39Z4lO5fk5zFfp5dioDPMTULayFN6vSVxx23F1EkbS4fzh
	IKx1CCKpjflv/V2f2ux+ZE6fHybblSYs/rzr9edRqv84+rvmmA5OMFL1nUX3AuKrejBj7zEGdoI
	B/cbjopjBMCETEDofMWUhhwOK5v6CorT6jVsEJA==
X-Google-Smtp-Source: AGHT+IGnWsj7m6M03RuqK5J3Evla2on7+gi75SF/oTkeVo0Do/aPuvXYeH6pKmpjg/5K6bHn/XUas+a8J1zUo6DQYR8=
X-Received: by 2002:a05:6830:6586:b0:710:db4f:8ee2 with SMTP id
 46e09a7af769-71116bf700dmr10718380a34.16.1726630037010; Tue, 17 Sep 2024
 20:27:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874j8hku51.fsf@gmail.com> <mhng-7b39a06f-bf26-4bc0-beef-45bd4b5312e1@palmer-ri-x1c9>
In-Reply-To: <mhng-7b39a06f-bf26-4bc0-beef-45bd4b5312e1@palmer-ri-x1c9>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Wed, 18 Sep 2024 11:27:05 +0800
Message-ID: <CAEEQ3wkMY-gfvVo9LqrQUGXibKaBf9vmBjtN+AsRVG5-e1fv0A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] RISC-V: cmdline: Add support for
 'memmap' parameter
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: punit.agrawal@bytedance.com, rppt@kernel.org, 
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, alexghiti@rivosinc.com, 
	akpm@linux-foundation.org, bhe@redhat.com, dawei.li@shingroup.cn, 
	jszhang@kernel.org, namcao@linutronix.de, chenjiahao16@huawei.com, 
	Bjorn Topel <bjorn@rivosinc.com>, vishal.moola@gmail.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Charlie Jenkins <charlie@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Palmer,

On Sat, Sep 14, 2024 at 4:21=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Mon, 22 Jul 2024 14:13:14 PDT (-0700), punit.agrawal@bytedance.com wro=
te:
> > Hi Palmer,
> >
> > Charlie Jenkins <charlie@rivosinc.com> writes:
> >
> >> On Mon, Jun 24, 2024 at 08:37:39PM +0800, Yunhui Cui wrote:
> >>> Add parsing of 'memmap' to use or reserve a specific region of memory=
.
> >>>
> >>> Implement the following memmap variants:
> >>> - memmap=3Dnn[KMG]@ss[KMG]: force usage of a specific region of memor=
y;
> >>> - memmap=3Dnn[KMG]$ss[KMG]: mark specified memory as reserved;
> >>>
> >>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> >>> ---
> >>>  arch/riscv/mm/init.c | 46 ++++++++++++++++++++++++++++++++++++++++++=
++
> >>>  1 file changed, 46 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >>> index e3405e4b99af..8e1d93ae5cb2 100644
> >>> --- a/arch/riscv/mm/init.c
> >>> +++ b/arch/riscv/mm/init.c
> >>> @@ -208,6 +208,52 @@ static int __init early_mem(char *p)
> >>>  }
> >>>  early_param("mem", early_mem);
> >>>
> >>> +static void __init parse_memmap_one(char *p)
> >>> +{
> >>> +   char *oldp;
> >>> +   unsigned long start_at, mem_size;
> >>> +
> >>> +   if (!p)
> >>> +           return;
> >>> +
> >>> +   oldp =3D p;
> >>> +   mem_size =3D memparse(p, &p);
> >>> +   if (p =3D=3D oldp)
> >>> +           return;
> >>> +
> >>> +   switch (*p) {
> >>> +   case '@':
> >>> +           start_at =3D memparse(p + 1, &p);
> >>> +           memblock_add(start_at, mem_size);
> >>> +           break;
> >>> +
> >>> +   case '$':
> >>> +           start_at =3D memparse(p + 1, &p);
> >>> +           memblock_reserve(start_at, mem_size);
> >>> +           break;
> >>> +
> >>> +   default:
> >>> +           pr_warn("Unrecognized memmap syntax: %s\n", p);
> >>> +           break;
> >>> +   }
> >>> +}
> >>> +
> >>> +static int __init parse_memmap_opt(char *str)
> >>> +{
> >>> +   while (str) {
> >>> +           char *k =3D strchr(str, ',');
> >>> +
> >>> +           if (k)
> >>> +                   *k++ =3D 0;
> >>> +
> >>> +           parse_memmap_one(str);
> >>> +           str =3D k;
> >>> +   }
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +early_param("memmap", parse_memmap_opt);
> >>> +
> >>>  static void __init setup_bootmem(void)
> >>>  {
> >>>     phys_addr_t vmlinux_end =3D __pa_symbol(&_end);
> >>> --
> >>> 2.20.1
> >>>
> >>
> >> Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
> >
> > Another patch that looks good to get merged if there are no further
> > comments.
> >
> > Any chance this can be picked up for this cycle?
>
> Sorry for being slow here, but I don't understand the use case for this:
> we already get the memory map from the firmware, it seems like
> overriding that is just asking for issues.

Without modifying the firmware, it is more convenient to complete the
reservation of the memory block in this way.
This parameter is also mentioned in Documentation/admin - guide/kernel
- parameters.txt.

Thanks,
Yunhui

