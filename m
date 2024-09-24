Return-Path: <linux-kernel+bounces-337689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3B5984D98
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 00:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9035E283EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09068146D76;
	Tue, 24 Sep 2024 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMhG1+Dd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF3768FD
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216468; cv=none; b=Ngu6h3L2pzl8tnqyGYzd6ttKicJgCoOhCl0QMDznEDNIWMbVMmufrVsSEZPrPzI1S1Fpr8ihmCXhwz0wxbFXGVAwimdXu6kYSTo1Z3O3PdllZA9/W5Eu1bPjgxXdCsTT5OeXVyMt8vPuAz+E0G7kF0cbLUQL/SG/ai96EUfZo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216468; c=relaxed/simple;
	bh=IEcpi0dcsewJ8brdSftNwRatvant9udIb6aVLqand/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjHDJQRgj8N3IkhpZDHdtm6kH7cghFHe3XvRTOsCwYH+Rh1YTRBBpnLuNRW1s2AvKXXhC4gJKOgVCA49hRWWs3zmSp2jzC7M77gnURk2PJn/B/U+zI1vjKjRDv92gIp0BdXiAGEKRADcgVOlebBwIK6m8p+63KRE2CwD6FOi0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMhG1+Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D466CC4CEC4;
	Tue, 24 Sep 2024 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727216468;
	bh=IEcpi0dcsewJ8brdSftNwRatvant9udIb6aVLqand/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMhG1+Dd9gKTlViIdDZOr0wvQmIhSzbM0cJR1swkfDoGuCSkUHwN7SQHC9Yu/5Rqs
	 QCxe3vqa29teM5uu0hMnCesNs71OIU86STBZpGGofe0babzfp42a7e33NnO4/mGbBJ
	 mbTkr5KMYW76DddYb+BkgUug5mIRVLcEbUPWdamWLrngpsAGHL8py/mrjOvAY2FKkk
	 IRCDeNp3h3vOTK9HauRIKnpj3F0D1JHWP6Tk0iYyZQdxFR8G4CX+J4OxP/B4Jxkd1K
	 FOxbGl7vkfhcv6bKU0nUrR/zXQf8QMGkyOS2eSmXPEybU2iNwWfJ5cgUP6jLAnNKA3
	 Z/koX1bJPkD6A==
Date: Tue, 24 Sep 2024 12:21:06 -1000
From: Tejun Heo <tj@kernel.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	sched-ext@meta.com, peterz@infradead.org,
	Pat Somaru <patso@likewhatevs.io>
Subject: Re: [PATCH sched_ext/for-6.12-fixes] Disable SM_IDLE/rq empty path
 when scx_enabled
Message-ID: <ZvM7UntdPJKioomO@slm.duckdns.org>
References: <20240920194159.158152-1-patso@likewhatevs.io>
 <ZvGMjn1Va3aNbieH@slm.duckdns.org>
 <3e6fdedc-a87c-ff8a-a75c-5c1282a122b5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e6fdedc-a87c-ff8a-a75c-5c1282a122b5@amd.com>

Hello,

On Tue, Sep 24, 2024 at 09:10:02AM +0530, K Prateek Nayak wrote:
> >   	prev_state = READ_ONCE(prev->__state);
> >   	if (sched_mode == SM_IDLE) {
> > -		if (!rq->nr_running) {
> > +		/* SCX must consult the BPF scheduler to tell if rq is empty */
> 
> I was wondering if sched_ext case could simply do:
> 
> 		if (scx_enabled())
> 			prev_balance(rq, prev, rf);
> 
> and use "rq->scx.flags" to skip balancing in balance_scx() later when
> __pick_next_task() calls prev_balance() but (and please correct me if
> I'm wrong here) balance_scx() calls balance_one() which can call
> consume_dispatch_q() to pick a task from global / user-defined dispatch
> queue, and in doing so, it does not update "rq->nr_running".

Hmm... would that be a meaningful optimization? prev_balance() calls into
SCX's dispatch path and there can be quite a bit going on there. I'm not
sure whether it'd worth much to save a trip through __pick_next_task().

> I could only see add_nr_running() being called from enqueue_task_scx()
> and this is even before the ext core calls do_enqueue_task() which hooks
> into the bpf layer which makes the decision where the task actually
> goes.
> 
> Is my understanding correct that whichever CPU is the target for the
> enqueue_task_scx() callback initially is the one that accounts the
> enqueue in "rq->nr_running" until the task is dequeued or did I miss
> something?

Whenever a task is dispatched to a local DSQ of a CPU including from
balance_one(), if the task is not on that CPU already,
move_remote_task_to_local_dsq() is called which migrates the task to the
target CPU by deactivating and then re-activating it. As deactivating and
re-activating involves dequeueing and re-enqueueing, rq->running gets
updated accordingly.

Thanks.

-- 
tejun

