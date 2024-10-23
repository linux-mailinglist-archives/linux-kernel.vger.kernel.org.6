Return-Path: <linux-kernel+bounces-377203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691499ABB39
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 03:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8E92845D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503D381BA;
	Wed, 23 Oct 2024 01:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="10eXvid8"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B531798C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648699; cv=none; b=W0gec8zsKHoaJb85NUo36SL8YavnHlaOhOkn7teVkA7iTZ9FDYpZYkAnefeIKe7rXciDw6LQXNhJlVW8UZErtLH3XeAFAVG++4xyTsz76lYsqPC9malenLlyVwoxnkXb+NeZ4M2dt+cufuiIIKK6GQJdHU8HhN3y/hrYaxHK5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648699; c=relaxed/simple;
	bh=sjXYwAuVhvLjlf70ZwFYWsEH5rWc0KU1Z4c55IXe4tE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syC/5kiFaFrs11x8XpJN+4saaKJ1y816rAoM+eL+3/Hy7BsSFpSIlf58Cpdpmb/3dJrUYKKtps9QdTJw35qa6/2ob69K3jA3PIPCI1CG60BukjRuoQzdT7Qtwyw8HrwKgTQ15Ztge89uOR9vz6EeHUDNGK6hWmsr+svpyLoj8FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=10eXvid8; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-460a8d1a9b7so87911cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 18:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729648696; x=1730253496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qul5hLmQAu+fWVlqGFGYgtVKdRyN4ZhOl3zbp5Ssux4=;
        b=10eXvid8ajNgajTPglj+JLoNgJQACFh2aXlm6Awrej/KQLE3Uz6+fGCjiwXfCaU8RW
         bVTPeitP4MdluTcTOlDkyij0VjVMakfRawOERANzdDcgSNgsZRnP+bnIQ6pus2OvvGUT
         LibvCvHMdj0eOrgzA+1ssSqpfzn6DpAKcTVYvLqyRzjjEkeH+algQmRLCAI70Ec7TRq9
         mWlXc6v3/KzwQ+L9mXs07U2kkXDfz6JaG5m3qsSjrwwhsn1wHjz7BPF/PSjN+mA/Bv0j
         T403/o7b4o5mZp04/KQx0ZuBOVHz4LKk3TPUOFR12AnN2ty/TB2jwY7AaNMo7bl5EdTK
         2tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729648696; x=1730253496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qul5hLmQAu+fWVlqGFGYgtVKdRyN4ZhOl3zbp5Ssux4=;
        b=aCTZb7Uqeua1ILQKg62KzfdEm0G9wjZch53dqEOsdHcR1MowSVsF2CgER5mdVgjcH2
         8AxinShel2bRvDwc3kUytRpzv/K4Rtu1FYfGpG4ZA+6Hqo4D0/ox44iI+SUofdjZNIj+
         wntCuy8UIIvmdeH5+2FvmSdtJfXgrWzwOsQZ3k9Xvl3clU6zufXoxknoRKj6/gg2ml/2
         MvAv4MX5FyE0OACQuIK6l2ANWM+dGhEb4LY6jm6G96SChymmbc65mbT3+4NDBLGRE5Bk
         7LacvtOkGqp/Cw5AkOpfCN4eccfbvW3iTzlgRSK1ypZ4z8YKbd1UQXXsW03IzsEVQ5ND
         SZGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCWT769J70FPCR5VtiJgu37tX6JtE+UKjh1x1kmVt4Z9Wy3FoOmgn2r2rBWiFZML6/yYVtEZ0SwM7tT1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxefqdm6NRhKCk6sbTjI0r9IB//GzvB8FTiIV1wrf/q+CLWeqbQ
	8E/pa4BCFtvbxds6/V5Xs0eAWocl0ao2/n8gsSQ3POrZfWx4MLtg9Bi87CMBv3GS52GSuTPbMQX
	rcHewyiZlFbZ6RsIDFpN930AMxPVc/GeTcSo4
X-Google-Smtp-Source: AGHT+IEXNDm0BLPjKfpJzKU5ks7mDQGYPygYIIjU5CoGy8C32YDo/LicyZhWjZFCdyr9c69s0t6/gbsD4i/CuS9Mrf8=
X-Received: by 2002:a05:622a:2986:b0:460:afbd:4101 with SMTP id
 d75a77b69052e-46113afa5c2mr1823401cf.4.1729648696304; Tue, 22 Oct 2024
 18:58:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_C1486E2FA393F0B97DD7D308336E262A3407@qq.com>
 <CAJuCfpEpxa=jPAZiu5OP=jwQw0awiYDv6x5sz6-BAmAK40iJ6w@mail.gmail.com>
 <f2b0d4a1-6603-4f46-79bf-5edf40429d4b@linux.dev> <e283001d-c6f4-49f8-aca6-4e9826d45c9a@suse.cz>
 <32f70816-1678-d6ab-0db1-6412ff7a7333@linux.dev>
