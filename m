Return-Path: <linux-kernel+bounces-443802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D136E9EFBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 20:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896CA28A57A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD186189BBB;
	Thu, 12 Dec 2024 19:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STHmr6wC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6315C140
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734030025; cv=none; b=LHs2zakV+LKJDm8oc/tMIWLxOMe2bn42U3MmqxTDCEF86dNpnk5gPmST0jqOMxFNHBKrQVyj8Fzc8ozloD/sknyZcfDj36uHWW73ztpDrASyR/D1gO++1XUDmQxOM1Ij6Os0us27qQCrZkGjZWRDnJWXRRhkc6JvW80CFypsNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734030025; c=relaxed/simple;
	bh=v2zzQLtKwkeasc7lV/u2/xA/7TmArdlOG9GEBR8/ltk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AL9iJBeP2NIGcmPBUC9q/9wQajzLCsInmQtFHmTzJ+kLKqhklGtTb0j+wm4OVvlXnBo8d4Fe6GPllSxFdfCxOqj77/26SZUult/qYz8hQwSQXO93eejYi6IKvQqXndyD/UwZA5gyOja+CH9oRzltBnEk+S7JXaM+Ot/tSz2gNl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STHmr6wC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB60AC4CED3;
	Thu, 12 Dec 2024 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734030024;
	bh=v2zzQLtKwkeasc7lV/u2/xA/7TmArdlOG9GEBR8/ltk=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=STHmr6wCmiHvNKwBTFM34G18qvy+vzvXr6SsowxdqIwdnMRmpX6r4V9kOaJXw91+V
	 jSLfA2Lsgw7RUD+wq6gu5w5tOGqqe/UKiFP/e+hSVsfpcJSQZLcHGFR1drwJV2vkMk
	 FAoBR3j7trT6t7VpnjgSQbFbmvSWfCNsP5B/LbrAaa9FAczMnxwEKX7NDiKlGLJXhg
	 Y8ie0u9qJgEWYvqOtZTeld4fktGuttBj4+RzVAzfYNDpg/GbQjm5Ceoam096nfYK5/
	 ApIUnwZjKfDpy2gL8L+Auf/sehwyxciUDgbzluTqgSXORmil+L+RNQyRnzOyaNFDFL
	 dqoX0TUOjnF0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4C533CE0808; Thu, 12 Dec 2024 11:00:24 -0800 (PST)
Date: Thu, 12 Dec 2024 11:00:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: quic_mojha@quicinc.com, vschneid@redhat.com, neeraj.upadhyay@kernel.org,
	frederic@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH stop-machine] Fix rcu_momentary_eqs() call in multi_cpu_stop()
Message-ID: <689a793b-6931-42e1-afbe-d920e1b39228@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The multi_cpu_stop() contains a loop that can initially be executed with
interrupts enabled (in the MULTI_STOP_NONE and MULTI_STOP_PREPARE states).
Interrupts are guaranteed to be once the MULTI_STOP_DISABLE_IRQ state
is reached.  Unfortunately, the rcu_momentary_eqs() function that is
currently invoked on each pass through this loop requires that interrupts
be disabled.

This commit therefore moves this call to rcu_momentary_eqs() to the body
of the "else if (curstate > MULTI_STOP_PREPARE)" portion of the loop, thus
guaranteeing that interrupts will be disabled on each call, as required.

Kudos to 朱恺乾 (Kaiqian) for noting that this had not made it to mainline.

[ paulmck: Update from rcu_momentary_dyntick_idle() to rcu_momentary_eqs(). ]

Link: https://lore.kernel.org/all/1712649736-27058-1-git-send-email-quic_mojha@quicinc.com/

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index da821ce258ea7..8896d844d738f 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -250,8 +250,8 @@ static int multi_cpu_stop(void *data)
 			 * be detected and reported on their side.
 			 */
 			touch_nmi_watchdog();
+			rcu_momentary_eqs();
 		}
-		rcu_momentary_eqs();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);

