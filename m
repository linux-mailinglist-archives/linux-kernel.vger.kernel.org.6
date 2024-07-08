Return-Path: <linux-kernel+bounces-244026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9A2929E23
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EAE12841F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4DA481B4;
	Mon,  8 Jul 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xmYofk82"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D57B45BEF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720426557; cv=none; b=QiCfEy1YgTKCV0xuxyKxFG6afqfLtqk7Wn4d9qNzXqYkgwgkIjNyEzqxkXVTakvtUuXB3Kk0ltHCz2lVPTZ4gcuwXaVHsZbqqud2XVMq/lplAvJ/W44DCCOO+McxSPnzvaUr1ysKgfaioiqoN9p0An+s8vVOel7wKJsSN25gyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720426557; c=relaxed/simple;
	bh=xAWtMk7tdjyeWc6UwS9Gy+6A7OB9syVCXQ+jAAaznA4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lKI+MOP5rpQUZrBldpD+t2tp8537RH7Z21ihxHBPpcjwx6GrEJyI9khdgqDdeaxie2i7cKjb0MwPA9tJEpGGXD80YrKsko7B02Wv84DpOtSUuNMD61ywTqOWNNs6lZRMXzbTR+Rw2O1hUXjKdI35xPCvD9V1vSLff0Yg7buugHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xmYofk82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FDBC4AF0B;
	Mon,  8 Jul 2024 08:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720426557;
	bh=xAWtMk7tdjyeWc6UwS9Gy+6A7OB9syVCXQ+jAAaznA4=;
	h=From:To:Cc:Subject:Date:From;
	b=xmYofk82FZ/47WynvR8NobBdxCMyN7TD2Wb6Kn9xqW+G8QOb5+PAsTZEdpO9A4O9w
	 6vxZ3nWxs1dugrkGkbIn59JJPFSUyGLirL+LHwulq1ewKTM+u1BnE1UwNt8EMxpcKn
	 S/u63XtvsfChFxL3xSRnY7k9o8mjhd/KIn38c/r0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 1/3] driver core: make driver_[create|remove]_file take a const *
Date: Mon,  8 Jul 2024 10:15:45 +0200
Message-ID: <2024070844-volley-hatchling-c812@gregkh>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 53
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=xAWtMk7tdjyeWc6UwS9Gy+6A7OB9syVCXQ+jAAaznA4=; b=kA0DAAIRMUfUDdst+ykByyZiAGaLoDGg9pIv1A0XKWiw00BjoYtwfRXaAFdM0d1ZkIb4xoCC8 YhdBAARAgAdFiEE9LYMxb94wiFKMT3LMUfUDdst+ykFAmaLoDEACgkQMUfUDdst+yngUACfTfFl Qdmw/WcdB83G6wOpg4Ciz10AoK9VUlxcwJrp8i8DwbBZkbGkIxDZ
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The functions driver_create_file() and driver_remove_file() do not
modify the struct device_driver structure directly, so they are safe to
be marked as a constant pointer type.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/driver.c         | 4 ++--
 include/linux/device/driver.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 85b4c00df078..3eeafdb79d0e 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -173,7 +173,7 @@ EXPORT_SYMBOL_GPL(driver_find_device);
  * @drv: driver.
  * @attr: driver attribute descriptor.
  */
-int driver_create_file(struct device_driver *drv,
+int driver_create_file(const struct device_driver *drv,
 		       const struct driver_attribute *attr)
 {
 	int error;
@@ -191,7 +191,7 @@ EXPORT_SYMBOL_GPL(driver_create_file);
  * @drv: driver.
  * @attr: driver attribute descriptor.
  */
-void driver_remove_file(struct device_driver *drv,
+void driver_remove_file(const struct device_driver *drv,
 			const struct driver_attribute *attr)
 {
 	if (drv)
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index 7738f458995f..dceb36f1c42c 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -146,9 +146,9 @@ struct driver_attribute {
 #define DRIVER_ATTR_WO(_name) \
 	struct driver_attribute driver_attr_##_name = __ATTR_WO(_name)
 
-int __must_check driver_create_file(struct device_driver *driver,
+int __must_check driver_create_file(const struct device_driver *driver,
 				    const struct driver_attribute *attr);
-void driver_remove_file(struct device_driver *driver,
+void driver_remove_file(const struct device_driver *driver,
 			const struct driver_attribute *attr);
 
 int driver_set_override(struct device *dev, const char **override,

base-commit: 997197b58bf6e22b8c6ef88a168d8292fa9acec9
-- 
2.45.2


