Return-Path: <linux-kernel+bounces-438179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 063E19E9DDB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53C0E1887640
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5CC15665C;
	Mon,  9 Dec 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GVH/nU5R"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B2C1F5F6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733767705; cv=none; b=eXZEToqTmfY2L8f1UBSzK9MFROKB6zl/pqEhdDZXGbnDiscq5KX8OpYaOw/82tBDD3ebEfXBoTEN3PGuVEC6TDHHT/BCA4Y6DXSZFvaRVD+XyIC+aNlLA9VXjYKmoMcwYFWpiWD+G+NdKBJOpT4elQYmmnG/UCbWke+qRXNdVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733767705; c=relaxed/simple;
	bh=SYlLN9UFX32GCPpq5py62zqO6fENhSvBwYA0y1bxaIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnPlLL5jbNBAv1hKwCFOu7a9HYpDGMvCr/DPHAKDRtZYN2kIc9tmvISnJOP8cE+9L8Po3/aftq9dhZSJXsTwxOdPDi3qTU8uF7uaauSBhWITWi0/hI4mj7+vAhbmg/TvGUnhm1yZsH+d6zE9zFey7d++BfAXmjh4QeozAD0Uw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GVH/nU5R; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434f3d934fcso10287745e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733767700; x=1734372500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=knoMYSdzgasoEigK0YXowWD0Yw43nNqQqbSbAMFId7E=;
        b=GVH/nU5REnMGD2E/n7JvCKf4mJF5WDmUFZXjuTJK8UVWpR3PawJnF6ZvGr16i/4pmx
         tZmRmtO1l2zInuwgODY/vhUWgxS19ts8LB7qGjubcUPtNqKdqw5hg08r9E6sq+don7LK
         XyzvXgJynsp7qPlPKUge6dm1pLueWShKsKjV7Qv0igGG9zWDdjLrEeUANcomMl19fgfH
         u3W8yZdX6WmixptRIJzVE68u95moifgaKC+JeG6IYcnVeXBkerZ3khNNd3BPOrNxlk9K
         7J9uypyOY/ev5GvAfETi0fBnOTCEn+2O/8vit5+XrXWQ5RfybL1N1EVM0Nops+mExJ9B
         /xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733767700; x=1734372500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knoMYSdzgasoEigK0YXowWD0Yw43nNqQqbSbAMFId7E=;
        b=PWDeUcaKtJJNPvFEjb0iLpG4YxJRWsPhm8Mh6jiVHowF0IU0J8Y+yWI7zyF8rfW6Ua
         TPEvSnMXWgtOp+2yxWRena2BNLPu0wPvrW0rggkGgqvavaFC9MjkLoLDjy5Vgn8tIJbY
         COlEWBAM9eNRqvlfIcfosxnrvb8dlDA/m4p58Nce2ONDFzdEa+6LZIQxHGGAtMsQIhZj
         jHiwacUHvCj6wXI3iu3yLHLWntW86HYPobmeTIe5RQ+qZ0XugQOhI5OFkBcOIY51CVr1
         Wp5+PfMVImzFcmS147Sf07jVl9HcGoVBhUhLGuUzMVZM29KUJCpzwVwrtcdqDjmGKcZx
         JYYw==
X-Forwarded-Encrypted: i=1; AJvYcCXEba7Gvq/UHbCXkHzS25jz+NTYqCsW3hbfA9yJc/LTaFduwcw/iffGEUE+dXkOlCHdyqAcasB7Hr1hCFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM55n1VPsXKV4Gb6tCCIhNW1cZ1KHLXM5vbSiMPYCjRgUOjopn
	5PYBPOj3JELGSJcUI5Uies/YQfTqlreYfBWiUsqtbKx5+AsRT+F9AF7O4RLGoGE=
X-Gm-Gg: ASbGncsKjt/ZYd5kdrqm/tiQVG7MCsqp8B0bUqRIrpVyw/6+cR2nsVA9M1G1te5LEna
	NqVQDR+McVCJvwCzQOtComegzIjIpWQlx24i9ue8Wj0T1RUU375nkSWzq0028oni6OnpKPR8wju
	jvJIQRj1mDJi+Nn+oMF9FJmJHu5wmGSB0Mk/5HkDMKQ+CNqPydEeJOHg6JZ680h4HBZKLrSL46g
	al8IkeWT6B77BsRhlded4vb5iSKDnR1sC6C7i88tz4yv3l9Ncmzq7nHYN/8IDw=
X-Google-Smtp-Source: AGHT+IHCTcISOZZqgK7Gjuef8mOP8E5E5f9tc/AxJWU+swbLtQRVrk59K5349YN57JJQmurGW/4aHg==
X-Received: by 2002:a05:600c:3b99:b0:431:44fe:fd9a with SMTP id 5b1f17b1804b1-434fff98d7fmr14829555e9.19.1733767700211;
        Mon, 09 Dec 2024 10:08:20 -0800 (PST)
Received: from localhost (109-81-86-131.rct.o2.cz. [109.81.86.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f123da83sm80119745e9.29.2024.12.09.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 10:08:19 -0800 (PST)
Date: Mon, 9 Dec 2024 19:08:19 +0100
From: Michal Hocko <mhocko@suse.com>
To: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: allow exiting processes to exceed the memory.max
 limit
Message-ID: <Z1cyExTkg3OoaJy5@tiehlicka>
References: <20241209124233.3543f237@fangorn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209124233.3543f237@fangorn>

On Mon 09-12-24 12:42:33, Rik van Riel wrote:
> It is possible for programs to get stuck in exit, when their
> memcg is at or above the memory.max limit, and things like
> the do_futex() call from mm_release() need to page memory in.
> 
> This can hang forever, but it really doesn't have to.

Are you sure this is really happening?

> 
> The amount of memory that the exit path will page into memory
> should be relatively small, and letting exit proceed faster
> will free up memory faster.
> 
> Allow PF_EXITING tasks to bypass the cgroup memory.max limit
> the same way PF_MEMALLOC already does.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> ---
>  mm/memcontrol.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..d1abef1138ff 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2218,11 +2218,12 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	/*
>  	 * Prevent unbounded recursion when reclaim operations need to
> -	 * allocate memory. This might exceed the limits temporarily,
> -	 * but we prefer facilitating memory reclaim and getting back
> -	 * under the limit over triggering OOM kills in these cases.
> +	 * allocate memory, or the process is exiting. This might exceed
> +	 * the limits temporarily, but we prefer facilitating memory reclaim
> +	 * and getting back under the limit over triggering OOM kills in
> +	 * these cases.
>  	 */
> -	if (unlikely(current->flags & PF_MEMALLOC))
> +	if (unlikely(current->flags & (PF_MEMALLOC | PF_EXITING)))
>  		goto force;

We already have task_is_dying() bail out. Why is that insufficient?
It is currently hitting when the oom situation is triggered while your
patch is triggering this much earlier. We used to do that in the past
but this got changed by a4ebf1b6ca1e ("memcg: prohibit unconditional
exceeding the limit of dying tasks"). I believe the situation in vmalloc
has changed since then but I suspect the fundamental problem that the
amount of memory dying tasks could allocate a lot of memory stays.

There is still this
:     It has been observed that it is not really hard to trigger these
:     bypasses and cause global OOM situation.
that really needs to be re-evaluated.
-- 
Michal Hocko
SUSE Labs

