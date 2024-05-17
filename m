Return-Path: <linux-kernel+bounces-182235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C188C8871
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98773284251
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C41760264;
	Fri, 17 May 2024 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCd0e5Wk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF2E1863F
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957459; cv=none; b=gbD7KsPyaiNFqhHQd/k6k5uDwzV2HAmCTvOS0VNAGF7fgd6DrYHKzKTVx5Ah7lnU+EfQOrI1VLeXlEvFksiPLGivgRgkXZUoPifgSE43jsJL9nKSNWAgxC6pHEumF9IzKxN/DJ2jqhCBFkDYxp2mXASEBpgMQ/bENrtANuIKkL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957459; c=relaxed/simple;
	bh=/3Ff205MN8HPJmBvMpwpWRFGY7yUTT9Pn5wmoEEM/gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULZOV2AbCa1XzUhq6mVRLRUFB4wUJCmlJak13RzpjHb9RTArFCOjCO9Fu5lo21sjjRXG7aDPnT33bRGUu2sAw5KCLmjG8ic2BXQgd/h2xl1Ia0SSo5s8WsQA5fgt4opUEi7WKtpkmKA6PBrX/cqUhdE6IhWRngEnECBPmuUD3NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCd0e5Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED950C2BD10;
	Fri, 17 May 2024 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715957459;
	bh=/3Ff205MN8HPJmBvMpwpWRFGY7yUTT9Pn5wmoEEM/gw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCd0e5WkPiDFIR4LEwBHnb56CyyWxfk3T9IhBesuNmMwENf5/QRX7LAf0BTUkUR2u
	 IubphLQ0cjXXDv+v9Y9ok5to/pPGfUbLCT8vAlx+BL+QseFMOPa7oCu86VmFcjQcBe
	 P92YYEHxRQ4joIJNZZFgAibVQFrZooxFnNGztZF30hom2deOHhJ4wzNgOkCNxZY7s8
	 qK16zwb4hqrKT2+RCaZ6pvZAo1Dw8BT4RMP2ls1XIlj7B2K+4+pO6AfMayDB6fnv9t
	 1I3dUfkGolM0i2fhPRNL3ZxraygAIPuTSqQ6GM98jx9cKFKnQPNV9gQaiBLyHaSeww
	 jfFa4hrrpw/BQ==
Date: Fri, 17 May 2024 16:50:56 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yun Levi <ppbuk5246@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	anna-maria@linutronix.de, mingo@kernel.org, tglx@linutronix.de,
	Markus.Elfring@web.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
Message-ID: <Zkdu0Guz8ySN2Qoe@localhost.localdomain>
References: <20240516084911.GF22557@noisy.programming.kicks-ass.net>
 <ZkXtHv+fHUD2+lFJ@lothringen>
 <CAM7-yPTSq0CSmRsTpeXwzhFk77gfwUK_LZKnbgo4NPk5zPCaAg@mail.gmail.com>
 <20240516140003.GJ22557@noisy.programming.kicks-ass.net>
 <ZkYW48dTX2FH5NaD@lothringen>
 <20240516144504.GL22557@noisy.programming.kicks-ass.net>
 <ZkYgG9KYMpUPeJsM@lothringen>
 <20240516151953.GM22557@noisy.programming.kicks-ass.net>
 <ZkYnKAd1Qy+yvjDY@lothringen>
 <20240516175321.GN22557@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516175321.GN22557@noisy.programming.kicks-ass.net>

Le Thu, May 16, 2024 at 07:53:21PM +0200, Peter Zijlstra a écrit :
> On Thu, May 16, 2024 at 05:32:56PM +0200, Frederic Weisbecker wrote:
> > On Thu, May 16, 2024 at 05:19:53PM +0200, Peter Zijlstra wrote:
> 
> > > Yes, but stronger, as long as the CPU is part of a load-balance domain,
> > > it must not disable the tick while running anything.
> > > 
> > > that is, NOHZ_FULL must not become active unless it's running on a
> > > single CPU partition.
> > 
> > I like the idea but I'm afraid to introduce regressions while doing so,
> > with people currently using nohz_full without proper partionning...
> 
> There is no regression, if this is possible today it is utterly broken.
> 
> This should never have been possible.

Ok, I'll try something.

Thanks.

