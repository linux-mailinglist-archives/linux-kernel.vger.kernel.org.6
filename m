Return-Path: <linux-kernel+bounces-296682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFAA95ADB9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF421F23126
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E913AA2D;
	Thu, 22 Aug 2024 06:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SqVD5XTz"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F0249F9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308803; cv=none; b=AdNOkjK40hhApXpDTiv7bHrK3ySv7wMwUgWuEWoee8hpeJ7QnARAG5JawSgM9JKXeJNBqwcjdpAd8tw0x33pkYNHRKVHIHroMnaCjXRnwtHH15uMq7JgMHeRm7KJQ9XIsqSlDJ9gGmoF2f8bwXjCvFz7cK6CR9zkCmzdTFwzU/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308803; c=relaxed/simple;
	bh=tKfxE5U7DeTK3eywPBXzwKSzxiNZmqJnws5mhMNgBSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwx9pDsmiv3SRCjGc8nvHbzhQeqsH8q+HMEfl9huaRvZdC/qr4zIj/HIq3Cx0Rhi36uiVOcQ5yBGVhr3rALuMa+i3DkhQ0YaooqJSCvCrDElDyb3PctlV+dAhIzDGD2Kw4Tr4aR7b3r71arGffI0KmvlSxiIJLwuxJghCjiHhdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SqVD5XTz; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso598376e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 23:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724308800; x=1724913600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCVQDVF7en/QRnK1xIM7N8O/LMZFliQ8B1T6Dzt8Q7M=;
        b=SqVD5XTzuOiy3w3qaIAfL0BF7ECs/eplyWbo7+ORLcT94p7jlVZ+3fPv0kJpRfQ+Vs
         gEeQAo4M8g71tJfbAd9Nj4z/7eiZ3F7rN3bwooGM14Y08tG4DH/tgnYwsooci9MmEKQs
         EFXWQ8wbUli7vL57BRkvB06iwxWV+nT2ZiVI6ma6STugUwv27jDKQi/5QmasDXsaV/+k
         39hm7UVKaTRy61UZ89sLnEEfLjtz0qdV7A7NU9zdSz9Umq3hy+LA6mg8WljhhTFOF9n9
         r25egq86DMrO2LRacjLWJeihwGEOdeH8YevmVZl4Cb4xcZBnA7D8ROWP5EAwjigyI6Wi
         9azw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724308800; x=1724913600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCVQDVF7en/QRnK1xIM7N8O/LMZFliQ8B1T6Dzt8Q7M=;
        b=pGZwXOmFoTmplIwzW7ZjrfKiRDx7Fx/BrEZeC6cN5CF/8YAmMeSjG/wPxxnDibz5Vo
         DNI2/kPEdoUXzkmbb1mCX5y41leO25DXmNQY4fxsQj+nopSVqe/mwlvjb3tPuP64CZgQ
         vFwDdoG12sbwnpHxI3o0xLUNQGJG5zcwTyFOcuZNCNigb3ZRKtw2gMSV9nuv+ZN4bVLi
         P9WIJ2Dx/hXo+0UkVYR8sDG7hVnFaJOrqVdzZHw3n/T/qn9hG43swaVxitZL/mESmoWh
         2buYeg2k1ZB5caEurUhar5beVecGE7FGYlt6vZ/Cs3AWaVR+AIasVY6rZu2VRxWaJ0X5
         3JrA==
X-Forwarded-Encrypted: i=1; AJvYcCVyGofHPPy919C9YkOUWWtZZUr9Dle2HW3DTud6GnRUOUBlR/qaAJKLJH1d+Kq85S5N+uyE0tNzwntSH3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr4JEdRsicRJOsXpLhdjnumEln6DHXqQVpR6/kECUiyehqlJ9l
	RpI3SPxrqlYwn2myXqrM6Qr/Bpz4GUs86GkeRsZ4HdV74mQCJcpzENwABY6Vmsv1ETtYyY2dSeF
	OIWzEgivsipvYNqX/NCt5htlsXtUNtjrEX9PBj2E1l9G9BlXC
