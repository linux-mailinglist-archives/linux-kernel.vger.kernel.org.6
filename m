Return-Path: <linux-kernel+bounces-564812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F3EA65B27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339F73A746E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E521AF0BF;
	Mon, 17 Mar 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jLQhNXBt"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829CD17A2F7
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233483; cv=none; b=fE7L4xcel8upvk/BgqYt9AhQ34VBKuN23n1hFwI+F8BM1bI7L1BJPbm3yjTQGC8ygZN4C0qWeCCzVkaEzRtU/2qSHVpjikg+7JERvs3V33akV98LNYXBMyMNfxevaU8UhRpAEqzXof6zAApqf82iP+hIxRjwaRUJibrrv33BH5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233483; c=relaxed/simple;
	bh=0eV+Wt4gBgMeg5xMoR83fjBPYqPFLM8wZ5nwC5uOzQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECUTKpm1OQ0u6/XSsaF6lEX2peiquPwsiDIZ/p0/588/i3tEno8EGapB2KwP1qJX4ROPbLW6FcPgnYism2XmXNI1u8s3bTE4L8WQzfG8Ftzw5rmJLueQP3m2xK/aZJaA909K5Txdefdn6pwllFG+LX7Pc9kCtyBz/QsSJ/4dcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jLQhNXBt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0eV+Wt4gBgMeg5xMoR83fjBPYqPFLM8wZ5nwC5uOzQE=; b=jLQhNXBtRpI5ZJuIvUZ758YJg3
	UZBZ2ie0r7rgEzaKWV3dsaCy1/9MCBsWbXdLu9vmMdA9W00AOM1KF4PN/7aa2T2zx79JnAWILTsAs
	tr6IpD552Z6793zdqrXkK2WPVzmOIF7erK5S9rpdfK4vQMOipvoT/GVTRvn1gri6WXa54btuZ+xyn
	/lq3H3oSm1uggappEC2tgW2PJ0DnIZjea/+uPHkZFvBVEubdGqdrsvVATwQLwLZKuoy/Ojq7jkPic
	sOL6xqVb3atwd+YUefuA6AEnjW1OPlNY9OPLx2SoDvpUZv4XNgKWm42ZB/gkOeKwdvSYhCxWJa6Fe
	+4dCpzVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tuEVs-00000009F0q-1WfY;
	Mon, 17 Mar 2025 17:44:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC2FD300783; Mon, 17 Mar 2025 18:44:31 +0100 (CET)
Date: Mon, 17 Mar 2025 18:44:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH RFC] sched_ext: Choose prev_cpu if idle and cache affine
 without WF_SYNC
Message-ID: <20250317174431.GI6888@noisy.programming.kicks-ass.net>
References: <20250317082803.3071809-1-joelagnelf@nvidia.com>
 <Z9hW_3cPN8u7VURV@slm.duckdns.org>
 <Z9hcUSp6P72wT5ig@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9hcUSp6P72wT5ig@gpd3>

On Mon, Mar 17, 2025 at 06:30:57PM +0100, Andrea Righi wrote:

> I guess the question is: what is more expensive in general on task wakeup?
> 1) a cross-node migration or 2) running on a partially busy SMT core?

That totally depends on both the workload and the actual machine :/

If you have 'fast' numa and not a very big footprint, the numa
migrations aren't too bad. OTOH if you have sucky numa or your memory
footprint is significant, then running on the wrong node is super
painful.


