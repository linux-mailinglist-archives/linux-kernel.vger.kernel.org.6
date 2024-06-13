Return-Path: <linux-kernel+bounces-213351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74393907416
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E07FB260FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FA1144D1F;
	Thu, 13 Jun 2024 13:42:44 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5711448E4;
	Thu, 13 Jun 2024 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286164; cv=none; b=DxXqKSZWOku/j18lZ0IYxwb+hTfJv2pL/53ImdE/HotUYG7J9EmJlngl3T+WIx2Rf6k2W6UXMEcjZIGdgqtK1KJfsUBtGVOHE2kip9RRTB7nj4xhUIo4LLXe17I7StwUI/4nSdXEMTEHjcqaxqu/LlMI6M8ENOiREwVoFj/bvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286164; c=relaxed/simple;
	bh=BYkU2H0S4zNO8fR5V5JXw4c7o2fqGO6rVne/z+EvD1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCIP/QZXRjGKnwiowSF8LAAxhKLRRYTUKjmphwZI3LAINKYg0EPXNfAiUnoNQo5lRzV/PmvbFyUamirgJPv3iLdR5aSf3qkqduh6s70+T8ejfTHMhl0BwQ0ECK6PmobyKj03HQlrS9n2JXpUhYnbfdn4NidHDEKcgptbzZJDVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D36EC2BBFC;
	Thu, 13 Jun 2024 13:42:42 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:42:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>, Dan Carpenter
 <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: LTP tracing crashed on arm64 rk3399-rock-pi-4 - pc :
 ftrace_ops_test
Message-ID: <20240613094241.549038df@rorschach.local.home>
In-Reply-To: <CA+G9fYu+GbYyw5J0XBy_W8VcHPdEf5Yu-gV7nhZTZioz9G6q_A@mail.gmail.com>
References: <CA+G9fYsSVJQZH=nM=1cjTc94PgSnMF9y65BnOv6XSoCG_b6wmw@mail.gmail.com>
	<20240612125130.2c1d6d2d@rorschach.local.home>
	<20240612171748.0bc6d9cb@rorschach.local.home>
	<CA+G9fYu+GbYyw5J0XBy_W8VcHPdEf5Yu-gV7nhZTZioz9G6q_A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 13:29:58 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> > --- a/kernel/trace/fgraph.c
> > +++ b/kernel/trace/fgraph.c
> > @@ -641,7 +641,7 @@ int function_graph_enter(unsigned long ret, unsigned long func,
> >         {
> >                 for_each_set_bit(i, &fgraph_array_bitmask,
> >                                          sizeof(fgraph_array_bitmask) * BITS_PER_BYTE) {
> > -                       struct fgraph_ops *gops = fgraph_array[i];
> > +                       struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
> >                         int save_curr_ret_stack;
> >
> >                         if (gops == &fgraph_stub)
> >
> >
> > Because if the compiler decides to re-read gops from fgraph_array[i] after the
> > above check for the following line that does:
> >
> >                         save_curr_ret_stack = current->curr_ret_stack;
> >                         if (ftrace_ops_test(&gops->ops, func, NULL) &&
> >                             gops->entryfunc(&trace, gops))
> >                                 bitmap |= BIT(i);
> >
> >
> > and gops now points to fgraph_stub, it will trigger this bug.
> >
> > Can you apply the above change and see if the bug goes away?  
> 
> I will apply this patch and run the test in a loop.
> Since it is only seen once. Not sure I could validate this and confirm.

We could just look at the code that clang produced and see if it
accesses the fgraph_array[] again. If this was the cause, it would show
up it in the code.

But regardless, I think I'm going to add that READ_ONCE() anyway,
because it is legitimate for the compiler to do the above without it.

Thanks,

-- Steve

