Return-Path: <linux-kernel+bounces-561244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C994A60F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90183BAF71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403E1F4630;
	Fri, 14 Mar 2025 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cBiEq7ci"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AD1F4162
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948759; cv=none; b=Q4Lh8HLrEM+ttO3pmQAjctr2y1MySQ4ttwEeXbdMcOa9FUy9tD/0nUUQ2EOjijjgyI1bgAnpD86d0FHHDvr3JMPbvYeAH0KzHzNb97ed+WawVIqzIm60EyPLg+TDD2aPhoZUHlFuwLGPzfL0wZpk819YNcrzyB2l4iFq1HnO1Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948759; c=relaxed/simple;
	bh=YKihAsL4d3MU4Q9+aTJ0Mp58dvN/KK/SUZMnSA2ia74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRW8MhQqqy8LYLwI5oGOorK+mQgV9tKU1CfYShnh4vw1n73v6mDRcYXuopgcZucD9Zu+pTqqFkbI2oRhSvwBUqoCBau7NKkyiSyDC9/E+cpztAd+LVtiZXs1OglQTtMiNZoa/lKhQNummq1/BJwFDXiP+6Adqd2UVX5+l2fRdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cBiEq7ci; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DjA0hJP0PPCW8Upw9Xeu0p4vs/tj+QJVKfxm6TiMsNc=; b=cBiEq7cil8vM8WWTNfoC694Uqo
	Qp+MfVI00lf3A+/d+I4S1PLvzEJK4TPhSljKgu0zBd6ZnoICh2F2IpI4mBlAa/PbVQJyt3s6KFte0
	O4pytNFuUCDlW61JuZPlpJ4NYlKNFERa1i3BclriORcPRUHE9JwRhSr7k46ulzS/Bj+LC1UfmX5zT
	UuvWXnA9/ayLr/mjq2xPkANxEewH2civYjTWLOunMcuttemTQoD+9bSeaFbaEtToM+wGB+db4yeBR
	OzUCu5478QQpgMFV84v3zA9QFD5Y6la+Kiz6HBAdITKzZUO3/P1wjaPGONaWKNLvtcjuI+rs/eFbO
	v8wlk1gg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt2P1-0000000GnWN-2CcK;
	Fri, 14 Mar 2025 10:37:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BA060300599; Fri, 14 Mar 2025 11:36:30 +0100 (CET)
Date: Fri, 14 Mar 2025 11:36:30 +0100
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
Subject: Re: [PATCH v10 01/21] rcuref: Provide rcuref_is_dead().
Message-ID: <20250314103630.GM19344@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312151634.2183278-2-bigeasy@linutronix.de>

On Wed, Mar 12, 2025 at 04:16:14PM +0100, Sebastian Andrzej Siewior wrote:

> +/**
> + * rcuref_is_dead -	Check if the rcuref has been already marked dead
> + * @ref:		Pointer to the reference count
> + *
> + * Return: True if the object has been marked DEAD. This signals that a previous
> + * invocation of rcuref_put() returned true on this reference counter meaning
> + * the protected object can safely be scheduled for deconstruction.
> + * Otherwise, returns false.
> + */
> +static inline bool rcuref_is_dead(rcuref_t *ref)
> +{
> +	unsigned int c = atomic_read(&ref->refcnt);
> +
> +	return (c >= RCUREF_RELEASED) && (c < RCUREF_NOREF);
> +}

I had to check, but yes, the compiler generates sane code for this.

