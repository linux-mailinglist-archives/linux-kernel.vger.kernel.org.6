Return-Path: <linux-kernel+bounces-239725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 950B0926490
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69F61C211F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF030180A9B;
	Wed,  3 Jul 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="deK9cLHK"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535311DA318
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019571; cv=none; b=DYvZ2cOT1PoHQdrP0+MYJBCCzhzlaZIvkFywOorwnafsl3r+lD1GeiQ9ViyH2ZWEHwgpN2bWZXNSDEEyOm4RsL8KGoqC8EQGBO99HCvM7uBWX5A2IqBN43xtBWppe46P8LX5YP91X7WfAPza5S2oK48yoU60IHLNoDw+NHYcI5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019571; c=relaxed/simple;
	bh=Hud6xR0o2mx9G/4jrdBZkRNINU79S0GB0NsgtlbSfLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZsP5i33NB7HbJf0Ixr222glArKPQfNvA5kQpuevlEHMj37u4JXMgKjyL9UdjbIOchBcW9cPPwHBmOrzcxwsIqfGmtmU1IGZoqgnGwR/e+3u8uq05/FVOqJA9EI2E2Ev+7i9+A7b7MWAR3P3Dz93fhywz/r2gpfYwXo5Kf5Oc0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=deK9cLHK; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: roman.gushchin@linux.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720019567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1RVcsbBbyOrFN84Bpuysv00oCmVzMFIETbf4n93TAfs=;
	b=deK9cLHK5L6tmKb5SncV0a9CHbMK806EQUxbovkzNl5IUrHpaePuemPOay8Pr4R2RurJ9j
	MglUAWkHVg+V3fTFgQ0TNSOym8Pq1EnySQ1VL5Ek2EIc9+E92iP2LO6qmeVrAYdszsviRL
	sByd6rqAVsBSqL0EHjLSeiHewaOQ+Dk=
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: muchun.song@linux.dev
Date: Wed, 3 Jul 2024 08:12:42 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH v1 6/9] mm: memcg: put memcg1-specific struct
 mem_cgroup's members under CONFIG_MEMCG_V1
Message-ID: <inhyh4blxjzdzgzp5elgummcufsqis22ni2xpbcgtmlzpirsnv@cs6efw43wpfn>
References: <20240628210317.272856-1-roman.gushchin@linux.dev>
 <20240628210317.272856-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628210317.272856-7-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 28, 2024 at 09:03:14PM GMT, Roman Gushchin wrote:
> Put memcg1-specific members of struct mem_cgroup under the
> CONFIG_MEMCG_V1 config option. Also group them close to the end
> of struct mem_cgroup just before the dynamic per-node part.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

