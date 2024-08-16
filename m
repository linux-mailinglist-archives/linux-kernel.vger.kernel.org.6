Return-Path: <linux-kernel+bounces-289444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6CB954649
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5F41C2232E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9EC16F0E1;
	Fri, 16 Aug 2024 09:55:59 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0CF36C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802159; cv=none; b=CApCiR5vTww/KasC85fHuu7UZeMfziJ1vleU/oL02ngV7Ch7hB4Yepr6R36hRacDXeyReQe0QXQRVxq951CkV2nqaAzEziHZBhQhb+1v7rGX1lXUwto0j4EHffrKZmQ6tssTk+p5eiPhDT06ofr37TgLyzeZOhbei2CH+Jqc0Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802159; c=relaxed/simple;
	bh=Vw1E9RM6ugXQietuKSdkorfoPsp52vTa3dXQIdCl1K4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oiMc1oxaRXkqb44RT2pFd92YNvRZO9XFAx96nKwCd97Yb9bpJfWnfP6Dw8SNyQAUGZ03TPPnMXHbai7L8ZzNJ2uyHiLd+e7PvNRwvs/aUZjNmAjQn+qnM9S1zScKKHoMwElIBvZ42kCfbLIvXPG7BGCCgt0iL4gGM1NYt7nNq1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wlcgk0gwWz1j6XQ;
	Fri, 16 Aug 2024 17:50:58 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C9291400FD;
	Fri, 16 Aug 2024 17:55:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 17:55:51 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <sudeep.holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] firmware: arm_ffa: Fix beyond size of field warning
Date: Fri, 16 Aug 2024 18:02:58 +0800
Message-ID: <20240816100258.2159447-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

An allmodconfig build of arm64 resulted in following warning:

	In function ‘fortify_memcpy_chk’,
	    inlined from ‘export_uuid’ at ./include/linux/uuid.h:88:2,
	    inlined from ‘ffa_msg_send_direct_req2’ at ./drivers/firmware/arm_ffa/driver.c:488:2:
	./include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
	  571 |                         __write_overflow_field(p_size_field, size);
	      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	In function ‘fortify_memcpy_chk’,
	    inlined from ‘ffa_msg_send_direct_req2’ at ./drivers/firmware/arm_ffa/driver.c:489:2:
	./linux-next/include/linux/fortify-string.h:571:25: error: call to ‘__write_overflow_field’ declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
	  571 |                         __write_overflow_field(p_size_field, size);
	      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Because ffa_msg_send_direct_req2() memcpy uuid_t and struct
ffa_send_direct_data2 data to unsigned long dst, the copy size is 2 or
or 14 unsigned long which beyond size of dst size, fix it by using a temp
array for memcpy.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/firmware/arm_ffa/driver.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 1e3764852118..674fbe008ea6 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -480,13 +480,23 @@ static int ffa_msg_send2(u16 src_id, u16 dst_id, void *buf, size_t sz)
 static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 				    struct ffa_send_direct_data2 *data)
 {
+	unsigned long args_data[14];
+	unsigned long args_uuid[2];
+	unsigned long *data_ptr;
+
 	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
 	ffa_value_t ret, args = {
 		.a0 = FFA_MSG_SEND_DIRECT_REQ2, .a1 = src_dst_ids,
 	};
 
-	export_uuid((u8 *)&args.a2, uuid);
-	memcpy(&args.a4, data, sizeof(*data));
+	memcpy(args_uuid, uuid, sizeof(uuid_t));
+	args.a2 = args_uuid[0];
+	args.a3 = args_uuid[1];
+
+	memcpy(args_data, data, sizeof(*data));
+	data_ptr = &args.a4;
+	for (int i = 0; i < 14; i++)
+		*data_ptr++ = args_data[i];
 
 	invoke_ffa_fn(args, &ret);
 
-- 
2.34.1


