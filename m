Return-Path: <linux-kernel+bounces-243883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60A929C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE55728101E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB013AF2;
	Mon,  8 Jul 2024 06:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLFZVu3+"
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FD1171D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720419740; cv=none; b=aSR/3LEDOfqW/+FVJHLz2rSc/CyeoPBLrvp5lmb/DuSDfBSP5TpSxPI335XSwdyUiZ+AZzDNXhyJOykx3imVfoN71dZsEpOcYuu/Da1KVwJZuaoHenoBqEj0XX4ySmVWiNCOumbnASS5weIKx6VfHTHhRgnPkK/Hwq1SvIu51iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720419740; c=relaxed/simple;
	bh=Bd5ESUhO2iksJ0+oegKWpQOyrcXRzCq5XJiTPZCIh+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNY+YsbqpgyS1foaZJkv+6BvJeu1qzW+v3kXlNC2Fcou2UUa2tOyV+nnCPO1Q7WD8CNPWc5Z2h9IB06V+tcWZ45eqTCXcnmPwVXxgNiANhsmbfnh/Lv+fYNpJvHkvcFE8F5SwahHbM4hGp2lrvWoe1eH6xFz1Or1sSE82VBO2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLFZVu3+; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4f2fad3fb8eso1409338e0c.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720419738; x=1721024538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifbBmc00s6PDs4jKRokz1EGyBAXHA5r+QHtuV6zq9aU=;
        b=mLFZVu3+9uB7RY62NIj9Jrz9My3b3abfUH0fCw4v5BBwmpssP7Vf8S8BuORbZ1GA95
         jUWulkb3KT9olKrDssmgKP9wC4tYXlCktZpmmm/llwAUiC/W0rnaADmuU9NZv8rLjPpA
         aNdhQ/VZa0mUYIUESDSNBHWEgIrcHW83bMFGh+8rcdxuZWTOBEKgKWRT2QipecEyAUWo
         bXzxcf6NFrCHMUxxJa4ZkoXFekWokW8Rwx5WBb/7FHrWA+zgj0O2eo25V2Gjw8Fn/uge
         BhNzx7gCBBpDzD9ZBsrFFzQ/4+URpygZIQQzPUCIwTabmnNqPKszJ1k4ZOCXxMgxd/RU
         FKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720419738; x=1721024538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifbBmc00s6PDs4jKRokz1EGyBAXHA5r+QHtuV6zq9aU=;
        b=EGSq6GKDdY9Oe2T7hPkPZwWujZYpU6NCs8yUJYpXN0cs5UouyIanq8nk56FP6Yrd8M
         bKBQ5goLGdnKnsBY4QNPNG+x0Bo3v8gFlmNdzhxYCyFwJvXavlTzhCEh64VZAlLAfikW
         s3pZqM9429x/HKOMP5rMmqwGQHrcErbxL1Ni487f6nBFAapxA9h1sYKVZq4KmExJI0uE
         hRhjzXZekuYytm34kJ+9+QsmpGp09XuXOqwq0ebGRYDi5jJ/Xw2Jd/DPR/nHF1pr+T6W
         A2+fATBH+64wzhOfVjReTqp6Ij896qNM6+cUT7QLZCbWAoUe3BZSSBu8ZSoCWq5+uTt+
         ECOg==
X-Gm-Message-State: AOJu0YwoAU4+KFMfzdZJRE7hY6oTikMJrSuxtgMB84BO7/aCjChWwx1Y
	VKL/0RNlHx7EDs9Ro9elHWz08aAQVMyESGAlyxKC1Itd3A5E4p1d6fiMrm1cv0gCOFLGc5CNQYJ
	4ctArCIi4Z7pHDOzUqDiy7cpa1P1xSO+x
X-Google-Smtp-Source: AGHT+IGrJQmhgXFsCY2qekC9LVQNgQRc/rdLVgJl+vebrSbBItHIhf9jN3LXtZ+VVv8NFhqfcLjpjX0XuCGP/9CgupY=
X-Received: by 2002:a05:6122:1c0d:b0:4ef:66cf:8745 with SMTP id
 71dfb90a1353d-4f2f3f84f21mr11564421e0c.7.1720419737768; Sun, 07 Jul 2024
 23:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708061502.9006-1-21cnbao@gmail.com>
In-Reply-To: <20240708061502.9006-1-21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 8 Jul 2024 18:22:06 +1200
Message-ID: <CAGsJ_4xbnAS=rbQ=adq7X0ig8Vw9fGzW5d06e6CnP3oBwpUM3w@mail.gmail.com>
Subject: Re: [PATCH] mm: Extend 'usage' parameter so that cluster_swap_free_nr()
 can be reused
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kairui Song <kasong@tencent.com>, 
	David Hildenbrand <david@redhat.com>, Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 6:15=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Extend a usage parameter so that cluster_swap_free_nr() can be reused by
> both swapcache_clear() and swap_free().
> __swap_entry_free() is quite similar but more tricky as it requires the
> return value of __swap_entry_free_locked() which cluster_swap_free_nr()
> doesn't support.
>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Chris Li <chrisl@kernel.org>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Chuanhua Han <hanchuanhua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  mm/swapfile.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f7224bc1320c..70c4a9132672 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1352,7 +1352,8 @@ static void swap_entry_free(struct swap_info_struct=
 *p, swp_entry_t entry)
>  }
>
>  static void cluster_swap_free_nr(struct swap_info_struct *sis,
> -               unsigned long offset, int nr_pages)
> +               unsigned long offset, int nr_pages,
> +               unsigned char usage)
>  {
>         struct swap_cluster_info *ci;
>         DECLARE_BITMAP(to_free, BITS_PER_LONG) =3D { 0 };
> @@ -1363,7 +1364,7 @@ static void cluster_swap_free_nr(struct swap_info_s=
truct *sis,
>                 nr =3D min(BITS_PER_LONG, nr_pages);
>                 for (i =3D 0; i < nr; i++) {
>                         if (!__swap_entry_free_locked(sis, offset + i, 1)=
)
> -                               bitmap_set(to_free, i, 1);
> +                               bitmap_set(to_free, i, usage);

I'm terribly sorry for the mis-operation(sent the wrong patch),
I actually mean:

if (!__swap_entry_free_locked(sis, offset + i, usage))
           bitmap_set(to_free, i, 1);

>                 }
>                 if (!bitmap_empty(to_free, BITS_PER_LONG)) {
>                         unlock_cluster_or_swap_info(sis, ci);
> @@ -1396,7 +1397,7 @@ void swap_free_nr(swp_entry_t entry, int nr_pages)
>
>         while (nr_pages) {
>                 nr =3D min_t(int, nr_pages, SWAPFILE_CLUSTER - offset % S=
WAPFILE_CLUSTER);
> -               cluster_swap_free_nr(sis, offset, nr);
> +               cluster_swap_free_nr(sis, offset, nr, 1);
>                 offset +=3D nr;
>                 nr_pages -=3D nr;
>         }
> @@ -3492,15 +3493,9 @@ int swapcache_prepare(swp_entry_t entry)
>
>  void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
>  {
> -       struct swap_cluster_info *ci;
>         unsigned long offset =3D swp_offset(entry);
> -       unsigned char usage;
>
> -       ci =3D lock_cluster_or_swap_info(si, offset);
> -       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> -       unlock_cluster_or_swap_info(si, ci);
> -       if (!usage)
> -               free_swap_slot(entry);
> +       cluster_swap_free_nr(si, offset, 1, SWAP_HAS_CACHE);
>  }
>
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
> --
> 2.39.2
>

