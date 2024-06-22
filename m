Return-Path: <linux-kernel+bounces-225540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3799131EB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 06:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2196A286477
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99DE36AF8;
	Sat, 22 Jun 2024 04:23:40 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331C2D02E
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719030220; cv=none; b=sbCmFRamocL4ltTKSlctNh1RPjRwreeJu4uRvDR+WJJpkeMhvPhIAnqzmZ8axaZ6w+jivV8XGEUmZbSNBlM6HiPUw/p0LYpoLklOqeFW3P8XznFNDGVj8cw7KVnBFpqPulW5IFfvJohVlHBXONYNb9Ea4CJtErtADu3Mt31scBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719030220; c=relaxed/simple;
	bh=E2lhudFZqA6KUjayaDPIncULW2x8bmm3GkkhLEnRZZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FFpLQEFf5xIFWZq0Zhqkmb/d/+CuTlm6xJPilmNaj5q3PwJoS00vgb24/zhphIM2/vPjmGWb25QZ5EjwI9sI/w0a1+o6hU95aAVdNgoJtvkEsVvgtSK/oPZDGUn+xtxvj0xnO+sKrYYiXzcFEmLmd+I54vg8IQ+VbT0y+9XDuhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip1t1719030084tfaiozm
X-QQ-Originating-IP: PRuQglMkaNNVScql+O3EOQIRXjh5zzF4aXn6jiA2KD8=
Received: from 192.168.5.25 ( [255.167.206.11])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 22 Jun 2024 12:21:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6017219967189827787
From: WangYuli <wangyuli@uniontech.com>
To: wangyuli@uniontech.com,
	guanwentao@uniontech.com,
	huanglin@uniontech.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND. PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Sat, 22 Jun 2024 12:21:08 +0800
Message-ID: <AFD9EEAB191702D0+20240622042108.10427-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 30 minutes, there is a
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
2.45.2


