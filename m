Return-Path: <linux-kernel+bounces-525545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA1A3F118
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FDB166715
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9433204C3F;
	Fri, 21 Feb 2025 09:56:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BF1204C22
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131801; cv=none; b=F43Uv2QEI7Yg2Au974Ghmf6lTnDGSWhWFOgSeGc0P7WMskIIqmTpG/R3NMslFbwJLRHxSmfpXzlwgXe1dKNQVzeLmZ6wCReJVddM7KAxwUk6csxgkeD7iDqSlH1DZfPFAptDdKVXz1yXBTMBKPda7oiPmkX0KK0xBYxTbqgq+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131801; c=relaxed/simple;
	bh=6pOU2XYt1EHNYj/6T8Ub0H0zn3x7/XF/PtdO6tS8CiI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhRwb99c6Ajx+M55A/lpKXm7kCUbiKeo40tvWioOGD9KnX5QNWbaFPM6jZl8AaaRBjGvBDSViJVKcKCN+bB+R83t0QY5D75azh9D9idvnvzV2YIfSCHqqB+QWwyfURSbGTAMm8GW1iPJiIVKQqHLWC/8Jannx5jYf/kNRZy0nlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AC3416F3;
	Fri, 21 Feb 2025 01:56:57 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C6B43F6A8;
	Fri, 21 Feb 2025 01:56:38 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-kernel@vger.kernel.org,
	Andrei Homescu <ahomescu@google.com>
Subject: [PATCH 2/2] firmware: arm_ffa: Explicitly cast return value from NOTIFICATION_INFO_GET
Date: Fri, 21 Feb 2025 09:56:32 +0000
Message-Id: <20250221095633.506678-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221095633.506678-1-sudeep.holla@arm.com>
References: <20250221095633.506678-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value ret.a2 is of type unsigned long and FFA_RET_NO_DATA is
a negative value.

Since the return value from the firmware can be just 32-bit even on
64-bit systems as FFA specification mentions it as int32 error code in
w0 register, explicitly casting to s32 ensures correct sign interpretation
when comparing against a signed error code FFA_RET_NO_DATA.

Without casting, comparison between unsigned long and a negative
constant could lead to unintended results due to type promotions.

Fixes: 3522be48d82b ("firmware: arm_ffa: Implement the NOTIFICATION_INFO_GET interface")
Reported-by: Andrei Homescu <ahomescu@google.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index a77bb205ff7d..31832af7a7bb 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -976,7 +976,7 @@ static void ffa_notification_info_get(void)
 			  }, &ret);
 
 		if (ret.a0 != FFA_FN_NATIVE(SUCCESS) && ret.a0 != FFA_SUCCESS) {
-			if (ret.a2 != FFA_RET_NO_DATA)
+			if ((s32)ret.a2 != FFA_RET_NO_DATA)
 				pr_err("Notification Info fetch failed: 0x%lx (0x%lx)",
 				       ret.a0, ret.a2);
 			return;
-- 
2.34.1


