Return-Path: <linux-kernel+bounces-211009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE030904BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26FD283A16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 06:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4854D16B74A;
	Wed, 12 Jun 2024 06:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TsWZxgy1"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30AB13C9DC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175197; cv=none; b=WEvy9vB24wQL4y3uTUh3dod02soXFZLJ8zWxz3122FmobftN45sST+NJF92x0AB72ZvVtUVZGUHyu75OMksJfqNF/s/Lof8GvgtPiAjvCSLzazG1QJCoUkxvq1iTKM1oEzBMBvwn5Jh2fazPJ8epvi0ItaTGrQDN1DFtnHOUcYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175197; c=relaxed/simple;
	bh=eVsnbk3vODZ9GEfnQrJWZQ2XQUcBCC7/19+8gYFNuPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3KLcgrZ0Dw8YTd+WUEKL1tUJfyUZV/YKhSVLJ6z+8Z+MVLbu/N+wXdTzFDtawCrTeYThzD6zPzYKOk2d5DAUnBA10pLPKPGRJXBBPRL9mSuiJu5x4TTveVBR45kkrLDZ7gMFgckoINT6aHQwCaAFcmcr0Z6TJEfg7+GL+2J/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TsWZxgy1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a6f1da33826so254246366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718175194; x=1718779994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmnYbKCYy71ljFO/mUSsSDpLkrZDTOZpbwT5Mhb2Clg=;
        b=TsWZxgy1QxkTNPeWTxg/bK+MVMahXeFIw1FZ7NTe1pLEDCTrexWvW2fisD/2r2gFuD
         CCDY2Y1TXIC+3F419/ItiiKAWR6eNhIrPTgJZzwk5V2nSy+3HHi3Tnv2xagxJM7c65lV
         3yhD9f6cBMbrZhdmvgVJBQOhdMSq53GB59O4KFQ6hea4sHYsQMdlJxaYX0n5PMgDZXMK
         jictl/hMP9/EslKdnOSsoY1WwNch8XXc9/DvTWAQ3t31+Ch3QAUgpMcIufourWt2LaxA
         MTHA+EXGnVCoEqRaqw8Jwz21ks1OFnNp2/zL/CxSvPHYqfdhLxyLDg6VQx2/Vqg6kJuK
         gsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718175194; x=1718779994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmnYbKCYy71ljFO/mUSsSDpLkrZDTOZpbwT5Mhb2Clg=;
        b=QiDmBGLoD3/VfYAblDmtqqxXYLXawGwQZs5JxwsCceZ3p6v6BQ3Wa7VtwoUALVe7yn
         rQB01Vcuo9XKgxDt7Khbs3gOR0EjAW2iEA2cKyqqvedrzGgWvhHQaSr3LoswpPy0sKyd
         nCbpa0hROY7ew2YCyGp/xWhIw1U95HPXjUdNHY34gsuFJAllDT4vxCdsex3Elqih8PO1
         2p9iLPgvpX5mVAH0imlVenuIzyoAGJzFcfdZXWT+h4Yr96dUAvn9QdR60+tn7oqGB56W
         8UDMBM2Dz/BYEDNZ3+LB4ERQEcxs/wuCOFf+QNBRrooHJOqPTZ1Vtqwx5q6HKHWcEi4y
         Dy1w==
X-Forwarded-Encrypted: i=1; AJvYcCX0tFVAsIXl2LyPRByCS+QpDfwfdfVRfGoCSvusEdjH24RuxompteNIT8hZlLr/0yMY2r8R1fRvSXpPpOLOBKQn+hf73klkEdwmKZac
X-Gm-Message-State: AOJu0YzBCBAMXW/JGSkRTVlNUUFU7Cy71jbHQ8pV0iPc+KuCNfNvJJI2
	Au4N7AEZnAKVR2LBIg9e6nLlo7F0YYr39Lfl4VUHJINNC4VIAcNYo1qJk/ZBJm4o7d828dGAV3g
	W2d3O0rt4jEIT9uUkXzjikX44fdnBgkYu9h4Y
X-Google-Smtp-Source: AGHT+IEPNM7hqNNuA4wqNEKCQ1azATv5uLGXKGCah993/BTMvOLHlOw2ruKIWAHxB1JAYdurYPKY+L5QptThob//SA4=
X-Received: by 2002:a17:906:7c06:b0:a6e:f6b0:c4a9 with SMTP id
 a640c23a62f3a-a6f47d4ec35mr77459166b.9.1718175193964; Tue, 11 Jun 2024
 23:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49914517-dfc7-e784-fde0-0e08fafbecc2@google.com>
In-Reply-To: <49914517-dfc7-e784-fde0-0e08fafbecc2@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 23:52:37 -0700
Message-ID: <CAJD7tkYg1beWy7g-5iyxwHOyeUw43MO6Yvnqr+ZqSsnQRRJ-SQ@mail.gmail.com>
Subject: Re: [PATCH unstable] mm: rmap: abstract updating per-node and
 per-memcg stats fix
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 10:10=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> /proc/meminfo is showing ridiculously large numbers on some lines:
> __folio_remove_rmap()'s __folio_mod_stat() should be subtracting!
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Thanks a lot for fixing this! I was just looking at a test failure
report by the kernel robot caused by this [1].

Just to document my own stupidity here:

1. In [2], I sent a fix to use  __mod_node_page_state() instead of
__lruvec_stat_mod_folio() in __folio_remove_rmap(). I made the same
mistake of replacing subtraction with addition.

2. In [3], I sent a v2 of that fix that kept the subtraction in
__folio_remove_rmap() correctly.

3. In [4], I sent a cleanup on top of the fix, and that cleanup
replaced the subtraction in __folio_remove_rmap() with an addition,
again.

Apparently, I just suck at subtraction :)

[1]https://lore.kernel.org/linux-mm/202406121026.579593f2-oliver.sang@intel=
.com/
[2]https://lore.kernel.org/lkml/20240506170024.202111-1-yosryahmed@google.c=
om/
[3]https://lore.kernel.org/lkml/20240506192924.271999-1-yosryahmed@google.c=
om/
[4]https://lore.kernel.org/lkml/20240506211333.346605-1-yosryahmed@google.c=
om/

> ---
> A fix for folding into mm-unstable, not needed for 6.10-rc.
>
>  mm/rmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1567,7 +1567,7 @@ static __always_inline void __folio_remove_rmap(str=
uct folio *folio,
>                     list_empty(&folio->_deferred_list))
>                         deferred_split_folio(folio);
>         }
> -       __folio_mod_stat(folio, nr, nr_pmdmapped);
> +       __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>
>         /*
>          * It would be tidy to reset folio_test_anon mapping when fully
> --
> 2.35.3
>

