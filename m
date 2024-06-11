Return-Path: <linux-kernel+bounces-210705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368EF9047B5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EECC2850F0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90319155CB1;
	Tue, 11 Jun 2024 23:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iQjnoYWs"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EFD4594C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149077; cv=none; b=HeE8FwmnQuX7FdLyz9SE5twQx2c563HhYaqgJXIaaXI458o3oCdjuDKDUslLG5uwnZNC0fCTnmDv3V4SC4GDAWA6SaGFmg6in3t22VspMG32YDnxCFauuDGk3VvMRWebuLgCTs7LhEdpXF5G+Qlx/OHZiqyfiiYuQLxFO76tWj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149077; c=relaxed/simple;
	bh=ts2SaC5zUzYU0lD3VSl8DQyHFo7EOQkQzr0Fz/W6ogQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ihg7VOTBCRQVkdDzmW7Jo+U7HDZ/ra9lg6zYs7uWqfUraM9Hyxj+N7dubaEnACuGgzN2bjmcRW0O2C62fjqS7yK8UEhdZ/n8FHiNHXfJt6V5KnEZNUesBnL6NVbLiuwuN9jP/GtGRQa/45zCVlCGzu/jH5GqntYwuTuyyhc5rP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iQjnoYWs; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62d054b1ceeso54301167b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718149075; x=1718753875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wFURrLEu8yru5FCu/H1+vtARd6FDi8T2rnq3Ao2LjWE=;
        b=iQjnoYWsTbiRtql1jsvHTocCQQdZdiyDux9hjbQMCDyEAAnvwgra/2NYBsBA/K4/B+
         sVtfwvlelEy2/SXbnDTOg15fxVq8D37cfgm8wvBKZqwW1zu3dsTI00H4Bfn0YeRVrscm
         TicJasWHPjtBKFsWRdpG0oKcG+TdvE18GJNf+CAcE1N2+rTIIL6FarD7IDO0MkgIES7O
         yi4n51kw1Cs5AMALXxLRrCQ5AFToqv0LmgEiKGuweeO4rut9K6mFyUOTZcO4C2+rYXDm
         eEcqsnwOlvlAfw1Ls/PC+8jZUuKI8/QwqaSwtCeDI9V0mnIrkchxGhqZAUe4S30gfnfa
         h71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718149075; x=1718753875;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wFURrLEu8yru5FCu/H1+vtARd6FDi8T2rnq3Ao2LjWE=;
        b=NGr2FUOyYj10iJ3AwnFf3Nu8LRl7xFqlwNuCkDn6H/Dsssmi+LNCcoDDB7tlv2XWif
         VRfI0aPKehihhACQyHI0O7tarGlyMXyzcQWeaD8MXPKv7ry+zfUqSxxIF0fE0s2relaP
         0PS0slNY8WeZWgftKo9m4mYrJi5bftmH/dcQTxhq3A8I2kG7bIsWkfoK2aZWjCS2iTMI
         7lt5t3pHPpJo114tQGbWQTfXotR1TyS7N00TJstxYaZtNGP9Cto8dJXXWhrhfreB1nXC
         +ENxcUZBSaL/GM04mpj7jnzyaX1rFUTWIt+7VksiyvGCMppSqDo8lWZNl8pvKwO4puSP
         FoEg==
X-Forwarded-Encrypted: i=1; AJvYcCXyrzjsF26gDdMN6praILC1WNas83r/RNwsCLLh9AAhF2gJ2cATyndAYCXhjD9GxNV4rWkKamSdNW6/++Y0iNbQy8lyUgMiub2Kf9w+
X-Gm-Message-State: AOJu0Yy6ahhNG8n2MzgLLy/h55Q1nsSVo9wyUTqoKk3fJtZ6osWFGGxd
	yiq5hRhCIQasEoEaDWyMBsjr05Hhp/MZBSgjIbQ8JQI2PI/gNxccWvuhtcsrBcGTwjhFzCIZvrc
	c2AmJhgGccht4JVUMhQ==
X-Google-Smtp-Source: AGHT+IFTAoZnT4eXyEEesCaHsE31DKaQg2+GUzj1w/L2OSqhBitgxDfMEMrBoLNLHf/s7pg80CybVr1XyhqKyqQu
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:3810:b0:61b:ec22:8666 with
 SMTP id 00721157ae682-62fb6c1f4damr829967b3.0.1718149075136; Tue, 11 Jun 2024
 16:37:55 -0700 (PDT)
