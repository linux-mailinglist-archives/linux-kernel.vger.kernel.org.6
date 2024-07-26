Return-Path: <linux-kernel+bounces-262767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A85B893CC73
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 03:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340A61F22356
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1C817E9;
	Fri, 26 Jul 2024 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuOcD7YB"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852EEC5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957504; cv=none; b=ocgQces5EjCkyhyit6sxu7uaeZChpzsJamPog7PfqDN7MrHdUCu2rX2D94Wrlu55/BsBOSUAaLZlqABl/SwLDYfPNXH5CtIhOxjsJ5ffBvFN3PpF3Ak435wBLap/YgbD0AzRfuxfM1VkkBgAEor+IeUV0sg+fYdeQZOynkCbYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957504; c=relaxed/simple;
	bh=Jr+MlIU2peMu43l2wTAuwGBg+9b52oX6EBSsXgSobwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgBZGOtSdzHNhI8IAe1GbNDg7zH7P/4B7jhEFlfcbaJiIUK/J5AFjaorZCAj7+AQgJtrl2ljWLPRgKQrtYjKCiRJN/UTVxalUvsPj449HKVsp7H0JCoLBD+FuC3r15mRuourUUnwfxTKofvRMbA+yyLwcuNcGhzM2+nE9bmEvrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuOcD7YB; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-821b8d887b8so46622241.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721957501; x=1722562301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YghOf0p5Z5aY+HS5FcJlRDILUlgv3pFmY/AoP2dscpw=;
        b=SuOcD7YBViAQcUCVm1vLACinCvcoBsfdh8PjnBNBoS4oP6ya0zHcINCux7Bxs7jjT2
         0WQGbPWnz6s4p+72rY291HRuvPZ33pj7sItH8oafhnxkiI1ezPmt3TFpI1Bks+PMRYCq
         GLfdPkFtW5IJr/ILdGyadOHflLwTMvgyylTvGeYzV/Fl3y56ztWHCdZStdsl3rhdKBl3
         DBWQMCfz8QoaN8TGe1syU9WagO+IrS7wKOCIs6C97VsCZBAYmbdtMBThcpGGDU/f0pJ0
         jXQWMQi7UJUcOy30a5zbo2bEKnF9gqIeAoB/EOzTpRIkuPLir5V9AWVaNYNTuFf654tE
         2xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721957501; x=1722562301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YghOf0p5Z5aY+HS5FcJlRDILUlgv3pFmY/AoP2dscpw=;
        b=ogowd5wCpVoF+13kGp2dv5y1dWUOHwRMGgT0BK3n+DYd2db/n1DqvQ8QPvyJDns3zS
         PhjXcPF+8k+acF9lBOIc92IjhXQt+y2J53uzjY4D9D0axT0Sm6MBKfGuFQDNvKGPaMvP
         fRDlb5MA9zh/XrDXP8zPxM8/UUXEJrIjwHv1+VC1VFw295L5Dqp186Er8e87BlvaD3EZ
         DMOgW0PmFTA6lw/+ogssghob8HrRKqq6k25Py5YpZvJFbyBORTqpe88nyczBRdrDZSXa
         2zCfHkzzchU02Acfra2PdPEHf8sqo45SCl4uoxNA2ckGi9vFOU45JDjw5pRBd0ciTYYZ
         rZTA==
X-Forwarded-Encrypted: i=1; AJvYcCUAl0PAD60p8LwBEMIU7A2RmS6fnQta/clNM5S4wSslNR/GDTSdSDTPRp/AgxF7H3HXwqLjEmtKHYQjSxJ8lNA6+nOwXQSOJs/QGX+o
X-Gm-Message-State: AOJu0Yzio1de4LbkUDfZT1VrwSaDu8l2JYO8174tmp5MGpFG+VIXJjF/
	vAZotFJKmaoZhDy/NGJXUOtz6THXLFzCsjRoBx7IGgVKPgVZzPLLN+Dy6M6jQjJuxEv9yJ5gXTw
	vVawqufh7At6KHZkKQrDXdPbHtDI=
