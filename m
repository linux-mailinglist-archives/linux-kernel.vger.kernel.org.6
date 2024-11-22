Return-Path: <linux-kernel+bounces-417804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B89D5943
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 07:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884EEB22B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73AF1632CD;
	Fri, 22 Nov 2024 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iegPtFA0"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9D15ADAB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732255906; cv=none; b=TpXCPDG+E7UL/3hMFjpagOfQcUts1XMpz0G2Zblvh3emR9ADyf54WpSxVElL1Cmq6XC4W/9J46ySYcR/XS10kffqKMp20MdT0+gAoWAyAHBMSZi+OSCN3V2a32yY+GBfXZoAuEhL9L3Yd6BnFCQscJsIo2mhQv3BKc3HM9TIvNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732255906; c=relaxed/simple;
	bh=I3IUElX8/5bjB//wumcR7e4AYMOuUaihltii6i/CqrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQAN+4EUPQ4xEtdKsSiwX+uIjt3++52lvQcOWCuVp+DzEpX11MU/2aYXlpf+MHEfo4dh/BK9AtlZHEVA5ZUi09mB12NXFSaKbhQvz9Yry+YJ8R9XUMf4c7h1/qp9F2as1q232mXuvQ2X/GLxGiO0vqWwpc3l6Z90EtjTl8wBxS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iegPtFA0; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720d5ada03cso1687381b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732255904; x=1732860704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KsdWADtCZxfDmt5l2khF1eoZiMv6I7S5kAe1tkpZwuc=;
        b=iegPtFA0Xse2ERoxGbJ2JDRmBTFdoXu5IwPhpHd2MeHvsrgMQaw/oPQ1xL9X4/iaC9
         emX+Y27ubLWyM7uuDvhDmiTmLxL3wQYUmWp0Uj4ADHb5MwzGJo/7LgElfJUBSHfnmKq8
         DX0POnFvJvUdecD7JVVaSrmcqhMNGD5qsmAvCjY5Re2UZdCjtYB4zm5+T8SCKyZVFufx
         wgXm3UamohfWp6YUlith+0oP5oE4/A+6TQkjgKML1Ug00TuZo7DA6wJeaLUu6/GaA0cU
         yk/dZcC/uEYaZ4MXKU+23p+T1Sl++dBoA6MGi0+hhrhmx6Fb7H1imHAciXA2IMqzbAHY
         NusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732255904; x=1732860704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsdWADtCZxfDmt5l2khF1eoZiMv6I7S5kAe1tkpZwuc=;
        b=oNMggzrylY1tdVkUcF7NOl2BmB2tNiPrpZWfvwv+y/2+X6A3KCRM0q6f4n09xhJUl+
         e7Y9De5lnMxPivOuRFozE1qOZMBG4ul4w1cS3nvO/k0Rhe654FVsuSnpSGdGWaRkgQGz
         2//fVmvRRyDKF2NCdAMEMrAYgrUuK2L51KxnZaZgABbrtDhK4WTQ3Su3nTstRnF7YsOX
         SelRzrYO63WoWNeVd2swplHRhe1YjaG629SRJLlP8mpKGHIDiUXMWlIK1sxteDw5W0xL
         sTeGJuIkdBWJO5GpQlSYgicT0sh6TK7KNkSJnJTDzU4Ph2Jx8uZ+PouapoJb50Zb7WpZ
         gtXw==
X-Forwarded-Encrypted: i=1; AJvYcCVtayAATYPUThjcGLzKa2n31gKz53Ze4yvtemsq16Jv8CyFpj70BxnSNz+I/fvZiVTjL3YswXklsOZBWoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAdm2bapk1NaLaArZHjqMFKb6+s3TCRISvEc3/uZ6JwM+T+5n
	0b/aGVfJIKEncAAqwfNp1vgQwg9PHfO+tApSeNipV1Yv2dcuOl+qPJgKTWJvHFI=
