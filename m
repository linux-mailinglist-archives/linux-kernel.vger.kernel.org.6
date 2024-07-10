Return-Path: <linux-kernel+bounces-248002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1207A92D749
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364321C210CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9660619538C;
	Wed, 10 Jul 2024 17:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OvQsihz8"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FB334545
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631695; cv=none; b=HEjGZbt2iWkhbCwS3pKBH4PQpR3ZVNipc6DayMVmD72yzS7IHdMVivdIQLRdXEuJWtAjteDgDCWglHT+/A+al5I+0OJYcwsBrkxAmz3rItbFRViFuXEw2g9eHLwUR8Bvz1jOPQUPRuVdk3D8uDt5FDYXqwTsty32Xw5DrsLCiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631695; c=relaxed/simple;
	bh=c8NYHOSn9mRFWbG1Z55tFMk36XEfBEQbkNjlVbPdkAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Niav+sl9QCbgzPrBSMkeIBXozAKKHq4QGN3AIw9laMBvIF4qhdvAU1K1vb0+w3Xbu49M/IbU+VqEzEuXYR5EKz2DkKy/lKIXNmN1sXZHD+NkraT3N0+mwVZAQ84lqwjEY+yg8zX+cUvV4/KAsvJ5yWvAU0nJvLVrInSuhnWYEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OvQsihz8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-651961563d6so56667607b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720631693; x=1721236493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZZPZ6oc0vtM3vYVsL/GSe7en3bxgVNx9RbpRjGxJ6E=;
        b=OvQsihz8rkvu5FejKGjAaXjpC9yrvkcCN18/wWn0ywyjLId+vsFxapchk+J2xBWRtp
         YM2G7dupNZeu/1XqHjFILa7k3RUrWdpcRmp9FhgCVwziSX3vMUzPW1wFqFfNSid4+n+c
         wkv6SiJx7e4hicdWBh6XF3ghe9wa8STUy5Vw+Ia2gNiuSm8TwZgj9AkZQxRvrqwNtJz5
         8LcJ0vCAYSxWpKcpfSiCUtov7oEiM0CNJU17nWbvu0eMvZV0r74BGMTb/xpB8lw9M/s6
         oKIRUViiRl/50v/S3LTOCelVwzKvNq/ONdjorysNgY5lENKKiiV0aqOrapERNSi39Rmv
         ygJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720631693; x=1721236493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZZPZ6oc0vtM3vYVsL/GSe7en3bxgVNx9RbpRjGxJ6E=;
        b=sfbv2F2Ku18KZ1xLVHWFQMFkgx8ES5CNnLqwdZUqCtP1BWN4HHBhyUbHO5xK9JIG/D
         SvJUKyLdyPHkjl7cWGaS+J8pNe65LhUp0fWdEqgISaJkWA26/0cWVlL7gdykFyKwvjTn
         yleStcQMwDDOdwNF2GPPnmsLJEkzUETJV4tFgYr1VIRIh3NT05uhfx+/LMXZp7mtSbvq
         wxEkBYhNXMdk1Wab07/imc7eyHvSClEkmugR+rHRSOOtQvfECnzFfeYdzZ6QL89MVZMf
         M2+IR9IcSqhVNgW91xweqeNhu/wPH4yTtWnhXqhceiH6/RyoFdp+RcfbQtejlmpIVyGW
         qw4w==
X-Forwarded-Encrypted: i=1; AJvYcCXTNwd/LFBty9cFyvzf9ACMfwQQH8XVia+sp1+Mxh+N12SEuRqOJ22ugtoOhIO63zPzT8awliCgmWuQSlKBsYDdeFLeMhN2bRotjfwu
X-Gm-Message-State: AOJu0Yzy+65fdXHeWaG184Bsgz3I4kym1eGjuUtkQ2FY3rxd/VPJGw6D
	gM629JL8DDUBLBSMTbMC7u5+r+68H16UgvgJCLk/OiTzDnbaqsZNDIoYldYN6VKFkNLXIsmxh5/
	/pIZnkZ0Ks+bdsW/j7GN9Lu9+g00GUUrS895H
