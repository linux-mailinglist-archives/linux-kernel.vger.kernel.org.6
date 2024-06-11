Return-Path: <linux-kernel+bounces-210170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E51904051
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D227CB2175E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8439FD0;
	Tue, 11 Jun 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jpB0vpMO"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B847381B9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120615; cv=none; b=X1/COWuIA84DjsKgk5PCs4Gjmeqcdchj9nRWFZON0kHwTaV+Cgt7Q9T/5MMt09mNoPAJRmM0jJMAeDTsUjfGtFJL2xurFMU/hgLxDdeLv1s82VALVY7vTZdMX2Ds1UsGSJxGHBZH8jY01/KVSDuooWpINtp1rz0bo+Roax0QVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120615; c=relaxed/simple;
	bh=JwLqZcboxVgJz+tsk/GUzQB6OGX4m3yEHKScXnDMpJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMyzBgW4PsIojc5iQFaZZ6J7lETy5zTbm797igLoTt3cdzfot2CkNT2c57hxw/8fCZhoaLRWYHj5j9VkartPvsHdaV4uq1JRsoK2Zcxsu+/vp9uQClEpc8Bbbbcrros2S965YRm57lY2aOmbIAk3577QrmJxVKXzFcq/zRgUtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jpB0vpMO; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52bc27cfb14so5237013e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718120609; x=1718725409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtoYh4khLsFmK6WU0BTex1tBaCSDZcazUnln/dzNt8c=;
        b=jpB0vpMOhLoRpeDgPDjvzOzRbTwZdpIw6OhiTSdbUWY+AmB7R1+X8bu4KBURL6k8cI
         Dvhaao2OsNJ/9YCiErP1mEGlmKaIOJtzuc6B5uNZtwYksJiX+jybnDK40scaWAkXfegP
         NCuL5xbrkT39w81p6Ruh1URajRjHEN+fjp/kr1yaQaMXD5rNH7ddYwzB1CJuiguUU7nJ
         VY7oIEY73sGIO69MeIJkkJdBmDsfNaiKWquusOmfn33uQlFBIMOBxUriCIep63pLt6a4
         terGWFGFXB+lDHnrBx3OMqL89qminrSpa2JFMuYPgm4WtDHfupgp/zt63/dpAsZM59KJ
         aQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718120609; x=1718725409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtoYh4khLsFmK6WU0BTex1tBaCSDZcazUnln/dzNt8c=;
        b=ClszM/9LZqnJYVW/HtkNZNSeXAwecGM2eZdbjm4NScejHAHtrBH2MNHKBMJZQh0Fej
         QnVi3L8vNz4Sy/z21JFoSobnAQfwmZftRV75sJUUd+AKGdcykPbVW5c154OwNdQWobiO
         uC1/GnCrCAPsvxVEVlwu28o4m8Aqr02fGAAi2KlUKaqiauAaiOvpt9wni0X10kvxD1Ae
         iaAc9HN8qpwRY0ECF0op5dav0HvPvuLoYLBfHoMUwsTmxnQs0dtFom9tWNAvK4XCdeGD
         fUOvmdVKKou4E+lT9woHCDN/CIjm2taYXwOyDpKi81Q3nuxmJgnVTbGDcE9AthN7fpKf
         Tuww==
X-Forwarded-Encrypted: i=1; AJvYcCXG24ZIn1Q8UHhjKbzfo2qijA2K6NvBz+d09gv2RNCioiEZPuMtubzL2jcjOGt7a6+F7WGztcn2VgcZEjOqf57sLw8F0Jq5men8FZqB
X-Gm-Message-State: AOJu0YwFVrAMD3TND1E1p2AL6cMVL2GQdDoZ7FKx6LzVVTgbppFKHPYQ
	b21+l8zJQMyWILTOklDW+i0FEP1B2WgVSzLoUGkN9xkX9TNYfqYQqN5ggU7lDkSDJfQqw0UXI3o
	coV8S+SlEr89wLaiE5ng6b6QC9E/qcWYApEOj
X-Google-Smtp-Source: AGHT+IG3HG7sJETAPhIUdddPCLOjWaSEHzbToxKs2II+yrkoBEyxRoeaXdMHulT8rNexKPFYuuEU6QJ0wxUA2xvG4LY=
X-Received: by 2002:ac2:42c4:0:b0:52c:826f:f3f1 with SMTP id
 2adb3069b0e04-52c82700c52mr5705373e87.2.1718120609166; Tue, 11 Jun 2024
 08:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com> <CAJD7tkbpXjg00CRSrXU_pbaHwEaW1b3k8AQgu8y2PAh7EkTOug@mail.gmail.com>
 <d822ec8b-3b7d-4e5c-ac96-b6fda63da5d4@gmail.com> <CAJD7tkZoaM=dWim7GPqEERDZyxp3PqMNctzXQCPDMO=8kQSwfw@mail.gmail.com>
 <9ddfe544-636d-4638-ae0e-053674e47322@gmail.com>
