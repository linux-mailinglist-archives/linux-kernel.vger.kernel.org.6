Return-Path: <linux-kernel+bounces-396218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C7C9BC976
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 10:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CD89281895
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 09:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B34F1D040B;
	Tue,  5 Nov 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YTvdVs3m"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC1E1CEAA0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799683; cv=none; b=CJL5PReQUhnRFpf3WZWa7SyBtJ1frxOSL32ufoNAOnR6xoMwa9576rGp6iuKoBcr8l6n4HM0PeEKKlYePONlv6gDKtSVJALke0bPTeKBSOZOFF4h4OETZxxKaXTPAdb8BD16eENwqba4Oy0buP6n1f+9xvmmgTpWb0yTbFXqpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799683; c=relaxed/simple;
	bh=UIZkdkaPNbpizRMannyGT9YL5Aw5aae17itjwAtmfsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoGkxb/6gx46Q7nefLn24GgGTHhcXwgbxuI4niryQXSlFGrCH2s86T9LOFrhOUtdrMNEUR/GGWDiu4iucyYO3HYrbUBEkppgh+ETdx0+3wdjjkpUu5YiKyI2/4PYi+ttO0w7U5Cfkb/h87DgM/AM1zi9agfEow8f7C1dUt08naM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YTvdVs3m; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z8kH650L1UR0Vg33/2iiIpMIQ3EUCdNJGgzftwXxcEI=; b=YTvdVs3mxZ4d/szkxise4hjPyK
	ECQ3Fj5MkWgsgm5tgTR9K7J53gBgPdshMZTEUD+S32WC4Ewe9kvp5SnF5bAoQcxIN8gdEljYXY0+7
	1sE2xM9hurybmQY+iBClMkNV9vcAyukeftYXbmAqjwXgbajDQI0bVTOxXm+ilWtTKNG+myk7UcxZh
	fwjDZ99+FRu1+3PATlV5K9gt7FaNx4sBFnvrfiULvGvvHbyj6SgZAtR680BJxdJwQBcnFY7FRoE/M
	aClju/9dq+bOTuKn7oDKy1qJC8GxfZjiHp/KCUvlrpTeT9DAjFSag2X2zMYjgrD+oVq1iZZWsgInk
	T/Q8a5Uw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8G3o-0000000BiOG-2CUo;
	Tue, 05 Nov 2024 09:41:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BAF8330083E; Tue,  5 Nov 2024 10:41:15 +0100 (CET)
Date: Tue, 5 Nov 2024 10:41:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 5/5] kcsan, seqlock: Fix incorrect assumption in
 read_seqbegin()
Message-ID: <20241105094115.GX33184@noisy.programming.kicks-ass.net>
References: <20241104161910.780003-1-elver@google.com>
 <20241104161910.780003-6-elver@google.com>
 <20241105093400.GA10375@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105093400.GA10375@noisy.programming.kicks-ass.net>

On Tue, Nov 05, 2024 at 10:34:00AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 04, 2024 at 04:43:09PM +0100, Marco Elver wrote:
> > During testing of the preceding changes, I noticed that in some cases,
> > current->kcsan_ctx.in_flat_atomic remained true until task exit. This is
> > obviously wrong, because _all_ accesses for the given task will be
> > treated as atomic, resulting in false negatives i.e. missed data races.
> > 
> > Debugging led to fs/dcache.c, where we can see this usage of seqlock:
> > 
> > 	struct dentry *d_lookup(const struct dentry *parent, const struct qstr *name)
> > 	{
> > 		struct dentry *dentry;
> > 		unsigned seq;
> > 
> > 		do {
> > 			seq = read_seqbegin(&rename_lock);
> > 			dentry = __d_lookup(parent, name);
> > 			if (dentry)
> > 				break;
> > 		} while (read_seqretry(&rename_lock, seq));
> > 	[...]
> 
> 
> How's something like this completely untested hack?
> 
> 
> 	struct dentry *dentry;
> 
> 	read_seqcount_scope (&rename_lock) {
> 		dentry = __d_lookup(parent, name);
> 		if (dentry)
> 			break;
> 	}
> 
> 
> But perhaps naming isn't right, s/_scope/_loop/ ?

It is also confused between seqcount and seqlock. So perhaps it should
read:

	read_seqcount_loop (&rename_lock.seqcount) {
	   ...
	}

instead.

