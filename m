Return-Path: <linux-kernel+bounces-204205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E48A88FE5D6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0D71F2569B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5F51957F6;
	Thu,  6 Jun 2024 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ca9dmr/p"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A87813D28C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717674815; cv=none; b=tNjOSEy7cd3kui5Xujf/dzHsxnSnhzeRulLqWjBlui29vsCBwfbOctac7IGqVMm0yhXE0F5WmC+CEMFEI9CfZnrCxTZ0fpqN9/q+C2clrNVXFLJtL86DcwT1L2TpXgeBwS7+T4ymKyPUOAZGzKn67He8gJV2QsasPtO83eXFrPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717674815; c=relaxed/simple;
	bh=MZxV6F75nZKmqUEOUAqMNdx5/blZ0m+jsECgN2bV7os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0QDHUeYHnG/fmXCN7zx4d7o926a0+IHZi0ZKwrbv+Sr8euF4vvy2YB80KznPM2llmDfm7QgxEFVHJRG95uXEb6USo8pEEjc+IPn3xTYcbnYMvxdjc/8ywsgKR+WS6VDL4H41TmYjMEWGKQ+sS4fINbpdDrG7QIUEX2qsFEyrtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ca9dmr/p; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MZxV6F75nZKmqUEOUAqMNdx5/blZ0m+jsECgN2bV7os=; b=ca9dmr/pLETq/5NICsLXRG6J3Y
	gVxppDTzq+BRV5tbTbrmWKu1VXJESJIN+/phPrItw+/q2UnhuXgxO0WUa9XBucu2D3ECUZOXEf8NZ
	pw5DSACugIbChRf5/Gul1V7DbHZnUR1WgeemI4khiDBSzRrxSPSguW5PwUEomBJb5L+VR+dhr81pB
	J83VDhqCxlarkYdbuzkGvTYH2j9aW4QUTVcYGw9zDjfqCodBST1lqWHPAwr84x1fQyTca3AKHW122
	kAFM02+TlHYPxXfbrDfnz5alRKUzoT00F3aXe5PTeBxOd2JNCySB2rpP8vJpxD3n1fL5OjMyfqt/+
	W9LZfRAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFBgM-0000000DxXj-0Adb;
	Thu, 06 Jun 2024 11:53:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AA11F30047C; Thu,  6 Jun 2024 13:53:25 +0200 (CEST)
Date: Thu, 6 Jun 2024 13:53:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, torvalds@linux-foundation.org,
	rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
	joel@joelfernandes.org, raghavendra.kt@amd.com,
	sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2 16/35] preempt,rcu: warn on PREEMPT_RCU=n, preempt=full
Message-ID: <20240606115325.GD8774@noisy.programming.kicks-ass.net>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-17-ankur.a.arora@oracle.com>
 <20240529081404.GI26599@noisy.programming.kicks-ass.net>
 <8734py6gvq.fsf@oracle.com>
 <c6b5a5e4-e14e-4fbb-84af-75d4035ced32@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b5a5e4-e14e-4fbb-84af-75d4035ced32@paulmck-laptop>

On Thu, May 30, 2024 at 04:20:26PM -0700, Paul E. McKenney wrote:

> My selfish motivation here is to avoid testing this combination unless
> and until someone actually has a good use for it.

That doesn't make sense, the whole LAZY thing is fundamentally identical
to FULL, except it sometimes delays the preemption a wee bit. But all
the preemption scenarios from FULL are possible.

As such, it makes far more sense to only test FULL.