In-Reply-To: <32f70816-1678-d6ab-0db1-6412ff7a7333@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 22 Oct 2024 18:58:02 -0700
Message-ID: <CAJuCfpHxrN_12h3pmK6Z+k7W1_6QWgAym9xgczcKTjYyLQ+S_Q@mail.gmail.com>
Subject: Re: [PATCH] slub/slub_kunit:fix a panic due to __kmalloc_cache_noprof
 incorretly use
To: Hao Ge <hao.ge@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, xiaopeitux@foxmail.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, yuzhao@google.com, 
	xiaopei01@kylinos.cn, gehao@kylinso.cn, xiongxin@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 6:47=E2=80=AFPM Hao Ge <hao.ge@linux.dev> wrote:
>
>
> On 10/22/24 23:27, Vlastimil Babka wrote:
> > On 10/22/24 04:19, Hao Ge wrote:
> >> On 10/22/24 01:42, Suren Baghdasaryan wrote:
> >>> On Sun, Oct 20, 2024 at 11:59=E2=80=AFPM <xiaopeitux@foxmail.com> wro=
te:
> >>>> From: Pei Xiao <xiaopei01@kylinos.cn>
> >>>>
> >>>> 'modprobe slub_kunit',will have a panic.The root cause is that
> >>>> __kmalloc_cache_noprof was directly ,which resulted in no alloc_tag
> >>>> being allocated.This caused current->alloc_tag to be null,leading to
> >>>> a null pointer dereference in alloc_tag_ref_set.
> >>> I think the root cause of this crash is the bug that is fixed by
> >>> https://lore.kernel.org/all/20241020070819.307944-1-hao.ge@linux.dev/=
.
> >>> Do you get this crash if you apply that fix?
> >> Yes, this patch has resolved the panic issue.
> >>>> Here is the log for the panic:
> >>>> [   74.779373][ T2158] Unable to handle kernel NULL pointer derefere=
nce at virtual address 0000000000000020
> >>>> [   74.780130][ T2158] Mem abort info:
> >>>> [   74.780406][ T2158]   ESR =3D 0x0000000096000004
> >>>> [   74.780756][ T2158]   EC =3D 0x25: DABT (current EL), IL =3D 32 b=
its
> >>>> [   74.781225][ T2158]   SET =3D 0, FnV =3D 0
> >>>> [   74.781529][ T2158]   EA =3D 0, S1PTW =3D 0
> >>>> [   74.781836][ T2158]   FSC =3D 0x04: level 0 translation fault
> >>>> [   74.782288][ T2158] Data abort info:
> >>>> [   74.782577][ T2158]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x0=
0000000
> >>>> [   74.783068][ T2158]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =
=3D 0
> >>>> [   74.783533][ T2158]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, X=
s =3D 0
> >>>> [   74.784010][ T2158] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00=
00000105f34000
> >>>> [   74.784586][ T2158] [0000000000000020] pgd=3D0000000000000000, p4=
d=3D0000000000000000
> >>>> [   74.785293][ T2158] Internal error: Oops: 0000000096000004 [#1] S=
MP
> >>>> [   74.785805][ T2158] Modules linked in: slub_kunit kunit ip6t_rpfi=
lter ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_conntrack ebta=
ble_nat ebtable_broute ip6table_nat ip6table_mangle 4
> >>>> [   74.790661][ T2158] CPU: 0 UID: 0 PID: 2158 Comm: kunit_try_catch=
 Kdump: loaded Tainted: G        W        N 6.12.0-rc3+ #2
> >>>> [   74.791535][ T2158] Tainted: [W]=3DWARN, [N]=3DTEST
> >>>> [   74.791889][ T2158] Hardware name: QEMU KVM Virtual Machine, BIOS=
 0.0.0 02/06/2015
> >>>> [   74.792479][ T2158] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -D=
IT -SSBS BTYPE=3D--)
> >>>> [   74.793101][ T2158] pc : alloc_tagging_slab_alloc_hook+0x120/0x27=
0
> >>>> [   74.793607][ T2158] lr : alloc_tagging_slab_alloc_hook+0x120/0x27=
0
> >>>>
> >>>> [   74.794095][ T2158] sp : ffff800084d33cd0
> >>>> [   74.794418][ T2158] x29: ffff800084d33cd0 x28: 0000000000000000 x=
27: 0000000000000000
> >>>> [   74.795095][ T2158] x26: 0000000000000000 x25: 0000000000000012 x=
24: ffff80007b30e314
> >>>> [   74.795822][ T2158] x23: ffff000390ff6f10 x22: 0000000000000000 x=
21: 0000000000000088
> >>>> [   74.796555][ T2158] x20: ffff000390285840 x19: fffffd7fc3ef7830 x=
18: ffffffffffffffff
> >>>> [   74.797283][ T2158] x17: ffff8000800e63b4 x16: ffff80007b33afc4 x=
15: ffff800081654c00
> >>>> [   74.798011][ T2158] x14: 0000000000000000 x13: 205d383531325420 x=
12: 5b5d383734363537
> >>>> [   74.798744][ T2158] x11: ffff800084d337e0 x10: 000000000000005d x=
9 : 00000000ffffffd0
> >>>> [   74.799476][ T2158] x8 : 7f7f7f7f7f7f7f7f x7 : ffff80008219d188 x=
6 : c0000000ffff7fff
> >>>> [   74.800206][ T2158] x5 : ffff0003fdbc9208 x4 : ffff800081edd188 x=
3 : 0000000000000001
> >>>> [   74.800932][ T2158] x2 : 0beaa6dee1ac5a00 x1 : 0beaa6dee1ac5a00 x=
0 : ffff80037c2cb000
> >>>> [   74.801656][ T2158] Call trace:
> >>>> [   74.801954][ T2158]  alloc_tagging_slab_alloc_hook+0x120/0x270
> >>>> [   74.802494][ T2158]  __kmalloc_cache_noprof+0x148/0x33c
> >>>> [   74.802976][ T2158]  test_kmalloc_redzone_access+0x4c/0x104 [slub=
_kunit]
> >>>> [   74.803607][ T2158]  kunit_try_run_case+0x70/0x17c [kunit]
> >>>> [   74.804124][ T2158]  kunit_generic_run_threadfn_adapter+0x2c/0x4c=
 [kunit]
