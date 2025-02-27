Return-Path: <linux-kernel+bounces-537426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB97A48BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0B133B44B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F17E1B85DF;
	Thu, 27 Feb 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TXMSNwFz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DDD27781A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 22:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740695584; cv=none; b=CuoyK0mr4t40uyW9nvoyIEDcztWhETXK8st9KXc2RqqMdVw3z4ubZjfhKk8F1JmFB7NztEh+xJppAaKDI2Cgs33OolxXjzjom/kpYP3+QlxDEUVeKOcDnICUWy9kcBxsatcI2ak5STXQJYVUMiesJnRn/lXBiCBDdDumu+FYZlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740695584; c=relaxed/simple;
	bh=USyZMIv4w7ltYQtCQ7S44ydRGVMpGMJlitCpYdvXx/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RwcRG9m0y977IDwJrFa1z0oLAfKfhV/HlLP/CMr7DZBI54J5wB5uKpIXNnclsFkhrAa8BuE5acxI22vkLSe3/Y4YtZciaohxQvij17i0gyHAXzXEn8xggfLz1AxnOe0GdB+9GheAbHHJY2CCQOIO1wFGLjsz7MfZncoeSm9f1gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TXMSNwFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE0BC4CEDD;
	Thu, 27 Feb 2025 22:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1740695583;
	bh=USyZMIv4w7ltYQtCQ7S44ydRGVMpGMJlitCpYdvXx/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TXMSNwFz++Ybn6NfXVV8MQy8HFwktvEeMRHtc/o8wPXxb2ZHldTS0O+hEMqQ2iJ4R
	 xAS8WhIHrfQ0eKZfh9sOmuGwLac/T/HU6CEW7l5D72f2wnyNO2B4lcJgkyxF0UopJL
	 C5LntxoreDgB8WfFMnU0zOjeYgusBrdxp9OznMTc=
Date: Thu, 27 Feb 2025 14:33:02 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: David Hildenbrand <david@redhat.com>, Oscar Salvador
 <osalvador@suse.de>, Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka
 <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Add lockdep assertion for pageblock type
 change
Message-Id: <20250227143302.2338b1cf15919c64a6c1eb27@linux-foundation.org>
In-Reply-To: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
References: <20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 16:15:47 +0000 Brendan Jackman <jackmanb@google.com> wrote:

> Since the migratetype hygiene patches [0], the locking here is
> a bit more formalised, so write it down with an assert.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>  
>  void set_pageblock_migratetype(struct page *page, int migratetype)
>  {
> +	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
> +		in_mem_hotplug() ||
> +		lockdep_is_held(&page_zone(page)->lock));
> +
>  	if (unlikely(page_group_by_mobility_disabled &&
>  		     migratetype < MIGRATE_PCPTYPES))
>  		migratetype = MIGRATE_UNMOVABLE;
> 

We could add such assertions all over the place.  Why this place in
particular?

