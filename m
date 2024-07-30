Return-Path: <linux-kernel+bounces-266960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D3E940A72
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8E528445F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1997191F92;
	Tue, 30 Jul 2024 07:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B6ZojIcJ"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B26624
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326097; cv=none; b=mjIN6mzVKKJB7xhsb5Gr42hp9PBhiITBkvL4p0OBc+ZTx9yWfZMszB6LaVp0P5ksSb+2ND3odAhm2ArKJLQM1i004cU8f2CchEMI2+clxfTwMUVwGfOPTf2DLSCLLzFZZyZyqn8h6Heu6Xuam7S7fzG5FZ5r6AYwfKFrdoukQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326097; c=relaxed/simple;
	bh=gff5W5hqMf3+d4MTsalDDna8/gh45r8NB4WEn+JozNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ysc3zCmfwCOVNuvyDt/PJRx33beIZQ+PgSRjrH5o4WzZjkoMRme3ykGa0qdTKzXoGwnTiQP5tqLhJJMUJE+TG4jKhrrDULCJWz5v4jp3xJdS0TUP8WLtzStnHIv043RnphPWkCd3i1Rt3SP8dZa2OEelTErZDWPLptjNrdLWIl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B6ZojIcJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gff5W5hqMf3+d4MTsalDDna8/gh45r8NB4WEn+JozNc=; b=B6ZojIcJdtnIxZQYJqWxvrZVcR
	KxexjmFGV06FERdY27Li5npA5z1OUgHa+ECXVh5Nn1ZS05E8UEtVrQ1Z5DnE74OOFhIksBA27EDv+
	EtvhamOW9sQE7QVV47Ci+pnlr87wD9hK3eok8kjhvAjEpj4SebwTeAgHuCAcjEvmstK3ziih1hErH
	gd+qBW2mz7iFO8rv8Ge9Fihh1zuhDmOEz4J+Os95p2+6nDkDS6EhKnsAAUKycRn8ClFpSXRHqEvJZ
	SQawXm0NQFDOBSw4yK12TsEuRv4J2n+OJj0nzGtBWiQJ9BqTK6xN8bdW6mxrIrz9TJ2cs6yReMDRd
	qwIFEzlQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYhh5-0000000EQvl-24OF;
	Tue, 30 Jul 2024 07:54:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 448BA3003EA; Tue, 30 Jul 2024 09:54:50 +0200 (CEST)
Date: Tue, 30 Jul 2024 09:54:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240730075450.GE33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi-U672Eji+tz1x7JCVyEBjEGmm04umj9JqwfD5n8BMGg@mail.gmail.com>

On Mon, Jul 29, 2024 at 12:23:01PM -0700, Linus Torvalds wrote:

> Not super-happy about how people apparently were discussing the build
> failures for a long time, and didn't even bother mentioning them in
> the pull requests. That broken commit came in through the perf-core
> pull from Ingo.

My bad, sorry. That issue seems to have completely slipped my mind :-(


