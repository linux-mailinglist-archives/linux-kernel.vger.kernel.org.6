Return-Path: <linux-kernel+bounces-234729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD7191C9D9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A7A1F23386
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3F0EDF;
	Sat, 29 Jun 2024 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FjhVUncZ"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1F5370
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719622561; cv=none; b=JiiWdGHCDUi4VQrO7X3M890HsDPA7fDuQ2onsYv77aoBw0/0wo6xuNeJyg9+6aeJQYxRet6zax/cKo7E4y6qZaczLRjhbHPhBUSKDW9K9f3HiHmhy7IF3tF6iRg5nXq398F+Rvnykeyr8ogjeKSAVjD6KaI6NUkaMMuqxa0ufZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719622561; c=relaxed/simple;
	bh=dkhGLgAccySiIKVbklYHFO8xjLALQqshVUa3PnAXc28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHDlMP5WLBvN9mCXTaGuPbBAgRPTnTH/YzhU1ttb3YzCVIWGoqpdN4uxZub9guGsS7kqZLWjbwrtYZTZvplq9DaMM4t7HNNhJ1n+IQhd1/TIJccfy4cQp6tNouOPdzlUdumWk5nHgwwJal0C0pgybJ+nnUENNQdSod9FBGAl9Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FjhVUncZ; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719622558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qg+0EfJ2yo59aUyKXNYz9D5YZ0EGg0i1iOZsN2rcOIA=;
	b=FjhVUncZBpiIOvlGmhx7Zjo3SMrQ0LCehibWREL2JdFB0JaHHVXAKXPbNw4uRGMxTaoWIx
	+fKuBRYRSByIv4FyRk+fpoIWCnTfl1NBRuLXTDGRGWf5xJer8r5zTObVzuhoyF/tTnZxfc
	YnOTpPBJIIAzCJ7L7CEW8Ct/gPvtaTA=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:55:54 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 9/9] mm: memcg: put struct task_struct::in_user_fault
 under CONFIG_MEMCG_V1
Message-ID: <6arslsp6asbcvz6igp5argwhfmtf7xknsnvsdcfgxsjhlbacy4@xj6itmt5bfn7>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-10-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-10-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:17PM GMT, Roman Gushchin wrote:
> The struct task_struct's in_user_fault member is not used by the
> cgroup v2's memory controller, so it can be put under the
> CONFIG_MEMCG_V1 config option. To do so, mem_cgroup_enter_user_fault()
> and mem_cgroup_exit_user_fault() are moved under the CONFIG_MEMCG_V1
> option as well.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

