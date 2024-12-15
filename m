Return-Path: <linux-kernel+bounces-446421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE49F242A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412D3164417
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A90183CA6;
	Sun, 15 Dec 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o09sem4f"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90181D696
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734268771; cv=none; b=FVRlHo7josfyKSGAqZNaE59uPLjX7GlayaWS9Oq3nGHgdNYX2e3Hk0H7JzEJ628Qy22DwajMk9xEbFSPnOISlwr22Qm0kDFfTkBYMMCLufmcVKgAttslIf3lLSYe7nBoHoCTYfdwEQLDa6ENEW0VgMcXDvu3aMWBolbNwfpm89o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734268771; c=relaxed/simple;
	bh=R9rEHspKHTY4a2VWa5IICYt2eibwitOEL7/37dUjcfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N72PjDI6m7pwnmWPW+8CB6xCwQA5z+yhTkYw0q7yUX3lSqZwxjNYGx3EXg096Wl+0MspRUNWVhKTzcKPF9bWlZM70A45gjvYkPC7hlDpARoDoIIU1sZ57Uz4kUzcHc2/TQf9V34Mhw81Q3j4iKvarVHoTCnK+3N15nUpnT+yucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o09sem4f; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734268757;
	bh=R9rEHspKHTY4a2VWa5IICYt2eibwitOEL7/37dUjcfU=;
	h=From:Date:Subject:To:Cc:From;
	b=o09sem4fTqUXy8BVE3huEp4S36VH/VqxVlRAeu7F+bS+g5aDuC/smeXV41/VfqdVT
	 iQfaR++e4FxVKH6JWBMf7D3DdD+4cbH9phxeuTpeWnNEwyn7QuG479mN33bxIuAXFB
	 QkH4R9qJZuEnt3470Fy1ud4Zu1hvN2nef71kHTdU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 14:18:59 +0100
Subject: [PATCH] pcmcia: cistpl: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-pcmcia-v1-1-ebb82e47d834@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAELXXmcC/x3MQQqEMAwAwK9IzhuwRVH8yrIsbRo1B6s0RRTx7
 xaPc5kLlJOwwlBdkHgXlTUWmE8FNLs4MUooBlvbxljTop46KtIaNaOX+Hc5J9xoIXHoQxdCwz2
 11kAZtsSjHO/+/d33AzADtmZtAAAA
X-Change-ID: 20241215-sysfs-const-bin_attr-pcmcia-bd7dd4e8c521
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734268756; l=1778;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=R9rEHspKHTY4a2VWa5IICYt2eibwitOEL7/37dUjcfU=;
 b=eQf2ZpwtBcsTL0MF0s2dO+sRcrAR6mO0rEuRchVLkqXlgq8O2KdJvRi/BxVTlYFgyHwgUXv37
 C17i90rOJC0CT4tIiMwKAhWaq46+/9rcfa0Wxaed+Qc44ZitmJTh7MA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/pcmcia/cistpl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pcmcia/cistpl.c b/drivers/pcmcia/cistpl.c
index d018f36f3a8935630f88a627d7241025f24b5be9..0c801e4ccc6c2c8701ecf855e10a67a677c85278 100644
--- a/drivers/pcmcia/cistpl.c
+++ b/drivers/pcmcia/cistpl.c
@@ -1540,7 +1540,7 @@ static ssize_t pccard_extract_cis(struct pcmcia_socket *s, char *buf,
 
 
 static ssize_t pccard_show_cis(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr,
+			       const struct bin_attribute *bin_attr,
 			       char *buf, loff_t off, size_t count)
 {
 	unsigned int size = 0x200;
@@ -1571,7 +1571,7 @@ static ssize_t pccard_show_cis(struct file *filp, struct kobject *kobj,
 
 
 static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
-				struct bin_attribute *bin_attr,
+				const struct bin_attribute *bin_attr,
 				char *buf, loff_t off, size_t count)
 {
 	struct pcmcia_socket *s;
@@ -1605,6 +1605,6 @@ static ssize_t pccard_store_cis(struct file *filp, struct kobject *kobj,
 const struct bin_attribute pccard_cis_attr = {
 	.attr = { .name = "cis", .mode = S_IRUGO | S_IWUSR },
 	.size = 0x200,
-	.read = pccard_show_cis,
-	.write = pccard_store_cis,
+	.read_new = pccard_show_cis,
+	.write_new = pccard_store_cis,
 };

---
base-commit: 2d8308bf5b67dff50262d8a9260a50113b3628c6
change-id: 20241215-sysfs-const-bin_attr-pcmcia-bd7dd4e8c521

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


