Return-Path: <linux-kernel+bounces-428053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D562D9E097D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E6C161B0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3639C1DA112;
	Mon,  2 Dec 2024 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NWzK/hld"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA22E125B9;
	Mon,  2 Dec 2024 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159476; cv=none; b=Fqf0DlyTXrhvrGmNnPixbrPzSYzW6C7DnTq05RkWzJiF+ATcBvqiG69ksXaI4D15v2h5SPOq4qFZeY2CAvHuZpZya5MNkHcAFBUOpB3Okzj8BSce+hG5FqjNOjEO6Hg3s7petxLzdGpXRwaNBXNMF7kYdjrIQbhl1fYo5cHvLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159476; c=relaxed/simple;
	bh=vABmO3a9ptqVa7aijKK3nhvQcpmmGcr5OTsWgzjsOZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyEiG0UIxl7hW2Xql/nonj3KHjKbXJM1+1F1/SJj1bvrgaZuAta0nl7O7HkQV6vaNwh7wtrTtxA8FstZFB3YvzeCJo7uo3mT4NWc7OA+DmarvAEjN2IG+Fa4wg6k5AiPMas+85g9JpRukqiOJ1GzV2Z3gdWxSAr3Chkpdj2m40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NWzK/hld; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pzu6FHFKvY1fkmm5m6RJBFQICe/d040JPPfejReux0k=; b=NWzK/hldf3qSAHq8nyp0nMG9F7
	sqlP+bpMbg9PF7hbNfEq0pDtg4Oglxv0DeMv3VDfJmRCFKLYbtkjYY2MvjJB7DNcJfR0G+Dl3G1Sz
	c8ytxQYeZJg5DRcROmH65fbOgC6TDalF4PBa/7T/U9oLjBIhXVB2OQaqwrH3mgDF/QIXk2qDK/JuC
	ZGeZRUGYaEA0QIFf+nqodenZpUbaRwuhLDK+eKED/ao+1WeWa1Rtw9ZySwHO37URQk4R42pmxSUjj
	7XRp6AitcWQtbA0s1foZriTyHEXUsYclIz+gTAyDpTMBft0MhEpdbjuudwuLQiMZJCeMo7ZXiTy66
	/Th27nBg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tI9wq-00000008MCm-2TtC;
	Mon, 02 Dec 2024 17:11:00 +0000
Date: Mon, 2 Dec 2024 17:11:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, apw@canonical.com,
	joe@perches.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, wens@csie.org
Subject: Re: [PATCH v2 0/3] Make Helped-by tag supported
Message-ID: <Z03qJKpjBqJ9vAhY@casper.infradead.org>
References: <cover.1730874296.git.dsimic@manjaro.org>
 <87h68k4esb.fsf@trenco.lwn.net>
 <cabfa180845df30bfb7a541a701a57e9@manjaro.org>
 <672e628111eb0_10bc629436@dwillia2-xfh.jf.intel.com.notmuch>
 <28c0a0ecc2e2880e4cb98449767e2842@manjaro.org>
 <9ae99d14dcd8867333fceacfaaa4430a@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ae99d14dcd8867333fceacfaaa4430a@manjaro.org>

On Mon, Dec 02, 2024 at 04:00:47PM +0100, Dragan Simic wrote:
> On 2024-11-09 04:10, Dragan Simic wrote:
> > On 2024-11-08 20:12, Dan Williams wrote:
> > > Dragan Simic wrote:
> > > > I'm fully aware that we may be reluctant to supporting
> > > > additional tags,
> > > > because we may then end up with a whole bunch of strange tags
> > > > that might
> > > > be a bit hard to understand and use properly, but I think that adding
> > > > Helped-by to the supported tag list may actually be a good thing
> > > > to do.
> > > > As described above, Helped-by fits very well between the Suggested-by
> > > > tag and the Co-developed-by + Signed-off-by pair of tags, and I think
> > > > that providing the right level of attribution may be beneficial.
> > > 
> > > Patch attribution is separate from giving thanks. I would much rather
> > > someone take the time to say "Thanks" in the changelog with some
> > > supporting text rather than boil down all the myriad ways to be
> > > thankful
> > > into a generic tag. "git log --grep=Thanks" often yields valuable
> > > details, beyond just attribution, on how people have helped each other
> > > develop this global project of ours. If the introduction of Helped-by
> > > would replace even one authentic "Thank you" note with a generic tag
> > > then it is a net loss for the community.
> > 
> > I do agree that writing "Thanks John for helping with..." in a patch
> > description would be nice, but unfortunately I've seen multiple times
> > that people don't enjoy writing their patch descriptions at all, and
> > just want to "get them out the door" as quickly as possible.
> > 
> > With that in mind, making Helped-by tags supported would allow such
> > people to at least quickly mention someone they're thankful to, which
> > actually wouldn't prevent anyone from saying the same more verbosely
> > in a patch description.
> 
> Just checking, are there any further thoughts on this patch?

I agree with Dan & Jon; we don't need this tag.  And if someone's doing
a poor job of writing commit messages, they need to be helped to write
better ones.

