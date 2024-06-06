Return-Path: <linux-kernel+bounces-205018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBD68FF639
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9F28794F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7678C96;
	Thu,  6 Jun 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWP4BbHq"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD01BDEF
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717707647; cv=none; b=qzLxSqedQRRSKEn9VfLsaw5d2p9wPgNjIDv1/OLXqqA4LDMDreD3Ww8Lq+CvOk3lwnAIeHRh0499kCWfJFHzEfIxczWOTP/G0HK3taeT2XaFqdTejqDrbcGJyXWhl1ekX6LW4LxjKu//IguuwUXbU2w7Va1PmvF5X6DCU1r+Ofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717707647; c=relaxed/simple;
	bh=vmK7m3jqRULb3qiu4kjw11C00ZZdOCR19TbVXR5IWcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVCrhmklr5ONtav267nKqCrqR1SY8rlqsO1OtPwgO5EZCUBloiDJ/fLp2J65mPrxnGv8FQh5hosCWVd97LT49vdXBNNT0j21OW+aAL2/hnX1OawYBEnbGlYpVam5Ij4u69LMg2nY2pgyUaapjlJaUhwYGIjmg+0k0vQvIJKWQw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWP4BbHq; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-80ad2893ae5so389615241.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717707644; x=1718312444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbT4Y3Y/h7wbsMDxOnKoTQqMWb5YcFDUKO9fnBN+XwE=;
        b=HWP4BbHqF6YDZgYFRlSBGE/7NUhYw8H8yTN+KVI9sn04l8M5rb4O9gWPKwq6i0/4yF
         YjzLfTV5tHEiE/eqYYqLjsSDFJHvDlaYrzbm83kikdRvLSwcIpg8KTDv2mmlRmwM4wXk
         J+hsGQPZpz4dAhRDD9lYZrrD3kUyhdCM/i15/kduVkMogZhhc2evIye1YUjpvL64fMfp
         MazncSiI0uvvhIZsrOwYdJzm82cjnyZkZrRKqhjdzU22fimnH33y2s+uAjTJF6Bu0Ytz
         TMP6GuE8hdzvMHD4qlXctOJ0GMYGFf+NZhLzXt7SG922bbJbdGynG3S5gDGCTn0XE0Wz
         AD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717707644; x=1718312444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lbT4Y3Y/h7wbsMDxOnKoTQqMWb5YcFDUKO9fnBN+XwE=;
        b=OBxxaM+F/0fQpFITLXXoKY7yV2cclknQXEThaxT+bpTH2c0ST46uKeOn1ZVa5Xq/W4
         lm5t5p1ipbUv5p/nBrWD9RvKC64yuR9GjaIsCSuLVqLoC54kln+mKtwf+Cw0LjNrFwx5
         tGouzZ3/MqUJ1Z7Yw8VrO5/AdA2U7ZCuINHk5/Hs2nolFbX7RPmUBTFABVPu8sX+cmGM
         6tjiKfTcc78RpvhCtoki1wQNhiY9E52LMqKvex2wYOY5BzOjSesEAq0Q1+B2xQSd01jV
         pgvVyTCrdbTjXhYMz5wr/Te6p4lhmGnTKEY4kzYo+my0HO+y2PligHvP77yqQVFjt+nT
         GNXw==
X-Forwarded-Encrypted: i=1; AJvYcCUeFz5t6MQ7M7S2fVqdKLzvx7aChm8BD24/Cu4JIacVd4DL50FFUDxwqJiFoFV5h4hbK2DXl3+M+ITze4o6UJNzGTDXZqMOkL/+n74u
X-Gm-Message-State: AOJu0YyWA8CK39cvxrdXNNS3OT9QmrIbGEqiJ6IxOR/cCc4yfW0Sppcm
	pQZs7XnJ7oudf7c0YRBhFiNRX+SBjxJuaFPq6DE0BgrLykCkkKXrca5BSLYuojiGUA1+oex5iQ2
	8DAhPSqOZ57vrR0qABjr/bX1FcOmT0XZ8
X-Google-Smtp-Source: AGHT+IF/5u5Baa4VRSA+h9ecC9KG95vBFCUol6RE+wcGpEiVT3tgGrNT8/lIIXLfb1GhipEd6Z7hDApzS1cjsbkxgkk=
X-Received: by 2002:a05:6102:3092:b0:48c:1157:2f58 with SMTP id
 ada2fe7eead31-48c275dd6edmr434522137.17.1717707644169; Thu, 06 Jun 2024
 14:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn> <51DED95F-832A-4836-AA81-556968F6B645@nvidia.com>
