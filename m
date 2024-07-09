Return-Path: <linux-kernel+bounces-246035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5913592BCF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8979E1C22542
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BC015FA6B;
	Tue,  9 Jul 2024 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q+Zt6v3G"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418921586F2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535544; cv=none; b=Wgk87m44o/12kMX70uLhp/GHuCvd9KtUo7O0lYJRkca9TOyWW+6P5k+pGOBzXroFeVQmFGe+Er/PvDFmK/TMQyM+i/xltluXlg2MMUUZbTI2TeKeiG31R9GeVzq9BQEBl1+AZn3xkpNy0QQq5v8gyVNp+mwltBQfdoLiG8zdnEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535544; c=relaxed/simple;
	bh=JltaKZeZoPepmvo00u/7n5SPVjFNCaLOZb0flPvDeAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbsVDayfVFkbY1FfqXWD+wK2r7ceo+odvuzIhXMzPJyPyIW77BRM4pdDrlTnUzJswc7JDsjmA96mnHoXia/51gSg33yhEfIuPgIGBnsj3+M9e9Imd1zsrWh3vciTeRZ2ve7Qk3qz68W/Uyia8/EJNLZuGZrxpum9zwO3iWRlpME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q+Zt6v3G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QnQRtEAFTGpYXZppPGig49Hw32QYDPganEH//DlgqbE=; b=q+Zt6v3G62lVSZusFd3z6LRnSi
	ToFQFdFMfPa3qMg3pYIrSYb9Wx3AatGkskxEV0MJ7Nk8UoEJkVtO6FaG4UdN3Y3uzmKQNgAenRqvB
	hQUPoT+q1zLhQP3qmpgYUYJeOipH5ezowCZ8yU2iGi4bvV/4C2M5tFIPEKhb7X9bIyQ9KGEBIAzXt
	IPoQhpa5gRZ5yb2raT3Mp3krMSq6dOlsIA4IahHh4AGVrwL3ZpsHtUgp8BPdJp3+uhpKx0w9MVvp/
	RmE7jUWFbTYJ32fNAl1/Vv4CmNyUOgkSJ5xCdRaNNCMWUDjk+K+j1kgGBErd+KMmSG9DZXFclz3G0
	f50SUhgw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRBtD-00000007yQI-0zJ0;
	Tue, 09 Jul 2024 14:32:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D70F63006B7; Tue,  9 Jul 2024 16:32:18 +0200 (CEST)
Date: Tue, 9 Jul 2024 16:32:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709143218.GM27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
 <20240709120551.GK27299@noisy.programming.kicks-ass.net>
 <20240709133349.GC28495@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709133349.GC28495@redhat.com>

On Tue, Jul 09, 2024 at 03:33:49PM +0200, Oleg Nesterov wrote:
> On 07/09, Peter Zijlstra wrote:
> >
> > > +	guard(srcu)(&uprobes_srcu);
> > > +
> > > +	for_each_consumer_rcu(uc, uprobe->consumers) {
> > >  		int rc = 0;
> > >
> > >  		if (uc->handler) {
> > > @@ -2116,7 +2126,6 @@ static void handler_chain(struct uprobe
> > >  		WARN_ON(!uprobe_is_active(uprobe));
> > >  		unapply_uprobe(uprobe, current->mm);
> >
> >    ^^^ this remove case needs more thought.
> 
> Yeah... that is why the current code doesn't use ->consumer_rwsem, iirc.

AFAICT something like the below should work. Concurrent
remove_breakpoint() should already be possible today and doesn't appear
to be a problem.

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1260,6 +1260,10 @@ int uprobe_apply(struct inode *inode, lo
 	return ret;
 }
 
+/*
+ * Can race against uprobe_unregister() / register_for_each_vma(), and relies
+ * on duplicate remove_breakpoint() being a no-op.
+ */
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
 	VMA_ITERATOR(vmi, mm, 0);
@@ -2101,6 +2105,7 @@ static void handler_chain(struct uprobe
 	struct uprobe_consumer *uc;
 	int remove = UPROBE_HANDLER_REMOVE;
 	bool need_prep = false; /* prepare return uprobe, when needed */
+	bool had_handler = false;
 
 	down_read(&uprobe->register_rwsem);
 	for (uc = uprobe->consumers; uc; uc = uc->next) {
@@ -2115,16 +2120,26 @@ static void handler_chain(struct uprobe
 		if (uc->ret_handler)
 			need_prep = true;
 
+		/*
+		 * A single handler that does not mask out REMOVE, means the
+		 * probe stays.
+		 */
+		had_handler = true;
 		remove &= rc;
 	}
 
+	/*
+	 * If there were no handlers called, nobody asked for it to be removed
+	 * but also nobody got to mask the value. Fix it up.
+	 */
+	if (!had_handler)
+		remove = 0;
+
 	if (need_prep && !remove)
 		prepare_uretprobe(uprobe, regs); /* put bp at return */
 
-	if (remove && uprobe->consumers) {
-		WARN_ON(!uprobe_is_active(uprobe));
+	if (remove)
 		unapply_uprobe(uprobe, current->mm);
-	}
 	up_read(&uprobe->register_rwsem);
 }
 

