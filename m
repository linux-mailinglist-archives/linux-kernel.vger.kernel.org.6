Return-Path: <linux-kernel+bounces-191031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B83768D05C5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597E51F271E8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCA316C856;
	Mon, 27 May 2024 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b="cURU/Aju"
Received: from mail02.habana.ai (habanamailrelay02.habana.ai [62.90.112.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8EC15F3F7
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.90.112.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822161; cv=none; b=spk5NDEZdIamU+bWLDw2takrHZETsx+HdMHEPXTOLBknthJZxfDw0MUUEStfYEQnosya52usFM3OkkkU7eJOBWBH6ZiiXXPm7Fki8H6DW1eskG00wPpGRfSh1SW+Gkez/ZLqT+eqPhzKr0QTlheQsfKwvSFl77ow8qPuW/WUbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822161; c=relaxed/simple;
	bh=mO1wTBrjD0PxLOyQ4AqovbqlEFzmz5ozW7rB391zFZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lYJT0Qb21ljlbc+0WN2vfaBs/vp6jB/xiuBrgU4s/EEujf7161Jm6VPfI0715/SbS82q7LXZygzvVK8fMaiZYQ4a+yQWZsb5LbemvpcZ5G1cMfQk5mF+ywSmnFb66boq5Mj7dHjcpY8hI+rXETVjrb3Ly8mSRUZJhZDe4/A+usQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai; spf=pass smtp.mailfrom=habana.ai; dkim=pass (2048-bit key) header.d=habana.ai header.i=@habana.ai header.b=cURU/Aju; arc=none smtp.client-ip=62.90.112.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=habana.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=habana.ai
Received: internal info suppressed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=habana.ai; s=default;
	t=1716822151; bh=mO1wTBrjD0PxLOyQ4AqovbqlEFzmz5ozW7rB391zFZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cURU/AjuxgUwR+8nWz1e4LtyXs/e1DBcpK1wFmxlXep0ObfgsF5ZvgtPS+d1JnRxA
	 IDCRW/4Q3AqLNCwF8+pE/UIHPPfOy17xNm2u4UmbHubR8HHKn/mLwi24TOgL9ARuY3
	 SgAxj0YCbgtYPDjAPpVD0+tRVCv5Mwlr//PIZFxz92HZhXJ/E9QzANce44CgngQVa6
	 n3GgTwg7LvtvysfhUUHW4uv3O/Ke6DreKA38CmDl//SOQWDafxsMm7tE8Dk+I9kQwK
	 a95TKV6v7BESJqVpzvIKI0wBbPga4hVmshbGBnMIQd/H+b+2L1NRqxgzYdbNlfLXb+
	 SV8Zm+6KAnVaw==
Received: from obitton-vm-u22.habana-labs.com (localhost [127.0.0.1])
	by obitton-vm-u22.habana-labs.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id 44RF2PiZ1954007;
	Mon, 27 May 2024 18:02:26 +0300
From: Ofir Bitton <obitton@habana.ai>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Tal Cohen <talcohen@habana.ai>
Subject: [PATCH 8/8] accel/habanalabs: disable EQ interrupt after disabling pci
Date: Mon, 27 May 2024 18:02:24 +0300
Message-Id: <20240527150224.1953969-8-obitton@habana.ai>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527150224.1953969-1-obitton@habana.ai>
References: <20240527150224.1953969-1-obitton@habana.ai>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tal Cohen <talcohen@habana.ai>

When sending disable pci msg towards firmware, there is a
possibility that an EQ packet is already pending,
disabling EQ interrupt will prevent this from happening.
The interrupt will be re-enabled after reset.

Signed-off-by: Tal Cohen <talcohen@habana.ai>
Reviewed-by: Ofir Bitton <obitton@habana.ai>
---
 drivers/accel/habanalabs/common/device.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 5ca7014def00..78e65c6b76a7 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1502,10 +1502,11 @@ static void send_disable_pci_access(struct hl_device *hdev, u32 flags)
 		if (hl_fw_send_pci_access_msg(hdev, CPUCP_PACKET_DISABLE_PCI_ACCESS, 0x0))
 			return;
 
-		/* verify that last EQs are handled before disabled is set */
+		/* disable_irq also generates sync irq, this verifies that last EQs are handled
+		 * before disabled is set. The IRQ will be enabled again in request_irq call.
+		 */
 		if (hdev->cpu_queues_enable)
-			synchronize_irq(pci_irq_vector(hdev->pdev,
-					hdev->asic_prop.eq_interrupt_id));
+			disable_irq(pci_irq_vector(hdev->pdev, hdev->asic_prop.eq_interrupt_id));
 	}
 }
 
-- 
2.34.1


