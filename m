Return-Path: <linux-kernel+bounces-262242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19AB93C2E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1D31C218FD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0218719ADB6;
	Thu, 25 Jul 2024 13:25:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AACC8DF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721913950; cv=none; b=O8xwS9htm6sENbY5QMjSL8R8sUKCbez+TpHkkqeMNbiiE9OhSp7B3WVlONeJQ4B8cHezdmcdEy3Dk91xrbKYY7S3uEaCn8VBNRn/qL5dsghIg1LzgRwnCC6bubfXJiFrDiSOotCSP3eYAp3w+2BusVAOtc6ChxqTX2s2S5BmNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721913950; c=relaxed/simple;
	bh=WAotzDsgjQFcLY3DeTzUEEWq1HTCsuplBH2nJEzD90M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/3lMLDOU7HfQOsYmdCo1NYM4uuwEf32b3ankmjBAfm4P4Psrp/PAv0lq8LDyQt+jauNYGjc7aSMwqR304had37bLB8dOvcYjOajh/P7DI37Jj0TJKe89z9rFmB5pfKQ0abNvOsqDpCjUGMzr8CS492LVhna4tM3cVY59Vgk4kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3FC116B1;
	Thu, 25 Jul 2024 13:25:49 +0000 (UTC)
Date: Thu, 25 Jul 2024 09:26:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <20240725092609.1441788d@gandalf.local.home>
In-Reply-To: <2024072506-aghast-appointee-7f83@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
	<20240725083102.38950c1c@gandalf.local.home>
	<2024072506-aghast-appointee-7f83@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jul 2024 14:52:24 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 25, 2024 at 08:31:02AM -0400, Steven Rostedt wrote:
> > On Thu, 25 Jul 2024 11:36:08 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >   
> > > The function tracing_is_on() is only called by in-kernel code, not by
> > > any modules, so no need to export it as a symbol at all.  
> > 
> > Hmm, this is part of the debugging code along with:
> > 
> >  tracing_on();  tracing_off();
> > 
> > I had it exported in case a module needed to use it in debugging.  
> 
> What module?  There is no in-kernel user of it as a module that I could
> find, what am I missing?
>

Any module ;-)

It's for debugging. Just like trace_printk(). Something you would add to
debug a module and then delete it before submitting. It's why I put the
prototype into kernel.h. It's one of functions that can be handy during
development. It's not supposed to be submitted into the kernel.

Granted, tracing_is_on() is probably the least likely one to be used, but I
added it with the package, and I have actually used it for debugging a few
times.

-- Steve

