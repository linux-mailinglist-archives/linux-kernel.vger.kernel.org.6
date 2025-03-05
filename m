Return-Path: <linux-kernel+bounces-546298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD7DA4F8E6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C93CE7A4F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D464B1F5845;
	Wed,  5 Mar 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaJnrsaT"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9282E3385
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741163718; cv=none; b=l5wsm+ba/lELlZCeET4SiIpPAwpx1NBcDRJGPTO/1P05K/zaFe3XgpIB56cqJlDhlTmt8i0Y71ApvJHj3ILX9f9kqtlcvBsRxktNF1vwmqP6nDlaS9iQf+Y7tRCsvNZCaOWAxpG66lNM2ggaB7E8pNjTRAwNs3OBFoICl5q5ySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741163718; c=relaxed/simple;
	bh=pTqm9220dgrcn0n+OL0BvmV7k0SkCm58CdrYAm9Pd58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euzC8fztiHCQeqFjXIUuPwtenpiGCqngRoBPoRB08VKs5Xl7/JyMNCh0JrrsyIYYGn8eQlRl6opsw8XqSVn2mcxZhA4ItfU805r2GuVuWO6nf9aBjkv5uXrjaNLI+X+bKErZprDadO3tE3rMl2BKRfS6vmbJrWY6gqsXf9TcLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AaJnrsaT; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so5485347a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741163714; x=1741768514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hQTmFT6mApmwuRzRL0A7qIRG9jv/Hs1V82D1ok1SIDM=;
        b=AaJnrsaTMLzJCx4a8HAMDVz4eoxqtggI5UmjxM35xqgM0BOLVNhKxvOLg45GP1eNSu
         RfbxMU/OsxYEJhcj2cG02bjEZkxqrwdp7qh8+N/sbn8MCzGZYvChWAnhaZ/hmjCo9rid
         Uym4suDR7lEVEjPT/pCW5eVd0xoa/gJQfrx74jE+tyepvbuC9dpmIXUPEX0nhrQp0Rxv
         +JaGzKMMyC04fathsc9n62rgVQhDLgyPucvHUroI5LptN3iT4cbpidtd7TjYPHtuPBKE
         1tYKgP7da0wenv92t6rFDtoUCrXzKJi1dWnyn8BNu+gd+uzmsukdr1hTiTdNkVvy3i8j
         ArPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741163714; x=1741768514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQTmFT6mApmwuRzRL0A7qIRG9jv/Hs1V82D1ok1SIDM=;
        b=qLXhwQEZvOmQbm/Ok11BN1GV9RvtD1kZ86ywv1So8kgnHT4RH8oxLXKo3HFOLEY4mx
         haxW6oT8feG5NjCESQwk4n13jrFvaQhXJ0Hjpi9TQkZgpBdqx42TDdjErVzXMWG3LOpp
         APon+luBFBYHGnwQMY1va0d3G7V90bTkJ13eRA1LT4ltK+Z8uL7D6oMdX9oLdeXpFDJT
         fF8jqasUInO80i5uBkpUwTqYslPtRPJ4OLliQrpPvNn/nwBqEIL3LDuLAfu0cqlQIZRs
         mPqyDolCN3HBMsSbY153K1+pxFQ7UDCaVRvkMM8ydib6j1zYagDAMw1PBLwK1OpWxLXa
         8hRw==
X-Forwarded-Encrypted: i=1; AJvYcCVWlu3wouryQRvkzea3bkEO6ok3FjhumIH2scGA5e4Qchwe0OARfoGMyFoepYGbLS3FyBQmldo5SGBFUr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDb4EoBO4Kw98Zt83/XRDb2ffkAtloNCQeJsqeVX6/tbbaXq0k
	1788p7B1tYMEHX/cSfF8KsP96Jj+juIqc4aMr+etc3/aCU3ZP2s9FSjqu+bnBsJms6D0qhD3yoh
	BszaghR21evl3i2QFDX8L06pfsyL6MQjahWe/Kw==
