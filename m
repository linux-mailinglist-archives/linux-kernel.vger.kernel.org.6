Return-Path: <linux-kernel+bounces-253620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECED19323DF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 12:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAA41C22A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 10:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240F51957F5;
	Tue, 16 Jul 2024 10:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="beFHm6bv"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841CED8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721125522; cv=none; b=ZqzfTcXtwAoGVH+yhMZWw0COKVal5jiP1RJSdDB+vVEPBhgkhP85uqI6xAfmRUxPrsUdgIiAEKyoHz6IuX1olO4pldVvCJj1EpzoNSsLn5lm8ZPRIiplvKxituD8nIeEU+hteCIBs8SFVhprVGuWW9rfhpuv5AFmCLlxRFEO3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721125522; c=relaxed/simple;
	bh=mfJ25zDowDH5fsSFdYo4/55ojXh7pQ1MXRAkgk42NU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qd7IWUjsrpRfqwHJ1CLuJKSCzuv77M3i0KycD9jrIczK/E+CX/tzCvem8rYDOYauWkVASnu316rkZOAKOibTi2jU3tAawkbuennGapUbUbh7AnXZJ7Y/n5Ux/fIY0M4e27kGCF4UQawHfKddwDHxB8zGwW7B+jLgZOraS6rT/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=beFHm6bv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ddN4CHpguZCq4xlapXCAuslzj3WHd0soajdpoP4a9lA=; b=beFHm6bv6+vRAUJfQr+Ud9P+pQ
	25BwHtwyY8tUr4evI/z7RIV8nVHkXMeUPtilee6wP2BZ/sLj2Qxuzlp8jKnuUKSrD5O+kiZbk/6It
	wpdFTxKk83mIJQDUNP8Tfmv+j+wCpJ81WNipSz30r19Chh716uIawGW4xPw5/82A8wpGYpI7mfJz7
	DLRRPiUIG99SX+zW89hgLjntwi46JBmFoSFwyyENhR/mrLCWIuL/8li8lLe9HWqfPpzRbE6oup8QV
	WNjLvQUffpsJL1SkgbaJagI68J5upUoGqOaFA15Bt4Snqdha+S+2BrEyc0sdiga/vWIl8U2CGOsx7
	FzDIzeWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTfMp-000000021Gp-1BqL;
	Tue, 16 Jul 2024 10:25:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 84B713003FF; Tue, 16 Jul 2024 12:25:06 +0200 (CEST)
Date: Tue, 16 Jul 2024 12:25:06 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Xavier <xavier_qy@163.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, oliver.sang@intel.com
Subject: Re: Re: [PATCH-RT sched v3 0/2] Optimize the RT group scheduling
Message-ID: <20240716102506.GE26750@noisy.programming.kicks-ass.net>
References: <20240716052543.302383-1-xavier_qy@163.com>
 <20240716085926.GP14400@noisy.programming.kicks-ass.net>
 <6af6feef.83df.190bad579d3.Coremail.xavier_qy@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6af6feef.83df.190bad579d3.Coremail.xavier_qy@163.com>

On Tue, Jul 16, 2024 at 05:17:50PM +0800, Xavier wrote:
> 
> Hi Peter,
> 
> Your meaning is, will the RT scheduling policy be removed? I see that the
> current kernel already includes the deadline and EEVDF scheduling policies.
> I noticed that the enqueue and dequeue operations for RT are quite
> complicated, so I proposed this patch for optimization.

No, not the policy, but we would really like to completely redo the
group scheduling part for RT.

For UP it is trivial, but we're not completely sure how to best do it
for SMP yet.

Anyway, I had gotten the impression that very few people indeed were
using the RT group scheduling feature, so I was surprised so see your
patches.