Date: Tue, 11 Jun 2024 23:37:52 +0000
In-Reply-To: <CAGsJ_4xAHR-fMP6c8w6Xf5cVF2OJYwChiGn5Y66qvM_qiEnEDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
 <20240611024516.1375191-2-yosryahmed@google.com> <CAGsJ_4w3LDE1OuDiX_LAeTxEGUFPVOwqMxoOF+Dr55bdLUZQ7w@mail.gmail.com>
 <CAJD7tkY6h1RkbYHbaQcTuVXOsY-t=arytf5HtcKfx7A75x06bg@mail.gmail.com> <CAGsJ_4xAHR-fMP6c8w6Xf5cVF2OJYwChiGn5Y66qvM_qiEnEDQ@mail.gmail.com>
Message-ID: <Zmjf0Dr8s9xSW41X@google.com>
Subject: Re: [PATCH v3 2/3] mm: zswap: add zswap_never_enabled()
From: Yosry Ahmed <yosryahmed@google.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 10:19:58AM +1200, Barry Song wrote:
> On Wed, Jun 12, 2024 at 9:55=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Tue, Jun 11, 2024 at 2:53=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> > >
> > > On Tue, Jun 11, 2024 at 2:45=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > Add zswap_never_enabled() to skip the xarray lookup in zswap_load()=
 if
> > > > zswap was never enabled on the system. It is implemented using stat=
ic
> > > > branches for efficiency, as enabling zswap should be a rare event. =
This
> > > > could shave some cycles off zswap_load() when CONFIG_ZSWAP is used =
but
> > > > zswap is never enabled.
> > > >
> > > > However, the real motivation behind this patch is two-fold:
> > > > - Incoming large folio swapin work will need to fallback to order-0
> > > >   folios if zswap was ever enabled, because any part of the folio c=
ould
> > > >   be in zswap, until proper handling of large folios with zswap is
> > > >   added.
> > > >
> > > > - A warning and recovery attempt will be added in a following chang=
e in
> > > >   case the above was not done incorrectly. Zswap will fail the read=
 if
> > > >   the folio is large and it was ever enabled.
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > ---
> > > >  mm/zswap.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index a8c8dd8cfe6f5..7fcd751e847d6 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -83,6 +83,7 @@ static bool zswap_pool_reached_full;
> > > >  static int zswap_setup(void);
> > > >
> > > >  /* Enable/disable zswap */
> > > > +static DEFINE_STATIC_KEY_MAYBE(CONFIG_ZSWAP_DEFAULT_ON, zswap_ever=
_enabled);
> > > >  static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
> > > >  static int zswap_enabled_param_set(const char *,
> > > >                                    const struct kernel_param *);
> > > > @@ -136,6 +137,11 @@ bool zswap_is_enabled(void)
> > > >         return zswap_enabled;
> > > >  }
> > > >
> > > > +static bool zswap_never_enabled(void)
> > > > +{
> > > > +       return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap=
_ever_enabled);
> > > > +}
> > >
> > > Will we "extern" this one so that mm-core can use it to fallback
> > > to small folios?
> > > or you prefer this to be done within the coming swapin series?
> >
> > My intention was to keep it static for now, and expose it in the
> > header when needed (in the swapin series). If others think it's better
> > to do this now to avoid the churn I am happy to do it as well.
>=20
> Personally, I'd vote for exposing it now to avoid one more patch which mi=
ght
> come shortly. And this patchset serves the clear purpose of drawing atten=
tion
> from mm-core to fallback to small folios.

Sure. Andrew, unless anyone objects, could you please squash the
following diff and add the following sentence to the commit log:

"Expose zswap_never_enabled() in the header for the swapin work to use
it later."

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index ce5e7bfe8f1ec..bf83ae5e285d4 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -36,6 +36,7 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg=
);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool zswap_is_enabled(void);
+bool zswap_never_enabled(void);
 #else
=20
 struct zswap_lruvec_state {};
@@ -65,6 +66,11 @@ static inline bool zswap_is_enabled(void)
 	return false;
 }
=20
+static inline bool zswap_never_enabled(void)
+{
+	return false;
+}
+
 #endif
=20
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index 505f4b9812891..a546c01602aaf 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -137,7 +137,7 @@ bool zswap_is_enabled(void)
 	return zswap_enabled;
 }
=20
-static bool zswap_never_enabled(void)
+bool zswap_never_enabled(void)
 {
 	return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap_ever_enabled)=
;
 }

>=20
> Thanks
> Barry

