Return-Path: <linux-kernel+bounces-204919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568978FF4FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAF41C212C3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1FC4F5FB;
	Thu,  6 Jun 2024 18:52:06 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B7C204DA0F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.131.102.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699925; cv=none; b=eTKY2gqFQJgWnqRotj2c7KOruQleaf8rQq+qX9Sxmf71ZErPBdg4JLgSIWc9X/4yvlornk/ehzDrDBLSh2/e1iusX91MkSTWcRvmYnHF7SOmEQrHXW+AP0s2+NII5oSPtJk4Leaj12W/bBkTxTo1YN060JuAkt8c3pGifsXvt/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699925; c=relaxed/simple;
	bh=tT1S45dFo3TnMqFOJNXtbpzOZ2RqSOmznvA+HJXmivk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPbmJTh+nUdRGU38uaBAI9Zsm0Uh/p5lvLq0Sn/QTq8+DAOilU9B8GhEsmaZsRYEQQdquT6R36FnVx4FgwAqMNdDTJia2Eu+TSqvAWaLjbug1cKh0c6IB1JhgltKxmvdL6wI7w5ey9N/D+2zL8UqBrXObR0/v4weDq91aqzH3fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu; spf=pass smtp.mailfrom=netrider.rowland.org; arc=none smtp.client-ip=192.131.102.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netrider.rowland.org
Received: (qmail 16315 invoked by uid 1000); 6 Jun 2024 14:52:02 -0400
Date: Thu, 6 Jun 2024 14:52:02 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>, will@kernel.org,
  peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
  dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
  akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
  linux-kernel@vger.kernel.org, hernan.poncedeleon@huaweicloud.com,
  jonas.oberhauser@huaweicloud.com
Subject: Re: New locking test for the paulmckrcu/litmus github archive
Message-ID: <51b94313-ed74-4507-a354-eb418389fdaf@rowland.harvard.edu>
References: <a8c06694-098d-4b95-845c-96b40cd3ff2d@rowland.harvard.edu>
 <df851df5-0e3a-45b1-ae85-9625309766b0@paulmck-laptop>
 <1d175b42-84b4-4a48-b1fb-ab6fd3566f75@rowland.harvard.edu>
 <64d944ff-b609-4977-a491-91ffc199a4cd@paulmck-laptop>
 <26aa2333-5e54-4dcd-b6df-f8f8545b2672@rowland.harvard.edu>
 <47fe55b3-81af-4397-9769-bda25209e980@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fe55b3-81af-4397-9769-bda25209e980@paulmck-laptop>

On Thu, Jun 06, 2024 at 10:57:42AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 06, 2024 at 01:21:28PM -0400, Alan Stern wrote:
> > Okay.  Don't we already have a litmus test in the archive that really 
> > does create a deadlock?  Something like: Lock Lock Unlock Unlock, all 
> > using the same lock variable?
> 
> We do have these guys:
> 
> auto/C-RR-GR+RR-R+RR-R.litmus
> auto/C-RR-GR+RR-R.litmus
> auto/C-RW-GR+RW-R+RW-R.litmus
> auto/C-RW-GR+RW-R.litmus
> auto/C-WR-GR+WR-R+WR-R.litmus
> auto/C-WR-GR+WR-R.litmus
> auto/C-WW-GR+WW-R+WW-R.litmus
> auto/C-WW-GR+WW-R.litmus
> 	A synchronize_rcu() in an RCU read-side critical section.
> 
> I added a manual/locked/self-deadlock.litmus, which is shown at the
> end of this email.  Omitting the nested self-deadlocking acquisition
> and release gives one state with blank line.  ;-)

Hah, because there is no "exists" clause and no variables other than the 
spinlock itself.

> Or should I add a spin_is_locked() in order to get a non-empty
> state line?

It's fine the way it is.

Alan

