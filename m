Return-Path: <linux-kernel+bounces-364799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D84D699D998
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921D92823AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A91D12FE;
	Mon, 14 Oct 2024 22:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7V+Moa+"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7021313BC02
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943444; cv=none; b=hB6E10JND8785OI6AtSiDs8h51c3vhyX4qa/jpUQ4xbzSi+re2v8ErTsndaxooLu+NsHoDmHwluADMnQbtYzUQAISOP6ZQ6Fa40fTNhutL4ez0ZODz9a8LMT5yonup8lSLJSP7EFz+A47ExblsU1+4KDV1dgXWIO/cFez/TKgKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943444; c=relaxed/simple;
	bh=9XUpDDRcBqbu2w6QU8TQz9geqnw9ZPIRtw1PaYRliVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9K65b7JVF/gKJIDqVvXxisiIZHZ48GdqAqK7FBAP3HZ6KrB50UYJui2PHwTOKRUBD8emumjr1Iaq5iwy0D6gBqEB6VfFfxY1KmM3BQFL4OgngCZaMlEzqUUkNWWYZtaVCYIquNbDPRze4k/fwsMPlhyhGOPr2YTiWPGYe/3/rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7V+Moa+; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso7131825a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728943441; x=1729548241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx8NM0bdeYN9rCrOevOuCpiyugT4ieg6TW43vGbOgbI=;
        b=Z7V+Moa+1fK1gCCXz308TV1e8OLZ4Qm9Rg0YaCbhcLa57Yeuav2TxhaSKjLjsun4WK
         aUeauJSXjrCzPd8JvRo5rCknB/9gFvgA/Q4iGhyOA+08pYUNOR/maqPSyB93+C5ZDu77
         n2czaObeXlqD3DKq3ZpveeMf015IKkjmKygahmELbZdZ+W4zv6ls1Xvmo1jcounXb8BV
         gCu6DjyAbOZfMKm9liuH9c3m5d8EeA+D/J5sC1aMzR4Fk8lc3bEAJ3DOR2/u4y/m0A/p
         vmAlOlVUYUBNswQCMaJJ8gVcLa24S/SDSunWo4bHTeWynqlaM+k47yeSl5c7lG7wF26a
         47Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943441; x=1729548241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kx8NM0bdeYN9rCrOevOuCpiyugT4ieg6TW43vGbOgbI=;
        b=m590BgFYg3PaUzoLLNzPS/A5GpXXHfCREh/hJuYA0ECacTMf8rEH8gpklhF6DLzbEQ
         MWma6CuC8/oK5HqbK/pM/qXT3YuJHGEAjDxO/ov5K6rAus5bT+0Dm7ejYrHWcWqwr/mk
         DCFGuMpbVemyoxueYTAKmIPtSA4eCdOCPhO627F/ntwOcXeihTueQctgIWjbzuwT5/u+
         w+HVV7Iy2AlAfdSg88ULLmkUGkcpnH3vvHgaTh9O6rrR9qgm4WJjGaTYPVgQAkT6w0Hr
         K0XL9R65EjQLDjUeuF2p5p0vAFlPpR93JyrKqcZnzAC1fJCak3XrjblAeDn7tB2ExYA0
         5jow==
X-Forwarded-Encrypted: i=1; AJvYcCVQM2GbVx/FWxUIGDiAW12E7eYJkM6azjftsMxn/FOkTpcRTbJOVYlltI7lyGiaPHU6LGP2I5vSfnA7Duk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtgpWF8Mlk8H6NhjzporaKcmIeyOxyircPxRl3rZ2BtWYyWYt
	P038vortFZsBtlEbBxbLKcwFb0KFX+0ctPHb79WT6aV4yW6iXRN2g2Zt6q1V7uSbf94NYm8HYI0
	aYPDqo+0G8FYs33ZbHwNXyI5EKnT8Zg==
X-Google-Smtp-Source: AGHT+IH1au53PnEHPZpGVBw9/xMf5uc+ZKuMLIu75sipFRo4eJPp6kB8vAbXB2AteZ3k1ccGdMJyQ20z+UcpfglcAO0=
X-Received: by 2002:a05:6402:358e:b0:5c0:903e:963a with SMTP id
 4fb4d7f45d1cf-5c948dac35emr9155725a12.29.1728943440468; Mon, 14 Oct 2024
 15:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
From: Yang Shi <shy828301@gmail.com>
Date: Mon, 14 Oct 2024 15:03:48 -0700
Message-ID: <CAHbLzkqB_CfaTH=KvqdgTq9rFcO5SZ8wHYo8vzJXVQpmBiRN9w@mail.gmail.com>
Subject: Re: [PATCH] mm: khugepaged: fix the incorrect statistics when
 collapsing large file folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, 21cnbao@gmail.com, ryan.roberts@arm.com, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:25=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Khugepaged already supports collapsing file large folios (including shmem=
 mTHP)
> by commit 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse"), a=
nd the
> control parameters in khugepaged: 'khugepaged_max_ptes_swap' and 'khugepa=
ged_max_ptes_none',
> still compare based on PTE granularity to determine whether a file collap=
se is
> needed. However, the statistics for 'present' and 'swap' in hpage_collaps=
e_scan_file()
> do not take into account the large folios, which may lead to incorrect ju=
dgments
> regarding the khugepaged_max_ptes_swap/none parameters, resulting in unne=
cessary
> file collapses.
>
> To fix this issue, take into account the large folios' statistics for 'pr=
esent'
> and 'swap' variables in the hpage_collapse_scan_file().
>
> Fixes: 7de856ffd007 ("mm: khugepaged: support shmem mTHP collapse")
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/khugepaged.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ba28ba09fe89..6f8d46d107b4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2267,7 +2267,7 @@ static int hpage_collapse_scan_file(struct mm_struc=
t *mm, unsigned long addr,
>                         continue;
>
>                 if (xa_is_value(folio)) {
> -                       ++swap;
> +                       swap +=3D 1 << xas_get_order(&xas);
>                         if (cc->is_khugepaged &&
>                             swap > khugepaged_max_ptes_swap) {
>                                 result =3D SCAN_EXCEED_SWAP_PTE;
> @@ -2314,7 +2314,7 @@ static int hpage_collapse_scan_file(struct mm_struc=
t *mm, unsigned long addr,
>                  * is just too costly...
>                  */
>
> -               present++;
> +               present +=3D folio_nr_pages(folio);
>
>                 if (need_resched()) {
>                         xas_pause(&xas);
> --
> 2.39.3
>

