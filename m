Return-Path: <linux-kernel+bounces-221068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385590EB6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D36286E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D92143877;
	Wed, 19 Jun 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WkBcJoXS"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178C1FC1F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801377; cv=none; b=jZit+CnO33Q7fz6mPyvQXwjUwXrTb3H0aVGqPfE8gA+b0oLh/VTLM7CaD4CY7fK45STvRSztaXYTodEBlLP9EFDpcIqjDZf+98Jt/QUaDMmduHp6eWk8rn0QDh1fvkWutvd2vMt8swhGQiVdfxWb0Rm9KPizMe7QhxTNbe2BfAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801377; c=relaxed/simple;
	bh=kySDQSPpiI1yjOGgLE+4Ke9klqnmb5xpWtmNOwbuToU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsKblBa5AsQASVEBrAbxyRtNLuL4SUU3ymF+RcmebLOonvofESaRSCJcCOSa/Zcbgx38gtHGy/+OUAXLmRQvPNq6PK5guDLNPqbqd2FtDF8YeOqxXt8sFst02ntaOOBshn+sZlPfJj4gfoKHKeSeak+M2iBDsRo76Y8EWwwmHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WkBcJoXS; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f176c5c10so803607066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718801374; x=1719406174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bpjz0lX4gdiG8izGnJSD4JNeNkRMIt8R1nn+zHTjtn8=;
        b=WkBcJoXSwO5HqNYCktdVSOyBKjN4RFYuL4BFG5mtVadGkIEy6yvgOJRsSUFn9uEFsN
         apPj6emPUenjZyIIaGfx9cev5ar9wAjP7kyAN7PrFY41DF/a2VR8/204sX3ziw6oQTQu
         g9E3k0ft+Hs2G9k7IFBMPIkU583zxo6F76n4tF83riTzEiAgvltEdlqrMIiiBRF6iT05
         1xJcdpuIZ8NuFIun92Etvd+JcpxWj8ZGu7+ALbOvTGdqkh4fLaElPdUFDoB+z+d5vm9W
         rprrlbnAtBma3INH+BDczsJzT8iwrcd7icO49r2CvxUGxhLDphhnGXFGUl1c6g2V5Kfg
         cbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801374; x=1719406174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bpjz0lX4gdiG8izGnJSD4JNeNkRMIt8R1nn+zHTjtn8=;
        b=XRp2SGGyx13cZWIG0pwI/53ESMUI7h0nnQ8MteoSILEBbMM0UCoTJKkHJn+QvmyHyQ
         da8ndSHMjmyv2QIi+LGMLSPX0I1hUlotgFJdfLVSP/m6ncT3N+r8ucadYK0U4k1rfoSu
         AfqLYnmi6ItCN+NNa7FDPMhZxaaaDziF9vF6emSnC3FsulWR/G2e01yb946HvEVWx9Ue
         1aD77Qr5JjrdKrSa1aqguJCxDAokoCXcHuJD2vKXwLH0uvvXgd4qoyk69OYSMhfcNyqv
         k9km1z1osvqBOdkkVpWisIfHhQttz7G8vqlXy6llnBLRu4fXoy7YkljdoVPQVJAw+qwH
         P+1w==
X-Forwarded-Encrypted: i=1; AJvYcCVHdMmKURm8fswu19y2b0ClHXOWbK0Au0UBgtQyrW7Jm3U9ynqSvRTFD3I4j6vb9FX+3UH4Q+JgIkrBvmE+5uIXH8fpNchQv5laVtu+
X-Gm-Message-State: AOJu0YwiknVspU18/uj7aencA3Xtu/QTY4KBF3F6Cc3j8K4fLj8tt4OG
	ZgnkDk2S9xj+j5wNuMefTcY9v9wKmIBp1foFRnZfRqnuiFmBkCeP
X-Google-Smtp-Source: AGHT+IGOq/zNWszfyhqzTg/FGYYZ1XNMIHD0Ip9bIXCTfv9EGQolffnOerLXpNb3aysPvYg8WIqARw==
X-Received: by 2002:a17:907:cc06:b0:a68:bae4:d66f with SMTP id a640c23a62f3a-a6fab615d55mr128333766b.30.1718801373990;
        Wed, 19 Jun 2024 05:49:33 -0700 (PDT)
Received: from f (cst-prg-30-39.cust.vodafone.cz. [46.135.30.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6759sm660799666b.63.2024.06.19.05.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:49:33 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:49:21 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel-team@meta.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH] mm: ratelimit oversized kvmalloc warnings instead of once
Message-ID: <fm7buc5wqjfbpkc4vciubjttk73k7vzahohlcolztrhjqywnca@pysupztheg6i>
References: <20240618213421.282381-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618213421.282381-1-shakeel.butt@linux.dev>

On Tue, Jun 18, 2024 at 02:34:21PM -0700, Shakeel Butt wrote:
> At the moment oversize kvmalloc warnings are triggered once using
> WARN_ON_ONCE() macro. One issue with this approach is that it only
> detects the first abuser and then ignores the remaining abusers which
> complicates detecting all such abusers in a timely manner. The situation
> becomes worse when the repro has low probability and requires production
> traffic and thus require large set of machines to find such abusers. In
> Mera production, this warn once is slowing down the detection of these
> abusers. Simply replace WARN_ON_ONCE with WARN_RATELIMIT.
> 
> Reported-by: Kyle McMartin <kyle@infradead.org>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
>  mm/util.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 10f215985fe5..de36344e8d53 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -649,7 +649,8 @@ void *kvmalloc_node_noprof(size_t size, gfp_t flags, int node)
>  
>  	/* Don't even allow crazy sizes */
>  	if (unlikely(size > INT_MAX)) {
> -		WARN_ON_ONCE(!(flags & __GFP_NOWARN));
> +		WARN_RATELIMIT(!(flags & __GFP_NOWARN), "size = %zu > INT_MAX",
> +			       size);
>  		return NULL;
>  	}
>  

I don't think this is necessary. From the description I think interested
parties can get away with bpftrace.

Suppose you have an abuser of the sort and you are worried there is more
than one.

Then this one-liner will catch *all* of them, not just the ones which
were "lucky" to get logged with ratelimit:
bpftrace -e 'kprobe:kvmalloc_node_noprof /arg0 > 2147483647/ { @[kstack()] = count(); }'

Of course adding a probe is not free, but then again kvmalloc should not
be used often to begin with so I doubt it is going to have material
impact in terms of performance.

While I concede it takes more effort to get this running on all affected
machines, the result is much better than mere ratelimit. Also there is
no need to patch the kernel.

btw, I found drm keeps spamming kvmalloc, someone(tm) should look into
it:
@[
    kvmalloc_node_noprof+5
    drm_property_create_blob+76
    drm_atomic_helper_dirtyfb+234
    drm_fbdev_generic_helper_fb_dirty+509
    drm_fb_helper_damage_work+139
    process_one_work+376
    worker_thread+753
    kthread+207
    ret_from_fork+49
    ret_from_fork_asm+26
, 104]: 12

