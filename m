Return-Path: <linux-kernel+bounces-211306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84184904FBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBE02849B0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754E16DEDE;
	Wed, 12 Jun 2024 09:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbgQ/ePR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1AA34;
	Wed, 12 Jun 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186120; cv=none; b=a2w/3oYpp1k6xJia5g2Tkcm+GbXaP0c7K6vSesFVNNe8+2x8m2fXGYQ5imhFFzlxLuLE0EoOlxBEUgWr8IBT1E7ULi+iZxjRUYlCPA+QNfOXvTm9zJ3RqelZ1y38t2jNNl5lsXpoFVr+rkqqL52EUpwilUrpj7/d0ya0h40zQvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186120; c=relaxed/simple;
	bh=IUlWQQqW3cQb1qb4NtDCHI7QOQj5j7JMOhaHKauOiNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0/FkcMPd9Aebfje/obsl9HEfSdpDdrfCgx4MroCZjdCTxkOeM5/HBHUGztdvLIlNGR6ElStJf47pibM5mYHaBjyYl9BuFZOiCtVNICvpSNWVWMm5hBNHTtDJlLKulK/An06TVvahaalr9/TlFPjY/M90a7eeCUUmWmCShFHi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbgQ/ePR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A594C3277B;
	Wed, 12 Jun 2024 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718186119;
	bh=IUlWQQqW3cQb1qb4NtDCHI7QOQj5j7JMOhaHKauOiNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wbgQ/ePRCJCuF1v4mZFoS9pFDhM27kHeWXMuh9OoDCTYgnuVBWGotLmRaILAdj/jH
	 +c10ngXD8YNfyoD9n+CACwFleSSp4TXlsfzqrFQgimCIsTxeQQymsWqvrSL0zvSsPm
	 AQL7L0BdYfUUPgjdysWu4HYqXWaoGXE4ZZrGnmEw=
Date: Wed, 12 Jun 2024 11:55:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oneukum@suse.com>,
	USB mailing list <linux-usb@vger.kernel.org>,
	Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: USB Denial Of Service
Message-ID: <2024061236-diabolic-wisplike-d2b1@gregkh>
References: <40dfa45b-5f21-4eef-a8c1-51a2f320e267@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40dfa45b-5f21-4eef-a8c1-51a2f320e267@rowland.harvard.edu>

On Tue, Jun 11, 2024 at 10:35:12AM -0400, Alan Stern wrote:
> Greg, Oliver, or anyone else:
> 
> Questions:
> 
> If a broken or malicious device causes a USB class driver to add a 
> thousand (or more) error messages per second to the kernel log, 
> indefinitely, would that be considered a form of DOS?
> 
> Should the driver be fixed?

Good question.  Right now, by default, we "trust" usb devices to an
extent.  We have been "pushing back" that boundry over time, such that
now we will validate USB descriptors to verify that they actually are
sane before allowing a driver to bind to them, and if there's any bugs
with that, we will fix them.

But we totally trust the data stream from devices, and trust that once
an urb is submitted, they work properly.

If we wish to change that threat model, great, but that will require
those that wish to change that model to DO THE ACTUAL WORK!

I don't want to see fuzzers start to fuzz the data streams of USB
drivers and expect us to fix the bugs.  That's flat out not ok, as this
is something that right now, we do not care about.  If companies do care
about this, they need to do the work as that is NOT how Linux is
currently designed and implemented.

Same goes for other device types.  I get this conversation all the time
(had it last week at a very very very large Linux company.)  It usually
goes something like:

	Them:	We want to claim that we can trust drivers to work
		properly for malicious devices
	Me:	Wonderful, send the patches to do so, fixing up all
		subsystems that rely on them!
	Them:	No, that's something that Linux should already support.
	Me:	Why do you care about this?
	Them:	Because we want to host systems in untrusted situations.
	Me:	So you want to save money by not using a single physical
		host.
	Them:	Yes.
	Me:	Then spend some of that money to do the work to make
		this happen, do not force the community to do it for you.
	Them:	...

> What is an acceptable rate for an unending stream of error messages?  
> Once a second?  Once a minute?

The *_ratelimited() functions should handle this if you want to use
them.

> At what point should the driver give up and stop trying to communicate 
> with the device?

That's tricky, we don't have good answers for that as everyone has a
different idea of how long "flaky" devices should be able to flake out
before coming back.

> (These are not moot questions.  There are indeed drivers, and probably 
> not just in the USB subsystem, subject to this sort of behavior.)

Totally agreed.  But again, the design of Linux right now is that we
implicitly trust the hardware we are running on.  If that design
decision wants to be changed, some people need to do a ton of work to
change it.

Thanks,

greg k-h

