Return-Path: <linux-kernel+bounces-406852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 365069C6537
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8023B3D8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E185121CFA4;
	Tue, 12 Nov 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o050sadq"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A251421D215
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731453790; cv=none; b=m1TxN4xByiWbYAucwgcwnwCK64kr4mOlvYTn2Ee2LUStkLEpyUFGDH/ot9swlDH3xOeJ7zIu+/PnyYldKc/1212gCd8yRJNSQuc/91KQ6/3F0yyfi3pHI+pdQdDEwedSpTeEzXZgURPYwGnTD+cxHHMFk0l0vrN/G2kFb5uNuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731453790; c=relaxed/simple;
	bh=fkSYYUFFU2dhT6w7OYZJxAhhsJkywG0c349xGH09+og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iw5eDV8Dow7oCCC5UYx/ujEonZ9SJk1fYLC+wMvHC0j/wr0ombD9sGoI0BsLTwVd/baXX3sVReKCckxJ2Ly8lUeTchtf/mY/lY7CYSjLH8ftG9fx0hDEJdXs/bdSq32Jo6oNeTh3D+FfKMZPp7293qi6iqLb+c70PwE5UiijmMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o050sadq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e7e7568ed3so2805067b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731453787; x=1732058587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=waco7iVOB4xSaLUY84IKzzTbmzK38z3CV8Wi2DuMfOk=;
        b=o050sadqo1QrI4MAIphrM+Wrw4rVusq2jJLpkUqTa51z2sq4c+MnzaM9R5ROwKscnb
         Jw6YeM2t8QiO+XTpd3wVH948Uw6I7U5evQAlwvRkgQZ0vnjHEhOHEualKQuHI41GAKcA
         ofsUAWzji9qO9COgifNXdpbz4CjeMzEaBc7llDWztlx8Ok0m+ItMtvz463q0dARpS7j1
         dvhjJQtcmJGyIim9R7VkZ0y8PFgziBJqggBrJO+FoC/JAy1I73eqQiJZAdJXky6HVPUc
         Y/UPaXKR9gyxwvrqnxEV9UPxB9pfuTm3Kesa2OQRAsy12J+Cvv3hHJ6Uuxs3hqLZoFNZ
         dO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731453787; x=1732058587;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waco7iVOB4xSaLUY84IKzzTbmzK38z3CV8Wi2DuMfOk=;
        b=vDP9c/WQeRTIZxxfW+Q6vj0mxXID/2euEX7sXpgZlWYojYAKquQbDw0M/3KEYirxfT
         k6+3Bmy5RizFxBDWGb6BVTePLLHK3gr2+3lwn1sdbzb7VFZVRGvOk0c30Gbi0hD04WDx
         xJ1lgrSaNBe8NVjqsbbYpclMAtxToKrDzHZM1fEHv52PHgpfOhF15cyLwaAjsvQg38sg
         G7MIKE1S0ZCNshI4hzwObr/Sx7BDGth5xIxXbieYBEdsAlrhWUf8k5qQgybq/O+dPIbn
         c8iKTygrh9iuJD+9K1OZG7ymTr2zvgCInLe7QsJNPSJvHsfRxqLKQ3ykh7YtHDSwQbNV
         ocUg==
X-Gm-Message-State: AOJu0YwgWfg4otfjn8Xjuix9zU/MyLWCpSIy21vyVvAQKKPAr3M6012w
	5dC5Sc2vyL/WbDuzQKD1cVr49D5h2DAL1FCmfpey5cSfsu8UEcIW2geHy4phR7cnJkmgHhKLWE5
	1CYPc9tBFgnZ4JfF61L97r7psLulsUinyVm/RTuaWvZgz3sHfrJDwpFAh77FvssepdWNmUKI9kO
	OS4dZH0S4f4XSIPftVg2rFikSwgQGbzkFARIc5tZVTXYaUUq3xIDk6U0lUMlk01aa0a5U=
