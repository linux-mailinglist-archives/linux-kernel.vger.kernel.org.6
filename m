Return-Path: <linux-kernel+bounces-187206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DED58CCE95
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05481F2532B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD8D13D259;
	Thu, 23 May 2024 08:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ujVp4Rig"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B09513D246
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716453971; cv=none; b=Jrzgl2KXIjr8/g0hTyXAqLO4dXUsbPHfqG4WGpYfMLAMea0ZYFeFZAkTd0s+s3pp4aiuRjUaid9TefUSpdvK5V7UOhvW0tYwjTpFoJIeZ2JoIgCn9BjiAcc2RAxOoLqvxLz5k1KMyHvDupQgD+RMZfVp+pWffVy8hfc77Z3fnv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716453971; c=relaxed/simple;
	bh=yj7Hf/rOLr1AgYBCC7C+5E7w8ubSJZrqEgnnz4pLIIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyxpcLPLpRUcTVh1wHS5I4eSz3jpM07aybABg5ehWjGavD/tOWpYL71zzQFHVt718ag2pzOMj1FMYNmRj8AQ5CaCNEa0+0VZt+zQsCm+OeDiwYgnpxr8zdQqT03StSn4rPXuiecjKGbdjRK7jGdLYN5dQ5xLRteQckzpxRiGqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ujVp4Rig; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OzaeIm3CEcZ/rg0C2pbEPEQ3M4jZVchEi4wcYEBg0NI=; b=ujVp4RigCCxMueW6p1w6NVq8Rn
	DsLFxa9QuA5/JsfGds7CybKxTzGGY0Wwr9gflOhIx0IDRnzfuF6BsWb1O7LFxye6e3XK0bmJH4aUv
	7o1bbOU3Hc7H2PP65XRQg59OKUlMHpobt66HIma2ObapCq48DivozY0Ppgs1mioUwmUd+z5XXPwIW
	UJw3jLdyS/jCevjfcghrqquOnEGGJ+Dz/cNkSobetYEmi41kKR1IQVRbgTDCNPvWfPpsVK4soxcFI
	+NVokI8cxDNKAqzEBLE5vY9cMaU94hhSyyrEf9kOOjuglnLSyN8Zh38UcHJHYxssvfgijaeGu60Nn
	A+N4DBCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA459-00000001a2K-35ly;
	Thu, 23 May 2024 08:45:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B5F5330057C; Thu, 23 May 2024 10:45:48 +0200 (CEST)
Date: Thu, 23 May 2024 10:45:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>,
	Hongyan.Xia2@arm.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240523084548.GI40213@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>

On Mon, Apr 29, 2024 at 03:33:04PM +0100, Luis Machado wrote:

> (2) m6.6-eevdf-complete: m6.6-stock plus this series.
> (3) m6.6-eevdf-complete-no-delay-dequeue: (2) + NO_DELAY_DEQUEUE

> +------------+------------------------------------------------------+-----------+
> |  cluster   |                         tag                          | perc_diff |
> +------------+------------------------------------------------------+-----------+
> |    CPU     |                   m6.6-stock                         |   0.0%    |
> |  CPU-Big   |                   m6.6-stock                         |   0.0%    |
> | CPU-Little |                   m6.6-stock                         |   0.0%    |
> |  CPU-Mid   |                   m6.6-stock                         |   0.0%    |
> |    GPU     |                   m6.6-stock                         |   0.0%    |
> |   Total    |                   m6.6-stock                         |   0.0%    |

> |    CPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  117.77%  |
> |  CPU-Big   |        m6.6-eevdf-complete-no-delay-dequeue          |  113.79%  |
> | CPU-Little |        m6.6-eevdf-complete-no-delay-dequeue          |  97.47%   |
> |  CPU-Mid   |        m6.6-eevdf-complete-no-delay-dequeue          |  189.0%   |
> |    GPU     |        m6.6-eevdf-complete-no-delay-dequeue          |  -6.74%   |
> |   Total    |        m6.6-eevdf-complete-no-delay-dequeue          |  103.84%  |

This one is still flummoxing me. I've gone over the patch a few times on
different days and I'm not seeing it. Without DELAY_DEQUEUE it should
behave as before.

Let me try and split this patch up into smaller parts such that you can
try and bisect this.


