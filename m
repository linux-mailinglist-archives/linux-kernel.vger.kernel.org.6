Return-Path: <linux-kernel+bounces-240197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD349926A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 518721F22BFE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D73E191F6F;
	Wed,  3 Jul 2024 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8mW+ESQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D72BB13
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041869; cv=none; b=IUFGGVmBLwI9pwSOLqpq73g3cQt/5A89qhptcEvL3TxXjXPKcYFe5/h4Ewakp01F7meEv6Hgw95DEBWDrUEKgpY3StmaKdH8xwYdmkLFWm83ooV5xwi1O+XN38S73pVCfP31ixXAWkQMUVn/2Zntk5aglURJThr525f3eBxjvdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041869; c=relaxed/simple;
	bh=8mw7I41E/rk69cDwi0X99n/NyJfc44RZFySPkI8Bmfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/F/4ugK1afk0m7NIqV0fwRJ8nlFOnMpuDyHmlbo6XFBzGVNy/RDiG19PT5EXjTHdjoQI6aUA9MddxL2O9C63kj1lSmeUNCWgtcksbYZihzSdGvd+Eo5lB+VUUUgomADysFtD5c0ErVVkskbvybxZlS2/8wMCVI0sTn4Hvwtojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8mW+ESQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E01C2BD10;
	Wed,  3 Jul 2024 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720041869;
	bh=8mw7I41E/rk69cDwi0X99n/NyJfc44RZFySPkI8Bmfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8mW+ESQ17E9pRN4tg53ohDHinXBT3qCNcPjlCH/qJaRZpy6dOA0qdd9zLz6qxpeO
	 o7mMn2aDirixox07LC8jZ5kHUqMnf+agPYm7os31yGnD5IUZNXJ6d4amSZkVHVZ7NB
	 //gVhHFKlDfrWzmoGD/8b+AQFiGKtbKwky8qQHb6dlwW5H7Qvy5TvHDWOZq5qASMmj
	 Ahm3G+QSM3Jmb6JDTmLcgVZ8lOShPxjqBdp6fOBlksJ8PgZkeI55A1ED8aEwWEzDZX
	 rex5xoLqsvlIVk+y8GdWMKCsKJo936kO0/xbAasxVi3B5VcIGW999y7GpMzoKdLVlo
	 2g4UBJkoeNcag==
Date: Wed, 3 Jul 2024 23:24:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] timers/migration: Move hierarchy setup into
 cpuhotplug prepare callback
Message-ID: <ZoXBivGZrfePE2Xx@pavilion.home>
References: <20240701-tmigr-fixes-v3-2-25cd5de318fb@linutronix.de>
 <20240703202839.8921-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703202839.8921-1-anna-maria@linutronix.de>

