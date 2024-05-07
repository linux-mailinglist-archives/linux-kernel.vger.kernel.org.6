Return-Path: <linux-kernel+bounces-171139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13C8BE022
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBDC1C234EA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AF9152E0E;
	Tue,  7 May 2024 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hI775dL/"
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF6155357
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078897; cv=none; b=rrVfstKml+8KQVF3GyUmLQv57S5mFhCoHBKWRqii/1pYpYiusQgkC7aPnCgq2LdGOpv0MOqTqktrcTLMhlNSw0xL8cKwtL6cSYzwHbo07gLsxt2QBAxFruwM8uRd3iOKrUhjUnuyZ6r5QaK/pFBchcUF0fHIY7ZaHBWjfXgnAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078897; c=relaxed/simple;
	bh=gr6MCpczg12et+FBMDjyCUfNDicp71lojIb2Pw4ZPGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SK40ziRwATuX9/XKs1gKyOHPb3Wr4EhkLqj5PFXO08NFJt7kkGnU5nqEsQvRToDaz7SuZvi9+khS+xBSLv+FcZFEN9R0mDcOtduhpQcrbexyknOksyB7FYbZce+HSF38PsKjruXM8E4Z0Dc1OsCHXjhavaSj45mnrqnm0Gbb3MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hI775dL/; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47ef107b07fso1578422137.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715078895; x=1715683695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8LWXi1t+lE6KI0eavFtHLY+RQwXGx7aET3nURSVgDQU=;
        b=hI775dL/nyzZpi8lC88ZoN00fZ5w5N1nupUOP35BMC0eEOwDxenh5SxDgb5m6b6eTs
         gdn0LFxAwgTx/6/SbuGZrLqfdizyeb8/Z5yRvjgEI8bBfsm44M82kAzqkj6dxuCo18G8
         KvUsNTkrC/SSqZkdR6zyyXaUdSxV+Edxc/NIl3foCc952PgMsG+R/XRiRFWyye12UKKN
         oVKFMz4SqrLi0ldOxwXP2aosyqQZSsgyDUm8K0epooaOaz8ErBs7OVIv047sbAHHYlDQ
         b02F77PtK5avE5gVx4eFk5OZbFnHL4jPo2gKmKBbDZk8dKNgmDAW7lddTa2YkXNne6ha
         JKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715078895; x=1715683695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8LWXi1t+lE6KI0eavFtHLY+RQwXGx7aET3nURSVgDQU=;
        b=L1Eqw8X7LX/TG3fQwj4tIC8ed/NVY4T8oiSL+iwnD4DWPXlowrhDSNgLf/uzN76RAq
         TFkZZ1zO0k5deTcBcuwr1BYDzk4f6vo93URoVI3ykcA3jng5va3bVBPXZiZQmxzBoIdA
         v9krvrZjs9pnYEqAuEPCq8Wo+7fCDgqYykN71bCcBCsWM8id88J6HiEPX8Jtne6E5pBW
         5mYBMzmgXaawGNmuW4bbErWe/S6Hcwbm98GGGAzmn3vIXUcnblZ189rxjkV7Wi0Nrk4d
         B96li0HhZEQ22OtzA6mrJcE6U/5UG8q3Ktgouj6lYPivgAWYvwXJdzRyoiJ/2GPLnmAu
         fnLA==
X-Forwarded-Encrypted: i=1; AJvYcCV+8xW/2ebvIqdw9bh6U17NS+/FDAQLX/5DyPccFnHuWWabAQQSRa4QmH9TnRhJ/1IpfCHEggPLzjR2kvXJRwiD4sJwo/fAgC+BnN8t
X-Gm-Message-State: AOJu0YxDKspcP8EzRqtPZRAt79uW4LsTfck9xxSe7K6lNu1FEWsNWfPT
	D9j56LYI7geB/SQCP3QKT9lPWej03sYixgH+O4Ldme9uc4xqz6n1VeQ3efJZy30IplqJnylguWF
	YTKHUaQYEt+LVhuo1fEbljYTjO+k=
