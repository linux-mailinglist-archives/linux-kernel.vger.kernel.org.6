Return-Path: <linux-kernel+bounces-192752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6708D219D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349901C22E95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D28172BB6;
	Tue, 28 May 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dZbQd+ij"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852C416F91D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913667; cv=none; b=d9xAdHkldnVaN/2NON0RnEpo9XXNJV2stK0ucKetXyaXOREqh6gDeFj1cOy6yabaGVyNI4WouPeT8v+lrWq7V/JVoQn0vQ+6xZmTYYdm0juyq0KwxuRW5LUqeQVf7jqdi1jy2OqIbfJ3hV+VqPBab4zo8BOEgHowk8iKTR3/ZaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913667; c=relaxed/simple;
	bh=vyWFi5wev+0Ypwx2V9LULhYDfKtfswp83P0XAsAbqXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJyPZd18eiIgSoD+5YWFJdoWR+LGvkyY7NStjN3sYIy614GwnW8hncWDoQ9CQmGZL3LQR36P8yReAWnzI20OJ8gVmVwBEqJc331u5j8FtjROYN2h54lBLb9hHOtHBE12+kaCSZwihZnoBXleIVSLHjlKdc37+LrdBiC6gl9N4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dZbQd+ij; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H85665RpHSmm8YnMeG0iOy0Fh6cTP7WSYgj5rk9gesg=; b=dZbQd+ij+qNH4zA+bWMdBwFfh7
	mO0+899ZZ760jpctBrtYrGUXVoSQ+Bc1KijC0V5midtp6ijYrK+A7wM46mKPKWC8GYHNMF8DljDrE
	TUcFc9VVPq+bVnBjJJq9n9ctNnf9LI+aV6XJlzVg4+GhiatD068tTOezKZYOF9lBurwx3ZPgrZCAw
	O1iZX5FtwnqDS4zrK+EdA9idBM6hJsx0me7h4u+BnDOVvMr3yxyx19xIBipAs1C3tVkZnhnhB6F9i
	QupLaHyFShCdtY/Yfgf4Gd2jk1q2CSruRKcqQqv6wOUT+I0Hc+2GUD3wviEPX9qr+krd8iOm5IytG
	XvJCbDoQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBzfZ-0000000Bjrj-2Psr;
	Tue, 28 May 2024 16:27:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 39C3430058E; Tue, 28 May 2024 18:27:25 +0200 (CEST)
Date: Tue, 28 May 2024 18:27:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 13/35] sched: allow runtime config for PREEMPT_AUTO
Message-ID: <20240528162725.GH26599@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-14-ankur.a.arora@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528003521.979836-14-ankur.a.arora@oracle.com>

On Mon, May 27, 2024 at 05:34:59PM -0700, Ankur Arora wrote:
> Reuse sched_dynamic_update() and related logic to enable choosing
> the preemption model at boot or runtime for PREEMPT_AUTO.
> 
> The interface is identical to PREEMPT_DYNAMIC.

Colour me confused, why?!? What are you doing and why aren't just just
adding AUTO to the existing DYNAMIC thing?

