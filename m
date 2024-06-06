Return-Path: <linux-kernel+bounces-204927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DA8FF515
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 21:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD8FB250A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ACC535C8;
	Thu,  6 Jun 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNhMvnrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A656151012
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717700423; cv=none; b=FzOdtsR0kigWlDsfRVMDM6uYsn3ywbbtbyuXVAdjp2GydHF57ASSNGeB4tDVdUT3VUpXPGw71hMO0KLrDPh4wX6vM37L9FXFDPDgikDpV+hPCrl9vciX2d4dsvw8xzVit0VxOM7PkQdSqaZWonoPSx8wKeErgOvFhXukLn9lYYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717700423; c=relaxed/simple;
	bh=7gzIEr0O1FpA8ow/cHDpRo9oBct7qyoJtU3ypxIMsoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGBAMZ0blUO8o8mwNLLv8ZeJ3WokwzwOmN2XBi+KV2cG9u0OaT5jAI0khNyzL+Q1B0N5xTKgp4AKpa696/JGlTvl/SMgPTlBc9toszJSpE64uuuFNTju8igCzQ2NftJClafQ1B6Ti6/tbmWeHv9dctQ11xr/PvlYpzVnesoJJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNhMvnrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32549C32782;
	Thu,  6 Jun 2024 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717700423;
	bh=7gzIEr0O1FpA8ow/cHDpRo9oBct7qyoJtU3ypxIMsoY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mNhMvnrRkqXensqpBOlrc+JrTxdE+bXwyi6yLzDg8VaLM6z3ZAYoBWxMtbPKrp45b
	 3732AWU+1hSCltuAqu4HcD+J8gqpxdG/x/1f+73ZitLN8cjajUZ5i6MEum+Zb7jzSf
	 8HhEON7T0fxkvUg2WCkwhtBbxWyyvlWZ0lMwOJtVipb7hdr/BO2bc3jw0XRuXQuzoK
	 XQac+dJyEJlo4VxiOVNhjXxGhX8f1mFFWQqra3Xo6DQGDICwKUhZAsqV65bbiYbzMO
	 ZjNscX6GRtcDKlgAL6iowMVg1Qk+ebOGSgZA+dKGAFGhIGsARZTogohzCNvyIoFH/D
	 6xmDzoQxyOX1g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CB0BECE3F34; Thu,  6 Jun 2024 12:00:22 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:00:22 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
	peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <469cb89f-24b3-487e-bd66-a2b4ebddfed2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
 <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
 <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>
 <64d944ff-b609-4977-a491-91ffc199a4cd@paulmck-laptop>
 <26aa2333-5e54-4dcd-b6df-f8f8545b2672@rowland.harvard.edu>
 <47fe55b3-81af-4397-9769-bda25209e980@paulmck-laptop>
 <51b94313-ed74-4507-a354-eb418389fdaf@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b94313-ed74-4507-a354-eb418389fdaf@rowland.harvard.edu>

On Thu, Jun 06, 2024 at 02:52:02PM -0400, Alan Stern wrote:
> On Thu, Jun 06, 2024 at 10:57:42AM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 06, 2024 at 01:21:28PM -0400, Alan Stern wrote:
> > > Okay.  Don't we already have a litmus test in the archive that really 
> > > does create a deadlock?  Something like: Lock Lock Unlock Unlock, all 
> > > using the same lock variable?
> > 
> > We do have these guys:
> > 
> > auto/C-RR-GR+RR-R+RR-R.litmus
> > auto/C-RR-GR+RR-R.litmus
> > auto/C-RW-GR+RW-R+RW-R.litmus
> > auto/C-RW-GR+RW-R.litmus
> > auto/C-WR-GR+WR-R+WR-R.litmus
> > auto/C-WR-GR+WR-R.litmus
> > auto/C-WW-GR+WW-R+WW-R.litmus
> > auto/C-WW-GR+WW-R.litmus
> > 	A synchronize_rcu() in an RCU read-side critical section.
> > 
> > I added a manual/locked/self-deadlock.litmus, which is shown at the
> > end of this email.  Omitting the nested self-deadlocking acquisition
> > and release gives one state with blank line.  ;-)
> 
> Hah, because there is no "exists" clause and no variables other than the 
> spinlock itself.

;-) ;-) ;-)

> > Or should I add a spin_is_locked() in order to get a non-empty
> > state line?
> 
> It's fine the way it is.

Very good, pushed.

							Thanx, Paul

