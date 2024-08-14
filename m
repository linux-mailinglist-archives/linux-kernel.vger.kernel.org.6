Return-Path: <linux-kernel+bounces-286054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 638BA9515E6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 09:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC03B27E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 07:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183E913C906;
	Wed, 14 Aug 2024 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtZ4pwug"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C01311AC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723622013; cv=none; b=eWC8BdHnszUb9DJLl2qxKplBHr5T4Sa90xPFIyGerBziQ2MUFhE0ic/raJ4lVwO7c1LvstLXpGplQAFk4sXrY244X/UD/V40IOTChVa37mzRmU8UYSik1BaSfGgypCRAX9GrYCqy0Mtmtdl3cDwyT2s6AxE/+LRwnYLQ8zNgMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723622013; c=relaxed/simple;
	bh=82z1k8xSu4idd3seG2qx5owXK5dgpMj/66A/uDaTfCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjKnxuebX7c21N55Kl1Vx2zT5r9urg7u3FQIDlr0II3tXGWCwVyY5fCRSSHlyK4F60vpZvsKGkyPwkc7BHj0tzTPllIEnELEWFpUGKiUV1uK1QlTm+fTencYHq3bm0kWSuM0HYhMXwlaBxt8QO76Uiyr1MIzz1kZrBiAKlvvujQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtZ4pwug; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4f2c8e99c0fso2196123e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 00:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723622011; x=1724226811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWPmnyLQbNmcYguFPVD4++tm9j3qt13xY2mjBkRs+NQ=;
        b=NtZ4pwugUkt56AhTNammRRxsdcPgbZOmX36d0KgCEk4ZxGWCdsRiEBZhlM7vHZjryZ
         Lvw/5li7NGx1DA8RFl5YUzIIDtGYe8ZbLImZ8SaK4oPg4+F8FAInI59+KvxQyhJUYwzX
         GF5SBPOtL98/ex5CEoqh0jFP4A287+PSiiwd0mOquGI3HXCjnqTq8mWMdIEuVzHwig4I
         iv7KVybjGiK2WcQ72qZ9RH+VlfbTcq9LKOG4SKt+cpuP6k3KHYFL25TvSBoqf2exzfsV
         PNw+ckItkEF1i0eau/m72gdR7KKym/I8QsTELNOERPJEZ7FbI6YcWfpVWYkWTGOB+moQ
         HOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723622011; x=1724226811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWPmnyLQbNmcYguFPVD4++tm9j3qt13xY2mjBkRs+NQ=;
        b=b/SjcFFv44Kymm1zw59j15EuC1TQSv5SfwE1tNqnbLnPTvBIPvoMeGA0GbkUAE7iGR
         8D5t3JcaUUNH/s0rhuh+mG7nADq8hUNvZ1kRZkTQQ4yubHF1xYreGyydd6hdyIU6eeYa
         eNgXlhhhqy4N/tQfs62s8+nnZ7x27QOCoUVsKKASYC2+EFshr5zvkS4HPIlsyYIeQI//
         QbIhLy4AYScoWfAhMiTRM12rUe0++cOjLuLfgCH8fVT1F8AkPsDYqdA+e1jGqtTXSyM8
         xJOlx/xQfaFEUCaDACpJRywdomCCrQPEobkQepAyET+LzYq/Sbww1D/uk5Hau6hJOScw
         ASLw==
X-Gm-Message-State: AOJu0YzPDulTFHZbitVRB/cz63IQpxo50UwttUFZ+5K92oKQLHwsqexV
	oj5cmH4jSePg6wNMSwSh//Fx0gRtw7Cd8vZsDC0h8nqWZDNS/GQ5Q7sZDz4Ctb+ZTB00lhsTKJ7
	uXrCYVDSVst0lOYCxPPZ61vhDpzs=
X-Google-Smtp-Source: AGHT+IHUcw9mHBUfzjYt1BFLmaj9axsllWLkFoBBFMlfq2rgfBtEKDHO4QjdeJwEVjSOOAPXHyz/T96Ffymb+gbkkfA=
X-Received: by 2002:a05:6122:3b04:b0:4f5:1ea3:736f with SMTP id
 71dfb90a1353d-4fad234cbc0mr2376312e0c.13.1723622010677; Wed, 14 Aug 2024
 00:53:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814062830.26833-1-kanchana.p.sridhar@intel.com> <20240814062830.26833-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240814062830.26833-5-kanchana.p.sridhar@intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 14 Aug 2024 19:53:19 +1200
