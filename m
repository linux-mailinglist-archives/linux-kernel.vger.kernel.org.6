Return-Path: <linux-kernel+bounces-294229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2DC958AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5349D1F22399
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9D71922EB;
	Tue, 20 Aug 2024 15:19:32 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B22192B77
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167171; cv=none; b=mQoV8lQGhbI0D3mCt6IZOOpvabu5VL6/3syNXZDT6gdwmmVUAgXKwigYbfErg9IfGlGuh1xpsyzQLhyiDdxhqVe58+VuCRjhgQVidRRmPpQLgOdUHQHfEQwFefxricVJRdKBNv1kBPfQxhW6iXE42mypSDrraVeU27bSY6OdDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167171; c=relaxed/simple;
	bh=4ZSbEPkGcVOGkcexJeI5QRnfgiJYK5jAAtudTsXc+y8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HEJzk1oeiy7JHgibvJZeY5k8aS6b46imGaX+9wLHqciRbgBYaTwaF4Fyoe4edFi5fhnwfLvLcR2T06VzDbl4PCmaIrWIRRM6S23T5uS0ub7R5ta3KRC9iLhZrk7+JVPxjpIw5oVkM/cei6mI0rEBKzeVHncmCvJwQMEOAnYia34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 53F1F2023DB;
	Tue, 20 Aug 2024 17:19:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AC4762023D2;
	Tue, 20 Aug 2024 17:19:22 +0200 (CEST)
Received: from lsv031045.swis.in-blr01.nxp.com (lsv031045.swis.in-blr01.nxp.com [10.12.176.65])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 250911802200;
	Tue, 20 Aug 2024 23:19:21 +0800 (+08)
From: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	Frank.Li@nxp.com,
	Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
Subject: [PATCH v2 1/1] i3c: master: Avoid sending DISEC command with old device address.
Date: Tue, 20 Aug 2024 20:49:17 +0530
Message-ID: <20240820151917.3904956-1-ravindra.yashvant.shinde@nxp.com>
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
change from v1 to v2
- Fixed the author name.
- Unconditional set to the false & added some comments.
---
 drivers/i3c/master.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7028f03c2c42..0dd8d1c28d58 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2043,7 +2043,14 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 				enable_ibi = true;
 				i3c_dev_disable_ibi_locked(olddev);
 			}
-
+			/*
+			 * The olddev should not receive any commands on the
+			 * i3c bus as it does not exist and has been assigned
+			 * a new address. This will result in NACK or timeout.
+			 * So, update the olddev->ibi->enabled flag to false
+			 * to avoid DISEC with OldAddr.
+			 */
+			olddev->ibi->enabled = false;
 			i3c_dev_free_ibi_locked(olddev);
 		}
 		mutex_unlock(&olddev->ibi_lock);
-- 
2.46.0


