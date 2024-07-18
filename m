Return-Path: <linux-kernel+bounces-255920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB9F9346A9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 05:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4A9F283B67
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 03:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EEF2CCA3;
	Thu, 18 Jul 2024 03:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ouvqrdYy"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C5D10FA;
	Thu, 18 Jul 2024 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721272773; cv=none; b=hO6/YabkyopMXsOx4lRlm1AhdyXUW+ZdgcrkvCjllrfvnNQph7JEhut+omAK7TEowcB0yrQ/kQJdMwDvmWYmLb5VUNZ7jbe5kGG85wJQzqhkoTzJm5aWZSkqvTdgn+YygYBZYw64xd+bFjSKsRQquq1qPC5dBYJ3x+VrwJ0Uk5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721272773; c=relaxed/simple;
	bh=tXruxjgAXXRBLUq1EkRrqyOOCz8QYRXKeMCznTc40C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KE5Ft1DZNGKO1zpBq8cUivyVyB0ix8XJXGIxTBReNiOW1YoHtmN/7dt7+OZNOwKb6wNETfnr9UaDMsudRlWJFVqINir7Fxp8JXn4BWKOuPWc5L5MhE0VdMJ2VQjUi4EXREaLZqB/BhHuXTgsJ6ZpX6EHbAkdn3GwDfw4TZZGz2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ouvqrdYy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/LTPAcX/ZdjGkJwMuB2EgBlggsZFjsN2rKA6eaMLSE8=; b=ouvqrdYykFU+bNpobimR6tPIcb
	8NVCZ3LzwWqCgBwgzE5KcKF6vi++xgF+5VFZaPkj2K5xCbUC/PQCfsuOG3cXOWdEUzJG49cKQmljT
	ucgMwNZILMaMifaz0Z38PZbDjiWbtXt6r4sr3ZggLYUh2/t+IdI4VEkPDJ1Z1Yc1E8OSWI7ts8vG5
	E+vRVLGgdr4NHWg4o53/RRR7y46J/tDfh+VnVW14E42kYPJAdU0TnkgbZw/VF5ZBxAWLpAO/mBClu
	jfupGLl2SauTXBANww59ennqTdZiqq2lPcCHPnj7O+CtyWZ6+pDEDDiiLqqRy3nNYzj6QFMh2NOLF
	LD70kLfw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUHfy-0000000Fbpe-1eTd;
	Thu, 18 Jul 2024 03:19:26 +0000
Date: Wed, 17 Jul 2024 20:19:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, urezki@gmail.com,
	hch@infradead.org, kees@kernel.org, ojeda@kernel.org,
	wedsonaf@gmail.com, mhocko@kernel.org, mpe@ellerman.id.au,
	chandan.babu@oracle.com, christian.koenig@amd.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: kvmalloc: align kvrealloc() with krealloc()
Message-ID: <ZpiJvj1_rKodpVSt@infradead.org>
References: <20240717222427.2211-1-dakr@kernel.org>
 <20240717222427.2211-3-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717222427.2211-3-dakr@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +extern void *kvrealloc_noprof(const void *p, size_t size, gfp_t flags) __realloc_size(2);

Please drop the extern while you're at it and move the __realloc_size
attribute to a separate line.

> +static gfp_t to_kmalloc_flags(gfp_t flags, size_t size)
> +{
> +	if (size > PAGE_SIZE) {
> +		flags |= __GFP_NOWARN;
> +
> +		if (!(flags & __GFP_RETRY_MAYFAIL))
> +			flags |= __GFP_NORETRY;
> +
> +		/* nofail semantic is implemented by the vmalloc fallback */
> +		flags &= ~__GFP_NOFAIL;
> +	}
> +
> +	return flags;

The name for this function sounds a bit odd.  Maybe kmalloc_gfp_adjust
instead?  Also the comment explaining these flags tweaks should move
from the caller to this function.


