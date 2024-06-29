Return-Path: <linux-kernel+bounces-234726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF891C9D5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957A8283DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D515A5;
	Sat, 29 Jun 2024 00:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLWaFhY8"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392D1628
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719622171; cv=none; b=H3KuOX5alFPzyYow7oX7BzoOg6xN8bR6mkrf6T1iJeDrD9ZcNpd2FmMJEqhPHuDA/EKUKog4ez9JCkTbt4A57QHaUkOfhn6QpHnsw40ufyZgKH3m5YTj7xsYBPBgIwYRG/Jg7N++cqcQ4dEstJM1GRF8yt2YC3REwIlo9b3aNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719622171; c=relaxed/simple;
	bh=J6LZ19caBts+fl45YDrgv5DAzLqGJsBN6DawlF8tAMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtFcTY9d6T2PkxandFaWYFxOAe3GBL/5RKgAvPRbdq1IgORiH4i9KiT5LSdUeXzTJ3RXbMH6Q37ybgMtzC2gwJIG3Yeb2iOyC+swtD0nc6JMKQPdZyd6vphOdp8mXVD7f6KAdVLkM8l6rAoKLGRGE7JwMoWdfNaU7q7Sm6m19/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLWaFhY8; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719622168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zq1pu6XHEe4T66VpQWUMC5o9zpyujkztzW++fUoeWw=;
	b=uLWaFhY8ALNNBF0kUdRMGWwnyuZQVgtsKgsbl/2SWu73CHhLuXVVwfX0dDGaCYvF3HWdVu
	1HGBxdCDIFl4lucNpCLPyyD+JBZ94FbMhyT13Vp6tIoRBSFetOvx/P8vr/t+domb/zHVp0
	qjiuNIbhDRsiwAY/knUIGwMDWN+Gg7U=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Fri, 28 Jun 2024 17:49:24 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 5/9] mm: memcg: guard memcg1-specific fields accesses
 in mm/memcontrol.c
Message-ID: <b57jiwyaeamftgn4jdan5blwzxexdqmfgh7hfot5orjmb2dax7@ltddbvoluvbm>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-6-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:13PM GMT, Roman Gushchin wrote:
> There are only few memcg1-specific struct mem_cgroup's members
> accesses left in mm/memcontrol.c. Let's guard them with the
> CONFIG_MEMCG_V1 config option.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>


