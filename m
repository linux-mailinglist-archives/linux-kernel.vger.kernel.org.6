Return-Path: <linux-kernel+bounces-293247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CE0957C7E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6F71F24846
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB914C59C;
	Tue, 20 Aug 2024 04:38:26 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3D130E4A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128706; cv=none; b=K8+4Zj+STFri7rb///zSpXUAsHuvC4gVz9NU63eruSjW74aR5rVZbhkspveeGJgTLyjbMxfLfRAIYOM7hFdC6T4K1LXFeS2UyzG7DpEx6/+xnYafbL90K0PFh76rRxnbvMXk0BluTJj0Ophku1VoCylVyhWZbCoDjMIllEKDKaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128706; c=relaxed/simple;
	bh=sh9LGBRjcIzsBHmnEb17Y4QMpv16xq1odAtJBr8Dvgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDSakc2UorMt5bw8WJW9rq6Ps5hpZbm4wAszdpL/duROI5sTL2c9RogDim4R1UHT9ssG1TalDW0Fk2bNCqrGWm1uFj82q9Dk8FXGYVLHNBcRcFy5KEnHXHHYblNLTEHBfZvfsLFk76XK5w/ne8OR/ym3+fDhHD+ixi7mKJrRMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F336B1A20EF;
	Tue, 20 Aug 2024 06:38:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA0BA1A2113;
	Tue, 20 Aug 2024 06:38:22 +0200 (CEST)
Received: from lsv031045.swis.in-blr01.nxp.com (lsv031045.swis.in-blr01.nxp.com [10.12.176.65])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C2029183DC24;
	Tue, 20 Aug 2024 12:38:21 +0800 (+08)
From: nxf24178 <ravindra.yashvant.shinde@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank.Li@nxp.com,
	nxf24178 <ravindra.yashvant.shinde@nxp.com>
Subject: [PATCH] i3c: master: Avoid sending DISEC command with old device address.
Date: Tue, 20 Aug 2024 10:08:17 +0530
Message-ID: <20240820043818.3352614-1-ravindra.yashvant.shinde@nxp.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

When a new device hotjoins, a new dynamic address is assigned.
i3c_master_add_i3c_dev_locked() identifies that the device was previously
attached to the bus and locates the olddev.

i3c_master_add_i3c_dev_locked()
{
    ...
    olddev = i3c_master_search_i3c_dev_duplicate(newdev);
    ...
    if (olddev) {
        enable_ibi = true;
        ...
    }
    i3c_dev_free_ibi_locked(olddev);
    ^^^^^^^^
    This function internally calls i3c_dev_disable_ibi_locked(addr)
    function causing to send DISEC command with old Address.

    The olddev should not receive any commands on the i3c bus as it
    does not exist and has been assigned a new address. This will
    result in NACK or timeout. So, update the olddev->ibi->enabled
    flag to false to avoid DISEC with OldAddr.
    ...
}

Signed-off-by: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
---
 drivers/i3c/master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42..07ccb2c00074 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2042,6 +2042,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 			if (olddev->ibi->enabled) {
 				enable_ibi = true;
 				i3c_dev_disable_ibi_locked(olddev);
+				olddev->ibi->enabled = false;
 			}
 
 			i3c_dev_free_ibi_locked(olddev);
-- 
2.46.0


