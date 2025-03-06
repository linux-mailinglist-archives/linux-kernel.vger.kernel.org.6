Return-Path: <linux-kernel+bounces-549781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6797FA55735
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B1B3AB016
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B470827291D;
	Thu,  6 Mar 2025 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujJIvMiR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C28221570
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291203; cv=none; b=qZXlCVhFSFBqXujCSH2iW6m5kBZaNi50KWVGzIl/8FylALAVp3t9Gf+saKOsYZjTN6Y9SIgNe0pmk4U1/+028OPt/WooQunCFgO4s9alS0vvqNlOesBOQ4iarSbJiCWVgKz4cUf9fOdinTbx23qLwbEXaGwzkH7GdKoKxakF+mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291203; c=relaxed/simple;
	bh=CGu5XrruTaOTWbm+H8SU4/LST9GYJ3CBnT53RdCtMCo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kv0PHlCH4jRcu7dTh+OS36A3+T/TsQJfeBwkoM0uYn95Gqldx7kD78tNni5EjTrMYE/kmrTe/+Bo0xnyiWd/ybWTN/5vrABj/yO3wqknGfXa91CKvmQL+CNiIBmlLOl8r1aq1e6hiZY33Pz6w20tTxJB8kvbyBAWSIVZCtBspHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujJIvMiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992E7C4CEE0;
	Thu,  6 Mar 2025 20:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741291202;
	bh=CGu5XrruTaOTWbm+H8SU4/LST9GYJ3CBnT53RdCtMCo=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=ujJIvMiRCwg43DdCgvoXborsFW6ccPLXvstqOQDcaVVADB9Id894sd34tIrE7iQbe
	 9sYH5XQDxM3+Wpwy0857u1R0vQWEc52tPgQvgtGoNKRN6Oo1Y4yIsuIcOdo3JJ1TnL
	 28NRoPTW0dOchpxkc7gmQDnYskRaT+p8DkZagtUJo7mLw/8licTrt3PFF/1VtjqoJ1
	 4Wclm+u0/w0VOpb5wZp0dn5LTzqkt6ZshipCacepjNJD1t3sHaYfaI8W0T5T9Eqfla
	 dqpF/i1Xgqy6Al4bT8utXGkVRrZx6gdbQr2eLfRaRxR00fOiN4l8JqqJ+CZuPe46KL
	 2ELLR1x1/KyxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 28F70CE1163; Thu,  6 Mar 2025 12:00:02 -0800 (PST)
Date: Thu, 6 Mar 2025 12:00:02 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, vschneid@redhat.com, neeraj.upadhyay@kernel.org,
	frederic@kernel.org, kernel-team@meta.com
Subject: [PATCH] stop-machine: Add comment for rcu_momentary_eqs()
Message-ID: <9d3f4116-db64-43fb-85f1-0b939038206e@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a comment to explain the purpose of the rcu_momentary_eqs() call
from multi_cpu_stop(), which is to suppress false-positive RCU CPU
stall warnings.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/87wmeuanti.ffs@tglx/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 stop_machine.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 8896d844d738f..5d2d0562115b3 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -250,6 +250,7 @@ static int multi_cpu_stop(void *data)
 			 * be detected and reported on their side.
 			 */
 			touch_nmi_watchdog();
+			/* Also suppress RCU CPU stall warnings. */
 			rcu_momentary_eqs();
 		}
 	} while (curstate != MULTI_STOP_EXIT);

