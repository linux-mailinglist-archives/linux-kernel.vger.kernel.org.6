Return-Path: <linux-kernel+bounces-537428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EED3A48BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37454188A6AF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD101B85DF;
	Thu, 27 Feb 2025 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsT7sTCn"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876342777F6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695719; cv=none; b=szudWiA4I+QRGd10AdjFfV0K+fqKhcu1ELVnMn4qQvoQvV7pNA2hTRERqwjyOegaBd0n0hAi5Rke+EbcdFtanuvEIrEO84suRx5C6QSNeqcUjwBKCGapNCpiIXIDTDHt7dtyNGX9Lwpvpotal1kVnmt7dm54BmSSkD/DS66Qt/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695719; c=relaxed/simple;
	bh=pzgJZqp9/2jxPuKYv7SlvRY3rJR8w+poscUcNCqmU14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xw5+QyufNsN6gCuKo13rznr4ypsy+Y8iWsmN0VWb54UUhbBNDvQ5VwSomiOSrp0GGb7gcqKXPEZteBOrdIMbFi1MW+vdJgOVMgpTHU99pVyMGs/ijpEjL9330AcnjrMznIUMpV7BZ1Q3CNq6C/aC2DD3SbFdldZktb760srkN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsT7sTCn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-471f9d11176so15437281cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 14:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740695717; x=1741300517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFM8VWziXs6qPoRm1OGpOhZo/LlHLEag1S842GTC5Ws=;
        b=YsT7sTCn+NqVmyphZKBJBZ3jFaPMpIt8/UWRtJgzhMw2TYfv7/bkWTehPywwksmZ4z
         vIX9V3GJLYdnA50prbXbFuB85t3BU7aRrI9G9ysKFhK5oFv3DcJUOMedPQEJD9Rfvs3c
         oS0jkSZlvPVbQWmApe9e1YF31fxJJSCsG5RR8KleGT6p5wjjOsFHYNZvsxDzCr/YQkEz
         5NSSa7jYRbJ+0DTizqLuAa/+9JNIhxmh/EltsBgrx3Pp6HjL6kgnkTZVNGUL9F/EMxoM
         gZhGbzz9HvizFIDimIuVfCgzyPPK/pBIQjF1Rf/CMe55CIBdkc62mQ5LJK1t8Y/kxx0A
         o2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740695717; x=1741300517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFM8VWziXs6qPoRm1OGpOhZo/LlHLEag1S842GTC5Ws=;
        b=t4lmDy5SnMgHivFY/g6o6GtQj20uQZYtQglr96d+qv5RSuhD36wyKfOV7TZ7HyVJ/B
         X2Lf+sT4Q390F5W15RmQgpwNRblAWqB09p0V7qJQSDqvKSqs6xeH8ttiiJPopFdWb0pk
         S1J8GB0EvUMpysnzCqFM3vkALll7a1cZe049/sQdwiR0dsI98r5p7qZj2Vt65C2uKUs5
         1hxPx+TyACKHgdJXizt5U1Y0ujBK9pkNwvbw++l8EZOV6b/Tt3Q2iYfl8vXZ1vnmADB+
         thB8YrepsyNdg5/ZjSYAFyIJerA7rpHQlpOKN8bi4Ekuo06LUWmYLs7Hjts5+LPtwqqK
         gc7g==
X-Forwarded-Encrypted: i=1; AJvYcCWVPTypzHuCDtdZF8zsQ8s/8UGFDJvVWV+7UNFHrQO6Du57Evc7sqejPkct0fVyDfB2o+VtemLA7i3WQ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx50UYzMVpanG73gLOjye4lfblqSgU+7BmfrseifUJyVWwv37I7
	11+OXyJ82/gSwAdt/Pf2EfVREVFR2HGCwZDqHgyXAu3jZzxz7vT+zaF8iIjFerIXS2dgvzQy97g
	QkKNuAB8M1ErBd7kxMDN71zu34Fg=
X-Gm-Gg: ASbGncsPSoeRdDM3nAz8HDUpTY8YZCIMhdMhaRphtlAP5Xz9vJT71EXJP9eVxm92e4o
	tsj2c3M0ijQmHJP6fje8ZZ32ejhRQe2w64uAIWFykexYKv8oAxbTHsFuanGAhp4aP7I/XI1EGNG
	zykgvM6958xEd4024kIa+1+tw=
X-Google-Smtp-Source: AGHT+IEKEh9+VP9PxT3Ome4pZ0WRyhZginhvWUAbbhlLQjq1Ic8MRf9Imw9JTqKSE/JzbaFoS6MWQBoZH8PBhIZstDg=
X-Received: by 2002:a05:6214:2683:b0:6e8:97fb:12a9 with SMTP id
 6a1803df08f44-6e8a0d8fb33mr21616166d6.28.1740695717316; Thu, 27 Feb 2025
 14:35:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227001445.1099203-1-nphamcs@gmail.com> <Z7-9o81kBfw4tFSz@google.com>
 <20250227043141.GB110982@cmpxchg.org> <Z7_7vah_U1JzmpCX@google.com>
 <20250227061616.GD110982@cmpxchg.org> <Z8AQPyY7Qpux0mO0@google.com>
 <Z8AUaQamubA9lWae@google.com> <20250227160528.GF110982@cmpxchg.org>
In-Reply-To: <20250227160528.GF110982@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 27 Feb 2025 14:35:04 -0800
X-Gm-Features: AQ5f1JrIyB8NeFMvyRWqGR1j-hVWPQwf0WPDBa5kdP0n3rnMfWnOIWA_Ki6zHH0
Message-ID: <CAKEwX=NsHtTpOV+LSh2GHCMhF9GSKFhyXFNOTifKPk17UiN-ag@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression failure
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:05=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Feb 27, 2025 at 07:29:45AM +0000, Yosry Ahmed wrote:

I like this actually,

> I'd actually rather push those down into zeromap and zswap as well to
> follow that pattern more closely:
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 9b983de351f9..1fb5ce1884bd 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -538,6 +538,7 @@ static bool swap_read_folio_zeromap(struct folio *fol=
io)
>
>         folio_zero_range(folio, 0, folio_size(folio));
>         folio_mark_uptodate(folio);

There should be another folio_unlock() above I think.

> +       folio_unlock(folio);
>         return true;
>  }
>

