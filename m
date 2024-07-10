Return-Path: <linux-kernel+bounces-247536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BC892D0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 13:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D41F24403
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB6190492;
	Wed, 10 Jul 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pqb/wdjI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767C1190486
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 11:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611711; cv=none; b=pZGIOxZYzfzCPwcfLKEi27/iS4rRtyQ0HUPoAelDe5IeKK6cQiUBn63gW1hcX4Oqgv3hDqcTxa5pCgFRwk2JH8+uYNa16L9MEPs3Yb89OweUxo0Ae6mRGmRtacONCO08OiEf3svKye5JH3nleBEnNxmX1Rznrl/vDRb6je18YcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611711; c=relaxed/simple;
	bh=SevchnRjLxN262FH3CoJo6NLdyefYAkp5DdHLTpmSoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVlui0GmX3in9aXkTg2KkFdzyOOu89CkeMzzjZ8cgoSgg0RFIaGs+58qJX34wN+5PECmEZOFEG5hctzISpxMx4JEDaiDRQezYVEIF26EjSl/JzIfkcPLsvxDdozDlQ8+1BHqL7buFPoF3CTKRzusD7tevljd8TeXikShHGJYZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pqb/wdjI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ys+KAWxJuasF9TIEMynAnbA52tKXzDW2JdSwnqUx9Ss=; b=pqb/wdjIGjR8fvZ7/wHo5I3CqC
	mb4VkD2NjBeNFuZ3+B4fNC+OEXVPK3jZ6z25Y0lltkDIqRZ518q1qUKtEy6dF6UESqhozrbdA5g8e
	wceJdSnX2eBsfz84qBHJrhxiH9Rv/JSiwcycAoj1j1A+7QXAkxk7BG0XSV45ljXJOFSV9G61c/jel
	zEHOejGpRWurZpUw+NQrNdCw+ztFhQYxgDarsDfv9xJ5NzDAi2fcovnNdr+r/Qf2F9VPTq6lX8Vb3
	Em7L/PcTj1qZxBUEpCRdSj/is0aOJto8n/YbYgboPM/sD7RxcxzjgxvMreTEn2UCCB+FgzQm1Xmjf
	EwIlJQqw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRVhf-00000009CxE-0fT1;
	Wed, 10 Jul 2024 11:41:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C6323300694; Wed, 10 Jul 2024 13:41:42 +0200 (CEST)
Date: Wed, 10 Jul 2024 13:41:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <righi.andrea@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, void@manifault.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	schatzberg.dan@gmail.com, mingo@redhat.com, changwoo@igalia.com
Subject: Re: [PATCH 3/6] sched_ext: Make @rf optional for
 dispatch_to_local_dsq()
Message-ID: <20240710114142.GY27299@noisy.programming.kicks-ass.net>
References: <20240709212137.1199269-1-tj@kernel.org>
 <20240709212137.1199269-4-tj@kernel.org>
 <Zo5Ncd8DxGSVztoH@gpd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo5Ncd8DxGSVztoH@gpd>

On Wed, Jul 10, 2024 at 10:59:29AM +0200, Andrea Righi wrote:
> On Tue, Jul 09, 2024 at 11:21:09AM -1000, Tejun Heo wrote:
> ...
> > @@ -2052,17 +2052,20 @@ static bool move_task_to_local_dsq(struct rq *rq, struct task_struct *p,
> >  static void dispatch_to_local_dsq_lock(struct rq *rq, struct rq_flags *rf,
> >  				       struct rq *src_rq, struct rq *dst_rq)
> >  {
> > -	rq_unpin_lock(rq, rf);
> > +	if (rf)
> > +		rq_unpin_lock(rq, rf);
> >  
> >  	if (src_rq == dst_rq) {
> >  		raw_spin_rq_unlock(rq);
> >  		raw_spin_rq_lock(dst_rq);
> >  	} else if (rq == src_rq) {
> >  		double_lock_balance(rq, dst_rq);
> > -		rq_repin_lock(rq, rf);
> > +		if (rf)
> > +			rq_repin_lock(rq, rf);
> >  	} else if (rq == dst_rq) {
> >  		double_lock_balance(rq, src_rq);
> > -		rq_repin_lock(rq, rf);
> > +		if (rf)
> > +			rq_repin_lock(rq, rf);
> >  	} else {
> >  		raw_spin_rq_unlock(rq);
> >  		double_rq_lock(src_rq, dst_rq);
> 
> Not a blocker, but would it make sense to provide some wrappers for
> rq_unpin_lock() / rq_repin_lock() to simply return if rf == NULL?

There are very limited contexts where unpin is sound. I have no idea if
this is one of them or not.

