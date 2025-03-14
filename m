Return-Path: <linux-kernel+bounces-560776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8758A6095C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064CD3BAA6B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC52157A6C;
	Fri, 14 Mar 2025 07:00:16 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B462B1547E1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741935616; cv=none; b=XomeqknOvIzaPBUGqJzD37gcn2fL4krrpb7hJJ50T9lwR7/4gggvMrBgymfAN2oVJEH+qmMv17uMOrH54g530oxcJ3spPPMP5A0Mk6gJIK2Y1k3I8Y8quhE3wVG8DC3D+AC4AxzONciiuL6XYiKVToFnBN3xH8GnehzUNYLvGKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741935616; c=relaxed/simple;
	bh=1bbpBCM8izED4ho1GRqfmW+se0PWB24MxbQ99B+S7vA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bKCtnIve506upijGNYX03UP8pMx2ZTJIQMZEHpOghXPuh/+7xqpHbZNWUWHAG5MFEfVUQ7Vpdc133gHm8IlJoLvEQ1EDHuO65DtwCFPtBOADTDjXmKz8SFgEeaMV9yeM0LPEaeHr9Ohc/5UMQjlUQoncYhU/dfeO13SA0q6jOY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZDZsw0zqTzCtQ9;
	Fri, 14 Mar 2025 14:56:52 +0800 (CST)
Received: from kwepemh200013.china.huawei.com (unknown [7.202.181.122])
	by mail.maildlp.com (Postfix) with ESMTPS id 03221180102;
	Fri, 14 Mar 2025 15:00:04 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.175.36) by
 kwepemh200013.china.huawei.com (7.202.181.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Mar 2025 15:00:03 +0800
From: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
To: Carlos Llamas <cmllamas@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, "J. R. Okajima" <hooanon05g@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] lockdep: Fix upper limit for LOCKDEP_BITS configs
Date: Fri, 14 Mar 2025 06:47:29 +0000
Message-ID: <20250314064729.163602-1-zhangxiaomeng13@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh200013.china.huawei.com (7.202.181.122)

The upper limit that was initially setup for LOCKDEP_BITS configs
is too high (24 bit shift), which causes the kernel image size to exceed
KERNEL_IMAGE_SIZE (1024MB) limit. When LOCKDEP_BITS is set to 24,
the kernel image size grows to 1562.19MB.

Adjust LOCKDEP_BITS to 22, which results in a kernel image size of
888.19MB, keeping it under the KERNEL_IMAGE_SIZE limit while still
maintaining adequate debug information capacity.

This change prevents the linker error:
  ld: kernel image bigger than KERNEL_IMAGE_SIZE

Fixes: e638072e6172 ("lockdep: Fix upper limit for LOCKDEP_*_BITS configs")
Signed-off-by: Xiaomeng Zhang <zhangxiaomeng13@huawei.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 35796c290ca3..6faba965a349 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1504,7 +1504,7 @@ config LOCKDEP_SMALL
 config LOCKDEP_BITS
 	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
-	range 10 24
+	range 10 22
 	default 15
 	help
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
-- 
2.34.1


