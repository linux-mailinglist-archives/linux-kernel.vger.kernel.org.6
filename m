Return-Path: <linux-kernel+bounces-517935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74128A387CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90A863B3FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8AB2253F3;
	Mon, 17 Feb 2025 15:39:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998302206B6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806773; cv=none; b=DGnmso/mA/PT9QUxjan9KERyArV1IKD3ZF3DLfQIFv04jFlc4AbhzYmQZpY2cizco2kcJI/qTgWiMVn+uahRYaBzVAO88NsKvW2/xm/V5UgQx7oAxEE4E4oHHAWGVdrJalRZauD7sgGkM8dO+P6DhvV8y2ok6JWNtlXs6C2CGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806773; c=relaxed/simple;
	bh=41/PckYdXDOTJF8iWlnuSJNwd8OQjt77Kk+5Anq6r5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=juIOAI7VKh8qHqhQGvkaGPqwyzCqzoywYhZToRioJGvNA8o+22vXa8KSX8azsg5RqPvnnXoK1J71+GyYs6pyREtVAktKhwc/CgFHi0xESzShlE06EGHHU0gMfUNuLsf6ufkHd1RAA2BEBKFJ5vnIaOaOseItVdix67DO6Zpar8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10D8B176C;
	Mon, 17 Feb 2025 07:39:50 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C96B3F6A8;
	Mon, 17 Feb 2025 07:39:30 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:43 +0000
Subject: [PATCH v3 02/19] firmware: arm_ffa: Replace UUID buffer to
 standard UUID format
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-2-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=41/PckYdXDOTJF8iWlnuSJNwd8OQjt77Kk+5Anq6r5U=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gujyDHIKZMNG7950DZexKR3aYwMRvLGf/k2
 G9mgUW16smJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mHZ/D/wNF9tM7wzyNXUygi+AGta04YEYaQ9RmT6Vh64PQoapjffroFoi2W0QDJXXUqepbb0ErNE
 JzO6MLjbqRP6H4Q+cWQNZ9Fl31BbbIUpwiqMTyeDir/1dkSrSQ840i9DdBaSzVmrcZPs+vJ2BFN
 YjTqjoUcjZgvySN61u6M2duPKrARh02IPJ9WJMadGipV6vGW/sTzX5zKBkW8noYZT7TayLrNrV4
 8czN/yo359zKxTqAIcoUJTenDgEJ0ubrEBtpnvpdbwm2AOniqlqJ4nkNd9dVZn2ox/CwL8mu71V
 re2GamEvkh2pRLD4+/4wdzmO6uMwReOSxsfNUiR/hb069YcwVF45gpoQeyOGDWrDLfY/vb+Gzfx
 u5WbcDoMBQ+fkO88uM2OVn7bAw7QUNVFZZYqbRAb81GyqSgYa7yG/0Zoi5/WzzCvA6xFji0w0lA
 pRqsrZRRLNBe9bMp2BM+pWz658nenMeXjZ2vhciYYZgKmov7jkTO4kN/PYS8pryqZNCe0OdEN9E
 +FGeSUk7MVr+RpWXSefHEU1WDThFV5hHUgjXQ4db+nOFCm/dk1IUU2+P83NujIVDo4jMrragsFJ
 m6jNPesiCF5ho35L2AQhYY7/QyzFSSPymBMEkcrEcfzWpS8nw/woTXdnus6N6JlxkoCqEhvXTx4
 +AR8N6sI/Z+ixXA==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

Currently ffa_partition_info structure holds the UUID in the format
compatible with the firmware interface. However, most of the functions
in the FF-A core driver deals directly with uuid_t type.

Replace UUID buffer to standard UUID format in the ffa_partition_info
structure.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/bus.c | 4 +---
 include/linux/arm_ffa.h        | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 52b1f09209a0e51e321cd23a69aa7e4c4daa8dd1..a90e2faa990219574ff20b8f573dbb7ca76137d9 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -192,7 +192,6 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 		    const struct ffa_ops *ops)
 {
 	int id, ret;
-	uuid_t uuid;
 	struct device *dev;
 	struct ffa_device *ffa_dev;
 
@@ -218,8 +217,7 @@ ffa_device_register(const struct ffa_partition_info *part_info,
 	ffa_dev->vm_id = part_info->id;
 	ffa_dev->properties = part_info->properties;
 	ffa_dev->ops = ops;
-	import_uuid(&uuid, (u8 *)part_info->uuid);
-	uuid_copy(&ffa_dev->uuid, &uuid);
+	uuid_copy(&ffa_dev->uuid, &part_info->uuid);
 
 	ret = device_register(&ffa_dev->dev);
 	if (ret) {
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 74169dd0f65948b05991732358855cdc31b54adb..abd0208f0f74c15ef4ee4c81de81eb7800a0eb1d 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -238,7 +238,7 @@ struct ffa_partition_info {
 /* partition runs in the AArch64 execution state. */
 #define FFA_PARTITION_AARCH64_EXEC	BIT(8)
 	u32 properties;
-	u32 uuid[4];
+	uuid_t uuid;
 };
 
 static inline

-- 
2.34.1


