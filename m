Return-Path: <linux-kernel+bounces-563885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2CA64A25
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC7B3A8E99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEFB21A42C;
	Mon, 17 Mar 2025 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aXlsJW0f"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A9838B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207481; cv=none; b=At9EMfrgEiXxtN85y+bxMQfhoPkRsgHpkJOUJz9QMbFBqAPG0av2W9o8Bzh2jJN2hIHTz5n5sSsmSbG5cQgt0jZWwaK+b4UGd8Qzv0pVW8Z8WnSwFBrrUqTm5n5eDA7VY1N3KKy9UOB/la81EZeF58ds7qlOZrdWBaQjcnCDHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207481; c=relaxed/simple;
	bh=p1kK8xRdVkgvTjsOb10aZe0DSNAANoFdjSyf/TKkmAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epMMgEc6YcmfrZbhi8nJ2609PqC9lBC6fQxN+GpDKGvB4A+1K/ZbbufSeBibNigdPMMCkcCpRVhTXh3bihVvrFN2qNAoXWGHjw+20/4+OvdacjAht0Hl7JZrv6wI2KpRsP0WStgn+Df82aLNikJeFllcLLu2xTUHDDWQ0VDL4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aXlsJW0f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+fhTvmuo/XJpQAoRNZixWJv0sOe/uwdvXPJsR9JrbwE=; b=aXlsJW0f1pTvcXWHh9oZMonMTT
	t89FJZPqAHSUT8JTE6uADzaKRWPF5c8sfZYutvQHdtrX4/27L/KMFMBEUNlV6SVwjtOiNnjZ5nxYu
	dDIM2dEFVEfZDtPzATge6e9V6606sQTE8cUjGr+qqlyQsmVvnrc+KYPefDUDqri9ZeKdrEA56NfvJ
	Cg0XoNI8yXES9DGD/1ftoQPiYPJdVcAvRAjUnveSBrrgNuOYutW4ajNkpldhM5CF6cQoAlIU97Fo0
	3+NlElpDleIRBmw7N3dXhDUzZlnnB3B9zB87b7D0oAs0C1/CClMN4sRPQQgxBT4h58mfjLhzfRCOY
	+/Sv5uWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tu7kM-00000008V67-22Mz;
	Mon, 17 Mar 2025 10:31:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6F141300783; Mon, 17 Mar 2025 11:31:01 +0100 (CET)
Date: Mon, 17 Mar 2025 11:31:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Luigi De Matteis <ldematteis123@gmail.com>, paulmck@kernel.org,
	boqun.feng@gmail.com
Subject: Re: [PATCH RFC 3/8] sched/ext: Add a DL server for sched_ext tasks
Message-ID: <20250317103101.GC34541@noisy.programming.kicks-ass.net>
References: <20250315022158.2354454-1-joelagnelf@nvidia.com>
 <20250315022158.2354454-4-joelagnelf@nvidia.com>
 <20250315072225.GG36322@noisy.programming.kicks-ass.net>
 <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b244939-6d55-4d86-8b77-a9a7629f8239@nvidia.com>

On Sat, Mar 15, 2025 at 07:15:27PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/15/2025 3:22 AM, Peter Zijlstra wrote:
> > On Fri, Mar 14, 2025 at 10:21:50PM -0400, Joel Fernandes wrote:
> >> sched_ext currently suffers starvation due to RT. The same workload when
> >> converted to EXT can get zero runtime if RT is 100% running, causing EXT
> >> processes to stall. Fix it by adding a DL server for EXT.
> > 
> > This needs a lot more words on why you need a second server. Because I
> > don't think you do.
> 
> Sure, I will add more words to the change log to explain rationale. When you say
> "I don't think you do", do you mean that both FAIR and EXT could be served by
> the same server? 

Yeah, because now you get two deadline entities both having a
reservation on bandwidth. One of which is not going to be used -- this
is not nice.

> If so, that will not handle the case where the system has both
> FAIR and EXT tasks in the mix (EXT has a partial mode where certain tasks can be
> made EXT with certain others left as FAIR) and FAIR runs 100% and starves EXT.

Well, you did not mention that issue, you only babbled about RT.

I did point out that issue with ext, and TJ said this mixed mode wasn't
really meant to be used or somesuch.

So if that's changed, this needs a separate discussion.

Also; I gotta ask, why is nvidia looking at ext ?