X-Gm-Gg: ASbGncu6NGtjKQnu7RE17jOoGdfhy+VrWD/0HxY34CdS3QaeKnrjdhCrYUOfavsv2lA
	f5O/XuYGCkWcHGCMe3g6cDaS4qULKODc7b5fZLI0/NjrRhRaVlT0bPYzLlWxKjxTvn3cRGJQ5EG
	7E9NjEq0EmurRPhcAwF7uCudaNCPTmWG8g1jwNuPVeKAZ9WEabM6CEzdM=
X-Google-Smtp-Source: AGHT+IEL3AAsnjQfkXQh7NTc9KjW/yVJkq3GC7739pQTQ3oZAl3a2dyh29NrzdAuzEV/+cKWcrip/BXhumn4F/iZ/RI=
X-Received: by 2002:a17:907:3f89:b0:abf:3f82:1218 with SMTP id
 a640c23a62f3a-ac20dd0539fmr234687466b.46.1741163714374; Wed, 05 Mar 2025
 00:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304214031.2882646-1-zecheng@google.com>
In-Reply-To: <20250304214031.2882646-1-zecheng@google.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 5 Mar 2025 09:35:03 +0100
X-Gm-Features: AQ5f1JpVyUNRW1uAMbY6oc7mf-_2EYLYp2LPWSUwwZ5nfZ6HHK18ZR1Rho-ilH4
Message-ID: <CAKfTPtDLtm2Z6PvXSvZ3XcF3PK2Nd6zF2Xei17eXGkgRGc70KQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Fix potential memory corruption in child_cfs_rq_on_list
To: Zecheng Li <zecheng@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 22:40, Zecheng Li <zecheng@google.com> wrote:
>
> child_cfs_rq_on_list attempts to convert a 'prev' pointer to a cfs_rq.
> This 'prev' pointer can originate from struct rq's leaf_cfs_rq_list,
> making the conversion invalid and potentially leading to memory
> corruption. Depending on the relative positions of leaf_cfs_rq_list and
> the task group (tg) pointer within the struct, this can cause a memory
> fault or access garbage data.
>
> The issue arises in list_add_leaf_cfs_rq, where both
> cfs_rq->leaf_cfs_rq_list and rq->leaf_cfs_rq_list are added to the same
> leaf list. Also, rq->tmp_alone_branch can be set to rq->leaf_cfs_rq_list.
>
> This adds a check `if (prev == &rq->leaf_cfs_rq_list)` after the main
> conditional in child_cfs_rq_on_list. This ensures that the container_of
> operation will convert a correct cfs_rq struct.
>
> This check is sufficient because only cfs_rqs on the same CPU are added
> to the list, so verifying the 'prev' pointer against the current rq's list
> head is enough.
>
> Fixes a potential memory corruption issue that due to current struct
> layout might not be manifesting as a crash but could lead to unpredictable
> behavior when the layout changes.

Would be good to add a fix tag
Fixes: fdaba61ef8a2 ("sched/fair: Ensure that the CFS parent is added
after unthrottling")

>
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  kernel/sched/fair.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 857808da23d8..9dafb374d76d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4061,15 +4061,17 @@ static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
>  {
>         struct cfs_rq *prev_cfs_rq;
>         struct list_head *prev;
> +       struct rq *rq = rq_of(cfs_rq);
>
>         if (cfs_rq->on_list) {
>                 prev = cfs_rq->leaf_cfs_rq_list.prev;
>         } else {
> -               struct rq *rq = rq_of(cfs_rq);
> -
>                 prev = rq->tmp_alone_branch;
>         }
>
> +       if (prev == &rq->leaf_cfs_rq_list)
> +               return false;

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>


> +
>         prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
>
>         return (prev_cfs_rq->tg->parent == cfs_rq->tg);
>
> base-commit: 7ab02bd36eb444654183ad6c5b15211ddfa32a8f
> --
> 2.48.1
>

