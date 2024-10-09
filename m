Return-Path: <linux-kernel+bounces-357912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA59977B6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861ED1C223A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099AF1E3784;
	Wed,  9 Oct 2024 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap9e1dD1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD261E32C6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 21:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728510256; cv=none; b=TfevxDcsTvmohUW/8M+sXLsOolqW10GMWS75tGBFmFBVEzQiawZQ6jekfJdt9REarupu9Txo4/JOFqvljFdlNVOV4sK1dCERzwbqS3dg1tRwaieMYg52gu/10xMxbP/rzfHB8kWiOObf4MjZP0dCRLoL2h5M46D4nBOiBDkbUWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728510256; c=relaxed/simple;
	bh=s5qTXQtVFpk+x6KiDn1XYEAQkvcRk82S5eUjt2mMXMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWRAVV1T4rZKrOENC1tLk4fH6ue1K02xpmh12BhpyXdhSct7nobFNNXK7Ju/NfOVX+aXMiyi39Yq4GPfRg6dmN38i5h+i4dWv55f5i+W62MXwcMlDhYeCgQTFjJMjnFHrJM3f4UgMWbopsjUIAtNOxngroSWzcfF4tl9sW+Apsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap9e1dD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC864C4CEC3;
	Wed,  9 Oct 2024 21:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728510256;
	bh=s5qTXQtVFpk+x6KiDn1XYEAQkvcRk82S5eUjt2mMXMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ap9e1dD1sKTO7BFz4uJyPpMqs5tSY5/bzO/4jXpyFun6wm8DXtistIPXBDMupVPTd
	 1dGPzPx7LcOKLmfDjwu/R+Ro/NkgFAA5sddeVf0QgHrFNvOc82lEEeYy/xMJ5BZSCR
	 +UfW0QP4JH0KBAj7F8LnD+npLY8aqxVk6Olv8r6F0W9SBetSblXhwNpF4c2CXUyDXy
	 9cVmi48sjYXNiQPmevjczTqOySHUMOWxa/KdehOtblJHiABJHlbkmUvnPFJDlrwwLR
	 nbDPtFoD8hrmpihqy0v6fAqhCL++TLCgVqQlU1DHyy8cB58oKIVEFThT4o/0PLbCCR
	 TtzwIck8TwK+A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com
Cc: kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	sched-ext@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/6] sched_ext: Start schedulers with consistent p->scx.slice values
Date: Wed,  9 Oct 2024 11:40:58 -1000
Message-ID: <20241009214411.681233-3-tj@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009214411.681233-1-tj@kernel.org>
References: <20241009214411.681233-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The disable path caps p->scx.slice to SCX_SLICE_DFL. As the field is already
being ignored at this stage during disable, the only effect this has is that
when the next BPF scheduler is loaded, it won't see unreasonable left-over
slices. Ultimately, this shouldn't matter but it's better to start in a
known state. Drop p->scx.slice capping from the disable path and instead
reset it to SCX_SLICE_DFL in the enable path.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index e08cfba33cb4..7d2fa78ba0c9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4473,7 +4473,6 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		p->scx.slice = min_t(u64, p->scx.slice, SCX_SLICE_DFL);
 		__setscheduler_prio(p, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
@@ -5190,6 +5189,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
+		p->scx.slice = SCX_SLICE_DFL;
 		__setscheduler_prio(p, p->prio);
 		check_class_changing(task_rq(p), p, old_class);
 
-- 
2.46.2


