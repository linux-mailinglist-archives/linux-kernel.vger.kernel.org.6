Return-Path: <linux-kernel+bounces-526509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52989A3FFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0C019E06D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3124C2512F6;
	Fri, 21 Feb 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QmQyT55i"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C55223
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740165710; cv=none; b=KHcn/hlNLmzNs1VFzZBsMR6Lp2jB5BIRY1aksHDyJUQXS9M+BOnI3AlgzwzfdaA7jUV9/ORmS61f0xzQZiZkRGvrcjz8EWy9VyDGLDlb8QJW3UKSNfloOET1FXBvQ+uVNhBDX5ZgQo/g8m25CZFrJ7xTTBN2AjR8pbSb0ENCQio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740165710; c=relaxed/simple;
	bh=AE2g6+aGRUljboHDO9DcIfZ/V/y8WQjPyl3LlS1icIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASNtWsZCT5NnhtIbhngWAheFJqlxd8deZ36bIGj9AddNL24qlDqzCq3LVO+j7LSl05CMbxhy/G6LahHPppeFPkr9+NSs+M0NJqnufqsr5OW3BxxJq5HDkSFT3dLg9MeZ1f0UH1yqy1KyHoWCzYeejkn/7iCNAYqiqvEJreT7GYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QmQyT55i; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MPtV3jcADDpRsSjNnVTPvU7MlkHEQFqKy/MluV3hk/Q=; b=QmQyT55inVjixzpv70bSmXmI8f
	QEJ2DDMku8iaDb1o8AQR2ziN1OWy4LD240JPeDzbyHkqEB3kzI/uzZwZ+idmxjRmkSxjXB52UdXd4
	K2GZ2kZ/4NxwIK1xO8CvrYDewa5UYUuB1qtvRttf8u84dHCb6Q4qzi35w9KptkFv10u315CeDwgjX
	+SbqDDteWGFVghS3lcFYTfcDvhYZB4XWHl67u0FZS5juMNUgX2MrVd189W3NM1+jZJ3OfYGS4B9W/
	P2b25ERzs+mCVf70pqTvmlrMsNiuwGRVMJ4UYwbXhS+hGGlZYdzYo1tL+35IMPJKtNRfZ4SbXF8ow
	3jqy9q5Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tlYak-00000002iVl-07lu;
	Fri, 21 Feb 2025 19:21:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A39FE30066A; Fri, 21 Feb 2025 20:21:41 +0100 (CET)
Date: Fri, 21 Feb 2025 20:21:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 00/15] futex: Add support task local hash maps.
Message-ID: <20250221192141.GF7373@noisy.programming.kicks-ass.net>
References: <20250203135935.440018-1-bigeasy@linutronix.de>
 <20250204151405.GW7145@noisy.programming.kicks-ass.net>
 <20250205122026.l6AQ2lf7@linutronix.de>
 <20250220151206.GB11590@noisy.programming.kicks-ass.net>
 <20250221160043.02H2_t3P@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221160043.02H2_t3P@linutronix.de>

On Fri, Feb 21, 2025 at 05:00:43PM +0100, Sebastian Andrzej Siewior wrote:
> On 2025-02-20 16:12:06 [+0100], Peter Zijlstra wrote:
> > I've split up the patch a little and stuck them here:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=futex/scope 
> 
> futex_wait_setup() has an unused task argument (current is always used).
> 
> You solved the thing in lock_pi, I mentioned, by throwing in a
> no_free_ptr() in the middle. Well that works, I assumed we wanted to
> close the context somehow.

Yeah, it ain't pretty, but given the crazy code flow around there, I
couldn't come up with something sensible :/



