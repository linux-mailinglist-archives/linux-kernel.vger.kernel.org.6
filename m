Return-Path: <linux-kernel+bounces-205238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5208FF9DB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2463284F1C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F212E7E;
	Fri,  7 Jun 2024 02:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJL37RP4"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031C4C70
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 02:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717725662; cv=none; b=BzLjlvCjOyBusGR1j1PcVaoUYdzKZ9KgEYPbbieDkOD74nEUL9HZ/egWcwBoJuCw5i3/dG+RrEE/48yUzkABUE/6DbzF+DzphgraJ7DF0tyuvo+H1EWMwpuIn5mzjA9cpTRjUY442O8ZSQp+zlBBn7FXWrEZptcAqTr/s85uHZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717725662; c=relaxed/simple;
	bh=/xcGYKkMrmyvxXdQr0zjgzN8XMOZABCsWQiVdP7zNCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te43iEuldU/U+aZYKFKguFdqPpnrEZTSbFHHhNx3Jm7rYRmYyIna+VB//kCcdER635Ttpaf4DgvXiDU72sSAr1su2zzFDOihz72jJ+uTjNJGTvpzhasXuIREVdPPUjwLt6xSQ69OiKxFVGIJwY/fbSyX16K1oal3paw5hnXFYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJL37RP4; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4e1c721c040so598829e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 19:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717725659; x=1718330459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Peut3ZHW0CaxiZSEBfz/De33tzBSHWA6rV+eq1ptdg4=;
        b=dJL37RP4K/UuAFCrznfqqWJP4+30dWaIT+HP3qxWSIlWK+Y8ANBdZmb1RnsjNLW8+R
         hWGSAZS2W8Dl+A0ERCkTQQbzk3f/dhb264wwpOspwlefVkF4+H+CppwWrRaQQpJP5dCh
         bgdlRxCtYgGcUT9DZ/Q+78rMAe5wfFJDHC0yKHDaXoojl7fZqIp8QJC6JOVcrqghGCQB
         vjLdzRbb9epsPbJ6zeZYJe3c+GU2CBSlsb0hMfHjW1YNcyWRlZpl28RsN9Z6fB/fgO+l
         Yg3mi3jC8QadO0HZZ+xTPrbX+WHnAsVNdxxJ6L5glCwUcYyIR8COgdgZuFvSOXU6bGZe
         fOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717725659; x=1718330459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Peut3ZHW0CaxiZSEBfz/De33tzBSHWA6rV+eq1ptdg4=;
        b=ZzyJqTWWPQrZGJew18AtoOWq7nmVKO8pHpnzAt+XHSmbsL/6GrfWD4VZFadlZhViVg
         hJgqjSVMxh6+v8x6Zuq8G5YELCqJE+f7fO76yO/YApefXQJEWI4DVPjw/d9HUPDWAW4u
         8APMlGossNMkxMe+FNCbxOhKyCz2HoGoFNJftiQdOJLImZnCZbPIHN7TvwRb/q6Bsnf3
         fkba83o9pa5aXKKVGylc7igzuoeghzk0+TSRQxegNgWJ19fTTo21Z3ja6fJXcjARBxaK
         dGkJ4AXEWyh0dSQNLW9R4o5DmyWP3LkQa3soYQHygyBy7h1xjpb2cPAyTuTSzROtasd9
         78Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVDrQDAGcBDRKh5VGXfsl2aSL5JJ1ak8pGwVjeXNN2eFGIA7TpqhYziJa9OxuouPrEJN/d7i8OrLJUqPiaHlpAxXXRYMBJXZv7WQ+kz
X-Gm-Message-State: AOJu0Yy3XfFG5IPkFvnquTp0vomEBISf9An4lB88Cy9/HZOGc8X8IYNS
	NhAyu0HJNdzGSZFORSNXmjY2z42+uth3RMvHbSHnlBHnB1alpQ2INpVRvOZJtoA1+aWbFEujeP9
	9paJaV7LbYqIMi0DZUJKY4sUu4ko=
X-Google-Smtp-Source: AGHT+IFUxc/68yDjHSucpnbaL0dK7Iasec77dpQWlMEcXErUMAq18HXUUuZT1TlHReP7TBShY1UOOeoHrxoNh11v39A=
X-Received: by 2002:a1f:7d4e:0:b0:4ea:ede1:ab15 with SMTP id
 71dfb90a1353d-4eb562cd389mr1343760e0c.15.1717725659274; Thu, 06 Jun 2024
 19:00:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGsJ_4x=v0fDN_QVjdHSGVykH2+o_f81NnN_0-SUL+iwe+v84g@mail.gmail.com>
 <20240607013617.913054-1-ranxiaokai627@163.com>
In-Reply-To: <20240607013617.913054-1-ranxiaokai627@163.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 7 Jun 2024 14:00:47 +1200
Message-ID: <CAGsJ_4yt2eegrB5fDsGMZiirzhqNtnRGOOnhvrvv-0V=x_WG=A@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] mm: huge_memory: fix misused
 mapping_large_folio_support() for anon folios
