Return-Path: <linux-kernel+bounces-410943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9939CF0AA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43663281DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71811D6187;
	Fri, 15 Nov 2024 15:46:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFE1D5CE3
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685604; cv=none; b=EYxzg84JHyHyFGC/PW1DWpi/yng2WKKXGDGXk0ZPCw1N5/eajBsRfOjK/LdPrMjVDsDumKHAtSfESfn1kmj5mOUQKtdLlo5Sy3MZWI6+J16BaS9pVb13cz2/GvDBrQblDfB9rN1/dJ4mv+dfG365IDsOjBcdq2y+Ga/TB9l4BGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685604; c=relaxed/simple;
	bh=nJcV3GxH1z1StS58ulVshw5pLbtCCtXkKoEE4Cs5EVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FiOSKyTbIjxcQAFWbsTb8JJvxnFwr/RTjjTKrQisVtTZYCarpYLk4BnF/0oy6A4nIcNir7CPOzFwMz2pF2HPcKN1VgSihLuHQR3yyCjpSQYf9T2fa8OjRIqWupbpGJXzTRG613NS411+ugGVpoBHoTEOrSB69IuUrBjpqXg6vBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B17C4CECF;
	Fri, 15 Nov 2024 15:46:42 +0000 (UTC)
Date: Fri, 15 Nov 2024 10:47:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jon Kohler <jon@nutanix.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: use smp_wmb in rt_clear_overload
Message-ID: <20241115104706.52b03f47@gandalf.local.home>
In-Reply-To: <20241115100341.GW22801@noisy.programming.kicks-ass.net>
References: <20241114213156.1839644-1-jon@nutanix.com>
	<20241115100341.GW22801@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 11:03:41 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> There is a comment in pull_rt_task() that says there is a barrier in
> rt_set_overloaded(), was there ever, when did it go away?

That's a typo. It matches the barrier in rt_set_overload().

I'll take a look at this change too, since I wrote a bunch of this code a
long time ago. :-p

-- Steve

