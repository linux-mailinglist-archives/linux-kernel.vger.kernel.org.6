Return-Path: <linux-kernel+bounces-430364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBF49E2FF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 00:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E8F28346B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223CD205E2F;
	Tue,  3 Dec 2024 23:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUvihff6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE55202F84
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733269028; cv=none; b=mFILAIJzhrUacydNJ1c8+10B+QgUCjemK599w9dU0q8edQV9jfMRSNeMQjr5WYYsfc+H8dBscfepp6CVyfM9MDfiqkXbv7xKFUIHmcqDjrGZEiqGO8ZaFB3FG5d5QAPALjI6xd6NEDsG6Inrcuwm9qWTX+xImXJtMbxuWhQtlHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733269028; c=relaxed/simple;
	bh=V4J3uFoR5MQsKxPOQs/L0tqrUnwoJsj3hOQIU4WPdzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seuNQ9htQy2ObWzxsNH60OR7JvOWjswDTPs1wC6APyY8wDu3C368KsFhx2SWAZ9NnIsNB3luZoqgWLRPxRST+OZJFkM/+NSGlcnQbGwWO60nnaQX0+CAmWgmjTrJCZrYnvKc9f1ypLb9GZDEWRFjzQXAHaLjPqYF46tvOn9kRLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUvihff6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EAAC4CEDC;
	Tue,  3 Dec 2024 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733269028;
	bh=V4J3uFoR5MQsKxPOQs/L0tqrUnwoJsj3hOQIU4WPdzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GUvihff6Le9fs9JGjNjOlKISiEkZAFYyKzws9hUjaTxA/LQLljr9Q/bG0C3/9dcmy
	 +WfiDLEiUxQhIj7WN681gXejRvu5rdU6j5LThL+gXyKUd0KXN/xpjy/iKsu6cxklJi
	 l46iUBkKuUY8UemDGqvzBNEt81HJW3FuVxdcTR/qXyTSMpGoOQJle2XPIDvcD4Bkou
	 U9/zeMo9fc7SDNZX0XIWfb7X8NPE/J9Zl6o+Fy246q2XxQ03NioJJh1UnxtljFaEBc
	 chy5a90lV5OfxL46oDeQW0Hg99DstPB98VNTtlDqMrs0YTNSewQSPk8UCkyrHcxrE3
	 tPrXNBc44zJRg==
Date: Tue, 3 Dec 2024 13:37:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <multics69@gmail.com>
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	changwoo@igalia.com, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] sched_ext: Implement scx_bpf_clock_get_ns()
Message-ID: <Z0-WIkfltRm9b3ZN@slm.duckdns.org>
References: <20241203142802.36305-1-changwoo@igalia.com>
 <20241203142802.36305-4-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203142802.36305-4-changwoo@igalia.com>

Hello,

On Tue, Dec 03, 2024 at 11:28:00PM +0900, Changwoo Min wrote:
> +__bpf_kfunc u64 scx_bpf_clock_get_ns(void)
> +{
> +	static DEFINE_PER_CPU(u64, prev_clk);
> +	struct rq *rq = this_rq();

this_rq() is this_cpu_ptr(). Shouldn't this be below preempt_disable() if
this function is allowed to be called from sleepable ops?

> +	u64 pr_clk, cr_clk;
> +
> +	preempt_disable();
> +	pr_clk = __this_cpu_read(prev_clk);

Would it make sense to make the above rq->scx.prev_clk?

> +	/*
> +	 * If the rq clock is invalid, start a new rq clock period
> +	 * with a fresh sched_clock().
> +	 */
> +	if (!(rq->scx.flags & SCX_RQ_CLK_VALID)) {
> +		cr_clk = sched_clock();
> +		scx_rq_clock_update(rq, cr_clk);
> +	}
> +	/*
> +	 * If the rq clock is valid, use the cached rq clock
> +	 * whenever the clock does not go backward.
> +	 */

Can you move the comments inside the if/else bodies so that "} else {" can
stay on the same line?

> +	else {
> +		cr_clk = rq->scx.clock;
> +		/*
> +		 * If the clock goes backward, start a new rq clock period
> +		 * with a fresh sched_clock().
> +		 */

Can you please add comment explaining how this can happen?

Thanks.

-- 
tejun

