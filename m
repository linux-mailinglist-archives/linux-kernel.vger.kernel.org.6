Return-Path: <linux-kernel+bounces-446436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2319F244D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5B4164DAC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCF918FC7E;
	Sun, 15 Dec 2024 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JNlhvb4R"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1D1805A
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734271861; cv=none; b=nOL4RD1uuyYyTuNzRuAW9baiKjq9QLK4PSL541j8pipcexuQu3OBpy5LvFZHuO81G1CpRrom2YBemhre3rDfUaXHivkfU2j/GjS6DP21O1g/QR0dop/ou59dRVql+sKYeE/9p2VmHuwXeoBA9EpI3FwjwfKtiy44U0isBUOE6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734271861; c=relaxed/simple;
	bh=MlrPz+vnLABP0cabnsl55vKGWyPFUDb6AU/xf7DTd+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NIETj6n6PemWJINcnRiPcUeFGv0steQ+Fv404EPkGIx+YwhyEDaQae8JM/YLLhx8AAzGmadIQA6f8OPAuvqtAfW87UDc4/0IfWmc7xouoNFQvFo+fb4uVM9vBgf5UM2NsLmNZNuN+ewr1J9nnnNk3GqIghX9lawO6DNG+Gg4Dko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JNlhvb4R; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734271857;
	bh=MlrPz+vnLABP0cabnsl55vKGWyPFUDb6AU/xf7DTd+E=;
	h=From:Date:Subject:To:Cc:From;
	b=JNlhvb4RtAzc9pM9OrkxFMoqhO3giS+mXtanzUX4hXJ4v59Om4TMz2I+pUtvtV2Ij
	 O7aESygV4Ebx8q27wv7gsTRkdbC5ZMnX40Wx4a7Gy212lFYHDBSQgZZcJZ1lmgc2e7
	 dPjYiqjJPY7VhsMdCcdCVTjGLbtdy07M6rauebkE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:10:53 +0100
Subject: [PATCH] fsi: core: Use const 'struct bin_attribute' callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-fsi-v1-1-b717f76a0146@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGzjXmcC/x3MQQqAIBBA0avErBtISYOuEhFaY83GwpEoorsnL
 d/i/weEEpNAXz2Q6GThPRaouoJ5c3El5KUYdKNbpZVBuSUIznuUjJ7j5HJOGISx09Z3djHWKQM
 lPxIFvv71ML7vBwUvZ8dqAAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-fsi-726b76d56a15
To: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>, 
 Alistar Popple <alistair@popple.id.au>, Eddie James <eajames@linux.ibm.com>
Cc: linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734271855; l=1791;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MlrPz+vnLABP0cabnsl55vKGWyPFUDb6AU/xf7DTd+E=;
 b=sfrDvgZFpT83hjbwy8ehyMngs9daL4oPazDo+o8Yune2N4sGIFImzpLphFZxQx3mye1J6xJyN
 wSBrCacsSxKBtl4PbO0ZF2+bMTRofo64sX3nXe5a1+Ma0gEo20jSirQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Make use of it to match the attribute definition.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/fsi/fsi-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index e2e1e9df611543343a8498cdc425528a3e44619a..50e8736039fe686dd402ecf8fabe37a4c237d71b 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -554,7 +554,7 @@ static unsigned long aligned_access_size(size_t offset, size_t count)
 }
 
 static ssize_t fsi_slave_sysfs_raw_read(struct file *file,
-		struct kobject *kobj, struct bin_attribute *attr, char *buf,
+		struct kobject *kobj, const struct bin_attribute *attr, char *buf,
 		loff_t off, size_t count)
 {
 	struct fsi_slave *slave = to_fsi_slave(kobj_to_dev(kobj));
@@ -581,7 +581,7 @@ static ssize_t fsi_slave_sysfs_raw_read(struct file *file,
 }
 
 static ssize_t fsi_slave_sysfs_raw_write(struct file *file,
-		struct kobject *kobj, struct bin_attribute *attr,
+		struct kobject *kobj, const struct bin_attribute *attr,
 		char *buf, loff_t off, size_t count)
 {
 	struct fsi_slave *slave = to_fsi_slave(kobj_to_dev(kobj));
@@ -613,8 +613,8 @@ static const struct bin_attribute fsi_slave_raw_attr = {
 		.mode = 0600,
 	},
 	.size = 0,
-	.read = fsi_slave_sysfs_raw_read,
-	.write = fsi_slave_sysfs_raw_write,
+	.read_new = fsi_slave_sysfs_raw_read,
+	.write_new = fsi_slave_sysfs_raw_write,
 };
 
 static void fsi_slave_release(struct device *dev)

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-fsi-726b76d56a15

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


