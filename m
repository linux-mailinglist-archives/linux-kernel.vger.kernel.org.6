Return-Path: <linux-kernel+bounces-210175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C03904071
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71752860D4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E85383A3;
	Tue, 11 Jun 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FUxVeja1"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E446125A9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718120872; cv=none; b=HSTHayN/YQp5HuGOVl7/9DcpG8H8pwXERsUsc/EzjoH8vgBer9vVI1NM8h3BhbktQGvoM3xtDPCQ4w8NV3cR+sjzcYSCejTsfmKPXABlBx5UZascW8hQoqbqE7Sxu2zE1xilCS0umolFDOYgC3nW7aAXD4Nu14iOXM4wGTJ/aC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718120872; c=relaxed/simple;
	bh=9geANwTIsJXpD5TdTNQhyt0cAYwzG1X84sh66DYrpYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zyw+FPLm4/BtmlRWoFg2pAq6wwqIe2BnOFCxAiE0TAccGHai2q/j42dOr5/He3uydviRlPVtmFcS1IWs1F52ESD7ar9OiKCoJcLBZ9o6i4Dmk2wCvIGUgsamIFuu62UhUPpDCkVaEbe9QoU/0OcNPOTQYj9t6fDjSs6XQDWb7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FUxVeja1; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d218ea7750so708750b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718120870; x=1718725670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpM+X0foseE+HCoQOOJMRUvbhVQW/GLwLX9rUTKHX0Q=;
        b=FUxVeja1De5C64/CTv2YzLuvK6RUFYgLqeJff8Ff0B3m/+hrutMp2sl1tsC4ZTGy4O
         e1jx9iDDKXycCqZkpkCanFP5OaJ5Bqy4OEkONtuCLEDRtMqM6TWoxJ44CDEYFtGwJx/4
         glYOAYdTCfrcG9HxZUqByBh4+OuNLltTIh9Yqvrs1W0obbvfxE7vCv7Tej14pwPh7c30
         Q6JTCg0Bo5v0C2me6e5vgHqAE4sShzBN0A/EjpV1TfIsi/5lX2ITDj/4PPtOv2NakAU6
         Xr4y2LyQVAizoTTIxb7qTUyQWg6Zt5kG6gV3N4dMLhKK+kAeNLw9iTs6UjWKG0+FVaFY
         T8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718120870; x=1718725670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpM+X0foseE+HCoQOOJMRUvbhVQW/GLwLX9rUTKHX0Q=;
        b=ASqdnMbzQYfvhamEIp22UHAM23Axud08shMYo38jcOeKCwF1YedtlWrxlxZLD6Xmz1
         2Ll63LoX0e+l1QajjsC6zXLmrrB0gYtFIzujAyVZXZradO4kXZapKCxOzVdZY70NdCUs
         VZTBhhG6eJHta2Jho1L4fUehZOrLzZow3h8vOPzi7mA3EfvmVhvp/9q05/DNBo1KEjBo
         o/q+TbOArAIbllxzWe1zvGiZObTPM6wWAaKmCuIjIAjpFHaQkLrI8M04ePa2Bh+9w2ql
         nROwzdf4DXPbX5+ORMUmm/BHScHcHr6RyFH4PKpQTzdifHvLKJVMZubAmYhY6sDtMGai
         G7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGYrxfjN0sZLlbTLj1x22f+lnRQg0TCCYdUZ/5+dOxF09r/LbTPeV9Ea3a+oFnIFSZqyevFr5jW8RNTaLNjIN6uJn50qhasir5Dv6W
X-Gm-Message-State: AOJu0Yw3gmNSXoP7/HkmJ3fQOZM+WrpaBbGP4fcBXLZiOoCuNUEVmUiT
	npHxANlL1keU5VzlKLSL9v3x6jqTJT+lybLHncS2J8Oz6kQlifgiiJGTDNPV44lloPHyKXa0g8l
	Ad+TvuelYNld2v5OZGt9cwczzERrGJBbcJ3Zj
