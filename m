Return-Path: <linux-kernel+bounces-289288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEEE954456
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546D3B22B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9575A142E90;
	Fri, 16 Aug 2024 08:27:47 +0000 (UTC)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB271369BB;
	Fri, 16 Aug 2024 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796867; cv=none; b=LLvL66PKPhrmTEYLLHSfc8opUgzX/htDI62czhgquYcpspCoweLPp7dR1yd8zrwwWoS9t6bPVps0U4n246IEdkXa7H5ngkrp1HS4wl8ZHGVfxZ3TfsyAFzVH/5qWMSzMbYoBuTvADBq5nQPzkuE4sOzP+j7PL4vw4dY/kSiTwhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796867; c=relaxed/simple;
	bh=X/NC8Fn35SuJ+/Zgd8nVnQApdeQjzg11aXOWQ5rYbC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NjRxBcccnUQ8x/pvVjTTUAla9JdMadZf1Rdra+s0iLZG+nlGNFcRdfeLmuj86QLn8oEa+tRHPVOLxQBfV2Vt7jXVqhW04Jb7hsJzw6PI5k5Q5fOufKlDiNK2aJ2SOL+2ZPLundY8zg4gnzjLAAlJKm9fZjph8KiX0KU1LMxY3i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A2C5D2017B0;
	Fri, 16 Aug 2024 10:27:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5761420179E;
	Fri, 16 Aug 2024 10:27:43 +0200 (CEST)
Received: from pe-lt8779.in-pnq01.nxp.com (pe-lt8779.in-pnq01.nxp.com [10.17.104.141])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B259C181D0FD;
	Fri, 16 Aug 2024 16:27:41 +0800 (+08)
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v1 1/2] Bluetooth: hci_h4: Add support for ISO packets in h4_recv.h
Date: Fri, 16 Aug 2024 13:55:23 +0530
Message-Id: <20240816082524.286245-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

This adds ISO packet support in h4_recv.h, which was created before ISO
packet handling was added to hci_h4.c and hci_uart.c

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/h4_recv.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/h4_recv.h b/drivers/bluetooth/h4_recv.h
index 4f2c89742245..647d37ca4cdd 100644
--- a/drivers/bluetooth/h4_recv.h
+++ b/drivers/bluetooth/h4_recv.h
@@ -38,6 +38,13 @@ struct h4_recv_pkt {
 	.lsize = 1, \
 	.maxlen = HCI_MAX_EVENT_SIZE
 
+#define H4_RECV_ISO \
+	.type = HCI_ISODATA_PKT, \
+	.hlen = HCI_ISO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE
+
 static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
 					  struct sk_buff *skb,
 					  const unsigned char *buffer,
-- 
2.34.1


