Return-Path: <linux-kernel+bounces-414418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B222F9D27A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7819928426A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B821CDA35;
	Tue, 19 Nov 2024 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="hor3vsRc"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D781CCECF;
	Tue, 19 Nov 2024 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732025329; cv=none; b=DYQLpT7pK/F+8NlrHCSf28eML7cfhakhGbtlnAkXPysxrty+uMKogdA59q6dBE3kniuSyg99rb4rgPw/KDKhHXLy7wnjlrX7F+6Lc2HNuPvA2/rgaK2OMyLE5bTuhwEAAVlWv31UNwtzM4K9IvxEpLPc48VA78yJjRtaogK11Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732025329; c=relaxed/simple;
	bh=VddMon7KGsoAO+8uNG9DoNYGSEVrl+SvzfCAy5RVITw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/oeo4vA3VE8fq3Un8mJ5TMTU54L/n+yfZOshPMxoE2qXqseSK0LVYuFTbQgsXE/faj0CZ0ypRgHeCcrEMEmSjT8gqIw+p+/IbahtTv3DAnJEa4JtQpeGZw8A4EQpBVIgqXx8ibe7BQGs5ty/fx9xgjgp75QdzRSFY8iltj0PpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=hor3vsRc; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cHi0m
	zq8NWBijK4Ly2A3LsdTUocLcPH7MQG+4r3jEMc=; b=hor3vsRcMEtHz0EMzcO3D
	iAtoByyRGpOAj4qWMNopKgYfcBCHEkIyAzzk+1fMnNcnmgfwSzy5+OqGRHWkQCIK
	hALnDJxF6vD0fAE4pqZ2f3PYIJlTR8JgI3upySrmqkffxcFd5FZoMNR3MyBtlcGF
	b/R4+FKgCEtC9g733isXCM=
Received: from localhost.localdomain (unknown [122.225.16.198])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3H6a0mzxn+SwgBw--.35577S2;
	Tue, 19 Nov 2024 22:08:00 +0800 (CST)
From: JuenKit Yip <hunterteaegg@126.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	peteryin.openbmc@gmail.com,
	noahwang.wang@outlook.com,
	festevam@gmail.com,
	marex@denx.de,
	lukas@wunner.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: JuenKit Yip <hunterteaegg@126.com>
Subject: [PATCH 1/2] hwmon: (sht3x) add devicetree support
Date: Tue, 19 Nov 2024 09:07:24 -0500
Message-Id: <20241119140725.75297-1-hunterteaegg@126.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H6a0mzxn+SwgBw--.35577S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFy8Xw1rurW5Ar17CF4kWFg_yoW8Gw48p3
	Wrur9aqF15WF4fX39Iqay09Fy5Cwn3A3yIkr9rGas09FWDJ34jqa1ftFyDA3Z8Zry5Xr12
	gFykt34fGF48AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zuXd78UUUUU=
X-CM-SenderInfo: xkxq3v5uwhtvljj6ij2wof0z/1tbiWQWc7Gc8V-HN-AACsi

add "compatible" property for supporting devicetree

Signed-off-by: JuenKit Yip <hunterteaegg@126.com>
---
 drivers/hwmon/sht3x.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
index 650b0bcc2359..2ac1537b3e3e 100644
--- a/drivers/hwmon/sht3x.c
+++ b/drivers/hwmon/sht3x.c
@@ -954,6 +954,19 @@ static int sht3x_probe(struct i2c_client *client)
 	return PTR_ERR_OR_ZERO(hwmon_dev);
 }
 
+/* devicetree ID table */
+static const struct of_device_id sht3x_of_match[] = {
+	{ .compatible = "sensirion,sht30", .data = (void *)sht3x },
+	{ .compatible = "sensirion,sht31", .data = (void *)sht3x },
+	{ .compatible = "sensirion,sht35", .data = (void *)sht3x },
+	{ .compatible = "sensirion,sts30", .data = (void *)sts3x },
+	{ .compatible = "sensirion,sts31", .data = (void *)sts3x },
+	{ .compatible = "sensirion,sts35", .data = (void *)sts3x },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sht3x_of_match);
+
 /* device ID table */
 static const struct i2c_device_id sht3x_ids[] = {
 	{"sht3x", sht3x},
@@ -964,7 +977,10 @@ static const struct i2c_device_id sht3x_ids[] = {
 MODULE_DEVICE_TABLE(i2c, sht3x_ids);
 
 static struct i2c_driver sht3x_i2c_driver = {
-	.driver.name = "sht3x",
+	.driver = {
+		.name = "sht3x",
+		.of_match_table = sht3x_of_match,
+	},
 	.probe       = sht3x_probe,
 	.id_table    = sht3x_ids,
 };
-- 
2.39.5


