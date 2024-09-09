Return-Path: <linux-kernel+bounces-321476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F15971AED
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6112A288F4A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF771B86FE;
	Mon,  9 Sep 2024 13:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HhOyUxg7"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA9917837E
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888259; cv=none; b=ay7cKb1M+lNjHUSqaarY17M9j1dzTLtX0nGKxqNhkS6XUFKETyPSPDyuIEuZzcy2KLqX5e2Z4f5xXxtsqoJh1ISC+O9MIyCdCkR7T2c7DiS0E6ggPYFYavJKBJ0rIDh2wqXv0XfKSsp/teAaeBc0iL8jXzeKNa7DVedbDkxgi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888259; c=relaxed/simple;
	bh=XejnyxENUuV5Sfj8Tm3+y1m2vQm5470RcIAjK61QG9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOnbRZPiqRFP3eyn/PRmtdgYPlfJjezb1H5skNVkNHMuKaUpYCdeQ3F4unJZs/LH2qhNCL97x6pvF0xmo4zmMZPWOmH9oZ6U6WOMo3AN5p0C8BKY625C/pKJBsZoqMqNrt96vtbEO9vDtSkKsS+XC4OCQ5CZcytMSv4ig5PEYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HhOyUxg7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XejnyxENUuV5Sfj8Tm3+y1m2vQm5470RcIAjK61QG9Q=; b=HhOyUxg71F8B70lzYu+fSPuONz
	FaSnKX0cbWgD3xPCbeza9X0721N8W6KUtFVlGijrZAc7OBHiZznhObkGVo1z8RYoIOJkVRa3sEjSO
	OujNtSTwJW6+79Fp3FoZAeRiiMiorFgAg7XckXAqYmwXx9FQQF44DdcTrYrZspdUsjX0zejg5jw7I
	QMm1eQD8zntGgIfz2+K7rKGBMG2uIK9BrGQHedYd7eavAqrrl4zudw8JlpLhzngkwgWJsKBJfCpxM
	DKCeafZVJg4EbNbwjv3UxBU8WoYJQumYqGsKCo99dsPmRVUgM65lYCrSsDm8paIWJj96/zwoc3c8S
	7+RHBa5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sneNF-0000000D9QV-1dOK;
	Mon, 09 Sep 2024 13:24:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7EA4B30047C; Mon,  9 Sep 2024 15:24:09 +0200 (CEST)
Date: Mon, 9 Sep 2024 15:24:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, mingo@redhat.com,
	acme@kernel.org, namhyung@kernel.org, irogers@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] perf/x86/rapl: Move the pmu allocation out of CPU
 hotplug
Message-ID: <20240909132409.GC4723@noisy.programming.kicks-ass.net>
References: <20240802151643.1691631-1-kan.liang@linux.intel.com>
 <20240802151643.1691631-7-kan.liang@linux.intel.com>
 <88fa2064-c054-4833-872c-0cf5ff1e3609@amd.com>
 <b9893f4f-c91e-4c83-b785-ad78dc2f67f5@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9893f4f-c91e-4c83-b785-ad78dc2f67f5@linux.intel.com>

On Mon, Sep 09, 2024 at 09:02:56AM -0400, Liang, Kan wrote:

> The patch set has been merged into Peter's perf/core branch. Do you want
> to post a fix patch to address the issue?

I've not yet pushed out to tip, so I can readily rebase. Send me a delta
and indicate what patch it should go into and I'll make it happen.

