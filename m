Return-Path: <linux-kernel+bounces-187274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792668CCF59
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6513B221F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C813D260;
	Thu, 23 May 2024 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hNOqFYp2"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B3A929
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 09:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456845; cv=none; b=jqQjYzeuas00tqLbHkNQRcgZTDTB4ya486P4el8bHPmQBJwki/mrE6gg7a2Jw8Rj57Xxgc1xlQOcmWg8fLmPPr7goW1Y+FoC8z3t5HMPLMGnKv6yrGqYnUyBZ+cmH++vOq4CQPycdlu0RBv9D/30BMHQ2B8uk5r3ohlleZdriwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456845; c=relaxed/simple;
	bh=Zny2wNgqTamRWkejdl43i5F34DfV9GBO0UMNYMGeFdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dA7QN7dK2hfbHbxzhVSmv7n25hCzPcGD3w/Q1toXjySS1ENk88Bfi2JXa2SgUqdaCpyZ/jGHGNpvsi6H3tR5oLmgiQSDhckLyvZ6MLfk8SijWkutQtAJWiwoQGDXj4XcoOFX6tGEtkqrN+rN108+Md1o8LfvgKJf/D2hjtY/yA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hNOqFYp2; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8hhCRUqXEu3HdppjYK3fgpfFwQbKZJat1RgK7sPaU7k=; b=hNOqFYp2FwMo1mse8DQ9+ENnlE
	H8cZNIhc35T7cOWBsjtVXSgx4LJuW1EIogLfhHRy1xfHOcquHp6ZTmg5YflAf3pvLbOF0JaiK12Vt
	fGJDGvLdktm96FGx9KNtjPhaLq4tpHRSnP9e3SMPYbvSvZAqFS+x3345gfm7/3WmLGkX+USINEs44
	Gcx+Mbdbow8wV21B6hVEPdh4Mmnosesf5qpiB7d+wgtGSNRIBwRC1CzwcxnOJLyNJCGgkhtJlF0uO
	ZhDhUD+BTabQKDVW89dYH/GSIuIBmx99lWypNiCQcYnFPgJqny9uw9uw9aOV4V1D8+IdkYxYdXnWH
	w3MpIqeA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA4pR-00000009ER6-3f9J;
	Thu, 23 May 2024 09:33:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EC50D30057C; Thu, 23 May 2024 11:33:38 +0200 (CEST)
Date: Thu, 23 May 2024 11:33:38 +0200
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
Message-ID: <20240523093338.GJ40213@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <20240523084548.GI40213@noisy.programming.kicks-ass.net>
 <e4b472c9-ad8b-4423-81ad-02a1ab231f95@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b472c9-ad8b-4423-81ad-02a1ab231f95@arm.com>

On Thu, May 23, 2024 at 10:06:04AM +0100, Luis Machado wrote:

> Booting the kernel with NO_DELAY_DEQUEUE (default to false), things work fine. Then
> if I switch to DELAY_DEQUEUE at runtime, things start using a lot more power.
> 
> The interesting bit is if I switch to NO_DELAY_DEQUEUE again at runtime, things don't
> go back to normal. Rather they stay the same, using a lot more energy.

Ooh, cute.. weird. I'll try and see if we leak state somehow.

