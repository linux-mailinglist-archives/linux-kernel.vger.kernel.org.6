Return-Path: <linux-kernel+bounces-576283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05284A70D50
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 23:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF7172F5D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB5926A089;
	Tue, 25 Mar 2025 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cu0s7nIL"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D9A269D1B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943370; cv=none; b=l8+5ffsSvA6gGiw2v2cb0EMrr+enbjOoyOVCilXzWaCpqXCa0xLJPao0iA4l/GDgQtRbrrMAxdbFEtiAIfM4y6YmzEedejdHiN6RvH4WcVBo7lFxMkdu1TR0KI+j964O0YPFJOhwluuISFbbNQ4sLpp1twyivlGcuopmF8eU5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943370; c=relaxed/simple;
	bh=FVXn+ePiO7SsganxJWLxApMnAvpevyjQ5Nmk1sQuArw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgmJWgTzi+FV9ZyWoSjI+Rpe8jGo1MulO8liuh2XLqxO2K2AVqGK3AmWb4harwIT15UwrXFblLg3c1j+SHfrQf8CkstGUTDsXdg62vhLi03hEIkQHr9g75Kd2mh9g1RP0Tu0h8q2uuvNingOe/6s4fCePRpCyqWJrRDe52FIh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cu0s7nIL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=48qNXt5Nqoz8bU6zLlnPCh1vzoAG4BT9CKkzfi0YKjE=; b=cu0s7nILI3fBDPiB3nB6M46+zp
	CVqE966Ro3HImuNxX0z1qCqqcM655wEcquh2bvj7e8fELhsSuQ96Of5xtZ7+y9Ils4EjCnKCqU/1q
	Z5PEgXQlYDI+cGP9pWiQWi80MK+0W7W/zSLO/iO8tE3lF0bESGhLav0Qvv0cMa3PwfD1By24OLvit
	eMdlTr59zTgJhaYVRF8M9fDbXd8/8ELu36yxo8prgmpl7uSVFdK5JZbMISELOvsGrBtQ5I2drm34D
	NmLK5sGGty9nku54P62ftDkzSTl4v/WuPMjYkgW25vyLRVQhiavMkdovwnT4hQqfaZjI02swK90UO
	hO6fUp6Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txDBg-0000000FXQM-43ge;
	Tue, 25 Mar 2025 22:56:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 89E463004AF; Tue, 25 Mar 2025 23:56:00 +0100 (CET)
Date: Tue, 25 Mar 2025 23:56:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 20/21] futex: Implement FUTEX2_NUMA
Message-ID: <20250325225600.GP36322@noisy.programming.kicks-ass.net>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-21-bigeasy@linutronix.de>
 <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc3a6902-a845-4b11-ace8-514f10194288@linux.ibm.com>

On Wed, Mar 26, 2025 at 01:22:19AM +0530, Shrikanth Hegde wrote:

> > +	return &futex_queues[node][hash & futex_hashmask];

                            ^^^^^^^

> > +	hashsize = 256 * num_possible_cpus();
> > +	hashsize /= num_possible_nodes();
> 
> Wouldn't it be better to use num_online_nodes? each node may get a bigger
> hash bucket which means less collision no?

No. There are two problems with num_online_nodes, and both are evident
above.

Consider the case of a sparse set.

