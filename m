Return-Path: <linux-kernel+bounces-331320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FF697AB41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 08:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B3B8B28D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 06:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64294D8CB;
	Tue, 17 Sep 2024 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="G7rAXiMT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B064778E
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 06:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726553114; cv=none; b=AFbMwGwwhnqEfMke9guM6zqEo/LWHI+qHAouT1CoO92lTJmJ1WQgXs9h6V3xGPyFQm8HeQx7UGqF0bU+dY7bdjzUOJ27vPOLIX9dvqhWCjwcXGh8/2hWm/E+OpBn4Y5fVvbzAbmfYr/envo0egKI7FRajIVRgh2AV3FLeBSdMB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726553114; c=relaxed/simple;
	bh=i6VfCIU+UDMyljEhAjvUnnMMjVD3LmvgW+qc/y486Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KZ7RvYpn46LKDl5r8/vC/nSOFOvpFjw36mUI4ThCJHLGPOWYol1jl/LO/K1BpINa1E9UMSJoLjeGnfl4fAgVzgxry/tth+tPQ7wMxvwagWt6h1swXpe0OyQ+0I0zsloL3lJb5YIUdkkNI16v4jw3ZEpyYDbzE1IPnIX7qFd92LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=G7rAXiMT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cae102702so32956875e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1726553110; x=1727157910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IAqEXr9dsx/GFARHKZ+CSfu6ynKeAlvuTAEqE2pmJ5s=;
        b=G7rAXiMToZRpHAKdy3r80682Z6yxiQpf5qMZmQLazy4m5lGdDzX+Bngi1BYf91ui+x
         w0ELnfz0dLkK4OFOiOKMbUdi//kvu5WN4AhjBZbzs6jEL9BmNHrRMME18mHHIaHlqu6r
         IkHyq7bvX/qFwgORHAxSRXKV7Njud0r5gH7ZJwRQyYmZZ5G7QukKKV5KjdpawiTJKpZF
         bVrkcQjPp/r+cLJCLn4RclSHVYHywExWzKwXOsuINTyJmaEGGkICZdKS9dltmOcCucIq
         EAI3eo4dHJ6ZSjLK1Q1LA9ytTtpqMLX/np7QUThgk14VlrifJcflxQv2oR9irwJ9S0/Q
         M1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726553110; x=1727157910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAqEXr9dsx/GFARHKZ+CSfu6ynKeAlvuTAEqE2pmJ5s=;
        b=jsZF+VsJY/Na3ubyoXi5w9zOWT9KAHBJrzjoQem7emHB+zapvt++dc1AmzXC3JJqY8
         7+abKjbKdQ94H5UaLFOR1Y4zJkbxzLoiro6IZW9MLJtJ5sZfgldvpsobM5Y0Y+mp3UxC
         oVL0ilqzEz7OzlzljVs2JKWZzTlK9dGN03JUrWs21PQe1o+JL2xfogGYm6XpUu9atvJL
         DXSlZAh9IqX/UVrGTVhVCaaAf5EJFIB/6PTkbGQ+EpNtJozK+tY2+L1xzd90bzp9gTVH
         swEFfafwDcSKm9bBCz4T/Ik47k+enWbSpalCIanG3ivFNHNRY6Ba9jw+ArGYEfM07FAM
         kR4w==
X-Gm-Message-State: AOJu0YynJvxQuXEcN9fkJXAj6AIyGtnaUU4k4s6i728FheXqhEy6TbgY
	5FaLmN6l3cAJzpj1Bami9rPvYdvLhzAi6vcG+kUk3VC73nNfp9AJVhotJC5PdUA=
X-Google-Smtp-Source: AGHT+IHWktBmb6JyxkK3Y8xMasoWNsJW/k8Kak+KevSump0oJf2owVsn0eMLrPm7k+dYafLzUSmICw==
X-Received: by 2002:a05:600c:35ca:b0:425:5ec3:570b with SMTP id 5b1f17b1804b1-42d964e186amr78086315e9.35.1726553110371;
        Mon, 16 Sep 2024 23:05:10 -0700 (PDT)
Received: from localhost (109-81-84-13.rct.o2.cz. [109.81.84.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f0699sm8622412f8f.15.2024.09.16.23.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 23:05:10 -0700 (PDT)
Date: Tue, 17 Sep 2024 08:05:09 +0200
From: Michal Hocko <mhocko@suse.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 14/19] mm: Create/affine kswapd to its preferred node
Message-ID: <ZukcFS8aFLrUzH7b@tiehlicka>
References: <20240916224925.20540-1-frederic@kernel.org>
 <20240916224925.20540-15-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240916224925.20540-15-frederic@kernel.org>

On Tue 17-09-24 00:49:18, Frederic Weisbecker wrote:
> kswapd is dedicated to a specific node. As such it wants to be
> preferrably affine to it, memory and CPUs-wise.
> 
> Use the proper kthread API to achieve that. As a bonus it takes care of
> CPU-hotplug events and CPU-isolation on its behalf.
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd489c1af228..00a7f1e92447 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -7139,10 +7139,6 @@ static int kswapd(void *p)
>  	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
>  	pg_data_t *pgdat = (pg_data_t *)p;
>  	struct task_struct *tsk = current;
> -	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> -
> -	if (!cpumask_empty(cpumask))
> -		set_cpus_allowed_ptr(tsk, cpumask);
>  
>  	/*
>  	 * Tell the memory management that we're a "memory allocator",
> @@ -7311,13 +7307,15 @@ void __meminit kswapd_run(int nid)
>  
>  	pgdat_kswapd_lock(pgdat);
>  	if (!pgdat->kswapd) {
> -		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d", nid);
> +		pgdat->kswapd = kthread_create_on_node(kswapd, pgdat, nid, "kswapd%d", nid);
>  		if (IS_ERR(pgdat->kswapd)) {
>  			/* failure at boot is fatal */
>  			pr_err("Failed to start kswapd on node %d，ret=%ld\n",
>  				   nid, PTR_ERR(pgdat->kswapd));
>  			BUG_ON(system_state < SYSTEM_RUNNING);
>  			pgdat->kswapd = NULL;
> +		} else {
> +			wake_up_process(pgdat->kswapd);
>  		}
>  	}
>  	pgdat_kswapd_unlock(pgdat);
> -- 
> 2.46.0

-- 
Michal Hocko
SUSE Labs

