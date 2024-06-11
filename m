Return-Path: <linux-kernel+bounces-210403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CDE904337
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B283D1C22757
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076066F2EB;
	Tue, 11 Jun 2024 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUft8noa"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44AC38F82;
	Tue, 11 Jun 2024 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129446; cv=none; b=Qo+W8Fjl2kA8sjQ5YLBXFKsrOXpFpHxa2mnNKVVx7TLz+l9npEa5sDIkcn/7kcxq2PtRXAa1NLWWnDnXriyi0Ou1o6G51+yZF0ND+1kIOWXEPcH3coWrw+8isSwoSNyM5XWIf7Ck3ON2ngy55SEUEV81WO3KRMUlzq0OHYcwQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129446; c=relaxed/simple;
	bh=/kBuMNz5xz6ybpf6jMEy9R7kpmTZY+KerEUZxX8ArSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tejGWYMbODyRY9VyNWsOz9xUB0oTzMZiGZfmsceC2GygbmYkS16B2kopuB4If9YWlJ2ZtMTKU1HhxLX/LvHteGjI9D/IjI1xi+73fU9Oc2YzTCASssUf/f3PmrnCVNNWpZMUQTLelTF93tZ9opg3oJoqQWI7h1M/xLQbJxoGo60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUft8noa; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-797f0c49a11so26139385a.0;
        Tue, 11 Jun 2024 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718129444; x=1718734244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mbopcsfn5WDDZMHTl7045YVZTo/YxkYjZ3QqPNkTqbU=;
        b=BUft8noaB/JcKOHApMPx71DBblngbPk4064qJoXT/B/85uigZW5BPQa641YeSUPK56
         cqXrMVGm0qR5o9ewn9XZsF1cnKQ7mVTiAo/GUdh5NaHW4wiNtMgICUyyeweKTfkSBznM
         /Pn3Lmrt5BT2hnYzC89cZ3JPgmBFVsdfHZoAxSE5Sxd3lVU3NMcX2e/0GSLmlkJoVoib
         /qIVTjLDo+79u8t1hUcz2MWtEWxo5J8vXDYQjP2WcgrT+LUhS4prVzOK6U4VWkJVCJI/
         qWlWyHPQAKTFORKTbqwm4sEqRfueuvDvUZHNnyWrte2tw1fI4xuORW4vPwMCXTDHicC5
         JUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129444; x=1718734244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mbopcsfn5WDDZMHTl7045YVZTo/YxkYjZ3QqPNkTqbU=;
        b=HM7XIHTkLiNSbx3XYlyvKfOyzrpaS3ux0wT4PDRwJL/NMctmdEwq/oAORmsCKW/BcK
         KoezOhr5HInWnYyoYtoNA8AgA3ItypYw5k6TFt9WXHuGzlysbf+0L28ZpkLKCww+vNRp
         WNMGiPUYzlf/azfgeg/eag8PEFuisObrVu1DdM/ozMQU5FQsOgcdy4FFcvf8wfGfW/ox
         vXBjHdUuJZK8LuecIVVS8QS/gDwRL4MSnuMfnc4drDQwYWmOqkB3MWT+8Y6jYXikXoDB
         dexSdqAHap+Hs5vgrCMnh7vnmICN9T3Dn/sYCxKQ4xFLR5eXqEVSsnoWB1Ok4FDRjoQE
         HlNA==
X-Forwarded-Encrypted: i=1; AJvYcCUw6dUaFkxrUPKMzyv5Oo1qvGYH12mxdHhVm8gs17mT6ObH8fXfOFj3jf3ZbDbikzDgJRvSJZPWurXDnurTYQD/tJNkhhK4TCU13UKFCrV4s21KKaklbc4FlaoHG7RT6/7ISl4gI5Ci
X-Gm-Message-State: AOJu0YzW9u0Z5AFxuj5KshdBsxtkSis2MPUHIWSBeJ5NlNlDpANACXYz
	Kk5c1UyW60shMrORzI0ybsZgs+b6BsFYeIjMoYREwFoyAnAvHEdWdThCPjEo0/xU65EyTkh91t9
	18UBX4iGzSwbhfg5u5SE87f02Wzo=
