Return-Path: <linux-kernel+bounces-391456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFDC9B8734
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB711C21555
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC801CDA0E;
	Thu, 31 Oct 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRBxjP7t"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C61CBEB4
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730417813; cv=none; b=Cse5vNK/2toNmboxw0KM7imQkJ3PHiZcCl2w82aH6tQA8jk5RWqwjeJoeed6xO4r7iO9fuf6q9as03qhp1vKH46ETqM76YN8KcaIAVM1CFlWSa0V4rH2KTTXl/mle3lZ2Os6gUY8oeYTErUvgB7k4ppSWUSdLOR51wwf8qdk2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730417813; c=relaxed/simple;
	bh=9etzIqVEWzqdSRtqiTTz+2Hw9yT53vmtQBTqyeQ0bYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vy947KIEE2WfRAQSIQrlXYAL8Hip1Ql57x5SoPtH+SdmB413bI/Rq5zP8c9DCoy3Tko0edcxRZR4CEzIcuI7+CrE7R0Iy0G9FZWMbIjdE7F2pmRoCbMne+XxQlAN9QFRr5Efos86j/ya4CjaiyFS4NImkm5ck0/fG6Ccs1mWci8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JRBxjP7t; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=imIWV3XSKCbBAOmfN56du95YVOjyEu7HBNgJIIlLFBQ=; b=JRBxjP7tgZYSnpWNVEJi/vcciB
	63+TzmzyIRyEC9qLgdefUBC8+CqGXLPeSLYEzQry0MFWWBQ+VddqCcVKN9ceMD6q/g//ZRBNyZM8N
	M9R0+CRfzLErQyjJxbeQiv/YuhoXDdMUG9hMfiSIaLd1mYIP5/4ov8ZlFqGqN/cnr/9ehm7vmAZTD
	v2ovT2AyXYnMRbEjG5XVERRpPCRYeBVF4EU5aQxENrzxrlOAgvGE8y3olmtcCuF72ZMZdyildId/j
	3sT19CsAUkZHkQ2gUGNa3VSQ8GzcDC1zQu7ldANvIQCN0KN+3aFJP/071MVLVHjiuDdmXnRVOtSNb
	N41MjDEw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6eiQ-0000000FFWi-2bkg;
	Thu, 31 Oct 2024 23:36:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 548B8300599; Fri,  1 Nov 2024 00:36:34 +0100 (CET)
Date: Fri, 1 Nov 2024 00:36:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	sched-ext@meta.com, kernel-team@meta.com,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH sched_ext/for-6.12-fixes] sched_ext: Call
 __balance_callbacks() from __scx_task_iter_rq_unlock()
Message-ID: <20241031233634.GU14555@noisy.programming.kicks-ass.net>
References: <ZyKoE9RUulWtYpEh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyKoE9RUulWtYpEh@slm.duckdns.org>

On Wed, Oct 30, 2024 at 11:41:39AM -1000, Tejun Heo wrote:

> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1315,6 +1315,8 @@ static void scx_task_iter_start(struct s
>  static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
>  {
>  	if (iter->locked) {
> +		/* ->switched_from() may have scheduled balance callbacks */
> +		__balance_callbacks(iter->rq);
>  		task_rq_unlock(iter->rq, iter->locked, &iter->rf);
>  		iter->locked = NULL;
>  	}

I think you need to unpin/repin around it. The balance callbacks like to
drop rq->lock at times.

