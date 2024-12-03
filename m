Return-Path: <linux-kernel+bounces-428519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EFC9E0F95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB03FB22716
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E00136E;
	Tue,  3 Dec 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qikp3wu7"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277B81FC8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185062; cv=none; b=DLU0wUqdYAYkOJbhc011bfF8UTNqhQrQ5QCHTKh34THZ1RR2dYgI7wurrNvRVW2SZCkAJpnqjkMxcfmuRhKRPV1cqb96sH5/J7FD5pIm5hC+uJ38ReAwrWe/J94Huc/AO+KtPImKxaV8QWJqPfE293aX2V5TDQnnw/5QIeSg1sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185062; c=relaxed/simple;
	bh=OSLedXbD/kr7jbjkR2jT2olk8x1cF6yjqTjc9OPU2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOQxCBbo6/L0P4uYMx7sKk5zGcaXQ1O08JUsLauBOCklmWwYmTqCtFk6CbEJ3r3QSOHoqeaQWpLz/a4+9tUvGTlG8qwc2O1vVzclqzBTHsDwGGfhQNLVknBeH+3+6iw7+4nCzMpxKH9RP/h4J4oYw5hRMdFpnpkdIuCmDIxWJOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qikp3wu7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6d842280932so48509936d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733185060; x=1733789860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krGF3mlNQ8d+J7M3u+OrOilG5NzzZ6fC1XLrijBYY9k=;
        b=Qikp3wu79SaqWMrxNxYwC552mBQ5VVWEriRjozX8hrp91WCJQLffHCqopmrAMP8PNb
         xI+hODkhPm2/1g1d37S8yqr/LVvWglBTh+4ODMq0NAsIJlej+U3cVIePPJT+0Y43eFTb
         XkHYxYdK50k2wMwu60C2Gj85kWxb0MIcqiSZ4I56cVvk/scJLQyBEMo8F28hBaQNr7or
         6EsEk/VguHYXU9R4IlSSFRAS73VmiUg34GLt1vg3/23NuC1bIdKqXNPGHChVHb00hRjh
         5Dn4Sw00Mb/S5BWMNd5m6Cno/wN8EMVDlYWqQu/2Uhu3etDbkdhfc1Nn8b/ZI/M1pUHz
         /RKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185060; x=1733789860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=krGF3mlNQ8d+J7M3u+OrOilG5NzzZ6fC1XLrijBYY9k=;
        b=cuO68UX67Yf+pUV9vzFN2aAlcijOanwct16QMhB2XH/ej/Aa2G304U5fq6XFKvAnSl
         +F2KOHLtbvyQlWtmSUZd5SX+J4p+w3H8FpvTY9bS+bqU0rHcaB2xBwyVwBen8E2MjtNQ
         azAJ6ZNVczAxbyqgByQuHfMP33SCPdYgRZcKk047ISSqErK8pAG/eyXVyOlp0kzlDfwA
         e2bN5w4Iqrgu2OgfhK6kvKhsXImB72qQA0GWCAYHWb79WKbJ782wx6KgGXbvtSB3wSEL
         /EjikF8jdX1J0dj2t1PP8A5ylUWaNLXXNSnZ6IQ1aNTcTOzRDJ/MufFDaHc1E1fAPRph
         bo4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVilFF39GkJ7lG/XLgg4yoAXQQxRZnofYBRiRWUYyopWz6u4z/z4ZbL+vXnt/JnMdUN4b6W9RHrReymH8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsUOJ5sS4zYqTsPIiduZbmH4uVmvAijyaVpb0wF+cMEbXmxI3
	lFhxyaNNo+cTnfaOxugySMmBhTVF/gV7AmAukz5tof48UAKxUOMiNnHOOyA5QPoXqtbLuUX0NiL
	tow+FORe0o5IKq+UNN8kC6FmVhVo=
X-Gm-Gg: ASbGncvH4sio/UMXuzrQGkLhwX5QFdhbQU/XyQdO3CdFEBPDRPhoJnxzV2QnXH+4GTj
	oXJwt9RiEfboyVZ6mwuUydPt4xPkVSA==
X-Google-Smtp-Source: AGHT+IFI3RRX0sc4tNfzQIw22CJwi4WTZGCYXnLnpD5mChTG9YssqvqmWD+fX2tORqmxM/maI2BeW/OVRPTMUKl4nSo=
X-Received: by 2002:a05:6214:e86:b0:6d4:22d4:f5b0 with SMTP id
 6a1803df08f44-6d8b73b7668mr9909076d6.33.1733185060044; Mon, 02 Dec 2024
 16:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127225324.6770-1-kanchana.p.sridhar@intel.com>
 <20241127225324.6770-3-kanchana.p.sridhar@intel.com> <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
In-Reply-To: <c9a0f00b-3aeb-467a-8771-a4ebb57fbba0@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 2 Dec 2024 16:17:29 -0800
Message-ID: <CAKEwX=Oxa6Ov25ef6uj598jpZY=pFC2pcFrHSD626zuhokhrrQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mm: zswap: zswap_store_pages() simplifications for batching.
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, yosryahmed@google.com, 
	usamaarif642@gmail.com, ryan.roberts@arm.com, 21cnbao@gmail.com, 
	akpm@linux-foundation.org, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 11:00=E2=80=AFPM Chengming Zhou
<chengming.zhou@linux.dev> wrote:
>
> How about introducing a `zswap_compress_folio()` interface which
> can be used by `zswap_store()`?
> ```
> zswap_store()
>         nr_pages =3D folio_nr_pages(folio)
>
>         entries =3D zswap_alloc_entries(nr_pages)
>
>         ret =3D zswap_compress_folio(folio, entries, pool)
>
>         // store entries into xarray and LRU list
> ```
>
> And this version `zswap_compress_folio()` is very simple for now:
> ```
> zswap_compress_folio()
>         nr_pages =3D folio_nr_pages(folio)
>
>         for (index =3D 0; index < nr_pages; ++index) {
>                 struct page *page =3D folio_page(folio, index);
>
>                 if (!zswap_compress(page, &entries[index], pool))
>                         return false;
>         }
>
>         return true;
> ```
> This can be easily extended to support your "batched" version.
>
> Then the old `zswap_store_page()` could be removed.
>
> The good point is simplicity, that we don't need to slice folio
> into multiple batches, then repeat the common operations for each
> batch, like preparing entries, storing into xarray and LRU list...
>

+1.

