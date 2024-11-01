Return-Path: <linux-kernel+bounces-392698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03779B9734
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26AF8B21903
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3571CEE97;
	Fri,  1 Nov 2024 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEM4odJ3"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99411CEAA7
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484951; cv=none; b=JjSe8qcBSFle0FknW3pXa27gSqRk9ko2mtE4eaT1HXD0n5PvHvwJGO9bqrEH0jt7vdDlmJRhlpN+bLyUsdfTc89xeDPBEbMsX+V1b///nkPorZytY9g6OsxtRWlYS6tDZG2mvdPq6Aaln5f5DiDGBKBySLfKB+NjUlcju7DL+64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484951; c=relaxed/simple;
	bh=CRLaBJcbgMnRwxlma4TtUjkzI9nzDDegqxb4hAOa1II=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LHDCoWg9IPbNzv+YfCvyzeVl+SZOxoCxdybaKcgvoWSzaRhzJ3NHkZmaT/1HYk/mseV+O5IRdCfYu9nXWmwMVbkZBsURgOGjjA9ZSUMIt2xphp7038Ax+QWLPv2IhJJi3VaCA2+S4xnkVpTSiI4QrXyuZJ3Jv5IPRS4Y2EImcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEM4odJ3; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-71e467c39a4so2822043b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 11:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730484949; x=1731089749; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+HgrFNy1S3okvh+7az30cmRtXI+hsD3EQs9truFaNI=;
        b=uEM4odJ3R4z0Htq5/g82UZahx1T7Iioim9lSIE1t3pREdbfXhvRP6b1hNWnB+EP1t8
         BcwCl/Oa6DTFLprkXws/5ovIgvdh0pCObTEpD2KfHiCjE54Y/U4ATXQtz6AkAX8QL8Q1
         +4nbQq3zpfhTD/XFk4vxHt1Ah8DQR/FvSn+H8bfkXc1SQ5xyK3Tca42BkNyrMHOnabwb
         H5/fecZDTiFmOE+PVJ/0DyMUYRLx5bZMAxNubFCK9Cz1EkPcPXb93YtddKQFuuG1FqQk
         iYllhl1dMLa44zfjUywTdjn8wluROg69RCitNZOwAzv9jk1vruNj9aZ8gl6MAfI2ZbBO
         6Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484949; x=1731089749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+HgrFNy1S3okvh+7az30cmRtXI+hsD3EQs9truFaNI=;
        b=H7lLA7mKBCdRZJfgRhSKS4Nrl0PqsLTZNxW2aBcVS/eeYFBM75jQNHwfm5GgYVVyq4
         gTy5uMAic+ZAZPMuxiv/20e1TkZ6vK3zuMAaGYn+Pq3/3EXk1qfSlKR393iIdJaNlrAH
         LUTduXjMoi8/ygZ+NVBX+gkfgzZrxb/JStXrrA8p7bt1TEkv2Y6f+BLFA/ZadYxX1UOK
         IB8dcILS11NoL6g2chDK1CTQwO1EKG8SUd8YBsOuIJE4+hXUO8z3SO5Ze5EmA6YrvTUB
         GSrR65lS+/1Uq5BnMrvsMKNcqTLrMKVsb6blMr4QWvBG4A6lASxv9SqdoA/AdqKiTPRz
         T7qA==
X-Gm-Message-State: AOJu0YwPma5w3NygKEBbLaOq9hcSLcfHh9LwSFHILB526mp24YTbqlvr
	4ve+R+seTOGayU8TFvJDXUHr7iGRbJcW21GU5u0tJDITTTMswcHYZS4k2tEwTXOBad1JfRN76fJ
	Zt7pG1q7uOQdRb/nNFh/I0NOpMpqfskHxLj8qtTSWDaYI+OdVYO/0ksIelnD5WBan9cCzgMwAUq
	/qT1mS5TQtJFgb7vfiXsAzJQlA+qJLFYyQpjmRz+f6nd1hfFNcAcW2MDqpWkd99XPHwK8=
X-Google-Smtp-Source: AGHT+IG7wmlIzLfxL2ty/OwpieTnV1d/2VRca3whn85OUbmznjoBhH3JCc6Z4h0bptq/5GHwpF6DK0NJGNc1d6wq/Q==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:8581:b0:720:2db7:c7e3 with
 SMTP id d2e1a72fcca58-720b9a200fbmr50184b3a.0.1730484948657; Fri, 01 Nov 2024
 11:15:48 -0700 (PDT)
Date: Fri,  1 Nov 2024 18:15:27 +0000
In-Reply-To: <20241101181533.1976040-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241101181533.1976040-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101181533.1976040-3-dionnaglaze@google.com>
Subject: [PATCH v2 2/4] firmware_loader: Move module refcounts to allow unloading
From: Dionna Glaze <dionnaglaze@google.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Danilo Krummrich <dakr@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Tianfei zhang <tianfei.zhang@intel.com>
Cc: Dionna Glaze <dionnaglaze@google.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Michael Roth <michael.roth@amd.com>, 
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

Tested-by: Ashish Kalra <ashish.kalra@amd.com>
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
2.47.0.163.g1226f6d8fa-goog


