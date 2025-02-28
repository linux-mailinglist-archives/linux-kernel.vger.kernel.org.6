Return-Path: <linux-kernel+bounces-538843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE9A49DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 873241708DC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C21A19007E;
	Fri, 28 Feb 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEJ4+BNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018341EF399;
	Fri, 28 Feb 2025 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740757302; cv=none; b=Hs4Y/1RQ5eXktKGNheZwdUlPYi8Ppax02jcH3FcsTQDpB4gULp8cgF5TXYe3zvjcPeEM7Mnm7xr8v5ot2BX3j1zX0rzDk7BPhLWAHfVtM+8haJ/oz4qqPtU/SCdih9BxYUzI0CFDpfl6YLOT9bS5rjtKFm78K6wGk+zdQ1vOJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740757302; c=relaxed/simple;
	bh=BCaOwpKwAe2iR8W7rXlgoLie6yh6rPXawN66ANiiYGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfooHcmHGsXZ+4reyJbPHsVDUoveoR2tg6zJep2duGVv+nBPB07WnppinBfXGZCs90jKipxnpj+WIFZTEFHLpWWzUDWjLvdsRg3nCGjDbfajxMSAn+3I2G7YTpb39DS5OS2EcnL2wgU1VV/y1seYHkbq9qvA6o1O7O5FCosx2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEJ4+BNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C0BC4CEEB;
	Fri, 28 Feb 2025 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740757301;
	bh=BCaOwpKwAe2iR8W7rXlgoLie6yh6rPXawN66ANiiYGw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=UEJ4+BNbm2XZJJI3Cxz9uwBm1IS4h1iw91MI7ZOgka/OaOKLTUN43q4IdzpbYyPQW
	 qkGA+1h90JHzSylifihfxCRirjBMyjAWK5H0ABFEOoi0NtHCAJ2ltJ2srMh9otnkK3
	 xh45gdILQBFgc/0rDRx67ZkgvTlWR5ckVn8R1HVGANsV83u1ztlDCzq+MT42DXQu4k
	 qz6vi6QNVzirG0buyWCQPEAArAggKVCYkdQdF8tY3QMBczaHnL2nKsLkgMhDtD2dN9
	 MtohUXcxRXedyQSBSBXbgLmncBArJbe64rzsEijkg328lpaX3taM4EMx1T2AhVdiKc
	 2IgC3A1Jl0P/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90F5BCE0928; Fri, 28 Feb 2025 07:41:40 -0800 (PST)
Date: Fri, 28 Feb 2025 07:41:40 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v4 3/3] rcu: Use _full() API to debug synchronize_rcu()
Message-ID: <1408fc88-e2c6-4f49-b581-0e9ad5620fe0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250227131613.52683-1-urezki@gmail.com>
 <20250227131613.52683-3-urezki@gmail.com>
 <Z8CdB0Hzvdu5ZVSI@Mac.home>
 <d8b196c1-c1b5-4bf9-b1cb-dde8642cc34b@paulmck-laptop>
 <Z8Ckb6spK35-Ez4U@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8Ckb6spK35-Ez4U@pc636>

On Thu, Feb 27, 2025 at 06:44:15PM +0100, Uladzislau Rezki wrote:
> On Thu, Feb 27, 2025 at 09:26:40AM -0800, Paul E. McKenney wrote:
> > On Thu, Feb 27, 2025 at 09:12:39AM -0800, Boqun Feng wrote:
> > > Hi Ulad,
> > > 
> > > I put these three patches into next (and misc.2025.02.27a) for some
> > > testing, hopefully it all goes well and they can make it v6.15.
> > > 
> > > A few tag changed below:
> > > 
> > > On Thu, Feb 27, 2025 at 02:16:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > Switch for using of get_state_synchronize_rcu_full() and
> > > > poll_state_synchronize_rcu_full() pair to debug a normal
> > > > synchronize_rcu() call.
> > > > 
> > > > Just using "not" full APIs to identify if a grace period is
> > > > passed or not might lead to a false-positive kernel splat.
> > > > 
> > > > It can happen, because get_state_synchronize_rcu() compresses
> > > > both normal and expedited states into one single unsigned long
> > > > value, so a poll_state_synchronize_rcu() can miss GP-completion
> > > > when synchronize_rcu()/synchronize_rcu_expedited() concurrently
> > > > run.
> > > > 
> > > > To address this, switch to poll_state_synchronize_rcu_full() and
> > > > get_state_synchronize_rcu_full() APIs, which use separate variables
> > > > for expedited and normal states.
> > > > 
> > > > Link: https://lore.kernel.org/lkml/Z5ikQeVmVdsWQrdD@pc636/T/
> > > 
> > > I switch this into "Closes:" per checkpatch.
> > > 
> > > > Fixes: 988f569ae041 ("rcu: Reduce synchronize_rcu() latency")
> > > > Reported-by: cheung wall <zzqq0103.hey@gmail.com>
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > 
> > > You seem to forget add Paul's Reviewed-by, so I add it in rcu/next.
> > > Would you or Paul double-check the Reviewed-by should be here?
> > 
> > I am good with keeping my Reviewed-by tags.
> > 
> Thanks Paul!

Except that I got this from overnight testing of rcu/dev on the shared
RCU tree:

WARNING: CPU: 5 PID: 14 at kernel/rcu/tree.c:1636 rcu_sr_normal_complete+0x5c/0x80

I see this only on TREE05.  Which should not be too surprising, given
that this is the scenario that tests it.  It happened within five minutes
on all 14 of the TREE05 runs.

This commit, just to avoid any ambiguity:

7cb48b64a563 ("MAINTAINERS: Update Joel's email address")

							Thanx, Paul

