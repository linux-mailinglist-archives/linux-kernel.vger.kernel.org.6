Return-Path: <linux-kernel+bounces-417236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82AB9D5105
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F58D1F26750
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C03919D881;
	Thu, 21 Nov 2024 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Elh2rBJQ"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BD2155CBF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208152; cv=none; b=CmfNM0jXklGWnH/GxiYIeFjPGeksS0qcFnxKDHuaoDCn1N5xJq04lDHNLvK3CN6F7Xzic4g7H8TBsX1FXice6c+gIcHt838nXV8USrMYZz8XKQ2HICj/RA5JN3sye0BdLNPy0mxSLlTG8BTA7A5iotfr8xpf2LL7Yd5VMrD877s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208152; c=relaxed/simple;
	bh=lYn0VcRkPZbLFN/OpQkJZQViuEdrftiORuc/r5J5Tts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JlZQKnBZipt/fS/KNeI3yhwlt6fwzm+EH+sgdNk8uUuDT8+E/CNf17HPBX5Y/qjj8LzknGeZ5ZxSvKPWDHjNEcCr1QqU5/hznZ41WeSfix8rGnNruTcsHntXtlV9LvZQ+6sTsNr8njXhFrUH/XACpJ9aBxAkGhxorVFjeCohqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Elh2rBJQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732208144;
	bh=lYn0VcRkPZbLFN/OpQkJZQViuEdrftiORuc/r5J5Tts=;
	h=From:Date:Subject:To:Cc:From;
	b=Elh2rBJQ7JNfJ89zeSz7pJS2RQEzlvb/l5TPi7c1FsvG6ElIy5t7MYs3bn6SCMEA/
	 UxgblQ9Rzy5z0XmKgU6kZ1yJctw2boNJzhVV5FvN6p356JMVZKZKfcAMiSn3I0jm4P
	 GCwP1fIGWPGuQgqDuwalfZ/fK1olyI0ZLpAs9qao=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 21 Nov 2024 17:48:47 +0100
Subject: [PATCH] kernel/ksysfs.c: simplify bin_attribute definition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241121-sysfs-const-bin_attr-ksysfs-v1-1-972faced149d@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAG5kP2cC/y3M0QoCIRBA0V9Z5rkBFanYX1kiJh1rCDQcWQrx3
 5Po8dyH20G5CiusS4fKu6iUPGEPC4QH5TujxGlwxnlrnUX9aFIMJWvDm+QrtVbx+a+R/Mmc6Uj
 GwTy8Kid5/+7bZYwvJ3QmuW0AAAA=
X-Change-ID: 20241121-sysfs-const-bin_attr-ksysfs-cda4708a6a02
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732207729; l=1806;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=lYn0VcRkPZbLFN/OpQkJZQViuEdrftiORuc/r5J5Tts=;
 b=gEa50ts77hZCp2ar4edjEZNZ7lk5pNq8oCt8p3mqO8YOiBscUIzIg74etCblUd8E0FMpGbhhN
 ulNqJxSz+G7CgdkqmznZWjnX1cZuMLMVPlJbG/dz86dkpapMBHko+5R
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The notes attribute can be implemented in terms of BIN_ATTR_SIMPLE().
This saves memory at runtime and is a preparation for the constification
of struct bin_attribute.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/ksysfs.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index 1bab21b4718fffd9fa1c76d46827f44af870dd9d..eefb67d9883c2ca876023d75bb752b26a93a839b 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -239,21 +239,7 @@ extern const void __start_notes;
 extern const void __stop_notes;
 #define	notes_size (&__stop_notes - &__start_notes)
 
-static ssize_t notes_read(struct file *filp, struct kobject *kobj,
-			  struct bin_attribute *bin_attr,
-			  char *buf, loff_t off, size_t count)
-{
-	memcpy(buf, &__start_notes + off, count);
-	return count;
-}
-
-static struct bin_attribute notes_attr __ro_after_init  = {
-	.attr = {
-		.name = "notes",
-		.mode = S_IRUGO,
-	},
-	.read = &notes_read,
-};
+static __ro_after_init BIN_ATTR_SIMPLE_RO(notes);
 
 struct kobject *kernel_kobj;
 EXPORT_SYMBOL_GPL(kernel_kobj);
@@ -307,8 +293,9 @@ static int __init ksysfs_init(void)
 		goto kset_exit;
 
 	if (notes_size > 0) {
-		notes_attr.size = notes_size;
-		error = sysfs_create_bin_file(kernel_kobj, &notes_attr);
+		bin_attr_notes.private = (void *)&__start_notes;
+		bin_attr_notes.size = notes_size;
+		error = sysfs_create_bin_file(kernel_kobj, &bin_attr_notes);
 		if (error)
 			goto group_exit;
 	}

---
base-commit: 43fb83c17ba2d63dfb798f0be7453ed55ca3f9c2
change-id: 20241121-sysfs-const-bin_attr-ksysfs-cda4708a6a02

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