X-Google-Smtp-Source: AGHT+IGIQBgQs0/0XUDNmD2dno2WAe2gtY1HXhGqpZCxiIFvub8VoZsh8lfP2ESItgpq0YzJYUMQuR9NE9/ZfyctA4I=
X-Received: by 2002:a67:f658:0:b0:47b:bda4:c30d with SMTP id
 u24-20020a67f658000000b0047bbda4c30dmr1839721vso.3.1715078894913; Tue, 07 May
 2024 03:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503005023.174597-1-21cnbao@gmail.com> <20240503005023.174597-7-21cnbao@gmail.com>
 <0b4d4d4b-91d8-4fd5-af4e-aebe9ee08b89@arm.com> <CAGsJ_4wm6v+xgh4jQ+u2-EzOXCLsz6L6nRJi_=FfWuGDUjxRYg@mail.gmail.com>
 <ff5b371a-16f6-4d03-b80d-b56af0f488c3@redhat.com> <CAGsJ_4z93FwPZx7w2VuCEkHP_JCwkO0whKwymonRJ9bSiKMVyQ@mail.gmail.com>
 <CAGsJ_4xssg3CcjifePMmgk4aqLO+iAon0YdT9p=Uq-D8vFMxyQ@mail.gmail.com>
 <5b770715-7516-42a8-9ea0-3f61572d92af@redhat.com> <CAGsJ_4xP1jPjH-SH7BgnFHiT4m+2gB0tP7ie_cUFynVpD_zpxQ@mail.gmail.com>
 <7dc2084e-d8b1-42f7-b854-38981839f82e@redhat.com> <CAGsJ_4w4vDu4p-ALrTSKMZhGKDK6TpyDLrAyvY4vkPJEJ3N5Lw@mail.gmail.com>
 <099a2c9e-f85e-4fe7-99dd-81b61115935c@redhat.com> <CAGsJ_4wNTgkP7An7ofXkfyhRpF=J-OLWTW7e5hOFef5-CxZe4Q@mail.gmail.com>
 <41c1bd1f-b1d7-4faf-a422-1eff7425b35c@redhat.com>
In-Reply-To: <41c1bd1f-b1d7-4faf-a422-1eff7425b35c@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 7 May 2024 18:48:03 +0800
Message-ID: <CAGsJ_4whPN91m0v_=TtnnQN8y1CQgau+4F40q1vkrRUFK5t0wA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] mm: swap: entirely map large folios found in swapcache
To: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com, 
	hannes@cmpxchg.org, hughd@google.com, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:39=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 07.05.24 11:24, Barry Song wrote:
