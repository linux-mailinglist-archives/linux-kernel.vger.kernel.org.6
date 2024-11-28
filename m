Return-Path: <linux-kernel+bounces-424181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE259DB154
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053A0B21523
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AD542065;
	Thu, 28 Nov 2024 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aoBob2J/"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475C4C7C
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759568; cv=none; b=n5jfN8FJ45kXDlkgsD3OhUE3V7LpZkS9a9XQ80Q6ZDlUrG6iZAAPM3T/0vHifj3+Niz+34TDPCUzPm0xJeHWmEIDFhmksHwo66E8cJpVK1ZSFdG3S2bZ32cBuIeJyBl5aMCC6F/BoQ3we3eEcJFH90wjyXlemMrAmC05S+PR+qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759568; c=relaxed/simple;
	bh=2n3j+cIsiRjP48Dex1vslD2KXhUxBICu/vlYHrSfTwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAbEuypiVj/y0dN+EO78Uuy52n1JtPV9SqtLazoBwctLlRHRmuGWwQGmIQgGFjtUyIj1zC1RGhvIfbdlldcmcyHooJp/d9I/e+NJDs7kWVMf4F3w1SaHdnFwGGsSO4d/VGonSU0hZw9vrRComCWnjKMn+juJXotCsyGUm6OWHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aoBob2J/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+msx6rh+p0ATbHpULJ+OcIyHAGEaXjpT5WO/tynvHl0=; b=aoBob2J/0MyERUw2He0RHL5XTk
	nQceSUKjBOK6b/MMoMmFigz2prrZUEUhNXSsuscsCmoO8FVFyWgOQQMuLXQyepYzScVbEIpnnLMnM
	DkONkOMi4is0RH+zg5agmxZAqxrf9MgcuRPCvIf/+VHKpKplAxnbzfizyto/+XWHlHn/miKlaWa+w
	IUQStqlFFnXHCkqkk1EpBifYYVA5MFAhwbgtn2Q+179b/jisYj6InTB5UJ/upRd3hh42/46Ztk47w
	fOLcsx1JgnKzdd13glbuhsT+rVe3meyfSS15UKtjT3tjzndr3CMpDBo6aHIRljTafpAib/kBpwGsb
	zKOWyJ+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tGTuo-00000002aVG-0OVn;
	Thu, 28 Nov 2024 02:05:58 +0000
Date: Thu, 28 Nov 2024 02:05:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Nir Lichtman <nir@lichtman.org>,
	Tycho Andersen <tandersen@netflix.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [GIT PULL] execve updates for v6.13-rc1 (take 2)
Message-ID: <20241128020558.GF3387508@ZenIV>
References: <202411210651.CD8B5A3B98@keescook>
 <CAHk-=wjMagH_5-_8KhAOJ+YSjXUR5FELYxFgqtWBHOhKyUzGxA@mail.gmail.com>
 <05F133C4-DB2D-4186-9243-E9E18FCBF745@kernel.org>
 <CAHk-=wgEjs8bwSMSpoyFRiUT=_NEFzF8BXFEvYzVQCu8RD=WmA@mail.gmail.com>
 <202411271645.04C3508@keescook>
 <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+_a9Y8DtEp2P9RnDCjn=gd4ym_5ddSTEAadAyzy1rkw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 27, 2024 at 05:59:53PM -0800, Linus Torvalds wrote:
> On Wed, 27 Nov 2024 at 16:53, Kees Cook <kees@kernel.org> wrote:
> >
> > On a related note, what do you think of using execveat's "pathname"
> > argument as "comm" if AT_EMPTY_PATH is set? That'll give process
> > launchers control over comm (which is what they want), and we can keep
> > the dentry name fallback as proposed too?
> 
> That's not actually how AT_EMPTY_PATH works.
> 
> Yes, it's how AT_EMPTY_PATH *should* work, but despite the name,
> AT_EMPTYH_PATH does not mean "path is empty".
> 
> It means "path *may* be empty - but if path isn't empty, it's a regular path".
> 
> IOW, what is going on is that POSIX required that an empty path be an
> error. And AT_EMPTY_PATH is basically a "don't error out on an empty
> path" flag, not a "path *is* empty" flag.
> 
> So if pathname exists and isn't empty, AT_EMPTY_PATH does nothing.

... so let's tie that to pathname _being_ empty - it's not as if it
had been hard to check.

What's more, let's allow userland pointer to be NULL - use getname_maybe_null()
and treat NULL returned by it as "we have an empty pathname".