> >>>> [   74.804768][ T2158]  kthread+0x10c/0x118
> >>>> [   74.805141][ T2158]  ret_from_fork+0x10/0x20
> >>>> [   74.805540][ T2158] Code: b9400a80 11000400 b9000a80 97ffd858 (f9=
4012d3)
> >>>> [   74.806176][ T2158] SMP: stopping secondary CPUs
> >>>> [   74.808130][ T2158] Starting crashdump kernel...
> >>>>
> >>> CC'ing Vlastimil.
> >>> This patch essentially reverts Vlastimil's "mm, slab: don't wrap
> >>> internal functions with alloc_hooks()" change. Please check why that
> >>> change was needed before proceeding.
> >>> If this change is indeed needed, please add:
> >> Hi Suren and Vlastimil
> >>
> >> In fact, besides the panic, there is also a warning here due to direct=
ly
> >> invoking__kmalloc_cache_noprof
> >>
> >> Regarding this, do you have any suggestions?
> >>
> >> [58162.947016] WARNING: CPU: 2 PID: 6210 at
> >> ./include/linux/alloc_tag.h:125 alloc_tagging_slab_alloc_hook+0x268/0x=
27c
> >> [58162.957721] Call trace:
> >> [58162.957919]  alloc_tagging_slab_alloc_hook+0x268/0x27c
> >> [58162.958286]  __kmalloc_cache_noprof+0x14c/0x344
> >> [58162.958615]  test_kmalloc_redzone_access+0x50/0x10c [slub_kunit]
> >> [58162.959045]  kunit_try_run_case+0x74/0x184 [kunit]
> >> [58162.959401]  kunit_generic_run_threadfn_adapter+0x2c/0x4c [kunit]
> >> [58162.959841]  kthread+0x10c/0x118
> >> [58162.960093]  ret_from_fork+0x10/0x20
> >> [58162.960363] ---[ end trace 0000000000000000 ]---
> > I see.
> > The kunit test is the only user of __kmalloc_cache_noprof outside of km=
alloc()
> > itself so it's not worth defining again a wrapper for everyone, how abo=
ut just
> > wrapping the two callsites?
> >
> > --- a/lib/slub_kunit.c
> > +++ b/lib/slub_kunit.c
> > @@ -141,7 +141,7 @@ static void test_kmalloc_redzone_access(struct kuni=
t *test)
> >   {
> >          struct kmem_cache *s =3D test_kmem_cache_create("TestSlub_RZ_k=
malloc", 32,
> >                                  SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_=
ZONE);
> > -       u8 *p =3D __kmalloc_cache_noprof(s, GFP_KERNEL, 18);
> > +       u8 *p =3D alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 18)=
);
> >
> >          kasan_disable_current();
> >
> > @@ -199,7 +199,7 @@ static void test_krealloc_redzone_zeroing(struct ku=
nit *test)
> >          struct kmem_cache *s =3D test_kmem_cache_create("TestSlub_krea=
lloc", 64,
> >                                  SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_=
ZONE);
> >
> > -       p =3D __kmalloc_cache_noprof(s, GFP_KERNEL, 48);
> > +       p =3D alloc_hooks(__kmalloc_cache_noprof(s, GFP_KERNEL, 48));
> >          memset(p, 0xff, 48);
> >
> >          kasan_disable_current();
> >
> Hi  Vlastimil
>
> I agree with your point of view, thank you for you and Suren's help and
> suggestion.

That seems reasonable to me. Thanks!

>
> Best regards
>
> Hao
>

