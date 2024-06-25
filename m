Return-Path: <linux-kernel+bounces-228344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B36915E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6A81F2331E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B4145B26;
	Tue, 25 Jun 2024 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ogrGwA"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422D13A3ED
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294966; cv=none; b=nYY0ql0OKsQOqwJ2a64QsoK44TS/o+FQ8uUoD5gJIL0BvQpxcEl35YO27MCJVJ4w1mwlARxH5KMJWBEi+2cmH9tGDxIyif6TFggdSaJFRA40qi+qUkRNy92MPR9MHP4olAN4/AuPupmseQ8LSPuaAQNnj2AfS9pOduD8azX/kbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294966; c=relaxed/simple;
	bh=l6/nDOsySzcGEWttp3aXYRErAU2WilZ5nJIXPHBdA4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B81I865gkVoFMgKlGuiPLLeSOnUQSyl9buEQMGGTYD4lQGDnhzKXqxMWBEUScNFyub2tiXPlwQR/GsBj2yifWp4BaxAjLhA36S3SYuJFAB/6g3eyA2kkv2uiMRpjnjVKG1VHsLrpEEvW2rIaNDTMGFjn36cn7ZrMxDTHf8KHq2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ogrGwA; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4ef662a4725so1056554e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719294964; x=1719899764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOFhycCWHBbJEQrq9FLSxAq+8ycAlK7Oq890nn94zL4=;
        b=N6ogrGwA0FRX6pAPgVcdNBZwo90xQKvRrQWZM4YuM1BUMznrBOAyJeiXh7umctbzJl
         MibiHaI/NMtWnb9fXnNLBM29wi+Og1iruzY4rn6vUkSuV+f/Aw3Y+tPgujKI4xMQU+eB
         0VILNimOy80s2GLRKSAJbYOFZeL+EMulpjJYXS8aOqO5XJHCfVleMTgkZ/oJBTMSwEeL
         MmV33ITYL5tUy9m85sD+TsW8LgxOwVkCYeAo5R+C0rnVE2WYsHLlyO7xaYWxFRsS6VyY
         chN/e3L6aWRmxkMO1thnOqRt40Mwx2lYJqTPJpv5NEu6ayN+vHl5njNDMclPGC0+jrXO
         92YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719294964; x=1719899764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOFhycCWHBbJEQrq9FLSxAq+8ycAlK7Oq890nn94zL4=;
        b=RUCMdLhSJJdKfuuwkwN7cvnIDO9X+8DZjTpvzaeIo92kYy0ZOmN4771FDIlNRq8R6j
         FjzWuY2MY5Sv4xCVlepHgXAh3TyoSrLTOEjmHHnhvmEUeiOXuscFfjhwUHVZQKnjkbu7
         VM09aCQKC4rM+4TmBHjlNoupfoNLqpoN9GmM7voPTccZ6JyTvNVWcbyyQqzUnPPZAH5D
         5UkC4ChkkenC7IYdhHtQDVBcUQ2Uo0yWAA7XK1QwXoflr2CqXyWRGAqiFBgwicDwSIWE
         KSMkUi4EgV+Pn49YftclJvbcDkP2YmGjs0LHzdHOrp74V4fI7SWEHasYS8fA70Q/ojpb
         aTpg==
X-Forwarded-Encrypted: i=1; AJvYcCWyoQuHWgaPEznsNQA1PFn8btorSI86ARjZu8Dp9tElE6l9pHLi7yDV5Bsw8ISXDYE9GDgg6PFFUGSsPc7V4ujWygoxwWktXdDuubR3
X-Gm-Message-State: AOJu0YxNUmAoxL8FaWKamUWBt6oZjA0EFvTQhN19cah/hv26Sbudd6KX
	XTlU4WO+IAZ2eeIEExGZghV9Pz1xS/tkcyPR10jLRKnG3jd2i9ejz12rrepkzmq45gSOe8H7JVM
	W8+cEGda9iZKNJYGLQtyZfQGsmMB8uZJx
X-Google-Smtp-Source: AGHT+IE7T2LcUMcE1A63kLs9QJDaEDTGtUFg7xS+X+MZm0MSQGirxng8mmJ4g8tYXVFqJY2sPGcbFxxlUyITU3dOggc=
X-Received: by 2002:a05:6122:4a13:b0:4ef:6b47:3570 with SMTP id
 71dfb90a1353d-4ef6b473751mr5401208e0c.8.1719294963866; Mon, 24 Jun 2024
 22:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com>
In-Reply-To: <f3599b1d-8323-0dc5-e9e0-fdb3cfc3dd5a@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 25 Jun 2024 17:55:51 +1200
Message-ID: <CAGsJ_4xABUi11ruC5obXvGi3R8zVQx2gzGAeqTGh22bj4xR9Dw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm: folio_add_new_anon_rmap() careful __folio_set_swapbacked()
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, mhocko@suse.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, surenb@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuanshuai@oppo.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 5:00=E2=80=AFPM Hugh Dickins <hughd@google.com> wro=
te:
>
> Commit "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio)=3D=3D
> false" has extended folio_add_new_anon_rmap() to use on non-exclusive
> folios, already visible to others in swap cache and on LRU.
>
> That renders its non-atomic __folio_set_swapbacked() unsafe: it risks
> overwriting concurrent atomic operations on folio->flags, losing bits
> added or restoring bits cleared.  Since it's only used in this risky
> way when folio_test_locked and !folio_test_anon, many such races are
> excluded; but, for example, isolations by folio_test_clear_lru() are
> vulnerable, and setting or clearing active.
>
> It could just use the atomic folio_set_swapbacked(); but this function
> does try to avoid atomics where it can, so use a branch instead: just
> avoid setting swapbacked when it is already set, that is good enough.
> (Swapbacked is normally stable once set: lazyfree can undo it, but
> only later, when found anon in a page table.)
>
> This fixes a lot of instability under compaction and swapping loads:
> assorted "Bad page"s, VM_BUG_ON_FOLIO()s, apparently even page double
> frees - though I've not worked out what races could lead to the latter.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks a lot, Hugh. Sorry for my mistake. I guess we should squash this int=
o
patch 1/3 "mm: use folio_add_new_anon_rmap() if folio_test_anon(folio) =3D=
=3D
false"?
Andrew, could you please help to squash this one?

> ---
>  mm/rmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index df1a43295c85..5394c1178bf1 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1408,7 +1408,9 @@ void folio_add_new_anon_rmap(struct folio *folio, s=
truct vm_area_struct *vma,
>         VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
>         VM_BUG_ON_VMA(address < vma->vm_start ||
>                         address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
> -       __folio_set_swapbacked(folio);
> +
> +       if (!folio_test_swapbacked(folio))
> +               __folio_set_swapbacked(folio);
>         __folio_set_anon(folio, vma, address, exclusive);
>
>         if (likely(!folio_test_large(folio))) {
> --
> 2.35.3
>

Thanks
Barry

