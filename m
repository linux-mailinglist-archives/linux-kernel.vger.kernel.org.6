Return-Path: <linux-kernel+bounces-224866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B59127D0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 16:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8E31C2637A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F0021A19;
	Fri, 21 Jun 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBjwrxbF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2260208A1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718980278; cv=none; b=C3R/RaS4gYfr53gGnBnygy7SmndbEx3JoM2NcQ8Xtlp89+rSMpYwUIsSfEomhGWPuHOECtrBKn2Jr5udL3yaJVCEgi6EkK+CzpzgLPyoqN/VL+4z/oYn7zCqnxGspYiGdh+GgTbYlK/Ry+tdbY6kYVzz6gbwfcpA93Gy4/cO014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718980278; c=relaxed/simple;
	bh=8QFjndEQ8+qdauD0rfTeR1Hzck+SUb8TF1DtGMQns3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlNfOvfCvxUR9rENO7DXi5+dvQOHNas8a4e3zXTifdNv1bfjYjDnS3jz7JJCPg6OylVw86ngDd5H2s9NmBRAK+eSmHC6kFvCoopfe1U6WaE4Ny8/lE6vr6hXn/sJO2gx2q3Mx+LVCfqZgO6qqIRcvavyZnYDtVRjCxw95TsEhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBjwrxbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B18C2BBFC;
	Fri, 21 Jun 2024 14:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718980278;
	bh=8QFjndEQ8+qdauD0rfTeR1Hzck+SUb8TF1DtGMQns3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBjwrxbFNAmKqYbU+H4G0IV6ZdBIcR24sIX/4VgV71qfFApJyHOUKf+uQKPo5ag0x
	 Ow2c78DOguzutDjJelpaHJC7Z1IxaGN8MagU3mCYosfTIThifhYSXKsANNKvliqRYC
	 60d6IPOUUkYuSQbsbUiSsi0iLPn4hgEIPvE/v9TyEbZ1iRPop0LqAkXVbOdPD4Ec7N
	 OVZ4gCcsGQf5JFgrOK81x/aeNMrwp7NXHXHiYJS4q3N303/4ogx47+Maay6mjay8A/
	 AwkcXwcFPsQvr7CkqFsF1y1RkomCQrbsety9xUx84PefywJloVdXERI+gH3hYL1Pif
	 AaM/XYb7Hez2g==
Date: Fri, 21 Jun 2024 16:31:15 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>, Narasimhan V <Narasimhan.V@amd.com>
Subject: Re: [PATCH 0/3] timer_migration: Fix a possible race and improvements
Message-ID: <ZnWOswTMML6ShzYO@localhost.localdomain>
References: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>

Le Fri, Jun 21, 2024 at 11:37:05AM +0200, Anna-Maria Behnsen a écrit :
> Borislav reported a warning in timer migration deactive path
> 
>   https://lore.kernel.org/r/20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local
> 
> Sadly it doesn't reproduce directly. But with the change of timing (by
> adding a trace prinkt before the warning), it is possible to trigger the
> warning reliable at least in my test setup. The problem here is a racy
> check agains group->parent pointer. This is also used in other places in
> the code and fixing this racy usage is adressed by the first patch.
> 
> While working with the code, I saw two things which could be improved
> (tracing and update of per cpu group wakeup value). This improvements are
> adressed by the other two patches.
> 
> Patches are available here:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git timers/misc
> 
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> 
> Thanks,
> 
> Anna-Maria
> 
> ---

This made me stare at the group creation again and I might have found
something. Does the following race look plausible to you?


                  [GRP0:0]
               migrator = 0
               active   = 0
               nextevt  = KTIME_MAX
               /         \
              0         1 .. 7
          active         idle

