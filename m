Return-Path: <linux-kernel+bounces-560133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68EA5FE6A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C7FE3A9F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71661D63DF;
	Thu, 13 Mar 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2unidVw"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B01BB6BA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741887743; cv=none; b=Z/VbykGr06WNAbZjsHwaciznWvco814XDN7eGv0RR4qINQmORpZERPdIDS4MtBWdZjUHfPCbwVZQP3i3LBbDZNN5Ifn8m7au6M27f3vPLS1pRT+gWgPoz0L2tmnUIOeCRVGtiYQdnCWyRvLVYPCDFm16VJkryv+gNTC3AZyAjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741887743; c=relaxed/simple;
	bh=kzAfVEhiIMAdI9Tvq1TPdn47C0NKDfWoqMTK/7cgPI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/fV3ZNjT6rjv0AsWV6it34OxZXyYxcVw7YtAE4+ZT8tKdqi7Nd+r67EAmoz/7wU+BopnQpiCof89gqgRgGCCj5VXzUlxQiZPSGdjVnZDmDUvJC1h70Y46O/HOaOhfrKnhQP3DI7thIshNFFER0ctxzOvP/GtlLdo+W2ayr2S9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2unidVw; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85517db52a2so21989039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741887740; x=1742492540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzRjsGmgrcmLRD9pxAIJR9UDP98igLf07dZiBIxzCu8=;
        b=g2unidVwRyTo/y55IcF3KiBmplEG2JucUCLxvUfCh20Jssq79TOnscaGwzw69K78BD
         SKt5aIoYazZigq/kZ2dE2oYO+23aUnB/EgkT1qIgweON5MhczSry7zBdfzvEty6+Zyg1
         kmd27jvYq3Tr8v30j28FFTJLULwYzZMYSfGtdQDUGjd0wp1t59l5Fmr4lbg1ZdzUJ76x
         Sdj3Pg/PTSBda8D8C2hQ4ERPWI9+c7ILYXfBwN0wwnNSuwrMx3cfkoyBK53YLhKILMLx
         pNNR7RqySe3KrE5i3pCJfO4JpeyiLMVkVWG/9O054LmAd9Zx1/Yw2zSC7o5s8ZtnXabg
         Gv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741887740; x=1742492540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzRjsGmgrcmLRD9pxAIJR9UDP98igLf07dZiBIxzCu8=;
        b=vM0uYHlSeYALMLZeMxxb0EkKNSew0xxMuBnOQAabEL88xBIbaQzpJquBUcxR+KGysF
         WwpVx6i8FkxnV9E9Ru+kMJKuoc9hRnjnVlBgzo81YVUquB3xZBIzKa1krs9OfKOC3aOI
         UUzL9W7SXb+o0jnraN1N++/8Xpz8AL6A0GqoFsZ7YDe7pedB1Gq2lRUqi1zOggQSFRjV
         eGaTUbQ9OnN8iskmTT1UNUqm0yImRvSQiNmzeVOrLdIL90Vm6XOr7abtaWV+3a22LxUx
         YEsQuXeiY7/zdpFyP8WDKnp+6oadYeUUN8q3igkijRxFNFccaHCAgQ3X415Fm7mHHsq3
         z/LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnJoQD0jfyQNS+zC2p5mxOa3fkIxYTWPox3jBZN30SYQPvdBOOont5luKhV//wlv7/yvIx8OG1BUOL+5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZqGrSbC2jjOnxS5ZatM2T97sbD9d104k7981dCRFINMLwGdpG
	FkvfuSiCd3jFqgRbEIg0KvpoTz+yuUArdhnUV0ZZhdUuhrG1dLcd3N/jsjbgxDPu0MzVUrVx6wb
	wKKmYhm2xLbEhWN0PKeMqvSBxa94=
X-Gm-Gg: ASbGncvrlIp7fplgfpOyx+95Cmlqy/dVhemYbxmuAf4ICUy7G3sJnndaJtxx5YVQWku
	NgeZXoAJQgR/62d50CwUqTvUy3La2igoOkwYaXCBy9kr0Ww6JSCSSDtx0xGXahRZB13Ne4jtvea
	DGWDvMgCmNd7hTeB/Lmweult6wwyPZlr1QrI2Y
