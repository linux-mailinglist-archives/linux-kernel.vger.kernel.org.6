Return-Path: <linux-kernel+bounces-522493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB3CA3CB17
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9F189DAF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD852580C6;
	Wed, 19 Feb 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H7gvGTJ5"
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC008253F17
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999252; cv=none; b=W8MGr0/U/1ptkqdAZXTkCRhEQfeS70vCAw6GQ6v65RnJryRlb+cTabWJxu5pZa1N0nxugioLr5/2FY6dDBsX36MLQjx8h8RFHkcr4ROdm71LLuuEQmi3ZQyjCijD+Chb3YHaFE5EnENIXID4Q7OEar/lpoPwT85FlzP2zDBPHBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999252; c=relaxed/simple;
	bh=e/o1eQ+leB7IhLSLHZ3eYHIb2TXAYIu+EOXT1rWeLvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmtkZgVPN2kLmNgyaXv/9997syryzTIIdtIh1OWIU94XzSabrMIeQvn+MSmMe1kb4+3s+QNNbbfFcY048uC33V16+Tm7bUFljXMBGbtFa4Xf6V4uIQeTOYurATae/BSG31zAmajmc9LgRlpQ8oC0EIAG8nuppSoDDN2D7psQi5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H7gvGTJ5; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Feb 2025 16:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739999249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZrtR3/3Axl9EnmDRnXytD77e8XV+26r4Yh3abGA8gI=;
	b=H7gvGTJ5ezYtzvKj+zN4UN67iWeEHtqbMXfAr/TBIeGDrCLh1bjpsh+dAlP4YDfKv1wMRT
	HP4pMvwcqIYRuZ/FmR3QoqRAe+dS1Tz09AYLbXd7fxjuGp60RMvdRW1ddrx7U4PgEb7fg+
	cnSpO8EdtLQH4BuDoBKG1C3ZRkMoqXw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: paulmck@kernel.org, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, rcu@vger.kernel.org
Subject: Re: [PATCH v2 -rcu] srcu: Use rcu_seq_done_exact() for polling API
Message-ID: <dyzwqkaldmoi7qircj6plzp6wnghvkmrxjbaf4ejvv7xy6t4p2@ea7mpkosxju2>
References: <20250219124309.463702-1-joelagnelf@nvidia.com>
 <dde0f073-c3d9-44c9-bd85-cf0e8a0fd628@paulmck-laptop>
 <52320693-3247-454f-931f-d9e23592862a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52320693-3247-454f-931f-d9e23592862a@nvidia.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 19, 2025 at 08:29:47AM -0500, Joel Fernandes wrote:
> 
> 
> On 2/19/2025 8:22 AM, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2025 at 07:43:08AM -0500, Joel Fernandes wrote:
> >> poll_state_synchronize_srcu() uses rcu_seq_done() unlike
> >> poll_state_synchronize_rcu() which uses rcu_seq_done_exact().
> >>
> >> The  rcu_seq_done_exact() makes more sense for polling API, as with
> >> this API, there is a higher chance that there is a significant delay
> >> between the get_state..() and poll_state..() calls since a cookie
> >> can be stored and reused at a later time. During such a delay, if
> >> the gp_seq counter progresses more than ULONG_MAX/2 distance, then
> >> poll_state..() may return false for a long time unwantedly.
> >>
> >> Fix by using the more accurate rcu_seq_done_exact() API which is
> >> exactly what straight RCU's polling does.
> >>
> >> It may make sense, as future work, to add debug code here as well, where
> >> we compare a physical timestamp between get_state..() and poll_state()
> >> calls and yell if significant time has past but the grace period has
> >> still not progressed.
> >>
> >> Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> >> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > But we should also run this by Kent Overstreet, given that bcachefs
> > uses this.  Should be OK, given that bcachefs uses this API in the same
> > way that it does poll_state_synchronize_rcu(), but still...
> 
> Thanks Paul!  Adding Kent Overstreet to the email to raise any objections.

It sounds like rcu_done_exact() is indeed what we want - bcachefs uses
this for determining when objects may be reclaimed (as is typical with
rcu), so we don't want objects to be stranded a "significant time past
the grace period".

Is there any additional cost? I'm not seeing rcu_done_exact() in Linus's
tree yet. Minor additional overhead would be totally fine; we use this
from fs/bcachefs/rcu_pending.c which doesn't call it for each object.

