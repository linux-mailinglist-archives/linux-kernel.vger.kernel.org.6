Return-Path: <linux-kernel+bounces-313548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E98CA96A6EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 20:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946231F2244D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D6E1922F9;
	Tue,  3 Sep 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrHnM93V"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AC18B49C
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725389476; cv=none; b=Cu4H5LlJlIbg1XvVZWDuNxwkpQ8j7oaMew4NDz9EI/ONqRG38hcP3omO0epdstQXfa8jv9SLN+C1RMybXx0dKkXpIZcu5lkyVgbQYkgInsBN5lkIf9bMMJj/MFZhOQJoUash7A5Wl0xX5H6emMoCG83P5NrRhVzhGfRL58jTf20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725389476; c=relaxed/simple;
	bh=4h+P6yc/REOFfJt0E37lTDOQnT5Gl8Xfw0hvfozEbCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oynsui/5tXKGDrVu3NAp86Y49r3XQ4PghCEqRtqwk4/2YdfMW/pwoKBiQm+QR7UJKVUX3Aku0I3mYF+trN7AxxGhUZ2KrQ2cIuNVvhXLlAbzqVSWkNgorX4s1S63MKennePvsZZZX+glJdibsLTb5qBS1oCMXapw5H9SNb6wvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrHnM93V; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f43de7ad5eso71861441fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 11:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725389472; x=1725994272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HWBUov06ObmMzy01hCLFdm8w+seLfM6Kvtbr0Nq9fo=;
        b=IrHnM93Vv5TvKowZ565YrztOOa9ngBZwnjVs1UrT4V4lXTa2vn0VN3qesIw9ZYurjp
         OC4PljpldWajdlz7sovPOOOUogvN7QkFIpEieyFCkA0YdsqFlbh6Kjsn/pdQtLTW1Y/z
         Q7XL3Qz8jXYzE8J0t4e6fcR+Uvvpwy/cAIRh8nxfzJ1iln9UA/Fm+V02J5PkacKCQC9x
         nejaNzIRUPvRiQcjiq2ne4DRJtOVzDQCoJ2XKFrthsr9vA7ljTOh94NULAq3WKsvQP4n
         MXkRIJv1oOmaqISZb02t3+T4YGRGpdHVq2Oj4btEcd/1WuuO/LLnK9x+Z2nHnyUfUiYl
         SSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725389472; x=1725994272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HWBUov06ObmMzy01hCLFdm8w+seLfM6Kvtbr0Nq9fo=;
        b=CIj3DET+Kx/tSicFNEZIhhWNaTnDQsPHHnZUoBj43kkuUJEUAQGf/yjkwChGL79B3G
         QH3buMnyiYmYg8uAMduSTrW+FkoTerA82LKMFS1AePDv3UwgF81k9WELyoFkOLr5Qujk
         VMDDcwX+1LwBGFsOBURDpc5gv0IHCmYQxMb24/YUhX3bj3thT1iaei7bYMY+Q3IWcO9x
         oIUj85xopcyF+3BeBL2zJHchZUxCEeq+vx4Ew8kV7GeS22/O3lj58bS0B+rdboa8NHxZ
         vxwe8OqQ7Es+7qqiS19D3ensMumFxEjq0iQu3Xi/e/M5jTjlxvrJKcHVSPU3fvMYYjIo
         NhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp6IzgKLKO+ebBH6pIdWZ5cwlZ5NYyr+61k+JieZSOeVlkuXpJKZcb0rbDAFKAJ7/H921ESxiYKFMnU0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0ndUlurCiU8ONmEETazkYjH1tUuZ8oEbwBtiIbUx8cWzKTn+
	rPY5PlJgNVcivHNIwtY7C8/23S3PUL9dR9ZpQHYLeqMUHCNqXAoCDHtkB4vJ3iuweBUXMsXbLE9
	8dk9c1HJXktgWPk1W9W2urFTf0nY=
X-Google-Smtp-Source: AGHT+IHIYvnSqEsvBrn3eJeKpOQW9mnpJmyGbglDWb8nmEiSfSKQi9dy0Ikae6W7IQ6tCy7o2BWBJZD7PuX5i0kIfd0=
X-Received: by 2002:a2e:be21:0:b0:2f3:af4b:224 with SMTP id
 38308e7fff4ca-2f6265504cemr88310481fa.8.1725389472235; Tue, 03 Sep 2024
 11:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMgjq7BhpCoPMEkSkCAqWcvTO93KQK4xzn2Av6M0ATkk8YZapg@mail.gmail.com>
 <20240821054921.43468-1-21cnbao@gmail.com> <CAMgjq7Czvr+PXF7Q5eSChAdmiLH-uvd7HTred63T8JPCCYzTSQ@mail.gmail.com>
 <CAJD7tkYxAUVhvb_khBngRg5d504-KYVbW-v=GNfUPR-6_f-rVQ@mail.gmail.com> <CAJD7tkamz0RHzv3yy7833GhhhBzGB1ozRo085wB4xZjXppEBWg@mail.gmail.com>
In-Reply-To: <CAJD7tkamz0RHzv3yy7833GhhhBzGB1ozRo085wB4xZjXppEBWg@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 4 Sep 2024 02:50:55 +0800
Message-ID: <CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdmesW_59W1BWw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in zswap_swapoff
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	chrisl@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	syzbot+ce6029250d7fd4d0476d@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 2:22=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>

Hi Yosry,

> > > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > > index c1638a009113..8ff58be40544 100644
> > > > --- a/mm/swapfile.c
> > > > +++ b/mm/swapfile.c
> > > > @@ -1514,6 +1514,8 @@ static bool __swap_entries_free(struct swap_i=
nfo_struct *si,
> > > >         unlock_cluster_or_swap_info(si, ci);
> > > >
> > > >         if (!has_cache) {
> > > > +               for (i =3D 0; i < nr; i++)
> > > > +                       zswap_invalidate(swp_entry(si->type, offset=
 + i));
> > > >                 spin_lock(&si->lock);
> > > >                 swap_entry_range_free(si, entry, nr);
> > > >                 spin_unlock(&si->lock);
> > > >

This fix from Barry have been applied for mm-unstable and it's looking
good so far.

> Kairui, Barry, any thoughts on this? Any preferences on how to make
> sure zswap_invalidate() is being called in all possible swap freeing
> paths?

I have a set of patched that removed the si->lock around
swap_entry_range_free, and the slot return cache is removed too. So we
can move zswap_invalidate into it as locking or caching is no longer
an issue, I will post it ASAP.

