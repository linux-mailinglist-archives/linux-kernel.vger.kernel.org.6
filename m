Return-Path: <linux-kernel+bounces-297838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A926695BE50
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DE51C230E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2529E1D0488;
	Thu, 22 Aug 2024 18:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ico4TFXr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677BDEC5
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351795; cv=none; b=pshwaKgU2kPQiK7PiAlBlBgmw/IJeGnGaBu8HIwZYpyTwxqav7QWHP/1k2n0xt7QV6AHDyTJVnZbxBrD1SF2emaKasJx1jX4LAbXBQIYN8x8X+oxzX4HJbV4iAnpmYiDwWDs0DQGrGnFHd7t7zxw8r1o2OZZ/foe0NzotMQZ+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351795; c=relaxed/simple;
	bh=RBkOLtuY711Q9bWjndhDlXTmTY7FvXKaoIGDTvxNjvg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hwnFUZNZ+Z7kNOGt0L0bsv5+xy3ha2v6n7zeWjCrVLnHUECBw120XpnQE3/vhr7uxya7YXAzO8KCCYtM1s11LnktwoQkzjkyyU5mQ3Jtj/ZbmvE1IpkugKfiniBPJDGyv0QdEL7E9fBSiT4NhuMkl9Ro/XSok/pIjz1yE8n0rC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ico4TFXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2F1C32782;
	Thu, 22 Aug 2024 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1724351794;
	bh=RBkOLtuY711Q9bWjndhDlXTmTY7FvXKaoIGDTvxNjvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ico4TFXr/9CTt4AbfMUUWbXaviDwrXZ3lIo/zj6y26ZZaWvAESwgv8OFqCQV2bCCg
	 urnwAc2AtUNFXXOuH8P56q5jkP3u/eFcTfMWUMwsVl3GVi8LRZGjxJO/p4rZxLrTD+
	 Qk/BfRvpLpyqOWs/QWCwGOMbarzZIKreOt945ESo=
Date: Thu, 22 Aug 2024 11:36:34 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Liao <liaoyu15@huawei.com>
Cc: Yu Zhao <yuzhao@google.com>, Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, Kefeng Wang
 <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH mm-unstable v2 1/3] mm/contig_alloc: support __GFP_COMP
Message-Id: <20240822113634.1aaf99c506796ecc233cb472@linux-foundation.org>
In-Reply-To: <2d418463-1458-5361-86c4-a07908fc114d@huawei.com>
References: <20240814035451.773331-1-yuzhao@google.com>
	<20240814035451.773331-2-yuzhao@google.com>
	<2d418463-1458-5361-86c4-a07908fc114d@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 16:21:27 +0800 Yu Liao <liaoyu15@huawei.com> wrote:

> > +#ifdef CONFIG_CONTIG_ALLOC
> > +static inline struct folio *folio_alloc_gigantic_noprof(int order, gfp_t gfp,
> > +							int nid, nodemask_t *node)
> > +{
> > +	struct page *page;
> > +
> > +	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
> 
> It doesn't seem right, it should be !(gfp & __GFP_COMP).

Yup.  Although I'm wondering why we're checking __GFP_COMP at all? 
It's a gigantic page - we know it's compound, so why require that the
caller tell us something we already know?

--- a/include/linux/gfp.h~mm-contig_alloc-support-__gfp_comp-fix
+++ a/include/linux/gfp.h
@@ -452,7 +452,7 @@ static inline struct folio *folio_alloc_
 {
 	struct page *page;
 
-	if (WARN_ON(!order || !(gfp | __GFP_COMP)))
+	if (WARN_ON(!order || !(gfp & __GFP_COMP)))
 		return NULL;
 
 	page = alloc_contig_pages_noprof(1 << order, gfp, nid, node);
_



