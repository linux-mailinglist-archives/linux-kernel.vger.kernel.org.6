Return-Path: <linux-kernel+bounces-312109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C3F969261
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 05:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E74284FF5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 03:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1246433BC;
	Tue,  3 Sep 2024 03:45:37 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FCD18EBF
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725335137; cv=none; b=iGNjlOOL2boImxnyk3eN8agvMOwQS2IL3c6kwEq7voTtUOEP3bbVXL6yiDZimKSrCkRoAH+KYoojPwHbfRPGfq+NTX50vvHXWl+pOdQrtpgJ/JYzB2XBuwgYZb89Bw1oZEKZ1hKijoS34HjlCgTQs3sxZT6wxlsJcoXTmTy/J0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725335137; c=relaxed/simple;
	bh=DR3kwa3/bIos73yr5KF/QcBGcUaNM7F9rCDjs0fwhCM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnBzE73iUh3lNCsKh1rHXUziUXoLuNBWlsykGVfYs0OAJ1M7IMajeFuz+WIJanhyPSWXucEZNwVaFJ+VjKolnVve8K/n89h0ImK94JWVFfEMkhNzctLmMZpNV5U+4dZiclGg7lo5a+MFU3u+HdOrq6oaz0+Qp5A4vwCYGyCbyes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WyWc50Yksz69RJ;
	Tue,  3 Sep 2024 11:40:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 28A9A18010B;
	Tue,  3 Sep 2024 11:45:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 3 Sep
 2024 11:45:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <pmladek@suse.com>, <rostedt@goodmis.org>, <john.ogness@linutronix.de>,
	<senozhatsky@chromium.org>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 RESEND] printk: Use the BITS_PER_LONG macro
Date: Tue, 3 Sep 2024 11:53:58 +0800
Message-ID: <20240903035358.308482-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)

sizeof(unsigned long) * 8 is the number of bits in an unsigned long
variable, replace it with BITS_PER_LONG macro to make it simpler.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
v2:
- Add include.
---
 kernel/printk/printk_ringbuffer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index bd2a892deac1..8de6c495cf2b 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -4,6 +4,7 @@
 #define _KERNEL_PRINTK_RINGBUFFER_H
 
 #include <linux/atomic.h>
+#include <linux/bits.h>
 #include <linux/dev_printk.h>
 #include <linux/stddef.h>
 #include <linux/types.h>
@@ -122,7 +123,7 @@ enum desc_state {
 
 #define _DATA_SIZE(sz_bits)	(1UL << (sz_bits))
 #define _DESCS_COUNT(ct_bits)	(1U << (ct_bits))
-#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
+#define DESC_SV_BITS		BITS_PER_LONG
 #define DESC_FLAGS_SHIFT	(DESC_SV_BITS - 2)
 #define DESC_FLAGS_MASK		(3UL << DESC_FLAGS_SHIFT)
 #define DESC_STATE(sv)		(3UL & (sv >> DESC_FLAGS_SHIFT))
-- 
2.34.1


