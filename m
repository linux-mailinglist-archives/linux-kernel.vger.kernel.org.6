Return-Path: <linux-kernel+bounces-272691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25763945FFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCAD2846AF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7586D21C16B;
	Fri,  2 Aug 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J96PUZPR"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F52139C6
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611446; cv=none; b=FQJR8+ttCmMmdQfIGXztGSIfY0L3BdqvzBAKRYMEMTr9hDvsIW8KmOf5VOqAo/7qzx99bCt9yJU4EfP24Fz/BlgAGU6L2I0CcHem+Ha4n2llM7A0eViO9JInkLXT2s8y6n4sCvzpss19FoCL91PsizzDehDZu0bk9P+1RQCYVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611446; c=relaxed/simple;
	bh=IDUSoDSA7+eKJmWJ4xQGsFqXwG6c85Uc0U67D1FRy78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvaJqAXGb9Zt1CcKDqwU8e+dFmXe+WG58JuXQg4AWGi94GtC/ADu1wQwb9OyQh2fPYQA7rVksVTdDaq9x0Bqdj/XrDtxbTEvgw1nEHqa8dw0jSXloDqKBCacikaf6oun0AQOrs4zDM7+bZIrUYAgY1N5npeTjJl012M3zyEiaTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J96PUZPR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1xrY8J73JFNH+hYMm5thHFxWWB+RC04sPoM6FBOH12o=; b=J96PUZPRnXrA2N3nGlKF8ZGtmK
	nuyxU8W8u8e7YPlC9lMDpd/EwVxlCN5xSLUlyPPnbHXXj24JCMXSJyd6iIUEheLsY+MSca8d7wgSL
	QHphJ+E9MiwUM0dXDL5JG8+VesKhHOgS3kvQLtrGB+Td0XsvfBz7kCj+5DRVnSrb5SWIeoywLoJvZ
	E00/FHX4rCKGz0/F9f37ef9PCpLYPgrtnbtQ5TE0I1Nor44aOj+rU/L6V90YZPi7pLYzKF2s0gGWz
	Bf+e06hdW06bve2is2RRBNCMmgwnNXRV3Rti1jb5twleVBBOfmvzc4fMB/9A76h1maieYbJ7dZcMm
	WJ6yiSjg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZtvW-000000018kg-3dRp;
	Fri, 02 Aug 2024 15:10:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 780F030049D; Fri,  2 Aug 2024 17:10:42 +0200 (CEST)
Date: Fri, 2 Aug 2024 17:10:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] lockdep: suggest the fix for "lockdep bfs error:-1"
 on print_bfs_bug
Message-ID: <20240802151042.GM39708@noisy.programming.kicks-ass.net>
References: <Zqkmy0lS-9Sw0M9j@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqkmy0lS-9Sw0M9j@uudg.org>

On Tue, Jul 30, 2024 at 02:45:47PM -0300, Luis Claudio R. Goncalves wrote:
> When lockdep fails while performing the Breadth-first-search operation
> due to lack of memory, hint that increasing the value of the config
> switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.
> 
> Preface the scary backtrace with the suggestion:
> 
>     [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:
>     [  163.849248] ------------[ cut here ]------------
>     [  163.849250] lockdep bfs error:-1
>     [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c:2091 print_bfs_bug+0x27/0x40
>     ...
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Thanks!

> ---
> 
> Changes in v2:
>   - removed extra space from the if condition.
> 
>  kernel/locking/lockdep.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 58c88220a478a..1cf6d9fdddc9c 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
>  	/*
>  	 * Breadth-first-search failed, graph got corrupted?
>  	 */
> +	if (ret == BFS_EQUEUEFULL)
> +		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n");
> +
>  	WARN(1, "lockdep bfs error:%d\n", ret);
>  }
>  
> -- 
> 2.45.2
> 

