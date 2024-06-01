Return-Path: <linux-kernel+bounces-197739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78F8D6E8F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 08:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DB95283FEA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E159134BC;
	Sat,  1 Jun 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ns89iws0"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702317BA6
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717224499; cv=none; b=ccED3AlPK7eKGFHtMed1q2YHuPmcxDqZdKpcQS349oWgdwJkQk0xxWvygiBp2WOqqSRVFpoOXOrW8tqbRiml+xDRbyITNADMLFq2wkhtmAYxL7M4rN0Swkz89RFkzaqocRwvOttD9BfPLLyEtnLN/nNDRhcqjWyIWc9MEs2+40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717224499; c=relaxed/simple;
	bh=4/jmWkv8DzzjNDuW9hn8p6nI6XRe0rJm9NTLyO9FiXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGEV4B8FT6uAyt3trjGH+gc9nYCTXB9VL6DEXhH37aPbkkWm1S11LxDsI8LhK6oKJ5REYcGp+BIbPE9fA8faSjYjQ2rrKMKZzBgFjk+nMr5HmUL7NAv9euXIQhd0FFM2HQO8NWJeXHuNd4AHxeG+LhR708boqJAYM6fCFxfySs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ns89iws0; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717224496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PGIdBLs5Ze9hih1BvRArgKxcZvKS87M7fVfrfQ1t+/w=;
	b=ns89iws0sz054BKU9UqX2WY8gUTQZjPlYLVAhgsPchkLhykgv9TzTYhX7ogsN09TdgZrLM
	N1R5/6trDEkcQO93RGa/73nL3DweUa5vz7JLaCyS3uLRP07X5IjDoVuShrYk0eobUJ8QAh
	DkQnbU0T7tZj6Mp7Y7rggEehqMyGUHM=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: willy@infradead.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 23:48:10 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 09/14] mm: memcg: rename memcg_oom_recover()
Message-ID: <c7usn2dfexvdo5ogg6hl3yqoubj6thy3x5z4cqopzss66w472s@rzjfbvqsd43g>
References: <20240528202101.3099300-1-roman.gushchin@linux.dev>
 <20240528202101.3099300-10-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528202101.3099300-10-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, May 28, 2024 at 01:21:01PM GMT, Roman Gushchin wrote:
> Rename memcg_oom_recover() into memcg1_oom_recover() for consistency
> with other memory cgroup v1-related functions.
> 
> Move the declaration in mm/memcontrol-v1.h to be nearby other
> memcg v1 oom handling functions.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

