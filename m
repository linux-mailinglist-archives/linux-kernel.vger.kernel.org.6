Return-Path: <linux-kernel+bounces-347874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC898DFC4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E41F6286B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F25B1D1E7C;
	Wed,  2 Oct 2024 15:48:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3541D1E83;
	Wed,  2 Oct 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884107; cv=none; b=Rn3L0lK95J4ttrDbJakKt/BZs+e5dQACeykk2IAJhsVsb7WUA2FqWjCwg9b6fKpGRYQfQnJzqCT8kAiQ4vND0IW5SszZUyzb+EKFEv2U85Pp4qE2Yo06hpJxaOlo+Y2ZUvrGOsEr79wX0b3JR0Vby12Ru3jl1/325Zi5EfF18lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884107; c=relaxed/simple;
	bh=EHqQcGMzFnv/BB0WyR8lN6YU+xHk/lTA5lKGSSVWtkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7S9djTu8ZFhB0fidYNRvfbyWBl6GmV9/8M6OEjCmabbaI4k69XmNCgj3KrxZVZGEojxL9EGMJ4Ehi+KaLuEc8g388pVJBItXAFbRsn5Mnid+jvojgGezOjo5MCRPGJZC2aSyu3R4/aP+XZHSbidW9Mj8LBVFQcytC3wcv/zmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE40DC4CEC2;
	Wed,  2 Oct 2024 15:48:25 +0000 (UTC)
Date: Wed, 2 Oct 2024 11:49:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tatsuya S <tatsuya.s2862@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Hide a extra entry in stack trace
Message-ID: <20241002114917.227ed564@gandalf.local.home>
In-Reply-To: <920d0c47-bc4a-418f-a9ea-ceeb931748f5@gmail.com>
References: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
	<20241002095640.55e6cc37@gandalf.local.home>
	<920d0c47-bc4a-418f-a9ea-ceeb931748f5@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 00:28:28 +0900
Tatsuya S <tatsuya.s2862@gmail.com> wrote:

> > Tatsuya S <tatsuya.s2862@gmail.com> wrote:
> >   
> >> A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).
> >>
> >> [003] .....   110.171589: vfs_write <-__x64_sys_write
> >> [003] .....   110.171600: <stack trace>  
> >> => XXXXXXXXX (Wrong function name)  
> > 
> > BTW, instead of X'ing it out, can you show what that extra function was.
> > Just saying "Wrong function name" doesn't give me any idea of what happened.  
> This is changed each shutdown.
> For example, client_init_data, hidpp_driver_init, rfcomm_init.
> 
> The same function name was displayed each time if system was not shutdown.
> 
> And I added "nokaslr" to the kernel command line and boot, got same result.

So I'm trying to understand this part. Where is the function coming from
then? The skip is there to skip over the functions that are calling the
stack trace. It shouldn't be garbage, as the stack walk shouldn't be giving
us that.

Now I'm even more curious to what is going wrong.

-- Steve