To: ran xiaokai <ranxiaokai627@163.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@kernel.org, ran.xiaokai@zte.com.cn, 
	v-songbaohua@oppo.com, si.hao@zte.com.cn, xu.xin16@zte.com.cn, 
	yang.yang29@zte.com.cn, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 1:37=E2=80=AFPM ran xiaokai <ranxiaokai627@163.com> =
wrote:
>
> > > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > >
> > > When I did a large folios split test, a WARNING
> > > "[ 5059.122759][  T166] Cannot split file folio to non-0 order"
> > > was triggered. But the test cases are only for anonmous folios.
> > > while mapping_large_folio_support() is only reasonable for page
> > > cache folios.
> > >
> > > In split_huge_page_to_list_to_order(), the folio passed to
> > > mapping_large_folio_support() maybe anonmous folio. The
> > > folio_test_anon() check is missing. So the split of the anonmous THP
> > > is failed. This is also the same for shmem_mapping(). We'd better add
> > > a check for both. But the shmem_mapping() in __split_huge_page() is
> > > not involved, as for anonmous folios, the end parameter is set to -1,=
 so
> > > (head[i].index >=3D end) is always false. shmem_mapping() is not call=
ed.
> > >
> > > Also add a VM_WARN_ON_ONCE() in mapping_large_folio_support()
> > > for anon mapping, So we can detect the wrong use more easily.
> > >
> > > THP folios maybe exist in the pagecache even the file system doesn't
> > > support large folio, it is because when CONFIG_TRANSPARENT_HUGEPAGE
> > > is enabled, khugepaged will try to collapse read-only file-backed pag=
es
> > > to THP. But the mapping does not actually support multi order
> > > large folios properly.
> > >
> > > Using /sys/kernel/debug/split_huge_pages to verify this, with this
> > > patch, large anon THP is successfully split and the warning is ceased=
.
> > >
> > > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > > ---
> > >  include/linux/pagemap.h |  4 ++++
> > >  mm/huge_memory.c        | 27 ++++++++++++++++-----------
> > >  2 files changed, 20 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > > index ee633712bba0..59f1df0cde5a 100644
> > > --- a/include/linux/pagemap.h
> > > +++ b/include/linux/pagemap.h
> > > @@ -381,6 +381,10 @@ static inline void mapping_set_large_folios(stru=
ct address_space *mapping)
> > >   */
> > >  static inline bool mapping_large_folio_support(struct address_space =
*mapping)
> > >  {
> > > +       /* AS_LARGE_FOLIO_SUPPORT is only reasonable for pagecache fo=
lios */
> > > +       VM_WARN_ONCE((unsigned long)mapping & PAGE_MAPPING_ANON,
> > > +                       "Anonymous mapping always supports large foli=
o");
> > > +
> > >         return IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> > >                 test_bit(AS_LARGE_FOLIO_SUPPORT, &mapping->flags);
> > >  }
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 317de2afd371..62d57270b08e 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -3009,30 +3009,35 @@ int split_huge_page_to_list_to_order(struct p=
age *page, struct list_head *list,
> > >         if (new_order >=3D folio_order(folio))
> > >                 return -EINVAL;
> > >
> > > -       /* Cannot split anonymous THP to order-1 */
> > > -       if (new_order =3D=3D 1 && folio_test_anon(folio)) {
> > > -               VM_WARN_ONCE(1, "Cannot split to order-1 folio");
> > > -               return -EINVAL;
> > > -       }
> > > -
> > > -       if (new_order) {
> > > -               /* Only swapping a whole PMD-mapped folio is supporte=
d */
> > > -               if (folio_test_swapcache(folio))
> > > +       if (folio_test_anon(folio)) {
> > > +               /* Cannot split anonymous THP to order-1 */
> >
> > This is simply what the code is indicating. Shouldn't we phrase
> > it differently to explain "why" but not "how"? for example, anon
> > order-1 mTHP is not supported?
>
> Hi, Barry,
> Good comments, thanks.
> Is "order-1 is not a anonymouns mTHP suitable order." better?

could pick up some words from include/linux/huge_mm.h, particularly
those words regarding "a limitation of the THP implementation".

/*
 * Mask of all large folio orders supported for anonymous THP; all orders u=
p to
 * and including PMD_ORDER, except order-0 (which is not "huge") and order-=
1
 * (which is a limitation of the THP implementation).
 */
#define THP_ORDERS_ALL_ANON     ((BIT(PMD_ORDER + 1) - 1) & ~(BIT(0) | BIT(=
1)))

perhaps, you can even do

if (order > 0 && !(bit(order) & THP_ORDERS_ALL_ANON))
      return -EINVAL;

This is self-commented. Either way is fine.

>
> > Otherwise, it looks good to me.
> >
> > Reviewed-by: Barry Song <baohua@kernel.org>
>

Thanks
Barry

