Return-Path: <linux-kernel+bounces-410199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 254699CD625
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 05:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C2CB21BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9747A16CD35;
	Fri, 15 Nov 2024 04:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y1pqcgn3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3689165F1E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731643685; cv=none; b=ZAwq4qkm/pgWKLz3gQotxUkJcH4aKAwxXZ7A9HwQvspwMJlJP7ybG7Kq1R2tG+vToUl3P2GqIFI71WcXkFBb97d70C8OBMU1FD8OEe1+UHQuAPfTkhhFg1/XhAOMQpYiQsCixgSOoZWl6FVv4wC0b8/UIX9B0DauB/n7ah+sQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731643685; c=relaxed/simple;
	bh=koK7eN0gpTgHQbmkfgXMavzPGSWtnFWMxkZYDyi6Tn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9/Ql5iKOVh3ikjh0vXFxkIdcAMx5z9eEgJkKKcWeFnIgO9rsyavJw2sTZRhbSh8ufBMkUKMGIjjPt917M5b9y/ge09zNKxJ8XyKfXf8Qqh3y//0kVNmzAarukFQC87d0lU/y6tMvUMKJh7wuxgTMknjnPLUaxD63M7qCcay6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y1pqcgn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE79C4CECF;
	Fri, 15 Nov 2024 04:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731643684;
	bh=koK7eN0gpTgHQbmkfgXMavzPGSWtnFWMxkZYDyi6Tn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y1pqcgn3/LVvw+hMxUiVzTuQhtnoLFAQ4+29SG2kXG73CpDZ7lcIejFeIRcBrlR8D
	 DWTEv8haIwAwjT5tokC8t8tlkRFOVYH0GeGfcnKn0kvIfb4sXt7ppTursdyN1D9AxI
	 LBd25F7/HKiv4d/EVXRKSmoDveq13zSbDVOjQzHY=
Date: Fri, 15 Nov 2024 05:08:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Down <chris@chrisdown.name>
Cc: Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Tony Lindgren <tony.lindgren@linux.intel.com>, kernel-team@fb.com
Subject: Re: register_device: was: Re: [PATCH v6 06/11] printk: console:
 Introduce sysfs interface for per-console loglevels
Message-ID: <2024111538-annually-structure-e2b4@gregkh>
References: <cover.1730133890.git.chris@chrisdown.name>
 <0312cd1e80e68a1450a194ebce27728cdf497575.1730133890.git.chris@chrisdown.name>
 <ZzTM04qQXOg2RsOa@pathway.suse.cz>
 <ZzZEW5pz5WWVruvd@chrisdown.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzZEW5pz5WWVruvd@chrisdown.name>

On Thu, Nov 14, 2024 at 01:41:31PM -0500, Chris Down wrote:
> Petr Mladek writes:
> > Honestly, I am not sure how to review this. I am not familiar with
> > these APIs. I have spent few hours trying to investigate various
> > drivers but I did not find any similar use case. I tried to look
> > for documentation but I did not find any good HOWTO.
> > 
> > It seems to work but it is the only thing that I could
> > say about it ;-)
> > 
> > Just by chance, do you have any pointers into a code or
> > documentation which could help me to feel more comfortable?
> 
> I think you and I are in a similar boat :-) Some similar code can be seen in
> places like block/genhd.c in device_add_disk and __alloc_disk_node, which
> also do this kind of dynamic setup. I mostly just spent my time looking at
> device.h and its users.
> 
> Greg, maybe you could also take a look?

Sorry, I missed that you were adding a new sysfs api here.  Yes, I'll
add this to my queue to review, give me a few days...

thanks,

greg k-h

