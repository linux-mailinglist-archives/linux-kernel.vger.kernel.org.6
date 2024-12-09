Return-Path: <linux-kernel+bounces-437436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765989E932E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A035188635D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC222069F;
	Mon,  9 Dec 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="my2I9cnO"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16071922F6
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745696; cv=none; b=bgRcDzPx01dgzcunUi+nP/gpx1PB9ADMiTO0bjGYlZPEQBspwu0zC30B1Kwl/ADNhS9HRpTu9ucunLFtoHgduva+vt6TLuA5RhSX5INvtQFN5M7O+hmpxmiKUtgCHFgSMoD0c1GxW3mB8AAlRGUtUWQnhjctSsrtx/cFLqbr2ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745696; c=relaxed/simple;
	bh=NCtoEF3RZzWUtuloLqoK3tLezQIbchFnf+Fj0sjSaKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+54lLm4UyiZMC5KTebIYrSSUhBMUihc3Cij42+kV+fhz04vBQddXqgREn4jMO+LzXJQ4RRpScdamXMLdwSDlYPMFIe5AQILnWe9Ei/FHL/nN+ZD3j/ZfZSWDqjZBAmdqxSQkLIRuNZTvKGbcUvLm+Al277Wc18u3SL1LmmmNN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=my2I9cnO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XzkPlDDEBZX8syw1WyM3+7p5HW5nOS948jMCy/nHgOY=; b=my2I9cnOKcAopCw3YlT0e9rzd+
	qiPpZXlFhxldIcRG8McZg1/SSlgwFbCQj3M1xYqbkITklIU4nQJvTiIZJSFcoVMQz15GL+fAPfx+3
	gpSTydHfI9mxgjLtVWtq5u1CxjuzBnfaqfKlpHZktf5i07VlaLx01rxjPyQ0qx30vJgpCaIw/aDPq
	ru3NBuzFuXsmPFz3CnLQu03j4QASJmf+mkR7+dwnyJ4x6HOKkbLcf8OqBS2D+Oe33iReds1AWx2QX
	Yf2ZyUu1Hen47/xN+6xwaBuIpY59U30JAZ5NTmFCaovoipzlRJFf5ni404OOMLZDrPldjvD6I1EVp
	kXTHpy/A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKcS5-00000003X5V-3W96;
	Mon, 09 Dec 2024 12:01:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29BA53003FF; Mon,  9 Dec 2024 13:01:25 +0100 (CET)
Date: Mon, 9 Dec 2024 13:01:25 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Wanpeng Li <wanpeng.li@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Todd Kjos <tkjos@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2] sched: deadline: Cleanup goto label in
 pick_earliest_pushable_dl_task
Message-ID: <20241209120125.GL35539@noisy.programming.kicks-ass.net>
References: <20241205211632.1181715-1-jstultz@google.com>
 <20241206000009.1226085-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206000009.1226085-1-jstultz@google.com>

On Thu, Dec 05, 2024 at 03:59:35PM -0800, John Stultz wrote:
> Commit 8b5e770ed7c0 ("sched/deadline: Optimize pull_dl_task()")
> added a goto label seems would be better written as a while
> loop.
> 
> So replace the goto with a while loop, to make it easier to read.
> 

Thanks!

