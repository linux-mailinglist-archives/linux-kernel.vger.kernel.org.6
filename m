Return-Path: <linux-kernel+bounces-273041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7D9463E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C31C212B4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3C745976;
	Fri,  2 Aug 2024 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oe3wlsfL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFC51ABEC0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722627012; cv=none; b=NFgA4BiD1HuFU9PyOyFsfwVgJvyNZHwMQ3GsEpWuNCXc1FupipuntEnNKDMe5Yztg/tLdZkjZ3Up/bdyuyP6bcmDC/P1U5ZLfVDkPIykQ7Mz4z5UZTBnknzFm7A3hOXu/romi8vcIdeiiYrhaMZsbfAm5/UwuV0/q1lmc0tKaVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722627012; c=relaxed/simple;
	bh=hbT3zHRl6k2r5GYK+a6xgD3XDO4ptYaN45gkgC9Dk4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/jZuscWlHjhnj7yzfyINE/mzzvAFZdEDfJBuP21aeO+J5/QYlrVc0sGYbZXtnd4XWbVtsAQYN6Ogxf6uYvkv7kY5C0fzQP45MG/YtAOnLvjQ6D6tL3+rkSdwO7bVEoTJn4G8NJMd7pc6yLO/p7rV4qtJXfl4Vn1TXFNzMHt8Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oe3wlsfL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nFNTAtL5Hmcp9+Bqv+5LW3nvrU4sFP9ObrjCWtvtw2Q=; b=oe3wlsfL3RFdsc/SRUSbkQW1/J
	ltLS4fevm6vucsNv46mGlBoqOvuXx2aerfCEEIt8qd60wDLGtgkJX0sDRscnLP71Y2TBknvtwo5UX
	lSWeQcDs4Tt13lkOQKEt8XlHjRtsfCR0/qodnbLwhDaKwa64HIXor1O7ZBYU0coKSpfz4SsV2/vfI
	ocKkkFGXz11Tne4lW6Y501uYq6nUNK03lXie6w1HEPRi5dYMsP8KTcxYdx187/h/A6W4u8uEHvz4T
	fk7USmoaGfuZKjHhFeSc/yN2gDEfS8jbQ7SLS4kYUmWmgAqn76kjYCDf+FoMlveqMmojAqx3L28y0
	KA5vnudw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZxyT-00000001Lru-38NA;
	Fri, 02 Aug 2024 19:30:01 +0000
Date: Fri, 2 Aug 2024 20:30:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: alexs@kernel.org
Cc: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
	42.hyeyoo@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
	nphamcs@gmail.com
Subject: Re: [PATCH v4 01/22] mm/zsmalloc: add zpdesc memory descriptor for
 zswap.zpool
Message-ID: <Zq0zucMFsOwATsAC@casper.infradead.org>
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729112534.3416707-2-alexs@kernel.org>

On Mon, Jul 29, 2024 at 07:25:13PM +0800, alexs@kernel.org wrote:
> +/*
> + * struct zpdesc -	Memory descriptor for zpool memory, now is for zsmalloc
> + * @flags:		Page flags, PG_private: identifies the first component page
> + * @lru:		Indirectly used by page migration
> + * @mops:		Used by page migration
> + * @next:		Next zpdesc in a zspage in zsmalloc zpool
> + * @handle:		For huge zspage in zsmalloc zpool
> + * @zspage:		Pointer to zspage in zsmalloc
> + * @memcg_data:		Memory Control Group data.
> + *
> + * This struct overlays struct page for now. Do not modify without a good
> + * understanding of the issues.
> + */
> +struct zpdesc {
> +	unsigned long flags;
> +	struct list_head lru;
> +	struct movable_operations *mops;
> +	union {
> +		/* Next zpdescs in a zspage in zsmalloc zpool */
> +		struct zpdesc *next;
> +		/* For huge zspage in zsmalloc zpool */
> +		unsigned long handle;
> +	};
> +	struct zspage *zspage;
> +	unsigned long _zp_pad_1;
> +#ifdef CONFIG_MEMCG
> +	unsigned long memcg_data;
> +#endif
> +};

Before we do a v5, what's the plan for a shrunk struct page?  It feels
like a lot of what's going on here is just "because we can".  But if you
actually had to allocate the memory, would you?

That is, if we get to

struct page {
	unsigned long memdesc;
};

what do you put in the 60  bits of information?  Do you allocate a
per-page struct zpdesc, and have each one pointing to a zspage?  Or do
you extend the current contents of zspage to describe the pages allocated
to it, and make each struct page point to the zspage?

I don't know your code, so I'm not trying to choose for you.  I'm just
trying to make sure we're walking in the right direction.

