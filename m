Return-Path: <linux-kernel+bounces-252304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C0D931144
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A130A2838E3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C15C18732B;
	Mon, 15 Jul 2024 09:35:25 +0000 (UTC)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE8186E5F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036124; cv=none; b=jj2NzMWdXCTHCSVY7UDadBNmBPA6KeU9JuWj8BXi/1DRla4qqBhPw84IUG4raHpRarKaFpiXR5yaK+b4QfKO26FDDBsBGZ5J2mqBgpTJjgQZs+GsBeHIaW+V3dtZ1+h39QaQIKGS84janF1SRb8MU0u2HKZ1/XHW0w3VqizKCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036124; c=relaxed/simple;
	bh=lmtxfMUre6h1xU2YztvSKCW9Y7FPeFz959LQbBX3KS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3K4cZMX1CADyz5zHjhOZHj3uTCjPzcWRkL8HjqhJhpwDRCEcxX2j+dDEGXmq+ivXudGIHGHqLn8ImUPflorQuU/NEwbp8TWVD1SwcNtlBDnoJyisxSAoiBHg9R1rknPO+ypatmJG7LiZps5fu/gs0DD2i1QoZ0beaO0QT2jQHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp90t1721035915tgnps5d8
X-QQ-Originating-IP: YMoGnuC64TH6HmUbXvBuO8QTArCIGBPn8yVSfdChpJY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Jul 2024 17:31:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10882346424374145259
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
Subject: [PATCH v4] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Mon, 15 Jul 2024 17:31:44 +0800
Message-ID: <6CDDDB0BA2EAE00D+20240715093144.1548609-1-wangyuli@uniontech.com>
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

Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 282d808400c5..9c300d7b04cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2903,6 +2903,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
-- 
2.43.4


