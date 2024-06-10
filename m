Return-Path: <linux-kernel+bounces-208733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E609028AB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C764EB21C94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EDC14C5BE;
	Mon, 10 Jun 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ibP8fv8"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E82B9D7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718044205; cv=none; b=Vib0UfJGPzdKadnvYhgiF7eiTrlkhCev2VVQ3h5/t77CiR0ix+GjbosPYOfioOzlv3dbA5aWQ4L8/SZRpiBz/jYqIMyy+2bNIpMgqxFNyelgCMiS1eZPxH9zgS54d2JYefxj3baXHyTaIXIOB6hWGv/DJYrHrxpc+siaeILJJIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718044205; c=relaxed/simple;
	bh=QdUYJpnRolTcMyemzLnepRhmqcaapui/zzEPf/fv+KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eXGsDhAzq7I3y0V7j3RTra8waXEkq4DIUxv2bZNsPxDZaRWTolvvxPVpkcpiocPBkYnFGsWIG6PBcMhBUmFtiqORsSA2DjOINNwgf2fQ18xVJdz0RnSfYm+auXoWRzmrYqLqYCbQM21gqx6E2FiLio4bx6Ej8+g2XyMnMl0sZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ibP8fv8; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so95268281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718044202; x=1718649002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzeYDX53YhzVDP5G9Sqj56BiX8iqkARqJWojqclpCyw=;
        b=3ibP8fv8USziM4jjiP8j0cO7ixV5sgtj41tBYnYOZ1DL7yHqeygiLCOvtmIWonC895
         s9nrB4hN7fOvXqcJU8rKg59EYv5BKIZW7Ou4rQ3II4NfZKRK3DnB/UyotBIdPZlsgbSf
         PIMVKBR0J1ntoG2wH8SCfIpR68bgZl2YUdwfwtfJJbMV8urQj2L4CkiWDygWuYXCwEOP
         7G++S9O1HWTxg04C5vyXcCtAfWO43nBYjbFijGxkiH0ptB75zp8GA/V4GpyBtQ3CPG/y
         S8PXvAkkW+4ZOhpKV+yxTEEK+ylrUSDezpFtX6WEcKGqEFuXIkQjCty7LuHqMOzKkBf4
         fyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718044202; x=1718649002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzeYDX53YhzVDP5G9Sqj56BiX8iqkARqJWojqclpCyw=;
        b=mh4s0OYjhqRTlLYfPk5mxBrW49lcw4o8ffsqEPzNFQNfHKDZndGSY0/thlnjqiYYew
         gaebQr7Q8c9iIkWwF+UuIXgbOdS/bMKswHnvgv6xmymjygBL3o3e3E/5tAkFMpvqrxc1
         nfp8ovrP3vxi4jdPoXwfVuxJ+y5lC55cmTBbJhz7+G2czdk8VfuKum6kRhnbjyHgJws6
         MorjJPYycNvjnrIwgM5IU2v0/VseEODNgRzEAWUWuP+RJTYDqlGQItsUpDQTtD3LRwbu
         vEngw7USBNs6ksWR1vwQ4vjx8fve5xYeGbdrzQxcymmIvJzcYh8E1prWYHDMeRMlA7ek
         VPKw==
X-Forwarded-Encrypted: i=1; AJvYcCX3cYKY8KGibYprUUsKEVF9XvkxUugIJcTNHWAGJRGDAnHSwKctnTd7IermYculo7f3/u5atW/sBSAOjsFDFP45S1hSlR43nJBWg3/R
X-Gm-Message-State: AOJu0Yz38CNiVWuQ/BTtLMv6m3P3gmQcOc7592dKjfRMSKlWJC8mOeq7
	VZ1g++uQgfviYlENoT3SecL7rSTgreGvC2XgEHV48cE3jhyvIHuHMH0jTojcFx9XqL4vrfkJSYT
	TmsKAKuIS9pq6h/42fp4UffFTSjl4p/Uk61A4vWNd4fnHCjlqyHt5nLE=
