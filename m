Return-Path: <linux-kernel+bounces-174284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D33108C0C7E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 10:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB141F216AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A7714A4C0;
	Thu,  9 May 2024 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XtqR681b"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F69D14A4DA
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715242915; cv=none; b=V9ApfPiylzvwkgMvM4AmwFPKSL7NM0/xYn7FoQO+Mt3qjpPZDN6w6aHDfVXI1qdGRSC4IrN+N4D+XE7VCWa2aEbJiOkLly59QWhtUhpVaoKaU2fjEL1LGXn5Dm9gvMtkcgbKXj9rHnkWGfzl3bsCP66u6LCjzfspeY78Km898JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715242915; c=relaxed/simple;
	bh=3uvc5L0N0IrJvhHtxGTt/rLIh4P1YRMBVY8Tc45LZiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNZfX9Psn6U41Wpd21NuCFYDOyTc7GDocpdR9ZrXv+QhoCR3kvDgHN/4JeQEuWbmZI+JnNxJtJPTG4ZEoGDM715Nv3OK1+vQMK9RVdUkUZSpnb+HnalUUT+W9sEgNotHf45JYy4lZZAiM+SWC5of8a8i7R2ytNc5eO+wfbgGaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XtqR681b; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572baf393ddso2814080a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715242912; x=1715847712; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3uvc5L0N0IrJvhHtxGTt/rLIh4P1YRMBVY8Tc45LZiE=;
        b=XtqR681bGiGahPCj5dY+dfvQ5RzH7OUrEvETUGor65+YzazNBSAGRm62c0IW/BqpOF
         ZWHPFQ+I8Suy8goI/c7AsND3zu6BphnOjes2qPnKRMiVxhXk3TqfPgUQKxdSPpvOY30X
         5jilcyZrbQEXYPCDZxYbI8STzNjbCQ7co5fnahnD9QnjCfvkWBOKk5xrznAQC0BKwK0F
         ZH16Oovk8ltwmK6CotWZoNi3mZaBVCdt1qmaevkMjRQ/1S9kDg1wOzfnNC7Dx6R30GFU
         0XX/LmQ4vukgH2jXNkaerTtA2wDpaeBot64J34i2ttLGQBKtBtBs2YjriziIQB1je9Tv
         hfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715242912; x=1715847712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3uvc5L0N0IrJvhHtxGTt/rLIh4P1YRMBVY8Tc45LZiE=;
        b=MrHTQ936UT8n05AtFY+ErflH1zYe67JC/HKGbW3mDODslt8p5Gza72rdNulK8nUCS6
         31yTzTTdHCJJfBEf+6w+B2ckrimLpbqNxe+nEAWy6ThzLL85ZofoDDgFASH3UfeoGVvk
         IDREMURo+83Hlj33KsQgrNizyhQASgC//8gk06xtY+2Bbfex5fLznxkQvZVgIQUrr0vP
         XkxZywcTA9xI8tEePiYZLZPp4WFRefUErU5YwBa1ex55Aj9LBL63Cqi9OaGWWElGMFhc
         mvm+czSmG2iTGtqBSYOCj2z3DLVu04wworSHqnNq61+rvn1hJOzhrEItYXNZSwPdGlJw
         IVyg==
X-Forwarded-Encrypted: i=1; AJvYcCUylHksJ0Xz5nHNGjMQf5/zBQsB6aR6heJKi0v4t5xL31kce/SQEf3mNKpOMBSep4pFj9AVC1qM21KEBun8fxtKz3Dwfv46W1NFoh0j
X-Gm-Message-State: AOJu0Ywb54310tWfYV5ObSbzj2A1TDNGn/lmMzAbjU8SihPoqHFhINLb
	L7/a8RmZMfa1VDwuI9ME023/bG35m5/EG7eDaGum67kgruM1UwByg8V2n4vC2F7nsaV9pEs8GQH
	saqh1Gis9swT2zGm52M9s4Bja/ME=
X-Google-Smtp-Source: AGHT+IHESwZO+wOaWv8ASTC/Ph6luCzkAHQV4yOwfchkcprT6g3v71swVJ1O67hKJtn3VP9US4nDOVonhvmWH8LcfXY=
X-Received: by 2002:aa7:c485:0:b0:572:7d77:179d with SMTP id
 4fb4d7f45d1cf-573326edde8mr1337387a12.5.1715242911497; Thu, 09 May 2024
 01:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501042700.83974-1-ioworker0@gmail.com> <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com> <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com> <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com> <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
 <20240508155253.GK4650@nvidia.com> <30469615-2DDC-467E-A810-5EE8E1CFCB43@nvidia.com>
 <20240508163526.GM4650@nvidia.com>
