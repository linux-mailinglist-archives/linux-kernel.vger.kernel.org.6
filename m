Return-Path: <linux-kernel+bounces-525544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7606A3F115
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D4063A3E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E4204596;
	Fri, 21 Feb 2025 09:56:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4A1C1F2F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131798; cv=none; b=hhw70tOshTtKs1gp3OwaL1EJFqtRnNu2hevzENN813GQZovi1L6AgSy2vhrL1IIfjjCvtoWD2JAeL4ZxDuuHm8Ds6rJUXgC//XLBFvHX+MnvQz+2mzYmPqgjSr8mW4dluNtoUtjWS2QuoOWzQXKCvjLB7IkCmLC+Zqa8+18WMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131798; c=relaxed/simple;
	bh=nSgoNOZ8qeYXyh0KhrhLY3rh1kx0GBIA1NHoFyqM8N8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mdlB7jxt2TTTjPa2YAQLy6bomqQt0McrUkun4TNMdz0/vC3B3NuhYSzSxLswYK7oReYH24ybq+f2Bht0cKfuwEYAOM0KI/nNzGnlKWMQZHIVBLA/d/TJkxT2nSFrOuQbT94gKPYGFZJJF9su+06NaYJ56JaaWGHHiQOlJWGBpTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F1C4168F;
	Fri, 21 Feb 2025 01:56:54 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 65E393F6A8;
	Fri, 21 Feb 2025 01:56:35 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org,
	Andrei Homescu <ahomescu@google.com>
Subject: [PATCH 1/2] firmware: arm_ffa: Explicitly cast return value from FFA_VERSION before comparison
Date: Fri, 21 Feb 2025 09:56:31 +0000
Message-Id: <20250221095633.506678-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value ver.a0 is unsigned long type and FFA_RET_NOT_SUPPORTED
is a negative value.

Since the return value from the firmware can be just 32-bit even on
64-bit systems as FFA specification mentions it as int32 error code in
w0 register, explicitly casting to s32 ensures correct sign interpretation
when comparing against a signed error code FFA_RET_NOT_SUPPORTED.

Without casting, comparison between unsigned long and a negative
constant could lead to unintended results due to type promotions.

Fixes: 3bbfe9871005 ("firmware: arm_ffa: Add initial Arm FFA driver support")
Reported-by: Andrei Homescu <ahomescu@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 254aa57ddafd..a77bb205ff7d 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -144,7 +144,7 @@ static int ffa_version_check(u32 *version)
 		      .a0 = FFA_VERSION, .a1 = FFA_DRIVER_VERSION,
 		      }, &ver);
 
-	if (ver.a0 == FFA_RET_NOT_SUPPORTED) {
+	if ((s32)ver.a0 == FFA_RET_NOT_SUPPORTED) {
 		pr_info("FFA_VERSION returned not supported\n");
 		return -EOPNOTSUPP;
 	}
-- 
2.34.1


