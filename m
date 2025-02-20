Return-Path: <linux-kernel+bounces-523056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C86BA3D17A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6983BADE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFFA1E3DF9;
	Thu, 20 Feb 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DXDj2k/V"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4CA18C322;
	Thu, 20 Feb 2025 06:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033753; cv=none; b=AyLgIMCPgN3nBm3e+h8oQBtbcq2eTyPpCOfd8koCPvijjtnegxw3lZK6Ltis3T7shH7rapd2HF9EUhD3bTjHJ0GiSv+myBTVwGHnpSKLbL1jBTxNd4c6J45qXpmRxuYhxjOp4ILmlB2aqY6xicEdMG57W8r4YwYnW07TUltpkVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033753; c=relaxed/simple;
	bh=n41e5Oiomf7d7XkNFbNpqL7PIJEd7BcHe06PwR2A1/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJiOyj5Z5PZSt2dLwx98mntfV8+y3XMpOGdfejQyd3iG4gzfP2g9gbrZcyG6Ywfjz++//Cgo28hhad3SOceNhdw8eoHYk9fmWSdud+2Pmqi2GkuvUbsIMnSuC+dICeOD8H+pX69VAva1w7QalhIZtPsAq9JHpzi2dIsQMXS1WZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DXDj2k/V; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6LtIK8uPo9YjWjZpMmXR4Lu8Pnx4oyMc1ml30IHmbZg=; b=DXDj2k/VPh19fTEpHyANnYxfET
	0+plalpIX2L1uAjtPJRBxW4BnzFanc8sS2Opnmw6BGK4jEx5BkCK7zjJd9XW5uDaUd/H5Z9f7ZNTK
	wiZYqlHXYzSDXZGl9mVmMp+3/q5QlMuREmJ9DMAII6Fpwrmpnrul42sMrUvzmIsyuvLr6wdR1fumo
	aGTN1a8zZR/cuwEWA+wApmeqgxPAYmMcL0DrLvvXyMt5VqrYkoS9yKu7xo6lWUtLLcmA2zpqlEVbq
	S6CtvX4kGcyPUGUXVBF5yiopCDXpLeAlZyI3qnrRLJhuoavRdlu5PoYk2L6ywTOJZO66r1+EUcqn0
	DQeI1KLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tl0GU-0000000GzSQ-30Vx;
	Thu, 20 Feb 2025 06:42:30 +0000
Date: Wed, 19 Feb 2025 22:42:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	rust-for-linux <rust-for-linux@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <Z7bO1jT2onZFZwgH@infradead.org>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Feb 18, 2025 at 07:46:29PM +0100, Miguel Ojeda wrote:
> > while Linus in private said that he absolutely is going to merge Rust
> > code over a maintainers objection.  (He did so in private in case you
> > are looking for a reference).
> 
> The document does not claim Linus cannot override maintainers anymore.

The document claims no subsystem is forced to take Rust.  That's proven
to be wrong by Linus.  And while you might not have known that when
writing the document, you absolutely did when posting it to the list.

That is a very dishonest way of communication.

> You were in the meeting that the document mentions in the next
> paragraph, so I am not sure why you bring this point up again. I know
> you have raised your concerns about Rust before; and, as we talked in
> private, I understand your reasoning, and I agree with part of it. But
> I still do not understand what you expect us to do -- we still think
> that, today, Rust is worth the tradeoffs for Linux.

And I fundamentally disagree with that approach.

> If the only option you are offering is dropping Rust completely, that
> is fine and something that a reasonable person could argue, but it is
> not on our plate to decide.

We'll it's up to Linus to decide, and he hides behind the experiment
thing in public without giving much guidance, and then decides
differently in private.  Coupled with the misleading policy document
this doesn't even make it clear what contributors and maintainers are
getting themselves into.

> > So as of now, as a Linux developer or maintainer you must deal with
> > Rust if you want to or not.
> 
> It only affects those that maintain APIs that are needed by a Rust
> user, not every single developer.

Which given the binding creep means every single non-leaf subsystem
eventually.

> But it is also true that there are kernel maintainers saying publicly
> that they want to proceed with this. Even someone with 20 years of
> experience saying "I don't ever want to go back to C based development
> again". Please see the slides above for the quotes.

I'm not sure how that matters.  Of course your Rust testimonials are
going to like it, otherwise you would not have quoted it.  They
generally are not the people who do the grunt work to keep the core
kernel alive.  And I absolutely do understand everyone who would rather
spend their time on a higher level language with more safety, but that's
not the point here.

> We also have a bunch of groups and companies waiting to use Rust.

Well, obviously you do.  But as in many other things I would usually
not count corporate pressure as a good thing.


