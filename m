Return-Path: <linux-kernel+bounces-283651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FD994F757
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4AF1F21604
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0957A1922D8;
	Mon, 12 Aug 2024 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQDOpMWY"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85DBC156
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 19:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723489905; cv=none; b=BPvpqUNG/NWK5HJbtYIN/gi/mjOd2vYLm8JytE1G23Pf+6tNhkbH5MEYkV2t5EbOdqmCdBchskGkF15gdkREKk97K8U9uKZMEgeyylyPPOiUTotqMyfQpPODRvj8YvG55QLrPv6hwv3MynYX1cVItb6XMh9xWxCj4wv79pKG7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723489905; c=relaxed/simple;
	bh=7JQ42aZmHXGbc0D18fOwc3DN318cJ7h83r/OxEldFwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+az55xa2F3c91+BIW5KgFrRCt5nm2t6ersOZAVGvLAGUDQHZc0l43uLRNp/oRGVeg40DWaDBX3PYOBjE1Au9ikZQTRVxIZqQCfVHCFO6V/FYid6JgHmtEF41j0hQElnOResa2tdOJoJiozzxsHYMMd78fjBpUnytDf9iabkknA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQDOpMWY; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7094468d392so2723271a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723489903; x=1724094703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddp64rJgdO0xjary+ehUrD62neWvl3gWUy4flarg04k=;
        b=DQDOpMWY+Nba99EECimd6qqtCb27iE8NAYEi0/dzmIQ3eHR8wjEOYwz9UUWO6yf82E
         +os74Q5WKrJE9stgjRUVZI5K5HxXPleXLvKk+Pu4bsB2QJeBjph6R3WndXFE/YWZ8TQG
         ZWDQv2zGeYCaREx5Z8Q3xJ837IJnSJE+wbpCrqQCXbJ58eGcMVqtNrSQ1ghjE46vU2Sl
         eOEw1V/392e8o4Fb+fss5LWHWCClTo0Rugz2nLRsAbdDWiFf2E2E60VMRUvK3IhmcEKJ
         OM5ORmydNyeELRJ8AGgjO3Sd9pjv1ehCOt7b+wTqxdKZYTsXZIHNMBTDi8a21ZeGp49l
         Joag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723489903; x=1724094703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddp64rJgdO0xjary+ehUrD62neWvl3gWUy4flarg04k=;
        b=tL1mioNvq4Tzi1GjhedCp3xfINrnqFgujr/FGT19OnqtVWaswT7q0P8N8CpEcl3yaO
         1/mo7SymxQMDKWiIgZfkoBuymiWBAy/ZCv2czEgdKMDlkveuJ+tVGoPTtzw2Kesm7bpG
         5W+rFZ36EE5JR+bw7BaFCx0jMcws8ZEvxrEIl9XPpVsy8BqIbucYHH1Z2uDGaWzAyWiA
         /gKqy2fNOKxOeQ9F5ARKKhQ3ot+lQmtjeKhWXK/bIfUoaQEiuATJPO90yeXQnSLik84o
         uqYs2nWAveA361L0YM3zMcm4BVxg2Fa2ZKW0MAx7UJ7YuXGi2Zrfyi9h2KRSn/+KIn0z
         fQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCWWMLtk0ycldaswBOhXmQvLYAlHGi4tSO2OoDWrRRq+UaQQ8nMSvfjPnOMH4nb4IlWl+Yn3jSnir3ohJQwdn1OiosO1QtaYgctlaYdN
X-Gm-Message-State: AOJu0YxIhUZMxXcdcweJVM/WmZ7J+VOF+7jWcsPRS17eD/Y0LM9e3waU
	E7YHaS62KxEVVfy/w2uWph0WQsZJCH+13r+GBJm6Al9nwF0W8sIUKdiAUnwoNmtOFB0kX+5ETxz
	XEO273d65TSFIjG9QUkGLfzPc+BY4ikp2kb26
X-Google-Smtp-Source: AGHT+IHsMOZHQZxd786VilZxK1OHo7ieE7rCGuIWR72I+ELe8SNSwsiuREiwh69sSoCiDqaY/lP7ALuUKioYndTrYBc=
X-Received: by 2002:a05:6830:4111:b0:703:6aa3:d091 with SMTP id
 46e09a7af769-70c9386796fmr1551866a34.2.1723489902608; Mon, 12 Aug 2024
 12:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812184455.86580-1-surenb@google.com>
In-Reply-To: <20240812184455.86580-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 12 Aug 2024 12:11:29 -0700
Message-ID: <CAJuCfpFFEa43D2qMkO_DpscYSAjKrvPo7b3hFMtxDrDAmo=fmg@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark pages reserved during CMA activation
 as not tagged
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 11:44=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> During CMA activation, pages in CMA area are prepared and then freed
> without being allocated. This triggers warnings when memory allocation
> debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
> by marking these pages not tagged before freeing them.

This should also have:

Fixes: d224eb0287fb "codetag: debug: mark codetags for reserved pages as em=
pty"

>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mm_init.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 75c3bd42799b..ec9324653ad9 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct pag=
e *page)
>
>         set_pageblock_migratetype(page, MIGRATE_CMA);
>         set_page_refcounted(page);
> +
> +       /* pages were reserved and not allocated */
> +       if (mem_alloc_profiling_enabled()) {
> +               union codetag_ref *ref =3D get_page_tag_ref(page);
> +
> +               if (ref) {
> +                       set_codetag_empty(ref);
> +                       put_page_tag_ref(ref);
> +               }
> +       }
>         __free_pages(page, pageblock_order);
>
>         adjust_managed_page_count(page, pageblock_nr_pages);
>
> base-commit: d74da846046aeec9333e802f5918bd3261fb5509
> --
> 2.46.0.76.ge559c4bf1a-goog
>

