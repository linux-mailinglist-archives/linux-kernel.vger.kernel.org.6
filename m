Return-Path: <linux-kernel+bounces-372590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89079A4AC8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 02:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E7AD1F23302
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 00:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698351990B7;
	Sat, 19 Oct 2024 00:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5Xk8cqI"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633F746450
	for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729299412; cv=none; b=d4Gu4DQnmyUMdnmxCZ4PvlPO8XI2ks17VqAlHIqDTRstcCS3jlASqzogdFDI30b1FtkchJt9T5PaX//9EdCvX2CRob7bKjDU9XDLIgf0w4XLPrJhwVW1NXWAUbTDBYlm635bVcuLJ4oH4mXqRMB4nGlPZA8MF3Z2lDfoAbVDZTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729299412; c=relaxed/simple;
	bh=Wu3NiGXO0CBo6pfSehSOq5PnryLvrM4LIpXHekfQP7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjCUQWXptcN2qKemHgscfvxpFR7op8pzrQ3A9ymruPWFdDEgnwFJULJR4SAAzTWTCkhMvf8YaRgzqrMjdjPNShmxG2yqdOzd/08wEIgnPaz4txNHp5/nFWy6ACUmbib7kVumaBfrCsZvpkNkOMZqCU+7XbjbJdOWDWbx0AQObv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5Xk8cqI; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-851e191d541so539453241.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729299409; x=1729904209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ogPnR+iPnz306L/2kyuRy57MK9w8E4o4gDlqm43OcY=;
        b=Z5Xk8cqIfqXzkkyip/4f18kw38PZXaH5Svr5Gq/SPHFEFXmpag037UH689BgKp2zRF
         5ydFTrgDSCFoaRegMOYY0tLnIh0ZGXR9piY7gja6xNOE81cpLd8H+eaeNx9RGhsnHb3v
         aDxAryLpLfZTJmWPk9qOpKqHNXWqi7kQK2XaabxYKVlFRSv9+jHNmIVIg8jZS5bheLBk
         Ks+nGCBtr6CmbGRE10StOYYVsNAIUQ+aLUPG1dTSORU1an6WKEhKEcFMV3Jd2XE2IH3N
         SyLUu0INTA828ms8+5g40Sn7tMZrlGjUettxmXQ0/6FXStST0P+Zmawn9JT8N2wQezN+
         PAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729299409; x=1729904209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ogPnR+iPnz306L/2kyuRy57MK9w8E4o4gDlqm43OcY=;
        b=e6GmXHT5zE9mP4dxAAFnu0IIZm004Xhjb8Fgv8auahsLJVTmU5mhgh9yo64iELfw/n
         HsEIcnSMsprPf+K9Sq55iYamK1HlrAurOumBVKx8GFIyV5jz9nL9Qgt84gSKZYAl4E08
         aIDiDRJzN3GzJCWsjRrEXGwlDbZQtWmwBy60AHqpU85NCgu2M0MQ64SaU3mxZ672HmoU
         ZsC2APk1oArfoEgoFsTRakwl2kvApDqlMSTCDVgAyp88HiMO/9Sdv8bOydqqNiZj4rrN
         VheKUyc5V4lCrljYJAvpnuhlO70spljhGMYUQkffGTmRFhtWJOrHOld5i4QumHElSKHT
         oFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdVomqzcr/oCZVyKInrQ2ucFj2Rjcyl0LvD45RB9IoeIg4WNqUMKwM02Fsxg9vHX1qF8ZxT9qUw50mrzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fGIFgJ8/l520fk2JBOW4cM2YSwUlwMGBd3wqS7x26ObKV+p/
	8kl4mEXHvAmXZ4Lnat4o9cgV0og/hVl0LNrjAQ5xj2duwopWSnwOYtjQ6y6/Chqx5wP9Dfwxx05
	1ef4LNxBKypvhsInWz+iRCP6JFjcaCgDWB5cN
X-Google-Smtp-Source: AGHT+IGGzCk8DuoFf2e4+BWdxxCuoVDC+WR0hRVS416Ii7TDJ1/ieZz3jF/qq9mm8/zGhxUaVBeGFKI2RnL7Q5T02YE=
X-Received: by 2002:a05:6102:c04:b0:4a3:cb2b:9745 with SMTP id
 ada2fe7eead31-4a5d6bb5f1emr5104987137.22.1729299408864; Fri, 18 Oct 2024
 17:56:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018152925.138341-1-hao.ge@linux.dev> <20241018162559.143548-1-hao.ge@linux.dev>
 <CAJuCfpEnRQ9p4V22wWMNwcHMYjToJETwrxkVNMV_EM46WbcF5g@mail.gmail.com>
