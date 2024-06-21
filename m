Return-Path: <linux-kernel+bounces-224841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828B091277B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B40E61C25208
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6D2C6BB;
	Fri, 21 Jun 2024 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DP61nD8c"
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA428DC1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979670; cv=none; b=KO5F/XTZhIggB65g9sm4o1kTWbRfrGmUIP9OdazssRVOMolIXrQQ9C4+Q+hSHO1h/KsDe7wUwF+vowFJBsy3v9Qd3K9CwOjNIGtCCcVPq/oG3aP0yfhwUiixunvybV61Wn7V/rfi9jOpCMpgBprdV3I7/na/Ga1peuL7NgL9tYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979670; c=relaxed/simple;
	bh=gIsAYvc7V06aARwVwNxvDtx9375NHja9zxf8RAiawlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXt4yy+l7rEMdRFxA0P6lLCWYyOOqTAKvSOqogTON4Grvi1cib8t6d4qhzRT/4JcpCQFCGNvI+BnYZ9uDPWSZd+BiX9vWVDnQ+N9K+xrO+lbN/GN0/WSlDSqiBIV+GPSTabnl4y52yyS4nuYqru0g3HjQBip1JFAvNi0rVN67/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DP61nD8c; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bigeasy@linutronix.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718979663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mDg/bErLUvNLFGhkln1hOOoZ0QemIVkLLqNOX1eZjvc=;
	b=DP61nD8cD+WMlBNVxN5rxuw+H7kQ6yW/DOZv+JW6Z9j1S9s4E2wRynhrjNxyzEYG8hbvz9
	y6k8bd5jMefXElAlou8muA3XDqhOJSvy8rWQugQQXYi+8KlzLcW+ozHOccy2uDvWiqYG+f
	kP6YzLaOH6z/vUFTQsRH+q8gwNTWyRc=
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: bristot@redhat.com
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: klarasmodin@gmail.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: peterz@infradead.org
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: surenb@google.com
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
Date: Fri, 21 Jun 2024 10:20:58 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Segall <bsegall@google.com>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Klara Modin <klarasmodin@gmail.com>, Mel Gorman <mgorman@suse.de>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/task_struct: Move alloc_tag to the end of the
 struct.
Message-ID: <7zretxxixkpfxt6lr7x64n67ql2v2qpb7abbbjklclwlu4u2kx@22o5sdlnpkea>
References: <20240621102750.oH9p1FQq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621102750.oH9p1FQq@linutronix.de>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 21, 2024 at 12:27:50PM +0200, Sebastian Andrzej Siewior wrote:
> The alloc_tag member has been added to task_struct at the very
> beginning. This is a pointer and on 64bit architectures it forces 4 byte
> padding after `ptrace' and then forcing another another 4 byte padding
> after `on_cpu'. A few members later, `se' requires a cacheline aligned
> due to struct sched_avg resulting in 52 hole before `se'.
> 
> This is the case on 64bit-SMP architectures.
> The 52 byte hole can be avoided by moving alloc_tag away where it
> currently resides.
> 
> Move alloc_tag to the end of task_struct. There is likely a hole before
> `thread' due to its alignment requirement and the previous members are
> likely to be already pointer-aligned.

We sure we want it at the end? we do want it on a hot cacheline

