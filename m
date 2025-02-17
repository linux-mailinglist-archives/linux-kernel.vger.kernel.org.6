Return-Path: <linux-kernel+bounces-518201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE9BA38B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83DB7A3AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762FD22F3BA;
	Mon, 17 Feb 2025 18:38:13 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED3F18BBB9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817493; cv=none; b=LpfH3Yh80aC7ij9m3seKcxi1y51sSqcDnMijRsplQWg3bqbqm0N9Q7pZX7sIfzrxI195btMcCKf/AUlNjoc+t7TmaG8Ar082dJ6N0fsnXdG5haBoiRbk+mjy4qOR7zUTt0kgvjcgM9xF6DEcjVekviD2wM6VlsBPW8u6oVFAjdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817493; c=relaxed/simple;
	bh=7cv9t7KPQUFNr5F6TuYUPYx8eCGfdxIy4jwla4a9dSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8277h7DpBhQO6R40F533b0BE+5PIzWRLFO6wDekUD/4zwCbleKJvpXdQ/5SPbRWUUia1fBCoYp+llvu+zeDZlUV6yFQ9c0oriynzmgZhPWqmKCn/EoxLsxLmQrp2gdD0I14r0zDRHStx7bUCSYFRhMLCEjWgEU0J4voda3tDfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6166AC4CED1;
	Mon, 17 Feb 2025 18:38:11 +0000 (UTC)
Date: Mon, 17 Feb 2025 13:38:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sven Schnelle <svens@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [GIT PULL] ftrace: Updates for v6.14
Message-ID: <20250217133830.25e634d8@gandalf.local.home>
In-Reply-To: <20250217114918.10397-A-hca@linux.ibm.com>
References: <20250119193134.0ebd56bc@gandalf.local.home>
	<20250217114918.10397-A-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 12:49:18 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> $ cat /sys/kernel/debug/tracing/current_tracer
> nop
> 
> Bisected to commit 4346ba160409 ("fprobe: Rewrite fprobe on function-graph
> tracer"). Before this commit there were no ftrace enabled functions after the
> test suite finished:
> 
> $ wc -l /sys/kernel/debug/tracing/enabled_functions
> 0 /sys/kernel/debug/tracing/enabled_functions
> 
> This is on s390 with defconfig.

Thanks, I can reproduce it on x86 (I didn't check that commit though).

I'll take a look.

-- Steve

