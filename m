Return-Path: <linux-kernel+bounces-197792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF228D6F2F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1B71C2112C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 09:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CCC14EC41;
	Sat,  1 Jun 2024 09:43:42 +0000 (UTC)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A002D61B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717235021; cv=none; b=ibY9GJGHWRWl0B/oONY7Q8q3SvZDOXOvb6O6BZqqx9vDw6ymAxfhA0pRgud9tgjVd8pQcOYgZ4Gl/fHZFgITH/6HRBe8XZ+xStCa4wxmiOmPB8yva8/TxnrdETxH3M3Md52b9eP2vV6s/zqdUZ55O4b2J/PzOpknRhu2FOS6eIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717235021; c=relaxed/simple;
	bh=oHc2itPSkdCfhEk+SzhIrjXTk203PODTg41jbcsbXfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F3QH5jD5MQ9AyTq8MRXULRhFUjDoXeWJBvMGRw2YRh9uSR+4e3VreFfwHVstgy8vb+cf+2pTQ9OT10FSSdrglaH0eMu93YySjyvqMJ8AejOHrhyMqCr0MgsNR0F0NdklZe5+czSOzxSlc5ly5USu9M/D6YYqRXV/9Xgov1Tngk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtpip2t1717234916tdymemk
X-QQ-Originating-IP: gIy0LiGnTn3AK5EL3/Cf5tzlesxG0DekhLgc7FFD8Ec=
Received: from 192.168.5.25 ( [255.207.235.15])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 01 Jun 2024 17:41:54 +0800 (CST)
X-QQ-SSF: 01400000000000E0B000000A0000000
X-QQ-FEAT: bQsUcYFpAAYZgSaD1UReWU5dBtwmic1unPItvAt6mXUVEjD4YR4qZAM1DyCf6
	DMURWVXHAsEDKCj8ppWQlKDcrKWnrAkOU8fEqloyUnfO+nWAqbx584kbglKz+H8mfzeMSRx
	aqCbqe9OqvNxXh5EU3cAL/zFZGHppKbP153Toorc4EGs7ix059btDWeIN1364Xi+oIyuWBC
	ZU+ptyVxS6n9hruSFCfIPRY7AlYl1hKqvDbB70TcyKrzipGOx18JZGsiJJUzMHXZfp5xQS/
	TyipkdLmwtYvYbSX+ZEg0LvhE3ivOEJLLwDk/FpL344bXGeP5aIcoU+KkIkNgI88Y11nKxF
	kdyBhhUAXpoMirRFzq27sXTu2Si1ulnn3Oj3C16haxJdyhjWC9Zta0n7bI9vFC4/PbTjgoN
	5x3+Wgz3cbc=
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11862926628622183392
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
Subject: [PATCH] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Sat,  1 Jun 2024 17:41:43 +0800
Message-ID: <5CB69FDA62BB24AB+20240601094143.295718-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.45.1
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
2.45.1


