Return-Path: <linux-kernel+bounces-382382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A409B0D09
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 341E11C22ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662C18C90E;
	Fri, 25 Oct 2024 18:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsdlWuIn"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5F20C33B;
	Fri, 25 Oct 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880369; cv=none; b=Jn4hCpyufYV16hOzCW8JXCBCojeO+NTcgYa64AENbSIqeXalKqvb4yReKVvNRhWCy5oRvd1XxJ0vjkAZPBHWh5e0oXeiwoxTzeHXaDZRv6Mp3x81UCgK7obdjvY/taTCU7J/DxNkgauJ+y83c0scTb+mLuxbpejipDQdZ/AdZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880369; c=relaxed/simple;
	bh=QgAvrwRK2eLAe0WGscMVJ3X6H7dCEK3wmausS4uWva4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6Zwe9S93A8Th5WLwIMDwBRz7RN9KbYDTo+JAc8owFl+OspmBM2VLSqmb3t9BK8sLnWddzKeKhYmEIA01ntoebj7Ptr3E3kOXB82m/GhIB2P15wv94kCyPwrfRTl1FLmaK/STb1gaQMWGBHLpuqVR47vQykRpbxJWN7Y8iESuGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsdlWuIn; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe9914487so13076776d6.1;
        Fri, 25 Oct 2024 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729880366; x=1730485166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl0En9CAadDTqXHS8tVcFczlM5FFbAZNtAmw0XzqmtU=;
        b=YsdlWuInAuwHqN5QbelSN1NoIOs9Bly+wDNgq3Km4EHNVQccKym78ShJg3CwwvsXqf
         4agvXqknU2C6W1iAfAK2Wajm9cWJ3a5k3CMpNGFC8zu0dyohsNBaEuPHAFz5O2I4SrpZ
         icvqcoAiPnZ0S02LqXiA1RtcppBbeRUvOe+CylxF5jMThVKkyPfVpikM4oAycaFBIk6J
         MmJOoXnLYEyF7yGRMQLktBd6EFUNyuqICzkeyRyWGTIuBt8IEuQhAvbfwomODZXlzI0o
         GnVZ2W8N5h9xs4jY7r561E5NDIIpgH/tOxtdbP980UZcIP9AoNKN93Jj95x7FmnYteFZ
         OfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729880366; x=1730485166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dl0En9CAadDTqXHS8tVcFczlM5FFbAZNtAmw0XzqmtU=;
        b=SBvA9B3fwRqO/8hyPdBsDpFG0aocI94wDxDTLRDVtNv6JuulzJTZfGi3dPgbzATQKl
         PgcMnl4Z5JfwjAT8WbSyqrYN7kD6v5UwLIax09O8ybQCLaU//RdvMWn7aGxfEi/qf79c
         +S7l1ZRRPIYY3FrT8xbKwyakm2bitg3wsI9j0F8iYpwFF2sQluVXUszncKTi3OjF0Xef
         3u+7oYxKWRGsTF2g2sCRQYrDc49N3hnvGW1+uyjlNjI3WStGWS3kdxyV0ghgqWVwy0ZK
         FDkhnP/omk/eMeZWTomqjKDlWZS9Niyh0Qq/4YkG9wv9Fh6Q42GdU8XCSerOCh3eyLQ/
         SoYA==
X-Forwarded-Encrypted: i=1; AJvYcCWNNkxgUpZP7ymZbVGCdRPmGbQr2GQduDjoa0FZzWWFAxL4VlSNT3jFAMQCwTNBsTLnNWgAJ1ks3lgyZoCB@vger.kernel.org, AJvYcCWbjE8rh1oLRRuqZkiFdGUFZS6MULiSLfVdFVI5sXQ0Q7KaVjFbIiIXKEzfizpvzBV++4HU0fe+TJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzvRYsTOMfA+hS2/qYHjggLvSuAk6Dd7YzuO702R/k4G4PJJc/
	jU2WuP8+D+u+UyFuyn7bSx7oL4Tr4LL0T4fQIgh6YrePnjFYqLW7wI1Zdv9NmQ21Fgd+E8w4x8e
	v7stEbOpIqlpPd2yZ4zTfo1W8ajE=
X-Google-Smtp-Source: AGHT+IEOF5qmnx1Hp0tE56NzkJcYLq0TSfFoBwTuQWywUUPjhDx6kPtdwQp7JKC7E9Jbrvm3zv41MwJasknH6wc3S7Y=
X-Received: by 2002:a05:6214:4613:b0:6cd:ac54:7991 with SMTP id
 6a1803df08f44-6d1856c86a9mr4549136d6.17.1729880366479; Fri, 25 Oct 2024
 11:19:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105026.2521366-1-usamaarif642@gmail.com>
 <20241018105026.2521366-2-usamaarif642@gmail.com> <CAJD7tkYEe10Xw-8azM-80pHv6YjvosZDHTdZfYttAuD5u1+s8A@mail.gmail.com>
 <07e6018b-bc6f-4e1e-9bc3-07a4b5a384fc@gmail.com> <CAJD7tkaD0m7ciiy6Nj7CZb2_26Dv4T=2cRW7h728vLxczOVkYg@mail.gmail.com>
