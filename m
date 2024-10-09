Return-Path: <linux-kernel+bounces-357580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 871C89972E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 19:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8F321C21A8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1621DFD8E;
	Wed,  9 Oct 2024 17:19:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F951DEFF0;
	Wed,  9 Oct 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728494356; cv=none; b=tPZM454TSA9KxNVuXhQV4RmBNWmT83STMisvTyhTI2nXqQRXY95IXquBN6MPVjzaynVA3dH80i8VNG9B3Dc2mfuU2e6qUBa7ZDBZ/2bl/Ayy6nJq4cisfgr43fD8LBRQtYsFYnHry1Y2163FJdNlHxQimVK3hcWNtOMgk1ZPjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728494356; c=relaxed/simple;
	bh=GiTnS78It4gpOlcQnpixGNdlUMfQV9vGGk1hGdtxtOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3toYGOQRNlTg2SRxfwKdzUD+gb0XMNTZksfBQovLNDnMQ/7qnOG01LbI2RAgmitUry2q9Y+2n9uwjjfOcP56n0/5msOndJQz8j675zS3rTIozMEL5tHQQ8JWQIpaTPHBcnUAM6iDmZ2GoUCZiAqieZxK9ndeQOAIK+kx4lvyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEF8C4CEC3;
	Wed,  9 Oct 2024 17:19:15 +0000 (UTC)
Date: Wed, 9 Oct 2024 13:19:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 RESEND] function_graph: Support recording and
 printing the function return address
Message-ID: <20241009131920.2afaf15f@gandalf.local.home>
In-Reply-To: <20241010013222.3748287f165e9f874eda0f84@kernel.org>
References: <20241009030340.16400-1-dolinux.peng@gmail.com>
	<20241010013222.3748287f165e9f874eda0f84@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 01:32:22 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >From 8c2851452dd11a3a20ab22bd6bf8dd663c3c4b9c Mon Sep 17 00:00:00 2001  
> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> Date: Thu, 10 Oct 2024 00:58:12 +0900
> Subject: [PATCH] tracing/fgraph: Simplify return address printing in function
>  graph tracer
> 
> Simplify return address printing in the function graph tracer by removing
> fgraph_extras. Since this feature is only used by the function graph
> tracer and we can check the flag directly in the function graph tracer,
> we can remove the fgraph_extras from the fgraph callback.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  include/linux/ftrace.h               | 16 ++++------
>  kernel/trace/fgraph.c                | 45 ++++++++++++++++++----------
>  kernel/trace/ftrace.c                |  3 +-
>  kernel/trace/trace.h                 |  3 +-
>  kernel/trace/trace_functions_graph.c | 14 ++++-----
>  kernel/trace/trace_irqsoff.c         |  3 +-
>  kernel/trace/trace_sched_wakeup.c    |  3 +-
>  kernel/trace/trace_selftest.c        |  8 ++---
>  8 files changed, 48 insertions(+), 47 deletions(-)
> 

Hi Masami,

Care to send this as a real patch?

-- Steve

