Return-Path: <linux-kernel+bounces-344296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4225E98A7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 16:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD322B27A5A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D0F1917FF;
	Mon, 30 Sep 2024 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A67NZL3k"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D760190471
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727708193; cv=none; b=Xbqj4TCQAIOCg9c/GFlw/6+4hoSjTV90IGgyXjjegZd8jL8XgxGypLUeSZS4Dmn91o4y+JJ1qQgqE7NSBx9foagQvlobiNoRa4Jr8MV+g7rIXYdMvIbVWdtba/L3q6w3FgvJO7/zB1appjVQTVT3J+Gr9vB1Bs1r3hNqlNnL8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727708193; c=relaxed/simple;
	bh=16s/9Mydy31UJltn2ljHYMXhM2Ucz6mRgLggv/vHfgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNKUBeRWUR8Ip5tO0opWZE8Tzf+pPbhAjuY7J5qkPLKdCVdxOHJtQzKdzQIIftNk5HPNDDz391v8pTlOUpvUlZ679C+MeBWkllDwzXNlhmQN/MonljBr2B6D51PXAXBa3ESlEMFARMA/fXcYuiWqXk8f0Y7Sw3qRYbSAb4DlEkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A67NZL3k; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ksi+nXEzxwbt1R/VHNvBjNr9Ahcsl2csKfy6fOP8Ops=; b=A67NZL3kOdgDstbnyJKdM7DVWz
	VNunYMEuKsrmao/B9GGdCZa1Aed1JAYTHpw+K3dAcFz37FK9pnXEuAdBHXKMmzEtnNS6jpSGx71o7
	Jz/JnUj/pROFo1KxuubsxH9C3Eh4vWGHj8FBy7aq/pxqx4dbEyle8Vp1+WqzTC+Q1oaU+VyQRCv1D
	DruwsUDHKZBpUtBr5vORo/1fYIhjbYguK14yoPa19RSbbMe+WNBappGOQLtPmRUFY/y1OHBmtD3wG
	wOlzylnKKhLi4THJrMzcEooY6+0TULOERkW87J32f0dGZr+n6Oov02dfOzW4mDncF3ux4EGej0p98
	ockjCTeg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1svHp4-00000002qle-28EC;
	Mon, 30 Sep 2024 14:56:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2632D300754; Mon, 30 Sep 2024 16:56:26 +0200 (CEST)
Date: Mon, 30 Sep 2024 16:56:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Disseldorp <ddiss@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>, Hajime Tazaki <thehajime@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched: remove unused __HAVE_THREAD_FUNCTIONS hook
 support
Message-ID: <20240930145626.GK5594@noisy.programming.kicks-ass.net>
References: <20240930050945.30304-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930050945.30304-2-ddiss@suse.de>

On Mon, Sep 30, 2024 at 05:09:46AM +0000, David Disseldorp wrote:
> __HAVE_THREAD_FUNCTIONS could be defined by architectures wishing to
> provide their own task_thread_info(), task_stack_page(),
> setup_thread_stack() and end_of_stack() hooks.
> 
> Commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
> removed the last upstream consumer of __HAVE_THREAD_FUNCTIONS, so change
> the remaining !CONFIG_THREAD_INFO_IN_TASK && !__HAVE_THREAD_FUNCTIONS
> conditionals to only check for the former case.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

Thanks

