Return-Path: <linux-kernel+bounces-315668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A6996C598
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 19:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FF51C22771
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037F21E132F;
	Wed,  4 Sep 2024 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1GiFEEW"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38521DEFCD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725471679; cv=none; b=KeRgCDwpCToa+4hFcfiRkt3dfdQIEmdUR34oTsqWUmNKfIpy4O3jLv5Un4eZgO1MT8Ua92y1yIfafD+/FjP0BKMGUpj3s4eHjqfdUXgzMeP7Oxj1rWkA4RvKlJXdQnHdUzBzBMkKz+juZ3E7ExLsEzFHDt/kGZf2/lM2xY+VnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725471679; c=relaxed/simple;
	bh=UZBuD8ujlpQgbSRbizirR+La9i0Qd++C4v9xqo3Ygjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=myY7uJ26MRK1y7cgjgQZDDVvSY87lBXS1mYusz9MwtwiCCVsIStOuKrX57CSP/km1AvWb7vOhIC0e14dkeecdrNKl2hKdajEo3IOAsRA2pL0MmO6cfevckHYbFlJ9B9OWf6Q28SSjphFwF1kcqly6P9jyzyFDauLZJMImoTuDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1GiFEEW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f6514f23b6so21307131fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 10:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725471676; x=1726076476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UZBuD8ujlpQgbSRbizirR+La9i0Qd++C4v9xqo3Ygjg=;
        b=s1GiFEEW3bWiqkCvbdgkAu+uHPfgit5gmMRUnrjuyZQePv2BhO5x5xLZXHtkDHbzuD
         Ss4FH1wM7F/sBN6OmjwIch2k+PhD3dn880Q51ecD6o7w3TkxY7eE5l7fBjAy2Jx9i7AU
         Py2GvvuNr3tBvB+DuMpT0ruCCQuDhWOlLhylJ2PFxGy4Tugegu8VgSO6ENbk3CcKheCf
         yqVxXlwlDQh4eFnVuTnPRBoVMAoDwJBeh3sVR4bStWG0bSp31ERd/KpBrrsSZezn/yDf
         Cmx8dnacsD2bvkS9fM0SPkogFFI4Umni+hh6XUUSCmqimLpDqCM0I/tvnOyrJJAdxkZ8
         4M4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725471676; x=1726076476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZBuD8ujlpQgbSRbizirR+La9i0Qd++C4v9xqo3Ygjg=;
        b=IBbItuC2SBfYzMgEF3zLfCQ22v4TOE4k75BxR5XlG0fnyfmZGh5ZlLndhNthTlcs45
         IV9mhY38dSXDPWu48U3U2/NRmd7H5t/2jdz6xZh4f6ffpXo422CGKOx61dyCpSTyFp//
         3mqR3EpWU4hmLGoqCGrF5VlOwWqzA0VjEd0NkWf0nveST4KxcwNZ3JAcHcxEgC+mmeA9
         wpdLeFE3jZG1309vDsWQiKQzH0zfVFD66vep3GB5WZfVuawj15/afjgtK12tBig5aWgv
         x3A1LAWoYNH6Dj3yBxn43pGMO8slnGUgR2yUea8qQtwpwJ5EOLp6v4+a+aVQlpcgAIdc
         /r2w==
X-Forwarded-Encrypted: i=1; AJvYcCXTFmLIKcvgj0b4RFpCgFw+CNBnWtc2XhlMXP+pupRVDoirwEGY3TV1LRJvq0ZhWthbi/3b4xcT6qfPJ8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzazvud1fTtaDT3H+gPiDwHovvG9pswpCcYn+nXl186DSFj/QvD
	OYOu/Sy/5MI6gTMjw5RkgCgNFxHq25DpQ5CeDtQjYw/G/x2HHwQ4MJEgeNcHHr4cvkQalyN6B8A
	FJ1/tDUuQur2x3GtUOxgjfuDST2mjm7zbTaIH
X-Google-Smtp-Source: AGHT+IEoDXI8FoMx8V9lgWzFfG23TZNEnZ2xUS6KrnJAvtWs0eqvlCYsIDcNRgoyvFYSEkuv8wZ+8GZJ8TUPESV3Hms=
X-Received: by 2002:a2e:b8d6:0:b0:2ef:2ba5:d214 with SMTP id
 38308e7fff4ca-2f6105c4facmr208540991fa.4.1725471674645; Wed, 04 Sep 2024
 10:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com> <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
In-Reply-To: <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 4 Sep 2024 10:40:37 -0700
Message-ID: <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"

[..]
> > I understand the point of doing this to unblock the synchronous large
> > folio swapin support work, but at some point we're gonna have to
> > actually handle the cases where a large folio being swapped in is
> > partially in the swap cache, zswap, the zeromap, etc.
> >
> > All these cases will need similar-ish handling, and I suspect we won't
> > just skip swapping in large folios in all these cases.
>
> I agree that this is definitely the goal. `swap_read_folio()` should be a
> dependable API that always returns reliable data, regardless of whether
> `zeromap` or `zswap` is involved. Despite these issues, mTHP swap-in shouldn't
> be held back. Significant efforts are underway to support large folios in
> `zswap`, and progress is being made. Not to mention we've already allowed
> `zeromap` to proceed, even though it doesn't support large folios.
>
> It's genuinely unfair to let the lack of mTHP support in `zeromap` and
> `zswap` hold swap-in hostage.

Well, two points here:

1. I did not say that we should block the synchronous mTHP swapin work
for this :) I said the next item on the TODO list for mTHP swapin
support should be handling these cases.

2. I think two things are getting conflated here. Zswap needs to
support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What is
truly, and is outside the scope of zswap/zeromap, is being able to
support hybrid mTHP swapin.

When swapping in an mTHP, the swapped entries can be on disk, in the
swapcache, in zswap, or in the zeromap. Even if all these things
support mTHPs individually, we essentially need support to form an
mTHP from swap entries in different backends. That's what I meant.
Actually if we have that, we may not really need mTHP swapin support
in zswap, because we can just form the large folio in the swap layer
from multiple zswap entries.

>
> Nonetheless, `zeromap` and `zswap` are distinct cases. With `zeromap`, we
> permit almost all mTHP swap-ins, except for those rare situations where
> small folios that were swapped out happen to have contiguous and aligned
> swap slots.
>
> swapcache is another quite different story, since our user scenarios begin from
> the simplest sync io on mobile phones, we don't quite care about swapcache.

Right. The reason I bring this up is as I mentioned above, there is a
common problem of forming large folios from different sources, which
includes the swap cache. The fact that synchronous swapin does not use
the swapcache was a happy coincidence for you, as you can add support
mTHP swapins without handling this case yet ;)

