Return-Path: <linux-kernel+bounces-402195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338589C24EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2811C246C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC161A9B2A;
	Fri,  8 Nov 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJBDm+xn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E8D233D6E;
	Fri,  8 Nov 2024 18:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090925; cv=none; b=niWAEdc2Qqh7+i2dloXFTesISCji+/djuXlGFUQeHHM04bTgSInLXm2pIkLBb7iNe9fJlJilOyEhhte7VZganY3Be+jp6Rb1jaYWuu1OWUto6YECfpARRVnM+PwdXF0u4UkjRtWn6gFEgd/9ojwR2ewAs/+aFTvh2R53Ei8ZQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090925; c=relaxed/simple;
	bh=Rcgi0WSaiAvw0zLkHN3rVnCELx/EW6YPS2PAGkjKTEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZsJ4Jii77ao41NH4U1jBawLc4eKD9yYst9cv8GLa8oFEqDpB8mq4SlXx2EsvvbcLEeB9iYBjiNvD/fHuJg6T9oQVozDKGrAEfZq9ZWiFgjXahHlvVovAUARs7QGAzbM5PmEbk/jmNUvKwD7Cejqrgb+TiLYtS5Gl3rysPi4l6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJBDm+xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6437C4CECD;
	Fri,  8 Nov 2024 18:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731090924;
	bh=Rcgi0WSaiAvw0zLkHN3rVnCELx/EW6YPS2PAGkjKTEQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=KJBDm+xnwQ5zNTcsPk1XqrWdxE5gqcYc2SRl/sko1PFjoArtdgZPms8qNUnKUuYlw
	 XXoLP47HhqoiHH6fABDs2Kh8+47JCc9NJ1InxZKINCvEpHJ20gk5suC/NGmOcBOGGu
	 wsJ1LiIY+F2Zu0vo4ewIExPkZbrq+V+T1dS6Dos8LKMjOEZIVBfwShg7TbsmuTnKVJ
	 d7ZDw/+BVOGaWjvA2vj1u7FJ+RHInkc/EYjGP5/CSbMtCWid5JAvUYDSZl3O7c362j
	 Uqa/QecCQzUKaQ87c2AHME8Z2whdp7JrTZ2LpJOYmo7J/kiFLC2s1wRoRekmZwOCjo
	 lVw/tCfko9JIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 52AC2CE09E4; Fri,  8 Nov 2024 10:35:24 -0800 (PST)
Date: Fri, 8 Nov 2024 10:35:24 -0800
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
Message-ID: <245e4781-80b2-4e21-b4de-51ffeac9cc39@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3d72b92a-4935-425c-abd5-ec4631baef2c@huaweicloud.com>
 <46d291da-ddb9-43b9-bd93-b81aacd5e29c@gmail.com>
 <7542399d-87c5-4f1c-9d09-6a6f96d148da@huaweicloud.com>
 <a278c4a9-eae2-491e-8f13-5a87a25dad26@gmail.com>
 <f1d7a295-ad24-41c8-a431-7d6492d51097@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d7a295-ad24-41c8-a431-7d6492d51097@huaweicloud.com>

On Fri, Nov 08, 2024 at 12:07:43PM +0100, Jonas Oberhauser wrote:
> 
> 
> Am 11/8/2024 um 11:12 AM schrieb Akira Yokosawa:
> > On Fri, 8 Nov 2024 10:10:48 +0100, Jonas Oberhauser wrote:
> > > I hadn't done that before (because I thought I should not add other people's tags
> > > especially if they hadn't reviewed that specific revision), so we may be missing
> > > *a lot* of reviewed-by...
> > > 
> > 
> > Section "Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
> > of Documentation/process/submitting-patches.rst has this paragraph:
> > 
> >    Both Tested-by and Reviewed-by tags, once received on mailing list from tester
> >    or reviewer, should be added by author to the applicable patches when sending
> >    next versions.  However if the patch has changed substantially in following
> >    version, these tags might not be applicable anymore and thus should be removed.
> >    Usually removal of someone's Tested-by or Reviewed-by tags should be mentioned
> >    in the patch changelog (after the '---' separator).
> > 
> > Does this help you?
> 
> Thanks so much, it does. My apologies to everyone whose reviewed-by tag I
> failed to add :(
> 
> I should have read that more document more carefully.

No worries!  The important part is your changes.  The tags are easy
to add.  And now you know.  ;-)

							Thanx, Paul

