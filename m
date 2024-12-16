Return-Path: <linux-kernel+bounces-447310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030A9F3060
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 13:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C2A16709D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C5F204C02;
	Mon, 16 Dec 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j/wMSdQd"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47EB202F7E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734351633; cv=none; b=tghxKNIQaqUdLPbQhqFC6liZsh2RbscwTZK0r6yqzkwlOOJ9k1NFDhkt6DAX0yBTmS5SovDpcPNbEfDI/vu3geeWYEpGANQlIac+sOUzBcxuJKD78Gy5IN/VElvhwKCk/zLN/An+WnB/atsa/4UigjG9ga9eZwzvibvF8F0HzsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734351633; c=relaxed/simple;
	bh=6uSzS295pBUph9/CaqG8BNCeLzLkb5Xo0dFAAPEqQAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AxbltXi85nKzy5BImiV/Uet2mQkOXDRIJStDPnqWG3luK3HCHGXXhmlI/ocKWFjH+YyEl8nJN+lGQAs+M1hwM2haIzgyIbeXM6v9Dem/JPG6mLFY5tHVlRLEhmTdX70698S9rxfE3aHhxRZZ5lW0Ir5mderqqgPCGb3FzTsfjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j/wMSdQd; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734351628;
	bh=6uSzS295pBUph9/CaqG8BNCeLzLkb5Xo0dFAAPEqQAI=;
	h=From:Date:Subject:To:Cc:From;
	b=j/wMSdQdDGGFIzx0EsKaPKVvzdrbfybSr8XN5+ubf30Z0VpxqWk8m+s/Z6np1Zagb
	 BrIruhNYbv8Dz8C4IikA4iTTAbtVtinJ8EAsCCPC/hOhVBP/Vxtzd7E3Kq1FDxrLKZ
	 wBEmKtO2D87rKXIQdiFGcOG3hCmnKiBHiYev7t1s=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 13:20:25 +0100
Subject: [PATCH] mm/page_idle: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-page_idle-v1-1-cc01ecc55196@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAAgbYGcC/x3NQQqDMBBG4avIrDtgglrsVUoJUf/YAYmSCdIi3
 t3g8tu8d5AiCZRe1UEJu6isscA8Khq/Ps5gmYrJ1rYx1nSsfw3K4xo18yDR+ZwTb36Gk2kBt/B
 Dhx7POgQqkS0hyO8evD/neQFRxlU1cAAAAA==
X-Change-ID: 20241216-sysfs-const-bin_attr-page_idle-5eab6e9e70ff
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734351627; l=2099;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6uSzS295pBUph9/CaqG8BNCeLzLkb5Xo0dFAAPEqQAI=;
 b=sSim89Ek+/uC5QVd1ArbYMoQroruCbMMnZhJ0yx4TrtO6A5rtACkY3y/xeO6kDGF7KhKkdnSj
 ykCcV1XTL/qCU7lrHaYDx/OLG+XChsgtW6/IXafZhjzeqKRfueekR6z
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 mm/page_idle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 41ea77f22011ebc88cd0fe1e40abad6d11ff9b08..947c7c7a37289ad386f140047f733d4388833546 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -112,7 +112,7 @@ static void page_idle_clear_pte_refs(struct folio *folio)
 }
 
 static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
-				     struct bin_attribute *attr, char *buf,
+				     const struct bin_attribute *attr, char *buf,
 				     loff_t pos, size_t count)
 {
 	u64 *out = (u64 *)buf;
@@ -157,7 +157,7 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 }
 
 static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
-				      struct bin_attribute *attr, char *buf,
+				      const struct bin_attribute *attr, char *buf,
 				      loff_t pos, size_t count)
 {
 	const u64 *in = (u64 *)buf;
@@ -193,17 +193,17 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	return (char *)in - buf;
 }
 
-static struct bin_attribute page_idle_bitmap_attr =
+static const struct bin_attribute page_idle_bitmap_attr =
 		__BIN_ATTR(bitmap, 0600,
 			   page_idle_bitmap_read, page_idle_bitmap_write, 0);
 
-static struct bin_attribute *page_idle_bin_attrs[] = {
+static const struct bin_attribute *const page_idle_bin_attrs[] = {
 	&page_idle_bitmap_attr,
 	NULL,
 };
 
 static const struct attribute_group page_idle_attr_group = {
-	.bin_attrs = page_idle_bin_attrs,
+	.bin_attrs_new = page_idle_bin_attrs,
 	.name = "page_idle",
 };
 

---
base-commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
change-id: 20241216-sysfs-const-bin_attr-page_idle-5eab6e9e70ff

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


