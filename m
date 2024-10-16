Return-Path: <linux-kernel+bounces-367269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E549A005C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E051C2280B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C82189906;
	Wed, 16 Oct 2024 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsCYLc8r"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4A21E3BA
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 04:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729054565; cv=none; b=FZ0QESSSIXFXLKFvcLcYp0F58fnVBcTg2+Uvdms+cHnevySHaScgc8S1BfBoopvahiW1GNQMdR3i0GRxqUvV226+n71ExZdvXwUZ9YqLhzzisszLq/4KTkfyjMWpoS2RldP/nQvatBJ9YMHFeu+IzB5e4cvaAbVe+evqAuMOUho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729054565; c=relaxed/simple;
	bh=AUMzU7Efyp1APsBKCm3NngSObkuSLuWxnc0K82Q09Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kobm31Dtp9k5a8d4lwn/3OeMFFrDGKb6PJ6jAeHSBtgnEDbiwABozDcecoe7JULomXc51F6x/SyRamKwkVyjXmpL7Dsz3+iYCcaXZ/DsYj2yT1mJ+ID920zSDh6XR+IYlJEvVMilsXvaMLkOCq1tMNIZuPeeqXiz6MEqpoa+vm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsCYLc8r; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a47cdaf158so1121210137.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729054562; x=1729659362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsSA0Jh+tBY3flF9iO9sgAWGwBYIu1+LghALUo3LUJ0=;
        b=HsCYLc8rBzFvdNbhl+zhb4cHPHZyDeso9u/xHQp9YiduDYnlfoTfnKPUGFC0rw+0sH
         1cdDXIgSoMsVkpg02zw1eZHAhKbgyKbRJWfYWAyNP5f2XXIfJcKjJR9BgmhrsursBBpt
         NNq++Z8a9j34r6kGkBgT15eWorhreeO6laED0PGIMOlDyKYaP4xUh/GtrauB5nxngXRt
         liAv7X/8AwKc/+XUVGIBpEOj4paQRSjtOeIAM1Toe01Ael8cvu+VRf2vIplkWHCYDfRL
         wwnGEzJoIG4vPgnX0rxUdZRNXupSOytGs4m3/30JPAHx4sJHXokrSu1vEyj1+fFkDn3D
         EwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729054562; x=1729659362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsSA0Jh+tBY3flF9iO9sgAWGwBYIu1+LghALUo3LUJ0=;
        b=fIDPOw/je1d/FxQavP+WNVihn4hdKH0tfjGNJYN9Itho7eEvjaFYKde4/ds12FHfjK
         AD+P3EoM9kFb3DzPXBbTLcCtfsW+ktm0fgCZ4XTp7bA0LZnu953zO5t8+hYNe1jdICrv
         3aUu0TMx4twxZ5EVEqVTxjHs4Q/eetJQU86ej6Qug2D++4mNgJz2qVqHNMjWRHFNf/2C
         1NtlfzoxdJKlQ6OJJIF9pnSrr7qLNF9FoOFQOOAuNItgUuGkv0pAMjr282EqEc0jYZHj
         MVs9SqiK5Vp2V6HUp+dXYg6IQs6LeX682aWfIsoumOkCuME1d/fVyxUIlmKw4VduQgjF
         YJWw==
X-Forwarded-Encrypted: i=1; AJvYcCW6kI53uIAeX4U5BL3KcQKvxkjZNKXxkwaMRA6hFXvsaJJq29k1uwne1LpeT/i1BuygMrjFWVBE4XF8uRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKHk2I6xd5gqxqInbMJmjlecrtsrhGEdNBWB7N+7xSyZgDEa+c
	8PNY77s3KQPtzXIdVSOEUjlIIMGnVq7WtGysSDCz9sumBhtTQWuaMaqbIIRk1fsnPXNkJXwFvOe
	wGsN+3QiNy+6QLM1obmbblOjCWAhv7+tiSdQ8
