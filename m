Return-Path: <linux-kernel+bounces-209203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D496D902ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B0B1C22C65
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FDF16F8EC;
	Tue, 11 Jun 2024 02:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQleJxrc"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB344C64
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074769; cv=none; b=jC4u27QHdRSexnjtZQIhsGYA3AjHHh4CV+s/em1rxGrCbYJFFY5EmwkDJpJMQ1dKj0U46RCfHau0gneNRtBSyvsf7jmVevvr1WAYiBHIPxT9lFpyHsoYLBi3hccF5SBvEtysYyYv838IjXR8rFVR1jU7pVQ7Op2nNGX5AB9h5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074769; c=relaxed/simple;
	bh=cfpfbuyRG2sOUqpxNIduPAvsoh9nWjBaZKYsd+KPehk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/X9RZUGzXE1CvASabBAhHIUN0TkXs0rEVG1D01KaYi0NgBdc5at/Gk38uyJiwww6GkKGihsd//OXlNDifBPrIp/OF06GyUWr9dtjMrcbNIUzblyyq9GnhMz01GSlL1k3sOw0ZTGarRnFVtiCIvE0rJWvpWlwRt6GB4yGGR83dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQleJxrc; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80b8efd9adcso561374241.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718074766; x=1718679566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud8Y/RGuWXbBKz7MlAb9Fh+BQvy1bg4qOh9fhwLLmdc=;
        b=FQleJxrcHE8kU1cswBGkhtRHpk86XEjIrSFqn0EbGS/RVTrlZbCus3/w/N9GQxSNHz
         mWn5tmEKu09WHP8KrWMYABy2MepVOPIPHxm9SzavuzjO/H9DmmgZ8G1GmFjQx1mKGlDj
         ONV5FMLe1yFppVPgwUEkNhoVy6+hUkZ51OPkw0XwwQ6btEL3m0PHh0aL0lQ/996TwxNM
         FN53to/tLeia1VF9ZNc1Cab8HL9MpUp2Pp5qjh23ewKSkFMv8QN9941HfAITGc8Gfybo
         3I3Ai0a4rCPOi2BgyxNxUI8Cx4byVyie7LFC9W5qatbhGkOkjdB1ebKysq2Pf191Tcts
         c5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718074766; x=1718679566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ud8Y/RGuWXbBKz7MlAb9Fh+BQvy1bg4qOh9fhwLLmdc=;
        b=iVXdLT8hrbzTOBZzjx8UYZ7ZX/nXqT636jd9GNP34PZS4FA8NfxtJj4AB5C/hgmNYP
         Vso4I1jfHf9CgrUlIMS2PPcOEgNgmwefOSszjr5m/B2aFgPULsAw/pjAX0jwkmZwwuE2
         9b5uhZGGXNXypPvHXfcmb6jq2y40oZJJDYcTW1g4QSbSi5hkx/WgH5lgfl8riBF1AoA2
         w9hjfkGZ/2etMr8Y8Nb02GF/koCmiqKUFOS0n+96q0W6WFuRJnN3zbEh07OSJEKmG9c7
         3LSajXpboBBpXl9GnaqFxBi4SvyAM0srM9S8s970N6uO0YQ1qHUH2fUIdHQAzoF60U1N
         PTUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTAA+p5QR0k7B5aTuorNdhZuaK7eTQ/GTkrFBierIGoUFtEG2vmfQMQbi7Y79Ry8bi6CwFGx98SGo9UaRXbaxI4IM9d9QL++LvDzav
X-Gm-Message-State: AOJu0Yzq2FWAJrme2ZrxzFEYNGPFCuNPqjt114kdtNpERL9ZL9WrDOpy
	k/LP3l9liSYPIEm4wj+64DSC/cgxgW0z2blDWBzAh2vAq6CG6C+IUZ3psHwZctEg2tSIgcppiXd
	Q7h11y7RVSYHNJjrJKBGE4Hegjro=
X-Google-Smtp-Source: AGHT+IHGZoJCvXd6Cw27+L78MQzXQpSh7YuJ5NtX+G3yz2A+hr/v7wo/fv1uFKyWtllt8qFNormYrYjOq1oGylRcYIs=
X-Received: by 2002:a67:ebd0:0:b0:48c:47c3:7857 with SMTP id
 ada2fe7eead31-48c47c37b1bmr6194902137.29.1718074766436; Mon, 10 Jun 2024
 19:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
In-Reply-To: <20240611024516.1375191-1-yosryahmed@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Jun 2024 14:59:15 +1200
Message-ID: <CAGsJ_4x7GjeeVpcjxxxeemgA9aKC2ZzFHR9r0Ang_-W2RQ2KAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mm: zswap: rename is_zswap_enabled() to zswap_is_enabled()
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
> In preparation of introducing a similar function, rename
> is_zswap_enabled() to use zswap_* prefix like other zswap functions.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Barry Song <baohua@kernel.org>

> ---
>  include/linux/zswap.h | 4 ++--
>  mm/memcontrol.c       | 2 +-
>  mm/zswap.c            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/zswap.h b/include/linux/zswap.h
> index 2a85b941db975..ce5e7bfe8f1ec 100644
> --- a/include/linux/zswap.h
> +++ b/include/linux/zswap.h
> @@ -35,7 +35,7 @@ void zswap_swapoff(int type);
>  void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg);
>  void zswap_lruvec_state_init(struct lruvec *lruvec);
>  void zswap_folio_swapin(struct folio *folio);
> -bool is_zswap_enabled(void);
> +bool zswap_is_enabled(void);
>  #else
>
>  struct zswap_lruvec_state {};
> @@ -60,7 +60,7 @@ static inline void zswap_memcg_offline_cleanup(struct m=
em_cgroup *memcg) {}
>  static inline void zswap_lruvec_state_init(struct lruvec *lruvec) {}
>  static inline void zswap_folio_swapin(struct folio *folio) {}
>
> -static inline bool is_zswap_enabled(void)
> +static inline bool zswap_is_enabled(void)
>  {
>         return false;
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1303ed01bb5e5..a811dfff10cda 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -8469,7 +8469,7 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *o=
bjcg, size_t size)
>  bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
>  {
>         /* if zswap is disabled, do not block pages going to the swapping=
 device */
> -       return !is_zswap_enabled() || !memcg || READ_ONCE(memcg->zswap_wr=
iteback);
> +       return !zswap_is_enabled() || !memcg || READ_ONCE(memcg->zswap_wr=
iteback);
>  }
>
>  static u64 zswap_current_read(struct cgroup_subsys_state *css,
> diff --git a/mm/zswap.c b/mm/zswap.c
> index b9b35ef86d9be..a8c8dd8cfe6f5 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -131,7 +131,7 @@ static bool zswap_shrinker_enabled =3D IS_ENABLED(
>                 CONFIG_ZSWAP_SHRINKER_DEFAULT_ON);
>  module_param_named(shrinker_enabled, zswap_shrinker_enabled, bool, 0644)=
;
>
> -bool is_zswap_enabled(void)
> +bool zswap_is_enabled(void)
>  {
>         return zswap_enabled;
>  }
> --
> 2.45.2.505.gda0bf45e8d-goog
>

