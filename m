Return-Path: <linux-kernel+bounces-358655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2895998208
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9C7F1F233B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B0E19AD73;
	Thu, 10 Oct 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A4Oll53m"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60617C22F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552177; cv=none; b=C62J9vq6wGyljWmDAx1zbWxmSCjwTc0kPbLJmovH9Ob1zXys3e5bNltdr3LlqhK4UpCAXZEf5gnheP79QhAX4bFnRO1EyVzQ0zqaiE2xVD5oPIaAKWMNknIL/W8cKoOlAgWICyZCIiRuRN1rVzZnzqUugI5JOBhmX5+BouCcx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552177; c=relaxed/simple;
	bh=+ajV99vuiVf1H95WpcIWBKBTjT04JkAIcXBqrXvquY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSFGgX4PKcjO67eQYkoKjVeUdcUXpyNuarhTdul0hYbBxk4n2xs7k6wKF7QZJqvu92JwbJlJ+oe1Po5R3/BseqwC/RElZXsnC3NceVYryGKw1ekVuvPOx7ck0o0bMbHIxYU0SQc5bCpgizsLIOIpaOerFncUERr8NXd4sQWfBhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A4Oll53m; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=00Rh2zNG6cUhRVddO6LKQ3TRCWt9itUhN1GlPYRsD7g=; b=A4Oll53mW8TAG5ccPVAVXmX700
	rCSTbJ1I36wRhN0SUrnA/qIOFzL12OOkNtCgFaNmCcE8FcCNiqI6s7rca7RlnRz1RBpRe8sN2WzTP
	uCqoAaCJc7aZT2BYOQWIwFZyLELh6mclkZD45KBKCW3zedYGb/PS7qlNezY0Gn8C1pL4y4bHgecV0
	S00Urh1TfoXAnJi/MbqqFDd8VdvndebixUQ+q7Qi1wiVftCs9xtEykkHnvy6thUUze5lirLb8FouX
	5xSBAIy6kPAZUmeL6LXOyj8Bn/JEixwsN9NRgSsx6AfYb/BjgBt0H/EwzHK40VEMoXlfgaFgGuF28
	qDMK6LXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sypNi-00000005JfM-0syE;
	Thu, 10 Oct 2024 09:22:50 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D6E3830088D; Thu, 10 Oct 2024 11:22:49 +0200 (CEST)
Date: Thu, 10 Oct 2024 11:22:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Hariom Panthi <hariom1.p@samsung.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	r.thapliyal@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: Re: [PATCH 1/1] sched.h: silent false ATOMIC_SLEEP warning from
 cond_resched
Message-ID: <20241010092249.GD17263@noisy.programming.kicks-ass.net>
References: <CGME20241010032751epcas5p1154533995a184be3fea39325c4d33740@epcas5p1.samsung.com>
 <20241010032653.1922214-1-hariom1.p@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010032653.1922214-1-hariom1.p@samsung.com>

On Thu, Oct 10, 2024 at 08:56:53AM +0530, Hariom Panthi wrote:
> In case of (CONFIG_PREEMPTION && !CONFIG_PREEMPT_DYNAMIC),
> cond_reched() is not sleeping.
> 
> Thus remove __might_resched in that cases.

*why* ? It's still a valid site to do the atomic_sleep testing, no?

