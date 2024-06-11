Return-Path: <linux-kernel+bounces-210687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D26F904770
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 01:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAFB11F230BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 23:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B84155724;
	Tue, 11 Jun 2024 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QipTlLjG"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B2523774
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147034; cv=none; b=JmAs2EUQnJVqPh6ZZ89JNsta0k/H6jiEynkqO1E8JskJJx2dwJrkBZvhczhlGDQbWU1eC6VStoBov4EvjboRkrhcNgbLD7vfKwFkdCWLlvqoPl0HBYWwWo0HjEdGx8ldDs2pjZH/CqRFM0ldtWWQGLQ+pxSkN30nWfXdSCMG5yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147034; c=relaxed/simple;
	bh=igJT8cUpDve8IjaCvmiS3zLQCugrSlFStDt4bdY0TaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnxRJug03GsPvoJKidJ7R2LYB5VVENr0m7xy57ipKVfDjdgEhbOKTnEMowOh9CidGXLx/FXMsSEXBgXvsh3jhBB6e7NudESdrVwe46qNBvrBTu4EkcpdrF/cAd0j/laRfptyYa2cW/xBfZcy8Is2HqIvf3E0mWPPOG07qC8iw/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QipTlLjG; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: nphamcs@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718147029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRAlcehmKrH8u2eO41EtyxgbQ0HOlcGAgKUeCSwiCvE=;
	b=QipTlLjG2G3TIGefG8JkL0kQebRpKYyXoKIwHK+5dDUxI1qQW+BCsK3wIHqY/y7dCRYeUB
	fpV8gx5qA4ty6q6dhhJS5oNVXyacNmsh3b8U6fmZdMSPU7XZJMMJAQZTFfw1lIy3gYwn3Z
	Pb80J3UaMMdhJea8d6QDRgebMdbtFbw=
X-Envelope-To: flintglass@gmail.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: corbet@lwn.net
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: cerasuolodomenico@gmail.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2024 16:03:43 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] mm: zswap: fix global shrinker memcg iteration
Message-ID: <jv3lubz52taq6hw5vpoibq3jg7cjhfegutvvk7kcxhnth7tjw3@vwxdy2fnekec>
References: <20240608155316.451600-1-flintglass@gmail.com>
 <20240608155316.451600-2-flintglass@gmail.com>
 <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKEwX=P1Ojb71AEJ2gzQTrfWidFPcJZmoNxEwji7TceBN-szCg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 11:26:12AM GMT, Nhat Pham wrote:
[...]
> 
> Hmmm yeah in the past, I set it to NULL to make sure we're not
> replacing zswap_next_shrink with an offlined memcg, after that zswap
> offlining callback for that memcg has been completed..
> 
> I suppose we can just call mem_cgroup_iter(...) on that offlined
> cgroup, but I'm not 100% sure what happens when we call this function
> on a cgroup that is currently being offlined, and has gone past the
> zswap offline callback stage. So I was just playing it safe and
> restart from the top of the tree :)
> 
> I think this implementation has that behavior right? We see that the
> memcg is offlined, so we drop the lock and go to the beginning of the
> loop. We reacquire the lock, and might see that zswap_next_shrink ==
> memcg, so we call mem_cgroup_iter(...) on it. Is this safe?
> 
> Note that zswap_shrink_lock only orders serializes this memcg
> selection loop with memcg offlining after it - there's no guarantee
> what's the behavior is for memcg offlining before it (well other than
> one reference that we manage to acquire thanks to
> mem_cgroup_iter(...), so that memcg has not been freed, but not sure
> what we can guarantee regarding its place in the memcg hierarchy
> tree?).
> 
> Johannes, do you have any idea what we can expect here? Let me also cc Shakeel.
> 
> 
> 

mem_cgroup_iter() does a pre-order traversal, so you can see mixture of
online and offlined memcgs during a traversal.


