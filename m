Return-Path: <linux-kernel+bounces-174622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F35AF8C11C7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 17:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4121F2487E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93986131723;
	Thu,  9 May 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inQckuKn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F15015EFC7
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267700; cv=none; b=YUOtKkTz1a9j22DAJABfjan+eCP5sQJFVjKX9yZ9Tr+U0vE40LDVmie7N31orrkH9K6FAuHfy/vYtLYSlPzKDuj0ZFs24M10HdLwMUCt6ryef8xiTqEE7XQvi3BIqJ5cj96VOE+s29RCE7Dp54T1if9mY+NpjHKEkuXUaY4oiSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267700; c=relaxed/simple;
	bh=sc74tBRMVvyTIdXQ9GqJohO+ywn2hU9eX2MnEwP3XK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUBv773rFKeZ/W7qeTDIFtNLyTdUQ9xQAH58XDVLPzqCpx3Lx0uY9vF+JEYHxcQSbO5iURBdpYOtPI0Z3Ah9SkoPIbUDynf0Ogf9k87bO1VfKN+WxBEZbGwm8d56EIXfeFbzZ/zHKx1xQGQDQkaimRrp8ut8D1aGbYcqCQcwOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inQckuKn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715267686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYnzWWSL9wgQpzexR+ABGgs/vlGO/GpNcmd0n9BQDz0=;
	b=inQckuKnIif0KWePcgt2p+wlpODGZ0WQxffGsXNcKrMJ1njnLW4KLrsV/2etm/YSYB7nWB
	q5dzGrSyF3sWJneAKDJFgld/6O6v2DyW1dO7QcipP65ytZIuD7hQGqeep7b2XIufhtacPj
	dIEjTc1yXhVHtIEe/shOx30XDsxkfyY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-DXZ-1WvIMXO1hQdBwgvjqw-1; Thu, 09 May 2024 11:14:42 -0400
X-MC-Unique: DXZ-1WvIMXO1hQdBwgvjqw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0CD58857A81;
	Thu,  9 May 2024 15:14:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.91])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0F1C24A43EE;
	Thu,  9 May 2024 15:14:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  9 May 2024 17:13:16 +0200 (CEST)
Date: Thu, 9 May 2024 17:13:12 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 25/48] rcu: Mark writes to rcu_sync ->gp_count field
Message-ID: <20240509151312.GA22612@redhat.com>
References: <20240507093530.3043-1-urezki@gmail.com>
 <20240507093530.3043-26-urezki@gmail.com>
 <ZjpAsYJIfzYSKgdA@redhat.com>
 <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9e89b5-c981-4809-8bc2-247563ce04e9@paulmck-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On 05/07, Paul E. McKenney wrote:
>
> On Tue, May 07, 2024 at 10:54:41AM -0400, Oleg Nesterov wrote:
> > Hello,
> >
> > I feel I don't really like this patch but I am travelling without my working
> > laptop, can't read the source code ;) Quite possibly I am wrong, I'll return
> > to this when I get back on May 10.
>
> By the stricter data-race rules used in RCU code [1], this is a bug that
> needs to be fixed.

Now that I can read the code... Sorry, still can't understand.

> which is read locklessly,

Where???

OK, OK, we have

	// rcu_sync_exit()
	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0)

and

	// rcu_sync_dtor()
	WARN_ON_ONCE(READ_ONCE(rsp->gp_count));

other than that ->gp_count is always accessed under ->rss_lock.

And yes, at least WARN_ON_ONCE() in rcu_sync_exit() can obviously race with
rcu_sync_enter/exit which update gp_count. I think this is fine correctness-wise.

But OK, we need to please KCSAN (or is there another problem I missed ???)

We can move these WARN_ON()'s into the ->rss_lock protected section.

Or perhaps we can use data_race(rsp->gp_count) ? To be honest I thought
that READ_ONCE() should be enough...

Or we can simply kill these WARN_ON_ONCE()'s.

I don't understand why should we add more WRITE_ONCE()'s into the critical
section protected by ->rss_lock.

Help! ;)

Oleg.


which in turn results in a data race.  The fix is to mark
> the updates (as below) with WRITE_ONCE().
>
> Or is there something in one or the other of these updates to ->gp_count
> that excludes lockless readers?  (I am not seeing it, but you know this
> code way better than I do!)
>
> 							Thanx, Paul
>
> [1] https://docs.google.com/document/d/1FwZaXSg3A55ivVoWffA9iMuhJ3_Gmj_E494dLYjjyLQ/edit?usp=sharing
>
> > Oleg.
> >
> > On 05/07, Uladzislau Rezki (Sony) wrote:
> > >
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > >
> > > The rcu_sync structure's ->gp_count field is updated under the protection
> > > of ->rss_lock, but read locklessly, and KCSAN noted the data race.
> > > This commit therefore uses WRITE_ONCE() to do this update to clearly
> > > document its racy nature.
> > >
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Cc: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > ---
> > >  kernel/rcu/sync.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
> > > index 86df878a2fee..6c2bd9001adc 100644
> > > --- a/kernel/rcu/sync.c
> > > +++ b/kernel/rcu/sync.c
> > > @@ -122,7 +122,7 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> > >  		 * we are called at early boot time but this shouldn't happen.
> > >  		 */
> > >  	}
> > > -	rsp->gp_count++;
> > > +	WRITE_ONCE(rsp->gp_count, rsp->gp_count + 1);
> > >  	spin_unlock_irq(&rsp->rss_lock);
> > >
> > >  	if (gp_state == GP_IDLE) {
> > > @@ -151,11 +151,15 @@ void rcu_sync_enter(struct rcu_sync *rsp)
> > >   */
> > >  void rcu_sync_exit(struct rcu_sync *rsp)
> > >  {
> > > +	int gpc;
> > > +
> > >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_state) == GP_IDLE);
> > >  	WARN_ON_ONCE(READ_ONCE(rsp->gp_count) == 0);
> > >
> > >  	spin_lock_irq(&rsp->rss_lock);
> > > -	if (!--rsp->gp_count) {
> > > +	gpc = rsp->gp_count - 1;
> > > +	WRITE_ONCE(rsp->gp_count, gpc);
> > > +	if (!gpc) {
> > >  		if (rsp->gp_state == GP_PASSED) {
> > >  			WRITE_ONCE(rsp->gp_state, GP_EXIT);
> > >  			rcu_sync_call(rsp);
> > > --
> > > 2.39.2
> > >
> >
>


