Return-Path: <linux-kernel+bounces-429886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1B9E2877
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 18:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EFCBC68F8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763E1F9EAB;
	Tue,  3 Dec 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kcUGLwD9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667C1F8AD8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244687; cv=none; b=RwGP8uf6Li5A0icl3HTZShoFlbToccMr7fad63YROxsz/heyf5CRAbqCC6N1avOkFCPmXb5Yhln64mKJNAMh1LpW/T1RiPLG88fOY4LvcjsH3GeiN5P7U3N2Eq9jADmGhNmwVugKm8BFYRuHPCZPGIE4+i1XlgvyghEUlLMrxbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244687; c=relaxed/simple;
	bh=vloeXl6uT3w6Uqfv+CKt3GOgs2eqhXmBXtqY3o4O/Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXJ/EMWfLp8CaH8rDzHos9repvFKRwK1pnvkRQ4dRMcGacCJAvJeUFl4PwXP6/TgPghVLapJn9S7qZC0tN31nM6CI7dtCLRO/kc79dIeINa39Ok/Ph3TDCDLPNc7TfiZhKQyN9JZp3v8P++kaNZBwsu7uYeljyMkeoeGroYC+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kcUGLwD9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PEy0xzOQmFtsAubHZhQVUKPelhUO+CET1Kndu3/TO0Q=; b=kcUGLwD98U7AV/Nx0H5iKyc5Vw
	i026TX4gLqkLN/uUGMLL9wAAcjFtQQMYdFV2QvplzBVL3/V44L6m+K7QLIZNyX+QJ+8csOUfjERw2
	xcltDx4Tais1TCq4Ghij1vUbEnC0Yoa/UVoJhsfkBNotA0toN3gfMIf8NvamjE0E0Gtpj3zUCHKG1
	kO/WpI5OyjrYbd4PqlChIMsyLLocsYi5KhOt2WQVp7GVMHeneKeAY/FH8Pqqc0Ej3kqxwYfwvrIe/
	4nW1ke4TKXUzr/Ca5tp+6+4ODd7njjmVKTvMG3B1DNdF0bZwnlZqv8WqT200d5mq8mf45WixZCcpI
	O3fi/6NA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIW7M-00000009tWb-2F0h;
	Tue, 03 Dec 2024 16:51:20 +0000
Date: Tue, 3 Dec 2024 16:51:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Subject: Re: [PATCH v7 01/21] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <Z083CD441MML7zsi@casper.infradead.org>
References: <20240902072136.578720-1-alexs@kernel.org>
 <20240902072136.578720-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902072136.578720-2-alexs@kernel.org>

On Mon, Sep 02, 2024 at 03:21:12PM +0800, alexs@kernel.org wrote:
> And keep the memcg_data member, since as Yosry pointed out:
> "When the pages are freed, put_page() -> folio_put() -> __folio_put()
> will call mem_cgroup_uncharge(). The latter will call folio_memcg()
> (which reads folio->memcg_data) to figure out if uncharging needs to
> be done.

... why does that mean we need to keep memcg_data in this definition?
If it's unused, it will stay unused.

> There are also other similar code paths that will check
> folio->memcg_data. It is currently expected to be present for all
> folios. So until we have custom code paths per-folio type for
> allocation/freeing/etc, we need to keep folio->memcg_data present and
> properly initialized."

...

> +struct zpdesc {
> +	unsigned long flags;
> +	struct list_head lru;
> +	struct movable_operations *mops;

Hm.  I'm not sure this is a wise definition.  While yes, we know it
will only point to the mops, we always set the bottom two bits to '10'.
So I think it's safer to make this 'unsigned long mops' and force people
to _not_ use it directly.


