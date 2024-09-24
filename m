Return-Path: <linux-kernel+bounces-336459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768E1983B1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 04:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37F6A281A52
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 02:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D15BE46;
	Tue, 24 Sep 2024 02:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e6SBuxSq"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3C71FB4
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727144188; cv=none; b=Yc3OkrDzLKQgHRhBGcKFjvReU4drgk3H2z8wbwyNDhzh5DEoVtN9xIqkpfbVbfAkgrqYiKt/hepBpFjZv/8epIGdReldi5idBFkyGxXpRoxSTQirw7YwRoZeSp1rE2Lu2t11rXQG7TnhumXTqJmoOsEnxIFhTS9dju06k4BWpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727144188; c=relaxed/simple;
	bh=plsBfA14qjax7fKN3MmIiXJIE/hOVCFotOeEkkQUn3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=foviGEiM28WCl0EZRWqyVd8bZe2SIy4NUOCa19CiBcujU+kK3kwIfdflqm3S+BB4lxoxtsKrW3B0tQhqoSdcRCxp7YCA7BjfkMK8ICYvUl4Xhj/mOwUrqGvviHe81fiPEWr7AWoIAWLVI/mTGMQpqwpEUPfMGrwFO+ynUpmTcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e6SBuxSq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so746362166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 19:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727144184; x=1727748984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0k1FN4MxEmeH8y9wuYWDQg/1jQnyip2ukqCSef53R4k=;
        b=e6SBuxSqxuz0kvV5pZB+DQq244SSJFts/0NlunLAKeawvqdhT9tMoQ2h4tM8ZnUxW4
         t8krjy2srXqew0K7kbyGgM5n2HpkUkYuZOeSYhAvayQ7vAXClaGHy9q98TSdmC+VwS+F
         CZPJq9KqydacPj1vY9SouWwmTQy232V6fIhFcIUv2YiphXEKlmoLZUP7n41s4v8yfwTG
         Cuy1B95qcGTXvVDoDJjHesYGkJfKEWpeZcU9SoPiveMqSFOIxKGSupXSqggLYuZiLKWl
         Ia+LKIw4EK5C+bSWwfjDMit3wVtMf9Udk2UoNi0DGwBjghFhRtnStRdeoikAyv1umcPq
         mRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727144184; x=1727748984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0k1FN4MxEmeH8y9wuYWDQg/1jQnyip2ukqCSef53R4k=;
        b=Dg6QQHgfkTE69MurQgVh+ivvRNNxIJjR+k2L4JSyDVsv6Y6Z/ZhJTnDSN7uQulg0y8
         RzwHBV21dMaWvp697MA/szVDP03cVvqyWfwYAIus1unoY1yEkuup+4uy7VsVMLn+/v31
         vLgp3xMdyNx3ENQXRtJb/k1eH6MSgRkOAAQFh9sXM2asPpBN6Sd0Y01TttoyXYvGqn10
         W3OrpjcEjHlsNdQqpQj8KPAahba+NF3SBKwqtmFf2VCwo6P4n01TaWimJuL5eLpm1iKe
         hnOmtbkGXKfsw2U5vz7gHxUSmXOblBjOIEOCRdH10C26aVL8iJqk/lgHabWhOgJESeFv
         LGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSURHoZXhRuqnTw54AZbWs08fL9g/kH/TMIyqXaL/rC4cEAF1aNy5UJ4y3p77LpolvoahKmC1taMvuAlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAqjj76yZ/GAxFXBy99iZJueR39VVeL/uub4vmJdqE14Z/GmQ
	LjCyxwd6bcgJ+GBQMtaeQTnDSDgVTAWIutfOX9Lmy0VA66s55bwb4XWAeWmqTlHw2Mr/Q9KJvgY
	NlUNULC5R7UuffyvTxleSKxkteHACFySnmgsd
X-Google-Smtp-Source: AGHT+IHae7upEiBlqxLXCl/vPI4DXcCUvTiJ/wdUkT34X2pIpquKBp57tEW3ErNn+Mag6pVUk7mxHJ21ZhE1zZOW8NY=
X-Received: by 2002:a17:906:bc12:b0:a8f:f799:e7d1 with SMTP id
 a640c23a62f3a-a90d503430cmr1239116266b.38.1727144184322; Mon, 23 Sep 2024
 19:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
In-Reply-To: <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 23 Sep 2024 19:15:47 -0700
Message-ID: <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	hughd@google.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, chrisl@kernel.org, david@redhat.com, kasong@tencent.com, 
	willy@infradead.org, viro@zeniv.linux.org.uk, baohua@kernel.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:55=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2024/9/24 07:11, Nhat Pham wrote:
