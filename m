Return-Path: <linux-kernel+bounces-364998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D083B99DC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 04:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0861F238D8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 02:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F415C145;
	Tue, 15 Oct 2024 02:06:28 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F7315AD9C
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 02:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957988; cv=none; b=ckqG0fu+EHF/dF+hYdnfyLafn3Wje+G4UgwXcAWmdUzsCEfL8rxC/X9WD3mVgReoVZdj766RsODtvcoGAWMIgLPlxz+STkh5SQgVh9Pb8WKSgyq2q28gS+2FfiZOfCf/MPcxdcGD04yA/72oMymWUQ9Cla7vwPRYeFRvn6by2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957988; c=relaxed/simple;
	bh=g0PEq5gyp9bru5qpvJtXPdkX9I4+CdyhiS4GVx670/s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=amQP99iAAFiguoVQnXmHzvPD+W966ykUBR/GuFnHOxqUx/8lCOelqeIr3Ixv8XKpt0/blMQwRQZkHylKWtTBv+nOqhia0o8jBeW6I6/2XYJQk+cjbhz3gDj7taSs06PlSY/1Bw2AjanpLRbZHprv5IO65nUBi5lHRROlzq4PNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 15 Oct
 2024 10:06:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 15 Oct 2024 10:06:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jacky_chou@aspeedtech.com>, <jacob.e.keller@intel.com>,
	<u.kleine-koenig@baylibre.com>, <linux-kernel@vger.kernel.org>
Subject: [net-next] net: ftgmac100: corrcet the phy interface of NC-SI mode
Date: Tue, 15 Oct 2024 10:06:10 +0800
Message-ID: <20241015020610.1824763-1-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

In NC-SI specification, NC-SI is using RMII, not MII.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index e64a90a91dd4..10c1a2f11000 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -1913,7 +1913,7 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			goto err_phy_connect;
 		}
 		err = phy_connect_direct(netdev, phydev, ftgmac100_adjust_link,
-					 PHY_INTERFACE_MODE_MII);
+					 PHY_INTERFACE_MODE_RMII);
 		if (err) {
 			dev_err(&pdev->dev, "Connecting PHY failed\n");
 			goto err_phy_connect;
-- 
2.25.1


