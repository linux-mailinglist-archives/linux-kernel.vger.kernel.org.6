Return-Path: <linux-kernel+bounces-171728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237608BE7D8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E39F1F2937A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8CA168AEB;
	Tue,  7 May 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEF2GMcW"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F499161327
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715097282; cv=none; b=WUMIQ7ASla28gGczWIGmLh9TyPSdLPDMeG0BZl3I6v1mq0CPlE7TtkyIqNZKOXVEc4lwlb2l/+lrvoei/XqDssGhPccendSoQSmyELwSw6WU61VSZ59qvCB+PDmiDP9gTQVrRWa4uvkOnrfrwP/ntrRfKJC/VMrdyCF+rrw7mFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715097282; c=relaxed/simple;
	bh=aBJBQLQUjfT7PWQGJ5g0Hkb16T+DG7DAQh4PmBiCF2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5fNzszKMBMF9Ggf0msgcdiADAqHSz4lSVYiygUIDi9W6f6IUaUxe8D/T4J739Vtf+HC7W3PZL9UIHsj+as6LBM2ukV01FhLb/MumAAneC2+kug8spnMzBsd2/wkuY41LuDPJcJGjLur0CWWGdhV/wTrkF5biK2OfV25KSADDxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEF2GMcW; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a599af16934so831822566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 08:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715097279; x=1715702079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+//lctqNApZOsedm3CHZikHUh063xmeaaMM6XmCk0O8=;
        b=BEF2GMcWj932ti2szi19iUpOUZd1/Lig71u2jVPieWqc2wO5T08uqywcm9oW2cBua4
         OaSgXatQLMWbDLa0+HWUIwq88d9uWGvtqSGsFDL8qXwuSXGMviEINxjaEtcwcM/Ztbyx
         5LBFUFLxq7W64DPQTRzfDk7OfbpE407b5tG6p8L3a0jYoNZ7Ya30XhaOC3ubPE4yaCdu
         TFi9K8CvOPLBgODzhBTLYbxR3hVCwWAuLRfti0GpXmRX5HkRnsq9nNptYggtx/dUqIVN
         huyd78joXEP+7eq8T3oLyffsWfhL/FUT8meRni8FF/1R/A9UvnaRPbNQAW5CwqSNNuaf
         733w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715097279; x=1715702079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+//lctqNApZOsedm3CHZikHUh063xmeaaMM6XmCk0O8=;
        b=MtDHoEEUwSx5oLvJfH777QXTgpZljCoxnU5dxsbkBWNjCVmQ6grGsOLuLL6m54hYMp
         Sd9rbQb300c9nVUpHHWolBixPUJsRlpFog16npXHGhGJoQW+wUP8mY9kBw8ZeSkZPxwj
         WAarHxWQm5/lFtMIhuDQS40KPDaPCA6Os70jPE72zRBrHV/wsgFzoGwID88bcMhAvMQe
         noe/vtwX6iko0N9Us0j26DhIoSVQcRVS9PtaFy8thQ1LFTbgF1TmTNo0ReYpg4T6LW2w
         Y6z3wLn7MnmbRYS21JzAoIR7Ei+5VblJRlKx2p2w+I3xWirwiUYF2nTZVlmtNBF4e6s0
         k0Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVdH1eWDaL073WLb4P9V5hXbFh3zHiwBAy/jnGA1PJzoifVBYcIRHtz2fAb5msFCWsQe1S6SZ2wL0SwBUhb0G3+0m2u9eCm+mjXTcyc
X-Gm-Message-State: AOJu0Ywl1SZexgoNBTi1bnEOaoFYiun47TX7Id7LaBKdeW/obmQ0BJhf
	OUmGeTCs7Bsd/BAEO5zESnx3K3fKwz/YI+aJG5wl4UgAwHgp4ZM3nG1tcfF4HJZj3aU2OlgIRzY
	+B6Q6JWNZu6cQe5ZRB5ptXrgyf7Qy15XlpbbV2HMgrRA4fdXkrv9AqFg=
X-Google-Smtp-Source: AGHT+IFxN2iMkSNNChJnnCrpQyYGZeo+zP3RyqjYIB5+hyDPmeiBMPxXA+yp70ayfL9q+R57TS3RzGHxOJgdbXrGQCQ=
X-Received: by 2002:a17:906:1d0e:b0:a59:c28a:7eb6 with SMTP id
 n14-20020a1709061d0e00b00a59c28a7eb6mr4883867ejh.24.1715097279321; Tue, 07
 May 2024 08:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506211333.346605-1-yosryahmed@google.com> <1a408ed1-7e81-457e-a205-db274b4d6b78@redhat.com>
