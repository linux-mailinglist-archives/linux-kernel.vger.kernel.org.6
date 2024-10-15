Return-Path: <linux-kernel+bounces-366627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F03E999F7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF872B21E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7961F76D2;
	Tue, 15 Oct 2024 20:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uq8bOfXN"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F41B6D04
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 20:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729023286; cv=none; b=QAz2vb85sdOqx8Espv6HjpDPcoomvEIOcBqNqIXxDY4mkNgQty2nzP0BSVibHMXjFcYClDnums0g5rXCNg4h1VgacD8iuewnHtLgEaU+C3ZvDdCkLSdn/DDpn2brqCdsXlNE07SwgmtUjYt9WotKqeHKETU0OjWdn6ChwdmbViQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729023286; c=relaxed/simple;
	bh=c/bKIOsvcd/ldDaqMA9ktiDp5SrgrMB7GIaoSV1abEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gn0IkOeOXEqXT8M26c17GKdykKcbO0X6kPlMpxHG183OSFkFBlTHE5sXWIANLc7UHmIY0PejdADaRdl38XJHMPhzdmqtsZsL1gdUb3Bnuc8Y96lRH55sC/ojpmwKTsUrUzq7b6yUHneoqbI49KkhhDuuzz4DQvZslazt6ydjJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uq8bOfXN; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e28b624bfcso85982707b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729023283; x=1729628083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UebaYyh75z6MJT0VxBr84RUXU8RvVMyK7KQq+4D8YPQ=;
        b=uq8bOfXNM/7352Zwkk/zvQNOp6m9WdK1nxwL+oBcN68GLgiuBkt4mOyXjz9KyJLJpR
         7F5sJ3YNsS65K3fcdXjBmuS0EPVcp7dE5GAq4w8Rh7tnOoPm8J0My/U8i5tyn0AprqNC
         hBV++fjr+Si6PZJK6Mb/YY49LTW36HtWdUvXW6Dg8PXXELXaGY6d3aqL55pIGbb+Uvcb
         Lico9Ulz/2NSCScW0I8Nud3c/YYcA5C2Qybs7aylvlzfPBKHcj1FGmGRnmqCDJ0Nr1+p
         BfIFbAnugVFkUj9baVkuyJd41htd8cC7+QtGZKGVa5nVTJ2ogBfn2fXfQFchAaZ6hQQY
         DBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729023283; x=1729628083;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UebaYyh75z6MJT0VxBr84RUXU8RvVMyK7KQq+4D8YPQ=;
        b=wa9DScvEo6g1mpNIDt8+mJ5wco9S65FNdstc+TMad/gwnm5e8vBVSjQ1mWEP3xTDCy
         b1mDeSevZsST1KiW6C6gDIau5i1dox1JMft0qK3qkyS95qVsZVmapxrLNP5mGlQug56E
         8MWR26OxBwpkG1eCaUAVskGJKzsMhoiYYmeQkzzDRcgvfPJ0r4sYHkC8bVhRv1gDmD/K
         pcpqqzlwFLTZbgDdWVwdkVLV6Fg3OGKiy/31LwSU0t+HX6nKaqeDd+3BXHkG/RuppyLN
         WyiOApEbDAXRe95VzlssjUc5qJdQiUox1gusj3PRXmiTJCU/azfx8HWN5Dm1JmgT91ak
         cpGA==
X-Gm-Message-State: AOJu0Yzm2pjwDgtRwddRqjLMBTMRnQMaDAN3IJCbN0Mv9TRJIae6TTAm
	yxjCyvzt5TBAA0JZHVRvEWE0AKvfKpVLGyWZEYXrHS6zrHiBou3ux8oafLwo/ZswcA8/ekLNML8
	MK5K+T/NsBaM2VVG1AxGcV9zywLPuTO4muzfrQPX+z1NHX0LhPGNgBVXnfxkiNk1jYiRhwMQ+3P
	HqE04RyWQcpujVfbjoN/F7AXzOqdaG7Mrr9ByqSG4IBU3TydnbW/gisu5Kf0ZrK+GEJSc=
X-Google-Smtp-Source: AGHT+IH3LV0vykkRQI21CsAiqWjAUAGcQV66bpXIuI+9nascUO4puiuz/cvcc+SQdRPIbWeMLCdflCLrFkG3djr7Qg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:690c:6906:b0:6e3:eda:5302 with
 SMTP id 00721157ae682-6e3d41e8268mr245337b3.8.1729023282687; Tue, 15 Oct 2024
 13:14:42 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:14:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241015201424.2914652-1-dionnaglaze@google.com>