Message-ID: <CAGsJ_4yng2ES6C8OSA2qoW5AwQ+zNdEAYWcNpoXmOP+m84qprg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/4] mm: page_io: Count successful mTHP zswap
 stores in vmstat.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, nphamcs@gmail.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:28=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added count_zswap_thp_swpout_vm_event() that will increment the
> appropriate mTHP/PMD vmstat event counters if zswap_store succeeds for
> a large folio:
>
> zswap_store mTHP order [0, HPAGE_PMD_ORDER-1] will increment these
> vmstat event counters:
>
>   ZSWPOUT_4KB_FOLIO
>   mTHP_ZSWPOUT_8kB
>   mTHP_ZSWPOUT_16kB
>   mTHP_ZSWPOUT_32kB
>   mTHP_ZSWPOUT_64kB
>   mTHP_ZSWPOUT_128kB
>   mTHP_ZSWPOUT_256kB
>   mTHP_ZSWPOUT_512kB
>   mTHP_ZSWPOUT_1024kB
>
> zswap_store of a PMD-size THP, i.e., mTHP order HPAGE_PMD_ORDER, will
> increment both these vmstat event counters:
>
>   ZSWPOUT_PMD_THP_FOLIO
>   mTHP_ZSWPOUT_2048kB
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/page_io.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 0a150c240bf4..ab54d2060cc4 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -172,6 +172,49 @@ int generic_swapfile_activate(struct swap_info_struc=
t *sis,
>         goto out;
>  }
>
> +/*
> + * Count vmstats for ZSWAP store of large folios (mTHP and PMD-size THP)=
.
> + */
> +static inline void count_zswap_thp_swpout_vm_event(struct folio *folio)
> +{
> +       if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && folio_test_pmd_map=
pable(folio)) {
> +               count_vm_event(ZSWPOUT_PMD_THP_FOLIO);
> +               count_vm_event(mTHP_ZSWPOUT_2048kB);
> +       } else if (folio_order(folio) =3D=3D 0) {
> +               count_vm_event(ZSWPOUT_4KB_FOLIO);
> +       } else if (IS_ENABLED(CONFIG_THP_SWAP)) {
> +               switch (folio_order(folio)) {
> +               case 1:
> +                       count_vm_event(mTHP_ZSWPOUT_8kB);
> +                       break;
> +               case 2:
> +                       count_vm_event(mTHP_ZSWPOUT_16kB);
> +                       break;
> +               case 3:
> +                       count_vm_event(mTHP_ZSWPOUT_32kB);
> +                       break;
> +               case 4:
> +                       count_vm_event(mTHP_ZSWPOUT_64kB);
> +                       break;
> +               case 5:
> +                       count_vm_event(mTHP_ZSWPOUT_128kB);
> +                       break;
> +               case 6:
> +                       count_vm_event(mTHP_ZSWPOUT_256kB);
> +                       break;
> +               case 7:
> +                       count_vm_event(mTHP_ZSWPOUT_512kB);
> +                       break;
> +               case 8:
> +                       count_vm_event(mTHP_ZSWPOUT_1024kB);
> +                       break;
> +               case 9:
> +                       count_vm_event(mTHP_ZSWPOUT_2048kB);
> +                       break;
> +               }

The number of orders is PMD_ORDER, also ilog2(MAX_PTRS_PER_PTE) .
PMD_ORDER isn't necessarily 9. It seems we need some general way
to handle this and avoid so many duplicated case 1, case 2.... case 9.

> +       }
> +}
> +
>  /*
>   * We may have stale swap cache pages in memory: notice
>   * them here and get rid of the unnecessary final write.
> @@ -196,6 +239,7 @@ int swap_writepage(struct page *page, struct writebac=
k_control *wbc)
>                 return ret;
>         }
>         if (zswap_store(folio)) {
> +               count_zswap_thp_swpout_vm_event(folio);
>                 folio_start_writeback(folio);
>                 folio_unlock(folio);
>                 folio_end_writeback(folio);
> --
> 2.27.0
>

Thanks
Barry