In-Reply-To: <20240508163526.GM4650@nvidia.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Thu, 9 May 2024 16:21:39 +0800
Message-ID: <CAK1f24=PmS1RMQ6=0dgX_q9xqUthWOjJBz_FE-Ndb7MwGLWYdg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Zi Yan <ziy@nvidia.com>, Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org, 
	willy@infradead.org, sj@kernel.org, maskray@google.com, ryan.roberts@arm.com, 
	david@redhat.com, 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com, 
	zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com, 
	libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Zi and Jason,

Thanks a lot for reaching out!

On Thu, May 9, 2024 at 12:35=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, May 08, 2024 at 12:22:08PM -0400, Zi Yan wrote:
> > On 8 May 2024, at 11:52, Jason Gunthorpe wrote:
> >
> > > On Wed, May 08, 2024 at 10:56:34AM -0400, Zi Yan wrote:
> > >
> > >> Lance is improving try_to_unmap_one() to support unmapping PMD THP a=
s a whole,
> > >> so he moves split_huge_pmd_address() inside while (page_vma_mapped_w=
alk(&pvmw))
> > >> and after mmu_notifier_invalidate_range_start() as split_huge_pmd_lo=
cked()
> > >> and does not include the mmu notifier ops inside split_huge_pmd_addr=
ess().

IMO, It might be reasonable to exclude the mmu notifier ops in
split_huge_pmd_locked(). IIUC, before acquiring the PTL, callers need to te=
ar
down the secondary mappings via mmu_notifier_invalidate_range_start() with
the range aligned to HPAGE_PMD_SIZE.

> > >> I wonder if that could cause issues, since the mmu_notifier_invalida=
te_range_start()
> > >> before the while loop only has range of the original address and
> > >> split huge pmd can affect the entire PMD address range and these two=
 ranges
> > >> might not be the same.

As Baolin mentioned [1] before:
"For a PMD mapped THP, I think the address is already THP size alignment
returned from vma_address(&folio->page, vma)."

Given this, perhaps we don't need to re-align the input address after
starting the pagewalk? IMO, if any corner cases arise, we should catch them
by using VM_WARN_ON_ONCE() in split_huge_pmd_locked().

Zi, what do you think?

[1] https://lore.kernel.org/linux-mm/cc9fd23f-7d87-48a7-a737-acbea8e95fb7@l=
inux.alibaba.com/

> > >
> > > That does not sound entirely good..
> > >
> > > I suppose it depends on what split does, if the MM page table has the
> > > same translation before and after split then perhaps no invalidation
> > > is even necessary.
> >
> > Before split, it is a PMD mapping to a PMD THP (order-9). After split,
> > they are 512 PTEs mapping to the same THP. Unless the secondary TLB
> > does not support PMD mapping and use 512 PTEs instead, it seems to
> > be an issue from my understanding.
>
> I may not recall fully, but I don't think any secondaries are
> so sensitive to the PMD/PTE distinction.. At least the ones using
> hmm_range_fault() are not.
>
> When the PTE eventually comes up for invalidation then the secondary
> should wipe out any granual they may have captured.
>
> Though, perhaps KVM should be checked carefully.
>
> > In terms of two mmu_notifier ranges, first is in the split_huge_pmd_add=
ress()[1]
> > and second is in try_to_unmap_one()[2]. When try_to_unmap_one() is unma=
pping
> > a subpage in the middle of a PMD THP, the former notifies about the PMD=
 range
> > change due to one PMD split into 512 PTEs and the latter only needs to =
notify
> > about the invalidation of the unmapped PTE. I do not think the latter c=
an
> > replace the former, although a potential optimization can be that the l=
atter
> > can be removed as it is included in the range of the former.
>
> I think we probably don't need both, either size might be fine, but
> the larger size is definately fine..
>
> > Regarding Lance's current code change, is it OK to change mmu_notifier =
range
> > after mmu_notifier_invalidate_range_start()?
>
> No, it cannot be changed during a start/stop transaction.

I understood and will keep that in mind - thanks!

Thanks again for clarifying!
Lance

>
> Jason
>
>