X-Google-Smtp-Source: AGHT+IGsUm8uoXy2Frod9+g47BSX/WQwflOqQo3V7ZvgfN5VWQw8m8zz9XQk2EJ6h60boQrBDC7OiaZYSjlc+6BkQ24=
X-Received: by 2002:a05:6808:3196:b0:3d2:314b:cd0f with SMTP id
 5614622812f47-3d2314bd006mr4312540b6e.3.1718120870066; Tue, 11 Jun 2024
 08:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <2821278f-bc94-c147-d0fe-8cc52dbdccb1@redhat.com> <CAJD7tkYepf6z1Q7HiSRAc7-S9OwYCphx=9NcyHxtW0YrkFv0sQ@mail.gmail.com>
 <811778e4-6af4-563a-757e-83fec207e79f@redhat.com>
In-Reply-To: <811778e4-6af4-563a-757e-83fec207e79f@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 08:47:10 -0700
Message-ID: <CAJD7tkZ60Ru7b_BYZZy_hZtp=Tmz=KwQy28tqn-kHMkEKwbiFQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 9:14=E2=80=AFPM Mika Penttil=C3=A4 <mpenttil@redhat=
.com> wrote:
>
>
> On 6/10/24 20:35, Yosry Ahmed wrote:
> > On Fri, Jun 7, 2024 at 9:08=E2=80=AFPM Mika Penttil=C3=A4 <mpenttil@red=
hat.com> wrote:
> >> On 6/8/24 05:36, Yosry Ahmed wrote:
> >>> diff --git a/mm/zswap.c b/mm/zswap.c
> >>> index b9b35ef86d9be..ebb878d3e7865 100644
> >>> --- a/mm/zswap.c
> >>> +++ b/mm/zswap.c
> >>> @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> >>>
> >>>       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >>>
> >>> +     /*
> >>> +      * Large folios should not be swapped in while zswap is being u=
sed, as
> >>> +      * they are not properly handled. Zswap does not properly load =
large
> >>> +      * folios, and a large folio may only be partially in zswap.
> >>> +      *
> >>> +      * If any of the subpages are in zswap, reading from disk would=
 result
> >>> +      * in data corruption, so return true without marking the folio=
 uptodate
> >>> +      * so that an IO error is emitted (e.g. do_swap_page() will sig=
fault).
> >>> +      *
> >>> +      * Otherwise, return false and read the folio from disk.
> >>> +      */
> >>> +     if (folio_test_large(folio)) {
> >>> +             if (xa_find(tree, &offset,
> >>> +                         offset + folio_nr_pages(folio) - 1, XA_PRES=
ENT)) {
> >>> +                     WARN_ON_ONCE(1);
> >>> +                     return true;
> >>> +             }
> >> How does that work? Should it be xa_find_after() to not always find
> >> current entry?
> > By "current entry" I believe you mean the entry corresponding to
> > "offset" (i.e. the first subpage of the folio). At this point, we
> > haven't checked if that offset has a corresponding entry in zswap or
> > not. It may be on disk, or zwap may be disabled.
>
> Okay you test if there's any matching offset in zswap for the folio.
>
>
> >> And does it still mean those subsequent entries map to same folio?
> > If I understand correctly, a folio in the swapcache has contiguous
> > swap offsets for its subpages. So I am assuming that the large folio
> > swapin case will adhere to that (i.e. we only swapin a large folio if
> > the swap offsets are contiguous). Did I misunderstand something here?
>
> Yes I think that is fair assumption for now. But also saw your v3 which
> doesn't depend on this.

Yeah Barry pointed out that we want to warn if a large folio reaches
zswap and there is a chance that it is in zswap (i.e. zswap was
enabled), even if it happens that the folio is not in zswap during
swapin. This gives wider coverage and is cheaper when zswap is
disabled than the lookups.

We will also need to check if zswap was ever enabled in the large
folio swapin series anyway, so the helper introduced in v3 should be
helpful there as well.

