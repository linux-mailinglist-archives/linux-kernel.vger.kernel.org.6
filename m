Return-Path: <linux-kernel+bounces-290349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31084955289
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1000283D6D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307B11C3F23;
	Fri, 16 Aug 2024 21:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+KtcFUj"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001508405D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844391; cv=none; b=omp6yZ29WzzWV8HK7/2wCil/MFyENQl2bw8g5zTQuu/rr1wKSECDATZa7RArDl4e0OTozudLlBrMRSVqtxCnjvaaCknClm8nX3r0wBRiLSb3fb7JI8M5atiuA1OORpco9ZfS4t/8A2XnrfmKGIQUkskb497t0xz49L93JAH+n3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844391; c=relaxed/simple;
	bh=854+cZA8HVPzmvJgUNcG3XBXvauB4RcvZN/LwKgaEfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6q/Du0QybljuyB8QERK7IjA1xBKExhi0/lA/HU9ZzJi8UQYH3EWewp36l/vpTZAH3qcNresn8AfYiPjh5i3aaRvAmqmMu/1TDEueMBp2u4w4GSk41FNXXWpYcTJ4v27WwTix1a5jo+vIJkCx3BN5M7pprGJWeHv8GLaxURi1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+KtcFUj; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-842f95b73daso839703241.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723844389; x=1724449189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fu54m1BE1Tp4feU+Pk2caY04Wi1lkN5b/KXo2lfdBc=;
        b=N+KtcFUjGRztXK/EK+5+NuD8fqBlLoW7I48tdU56EBFcS5c6tWtyDBEbhtnp0bFCLf
         Y0IUL2aQUKlxpDD8faPtKPz34h95RLppG7ZrkHKD7LC1yYef3Oabb9JDpy3rWjJU/sVA
         DHOptY6QEIpWLWiwJNR2EHHe741zyUuMeNO4E48xVg6ONJPE4PGvKR0xOCCWf0aAE0Gr
         H36e6/dKy0IDPjU8izwUbhJwJYb64SBeFNFezCB5V2BH8cP702ID7poKVyZwizfbE2Xb
         hsivTf13MSXhDzIGg9VosbEl9pc0qgf4EKQvtipMJvc+U5tBA2Ijo3woqP09mgii5eee
         0O+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723844389; x=1724449189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fu54m1BE1Tp4feU+Pk2caY04Wi1lkN5b/KXo2lfdBc=;
        b=EgNCVGevd6gzmK/eQtE7RRi1umb0Ai5uVx942iDOtsVpij8KrZNB+MDJp9rPLFf7Gi
         obw+wZYT+rR7rlzLg15lcrcIWeP4mQXxvty7WcBqjpCwwQpQIqJNRbWPLgbWYAKFn5fm
         fSrIlKWppBEEzI3LT2zFfAOvEot/TPrPfX3b/1yFpTedAvaPYmywPI8Rik7Nw+vP3dxL
         VQsN46t28trsL7X/G7ufFZVRsf3h6z7WChP8IkiuuJKtfroe/jCoXNMzWa4TrAm9CJXI
         FlDEfwHHmDrPOQgVpa6FGm50B9GG9Zvxmf/XBY0e4XIgIUFXkH3iAR0AO9R0TKhCfeQF
         4C3w==
X-Forwarded-Encrypted: i=1; AJvYcCUrzuvP41oN5Z/bB/vpm7qlC9IQY/3uddJBZqJ+PnMEaYfcsxQHyEoAQpEEZ31lb6w2T6LXZVEGYTZB9WWIY5Usmu2cVm7uCWkjA1pB
X-Gm-Message-State: AOJu0Yy2LLVwK2WzN9Nax5D0jsFgDoCaRYfgHww7/t36TReJ8vKHVjIu
	rC/HwVtO41BsrrI9+sOnGILWumUOoiVvVWZ+ZGfZDYP/u/Ds0tDFDka9MR+x1R20LZvXWyXzJGN
	4XRA60/S6//lBpP5WIeTyjYakqe0=
X-Google-Smtp-Source: AGHT+IE0EuNMhW9N8d57Iaz6zIYFlct7OmJF2QGdrCJ1xGYrXOCzVOkw98p7Pkb0c+BDIaGrMN7zTKlStB1cE7+mKuI=
X-Received: by 2002:a05:6122:4122:b0:4ef:5b2c:df41 with SMTP id
 71dfb90a1353d-4fc6c9a76a9mr5488807e0c.9.1723844388691; Fri, 16 Aug 2024
 14:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20ed69ad-5dad-446b-9f01-86ad8b1c67fa@huawei.com>
 <20240815230612.77266-1-21cnbao@gmail.com> <Zr_BydCiQInI0ZMz@casper.infradead.org>
In-Reply-To: <Zr_BydCiQInI0ZMz@casper.infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Sat, 17 Aug 2024 09:39:37 +1200
Message-ID: <CAGsJ_4xS7S4+8ajHCWhEPcaL9ZEPaWL-=E7vuzBQAPhCV1L0og@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] mm: support large folios swap-in for zRAM-like devices
To: Matthew Wilcox <willy@infradead.org>
Cc: wangkefeng.wang@huawei.com, akpm@linux-foundation.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hanchuanhua@oppo.com, hannes@cmpxchg.org, hch@infradead.org, hughd@google.com, 
	kaleshsingh@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ryncsn@gmail.com, senozhatsky@chromium.org, shakeel.butt@linux.dev, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	xiang@kernel.org, ying.huang@intel.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 9:17=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Aug 16, 2024 at 11:06:12AM +1200, Barry Song wrote:
> > When memcg approaches its limit, charging mTHP becomes difficult.
> > At this point, when the charge fails, we fallback to the next order
> > to avoid repeatedly retrying larger orders.
>
> Why do you always find the ugliest possible solution to a problem?
>

had definitely thought about charging order-0 as well in
alloc_swap_folio() when sending this
quick fix mainly for quick verification it can fix the problem. v7
will definitely charge order-0
in alloc_swap_folio().

> > @@ -4244,7 +4248,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                               }
> >                               need_clear_cache =3D true;
> >
> > -                             if (mem_cgroup_swapin_charge_folio(folio,
> > +                             if (nr_pages =3D=3D 1 && mem_cgroup_swapi=
n_charge_folio(folio,
> >                                                       vma->vm_mm, GFP_K=
ERNEL,
> >                                                       entry)) {
> >                                       ret =3D VM_FAULT_OOM;
>
> Just make alloc_swap_folio() always charge the folio, even for order-0.
>
> And you'll have to uncharge it in the swapcache_prepare() failure case.

I suppose this is done by folio_put() automatically.

Thanks
Barry

