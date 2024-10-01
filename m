Return-Path: <linux-kernel+bounces-346689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722A598C78F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 23:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA91C242F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 21:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD921CDFAF;
	Tue,  1 Oct 2024 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FhYS1JLP"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D41CCED0
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727817859; cv=none; b=O1XdjOucII21YR7QFwUs8kudoBlw71FdwLXvFZe64091L8AS8JrW9CZ9rS+ms/dFvtSzpv0r/QgB1iW3pG/7ieDSfZZrnM7vNEIl9DS26WP2jPd019E7PKEHH2oYP/xUgH3UEvpYHza0xnWlySlGwZN7MNybQRaGqCNhfz37Z4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727817859; c=relaxed/simple;
	bh=dtlV1lVWGHqIusGVP1xa6CPYy2ICFiVnSl9BJ6RA+lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO671FJURySyF7dyTOCPFpBlIfVLI0RyuwM4Zx53eaxFhV/NLnmQ9wh9XQnjxwFSeA6U5lyYVepktLZ0CmOKKCQo6LzQCILvLPQTyVKzh/KhBUx6ujQwjk3KOH6dxwPL66WexjcmMrhbRjUxn83gYTmrsToMq9LdBVYjr4XvVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FhYS1JLP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45b4e638a9aso34631cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 14:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727817857; x=1728422657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt3Is1RFmYLd5Na8zkD+A3g9HRH0C7v0jg6OTqp/amI=;
        b=FhYS1JLPHYXlz5pibzyc9ExOxaQ/7f/IfwGGTsjbcKnYhV/nmq4dge63kS7xaClhsP
         +jfcxBFtdL4EEjytQ4R9ZekK0W8SpmPLxfBuvguVouoRgZlCs45re4tcZdH0vJ8gqA70
         uiXz0goK4vyrZboFqwMWJZrDEwB6d+L+ewlq+SopiWfEurRcYfayxxqXy+wti1CFRwZP
         iomONP4bhdv4AEU3I5pIeKiraAgBsNeTjzoo6ejTJ6PdL5FglcS6nNCSFsxjQ2hn/gpx
         n5Z7vCIlkTKwde+3iLp0YtIGFhGPToZWPf+5NHlb1XFq3HNpzfCYJFVyHjDcMTJCF03z
         62cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727817857; x=1728422657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mt3Is1RFmYLd5Na8zkD+A3g9HRH0C7v0jg6OTqp/amI=;
        b=HbrOmVOC4m4lm+Fpca2jovacSb5rkCVeVKRWWxTjUrB2Sf6CyXaqSjM+WT3giBkwBj
         D5d8Fxm3Wc2aXVFlvgwT/DZbOGVSs2upJyP1/CtXxCsAd4g+Z+EpibpleOA1jHo4VdQe
         9FtesuE+4Ct3KWPV0QJ+icMA8MKPd/9I9UH4dOW2jLQXEduTXP7Kb10i76qQshfcFlyy
         hiHRLPJVxe1KDAmFJR/fgk44xRe29nlKtuUfK9hqcgL5C1GxgxEHvW7lzCS6F/pQQ6yA
         zN/Oilaqi/8TmwRFj3iDqBglhU6di1jwImuZ4sl1gtXVw5yLbw5CHGbbBWg47UqCne6R
         +Q8g==
X-Forwarded-Encrypted: i=1; AJvYcCXwDbaC/NJeOfkourDzbH9hf6NqomTv3wyW1DRB7K5UidH8G4Z9JMWJfpBogt23Py5k8Hu+XLT0fn3pkds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKTrVzjg455m0kDTJwbwi1TgxziS6FYq4oIi+Ij9pRhSY0xyx
	IjKiyCjCWmZP6dDZ66Tcv0uZ9/wp2r5bbSrjjyKuRyX5WyFcaeRle2HmEhDUGiFeQ9S/Jb+X1U0
	pna9RqBoh/Y9JYOWSP9K5WZGGN/9Qu1aLPtGF
X-Google-Smtp-Source: AGHT+IEb/LrlGiLV25l7MI+5b+nV38eUfZtAIem1Ibw7evfeTyXOlxSzC1S9UXoNTcPhVVESXBGpaUCGkw/4Vut/mp0=
X-Received: by 2002:a05:622a:500e:b0:453:5f2f:d5d2 with SMTP id
 d75a77b69052e-45d8323ab96mr258141cf.1.1727817856653; Tue, 01 Oct 2024
 14:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001175057.27172-1-quic_pintu@quicinc.com>
In-Reply-To: <20241001175057.27172-1-quic_pintu@quicinc.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 1 Oct 2024 23:24:03 +0200
Message-ID: <CABdmKX2xEn8QjObqR3VNb=RqMZVNBiNtkfYWm8h_3Xc8KMkdag@mail.gmail.com>
Subject: Re: [PATCH 2/3] dma-buf/heaps: replace kmap_atomic with kmap_local_page
To: Pintu Kumar <quic_pintu@quicinc.com>
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com, 
	Brian.Starkey@arm.com, jstultz@google.com, christian.koenig@amd.com, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, joe@perches.com, 
	skhan@linuxfoundation.org, pintu.ping@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:51=E2=80=AFPM Pintu Kumar <quic_pintu@quicinc.com>=
 wrote:
>
> Use of kmap_atomic/kunmap_atomic is deprecated, use
> kmap_local_page/kunmap_local instead.
>
> This is reported by checkpatch.
> Also fix repeated word issue.
>
> WARNING: Deprecated use of 'kmap_atomic', prefer 'kmap_local_page' instea=
d
> +                       void *vaddr =3D kmap_atomic(page);
>
> WARNING: Deprecated use of 'kunmap_atomic', prefer 'kunmap_local' instead
> +                       kunmap_atomic(vaddr);
>
> WARNING: Possible repeated word: 'by'
> +                        * has been killed by by SIGKILL
>
> total: 0 errors, 3 warnings, 405 lines checked
>
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

The Android kernels have been doing this for over a year, so should be
pretty well tested at this point:
https://r.android.com/c/kernel/common/+/2500840

> ---
>  drivers/dma-buf/heaps/cma_heap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma=
_heap.c
> index 93be88b805fe..8c55431cc16c 100644
> --- a/drivers/dma-buf/heaps/cma_heap.c
> +++ b/drivers/dma-buf/heaps/cma_heap.c
> @@ -309,13 +309,13 @@ static struct dma_buf *cma_heap_allocate(struct dma=
_heap *heap,
>                 struct page *page =3D cma_pages;
>
>                 while (nr_clear_pages > 0) {
> -                       void *vaddr =3D kmap_atomic(page);
> +                       void *vaddr =3D kmap_local_page(page);
>
>                         memset(vaddr, 0, PAGE_SIZE);
> -                       kunmap_atomic(vaddr);
> +                       kunmap_local(vaddr);
>                         /*
>                          * Avoid wasting time zeroing memory if the proce=
ss
> -                        * has been killed by by SIGKILL
> +                        * has been killed by SIGKILL.
>                          */
>                         if (fatal_signal_pending(current))
>                                 goto free_cma;
> --
> 2.17.1
>

