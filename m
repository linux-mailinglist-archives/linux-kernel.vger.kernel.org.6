Return-Path: <linux-kernel+bounces-237061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B7E91EA79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7001C2136B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A9F171657;
	Mon,  1 Jul 2024 21:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAHRSrng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ABF2C1BA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719870546; cv=none; b=nmEfHKLEBoqPMvr2qyBJs0o6iTQfoWrHZN6cUoYYPGJ/MRYrPl2vx8Zzb9jR0edli4OqX/KM+XnYNLJequpUciMiCeO+Ul5qoR5B8UCoqQHVWWeXSZ0W2N2GgwaZhM0cVNMoJKiqjeGx4k4tLctI5oGJStkPVxQABTCIzjmKxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719870546; c=relaxed/simple;
	bh=Byn5QNQ8h+2zCnguEP5D8U+mBLZxKBQdtqbsHOASRoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjcyr5cNVU0PvRUgBO+giHaC0QG3vxp21FGlFM2aL0YmHSUEuGbMCme6HE2DQRi0rD+cqNdriOGoBlD5+C4zZsUG9ry+AdM/t4WlBxOyJmNKyJ1jG23DTwE37mcw61K6WxPuKJAK6Hgu2rf/zYVM+YFxt/Nuy4ykfgvn+lIXoe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAHRSrng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57940C116B1;
	Mon,  1 Jul 2024 21:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719870545;
	bh=Byn5QNQ8h+2zCnguEP5D8U+mBLZxKBQdtqbsHOASRoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BAHRSrngnTvwA9Uy8Nbg6zQZssCyx6P6FjMpOIWBbPO+KOZH3Wx3T2Qd6z+LkDfgm
	 MrLoMyqH5FfSMMO8opTmuuhHFqKgfka1JDiciQRwl1ijcWrgqrOGSJzEc/Xornfo6/
	 Vfc9iRqvXtGmJXDZzXxBavuNMdjnSVrYSRVH/+eU7XC8SvJaAAMCkyqq4fJnR320sZ
	 OhfZqMwyxAXUja59rcRfoTmSjOJc/Ljp0Z55ESGSyJMvy3M+b3CAuu0653au2PMAvS
	 r5H0RPC7+YYCYCZsEz5pf93+lpOfM2Joy7rI8hC67Tw2D24Nzl3D5PqL9vo2vFc2TU
	 Pg+pF+QfQv5SQ==
Date: Mon, 1 Jul 2024 23:49:02 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] timers/migration: Move hierarchy setup into
 cpuhotplug prepare callback
Message-ID: <ZoMkTttgF_DgUvGG@pavilion.home>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
 <20240701-tmigr-fixes-v3-2-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-tmigr-fixes-v3-2-25cd5de318fb@linutronix.de>

Le Mon, Jul 01, 2024 at 12:18:38PM +0200, Anna-Maria Behnsen a écrit :
> To prevent those races, the setup of the hierarchy is moved into the
> cpuhotplug prepare callback. The prepare callback is not executed by the
> CPU which will come online, it is executed by the CPU which prepares
> onlining of the other CPU. This CPU will not go idle and so it is ensured,
> that the formerly top level group cannot go idle and change top level group
> state and the propagation could be done without a risk. The direction for
> the updates is now forced to look like "from bottom to top".

You might want to elaborate a bit on those last two sentences. For example:

"""
This CPU is active while it is connecting the formerly top level to the new
one. This prevents from (A) to happen and it also prevents from any further walk
above the formerly top level until that active CPU becomes inactive, releasing
the new ->parent and ->childmask updates to be visible by any subsequent walk
up above the formerly top level hierarchy. This prevents from (B) to happen.
"""

However if the active CPU prevents from tmigr_cpu_(in)active() to walk
up with the update not-or-half visible, nothing prevents walking up to
the new top with a 0 childmask in tmigr_handle_remote_up() or
tmigr_requires_handle_remote_up() if the active CPU doing the prepare is not
the migrator. But then it looks fine because:

* tmigr_check_migrator() should just return false
* The migrator is active and should eventually observe the new childmask
  at some point in a future tick.

But still it can be a good idea to mention that somewhere.

> @@ -1540,22 +1600,22 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
>  	 *   child to the new parent. So tmigr_connect_child_parent() is
>  	 *   executed with the formerly top level group (child) and the newly
>  	 *   created group (parent).
> +	 *
> +	 * * It is ensured, that the child is active, as this setup path is

First comma is not needed.

> +	 *   executed in hotplug prepare callback. This is exectued by an
> +	 *   already connected and !idle CPU. Even if all other CPUs go idle,
> +	 *   the CPU executing the setup will be responsible up to current top
> +	 *   level group.

And the next time it goes inactive, it will release the new childmask and parent
to subsequent walkers through this @child.

> +       * Therefore propagate active state unconditionally.

As for the change itself:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.