X-Gm-Gg: ASbGncv8ClJ67wjD/+g11p+NbQM7mSLV5gQ6h0E3VTjFvrwAHtwNBvBnsL2+yqAXzk8
	SgCPgEVKzKzxk4WtbQEKQpCG7ukknojRw9wrj5aZQgwZj9tJA1Tng4wBp7OIazZfMX1mfO4L0Bx
	oDLWlUxSMv+iat/zUwmZLSMtmfn5jQH1oh8VdV6g7EoG0/l9dWhlH2zRTb/Qi75Ldkeo19hpz2Z
	pox5MasjouWEvVUBfccOryW9PfLDPgDhxIqJy4baeRsM/YhhcB5
X-Google-Smtp-Source: AGHT+IE0eJmFuahjKbCISpPbJp4kSO8jy3nKnYRP7eeOOTivTvW9UHLBye4KY33+7uFh0ZrM7Uugbg==
X-Received: by 2002:a17:90b:1d03:b0:2ea:853b:276c with SMTP id 98e67ed59e1d1-2eb0e0204a8mr2029224a91.8.1732255903926;
        Thu, 21 Nov 2024 22:11:43 -0800 (PST)
Received: from localhost ([122.172.86.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2eb0cfe72f4sm768079a91.10.2024.11.21.22.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 22:11:43 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Bill Mills <bill.mills@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_ffa: Add ffa_add_partition_info()
Date: Fri, 22 Nov 2024 11:41:38 +0530
Message-Id: <9967e35eb1cbdb8d0c0bae3f54401d806700e6b6.1732255888.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move common code to a new routine. No functional change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/firmware/arm_ffa/driver.c | 53 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 30 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index b14cbdae94e8..d50062cb6c43 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -1384,12 +1384,31 @@ static struct notifier_block ffa_bus_nb = {
 	.notifier_call = ffa_bus_notifier,
 };
 
+static int ffa_add_partition_info(int vm_id)
+{
+	struct ffa_dev_part_info *info;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	rwlock_init(&info->rw_lock);
+	ret = xa_insert(&drv_info->partition_info, vm_id, info, GFP_KERNEL);
+	if (ret) {
+		pr_err("%s: failed to save partition ID 0x%x - ret:%d. Abort.\n",
+		       __func__, vm_id, ret);
+		kfree(info);
+	}
+
+	return ret;
+}
+
 static int ffa_setup_partitions(void)
 {
 	int count, idx, ret;
 	uuid_t uuid;
 	struct ffa_device *ffa_dev;
-	struct ffa_dev_part_info *info;
 	struct ffa_partition_info *pbuf, *tpbuf;
 
 	if (drv_info->version == FFA_VERSION_1_0) {
@@ -1427,42 +1446,16 @@ static int ffa_setup_partitions(void)
 		    !(tpbuf->properties & FFA_PARTITION_AARCH64_EXEC))
 			ffa_mode_32bit_set(ffa_dev);
 
-		info = kzalloc(sizeof(*info), GFP_KERNEL);
-		if (!info) {
+		if (ffa_add_partition_info(tpbuf->id))
 			ffa_device_unregister(ffa_dev);
-			continue;
-		}
-		rwlock_init(&info->rw_lock);
-		ret = xa_insert(&drv_info->partition_info, tpbuf->id,
-				info, GFP_KERNEL);
-		if (ret) {
-			pr_err("%s: failed to save partition ID 0x%x - ret:%d\n",
-			       __func__, tpbuf->id, ret);
-			ffa_device_unregister(ffa_dev);
-			kfree(info);
-		}
 	}
 
 	kfree(pbuf);
 
 	/* Allocate for the host */
-	info = kzalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		/* Already registered devices are freed on bus_exit */
-		ffa_partitions_cleanup();
-		return -ENOMEM;
-	}
-
-	rwlock_init(&info->rw_lock);
-	ret = xa_insert(&drv_info->partition_info, drv_info->vm_id,
-			info, GFP_KERNEL);
-	if (ret) {
-		pr_err("%s: failed to save Host partition ID 0x%x - ret:%d. Abort.\n",
-		       __func__, drv_info->vm_id, ret);
-		kfree(info);
-		/* Already registered devices are freed on bus_exit */
+	ret = ffa_add_partition_info(drv_info->vm_id);
+	if (ret)
 		ffa_partitions_cleanup();
-	}
 
 	return ret;
 }
-- 
2.31.1.272.g89b43f80a514