In-Reply-To: <CAJuCfpEnRQ9p4V22wWMNwcHMYjToJETwrxkVNMV_EM46WbcF5g@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 18 Oct 2024 18:56:08 -0600
Message-ID: <CAOUHufa9y3bZnV2Ahyy+OTLcED-4wEJ5MYQ2gvUj92Ahr6a5OA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/codetag: move ref and tag null pointer check to alloc_tag_add
To: Suren Baghdasaryan <surenb@google.com>, Hao Ge <hao.ge@linux.dev>
Cc: kent.overstreet@linux.dev, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Hao Ge <gehao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 11:30=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Fri, Oct 18, 2024 at 9:26=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
> >
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > When we compile and load lib/slub_kunit.c,it will cause a panic.
> >
> > The root cause is that __kmalloc_cache_noprof was directly called
> > instead of kmem_cache_alloc,which resulted in no alloc_tag being
> > allocated.This caused current->alloc_tag to be null,leading to a
> > null pointer dereference in alloc_tag_ref_set.
> >
> > Despite the fact that my colleague Pei Xiao will later fix the code
> > in slub_kunit.c,we still need to move the null pointer check for ref
> > and tag to alloc_tag_add here.
> > It is sufficient for us to issue a warning to the user;
> > It should not lead to a panic.
> >
> > Here is the log for the panic:
> >
> > [   74.779373][ T2158] Unable to handle kernel NULL pointer dereference=
 at virtual address 0000000000000020
> > [   74.780130][ T2158] Mem abort info:
> > [   74.780406][ T2158]   ESR =3D 0x0000000096000004
> > [   74.780756][ T2158]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [   74.781225][ T2158]   SET =3D 0, FnV =3D 0
> > [   74.781529][ T2158]   EA =3D 0, S1PTW =3D 0
> > [   74.781836][ T2158]   FSC =3D 0x04: level 0 translation fault
> > [   74.782288][ T2158] Data abort info:
> > [   74.782577][ T2158]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x0000=
0000
> > [   74.783068][ T2158]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D =
0
> > [   74.783533][ T2158]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =
=3D 0
> > [   74.784010][ T2158] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000=
00105f34000
> > [   74.784586][ T2158] [0000000000000020] pgd=3D0000000000000000, p4d=
=3D0000000000000000
> > [   74.785293][ T2158] Internal error: Oops: 0000000096000004 [#1] SMP
> > [   74.785805][ T2158] Modules linked in: slub_kunit kunit ip6t_rpfilte=
r ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebtable=
_nat ebtable_broute ip6table_nat ip6table_mangle 4
> > [   74.790661][ T2158] CPU: 0 UID: 0 PID: 2158 Comm: kunit_try_catch Kd=
ump: loaded Tainted: G        W        N 6.12.0-rc3+ #2
> > [   74.791535][ T2158] Tainted: [W]=3DWARN, [N]=3DTEST
> > [   74.791889][ T2158] Hardware name: QEMU KVM Virtual Machine, BIOS 0.=
0.0 02/06/2015
> > [   74.792479][ T2158] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT =
-SSBS BTYPE=3D--)
> > [   74.793101][ T2158] pc : alloc_tagging_slab_alloc_hook+0x120/0x270
> > [   74.793607][ T2158] lr : alloc_tagging_slab_alloc_hook+0x120/0x270
> > [   74.794095][ T2158] sp : ffff800084d33cd0
> > [   74.794418][ T2158] x29: ffff800084d33cd0 x28: 0000000000000000 x27:=
 0000000000000000
> > [   74.795095][ T2158] x26: 0000000000000000 x25: 0000000000000012 x24:=
 ffff80007b30e314
> > [   74.795822][ T2158] x23: ffff000390ff6f10 x22: 0000000000000000 x21:=
 0000000000000088
> > [   74.796555][ T2158] x20: ffff000390285840 x19: fffffd7fc3ef7830 x18:=
 ffffffffffffffff
> > [   74.797283][ T2158] x17: ffff8000800e63b4 x16: ffff80007b33afc4 x15:=
 ffff800081654c00
> > [   74.798011][ T2158] x14: 0000000000000000 x13: 205d383531325420 x12:=
 5b5d383734363537
> > [   74.798744][ T2158] x11: ffff800084d337e0 x10: 000000000000005d x9 :=
 00000000ffffffd0
> > [   74.799476][ T2158] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008219d188 x6 :=
 c0000000ffff7fff
> > [   74.800206][ T2158] x5 : ffff0003fdbc9208 x4 : ffff800081edd188 x3 :=
 0000000000000001
> > [   74.800932][ T2158] x2 : 0beaa6dee1ac5a00 x1 : 0beaa6dee1ac5a00 x0 :=
 ffff80037c2cb000
