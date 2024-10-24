Return-Path: <linux-kernel+bounces-380099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9FF9AE8E6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B85293BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78621EBA04;
	Thu, 24 Oct 2024 14:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG/jPtm8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BC1E3796
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780201; cv=none; b=pm9F4O8kKMEYFCPzC2w32TC8j48yPj4J+yI95vlQOKE04i6WfQVrANIcLp0owby5l9l+iKlHtE9dHs3W/D/zr4RJFt6ZL+66McF3gsDQKJt7I7uvIVP3tZt+B8/NKnm+45TyzvZn1Fq7lTbYY1n1v62E1GyCnXX3PvYLm64kt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780201; c=relaxed/simple;
	bh=jeysmufCSh1/W2WyVA55Zr0AbZ84Pcll53G1L+wY25g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgSUqzRT7OqRHdl7Q/LFBb7rHIzxl+m0vxxfBmOp9ho8z9myYsOb/qPXNQvlKAeIwPHNQWb+3ZYsomJnSO7ag0Abzp+AUi6Hrv6diXurtMuO2dF5oV+opF2dzek6J/K/CA63tAJYESHxc2ZAqIJ/z9+odfmfwUavy9e7oBWkzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG/jPtm8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54609C4CEE3;
	Thu, 24 Oct 2024 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729780200;
	bh=jeysmufCSh1/W2WyVA55Zr0AbZ84Pcll53G1L+wY25g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QG/jPtm8s/TnbrbEdHWTJzbpGcnIUHg7rXwxhmuzQgMcwo2/e62FPeY5ntOlbSbLs
	 wCV5o57/ACsI5ReHme/5oWFf1bq2rj7nl89/iQCMJ3Tf44H7HFAdK+6Es8/6QA0wnc
	 7KZVSMLa6eme192Ul+5C+oSC80M4jiZhiABuLls2G4Mlt+d+TjjTbvI95tSaqMprzr
	 1VEC5VtNt2SczV/I/CXvqBNf4zPra1xGz/lyjF8hYdHpyya9dnU32+LzmoOk2K13by
	 5rxT7//0Fc3MmLCaGU5dV9zRu5r6+FsO9NYMFKRsLj3u7OVnunLaJGo/R3s4g3meN0
	 yg5l0FwghHHqQ==
Date: Thu, 24 Oct 2024 16:29:57 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 10/20] net: pktgen: Use kthread_create_on_node()
Message-ID: <ZxpZ5fJEbjc9IucL@localhost.localdomain>
References: <20240926224910.11106-1-frederic@kernel.org>
 <20240926224910.11106-11-frederic@kernel.org>
 <Zvrdq43viQlcyk-K@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zvrdq43viQlcyk-K@linux.ibm.com>

Le Mon, Sep 30, 2024 at 10:49:39PM +0530, Vishal Chourasia a écrit :
> On Fri, Sep 27, 2024 at 12:48:58AM +0200, Frederic Weisbecker wrote:
> > Use the proper API instead of open coding it.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  net/core/pktgen.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/core/pktgen.c b/net/core/pktgen.c
> > index 34f68ef74b8f..7fcb4fc7a5d6 100644
> > --- a/net/core/pktgen.c
> > +++ b/net/core/pktgen.c
> > @@ -3883,17 +3883,14 @@ static int __net_init pktgen_create_thread(int cpu, struct pktgen_net *pn)
> >  	list_add_tail(&t->th_list, &pn->pktgen_threads);
> >  	init_completion(&t->start_done);
> >  
> > -	p = kthread_create_on_node(pktgen_thread_worker,
> > -				   t,
> > -				   cpu_to_node(cpu),
> > -				   "kpktgend_%d", cpu);
> > +	p = kthread_create_on_cpu(pktgen_thread_worker, t, cpu, "kpktgend_%d");
> Hi Frederic, 
> 
> The Subject line says "Use kthread_create_on_node()" while
> kthread_create_on_cpu is used in the diff.

Thanks!

Fixing this.

