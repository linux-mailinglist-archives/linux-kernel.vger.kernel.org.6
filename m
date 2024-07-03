Return-Path: <linux-kernel+bounces-240120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D65B8926946
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 22:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850831F25FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 20:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB7418F2F6;
	Wed,  3 Jul 2024 20:04:09 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5302D18E776
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720037049; cv=none; b=uLvtve0glBjuYBdT8BCZkM+Xc9db2ySIyqeft350wc9/A/Z2USs6EzWRL3WzfkTNZ1RpI2nKhUm+L3XgyS0gRMKobWf7WgLQ2fDUH6XBUzHsNz0mrGWeqs4krn2psbix1qE2Kjv6E51y8bVFlld1X+veeSkv9PziAAhjAOXOzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720037049; c=relaxed/simple;
	bh=3fgH0XWHG36FswiOG62ZLmozfTPobvKWy+M5PTfoOHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VzRV1uZnuEF6mA7FlqZkPrziTLjhBRs6FKpC137QX0QIF3mPamVeV5AXq+DRowekHc7Te9mymCn9btL53u2OXesyOnsIReAQwUjr900hd/CQQfuvG3XY4+NhH60CgMKBshCW1k4IMZmut0nNbhLD04bZ/eikWZ7IpXHBJII2o7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp80t1720036976t7hj17pi
X-QQ-Originating-IP: w7kLUGn3+OAwjLKXRoNA/5hdg2gjbxR4tC64VJOBRHM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 04 Jul 2024 04:02:54 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9036598913565450035
From: WangYuli <wangyuli@uniontech.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	guanwentao@uniontech.com,
	huanglin@uniontech.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v3] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Thu,  4 Jul 2024 04:02:50 +0800
Message-ID: <342CA313D86762A1+20240703200250.218225-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 10 hours, there is a
20% chance that a nvme disk will not wake up until reboot.

Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5..1e0991667453 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2903,6 +2903,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 30 minuites on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
-- 
2.43.4


