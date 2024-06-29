Return-Path: <linux-kernel+bounces-234720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB3F91C9CA
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233351F237B5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E5B816;
	Sat, 29 Jun 2024 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U+SH5Su3"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA81803
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719621559; cv=none; b=ZUziRfzZQqVYZWA5FnCCYAjuR09t48z7XvQbPEkOOJRq+TewEFV/++ilz3wq+euEwZWABHa9VmRqO5nSVl1wxQva8QfooY6YkufQ0ohTdjkqG/Tugl337SES8qn9TfhDwSRBpnzRrFbdun3otuMVkv1KLmBfd8Wy8ftu+SM2hC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719621559; c=relaxed/simple;
	bh=MRQAxR1JMabAmoJdjjWqijoOs95Mw1RmR3OhcZC5biA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NPvhKgQpzCEtS135vIg7rM0SY1FtXwvNs9pfD9ZPLNz2cqdt3ZeqLZVxXCdHEPHu5Y4qZw5r+AOQGHWA0v52jKN4SfIe5hm5JN1NevMYL9td6nUEGH/3nad5LdNoQDCSHH+idFIF6HNPsp7mFrBlzqqzjDs8VcnjjSf917kvDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U+SH5Su3; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719621556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hIdydIh8IPqBxhIl4IxBT7Ivfc2Q11iUcAGfKoD33k0=;
	b=U+SH5Su3LNu+1GZDNYbRDrroW1s6BE8CZdgdXyvVNOc8oSFIPbfgYZhIZH24MFM/JamihC
	iJOzAtqBn4JqiO+gyJGVCDs5YLHxZJ/EonEJtuLLAeUMwGhVgNusqXNi79NJYBHP4GHgi6
	sR3eq7XYJHYaqGijvRB2YqcRf5at2sk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:39:11 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 2/9] mm: memcg: factor out legacy socket memory
 accounting code
Message-ID: <zmlmufo7x4ik6lhi2jajtma3xkh3mmdbkvtngavb5mzzq4crig@73pgka52gwy7>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-3-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:10PM GMT, Roman Gushchin wrote:
> Move out the legacy cgroup v1 socket memory accounting code into
> mm/memcontrol-v1.c.
> 
> This commit introduces three new functions: memcg1_tcpmem_active(),
> memcg1_charge_skmem() and memcg1_uncharge_skmem(), which contain
> all cgroup v1-specific code and become trivial if CONFIG_MEMCG_V1
> isn't set.
> 
> Note, that !!memcg->tcpmem_pressure check in
> mem_cgroup_under_socket_pressure() can't be easily moved into
> memcontrol-v1.h without including memcontrol-v1.h from memcontrol.h
> which isn't a good idea, so it's better to just #ifdef it.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

[...]
> +static inline bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
> +				       gfp_t gfp_mask) { return true; }

I wonder if it really matters if we return true or false from above. If
CONFIG_MEMCG_V1=n then cgroup_subsys_on_dfl() is always true, so
memcg1_charge_skmem() should never be called. Anyways just wanted to
point this out, nothing actionable.

[...]
> +	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> +		return memcg1_charge_skmem(memcg, nr_pages, gfp_mask);