> > The SWAP_MAP_SHMEM state was originally introduced in the commit
> > aaa468653b4a ("swap_info: note SWAP_MAP_SHMEM"), to quickly determine i=
f a
> > swap entry belongs to shmem during swapoff.
> >
> > However, swapoff has since been rewritten drastically in the commit
> > b56a2d8af914 ("mm: rid swapoff of quadratic complexity"). Now
> > having swap count =3D=3D SWAP_MAP_SHMEM value is basically the same as =
having
> > swap count =3D=3D 1, and swap_shmem_alloc() behaves analogously to
> > swap_duplicate()
> >
> > This RFC proposes the removal of this state and the associated helper t=
o
> > simplify the state machine (both mentally and code-wise). We will also
> > have an extra state/special value that can be repurposed (for swap entr=
ies
> > that never gets re-duplicated).
> >
> > Another motivation (albeit a bit premature at the moment) is the new sw=
ap
> > abstraction I am currently working on, that would allow for swap/zswap
> > decoupling, swapoff optimization, etc. The fewer states and swap API
> > functions there are, the simpler the conversion will be.
> >
> > I am sending this series first as an RFC, just in case I missed somethi=
ng
> > or misunderstood this state, or if someone has a swap optimization in m=
ind
> > for shmem that would require this special state.
>
> The idea makes sense to me. I did a quick test with shmem mTHP, and
> encountered the following warning which is triggered by
> 'VM_WARN_ON(usage =3D=3D 1 && nr > 1)' in __swap_duplicate().

Apparently __swap_duplicate() does not currently handle increasing the
swap count for multiple swap entries by 1 (i.e. usage =3D=3D 1) because it
does not handle rolling back count increases when
swap_count_continued() fails.

I guess this voids my Reviewed-by until we sort this out. Technically
swap_count_continued() won't ever be called for shmem because we only
ever increment the count by 1, but there is no way to know this in
__swap_duplicate() without SWAP_HAS_SHMEM.

>
> [   81.064967] ------------[ cut here ]------------
> [   81.064968] WARNING: CPU: 4 PID: 6852 at mm/swapfile.c:3623
> __swap_duplicate+0x1d0/0x2e0
> [   81.064994] pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS
> BTYPE=3D--)
> [   81.064995] pc : __swap_duplicate+0x1d0/0x2e0
> [   81.064997] lr : swap_duplicate_nr+0x30/0x70
> [......]
> [   81.065019] Call trace:
> [   81.065019]  __swap_duplicate+0x1d0/0x2e0
> [   81.065021]  swap_duplicate_nr+0x30/0x70
> [   81.065022]  shmem_writepage+0x24c/0x438
> [   81.065024]  pageout+0x104/0x2e0
> [   81.065026]  shrink_folio_list+0x7f0/0xe60
> [   81.065027]  reclaim_folio_list+0x90/0x178
> [   81.065029]  reclaim_pages+0x128/0x1a8
> [   81.065030]  madvise_cold_or_pageout_pte_range+0x80c/0xd10
> [   81.065031]  walk_pmd_range.isra.0+0x1b8/0x3a0
> [   81.065033]  walk_pud_range+0x120/0x1b0
> [   81.065035]  walk_pgd_range+0x150/0x1a8
> [   81.065036]  __walk_page_range+0xa4/0xb8
> [   81.065038]  walk_page_range+0x1c8/0x250
> [   81.065039]  madvise_pageout+0xf4/0x280
> [   81.065041]  madvise_vma_behavior+0x268/0x3f0
> [   81.065042]  madvise_walk_vmas.constprop.0+0xb8/0x128
> [   81.065043]  do_madvise.part.0+0xe8/0x2a0
> [   81.065044]  __arm64_sys_madvise+0x64/0x78
> [   81.065046]  invoke_syscall.constprop.0+0x54/0xe8
> [   81.065048]  do_el0_svc+0xa4/0xc0
> [   81.065050]  el0_svc+0x2c/0xb0
> [   81.065052]  el0t_64_sync_handler+0xb8/0xc0
> [   81.065054]  el0t_64_sync+0x14c/0x150
>
> > Swap experts, let me know if I'm mistaken :) Otherwise if there is no
> > objection I will resend this patch series again for merging.
> >
> > Nhat Pham (2):
> >    swapfile: add a batched variant for swap_duplicate()
> >    swap: shmem: remove SWAP_MAP_SHMEM
> >
> >   include/linux/swap.h | 16 ++++++++--------
> >   mm/shmem.c           |  2 +-
> >   mm/swapfile.c        | 28 +++++++++-------------------
> >   3 files changed, 18 insertions(+), 28 deletions(-)
> >
> >
> > base-commit: acfabf7e197f7a5bedf4749dac1f39551417b049

