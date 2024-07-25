Return-Path: <linux-kernel+bounces-262256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52C93C31B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6732831F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E719AD8B;
	Thu, 25 Jul 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wea0xSu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817EC8DF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914504; cv=none; b=EGVwrf68bdBLacRosAk6R5lvfzD61GMqUNKVi8+socW5UXNop4uu9gyX2rXK6ie2J5tWrwDZOTCFw5/+ZJrl95GMHonnajm3apl+FuqIkGCHXrSdAijhUC/MvhN1lbp4MjHwAFUz8ejLZogC4kINZAI4I8O7BMWpYbGduxOBWuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914504; c=relaxed/simple;
	bh=aZZ97Q43K83GvaQ1kiSRGJQGnb2dXEq+CuxYHuArkx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocr1joKRJdltBg6glayy+wS101gJXcpprlL5m50PqDlQgpAwM4hvvfPh+vmZCnZM36Lau5bcbyQNH9y0bjw+zDrf3VUEn9DKeVkw1Jkdgu9J64PWqvrapCz8Mbqeoj7q4euoW/BSqw7GnsEhVV3plGxawbq5ocdmRP32oea5aW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wea0xSu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CC1C116B1;
	Thu, 25 Jul 2024 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721914503;
	bh=aZZ97Q43K83GvaQ1kiSRGJQGnb2dXEq+CuxYHuArkx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wea0xSu3niUREtOeNFxceUHo/vLRxThyLnEo5fjlh8l6eW14MfodcOSB1NP9rRPwm
	 FD086lygDHYVOLYa8WpVRBYkyejY64Ct8OtDB7RMreLKfjCBleDF+7Zo1ZD/+AjEPs
	 avYIWLo6S6r+1cCa4yv6hjHWULC/Si9GGRxbATZU=
Date: Thu, 25 Jul 2024 15:35:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: remove tracing_is_on export
Message-ID: <2024072525-declared-yam-0cad@gregkh>
References: <2024072508-freefall-headstand-7d47@gregkh>
 <20240725083102.38950c1c@gandalf.local.home>
 <2024072506-aghast-appointee-7f83@gregkh>
 <20240725092609.1441788d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725092609.1441788d@gandalf.local.home>

On Thu, Jul 25, 2024 at 09:26:09AM -0400, Steven Rostedt wrote:
> On Thu, 25 Jul 2024 14:52:24 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 25, 2024 at 08:31:02AM -0400, Steven Rostedt wrote:
> > > On Thu, 25 Jul 2024 11:36:08 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >   
> > > > The function tracing_is_on() is only called by in-kernel code, not by
> > > > any modules, so no need to export it as a symbol at all.  
> > > 
> > > Hmm, this is part of the debugging code along with:
> > > 
> > >  tracing_on();  tracing_off();
> > > 
> > > I had it exported in case a module needed to use it in debugging.  
> > 
> > What module?  There is no in-kernel user of it as a module that I could
> > find, what am I missing?
> >
> 
> Any module ;-)
> 
> It's for debugging. Just like trace_printk(). Something you would add to
> debug a module and then delete it before submitting. It's why I put the
> prototype into kernel.h. It's one of functions that can be handy during
> development. It's not supposed to be submitted into the kernel.
> 
> Granted, tracing_is_on() is probably the least likely one to be used, but I
> added it with the package, and I have actually used it for debugging a few
> times.

Generally, we don't allow symbols that are not actually being used in
the kernel tree?  tracing_is_on() is a "code flow" type of thing, where
code can operate differently if it is enabled or not.

And I would argue that tracing_on() and tracing_off() should also not be
allowed to be in a module, why would you want that?  Just enable/disable
it from userspace when doing your testing, IF you have permission to do
so.

thanks,

greg k-h

