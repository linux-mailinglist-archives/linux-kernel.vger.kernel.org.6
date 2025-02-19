Return-Path: <linux-kernel+bounces-521936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9EA3C40A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127A916E322
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D41F1FCCF5;
	Wed, 19 Feb 2025 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="QTyGmLDz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E041DF98E;
	Wed, 19 Feb 2025 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979924; cv=none; b=RxfVDfRzrCYgq6omCmXqKqtCLr4UWw+xRmKcpiw9ZI2OpMZLOZPXFVQCut3jL+Ssk0y64BoXzpdy9yYDIILyKWTt5fCE8X5mP5BKpEqhigUrfDP0Ck9TfC35qkWYrta33sRaybPyiVNuuwIidVWkK8LVXNNkAEBEYN1bnMKY8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979924; c=relaxed/simple;
	bh=xvG040riXjCk25+gxGRIqUwcxyI59YRjjS6SlDhqQQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKHcyuwhn1jBNMWJdY0SGvRKtX7UuK10AXYAB3aptb9/faMvKtD0dRCB5lki5YrYjKs/2yCEkA1y6PzUGu4Vgp7KhTsRhxtvROtUihX7zoTCENAhADo5QkP+URMppJWSLZy0Wv/zIgRUIfo06TbYOynd7eRNcrL9KDvJ+fHBUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=QTyGmLDz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E314A169;
	Wed, 19 Feb 2025 16:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739979837;
	bh=xvG040riXjCk25+gxGRIqUwcxyI59YRjjS6SlDhqQQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTyGmLDzdDsXhU9PWyisln1KcV+tRvX7Q2srWmTSTHGcaMWnOqYiYbGGTteSTY00z
	 87DUZ2XPqO2rt5dxkqOFjhd4Oz+Ja8GTZjAM6N277k6/dTzwIih471qP9ZR9hcNICm
	 jcZeVwsoexSamm9fxR/6iipIZBMgGrFfE0yTuAHU=
Date: Wed, 19 Feb 2025 17:45:04 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Willy Tarreau <w@1wt.eu>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
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
Message-ID: <20250219154504.GA11480@pendragon.ideasonboard.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
 <20250219153350.GG19203@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250219153350.GG19203@1wt.eu>

On Wed, Feb 19, 2025 at 04:33:50PM +0100, Willy Tarreau wrote:
> On Wed, Feb 19, 2025 at 10:15:00AM -0500, James Bottomley wrote:
> > On Wed, 2025-02-19 at 09:46 -0500, Martin K. Petersen wrote:
> > > 
> > > James,
> > > 
> > > > Could we possibly fix a lot of this by adopting the _cleanup_
> > > > annotations[1]? I've been working in systemd code recently and they
> > > > seem to make great use of this for error leg simplification.
> > > 
> > > We already have this:
> > > 
> > >   include/linux/cleanup.h
> > > 
> > > I like using cleanup attributes for some error handling. However, I'm
> > > finding that in many cases I want to do a bit more than a simple
> > > kfree(). And at that point things get syntactically messy in the
> > > variable declarations and harder to read than just doing a classic
> > > goto style unwind.
> > 
> > So the way systemd solves this is that they define a whole bunch of
> > _cleanup_<type>_ annotations which encode the additional logic.  It
> > does mean you need a globally defined function for each cleanup type,
> > but judicious use of cleanup types seems to mean they only have a few
> > dozen of these.
> 
> I may be missing something obvious, but this seems super dangerous to
> me to perform lightly without reference counting, as it increases the
> risks of use-after-free and double-free in case one of the allocated
> objects in question can sometimes be returned. Users of such mechanisms
> must be extremely cautious never to ever return a pointer derivated
> from a variable tagged as such, or to properly NULL-assign the original
> object for it not to double-free.

Correct. That's how glib-based code works too. See
https://manpagez.com/html/glib/glib-2.56.0/glib-Memory-Allocation.php#g-steal-pointer

I don't know if there are static checkers (or compile-time checkers)
that catch or could catch direct returns.

> So it might in the end require to be
> careful about null-setting on return instead of explicitly freeing what
> was explicitly allocated. I'm not sure about the overall benefit. Also
> I suspect it encourages to multiply the return points, which makes it
> even more difficult to possibly fix what needs to be fixed without
> coming from a locally allocated variable (e.g. restore a state in a
> parser etc). Maybe it's just me not seeing the whole picture, but as
> a general case I prefer to forget a free() call (worst case: memory
> leak) than forget a foo=NULL that may result in a double free, and the
> description here makes me think the latter might more easily happen.

-- 
Regards,

Laurent Pinchart

