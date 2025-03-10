Return-Path: <linux-kernel+bounces-554466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5B9A5980D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A27A2106
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E06F1AB52D;
	Mon, 10 Mar 2025 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Utlr2qkU"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA3718E361
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618047; cv=none; b=RIQpA2oO8uoRFuBJlQiNhBSja27MoEbnrZaYA6BKKBsiPn0i3CH15RTfnLUwujEr76MJ5/EJj7VFb828z1VadBnMWlgHtlAtQO1UCTAwZVEHGt1V8rEWkQC/dzzvmulGxzf2+rFZJlriNLMJYucBbLtztyeNqDiE669+5e90Q7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618047; c=relaxed/simple;
	bh=t4yepGD+f8Xcpt9SoYh7fZ7h4uxzB9rjYqJH73/SkqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo6sczlTGUySlUye9DhtGGt2UfVYcIS4O5yQ03VFUXFk+s97PLqpBO0SMX7jd/GFFl+2DbNAElS60no2HWgkxlVKAFj8b4+SZf/MOIZw05yCuWgGrAD4h8D6pEMM43o+mw0cvHcSVB/In8MDeZOrYBhsjEEsdIrNbPqkc3ghRuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Utlr2qkU; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vV4hiSomHqqYjfNKJCMNwDTgWrQfWvEQzcf0QSjyy1U=; b=Utlr2qkUb3+iuc3Fps/o9gALyw
	RtCzX7bb+zNOS/I9XfyODrE8HvJByqlO1gnzQxeYD77zYYlSLqdDguxtDmbJDw0XkoNivynrpnAX9
	vznTxau2ep014ptcrvV9cGl6feZD6HQQnpxn1FICPA86Btw85J8Tkt6OS/d3c5tISx1vKqdZULb7/
	Cui+wUQD0HpqIegNhJFRSzcy4NVlQLyK9C/CkBD0kLxihDWw+kUdslcDcD3Rfe6ThW+OlqB8eJK+M
	SCbty+oFvHBuQ0YTGT24oev+xfi+vCaiip1ta4gHe+mhjZULHPQXgW46hkf1KR8vz4MQDhXVk/MZV
	HjWrFV9Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1trePX-00000001sCF-09ID;
	Mon, 10 Mar 2025 14:47:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A0BB2300599; Mon, 10 Mar 2025 15:47:17 +0100 (CET)
Date: Mon, 10 Mar 2025 15:47:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: mingo@kernel.org, lucas.demarchi@intel.com,
	linux-kernel@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Subject: Re: [PATCH v3 6/7] perf: Rename perf_event_exit_task(.child)
Message-ID: <20250310144717.GS5880@noisy.programming.kicks-ass.net>
References: <20250307193305.486326750@infradead.org>
 <20250307193723.417881572@infradead.org>
 <d8be26ad-763b-4ab0-9f57-cfafad792194@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8be26ad-763b-4ab0-9f57-cfafad792194@amd.com>

On Mon, Mar 10, 2025 at 04:38:36PM +0530, Ravi Bangoria wrote:
> Hi Peter,
> 
> On 08-Mar-25 1:03 AM, Peter Zijlstra wrote:
> > The task passed to perf_event_exit_task() is not a child, it is
> > current. Fix this confusing naming, since much of the rest of the code
> > also relies on it being current.
> > 
> > Specifically, both exec() and exit() callers use it with current as
> > the argument.
> 
> ...
> 
> > -static void perf_event_exit_task_context(struct task_struct *child, bool exit)
> > +static void perf_event_exit_task_context(struct task_struct *task, bool exit)
> >  {
> > -	struct perf_event_context *child_ctx, *clone_ctx = NULL;
> > +	struct perf_event_context *ctx, *clone_ctx = NULL;
> >  	struct perf_event *child_event, *next;
> >  
> > -	WARN_ON_ONCE(child != current);
> > +	WARN_ON_ONCE(task != current);
> 
> exec() codepath (i.e. copy_process()) passes child pointer, not 'current'.

I am confused, this not a new warning. Also, copy_process() is clone(),
exec() is another code path.

