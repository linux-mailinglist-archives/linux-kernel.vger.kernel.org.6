Return-Path: <linux-kernel+bounces-400283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E229C0B69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBAD31F209E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C72215F72;
	Thu,  7 Nov 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O085Sl9r"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB7420EA3B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730996213; cv=none; b=aCl2CJdPUTonznto/YxBA5k6zKrAbe+zOeHYXJgCW72B8sqE+RiBQlihXYOubGgnkG/i6rTjnHiebEbBnZQoNgJCHKcCa++93yd4JKFNhHfErqjODITMiozbqPeuFoc7q3Twveeo+Feo+sOqZjLSIvRGdKNWzTbI10yOl/SW1Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730996213; c=relaxed/simple;
	bh=jdA0w2R5p4Lb0XNo82V9w5/w2t9S4oTeJM20f4R3Gk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMmF8VKKKMIgcsAmpX+rVeratfB5paJlHmJC+D/6Y2aSgo1iSnagJhiQl08VBii5DDUE4Y42oHZk+T0ZTbv6flYveRtl2i+m5zqiBF0pp0Nn0r8kX7EIzwZyNVfbfjnwY3bNjkmDK51CyGxj3UU196/N64+hAaK0ECY+oMGX1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O085Sl9r; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-460969c49f2so297201cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 08:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730996211; x=1731601011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d7z6Lde7rc2jYVf1JsvE5SFBGPQWI7mywzWdmLwwJ60=;
        b=O085Sl9rx7KZqqOuotQq1AcrK2m3jz7Cbwx1g1IOZDBxXPY/1e2im+SsshGaBnBAaR
         GDxH1lve62lHjUltquKq85IiYIIZEyctHbvu8Y5wz1F724ElBrLIkA7V5bWT7qFCmHze
         VAQblY8vvpOVJR9c7fASwYM2xQcEV4IdawIaNtndFyTcLlJGSo0RBloSx2BhHq4mzhpV
         owKIZCSWkvM47Rp4ieyjUe5ZcPTjIiTYfpt55pNi4t4K7BVegMxkvw7pzpXrglo9ruJk
         UFYKmag/wgQKlwRxDPg+MF/TqphylbKtts3mFaVuQjel8aA3pKtA1BnZ9jwrGR1xR3r6
         ePYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730996211; x=1731601011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d7z6Lde7rc2jYVf1JsvE5SFBGPQWI7mywzWdmLwwJ60=;
        b=tjCSB4pLaXxmVROCbRQIJqf0TVUCcC5C8nMKTEG7J4xDuatr0gnlFm44dSQg4TmIxE
         6j5DNsaU6Bh78jcGOCXAXiMIZ+Jsi0OFxHq0SPSVlpQxS8+ddLHvrGCzjYj6c808xNZY
         PnpZ1sSihLOkNe/ZzR/dp/x2/djmfwqjImprjjr5Bxe9NiA8ndIpsSAnzLZQQd0sveE0
         dREsZZM5v1sx/ULRPxIG661tQszzFZ0anieTMkpKjlv0aCm5S0APFDefGGIOpzLLpCk4
         s9WtTu+oZFiF7aav6j8qu3pThrilK/4oUkua5uvb/mpTL62RF0txLfnaBREPoo4eU7Tr
         pocw==
X-Forwarded-Encrypted: i=1; AJvYcCXYuozfxCNK8za2/pfnCoRkdih5pr6gQCPW96mIJWDXQi7aGPmEK1uAt/CJ/X/jmW3ZrRQki+h9mFDV0c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgTRopQz37pIYjz2tF8qcwBQ1s2SMGaSHB6SGjwgn4JY5xsMQI
	JgYTEQUlbuV08TYRg3kKFdWil2dvVhJ5WY/P3ZGpVDekTWqxukLErJoBAZUdwjaqNwZMc2sOHPD
	nnSefVYUjhmU3XK8oAVTx0JZd50hE0BgxrslJ
X-Gm-Gg: ASbGncslVHnoh/+cLihnzwOz61hggZhcHrG5xDxoC/CwtYtwjqb97/FIwrnZz1DYfsQ
	WRzA7S+eQcmUwwRsr4ByL0UdWIyGm/3aE5OPMEAgzRxPIDYbHzjIy3SAyX2aq
X-Google-Smtp-Source: AGHT+IGXkDiDi+fucesm+R5FbXdyU5GmXy/NwIQ2Wvo8J7Rb5eVN1ojToWaCf6Y7rzc6U2BQBed/bDyE/19AhV0YMQk=
X-Received: by 2002:a05:622a:5488:b0:461:31b8:d203 with SMTP id
 d75a77b69052e-462fa55cc46mr4612071cf.3.1730996210441; Thu, 07 Nov 2024
 08:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107040239.2847143-1-cmllamas@google.com> <20241107040239.2847143-9-cmllamas@google.com>
