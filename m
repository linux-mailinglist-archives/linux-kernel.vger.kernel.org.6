Return-Path: <linux-kernel+bounces-378622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CD09AD353
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02FF428365D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6EC1CFEC8;
	Wed, 23 Oct 2024 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJ7Hx2Q3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304AD1CDA0F;
	Wed, 23 Oct 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705920; cv=none; b=TTg1g8pAMCPG92fCMn9juq7DAAmbQ9ehaOs/gAkepeLL0Ycrx4Vxxlv+BR+HRczm+1iQBGEHevs9QxwynvSwo8/kFX4WpG7WqR3XwG3wO4H16SshgcT0t9o9IXd0NqbO1mZ6WZJBcGZUtdl0ky+YTi03l7vqHj22QP0ePX8egcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705920; c=relaxed/simple;
	bh=jNpPGrCzMHMCRG8VTWcOPP+akEnYhxIhfASYsXPqo+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhbwB0QX503rlg9meOa2tPJp75sobii6EW6oHKAvxrewcaz4k1v0rrAQGzF4gEF0rsFHVC35XbC3m8JmV3uw5NRVZdtpkKzkQpyrSHCu16v33vZJ/1P2CcJAMzMNk3vlQLfIh5kbe6ug/2fk3ZStExrWuLIWg6Ao+54jxdr9cQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJ7Hx2Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A942EC4CEC6;
	Wed, 23 Oct 2024 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729705919;
	bh=jNpPGrCzMHMCRG8VTWcOPP+akEnYhxIhfASYsXPqo+I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rJ7Hx2Q3bgbGMHOohIGS44Q+7fri+cYVngCYe29CeWtRQV2irsAXcJW1NTFp70R6q
	 Jn96brYzgA2+rN7a6enittfxO8IY5t8eAG39BlwqE0WhZ05F11PWciBbc12oIO7HfX
	 d2ixHt02VPJf6+LQLQ/NxSrBBCfPikFMyi79PFzgda+zV2A0q/JYkkgzxDsOE6n8r8
	 QxJpodAgqhrlymz/MzgfBwvs9EhRe3JYJrR75KKQRCNDU1LkrpwVrU3TFLRJ5LUh9a
	 gsyXGCZSua23qZYzJOjwET1ksZ9+FOyMMn1hVEdV5dVQ9NDuRTqV4LK9YjjtoTGHAn
	 QwiI2up9hXxUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4CE67CE0EE1; Wed, 23 Oct 2024 10:51:59 -0700 (PDT)
Date: Wed, 23 Oct 2024 10:51:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>, torvalds@linux-foundation.org,
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <7afdd542-2427-4b90-86dd-19e3c8a96e3c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <20241022041243.7f2e53ad@rorschach.local.home>
 <ZxiN3aINYI4u8pRx@infradead.org>
 <20241023042004.405056f5@rorschach.local.home>
 <CAMuHMdUxrULbo=A77DFDE4ySbii3jSMuh8xVvUXaqyCnwEAU-w@mail.gmail.com>
 <20241023051914.7f8cf758@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023051914.7f8cf758@rorschach.local.home>

On Wed, Oct 23, 2024 at 05:19:14AM -0400, Steven Rostedt wrote:

[ . . . ]

> But pushing to linux-next for a day or two, what does that give me?

If the stars align, I will run some serious rcutorture on it.  Not that
the stars have been aligning much over the past few weeks because I
have been putting most of my testing effort into chasing an RCU bug.
And not that rcutorture and friends are likely to find bugs in your part
of the Linux kernel.

Nevertheless, this is one of my concerns with a separate tree.  Right now,
my testing priority is (1) RCU, (2) -next, (3) mainline.  If we add
another tree, either I choose not to test that tree on the one hand or
it detracts from my testing -next and/or mainline on the other.

							Thanx, Paul

