Return-Path: <linux-kernel+bounces-441787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65409ED414
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0881888DF3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D522689C;
	Wed, 11 Dec 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o/n0myEd"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D320468B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939434; cv=none; b=KK2Mrw+s48aupWz9XNJh3/gzMKJSbWNlGFppHZ+aITIBy2ZgXg/13uA58K2NBcbDHFxHQLYlUvp394JANBdUkV8I3B4b8E0lhgqDKEUggQbmGCFBH4Rk28QpczpTexOfNcVMlXG5kQwz5LHjHjft2KGtdcOkAXftvGE6ejSQn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939434; c=relaxed/simple;
	bh=2Ok+j45K8wKtGWNRe98OVgySAaImjbysWId+0805zSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l7mVJRHU5m/0WlLl0TlR7GpRzZua21mfM8mz8/7Y15rbfJnHq1QjG/EARMXrkPPrQFkD5natpVjOoRPXE05KDYl2RG5TMc+wn6CS9CQpk25vgV3X7+28DA2TfrCQDhRaB3uYP7b/EKOcG062vykqWWCn3d5Z/9k2wh2Oan+zW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o/n0myEd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939419;
	bh=2Ok+j45K8wKtGWNRe98OVgySAaImjbysWId+0805zSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o/n0myEdZCRslFbZjvwWSof1qJJLcJeRmLyO5NF3S4TOBH6opqfs2vwjzmnrNiZgl
	 WW8zRVSKlaU2e3zzlBPtcsSBU7N/KZhT3gSFeZI6BytFMpIgGVCbyoiz/zWnYR0XXY
	 4fpR8m+PoQBkbxxF2Aq7wMBzp62AMQPzj+01e5X8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:26 +0100
Subject: [PATCH 11/12] w1: ds2805: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-11-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939418; l=1842;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2Ok+j45K8wKtGWNRe98OVgySAaImjbysWId+0805zSU=;
 b=Pr9wejeUDNYqNNnEmI7g5w7SFdXh6PtHTu1+v6sE9xwht3tIWtRy8MapaMYGAAT8ZPK/x6wMT
 N7wMcy0TZDEApr+i8GDcgRMhGF+jQtGhKTDUCXfXHXcwBQ8HT4w2qFO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/slaves/w1_ds2805.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/w1/slaves/w1_ds2805.c b/drivers/w1/slaves/w1_ds2805.c
index 4c1a2c51531779b2a10e136e25309171e697d89f..6ee895640d4ac781281e48ed01d9cb20cb71637c 100644
--- a/drivers/w1/slaves/w1_ds2805.c
+++ b/drivers/w1/slaves/w1_ds2805.c
@@ -92,7 +92,7 @@ static int w1_f0d_readblock(struct w1_slave *sl, int off, int count, char *buf)
 }
 
 static ssize_t w1_f0d_read_bin(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
+			       const struct bin_attribute *bin_attr,
 			       char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -200,7 +200,7 @@ static int w1_f0d_write(struct w1_slave *sl, int addr, int len, const u8 *data)
 }
 
 static ssize_t w1_f0d_write_bin(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -261,14 +261,14 @@ static ssize_t w1_f0d_write_bin(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static struct bin_attribute w1_f0d_bin_attr = {
+static const struct bin_attribute w1_f0d_bin_attr = {
 	.attr = {
 		.name = "eeprom",
 		.mode = 0644,
 	},
 	.size = W1_F0D_EEPROM_SIZE,
-	.read = w1_f0d_read_bin,
-	.write = w1_f0d_write_bin,
+	.read_new = w1_f0d_read_bin,
+	.write_new = w1_f0d_write_bin,
 };
 
 static int w1_f0d_add_slave(struct w1_slave *sl)

-- 
2.47.1