X-Google-Smtp-Source: AGHT+IFY36eHWfAP1XynkkC+LNEHHDuQ2xKBZLWRjR5by5IXkqnZjQHoJe+94UuXASK12H/Wxn6CnMh6K/TR6iCztAI=
X-Received: by 2002:a05:6512:3baa:b0:52c:e1cd:39b7 with SMTP id
 2adb3069b0e04-53348564ff3mr3085882e87.5.1724308799509; Wed, 21 Aug 2024
 23:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821135900.2199983-1-hezhongkun.hzk@bytedance.com>
 <ZsYBDGE-_8GPPEpE@tiehlicka> <CACSyD1OdKb4n1SrStdTfhwO0F1eBA5mNruxOeYKrhKP6+jTXAg@mail.gmail.com>
 <ZsbZsf2Z93_d9PQR@tiehlicka>
In-Reply-To: <ZsbZsf2Z93_d9PQR@tiehlicka>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Thu, 22 Aug 2024 14:39:47 +0800
Message-ID: <CACSyD1OjnPU_CLbu9QNkbN41cGFmdwuzT8Kg4340Fk0MuUk+0w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:page_alloc: fix the NULL ac->nodemask
 in __alloc_pages_slowpath()
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, mgorman@techsingularity.net, hannes@cmpxchg.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > > Are you suggesting that the problem is that should_reclaim_retry is
> > > iterating nodes which are not allowed by cpusets and that makes the
> > > retry loop happening more than unnecessary?
> >
> > Yes, exactly.
> >
> > >
> > > Is there any reason why you haven't done the same that the page
> > > allocator does in this case?
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index 28f80daf5c04..cbf09c0e3b8a 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -4098,6 +4098,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned =
order,
> > >                 unsigned long min_wmark =3D min_wmark_pages(zone);
> > >                 bool wmark;
> > >
> > > +               if (cpusets_enabled() &&
> > > +                       (alloc_flags & ALLOC_CPUSET) &&
> > > +                       !__cpuset_zone_allowed(zone, gfp_mask))
> > > +                               continue;
> > > +
> > >                 available =3D reclaimable =3D zone_reclaimable_pages(=
zone);
> > >                 available +=3D zone_page_state_snapshot(zone, NR_FREE=
_PAGES);
> > >
> >
> > That was my original version,  but I found that the problem exists in
> > other places.
> > Please see the function flow below.
> >
> > __alloc_pages_slowpath:
> >
> >   get_page_from_freelist
> >      __cpuset_zone_allowed /* check the node */
> >
> >   __alloc_pages_direct_reclaim
> >      shrink_zones
> >         cpuset_zone_allowed=EF=BC=88=EF=BC=89/* check the node */
> >
> >  __alloc_pages_direct_compact
> >    try_to_compact_pages
> >        /* do not check the cpuset_zone_allowed=EF=BC=88=EF=BC=89*/
> >
> >   should_reclaim_retry
> >   /* do not check the cpuset_zone_allowed=EF=BC=88=EF=BC=89*/
> >
> >   should_compact_retry
> >       compaction_zonelist_suitable
> >           /* do not check the cpuset_zone_allowed=EF=BC=88=EF=BC=89*/
> >
> > Should we add __cpuset_zone_allowed() checks in the three functions
> > listed above,
> > or should we set the nodemask in __alloc_pages_slowpath()  if it is emp=
ty
> > and the request comes from user space?
>
> cpuset integration into the page allocator is rather complex (check
> ALLOC_CPUSET) use. Reviewing your change is not an easy task to make
> sure all the subtlety is preserved. Therefore I would suggest addressing
> the specific issue you have found.
>

Got it=EF=BC=8Cthanks for your suggestion=EF=BC=8C i will send the next ver=
sion soon.

> --
> Michal Hocko
> SUSE Labs

