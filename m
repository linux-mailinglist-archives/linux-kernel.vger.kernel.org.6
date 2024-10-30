Return-Path: <linux-kernel+bounces-389146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9949B691D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0984C1C2137B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C1D21443B;
	Wed, 30 Oct 2024 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MftT5/hD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C921440F;
	Wed, 30 Oct 2024 16:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305625; cv=none; b=KOaK4h/amIhbbdFvhNCrS/SH4KiMQTFQjC9SroOosdeBI21kkSh/MFyvGVHDb5H4lZI7m9vszkmokatnx4lZlp4eEgf52zTbLcyqs5YGUFCIaF96cHAEZJmkKYNUTvhhJm4jL213FGlUD7qx0fIF/1i0aVktpnZAyJZiQD0aiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305625; c=relaxed/simple;
	bh=nON8JGjhzMmgUqSJeQKjBGrRpfhwPugcBp633E+LVv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COMOK7OyUuf7rJMDgrKiVnED/5lEKWW/XeYDJQbw+GR3bykz12waxHPvBT3aDMCyPz4ytBDUy3lpewSAkN/KX9ZmjKV68Rfd/B3Jjzf5h/DRd/y/s+a4Mux1renT67QvE/iMtZxJ2ev3gdXoW79c7aKU0/S/iKlubqyL665s9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MftT5/hD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B2C4CECE;
	Wed, 30 Oct 2024 16:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730305625;
	bh=nON8JGjhzMmgUqSJeQKjBGrRpfhwPugcBp633E+LVv0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=MftT5/hDlYV56Gb9WkIKQj4azgGIRymZruVabMtcAZX2QdCheHAWm6Btw0oTI3Fmv
	 ksm4szS6HhEnbPwAIOIgrXgQtmxf7ecA54fXGh6FfwuYyySDfSfu+Doh8vdAagvYJ6
	 M2diYMSN1/ZCR0JNXl+3vlTgM6EXzh9fLpUjF+vKCofcS+dX4ZDuvmcIhNfSf3AWPR
	 5O62YbM23Ro5HwRa7CmyYM2Cl9nb2oDIAXLl6PuXztI6/IcwoWKQBX+9tjzoPbSsLD
	 JlSNxIVQIUN7TjKO8DkwxNcAW/Dgv7x0P7tRP3hutLLaleMLNSqPxN0YQOblgCEZBe
	 mJC8EWUGBsDqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E245BCE0D99; Wed, 30 Oct 2024 09:27:04 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:27:04 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
	quic_neeraju@quicinc.com, frederic@kernel.org,
	linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	hernan.poncedeleon@huaweicloud.com
Subject: Re: [PATCH v4 5/5] tools/memory-model: Distinguish between syntactic
 and semantic tags
Message-ID: <374137f4-de9e-43a5-a777-31984dc17cfb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240930105710.383284-1-jonas.oberhauser@huaweicloud.com>
 <20240930105710.383284-6-jonas.oberhauser@huaweicloud.com>
 <ZyApMteRMxZbpBta@Boquns-Mac-mini.local>
 <cd97e045-dfa4-4ffe-9df0-f7abeec848e7@paulmck-laptop>
 <3b796ef4-735a-44df-a9b1-671df49fd44e@huaweicloud.com>
 <ZyJEBc1qwFHwQQT2@Boquns-Mac-mini.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJEBc1qwFHwQQT2@Boquns-Mac-mini.local>

On Wed, Oct 30, 2024 at 07:34:45AM -0700, Boqun Feng wrote:
> On Wed, Oct 30, 2024 at 12:38:26PM +0100, Jonas Oberhauser wrote:
> > 
> > 
> > Am 10/30/2024 um 12:41 AM schrieb Paul E. McKenney:
> > > On Mon, Oct 28, 2024 at 05:15:46PM -0700, Boqun Feng wrote:
> > > > On Mon, Sep 30, 2024 at 12:57:10PM +0200, Jonas Oberhauser wrote:
> > > > > Not all tags that are always there syntactically also provide semantic
> > > > > membership in the corresponding set. For example, an 'acquire tag on a
> > > > 
> > > > Maybe:
> > > > 
> > > > Not all annotated accesses provide the same semantic as their syntactic
> > > > tags...
> > > > 
> > > > ?
> > > 
> > > Jonas, are you OK with this change?  If so, I can apply it on my next
> > > rebase.
> > 
> > I'm ok with an extra s after semantics and a minor rephrase:
> > 
> > Not all annotated accesses provide the semantics their syntactic
> > tags would imply
> > 
> > What do you think @Boqun ?
> 
> Yes, of course! This looks good to me.

Very good!

This is in the commit that you (Jonas) will fix, correct?  If so, could
you please make this update as well?  Otherwise, Murphy being who he is,
I will end up changing this and then overwriting my change with your
updated commit.  ;-)

							Thanx, Paul

