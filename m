Return-Path: <linux-kernel+bounces-398095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 362C89BE540
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 12:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A741C20D1A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475ED1DE8AC;
	Wed,  6 Nov 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h03EHJOr"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB2B1DE4C7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730891377; cv=none; b=jkdtKSLcQbUR6CFJ2PaS5Ac+IIEb2T0Jwc8xPqjC9YEH2wyt1/jb8Z1a+hVPjCBfn+YZ5cX+WtbCxbomCrdbCu5BLxBUs8FMa3Lgf4AOXH6uwG/2H3Tk1jFBUiFvF+r8bgzURTNDUbgJG5uP3mfamrvljPq+KOil/kAxmtbmi30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730891377; c=relaxed/simple;
	bh=2hr9vNgaqFJGpc8y5Y5spJQWhzbyZLblQav8t9Ftgw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EprY+Cm3pFpIYfkRdAYkY+1OjEB0qJp4NYT52SQWJiyWaQTRMBpa1Aj/KS3pfhvUGi1vhc5VIHN90iPxb7BTHHoQI3xSGkbTR+ZhRDPBz3GmTJ5yORVAkxl+qm6lR9klJNPCUPWpsNvEOGH6Sbu8qeNx8Lz8KmZtDO7lRM17TF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h03EHJOr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2hr9vNgaqFJGpc8y5Y5spJQWhzbyZLblQav8t9Ftgw4=; b=h03EHJOrzsBk7V+/1ljPslDlTQ
	ZdbpYQkbkJPzS/0n/HFmyuNk6HdkmULhO+2Pt10foYJugyUFI42XGtJGTq52AD2ikrUf5DPMxhgNl
	d0T/m++7QTPiwUGS7uU7UhBBFkQTIis2BKuY0xTFPNGgnKZ6qdGOf+uDwRya4+BBBFE8V5kbSoxxl
	WNL5iEXQ0VMo0OVHUMpkzJVqc+w4MzEM21KmBAuZtBITmsheNBv9bPX12flH7OwCCSMMvY71LNasO
	IZ2/DyuUCBBlIkkL4s3tIU+KGw8qmHW34wro4ok1E2sUd4vwZ2vgVAGpWXkj5rGpd0bUGJ0Jl5TqP
	CF/W8WKg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8duf-00000004QZD-1jWf;
	Wed, 06 Nov 2024 11:09:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A294D300478; Wed,  6 Nov 2024 12:09:25 +0100 (CET)
Date: Wed, 6 Nov 2024 12:09:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Saravana Kannan <saravanak@google.com>, Samuel Wu <wusamuel@google.com>,
	David Dai <davidai@google.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com, youssefesmat@chromium.org,
	tglx@linutronix.de, efault@gmx.de,
	Android Kernel Team <kernel-team@android.com>,
	Qais Yousef <qyousef@google.com>,
	Vincent Palomares <paillon@google.com>,
	John Stultz <jstultz@google.com>,
	Luis Machado <luis.machado@arm.com>
Subject: Re: [PATCH 00/24] Complete EEVDF
Message-ID: <20241106110925.GK24862@noisy.programming.kicks-ass.net>
References: <20240727102732.960974693@infradead.org>
 <CAGETcx97SEHP5MspzBHsMkmSExnY870DQ-F5L077vzOGnPx0UA@mail.gmail.com>
 <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3dac53-69e5-d3cd-8bc0-3549af4932b3@amd.com>

On Wed, Nov 06, 2024 at 11:49:00AM +0530, K Prateek Nayak wrote:

> Since delayed entities are still on the runqueue, they can affect PELT
> calculation. Vincent and Dietmar have both noted this and Peter posted
> https://lore.kernel.org/lkml/172595576232.2215.18027704125134691219.tip-bot2@tip-bot2/
> in response but it was pulled out since Luis reported observing -ve
> values for h_nr_delayed on his setup. A lot has been fixed around
> delayed dequeue since and I wonder if now would be the right time to
> re-attempt h_nr_delayed tracking.

Yeah, it's something I meant to get back to. I think the patch as posted
was actually right and it didn't work for Luis because of some other,
since fixed issue.

But I might be misremembering things. I'll get to it eventually :/

