Return-Path: <linux-kernel+bounces-362510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA26199B5C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180801C210C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF221993A9;
	Sat, 12 Oct 2024 15:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="psqyFlPY"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148111CA0
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745676; cv=none; b=s9IwB2/y+Gn/tzm41H2oaeqU6rBkJtNofkgAznbfiflI35CLw+Do37R+fmrzbd2gSBti+UwQ6SVov4tIjyca81F/LakKXtjC3mo9f6sAHGnLL5/uHeT/pZQ7LtzuAi2+vzKjHcOvaPRH1yavYGKQ6RRNzJFF0jyUrt3Ls0V4VOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745676; c=relaxed/simple;
	bh=ckf7/28sUSyUL6KBafdbgB55rq3fNWtpq0yAaoHfzLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6CMC81tMtAXBHymLkc8He+dJgB66E9tqrx56wJZpcJ1bZMrfgzDhFSnRN0bn7WsRVmDQ200Tj6s3dII6xqJ37KzuWaaRtvjIAWYoh76orsFaRbTqUfNH6bM5rRNY8PZjLZn/EqA4/Qzn3pZC01hMj8gHxHczMw0K605NsEgZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=psqyFlPY; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7FdV056324;
	Sat, 12 Oct 2024 10:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728745635;
	bh=NDMyxZPzrYRPkCPsqTcwywGY8k7U3keYr7b79HWcFDM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=psqyFlPYz+8q2mKvzoq/DTsIVNmqa/qKE1Kk17HupGDw3TS22tz6zUkBiuVXRRY5d
	 kMF3bS6RfHluzJmH9Qy6b/syAxV21R/Hm2uE7jcqCDLqbaY1mHH5tOpjMuagqLvEAd
	 Vltz7VBY26SBplJNWDTxweM4QongyvTMsZ3sZRK4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7FCx020072;
	Sat, 12 Oct 2024 10:07:15 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Oct 2024 10:07:14 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Oct 2024 10:07:14 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7EDB114725;
	Sat, 12 Oct 2024 10:07:14 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <sam@ravnborg.org>,
        <bparrot@ti.com>, <jcormier@criticallink.com>, <devarsht@ti.com>
Subject: [PATCH 2/2] drm/tidss: Avoid race condition while handling interrupt registers
Date: Sat, 12 Oct 2024 20:37:10 +0530
Message-ID: <20241012150710.261767-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241012150710.261767-1-devarsht@ti.com>
References: <20241012150710.261767-1-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

There is a possibility of a race condition between interrupt subroutine
which accesses the interrupt related registers to clear the statuses before
handling the interrupt and other functions such as display soft reset,
runtime resume/suspend etc which also access the interrupt related
registers.  To prevent such scenarioes, use a spinlock to serialize access
to interrupt related registers.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 4 ++++
 drivers/gpu/drm/tidss/tidss_irq.c   | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index b04419b24863..cec59deff015 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -2767,8 +2767,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
  */
 static void dispc_softreset_k2g(struct dispc_device *dispc)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&dispc->tidss->wait_lock, flags);
 	dispc_set_irqenable(dispc, 0);
 	dispc_read_and_clear_irqstatus(dispc);
+	spin_unlock_irqrestore(&dispc->tidss->wait_lock, flags);
 
 	for (unsigned int vp_idx = 0; vp_idx < dispc->feat->num_vps; ++vp_idx)
 		VP_REG_FLD_MOD(dispc, vp_idx, DISPC_VP_CONTROL, 0, 0, 0);
diff --git a/drivers/gpu/drm/tidss/tidss_irq.c b/drivers/gpu/drm/tidss/tidss_irq.c
index 604334ef526a..d053dbb9d28c 100644
--- a/drivers/gpu/drm/tidss/tidss_irq.c
+++ b/drivers/gpu/drm/tidss/tidss_irq.c
@@ -60,7 +60,9 @@ static irqreturn_t tidss_irq_handler(int irq, void *arg)
 	unsigned int id;
 	dispc_irq_t irqstatus;
 
+	spin_lock(&tidss->wait_lock);
 	irqstatus = dispc_read_and_clear_irqstatus(tidss->dispc);
+	spin_unlock(&tidss->wait_lock);
 
 	for (id = 0; id < tidss->num_crtcs; id++) {
 		struct drm_crtc *crtc = tidss->crtcs[id];
-- 
2.39.1


