Return-Path: <linux-kernel+bounces-298301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A7B95C56F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEB51F217D3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05ABC76025;
	Fri, 23 Aug 2024 06:26:11 +0000 (UTC)
Received: from TWMBX01.aspeed.com (unknown [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFF3F9F9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394370; cv=none; b=IVNWz0RcoErZi6T8z2CNAIPBepOjqx7ReL+1qzFZukC0AJreYN/LkgOh98fx24IN/TzSG2beYDkbxw2ZIx1Fa2K3bameZkru9TFslafgwycB9MRQmYIDZuy5e3SiLeFSpWPCGq9rWwlbENaKN4jqVaVNp0YbF47RnI4ed+jtx6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394370; c=relaxed/simple;
	bh=0gM9gz+69VbD18vM1Bt6UB8rE7nzfUpKjw9v+9EFX2c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LkN06cDCG8n4k2eMCE1EhJlLueI7kCKJKCfyBySmW9K2qJqELpH7tUyolvx5t8Xxv3j7jUgXfYfT2RnoVwGigB0/WtnBZd+9Kyjhuu8bVh0bNhh9E2HaSYeVyDedj1KDUmWVLFzKZH0tuq07rwP+wjwPmMfdZoNE6Ar3nQxnVU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 23 Aug
 2024 14:25:35 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 23 Aug 2024 14:25:35 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <alexandre.belloni@bootlin.com>, <jarkko.nikula@linux.intel.com>,
	<billy_tsai@aspeedtech.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] i3c/master: cmd_v1: Fix the exit criteria for the daa procedure
Date: Fri, 23 Aug 2024 14:25:35 +0800
Message-ID: <20240823062535.3073706-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The exit criteria for the DAA should check if the data length is equal to
1, instead of checking if the response status is equal to 1.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/cmd_v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
index d97c3175e0e2..6a781f89b0e4 100644
--- a/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c
@@ -339,7 +339,7 @@ static int hci_cmd_v1_daa(struct i3c_hci *hci)
 			break;
 		}
 		if (RESP_STATUS(xfer[0].response) == RESP_ERR_NACK &&
-		    RESP_STATUS(xfer[0].response) == 1) {
+		    RESP_DATA_LENGTH(xfer->response) == 1) {
 			ret = 0;  /* no more devices to be assigned */
 			break;
 		}
-- 
2.25.1


