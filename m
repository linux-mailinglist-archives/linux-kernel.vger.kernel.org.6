Return-Path: <linux-kernel+bounces-227679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79265915570
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E787286F99
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA2C19F495;
	Mon, 24 Jun 2024 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I96PNCT/"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EC17BBF
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250314; cv=none; b=CvXLj6ig5b8CkcZUZL36Tj83YSuzzG7RfMEZkORCC1NXB/EETu85gjOqWH86ci4lg/PmItzXVt4uiuiEwt6yuLA7HGMQ31Hn2D1qAk9PlcfoRjDytPedf8HeeON3FgDM2DyrAFFoKpggSq1GzCzq6kobZ5la8tqUZI5CXNQveJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250314; c=relaxed/simple;
	bh=lzw62rV6dsrTStefsBXRWeKRQD78ZZQOIsaYkQC+T9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iByBNyQHS5L/wETEKQm7cli5VqoGHqabRlQFp8eBzdZwsDusY6g05DXCLv+M5l27d3fq8bBdbpHPm3n9EFgZyY/2sWaZf2YCIbWMgnoLgMppbYXCUaSLpQAC5Rd7Dz90hvlwdG85VavtaevYNEko6gr7vxXik2VwfMSe7XmOmMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I96PNCT/; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ce655ff5bso1268834e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719250311; x=1719855111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJahqqcPYHh8+eBoSG26csJCzav1KQmoeVFSqgS7I8o=;
        b=I96PNCT//Q9xHGaek2uRUPV3lQiwCkpb48lCA2S59eKt5Z9hFzRJ/emcBWHtsD/k7b
         exKrFiUl3Z7WWyNLd5eRobJZ9FuMQBn9X0N4VDl3ZTbRCeE7Dsw8GTtR8WQKRVzy1EYp
         o4CRxZZYIAWg43WDLKGojJnSb8ndFcBuQuqbXxXZI7xR1m67SJosdw6xbz0Cu1gutxiI
         6Jluq2QJocGBWejS37RSJVRzae85i0vlRfqgqRjYLP6wI4fXV4qgcuXYl8heKQELE9VJ
         jo5GuOikP2WBW9beIsDjtG1XCFynbMT23HNyT7SOVUaTj+Pt1zjrjBdslfb0df0v1MIf
         90pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719250311; x=1719855111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJahqqcPYHh8+eBoSG26csJCzav1KQmoeVFSqgS7I8o=;
        b=sSq1y/gDPADb/jXXCL8Ukkq4nIz54lCRYF/gOxAWF+u+fp2RzRjii4q0tuNbcHs+I/
         d7Z2m+Qaj/URnJY9u9Z8HtgoZkNIzL6UFh7MKJ4N/pQJjPmMaiJkiu+Ekd3SPie5k7Hi
         +bP+jYRNgt6SblvOUfR4pYRveI6KhCXjPFaWY5ULFkH4RgUGYjJ/kWJCZh4IaJ+XN9ZK
         VZHfbOTQVEflY6jC2cwas4kJtD6SZK7MJLUfZAIfCJZINNO57pMWojbjeMd8Z0dETf2x
         T0qBE4cFri6AhPK/gHwh4rj1n6tmYBh/wIoz9tZCe7lm4GnTVG6w0La/o0HuYgkunQi4
         s+bg==
X-Forwarded-Encrypted: i=1; AJvYcCUo//kh4/W89MiFg2vEuKVuPPCX1vBCPYTyTsNfnd6wqjfF/6W0hoAbredhviiP5edYHeQN3cWV0A6Hu8VYyV6Sy2UeVNavRNstszCV
X-Gm-Message-State: AOJu0Yyw47L2bkOSizoBeo+ZPmqdL2YumrNElGJy+QC5shh4nRIBOO3z
	GBDnWXNMjIeySc8Z6dnurEhQRX8P0c6A7NjbjqxH1sveg7mMLJ0z8d5+xFCgzKxvAtp2zQkXKea
	cX9YJSzqnJgHGrjhW6XoMOPERJi0qsCQnfi2x
