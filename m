Return-Path: <linux-kernel+bounces-400788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F009C126B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA678286C28
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6083821A711;
	Thu,  7 Nov 2024 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h07sKV/F"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD221A4B8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731022130; cv=none; b=QekxmVOJFXuBwkQidWq1/D99gkWPGM11q1aGmSNPPqWVD6erI3h6m2tLX//RUBd8bb6Eqy0bI9fFELOSjf7WCAfFtLgaQEa3MkmAu7q+1kyfGjdAPMcPAM3axTXhSVvyxiZr8D/dC40Y7EWvM7VWyk+R9FMyyOFr8YE3BUcrFA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731022130; c=relaxed/simple;
	bh=fkSYYUFFU2dhT6w7OYZJxAhhsJkywG0c349xGH09+og=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A2bu1f495dDCBVUzf4E6KfIyviyLj1mYhw3kVfG0v2YxwRg+UILRHi0PZ0eU/iEnMiHycJcSUZ952kZq3Q6WZ3E8EncTfBpDDtQk0rhPPWoS8PU80ajjAPiPHauBc9LddNBc4RuKsJd/4AHsoXj9rNZRpr0/YROtizO+Ax2jESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h07sKV/F; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e7858820eso1602647b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 15:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731022128; x=1731626928; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=waco7iVOB4xSaLUY84IKzzTbmzK38z3CV8Wi2DuMfOk=;
        b=h07sKV/FcnyzHzBlKqGvlZcLN/FUKAZpqTMFl69biwPH68JI7YiqDe3tvtzxyfP4S+
         l4rBn2xy2FfZcFd08hBE1fEjwxozWLLUkiQaVcmo8zknpez0VSTmBgeDTQvZZo6aP2fo
         WfJJHrjHHCBfBFQPlYQMi4mvx5b1HIPO46rG1MBJDKbCauEFdxbqnrxJda8uZZrn7vNk
         Pf+62CrJ5BVxt7YVy6JEe9zLESetDT5Aacbe3LgLa2ISJmCg8l3BlSFE9DNcruRElslq
         +33zv4Chn8L4wyqKE1KJ6v1k6FTpJwKBZxRcMRCjuZrlpxvuaRxDlgH4OXa8tHTlY+gM
         am5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731022128; x=1731626928;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waco7iVOB4xSaLUY84IKzzTbmzK38z3CV8Wi2DuMfOk=;
        b=U6uedLvIrxjh4NYhPw4m0WBrjs4daUA/PR+pjIG44BcnHOS6mz9crBXKurv7Ny9/kB
         N7OII8N0Ugxx4QrxiXudNpTXy9wJKAp5se2KR7UwUz8WuM4ulemEEJ+2v+q/dwGC0uxy
         uvqnw3q9TY8tqEEDGbckE1n4JbMe1X/AwiWWDnHwGx2T9ZNtxB/mI3+BYrraJhc6NPKI
         wmFsEwJWHoYIclL3S27avkS7WHRyWDEoWojiXvBPCcjRLAnL6FdwGAc2hqeJ8xKBq+Ci
         Pmg3BYWz6hIIyolWD5WLV/iSAoAD16TeSlB5mPat9bsZo9iLcsCuHe0MmM5flWuiZRKZ
         gC7g==
X-Gm-Message-State: AOJu0YyurBojsHTq46kS+jWbAMcfol0QFVkHTa1wxZ6q4qT11gJS7pSN
	7Wk8SPcRjujG203mTxWWh5/vlZ3ECEa2yEUnYT0eqNFhxvxFtitfd7Ym5iY9ofVS/yILiVcrTl8
	poBf1lqQWYN3c9AOJfKnODoF/PIo2dkJ1ehJEhDr34p1hMKcaf3A6achphLr+8ZQ2PFTElTlePE
	lK70r1xerKGM0PfYWvdA8k4O+iB68vTVr1QmEqC+gFIHB4CWGwU8J6Ya7DLeWCqNkyZFM=
X-Google-Smtp-Source: AGHT+IFktMlgSeVnC8o0GKn2MK1ClKfKNJm/XnNohjmQq7MlNLX7MB3brInoXmrcodjawxwEvJ0rGzMZv0e8oU/vTA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:768e:b0:71e:6122:d9c with
 SMTP id d2e1a72fcca58-7241339bbe2mr8635b3a.4.1731022128255; Thu, 07 Nov 2024
 15:28:48 -0800 (PST)
Date: Thu,  7 Nov 2024 23:24:43 +0000
In-Reply-To: <20241107232457.4059785-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107232457.4059785-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107232457.4059785-4-dionnaglaze@google.com>
Subject: [PATCH v5 03/10] firmware_loader: Move module refcounts to allow unloading
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


