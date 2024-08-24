Return-Path: <linux-kernel+bounces-300025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A595DDB6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 14:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A4828354D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCB516DEB3;
	Sat, 24 Aug 2024 12:02:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBEA15D5D9
	for <linux-kernel@vger.kernel.org>; Sat, 24 Aug 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724500960; cv=none; b=vDEG2yvMcpz45OvwJnW6WElxGz6R8PmbOpSCmSfVJP3s0wxmR/v47by/gHuFdPRXFk9DG0wCGeNd7X2UqERFIPvvHvtmcURbWUChcPj6ZpbjTtnFAjsvfUv/jZtoyNnxnS0hXEH4ZEO46aCBEfhUx7fU+YHWJyf+RcUAheOyT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724500960; c=relaxed/simple;
	bh=3ycEFoz3T0igV+AStkE3emIiu6ZyB8fjH4O8x1QcQWE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oJpnpKigSDEld1XCuw0Ripc1vM5hnmu+2VIFd5ijISbM0PieJv5AYKsr6IWsIjoBE4BHAHBwAWR3wkZt/iR8I1rUhl45OMjvy39uoE72R+2dDssa4CKs0UBxHVqkZ8Z/zmGa9RKRcX9TGq1oAFeOSaMrxPNb5KxMtYDn/BpKWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WrbB31WGkzpStT;
	Sat, 24 Aug 2024 20:00:59 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 36A961800F2;
	Sat, 24 Aug 2024 20:02:35 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 24 Aug 2024 20:02:34 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<cuigaosheng1@huawei.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] x86/mtrr: Remove obsoleted declaration for mtrr_bp_restore
Date: Sat, 24 Aug 2024 20:02:34 +0800
Message-ID: <20240824120234.2516830-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The mtrr_bp_restore() have been removed since
commit 0b9a6a8bedbf ("x86/mtrr: Add a stop_machine() handler calling
only cache_cpu_init()"), and now it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/x86/include/asm/mtrr.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 090d658a85a6..4218248083d9 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -69,7 +69,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 			 unsigned int type, bool increment);
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
-extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
 void mtrr_disable(void);
@@ -117,7 +116,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 	return 0;
 }
 #define mtrr_bp_init() do {} while (0)
-#define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
 #define mtrr_generic_set_state() do {} while (0)
-- 
2.25.1