X-Google-Smtp-Source: AGHT+IGmh8GUrcfNd9P4PJNsnOpWrRuzEdCySgfMDkRVKMBnetTsvdx4DVoBEuWzusjxpM/QJjEPz0RZgPZRkv9MyDM=
X-Received: by 2002:a2e:a7c8:0:b0:2eb:e505:ebd6 with SMTP id
 38308e7fff4ca-2ebe505ee6bmr41847781fa.0.1718044201601; Mon, 10 Jun 2024
 11:30:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610143037.812955-1-usamaarif642@gmail.com>
 <CAJD7tkYdTvfO8P+aZNmr7bF7vEetxiqQQ4ML8BcLdmKohT-+Cg@mail.gmail.com> <ed4cff58-93ff-4658-bade-13a3e66cba4b@gmail.com>
In-Reply-To: <ed4cff58-93ff-4658-bade-13a3e66cba4b@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 10 Jun 2024 11:29:25 -0700
Message-ID: <CAJD7tkZvEi1hOM+Qh-D5aFa0pQcnxMkQLn5OpR1ohAH0HA4v2g@mail.gmail.com>
Subject: Re: [PATCH] mm: Do not start/end writeback for pages stored in zswap
To: Usama Arif <usamaarif642@gmail.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 11:11=E2=80=AFAM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
> On 10/06/2024 18:31, Yosry Ahmed wrote:
> > On Mon, Jun 10, 2024 at 7:31=E2=80=AFAM Usama Arif <usamaarif642@gmail.=
com> wrote:
> >> start/end writeback combination incorrectly increments NR_WRITTEN
> >> counter, eventhough the pages aren't written to disk. Pages successful=
ly
> >> stored in zswap should just unlock folio and return from writepage.
> >>
> >> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> >> ---
> >>   mm/page_io.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/mm/page_io.c b/mm/page_io.c
> >> index a360857cf75d..501784d79977 100644
> >> --- a/mm/page_io.c
> >> +++ b/mm/page_io.c
> >> @@ -196,9 +196,7 @@ int swap_writepage(struct page *page, struct write=
back_control *wbc)
> >>                  return ret;
> >>          }
> >>          if (zswap_store(folio)) {
> >> -               folio_start_writeback(folio);
> >>                  folio_unlock(folio);
> >> -               folio_end_writeback(folio);
> > Removing these calls will have several effects, I am not really sure it=
's safe.
> >
> > 1. As you note in the commit log, NR_WRITTEN stats (and apparently
> > others) will no longer be updated. While this may make sense, it's a
> > user-visible change. I am not sure if anyone relies on this.
>
> Thanks for the review.
>
> This patch would correct NR_WRITTEN stat, so I think its a good thing?
> But yeah as you said for people relying on that stat, suddenly this
> number would be lowered if they pick up a kernel with this patch, not
> sure how such changes would be dealt with in the kernel.
>
> > 2. folio_end_writeback() calls folio_rotate_reclaimable() after
> > writeback completes to put a folio that has been marked with
> > PG_reclaim at the tail of the LRU, to be reclaimed first next time. Do
> > we get this call through other paths now?
>
> We could add
>
> if (folio_test_reclaim(folio)) {
>          folio_clear_reclaim(folio);
>          folio_rotate_reclaimable(folio);
>      }
>
> to if zswap_store is successful to fix this?
>
> > 3. If I remember correctly, there was some sort of state machine where
> > folios go from dirty to writeback to clean. I am not sure what happens
> > if we take the writeback phase out of the equation.
> >
> > Overall, the change seems like it will special case the folios written
> > to zswap vs. to disk further, and we may end up missing important
> > things (like folio_rotate_reclaimable()). I would like to see a much
> > stronger argument for why it is safe and justified tbh :)
> >
> The patch came about from zero page swap optimization series
> (https://lore.kernel.org/all/ZmcITDhdBzUGEHuY@casper.infradead.org/),
> where Matthew pointed out that NR_WRITTEN would be wrong with the way I
> was doing it.
>
> Overall, I thought it would be good to have consistency with how
> zeropages and zswap pages would be dealt with, and have a more correct
> NR_WRITTEN stat.
>
> In the next revision of the zero page patch, I will just add
> folio_rotate_reclaimable after folio_unlock if folio is zero filled.

I would wait until others weigh in here.

I am not sure we can just change the stat handling from under the
users, even if it is the right thing to do :/

I also think we need more analysis before we decide it's safe to
remove the writeback calls otherwise. I noticed
folio_rotate_reclaimable() on a quick look, but there may be other
problems. I am not very familiar with the dirty -> writeback -> clean
state machine.

What's the benefit of this patch beyond making the code (and stats)
make more sense semantically? It feels like a significant risk with
little reward to me.