In-Reply-To: <9ddfe544-636d-4638-ae0e-053674e47322@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 08:42:51 -0700
Message-ID: <CAJD7tkY0F-Tczq4j861HxKATzEOfkVv=76m8zFcJHuh8E3VMEw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: 21cnbao@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 4:49=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> @@ -515,8 +600,11 @@ void swap_read_folio(struct folio *folio, bool
> synchronous,
> >>>>                   psi_memstall_enter(&pflags);
> >>>>           }
> >>>>           delayacct_swapin_start();
> >>>> -
> >>>> -       if (zswap_load(folio)) {
> >>>> +       if (swap_zeromap_folio_test(folio)) {
> >>>> +               folio_zero_fill(folio);
> >>>> +               folio_mark_uptodate(folio);
> >>>> +               folio_unlock(folio);
> >>> We don't currently support swapping in large folios, but it is a work
> >>> in progress, and this will break once we have it.
> >>> swap_zeromap_folio_test() will return false even if parts of the foli=
o
> >>> are in fact zero-filled. Then, we will go read those from disk swap,
> >>> essentially corrupting data.
> >> So yes, with this patch I tested swap out of large zero folio, but whe=
n
> >> swapping in it was page by page. My assumption was that swap_read_foli=
o
> >> (when support is added) would only pass a large folio that was earlier
> >> swapped out as a large folio. So if a zero filled large folio was
> >> swapped out, the zeromap will be set for all the pages in that folio,
> >> and at large folio swap in (when it is supported), it will see that al=
l
> >> the bits in the zeromap for that folio are set,  and will just
> >> folio_zero_fill.
> >>
> >> If even a single page in large folio has non-zero data then zeromap wi=
ll
> >> not store it and it will go to either zswap or disk, and at read time =
as
> >> all the bits in zeromap are not set, it will still goto either zswap o=
r
> >> disk, so I think this works?
> >>
> >> Is my assumption wrong that only large folios can be swapped in only i=
f
> >> they were swapped out as large? I think this code works in that case.
> > I think the assumption is incorrect. I think we would just check if
> > contiguous PTEs have contiguous swap entries and swapin the folio as a
> > large folio in this case. It is likely that the swap entries are
> > contiguous because it was swapped out as a large folio, but I don't
> > think it's guaranteed.
>
> Yes, makes sense. Thanks for explaining this.
>
> >
> > For example, here is a patch that implements large swapin support for
> > the synchronous swapin case, and I think it just checks that the PTEs
> > have contiguous swap entries:
> > https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail.=
com/
> >
> > This makes a lot of sense because otherwise you'd have to keep track
> > of how the folios were composed at the time of swapout, to be able to
> > swap the same folios back in.
>
> I think the solution to large folio swap-in for this optimization and
> zswap is not in swap_read_folio in this patch-series or any call further
> down the stack, as its too late by the time you reach here, but in
> Barrys' patch. This needs to happen much earlier when deciding the size
> of the folio at folio creation in alloc_swap_folio, after Barry checks
>
>      if (is_zswap_enabled())
>          goto fallback;
>
> once the order is decided, we would need to check the indexes in the
> zeromap array starting from swap_offset(entry) and ending at
> swap_offset(entry) + 2^order are set. If no bits are set, or all bits
> are set, then we allocate large folio. Otherwise, we goto fallback.
>
> I think its better to handle this in Barrys patch. I feel this series is
> close to its final state, i.e. the only diff I have for the next
> revision is below to remove start/end_writeback for zer_filled case. I
> will comment on Barrys patch once the I send out the next revision of thi=
s.

Sorry I did not make myself clearer. I did not mean that you should
handle the large folio swapin here. This needs to be handled at a
higher level because as you mentioned, a large folio may be partially
in the zeromap, zswap, swapcache, disk, etc.

What I meant is that we should probably have a debug check to make
sure this doesn't go unhandled. For zswap, I am trying to add a
warning and fail the swapin operation if a large folio slips through
to zswap. We can do something similar here if folks agree this is the
right way in the interim:
https://lore.kernel.org/lkml/20240611024516.1375191-3-yosryahmed@google.com=
/.

Maybe I am too paranoid, but I think it's easy to mess up these things
when working on large folio swapin imo.

