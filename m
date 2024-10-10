Return-Path: <linux-kernel+bounces-359398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5130998CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E9B38F9B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426771D042C;
	Thu, 10 Oct 2024 15:04:29 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFB1CC88F;
	Thu, 10 Oct 2024 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572668; cv=none; b=cfDpSBMraTbMOyqjVHviV8wEJhN6SfoEf3TBrb8b/zXWo9XLLkm2Uwb/UrNVq1es/sfWU3ZBWNeD255f89xaNejP6I2JuCtIOYtLPARkcEotVdqjqx8rqDIelQKGJTR1cEV7XqROcoajgOs2Hjq84sCZpMTICpVzGSCMRbjkfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572668; c=relaxed/simple;
	bh=PxJSLcImqknPFWiDqzRa1RiNEUEGebC6uzrqr1bbrtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5zNsQYCjMMt+VtxUly7XAvVClxhbzVep+dLjz5iT/4oXJ9wGzphI1xmuCkq3YVV7Nk7pYRBaTaEMkZR6IZSKZZzQjQ3oeeQ0B7ajcvd5bEY5OJo0YKbpCYDnRPrJGvDALZO4GkA7+aRunqRYdwP+sI4RHacXe9rvcUrgrIEN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99782C4CEC5;
	Thu, 10 Oct 2024 15:04:26 +0000 (UTC)
Date: Thu, 10 Oct 2024 11:04:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu
 <mhiramat@kernel.org>, Zheng Yejian <zhengyejian@huaweicloud.com>, Donglin
 Peng <pengdonglin@xiaomi.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20241010110434.662595e2@gandalf.local.home>
In-Reply-To: <CAErzpmv7qAAXLt+J8Kn0kSkJeu64eE1P8Yv-WgGxuuMMpwGUHQ@mail.gmail.com>
References: <20241010134649.43ed357c@canb.auug.org.au>
	<20241010092755.21874a9f@gandalf.local.home>
	<CAErzpmv7qAAXLt+J8Kn0kSkJeu64eE1P8Yv-WgGxuuMMpwGUHQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 22:08:04 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> > Hmm, strange. This went through my tests that also does an allmodconfig build.
> >
> > I'll go investigate. Thanks for the report.  
> 
> I suspect that the configuration CONFIG_FUNCTION_GRAPH_RETADDR may be
>  disabled during testing. If this configuration is indeed disabled,
> the function
> __trace_graph_retaddr_entry will not invoke call_filter_check_discard.

allmodconfig should enable it. Unless it's a tristate.

I'll look at my tests to see if something else caused it to be disabled.

-- Steve

