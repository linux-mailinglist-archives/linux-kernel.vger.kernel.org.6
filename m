Return-Path: <linux-kernel+bounces-261597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 480DF93B9AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793D11C235CE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 23:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A7A1448CD;
	Wed, 24 Jul 2024 23:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JG+hdaJe"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB054D8B9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 23:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721865262; cv=none; b=OaQG5Zt0IFvb//kFl3SFTEM7HJO5WQQ0es3XuuuZTsBzctAoP64nkaD2Fm4JtVkL6pOM2k7cu1k1YFoHAzJuTRNZSgWIFGsVHcOVKfALqlrTck4+E5JxsXXtawncjBkVnY++E2RiqRzwgM1WM3fmVv9aS9UVPGM5w/JdH8VkOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721865262; c=relaxed/simple;
	bh=JaSEN8NOC4Matr/MQQEpkkMskz36HY7hcNwV2UrrTiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQGYtB+KHpAISwDbBtdy9IbPMm2CJ6VjTe058oNX7Ga6HQdnaXbQJzwN5NO++mSYVVP/MQZ12YbsBLyCW8w8VCFV/qXqQA3pNIfREtUrLhkU6Dqqc8W/dL9z3Pu+Sc7HjiWdR3HnSKb4fdNVRUlitDBhV3Jeh4ocMPhj+xctriA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JG+hdaJe; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 24 Jul 2024 23:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721865256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yk2XYWVfb0ajgjBqpBjfB0JQbWXRZtaSTamq2SyxgJA=;
	b=JG+hdaJepFrLRf9MvG7gveKe6Fko9GfH+pTQ5JnzanNmI6F2eIBwUCBzr/kee5wMiYS/uy
	9Y4V52GMdNnTeCqovstywhptovwqORs3ZYGX6+H5WxE/k4tOlMHsCThjBKH+G3S4sDS9zb
	jX1f/qnbtDByGQvtFpDSexaYJ9HpWBU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v2 5/5] mm: memcg: convert enum res_type to
 mem_counter_type
Message-ID: <ZqGUIzP_KuR9KaX0@google.com>
References: <20240724202103.1210065-1-roman.gushchin@linux.dev>
 <20240724202103.1210065-6-roman.gushchin@linux.dev>
 <lzg7yfgzcpqmk3x6ywfpjqnsqbexnt7rcx5pa6zm3w2ltqhdmp@y2gtwlh22ozp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lzg7yfgzcpqmk3x6ywfpjqnsqbexnt7rcx5pa6zm3w2ltqhdmp@y2gtwlh22ozp>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 24, 2024 at 04:48:47PM -0700, Shakeel Butt wrote:
> On Wed, Jul 24, 2024 at 08:21:03PM GMT, Roman Gushchin wrote:
> > The res_type enum is listing all types of memory tracked by memory
> > cgroups: generic memory, swap, kernel memory, tcp etc; and it's
> > currently used only for dealing with corresponding sysfs files.
> > 
> > To prepare for tracking of various types of memory by a single
> > page_counter structure, a similar enumeration is needed. Instead
> > of introducing a completely new enumeration, let's re-purpose
> > the existing one: rename it into mem_counter_type, change items
> > names to be more meaningful and move to page_counter.h. The latter
> > is needed to have the total number of different memory types
> > available.
> > 
> > This change doesn't bring any functional difference, it's a pure
> > refactoring.
> > 
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

Thank you for reviewing the series!

