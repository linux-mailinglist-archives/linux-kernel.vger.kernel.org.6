Return-Path: <linux-kernel+bounces-364005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373EB99C9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686281C22418
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 12:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F15819F418;
	Mon, 14 Oct 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErUj0oxC"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98219F13C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907803; cv=none; b=IECuAqcj982//BfYmJRuAseIPPMEM5ApZiQOivcxCPZNbnC6fkUHZoeBI+oSyKlLm94B3uFfhEYESuVFZ6HuS8o2XPmKu4qEredgkdWhtLNqWeL26pUHhHLGtkQ9K1Ff+ajejmGTrURLP9avsTZ8bsIF06cwaV1kiA3Qajl2hR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907803; c=relaxed/simple;
	bh=x0nenYqhgU7WL/LxRbJJmGNcIwqUgqYaFZUishbksuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkZknr8nyi+2tI22YdVwo4BNhKI6+ewM916Tp+wXbdN3QwtJSlTCBSHLxhCH/UZeTgIaumkf9EvB/3v/+xz0WgbnHoESqmjN1EzBFraG6rRvjK4ud/wR8b08RDXZuIkkHNwdLXruqjPoqnvTP/2YfTFHMBYHRhMjPPs9ijUV1X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErUj0oxC; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e291f1d659aso2164657276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728907800; x=1729512600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VevvSWbfTbI4kr7NbbWbmKgy6qwPGN0N31A8z+Cb31A=;
        b=ErUj0oxCA51ofzYdDjdkgBmB8KlwxI9n0+Q/MTCQ6HGfmJsLGj0vEjafSoSDWQ/5BU
         YAaht8VQYvplStsg4+j/3aWUNiXrqORYGeuxqEkpiGenKmsZwUy+lvf+4Zog9BQzoJSE
         nS3mBMbytz+XfKr/c6trcGFU3jkknBpfjb2FwZl+k6OI5MRNhaMiDuyG4LnAutIQxJ7t
         S8gIBACnUOE9hsQAwpsVS1uQettr5mPnfyD2EBXTE0MnNvf81gpuyA6ZX4onq+H/hYQK
         jUJHO+yZoRtRfU6vSqjunHlRhik3ypKdYeFkccPrm8DhCWTFhe721xjI8O8e+MC3ZQh1
         UD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907800; x=1729512600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VevvSWbfTbI4kr7NbbWbmKgy6qwPGN0N31A8z+Cb31A=;
        b=uPiJQPHQ3GxYOF9FeMqJZ1WWXyItbcMVlH3Oym6Y5YMQAuGMXxTRYyuXHECdQ/Dtlc
         ZLAs5UcGG91s1m//E30IkAPTepZjQd28XvAkOKK0snp2Nu2nvkVAi24sI+17i86TcdL6
         ZDL1FDY1KbKz6n70Lz50wkpBY3P2LyCEpIwT3ZhmoEMR3pXmlp/Z1aw4NoWpDAsMHJch
         hg7KmdUS/VZHUWbMX+r6nybC0tiWfNI92YHEbMTSqwrdFMH2FGaLdqRom74SuI80Rlbz
         Q/qz0vQFd5od2ibX8eH1+wdwiF+Y5aCeLr9LUM90JiJG7uaR93J/wn9ISIe9LN0nw9mX
         Cfzw==
X-Forwarded-Encrypted: i=1; AJvYcCXAgXvhtwcPDv54araRvyWrvs0fURiUnHotaQVOZIF1YwxDHW9H5Dait8ISBHIyX+yrDxC0cDS0s/K5cU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycsUg+v9b6UzjqIjTj/5GkAWnlwXlz6jlVz1lzPJJ79TvoAtaq
	23lT0Rzv9UBJNajR0k22oEP+4phU+OjbYZKl5m7j/hj1QWYUAOhY3jf83g8vgcmvzC2pXUcZQsu
	bdMUYc819FPlhPX41cZfbJNpAkc8=
X-Google-Smtp-Source: AGHT+IH7FzebbLM4Dxebzmr6WDsWW42x0eAUD0MeXR6sXUru9rfeO6cpRYzOCISM46t5SqVYx3VL/MsDkQF5vdXQQlY=
X-Received: by 2002:a25:d8d6:0:b0:e29:3bb6:d650 with SMTP id
 3f1490d57ef6-e293d80c2a4mr3336153276.21.1728907800518; Mon, 14 Oct 2024
 05:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <c76305d96d12d030a1a346b50503d148364246d2.1728901391.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 14 Oct 2024 20:09:49 +0800
Message-ID: <CAGsJ_4ybLyd3rHQgfySuiXQt1c7gS-w-2bK6xQ0Tuapt6qLwRA@mail.gmail.com>
Subject: Re: [PATCH] mm: khugepaged: fix the incorrect statistics when
 collapsing large file folios
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com, ziy@nvidia.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:25=E2=80=AFPM Baolin Wang
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

Reviewed-by: Barry Song <baohua@kernel.org>

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

