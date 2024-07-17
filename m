Return-Path: <linux-kernel+bounces-255160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C52E933CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67A31F24635
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CB17F519;
	Wed, 17 Jul 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kb/M8cE3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EE38385
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218684; cv=none; b=Z03EQO1/J3EBlz3CrTjPVZU23ypJ16+BpGzaL9xkbqAtBgesoYp4eDv0hMjJzA3BoGpMBcMieGC/N6T4cImNaLOdK+tjhhnNuP3bfMw01i3DdLyDNN5LLQCuZ48gDjHMr0M3ZJ0Kl39pHBhXxoYh4qqqDZjI3ZlwOMJQJwMWEJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218684; c=relaxed/simple;
	bh=tlJVdj+vMWNG4SYX2reBkxB8umy++v3m6pGGfORZsVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvTCIgfPg7tvK/5a3btcqPuj/kwuY0skbnWZq8930zwFGWZ7+FJfcLS+H8wf0b0Xb4GJxv07dYAoLpophsO+2QtWOa4d76vIWtySvZO3qXYZ780xt6s64HQh5J0iHMVwM3C8VFR98568O8lJfjE3/kdTIbc5LvdVFNJhodEL4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kb/M8cE3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HD1X/xED2ivKmDNo41Ze1f1M/4iNVEMmwW8Y8uRodf8=; b=kb/M8cE3NL/Y+XfH+ZxgIttE5w
	22Mx38b6kSMozprtwJmuTf6WLy9ucmhdDw7VhIajJOuJ+NVKZrRPR9U/AWjdBMpQew9fIWVxAOa+F
	oJiWzt16B3y7gGXtU9kjWR43t/htwc2vVjJKVbvR17Sl34kqecqnSwNqO3HF1WIUxhrTCzzV2nz1P
	3NkIOTxig+bdQwkPPp8Xf447+iN1PXCFY0kmdQJ18WnfcOjuIgYEm3whIGuJOCyTUi4a/PgNsgMjw
	YDa9htbo3QdEwVNrnkvMZSOVVdEslXJJhhhlST+ImL/mklilzcR4uPDMv8QV3mcRqoi0OHyYy/rs3
	o9J5smTg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU3bO-00000000oNV-175K;
	Wed, 17 Jul 2024 12:17:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 782603002C7; Wed, 17 Jul 2024 14:17:45 +0200 (CEST)
Date: Wed, 17 Jul 2024 14:17:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Chen Yu <yu.chen.surf@gmail.com>, Aaron Lu <aaron.lu@intel.com>,
	linux-kernel@vger.kernel.org, void@manifault.com
Subject: Re: [RFC PATCH 0/7] Optimization to reduce the cost of newidle
 balance
Message-ID: <20240717121745.GF26750@noisy.programming.kicks-ass.net>
References: <cover.1690273854.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690273854.git.yu.c.chen@intel.com>

On Thu, Jul 27, 2023 at 10:33:58PM +0800, Chen Yu wrote:
> Hi,
> 
> This is the second version of the newidle balance optimization[1].
> It aims to reduce the cost of newidle balance which is found to
> occupy noticeable CPU cycles on some high-core count systems.
> 
> For example, when running sqlite on Intel Sapphire Rapids, which has
> 2 x 56C/112T = 224 CPUs:
> 
> 6.69%    0.09%  sqlite3     [kernel.kallsyms]   [k] newidle_balance
> 5.39%    4.71%  sqlite3     [kernel.kallsyms]   [k] update_sd_lb_stats
> 
> To mitigate this cost, the optimization is inspired by the question
> raised by Tim:
> Do we always have to find the busiest group and pull from it? Would
> a relatively busy group be enough?

So doesn't this basically boil down to recognising that new-idle might
not be the same as regular load-balancing -- we need any task, fast,
rather than we need to make equal load.

David's shared runqueue patches did the same, they re-imagined this very
path.

Now, David's thing went side-ways because of some regression that wasn't
further investigated.

But it occurs to me this might be the same thing that Prateek chased
down here:

  https://lkml.kernel.org/r/20240710090210.41856-1-kprateek.nayak@amd.com

Hmm ?

Supposing that is indeed the case, I think it makes more sense to
proceed with that approach. That is, completely redo the sub-numa new
idle balance.



