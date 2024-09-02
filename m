Return-Path: <linux-kernel+bounces-311175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C496859F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 13:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684B11F21C86
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35060143C40;
	Mon,  2 Sep 2024 11:00:44 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D04273F9
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274843; cv=none; b=PxWM4RBqE9tfmUafuQFhO9gglszJrFWxvbtmvcxZSouGRBnvHG21529X/e0ZfXekVEa+VImc+Z7rKxysLIkvlSzVPre2p/3DEQxuK6rm/kZxCogyJRlG1FvYAIMbcueZVXWcpIyxm2kBVFCkuDi7FObYgXqHL63tORYlZuFreGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274843; c=relaxed/simple;
	bh=cUhHkOmxWpFF598bixpy4eM04dSXmy8/YPAv2H6qSkc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7Gx/vvX1CBQGx5W4L1ttynOgpb7VNQmH0kxMolmK5b60uvNoR04ZIhxyJJHK6BwwgEcVGd8gUKL7FkIUA275KnlM217qr4fvvbDGh7M1sv5C2i7c3scrkxVQ6paYPv/gGspiX3VU01/FROZ3zAH8qs1uueIJbJdOHt3sYZUQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wy5Px0rrqz1S9NF;
	Mon,  2 Sep 2024 19:00:21 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7701B18002B;
	Mon,  2 Sep 2024 19:00:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 2 Sep
 2024 19:00:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pmladek@suse.com>, <rostedt@goodmis.org>, <john.ogness@linutronix.de>,
	<senozhatsky@chromium.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] printk: Use the BITS_PER_LONG macro
Date: Mon, 2 Sep 2024 19:09:03 +0800
Message-ID: <20240902110903.2686082-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make it simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/printk/printk_ringbuffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index bd2a892deac1..7433fe477e08 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -122,7 +122,7 @@ enum desc_state {
 
 #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
-#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
+#define DESC_SV_BITS		BITS_PER_LONG
 #define DESC_FLAGS_SHIFT	(DESC_SV_BITS - 2)
 #define DESC_FLAGS_MASK		(3UL << DESC_FLAGS_SHIFT)
 #define DESC_STATE(sv)		(3UL & (sv >> DESC_FLAGS_SHIFT))
-- 
2.34.1


