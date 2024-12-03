Return-Path: <linux-kernel+bounces-429659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880D99E1F34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF7BB163EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9A1F6692;
	Tue,  3 Dec 2024 14:31:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D481F12FC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236277; cv=none; b=FhxB64UGBaT1NOAZx1rGzh9emgJXB4vB7Oi5uMQdU7gzeLag4BYrFsFkZ0GP0sNfUbro2/LQr822p/ZHGr4tZALQATjtrx1NGgA4gBWb+ULXDdN5dXu9uuiX16Pk9LAkktiEChhqSLSaTpS3y1CBT+9qKPH0dDmAummldirLaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236277; c=relaxed/simple;
	bh=LCdJDkwfotfhVqi8YzQZyilE8z5Bth4isfVxx4vU5kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+mRIKlYMph8H1YED4SrNsSGhfxxV9YF3Daqcvm8aLsfyaEu/mKbMOFrGapRlqg22Wn2Iocld9PvM5XmK9nEXa0xr67Bt2//HCtTyEESCEqJRToNsWMVhHRAH1jNHeraQYA+QxH5xq+Dpz7pxzZV9HKyKAOo0KNF7Ai2on2jwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8908A1C0A;
	Tue,  3 Dec 2024 06:31:42 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AE9C43F71E;
	Tue,  3 Dec 2024 06:31:13 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 2/2] firmware/arm_ffa: remove __le64_to_cpu() when set uuid for direct msg v2
Date: Tue,  3 Dec 2024 14:31:09 +0000
Message-Id: <20241203143109.1030514-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203143109.1030514-1-yeoreum.yun@arm.com>
References: <20241203143109.1030514-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

UUID is saved in big endian format.
i.e) For uuid "378daedc-f06b-4446-8314-40ab933c87a3",

It should be saved in memory like:
    37 8d ae dc
    f0 6b 44 46
    83 14 40 ab
    93 3c 87 a3

Accoding to FF-A specification[0] 15.4 FFA_MSG_SEND_DRIECT_REQ2,
then UUID is saved in register:
    UUID Lo  x2  Bytes[0...7] of UUID with byte 0 in the low-order bits.
    UUID Hi  x3  Bytes[8...15] of UUID with byte 8 in the low-order bits.

That means, we don't need to swap the uuid when it send via direct
message request version 2, just send it as saved in memory.

Remove le64_to_cpu() for uuid in direct message request version 2,
and change uuid_regs' type to unsigned long.

Link: https://developer.arm.com/documentation/den0077/latest [0]
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 2c2ec3c35f15..8bfeca9d0d2a 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -483,13 +483,13 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
 	union {
 		uuid_t uuid;
-		__le64 regs[2];
+		unsigned long regs[2];
 	} uuid_regs = { .uuid = *uuid };
 	ffa_value_t ret, args = {
 		.a0 = FFA_MSG_SEND_DIRECT_REQ2,
 		.a1 = src_dst_ids,
-		.a2 = le64_to_cpu(uuid_regs.regs[0]),
-		.a3 = le64_to_cpu(uuid_regs.regs[1]),
+		.a2 = uuid_regs.regs[0],
+		.a3 = uuid_regs.regs[1],
 	};
 	memcpy((void *)&args + offsetof(ffa_value_t, a4), data, sizeof(*data));

--
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}


