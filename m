Return-Path: <linux-kernel+bounces-271959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C494556C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B23A285FD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23796175AE;
	Fri,  2 Aug 2024 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVEKpVvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60484EAE7;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558868; cv=none; b=Z59PlDOJ22A00U7lz2uaTgUJMtxkO/oMnIHlN1wN563S523aWB7D6kgbeqGHk7nGdPzxqfY8rBk5qyca89xd1+xSrFkVpg6DTrW95GN6QU2U96IVE38sci+lPCTaZOdWS75sMNEU/SoXxP3u3w/OTAalIznKjNpjqOYvqQ1EZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558868; c=relaxed/simple;
	bh=WbIoVnZfKmvIceCjC2LaFnl97Erf9A6epdp+H3kywvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2iCfO0JUHRw8n2XX60BblgknQUUP3QwLCC18VEZCnCg5nrhiNCfvclfg32c1LgxbrxtNdps7kaPw9e/eVHJK4sfXAUS0NmMUdzgXOXzeFjxYGQ/jjhzWCMyNQbSMDSMaWN84i5i+rMO6lIblpff3HIf18tZCv6FWFTKS/6oHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVEKpVvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40591C4AF0C;
	Fri,  2 Aug 2024 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558868;
	bh=WbIoVnZfKmvIceCjC2LaFnl97Erf9A6epdp+H3kywvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nVEKpVvvg1cQbbjIiMOXTZ9+2q8cAN1JFDoSL6ukgX3omie260BGMTRNksBplWz4F
	 WyiPcaURRaQsPMRFJnyXjhHxpz1RMyQU4FpODAK57QC2cyZTiQ8NVTysmx/YR9h8+R
	 iFq+j+YW0pyZAPMZymFOrI1Ss0kM92epB52ONy+t/W/v1PLG0ELMhh8yd9irX2GZK1
	 RrZK4LsN/IISztHARodvjjKCgeDLjndOI+jPyP025eBsDfhQFMbvwRqxisO+dlAMt5
	 tvkkCdkcqOu927Vcyqg/voc2FNejqHMW/Jrm24D5SPmbhWtB6lP4DdLM4lkbQ8zegO
	 rEx99LgA/8aLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id E478BCE0A01; Thu,  1 Aug 2024 17:34:27 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/6] rcu/tasks: Update rtp->tasks_gp_seq comment
Date: Thu,  1 Aug 2024 17:34:22 -0700
Message-Id: <20240802003426.4134196-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
References: <41c68c6b-2c55-4c2d-ab70-f2a5b38eb374@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtp->tasks_gp_seq grace-period sequence number is not a strict count,
but rather the usual RCU sequence number with the lower few bits tracking
per-grace-period state and the upper bits the count of grace periods
since boot, give or take the initial value.  This commit therefore
adjusts this comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d473846a572aa..cf273c554f3b0 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -64,7 +64,7 @@ struct rcu_tasks_percpu {
  * @init_fract: Initial backoff sleep interval.
  * @gp_jiffies: Time of last @gp_state transition.
  * @gp_start: Most recent grace-period start in jiffies.
- * @tasks_gp_seq: Number of grace periods completed since boot.
+ * @tasks_gp_seq: Number of grace periods completed since boot in upper bits.
  * @n_ipis: Number of IPIs sent to encourage grace periods to end.
  * @n_ipis_fails: Number of IPI-send failures.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
-- 
2.40.1


