Return-Path: <linux-kernel+bounces-366829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123BA99FB0A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A701C234CB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1151D63F7;
	Tue, 15 Oct 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gc5CSKB9"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103AC1D63D5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729030369; cv=none; b=hqs/vtqh6O9UWjkaqb0eOToeh3ZFWK3YefeVkggpYXHGf1/GACrgyRSM8tRneYx5KK24UDxryggP4GGzRCODI6DD93AyHiXjBatqkRCE2F+8AEtg2jhp0ZFoQl1g07j1/EmLdSam8xMCct/bgQqKX/VpO+T8dKc4DYvdFZduhwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729030369; c=relaxed/simple;
	bh=qKsquAPd7RGZiWNsticIIwkqt1epwzwHhaYWEFEPAI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoK8uwYZtcXoX9BiOKVTtoOuc269ti8ZHCKsLtbAYl3JV6tXaNT4neRc9sG8JPgex3KcSzZ8ZCwzH4anQUrUyA5UmWy2zRydu+yVxH2+XvGexN2bJGbYXFWfHCSOVinUBiBQ+7TVLaBuU21ysTBMKPZ93SScZc9JJbIPrLVePHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gc5CSKB9; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 00:12:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729030364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EMcOU7/QSRVq81BFSE+q603ftk9NynIpdrS2PM4Y+tE=;
	b=Gc5CSKB9NjcCXKTXpG0ru4DmqBujy50QWZYCNngMFhDv0qgJyXFUHRzAoTij1hIbz4imLZ
	1fwyjlSZlx1S8rd3mXz9FEA+2uEhCP41Ev7fwnl+l9mGxkRofx4zaJK3FftbcjSDaIhAl6
	i+iVWUNvI8AWJfqqtVU3zFw/ITn/jno=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrea Righi <andrea.righi@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v4] sched_ext: Trigger ops.update_idle() from
 pick_task_idle()
Message-ID: <Zw7o0ot9Utomq9qa@gpd3>
References: <20241015111539.12136-1-andrea.righi@linux.dev>
 <Zw5_FlXfbLXDLCPG@slm.duckdns.org>
 <Zw6KuWHPn9d6GWOK@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw6KuWHPn9d6GWOK@gpd3>
X-Migadu-Flow: FLOW_OUT

On Tue, Oct 15, 2024 at 05:31:09PM +0200, Andrea Righi wrote:
...
> > - For the purpose of determining whether a CPU is idle for e.g. task
> >   placement from ops.select_cpu(). The CPU *should* be considered idle in
> >   this polling state.
> > 
> > Overall, it feels a bit contrived to generate update_idle() events
> > consecutively for this. If a scheduler wants to poll in idle state, can't it
> > do something like the following?
> > 
> > - Trigger kick from update_idle(cpu, true) and remember that the CPU is in
> >   the polling state.
> > 
> > - Keep kicking from ops.dispatch() until polling state is cleared.
> > 
> > As what kick() guarnatees is at least one dispatch event after kicking, this
> > is guaranteed to be correct and the control flow, while a bit more
> > complicated, makes sense - it triggers dispatch on idle transition and keeps
> > dispatching in the idle state.
> > 
> > What do you think?
> 
> That seems to work in theory, I'll run some tests to confirm that it
> also works in practice. :)
> 
> It looks definitely nicer than triggering multiple ops.update_idle()
> from the kernel and we can maintain the proper semantic of triggering
> update_idle() only on actual idle state changes.

For the record, this seems to be working for now. Here is the
implementation of the idea proposed by Tejun:
https://github.com/sched-ext/scx/commit/40ccca8cbef8fc73e16bfb789c7565326b3cca62

Therefore, we can ignore the kernel patch.

Thanks for the help on this!
-Andrea

