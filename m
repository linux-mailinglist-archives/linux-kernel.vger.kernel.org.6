Return-Path: <linux-kernel+bounces-337536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B347E984B79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 21:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D93C283F11
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 19:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81496126BE2;
	Tue, 24 Sep 2024 19:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vn9y52IL"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226563BBEF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727205654; cv=none; b=JEKezj5cm0iXbYfYR/+P5EiqAs04OtXfJPufJyGZX2oF3cKcLfW7xOfET4wxRTjyeGHHvB4b0doC8ZMgw7U67rAMxY6oB/InYsNp3QWRjNwS3YQzY1vKDMP72VzM469gKXRUg/FpX8RH9sxQ/nMKo+ivbMqEET5+79y5n8rC0S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727205654; c=relaxed/simple;
	bh=badAH7y7J8wtXGUY43bzVfsIFhsCLni2w8XHht8jap8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNfigPTsHd71DYXlhS8wbetMsItOL4g8iqDjPSkEW2paPPeTxsY0m39CoT22js+0pECh6yYtmFSEcIvyHRa5oYXgptCN18CrbZIdSY+zsUUiK/h0MMyP8Z/R1Scj3iHW9SJ98LYVa402pAgSQm8TbTnnOXQnLHxcqjAH22SX0jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vn9y52IL; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so880591766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727205651; x=1727810451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raaf+7JBNIDAcmpKXOzNkGLcUnQWjLcp9/ooEg61O8o=;
        b=vn9y52ILWpMLA2h0iz99UZSZdsOp6MBlb2qL7K3rNCRgqDRlUKnHQ5BV0MwzqovSpb
         kjBzMTBUA611J6qcgB0zvMgT6+fZrNFDCtnqisJUFmjqAyJQHXjUOiEIxXWcWMyfbQ+S
         hAEW1IHzRYEF9VHmAjzFBdVHvF2LryzbjE4UCSYbQu8aDbQV90ZSsXEgKCTRr+sIWe6Z
         CIv10PE/+208PfdLfamtlE4JanUCKvWA/dIMb4znQ0iZQy2C/hokoSXEV/3leFaxOojj
         OAZijBAH+zj/UNh3YfrqwN/rfLezW6tStvDM7+ClZRMNg4x2tHSdunjzrmqfkXx3aP5F
         KayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727205651; x=1727810451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raaf+7JBNIDAcmpKXOzNkGLcUnQWjLcp9/ooEg61O8o=;
        b=wshgAtHZc914MJnHVXxp+wcKvlgYH36xOsW0d7GlhXMiFOpdscymUVmluGX0ULR27Q
         M7NouXIVEbrFWlBcdwlf7mcdyEnuEeraVrxcFZ5DHk/Epk1aiId0sMBB/Mgc3ZSfLAcH
         k1mh6rDfDChzF8rMpaUDrL+POJVPuDQ8Ef2T9rguz0KOfK7CHUU1DaPNntZ0YgmTrak7
         +kDNi8Xz97eStHce1CPycXNlo2WBCldgym3fORRU9oEsCpm3a6+Hkt9HBM3AM0Ryz0Ky
         mk1jctnXbDppifhYAAIXowpeTFitKlKe6KWMImQlCgjXr6kW21XlpDCDLcivCejm/4AQ
         x+hA==
X-Gm-Message-State: AOJu0YyT8QgicTG9yn3stqK9dpLs4Y1qEtS835pH0Z/In3o4d2cm6QEF
	6fNJ5f+DEq1EmqRaY+aQU8Qefm6tfTctGL6v+W903wTIBgJi3RCBFDJViPfxBXvbtJL5tUFUy19
	zGRFaN0Oz8rY4qTXvzsUAgFxwxsEHjlu8Y3d6
X-Google-Smtp-Source: AGHT+IF56noL0SS3BYhYZVMxxk2MUDSX7D3UGPx+TBokGaqN9I3R+t03CX4nHG3AI+F0RW/YDav/JhykUXzasJCOGGk=
X-Received: by 2002:a17:907:7287:b0:a8a:9207:c4c1 with SMTP id
 a640c23a62f3a-a93a068a306mr26560366b.58.1727205650990; Tue, 24 Sep 2024
 12:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924011709.7037-1-kanchana.p.sridhar@intel.com> <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
In-Reply-To: <20240924011709.7037-5-kanchana.p.sridhar@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 12:20:15 -0700
Message-ID: <CAJD7tkbdRPKxOoVJMg5XdQuoByE1yuOjEENuM=wDnh_cOQZ7mA@mail.gmail.com>
Subject: Re: [PATCH v7 4/8] mm: zswap: Refactor code to delete stored offsets
 in case of errors.
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, usamaarif642@gmail.com, 
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

I don't see the value in this helper. It will get called in one place
AFAICT, and it is a bit inconsistent that we have to explicitly loop
in zswap_store() to store pages, but the loop to delete pages upon
failure is hidden in the helper.

I am not against adding a trivial zswap_tree_delete() helper (or
similar) that calls xa_erase() and  zswap_entry_free() to match
zswap_tree_store() if you prefer that.

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
>  bool zswap_store(struct folio *folio)
>  {
> +       long nr_pages =3D folio_nr_pages(folio);
>         swp_entry_t swp =3D folio->swap;
>         pgoff_t offset =3D swp_offset(swp);
>         struct xarray *tree =3D swap_zswap_tree(swp);
> @@ -1541,9 +1570,7 @@ bool zswap_store(struct folio *folio)
>          * possibly stale entry which was previously stored at this offse=
t.
>          * Otherwise, writeback could overwrite the new data in the swapf=
ile.
>          */
> -       entry =3D xa_erase(tree, offset);
> -       if (entry)
> -               zswap_entry_free(entry);
> +       zswap_delete_stored_offsets(tree, offset, nr_pages);
>         return false;
>  }
>
> --
> 2.27.0
>

