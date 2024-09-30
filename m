Return-Path: <linux-kernel+bounces-344921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E042298AFBC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993E71F23F82
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D73188904;
	Mon, 30 Sep 2024 22:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jXErXsit"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED017BB38
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727734649; cv=none; b=WeS9y4+7AMFUFVJkAFsTxyNQWb4lAFZ0sRPLpFYSfXhRlfDba3gZDoygXqQ6WWNDAhdl2vfVnu7HmTMFUN5h0GztKPocJ+4H/AsSilGUNmk3sL6ukRiFVI0nQsMV/8UH2wuTQhmKOd7yGzwnP0sqTfzNoBR77rYrIiiwx+3QVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727734649; c=relaxed/simple;
	bh=KGM2q5GKDYFvOjCjjkpZEUEiN4zut5pdMRBzXfQq6fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7BCXNv7s9sxUlKmjU164ke7Tcf9TQXGb+WkvvTwft8pcyUg2FeJA5hZ+08RF48i9niayoenCmrz9NDvc0jRa/BZsL/rHPUXyCsSfhMeJy6UHAM02OPTLbCngsXfGB6I7BIDRMSst4Y9UcAlYFCuZosn8gMdJ1eWWQ5VbOdKZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jXErXsit; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5399041167cso2828621e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727734645; x=1728339445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJGdws3Y+9tFEbg9OaIrhdneoAXQ+o0Ro9Aou8mtgpQ=;
        b=jXErXsitoB6JrXxu5t4qEY4PyC6rM7Zk/C69rSVITG6RnArNmbUkY2utBqP8q8o0yI
         3tinwBfq4am/EH1cCRi5KU3Vsz9aRiZG0EvInCACDiG0rZHYRglh9p0Q2TLHZRFuj61r
         ljZlS6geCLiZqvHkrGiNlRC54H0AqWvZc8CWh4vdmsCzUyutKNZxfteTAsBeaAbZQnZy
         2GESaF8rD86dwStuAsZI4F9SgAeQymeA0KO2LwUtG8+yL+q03XfVKN5aFXoEcXHzBKT5
         Om48A96hyDk0b3wqJn0UTHiSrmwNT1TlcCXlfwW2hTPwsrkIeRI+MFDvJlJt8mhJwS9m
         TPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727734645; x=1728339445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJGdws3Y+9tFEbg9OaIrhdneoAXQ+o0Ro9Aou8mtgpQ=;
        b=QfvxYlaVJKNWrEqsRb/+bUdifrMiyYYIwXVilVTN4rD7uRI8Y2JIBRrcOAM28kgrDn
         8SzrIPELavvlD3Siznck/pSfo12yDa+zmdboTs57VBjQKxsfhj2JQhnr873v3ybR03Sn
         DXlc0jGh8MHr4KKpaZZBY34fpQt5gqkvBLpMyXPbdla8knlUG5SU2D9LP4sMqR5f16eZ
         q8yUMW7NsnOu1KYWQzBzLOUkpQb60bHCcJsAyXbSm3ziUzzhLL9Q4U2aRaQgOS+jC9Zq
         SiSL4tPssxSohQyeRGBFaVPHDiyWa49mK611vrpABNJHMx42pt0PZ6wnjd7PXn40Tmde
         nIkA==
X-Gm-Message-State: AOJu0Yzx4ic21N/E7VET91YVo/WC2zVDRRJa5D12gkB6NCx0a83BSi7y
	TrnyzA4aiGNQcEOT+yaQhWPsjllBaHbf0EsGdHev7XGuVTRpgRZKZDczZUOiuKkABNCHkNcmEs+
	w1uSEc5Pq5EizzSXd6iOubzcvyweF5V1jsOfm
X-Google-Smtp-Source: AGHT+IEtqu/1t7+Hz8N8Rv2Nyxm5B7PZu26wi5aZv6kRMZuDbf3TAyoJC2dBD6Z6O5RquJR/2sG4qk6iSBELnMY+VtM=
X-Received: by 2002:a05:6512:220a:b0:539:9155:e8c1 with SMTP id
 2adb3069b0e04-5399155ebcbmr4361786e87.8.1727734645164; Mon, 30 Sep 2024
 15:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com> <20240930221221.6981-3-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240930221221.6981-3-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 30 Sep 2024 15:16:48 -0700
Message-ID: <CAJD7tkaFZAYT97nDfxd=t5TvKd2Zq5omauJUdLrCffcwP5OQzA@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] mm: zswap: Modify zswap_compress() to accept a
 page instead of a folio.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, willy@infradead.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 3:12=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> For zswap_store() to be able to store a large folio by compressing it
> one page at a time, zswap_compress() needs to accept a page as input.
> This will allow us to iterate through each page in the folio in
> zswap_store(), compress it and store it in the zpool.
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index efad4e941e44..fd7a8c14457a 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -875,7 +875,7 @@ static int zswap_cpu_comp_dead(unsigned int cpu, stru=
ct hlist_node *node)
>         return 0;
>  }
>
> -static bool zswap_compress(struct folio *folio, struct zswap_entry *entr=
y)
> +static bool zswap_compress(struct page *page, struct zswap_entry *entry)
>  {
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct scatterlist input, output;
> @@ -893,7 +893,7 @@ static bool zswap_compress(struct folio *folio, struc=
t zswap_entry *entry)
>
>         dst =3D acomp_ctx->buffer;
>         sg_init_table(&input, 1);
> -       sg_set_folio(&input, folio, PAGE_SIZE, 0);
> +       sg_set_page(&input, page, PAGE_SIZE, 0);
>
>         /*
>          * We need PAGE_SIZE * 2 here since there maybe over-compression =
case,
> @@ -1456,7 +1456,7 @@ bool zswap_store(struct folio *folio)
>                 mem_cgroup_put(memcg);
>         }
>
> -       if (!zswap_compress(folio, entry))
> +       if (!zswap_compress(&folio->page, entry))
>                 goto put_pool;
>
>         entry->swpentry =3D swp;
> --
> 2.27.0
>

