Return-Path: <linux-kernel+bounces-295693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4739D95A026
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B40B242CB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89021B1D4A;
	Wed, 21 Aug 2024 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JEclViUo"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4B01B1D54
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724251165; cv=pass; b=L2Q2xGvvjgn/+Qh+EkIXKrDebdqkTwtdYNKg9c1j2GXRDyVivKJ8+G6uxKLZHgHEQV9+EpsQB7EYsBN9XepId5K9oDdWbrpLSnnCoz1RfmC6KeOgxm2wRLcW89GLL1tmdWFQbW83nyOLsbuUIspg5wIbugiWvyUnFxHd10CSbhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724251165; c=relaxed/simple;
	bh=5WY3+gNhVO7XvYfdKyFpik6KpYa2KreAwq1robbCMKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHmyp9zKmruA0mFC5zhU6MXpAsgn84VVTwZY3DI8WRlchp6qab8RkXjQ++PoIiY8O2n55rj21TGfYmKAMXkzCow8vOuGl+C0tTV2hj7UYGw+ZsVmuqj8sYJIb3uX6n7rxB8C3E3Clt/9U2V09pJrp6MFpwzm2YjcDXD+U+Txc1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JEclViUo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: boris.brezillon@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724251156; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O8cn80QB488S0hspsD2N8iSIc7nblvantThsQYfOTt5e8kO9WMEE6biVCNPZUfvhMK7s4ZyEpvA67k2Brfw9fcM1tt4/lOGyjSjJAEmZtDfjLMJvoZxHWDIANC250FrLo+xv2nnbv9osR0GeCbrWH0fJE+4fKqEcQNQ8JgVeoHE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724251156; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PCQWaHskTaBykjAdT2PUbBbFw9GDVrxCBS6/qxN19Uc=; 
	b=ktg2D90Zx+fb2Jgif6jVIuH4+gP6k/gefr2yk+qpO79MrYfFfN3AhMZafQG4PcpgQypHe+pO6zWkc/IAUUxaPeRr+YiegpNqZ9krRVfQRiesnkz+iUT/rqTEF8gbuVRjftCnbiv3UaOeXL3bgFgDWtFfhIBHV5GdlUrdlLGeIG8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724251156;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PCQWaHskTaBykjAdT2PUbBbFw9GDVrxCBS6/qxN19Uc=;
	b=JEclViUo3WR9O+C0gY/QCSDrjvBG0k44yqOSJ/q7XtNnZFNqXAtY8LXgYYl8+qcY
	Sg2Es1IkE02R1mR6/b2YyordUghelPCdvjkotxZMESrBZ25hhMDJSh1t2uTpaoGcnHa
	VZDz+o0I0dtDA7U3Rngp7FuBUFHsKSizZbioll1s=
Received: by mx.zohomail.com with SMTPS id 1724251153593788.1214301888147;
	Wed, 21 Aug 2024 07:39:13 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
To: liviu.dudau@arm.com,
	steven.price@arm.com,
	carsten.haitzler@arm.com,
	boris.brezillon@collabora.com,
	robh@kernel.org,
	faith.ekstrand@collabora.com
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v2 RESEND 4/5] drm: panthor: add debugfs knob to dump successful jobs
Date: Wed, 21 Aug 2024 11:37:30 -0300
Message-ID: <20240821143826.3720-5-daniel.almeida@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821143826.3720-1-daniel.almeida@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <20240821143826.3720-1-daniel.almeida@collabora.com>
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


