Return-Path: <linux-kernel+bounces-205090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2888FF6F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EA1B26F9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6D913DBBE;
	Thu,  6 Jun 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHR3smTd"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229B713D8A0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 21:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709635; cv=none; b=g1Wj/5W6Vsh+88gz14abWgqCGlpxB6rwCaqbxzvpuVpdZH0qM/EpMgTg6WlH8R0qt6EIg9ZqMKhus33oUJ/IZZuaf7vvjroWiI6pIrno8Ff62SWA/OUl2nDadEVagrKSoKnGdQZWv/ZUNfuKXG9eE+4UCof64GawrTMo74hmEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709635; c=relaxed/simple;
	bh=bl6Q8nkiPHSSkriXbTCVWxpXKhPBGBfSU3OcD0PgMsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BuDNPZIE6oSwXMEApv3JddRxhQQtTrnhtBjMTXUCpdm9i9ZgBtH1yIW7N78RZNPtkTwe2uY8tfUtmDH8B26okla8yxW9YPQ9zSmSCIL0ydm78cSiGw1dRiC45172LhFbLsx8xZDQtaRgFlJ9uNfAvzrKvM01UnnLMZCMdGHqcfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHR3smTd; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4eb0c729c2eso404054e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 14:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709633; x=1718314433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENh6EmpxBzWS1RyJnWCwXYBRXkzIo8pjpUNY60CBW0M=;
        b=HHR3smTdV7aNLwhcL3K/4Y1o2NiUlo+SPShdLrshhFdBl7mhXdpb+ygBaf1xT/TP7m
         FYwTYMCJPZhWNWLNX4Txb4ySYhuAKtQ8C67ipLJLdxi9uoDg+yvApUr61Lp3xoJkL4ip
         1Cd2QnWhTCPX/AWh1Hpp+LM/5YumQgJe9lcMbYaf8unxytXkrm4BDBHTMciKWzcUt5V4
         tlYVkwXZP0QRss5zdsgkpbaIXaavFEOkDMxLMJqU3IrTUedxogUPH38LB/9rSAxzphw5
         VZJ7Xe9VkjCCQqLBPSYNCcEORXQusYSKEAeZXScd/6LzBOKanrM4wxLIv7hVDes+MqGs
         +dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709633; x=1718314433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENh6EmpxBzWS1RyJnWCwXYBRXkzIo8pjpUNY60CBW0M=;
        b=MjykUuXnXQYVLTtHBQvGjzATPUvy7BQAPKxZvJ/TS9L3z+C4SgrwN0BTPF8qyMiQOf
         Rvh9NXIkMSNam35SMm0OQs/cu8n1MxueM89mkTvDW9Q87RTQG/pKa0j/vlBlZgY471uI
         hxbvHyJREfzEyAsL2RjvKvUBmrhoGLjXP1tQSknDzKSxXAM5/VZFW+kqpDglj+rvRrct
         PTgPP111LKO+2DoLxGWmT+pIJ4FRsduN08xXaVA5cTprQ2CBdsYCcMwU4ikPPxPo0qC+
         9+iBZUB+4eDaLSIKY+I/iaDJGHtf8OhK5fQs1jIgHfD1oiF3CuI86FdV9aN/a/fONpIR
         Thxg==
X-Forwarded-Encrypted: i=1; AJvYcCUVew2EPlF3axNAWjxglv9SpI/8T0FHIvXQBaPmqV8pvl+Nd5Jlr3u2nqYYWR8RNbcRnFCfZewldSEy7sZkw7dgw/wEe/vyeEKR/+3Z
X-Gm-Message-State: AOJu0YwKz5qWNWF7gDhI0WWyhLNWzUtfMKRxiyVYOnT7yPVME0GgBfM5
	69me8DnyCC71I2oAMz1vPQf5WSBF8HUakXVbtwibqbq+PACdxOqeqG+i32fbBIbR3Axg7LgUpEK
	+WEQ7+TKpOqpmNaJry7KyNvZtFa0=
X-Google-Smtp-Source: AGHT+IE0+uM7qXu/RA+jEbZdc4cfBIOn2I55lHxR2NcB5mpJEcF1RcWblNNTj663LVKwR67OPlnWqxSyRWzSNbVzWrI=
X-Received: by 2002:a1f:cd87:0:b0:4e9:7f87:4c2b with SMTP id
 71dfb90a1353d-4eb5621cd6cmr876541e0c.3.1717709632786; Thu, 06 Jun 2024
 14:33:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606174203124_OW-VQZ_ZLm4lGEimA-K9@zte.com.cn>
 <51DED95F-832A-4836-AA81-556968F6B645@nvidia.com> <CAGsJ_4w9cRZUEF7PaVjz1HQoUr1pxHEO15gpbsnAoJHMZG0djQ@mail.gmail.com>
 <B7796F09-BAA6-4555-A9FE-F44DF1CBFA6F@nvidia.com>
In-Reply-To: <B7796F09-BAA6-4555-A9FE-F44DF1CBFA6F@nvidia.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 09:33:41 +1200
Message-ID: <CAGsJ_4xu9jfC7UWdOqP5_saEXRE26mo6Msx_=JGCKaWac57=BQ@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: Zi Yan <ziy@nvidia.com>
Cc: xu.xin16@zte.com.cn, david@redhat.com, v-songbaohua@oppo.com, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@kernel.org, yang.yang29@zte.com.cn, ran.xiaokai@zte.com.cn, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 9:24=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 6 Jun 2024, at 14:00, Barry Song wrote:
>
> > On Fri, Jun 7, 2024 at 2:35=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
> >>
> >> +Matthew
> >>
> >> For mapping_large_folio_support() changes.
> >>
> >> On 6 Jun 2024, at 2:42, xu.xin16@zte.com.cn wrote:
> >>
> >>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>>
> >>> When I did a large folios split test, a WARNING
> >>> "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> >>> was triggered. But the test cases are only for anonmous folios.
> >>> while mapping_large_folio_support() is only reasonable for page
> >>> cache folios.
> >>>
> >>> In split_huge_page_to_list_to_order(), the folio passed to
> >>> mapping_large_folio_support() maybe anonmous folio. The
> >>> folio_test_anon() check is missing. So the split of the anonmous THP
> >>> is failed. This is also the same for shmem_mapping(). We'd better add
> >>> a check for both. But the shmem_mapping() in __split_huge_page() is
> >>> not involved, as for anonmous folios, the end parameter is set to -1,=
 so
