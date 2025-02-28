Return-Path: <linux-kernel+bounces-538812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F122A49D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 16:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E023B95A5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5021EF396;
	Fri, 28 Feb 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pl5sYAKh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340D1EF37B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 15:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756275; cv=none; b=hQhzV2hvfto9mv111WUgIS8FwmO9DdhanjA316vj/jReXP0sNmR3wdv09W6XF6YniWb+Sdqt7iMM+gy4MYLpKoyOk9zSu10BS/qt/mqVXq+9aXoMDCNOBXlJwFTFjuxjnJnpNDzkWnND3AilwNXaODqHFFQwfgJqdzm86aPD3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756275; c=relaxed/simple;
	bh=g7/8BNf/tC/5Tg8SovHGPc8X/RflqIPkH8MEOzkU4ZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sZ2Cb6Rzd5OvwYM40Z1tZ7R8C229R1RQOerIbTRMtn/3CLJynWWCwJptpdxHofoB/fvEvkZxl6YQGwPALJ8NHslaCu+J/pP9bW/hTbaL62dnQO8pDssRLoqMNikuN0arbvXCkoj9PN7cgq2zTvdB8kIdX1u41sga08lid+eKPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pl5sYAKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0962EC4CEE9;
	Fri, 28 Feb 2025 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740756274;
	bh=g7/8BNf/tC/5Tg8SovHGPc8X/RflqIPkH8MEOzkU4ZI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=pl5sYAKhjN4xVXI05rS5vXCsrqCYrM7Y8Ao0aWaRNfouWbpULiKNeLyaHR0tWKMG2
	 p4a+gRNdBQ+3j5G/YheVF6SN8xH8k+L8LXuOp03k3v895BlTY2zO6qKkg0Ds3Yd16K
	 +LF+soSLa4xm6VqdgCQt5e4hLjAl1YDvdcx42tpZaHMqmNMDjZFLEzpnIy9QDITAJF
	 RM/DXo50ZqnADGDZnz3VS8cFv/oFqPYn93kTII/VZfRxHOi+LouNvdiR6GC4DvN2Yg
	 5HCxIYODz2thmNO3hQ1BYl8GZt4Zk5QHzazd5sq1yJFaRXDFuyBcIm+qWWPV9An8pz
	 7ebzV2WG4+u1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D2C282C1;
	Fri, 28 Feb 2025 15:24:33 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 28 Feb 2025 09:24:26 -0600
Subject: [PATCH v2] mfd: max77620: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-max77620-module-v2-1-eb686216437c@gmail.com>
X-B4-Tracking: v=1; b=H4sIACnVwWcC/3WNQQ6CMBBFr0JmbU07wWJdeQ/DooUBJqHUtEowp
 He3snf5XvLf3yFRZEpwq3aItHLisBTAUwXdZJeRBPeFASVeJGItvN2aRqMUPvTvmcS1dkRSGSe
 tgbJ6Rhp4O4qPtvDE6RXi5zhY1c/+b61KKGE0OUQyA2p9H73l+dwFD23O+Qv+gujRrgAAAA==
X-Change-ID: 20250224-max77620-module-84bee019b0a9
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740756273; l=1796;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=OT0FIDuDw3FGa5/XqyJt2qY/plz7HsCO8qtwF054Yxg=;
 b=DRFB1K+kfx5CalIeF1Lk99Ksmxn+8F6Js6l67aOGZq8tyTSDoS5w4KjK5dq+71lOqOGxmXFIz
 KpoxQVKK7c4AzNFlcgUehTLkcb0c9rAxhna6sbeFjG109OLqaHbqZXY
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The driver works fine as a module, so allowing building as such.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Include module.h directly
- Link to v1: https://lore.kernel.org/r/20250224-max77620-module-v1-1-96eb22e9f266@gmail.com
---
 drivers/mfd/Kconfig    | 2 +-
 drivers/mfd/max77620.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6b0682af6e32b434ee3e99940005a6cce14ff55c..922704bd0ce3fe6c094da6b1528b72fedcfa1677 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -858,7 +858,7 @@ config MFD_MAX77541
 	  There are regulators and adc.
 
 config MFD_MAX77620
-	bool "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
+	tristate "Maxim Semiconductor MAX77620 and MAX20024 PMIC Support"
 	depends on I2C=y
 	depends on OF
 	select MFD_CORE
diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index 89b30ef91f4f112b06e0e055e75e480fab176f8f..21d2ab3db2542ef8bcbd82262ac1fbd1dfdbce5c 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -29,6 +29,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/max77620.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -700,3 +701,7 @@ static struct i2c_driver max77620_driver = {
 	.id_table = max77620_id,
 };
 builtin_i2c_driver(max77620_driver);
+
+MODULE_DESCRIPTION("Maxim Semiconductor MAX77620 and MAX20024 PMIC Support");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_LICENSE("GPL");

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-max77620-module-84bee019b0a9

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



