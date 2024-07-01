Return-Path: <linux-kernel+bounces-236901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B802A91E863
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A623B2149C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207416F0FB;
	Mon,  1 Jul 2024 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kjtglvAU"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375BB1E49E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719861406; cv=none; b=BJ1/Eh+ZZtE6603AP9/C1ksbuZcx2C6r/NVUI/aB1YZFKCou3fAYZHZQ2H0iAb7Yf80WIT9cUqr3IZXt5EhyQJyJt55JRa9f0Q0v/DSEbIAswpp+X97+SUI2gvH67UKPS197fkRzo+Hw8HsMfEWPn3dYd05ZebfpuwpNnHqpg/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719861406; c=relaxed/simple;
	bh=EeUM4/+YXm+c2cmeQPx3TZY1IfBEKmX+Ha6v2lux6gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On3q8xVM0yXmzti04SwMUUd0j4hjnKUl0a+//9EpFAwBdMO4sMaXW6IOVBXfGvE6KJCjzy3DgJoiDorboqMqHIt3fhyZjha9MURms6///p4oJfKaCLecNemlzNC1X3naKdv0EdnDpynTi87Ov5suVF54Vyb+9zNPcIEYhO4VoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kjtglvAU; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719861398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EI9T8qquZIqxjuvprJrc9kB2RFFypUL9oDG4RfdWC/g=;
	b=kjtglvAUVmXAIZbhvdi7LKLTtDqYr8wCW5EEWrHJEv57P2cdgo7RDsFIijUn9bg/u/yGpX
	/7IdygZ/+F+COTpdIaDIwPZbNJoKPPUQuV6uzjGQ1Dh7NUTubLP3csxODSx1wbTnD/JXPB
	Aaqv9ZDHQHr/0aNzQ1zVP5zVyebM5oM=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Mon, 1 Jul 2024 12:16:32 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 1/2] mm: memcg: drop obsolete cache line padding in
 struct mem_cgroup
Message-ID: <ogyccyh4vv5jnvskblcmet3q2moudnpm67bl6j6tbxk5tjr5zr@77so6w2z3uml>
References: <20240701185932.704807-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701185932.704807-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 01, 2024 at 06:59:31PM GMT, Roman Gushchin wrote:
> After the grouping of the cgroup v1-related fields and the
> corresponding reorganization of the struct mem_cgroup, the existing
> cache line padding doesn't make much sense anymore. Let's drop
> it for now and put back to new places, if necessary.
> 
> Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

