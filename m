Return-Path: <linux-kernel+bounces-522067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95612A3C570
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8C53AE227
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E7214216;
	Wed, 19 Feb 2025 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EVrrsjBm"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974E2862B2;
	Wed, 19 Feb 2025 16:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983697; cv=none; b=dM2Nd6uKL9lpgsQksn4sPkGGuKXHuGFR7XIg9kkzSDVPa6jW9c86PMt88WBAaSwk3qFX6w5apuRF++Y2BKCUBTbqyuGpw/S5t+8iQ3qHwxziG/szHWtbPfa9cBCUmyJ1xbkfHR1SMH93EP/F5Lm2suCBUb+dQHXirNYwmDGrchg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983697; c=relaxed/simple;
	bh=autM+RJ3s43Lzh4Mjz4jQCjBOdzux19fRDijqU9FLGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovYjEBUEOUD+9HFkM5+k+Yd6iwV+3vXTd1hrefrV61UT7latRLCajdZ4KMgSQtXPUGCyf6BAw8OEzBXStc3vtmgLuPzTZYN5epgRrehEqWqhgXbBLzKS6HGawcOpoxwlJ+kZUbk1VgOOXkvZ7ZFZT3g2JVcCwad3fy+JzxjlNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=EVrrsjBm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sL1+mg2q26umhi2nwvSOZWxdt3u5cMZSRU5xPb7xHWY=; b=EVrrsjBmLbQ7+aWhz0PSoXAZ4M
	WP5x7rOcn3WmX1nLiW3CfBGgZbcz6H6OV6DLiMaFY26LiUysD33RLsj8JSPRdUpuxRxV2GyjaBkQG
	tvHicju0yfRh8oF7Z52CsVfXCWxRetZ4urTCyEOsV3q4+Tm4to/m2YxnkmhicqDjfpYo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tknEm-00Fgku-Qx; Wed, 19 Feb 2025 17:47:52 +0100
Date: Wed, 19 Feb 2025 17:47:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Willy Tarreau <w@1wt.eu>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Christoph Hellwig <hch@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <fb33ab90-7c9c-4840-9246-e0ad6a4db60a@lunn.ch>
References: <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
 <20250219153350.GG19203@1wt.eu>
 <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
 <20250219155617.GH19203@1wt.eu>
 <20250219160723.GB11480@pendragon.ideasonboard.com>
 <20250219161543.GI19203@1wt.eu>
 <20250219113331.17f014f4@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219113331.17f014f4@gandalf.local.home>

On Wed, Feb 19, 2025 at 11:33:31AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2025 17:15:43 +0100
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > Yeah absolutely. However I remember having faced code in the past where
> > developers had abused this "unlock on return" concept resulting in locks
> > lazily being kept way too long after an operation. I don't think this
> > will happen in the kernel thanks to reviews, but typically all the stuff
> > that's done after a locked retrieval was done normally is down outside
> > of the lock, while here for the sake of not dealing with unlocks, quite
> > a few lines were still covered by the lock for no purpose. Anyway
> > there's no perfect solution.
> 
> This was one of my concerns, and it does creep up slightly (even in my own
> use cases where I implemented them!).
> 
> But we should be encouraging the use of:
> 
> 	scoped_guard(mutex)(&my_mutex) {
> 		/* Do the work needed for for my_mutex */
> 	}
> 
> Which does work out very well. And the fact that the code guarded by the
> mutex is now also indented, it makes it easier to review.

In networking, at least for the moment, we have set a policy of only
allowing scoped_guard. The more magical, less C like constructs are
strongly discouraged. We will review this policy in a few years time,
see how well the rest of cleanup.h actually worked out in other parts
of the kernel.

	Andrew

