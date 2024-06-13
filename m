Return-Path: <linux-kernel+bounces-212890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE139067D9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD822289C01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC9813E04A;
	Thu, 13 Jun 2024 08:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTxXsssk"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478413E036
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268894; cv=none; b=NZ8/MinB5RpJqeq9LXNd83THzjHrM8gMF0C9M/+AtSWgaV/9Q+QfoyrO/Lb3fX+UFMZBuwRmqr+eN2bfjGmvcuAMDnhjokSlMaJAWdmNsR1OAw+d2mKCuJIFBu7u5Txo8nvDnMYpnKQulVfr67WwY73nzOqvEVE8dxKLh557MNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268894; c=relaxed/simple;
	bh=w3c++bE92mjoUTBy6ui0MjrF7z2S+BQxrMh1kRI8r+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ixw+T+GAMpbt9/1HD1Lfdh55w7MmM39Kba35Oh3a/fdZ1+GAyREjl9o8VsSzCmsP5BpWGz6j7gYMrF631q1R1qoILmrrPZQvzfWirZP1nFXl+/o2DczGurB2CZRClsA5Bm5QsMwdUh6GLx679yr8M24rzOUPAm9YtZM8hZRz0jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTxXsssk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c73a3b3d7so624691a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 01:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718268891; x=1718873691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBp2kHYj7n2BHev/+gQZZjKm6K2+dc661niSqj6ZNLM=;
        b=kTxXssskbczZ/Oqk8lCYkHRdhPoh7UQJbAoyULP2seUuLfwJT/00eYBPnwxbHoM7PE
         l3Ky2BUPnuYJMsaylboNLpZRxnYav9Z7/2VTLeYrn1ETggKppkNLoJJrziNQ3vLPSj3T
         NVY8nCn+KWkbVa84tbbWJOo7381jehpzd1HzPLTeCWopjBSPxyjl3VAz96yWrQBlEsnb
         Jb9ngJxGZW5Awi1kpRJZuntt22adguVk0naWg55HudcU7Sx464Kfa+cW7ShH4CtKe+WI
         VJf8gnMz6aa4xEZ0Ze/fRA6lkLnnu0Tzi0X8UU6uAMR6Ja6HHXpAHSbdGpVIZBLX1Krz
         ytGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718268891; x=1718873691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBp2kHYj7n2BHev/+gQZZjKm6K2+dc661niSqj6ZNLM=;
        b=jv/Ue2+/6iPDRGNl26qv8GllGYe+IWukgsaL6RO0X8mZHZY2eFyn0UdcO4uoU5jGyQ
         1IVYtOgx32vPx8g/puOv+0zTtUvMjqxAExezX6uaovqTWiskt2AnRiWkJhyEJwWTy/mW
         CKSQ5lmJq8Z7lvzsNhHTfRHfbJWrC0f92BnZXoHibABBXnDwhg0iBn5ctM5Fb8UOE2I7
         DDkvyZobviJ+KVXYQ1bGRkollDnHzp5hH3iBLtXQPAJG1d9zOIYmuHOPrUxyTQf1iFVg
         O4Do+KCUVUpj+04EIlIi6p5IXWCs4+Cw1+Nxv/vaSLVMy07XJ3018P9MPmK351oc3OEY
         UKPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXG7kYAGFP82pKbs3CH91XuE1NM2IH/gydh4/t3sozIMtIQgbcEf+LQRHP0XMqEdj/DULxToREHu5O6m8ZguSm8bNhyK/zaVtNcMOe
X-Gm-Message-State: AOJu0Yzu2NFKqWcgMQMXwIrGbpl9ZOGZKsjoDHs0hsvcq8C6s661jHj0
	m8HGE23zyWXjHptEiJnsI01/HntUVXFNqRCduMqg89/dFv8IijqyAIfd/ggwOlNJoom3RXfSWEp
	iM7lrq7YnMmzROrp8gFJ4nZ1Q00Y=