X-Google-Smtp-Source: AGHT+IE01g9g/PxfWypF0RlO9mu3/XLFJtUcH4DlX4BmUmad4SyrAWOG3jcuEXAki2FW1Ve3+Enmjmk42oFxvyt6a6E=
X-Received: by 2002:a05:6102:2c19:b0:48f:450b:2ea6 with SMTP id
 ada2fe7eead31-493d64d1612mr5214219137.31.1721957501178; Thu, 25 Jul 2024
 18:31:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725035318.471-1-hailong.liu@oppo.com> <ZqI5V+5E3RNhuSwx@MiWiFi-R3L-srv>
 <20240725164003.ft6huabwa5dqoy2g@oppo.com>
In-Reply-To: <20240725164003.ft6huabwa5dqoy2g@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 26 Jul 2024 13:31:30 +1200
Message-ID: <CAGsJ_4wxgm8DCYbyeZgrmUuNVSX-mOV-oc8Ws=hO8Fgu8xvuyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/vmalloc: fix incorrect __vmap_pages_range_noflush()
 if vm_area_alloc_pages() from high order fallback to order0
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Baoquan He <bhe@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, 
	Matthew Wilcox <willy@infradead.org>, Tangquan Zheng <zhengtangquan@oppo.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 4:40=E2=80=AFAM Hailong Liu <hailong.liu@oppo.com> =
wrote:
>
> On Thu, 25. Jul 19:39, Baoquan He wrote:
> > On 07/25/24 at 11:53am, hailong.liu@oppo.com wrote:
> > > From: "Hailong.Liu" <hailong.liu@oppo.com>
> > >
> > > The scenario where the issue occurs is as follows:
> > > CONFIG: vmap_allow_huge =3D true && 2M is for PMD_SIZE
> > > kvmalloc(2M, __GFP_NOFAIL|GFP_XXX)
> > >     __vmalloc_node_range(vm_flags=3DVM_ALLOW_HUGE_VMAP)
> > >         vm_area_alloc_pages(order=3D9) --->allocs order9 failed and f=
allback to order0
> > >                                         and phys_addr is aligned with=
 PMD_SIZE