In-Reply-To: <20241107040239.2847143-9-cmllamas@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 7 Nov 2024 08:16:39 -0800
Message-ID: <CAJuCfpHM8J0S4dXhxmVuFSTUV0czg1CTFpf_C=k7M57T9qh-VQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] binder: use per-vma lock in page installation
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Barry Song <v-songbaohua@oppo.com>, Hillf Danton <hdanton@sina.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 8:03=E2=80=AFPM Carlos Llamas <cmllamas@google.com> =
wrote:
>
> Use per-vma locking for concurrent page installations, this minimizes
> contention with unrelated vmas improving performance. The mmap_lock is
> still acquired when needed though, e.g. before get_user_pages_remote().
>
> Many thanks to Barry Song who posted a similar approach [1].
>
> Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.co=
m/ [1]
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 85 +++++++++++++++++++++++-----------
>  1 file changed, 57 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_allo=
c.c
> index 814435a2601a..debfa541e01b 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -233,6 +233,56 @@ static inline bool binder_alloc_is_mapped(struct bin=
der_alloc *alloc)
>         return smp_load_acquire(&alloc->mapped);
>  }
>
> +static struct page *binder_page_lookup(struct mm_struct *mm,

Maybe pass "struct binder_alloc" in both binder_page_lookup() and
binder_page_insert()?
I like how previous code stabilized mm with mmget_not_zero() once vs
now binder_page_lookup() and binder_page_insert() have to mmget/mmput
individually. Not a big deal but looked cleaner.

> +                                      unsigned long addr)
> +{
> +       struct page *page;
> +       long ret;
> +
> +       if (!mmget_not_zero(mm))
> +               return NULL;
> +
> +       mmap_read_lock(mm);
> +       ret =3D get_user_pages_remote(mm, addr, 1, 0, &page, NULL);
> +       mmap_read_unlock(mm);
> +       mmput_async(mm);
> +
> +       return ret > 0 ? page : NULL;
> +}
> +
> +static int binder_page_insert(struct binder_alloc *alloc,
> +                             unsigned long addr,
> +                             struct page *page)
> +{
> +       struct mm_struct *mm =3D alloc->mm;
> +       struct vm_area_struct *vma;
> +       int ret =3D -ESRCH;
> +
> +       if (!mmget_not_zero(mm))
> +               return -ESRCH;
> +
> +       /* attempt per-vma lock first */
> +       vma =3D lock_vma_under_rcu(mm, addr);
> +       if (!vma)
> +               goto lock_mmap;
> +
> +       if (binder_alloc_is_mapped(alloc))

I don't think you need this check here. lock_vma_under_rcu() ensures
that the VMA was not detached from the tree after locking the VMA, so
if you got a VMA it's in the tree and it can't be removed (because
it's locked). remove_vma()->vma_close()->vma->vm_ops->close() is
called after VMA gets detached from the tree and that won't happen
while VMA is locked. So, if lock_vma_under_rcu() returns a VMA,
binder_alloc_is_mapped() has to always return true. A WARN_ON() check
here to ensure that might be a better option.

> +               ret =3D vm_insert_page(vma, addr, page);
> +       vma_end_read(vma);
> +       goto done;

I think the code would be more readable without these jumps:

        vma =3D lock_vma_under_rcu(mm, addr);
        if (vma) {
               if (!WARN_ON(!binder_alloc_is_mapped(alloc)))
                       ret =3D vm_insert_page(vma, addr, page);
               vma_end_read(vma);
        } else {
               /* fall back to mmap_lock */
               mmap_read_lock(mm);
               vma =3D vma_lookup(mm, addr);
               if (vma && binder_alloc_is_mapped(alloc))
                       ret =3D vm_insert_page(vma, addr, page);
               mmap_read_unlock(mm);
        }
        mmput_async(mm);
        return ret;


> +
> +lock_mmap:
> +       /* fall back to mmap_lock */
> +       mmap_read_lock(mm);
> +       vma =3D vma_lookup(mm, addr);
> +       if (vma && binder_alloc_is_mapped(alloc))
> +               ret =3D vm_insert_page(vma, addr, page);
> +       mmap_read_unlock(mm);
> +done:
> +       mmput_async(mm);
> +       return ret;
> +}
> +
>  static struct page *binder_page_alloc(struct binder_alloc *alloc,
>                                       unsigned long index,
>                                       unsigned long addr)
> @@ -254,31 +304,14 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
>                                       unsigned long index,
>                                       unsigned long addr)
>  {
> -       struct vm_area_struct *vma;
>         struct page *page;
> -       long npages;
>         int ret;
>
> -       if (!mmget_not_zero(alloc->mm))
> -               return -ESRCH;
> -
>         page =3D binder_page_alloc(alloc, index, addr);
> -       if (!page) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> -
> -       mmap_read_lock(alloc->mm);
> -       vma =3D vma_lookup(alloc->mm, addr);
> -       if (!vma || !binder_alloc_is_mapped(alloc)) {
> -               mmap_read_unlock(alloc->mm);
> -               __free_page(page);
> -               pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> -               ret =3D -ESRCH;
> -               goto out;
> -       }
> +       if (!page)
> +               return -ENOMEM;
>
> -       ret =3D vm_insert_page(vma, addr, page);
> +       ret =3D binder_page_insert(alloc, addr, page);
>         switch (ret) {
>         case -EBUSY:
>                 /*
> @@ -288,12 +321,11 @@ static int binder_install_single_page(struct binder=
_alloc *alloc,
>                  */
>                 ret =3D 0;
>                 __free_page(page);
> -               npages =3D get_user_pages_remote(alloc->mm, addr, 1, 0, &=
page, NULL);
> -               if (npages <=3D 0) {
> +               page =3D binder_page_lookup(alloc->mm, addr);
> +               if (!page) {
>                         pr_err("%d: failed to find page at offset %lx\n",
>                                alloc->pid, addr - alloc->vm_start);
> -                       ret =3D -ESRCH;
> -                       break;
> +                       return -ESRCH;
>                 }
>                 fallthrough;
>         case 0:
> @@ -304,12 +336,9 @@ static int binder_install_single_page(struct binder_=
alloc *alloc,
>                 __free_page(page);
>                 pr_err("%d: %s failed to insert page at offset %lx with %=
d\n",
>                        alloc->pid, __func__, addr - alloc->vm_start, ret)=
;
> -               ret =3D -ENOMEM;
>                 break;
>         }
> -       mmap_read_unlock(alloc->mm);
> -out:
> -       mmput_async(alloc->mm);
> +
>         return ret;
>  }
>
> --
> 2.47.0.199.ga7371fff76-goog
>

