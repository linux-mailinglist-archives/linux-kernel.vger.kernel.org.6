Return-Path: <linux-kernel+bounces-428273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70049E0C48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7917C282A9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211F1DED4D;
	Mon,  2 Dec 2024 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="V3u6b9gg"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBF21DE3BC;
	Mon,  2 Dec 2024 19:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168321; cv=none; b=uU/z9btP3Q4Jx0mpCpx9sziWZAvMAlCw758hc98TlxlmZa/xDNFHxfRVZudVHPJ5aTNHx4sKVX0rX/dkyyMPwOXNiOmFRg9LHY1ghJ9yaFkdE76UWJrdsmuHsVaeBjYDvYfaKjpCZ4UYrvIeAPSDwxR0+4tzfOlY/BSrMEyo/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168321; c=relaxed/simple;
	bh=YsbcgpRFOi+cY43e/Gwc75c9FlqZyz0+ZOwZ6DhkDSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dX+UYtEymbuB0gMTXvpWp7fTWNaC5cm/qAItTTQvgM34YmgJj3Meofl3pYFzuquTnLTeuXWpRCKHSZ1TdwZpVns/yjOCA7nYu/envhFqulgZojiJc404p/WiH0S+uQgnLg7Hrr4Bq3/kjFFUlgW8pjhAl1pDshS4xRcSQEGBq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=V3u6b9gg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733168316;
	bh=YsbcgpRFOi+cY43e/Gwc75c9FlqZyz0+ZOwZ6DhkDSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V3u6b9ggz5UxbedruQ9U8mCgaUyqq/thMPo8C9kcwjSbkjjETaYTAnzNjeOpyMLz/
	 126gqxxY3WhHelteRYnRz3sNzQUh1LFqLtCSIrDUlYi13CVXFcc/mec4FbkKI+PysA
	 9pIq22l2BfckIt5p29IxYKQi5rWzrqZA+gw/jAsI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 20:38:33 +0100
Subject: [PATCH 2/5] platform/x86: dell_rbu: Constify 'struct
 bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-sysfs-const-bin_attr-pdx86-v1-2-9ab204c2a814@weissschuh.net>
References: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
In-Reply-To: <20241202-sysfs-const-bin_attr-pdx86-v1-0-9ab204c2a814@weissschuh.net>
To: Stuart Hayes <stuart.w.hayes@gmail.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 "David E. Box" <david.e.box@linux.intel.com>, 
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168316; l=3353;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YsbcgpRFOi+cY43e/Gwc75c9FlqZyz0+ZOwZ6DhkDSI=;
 b=FzqPL1axoOZTDBRkK5+Wfehj/Z+2MZfHleJLbw9zuoeB4O4Jp3P2DWebZ0f4j0f3MFJvpsqtW
 oaIF99Yxm1aCBmsNsuvvP+8ESgB84DV2fweV3+t45OwkEBbN7+tuH5w
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/dell/dell_rbu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/dell/dell_rbu.c b/drivers/platform/x86/dell/dell_rbu.c
index 9f51e0fcab04e1c61ce68b90b754b6b43a741b58..e30ca325938cb604560a810e7d63f65b4b70964b 100644
--- a/drivers/platform/x86/dell/dell_rbu.c
+++ b/drivers/platform/x86/dell/dell_rbu.c
@@ -475,7 +475,7 @@ static ssize_t read_rbu_mono_data(char *buffer, loff_t pos, size_t count)
 }
 
 static ssize_t data_read(struct file *filp, struct kobject *kobj,
-			 struct bin_attribute *bin_attr,
+			 const struct bin_attribute *bin_attr,
 			 char *buffer, loff_t pos, size_t count)
 {
 	ssize_t ret_count = 0;
@@ -492,7 +492,7 @@ static ssize_t data_read(struct file *filp, struct kobject *kobj,
 	spin_unlock(&rbu_data.lock);
 	return ret_count;
 }
-static BIN_ATTR_RO(data, 0);
+static const BIN_ATTR_RO(data, 0);
 
 static void callbackfn_rbu(const struct firmware *fw, void *context)
 {
@@ -530,7 +530,7 @@ static void callbackfn_rbu(const struct firmware *fw, void *context)
 }
 
 static ssize_t image_type_read(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
+			       const struct bin_attribute *bin_attr,
 			       char *buffer, loff_t pos, size_t count)
 {
 	int size = 0;
@@ -540,7 +540,7 @@ static ssize_t image_type_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t image_type_write(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buffer, loff_t pos, size_t count)
 {
 	int rc = count;
@@ -597,10 +597,10 @@ static ssize_t image_type_write(struct file *filp, struct kobject *kobj,
 
 	return rc;
 }
-static BIN_ATTR_RW(image_type, 0);
+static const BIN_ATTR_RW(image_type, 0);
 
 static ssize_t packet_size_read(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buffer, loff_t pos, size_t count)
 {
 	int size = 0;
@@ -613,7 +613,7 @@ static ssize_t packet_size_read(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t packet_size_write(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
+				 const struct bin_attribute *bin_attr,
 				 char *buffer, loff_t pos, size_t count)
 {
 	unsigned long temp;
@@ -626,9 +626,9 @@ static ssize_t packet_size_write(struct file *filp, struct kobject *kobj,
 	spin_unlock(&rbu_data.lock);
 	return count;
 }
-static BIN_ATTR_RW(packet_size, 0);
+static const BIN_ATTR_RW(packet_size, 0);
 
-static struct bin_attribute *rbu_bin_attrs[] = {
+static const struct bin_attribute *const rbu_bin_attrs[] = {
 	&bin_attr_data,
 	&bin_attr_image_type,
 	&bin_attr_packet_size,
@@ -636,7 +636,7 @@ static struct bin_attribute *rbu_bin_attrs[] = {
 };
 
 static const struct attribute_group rbu_group = {
-	.bin_attrs = rbu_bin_attrs,
+	.bin_attrs_new = rbu_bin_attrs,
 };
 
 static int __init dcdrbu_init(void)

-- 
2.47.1


