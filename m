Return-Path: <linux-kernel+bounces-571687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC5A6C0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F5E3B29A9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6222D4DA;
	Fri, 21 Mar 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IG2le371"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2852722D78E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576134; cv=none; b=YMtMH++5NIL7mOASvJ4bFdKGlVWCihcaHc3JQnbMdYAi49OI3BNgNrfmo/dkb4i0Qo5oCWJ9nXKQMDgToc/p3j0Xs0sFX8ks//qiquPmQ6nYRCy0cOCkYrFoGzuQROdaSxl8DvPAPgXOszKGQIAQ/dAIoy/b5tO5w4q9p5JRdFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576134; c=relaxed/simple;
	bh=VZuWKWwqx+D4t4EN9rOo44JbxcxMII7+7ELn8GMomqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORhNYwx3xZzHJq2gnZpqM3OvHZunpvmmcm8jLdVN6mRwkrcF2YDV1LOCpF32HNaeheud91XhuHKHNy7TG4ZXMKL5PUxw+mGS3dTiyA9O5IIAzMp0UWlP1+XWXnWAvHYre0LgwoYLUDeqZk9bATahcEXfnmjpumqZ4s1S4G47AT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IG2le371; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Mar 2025 09:55:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742576129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0k4BG0pUG6A1oGGXbZDig3252bONMGhq0TL6wCJItwM=;
	b=IG2le371hUF+BSyoky5EjdInNnAZOAN3FbWyq17bhJkLgRldYBBGqn6ItUpSnUNkxlj0V2
	Pr6c4FemD9GcNp/LhOgmvJSI/qZRRseq9C++gaPtSwRPmNPqlEc7X0RYDyi5A8pbb+tMvB
	WaataOkAKAl+EW6H6Emf4K40DzGbKQg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 1/9] memcg: remove root memcg check from refill_stock
Message-ID: <yldsarkfr3hjf4hyojxguxshyi6lml5tau2fykoj7s4lelxcpo@cdh67zvt5dmk>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315174930.1769599-2-shakeel.butt@linux.dev>
 <fcfbb44b-6ab9-4c39-8a00-3e6200dc25b0@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfbb44b-6ab9-4c39-8a00-3e6200dc25b0@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Tue, Mar 18, 2025 at 08:59:59AM +0100, Vlastimil Babka wrote:
> On 3/15/25 18:49, Shakeel Butt wrote:
> > refill_stock can not be called with root memcg, so there is no need to
> > check it.
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> It's not trivial to verify this so I'd add
> VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg)); as Roman suggested in patch 4 reply.
> 

Ack, will do in the next version.