In-Reply-To: <51DED95F-832A-4836-AA81-556968F6B645@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 09:00:33 +1200
Message-ID: <CAGsJ_4w9cRZUEF7PaVjz1HQoUr1pxHEO15gpbsnAoJHMZG0djQ@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: Zi Yan <ziy@nvidia.com>
Cc: xu.xin16@zte.com.cn, david@redhat.com, v-songbaohua@oppo.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 2:35=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> +Matthew
>
> For mapping_large_folio_support() changes.
>
> On 6 Jun 2024, at 2:42, xu.xin16@zte.com.cn wrote:
>
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > When I did a large folios split test, a WARNING
> > "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> > was triggered. But the test cases are only for anonmous folios.
> > while mapping_large_folio_support() is only reasonable for page
> > cache folios.
> >
> > In split_huge_page_to_list_to_order(), the folio passed to
> > mapping_large_folio_support() maybe anonmous folio. The
> > folio_test_anon() check is missing. So the split of the anonmous THP
> > is failed. This is also the same for shmem_mapping(). We'd better add
> > a check for both. But the shmem_mapping() in __split_huge_page() is
> > not involved, as for anonmous folios, the end parameter is set to -1, s=
o
> > (head[i].index >=3D end) is always false. shmem_mapping() is not called=
.
> >
> > Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> > for anon mapping, So we can detect the wrong use more easily.
> >
> > THP folios maybe exist in the pagecache even the file system doesn't
> > support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> > is enabled, khugepaged will try to collapse read-only file-backed pages
> > to THP. But the mapping does not actually support multi order
> > large folios properly.
> >
> > Using /sys/kernel/debug/split_huge_pages to verify this, with this
> > patch, large anon THP is successfully split and the warning is ceased.
> >
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> >  include/linux/pagemap.h |  4 ++++
> >  mm/huge_memory.c        | 27 ++++++++++++++++-----------
> >  2 files changed, 20 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index ee633712bba0..59f1df0cde5a 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(struct=
 address_space *mapping)
> >   */
> >  static inline bool mapping_large_folio_support(struct address_space *m=
apping)
> >  {
> > +     /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache folios=
 */
> > +     VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> > +                     "Anonymous mapping always supports large folio");
> > +
> >       return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >               test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> >  }
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index 317de2afd371..62d57270b08e 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct pag=
e *page, struct list_head *list,
> >       if (new_order >=3D folio_order(folio))
> >               return -EINVAL;
> >
> > -     /* Cannot split anonymous THP to order-1 */
> > -     if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> > -             VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > -             return -EINVAL;
> > -     }
> > -
> > -     if (new_order) {
> > -             /* Only swapping a whole PMD-mapped folio is supported */
> > -             if (folio_test_swapcache(folio))
> > +     if (folio_test_anon(folio)) {
> > +             /* Cannot split anonymous THP to order-1 */
> > +             if (new_order =3D=3D 1) {
> > +                     VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> >                       return -EINVAL;
> > +             }
> > +     } else if (new_order) {
> >               /* Split shmem folio to non-zero order not supported */
> >               if (shmem_mapping(folio->mapping)) {
> >                       VM_WARN_ONCE(1,
> >                               "Cannot split shmem folio to non-0 order"=
);
> >                       return -EINVAL;
> >               }
> > -             /* No split if the file system does not support large fol=
io */
> > -             if (!mapping_large_folio_support(folio->mapping)) {
> > +             /* No split if the file system does not support large fol=
io.
> > +              * Note that we might still have THPs in such mappings du=
e to
> > +              * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the map=
ping
> > +              * does not actually support large folios properly.
> > +              */
> > +             if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> > +                     !mapping_large_folio_support(folio->mapping)) {
>
> Shouldn=E2=80=99t this be
>
> if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>         !mapping_large_folio_support(folio->mapping)) {
>
> ?
>
> When CONFIG_READ_ONLY_THP_FOR_FS is not set, we need to check
> mapping_large_folio_support(), otherwise we do not.

while CONFIG_READ_ONLY_THP_FOR_FS is not set, that is no way
a large folio can be mapped to a filesystem which doesn't support
large folio mapping. i think
if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) is correct.

The below means a BUG which has never a chance to happen if it
is true.

!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
        !mapping_large_folio_support(folio->mapping));

>
> >                       VM_WARN_ONCE(1,
> >                               "Cannot split file folio to non-0 order")=
;
> >                       return -EINVAL;
> >               }
> >       }
> >
> > +     /* Only swapping a whole PMD-mapped folio is supported */
> > +     if (folio_test_swapcache(folio) && new_order)
> > +             return -EINVAL;
> >
> >       is_hzp =3D is_huge_zero_folio(folio);
> >       if (is_hzp) {
> > --
> > 2.15.2
>
>
> Best Regards,
> Yan, Zi

Thanks
Barry

