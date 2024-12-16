Return-Path: <linux-kernel+bounces-447252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 791D09F2FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 12:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C034169D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90A206286;
	Mon, 16 Dec 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TIC7WH5F"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF2205ABE
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348789; cv=none; b=dsVCbAwGvdn8RpBvxOtj2nJqoY9LHuP4Fx/WfD5XICHo4OioQfUz5uqBx7ijQ83WDb0wRYOYFZYn9kDIcWtq0KRIoyqI/CMiLZ5JiPzjt1o7aMx1B94P74MvErUtY5DXwna9CRUIBwBvTXRj9mCdkqGWrXGSA6zlJQv6ERG7u0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348789; c=relaxed/simple;
	bh=YZVj6n6MUOQkXt6QAAL170xdLVYk+e61jPPq6fs3yDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qmv2vrN4hqYLEx7mhYVTu2pJsHySP0spcc7btOFi2cK4WTkSeP1/LHuewdzM+Own9YxT95okwzaAEHLTp7psgUu0rE0LDEz0vwnz7Mnj0u9uCXCS7J2ZdTRUnygAmyZjQyD6fF/y1lJU2HuvTt2tlNgbW+2u9t6xYP5nCgzhclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TIC7WH5F; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734348781;
	bh=YZVj6n6MUOQkXt6QAAL170xdLVYk+e61jPPq6fs3yDY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TIC7WH5Fs7auSpnyx7AvYOMl5F9RiWBqyIEoEIz3GN1JNKyDGkvU+153FtDvWNHT3
	 Wgivpato4Er2WPrPKdIxaIT9urCsfOZ57wD1iC730eyKrUZsNzn03bbgSPUPiZmB4X
	 46ZSGOChSO6kSD539ppaY28qRuaFWxO1ZZxWDuNo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 16 Dec 2024 12:32:57 +0100
Subject: [PATCH 2/9] cxl: Constify 'struct bin_attribute'
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241216-sysfs-const-bin_attr-misc-drivers-v1-2-d50ff7b21367@weissschuh.net>
References: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-misc-drivers-v1-0-d50ff7b21367@weissschuh.net>
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734348781; l=2071;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YZVj6n6MUOQkXt6QAAL170xdLVYk+e61jPPq6fs3yDY=;
 b=dKNk6Ka86NjpVyOFYNLfo8D+1J/kscX1zKth6ShzAMoKs/hjMigT19zGTS2WtWemS12t34x+x
 XnZDPED1MGfDFY7A1fBBmrf6KXKrav90FMeUx1R6RrqaWJ0Yk6jMhAm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs core now allows instances of 'struct bin_attribute' to be
moved into read-only memory. Make use of that to protect them against
accidental or malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/misc/cxl/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/sysfs.c b/drivers/misc/cxl/sysfs.c
index 409bd1c39663159a0d11c3ccba2aa5a8451baa34..b1fc6446bd4b7caa2f5c6e23e0aba5934caffd46 100644
--- a/drivers/misc/cxl/sysfs.c
+++ b/drivers/misc/cxl/sysfs.c
@@ -444,7 +444,7 @@ static ssize_t api_version_compatible_show(struct device *device,
 }
 
 static ssize_t afu_eb_read(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
+			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count)
 {
 	struct cxl_afu *afu = to_cxl_afu(kobj_to_dev(kobj));
@@ -538,7 +538,7 @@ static ssize_t class_show(struct kobject *kobj,
 }
 
 static ssize_t afu_read_config(struct file *filp, struct kobject *kobj,
-			       struct bin_attribute *bin_attr, char *buf,
+			       const struct bin_attribute *bin_attr, char *buf,
 			       loff_t off, size_t count)
 {
 	struct afu_config_record *cr = to_cr(kobj);
@@ -620,7 +620,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int c
 	cr->config_attr.attr.name = "config";
 	cr->config_attr.attr.mode = S_IRUSR;
 	cr->config_attr.size = afu->crs_len;
-	cr->config_attr.read = afu_read_config;
+	cr->config_attr.read_new = afu_read_config;
 
 	rc = kobject_init_and_add(&cr->kobj, &afu_config_record_type,
 				  &afu->dev.kobj, "cr%i", cr->cr);
@@ -693,7 +693,7 @@ int cxl_sysfs_afu_add(struct cxl_afu *afu)
 		afu->attr_eb.attr.name = "afu_err_buff";
 		afu->attr_eb.attr.mode = S_IRUGO;
 		afu->attr_eb.size = afu->eb_len;
-		afu->attr_eb.read = afu_eb_read;
+		afu->attr_eb.read_new = afu_eb_read;
 
 		rc = device_create_bin_file(&afu->dev, &afu->attr_eb);
 		if (rc) {

-- 
2.47.1