X-Google-Smtp-Source: AGHT+IE0qPNehuCJmgZ3Y9jGmKLJIF83WkMtt6X+ytxPHivZrMnOcg1sXwjkCfj06PlKJC8uXCRQCyOSugbOqkdYyw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a25:d04c:0:b0:e2e:317a:d599 with SMTP
 id 3f1490d57ef6-e337fdb51ccmr99338276.2.1731453787171; Tue, 12 Nov 2024
 15:23:07 -0800 (PST)
Date: Tue, 12 Nov 2024 23:22:42 +0000
In-Reply-To: <20241112232253.3379178-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241112232253.3379178-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241112232253.3379178-4-dionnaglaze@google.com>
Subject: [PATCH v6 3/8] firmware_loader: Move module refcounts to allow unloading
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>
Cc: linux-coco@lists.linux.dev, Dionna Glaze <dionnaglaze@google.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Michael Roth <michael.roth@amd.com>, Alexey Kardashevskiy <aik@amd.com>, 
	Russ Weight <russell.h.weight@intel.com>
Content-Type: text/plain; charset="UTF-8"

If a kernel module registers a firmware upload API ops set, then it's
unable to be moved due to effectively a cyclic reference that the module
depends on the upload which depends on the module.

Instead, only require the try_module_get when an upload is requested to
disallow unloading a module only while the upload is in progress.

Fixes: 97730bbb242c ("firmware_loader: Add firmware-upload support")

CC: Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: Ashish Kalra <ashish.kalra@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>
CC: John Allen <john.allen@amd.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: "David S. Miller" <davem@davemloft.net>
CC: Michael Roth <michael.roth@amd.com>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Russ Weight <russ.weight@linux.dev>
CC: Danilo Krummrich <dakr@redhat.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Tianfei zhang <tianfei.zhang@intel.com>
CC: Alexey Kardashevskiy <aik@amd.com>

Tested-by: Ashish Kalra <ashish.kalra@amd.com>
Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/base/firmware_loader/sysfs_upload.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
index 829270067d163..7d9c6aef7720a 100644
--- a/drivers/base/firmware_loader/sysfs_upload.c
+++ b/drivers/base/firmware_loader/sysfs_upload.c
@@ -204,6 +204,7 @@ static void fw_upload_main(struct work_struct *work)
 		fwlp->ops->cleanup(fwl);
 
 putdev_exit:
+	module_put(fwlp->module);
 	put_device(fw_dev->parent);
 
 	/*
@@ -239,6 +240,9 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
 	}
 
 	fwlp = fw_sysfs->fw_upload_priv;
+	if (!try_module_get(fwlp->module)) /* released in fw_upload_main */
+		return -EFAULT;
+
 	mutex_lock(&fwlp->lock);
 
 	/* Do not interfere with an on-going fw_upload */
@@ -310,13 +314,10 @@ firmware_upload_register(struct module *module, struct device *parent,
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
@@ -358,7 +359,7 @@ firmware_upload_register(struct module *module, struct device *parent,
 	if (ret) {
 		dev_err(fw_dev, "%s: device_register failed\n", __func__);
 		put_device(fw_dev);
-		goto exit_module_put;
+		goto exit_err;
 	}
 
 	return fw_upload;
@@ -372,8 +373,7 @@ firmware_upload_register(struct module *module, struct device *parent,
 free_fw_upload:
 	kfree(fw_upload);
 
-exit_module_put:
-	module_put(module);
+exit_err:
 
 	return ERR_PTR(ret);
 }
@@ -387,7 +387,6 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 {
 	struct fw_sysfs *fw_sysfs = fw_upload->priv;
 	struct fw_upload_priv *fw_upload_priv = fw_sysfs->fw_upload_priv;
-	struct module *module = fw_upload_priv->module;
 
 	mutex_lock(&fw_upload_priv->lock);
 	if (fw_upload_priv->progress == FW_UPLOAD_PROG_IDLE) {
@@ -403,6 +402,5 @@ void firmware_upload_unregister(struct fw_upload *fw_upload)
 
 unregister:
 	device_unregister(&fw_sysfs->dev);
-	module_put(module);
 }
 EXPORT_SYMBOL_GPL(firmware_upload_unregister);
-- 
2.47.0.277.g8800431eea-goog


