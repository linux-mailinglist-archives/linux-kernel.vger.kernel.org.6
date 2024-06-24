Return-Path: <linux-kernel+bounces-227153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5373914922
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBF1F23FDF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CF813B297;
	Mon, 24 Jun 2024 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NA8ioZeE"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8719913AA45
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719229737; cv=none; b=nhtIgg7huDM9ajseV9PUNb4+z6S7kG0zims0CE4czNUYC1FllZkSN5bEJ3yOr+lJPAUpHrDgLp7GkQJcFilNg/YrEOeX2KAMiKX8lHA92hAqQiuveSjd9ky6hdEXUnhzSi7TXz08ZsK75zyaWv+bAoUPxcvvnHYk2D4M4bcHIS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719229737; c=relaxed/simple;
	bh=Kfg4RCoqE/Gmgj+Mjk3cRp2x3PjuDZdoVdLL/Pphyhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUUiyKvXG/Ayal03dNG0A/vDXNl6cG50bZQ3cDbhP6cAJUmIfyhQLXj8Z1XDpnj6A0tvsy1VdZpJTua5hH+Edswc+N5OqVPHazfxcaqkh5Sj/eLz6HCaGyd40k8eM5yEqKt5Ki2E4gRD3+cHWEt7Uui6/gaWFPakFsr4A6UuweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NA8ioZeE; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a72604c8c5bso46507566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719229734; x=1719834534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30fzgwULvXEqLioqFM6R9Hs9Qm8PujYdd5yXvrzn+gk=;
        b=NA8ioZeEhFlX1opkFxXfcbYq+rk4UcbQU5w8TNvFuwRS/KnyK7GXtS/600QnkY8rOh
         UmJcL6WZtOAi21PuzeOlwPpGeZ2qGdyg8Udf18ov7VDkeCzNQjeUxX8qVa9JRRTf9WHB
         lVtnrtgkCuEqAeXPHHATlRDeEVYm7///O66pHlAFxF4GJam4/6zZYrYvuCl/gDHT1sd9
         oKAVy3E7IRC/NxpwkbaXiwveBx54Rlk+gVboLizI5fdFSFTAr6NHQn46w1APeCM4yS4o
         rqbkBhv+kA3/0VcBBcsQ5RX3qyyLN9bw/Bo93Q3xnKLQAaeUUCY7DfwYeQQ30V/wyoEV
         fblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719229734; x=1719834534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30fzgwULvXEqLioqFM6R9Hs9Qm8PujYdd5yXvrzn+gk=;
        b=wsSQVVhbOo9avKH2/N9kqq3IpcV13FF9Ym9AA2DhhWeCP5QxGJYuAtcph2XLyRwZhN
         pcR1nnmYlDSYrddB7d0F7diVjDrma7Y6qkM6XYOxSLFvc1qiGf3R9nq/4nVPaU/OLvMQ
         Z7R2CO6RpnmmjCK49U+oSpDVxqvlc/eh94fCwTFjXHc/nBHzJ33/CGaUeL/SGg/Odi1v
         1M0qBF5MlIF3nVy4esyv8889kaqVLybDF6K79rQNqolu/AgjkdPgM/3WT1+7N0G8T0Uq
         D2i4Y8mr/Gs6pELN1UTVDqPmnbYT2fUeNw++okQLiEbGMDV3jrQY24t2bIuIN8LDSNGE
         Bsbw==
X-Gm-Message-State: AOJu0YwHR4idarGj/5epgFlAhbinqWo/ZdstUUn+grA1CyNXYC67jq2M
	eOnPfeaVzd3fEX/Jb7wa7lzwktb1JRrfzThMTeLpdtlzW9Nrcf/5h+Ev/+Ag0LWMBxZjLuRdlB9
	0tSiv6X8FWp/2nSTse9DlkgMSlc6KYkvXTPqmPX2mfgXbw2f+BGmpEI8=
X-Google-Smtp-Source: AGHT+IEXVn5tQ4BJGMDOndRlQGYJbVGz0+NoEyzZxIM4ouUg/O3z7/UIBizKdZ4kOjul7xIf0RII7O6Qj0mWDfXU+X0=
X-Received: by 2002:a17:907:a584:b0:a6f:b3bb:9249 with SMTP id
 a640c23a62f3a-a7245b564famr290593566b.22.1719229733273; Mon, 24 Jun 2024
 04:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618151026.521019-1-david@redhat.com>
In-Reply-To: <20240618151026.521019-1-david@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 04:48:17 -0700
Message-ID: <CAJD7tkax7gJdLAMUZ=x7bmDievcLv-w_ridqpTZxC4R-tsAoiw@mail.gmail.com>
Subject: Re: [PATCH v1] mm/rmap: cleanup partially-mapped handling in __folio_remove_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 8:10=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Let's simplify and reduce code indentation. In the RMAP_LEVEL_PTE case, w=
e
> already check for nr when computing partially_mapped.
>
> For RMAP_LEVEL_PMD, it's a bit more confusing. Likely, we don't need the
> "nr" check, but we could have "nr < nr_pmdmapped" also if we stumbled
> into the "/* Raced ahead of another remove and an add? */" case. So
> let's simply move the nr check in there.
>
> Note that partially_mapped is always false for small folios.
>
> No functional change intended.
>
> Cc: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Makes sense to me. FWIW:

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/rmap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index afec4b6800caf..aa900e46cdf82 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1551,11 +1551,12 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
>                         }
>                 }
>
> -               partially_mapped =3D nr < nr_pmdmapped;
> +               partially_mapped =3D nr && nr < nr_pmdmapped;
>                 break;
>         }
>
> -       if (nr) {
> +       if (partially_mapped && folio_test_anon(folio) &&
> +           list_empty(&folio->_deferred_list))
>                 /*
>                  * Queue anon large folio for deferred split if at least =
one
>                  * page of the folio is unmapped and at least one page
> @@ -1563,10 +1564,7 @@ static __always_inline void __folio_remove_rmap(st=
ruct folio *folio,
>                  *
>                  * Check partially_mapped first to ensure it is a large f=
olio.
>                  */
> -               if (folio_test_anon(folio) && partially_mapped &&
> -                   list_empty(&folio->_deferred_list))
> -                       deferred_split_folio(folio);
> -       }
> +               deferred_split_folio(folio);

FWIW, I prefer moving the comment out of the one-line if block as you
originally suggested in [1].

[1]https://lore.kernel.org/lkml/1a408ed1-7e81-457e-a205-db274b4d6b78@redhat=
.com/

>         __folio_mod_stat(folio, -nr, -nr_pmdmapped);
>
>         /*
> --
> 2.45.2
>