> > >             vmap_pages_range
> > >                 vmap_pages_range_noflush
> > >                     __vmap_pages_range_noflush(page_shift =3D 21) ---=
-> incorrect vmap *huge* here
> > >
> > > In fact, as long as page_shift is not equal to PAGE_SHIFT, there
> > > might be issues with the __vmap_pages_range_noflush().
> > >
> > > The patch also remove VM_ALLOW_HUGE_VMAP in kvmalloc_node(), There
> > > are several reasons for this:
> > > - This increases memory footprint because ALIGNMENT.
> > > - This increases the likelihood of kvmalloc allocation failures.
> > > - Without this it fixes the origin issue of kvmalloc with __GFP_NOFAI=
L may return NULL.
> > > Besides if drivers want to vmap huge, user vmalloc_huge instead.
> >
> > Seem there are two issues you are folding into one patch:
> Got it. I will separate in the next version.
>
> >
> > one is the wrong informatin passed into __vmap_pages_range_noflush();
> > the other is you want to take off VM_ALLOW_HUGE_VMAP on kvmalloc().
> >
> > About the 1st one, do you think below draft is OK to you?
> >
> > Pass out the fall back order and adjust the order and shift for later
> > usage, mainly for vmap_pages_range().
> >
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 260897b21b11..5ee9ae518f3d 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -3508,9 +3508,9 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
> >
> >  static inline unsigned int
> >  vm_area_alloc_pages(gfp_t gfp, int nid,
> > -             unsigned int order, unsigned int nr_pages, struct page **=
pages)
> > +             unsigned int *page_order, unsigned int nr_pages, struct p=
age **pages)
> >  {
> > -     unsigned int nr_allocated =3D 0;
> > +     unsigned int nr_allocated =3D 0, order =3D *page_order;
> >       gfp_t alloc_gfp =3D gfp;
> >       bool nofail =3D gfp & __GFP_NOFAIL;
> >       struct page *page;
> > @@ -3611,6 +3611,7 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
> >               cond_resched();
> >               nr_allocated +=3D 1U << order;
> >       }
> > +     *page_order =3D order;
> >
> >       return nr_allocated;
> >  }
> > @@ -3654,7 +3655,7 @@ static void *__vmalloc_area_node(struct vm_struct=
 *area, gfp_t gfp_mask,
> >       page_order =3D vm_area_page_order(area);
> >
> >       area->nr_pages =3D vm_area_alloc_pages(gfp_mask | __GFP_NOWARN,
> > -             node, page_order, nr_small_pages, area->pages);
> > +             node, &page_order, nr_small_pages, area->pages);
> >
> >       atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
> >       if (gfp_mask & __GFP_ACCOUNT) {
> > @@ -3686,6 +3687,10 @@ static void *__vmalloc_area_node(struct vm_struc=
t *area, gfp_t gfp_mask,
> >               goto fail;
> >       }
> >
> > +
> > +     set_vm_area_page_order(area, page_order);
> > +     page_shift =3D page_order + PAGE_SHIFT;
> > +
> >       /*
> >        * page tables allocations ignore external gfp mask, enforce it
> >        * by the scope API
> >
> The logic of this patch is somewhat similar to my first one. If high orde=
r
> allocation fails, it will go normal mapping.
>
> However I also save the fallback position. The ones before this position =
are
> used for huge mapping, the ones >=3D position for normal mapping as Barry=
 said.
> "support the combination of PMD and PTE mapping". this  will take some
> times as it needs to address the corner cases and do some tests.
>
> IMO, the draft can fix the current issue, it also does not have significa=
nt side
> effects. Barry, what do you think about this patch? If you think it's oka=
y,
> I will split this patch into two: one to remove the VM_ALLOW_HUGE_VMAP an=
d the
> other to address the current mapping issue.

Yes, it's acceptable, even though it's not perfect. However,
addressing the mapping
issues is an urgent requirement. Memory corruption is currently
occurring, and we
need to ensure the fix reaches the stable kernel and mainline as soon
as possible.

Removing VM_ALLOW_HUGE_VMAP in kvmalloc is not as urgent. with Baoquan's
patch, we can even extend the fallback to non-nofail case. then maybe we ca=
n
remain VM_ALLOW_HUGE_VMAP of kvmalloc. This at least fixes one problem of
kvmalloc: we are likely to fail because it is really difficult to get
2MB contiguous
memory from buddy while memory is fragmented.

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index caf032f0bd69..6f47b01cbe2e 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3585,11 +3585,11 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
                else
                        page =3D alloc_pages_node_noprof(nid, alloc_gfp, or=
der);
                if (unlikely(!page)) {
-                       if (!nofail)
+                       if (!nofail && order =3D=3D 0)
                                break;
-
+                       if (nofail)
+                               alloc_gfp |=3D __GFP_NOFAIL;
                        /* fall back to the zero order allocations */
-                       alloc_gfp |=3D __GFP_NOFAIL;
                        order =3D 0;
                        continue;
                }

Other two optimizations can be deferred tasks
1. to save memory=E2=80=94such as avoiding allocating 4MB when users reques=
t 2.1MB
with kvmalloc.

2. to do mixed and adaptive mapping, for example, for the 2.1kvmalloc,
 * if the first 2MB is contiguous, we map the 0~2MB as PMD and 2MB~2.1MB as=
 PTE;
 * if the first 2MB is not contiguous, we map the whole 0~2.1MB as PTE

>
> --
> help you, help me,
> Hailong.

Thanks
Barry