> > [   74.801656][ T2158] Call trace:
> > [   74.801954][ T2158]  alloc_tagging_slab_alloc_hook+0x120/0x270
> > [   74.802494][ T2158]  __kmalloc_cache_noprof+0x148/0x33c
> > [   74.802976][ T2158]  test_kmalloc_redzone_access+0x4c/0x104 [slub_ku=
nit]
> > [   74.803607][ T2158]  kunit_try_run_case+0x70/0x17c [kunit]
> > [   74.804124][ T2158]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [k=
unit]
> > [   74.804768][ T2158]  kthread+0x10c/0x118
> > [   74.805141][ T2158]  ret_from_fork+0x10/0x20
> > [   74.805540][ T2158] Code: b9400a80 11000400 b9000a80 97ffd858 (f9401=
2d3)
> > [   74.806176][ T2158] SMP: stopping secondary CPUs
> > [   74.808130][ T2158] Starting crashdump kernel...

Thank for catching this!

> > Fixes: e0a955bf7f61 ("mm/codetag: add pgalloc_tag_copy()")
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > ---
> > v2: Modify the errors in the title and commit message.
> >     Remove the empty lines that were mistakenly added in version v1.
> > ---
> >  include/linux/alloc_tag.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/alloc_tag.h b/include/linux/alloc_tag.h
> > index 1f0a9ff23a2c..8603e3a9df10 100644
> > --- a/include/linux/alloc_tag.h
> > +++ b/include/linux/alloc_tag.h
> > @@ -137,10 +137,6 @@ static inline void alloc_tag_sub_check(union codet=
ag_ref *ref) {}
> >  /* Caller should verify both ref and tag to be valid */
> >  static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct =
alloc_tag *tag)
> >  {
> > -       alloc_tag_add_check(ref, tag);
> > -       if (!ref || !tag)
> > -               return;
> > -
>
> Unfortunately this change will result in __alloc_tag_ref_set() and
> alloc_tag_ref_set() missing the following important check

Correct, and therefore this patch is a good fix.

> from alloc_tag_sub_check():
>
> WARN_ONCE(ref && ref->ct,
>   "alloc_tag was not cleared (got tag for %s:%u)\n",
>   ref->ct->filename, ref->ct->lineno);
>
> I think the change below would fix this issue without the above
> mentioned side-effect:

I had this in my mind too when I first saw this patch earlier today.

> -static inline void __alloc_tag_ref_set(union codetag_ref *ref, struct
> alloc_tag *tag)
> +static inline bool __alloc_tag_ref_set(union codetag_ref *ref, struct
> alloc_tag *tag)
>  {
>         alloc_tag_add_check(ref, tag);
>         if (!ref || !tag)
> -                return;
> +                return false;
>
>         ref->ct =3D &tag->ct;
> +        return true;
>  }
>
> -static inline void alloc_tag_ref_set(union codetag_ref *ref, struct
> alloc_tag *tag)
> +static inline bool alloc_tag_ref_set(union codetag_ref *ref, struct
> alloc_tag *tag)
>  {
> -        __alloc_tag_ref_set(ref, tag);
> +        if (unlikely(!__alloc_tag_ref_set(ref, tag)))
> +                return false;
> +
>         /*
>          * We need in increment the call counter every time we have a new
>          * allocation or when we split a large allocation into smaller on=
es.
>          * Each new reference for every sub-allocation needs to increment=
 call
>          * counter because when we free each part the counter will be
> decremented.
>          */
>         this_cpu_inc(tag->counters->calls);
> +        return true;
>  }
>
>  static inline void alloc_tag_add(union codetag_ref *ref, struct
> alloc_tag *tag, size_t bytes)
>  {
> -        alloc_tag_ref_set(ref, tag);
> -        this_cpu_add(tag->counters->bytes, bytes);
> +        if (likely(alloc_tag_ref_set(ref, tag)))
> +                this_cpu_add(tag->counters->bytes, bytes);
>  }
>
> Could you please confirm this fix?

After that, please feel free to add

Acked-by: Yu Zhao <yuzhao@google.com>

(Of course with Suggested-by: Suren).


> Thanks,
> Suren.
>
> >         ref->ct =3D &tag->ct;
> >  }
> >
> > @@ -158,6 +154,10 @@ static inline void alloc_tag_ref_set(union codetag=
_ref *ref, struct alloc_tag *t
> >
> >  static inline void alloc_tag_add(union codetag_ref *ref, struct alloc_=
tag *tag, size_t bytes)
> >  {
> > +       alloc_tag_add_check(ref, tag);
> > +       if (!ref || !tag)
> > +               return;
> > +
> >         alloc_tag_ref_set(ref, tag);
> >         this_cpu_add(tag->counters->bytes, bytes);
> >  }
> > --
> > 2.25.1
> >

