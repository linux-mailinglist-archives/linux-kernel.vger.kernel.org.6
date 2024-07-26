Return-Path: <linux-kernel+bounces-262981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B6C93CF63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331111C21C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49257581D;
	Fri, 26 Jul 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LBOH88gs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74111862A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721981718; cv=none; b=ecKcXOKsxadN9w6uBa9U055ua88iH/buHa+qkQjH5fcbFAQP0Is8ErQgQ0KMqf0vq6mCxZk4zSawiz6GZZo8miS/7NKRqP1ef34EdeWgyTNLab27XKwsGtj/kvCCeo/SyRzCxWL8GH8AZDnM/SiWanOXsSZ1RhbfjMQdg3u49/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721981718; c=relaxed/simple;
	bh=vj16Z/FJB9AlM4Uwb5qqQaltFdExF4iED2UWe8eiBb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFDcBDCemNSHUP4WUuL9vfPL4NR51XfLKEm8A4YsqypPwnQPVyT0veL4GjfKKbYpaY4fzkdUK05sGLVkKBa6g1sERSCeu5fT3joGZaPy6KZHnSl9KYqSG5pef98LJybkLUsanP/Colq3oea17MeuTvQPO64HZofdi9Pi9/XdqYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LBOH88gs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D82C32782;
	Fri, 26 Jul 2024 08:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721981717;
	bh=vj16Z/FJB9AlM4Uwb5qqQaltFdExF4iED2UWe8eiBb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBOH88gsUM59l0oJu6J/qtREQw04zIUZtkoz61sjgjsSxNb3wtKl2/mWdvpRPp8Xr
	 Nl1YTbsVtcpEBjxVprkzou0TJ4m4jcnwUcqvdozUKvbJxNqBniPoF3fUpCNKare93U
	 Ud97W3b/J239CE1BQannsyVTD1B6HOnTWlBFTJtk=
Date: Fri, 26 Jul 2024 10:15:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <2024072611-unrelated-aflame-bf41@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
 <20240725083102.38950c1c@gandalf.local.home>
 <2024072506-aghast-appointee-7f83@gregkh>
 <20240725092609.1441788d@gandalf.local.home>
 <2024072525-declared-yam-0cad@gregkh>
 <20240725095307.3067329f@gandalf.local.home>
 <2024072526-manned-ludicrous-1ce2@gregkh>
 <20240725121745.787c5b33@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725121745.787c5b33@gandalf.local.home>

On Thu, Jul 25, 2024 at 12:17:45PM -0400, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 16:41:11 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
>  This workflow is used by many developers.  
> > 
> > Is it documented anywhere?  I've never heard of it before, and nothing
> > really describes this in Documentation/ that I can find.
> 
> It is mentioned, but I could expand on it more:
> 
> Documentation/trace/ftrace.rst:
> 
>   tracing_on:
> 
>         This sets or displays whether writing to the trace
>         ring buffer is enabled. Echo 0 into this file to disable
>         the tracer or 1 to enable it. Note, this only disables
>         writing to the ring buffer, the tracing overhead may
>         still be occurring.
> 
>         The kernel function tracing_off() can be used within the
>         kernel to disable writing to the ring buffer, which will
>         set this file to "0". User space can re-enable tracing by
>         echoing "1" into the file.

Seems "dangerous" that any random driver can control all of the tracing
system like this, but you do you :)

> > But as you only want these to be exported to developer kernels, why not
> > say that and put that behind a debugging Kconfig option or something?
> 
> Why add the burden of having to compile the core kernel to enable it? I use
> this all the time.
> 
> > That way "vendor kernels" can properly disable this as they don't want
> > to give this type of functionality to random 3rd-party kernel modules.
> 
> This has been exported since 2008. Has it ever been a problem in the last
> 16 years?

As I am finding out, yes, external modules are "abusing" this to do
different types of logic depending on if tracing is enabled or not for
various unknown reasons.  As there was no in-kernel user of this symbol,
I assumed it was just an oversight and should be removed.

I'll go ask the distro involved to just remove the symbol from their
kernels instead, but that feels like the wrong thing to do to me.

thanks,

greg k-h

