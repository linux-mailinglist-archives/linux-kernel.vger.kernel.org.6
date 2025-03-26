Return-Path: <linux-kernel+bounces-576450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA695A70F84
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 04:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99C31717A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 03:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7741B15B54C;
	Wed, 26 Mar 2025 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RukF6RIe"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1B32E403
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 03:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959747; cv=none; b=Gut6xBd1ymH8PgSr0Cvru2k+KDEP2JotKPW2nfn7yvHXmui/V1Q7LOQAgyF/rd2YVAY5htDqJz29LN3UKZanFOepuLNNITtveJZZ8DxbJgZQ8KSjFyfPdLvjkn5HijX+40xatK9Ua4V9vASwhNdxRIXz9/8yEoeojKzGhDW4n7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959747; c=relaxed/simple;
	bh=IQnZd7RdC9Z06hw439OldlT2j+ltd4ZB52ugc38rkxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiqYG6nYByEh64LGYf/2fCRFges5R0uh7z+rjzq3t/k7gdL+Xyo9HlVyWXNhL5RRdEYTIC79D3e+RaPXjaHj5elqzNYUQF0fbgZ+CcR9BXARYlSd/BC3UrErtXBsxRIoGxatC+yppqpA3h713fP065f61rxf0t2zgdRr1TEAxgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RukF6RIe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pAbqfn9917SZykz6nJZN7p39auexhGko5H7nikU1ntw=; b=RukF6RIeS9qyGquKccw9sIjIOD
	IlAmgWqKEFoaEFw3QeFEB0GecGMAWuemzdTV+IMGvoDh9N55iQAeRpyFJiqUMdz4qN9R82oRxIZbK
	AzTL+Zrn7BIs569yEEXoD6rEJj7RXmSpZxXoUKmzE21jWqzMQ6IrlcjLv3706JjQ1cLAmoh3a0pMG
	AX5+vPxS2+4lW4kRLn/j9mW0QKIYZP4mziLGaXPr1owVDhe/poGm73bqPsJtTNoHr1Njmg3NfIVbu
	2Mp07+GecVd8LJT/SowUYliVnaLOJNOppD8mWu4o8/Q028IKlmG006sfViqOPxKbWHvZq0bvBAZ9w
	MLdtwUiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txHRq-0000000H0vW-25qv;
	Wed, 26 Mar 2025 03:28:58 +0000
Date: Wed, 26 Mar 2025 03:28:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: wangchuanguo <wangchuanguo@inspur.com>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: migrate: restore the nmask after successfully
 allocating on the  target node
Message-ID: <Z-N0ep6Vv6D9QRik@casper.infradead.org>
References: <20250326031218.487450-1-wangchuanguo@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326031218.487450-1-wangchuanguo@inspur.com>

On Wed, Mar 26, 2025 at 11:12:18AM +0800, wangchuanguo wrote:
> If memory is successfully allocated on the target node and the
> function directly returns without value restore for nmask,
> non-first migration operations in migrate_pages() by again label
> may ignore the nmask settings, thereby allowing new memory
> allocations for migration on any node.

I have no opinion on whether this is the right thing to do or not, but
if it is:

> +++ b/mm/vmscan.c
> @@ -1026,8 +1026,10 @@ struct folio *alloc_migrate_folio(struct folio *src, unsigned long private)
>  	mtc->nmask = NULL;
>  	mtc->gfp_mask |= __GFP_THISNODE;
>  	dst = alloc_migration_target(src, (unsigned long)mtc);
> -	if (dst)
> +	if (dst) {
> +		mtc->nmask = allowed_mask;
>  		return dst;
> +	}
>  
>  	mtc->gfp_mask &= ~__GFP_THISNODE;
>  	mtc->nmask = allowed_mask;

this should be:

	dst = alloc_migration_target(src, (unsigned long)mtc);
+	mtc->nmask = allowed_mask;
	if (dst)
		return dst;

	mtc->gfp_mask &= ~__GFP_THISNODE;
-	mtc->nmask = allowed_mask;

