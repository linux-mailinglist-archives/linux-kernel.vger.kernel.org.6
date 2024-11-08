Return-Path: <linux-kernel+bounces-401475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 358109C1AE9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC4821F23476
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A001E32CB;
	Fri,  8 Nov 2024 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hhcP8+Wo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KFvBYwKh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB71C9EB9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062547; cv=none; b=N3wAVp0MLBRClTmD4qOJhTUqohZ+CXG2VJxv24ayZQYIBRVsMH0BCx5h/OiVlSvRFAJmDqNvr+1Yuyb9zDEx6nexIKbBSCgQxjecrRDfrE71qKwei2Sg4qDkN9vYICt+ESrAi6wNWGzMqHVSO0HWwNlUEUPv6jtR0FWlrT6P3fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062547; c=relaxed/simple;
	bh=07fZDXRaDdbifNMW16jTx+iBkICOz9AKdzdzRjzV52M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxS+FLRf6FOndKklLEys0xR5A8Mzw0pgMwsqlFIwGRDtK5Zu/btk6AyiBEruhxMxcZPnoaN6mMaRUufdxAlh1w6lto7JEZKcw2BTyIRu/W9XYsNQxV2JhMXk4IavUiql291mzmuRXh1hkrEFxlCgA44IfFc0wu2a1J0XzAsX18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hhcP8+Wo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KFvBYwKh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ7T3n9ji38bfDcEZMnrKQTiWeEv9uEaf9nIoN35Fps=;
	b=hhcP8+WoqQYG//gIZ0hHGdOdSyU2yj6omU1f7N5TVMdwHq2GbxdOEikXD6YyWgpRoXeyiy
	dLlWDR8Mnb0SccFh//hL0bR+W6vDt+fSiWqO7IjsrNA9Mik/wvg0YoqaWNNZhVvEMuQX2w
	3frFc2smwspd0i3FXDtJ5icHSdqxqc9zIlLPIuf7b0OmBAN3nmL/e1RearU3oZyaZ21muY
	kDYmRG5HpF9447N78GlGMvSlYTuHLO6b6pTL2fIjcZa9/hNcSOU2PX46X7XXtzWA6z0Voi
	Qs27evJIdEGul1EmaRMj8gaet8r1RlZS3qb6pnTF1iiheLiQLKsDwI6q3EYCCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731062543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hZ7T3n9ji38bfDcEZMnrKQTiWeEv9uEaf9nIoN35Fps=;
	b=KFvBYwKhT7evOVi+BwnX0Mn/HduihryDoCDR9Lz7a5rjCyAy9P1BX5rp+JCGEycl5yXTZ3
	4hHU0Jgn84MXGsBw==
To: kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Marco Elver <elver@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	akpm@linux-foundation.org,
	cl@linux.com,
	iamjoonsoo.kim@lge.com,
	longman@redhat.com,
	penberg@kernel.org,
	rientjes@google.com,
	sfr@canb.auug.org.au,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 2/4] scftorture: Wait until scf_cleanup_handler() completes.
Date: Fri,  8 Nov 2024 11:39:32 +0100
Message-ID: <20241108104217.3759904-3-bigeasy@linutronix.de>
In-Reply-To: <20241108104217.3759904-1-bigeasy@linutronix.de>
References: <20241108104217.3759904-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The smp_call_function() needs to be invoked with the wait flag set to
wait until scf_cleanup_handler() is done. This ensures that all SMP
function calls, that have been queued earlier, complete at this point.

Tested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 455cbff35a1a2..654702f75c54b 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -523,7 +523,7 @@ static void scf_torture_cleanup(void)
 			torture_stop_kthread("scftorture_invoker", scf_stats_p[i].task);
 	else
 		goto end;
-	smp_call_function(scf_cleanup_handler, NULL, 0);
+	smp_call_function(scf_cleanup_handler, NULL, 1);
 	torture_stop_kthread(scf_torture_stats, scf_torture_stats_task);
 	scf_torture_stats_print();  // -After- the stats thread is stopped!
 	kfree(scf_stats_p);  // -After- the last stats print has completed!
--=20
2.45.2


