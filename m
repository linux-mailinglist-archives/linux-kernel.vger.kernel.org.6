Return-Path: <linux-kernel+bounces-380285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8D19AEBAA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC561C21D93
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB61F76C8;
	Thu, 24 Oct 2024 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hyh7jfbE"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF55B1AE005;
	Thu, 24 Oct 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786693; cv=none; b=tW47vmn2IE4jzvGGkherzJ/rZpQvC95rmmhLA/EUiG57+NA33BvJ+wA2z3/dhZjH11JpTNHYChwmXdnBNpHQUt96oyRUnwJj/6/n7pYkydDlolUFGFBnn5cWrGbLmoZnd6kHcl7ydtLeaPWKjV1LJbQL51mjpTJfSsq+1B041Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786693; c=relaxed/simple;
	bh=eACe4BV7izCB9TZCjey9Dz3CscEhpMH8kIe4r6aUA8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWdsFOpXoGCowFkAMOeQtjcC35nSyJjccyeZ3lgto85unTjj1F7D8RiWpsFgz3UN7UDNYpecdnwtFIDPYfGDugcsXTAyDhtqIbUSDIAkhLO0PWrG4uqTYIeS60bKV5T3uhJGMpcISEmNrS+Qg6ucOtFoQB1mRBXP8NmzrSiDXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hyh7jfbE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mEPllzIKJ41a2AXuCEun1BBXDaydWS3LbCjq9Yk6Xss=; b=Hyh7jfbE5a6YERoZ5qv/rTHnF9
	Dtu/acJsFnb1wrfvRYnsx2piWR724s0fm+nds/jJ0tYQkwr2UcF8G/0pPY71dN/KYeu5Amo3kipPJ
	0oJyakwSl/aA9CxnO058gVjHxM5S4adgquMtLU0BGZitiJh0l95Y1wHvDEfILzebbIAk2BGGULbCI
	AwJQfE7UdzTzgsMInmMZHTn13eByz4uKO/jarri2zYPx/l0hleXKaX8kDm90ADgb0Wxw/QjA1AK4q
	tFSKurq47zOEgIjuxf0Lf1qTKcLhaGpM8q3u0yNwgq8abIkZw/iNSofe1OCSiVzUVfCuX3bbqahkK
	BWN6v/YA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t40XA-00000004N0f-1qis;
	Thu, 24 Oct 2024 16:18:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2A07F300599; Thu, 24 Oct 2024 18:18:00 +0200 (CEST)
Date: Thu, 24 Oct 2024 18:18:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Lyude Paul <lyude@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
	Dirk Behme <dirk.behme@gmail.com>, rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>, airlied@redhat.com,
	Ingo Molnar <mingo@redhat.com>, will@kernel.org,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, wedsonaf@gmail.com,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>, aliceryhl@google.com,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [POC 1/6] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20241024161759.GF9767@noisy.programming.kicks-ass.net>
References: <1eaf7f61-4458-4d15-bbe6-7fd2e34723f4@app.fastmail.com>
 <20241018055125.2784186-1-boqun.feng@gmail.com>
 <20241018055125.2784186-2-boqun.feng@gmail.com>
 <09dab2fd1a8fc8caee2758563c0174030f7dd8c2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09dab2fd1a8fc8caee2758563c0174030f7dd8c2.camel@redhat.com>

On Mon, Oct 21, 2024 at 04:44:02PM -0400, Lyude Paul wrote:

> I like this so far (at least, assuming we consider making 
> raw_spin_lock_irq_disable() and enable() temporary names, and then following
> up with some automated conversions across the kernel using coccinelle).

Well, I hated adding a 3rd spinlock API enough that I tried replacing
the whole of irqsave/irqrestore with this thing in one go, and that is
utterly failing to boot :-(

Coccinelle isn't going to help I'm afraid.


