Return-Path: <linux-kernel+bounces-285511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C89950E57
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979181C23562
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167C1A7078;
	Tue, 13 Aug 2024 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Z3yWk6yq"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829821A76C2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723583205; cv=pass; b=ZTAbHv8GHnIOnbzRQYBi4WATM+8womXOeD/YArX9sl/zlMcUJaNOgLqSQsB+i4ZiiwpmZ5c5XjlOKSASD8NvvnuP3af6NDeq294YpqITojZtJjFdfLNklbueG2UdQg9RGnzlIAxi6duoNczB9ZROFdMF+zfOhcrJWA/P/W0EOVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723583205; c=relaxed/simple;
	bh=5WY3+gNhVO7XvYfdKyFpik6KpYa2KreAwq1robbCMKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7iurh+t55JCRGeuxO2S/4mUY4z951lQSZhvKOhA5L7j2z/0s7WJTD5Ue6G9WZC6SVKJHL8IBpDgs9XYgZg+dY1BWZ1ZxkxThtDy5o+HTFxVaDw9qTDHegj1Qen84JUR5Z/Z4+9kzJpUq/tiKB0M/rROKfMFuLepilEI3ihiZ9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Z3yWk6yq; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723583201; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VnhcDQrue3RoMgzcjWqERjSwPlGQqRmnyjLwdvp0Nm1YU40GLmHLnLMQqVhmSRrbFnPs3QhsjYrWrftwzbcpDsGg2+i8dbd2jV7kISJfuP0Lzzmxu2Gxlr5WH+l74nKl0ekYZgkwyJVZSL3OTJ2fsGe5ylgGUSd0vylmAmykJ4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723583201; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PCQWaHskTaBykjAdT2PUbBbFw9GDVrxCBS6/qxN19Uc=; 
	b=PKTePiWQoW/0GjqNlIVWN7ylmfFmrVFT9Iq9nMTqhUKm+wPUc0civIizI7mQcfmYuYPvYjH/ynWC+SSQTl77k2bOpRHJp1oSXIX2Ywok9Jqwf5UCpS8JmdLgVw7UooK/7WbCqmZkH3QIaxuxN3mVxVytBJZQ4n3P1gat98MCHzg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723583201;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PCQWaHskTaBykjAdT2PUbBbFw9GDVrxCBS6/qxN19Uc=;
	b=Z3yWk6yqcR3csH5BCEpmG9AzWOsuLrLvGJEnChWKt01J/z42F/oN5lmMtcVRLSxs
	/RZ050rShb8+MtlZnMIsn+CkeDkjYT8GAFzYhMbzG83TzyL2jpys+a2a3Y0qhLiBp9v
	yRkKxt8JyA7xr4MWlZzL0/dG5cLkkgVtfSmgz4g4=
Received: by mx.zohomail.com with SMTPS id 1723583199756876.345562240049;
	Tue, 13 Aug 2024 14:06:39 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] drm: panthor: add debugfs knob to dump successful jobs
Date: Tue, 13 Aug 2024 18:05:47 -0300
Message-ID: <20240813210555.607641-6-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813210555.607641-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240813210555.607641-1-daniel.almeida@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

It can be advantageous for userspace to have access to successful jobs.

Allow this as an opt-in through a debugfs file.

Note that the devcoredump infrastructure will discard new dumps if a
previous dump hasn't been read. A future patch will add support for
multi-job dumps which will work around this limitation.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index afd644c7d9f1..ea2696c1075a 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -10,6 +10,7 @@
 
 #include <linux/build_bug.h>
 #include <linux/clk.h>
+#include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dma-resv.h>
@@ -317,6 +318,9 @@ struct panthor_scheduler {
 		 */
 		struct list_head stopped_groups;
 	} reset;
+
+	/** @dump_successful_jobs: whether to dump successful jobs through coredumpv */
+	bool dump_successful_jobs;
 };
 
 /**
@@ -2946,6 +2950,16 @@ queue_run_job(struct drm_sched_job *sched_job)
 	queue->iface.input->extract = queue->iface.output->extract;
 	queue->iface.input->insert = job->ringbuf.end;
 
+	if (sched->dump_successful_jobs) {
+		struct panthor_core_dump_args core_dump_args = {
+			.ptdev = ptdev,
+			.group_vm = job->group->vm,
+			.group = job->group,
+		};
+
+		panthor_core_dump(&core_dump_args);
+	}
+
 	if (group->csg_id < 0) {
 		/* If the queue is blocked, we want to keep the timeout running, so we
 		 * can detect unbounded waits and kill the group when that happens.
@@ -3609,5 +3623,8 @@ void panthor_sched_debugfs_init(struct drm_minor *minor)
 	struct panthor_device *ptdev =
 		container_of(minor->dev, struct panthor_device, base);
 	struct panthor_scheduler *sched = ptdev->scheduler;
+
+	debugfs_create_bool("dump_successful_jobs", 0644, minor->debugfs_root,
+			    &sched->dump_successful_jobs);
 }
 #endif /* CONFIG_DEBUG_FS */
-- 
2.45.2


