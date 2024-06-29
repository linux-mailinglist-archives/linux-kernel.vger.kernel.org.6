Return-Path: <linux-kernel+bounces-234717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A80CC91C9C6
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FFC6B22EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C6812;
	Sat, 29 Jun 2024 00:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dHrrzMEY"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A3368
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719621057; cv=none; b=e5teLWV+z1nnLddcPqgwE6rGcptQlgSu4TcUuNSP1vX5RhX2mwZGeTn8/7MJDmpo66Rf5PsCr5C+QYN9ooy+wod6NtfSzrGO1cLQXo0IObmTnPSmR++Fqt05Wds+Jpf6ZcWuY8Ce9Fd5ptGUNcBP4q7ab1tSJHGKqZyvCUPBnA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719621057; c=relaxed/simple;
	bh=Nva1nK8llWQAWlb5qNaGamXQEICLj2sq/2p147Ocrtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyN2QbVu/Eq+HjRyvK0W4FYNzWViD1WmprUCz90E4xbs1G7mnsCbHfUfM3lYmQQct8moGJuvRWd1FMmZ79y6QDRrQq1yBt/pEMmlO9NvnEZ4HlXAWT4GlJwyrZfgLl2YC8LUW4S/7+LnAYaeQ9j99gIehE6ZbiyranHAaKkUUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dHrrzMEY; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719621052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IWXE+pd1tA7tWFX16NxlXvVl3NJJq7zNI9CADPNo6YM=;
	b=dHrrzMEY8h/nwrN5qCRzZKahmPhj7drTrbDPSgdeiHh9s4/f1vrRFfj33nBtP5OsRlXTI/
	aqk3SmcgjztRQxkrItwMIPkHb7RlHmPaVgmFO/qkFyVLOo8uQNKEZNWfAnZ8tmFEza7GsX
	1jaEugXxcQPYBGDqCcl3pBJhtW55/hw=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:30:47 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 1/9] mm: memcg: move memcg_account_kmem() to
 memcontrol-v1.c
Message-ID: <nvenjwiiqigwo53plgye7awlqq7mtcbg5me2n2zokfelpwwzda@ypy655tbg3za>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-2-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:09PM GMT, Roman Gushchin wrote:
> memcg_account_kmem() consists of a trivial statistics change via
> mod_memcg_state() call and a relatively large memcg1-specific part.
> 
> Let's factor out the mod_memcg_state() call and move the rest into
> the mm/memcontrol-v1.c file. Also rename memcg_account_kmem()
> into memcg1_account_kmem() for consistency.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

