Return-Path: <linux-kernel+bounces-446461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E02B9F2494
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 16:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D531885DFE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB018CC13;
	Sun, 15 Dec 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PMTe/a6o"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A40440C;
	Sun, 15 Dec 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734275956; cv=none; b=aBx3IxQmAA1kHs7XFN2OiIRuic3f6tv6xq4wBjB74tIIf8lg74JmujA5jHazvwlgoh6zX6cd2WTneEIudNU3Y7Dert+cl/rX07mo4ObfWa7sa8umnEkaH2D795P/7m1OzegnkfGbgQUS6BOgvI/wiV7L4VNjaWv+FK7wDj55bbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734275956; c=relaxed/simple;
	bh=UKZwM/MViNPNuJQk0soam9BhTTERDMWu87Mborqf0hM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b7CYkbaHrEUgKJ41adliQimxL7hISaeBJWawcpSQrVr4SGYziV3jAGcdeYhiL1H/VYtV8nf1c6az+gAsD5/lSv0Vv3H2hF0CnHQ+ayTB23l7FsaAXFsUL5Ey8rvWrYvL8rQUyRCHH5DH0qqvnL6vJs2ueIITxt9/Eec8UAi/RYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PMTe/a6o; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734275952;
	bh=UKZwM/MViNPNuJQk0soam9BhTTERDMWu87Mborqf0hM=;
	h=From:Date:Subject:To:Cc:From;
	b=PMTe/a6oxJEG2/LK1YZmNZEQYrGUIjN2egp20Ib5KZXOYWSl7r4c57YOeZp3Qs+ak
	 O+Hs0hfgZtrmp/BkR6j9RxT2ORA6hvIM7FtXoxFjuNGQMF3JB31XAV13Q4Z4fdDS6Q
	 rqD7yKpSBXXXVQnWFPWOhy28Sf3akaPp5jVoc2lM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 16:19:04 +0100
Subject: [PATCH] hwmon: (occ/p9_sbe) Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-hwmon-v1-1-ea72a6a46c36@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGfzXmcC/x3MwQqDMAwA0F+RnA3Y0grzV2RIV6PmsHQ0RTfEf
 1/x+C7vBKXMpDA0J2TaWTlJhWkbiFuQlZDnarCddcYaj/rTRTEm0YIvlimUknE73kmwdw/fGR/
 n3juowSfTwt87H5/X9Qc6Y85AbAAAAA==
X-Change-ID: 20241215-sysfs-const-bin_attr-hwmon-6495015cd654
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734275952; l=1420;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UKZwM/MViNPNuJQk0soam9BhTTERDMWu87Mborqf0hM=;
 b=68K9hOwlB8nHNntTl4AgEja0dXeFrqn1PJMueHYTZJNJAhfYxqhsgCUoSh9UpwDSgLv/giWoL
 1B4RturPZ1tBrauqO8CF/HXvcsKAC28xnEMSb+3lgw541ld2tjw2kAS
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/hwmon/occ/p9_sbe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/occ/p9_sbe.c b/drivers/hwmon/occ/p9_sbe.c
index 89761a9c8892fe4ac20da6207e32e3b4c9c6a712..1e3749dfa598c8a90341e6456d6175d9a7aef5b5 100644
--- a/drivers/hwmon/occ/p9_sbe.c
+++ b/drivers/hwmon/occ/p9_sbe.c
@@ -30,7 +30,7 @@ struct p9_sbe_occ {
 #define to_p9_sbe_occ(x)	container_of((x), struct p9_sbe_occ, occ)
 
 static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *battr, char *buf, loff_t pos,
+			 const struct bin_attribute *battr, char *buf, loff_t pos,
 			 size_t count)
 {
 	ssize_t rc = 0;
@@ -48,7 +48,7 @@ static ssize_t ffdc_read(struct file *filp, struct kobject *kobj,
 
 	return rc;
 }
-static BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
+static const BIN_ATTR_RO(ffdc, OCC_MAX_RESP_WORDS * 4);
 
 static bool p9_sbe_occ_save_ffdc(struct p9_sbe_occ *ctx, const void *resp,
 				 size_t resp_len)

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-hwmon-6495015cd654

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


