Return-Path: <linux-kernel+bounces-303119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761A9607A8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1087283142
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F2319E7FE;
	Tue, 27 Aug 2024 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="qG7YUdX1"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E909149E0E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724755307; cv=none; b=KsLASe7KpEyL9BUJ4BlAuhkjpcUyXgtRkcVf1Bw3vaAeQa8i5Ja/+OmDuBhmtcAs9125i2aBxFkI4DTN6Rx8jjm+kpXYRIqAV6uypP2LN3K7ycOg2SYFd02X2VoUGWZfETJVE8HL4na4xFM9/gbJudJuIjomsbGHM6qXHTvFiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724755307; c=relaxed/simple;
	bh=/uSZbBVxgZPpRdiAF7BTknt9Pn8Xick0TT+zdpgciyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DqupnZ5+/fVolz/gcnhcbiOkzoG7yptZkeNu99BXzQlNY1nAqHp3SLZsc9K1MYqL6aUZlogNPIV+EtVsXMsmiSZi0tWSRCRzCUVYXeyn/EGPqlibYcWKG8figSmfcE4cX3J4zVHPRWzaQT5SQY5XiVXWCL1Z230/GPXF9EvEnRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=qG7YUdX1; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse.fritz.box (p5b164fa4.dip0.t-ipconnect.de [91.22.79.164])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 949BB2FC005F;
	Tue, 27 Aug 2024 12:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1724755301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O8z0az3FVJk8o0jCJUzYwr7yw2OZPPMX5YYQGX1IePw=;
	b=qG7YUdX1sLUp1ujY4Od7ahRfqv4wuloFT7a4uNUzyP8/qnJpecziOA0fr0pD8ITJr9C5m9
	dyaqZY5CDKH5ybqjfM9Fh+gg2ca/ywXX1YHgpNA1CYMxRR0+VBHJorVEVuO8gdpBJux3i7
	V4wDhlNdTIQYgDiaSV1z7P4fg7hMmVI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-pci: Add sleep quirk for Samsung 990 Evo
Date: Tue, 27 Aug 2024 12:41:33 +0200
Message-Id: <20240827104134.11697-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georg Gottleuber <ggo@tuxedocomputers.com>

On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
power consumption in s2idle sleep (2-3 watts).

This patch applies 'Force No Simple Suspend' quirk to achieve a
sleep with a lower power consumption, typically around 0.5 watts.

v2: Rebase onto v6.11-rc5

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec3..48beea7e2f249 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2967,6 +2967,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa80d) {
+		/*
+		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
+		 * because of high power consumption (> 2 Watt) in s2idle
+		 * sleep. Only some boards with Intel CPU are affected.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
+		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	/*
-- 
2.34.1


