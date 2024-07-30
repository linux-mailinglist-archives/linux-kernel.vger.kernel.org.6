Return-Path: <linux-kernel+bounces-266837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C7940852
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE8F1F200E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 06:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3719D18D4B2;
	Tue, 30 Jul 2024 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZC/eD78"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6516A921
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320595; cv=none; b=Z65xZbPGvVIh+YKDNHdMKrL5iQLfN1L7lFUtytoPezRXTIe8Ngbp6iSiwLtc+S1Wmpw86NCDO9In+LQFYFhjhLq0Y3rIyXWW6yMWBwwXIPAlAmoWjj3W9Vu4g7MJW4S9Dp/tjiXIyQYCho41e5bj+P1WtK1qO/Woj+ZLB4vaxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320595; c=relaxed/simple;
	bh=Fn1XpXCE3F2UiQm6K2YQyMZaD6wcHBWyJavcktEFMnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyW5QiKXmNui892V1WN9ftgPeZbKzthF1QcgByZVjtT7OGIoxmTvpPICf0LkdtK6QezJWoBwWCjuj4uj+5R8g3tDINtrUCWpAzEJLFB8bp6B7aRK2th6Tvy+59F4vu6B3Voeo1nr86ZFcqBXpRo233EDzu7zZV1nTAFqvZ1haJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZC/eD78; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b7a0ef0e75so23936276d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722320593; x=1722925393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fn1XpXCE3F2UiQm6K2YQyMZaD6wcHBWyJavcktEFMnw=;
        b=eZC/eD78FtDXqcge/3ZnVsjowM+Evepa7gK3TumZMZ95MUgbsIs5obzc2gn4rBq+EK
         fRahuvbWMtPXUXKBOa6Ruf7+YuuPzMEqvP7R/DKsJW1V6JERXE+qf0M93WPSWvxs3HHS
         sNEIJyitPk1HrN24GUhqX842g5xZiXdai+nJ1vFyJKQ+eqpdCdKok64fbt5AX82fZK/V
         JlWWUPNOy6GbMkt1SeeD76klhwyosgfSMWgItjkj5HqjKYYZKZNONQHLTczd+GQOYAyJ
         hdhhceToxHz9ZG9bLtafmel0hr9Xp9MSve1ToDBP9vaXjcvCxDHCHwDyK45duWHQuzMe
         HICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722320593; x=1722925393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fn1XpXCE3F2UiQm6K2YQyMZaD6wcHBWyJavcktEFMnw=;
        b=v9e76NWqESt0Jk+5lZyavaY+UOXxNXYTFByOK6L+fmeIHBDdq5GK7l0JPHsEi9+p9e
         un8/Bj9jC0tV9SdcIsQ+CLdp8xq1eWTsMrmztO55eK/NVdveuPmmHwPzsty3aUyzOwdG
         Y/my16+sWUzOjt1gasjI79k4vXSAQPuOae/JM/jD25uKrO0Hf9v7VVwJhbX72QyQgjUV
         A+QIYvULzREkMpWLKT+B0ZaJXV0JklnxU8CVu5ytRTSCK530UbRXC7vjAvt8Itci/U+v
         6pZ5A9O/45nXTgLT3zt8VdkXFEKQerBdCWx6ocFh47wt4Ikc0T9s2p0+Md/SJDtzo5V/
         imaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlvyUR2d2ZrL7LVO4Fs3+auxw0Zqy5zeiim2vUnldb268AqLRhkNR3IlyiNYMOA6nltHbaGyMchBKdIAcsX54ep5RPShqTyQe2jggn
X-Gm-Message-State: AOJu0YxHp2FqekTgg2NSJNA6OxJbrPe45eQ022wzPB/KAcDTQNrHOKnY
	kUSYU5Ei7aVBjI6YkuPQC4286PsEhqfYRa0qcbobMo4vFGGTRyhRXvUQhnsxefolxhh08aw9NsA
	Rd6ac7sKZYXTUNkXeYAnH2VSoPfyY5ZRcSqA=
X-Google-Smtp-Source: AGHT+IG/RqYM7kt+KRNXWWffNels/XWJSltBqDKYgCfhE8HLCM9PZI9detPGXhrcKY6JSoBDOwE4NjCeFSonvB3ozGA=
X-Received: by 2002:ad4:5ba4:0:b0:6b5:4865:948c with SMTP id
 6a1803df08f44-6bb55a41ce9mr123582076d6.27.1722320592677; Mon, 29 Jul 2024
 23:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725232813.2260665-1-nphamcs@gmail.com> <20240725232813.2260665-2-nphamcs@gmail.com>
 <CAJD7tkY4Jt_OXDEsUN9jzQkrF4mEeLA0BxyNKppSK8k9xL-xKw@mail.gmail.com> <20240730033929.GB2866591@cmpxchg.org>
In-Reply-To: <20240730033929.GB2866591@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 29 Jul 2024 23:23:01 -0700
Message-ID: <CAKEwX=NsuNBijq9LEau9tM6e1r4qTbDLSfsF-f8bAcKFFx28mw@mail.gmail.com>
Subject: Re: [PATCH 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, flintglass@gmail.com, 
	Chengming Zhou <chengming.zhou@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:39=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Seek is a fixed coefficient for the scan rate.
>
> We want to slow writeback when recent zswapouts dominate the zswap
> pool (expanding or thrashing), and speed it up when recent entries
> make up a small share of the pool (stagnating).
>
> This is what the second chance accomplishes.

Wow, this is something that I did not even consider. Thanks for
pointing this out, Johannes.

shrinker->seeks tuning allows you to adjust writeback pacing, as a
ratio of the pool size. When the pool is static (no/few zswpin or
zswpout), then these two are similar (on average). But with concurrent
activities (pages coming in and out), the dynamics can potentially be
different.

Second chance allows you to have different dynamics depending on
recent pool activities. The recent zswpouts will be protected by
virtue of the reference bits (and given another chance, which will be
taken if it's used again soon), and the pages concurrently zswapped in
obviously will be too, whereas the stale objects who have already been
touched by the shrinker once in the past will be evicted immediately.
IOW, all of the above activities (zswpin, zswpout, reclaim pressure)
can harmonize seamlessly to adjust the effective rate of writeback.

Without any additional heuristics (old or new), increasing seek (i.e
decreasing the writeback rate) by itself only has a static effect, and
definitely does not accomplish the aformentioned dynamic writeback
rate adjustment. Now, we can (and did try to) mimic the above behavior
somewhat with the protection size scheme: only return the unprotected
size, carefully increase it on zswpout and swpin (so that zswpouts are
not considered), carefully prevent shrinker from reclaiming into
protected area, etc.. But it's incredibly brittle - with all these
hacks, it becomes even more complicated and unintuitive than the
second chance algorithm. If it's performing well, then sure, but it's
not. Might as well do the simpler thing? :)

Besides, the problem with the haphazard aging (i.e protection
decaying) remains - at which point do we decay, and how much do we
decay? Compare this with the new second chance scheme, which gives you
a natural aging mechanism, and can elegantly adjust itself with
reclaim/memory pressure.

