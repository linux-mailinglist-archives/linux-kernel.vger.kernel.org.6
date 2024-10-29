Return-Path: <linux-kernel+bounces-387492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C379B51F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24AAC1C22CBC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61325206E89;
	Tue, 29 Oct 2024 18:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XfLt64U8"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9F205E2D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227169; cv=none; b=dygGogVtUeX0BlsR63WLlGk6TeyfmXseHhBW9XEtNnIs5b/Uwjt2ItNlAsEqsNE3RQIkH2t1Zgt7nzHHCXfQA18FXYNtx1WbUQ0bhAWoVbRap8p0h/c8V2sUXvUE6qEpK5UjjAV878e/ZoNiPi73N/sOsraWcxDwLQNIrFda6DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227169; c=relaxed/simple;
	bh=94yI4N5JGZdOOiutAa3nIsdWx3G03s90rBf2KdVvRMI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XzmGf3dJsJwdnOanK3lekaUxPvCIo4cpbek4m281InIZXs3Qbc7pClcUaRgMuy5V1gokKh3RgyzizYvqFQ3DvUKH4zXE0HAZQCZcSkB7F9PEC9w+hdZH1E2h5BIztlPsT8JX/lD554FiC0W/6b8g/UKX9xjynspNAIWoNTwW2Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XfLt64U8; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c3d9a0eb2so74209945ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730227167; x=1730831967; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=q+sirgv64HIH9D2cMsnXNX5bNxSs6bhRNy8+QTukeFg=;
        b=XfLt64U8iaOCSwaZe/HrDVckBD2EjR/YdNM+ZtYwxLVH4CxQj4xKhnnOGlQvF3+7PH
         etqD1wBZBw3lmQBz0/o6GORUNWjCSJ6r9vobL1zkCxEsWhSG7KaECpryjExIdme22H04
         kiccs9KilPVBaAW4OUtKIMGCnT4jui/Y/Vob2EPISDpyMtxw/9gklowJvvSmQBYTXlsq
         HxJ3sfsN2RGgnnTk5+e8fZJATXTFi5+Azx2+QMV8GsRdlbeydqhGvOROjAnFA/I1UbgR
         xNiJEUbGUfPpAoz9131dD1Cn9yi91YNRNSnt+SA2/EVYptkMUvAe5u+C4KmCTKvMW84n
         t5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730227167; x=1730831967;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+sirgv64HIH9D2cMsnXNX5bNxSs6bhRNy8+QTukeFg=;
        b=wdF9t61doqX1FfNqPNfyGwwHqQb1P8KOXr5WJgqjtCyZmJy6W6ZdypLqdUdPRq9hNg
         zl6u2dWrPF+PBwhlZBlVyfgw21PC8X85x7KGg7OByvNMkcgof/6giAvSch1+fIQg35xU
         /8Yfi9HESyHj5iioZplKNEyBpFFYeEP4HnirxuoeTskOU5JHh4k6wf3NXsFauShxWP74
         tTQYpZvrHgPmV39tlKbMArt/neQlGyAe47pPuxuzhPHMVEVu9CarJKg2RGv9wwNBQW7y
         iJ3JOI5gW2V1Rs9OUBixJAk0Yu+7owPS8CST+syQ2tPkJ9nsFILaJYu4S7N201QGmIaM
         JUDQ==
X-Gm-Message-State: AOJu0YwPmqX61Qe0bd334p252xuAC0v1Zb8ezryjD3i51Rk65VbJxtv6
	psarzWVSAQLhwZV6xpJkIVNysx4v1rPj6X2Mw7jKcm2jPE0+tw6qK7I45FQV63qxY6kTSj1q96S
	59hDrB+iUsJySa8gWkEbVyLNYeZge2GE/kI99HogbWUTksKOgU8+hEBsEKa6oaAXHfuZo1vWnNP
	AKx1Cr5U7iJ6GF1ziMWbtEEQdK7LPj5KqqHZOAeaHmvyv+MnVNz/4DAgax63IGaMKN3ec=
X-Google-Smtp-Source: AGHT+IFs2W/MyS9XsGU5bPCMvLUacuJRkIgwcuKhWpCA0n9zD1Gt02pWARRJIj0P7Rm9hsEly5oft1ma7Sq2HT4aWQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:1c3:b0:20c:716c:5af with SMTP
 id d9443c01a7336-210c68d81b2mr502565ad.3.1730227166315; Tue, 29 Oct 2024
 11:39:26 -0700 (PDT)
Date: Tue, 29 Oct 2024 18:39:02 +0000
In-Reply-To: <20241029183907.3536683-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029183907.3536683-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029183907.3536683-3-dionnaglaze@google.com>
Subject: [PATCH 2/4] firmware_loader: Move module refcounts to allow unloading
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, Russ Weight <russell.h.weight@intel.com>
Content-Type: text/plain; charset="UTF-8"

If a kernel module registers a firmware upload API ops set, then it's
unable to be moved due to effectively a cyclic reference that the module
depends on the upload which depends on the module.

Instead, only require the try_module_get when an upload is requested to
disallow unloading a module only while the upload is in progress.

Fixes: 97730bbb242cd ("firmware_loader: Add firmware-upload support")

CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
Change-Id: Ifac9513de2f58a5120d4c0a681e969cd71cd3c68
---
 drivers/base/firmware_loader/sysfs_upload.c | 28 ++++++++++++++-------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 829270067d163..97b0ae855b5f0 100644
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
2.47.0.163.g1226f6d8fa-goog