X-Google-Smtp-Source: AGHT+IFtxEhyO1IKcnlH0FvteEBSozy4uGTfjTxz7WgpzIPVgvq9ZeYKqdI+KxU7LzWVWP9cq7CmKh14evR3+BDswrY=
X-Received: by 2002:a05:6214:5c04:b0:6b0:9048:9801 with SMTP id
 6a1803df08f44-6b09048cedfmr17979356d6.39.1718129443649; Tue, 11 Jun 2024
 11:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com>
In-Reply-To: <20240608155316.451600-1-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 11:10:32 -0700
Message-ID: <CAKEwX=NZ3miH--HXKEv9Z32aJ=0Ft7k=8Q6y7u+X7iwr5ha+CA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mm: zswap: global shrinker fix and proactive shrink
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 8, 2024 at 8:53=E2=80=AFAM Takero Funaki <flintglass@gmail.com>=
 wrote:
>
> This series addresses two issues and introduces a minor improvement in
> zswap global shrinker:

By the way, what is your current setup?

This global shrinker loop should only be run when the global pool
limit is hit. That *never* happens to us in production, even with the
zswap shrinker disabled.

The default pool limit is 20% of memory, which is quite a lot,
especially if anonymous memory is well-compressed and/or has a lot of
zero pages (which do not count towards the limit).

>
> 1. Fix the memcg iteration logic that breaks iteration on offline memcgs.
> 2. Fix the error path that aborts on expected error codes.
> 3. Add proactive shrinking at 91% full, for 90% accept threshold.
>
> These patches need to be applied in this order to avoid potential loops
> caused by the first issue. Patch 3 can be applied independently, but the
> two issues must be resolved to ensure the shrinker can evict pages.
>
> Previously, the zswap pool could be filled with old pages that the
> shrinker failed to evict, leading to zswap rejecting new pages. With
> this series applied, the shrinker will continue to evict pages until the
> pool reaches the accept_thr_percent threshold proactively, as
> documented, and maintain the pool to keep recent pages.
>
> As a side effect of changes in the hysteresis logic, zswap will no
> longer reject pages under the max pool limit.
>
> With this series, reclaims smaller than the proative shrinking amount
> finish instantly and trigger background shrinking. Admins can check if
> new pages are buffered by zswap by monitoring the pool_limit_hit
> counter.
>
> Changes since v0:
> mm: zswap: fix global shrinker memcg iteration
> - Drop and reacquire spinlock before skipping a memcg.
> - Add some comment to clarify the locking mechanism.
> mm: zswap: proactive shrinking before pool size limit is hit
> - Remove unneeded check before scheduling work.
> - Change shrink start threshold to accept_thr_percent + 1%.
>
> Now it starts shrinking at accept_thr_percent + 1%. Previously, the
> threshold was at the midpoint of 100% to accept_threshold.
>
> If a workload needs 10% space to buffer the average reclaim amount, with
> the previous patch, it required setting the accept_thr_percent to 80%.
> For 50%, it became 0%, which is not acceptable and unclear for admins.
> We can use the accept percent as the shrink threshold directly but that
> sounds shrinker is called too frequently around the accept threshold.  I
> added 1% as a minimum gap to the shrink threshold.
>
> ----
>
> Takero Funaki (3):
>   mm: zswap: fix global shrinker memcg iteration
>   mm: zswap: fix global shrinker error handling logic
>   mm: zswap: proactive shrinking before pool size limit is hit
>
>  Documentation/admin-guide/mm/zswap.rst |  17 ++-
>  mm/zswap.c                             | 172 ++++++++++++++++++-------
>  2 files changed, 136 insertions(+), 53 deletions(-)
>
> --
> 2.43.0
>

