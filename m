Return-Path: <linux-kernel+bounces-420766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075D99D82EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1CB0288D30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F83A1922DC;
	Mon, 25 Nov 2024 09:53:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97399192B62
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528381; cv=none; b=LjDhAVLPhLs+Iuy1ZcZtzT8cstuvSQ3X+CJ9x7b/0Sf3zXYwpz88mFfZqnCLniKrZ++zPP6j96kbOpKwPJN6/IknsQ/38KshlAEB+MdhNK/bP2E88nEz+Drn/C8uRcBNmBFoF9hpZCIMCr4rDS2Pxz/dDVdNI3laK9LyxljgG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528381; c=relaxed/simple;
	bh=plYSePR17bUYbnIXW6ASTUU+nFubMYrI/KTOuQNQ8as=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPCvwwibVxhqfeXMlosURolB6L8Pi9QyLcIFJB8BcnB2npKBCYPvQHYQaGohOogP4CuXtSNTetmA75q6EBaKTyvD83jxXHCxEE1ssXeRctl4kjNqVsf8sMHW4O47UswL9M5D6JcvZWu+y/ulCZNwTnLAsQlRt6t1i1fD4ZWgUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04ABF1756;
	Mon, 25 Nov 2024 01:53:29 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EEC823F5A1;
	Mon, 25 Nov 2024 01:52:57 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sudeep.holla@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nd@arm.com,
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 3/3] firmware/arm_ffa: remove __le64_to_cpu() when set uuid for direct msg v2
Date: Mon, 25 Nov 2024 09:52:51 +0000
Message-Id: <20241125095251.366866-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125095251.366866-1-yeoreum.yun@arm.com>
References: <20241125095251.366866-1-yeoreum.yun@arm.com>
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
and change uuid_regs' type to __be64 because UUID is saved in network
byte order.

Link: https://developer.arm.com/documentation/den0077/latest [0]
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index a3a9cdec7389..4a6bc6520d25 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -483,13 +483,13 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
 	union {
 		uuid_t uuid;
-		__le64 regs[2];
+		__be64 regs[2];
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


