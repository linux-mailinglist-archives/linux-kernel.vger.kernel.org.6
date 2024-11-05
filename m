Return-Path: <linux-kernel+bounces-395742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 803909BC249
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 02:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E04282FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C41B2A1D1;
	Tue,  5 Nov 2024 01:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dJId63t"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21941C68F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 01:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730768777; cv=none; b=ZyFCr+XSI1ymzHLDl+bsdk1xKnJcgEFgYtWXhHpip8MMvjS+6HkN3/+DyOa3QWTF6+sBvjhwHxD6P7igKqUViosRs9U5TeBRB+LC9EkujXA8iNWkYGX28FkTDxhVTavgDtsTVfztG+6PrdFsAaDkFPJ1OX0M1ftUi102rQuUB9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730768777; c=relaxed/simple;
	bh=uPJS3mnhiD5KP+r9032K22WkeGASPpslcji7zDxZohg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uuohcdZluwIjIQHHyHNqihFSzufh/q0kG76pW8GAM6bs1Fdjw7bDrKHJsjZNZvZR/UqIHe0T483GfwYFfLGR9GXpiHmIhOc3yOV4bd5dBhCXI77x+s8AI/DWw9rKrMFdrz6ZoM9WQZDtJ3nU4eYo5pcFSmgNC1JowjPt7Xselqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dJId63t; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dionnaglaze.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71e49ae1172so4785232b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 17:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730768775; x=1731373575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C69aGsOp2lpKUTUJIlKoxOdLcqIbpxWjUksMkIqKMLQ=;
        b=0dJId63txokrQGmNz9Je3Oe62KdedauQfHfEJajl01nR7g4CwXmxhLhfWr5dCep2BT
         lIDTW9r25YM0YFTfV8hvzo4uIT3FiaRXo0BO29jeFTcnheACXeq5DKl1GQzsSqhCYJjM
         sAIh5MXYkAIlaPKRzxijykyXoY/RvecLx46uCW5TjmDh4N/1ouKo5jdQ+32c09PdgRRT
         TXkfqV25bsvFHr8LqO7yVLY78vjswb6C+jNOEN6qAz7R7P8la1vq2vsJjH/pQoH8lzei
         TIvPwQqfp8XGV+7zUpzkikKJ6JUANTAwpmfiu/1JMVZNPP6cRwEGKyblCnQRNgDcJHRi
         4y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730768775; x=1731373575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C69aGsOp2lpKUTUJIlKoxOdLcqIbpxWjUksMkIqKMLQ=;
        b=tyAYt3iXJcV5+Ow2lgs6VTyurKApVLGhVJgSuEfk15E42x30Y3PjP5i43wkN8cL1Nn
         eyomAv0BZWvF59Jbmsyd7tdWB4ffTO0NqCJalQwSKJxd6oy4FZ7Npgku732fVIPIJCYq
         yZuppA5lKOQF/CBPz7+6eH+o4PJv6DU/XUyKGtLkcMyFbQv7SKk3I7H+bLgasVClqNw+
         E/R/lvnLsTlHvrxiMhdN2qm/tbHYhSdxtk+KEQ6Yyh9RYlJo4T519fZ7SbM9N7MhXcGA
         qSZZKi3pPfEP58jk9XzVIZZIj4UynvwURtpDrBCkJrKQYO6mHzrJRXevX06o+4lfwcvk
         NtMw==
X-Forwarded-Encrypted: i=1; AJvYcCVy1y1ujF7TF+iZxNV2Il8bsIn/wFQ5NxPYWgKG4SkC6fRF2rX3uOTaZRwE9OoWi8wtTqJu5lWG1zCimK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjlYKJ3C3jv8zjrOOEx6w2kubOcVwFmlvj1Bf179j2LUsKJBd
	q+UhhtR0X+4DBiImF0/4P6uiRJgy5o++Y1+3p9VjPNlz5cWIR2xYUVgwvZVUT7jQ5nBQpryla5V
	6fSwrELsigezIC1mlctIJAQ==
X-Google-Smtp-Source: AGHT+IEYcurUyDuk6UGh/vVlH4wPfYFJTLCfkxulUr59pdPf9DO6uq1RjaNDS0c4qAJxzK6f+CrS5V5OEHQDpLthYQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:36:e7b8:ac13:c9e8])
 (user=dionnaglaze job=sendgmr) by 2002:a62:e708:0:b0:71e:5580:f456 with SMTP
 id d2e1a72fcca58-7206306de0fmr86607b3a.3.1730768775293; Mon, 04 Nov 2024
 17:06:15 -0800 (PST)
Date: Tue,  5 Nov 2024 01:05:49 +0000
In-Reply-To: <20241105010558.1266699-1-dionnaglaze@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241105010558.1266699-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241105010558.1266699-3-dionnaglaze@google.com>
Subject: [PATCH v4 2/6] firmware_loader: Move module refcounts to allow unloading
From: Dionna Glaze <dionnaglaze@google.com>
To: x86@kernel.org, linux-kernel@vger.kernel.org, 
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
2.47.0.199.ga7371fff76-goog


