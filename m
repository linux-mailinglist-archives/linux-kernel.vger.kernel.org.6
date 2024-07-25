Return-Path: <linux-kernel+bounces-262381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB693C645
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5781C2203D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A919D8BA;
	Thu, 25 Jul 2024 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PHf3a2D+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002719D8B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920758; cv=none; b=p7XrQsG80cMB1YvgTSrY8QvUoJ3kfC9rc48I/kKd38VwDo/w3A/MMckB0DomcKBXY2lSCvQaKtxzP5jsYQPB5KpEBHvoQCAxUUwuoXuWxGc5CMImB+2nhum9y7yJVFvSXRn58mMzlqmFtgSX+Rc/bz2AQsmGGQF6cWK6eX1aeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920758; c=relaxed/simple;
	bh=pbIi9oGNpNXT2dkNfUs2tBnsh8bfDm631ifM/9QK6ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUXZXzYk+a2/5ptcvcMK08Raa18vkjjUV1buyW3DRAydm2yWVBIwdK7YO1e51zeBTCaNMg3wdp2YLEg2ha+3vNaEyoJuIjiEl5F9nsx0vDUC1TfBxSG6WvRjT0rDFOPQNMXJJvJ4F0Lv/mRrPvs//6JDeJQOm/cOZy/S4eQAoW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PHf3a2D+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A679AC32782;
	Thu, 25 Jul 2024 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721920758;
	bh=pbIi9oGNpNXT2dkNfUs2tBnsh8bfDm631ifM/9QK6ZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PHf3a2D+KHv88oy1s0k40rBRMppy4lPADfivwM1hlmRwuqjtyu6sdSyZVTywfrduH
	 TnVKazYb2NN5ZqdZf56d6xPoIxZXvmYq09wM3md2UciFF8fOaRZZ9Fmqpb08lnYfus
	 O9B6ts7QsFIBXx8uiuwSy9Y6z1HeVdb4TEwcarpA=
Date: Thu, 25 Jul 2024 16:41:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <2024072526-manned-ludicrous-1ce2@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
 <20240725083102.38950c1c@gandalf.local.home>
 <2024072506-aghast-appointee-7f83@gregkh>
 <20240725092609.1441788d@gandalf.local.home>
 <2024072525-declared-yam-0cad@gregkh>
 <20240725095307.3067329f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725095307.3067329f@gandalf.local.home>

On Thu, Jul 25, 2024 at 09:53:07AM -0400, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 15:35:00 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > Generally, we don't allow symbols that are not actually being used in
> > the kernel tree?  tracing_is_on() is a "code flow" type of thing, where
> > code can operate differently if it is enabled or not.
> > 
> > And I would argue that tracing_on() and tracing_off() should also not be
> > allowed to be in a module, why would you want that?  Just enable/disable
> > it from userspace when doing your testing, IF you have permission to do
> > so.
> 
> tracing_off() is key to development, and one that I would argue very much
> against removing. The other two are more just for "completeness".
> 
> It usually is used by adding a bunch of trace_printk(), and then:
> 
> 	if (condition) {
> 		trace_printk("Condition hit!\n");
> 		tracing_off();
> 	}
> 
> And then you run your kernel until you noticed that something weird
> happened. Then look at the trace file, and it will have all the events that
> happened up to the anomaly condition, and you don't have to worry about the
> ring buffer overflowing and losing your data.
> 
> This workflow is used by many developers.

Is it documented anywhere?  I've never heard of it before, and nothing
really describes this in Documentation/ that I can find.

But as you only want these to be exported to developer kernels, why not
say that and put that behind a debugging Kconfig option or something?
That way "vendor kernels" can properly disable this as they don't want
to give this type of functionality to random 3rd-party kernel modules.

thanks,

greg k-h

