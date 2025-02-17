Return-Path: <linux-kernel+bounces-517943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 676EFA387D6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03372173DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A1226525;
	Mon, 17 Feb 2025 15:39:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AB7226172
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806780; cv=none; b=o/MARsw50Fsj2mfu/A4SsjgUzdg+8yccLgFNbhx259l1nEclbWfbxYRWXGatRyoB9cqb63G+z5pqYW/rdoix90Id+cb7sHl5EqLlUxIuxDAfmLnuGiuxFVa2WCBre/Ib5QXhP8sEWLsYHRssk7TOP4OnUbMBHtK/sFnj01zoN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806780; c=relaxed/simple;
	bh=U2Pa8cgrduaKloppfthrgCFfrEI2zJBMeuwy12YpDv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=t3LSGx/EvXs8XepKTuaSo+NIlWH/FbNEzU7Q0t0oQ+GxL3Sn/SoRnpwrAiExfH2uDqdBk4taY1OKmSxGHzjLBJ+5ITLIz/XKwDsbWHSP32A4HEGFgCEHKIUpUPs0TuzKu4UbKYaOCTIGRXMKsVS8yT51z74WF1teqzTVwBHJeao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4793D176C;
	Mon, 17 Feb 2025 07:39:58 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63A1C3F6A8;
	Mon, 17 Feb 2025 07:39:38 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:51 +0000
Subject: [PATCH v3 10/19] firmware: arm_ffa: Add support for passing UUID
 in FFA_MSG_SEND2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-10-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2319; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=U2Pa8cgrduaKloppfthrgCFfrEI2zJBMeuwy12YpDv4=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gua4jzwB8ulT/HsdvweBObDE1MNmOMPFzpk
 RyPkgFi3/OJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLgAKCRAAQbq8MX7i
 mMiPD/4vawnoANQaxp+gh1u2/cX44bGHYZ5/NH28+CSRb0xMCouFdQzW5sJqifa9lzHIgJBku8T
 dmmkt3fGIjpBMxHbQt1rSRmQ+7jQgaz4mIGT3Wbg9YrmJ8TfQc3hQ3pCiV/2xHXe7WOQqDSO0AY
 jKM99UbiLYzLjQf1JdjXOa74Z0mZ3cBySjgQYtbXXwL9aGTMQBi96JIlsEsoAGUbpX3PQL0PF+8
 KVHPGeoLfYs+ZdKRKqfLBR+uTbRCl0vPhid7KhT+jrdxr2Kf1apAnKiYZ/tnkb/Eq8RWugjYXi9
 IPq0usqoqRHERdyu78TcoEPWC0mTylDZnd7hP1697xKocPFQLi17YkLcjwUsUdQK5SgN6oFtUrn
 7AcfATZ6i7TLu5U1KZVGis6YLETe+bYPWRPxD8q16NWgoOClx7SQ2TrZlQx2O9INr68DSzsNsOc
 kqA7raV8CYynrpoemGbRLefBxODP7k8ha2B5knh+PK+EsUzLbGDDddqszTW3cx9uIRNRmEjFSSB
 s1tFPZ5e26fPYqBL+EQ52KdoTiDvjNDPQAyQ6ulCV9Lrb161E1WZ9/O1M5qiM1GY4hmyYssgzmG
 ZHGWf4s87GUs4mkli4Dj4k4O0fHJlsPXc7EkOHlPiS8hhtfhPSwIXOOSpPaeSzmbIsg5sMjiNfF
 nKiwdWZlibXW3yw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

FF-A v1.2 introduces UUID field in partition message header used in
FFA_MSG_SEND2 to enable partitions/endpoints exposing multiple UUIDs.

Add the support for passing UUID in FFA_MSG_SEND2.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 7 ++++---
 include/linux/arm_ffa.h           | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 15305920ca9f2bcc72ac7453080f5c10430a3e26..545b1772df0095787b20332a7d5189c71bd5cacd 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -484,9 +484,9 @@ static int ffa_msg_send_direct_req(u16 src_id, u16 dst_id, bool mode_32bit,
 	return -EINVAL;
 }
 
-static int ffa_msg_send2(u16 src_id, u16 dst_id, void *buf, size_t sz)
+static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t sz)
 {
-	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dev->vm_id);
 	struct ffa_indirect_msg_hdr *msg;
 	ffa_value_t ret;
 	int retval = 0;
@@ -502,6 +502,7 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *buf, size_t sz)
 	msg->offset = sizeof(*msg);
 	msg->send_recv_id = src_dst_ids;
 	msg->size = sz;
+	uuid_copy(&msg->uuid, &dev->uuid);
 	memcpy((u8 *)msg + msg->offset, buf, sz);
 
 	/* flags = 0, sender VMID = 0 works for both physical/virtual NS */
@@ -1054,7 +1055,7 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
 
 static int ffa_indirect_msg_send(struct ffa_device *dev, void *buf, size_t sz)
 {
-	return ffa_msg_send2(drv_info->vm_id, dev->vm_id, buf, sz);
+	return ffa_msg_send2(dev, drv_info->vm_id, buf, sz);
 }
 
 static int ffa_sync_send_receive2(struct ffa_device *dev,
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index 761ea8fe3bb6080c893a5eb365358b62d6a4f3ff..bd78deeff284e2f46d42cfc7af218f4a0f3d1478 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -282,6 +282,7 @@ struct ffa_indirect_msg_hdr {
 	u32 offset;
 	u32 send_recv_id;
 	u32 size;
+	uuid_t uuid;
 };
 
 /* For use with FFA_MSG_SEND_DIRECT_{REQ,RESP}2 which pass data via registers */

-- 
2.34.1