> > On Tue, May 7, 2024 at 8:59=E2=80=AFPM David Hildenbrand <david@redhat.=
com> wrote:
> >>
> >>>> Let's assume a single subpage of a large folio is no longer mapped.
> >>>> Then, we'd have:
> >>>>
> >>>> nr_pages =3D=3D folio_nr_pages(folio) - 1.
> >>>>
> >>>> You could simply map+reuse most of the folio without COWing.
> >>>
> >>> yes. This is good but the pte which is no longer mapped could be
> >>> anyone within the nr_pages PTEs. so it could be quite tricky for
> >>> set_ptes.
> >>
> >> The swap batching logic should take care of that, otherwise it would b=
e
> >> buggy.
> >
> > When you mention "it would be buggy," are you also referring to the cur=
rent
> > fallback approach? or only refer to the future patch which might be abl=
e
> > to map/reuse "nr_pages - 1" pages?
>
> swap_pte_batch() should not skip any holes. So consequently, set_ptes()
> should do the right thing. (regarding your comment "could be quite ricky
> for set_ptes")
>
> So I think that should be working as expected.

maybe not. take a look at my current code, I am goto check_folio with
nr_pages =3D 1
if  swap_pte_batch(folio_ptep, nr, folio_pte) !=3D folio_nr_pages(folio).

+       nr_pages =3D 1;
+       ...
+       if (folio_test_large(folio) && folio_test_swapcache(folio)) {
+               int nr =3D folio_nr_pages(folio);
+               ...
+               if (!pte_same(folio_pte,
pte_move_swp_offset(vmf->orig_pte, -idx)) ||
+                   swap_pte_batch(folio_ptep, nr, folio_pte) !=3D nr)
+                       goto check_folio; /* read here, i am falling
back nr_pages =3D 1 */
+
+
+               ...
+               nr_pages =3D nr;

The fallback(=3D1) works. but it seems you are proposing set nr_pages =3D
swap_pte_batch(folio_ptep, nr, folio_pte)
if (swap_pte_batch(folio_ptep, nr, folio_pte) > 1 &&
swap_pte_batch(folio_ptep, nr, folio_pte) <
nr_pages) ?

>
> >
> > The current patch falls back to setting nr_pages =3D 1 without mapping =
or
> > reusing nr_pages - 1. I feel your concern doesn't refer to this fallbac=
k?
> >
> >>
> >>>
> >>>>
> >>>> Once we support COW reuse of PTE-mapped THP we'd do the same. Here, =
it's
> >>>> just easy to detect that the folio is exclusive (folio_ref_count(fol=
io)
> >>>> =3D=3D 1 before mapping anything).
> >>>>
> >>>> If you really want to mimic what do_wp_page() currently does, you sh=
ould
> >>>> have:
> >>>>
> >>>> exclusive || (folio_ref_count(folio) =3D=3D 1 && !folio_test_large(f=
olio))
> >>>
> >>> I actually dislike the part that do_wp_page() handles the reuse of a =
large
> >>> folio which is entirely mapped. For example, A forks B, B exit, we wr=
ite
> >>> A's large folio, we get nr_pages CoW of small folios. Ideally, we can
> >>> reuse the whole folios for writing.
> >>
> >> Yes, see the link I shared to what I am working on. There isn't really=
 a
> >> question if what we do right now needs to be improved and all these
> >> scenarios are pretty obvious clear.
> >
> > Great! I plan to dedicate more time to reviewing your work.
>
> Nice! And there will be a lot of follow-up optimization work I won't
> tackle immediately regarding COW (COW-reuse around, maybe sometimes we
> want to COW bigger chunks).
>
> I still have making PageAnonExclusive a per-folio flag on my TODO list,
> that will help the COW-reuse around case a lot.
>
> >
> >>
> >>>
> >>>>
> >>>> Personally, I think we should keep it simple here and use:
> >>>>
> >>>> exclusive || folio_ref_count(folio) =3D=3D 1
> >>>
> >>> I feel this is still better than
> >>> exclusive || (folio_ref_count(folio) =3D=3D 1 && !folio_test_large(fo=
lio))
> >>> as we reuse the whole large folio. the do_wp_page() behaviour
> >>> doesn't have this.
> >>
> >> Yes, but there is the comment "Same logic as in do_wp_page();". We
> >> already ran into issues having different COW reuse logic all over the
> >> place. For this case here, I don't care if we leave it as
> >>
> >> "exclusive || folio_ref_count(folio) =3D=3D 1"
> >
> > I'm perfectly fine with using the code for this patchset and maybe
> > looking for other
> > opportunities for potential optimization as an incremental patchset,
> > for example,
> > reusing the remaining PTEs as suggested by you -  "simply map+reuse mos=
t of
> > the folio without COWing."
> >
> >>
> >> But let's not try inventing new stuff here.
> >
> > It seems you ignored and snipped my "16 + 14" pages and "15" pages
> > example though. but once we support "simply map+reuse most of the
> > folio without COWing", the "16+14" problem can be resolved, instead,
> > we consume 16 pages.
>
>
> Oh, sorry for skipping that, for me it was rather clear: the partially
> mapped folios will be on the deferred split list and the excess memory
> can (and will be) reclaimed when there is need. So this temporary memory
> consumption is usually not a problem in practice. But yes, something to
> optimize (just like COW reuse in general).
>
> --
> Cheers,
>
> David / dhildenb
>