X-Google-Smtp-Source: AGHT+IFfF9KJneZJFwJIQuwgstII0wFOWeR+aLTcQrhWtdW21ZZ2D7ebLsDMmqKYndyO7oeydyE2oRvKM5JdMjl43Lk=
X-Received: by 2002:a05:6602:6a8a:b0:85b:45c4:571e with SMTP id
 ca18e2360f4ac-85dc19d718amr89275239f.9.1741887740579; Thu, 13 Mar 2025
 10:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313210515.9920-1-shikemeng@huaweicloud.com> <20250313210515.9920-3-shikemeng@huaweicloud.com>
In-Reply-To: <20250313210515.9920-3-shikemeng@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 14 Mar 2025 01:42:00 +0800
X-Gm-Features: AQ5f1JompTzgbwN-iESGGTqXlCXKY5nfcFyM3nd4dgCUQBqtFCjByq76KT6atM0
Message-ID: <CAMgjq7Ct8b25zuCEqJ4byU8gmrvz50pUqvyjYN=_RjTk_5U8cA@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm: swap: factor out the actual swap entry freeing
 logic to new helper
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 8:09=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> Factor out the actual swap entry freeing logic to new helper
> __swap_entries_free().
> This allow us to futher simplify other swap entry freeing code by
> leveraging __swap_entries_free() helper function.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5a775456e26c..7c886f9dd6f9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1347,6 +1347,25 @@ static struct swap_info_struct *_swap_info_get(swp=
_entry_t entry)
>         return NULL;
>  }
>
> +static inline void __swap_entries_free(struct swap_info_struct *si,
> +                                      struct swap_cluster_info *ci,
> +                                      swp_entry_t entry, unsigned int nr=
_pages)
> +{
> +       unsigned long offset =3D swp_offset(entry);
> +
> +       VM_BUG_ON(cluster_is_empty(ci));
> +       VM_BUG_ON(ci->count < nr_pages);
> +
> +       ci->count -=3D nr_pages;
> +       mem_cgroup_uncharge_swap(entry, nr_pages);
> +       swap_range_free(si, offset, nr_pages);
> +
> +       if (!ci->count)
> +               free_cluster(si, ci);
> +       else
> +               partial_free_cluster(si, ci);
> +}
> +
>  static unsigned char swap_entry_put_locked(struct swap_info_struct *si,
>                                            unsigned long offset,
>                                            unsigned char usage)
> @@ -1525,22 +1544,13 @@ static void swap_entry_range_free(struct swap_inf=
o_struct *si,
>
>         /* It should never free entries across different clusters */
>         VM_BUG_ON(ci !=3D offset_to_cluster(si, offset + nr_pages - 1));
> -       VM_BUG_ON(cluster_is_empty(ci));
> -       VM_BUG_ON(ci->count < nr_pages);
>
> -       ci->count -=3D nr_pages;
>         do {
>                 VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);
>                 *map =3D 0;
>         } while (++map < map_end);
>
> -       mem_cgroup_uncharge_swap(entry, nr_pages);
> -       swap_range_free(si, offset, nr_pages);
> -
> -       if (!ci->count)
> -               free_cluster(si, ci);
> -       else
> -               partial_free_cluster(si, ci);
> +       __swap_entries_free(si, ci, entry, nr_pages);
>  }
>
>  static void cluster_swap_free_nr(struct swap_info_struct *si,
> --
> 2.30.0
>
>

Hi Kemeng,

This patch is a bit too trivial to be a standalone one, you can fold
it with the later one easily. Also you may want to carry the
VM_BUG_ON(ci !=3D offset_to_cluster(si, offset + nr_pages - 1)); check
as well.

But, that is basically just renaming swap_entry_range_free, you may
just remove the HAS_CACHE check as you rename it, that way the changes
should be cleaner.

