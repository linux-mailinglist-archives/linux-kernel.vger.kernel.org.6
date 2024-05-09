Return-Path: <linux-kernel+bounces-174138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE5B8C0AB2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F08B22AA8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FAE14900F;
	Thu,  9 May 2024 04:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TXK3jkUV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2117513C8EE
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 04:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715230280; cv=none; b=q5ufOJXCUOrqjBv6ALG2BxMAfqre9TMr56Lpd6pzxLRvY+kvxJsw+X/soDRLFlmXM4FcILOBMBnjQBw+n4XkxfkcZY0ps7jNA97kqAIw74IMo75gsrRcWDHQeSPsIFDLfSIXkCnwJdNTmhBDCb7xxtL32+tGJl/Z41Lm7cZknfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715230280; c=relaxed/simple;
	bh=TDHK2pVj8mJUImJM5hiP5PVl2dpC7PhPEcQWT//QlKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTud0KaAAMJoAfDynO8wxf87YB6GUiZfOkM6dJBTBc6ftXCud8157Jjcbt59LqoOpydDayoY8aoWm1RzixNhh+byXlYVi71kdGoGJRbYz9yAQPyFRZg7PyP58HrKe3NSjsuWvM46HQK8NTU2QTT8PtRlebVcYPsP9zwzp6nGxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TXK3jkUV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RaN5985F7FCduVrYhbHTOUfpVUxqMFRtvYN9eBGKgx4=; b=TXK3jkUVA6GFKp6bn67mzx5jZz
	D2KALZM05btPADagOJbnT/k+0uIxFXiMzTmxD6sBFAtI5bdtOf9jgr54MpVzqt6mdnSZ65tV/vkN1
	OcXdcEvfyS+vR3Ur+8gn9XMhzHAo1ce+J9qc9hCKHaXnEaVPDDUVGoh0XYjINiJN3yOqofq4M4NeH
	b33qnKTfM9kDtLcNHWViJ5kEI5yDVDWqK3XRvGg2a296rSock9iZfgnC5HwbqJq1jOFdedraJTzTp
	F4SLlC1iw0IxV1piJNh4wx15Xktgy90pAnwN4DgGk45yyWWnok/vRC7hC25pd5IKQ8TjlyCMfHQ+o
	e7sbHNfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4vkR-00000000Lth-2TLR;
	Thu, 09 May 2024 04:51:15 +0000
Date: Wed, 8 May 2024 21:51:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hailong Liu <hailong.liu@oppo.com>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, akpm@linux-foundation.org,
	Michal Hocko <mhocko@suse.com>, urezki@gmail.com, hch@infradead.org,
	lstoakes@gmail.com, 21cnbao@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, xiang@kernel.org, chao@kernel.org,
	Oven <liyangouwen1@oppo.com>
Subject: Re: [RFC PATCH] mm/vmalloc: fix vmalloc which may return null if
 called with __GFP_NOFAIL
Message-ID: <ZjxWQ1Cyx8fhMdKS@infradead.org>
References: <20240508125808.28882-1-hailong.liu@oppo.com>
 <404add29-2d3f-45db-9103-0c5b66fb254e@linux.alibaba.com>
 <20240508144321.ymnhn54daaabalhe@oppo.com>
 <90a127e5-d884-44b5-bb76-773a7485c2f1@linux.alibaba.com>
 <20240508153136.x4rxildsgza234uv@oppo.com>
 <52f9e300-4ab9-43c1-abae-cbe3da27e5b0@linux.alibaba.com>
 <20240509013059.vegko7dlty7vppy5@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240509013059.vegko7dlty7vppy5@oppo.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, May 09, 2024 at 09:30:59AM +0800, Hailong Liu wrote:
> I’m not suggesting that erofs would cause a memleak. What I mean is
> that if kvmalloc is invoked with __GFP_NOFAIL, it must ensure a non-NULL
> return, even in scenarios where memory leaks caused by other processes
> result in the inability to allocate a page. In such a situation, it
> should result in “Kernel panic - not syncing: System is deadlocked
> on memory”.

Yes.  __GFP_NOFAIL is a contract that says never ever return NULL.
The callers will generally not handle a NULL return and blindly
dereference it, leading to all kinds of nasty security issues.

Note that deadlocking would be nice, but at least it is just a
denial of service and not a possible privilege escalation.