In-Reply-To: <1a408ed1-7e81-457e-a205-db274b4d6b78@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 7 May 2024 08:54:01 -0700
Message-ID: <CAJD7tkam8BvLvOrw_FfgZ8XOsfdu-Hv2oCv_s+LAMcGvd44hTA@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm: rmap: abstract updating per-node and
 per-memcg stats
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 1:52=E2=80=AFAM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 06.05.24 23:13, Yosry Ahmed wrote:
> > A lot of intricacies go into updating the stats when adding or removing
> > mappings: which stat index to use and which function. Abstract this awa=
y
> > into a new static helper in rmap.c, __folio_mod_stat().
> >
> > This adds an unnecessary call to folio_test_anon() in
> > __folio_add_anon_rmap() and __folio_add_file_rmap(). However, the folio
> > struct should already be in the cache at this point, so it shouldn't
> > cause any noticeable overhead.
>
> Depending on the inlining, we might have more branches that could be avoi=
ded
> (especially in folio_add_new_anon_rmap()).
>
> [the rmap code is more performance-sensitive and relevant than you might =
think]

I thought about making the helper __always_inline. Would that be better?

>
> >
> > No functional change intended.
> >
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > ---
> >
> > This applies on top of "mm: do not update memcg stats for
> > NR_{FILE/SHMEM}_PMDMAPPED":
> > https://lore.kernel.org/lkml/20240506192924.271999-1-yosryahmed@google.=
com/
> >
> > David, I was on the fence about adding a Suggested-by here. You did
> > suggest adding a helper, but the one with the extra folio_test_anon()
> > was my idea and I didn't want to blame it on you. So I'll leave this up
> > to you :)
>
> :) fair enough! It's a clear improvement to readability.
>
> [...]
> >
> > -     if (nr_pmdmapped) {
> > -             /* NR_{FILE/SHMEM}_PMDMAPPED are not maintained per-memcg=
 */
> > -             if (folio_test_anon(folio))
> > -                     __lruvec_stat_mod_folio(folio, NR_ANON_THPS, -nr_=
pmdmapped);
> > -             else
> > -                     __mod_node_page_state(pgdat,
> > -                                     folio_test_swapbacked(folio) ?
> > -                                     NR_SHMEM_PMDMAPPED : NR_FILE_PMDM=
APPED,
> > -                                     -nr_pmdmapped);
> > -     }
> >       if (nr) {
> > -             idx =3D folio_test_anon(folio) ? NR_ANON_MAPPED : NR_FILE=
_MAPPED;
> > -             __lruvec_stat_mod_folio(folio, idx, -nr);
> > -
>
>
> We can now even do:
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 9ed995da4709..7a147195e512 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1555,18 +1555,17 @@ static __always_inline void __folio_remove_rmap(s=
truct folio *folio,
>                  break;
>          }
>
> -       if (nr) {
> -               /*
> -                * Queue anon large folio for deferred split if at least =
one
> -                * page of the folio is unmapped and at least one page
> -                * is still mapped.
> -                *
> -                * Check partially_mapped first to ensure it is a large f=
olio.
> -                */
> -               if (folio_test_anon(folio) && partially_mapped &&
> -                   list_empty(&folio->_deferred_list))
> -                       deferred_split_folio(folio);
> -       }
> +       /*
> +        * Queue anon large folio for deferred split if at least one
> +        * page of the folio is unmapped and at least one page
> +        * is still mapped.
> +        *
> +        * Check partially_mapped first to ensure it is a large folio.
> +        */
> +       if (folio_test_anon(folio) && partially_mapped &&
> +           list_empty(&folio->_deferred_list))
> +               deferred_split_folio(folio);
> +

Dumb question: why is it okay to remove the 'if (nr)' condition here?
It seems to me by looking at the code in case RMAP_LEVEL_PMD that it
is possible for partially_mapped to be true while nr =3D=3D 0.

Is this practically impossible for some reason, or is adding the folio
to the deferred split queue okay either way?

>          __folio_mod_stat(folio, nr, nr_pmdmapped);
>
>          /*
>
>
> Which will help some of my upcoming patches.
>
> Feel free to include that in a v2, otherwise I'll include it in an upcomi=
ng
> patch series.
>
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

