Return-Path: <linux-kernel+bounces-248001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EE892D748
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECC91F21B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F619538C;
	Wed, 10 Jul 2024 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oML4VinS"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E02734545
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631689; cv=none; b=gYpqp+5QTbMW7CJPr8H5G+vrYDXhYxz7BEITBT6Kfamy66JHutm2fxjZ24AAHIpmGX0jmN42DBn10rRMgjarwy/vZdxum10r8qhBb8FUbKV1EvsloXDyMocem42704XJds+qnYqYQXPjWeePQ6XchhTz4QUCxjEKv/QZN1OJxgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631689; c=relaxed/simple;
	bh=z2C1c/7jgz/92ATJEDwGl+v8enOUT2l/t2cTuP/t+Sw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMPjv8yhFg6L6rtw4b3zCLlJ+iXwPN9uQHoYXwjqhtgNz2gywPJT0gjcHCpu+BOi7Qp172tDz83ftV+pOPO2QhpnyWI19jFx1ZhokOaKLVBYDtnwUqKT+c8wvCVVKhiIj1GUl7v2AaGDQrod2Hw3qQqdyNTghQz7+2duTzjmwBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oML4VinS; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65bceed88a2so7883287b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631687; x=1721236487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zxl2kkis+kjcyTxFXjBubE9OIoPPn2QmhQmRL9LDMpA=;
        b=oML4VinS96+wDYXD53GZPFEC5fu4kj3zniEMzu0MgTu6U8Z3OMlz8dawZE1iGOiRlV
         g0nHPjH0WUVRka4jRvmG0iRV8EC9mH525spXouvmpdgniu4EFBLw3c3Bd8r868tzYfXR
         1H8JsM5mTYwUzoOr3edPoaSSWinccFBe1PqDaJf63dQPEO+9pRKkxsZ/Mg8dRa4N3bSH
         lLgbWwWQx2mB7em6scTXYyUU5MP2B0LoFyZrcIGcevIdMAS+ef4O0YvRtzTN06eq+s3B
         iW7GS37l+o/FsMKPHgFWbU9/dgtuSJYJFAx9pDlW+P7mirJrtcI1wa4dGKjn9c7Ke9Tb
         JzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631687; x=1721236487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zxl2kkis+kjcyTxFXjBubE9OIoPPn2QmhQmRL9LDMpA=;
        b=fFOAvC8+oN6QgrsiA+6QVygFT7l+5eGriUD2evkAgubKYSn+H5CeNWTw6pf1/Eisto
         zqcx9ftDDU6vSifW7Nhbcbtfx538lJ3hGwOs3E4tTAGefAmBjrKPE4pP7F9gexCkCko8
         0WL4fPSNi21ebcPuVtDnvIKpHkxEXRuRLB62br8zgHKThdkxGUSNWFynFk4eJQzvf5IK
         qV2knKh/DeeMDipX4mg6Sb5cLndRZPWsynLuy1itbmnieQgUX4J1ntGSn8otkjGr1ht/
         zT6Ot4jcA/wQHSsJE+b6tH7uQsTJSkhwd65wh7aLxNRPvne8c51M+wtC8586HhOmQTlh
         zW5A==
X-Forwarded-Encrypted: i=1; AJvYcCVys3DmNyBbwHwaAj0E7Pw7dLWh7aHe/c8a+E2pRslzdQ8TBqnNLIg2kpVQi9iJZHHhXdj/3UjVaFOm3R9kBmxKznaWekU4JveeaoSp
X-Gm-Message-State: AOJu0YwI5I1/5jdsnW7i3pf9OEdNkxb9vJTLXNZia5Pwx8h3Ri7nC8E6
	j+V89r5IIfSUKy4XuBA5VbxnziVvcybS1EKjuiZOd5Y5JJL0Ryja/pz5laPb5yXf/DB3ae6pA5W
	S861ZvGid7qrGxur2mNbmg2e9d7Gl6amf0bid
X-Google-Smtp-Source: AGHT+IGApC8Pv8BfeUz/PxcB9I5vb5voVQrPZLkDp6gNRGlMNWMZwnIL5x2ugu2cR6eLBuhRfE6vaJmn5NZuZGQgGQo=
X-Received: by 2002:a81:8450:0:b0:627:dc03:575a with SMTP id
 00721157ae682-658f0fb31cemr64099237b3.49.1720631686957; Wed, 10 Jul 2024
 10:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-12-Liam.Howlett@oracle.com> <37ea5831-2163-4086-8b2c-baff3be2e5ad@lucifer.local>
