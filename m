Return-Path: <linux-kernel+bounces-275532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3189486E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD2E1C2228D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4977179C0;
	Tue,  6 Aug 2024 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8Y0gvDC"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018B4A15
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906484; cv=none; b=jM1P2AfJHdxxeCSqRCQMK+ZdeYsFybBDJevV+JGDQLT8dgnI13In5Q2ftrphhm5KJ7XXlwjPG64EbKbeqR3NVSBzs0+rShoYayMOloTIGgdTpta/c6KfWeRQNmod9/6XAYBtWgeSanWqQogUvs+SD4jkBKDa4K6gWAEqVAbn+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906484; c=relaxed/simple;
	bh=l7cAiRt8kOKCDFenfYmQSEyC20G3OW9HdO4GxtHcxQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGuZcjgepkUphfFpTJ8sdSuhoN4cLLEVgJ05VY+9qYEbluzHkm950c2RzDnfxjB6VsejPFHRhsNFfu3Cp2tV0SOUNO+ljPkE7KVimxHywXTyCynS69EunjWKDCEYeoABjynIackmmjmXr8sVJgOtqgFwKnVXR+OLMW38ICycpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f8Y0gvDC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aabb71bb2so1343180866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722906481; x=1723511281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ndtU8uZ3NwtS+ORp+o4K5xii6RVoLxBCf1D4iTv9w=;
        b=f8Y0gvDCZOdVnDgwRsSri879FdeUz5TqfDgwXIVgbw6p38OJVtlnpVik/HGJda2JRw
         cOIcRMkX3KOt55o1QKbpMvWW6mld+lbyV8tmHMuPyGuB2mYbjS3/D6B5IpnIgwLiHwdY
         bmnUXGNB60TMPLHkygCfSLNLgEpdqnoklgGHlm1Q5egAGlcnwGiF2h6Ls0wgzw6oQ9J3
         FKG7s24pQxi5MT529BKGyvsYe1OwEG1x2WYGJUKW1B1aNEMK34xDZpxd1TysVgn4Qff+
         zvgWsgaYvQ4DwYbOppfHoMFbK0USEAo3o4V39BJh4Izs4OWYjRkowatsBpBHTRbNe7kQ
         fo8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906481; x=1723511281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6ndtU8uZ3NwtS+ORp+o4K5xii6RVoLxBCf1D4iTv9w=;
        b=EUUmFPzhvppS/+NQOG9URdw8X2fEoCN/X/auUhv3gZTWLrnjBooZAiw10JM0g3f17D
         oD0keDrq3ZDBdKPpyvoKnJc0dOJwzcMKe1s1Hc8cDbDhH0VPakGWeLFhIZtafQbI3mfy
         9hlJ252w5H7BcCvAhfG45idQ9h0N+Ck4xoLE2/mb1m7qM8Zc04jBrzgb+T5cNMbVBcQd
         QiX2+mApDGYmkH1JtPRXJWrvA8/EuFltD6dM7C8VbSoEFE8hBueLLZ7+vn66ncIIJToV
         p/vwvWvpUwYl27Mf9Wbh5rJLxMKMdgDSJlg1mP8fjciA5BLwfLpfdQmOwb1i/cFcdE4H
         NV+w==
X-Forwarded-Encrypted: i=1; AJvYcCUz6uAVauqC+tttdpKJf0RbQGFwNY8K0eaFeOok5n/AnTVz1eYxwyffRsS4EQV8gxFl8z3MVYTEar3n09+HY1aLQv7xaI074UKIgakE
X-Gm-Message-State: AOJu0Yx50HXvBzYHsF17GzvxYsg0uM34GOVhYSnpHJ17JNYtCVOTyzhC
	zc6Wg9pR7+tvZzIVVUzIF3PyOuqPvSQaePqaZ+qhPnZ8TuwGakVRKSe8wpAnWcAjkBAkmx1hbrD
	fRMrgdJc8N8xaDOT8BijG8IBJJyEr8LI/4sbk
X-Google-Smtp-Source: AGHT+IFYsmuj2eHWrNVeUnRZvUF9JRFvdYm29RIdAQF9ytbZxgKKjw/ejQs71dC7KD6rFO3aPrr5vcCIsgOM7gqvDbE=
X-Received: by 2002:a17:907:7b8a:b0:a77:cca9:b21c with SMTP id
 a640c23a62f3a-a7dc4e8c3e5mr1042930566b.34.1722906480523; Mon, 05 Aug 2024
 18:08:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805232243.2896283-2-nphamcs@gmail.com> <20240806003403.3142387-1-nphamcs@gmail.com>
In-Reply-To: <20240806003403.3142387-1-nphamcs@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 5 Aug 2024 18:07:24 -0700
Message-ID: <CAJD7tkZACWjdr6Cow74XO+Kw1Pdt7esHQss03M5f2U6P6Ey_-w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] zswap: implement a second chance algorithm for
 dynamic zswap shrinker (fix)
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	flintglass@gmail.com, chengming.zhou@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:34=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Fix a small mistake in the referenced bit documentation.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index fb3d9cb88785..44a7234a7b11 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -188,8 +188,8 @@ static struct shrinker *zswap_shrinker;
>   *          decompression. For a same value filled page length is 0, and=
 both
>   *          pool and lru are invalid and must be ignored.
>   * referenced - true if the entry recently entered the zswap pool. Unset=
 by the
> - *              dynamic shrinker. The entry is only reclaimed by the dyn=
amic
> - *              shrinker if referenced is unset. See comments in the shr=
inker
> + *              writeback logic. The entry is only reclaimed by the writ=
eback
> + *              logic if referenced is unset. See comments in the shrink=
er
>   *              section for context.
>   * pool - the zswap_pool the entry's data is in
>   * handle - zpool allocation handle that stores the compressed page data
> --
> 2.43.0

