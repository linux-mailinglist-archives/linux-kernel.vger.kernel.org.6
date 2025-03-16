Return-Path: <linux-kernel+bounces-562875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45761A6340B
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 05:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6201B3AF342
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 04:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018D145FE8;
	Sun, 16 Mar 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrBFtTd9"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5213D8A0
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742100237; cv=none; b=SMk3S90IDjIIBKNmaYdQ8O+FJfzwoP7NrXB9L0oV1jY8u3FVcn2PDvf0LLdz/BytEPeSLhWIXGioZo30GeFrweE59oU7I6MOkwd+/c6ISo0bnjCNJw4Olf14bgBGbJ3KR09WsarC4oFx4b7t+523kYa9z9aE7cIEeMLEI1SvFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742100237; c=relaxed/simple;
	bh=AUnrriapiGkwd2RqI8DO908oV92FiqsRwTYsawiwcqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDTCruWLol+cb+xsGaFWtBa9LV+YRfYCuMxilgpM7wFgvzNaZMqVjqpNm84t531V6EED6ckZuZYCK1zue3AeM/4ImTSu7btZ2tDsdhb/7zRvvb5vl0RkOQuMSvyS3CHBRtYfJbydQvNVMLIuOLu6D5+Q54kvvDnwpjJxVo0SAYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrBFtTd9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 15 Mar 2025 21:43:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742100232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lFMOPq6zqDYkg+++uZfW7MyXeWairUVM1+MW/9m9jVk=;
	b=SrBFtTd9cwU7FP/mitEkfJAy+Ozt/iurTTbwwDCTwVcNDItp0GqZigptnn9bXfDoVxVqCr
	i7SJq5LouoAMPQpkog3TCq9F5FJb/m0Cy8NIin8Q1L+1OEhZwOThX4ixTRnC3xrMAby8yy
	fraMejiSeY5xuorHe7lcohCBg6FybMg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/9] memcg: cleanup per-cpu stock
Message-ID: <s6va6ux3y2nb7cy36zeyj6wbvhd4w4qakmx52jvxzj3onq53h4@yztw4rayrj36>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
 <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315205759.c9f9cdfc2c20467e4106c41a@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Sat, Mar 15, 2025 at 08:57:59PM -0700, Andrew Morton wrote:
> On Sat, 15 Mar 2025 10:49:21 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > 
> > This is a cleanup series which is trying to simplify the memcg per-cpu
> > stock code, particularly it tries to remove unnecessary dependencies on
> > local_lock of per-cpu memcg stock. The eight patch from Vlastimil
> > optimizes the charge path by combining the charging and accounting.
> > 
> > This series is based on next-20250314 plus two following patches:
> > 
> > Link: https://lore.kernel.org/all/20250312222552.3284173-1-shakeel.butt@linux.dev/
> > Link: https://lore.kernel.org/all/20250313054812.2185900-1-shakeel.butt@linux.dev/
> 
> Unfortunately the bpf tree has been making changes in the same area of
> memcontrol.c.  01d37228d331 ("memcg: Use trylock to access memcg
> stock_lock.")
> 
> Sigh.  We're at -rc7 and I don't think it's worth working around that
> for a cleanup series.  So I'm inclined to just defer this series until
> the next -rc cycle.
> 
> If BPF merges reasonably early in the next merge window then please
> promptly send this along and I should be able to squeak it into
> 6.15-rc1.
> 

Seems reasonable to me and thanks for taking a look.

