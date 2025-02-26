Return-Path: <linux-kernel+bounces-534435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F876A466A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 17:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB1A47A6BB6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1EB221D80;
	Wed, 26 Feb 2025 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsbeLXt5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0141F16B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587592; cv=none; b=K4h0ZGYdDUaQLYKBg42i3GTWrZ5Bnsd5dATrlGfLtwLrHg45KxJHp2JMSL/j7qYIve1/yhUN5cYRB2uZMABpaGoRKkscCXoIrun+Ah4lDj/pB0PNbQlU2uFhIbgDb0FOCO/3K/IY3JQmanXRAPDjYT8OESzwuo6VscW0LredWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587592; c=relaxed/simple;
	bh=E/pn7zPLMxVuzW0n3inIPRr6WHTrZ2ZQCVccs2DIisY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcR28yMRd6lqjODoTgim/okFMkdiNAjp83C9RLwIebHFmiwfN782lTQI53etDfDa+ahzazV+oAh16sRjpWCNfSk7JVSrk9j/D0OMYVaBLx7nWBxrg04wjnhMRpLk/ePUkD4VDGFJ2kh/p5koVOv6MlMYQUAjQFk9r4MPabl6gR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsbeLXt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3F4C4CED6;
	Wed, 26 Feb 2025 16:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740587592;
	bh=E/pn7zPLMxVuzW0n3inIPRr6WHTrZ2ZQCVccs2DIisY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BsbeLXt5zRri3Ipqwav8SUFDViIN38ozwJ/yVWtdCVDlkI8KiT5e8DwhW0EW7RUEc
	 0kWimGZ1XNqizWc3GOJHIQTFiu+0ryCMUAiU5zG4VkmKkcmMBDc75cXTLfi1qrEAdE
	 qNjANv3fJFHIgG/HVXnRIU4Hk9lS7TQz4cRsXg0646i+dV9bt9xSAMVddGTxePAX6q
	 fkMQACp1MetVcyCkrSXY2qVBPy7LCEJd3Iehs9jMRvLR1aoQEvyQOzo4ye7Cv52Qjs
	 Vd0JDrPyrh8gJ4is92HX1dbH3N5JaR3y8smoqZjW2BFkRcyFN/P9ZigOnU5V8zV+VW
	 r45zPLc0VUepA==
Date: Wed, 26 Feb 2025 06:33:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	open list <linux-kernel@vger.kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] workqueue: Always use wq_select_unbound_cpu() for
 WORK_CPU_UNBOUND.
Message-ID: <Z79CRnnNHOkxMNXD@slm.duckdns.org>
References: <20250221112003.1dSuoGyc@linutronix.de>
 <Z7iSboU-05uMJ7-e@localhost.localdomain>
 <Z7iuUObJGgZtsaJe@slm.duckdns.org>
 <Z78s-1jHXehA33px@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z78s-1jHXehA33px@localhost.localdomain>

Hello, Frederic.

On Wed, Feb 26, 2025 at 04:02:19PM +0100, Frederic Weisbecker wrote:
...
> > That's API guarantee and there are plenty of users who depend on
> > queue_work() and schedule_work() on per-cpu workqueues to be actually
> > per-cpu. I don't think we can pull the rug from under them. If we want to do
> > this, which I think is a good idea, we should:
> > 
> > 1. Convert per-cpu workqueue users to unbound workqueues. Most users don't
> >    care whether work item is executed locally or not. However, historically,
> >    we've been preferring per-cpu workqueues because unbound workqueues had a
> >    lot worse locality properties. Unbound workqueue's topology awareness is
> >    a lot better now, so this should be less of a problem and we should be
> >    able to move a lot of users over to unbound workqueues.
> 
> But we must check those ~1951 schedule_work() users one by one to make sure they
> don't rely on locality for correctness, right? :-)

Yes, no matter what we do, there is no way around that.

> > 2. There still are cases where local execution isn't required for
> >    correctness but local & concurrency controlled executions yield
> >    performance gains. Workqueue API currently doesn't distinguish these two
> >    cases. We should add a new API which prefers local execution but doesn't
> >    require it, which can then do what's suggested in this patch.
> 
> That is much trickier to find out and requires to know about the subsystem
> details and history.

One good thing is that for workqueues that actually should be per-CPU for
performance, there usually are a group of people, often including the
mtaintainers, that would be familiar with the performance situation and pipe
up, so it's not *that* hopeless.

> For those that don't rely on locality for correctness, we would really like
> to be able to offload them to unbound pool at least when nohz_full= is filled.
> Because in that case we don't care much on workqueues performance.

Yeah, that makes sense to me.

Thanks.

-- 
tejun