In-Reply-To: <CAJD7tkaD0m7ciiy6Nj7CZb2_26Dv4T=2cRW7h728vLxczOVkYg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 25 Oct 2024 11:19:15 -0700
Message-ID: <CAKEwX=PVbiEd9_4NAvLrHG9dr3k-25c4AB1iEagi4ZBcYRX24w@mail.gmail.com>
Subject: Re: [RFC 1/4] mm/zswap: skip swapcache for swapping in zswap pages
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	hannes@cmpxchg.org, david@redhat.com, willy@infradead.org, 
	kanchana.p.sridhar@intel.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, riel@surriel.com, 
	shakeel.butt@linux.dev, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 5:46=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> [..]
> > >> @@ -1576,6 +1576,52 @@ bool zswap_store(struct folio *folio)
> > >>         return ret;
> > >>  }
> > >>
> > >> +static bool swp_offset_in_zswap(unsigned int type, pgoff_t offset)
> > >> +{
> > >> +       return (offset >> SWAP_ADDRESS_SPACE_SHIFT) <  nr_zswap_tree=
s[type];
> > >
> > > I am not sure I understand what we are looking for here. When does
> > > this return false? Aren't the zswap trees always allocated during
> > > swapon?
> > >
> >
> > Hi Yosry,
> >
> > Thanks for the review!
> >
> > It becomes useful in patch 3 when trying to determine if a large folio =
can be allocated.
> >
> > For e.g. if the swap entry is the last entry of the last tree, and 1M f=
olios are enabled
> > (nr_pages =3D 256), then the while loop in zswap_present_test will try =
to access a tree
> > that doesn't exist from the 2nd 4K page onwards if we dont have this ch=
eck in
> > zswap_present_test.
>
> Doesn't swap_pte_batch() make sure that the range of swap entries
> passed here all corresponds to existing swap entries, and those
> entries should always have a corresponding zswap tree? How can the
> passed in range contain an entry that is not in any zswap tree?
>
> I feel like I am missing something.
>
> >
> > >> +}
> > >> +
> > >> +/* Returns true if the entire folio is in zswap */
> > >
> > > There isn't really a folio at this point, maybe "Returns true if the
> > > entire range is in zswap"?
> >
> > Will change, Thanks!
> >
> > >
> > > Also, this is racy because an exclusive load, invalidation, or
> > > writeback can cause an entry to be removed from zswap. Under what
> > > conditions is this safe? The caller can probably guarantee we don't
> > > race against invalidation, but can we guarantee that concurrent
> > > exclusive loads or writebacks don't happen?
> > >
> > > If the answer is yes, this needs to be properly documented.
> >
> > swapcache_prepare should stop things from becoming racy.
> >
> > lets say trying to swapin a mTHP of size 32 pages:
> > - T1 is doing do_swap_page, T2 is doing zswap_writeback.
> > - T1 - Check if the entire 32 pages is in zswap, swapcache_prepare(entr=
y, nr_pages) in do_swap_page is not yet called.
> > - T2 - zswap_writeback_entry starts and lets say writes page 2 to swap.=
 it calls __read_swap_cache_async -> swapcache_prepare increments swap_map =
count, writes page to swap.
>
> Can the folio be dropped from the swapcache at this point (e.g. by
> reclaim)? If yes, it seems like swapcache_prepare() can succeed and
> try to read it from zswap.
>

I think you're onto something.

Can this happen: say T2 writebacks a couple of tail pages, but not all
of them, then drops everything from swap cache. Then T1 can definitely
proceed. It would then check again in zswap_load(), which returns
false (thanks to zswap_present()) test.

All fine and good so far, but then in swap_read_folio(), it would try
to fall back to reading the entire large folio from swapfile, which
will contain bogus data in pages that have not been written back by
T2.

I think the problem is swap_read_folio() assumes it always succeeds,
and a precondition for successful reading is the large folio must have
no mixed backing state for its subpages, which we fail to guarantee
before entering swap_read_folio(). This can lead to memory corruption.

Buuut, I think all we need to do is just check the backing state again
after T1's swapcache_prepare() call. At this point, we are guaranteed
to have a stable backing state. If it fails here, then we can just
exit and fall back to individual page swapping in.

