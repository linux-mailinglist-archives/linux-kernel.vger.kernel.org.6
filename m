Return-Path: <linux-kernel+bounces-263498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6493D6EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C3B5283B89
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7312E3F2;
	Fri, 26 Jul 2024 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pLqNP9oO"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F29445
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722011478; cv=none; b=gPTDVPYMdX0XIWuF69fcUq/LhQAley7un71k5c6LK3+ItdZHdBd24S+He7w9u987nd28CcemGwCca0d6f7uKr4c5ejDlSzV+moY72hEv8puzQUXsb0wy/b73iAY8Yn7Ft3s5b/3d71IwbyHkXUYcAyrl3TGD0iNVFLnB9Df9fBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722011478; c=relaxed/simple;
	bh=8ZKGO7h/q2wOxpepELIwwmgWBjk5g+tuIIRCa1+iiJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5LRC4HgQmqdnMuhe6nLYjEAlIe3hYXx+ivX360qxh2/WKpXQPw+1mayH+7XDWoWjKGKe2K20OYW5cEm6EEavTYlobdjlE4gTeFvoqEsgTjvuvTT7Q4oLib54q/NI/7DdHMT1K3cBWz8TNaZLbVfHhgiYF7y1UmX1C0K1O5xXQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pLqNP9oO; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a8553db90so238398966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 09:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722011475; x=1722616275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuq4nuc6eH8XAV4Br/RwCNhXFpkg4GgzfdIGIN52r90=;
        b=pLqNP9oOJ5fyARNbw9x4zookFOtSL9kP/9LpI+X4fShypz09xZWDvOjiOoDjYb3r7n
         zjPRMzTPIg9jTyJGe4cKhWsKtEGHZYT5ZopUAxBjDQAeCTDKpKeK2DVI6urs90Tf+Iw3
         MXY3+QJ5h1wIkP9KZdinxWs9eyfmQ9ZACnNkhDcTlka9i1wk0vjCE0Doh/fW7hr+bV5u
         AsxraU/++qS9aC05m5x6fbYU4LVJuP4lb7EM94rTt86yPUb8zykhkdOD85E+SId3qEIP
         sOcbPrfCFrH5znFSuePRKDnq4f9iGCHakLZxBFa4nahG5OgNzg/Cmcb37a/SExP2GfWK
         kegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722011475; x=1722616275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vuq4nuc6eH8XAV4Br/RwCNhXFpkg4GgzfdIGIN52r90=;
        b=TzMkNvOmBZ1oYf1u+BKEg/4cs8QiKh3Ixs3hgzoUyogCswXk6hqnQCSTHQTSM17/dz
         GkokO4MJhVeZhzqJede7kVBkFqhZql/HJjvGezQTADdUe4BQ4E+mI3q1m6bFFBRjM6/v
         kqPkUaFxWTuSLLJkbPqNnxMMqOE/+3MHYW8uCe+i3lwX+EvvJ7wVP95u6tqsZmGsXHQF
         Z2KB9NVuRImTyyAzW0a9c72cmMpJBFF94vD65PTfnM8Tl4T8qR4f75CS35Qjvu5QYS4e
         tVfiU15vlfuuJe0xSRtcbzmGd69z/5KqwXHbgu4ZnQJnms1UpEaURz6sQPJrFOuP1u4u
         Z5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhGzwJLXrmZrfDAZ+g4k0fKPmuAHPDSJjFRhutNqYHhpWEsB/Mtxaae9H1yDIzfqPJymUByIvDZpzZKMnrKoFHgDiuLeO2UZcXjbK6
X-Gm-Message-State: AOJu0Yw8TwawX3XaUrfspoNE9XkKg+XbTMIUwXxC2fGDFRBCkSbFIrxk
	+yoPlRd1SRwkeCToHp1ivim1SEx1c458h2AQ1NgaC5lUydduA3cNvD0fcO37V6O47oV03g8iSPa
	KxmCI90zLjf/ru0wDSuZVC4N7AV9zpyTr7Ugc
X-Google-Smtp-Source: AGHT+IEvl52VvZgC94HfxhzNdwQSObujtyit0xKlqftROtM76O8gCSf5kKjxUKwzqZD2swB8DN5QUsX6y7vLAu7xY7U=
X-Received: by 2002:a17:907:9443:b0:a7a:b620:aa2f with SMTP id
 a640c23a62f3a-a7d3ff9e068mr2925366b.15.1722011474096; Fri, 26 Jul 2024
 09:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-3-21cnbao@gmail.com>
In-Reply-To: <20240726094618.401593-3-21cnbao@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 26 Jul 2024 09:30:38 -0700
Message-ID: <CAJD7tkbho1a6pwZq82aHBa8BpXijqVopde3k-RnageOtdO32pw@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm: Introduce mem_cgroup_swapin_uncharge_swap_nr()
 helper for large folios swap-in
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, hughd@google.com, kaleshsingh@google.com, 
	kasong@tencent.com, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2024 at 2:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> With large folios swap-in, we might need to uncharge multiple entries
> all together, it is better to introduce a helper for that.
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/linux/memcontrol.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1b79760af685..55958cbce61b 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -684,6 +684,14 @@ int mem_cgroup_swapin_charge_folio(struct folio *fol=
io, struct mm_struct *mm,
>                                   gfp_t gfp, swp_entry_t entry);
>  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
>
> +static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry,=
 int nr)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr; i++, entry.val++)
> +               mem_cgroup_swapin_uncharge_swap(entry);

mem_cgroup_swapin_uncharge_swap() calls mem_cgroup_uncharge_swap()
which already takes in nr_pages, but we currently only pass 1. Would
it be better if we just make mem_cgroup_swapin_uncharge_swap() take in
nr_pages as well and pass it along to mem_cgroup_uncharge_swap(),
instead of calling it in a loop?

This would batch the page counter, stats updates, and refcount updates
in mem_cgroup_uncharge_swap(). You may be able to observe a bit of a
performance gain with this.

> +}
> +
>  void __mem_cgroup_uncharge(struct folio *folio);
>
>  /**
> @@ -1185,6 +1193,10 @@ static inline void mem_cgroup_swapin_uncharge_swap=
(swp_entry_t entry)
>  {
>  }
>
> +static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry,=
 int nr)
> +{
> +}
> +
>  static inline void mem_cgroup_uncharge(struct folio *folio)
>  {
>  }
> --
> 2.34.1
>

