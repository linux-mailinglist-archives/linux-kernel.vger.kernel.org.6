Return-Path: <linux-kernel+bounces-378616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F391D9AD337
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE92285B11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E571CDA0F;
	Wed, 23 Oct 2024 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8vBYvl1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1801AC43E;
	Wed, 23 Oct 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705659; cv=none; b=uRpZTxqpYtvsTFcKsAUA5WBa9E2nd2CGaHw8WNac98uyQnaVGKWSz4x3T/fcA1usZMDE9rSrhhQmQAam7y4Awg8S3VphlYqecRHBdRkFIc/Ax7gQ3eTnaaxuANVSYlXPmhdr5eIqAt0e18KwjDmD+Af/07kjsF4MIJmnBocsZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705659; c=relaxed/simple;
	bh=rMnCFaLijyHahgc2hnLSWCJbr8t5r15Sr8AzmXXTEYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUseleY0pjLbLAbOCZNZvzL4uAA39H1auEgjEUUW8XaEnhANdjGnCG3pq5DzHRVUi2UPcKGQzmlSnMN6Xxrw4cgKRQ0SvyUwiClZwfNdA5J/PLvL+RbDfs4H58b/QC076GocffLI9ORBPNgbFJfk+q6NaHqFYfg+8IE0gb32sAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8vBYvl1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A766C4CEC6;
	Wed, 23 Oct 2024 17:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729705659;
	bh=rMnCFaLijyHahgc2hnLSWCJbr8t5r15Sr8AzmXXTEYE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=q8vBYvl1nvwS+LmMVrReYA+VMAqpxk5dNpNzH4W8CEmC5XSKc8ofGvNnvEGRctZOp
	 XRwJ4AzaNNMyEeVe6x5DXDY/Kg9XJJr/zfdTITntCYYGDQUYAKeaExpoxYkitQ5vEe
	 GR3hPjB0z4ezafLFm6H8gP/zmF+pRLmAHGjCg+LT+4iGn2UBJZqxGvYpvwHM/fY2lN
	 IcqCGMjIClAmOZJ5RXpnHkKeXqlqXGm8DpfzEIJ0m6VtLrCnK2A0Z+EBM1hwn0cRbI
	 ioQ7o+3r2AzjnVSIGlE7qfoa44EE8+Po7PSbLWm2ikw7NGBqGGjzX8uLZyptVuKwAl
	 E7tdUzLBe1zRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D0AB0CE0EE1; Wed, 23 Oct 2024 10:47:38 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:47:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
	torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <10b0cb74-2068-4819-ac91-fcf98ca8d96c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZxdyYjzxSktk34Zz@sashalap>
 <ZxiOjBRdO6EMAY4H@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxiOjBRdO6EMAY4H@infradead.org>

On Tue, Oct 22, 2024 at 10:50:04PM -0700, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 05:37:38AM -0400, Sasha Levin wrote:
> > We could add a report for the above, but:
> > 
> > 1. Linus consistently pulls patches that haven't seen the light of day.
> > 2. Linus explicitly objected to making a linux-next a must have.
> > 
> > So unless these results would be actually used, what's the point in
> > writing all of that?
> 
> Yes, without Linus caring we're not going to get our process worked out.
> Not sure how a tree that probably won't have much better latency than
> linux-next is going to fix that, though.

If I recall correctly, one thing Linus asked us to do earlier this year
(ARM Summit) is to CC him on -next failures.  I have been failing to do
this, so I will post myself a note or something to remind me.

After all, if Linus doesn't know of a problem with a set of commits,
how does he know not to pull it?

							Thanx, Paul