In-Reply-To: <37ea5831-2163-4086-8b2c-baff3be2e5ad@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 10:14:32 -0700
Message-ID: <CAJuCfpGg7_CcfQJOSAhcdSVHJY-QTT0dz90nSC8PNgf+xp3cOQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/16] mm/mmap: Track start and end of munmap in vma_munmap_struct
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:27=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jul 04, 2024 at 02:27:13PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Set the start and end address for munmap when the prev and next are
> > gathered.  This is needed to avoid incorrect addresses being used durin=
g
> > the vms_complete_munmap_vmas() function if the prev/next vma are
> > expanded.
>
> When we spoke about this separately you mentioned that specific arches ma=
y
> be more likely to encounter this issue, perhaps worth mentioning somethin=
g
> about that in the commit msg? Unless I misunderstood you.
>
> >
> > Add a new helper vms_complete_pte_clear(), which is needed later and
> > will avoid growing the argument list to unmap_region() beyond the 9 it
> > already has.
>
> My word.
>
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/internal.h |  2 ++
> >  mm/mmap.c     | 34 +++++++++++++++++++++++++++-------
> >  2 files changed, 29 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 8cbbbe7d40f3..4c9f06669cc4 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1493,6 +1493,8 @@ struct vma_munmap_struct {
> >       struct list_head *uf;           /* Userfaultfd list_head */
> >       unsigned long start;            /* Aligned start addr */
> >       unsigned long end;              /* Aligned end addr */
> > +     unsigned long unmap_start;
> > +     unsigned long unmap_end;
> >       int vma_count;                  /* Number of vmas that will be re=
moved */
> >       unsigned long nr_pages;         /* Number of pages being removed =
*/
> >       unsigned long locked_vm;        /* Number of locked pages */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index ecf55d32e804..45443a53be76 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -525,6 +525,8 @@ static inline void init_vma_munmap(struct vma_munma=
p_struct *vms,
> >       vms->vma_count =3D 0;
> >       vms->nr_pages =3D vms->locked_vm =3D vms->nr_accounted =3D 0;
> >       vms->exec_vm =3D vms->stack_vm =3D vms->data_vm =3D 0;
> > +     vms->unmap_start =3D FIRST_USER_ADDRESS;
> > +     vms->unmap_end =3D USER_PGTABLES_CEILING;
> >  }
> >
> >  /*
> > @@ -2610,6 +2612,26 @@ static inline void abort_munmap_vmas(struct ma_s=
tate *mas_detach)
> >       __mt_destroy(mas_detach->tree);
> >  }
> >
> > +
> > +static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> > +             struct ma_state *mas_detach, bool mm_wr_locked)
> > +{
> > +     struct mmu_gather tlb;
> > +
> > +     /*
> > +      * We can free page tables without write-locking mmap_lock becaus=
e VMAs
> > +      * were isolated before we downgraded mmap_lock.
> > +      */
> > +     mas_set(mas_detach, 1);
> > +     lru_add_drain();
> > +     tlb_gather_mmu(&tlb, vms->mm);
> > +     update_hiwater_rss(vms->mm);
> > +     unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms-=
>vma_count, mm_wr_locked);
> > +     mas_set(mas_detach, 1);
>
> I know it's necessary as unmap_vmas() will adjust mas_detach, but it kind
> of aesthetically sucks to set it to 1, do some stuff, then set it to 1
> again. But this is not a big deal :>)
>
> > +     free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->=
unmap_end, mm_wr_locked);
>
> Yeah this bit definitely needs a comment I think, this is very confusing
> indeed. Under what circumstances will these differ from [vms->start,
> vms->end), etc.?
>
> I'm guessing it's to do with !vms->prev and !vms->next needing to be set =
to
> [FIRST_USER_ADDRESS, USER_PGTABLES_CEILING)?
>
> > +     tlb_finish_mmu(&tlb);
> > +}
> > +
> >  /*
> >   * vms_complete_munmap_vmas() - Finish the munmap() operation
> >   * @vms: The vma munmap struct
> > @@ -2631,13 +2653,7 @@ static void vms_complete_munmap_vmas(struct vma_=
munmap_struct *vms,
> >       if (vms->unlock)
> >               mmap_write_downgrade(mm);
> >
> > -     /*
> > -      * We can free page tables without write-locking mmap_lock becaus=
e VMAs
> > -      * were isolated before we downgraded mmap_lock.
> > -      */
> > -     mas_set(mas_detach, 1);
> > -     unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
> > -                  vms->start, vms->end, vms->vma_count, !vms->unlock);
> > +     vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> >       /* Update high watermark before we lower total_vm */
> >       update_hiwater_vm(mm);
> >       /* Stat accounting */
> > @@ -2699,6 +2715,8 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >                       goto start_split_failed;
> >       }
> >       vms->prev =3D vma_prev(vms->vmi);
> > +     if (vms->prev)
> > +             vms->unmap_start =3D vms->prev->vm_end;
> >
> >       /*
> >        * Detach a range of VMAs from the mm. Using next as a temp varia=
ble as
> > @@ -2757,6 +2775,8 @@ static int vms_gather_munmap_vmas(struct vma_munm=
ap_struct *vms,
> >       }
> >
> >       vms->next =3D vma_next(vms->vmi);
> > +     if (vms->next)
> > +             vms->unmap_end =3D vms->next->vm_start;
> >
> >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> >       /* Make sure no VMAs are about to be lost. */
> > --
> > 2.43.0
> >
>
> Other than wanting some extra comments, this looks fine and I know how
> hard-won the unmap range bit of this change was so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Ok, another case when code duplication will be removed in the next patch. L=
GTM.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

