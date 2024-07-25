Return-Path: <linux-kernel+bounces-262434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5D93C712
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D90D1F2261B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC1419D8BD;
	Thu, 25 Jul 2024 16:17:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884319D880
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924246; cv=none; b=OkJEoUmrQ4tH5ad1vU9LeHkBDoAc9ltQ+sLapeP5qM8yqEna1JLCD13IUSJrOerYmu2huPGC5edLlkkWKTvQqnKGxUJdJV56uAhNJbFz2HLUsXqReEmVmR4EH7vFmOK6DDIfdhDxYZlcI3vwveSpR/f6L480xA3m2UfYhs5by+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924246; c=relaxed/simple;
	bh=iECMtmdYOLkr3A1KPzDxDMdfWIsHqgEFITEW6YRhIL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUnEAQjrhrmnlon2ZgCKWHKOXNmionIE0rEi9Al68sH8lXAKhHe9JFvp5X17iILiWaA31MEkoM6yxZWcQXyLVpaK2y0qDcJ+uE8AHI/a+ahq3gzlt8h8EY02TqZRSpFmrzyGRGlxX+jICRDIDyLamKKfzF/6BzfgdlmjHSbeU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934EFC116B1;
	Thu, 25 Jul 2024 16:17:24 +0000 (UTC)
Date: Thu, 25 Jul 2024 12:17:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <20240725121745.787c5b33@gandalf.local.home>
In-Reply-To: <2024072526-manned-ludicrous-1ce2@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
	<20240725083102.38950c1c@gandalf.local.home>
	<2024072506-aghast-appointee-7f83@gregkh>
	<20240725092609.1441788d@gandalf.local.home>
	<2024072525-declared-yam-0cad@gregkh>
	<20240725095307.3067329f@gandalf.local.home>
	<2024072526-manned-ludicrous-1ce2@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 16:41:11 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

 This workflow is used by many developers.  
> 
> Is it documented anywhere?  I've never heard of it before, and nothing
> really describes this in Documentation/ that I can find.

It is mentioned, but I could expand on it more:

Documentation/trace/ftrace.rst:

  tracing_on:

        This sets or displays whether writing to the trace
        ring buffer is enabled. Echo 0 into this file to disable
        the tracer or 1 to enable it. Note, this only disables
        writing to the ring buffer, the tracing overhead may
        still be occurring.

        The kernel function tracing_off() can be used within the
        kernel to disable writing to the ring buffer, which will
        set this file to "0". User space can re-enable tracing by
        echoing "1" into the file.

> 
> But as you only want these to be exported to developer kernels, why not
> say that and put that behind a debugging Kconfig option or something?

Why add the burden of having to compile the core kernel to enable it? I use
this all the time.

> That way "vendor kernels" can properly disable this as they don't want
> to give this type of functionality to random 3rd-party kernel modules.

This has been exported since 2008. Has it ever been a problem in the last
16 years?

-- Steve

