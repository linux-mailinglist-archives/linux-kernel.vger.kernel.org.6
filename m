Return-Path: <linux-kernel+bounces-362511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ADE99B5C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5969284226
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 15:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C7119B3CB;
	Sat, 12 Oct 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Err1FrX8"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CB1714A1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728745677; cv=none; b=l4R+PSvaZFa8QXfH0REGAcj5y6j/I7uiR2RPJPYzqcjEbGAypWAIK3HBE3RL0w+/iutzRcYjL12tlUT6rJHzQIwpEvt/7RH60D5plmjc8XnM97poIuJBKqDr7VZiEZwSBYuDRBgFcQ6E/HF4yKsrbgvIfBAEnmKACB20cBZpS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728745677; c=relaxed/simple;
	bh=sL9pu2NAFiu4R79SV3OoWwbl1t9d+s5p6Nr/2e1nXwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViO5mUSvOBkofMfagL/abzkXEe8pnbme3YIitwY3834bKMY4uKy5MttZ1GkyQY0+pHB3PG6x2hXLjUZYeuJSr/RfJ3JvK3e+E8GOr+92YsOWi9icFQj0kewfbP8m6jMGftwZbtcX9Xx02MvihdK6GjaMiLvOJmjPyYSpr9aDcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Err1FrX8; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7ET0056320;
	Sat, 12 Oct 2024 10:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728745634;
	bh=DFrowa/lRkObQyt3XVRqE/xAlxLVA1L+zikIaNZbF4k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Err1FrX8cRE5U3MTNSE6V806LQ4H4O9JtEmeGWP7K+VKwrwyX85PQCYXiXwEfcBZL
	 jc079+Paok4msDA/xaXI74oRZbeOrl2d/K3Zg3IGZAV0JiOlr48hgMNEleXVaWXzYk
	 oA5W42TOP53sPZIW4DAWGub+IlUGTKWKLP3k6KI0=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49CF7Ec2019370
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 12 Oct 2024 10:07:14 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 12
 Oct 2024 10:07:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 12 Oct 2024 10:07:13 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49CF7CL6030314;
	Sat, 12 Oct 2024 10:07:13 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: <jyri.sarha@iki.fi>, <tomi.valkeinen@ideasonboard.com>,
        <airlied@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>, <simona@ffwll.ch>,
        <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <aradhya.bhatia@linux.dev>,
        <s-jain1@ti.com>, <r-donadkar@ti.com>, <sam@ravnborg.org>,
        <bparrot@ti.com>, <jcormier@criticallink.com>, <devarsht@ti.com>
Subject: [PATCH 1/2] drm/tidss: Clear the interrupt status for interrupts being disabled
Date: Sat, 12 Oct 2024 20:37:09 +0530
Message-ID: <20241012150710.261767-2-devarsht@ti.com>
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

It is possible that dispc_{k2g/k3}_set_irqenable can be called for
disabling some interrupt events which were previously enabled. However
instead of clearing any pending events for the interrupt events that are
required to be disabled, it was instead clearing the new interrupt events
which were not even enabled. 

For e.g. While disabling the vsync events, dispc_k3_set_irqenable tries to
clear DSS_IRQ_DEVICE_OCP_ERR which was not enabled per the old_mask at all
as shown below :

"dispc_k3_set_irqenable : irqenabled - mask = 91, old = f0, clr = 1" where
clr = (mask ^ old_mask) & old_mask

This corrects the bit mask to make sure that it always clears any pending
interrupt events that are requested to be disabled before disabling them
actually.

Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform Display SubSystem")
Reported-by: Jonathan Cormier <jcormier@criticallink.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 1ad711f8d2a8..b04419b24863 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -700,8 +700,8 @@ void dispc_k2g_set_irqenable(struct dispc_device *dispc, dispc_irq_t mask)
 {
 	dispc_irq_t old_mask = dispc_k2g_read_irqenable(dispc);
 
-	/* clear the irqstatus for newly enabled irqs */
-	dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & mask);
+	/* clear the irqstatus for irqs that are being disabled now */
+	dispc_k2g_clear_irqstatus(dispc, (mask ^ old_mask) & old_mask);
 
 	dispc_k2g_vp_set_irqenable(dispc, 0, mask);
 	dispc_k2g_vid_set_irqenable(dispc, 0, mask);
@@ -843,8 +843,8 @@ static void dispc_k3_set_irqenable(struct dispc_device *dispc,
 
 	old_mask = dispc_k3_read_irqenable(dispc);
 
-	/* clear the irqstatus for newly enabled irqs */
-	dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & mask);
+	/* clear the irqstatus for irqs that are being disabled now */
+	dispc_k3_clear_irqstatus(dispc, (old_mask ^ mask) & old_mask);
 
 	for (i = 0; i < dispc->feat->num_vps; ++i) {
 		dispc_k3_vp_set_irqenable(dispc, i, mask);
-- 
2.39.1


