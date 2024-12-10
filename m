Return-Path: <linux-kernel+bounces-439813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF0319EB440
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BED167669
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA24C1B0433;
	Tue, 10 Dec 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="YQ/pNaSP"
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBE1A42A5
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843009; cv=none; b=MxoQ5jfV8O2wMwAVmrrCnhEJTDz50wUIL2+xkEifYXIrVUVuYCjelrLTVC3hcpyRS+MOBNTcY4NQu7lEKjNJE4p92AmseX4yGHvKVRVT0p87E0Shs9gY1bPcW1p4kyBrtWo2hxkBbDMCbx4czQoTAIZYFeuPHYawwlXBfUns4Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843009; c=relaxed/simple;
	bh=oEVSyd7C4Y/38xVR3/0EwUZWCLbyLG4XGJYDmOeNFoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ppB05RuixRzBMEF/tcUF7HWgJFziOxZsL0yFrSarJQH1IHbSFVFrkg2OD3yszCdqWEtWC0mDwmUyyR2lm0bYVk+rLPZ+7UJcCMUdhAQ6fq1a7x1Nnx7mrrLZO3/uSCQvrWi6eiTc123EQCYiIXCeZytjoVDF84U1dFT4GGyGhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=YQ/pNaSP; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id A10302FC0048;
	Tue, 10 Dec 2024 16:03:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1733842998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vV/cnHajIoIituMyb9QCfGXYanfuW4S0xFNFjCkf0kY=;
	b=YQ/pNaSPu0UYvJuAWKvLbMJQfuIbvx36Kc6o6E8t9sL56BH/HIt6pOdXBjdpaFVzNtVQSq
	1EoZk9UtYPJy1vfl4l/VZsW2x+NCt6jWUKK3ATjoZR58dw/u3p9M3Q0HSTpTSriEUbbLlE
	uvZ4F4M2zj2CY3ICmTaxHVQI1aemow8=
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
Subject: [PATCH] nvme-pci: Add TUXEDO Infinityflex to Samsung sleep quirk
Date: Tue, 10 Dec 2024 16:02:55 +0100
Message-ID: <20241210150305.52039-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Georg Gottleuber <ggo@tuxedocomputers.com>

On the TUXEDO InfinityFlex devices, a Samsung 990 Evo NVMe leads to a high
power consumption in s2idle sleep (4 watts).

This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
a lower power consumption, typically around 1.4 watts.

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a5ba80f1811a..c5ecbda6bd1da 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3143,7 +3143,8 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		 * because of high power consumption (> 2 Watt) in s2idle
 		 * sleep. Only some boards with Intel CPU are affected.
 		 */
-		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
+		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
 		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
-- 
2.43.0