0) Hierarchy has only 8 CPUs (single node for now with only CPU 0
   as active.

   
                             [GRP1:0]
                        migrator = TMIGR_NONE
                        active   = NONE
                        nextevt  = KTIME_MAX
                                         \
                 [GRP0:0]                  [GRP0:1]
              migrator = 0              migrator = TMIGR_NONE
              active   = 0              active   = NONE
              nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
                /         \                    |
              0          1 .. 7                8
          active         idle                !online

1) CPU 8 is booting and creates a new node and a new top. For now it's
   only connected to GRP0:1, not yet to GRP0:0. Also CPU 8 hasn't called
   __tmigr_cpu_activate() on itself yet.


                             [GRP1:0]
                        migrator = TMIGR_NONE
                        active   = NONE
                        nextevt  = KTIME_MAX
                       /                  \
                 [GRP0:0]                  [GRP0:1]
              migrator = 0              migrator = TMIGR_NONE
              active   = 0              active   = NONE
              nextevt  = KTIME_MAX      nextevt  = KTIME_MAX
                /         \                    |
              0          1 .. 7                8
          active         idle                active

2) CPU 8 connects GRP0:0 to GRP1:0 and observes while in
   tmigr_connect_child_parent() that GRP0:0 is not TMIGR_NONE. So it
   prepares to call tmigr_active_up() on it. It hasn't done it yet.


                             [GRP1:0]
                        migrator = TMIGR_NONE
                        active   = NONE
                        nextevt  = KTIME_MAX
                       /                  \
                 [GRP0:0]                  [GRP0:1]
              migrator = TMIGR_NONE        migrator = TMIGR_NONE
              active   = NONE              active   = NONE
              nextevt  = KTIME_MAX         nextevt  = KTIME_MAX
                /         \                    |
              0          1 .. 7                8
            idle         idle                active

3) CPU 0 goes idle. Since GRP0:0->parent has been updated by CPU 8 with
   GRP0:0->lock held, CPU 0 observes GRP1:0 after calling tmigr_update_events()
   and it propagates the change to the top (no change there and no wakeup
   programmed since there is no timer).


                             [GRP1:0]
                        migrator = GRP0:0
                        active   = GRP0:0
                        nextevt  = KTIME_MAX
                       /                  \
                 [GRP0:0]                  [GRP0:1]
              migrator = TMIGR_NONE       migrator = TMIGR_NONE
              active   = NONE             active   = NONE
              nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
                /         \                    |
              0          1 .. 7                8
            idle         idle                active

4) Now CPU 8 finally calls tmigr_active_up() to GRP0:0

                             [GRP1:0]
                        migrator = GRP0:0
                        active   = GRP0:0, GRP0:1
                        nextevt  = KTIME_MAX
                       /                  \
                 [GRP0:0]                  [GRP0:1]
              migrator = TMIGR_NONE       migrator = 8
              active   = NONE             active   = 8
              nextevt  = KTIME_MAX        nextevt  = KTIME_MAX
                /         \                    |
              0          1 .. 7                8
            idle         idle                active

5) And out of tmigr_cpu_online() CPU 8 calls tmigr_active_up() on itself

                             [GRP1:0]
                        migrator = GRP0:0
                        active   = GRP0:0
                        nextevt  = T8
                       /                  \
                 [GRP0:0]                  [GRP0:1]
              migrator = TMIGR_NONE         migrator = TMIGR_NONE
              active   = NONE               active   = NONE
              nextevt  = KTIME_MAX          nextevt  = T8
                /         \                    |
              0          1 .. 7                8
            idle         idle                  idle

5) CPU 8 goes idle with a timer T8 and relies on GRP0:0 as the migrator.
   But it's not really active, so T8 gets ignored.


And if that race looks plausible, does the following fix look good?

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 84413114db5c..0609cb8c770e 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1525,7 +1525,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	child->childmask = BIT(parent->num_children++);
 
 	raw_spin_unlock(&parent->lock);
-	raw_spin_unlock_irq(&child->lock);
 
 	trace_tmigr_connect_child_parent(child);
 
@@ -1559,6 +1558,14 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 		 */
 		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 	}
+	/*
+	 * Keep the lock up to that point so that if the child goes idle
+	 * concurrently, either it sees the new parent with its active state
+	 * after locking on tmigr_update_events() and propagates afterwards
+	 * its idle state up, or the current booting CPU will observe TMIGR_NONE
+	 * on the remote child and it won't propagate a spurious active state.
+	 */
+	raw_spin_unlock_irq(&child->lock);
 }
 
 static int tmigr_setup_groups(unsigned int cpu, unsigned int node)

