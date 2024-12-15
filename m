Return-Path: <linux-kernel+bounces-446450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789479F2471
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 15:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F98B1885EAF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAC4191F94;
	Sun, 15 Dec 2024 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dS6BGN6d"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2018E050
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734274159; cv=none; b=qGDEBit4YVE9TId4ZeSuH+MrDAIdnn9ms50vBZEWnMYfCmDF3WywJa/rRvT1YBIbK1QZoT9uQQRDsp2zBQbBf92OBI0I3vsMuDXtntZMxJCFp9Gky4q2bXKUGZ1/ODLbN0YXnaZ2CHQfhgJpiT2E7zmzEdhLA2xQoO9yrcMJR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734274159; c=relaxed/simple;
	bh=WLLl0SXp2QxmvD1/OoHCr/gA5uXOCZ9Y2YGLQhVDl4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aiGeAAiDEDorStgnmOdt8y0Yq/eTtRgRPd9v6mZMPn9Xsv54YjWMHVsHkwZtnXsDx4fGRhBlmPWPhN4cxwxIh5uZli6sejKXAWN0p5st3x1Pu4WWAoqHq5fp9JnGMq2OmiYuSQEodMyY4f90ELejjAcNRcWwGiGAXMOnraha7bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dS6BGN6d; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734274154;
	bh=WLLl0SXp2QxmvD1/OoHCr/gA5uXOCZ9Y2YGLQhVDl4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dS6BGN6d3DlsD5DTIEYhmwPuix1uiCp8OSaRbOgXHat0v9chIV4ZFUfz/jEfsM04B
	 S1SVKDnAenBUee1bZ3nk59i5IqGo4TB9gtMMrfoZ+b+ZdptUKvbFbo0mDOTdKdAJCU
	 gO4ShP8n5Hbpf+EnKAHiNoIiAoYsCtFks49DGQCQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 15 Dec 2024 15:49:12 +0100
Subject: [PATCH 4/4] firmware: google: vpd: Use const 'struct
 bin_attribute' callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241215-sysfs-const-bin_attr-google-v1-4-e5c2808f5833@weissschuh.net>
References: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
In-Reply-To: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734274153; l=3481;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WLLl0SXp2QxmvD1/OoHCr/gA5uXOCZ9Y2YGLQhVDl4s=;
 b=JnFxNi5bWLzCfBERDYtH86MY5DNmcQ9bY8COJI+GLalpI7cZQmFWf8FjrDl03KEuxUiLc4uvT
 TWrSRh5uiYbD/QL8mUOJOJz09vNs03PnzF70MIFJvYM3gcyWao/j7Ri
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now provides callback variants that explicitly take a
const pointer. Use them so the non-const variants can be removed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
The custom read functions could also just be replaced by
sysfs_bin_attr_simple_read(). See below.
That would slightly conflict with another series of mine [0],
bute the resolution would be trivial.

[0] https://lore.kernel.org/lkml/20241205-sysfs-const-bin_attr-simple-v1-0-4a4e4ced71e3@weissschuh.net/

	diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
	index 254ac6545d68..1ce9a7af635e 100644
	--- a/drivers/firmware/google/vpd.c
	+++ b/drivers/firmware/google/vpd.c
	@@ -121,8 +111,8 @@ static int vpd_section_attrib_add(const u8 *key, u32 key_len,
		info->bin_attr.attr.name = info->key;
		info->bin_attr.attr.mode = 0444;
		info->bin_attr.size = value_len;
	-	info->bin_attr.read_new = vpd_attrib_read;
	-	info->bin_attr.private = info;
	+	info->bin_attr.read = sysfs_bin_attr_simple_read;
	+	info->bin_attr.private = (void *)info->value;

		info->value = value;

	 static int vpd_section_create_attribs(struct vpd_section *sec)
	 {
		s32 consumed;
	@@ -201,8 +181,8 @@ static int vpd_section_init(const char *name, struct vpd_section *sec,
		sec->bin_attr.attr.name = sec->raw_name;
		sec->bin_attr.attr.mode = 0444;
		sec->bin_attr.size = size;
	-	sec->bin_attr.read_new = vpd_section_read;
	-	sec->bin_attr.private = sec;
	+	sec->bin_attr.read = sysfs_bin_attr_simple_read;
	+	sec->bin_attr.private = sec->baseaddr;

		err = sysfs_create_bin_file(vpd_kobj, &sec->bin_attr);
		if (err)
---
 drivers/firmware/google/vpd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
index 1749529f63d449dd88e90e12ac6e50ad8f15450d..254ac6545d680ac099ae2efa3c2109c9eb8c41be 100644
--- a/drivers/firmware/google/vpd.c
+++ b/drivers/firmware/google/vpd.c
@@ -56,7 +56,7 @@ static struct vpd_section ro_vpd;
 static struct vpd_section rw_vpd;
 
 static ssize_t vpd_attrib_read(struct file *filp, struct kobject *kobp,
-			       struct bin_attribute *bin_attr, char *buf,
+			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t pos, size_t count)
 {
 	struct vpd_attrib_info *info = bin_attr->private;
@@ -121,7 +121,7 @@ static int vpd_section_attrib_add(const u8 *key, u32 key_len,
 	info->bin_attr.attr.name = info->key;
 	info->bin_attr.attr.mode = 0444;
 	info->bin_attr.size = value_len;
-	info->bin_attr.read = vpd_attrib_read;
+	info->bin_attr.read_new = vpd_attrib_read;
 	info->bin_attr.private = info;
 
 	info->value = value;
@@ -156,7 +156,7 @@ static void vpd_section_attrib_destroy(struct vpd_section *sec)
 }
 
 static ssize_t vpd_section_read(struct file *filp, struct kobject *kobp,
-				struct bin_attribute *bin_attr, char *buf,
+				const struct bin_attribute *bin_attr, char *buf,
 				loff_t pos, size_t count)
 {
 	struct vpd_section *sec = bin_attr->private;
@@ -201,7 +201,7 @@ static int vpd_section_init(const char *name, struct vpd_section *sec,
 	sec->bin_attr.attr.name = sec->raw_name;
 	sec->bin_attr.attr.mode = 0444;
 	sec->bin_attr.size = size;
-	sec->bin_attr.read = vpd_section_read;
+	sec->bin_attr.read_new = vpd_section_read;
 	sec->bin_attr.private = sec;
 
 	err = sysfs_create_bin_file(vpd_kobj, &sec->bin_attr);

-- 
2.47.1


