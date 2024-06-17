Return-Path: <linux-kernel+bounces-217114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD8F90AAFE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1917F1F232BC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A81194132;
	Mon, 17 Jun 2024 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slhve6r2"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540B56F505
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718620005; cv=none; b=nkjD/diEkYN2+TYEj+Nyxy5aTERKojpXDDd7a3qjbFqyIH/TbbLA4ZtpDRkIrIIUfL6kMonTCsZ7jOzsr33bdW54fxOKDfi/u27Tpt2qWtUhNrifbilJQRgcBtl8u8hiru9v2adz9yRnT20RQW0B2HAvyVCagTjmhdfp/BFI2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718620005; c=relaxed/simple;
	bh=7hXGDHwLfhamJrMU1icU92e4wy3F23Sftij7zIlYQ5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngvkEFC8Ml+1QxyKkmrhuB4nRjnF3VXqXCkiK7HgNzDnscntRH7pgeYb4iJzI9zpYN2nX9XXyNmN5oybX8tz1Cze1MQlP4j1PQ1iMoSVCqPGVqrB2n1M1eoDeqzJNWyGUUAKbITrUOESif/OWQvp+xCUa41/ZmqoycsPUfIJJVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slhve6r2; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-80d68861bf9so1475123241.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718620003; x=1719224803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFoVB120xxdGUtJY/lUzDNHtyGa18ElXXxsWBBg/Yrg=;
        b=Slhve6r2PIAXJBTNGhNFeVPjOoFZDqU3PbxlJA2roqS6HNCBW70N3OWvSwb4T5WQ3D
         0UzuXfDhpVA9jdwS7xgUsrwpd+OJ0Qus61FcagekZJyiR8IMwj/S3BXxKNf+A242iw5S
         Spr7fQW74V2jHV360yoPglB/EyCRfy7U1IaBMR3/rGX4jWDNRE7DpOXLX51V9oexbEmQ
         3hkLsrOGPVY5p9bI34AaBkZGjguHR8AqhJR4dZQh2B4V5mI5mJdFX1DZm6Tl7Q4JZN2l
         psR8iiXj1De4Cb3kSAB/A84Bgj9R2kgnxTIjBS7Fza7MaDMft2EJwrAqzyFBuofNSq7C
         PDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718620003; x=1719224803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFoVB120xxdGUtJY/lUzDNHtyGa18ElXXxsWBBg/Yrg=;
        b=H4tzA3JLiacFrmUtjPSx7YMR8eKyKsyD9f6pA+B+qv4tWG+6GAaL91M1Xek/eClEZV
         D23xYWM9NFnL0AjhizX1nga+qN3zb8miShRZ+Ut0xj1YY9Ui/k5yv7m1mSLUL2H2G8tM
         ShAtAGVj8pcTf9TQP3n9K+fAvuk/i3cWBmNVlU0vTTmgi3HVazu9t4QIfFA5UpRVz4Nh
         qc94Hc4vFPsrLr6107Jkq5s8Kr12RSocb1pLeAazqDJeuxRURIFIptBCgrk+AkoEc+Pq
         Bae5CFOa1bhINGoyQQd10MVWnvRq0+qS8E5zBKNUmAHTBvdAuOb5V0Q6GKrPqXPlospJ
         oAMA==
X-Forwarded-Encrypted: i=1; AJvYcCUUbYUUFM9AUxEJaYqw2F4bHCLPa20qic1zgcjVm+tihsMi3b2gudC7B88BjuwD7WqlfwJLPGQw0O6x/3lxNF5X+kfDRlNHw/keJ3ro
X-Gm-Message-State: AOJu0YwolJ6eFEus6Gp3VJTBU/07CbWebcHEinx7esCXDYyNyBh+dQhl
	asVjU995786xqe/v94qHtrWRbIJFky41tS/Se/pqBHzJyQnG7d9Y9agSh4abKqw7GhjAB1nrOU9
	nR0TZmm8ADj0K6aFK39WPAJbdsG0=
X-Google-Smtp-Source: AGHT+IH4ZVF8+aYTJ8p8IDCCO95wJIZviSoKL/6SigeVRkIpcVRxNxBZG9nBpaxAl/YEqB5S5UdcVukr6A2/S5+1ktI=
X-Received: by 2002:a67:f9cb:0:b0:48c:30be:37f6 with SMTP id
 ada2fe7eead31-48dae3d5ad4mr9389244137.27.1718620003081; Mon, 17 Jun 2024
 03:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1717492460-19457-1-git-send-email-yangge1116@126.com>
In-Reply-To: <1717492460-19457-1-git-send-email-yangge1116@126.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 17 Jun 2024 22:26:31 +1200
Message-ID: <CAGsJ_4zvG7gwukioZnqN+GpWHbpK1rkC0Jeqo5VFVL_RLACkaw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: skip THP-sized PCP list when allocating
 non-CMA THP-sized page
To: yangge1116@126.com
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, baolin.wang@linux.alibaba.com, 
	liuzixing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 4, 2024 at 9:15=E2=80=AFPM <yangge1116@126.com> wrote:
>
> From: yangge <yangge1116@126.com>
>
> Since commit 5d0a661d808f ("mm/page_alloc: use only one PCP list for
> THP-sized allocations") no longer differentiates the migration type
> of pages in THP-sized PCP list, it's possible to get a CMA page from
> the list, in some cases, it's not acceptable, for example, allocating
> a non-CMA page with PF_MEMALLOC_PIN flag returns a CMA page.
>
> The patch forbids allocating non-CMA THP-sized page from THP-sized
> PCP list to avoid the issue above.

Could you please describe the impact on users in the commit log?
Is it possible that some CMA memory might be used by non-movable
allocation requests? If so, will CMA somehow become unable to
migrate, causing cma_alloc() to fail?

>
> Fixes: 5d0a661d808f ("mm/page_alloc: use only one PCP list for THP-sized =
allocations")
> Signed-off-by: yangge <yangge1116@126.com>
> ---
>  mm/page_alloc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e22ce5..0bdf471 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2987,10 +2987,20 @@ struct page *rmqueue(struct zone *preferred_zone,
>         WARN_ON_ONCE((gfp_flags & __GFP_NOFAIL) && (order > 1));
>
>         if (likely(pcp_allowed_order(order))) {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +               if (!IS_ENABLED(CONFIG_CMA) || alloc_flags & ALLOC_CMA ||
> +                                               order !=3D HPAGE_PMD_ORDE=
R) {
> +                       page =3D rmqueue_pcplist(preferred_zone, zone, or=
der,
> +                                               migratetype, alloc_flags)=
;
> +                       if (likely(page))
> +                               goto out;
> +               }

This seems not ideal, because non-CMA THP gets no chance to use PCP. But it
still seems better than causing the failure of CMA allocation.

Is there a possible approach to avoiding adding CMA THP into pcp from the f=
irst
beginning? Otherwise, we might need a separate PCP for CMA.

> +#else
>                 page =3D rmqueue_pcplist(preferred_zone, zone, order,
>                                        migratetype, alloc_flags);
>                 if (likely(page))
>                         goto out;
> +#endif
>         }
>
>         page =3D rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
> --
> 2.7.4

Thanks
Barry