Le Wed, Jul 03, 2024 at 10:28:39PM +0200, Anna-Maria Behnsen a écrit :
> When a CPU comes online the first time, it is possible that a new top level
> group will be created. In general all propagation is done from the bottom
> to top. This minimizes complexity and prevents possible races. But when a
> new top level group is created, the formely top level group needs to be
> connected to the new level. This is the only time, when the direction to
> propagate changes is changed: the changes are propagated from top (new top
> level group) to bottom (formerly top level group).
> 
> This introduces two races (see (A) and (B)) as reported by Frederic:
> 
> (A) This race happens, when marking the formely top level group as active,
> but the last active CPU of the formerly top level group goes idle. Then
> it's likely that formerly group is no longer active, but marked
> nevertheless as active in new top level group:
> 
> 		  [GRP0:0]
> 	       migrator = 0
> 	       active   = 0
> 	       nextevt  = KTIME_MAX
> 	       /         \
> 	      0         1 .. 7
> 	  active         idle
> 
> 0) Hierarchy has for now only 8 CPUs and CPU 0 is the only active CPU.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = NONE
> 			nextevt  = KTIME_MAX
> 					 \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0              migrator = TMIGR_NONE
> 	      active   = 0              active   = NONE
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	  active         idle                !online
> 
> 1) CPU 8 is booting and creates a new group in first level GRP0:1 and
>    therefore also a new top group GRP1:0. For now the setup code proceeded
>    only until the connected between GRP0:1 to the new top group. The
>    connection between CPU8 and GRP0:1 is not yet established and CPU 8 is
>    still !online.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = NONE
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0              migrator = TMIGR_NONE
> 	      active   = 0              active   = NONE
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	  active         idle                !online
> 
> 2) Setup code now connects GRP0:0 to GRP1:0 and observes while in
>    tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
>    prepares to call tmigr_active_up() on it. It hasn't done it yet.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = NONE
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE        migrator = TMIGR_NONE
> 	      active   = NONE              active   = NONE
> 	      nextevt  = KTIME_MAX         nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	    idle         idle                !online
> 
> 3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
>    GRP0:0->lock held, CPU 0 observes GRP1:0 after calling
>    tmigr_update_events() and it propagates the change to the top (no change
>    there and no wakeup programmed since there is no timer).
> 
> 			     [GRP1:0]
> 			migrator = GRP0:0
> 			active   = GRP0:0
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE       migrator = TMIGR_NONE
> 	      active   = NONE             active   = NONE
> 	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
> 		/         \
> 	      0          1 .. 7                8
> 	    idle         idle                !online
> 
> 4) Now the setup code finally calls tmigr_active_up() to and sets GRP0:0
>    active in GRP1:0
> 
> 			     [GRP1:0]
> 			migrator = GRP0:0
> 			active   = GRP0:0, GRP0:1
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE       migrator = 8
> 	      active   = NONE             active   = 8
> 	      nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
> 		/         \                    |
> 	      0          1 .. 7                8
> 	    idle         idle                active
> 
> 5) Now CPU 8 is connected with GRP0:1 and CPU 8 calls tmigr_active_up() out
>    of tmigr_cpu_online().
> 
> 			     [GRP1:0]
> 			migrator = GRP0:0
> 			active   = GRP0:0
> 			nextevt  = T8
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE         migrator = TMIGR_NONE
> 	      active   = NONE               active   = NONE
> 	      nextevt  = KTIME_MAX          nextevt  = T8
> 		/         \                    |
> 	      0          1 .. 7                8
> 	    idle         idle                  idle
> 
> 5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
>    But it's not really active, so T8 gets ignored.
> 
> --> The update which is done in third step is not noticed by setup code. So
>     a wrong migrator is set to top level group and a timer could get
>     ignored.
> 
> (B) Reading group->parent and group->childmask when an hierarchy update is
> ongoing and reaches the formerly top level group is racy as those values
> could be inconsistent. (The notation of migrator and active now slightly
> changes in contrast to the above example, as now the childmasks are used.)
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = 0x00
> 			nextevt  = KTIME_MAX
> 					 \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE     migrator = TMIGR_NONE
> 	      active   = 0x00           active   = 0x00
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 	      childmask= 0		childmask= 1
> 	      parent   = NULL		parent   = GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  idle           idle                !online
> 	  childmask=1
> 
> 1) Hierarchy has 8 CPUs. CPU 8 is at the moment in the process of onlining
>    but did not yet connect GRP0:0 to GRP1:0.
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = 0x00
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = TMIGR_NONE     migrator = TMIGR_NONE
> 	      active   = 0x00           active   = 0x00
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 	      childmask= 0		childmask= 1
> 	      parent   = GRP1:0		parent   = GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  idle           idle                !online
> 	  childmask=1
> 
> 2) Setup code (running on CPU 8) now connects GRP0:0 to GRP1:0, updates
>    parent pointer of GRP0:0 and ...
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = 0x00
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0x01           migrator = TMIGR_NONE
> 	      active   = 0x01           active   = 0x00
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 	      childmask= 0		childmask= 1
> 	      parent   = GRP1:0		parent   = GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  active          idle                !online
> 	  childmask=1
> 
> 	  tmigr_walk.childmask = 0
> 
> 3) ... CPU 0 comes active in the same time. As migrator in GRP0:0 was
>    TMIGR_NONE, childmask of GRP0:0 is stored in update propagation data
>    structure tmigr_walk (as update of childmask is not yet
>    visible/updated). And now ...
> 
> 			     [GRP1:0]
> 			migrator = TMIGR_NONE
> 			active   = 0x00
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0x01           migrator = TMIGR_NONE
> 	      active   = 0x01           active   = 0x00
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 	      childmask= 2		childmask= 1
> 	      parent   = GRP1:0		parent   = GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  active          idle                !online
> 	  childmask=1
> 
> 	  tmigr_walk.childmask = 0
> 
> 4) ... childmask of GRP0:0 is updated by CPU 8 (still part of setup
>    code).
> 
> 			     [GRP1:0]
> 			migrator = 0x00
> 			active   = 0x00
> 			nextevt  = KTIME_MAX
> 		       /                  \
> 		 [GRP0:0]                  [GRP0:1]
> 	      migrator = 0x01           migrator = TMIGR_NONE
> 	      active   = 0x01           active   = 0x00
> 	      nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
> 	      childmask= 2		childmask= 1
> 	      parent   = GRP1:0		parent   = GRP1:0
> 		/         \
> 	      0          1 .. 7                8
> 	  active          idle                !online
> 	  childmask=1
> 
> 	  tmigr_walk.childmask = 0
> 
> 5) CPU 0 sees the connection to GRP1:0 and now propagates active state to
>    GRP1:0 but with childmask = 0 as stored in propagation data structure.
> 
> --> Now GRP1:0 always has a migrator as 0x00 != TMIGR_NONE and for all CPUs
>     it looks like GRP1:0 is always active.
> 
> To prevent those races, the setup of the hierarchy is moved into the
> cpuhotplug prepare callback. The prepare callback is not executed by the
> CPU which will come online, it is executed by the CPU which prepares
> onlining of the other CPU. This CPU is active while it is connecting the
> formerly top level to the new one. This prevents from (A) to happen and it
> also prevents from any further walk above the formerly top level until that
> active CPU becomes inactive, releasing the new ->parent and ->childmask
> updates to be visible by any subsequent walk up above the formerly top
> level hierarchy. This prevents from (B) to happen. The direction for the
> updates is now forced to look like "from bottom to top".
> 
> However if the active CPU prevents from tmigr_cpu_(in)active() to walk up
> with the update not-or-half visible, nothing prevents walking up to the new
> top with a 0 childmask in tmigr_handle_remote_up() or
> tmigr_requires_handle_remote_up() if the active CPU doing the prepare is
> not the migrator. But then it looks fine because:
> 
>   * tmigr_check_migrator() should just return false
>   * The migrator is active and should eventually observe the new childmask
>     at some point in a future tick.
> 
> Split setup functionality of online callback into the cpuhotplug prepare
> callback and setup hotplug state. Reorder the code, that all prepare
> related functions are close to each other and online and offline callbacks
> are also close together.
> 
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Looks very good, thanks!

