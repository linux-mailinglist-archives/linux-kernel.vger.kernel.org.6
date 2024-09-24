Return-Path: <linux-kernel+bounces-337449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89531984A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9461C22A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 17:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A41AC42D;
	Tue, 24 Sep 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkLlmlDY"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D91AC422
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727198722; cv=none; b=LuLZl09QQyJVX7Fp4IMsVJFBxEhNjsdFYMcF5fnZDBO1yyS9Wk0XJJ9Mh5K0NRJcMC1Oz1jyWfc6TrQ6i78UXOCuAAZZym+AeHVJpGi55frsW+t5Buu2zMF9ARldrf4ZTO+u/HtfW0qFi2bZipuyiEtVWTG7qN7Vn/te0bdo2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727198722; c=relaxed/simple;
	bh=B0FsnnMCR3hFM5PFZYDQR7o5cSwaE6ha6bdY9xA3n4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Om/iZHdoBS/WOqqUEVCLGpPVsTwm1Si/yZahd+iNNm7Isx0ErHrsgcSoCBckLkRIB9BwakQx1awsPZvzPaNXU5u7njACibn8xDBJaQMGBNLBhD3ewg7b3zgvr/ldhf+/UrlVI+gU8MrcNH0mDXGttzpQF37+PD9ZZu37qRzh+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkLlmlDY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6c3551ce5c9so918276d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 10:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727198719; x=1727803519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8A+G+yD79v8nsi7qfP72GsLdnaN9OlB3PgC0/4siGUw=;
        b=KkLlmlDY00QVFvjYcBePsm9yyILDIduS3X1F1gOcwzGNtQn8+ronJWIB7gNGljTLdr
         Sus6/hmR+H6Srp7SphaqolKJUiS9+elYxxXmtiN4KFLB19iI2fWMQ47p1qoDVjZ37trC
         RG7Scl1488rJXqrL+a8cOW4PETtrBqZITvlbV8QBdX6BqOUk2VhldHjGc2XgzOfebA3I
         eV+jZop6/Mjp83G7dPEnSeIvP2yEVcgbc9YNJqSkg3Yy8+DO95aIj4L6R5jgYY8SkdH8
         v7Tpu2Xy02s1n0yM1BfYp+WixHYPpAJAH2Ol5JKNDrZSDDJbdKW9AXn5PM66hgf/sn3h
         qTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727198719; x=1727803519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A+G+yD79v8nsi7qfP72GsLdnaN9OlB3PgC0/4siGUw=;
        b=JzLNyzNiBMOkz4h/Bwt0lk75T86dhhpXpNbGCxCelUBn8AUlJJyhUGDNhYVGr/pkry
         nQmfzXuAWRmfYKeDU9XPd8TGC2cFojDkMY+kKTnNekEI6HwIjHcS1aCgII+kFySjGuBz
         qe5fgaGXTnHv1aPaSibu7Ag1iBqCqGlkiBnNrY0ey7mjNjRI7SRL08eKMZs3965H1Ydf
         522ZCPnR0CaqZmnh1AGigJuF1GsRxHpE3T86hxhoQuua6OIe3FZus1f2tbVXCEyhyfA2
         kSaJzLUP+oYp1t4AL6qWtdBN9LJqRM6bnBcNG38SB4RepSBpM8G7wzI5U9NT2iabsAKm
         RCKQ==
X-Gm-Message-State: AOJu0Ywkdsjod6Y12C4f/M2xmXxb5JpH3myBtPtPoHUzip96A5cBA8z9
	ViU+1aw6TvVpSxCjgnnvRjvICosalOs2HLO6vzJ7A5rZu3ia1d8+gVBGuV3CoU00EYCSifaYmPE
	MlLN+cSmiLqi7K+1LA6yf7Umrdr8=
X-Google-Smtp-Source: AGHT+IH69iGjuU6hz1mmyK9vQnX9dj7R7WIHP9vCiovvkIzF7Vrb4zuyWzd2mctBPKsoMxK/LkeHian/LBZq8OEqNwQ=
X-Received: by 2002:a05:6214:3983:b0:6c5:1f00:502f with SMTP id
 6a1803df08f44-6ca98b1245amr55744316d6.2.1727198719478; Tue, 24 Sep 2024
 10:25:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 24 Sep 2024 10:25:08 -0700
Message-ID: <CAKEwX=PM0xFj0VDOndarDk2n-PxWuQdyAdjdmVoGBk+RrN2wcw@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	21cnbao@gmail.com, akpm@linux-foundation.org, nanhai.zou@intel.com, 
	wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:17=E2=80=AFPM Kanchana P Sridhar
<kanchana.p.sridhar@intel.com> wrote:
>
> Added a new procedure zswap_delete_stored_offsets() that can be
> called to delete stored offsets in a folio in case zswap_store()
> fails or zswap is disabled.
>
> Refactored the code in zswap_store() that handles these cases,
> to call zswap_delete_stored_offsets().
>
> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> ---
>  mm/zswap.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fd35a81b6e36..9bea948d653e 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1435,8 +1435,37 @@ static bool zswap_store_entry(struct xarray *tree,
>         return true;
>  }
>
> +/*
> + * If the zswap store fails or zswap is disabled, we must invalidate the
> + * possibly stale entries which were previously stored at the offsets
> + * corresponding to each page of the folio. Otherwise, writeback could
> + * overwrite the new data in the swapfile.
> + *
> + * This is called after the store of an offset in a large folio has fail=
ed.

"store of a subpage" rather than "stored of an offset"?


> + * All zswap entries in the folio must be deleted. This helps make sure
> + * that a swapped-out mTHP is either entirely stored in zswap, or entire=
ly
> + * not stored in zswap.
> + *
> + * This is also called if zswap_store() is invoked, but zswap is not ena=
bled.
> + * All offsets for the folio are deleted from zswap in this case.
> + */
> +static void zswap_delete_stored_offsets(struct xarray *tree,
> +                                       pgoff_t offset,
> +                                       long nr_pages)
> +{
> +       struct zswap_entry *entry;
> +       long i;
> +
> +       for (i =3D 0; i < nr_pages; ++i) {
> +               entry =3D xa_erase(tree, offset + i);
> +               if (entry)
> +                       zswap_entry_free(entry);
> +       }
> +}
> +

