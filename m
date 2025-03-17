Return-Path: <linux-kernel+bounces-564008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40EA64BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52CD18874A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087C233731;
	Mon, 17 Mar 2025 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XCIJvXLE"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EF229B28
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742209853; cv=none; b=Tph9Vag+T/nh97X8+xbCbMSY4e3VpG5Zwd8vogVz7m0xhRMhvTn891lg1g3X19UhYB0VByg5qCQtYVDOuo91NZTB0DdFXSM8+WpGb3nPayVqzy+LihuQQjJBJYVtWXcP9hMpn4jQHGFGz6HOD/Ux52D+P2YF4Y7h+5545MLxM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742209853; c=relaxed/simple;
	bh=/ngKFYQCR9FYr7MvB4imU9sLAdn8fQfEgEOdcLZTymk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/lB+JvO+PhGod5mfQfGmplFQnSs9IoP4tVWiZ0gNn9xDtcJ8yXwvF6gb0DFqdOhiG7/yt2RQ6UmjPvxBFhq+qLczE4mgxTygTeXjmCckzbjaWwElpfeT6kDSOdyg09EeHycWp1oHDHnRSHRgvNZPHW8lCTHOtwzkiZ7Om4QOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XCIJvXLE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/ngKFYQCR9FYr7MvB4imU9sLAdn8fQfEgEOdcLZTymk=; b=XCIJvXLErz/LCKKl0JNWAQPi69
	7sFX1C/fn0HSohYjPRyQjXcxWLJNGEjLeFSsA5ogMv+evBbZx+SIP37ylWafF9JleMatr+bQxRaUZ
	vBe+2FIhdypi5aNJzGKm6y7jQet4pRF9DAXPGulV51RyUceNgUp7qOyOCKBaSENUT37TkviOAr3N5
	OFkpzMypjCqbV9pDkCI0QUdAr98SHLo9gWgEwnvCla7x3t4L/lCM6xyN93EACbSrvzrF8UsThhQCk
	/R2J9cMSY1QNGr4a5JpEGjlfTM7fXiCbN3C8XxU2rt04Fu/HXOel9A/mMW22+qSP69SVflBK1pSKK
	vaMrliog==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu8Mo-00000003QjB-0l7K;
	Mon, 17 Mar 2025 11:10:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id ACFA7300783; Mon, 17 Mar 2025 12:10:45 +0100 (CET)
Date: Mon, 17 Mar 2025 12:10:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@redhat.com, tglx@linutronix.de, bp@alien8.de, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org, ak@linux.intel.com,
	eranian@google.com
Subject: Re: [PATCH V10 1/7] perf: Save PMU specific data in task_struct
Message-ID: <20250317111045.GA36386@noisy.programming.kicks-ass.net>
References: <20250314172700.438923-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314172700.438923-1-kan.liang@linux.intel.com>



Kan, can you please do a patch failing perf_pmu_register() is there's
more than one pmu with one of the kmem_cache things on?

Because the current thing very much cannot deal with that case.

