Return-Path: <linux-kernel+bounces-337394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0E7984978
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E31F23F46
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DEA1AB6DE;
	Tue, 24 Sep 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHKPfDmb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597F6D531
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727194931; cv=none; b=p5jfDYeUuvTg4K7vxzASiBnwmv+o+qo7pY6Yz2CvkF4/5EPa/5Zpfu0himsXCW9IodWcmVMHb/tggk6+d0oTQwxjEBUGQHrdciLLw6QlqkIT83wuKZKsKj6kh8SXtaExHzsS7q8v25Te8/RiT+r/37WcxaAP6EVzycEzyfp6HrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727194931; c=relaxed/simple;
	bh=DrHwLh8j4IgBGryly9J8nujzkoAgCYWBxLrne0J/PRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lj4m5+E/oTaXYvZT7Sq0o3wbzXkV6tzsdZFSvc81bI+k8hj08XeOVwNPb2/dE6iw42AZPC6VuRJkSWkrybFBeSQuZAfsBrmmmLnOm35WZKazr0qcxaPTveQ1zcaRC5oQcLGtap0oG8xpQt6O2ShWfWJAjXhUtkxWVXkR1G4V8Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHKPfDmb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E52C4CEC4;
	Tue, 24 Sep 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727194930;
	bh=DrHwLh8j4IgBGryly9J8nujzkoAgCYWBxLrne0J/PRM=;
	h=From:Date:Subject:To:Cc:From;
	b=DHKPfDmbQH80It0G8/6x/pfsbOxQe8GDNK1JcuCpPxz8SmC8zOr39cEqxNO810uuR
	 itgswJbxTF8IopoONprsXfU6KXTS8iYMqGoEt3/FCGRcU0J3pjRqc4Fe+g+NvDJkLG
	 oYgxxp801qprsiB2nY3YWx/qYaj88PX+NNBOJb2tAkOmrAohzsxHBpdWb8iB6u3FFk
	 B3VYmj4hF0eeD2Y9Iq48gYi45Uu99lJ600Yx04f5vyMrhsNj6IFmW1KkkRIzkG6x/v
	 4NjQU8xkn/g70ekHZmUXrKjkUgt+O9r3Pih8l10qiN59HmjOB/B4cJ/0N3gJUmx7CN
	 zii5tTxcyx5ZA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 24 Sep 2024 18:22:04 +0200
Subject: [PATCH] mfd: bd96801: Use maple tree register cache
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240924-mfd-bd96801-maple-v1-1-04fe33e1f009@kernel.org>
X-B4-Tracking: v=1; b=H4sIACvn8mYC/x3MTQqAIBBA4avErBtQqdCuEi1MxxroD4UIxLsnL
 b/FexkSRaYEY5Mh0sOJr7NCtg24zZ4rIftqUEJ1wqgOj+Bx8WbQQuJh753QOUW9DtrIpYfa3ZE
 Cv/9zmkv5AOAzjFVjAAAA
To: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DrHwLh8j4IgBGryly9J8nujzkoAgCYWBxLrne0J/PRM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBm8ucvFVYg63lW33qcQTUupbwlV9lnh+83es4Dp
 2+PE/iicDOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZvLnLwAKCRAk1otyXVSH
 0EzjB/93FXHqU08lSIVgXsBE+IoifJFlm76+AzMpvNawhGFW61iqfnnyeP7VIfuiSep5brB2D7o
 q7Qj6vNPu8B3KWn2zBHQWb29IU2kxUqEH7Lvm4iymPrOavfOm391IOeqPHXkABHM7/WnlqtzHHO
 zTqUD3/QT5T06Q4cv6WGe8ojkvqQNpU5KKPHeoDc63HHoB4q9qyQtvcXd50AIASsx2orUqeuZeN
 jNdO/cO09ZIyS61isC3tjrUS93wIMG8Ch3X9OQ0rpqAmPQQAIOioladkgzAg46ivbai2CcoxFVS
 SmfcnYPJ7uuquwO0Litk42teu4vYvOnk4ULYdLGo2As8mQEE
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The maple tree register cache uses a more modern data structure than the
rbtree cache and makes implementation decisions more suited to modern
hardware, switch the bd96801 driver to it to take advantage of this newer
code. No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/mfd/rohm-bd96801.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rohm-bd96801.c b/drivers/mfd/rohm-bd96801.c
index 714f08ed544b..f118e63d9b7d 100644
--- a/drivers/mfd/rohm-bd96801.c
+++ b/drivers/mfd/rohm-bd96801.c
@@ -194,7 +194,7 @@ static const struct regmap_config bd96801_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &volatile_regs,
-	.cache_type = REGCACHE_RBTREE,
+	.cache_type = REGCACHE_MAPLE,
 };
 
 static int bd96801_i2c_probe(struct i2c_client *i2c)

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240924-mfd-bd96801-maple-cc2e58f891b5

Best regards,
-- 
Mark Brown <broonie@kernel.org>


