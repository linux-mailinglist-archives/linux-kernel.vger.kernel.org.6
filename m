Return-Path: <linux-kernel+bounces-521907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D3CA3C3B6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D417647C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634BA1F8BDD;
	Wed, 19 Feb 2025 15:34:15 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526C61E0DE6;
	Wed, 19 Feb 2025 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739979255; cv=none; b=Id6FigzbuqBIUlb0dPNc6HM5ldiAUDu1kf2/Oa63oC4I+i93IvU5vIJB61//97I2OWlkpEqXlWKIrceq40Wns5nYfo6LnYRUT3MI7azdYGLWtDIGxalrlHjVk6JXK4wns2WLsYmNa9ups9Fh5ESXb5N3Qjc+JWkribOu9x3BNZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739979255; c=relaxed/simple;
	bh=AH262twbeco0CVkJDgGgdinJ5Ed52X0ZjdMelCWdmR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpDEmzKbo5jn1AhXuuk1vdyxguor1Irp0ldNdhabd26IQVEUwILpHJMT6vp6ab831WSWek6OjNSH/kyGZtL+sOvAdL/IDan4ChOl3WJGM5ap2bgwCoDO7+lupT58nm5WXZTgj5F+Ov6JZfnCQeGCA/n9u97av1L7SG9pRX6SDW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51JFXoTx022768;
	Wed, 19 Feb 2025 16:33:50 +0100
Date: Wed, 19 Feb 2025 16:33:50 +0100
From: Willy Tarreau <w@1wt.eu>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>, David Airlie <airlied@gmail.com>,
        linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250219153350.GG19203@1wt.eu>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi James,

On Wed, Feb 19, 2025 at 10:15:00AM -0500, James Bottomley wrote:
> On Wed, 2025-02-19 at 09:46 -0500, Martin K. Petersen wrote:
> > 
> > James,
> > 
> > > Could we possibly fix a lot of this by adopting the _cleanup_
> > > annotations[1]? I've been working in systemd code recently and they
> > > seem to make great use of this for error leg simplification.
> > 
> > We already have this:
> > 
> >   include/linux/cleanup.h
> > 
> > I like using cleanup attributes for some error handling. However, I'm
> > finding that in many cases I want to do a bit more than a simple
> > kfree(). And at that point things get syntactically messy in the
> > variable declarations and harder to read than just doing a classic
> > goto style unwind.
> 
> So the way systemd solves this is that they define a whole bunch of
> _cleanup_<type>_ annotations which encode the additional logic.  It
> does mean you need a globally defined function for each cleanup type,
> but judicious use of cleanup types seems to mean they only have a few
> dozen of these.

I may be missing something obvious, but this seems super dangerous to
me to perform lightly without reference counting, as it increases the
risks of use-after-free and double-free in case one of the allocated
objects in question can sometimes be returned. Users of such mechanisms
must be extremely cautious never to ever return a pointer derivated
from a variable tagged as such, or to properly NULL-assign the original
object for it not to double-free. So it might in the end require to be
careful about null-setting on return instead of explicitly freeing what
was explicitly allocated. I'm not sure about the overall benefit. Also
I suspect it encourages to multiply the return points, which makes it
even more difficult to possibly fix what needs to be fixed without
coming from a locally allocated variable (e.g. restore a state in a
parser etc). Maybe it's just me not seeing the whole picture, but as
a general case I prefer to forget a free() call (worst case: memory
leak) than forget a foo=NULL that may result in a double free, and the
description here makes me think the latter might more easily happen.

Regards,
Willy