X-Google-Smtp-Source: AGHT+IFyzal6eYYu43TFxwjEGK1mcMNHndK2EfcE3+NjBZLwlfi/97EorJRMMm806cCeydg53YO0Dfdpj2CY7d3y9zA=
X-Received: by 2002:a05:6102:6c6:b0:492:a93d:7cab with SMTP id
 ada2fe7eead31-4a475f12a2cmr10158787137.1.1729054562299; Tue, 15 Oct 2024
 21:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014221231.832959-1-weixugc@google.com>
In-Reply-To: <20241014221231.832959-1-weixugc@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 15 Oct 2024 22:55:23 -0600
Message-ID: <CAOUHufb2nJ4-qEWrS_d0X_8FbLKR-+=OC3yNh1ExthKXiYYKHQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/mglru: reset page lru tier bits when activating
To: Wei Xu <weixugc@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Jan Alexander Steffens <heftig@archlinux.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suleiman Souhlal <suleiman@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 4:12=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
>
> folio_activate() calls lru_gen_add_folio() to move the folio to the
> youngest generation.  But unlike folio_update_gen()/folio_inc_gen(),
> lru_gen_add_folio() doesn't reset the folio lru tier bits
> (LRU_REFS_MASK | LRU_REFS_FLAGS).  Fix this inconsistency in
> lru_gen_add_folio() when activating a folio.
>
> Fixes: 018ee47f1489 ("mm: multi-gen LRU: exploit locality in rmap")
> Signed-off-by: Wei Xu <weixugc@google.com>
> ---
>  include/linux/mm_inline.h | 5 ++++-
>  include/linux/mmzone.h    | 2 ++
>  mm/vmscan.c               | 2 --
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6f801c7b36e2..87580e8363ef 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -222,6 +222,7 @@ static inline bool lru_gen_add_folio(struct lruvec *l=
ruvec, struct folio *folio,
>  {
>         unsigned long seq;
>         unsigned long flags;
> +       unsigned long mask;
>         int gen =3D folio_lru_gen(folio);
>         int type =3D folio_is_file_lru(folio);
>         int zone =3D folio_zonenum(folio);
> @@ -257,7 +258,9 @@ static inline bool lru_gen_add_folio(struct lruvec *l=
ruvec, struct folio *folio,
>         gen =3D lru_gen_from_seq(seq);
>         flags =3D (gen + 1UL) << LRU_GEN_PGOFF;
>         /* see the comment on MIN_NR_GENS about PG_active */
> -       set_mask_bits(&folio->flags, LRU_GEN_MASK | BIT(PG_active), flags=
);
> +       mask =3D LRU_GEN_MASK | BIT(PG_active);
> +       mask |=3D folio_test_active(folio) ? (LRU_REFS_MASK | LRU_REFS_FL=
AGS) : 0;

We shouldn't clear PG_workingset here because it can affect PSI
accounting, if the activation is due to workingset refault.

Also, nit:
  mask =3D LRU_GEN_MASK;
  if (folio_test_active(folio))
    mask |=3D LRU_REFS_MASK | BIT(PG_active) | BIT(PG_referenced);

> +       set_mask_bits(&folio->flags, mask, flags);
>
>         lru_gen_update_size(lruvec, folio, -1, gen);
>         /* for folio_rotate_reclaimable() */
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 17506e4a2835..96dea31fb211 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -403,6 +403,8 @@ enum {
>         NR_LRU_GEN_CAPS
>  };
>
> +#define LRU_REFS_FLAGS         (BIT(PG_referenced) | BIT(PG_workingset))
> +
>  #define MIN_LRU_BATCH          BITS_PER_LONG
>  #define MAX_LRU_BATCH          (MIN_LRU_BATCH * 64)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 9d1e1c4e383d..907262ebaef8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2601,8 +2601,6 @@ static bool should_clear_pmd_young(void)
>   *                          shorthand helpers
>   ***********************************************************************=
*******/
>
> -#define LRU_REFS_FLAGS (BIT(PG_referenced) | BIT(PG_workingset))
> -
>  #define DEFINE_MAX_SEQ(lruvec)                                         \
>         unsigned long max_seq =3D READ_ONCE((lruvec)->lrugen.max_seq)
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>
>