X-Google-Smtp-Source: AGHT+IEwoe0EZaXf2PrzoKl8chusq2h4Z4pgkoaMd1lJq7IJtqO/rZQGTBpSkdFC3XbRdmQJaT5hP993q0PSngJXOS0=
X-Received: by 2002:a50:9557:0:b0:57c:740a:c4e4 with SMTP id
 4fb4d7f45d1cf-57ca976ace5mr2623522a12.25.1718268890474; Thu, 13 Jun 2024
 01:54:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610120209.66311-1-ioworker0@gmail.com> <20240610120209.66311-3-ioworker0@gmail.com>
 <b0d551a9-ee70-46a7-a0d6-c422f0baf91e@redhat.com>
In-Reply-To: <b0d551a9-ee70-46a7-a0d6-c422f0baf91e@redhat.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 13 Jun 2024 16:54:39 +0800
Message-ID: <CAK1f24mZk8hKDSPk+y7fP=cLoTuWxGaju_JqnKd_6BYQbZr6zg@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] mm/rmap: add helper to restart pgtable walk on changes
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org, 
	baolin.wang@linux.alibaba.com, maskray@google.com, ziy@nvidia.com, 
	ryan.roberts@arm.com, 21cnbao@gmail.com, mhocko@suse.com, 
	fengwei.yin@intel.com, zokeefe@google.com, shy828301@gmail.com, 
	xiehuan09@gmail.com, libang.li@antgroup.com, wangkefeng.wang@huawei.com, 
	songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 4:30=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 10.06.24 14:02, Lance Yang wrote:
> > Introduce the page_vma_mapped_walk_restart() helper to handle scenarios
> > where the page table walk needs to be restarted due to changes in the p=
age
> > table, such as when a PMD is split. It releases the PTL held during the
> > previous walk and resets the state, allowing a new walk to start at the
> > current address stored in pvmw->address.
> >
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lance Yang <ioworker0@gmail.com>
> > ---
> >   include/linux/rmap.h | 22 ++++++++++++++++++++++
> >   1 file changed, 22 insertions(+)
> >
> > diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> > index 7229b9baf20d..5f18509610cc 100644
> > --- a/include/linux/rmap.h
> > +++ b/include/linux/rmap.h
> > @@ -710,6 +710,28 @@ static inline void page_vma_mapped_walk_done(struc=
t page_vma_mapped_walk *pvmw)
> >               spin_unlock(pvmw->ptl);
> >   }
> >
> > +/**
> > + * page_vma_mapped_walk_restart - Restart the page table walk.
> > + * @pvmw: Pointer to struct page_vma_mapped_walk.
> > + *
> > + * It restarts the page table walk when changes occur in the page
> > + * table, such as splitting a PMD. Ensures that the PTL held during
> > + * the previous walk is released and resets the state to allow for
> > + * a new walk starting at the current address stored in pvmw->address.
> > + */
> > +static inline void
> > +page_vma_mapped_walk_restart(struct page_vma_mapped_walk *pvmw)
> > +{
> > +     WARN_ON_ONCE(!pvmw->pmd);
>
> Can we have this more general, like
>
> WARN_ON_ONCE(!pvmw->pmd && !pvmw->pte);

Sure, let=E2=80=99s make it more general.

>
> And then setting both to NULL below?
>
>
> > +     WARN_ON_ONCE(!pvmw->ptl);
>
> This is confusing: you check for ptl below. What would be clearer is
>
> if (likely(pvmw->ptl))
>         spin_unlock(pvmw->ptl);
> else
>         WARN_ON_ONCE(1);

Will adjust as you suggested, thanks!

>
>
> > +
> > +     if (pvmw->ptl)
> > +             spin_unlock(pvmw->ptl);
> > +
> > +     pvmw->ptl =3D NULL;
> > +     pvmw->pmd =3D NULL;
> > +}
> > +
> >   bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
> >
> >   /*
>
> I'd suggest squashing that into the next patch.

Got it.

Thanks,
Lance

>
> --
> Cheers,
>
> David / dhildenb
>

