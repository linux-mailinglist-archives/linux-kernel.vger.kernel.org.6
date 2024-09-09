Return-Path: <linux-kernel+bounces-322026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266EC972307
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C26EE1F248FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27E189F2F;
	Mon,  9 Sep 2024 19:55:39 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AF1171066
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911739; cv=none; b=uebArcwSo3uhcisPhsEIsiHt/m8Q25OqZMb+zyEkzdWvGyIBrmhalEyNLsaizfcWfUjUz+X3EO3S7G7tLRWi0maIKZmmzoVCl4znHoTFoJSetyIx+bLgjnPI0bu3Lr4SMxs0TT2XVaCZjgDd8SbXdY/Lh2MX8A5agizeLledYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911739; c=relaxed/simple;
	bh=oTrtrWyf8b6pWanO+xSBmm+OyUWvBRFZrpT/f2Fpdeo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C5SDHegUgJxRJmbhe809VNccy9LoT67B56a/piVn6AozaUX8JwiLaCb9eQMnJVj7wcob7tlC6XzXiHetbggXrvIUvVPAmjvwz7TbLc3xr/dkF/C59TflMQ3A7XFaQtN/USA6ukYshv9h1z3tMwroeQPiddGAzgLKHkOOtWaihTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C729C4CEC5;
	Mon,  9 Sep 2024 19:55:38 +0000 (UTC)
Date: Mon, 9 Sep 2024 15:55:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 0/2] tracing: A couple more fixes for 6.11
Message-ID: <20240909155537.7de3ed82@gandalf.local.home>
In-Reply-To: <20240909195035.533786334@goodmis.org>
References: <20240909195035.533786334@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Looks like my system upgrade broke quilt, or at least the send mail portion
of it. It went into an infinite loop sending this, and I had to kill it :-p
and it didn't send any of the patches.

I'll go and see what broke.

-- Steve


On Mon, 09 Sep 2024 15:50:35 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> More tracing fixes for 6.11:
> 
> - Move declaration of interface_lock outside of CONFIG_TIMERLAT_TRACER
> 
>   The fix to some locking races moved the declaration of the
>   interface_lock up in the file, but also moved it into the
>   CONFIG_TIMERLAT_TRACER #ifdef block, breaking the build when
>   that wasn't set. Move it further up and out of that #ifdef block.
> 
> - Remove unused function run_tracer_selftest() stub
> 
>   When CONFIG_FTRACE_STARTUP_TEST is not set the stub function
>   run_tracer_selftest() is not used and clang is warning about it.
>   Remove the function stub as it is not needed.
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> trace/urgent
> 
> Head SHA1: eac6c0f8f297db0ee4434d076faf45a594c42b42
> 
> 
> Andy Shevchenko (1):
>       tracing: Drop unused helper function to fix the build
> 
> Steven Rostedt (1):
>       tracing/osnoise: Fix build when timerlat is not enabled
> 
> ----
>  kernel/trace/trace.c         |  4 ----
>  kernel/trace/trace_osnoise.c | 10 +++++-----
>  2 files changed, 5 insertions(+), 9 deletions(-)


