Return-Path: <linux-kernel+bounces-187851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E808CD992
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93659281611
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CCF78C67;
	Thu, 23 May 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzr55e51"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCDBF9F5
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487317; cv=none; b=eIOiN//cndR8r7WLp1jLZTFYZm7/VuKnuga8A+vaGZ4K9uzEFyTp0vi0UlX4CwlMchrHZTUillLozstN2EdYCAUQmOikISqkv0xCmx4W9iQ3Q0EcNc4oJjYO6R/zs8hCnJRZgJtUh47io2VGAgLCnKOqFfzIeY0/TpS7VWd4YHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487317; c=relaxed/simple;
	bh=Mkyvi+hwGqf0BwdJmb5ZcX25h3S6XKbnnfWJg5dvTVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8jLBFagj4caRw5/u01ZgiROzkFbMBQNHstq2MiVRzqFA1OOkxDLvOZqSY6CgD3HeoOPIHqJTDrwpUBgYgrIRw/fyhvOCLpKY+HD5WxyJZJKidqgLge2QPxR+cWYVy7N+3l5RQrfdqovbZilRnsFJsOMMmEemslWpaEfymlEj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzr55e51; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5785109cd7aso92864a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 11:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716487313; x=1717092113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAmXocRkIx1PH2lT0cYBRu4GpiG/zqum3FJI9WN36SY=;
        b=mzr55e51E1CQGLp0yOw/2IHd7cdnjAmJFZTN9QWh1i2MQpLRNRcwYD4dljhehCNhrR
         5tlM2StD92cViLROjHv+g7RwK9xGe/Bgb60av8HExGxvEjQFewt+/WG7SaKirdi81v8t
         TIz93GgPr1/V5NP4PhegpSYhL2nhcytC8Qqc+idl11/MJszgsyfAL9xmVaL3Tkww4vb5
         CBT3Az2czKQo2F4m5TJYfzRFWCUO1RDEEDRRNrkHFREHY4mrSlx7s2rqLHceiZgFUqgR
         NaXLRUwg78VnoY/nyzZwsUzyzKTbK4rjbm/R6nNCrjl19/Wq9nRewzaAEtvcUhz2AGGq
         3ACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716487313; x=1717092113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAmXocRkIx1PH2lT0cYBRu4GpiG/zqum3FJI9WN36SY=;
        b=KbNupBOHpDlmsy3sKj8paYkc04PU5/EEgh82MCO962Z7xK+o4MkxDXXvGSULI1Y0dI
         rc7ceemr1DMjJV5HVWdtxSvau2nDNNJrS95RcP/FS0zqiZV/Nk4HWDOmIWMZQv7wozGj
         IhWCf1Ae/u400WRlm7VWpTl9rmIxsRUcPJP8bUCowBqlAVayZEK8UzylYwDfPcDDT478
         kagcDMpZUi1x7//W/xU88PQuCa2rLnu4JS6/7GrCQyFkWrsEATxIsWQjp4YuYFk2A3iz
         Z5kB1qy/BRnR4rV6btGwQxdAS3JkhwSUbV/lWFLWgXxOlD8RKZO6MhfKVRNWJeMcv3B/
         uueQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzEnYEUgAVtxmqjEKT0bXIi86MPILQ69eslgmWEdX41po6VctcfV/wdIeB913lPhlyVCA2PHeP756AazQhXUnfJPXIgg3nzw+5lGEx
X-Gm-Message-State: AOJu0YzH/RZdeb5hk9syMWwmH79bvtSu8EFxYulLqcYwlbkfhPdEmB6o
	hLcWWR1LVnVim8Zxs5oOznEvlER9hNMvWtbZv6RKvQGuBhF2fr3b99H6eq9emh2/MqOvbILZVHT
	5g0eiL7SAB75QaHbkuQzaXL+Xoto=
X-Google-Smtp-Source: AGHT+IHGF0RBU6YdvZb1CDrHGJK3LLHbM9I07lFJkH8DJd1cswIT/hez7w8J0rcgYRoEJhJSjZhFDgFOn+Di3tiQZ4c=
X-Received: by 2002:a50:ccc2:0:b0:573:1ebd:d670 with SMTP id
 4fb4d7f45d1cf-5785190fc49mr28765a12.3.1716487313413; Thu, 23 May 2024
 11:01:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522194250.1165568-1-pvkumar5749404@gmail.com> <87h6eo3h4i.fsf@mail.lhotse>
In-Reply-To: <87h6eo3h4i.fsf@mail.lhotse>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Thu, 23 May 2024 23:31:40 +0530
Message-ID: <CAH8oh8UP=U11XJWoDWf2wRb08PZk0LuCiYMygWSmcYtZ3Yh3mA@mail.gmail.com>
Subject: Re: [PATCH next] arch: powerpc: platforms: Remove unnecessary call to of_node_get
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: akpm@linux-foundation.org, npiggin@gmail.com, christophe.leroy@csgroup.eu, 
	naveen.n.rao@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	julia.lawall@inria.fr, javier.carrasco.cruz@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:55=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Prabhav Kumar Vaish <pvkumar5749404@gmail.com> writes:
> > `dev->of_node` has a pointer to device node, of_node_get call seems
> > unnecessary.
>
> Sorry but it is necessary.
>
> > Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> > ---
> >  arch/powerpc/platforms/cell/iommu.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platfor=
ms/cell/iommu.c
> > index 4cd9c0de22c2..5b794ce08689 100644
> > --- a/arch/powerpc/platforms/cell/iommu.c
> > +++ b/arch/powerpc/platforms/cell/iommu.c
> > @@ -780,14 +780,13 @@ static int __init cell_iommu_init_disabled(void)
> >  static u64 cell_iommu_get_fixed_address(struct device *dev)
> >  {
> >       u64 cpu_addr, size, best_size, dev_addr =3D OF_BAD_ADDR;
> > -     struct device_node *np;
> > +     struct device_node *np =3D dev->of_node;
> >       const u32 *ranges =3D NULL;
> >       int i, len, best, naddr, nsize, pna, range_size;
> >
> >       /* We can be called for platform devices that have no of_node */
> > -     np =3D of_node_get(dev->of_node);
> >       if (!np)
> > -             goto out;
> > +             return dev_addr;
> >
> >       while (1) {
> >               naddr =3D of_n_addr_cells(np);
>
>                 nsize =3D of_n_size_cells(np);
>                 np =3D of_get_next_parent(np);
>                 if (!np)
>                         break;
>
> of_get_next_parent() drops the reference of the node passed to it (np).
>
> So if you actually tested your patch you should see a recount underflow.
>
Thanks, I will check this out once again
Prabhav
> cheers

