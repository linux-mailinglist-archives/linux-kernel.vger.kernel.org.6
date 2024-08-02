Return-Path: <linux-kernel+bounces-271979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AB1945592
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CC2D1F211C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000F171B3A;
	Fri,  2 Aug 2024 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDsEbP/A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323936A039;
	Fri,  2 Aug 2024 00:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558985; cv=none; b=PFFp+Rp2I4/S7GfwJx97M77+CmkWBOs0Tw/NneAXPyMNNZGjIa4mecoSVNSOIjzAfusMri3e3Iq4nx56mnFzrTdncxwfzwYTU32AIBHyb6YyVQVzN6g0RkUBdYFfmP9fZ/M7rvsfk9dgKi4J0vIkMzQpf6oNMFBQdpi1+8K1S7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558985; c=relaxed/simple;
	bh=jUOhqC2ZBiCXEZk0Hbd+1a83Wsy5c92Bk1JJhWuEWyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMGW18DW2Rg8ci8LAlXth41OvOUl37U20VrWH5BYSRFR0COM2hx2jJ34xYSc9XutCJkr7grE6+XtvwcoUjoqf0IwJpK2OtEfVI5h4aWrsHAA4e1pOStA+RePV9gakwHUBVvcY4iRivzLvktdsOmIRhsvnEfnWfH+EF1lg9Fjbz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDsEbP/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2165C4AF0E;
	Fri,  2 Aug 2024 00:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558984;
	bh=jUOhqC2ZBiCXEZk0Hbd+1a83Wsy5c92Bk1JJhWuEWyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dDsEbP/Ab8Xey4uj3AEXqFaGKs5Y1EFVXaP5sIONWTyk9VJkZdkEFF26Nr4vuPf8U
	 nu9eydpKqbbrqYAhRkco4x9Y5gLLvdcVMxHFHwAaQJ99G6ANqkvg3516mCiNXdgcEd
	 HVk8goDBEos134F5+TVIY1JgqQpk75u7ktRQ1prEsMHzZvJwNqMR8PpV7RkNwFVNAD
	 ttcSPwulPrTvH57eJsLx/+sc1YdhxSXD7Rx5qQMge7yvLogQLdPVaJ/gknoBAGLPZf
	 Z4NHpTIyIzzaIfMnskfskttb7iRg5du8DT94pPTJkkdTOAG8ZFPZgjXIkyUk6pPyJe
	 81GSfd9fA3hvA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7AC28CE0A01; Thu,  1 Aug 2024 17:36:24 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 2/2] srcu: Mark callbacks not currently participating in barrier operation
Date: Thu,  1 Aug 2024 17:36:22 -0700
Message-Id: <20240802003622.4134318-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7f2dd4bf-525d-4348-bf1d-c5c1c6c582b0@paulmck-laptop>
References: <7f2dd4bf-525d-4348-bf1d-c5c1c6c582b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SRCU keeps a count of the number of callbacks that the current
srcu_barrier() is waiting on, but there is currently no easy way to
work out which callback is stuck.  One way to do this is to mark idle
SRCU-barrier callbacks by making the ->next pointer point to the callback
itself, and this commit does just that.

Later commits will use this for debug output.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index d3fdaeba0c10d..50508c9605791 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -140,6 +140,7 @@ static void init_srcu_struct_data(struct srcu_struct *ssp)
 		sdp->srcu_cblist_invoking = false;
 		sdp->srcu_gp_seq_needed = ssp->srcu_sup->srcu_gp_seq;
 		sdp->srcu_gp_seq_needed_exp = ssp->srcu_sup->srcu_gp_seq;
+		sdp->srcu_barrier_head.next = &sdp->srcu_barrier_head;
 		sdp->mynode = NULL;
 		sdp->cpu = cpu;
 		INIT_WORK(&sdp->work, srcu_invoke_callbacks);
@@ -1565,6 +1566,7 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 	struct srcu_data *sdp;
 	struct srcu_struct *ssp;
 
+	rhp->next = rhp; // Mark the callback as having been invoked.
 	sdp = container_of(rhp, struct srcu_data, srcu_barrier_head);
 	ssp = sdp->ssp;
 	if (atomic_dec_and_test(&ssp->srcu_sup->srcu_barrier_cpu_cnt))
-- 
2.40.1