X-Google-Smtp-Source: AGHT+IG2NhnN+Dg6I6aeTHBqWbKfK2cI2ohnx7SNaE7JqPa8xBFQMbyVqE+yoKfBNCrElYsWzTj2CkwPGVR5L2jc+VQ=
X-Received: by 2002:a05:690c:f14:b0:632:7161:d16c with SMTP id
 00721157ae682-658ef3411demr91348227b3.28.1720631692966; Wed, 10 Jul 2024
 10:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-13-Liam.Howlett@oracle.com> <44baee28-a626-4be6-98ed-f5473d99157c@lucifer.local>
In-Reply-To: <44baee28-a626-4be6-98ed-f5473d99157c@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 10 Jul 2024 10:14:42 -0700
Message-ID: <CAJuCfpHABTQoNXn4o0ZewLY7P+m2-BxO0b_87p21HeKrGqJ2xA@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] mm/mmap: Clean up unmap_region() argument list
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, 
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 1:33=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Jul 04, 2024 at 02:27:14PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > With the only caller to unmap_region() being the error path of
> > mmap_region(), the argument list can be significantly reduced.
> >
> > There is also no need to forward declare the static function any
> > longer.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mmap.c | 25 +++++++++----------------
> >  1 file changed, 9 insertions(+), 16 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 45443a53be76..5d458c5f080e 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -76,11 +76,6 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_AR=
CH_MMAP_RND_COMPAT_BITS;
> >  static bool ignore_rlimit_data;
> >  core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
> >
> > -static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> > -             struct vm_area_struct *vma, struct vm_area_struct *prev,
> > -             struct vm_area_struct *next, unsigned long start,
> > -             unsigned long end, unsigned long tree_end, bool mm_wr_loc=
ked);
> > -
> >  static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_fl=
ags)
> >  {
> >       return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
> > @@ -2398,22 +2393,21 @@ struct vm_area_struct *expand_stack(struct mm_s=
truct *mm, unsigned long addr)
> >   *
> >   * Called with the mm semaphore held.
> >   */
> > -static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
> > -             struct vm_area_struct *vma, struct vm_area_struct *prev,
> > -             struct vm_area_struct *next, unsigned long start,
> > -             unsigned long end, unsigned long tree_end, bool mm_wr_loc=
ked)
> > +static void unmap_region(struct ma_state *mas, struct vm_area_struct *=
vma,
> > +             struct vm_area_struct *prev, struct vm_area_struct *next)
> >  {
> > +     struct mm_struct *mm =3D vma->vm_mm;
> >       struct mmu_gather tlb;
> > -     unsigned long mt_start =3D mas->index;
> >
> >       lru_add_drain();
> >       tlb_gather_mmu(&tlb, mm);
> >       update_hiwater_rss(mm);
> > -     unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
> > -     mas_set(mas, mt_start);
>
> OK so the 'raise something in one patch only for it to be removed in the
> next' pattern continues :) more aesthetically plasing.
>
> > +     unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_en=
d,
> > +                /* mm_wr_locked =3D */ true);
> > +     mas_set(mas, vma->vm_end);
> >       free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_AD=
DRESS,
> > -                              next ? next->vm_start : USER_PGTABLES_CE=
ILING,
> > -                              mm_wr_locked);
> > +                   next ? next->vm_start : USER_PGTABLES_CEILING,
> > +                   /* mm_wr_locked =3D */ true);
> >       tlb_finish_mmu(&tlb);
> >  }
> >
> > @@ -3186,8 +3180,7 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
> >
> >               vma_iter_set(&vmi, vma->vm_end);
> >               /* Undo any partial mapping done by a device driver. */
> > -             unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start=
,
> > -                          vma->vm_end, vma->vm_end, true);
> > +             unmap_region(&vmi.mas, vma, prev, next);
> >       }
> >       if (writable_file_mapping)
> >               mapping_unmap_writable(file->f_mapping);
> > --
> > 2.43.0
> >
>
> Lovely reduction in parameters.
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

