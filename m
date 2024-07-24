Return-Path: <linux-kernel+bounces-261596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6C693B9A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E569B239C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E52C143879;
	Wed, 24 Jul 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u++6+guB"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D2C4D8B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721864935; cv=none; b=KWKPF5xTTo7xqS95bV0I3v8i2iap0IE/XO/GP7ogXh8plYPvl267Y/TGGe5juMQGq05481IErjpy4wUi7mwfTI7Wbykeuo3Ye0txqemLRmxjV49lIaYS/k3JeLIINlTTFtOHtzwREyBmjz2aWVbSIycBXzKHoCRSzSFiMP8v7Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721864935; c=relaxed/simple;
	bh=r9s5IkIuC3lkWZsOZ6gDy5rE22ck+v7u8SgTfXQwbPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzyatLko9ddsP8K93q1tJKgUZ93QIboaNcixcs08gybBtz+aHmmSrx+XxxVbGFlt14xUGB1CghwlNaptFtsEasheAVEOF0AyvjiEQCmqKmvy+Ags1JmwNn+GaL3CI7CRO6Nm7bPbSYjCeRQNLsNzMOv0nnqyWI+oELAmL+fuGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u++6+guB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 16:48:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721864932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mR1ntPyIDIkwwZx0t7umJ2NLvnur/6lNVS/pCVIWqrs=;
	b=u++6+guBY8xmTQoZEYjgkpx5a5zGJducF7F5uC92awfJHWwl0AOCQXkiyFICOAc6XPq27s
	p5Q4RyFMqgkpLzrv2lWv/aNExFvzUxrKzw8ys/ygp8TIoiI0M14W5FFyCTzBWB530+1eRF
	YKHILPcGcHDaEhNOpsnbBIrI2PgAY7c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 5/5] mm: memcg: convert enum res_type to
 mem_counter_type
Message-ID: <lzg7yfgzcpqmk3x6ywfpjqnsqbexnt7rcx5pa6zm3w2ltqhdmp@y2gtwlh22ozp>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724202103.1210065-6-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 08:21:03PM GMT, Roman Gushchin wrote:
> The res_type enum is listing all types of memory tracked by memory
> cgroups: generic memory, swap, kernel memory, tcp etc; and it's
> currently used only for dealing with corresponding sysfs files.
> 
> To prepare for tracking of various types of memory by a single
> page_counter structure, a similar enumeration is needed. Instead
> of introducing a completely new enumeration, let's re-purpose
> the existing one: rename it into mem_counter_type, change items
> names to be more meaningful and move to page_counter.h. The latter
> is needed to have the total number of different memory types
> available.
> 
> This change doesn't bring any functional difference, it's a pure
> refactoring.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