> >>> (head[i].index >=3D end) is always false. shmem_mapping() is not call=
ed.
> >>>
> >>> Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> >>> for anon mapping, So we can detect the wrong use more easily.
> >>>
> >>> THP folios maybe exist in the pagecache even the file system doesn't
> >>> support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> >>> is enabled, khugepaged will try to collapse read-only file-backed pag=
es
> >>> to THP. But the mapping does not actually support multi order
> >>> large folios properly.
> >>>
> >>> Using /sys/kernel/debug/split_huge_pages to verify this, with this
> >>> patch, large anon THP is successfully split and the warning is ceased=
.
> >>>
> >>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>> ---
> >>>  include/linux/pagemap.h |  4 ++++
> >>>  mm/huge_memory.c        | 27 ++++++++++++++++-----------
> >>>  2 files changed, 20 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> >>> index ee633712bba0..59f1df0cde5a 100644
> >>> --- a/include/linux/pagemap.h
> >>> +++ b/include/linux/pagemap.h
> >>> @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(stru=
ct address_space *mapping)
> >>>   */
> >>>  static inline bool mapping_large_folio_support(struct address_space =
*mapping)
> >>>  {
> >>> +     /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache foli=
os */
> >>> +     VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> >>> +                     "Anonymous mapping always supports large folio"=
);
> >>> +
> >>>       return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >>>               test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> >>>  }
> >>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >>> index 317de2afd371..62d57270b08e 100644
> >>> --- a/mm/huge_memory.c
> >>> +++ b/mm/huge_memory.c
> >>> @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
> >>>       if (new_order >=3D folio_order(folio))
> >>>               return -EINVAL;
> >>>
> >>> -     /* Cannot split anonymous THP to order-1 */
> >>> -     if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> >>> -             VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> >>> -             return -EINVAL;
> >>> -     }
> >>> -
> >>> -     if (new_order) {
> >>> -             /* Only swapping a whole PMD-mapped folio is supported =
*/
> >>> -             if (folio_test_swapcache(folio))
> >>> +     if (folio_test_anon(folio)) {
> >>> +             /* Cannot split anonymous THP to order-1 */
> >>> +             if (new_order =3D=3D 1) {
> >>> +                     VM_WARN_ONCE(1, "Cannot split to order-1 folio"=
);
> >>>                       return -EINVAL;
> >>> +             }
> >>> +     } else if (new_order) {
> >>>               /* Split shmem folio to non-zero order not supported */
> >>>               if (shmem_mapping(folio->mapping)) {
> >>>                       VM_WARN_ONCE(1,
> >>>                               "Cannot split shmem folio to non-0 orde=
r");
> >>>                       return -EINVAL;
> >>>               }
> >>> -             /* No split if the file system does not support large f=
olio */
> >>> -             if (!mapping_large_folio_support(folio->mapping)) {
> >>> +             /* No split if the file system does not support large f=
olio.
> >>> +              * Note that we might still have THPs in such mappings =
due to
> >>> +              * CONFIG_READ_ONLY_THP_FOR_FS. But in that case, the m=
apping
> >>> +              * does not actually support large folios properly.
> >>> +              */
> >>> +             if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> >>> +                     !mapping_large_folio_support(folio->mapping)) {
> >>
> >> Shouldn=E2=80=99t this be
> >>
> >> if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> >>         !mapping_large_folio_support(folio->mapping)) {
> >>
> >> ?
> >>
> >> When CONFIG_READ_ONLY_THP_FOR_FS is not set, we need to check
> >> mapping_large_folio_support(), otherwise we do not.
> >
> > while CONFIG_READ_ONLY_THP_FOR_FS is not set, that is no way
> > a large folio can be mapped to a filesystem which doesn't support
> > large folio mapping. i think
>
> That is why we have the warning below to catch this undesired
> case.
>
> > if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) is correct.
>
> When it is set, khugepaged can create a large pagecache folio
> on a filesystem without large folio support and the warning
> will be triggered once the created large pagecache folio
> is split. That is not what we want.

yes. This is exactly why we need if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS=
))
but not if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)) .

because if (!IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS)), folio is definitely
pointing to a file system supporting large folio. otherwise, it is a bug.

>
> >
> > The below means a BUG which has never a chance to happen if it
> > is true.
> >
> > !IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
> >         !mapping_large_folio_support(folio->mapping));
> >
> >>
> >>>                       VM_WARN_ONCE(1,
> >>>                               "Cannot split file folio to non-0 order=
");
> >>>                       return -EINVAL;
> >>>               }
> >>>       }
> >>>
> >>> +     /* Only swapping a whole PMD-mapped folio is supported */
> >>> +     if (folio_test_swapcache(folio) && new_order)
> >>> +             return -EINVAL;
> >>>
> >>>       is_hzp =3D is_huge_zero_folio(folio);
> >>>       if (is_hzp) {
> >>> --
> >>> 2.15.2
> >>
> >>
> >> Best Regards,
> >> Yan, Zi
> >
> > Thanks
> > Barry
>
>
> Best Regards,
> Yan, Zi

