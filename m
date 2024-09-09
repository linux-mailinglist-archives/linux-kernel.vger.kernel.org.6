Return-Path: <linux-kernel+bounces-320983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA619712FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1A81C227CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FC1B29DB;
	Mon,  9 Sep 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmovxtfS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449241B14FB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 09:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872999; cv=none; b=XMQi1rBY3v5HdQKg+WHRxAxroTR/tIR14p8mcb9R9ujyHRIbs6Ebe0DpNrfUrkQJxscIml3ziKANyGct+2YoY1zDHA8aGWNfIfFvc0vgWFgiyCKjZWQKW/f3kDl8kqipKOYgTqrDgUohMLWd/ANyZc/uwEDUQxFmLIZoGGycAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872999; c=relaxed/simple;
	bh=fQ8Bq1F9OXzG4iPevCpwDBqQjYesBe5uPmyI+M/cVmU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RhvEpSq+1M/PbUg/rsWv/5/gJGrmQt4sTWGNDatnnNciSgFn9uP7ujtb5h0rcdh493zJs4gx4FbB9W5D6lxUQpi4VHpwvdeMZjRY4vxjNur4UAVVzio7LvwS0pQFG+2EwD1qBCDv5K/B2CbWbVp3PDWcX8NqCJXwTJbt2kXdl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmovxtfS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D291C4CEC5;
	Mon,  9 Sep 2024 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725872998;
	bh=fQ8Bq1F9OXzG4iPevCpwDBqQjYesBe5uPmyI+M/cVmU=;
	h=From:To:Cc:Subject:Date:From;
	b=HmovxtfSJlFXdTT4c965EOv+RUXltuPyRNc4Idn6x2ZoBFrQmLqzk781MXosQN30U
	 shUk63obARmxyQY3ZYqayCmYy7/6lrc07rc42OjHbmZsZ9na1yepUkwy8ClrF97OXm
	 DvOXHh9kMUdh8YWk2eSDdyYb0dj5i9I95FpVD8O2PApIJUmaxMqM4Jhfp9BH6TPxSS
	 FAwWqqMjKEEAzq0dVeShe+FJobXFEO8HhKbuoon1hHR7f66vhD1RXxuNPVddeVDs9V
	 gJqwWsu0iuxEAdo3P4osa5VsdTo+Y8Ke1KNtBU9momzI+Stc6xj5uFdgeDxUltt5j8
	 uXer5mEnmoTjA==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: arm_ffa: avoid string-fortify warningn in export_uuid()
Date: Mon,  9 Sep 2024 11:09:24 +0000
Message-Id: <20240909110938.247976-1-arnd@kernel.org>
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


