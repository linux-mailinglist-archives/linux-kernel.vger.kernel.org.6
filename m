Return-Path: <linux-kernel+bounces-210637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CD9904684
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACEAB23D83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4864E153BED;
	Tue, 11 Jun 2024 21:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrxLRWND"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE137150991
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143022; cv=none; b=Hld9IxmrCd6XVNsDP3XclFwUTjLUovIsYGJdKfesjW0HfDOc43AUI4RcYWZVmdyf8ksZhxI9g+0AXR1R8GBFjdYEv2guSQ8PqAYHS4QYWjBNCRToWlG6W8DiKj57Cb1kj0xSJLuwPM5OpeIAZ+R36fWZnh9QzWb/FljuG7qrny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143022; c=relaxed/simple;
	bh=agXN9Gipjw+pf0Mh9t9kyOWdsvHccTm14f95vB7PnqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOBmt/sKX2gy1WY2wVuxJLmSe8I4jMvW5dwQBPoEDnZmoZ6vEeBEVu8xQtuK0fxvJS5LsibhYtI16rtvJQoHeJ+35AMHEJZ/HE7iDbJO85NY9Z3z0iQFqN929mH5EQqvUrM5YPHuK7mz60oWf+YMaF2kKL8i7eAhp7EeHas30vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrxLRWND; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-627f3265898so66071937b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718143020; x=1718747820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFPzpbdZgLD1mZkKCkz1VVk0Pl1CoNVTvT/bK6W2iwY=;
        b=MrxLRWNDLtpixbpI8rS9oB6xHBQD2B2KFqpb8TnCxgNciWwIpfOOFbnOeQiYzeo7Nq
         XSV/8NNt++piniq+8JDzISFcIKBVLUuBgH/NbeV7wuYkhH8NPU8Qgtfe/xbq0VEiHS64
         bpOhkfkQ43fCWHusQQh98TT5qHJZ0W6ECk/re+687xVfj7/xFD74PfN3WIdmAtlqRhFn
         rzIgC2KzfE+buHqCvvzi4O4LZ2McB9oQZGBCQd6+G4Ld/w4RiV1c3tNzze2jVRxsQm1+
         KrWW2PM7nxl4tC32byHUZ7ztlSFfMRoUqoH32DMuIzqaNXEjWTzNK3/wQtnYJ66Z/ROL
         Pz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718143020; x=1718747820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFPzpbdZgLD1mZkKCkz1VVk0Pl1CoNVTvT/bK6W2iwY=;
        b=lGdm/+NuRHPVI4Bg7zPzZg1MfeWuIQ5oFm2a2UzZfLT9OVv8mOBBzTlrgAeew7NIkL
         0x2HeFMDOfluIPE+vw+0/TYXmPFSVR8DUB/JHFa5buW5HG4zr/Vse7gAeJ8AJHOiVkj2
         Ty+WDFkUNSGC5EsMKQeIpK7Wsk0NUUYQyucmrjxGDsKEXCT6MFgmZS9704PaqxTPlbhD
         /x5H7TOAceBV1RlXSRomoSAyB+0FrhD0oBwGg4UTvlTzStgVP00NKMorfjw5KLBZuerP
         jPRNp83ToYjbYBgaNAmbhC/fhm/gTaR1ayTHXxuTs3BFO4WRpQ+ghjHDV3ZacEyLW8Al
         vvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWugmiOYXdKpGRR3ziUf7tlxddKlrRx/6TW6U03HbzRRrHhP/X84RAoUNERjxIPPKvMAqRGCWhLs7o6i7AdD5S62xL78IdtV9wmnrEr
X-Gm-Message-State: AOJu0Yzqx1WT24VXcJWNuwr5VHnqQ+fKinjQAPVqBRKMeFJj0JQEVY/h
	FG3gYd2NWVFH+DS9Yxfkg5EJl33zTF5TvWBjLqmzjO4BUVjUEHb1Obd9RtxOwAJqlp1K3AssAX9
	xEV5+GgFQQGb8QsMG8n/NeNNqN0A=
