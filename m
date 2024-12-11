Return-Path: <linux-kernel+bounces-441777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC29ED40A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 18:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD82B188881E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B921FF5F7;
	Wed, 11 Dec 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="im1eIwNn"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5921FF1CB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733939429; cv=none; b=sIm6gyrsRnl3YuUP3vg+Ave1AQVhx8lR+IO/XdAnuKqd9IFF9dwWWDOf7mcf8CfSdyE/GqTbQ7U+qVv9qgfsyIHaOonBK2BtRI/X7O2k8iu1vYGMq4dHfUfiQeLe5J0sEoknmroqkcq6psqfpBS6BkbTJ79/hDuq2+Vw4bOZQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733939429; c=relaxed/simple;
	bh=bUyjneqJ82qE5Q2Egopw9U+eU3xunsYhHtD2ie3mmk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wo7al96Ihz3hXQy9xCzGvbR6JmeO51juHCrTwJhgn0zIXRyQw7JlZ2t8QCPQXefEG4mDdGmC+n74KbdzgTqneH88uES1XoDDup34ozlorTRWB3dhKfne7CYpqS2K1Y9+hsIfpYkyxZU1MHPQGtIY07tGw0uNI43b9q+W6Er/gw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=im1eIwNn; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733939418;
	bh=bUyjneqJ82qE5Q2Egopw9U+eU3xunsYhHtD2ie3mmk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=im1eIwNnwsh8MMLIExg0wHJPZDpx5LjBmfm7cPoH51b6WQq6Q/ok/e5cUv/hbsU6U
	 +FqLWDIpfzcMi3V7irAY9Wa7FgMmyPAzAoiwiiuLrtCcmyh8PSD5xh0bOiWsx8SXed
	 CK7hy8pdfpEJZ5WhjMAtOXKVX95gGXqqVmrMKa0o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 11 Dec 2024 18:50:16 +0100
Subject: [PATCH 01/12] w1: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-sysfs-const-bin_attr-w1-v1-1-c4befd2aa7cc@weissschuh.net>
References: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
In-Reply-To: <20241211-sysfs-const-bin_attr-w1-v1-0-c4befd2aa7cc@weissschuh.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733939417; l=1851;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bUyjneqJ82qE5Q2Egopw9U+eU3xunsYhHtD2ie3mmk8=;
 b=qiT2xdoVK6rzPO+5T0xUR2tWN6luxWoaCaiaT8kMD2UmLlybHwKKPz6Lk+udvI62SGltDfRFn
 txQViJKz0czC/EuP0YFP7MvoIsNDGNsHfm1JbXSTa6bh5V4wMOB+iY0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/w1/w1.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index d82e86d3ddf6429878a50bd9418845ee57667ae1..29f200bbab41f41948388635e0f1790ec39ca417 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -111,7 +111,7 @@ ATTRIBUTE_GROUPS(w1_slave);
 /* Default family */
 
 static ssize_t rw_write(struct file *filp, struct kobject *kobj,
-			struct bin_attribute *bin_attr, char *buf, loff_t off,
+			const struct bin_attribute *bin_attr, char *buf, loff_t off,
 			size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
@@ -130,8 +130,8 @@ static ssize_t rw_write(struct file *filp, struct kobject *kobj,
 }
 
 static ssize_t rw_read(struct file *filp, struct kobject *kobj,
-		       struct bin_attribute *bin_attr, char *buf, loff_t off,
-		       size_t count)
+		       const struct bin_attribute *bin_attr, char *buf,
+		       loff_t off, size_t count)
 {
 	struct w1_slave *sl = kobj_to_w1_slave(kobj);
 
@@ -141,15 +141,15 @@ static ssize_t rw_read(struct file *filp, struct kobject *kobj,
 	return count;
 }
 
-static BIN_ATTR_RW(rw, PAGE_SIZE);
+static const BIN_ATTR_RW(rw, PAGE_SIZE);
 
-static struct bin_attribute *w1_slave_bin_attrs[] = {
+static const struct bin_attribute *const w1_slave_bin_attrs[] = {
 	&bin_attr_rw,
 	NULL,
 };
 
 static const struct attribute_group w1_slave_default_group = {
-	.bin_attrs = w1_slave_bin_attrs,
+	.bin_attrs_new = w1_slave_bin_attrs,
 };
 
 static const struct attribute_group *w1_slave_default_groups[] = {

-- 
2.47.1


