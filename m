Return-Path: <linux-kernel+bounces-220721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC56D90E63C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C781F229FA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E007CF18;
	Wed, 19 Jun 2024 08:48:03 +0000 (UTC)
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBDC7C6DF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786883; cv=none; b=GKsKURY/RK05Dgw0Vox9mWLd9QK/qIsPTZ0h13SCuHQWgN7gZ6KBy9/pvnEe4hUapO/PiN/kUclVIxRLkYMBha/HIR7QzZa1Sq64HaEjQDj5iPc+8pRMA84hMZYQjlmcoy4WVsZNyOOR2ICSgPnQQjhrAY3NFcmL0OQKSRhYlFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786883; c=relaxed/simple;
	bh=FCE4CHEiQevoo0zi1nKry0ww328+u54fXJyCP0cAAWs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=EbyegHbaVT3uJj+SydrcGQ91f9SRoIIsptwxduSxqC7wDhL2xDFXFtSC1tgimLkOPzvqR76GQwaaG69/+I3Lt/JOxC/tNUwQOu4iS00MYAFEnvSyi2oaWSa7cBlwcsJEwZvKJbWTOg2op43I2gMr6M/Q+YQgGgQur9Twgf8bGF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 059B07F0004B;
	Wed, 19 Jun 2024 16:47:52 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rick.p.edgecombe@intel.com
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v3] virt: tdx-guest: Don't free decrypted memory
Date: Wed, 19 Jun 2024 16:47:50 +0800
Message-Id: <20240619084750.9207-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

In CoCo VMs it is possible for the untrusted host to cause
set_memory_decrypted() to fail such that an error is returned
and the resulting memory is shared. Callers need to take care
to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional
or security issues. So leak the decrypted memory when
set_memory_decrypted fails, and don't need to print an error
since set_memory_decrypted will call WARN_ONCE.

Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 diff with v2: remove print error
 diff with v1: leak the page, and print error

 drivers/virt/coco/tdx-guest/tdx-guest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf7..8575d98 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -124,10 +124,8 @@ static void *alloc_quote_buf(void)
 	if (!addr)
 		return NULL;
 
-	if (set_memory_decrypted((unsigned long)addr, count)) {
-		free_pages_exact(addr, len);
+	if (set_memory_decrypted((unsigned long)addr, count))
 		return NULL;
-	}
 
 	return addr;
 }
-- 
2.9.4


