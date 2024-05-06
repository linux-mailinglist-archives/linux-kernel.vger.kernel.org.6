Return-Path: <linux-kernel+bounces-170396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0884F8BD640
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2721C21670
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5A15B547;
	Mon,  6 May 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EvKNLO/J"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31458158D64
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715027435; cv=none; b=BFYw6NCM+0PjD4WAR/CcoNqKpFb+lBrQ9Pqzz7OQnprV4K8a46T2IwiU0Ph0RESpaymMHqZH9AYd5h67ClAhK5fYU1o50VIzBFmiWqYFc6SCTeV7MKweHkGnWl8R93bARzF+9PLaXOPL2p+eh6EjNn3ffzjJTI50N4VuteNBi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715027435; c=relaxed/simple;
	bh=R8tARm9RJFf1E2kRwZTfvLXE7k9nH6dKIKq82rh/Zr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5A0JKew0NG87C19F3Vr4qbCgEeACJUXxB1giAWD4nMJ9Xp+3ia8kw6vHhy3eI7lNSVL5t5czTaZC79QYbbfmq093AkkDTkQ6LKFU/JmhtVt/U+YLIi68NNfgv44oP7y67nsDJk7ZwneU0eHvNj/z5XM9dXxp3xeBQlCRbL7Tag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EvKNLO/J; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 May 2024 13:30:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715027429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zWTgDMw010qjBzY9SNStiBF2+BhONuUA6RIHZNLF4YI=;
	b=EvKNLO/JPjUI8g84XqS/c8Vr2c1jLOLboa5hR1FxWZnWTzoheYGGabDAkAgEWeVqHqnV7P
	Pr3PFGD+9YllGtNWxf0gWmfMRHjMGMb46W/O4HK2XpYp80gRGQL6WsDP1RpeyUeNM1GawN
	tCLtZY8O+UblZWbaC7vM8sYHrRGlJss=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] mm: do not update memcg stats for
 NR_{FILE/SHMEM}_PMDMAPPED
Message-ID: <Zjk931_5xRyf2Rle@P9FQF9L96D>
References: <20240506192924.271999-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506192924.271999-1-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 06, 2024 at 07:29:24PM +0000, Yosry Ahmed wrote:
> Previously, all NR_VM_EVENT_ITEMS stats were maintained per-memcg,
> although some of those fields are not exposed anywhere. Commit
> 14e0f6c957e39 ("memcg: reduce memory for the lruvec and memcg stats")
> changed this such that we only maintain the stats we actually expose
> per-memcg via a translation table.
> 
> Additionally, commit 514462bbe927b ("memcg: warn for unexpected events
> and stats") added a warning if a per-memcg stat update is attempted for
> a stat that is not in the translation table. The warning started firing
> for the NR_{FILE/SHMEM}_PMDMAPPED stat updates in the rmap code. These
> stats are not maintained per-memcg, and hence are not in the translation
> table.
> 
> Do not use __lruvec_stat_mod_folio() when updating NR_FILE_PMDMAPPED and
> NR_SHMEM_PMDMAPPED. Use __mod_node_page_state() instead, which updates
> the global per-node stats only.
> 
> Reported-by: syzbot+9319a4268a640e26b72b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/0000000000001b9d500617c8b23c@google.com
> Fixes: 514462bbe927 ("memcg: warn for unexpected events and stats")
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