Subject: [PATCH 1/1] firmware_loader: Move module refcounts to allow unloading
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ashish.Kalra@amd.com, Dionna Glaze <dionnaglaze@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

If a kernel module registers a firmware upload API ops set, then it's
unable to be moved due to effectively a cyclic reference that the module
depends on the upload which depends on the module.

Instead, only require the try_module_get when an upload is requested to
disallow unloading a module only while the upload is in progress.

CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/base/firmware_loader/sysfs_upload.c | 28 ++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 829270067d16..97b0ae855b5f 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -103,6 +103,10 @@ static ssize_t cancel_store(struct device *dev, struct device_attribute *attr,
 	if (fwlp->progress == FW_UPLOAD_PROG_IDLE)
 		ret = -ENODEV;
 
+	/*
+	 * Not idle, so fw_upload_start already called try_module_get.
+	 * No need to get/put around cancel.
+	 */
 	fwlp->ops->cancel(fwlp->fw_upload);
 	mutex_unlock(&fwlp->lock);
 
@@ -164,11 +168,13 @@ static void fw_upload_main(struct work_struct *work)
 	enum fw_upload_err ret;
 	struct device *fw_dev;
 	struct fw_upload *fwl;
+	struct module *module;
 
 	fwlp = container_of(work, struct fw_upload_priv, work);
 	fwl = fwlp->fw_upload;
 	fw_sysfs = (struct fw_sysfs *)fwl->priv;
 	fw_dev = &fw_sysfs->dev;
+	module = fwlp->module;
 
 	fw_upload_update_progress(fwlp, FW_UPLOAD_PROG_PREPARING);
 	ret = fwlp->ops->prepare(fwl, fwlp->data, fwlp->remaining_size);
@@ -204,6 +210,7 @@ static void fw_upload_main(struct work_struct *work)
 		fwlp->ops->cleanup(fwl);
 
 putdev_exit:
+	module_put(module);
 	put_device(fw_dev->parent);
 
 	/*
@@ -238,7 +245,11 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
 		return 0;
 	}
 
+
 	fwlp = fw_sysfs->fw_upload_priv;
+	if (!try_module_get(fwlp->module)) /* released in fw_upload_main */
+		return -EFAULT;
+
 	mutex_lock(&fwlp->lock);
 
 	/* Do not interfere with an on-going fw_upload */
@@ -310,13 +321,10 @@ firmware_upload_register(struct module *module, struct device *parent,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (!try_module_get(module))
-		return ERR_PTR(-EFAULT);
-
 	fw_upload = kzalloc(sizeof(*fw_upload), GFP_KERNEL);
 	if (!fw_upload) {
 		ret = -ENOMEM;
-		goto exit_module_put;
+		goto exit_err;
 	}
 
 	fw_upload_priv = kzalloc(sizeof(*fw_upload_priv), GFP_KERNEL);
@@ -358,7 +366,7 @@ firmware_upload_register(struct module *module, struct device *parent,
 	if (ret) {
 		dev_err(fw_dev, "%s: device_register failed\n", __func__);
 		put_device(fw_dev);
-		goto exit_module_put;
+		goto exit_err;
 	}
 
 	return fw_upload;
@@ -372,8 +380,7 @@ firmware_upload_register(struct module *module, struct device *parent,
 free_fw_upload:
 	kfree(fw_upload);
 
-exit_module_put:
-	module_put(module);
+exit_err:
 
 	return ERR_PTR(ret);
 }
@@ -387,7 +394,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 {
 	struct fw_sysfs *fw_sysfs = fw_upload->priv;
 	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
-	struct module *module = fw_upload_priv->module;
 
 	mutex_lock(&fw_upload_priv->lock);
 	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
@@ -395,6 +401,11 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 		goto unregister;
 	}
 
+	/*
+	 * No need to try_module_get/module_put around the op since only the
+	 * module itself will call unregister, usually when the refcount has
+	 * dropped to zero and it's cleaning up dependencies to destroy itself.
+	 */
 	fw_upload_priv->ops->cancel(fw_upload);
 	mutex_unlock(&fw_upload_priv->lock);
 
@@ -403,6 +414,5 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 unregister:
 	device_unregister(&fw_sysfs->dev);
-	module_put(module);
 }
 EXPORT_SYMBOL_GPL(firmware_upload_unregister);
-- 
2.47.0.rc1.288.g06298d1525-goog


