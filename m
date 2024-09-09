Return-Path: <linux-kernel+bounces-320982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487669712FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07383287D16
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE61B2EE0;
	Mon,  9 Sep 2024 09:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RthFmalh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54341B14FB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872954; cv=none; b=YGVfgqhcQWwg92R7Jw83VU/ecviPq8bKDWJUWfxAXDbbbhGDU/q5/xQ+cCqDthsKlJKu/YRMwPGrTZVQCCqYdOv5k3v/KjqFpRIle+Ynh3gdIEgp7+hQ5XkKljDGIMTnwVRu6k7ZDmJ2d0NgF0ifaQDozIVZhq0av2Usp0sozAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872954; c=relaxed/simple;
	bh=fQ8Bq1F9OXzG4iPevCpwDBqQjYesBe5uPmyI+M/cVmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMny8NFz2GqCa2J8ruecuuVW1+4eCTFX7f3mP6QURibtCA7iUkjhXwfSRwOLCTDTxaP3aDgZOFgifVWaHrVWMBvIigfQR7cBffF+ggwV9yIRe9MToL+fGXUjYjvsCzTSmGDkKoVNdcZhwclQc7MTa6mx/7NlZT6nlR3Tp2J1IA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RthFmalh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB8DC4CEC5;
	Mon,  9 Sep 2024 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872954;
	bh=fQ8Bq1F9OXzG4iPevCpwDBqQjYesBe5uPmyI+M/cVmU=;
	h=From:To:Cc:Subject:Date:From;
	b=RthFmalhEtdBVXTRCy4QLe1Z57VQK3yfHEnKvJIi0wIUQPa/ZJrulhusricxDKkPS
	 l2i0Y3lUEjjX5d5Ex2iOKTuhv+VqOOFA0uL27H3unAaYITSJl5sf/bl/Hy3wmr5ZWq
	 ivBwnwjeW8zBIyIE0t49f+8jBqX0ykKtPA6yF8FHqewHTuc3OGn/J5hqPuOVLQy9g7
	 tqA1tQF7pZAK1p1ICUijqxc/CE6vghEmW4ajAwSKwr9931ea8Yj9FXxawqnp1YC/54
	 EmRd0KDwCklC12YOAXhBh3+/HKao9/+ftTaB+gssxxwnNPet3MdakEc2h/P1/ufv3w
	 q8J32hWTywf6A==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_ffa: avoid string-fortify warningn in export_uuid()
Date: Mon,  9 Sep 2024 11:09:05 +0000
Message-Id: <20240909110909.247937-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Copying to a 16 byte structure into an 8-byte struct member
causes a compile-time warning:

In file included from drivers/firmware/arm_ffa/driver.c:25:
In function 'fortify_memcpy_chk',
    inlined from 'export_uuid' at include/linux/uuid.h:88:2,
    inlined from 'ffa_msg_send_direct_req2' at drivers/firmware/arm_ffa/driver.c:488:2:
include/linux/fortify-string.h:571:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
  571 |                         __write_overflow_field(p_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use a union for the conversion instead and make sure the byte order
is fixed in the process.

Fixes: aaef3bc98129 ("firmware: arm_ffa: Add support for FFA_MSG_SEND_DIRECT_{REQ,RESP}2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure how endianess is handled in the ABI, adding the conversion
seemed sensible here to allow big-endian kernels on a little-endian
firmware, but it's possible that ff-a is already required to do
the byte swapping in this case.
---
 drivers/firmware/arm_ffa/driver.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 4d231bc375e0..8dd81db9b071 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -481,11 +481,16 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 				    struct ffa_send_direct_data2 *data)
 {
 	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+	union {
+		uuid_t uuid;
+		__le64 regs[2];
+	} uuid_regs = { .uuid = *uuid };
 	ffa_value_t ret, args = {
-		.a0 = FFA_MSG_SEND_DIRECT_REQ2, .a1 = src_dst_ids,
+		.a0 = FFA_MSG_SEND_DIRECT_REQ2,
+		.a1 = src_dst_ids,
+		.a2 = le64_to_cpu(uuid_regs.regs[0]),
+		.a3 = le64_to_cpu(uuid_regs.regs[1]),
 	};
-
-	export_uuid((u8 *)&args.a2, uuid);
 	memcpy((void *)&args + offsetof(ffa_value_t, a4), data, sizeof(*data));
 
 	invoke_ffa_fn(args, &ret);
-- 
2.39.2


