Return-Path: <linux-kernel+bounces-293239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF531957C5C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 06:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8360B1F23F65
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2094D8C8;
	Tue, 20 Aug 2024 04:19:16 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEB92F5E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724127555; cv=none; b=JdtI8HQ7966X3g748AS42bQwfWX7/W51Eimj1T380P8geWtXHzvXVq7tx3Nb6AIjxJlz0QSV5oJNFqDbUMhoRQWiI+XQEF9faV3GyBAclT4v8hqHo3c9TCxMdmFezXVCVcKQKqssLGRFrWbgHddFBgfiZtZzif4rUSSwa6NhI10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724127555; c=relaxed/simple;
	bh=sh9LGBRjcIzsBHmnEb17Y4QMpv16xq1odAtJBr8Dvgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOO3EUnPlM3aXVLFRU9U+tYRLoS/2CKMEnk1RvB09ee1R7oKlW62244WF266p5WTBax5I7eDOTmC4TMJyQkdDHdB2dsTelm/2VpoWfBxS9j14YSntxtLVnzxmMOWDiRuWZJOpJcTsU0YnNdjjD2oYp+225t56y0CfjP7mbEcwZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE8661A20C3;
	Tue, 20 Aug 2024 06:19:06 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A62BE1A20BC;
	Tue, 20 Aug 2024 06:19:06 +0200 (CEST)
Received: from lsv031045.swis.in-blr01.nxp.com (lsv031045.swis.in-blr01.nxp.com [10.12.176.65])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ABC8A1802200;
	Tue, 20 Aug 2024 12:19:05 +0800 (+08)
From: nxf24178 <ravindra.yashvant.shinde@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:I3C SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	nxf24178 <ravindra.yashvant.shinde@nxp.com>
Subject: [PATCH] i3c: master: Remove i3c_dev_disable_ibi_locked(olddev) on  device hotjoin
Date: Tue, 20 Aug 2024 09:48:42 +0530
Message-ID: <20240820041842.3291130-1-ravindra.yashvant.shinde@nxp.com>
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


