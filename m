Return-Path: <linux-kernel+bounces-393051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098299B9B64
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E242B21885
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9EA1F19A;
	Sat,  2 Nov 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mxPBksPH"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF12F18035
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506116; cv=none; b=gX0olpm4+X3PYe9CCO+Qb7TzfUI3SwDPaxm2yhb3ooSQ2fzwYQ1N60dcrc+r2wa903pmu8QEx+a4qBX1W7uxVdAfe+/2wHpgV8YvxNEMe3vm/Em+YI6uwdETJZx2wBzPQUrhdm0k7GXCcRRwck5wCC42HWfVQRuBoiyLq1jKhEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506116; c=relaxed/simple;
	bh=D5TifaQ9HJSnoTRXPHyCsGQ6jNhcD5UTr+lHgNqoUEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fKuqNzM4PoQRNErGSI//NWW+ouQ73hofm2myf2GmfZcSzEQuZWmbV/4PGnZSJUspccLCESqcb2R9gqc6SzMzBifsrHBIMuNraFENPSEvCIvt1H0LnENFPQnKyaCsRkMr0Sx+UKMOfBjIWdGAaOYz+YUesn9odRw2DKBVTFlH5QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mxPBksPH; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-720738f8040so2501569b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730506114; x=1731110914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ah3K57+pIWf1JIbhJyIJqLnkO2+WjvytEokHBlHWy4I=;
        b=mxPBksPHxxA1fO3//JAhu6IIlSGrdxrCWpqcHuY94Iyj3Hx/Fp90ntAYyKecbl3SMw
         1Gys2Lyrif6fANE/l93jEvT5GSsx/4Sn6q+X2lIEeetK0TIwmszq2LobwlXwFGcN7R1x
         uo6ht+HbMuLucu+dI5OdOh/4EfI2TT46J9LSMg0lXpXULhCXTMrHHyObYW+lSq5CeC8s
         BpyByrO5HN9/dyFyDLnkGAolCHD+DYTXILUh4j+QKaakq7QMw2aVDBYGZrGTCCtfgeUj
         cUDZG5IhBkisiLinX8i3/JBiuqGMmnkK+11+ixacQZaFAqQJFLbQ+ceVZ3bhQDmbZe0g
         yuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506114; x=1731110914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ah3K57+pIWf1JIbhJyIJqLnkO2+WjvytEokHBlHWy4I=;
        b=vpu/r2sSXmAp8uyLC2Mwr6/SOlH9C5NgCo1AW2u7ZrilAroFAOZVGk4lw6ZPVwjjgM
         +Ef+PZBLTdL65c4jrzA2nxXO8q7rqveg/kcM1BRhCFpSwwNhIqod+lJctVg/tEo52EKz
         3R0b9RgV0PBLtWgJ+xUIHSX2Gd5XSDHmjajr5WYZmBnL+D0c8clnXKyETaKsDESstCHB
         Zp0R/bWx/2/Ymy1qG+/dLvnhB+LUwufIJvbBdcS/Ez3ZnS7DI2F0B4yzABaig8POToVw
         1QDqteLdF31au+ZOVPjDk1blTkOzZeY2ZAYTOivWrlCFG6N1TTkq8fRlMWh3+6mTMG0D
         wVfA==
X-Gm-Message-State: AOJu0YwXVhy0QUHMgmclrF752Tb19gs46dnruTJn/LInMF9fxb1H4uEV
	k9UFKwIlf+EML7/nrsuxFag/ovu0DtIBTN2CbeGoeGtAqQ7G7QawHPyqtOnKBj8BkcGfa8ZWxqp
	faOeoTfd2AfpM7o9/Dhi7t+WCLLz2TSyxDJe+1duBY7l7CLrAUOzRW9vpEEgFXwe9ROpUvnI4D3
	0yHoapJ/XuRpHoV207D6oa6EXeGhneUDw35I5sTi7RDGXpqBLErx428fd3W72/asVtAdg=
X-Google-Smtp-Source: AGHT+IEsDXtDKFkROLd+6BH4rvOWuiRlmFEnY+ixeW1YDYF9nECO3enAXVuU4Q7y4wadXSfJW5YExyJzTxwvQFSZCA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:a44d:b0:71e:4a06:8a5f with
 SMTP id d2e1a72fcca58-720ab690cc9mr24349b3a.6.1730506112466; Fri, 01 Nov 2024
 17:08:32 -0700 (PDT)
Date: Sat,  2 Nov 2024 00:08:12 +0000
In-Reply-To: <20241102000818.2512612-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241102000818.2512612-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241102000818.2512612-3-dionnaglaze@google.com>
Subject: [PATCH v3 2/4] firmware_loader: Move module refcounts to allow unloading
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
	Alexey Kardashevskiy <aik@amd.com>, Russ Weight <russell.h.weight@intel.com>
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


