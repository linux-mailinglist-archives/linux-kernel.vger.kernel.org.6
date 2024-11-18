Return-Path: <linux-kernel+bounces-413137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3268C9D1403
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C54280FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BE01C07CA;
	Mon, 18 Nov 2024 15:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVnYm+p2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AD419E99A;
	Mon, 18 Nov 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942306; cv=none; b=ZP6Q1RihIjv9VSQ6PaJ1iZxSvkxJ/YhJUM4A1Wgw4QFr4Xb6k9rm3E1RXtyqj5dA9vy2JFjnuJQYjAl70gUH8FgO8SLfHvNBqFGRHW43jpQBLxJ0Vih3uV3QzQH/ZTSKo2cWMFyZdNTw6wtaLoWStqFVDkReDdz+bePwrG0Dz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942306; c=relaxed/simple;
	bh=ZDcq0jZu95v/dsrTv8qsCUckd7K7sRDSvrPeRTOf0dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4HNbNOVc0sPgYlS0lKciMU/5ksSa3jA3WWJBmuqXbBtY0XiNr+NavmS0zLPtzYVHJnb7jMeLYS9e91hv//qsKSG/LADT9iH0w2kKktKUAdsPqxLvofYfL/uxGRx89H75DQottUkK1y1K1zNMqP/r/iJrpiVoe/jSbxmT4Yjp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVnYm+p2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE561C4CECC;
	Mon, 18 Nov 2024 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731942305;
	bh=ZDcq0jZu95v/dsrTv8qsCUckd7K7sRDSvrPeRTOf0dY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BVnYm+p2mngY0PG2hVWoYKRBm5R6SGGBHCkdzJoLnxmGP7ma0AuUWnoa6PItJYwFq
	 /Ocml2QhHs0jnZsoSJnqKtTS4U3KxFMJtAnlbDz3yq4koo5cumLnwS2emiyqex9oFh
	 u4wykHA9ibN53XGntA1/AQhJdz9GjfmOibV4pGHKLaFo13Zzxzq2LwzbSIErKN2OMW
	 /TvWQl+hcZz+ux0ZOQYSF3/Irfs7GPNC42gDwYcckNOUrD+4azCMukgfnscz9KF/ze
	 5sDTyl7vb4AQRyUGYfpn7scu/uCZ5e0eqA2G7z09vrPn+E855jdXn2GiP1wIHgFoOf
	 VFq9X7DAxJKKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F5AFCE0DEB; Mon, 18 Nov 2024 07:05:05 -0800 (PST)
Date: Mon, 18 Nov 2024 07:05:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, boqun.feng@gmail.com,
	dhowells@redhat.com, dlustig@nvidia.com, frederic@kernel.org,
	hernan.poncedeleon@huaweicloud.com, j.alglave@ucl.ac.uk,
	joel@joelfernandes.org, linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev, luc.maranget@inria.fr, npiggin@gmail.com,
	parri.andrea@gmail.com, peterz@infradead.org,
	quic_neeraju@quicinc.com, stern@rowland.harvard.edu,
	urezki@gmail.com, will@kernel.org
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <02537f27-ac3b-4e2e-80a2-ad57230ac478@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
 <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
 <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
 <f1d7a295-ad24-41c8-a431-7d6492d51097@huaweicloud.com>
 <245e4781-80b2-4e21-b4de-51ffeac9cc39@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <245e4781-80b2-4e21-b4de-51ffeac9cc39@paulmck-laptop>

On Fri, Nov 08, 2024 at 10:35:24AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 08, 2024 at 12:07:43PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > Am 11/8/2024 um 11:12 AM schrieb Akira Yokosawa:
> > > On Fri, 8 Nov 2024 10:10:48 +0100, Jonas Oberhauser wrote:
> > > > I hadn't done that before (because I thought I should not add other people's tags
> > > > especially if they hadn't reviewed that specific revision), so we may be missing
> > > > *a lot* of reviewed-by...
> > > > 
> > > 
> > > Section "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
> > > of Documentation/process/submitting-patches.rst has this paragraph:
> > > 
> > >    Both Tested-by and Reviewed-by tags, once received on mailing list from tester
> > >    or reviewer, should be added by author to the applicable patches when sending
> > >    next versions.  However if the patch has changed substantially in following
> > >    version, these tags might not be applicable anymore and thus should be removed.
> > >    Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
> > >    in the patch changelog (after the '---' separator).
> > > 
> > > Does this help you?
> > 
> > Thanks so much, it does. My apologies to everyone whose reviewed-by tag I
> > failed to add :(
> > 
> > I should have read that more document more carefully.
> 
> No worries!  The important part is your changes.  The tags are easy
> to add.  And now you know.  ;-)

The first three of your patches could go in, but the last two require a
new herd7 release (for the lkmmv2 flag).  Left to myself, I would hold
all five until we get a new herd7 release, but if it is important to
get the first three into the current merge window, please rebase them
to mainline some time this week.  I would then send a pull request for
the for next week, the second and final week of the merge window.

Over to you!

							Thanx, Paul

