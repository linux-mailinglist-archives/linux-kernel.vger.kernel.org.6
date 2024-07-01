Return-Path: <linux-kernel+bounces-236245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E7691DF53
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48CAEB20DEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9435814C596;
	Mon,  1 Jul 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SpIE163G"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D3B4EB45;
	Mon,  1 Jul 2024 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837112; cv=none; b=F1opFW5hb229mD9tWK8YUOnogcVtv3rsDlEbIpV3rckEdL7JKAXGJDVlhJlieqxRiih2VWhG+g8PgLk2o7KYpz1jytbMo4eYoQo1vMVNtbSaPW86JBv0IJlgMPeDb8mEtabUOir+QikdcjM/nOQOdVZ8bIpID7ZvJoNWIQvGVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837112; c=relaxed/simple;
	bh=BReYYFfhYkxLFM4o8fNg1xwFvXPIu8yp6wM+BNmK3+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxNLgo+7HNeeVHrHtrwZ39gd+JtmBHON+P58MQfB9o8JjGZtHoYYlygQBbxslTV6nofkcOv7Stp49NmSMNKQXMR2uZWG88Vy1aAg+ahCvhl+eWDidKKlgAQaB2sAy4AKJHrpJEHZNOqqmCAuDISqkup/IaK0xu+7o4W744ufzjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SpIE163G; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GXpf8n1yqAvgwJA1SS73M21QSVJ7nOMPXPy5McCX+TE=; b=SpIE163GOjkK5rTuYIch0NzY6L
	s/l2M7/AexFDUy1Pg/kieJc91aLKJSup/P3bqpGDF+76kjacLyPOu5n3kDQZhJ57G4bhEpG4fgkeC
	YvYfXu2VOt3wlfkM8YvGJVaX5n0whHFWU7DMQUmOiRcq6BR4dLqHR7i39mVyR3Zh3t/ilO+c5UcIL
	qkt8PRTnWvFwWAyFo9bwO+UcJFPK/geVL9OAkE4Mm8ER0Lt74G6pd6sn04I4ylGmFFLa2+J0anG9m
	d2z3P+La7ENDGlRtJH/Rh1U04CUPBQ279AUXIE+KBWDh4uq9FgIWW8CXkysSvNAA6238xIGEd62Z+
	WD5FEKYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOGC4-00000009edw-1ZtJ;
	Mon, 01 Jul 2024 12:31:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 781BF300694; Mon,  1 Jul 2024 14:31:37 +0200 (CEST)
Date: Mon, 1 Jul 2024 14:31:37 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v4 3/6] perf: Shrink the size of the recursion counter.
Message-ID: <20240701123137.GF20127@noisy.programming.kicks-ass.net>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624152732.1231678-4-bigeasy@linutronix.de>

On Mon, Jun 24, 2024 at 05:15:16PM +0200, Sebastian Andrzej Siewior wrote:
> There are four recursion counter, one for each context. The type of the
> counter is `int' but the counter is used as `bool' since it is only
> incremented if zero.
> 
> Reduce the type of the recursion counter to an unsigned char, keep the
> increment/ decrement operation.

Does this actually matter? Aren't u8 memops encoded by longer
instructions etc..

