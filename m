Return-Path: <linux-kernel+bounces-261584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF1C93B96A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 586E01F21F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D9B140E34;
	Wed, 24 Jul 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsOg79xO"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128813D8A8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862839; cv=none; b=ESEJT1PTZ+79SsfGFImq9aNuyN5/Dd7azSvvUZzA4kpAh9DM4kWvh6vcOkMMg7+PU4BAKoWHqXj1+PZRLSeAyZdb5ZlmeEo3lb9dj20ghNNYwRHO3kC9Wg9mN2CMnIlwla46H7VErP2vAVce0UL+jEmip7t+tzNz3jj3Wccx33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862839; c=relaxed/simple;
	bh=CfdBrWfnu9ZzB2Snlo9OApLGBDzePc6nC7s2JhSCY2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eO+QXlBTk9IvE8jkLkFB5x9JkZeBXCzVxVGuOQt2jme6mT8sFAilMnjOUiECcREbzWnOoyVWVH03BuXF9mU/bpToeDwxeZIw15BN7rEg4DOvOj04QdAKoQCn04gvjICnnidqrY6iXwBTMsZelw7q+eVku/pDo0wEzZIqeebLWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsOg79xO; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso35200166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 16:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721862835; x=1722467635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqGMsm+DN4bJglfHn2wnABQeEHoaj0YtiuVT5hiybgU=;
        b=JsOg79xOIjwXmJ79Sziqkpo8Svs65mx6IK1kZ0Aj4UsDqzEsAZVcH8hAge2jGgXGgI
         lzjGNLLJB0bzZqLrVj8QTaCtB+lO8FfS6cz06w/4YqqSCwWCmi+hHA+KyyA85jkKuwlq
         6RiEUXjEtU0Jy3Zel9y4eW1IBPYnRXOxa9/JGLPo3RM88cJaIwjdFL+nKbZ0S23NWS8S
         11Jb4B8iSe9YRzJgMEHViTo2mzUBrcqCj0IX3HiCZEkZAAiQ5R2GMLDOv0t58R1tbMu2
         yqO8xgISsanZ/wQfqD+2p3AayYyKEXwOxYuy1XT1pIxSCgCgVgUFpK1IGfafk4GB/9eS
         wDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721862835; x=1722467635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqGMsm+DN4bJglfHn2wnABQeEHoaj0YtiuVT5hiybgU=;
        b=mTuu9SsUKWfqZglAdJ5LhkAMSoOJzjqF6vSTPNreBn8/0b5T0zLCxdgsKXR2KrpKH1
         opJYYydoTSNg1NS0dPgccqqP++ou8hVw+FAeRysyehjZE/ibzJwzxINzE8r+1u+Y+Dt8
         ZfPVFXf2jb5006QOs8vR3M2uwosbaRWcnkiKZdurHr6qkCEtGHD+V8eqtPxocZTYVuCJ
         8IDdMKoogwGCea6if5A6YWmXjdFTGV8uwl9KLcsfmUUGFUgXFathYx0Ci6UThFpmI165
         zmACgSGVZ4aGZADM3TEfbwHEu1Vz6d09+p41I9iLU4cap++hBwm+oz28xSMSrZmc20xa
         GbXw==
X-Forwarded-Encrypted: i=1; AJvYcCXtmxEsRj96zh0R6/pO9Pc6r2Z5FXUHcmDJBgoBk6olWzHurbwRUUbc8C5WiM0EkyDliBID0LLizKY8B8ZdtVt2DrfC/i5bOcwfsjmQ
X-Gm-Message-State: AOJu0Yy1p+ZPJIo1SeIShIMMydKvMuiRUpeCVMydlSosA7j4dTNVH7IU
	Phbj0csBJJuQPOUfVsoFmuod4V9O4KCGiQPWtCK4FatS7R+BM094T0swrsM38e1JviWPBuCOQbc
	kB251TEMQEVnQRf7h+RmcPnNvQTSnAeoULScI
X-Google-Smtp-Source: AGHT+IHTLmFi/7sXK/A/TyOCcC2QmI6ORY6zfcii8AjERSIKyHssKh83IE3NsBtmc8E9qUtRbVWAGsvl9lbCxkutD44=
X-Received: by 2002:a17:907:971f:b0:a7a:8522:5eec with SMTP id
 a640c23a62f3a-a7ac5076647mr65335266b.53.1721862834987; Wed, 24 Jul 2024
 16:13:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724202103.1210065-1-roman.gushchin@linux.dev> <20240724202103.1210065-2-roman.gushchin@linux.dev>
In-Reply-To: <20240724202103.1210065-2-roman.gushchin@linux.dev>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 24 Jul 2024 16:13:17 -0700
Message-ID: <CAJD7tkYOgYMKp+u97wm6biA+C_2BR-B2hy6zi=cVqHovUxLTRA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm: memcg: don't call propagate_protected_usage() needlessly
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 1:21=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> Memory protection (min/low) requires a constant tracking of
> protected memory usage. propagate_protected_usage() is called
> on each page counters update and does a number of operations
> even in cases when the actual memory protection functionality
> is not supported (e.g. hugetlb cgroups or memcg swap counters).
>
> It's obviously inefficient and leads to a waste of CPU cycles.
> It can be addressed by calling propagate_protected_usage() only
> for the counters which do support memory guarantees. As of now
> it's only memcg->memory - the unified memory memcg counter.
>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/page_counter.h |  8 +++++++-
>  mm/hugetlb_cgroup.c          |  4 ++--
>  mm/memcontrol.c              | 16 ++++++++--------
>  mm/page_counter.c            | 16 +++++++++++++---
>  4 files changed, 30 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> index 860f313182e7..b31fd5b208aa 100644
> --- a/include/linux/page_counter.h
> +++ b/include/linux/page_counter.h
> @@ -32,6 +32,7 @@ struct page_counter {
>         /* Keep all the read most fields in a separete cacheline. */
>         CACHELINE_PADDING(_pad2_);
>
> +       bool protection_support;
>         unsigned long min;
>         unsigned long low;
>         unsigned long high;
> @@ -45,12 +46,17 @@ struct page_counter {
>  #define PAGE_COUNTER_MAX (LONG_MAX / PAGE_SIZE)
>  #endif
>
> +/*
> + * Protection is supported only for the first counter (with id 0).
> + */
>  static inline void page_counter_init(struct page_counter *counter,
> -                                    struct page_counter *parent)
> +                                    struct page_counter *parent,
> +                                    bool protection_support)

Would it be better to make this an internal helper (e.g.
__page_counter_init()), and add another API function that passes in
protection_support=3Dtrue, for example:

static inline void page_counter_init_protected(..)
{
       __page_counter_init(.., true);
}

This will get rid of the naked booleans at the callsites of
page_counter_init(), which are more difficult to interpret. It will
also reduce the diff as we only need to change the page_counter_init()
calls of memcg->memory.

WDYT?

>  {
>         atomic_long_set(&counter->usage, 0);
>         counter->max =3D PAGE_COUNTER_MAX;
>         counter->parent =3D parent;
> +       counter->protection_support =3D protection_support;
>  }
[..]

