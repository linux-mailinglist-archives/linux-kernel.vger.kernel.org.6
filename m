Return-Path: <linux-kernel+bounces-289132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FAC954250
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E272CB26FD8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BDC12F38B;
	Fri, 16 Aug 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbTgVMrZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73912D742;
	Fri, 16 Aug 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723791881; cv=none; b=clNNyZvOrhecsmyEBDXjD0YvwU8bQkIxL8jDIVc/jd0Its9x63CyrbCszeNqc4q6cxmUD1O5j/Jpsu9aaV6qWnH6mtpS8QME4z7tB8sLFb3mjsif7dQ49qs00e+7dC0ePOx348uTIfnjztv91snSiipuOlEJ08KR/OJNjyfaOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723791881; c=relaxed/simple;
	bh=7kERyCASbzE1YDDe0Of+LxZ9CqXpNEA+iRkLzJTLXbs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fZYCSbwdpmE86m7Q0Dvj4dbpfSZ1n5tlzoADDBYaGxsfYkJ8wTfUrR3L3bOsa2QLk54p/qDRNJRbTYd5Gz0qdSKupHuPowgqUr547JgfoqnjR6sRd0mvU9V8VnN/KB/P0D/PivCD91UgVXpiwali7khNN82udZTxN9qlcoNs/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbTgVMrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898F6C4AF09;
	Fri, 16 Aug 2024 07:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723791881;
	bh=7kERyCASbzE1YDDe0Of+LxZ9CqXpNEA+iRkLzJTLXbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UbTgVMrZDZTvbPIShvdWAXng721tYqKsA+GQ6ionUflthr2pdv7MW7rPxya61xiyc
	 1WsWHXMhrS3j5RcAuOOs5VWXQ7esNYJjRbwbB5uAlbNms2R/DrHMakHtko6YKOdQa4
	 Fjr7zUie1tiukMCntgEQfTrsxUxcQzx0+ifRdiLmzQOIStQz3Bqxe3srcyQ547a19n
	 tSnysHHIQ/3PqB4EymmS0VQGF8mR39E+MEl4UWkXozML6NmA7yB2T9eK5kn/qbyX0h
	 Ab451v/xfevi3W8lNHekYnyDX0lAskKqSTTGMeRQaqMxJlDTpd/86xHT4QHlpDQKiZ
	 j5ctei/zpeMHg==
From: neeraj.upadhyay@kernel.org
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	paulmck@kernel.org,
	neeraj.upadhyay@kernel.org,
	neeraj.upadhyay@amd.com,
	boqun.feng@gmail.com,
	joel@joelfernandes.org,
	urezki@gmail.com,
	frederic@kernel.org
Subject: [PATCH rcu 08/14] rcuscale: Provide clear error when async specified without primitives
Date: Fri, 16 Aug 2024 12:32:50 +0530
Message-Id: <20240816070256.60993-8-neeraj.upadhyay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240816070209.GA60666@neeraj.linux>
References: <20240816070209.GA60666@neeraj.linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if the rcuscale module's async module parameter is specified
for RCU implementations that do not have async primitives such as RCU
Tasks Rude (which now lacks a call_rcu_tasks_rude() function), there
will be a series of splats due to calls to a NULL pointer.  This commit
therefore warns of this situation, but switches to non-async testing.

Signed-off-by: "Paul E. McKenney" <paulmck@kernel.org>
Signed-off-by: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
---
 kernel/rcu/rcuscale.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index c507750e94d8..79e1c32d5c0f 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -525,7 +525,7 @@ rcu_scale_writer(void *arg)
 			schedule_timeout_idle(torture_random(&tr) % writer_holdoff_jiffies + 1);
 		wdp = &wdpp[i];
 		*wdp = ktime_get_mono_fast_ns();
-		if (gp_async) {
+		if (gp_async && !WARN_ON_ONCE(!cur_ops->async)) {
 retry:
 			if (!rhp)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
@@ -597,7 +597,7 @@ rcu_scale_writer(void *arg)
 			i++;
 		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-	if (gp_async) {
+	if (gp_async && cur_ops->async) {
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max + 1;
-- 
2.40.1