X-Google-Smtp-Source: AGHT+IEURE6BigixBTYPVVFvCEaxX5ps7Gkee44s3uyzU6SE32C414iu30bvkV4dlMcNqK52ptWcSKgWj6oQI4Rk5H4=
X-Received: by 2002:a81:48d2:0:b0:60c:c31c:4f71 with SMTP id
 00721157ae682-62fba567702mr600827b3.42.1718143019422; Tue, 11 Jun 2024
 14:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com> <20240611024516.1375191-3-yosryahmed@google.com>
In-Reply-To: <20240611024516.1375191-3-yosryahmed@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 12 Jun 2024 09:56:48 +1200
Message-ID: <CAGsJ_4xxtKTzpBo9KH75+DBQ=z_POa3O8ao3a8tnFg1Mr5PUDQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm: zswap: handle incorrect attempts to load large folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Zswap does not support storing or loading large folios. Until proper
> support is added, attempts to load large folios from zswap are a bug.
>
> For example, if a swapin fault observes that contiguous PTEs are
> pointing to contiguous swap entries and tries to swap them in as a large
> folio, swap_read_folio() will pass in a large folio to zswap_load(), but
> zswap_load() will only effectively load the first page in the folio. If
> the first page is not in zswap, the folio will be read from disk, even
> though other pages may be in zswap.
>
> In both cases, this will lead to silent data corruption. Proper support
> needs to be added before large folio swapins and zswap can work
> together.
>
> Looking at callers of swap_read_folio(), it seems like they are either
> allocated from __read_swap_cache_async() or do_swap_page() in the
> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, so
> everything is fine for now.
>
> However, there is ongoing work to add to support large folio swapins
> [1]. To make sure new development does not break zswap (or get broken by
> zswap), add minimal handling of incorrect loads of large folios to
> zswap.
>
> First, move the call folio_mark_uptodate() inside zswap_load().
>
> If a large folio load is attempted, and zswap was ever enabled on the
> system, return 'true' without calling folio_mark_uptodate(). This will
> prevent the folio from being read from disk, and will emit an IO error
> because the folio is not uptodate (e.g. do_swap_fault() will return
> VM_FAULT_SIGBUS). It may not be reliable recovery in all cases, but it
> is better than nothing.
>
> This was tested by hacking the allocation in __read_swap_cache_async()
> to use order 2 and __GFP_COMP.
>
> In the future, to handle this correctly, the swapin code should:
> (a) Fallback to order-0 swapins if zswap was ever used on the machine,
> because compressed pages remain in zswap after it is disabled.
> (b) Add proper support to swapin large folios from zswap (fully or
> partially).
>
> Probably start with (a) then followup with (b).
>
> [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-21cnbao@gmail=
.com/
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Barry Song <baohua@kernel.org>

> ---
>  mm/page_io.c |  1 -
>  mm/zswap.c   | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index f1a9cfab6e748..8f441dd8e109f 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct swap=
_iocb **plug)
>         delayacct_swapin_start();
>
>         if (zswap_load(folio)) {
> -               folio_mark_uptodate(folio);
>                 folio_unlock(folio);
>         } else if (data_race(sis->flags & SWP_FS_OPS)) {
>                 swap_read_folio_fs(folio, plug);
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7fcd751e847d6..505f4b9812891 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1566,6 +1566,17 @@ bool zswap_load(struct folio *folio)
>         if (zswap_never_enabled())
>                 return false;
>
> +       /*
> +        * Large folios should not be swapped in while zswap is being use=
d, as
> +        * they are not properly handled. Zswap does not properly load la=
rge
> +        * folios, and a large folio may only be partially in zswap.
> +        *
> +        * Return true without marking the folio uptodate so that an IO e=
rror is
> +        * emitted (e.g. do_swap_page() will sigbus).
> +        */
> +       if (WARN_ON_ONCE(folio_test_large(folio)))
> +               return true;
> +
>         /*
>          * When reading into the swapcache, invalidate our entry. The
>          * swapcache can be the authoritative owner of the page and
> @@ -1600,6 +1611,7 @@ bool zswap_load(struct folio *folio)
>                 folio_mark_dirty(folio);
>         }
>
> +       folio_mark_uptodate(folio);
>         return true;
>  }
>
> --
> 2.45.2.505.gda0bf45e8d-goog
>