X-Google-Smtp-Source: AGHT+IHu/6Uvh7AV/Zv0qy/SmWhabuqLk3uy9Cs1T7gS6dfZJh34AaaZ40gcXksxb2cum4I5w5DnMWycjP5k27WphGc=
X-Received: by 2002:a05:6512:6c3:b0:52c:83c2:9670 with SMTP id
 2adb3069b0e04-52ce0646e8bmr4646203e87.69.1719250310229; Mon, 24 Jun 2024
 10:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406241651.963e3e78-oliver.sang@intel.com> <CAJD7tkbqHyNUzQg_Qh+-ZryrKtMzdf5RE-ndT+4iURTqEo3o6A@mail.gmail.com>
 <12fb19d1-3e57-4880-be59-0e83cdc4b7f1@gmail.com> <61d19ec8-2ba7-e156-7bb7-f746dae8e120@google.com>
 <5b3e732c-d23d-41ef-ae5c-947fa3e866ab@gmail.com> <CAJD7tkYJVa=dd=hwqhJ8_-uzxFDaP6-GcTk3RdG_3DJouJ61AQ@mail.gmail.com>
 <cacd14a9-01fc-4844-9ac6-2e797af13c36@gmail.com>
In-Reply-To: <cacd14a9-01fc-4844-9ac6-2e797af13c36@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 10:31:14 -0700
Message-ID: <CAJD7tkbYbJHWQtC8+nsyfgS2jq7S5Qyy3-1NJWa4m80VAR9GXA@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 0fa2857d23: WARNING:at_mm/page_alloc.c:#__alloc_pages_noprof
To: Usama Arif <usamaarif642@gmail.com>
Cc: Hugh Dickins <hughd@google.com>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@redhat.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:26=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
> On 24/06/2024 19:56, Yosry Ahmed wrote:
> > [..]
> >>>> -       p->zeromap =3D bitmap_zalloc(maxpages, GFP_KERNEL);
> >>>> +       p->zeromap =3D kvzalloc(DIV_ROUND_UP(maxpages, 8), GFP_KERNE=
L);
> >>> No, 8 is not right for 32-bit kernels. I think you want
> >>>        p->zeromap =3D kvzalloc(BITS_TO_LONGS(maxpages), GFP_KERNEL);
> >>> but please check it carefully, I'm easily confused by such conversion=
s.
> >>>
> >>> Hugh
> >> Ah yes, didnt take into account 32-bit kernel. I think its supposed to=
 be
> >>
> >>    p->zeromap =3D kvzalloc(BITS_TO_LONGS(maxpages) * sizeof(unsigned l=
ong),
> >> GFP_KERNEL);
> > You can do something similar to bitmap_zalloc() and use:
> >
> > kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long), GFP_KERNEL
> > | __GFP_ZERO)
> >
> > I don't see a kvzalloc_array() variant to use directly, but it should
> > be trivial to add it. I can see other users of kvmalloc_array() that
> > pass in __GFP_ZERO (e.g. fs/ntfs3/bitmap.c).
> >
> > , or you could take it a step further and add bitmap_kvzalloc(),
> > assuming the maintainers are open to that.
>
> Thanks! bitmap_kvzalloc makes most sense to me. It doesnt make sense
> that bitmap should only be limited to MAX_PAGE_ORDER size. I can add
> this patch below at the start of the series and use it in the patch for
> zeropage swap optimization.
>
>
>      bitmap: add support for virtually contiguous bitmap
>
>      The current bitmap_zalloc API limits the allocation to MAX_PAGE_ORDE=
R,
>      which prevents larger order bitmap allocations. Introduce
>      bitmap_kvzalloc that will allow larger allocations of bitmap.
>      kvmalloc_array still attempts to allocate physically contiguous memo=
ry,
>      but upon failure, falls back to non-contiguous (vmalloc) allocation.
>
>      Suggested-by: Yosry Ahmed <yosryahmed@google.com>
>      Signed-off-by: Usama Arif <usamaarif642@gmail.com>
>

LGTM with a small fix below.

> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 8c4768c44a01..881c2ff2e834 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -131,9 +131,11 @@ struct device;
>    */
>   unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags);
>   unsigned long *bitmap_zalloc(unsigned int nbits, gfp_t flags);
> +unsigned long *bitmap_kvzalloc(unsigned int nbits, gfp_t flags);
>   unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int
> node);
>   unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int
> node);
>   void bitmap_free(const unsigned long *bitmap);
> +void bitmap_kvfree(const unsigned long *bitmap);
>
>   DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
>
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index b97692854966..eabbfb85fb45 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -727,6 +727,13 @@ unsigned long *bitmap_zalloc(unsigned int nbits,
> gfp_t flags)
>   }
>   EXPORT_SYMBOL(bitmap_zalloc);
>
> +unsigned long *bitmap_kvzalloc(unsigned int nbits, gfp_t flags)
> +{
> +       return kvmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long)=
,
> +                             flags | __GFP_ZERO);
> +}
> +EXPORT_SYMBOL(bitmap_zalloc);

EXPORT_SYMBOL(bitmap_kvzalloc)*

