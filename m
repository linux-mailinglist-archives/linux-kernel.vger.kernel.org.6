Return-Path: <linux-kernel+bounces-210179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564A90407B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BAAA1C23838
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C638839AEB;
	Tue, 11 Jun 2024 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZCcpyX5"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF7C3BBEB;
	Tue, 11 Jun 2024 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121076; cv=none; b=cqsQWx71L+C4XXrbsRMZaVqtZBr0v98BVPWqYxaxgDEi1z7CCzDpVVkHLvKM2kTmvWURedfhnWemTJZb0Xvr8EsBStSEvxOJq59bLmZY1ulCMgztoMi6HjygnSig9gRqVuPObdKaGYR63dUCsS83lffMkPY19gcoGLGUuEv/syo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121076; c=relaxed/simple;
	bh=pgGuDE+XrbAgHUHE3XCxL9tGB/eU0RinDylZrRbr6yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGd6aVSYGQtjHlUw3ePVkgX83+KnttMxoskBIPH9VZgsms3fJu7ZKPuIvpS3QhZ1meH2xg8Z+FpjMC9e2hkBSMTjcDsgmCdfls3CM+M/1kSAuaEvjQ7ZAs1TNHCS4Q8W1u3uARieiZR24HbqXzohVkL04FqUVurWWktXT1fy5lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZCcpyX5; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-df771959b5bso5817931276.1;
        Tue, 11 Jun 2024 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718121073; x=1718725873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgGuDE+XrbAgHUHE3XCxL9tGB/eU0RinDylZrRbr6yM=;
        b=nZCcpyX5G6f0IdSUW3uLZ9up63jEtgCHUCMWkgHtuEpmkC1EKk6RpMW5PKkZcDcCrv
         WqrhOFOVaCJ5TD+RHHnanoAmDBTmT4PIghwLiwxtWdkYhVspSWI6FQ/YblZykoOnaYoa
         uuyikdSOQTILpZmeRG2YPcBIQH7no1ppRZqcyUB7q0q0GlO7RYW5MpOYwarQgtaf4s7f
         vHYeN8UACp5EibbcrGDOQmVrQHkAEiN9CRWG2yYRZvfyZP/n3GsFH6MgQT4rrMPcp1FC
         riC/AQwbpsvjMHqYWs5Pg8uKhI62dwDC5nI1gkO+GkQw4JDYsTAp46zv3NmKrL2D2oWg
         fbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121073; x=1718725873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgGuDE+XrbAgHUHE3XCxL9tGB/eU0RinDylZrRbr6yM=;
        b=szgT7Giugph8OtF1IGcFg+1MVWKTTuchTA4R/lAEJB8hi/CmPqIdeNX30EUPSJKhFT
         CiLGiQYKV+UxUxq4sLlix1ci6vdPzvmtkCswXur6ddyQlka9tEE03jIpKZp5B/UcSt4O
         62K6hyDgCS0HyYzszixchbcCps57QhYA+Co6QBhXeX/uSj0DR5q++Bm3ddITYLlrmAIx
         QZdGo7IeZlaQJzRG6yhAmrUz9wSnaBmPbgKfW+wod/6LbS7LS867cFzFTjAZVQbsMr+P
         gQD1Jn7+GRaptdjHg7T3lZD+CeaYBm4hjkyCMaFpM15FJzXWJld8nUVcK/+5s+jmejfV
         DUEA==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8WtLJxfxuvqXfsgA+YuWoaGbA8nJrw5fhmt7lcPaIiNt6P9Akm+kwG/LX0jmImoOZWa2ddlGMxo5caBeW69onHzH4BfCDDhn5Y/wjQC39Jb4sYHDDa92GUfROPXE2+z6saZftpCf
X-Gm-Message-State: AOJu0YyT9tfsdvvuvpDe21pfFMg1EOO2Wy3yl8eQl7pPoaQ2+FAC4pkh
	YAvfFWW/qDYhYm6pTxbI25/7yak3xk/d1IdpcgkrRjglJsYXaOJI/1CDRYH07/VThmgvAlIjbkA
	6NX61JAkDkYds1/hjpHkm6DTs/jfZ+okV
X-Google-Smtp-Source: AGHT+IHNNEtnsE4csjfuwepPpDKNjhB/oWwbjvYHlUleiX67QfVK6AwXQmjdNC8kRnlAGwWx3GMQw0USiyj3gZlMLaI=
X-Received: by 2002:a25:ef45:0:b0:df7:695a:1cee with SMTP id
 3f1490d57ef6-dfaf66d1473mr12865314276.50.1718121073472; Tue, 11 Jun 2024
 08:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608155316.451600-1-flintglass@gmail.com> <20240608155316.451600-3-flintglass@gmail.com>
 <CAJD7tkZAkzUfbXY3C0QOGqCyjQZeiuGzkZac4hmogOoh=yoZsw@mail.gmail.com> <CAPpoddf0ysCG=s5ixbOZkXjmcB0t_eqLOs9xhdqZHiWnYY4_Wg@mail.gmail.com>
In-Reply-To: <CAPpoddf0ysCG=s5ixbOZkXjmcB0t_eqLOs9xhdqZHiWnYY4_Wg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 08:51:02 -0700
Message-ID: <CAKEwX=NSaRAjiKjGtYxPwh9ByBZ_DK+h3T6LS5-eNpxS4s4zPA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm: zswap: fix global shrinker error handling logic
To: Takero Funaki <flintglass@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 8:21=E2=80=AFAM Takero Funaki <flintglass@gmail.com=
> wrote:
>
>
> Since shrink_worker evicts only one page per tree walk when there is
> only one memcg using zswap, I believe this is the intended behavior.

I don't think this is the intended behavior :) It's a holdover from
the old zswap reclaiming behaviors.

1. In the past, we used to shrink one object per shrink worker call.
This is crazy.

2. We then move the LRU from the allocator level to zswap level, and
shrink one object at a time until the pool can accept new pages (i.e
under the acceptance threshold).

3. When we separate the LRU to per-(memcg, node), we keep the
shrink-one-at-a-time part, but do it round-robin style on each of the
(memcg, node) combination.

It's time to optimize this. 4th time's the charm!

> Even if we choose to break the loop more aggressively, it would only
> be postponing the problem because pool_limit_hit will trigger the
> worker again.
>
> I agree the existing approach is inefficient. It might be better to
> change the 1 page in a round-robin strategy.

We can play with a bigger batch.

1. Most straightforward idea is to just use a bigger constant (32? 64? 128?=
)

2. We can try to shrink until accept for each memcg, hoping that the
round robin selection maintains fairness in the long run - but this
can be a bad idea in the short run for the memcg selected. At the very
least, this should try to respect the protected area for each lruvec.
This might still come into conflict with the zswap shrinker though
(since the protection is best-effort).

3. Proportional reclaim - a variant of what we're doing in
get_scan_count() for page reclaim?

scan =3D lruvec_size - lruvec_size * protection / (cgroup_size + 1);

protection is derived from memory.min or memory.low of the cgroup, and
cgroup_size is the memory usage of the cgroup. lruvec_size maybe we
can substitute with the number of (reclaimable/unprotected?) zswap
objects in the (node, memcg) lru?

