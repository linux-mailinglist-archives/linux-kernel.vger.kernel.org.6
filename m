Return-Path: <linux-kernel+bounces-441785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD609ED412
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B679283349
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F00211A14;
	Wed, 11 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iHxyygQq"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8B6204F61
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939433; cv=none; b=FjIKPvvdldSv3v5D3Yhy9yqLdmyKPrd7Mfg1NHMoRLO3KjO48WfM6CSK3x3tZWjB1RFTOcmhv1w3NWy0dMqsb7NPOQdiXrkW3Eq1ULl0Rq+/DlxlPbxNbHsluZXcTYdOPXDKK+pFAK1GM56K8Qi8EpmDKFOHvzRG8C5U5ycCZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939433; c=relaxed/simple;
	bh=frkUSQXMfgqlNH7WR6G8UTYRdIbi+CzS3x05VMGy3Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gPXwO79/7cQFO7uwTpQqIC4lREvsk+Om2cBTJbWldumcpxUsOziPH0IInPo3idNM9DJcaW71PYJO8F4DGkcoG5W1XlfpIR+Od4tokQOG6zMK7mx+im7Z/A3pdItP6tZdnn9F2rQGjli8t2g08zAfSnD4xpd/zkd7GfxS737c9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iHxyygQq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939419;
	bh=frkUSQXMfgqlNH7WR6G8UTYRdIbi+CzS3x05VMGy3Vg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iHxyygQqFbqmFGrtKKqBG0k22GU1CcmB/d71LnmkaQRGcXCvw1TMCa/hIGVl7XMYj
	 txAbKKfHoP9lTfe3DrhSmtEN7JaSfYK3qw5eiD6GaeyC5hOUaSrvo0+I1/uQ8vq6re
	 Ci6f28BjN2OAYftL1UyiHTYhZE2Z3vFRvGxeReX0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:24 +0100
Subject: [PATCH 09/12] w1: ds2780: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-9-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=1623;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=frkUSQXMfgqlNH7WR6G8UTYRdIbi+CzS3x05VMGy3Vg=;
 b=GLy4SN79dPswTLsvD2ZvWnfSsn87yzfAMxhYeLGJp58lhExeQ5tptf4O10ueb9dtmuPOD3JL5
 GDKdalo18ekDQ9PpmrR7jfwKXiKfQm5R8rIYzt7IPchBURPHiEPxQsu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2780.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2780.c b/drivers/w1/slaves/w1_ds2780.c
index 3cde1bb1886b1acb1b37e471a2961f9ff0a2f11f..ba7beb7b01f98d631d61c44847540068ece4bdd6 100644
--- a/drivers/w1/slaves/w1_ds2780.c
+++ b/drivers/w1/slaves/w1_ds2780.c
@@ -87,7 +87,7 @@ int w1_ds2780_eeprom_cmd(struct device *dev, int addr, int cmd)
 EXPORT_SYMBOL(w1_ds2780_eeprom_cmd);
 
 static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
-			     struct bin_attribute *bin_attr, char *buf,
+			     const struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -95,15 +95,15 @@ static ssize_t w1_slave_read(struct file *filp, struct kobject *kobj,
 	return w1_ds2780_io(dev, buf, off, count, 0);
 }
 
-static BIN_ATTR_RO(w1_slave, DS2780_DATA_SIZE);
+static const BIN_ATTR_RO(w1_slave, DS2780_DATA_SIZE);
 
-static struct bin_attribute *w1_ds2780_bin_attrs[] = {
+static const struct bin_attribute *const w1_ds2780_bin_attrs[] = {
 	&bin_attr_w1_slave,
 	NULL,
 };
 
 static const struct attribute_group w1_ds2780_group = {
-	.bin_attrs = w1_ds2780_bin_attrs,
+	.bin_attrs_new = w1_ds2780_bin_attrs,
 };
 
 static const struct attribute_group *w1_ds2780_groups[] = {

-- 
2.47.1


