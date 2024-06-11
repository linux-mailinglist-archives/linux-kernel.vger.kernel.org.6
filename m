Return-Path: <linux-kernel+bounces-210634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F0C904680
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5EAB22060
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 21:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A018421364;
	Tue, 11 Jun 2024 21:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GKNFWLZ"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CB914B084
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142958; cv=none; b=cweaudNw9dK0A0z36lKdUM02lsHmoplckxhgYhl0y8CBTsxZ/nvcwQ8C6wvXik0UGHVeWYPDlO0Wfgv0TwXDPjDSYM6dZieWS1mfFyZd3q7pbhp9qFjkKvxVu9ZpntQAYedYUiQDZjcuuRn0nCtbgTbiUdGsqOhw4Uz9fBbU+G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142958; c=relaxed/simple;
	bh=T2UMJBgk19IVKYkD7w2cfkEKe2aqOfrZ1oJbyd4e32o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jcY1V8aIFnL4oDCqKzKf2BPNOpzTRLVq8hqovm52KWYjdpWMx5mZUuhD4k1ON8Tk90EgdKE/vfzuLv0bmrKvLL8GqUGS2iPqqhE9zwLTNzBgnMoD9JUGSm7CBd7++9gAipl89IQsryP27T0CiDzgP2zox+afjbgb6mWLFH7rPtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GKNFWLZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-421a1b834acso23197335e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 14:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718142955; x=1718747755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHE2HEn7bMqjvPWWqbM1V+OZB4MK2AKdneIbj/3ajoo=;
        b=0GKNFWLZmvCn+IragVcCnJN9AGVW0+KPQdTjy+1d0Lv8JerymgCYzbZ5Ctj/2V29TN
         QPF3CH2RRjURAnUtpBD9TWb9RDS7hto24LgLMT3fPQRPKQqSH9iE56qkvVVCN1bhznHA
         /P+jy99uGlN+iDyHdu/V/IueBHh7F5VaQqXjuZ8qVBBg5rrKDsRK7xR2h1UBekc9ppnk
         bWkE1poq0uDh7lErV3YzfkxPOqXWQNV4rKZydVBhOHTi0xLDhZBxfZtmLQ8AUFZCej6d
         Tvh+Kq7Ec/zcojkJkXbWcw1FooeRpcnVvF9c0JMwI5C4pBn6RGUXVOFYw6WwMxz6XpxO
         owYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718142955; x=1718747755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHE2HEn7bMqjvPWWqbM1V+OZB4MK2AKdneIbj/3ajoo=;
        b=OUbBtc8U/Lb2CNG6tyz1Rh8a4V50dT5f7PA3Q9+gsIBYI/tMv8qa65dDBZRGk7u37e
         d2BHdGh/qrwoYaNkbV0P0x5ymi1qX8IwH0u/yIPAyPxv/wdEKHk4s21e9NGZHzUTV55G
         dp2oSKA1G6c6S3a0tD84MArR/U4Ixv8Gu4tA36WkED2pZHLH/uiou34fSbo8Aoutiq1W
         57CW9QwzWP0dTy8Hx06+CRGv1lWYBkz0hpGLbc6bD/lcW9ytVP1AFrtfYyRDeMXD3UUc
         6f7fvmuj1aPmEzx7aks+Y7A8MFsjiC0FrYxBnVZYoFc06qZyJRITjixvyc5QMPVgFbu8
         M0pA==
X-Forwarded-Encrypted: i=1; AJvYcCXv2QAZOUifwV0j7PgGVeSXNtlWViXLA1A2RLvrq6CR71Tk+nQGHmt0TUUELn2Tpv8ZmYP8np9eVlDqTtulEgmizFa2A3jQjSCkmkBZ
X-Gm-Message-State: AOJu0YxOpYuzWRltLquGYJV0GHxFg+TCoGVySkinQtIc2KMDQBQzeiYB
	3meZZZSDy9rg1n/j7BmL5IjXo2sjNEEXT1k4GukKAVlIS8xy0u20QWlYLJPMCqyNfw+8bpXXd7P
	Ci1LsdotOfOG1p7x7FzmgJiThzIw1WWP5Iszt
X-Google-Smtp-Source: AGHT+IGIrydlGc0K+Ep9qLJ8qDncMWvnTsrHZ/48CbLuX3T5Y1FAItPXpJspsFytA6AxeYFOELh1ax65BRU687SUAyk=
X-Received: by 2002:a05:600c:3b87:b0:422:1163:44aa with SMTP id
 5b1f17b1804b1-422862a7368mr2407895e9.4.1718142955333; Tue, 11 Jun 2024
 14:55:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
 <20240611024516.1375191-2-yosryahmed@google.com> <CAGsJ_4w3LDE1OuDiX_LAeTxEGUFPVOwqMxoOF+Dr55bdLUZQ7w@mail.gmail.com>
In-Reply-To: <CAGsJ_4w3LDE1OuDiX_LAeTxEGUFPVOwqMxoOF+Dr55bdLUZQ7w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 14:55:17 -0700
Message-ID: <CAJD7tkY6h1RkbYHbaQcTuVXOsY-t=arytf5HtcKfx7A75x06bg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] mm: zswap: add zswap_never_enabled()
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 2:53=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Tue, Jun 11, 2024 at 2:45=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > Add zswap_never_enabled() to skip the xarray lookup in zswap_load() if
> > zswap was never enabled on the system. It is implemented using static
> > branches for efficiency, as enabling zswap should be a rare event. This
> > could shave some cycles off zswap_load() when CONFIG_ZSWAP is used but
> > zswap is never enabled.
> >
> > However, the real motivation behind this patch is two-fold:
> > - Incoming large folio swapin work will need to fallback to order-0
> >   folios if zswap was ever enabled, because any part of the folio could
> >   be in zswap, until proper handling of large folios with zswap is
> >   added.
> >
> > - A warning and recovery attempt will be added in a following change in
> >   case the above was not done incorrectly. Zswap will fail the read if
> >   the folio is large and it was ever enabled.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >  mm/zswap.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index a8c8dd8cfe6f5..7fcd751e847d6 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -83,6 +83,7 @@ static bool zswap_pool_reached_full;
> >  static int zswap_setup(void);
> >
> >  /* Enable/disable zswap */
> > +static DEFINE_STATIC_KEY_MAYBE(CONFIG_ZSWAP_DEFAULT_ON, zswap_ever_ena=
bled);
> >  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
> >  static int zswap_enabled_param_set(const char *,
> >                                    const struct kernel_param *);
> > @@ -136,6 +137,11 @@ bool zswap_is_enabled(void)
> >         return zswap_enabled;
> >  }
> >
> > +static bool zswap_never_enabled(void)
> > +{
> > +       return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap_eve=
r_enabled);
> > +}
>
> Will we "extern" this one so that mm-core can use it to fallback
> to small folios?
> or you prefer this to be done within the coming swapin series?

My intention was to keep it static for now, and expose it in the
header when needed (in the swapin series). If others think it's better
to do this now to avoid the churn I am happy to do it as well.

