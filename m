Return-Path: <linux-kernel+bounces-400830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E579C12EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 01:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7CD28419F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70D24414;
	Fri,  8 Nov 2024 00:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sF2ENVVt"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC7064A
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 00:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731024958; cv=none; b=gI/a4pscX1wDW3jLYyE3K3CPu6MytM3hm2ZqceJ0eubmrK2ADHjDfI5A/wkbxy5bizc2958/Ai953GfehQBY49se3WgGqfH3tNt6fMnhCCUVamynuJG4SpT30dzjYWO7iCcJMQ7RgTnsTyHPIcRcZiOBwZqT+VneDKLMW7MJEHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731024958; c=relaxed/simple;
	bh=bNQqUDWSpPVDp9f74/Vz4JfMnPFVGdfl7TBWEGPIpRs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LCD1QFkMDjVI4CzN0vQbkTAsnYDr4sidJdHFzMC2Ib7bFDaV3poZCOD56oqldzmAGOtRwurDmxSFRNaVRZbueaV6n2N0e4ITVVnKI46aTmSRSHBEdtnbh9zmjPDkmCF70nztgUPi9bAn4EavtwPo2w1eZlezvlylW7DQ1OBmA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sF2ENVVt; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e32ff6f578eso3514028276.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 16:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731024956; x=1731629756; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C+cvhfxMxcAGwNEI/sTbc9zPJ+TFYlYM6Rgfn0qgxwA=;
        b=sF2ENVVtyxwszfyTYrQyMNvoYVJu7ny1sk8HeukAVJ4HVIrY2x+aQiFFRNRAHu0d7y
         twwwvALNAfQLqdOsHiAguGMLMSFAPA0m/WHgNbSxx34e3h2YPt9k5NEAbP8FzD6xSUNK
         CHs1n00i0BOw8ev8GbEsicI4UJvd5lIm4N8XTlLjf5j6vr7CuUwxzJuz24VOjy75JKI8
         x20GMayxUNHNsupTYsObbd6nadegQRZ251lifz93lMua9RzvLEm7a9oFqSO+ti4mAyme
         Wy7WjsntL6yrC4GS79l019Vyq/FD2Wp5BqxAXAbpqx3QTDKyPB5ln5b8KPeW4YEosW1O
         Dmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731024956; x=1731629756;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+cvhfxMxcAGwNEI/sTbc9zPJ+TFYlYM6Rgfn0qgxwA=;
        b=YpdiFyqKWjL7yX5XxnqGBTTiUt/84Pi/B3yhFfjhq37MTpqZudNCWphdwADeNx9CuO
         1us2E2Y5nptOuCrYsOuKfzhjHQ7HDxljBp2aC7xdOsHv3IVZ5IaOJZ7xCTU1G+PsV0f9
         rOL+4+eIp+rOPs8r/7/XPcoUAvkPQUElYlIPQAqHteZDPXLPBRGQuZRYvG94K+QOQxRN
         hum1CWL1q2kJbPQNy4nXAh8/j9xEDQBKpMPCpqyWBp00mWgBaY5xSSQ6YLaYHMW6j2jG
         G9xscehjQVXFCbBGqxBS+CL7OtSvRDwMGtZ9ifFoPQCNv1FGOf+6lgPIi+QvBuDQVQdZ
         QLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXrVNb8tPd12uGn8nq3qrdyjahBaLf5JwkVkGY8pIUjJHOK226PNU63+RwJlW5puSmflvFa5Rta1JqBFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhdcBhOEJK3uemecV4PJqhBR6NGALuzHI1iVI6pdXxSVuQB+h
	DduVXraJKKPtktdlcjbifEChMhGx0ZyBkVKgWjeCng7i1T4q1ONZmE2vdvwAMrOfH/azeQ9IDC0
	oNqOJE2GYdw==
X-Google-Smtp-Source: AGHT+IF0uTz7dBmajkyMIyFuU38iEJPA3KUjwQ01O9i7tJDtXL5GXG6kS20R+PmADwYVMvNey9lNK63kXsGa2w==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a25:c2c7:0:b0:e29:9c5:5fcb with SMTP id
 3f1490d57ef6-e337e1b0c47mr13777276.4.1731024955790; Thu, 07 Nov 2024 16:15:55
 -0800 (PST)
Date: Fri,  8 Nov 2024 00:15:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241108001542.255155-1-ipylypiv@google.com>
Subject: [PATCH v2] i2c: dev: Fix memory leak when underlying adapter does not
 support I2C
From: Igor Pylypiv <ipylypiv@google.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Jean Delvare <jdelvare@suse.de>, 
	Andi Shyti <andi.shyti@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Early return in i2cdev_ioctl_rdwr() failed to free the memory allocated
by the caller. Move freeing the memory to the function where it has been
allocated to prevent similar leaks in the future.

Fixes: 97ca843f6ad3 ("i2c: dev: Check for I2C_FUNC_I2C before calling i2c_transfer")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/i2c/i2c-dev.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index 61f7c4003d2f..7717db1f4c23 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -251,10 +251,8 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		return -EOPNOTSUPP;
 
 	data_ptrs = kmalloc_array(nmsgs, sizeof(u8 __user *), GFP_KERNEL);
-	if (data_ptrs == NULL) {
-		kfree(msgs);
+	if (data_ptrs == NULL)
 		return -ENOMEM;
-	}
 
 	res = 0;
 	for (i = 0; i < nmsgs; i++) {
@@ -302,7 +300,6 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		for (j = 0; j < i; ++j)
 			kfree(msgs[j].buf);
 		kfree(data_ptrs);
-		kfree(msgs);
 		return res;
 	}
 
@@ -316,7 +313,6 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 		kfree(msgs[i].buf);
 	}
 	kfree(data_ptrs);
-	kfree(msgs);
 	return res;
 }
 
@@ -446,6 +442,7 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case I2C_RDWR: {
 		struct i2c_rdwr_ioctl_data rdwr_arg;
 		struct i2c_msg *rdwr_pa;
+		int res;
 
 		if (copy_from_user(&rdwr_arg,
 				   (struct i2c_rdwr_ioctl_data __user *)arg,
@@ -467,7 +464,9 @@ static long i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if (IS_ERR(rdwr_pa))
 			return PTR_ERR(rdwr_pa);
 
-		return i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		res = i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		kfree(rdwr_pa);
+		return res;
 	}
 
 	case I2C_SMBUS: {
@@ -540,7 +539,7 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 		struct i2c_rdwr_ioctl_data32 rdwr_arg;
 		struct i2c_msg32 __user *p;
 		struct i2c_msg *rdwr_pa;
-		int i;
+		int i, res;
 
 		if (copy_from_user(&rdwr_arg,
 				   (struct i2c_rdwr_ioctl_data32 __user *)arg,
@@ -573,7 +572,9 @@ static long compat_i2cdev_ioctl(struct file *file, unsigned int cmd, unsigned lo
 			};
 		}
 
-		return i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		res = i2cdev_ioctl_rdwr(client, rdwr_arg.nmsgs, rdwr_pa);
+		kfree(rdwr_pa);
+		return res;
 	}
 	case I2C_SMBUS: {
 		struct i2c_smbus_ioctl_data32	data32;
-- 
2.47.0.277.g8800431eea-goog


