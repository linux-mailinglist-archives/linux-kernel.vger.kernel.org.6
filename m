Return-Path: <linux-kernel+bounces-521955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749ABA3C440
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 926C51888217
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816351FDA6D;
	Wed, 19 Feb 2025 15:56:32 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2F71F8AE5;
	Wed, 19 Feb 2025 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980592; cv=none; b=lwY5kXw0SZaKPq9h/PSqZMmKKW2pK1NJp8ag4N8I3X5XJA26Bcy8kgRz6BQ/Y6387fMvmG1CutCd/t5AWkEbtuk9Zknus+nIJpAOlTZPseBtxf7iVyyBe1eqoup5UqqDBuCyOucESc3QOhp/Vw5j30A1ZwagvI/b4Z/5f7DvMig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980592; c=relaxed/simple;
	bh=qPZnrOyaKEYq5hbsMRbqV7X6oIhpSL4apigxMYTnzfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxsRfgfVZpt/q6cSm9c/mo5RcNPKl6YP6HR35ggfC8Ob07PBQIWDwvFr6QA+mwU84o+ooQpG0E6PymYrZF7C8OpInXaqpOjPKbNFL6F8EhKg5ujEMV44uyEtHNP5yz53ycr430LTGMdydqOqFvhnFMJmFbrw15/yed43aDuHjcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 51JFuHFe022922;
	Wed, 19 Feb 2025 16:56:17 +0100
Date: Wed, 19 Feb 2025 16:56:17 +0100
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
Message-ID: <20250219155617.GH19203@1wt.eu>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com>
 <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
 <c1693d15d0a9c8b7d194535f88cbc5b07b5740e5.camel@HansenPartnership.com>
 <20250219153350.GG19203@1wt.eu>
 <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e42e8e79a539849419e475ef8041e87b3bccbbfe.camel@HansenPartnership.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 19, 2025 at 10:46:03AM -0500, James Bottomley wrote:
> > > > I like using cleanup attributes for some error handling. However,
> > > > I'm finding that in many cases I want to do a bit more than a
> > > > simple kfree(). And at that point things get syntactically messy
> > > > in the variable declarations and harder to read than just doing a
> > > > classic goto style unwind.
> > > 
> > > So the way systemd solves this is that they define a whole bunch of
> > > _cleanup_<type>_ annotations which encode the additional logic.  It
> > > does mean you need a globally defined function for each cleanup
> > > type, but judicious use of cleanup types seems to mean they only
> > > have a few dozen of these.
> > 
> > I may be missing something obvious, but this seems super dangerous to
> > me to perform lightly without reference counting, as it increases the
> > risks of use-after-free and double-free in case one of the allocated
> > objects in question can sometimes be returned.
> 
> Who said anything about not reference counting?

Nobody, but it was not said either that they were used at all!

>  One the things the
> _cleanup_X annotations can do is drop references (or even locks).

OK then!

> >  Users of such mechanisms must be extremely cautious never to ever
> > return a pointer derivated from a variable tagged as such, or to
> > properly NULL-assign the original object for it not to double-free.
> > So it might in the end require to be careful about null-setting on
> > return instead of explicitly freeing what was explicitly allocated.
> > I'm not sure about the overall benefit.
> > Also I suspect it encourages to multiply the return points, which
> > makes it even more difficult to possibly fix what needs to be fixed
> > without coming from a locally allocated variable (e.g. restore a
> > state in a parser etc). Maybe it's just me not seeing the whole
> > picture, but as a general case I prefer to forget a free() call
> > (worst case: memory leak) than forget a foo=NULL that may result in a
> > double free, and the description here makes me think the latter might
> > more easily happen.
> 
> Well we could all speculate about the mess we'll make with any new
> tool.  All I'm saying is that another project with a large code base
> (systemd), which you can go an look at, managed to use these
> annotations very successfully to simplify their error legs. Perhaps
> there are reasons why the kernel can't be as successful, but I think
> assuming failure from the outset isn't the best way to flush these
> reasons out.

I'm not trying to assume failure or anything, just saying that it's
probably not always as simple as calling kfree() on anything locally
allocated for error paths to be magically cleaned, and it actually is
more subtle (and Laurent confirmed my concerns illustrating that this
case is precisely covered in glib using transfer of ownership).

And the temptation to return from everywhere since it's the only
required statement (instead of a goto to a collecting place) becomes
great and should sometimes be resisted to.

Regardless I do understand how these cleanups can help in a number of
case, at least to avoid some code duplication.

Regards,
Willy

