Return-Path: <linux-kernel+bounces-407056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5BE9C67F1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D3C284ECD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126D172777;
	Wed, 13 Nov 2024 03:58:38 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B2170854
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731470318; cv=none; b=lCUXhIuYHPawD+N+d0htEqbFU1jgEilymUpBoyLYdH/peAw0E39vkOhyyI166m9Rxwau3QdHuqudN06g+QmmrHj6GOYQ910TYx0NDcyGE+paSwg2fLEMNDyAe/OmaCtdvjJaMHlqGg5exRmX3i/gLg/PlhzdfMOO+F0fKuyk0Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731470318; c=relaxed/simple;
	bh=C4rxnlPvtJDGB5C7TCC2Q2vCQE5HPAaYwgzWEEJhh80=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bYNwgLICJh+U5N+ZhQgzTLewHbwx640/GX3DFXKjPsmPYP9cdX9qdTIXmPtMqa2AUnbyx22IZtbkt957CAETrm449SKnh9/X+/4Nuc1Wex9I9GdMn3Smezean6qTrdUPEOUSuRg6cawNLGpezGlLcpHkbQjw/ar2nWVnb1lA9ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 13 Nov
 2024 11:58:26 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 13 Nov 2024 11:58:26 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <alexandre.belloni@bootlin.com>, <jarkko.nikula@linux.intel.com>,
	<Shyam-sundar.S-k@amd.com>, <Guruvendra.Punugupati@amd.com>,
	<krishnamoorthi.m@amd.com>, <billy_tsai@aspeedtech.com>,
	<linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] i3c: mipi-i3c-hci: Support SETDASA CCC
Date: Wed, 13 Nov 2024 11:58:26 +0800
Message-ID: <20241113035826.923918-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

When the I3C subsystem wants to assign a dynamic address using the SETDASA
CCC, it needs to attach the I3C device with device info that includes only
the static address. In the HCI, if the driver want to send this SETDASA
CCC, a DAT entry is required to temporarily fill the device's static
address into the dynamic address field. Afterward, the reattach API will
be executed to update the DAT with the correct dynamic addrees value.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index a82c47c9986d..6655e8396a35 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -438,7 +438,8 @@ static int i3c_hci_attach_i3c_dev(struct i3c_dev_desc *dev)
 			kfree(dev_data);
 			return ret;
 		}
-		mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, ret, dev->info.dyn_addr);
+		mipi_i3c_hci_dat_v1.set_dynamic_addr(hci, ret,
+						     dev->info.dyn_addr ?: dev->info.static_addr);
 		dev_data->dat_idx = ret;
 	}
 	i3c_dev_set_master_data(dev, dev_data);
-- 
2.25.1


