Return-Path: <linux-kernel+bounces-179177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B918C5CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89FC1C20D34
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A3181B93;
	Tue, 14 May 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SxFKmuF+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E501E491
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721281; cv=none; b=TeAgp5kMr+ONBnb8bKA3vOcgmjbr6zMP4fq6Q4TG6g6DtYGiIjgzD7AVB2GhIwDvslbyNbAa1f1R4g7+CGxITMU/8pZlQz6MXfOQAO+wCQJgUslXM+lXf0EK2YvR7SvB4dQK+ui9MQE0aihslW1WquxTbu+Zlze4tk60WevFNbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721281; c=relaxed/simple;
	bh=+78pNISfXCXpQc/XQQZsCUs23dG3BM2mGKmH6j0NNjk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a5/mkMGu5K/lwc7r+ECXgB5yPg2GjQ26kL7XAEjWrTGXthvvVYEGJQxxXKnIIdjgmlB6m9gUI1Jy5R/nRE//pAww4n8tS6B9UOBxJh/Epu7YJ11a6GpRohHIa5vFzdB3BG3f9pqD8Gx1f3x1HhFKJsjyQdmEIuAIsCUI3Fppd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SxFKmuF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32221C2BD10;
	Tue, 14 May 2024 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715721280;
	bh=+78pNISfXCXpQc/XQQZsCUs23dG3BM2mGKmH6j0NNjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SxFKmuF+sG0UZJmAeOxtF9ZMQb8akcIRfMvgc4391rbSl8yD8FT5GFt6CEIaj2pUF
	 BSxBbwuptHGht6iv9I0uFiD44IZkm+fk/dycCHQ5+BDlhFO9ETq0+SDZpTDiJQ74Kb
	 W9KNmasRY5erD9X5YWKD0cYUdg/rHHrCSmPBDM2Y=
Date: Tue, 14 May 2024 14:14:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: <shy828301@gmail.com>, <nao.horiguchi@gmail.com>,
 <xuyu@linux.alibaba.com>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
Message-Id: <20240514141439.55fba39c81c1af55c9a100e1@linux-foundation.org>
In-Reply-To: <20240511035435.1477004-1-linmiaohe@huawei.com>
References: <20240511035435.1477004-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 May 2024 11:54:35 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When I did memory failure tests recently, below panic occurs:
> 
>  kernel BUG at include/linux/mm.h:1135!
>  invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 9 PID: 137 Comm: kswapd1 Not tainted 6.9.0-rc4-00491-gd5ce28f156fe-dirty #14
>
> ...
>
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -208,6 +208,7 @@ static bool get_huge_zero_page(void)
>  		__free_pages(zero_page, compound_order(zero_page));
>  		goto retry;
>  	}
> +	__SetPageReserved(zero_page);
>  	WRITE_ONCE(huge_zero_pfn, page_to_pfn(zero_page));
>  
>  	/* We take additional reference here. It will be put back by shrinker */
> @@ -260,6 +261,7 @@ static unsigned long shrink_huge_zero_page_scan(struct shrinker *shrink,
>  		struct page *zero_page = xchg(&huge_zero_page, NULL);
>  		BUG_ON(zero_page == NULL);
>  		WRITE_ONCE(huge_zero_pfn, ~0UL);
> +		__ClearPageReserved(zero_page);
>  		__free_pages(zero_page, compound_order(zero_page));
>  		return HPAGE_PMD_NR;
>  	}

This causes a bit of a mess when staged ahead of mm-stable.  So to
avoid disruption I staged it behind mm-stable.  This means that when
the -stable maintainers try to merge it, they will ask for a fixed up
version for older kernels so you can please just send them this
version.

To facilitate this I added the below adjustment:

(btw, shouldn't get_huge_zero_page() and shrink_huge_zero_page_scan()
be renamed to *_folio_*?)


From: Andrew Morton <akpm@linux-foundation.org>
Subject: mm-huge_memory-mark-huge_zero_page-reserved-fix
Date: Tue May 14 01:53:37 PM PDT 2024

Update it for 5691753d73a2 ("mm: convert huge_zero_page to huge_zero_folio")

Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Xu Yu <xuyu@linux.alibaba.com>
Cc: Yang Shi <shy828301@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/huge_memory.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/huge_memory.c~mm-huge_memory-mark-huge_zero_page-reserved-fix
+++ a/mm/huge_memory.c
@@ -212,7 +212,7 @@ retry:
 		folio_put(zero_folio);
 		goto retry;
 	}
-	__SetPageReserved(zero_page);
+	__folio_set_reserved(zero_folio);
 	WRITE_ONCE(huge_zero_pfn, folio_pfn(zero_folio));
 
 	/* We take additional reference here. It will be put back by shrinker */
@@ -265,7 +265,7 @@ static unsigned long shrink_huge_zero_pa
 		struct folio *zero_folio = xchg(&huge_zero_folio, NULL);
 		BUG_ON(zero_folio == NULL);
 		WRITE_ONCE(huge_zero_pfn, ~0UL);
-		__ClearPageReserved(zero_page);
+		__folio_clear_reserved(zero_folio);
 		folio_put(zero_folio);
 		return HPAGE_PMD_NR;
 	}
_


