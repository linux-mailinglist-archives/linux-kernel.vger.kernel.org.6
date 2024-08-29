Return-Path: <linux-kernel+bounces-306426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE5963EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8EF1F23790
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F6E18C352;
	Thu, 29 Aug 2024 08:44:53 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F816133E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921093; cv=none; b=XMSTzn9MVz9rNaNr+23UJ4oka1sa2EFWaeKLyeceqyTnj/a3xpuCpZw0Bxn6IRGl9eygF3I3nfJMDSEYnbttWmv3AoYbc++rdym6kgOf1Ch3yTvaENFHUDT7FqLAmLDLMrmDdbByPOppbJu8zyAv1aaA2XjHslJX/r74yozQJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921093; c=relaxed/simple;
	bh=68BG5uiEx3FsWZGMHxYsCWxXUTRCeyAjNYiFWt8yWjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bf5ETvsTSRt7rh02wqcgROmPWqizEi2ShQ68WDA7h6lgw9Jju7lOhXWViBVpkd6aPI++QoQJZBU1QjpshGJ1iryFj5Tpqs0RASVo5vHqjJQGjnT6xPW50sVQPBnD5WFAYfQiYWn5ZK5O5Afu5QzPR1D3HzeTVAMlRAUMC1+2qc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WvZb84Gf8z2DbZJ
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:44:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 193C81400FD
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:44:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 16:44:48 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] uts: Use KMEM_CACHE_USERCOPY() helper
Date: Thu, 29 Aug 2024 16:52:52 +0800
Message-ID: <20240829085252.156864-1-ruanjinjie@huawei.com>
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

Use KMEM_CACHE_USERCOPY() macro to simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/utsname.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/utsname.c b/kernel/utsname.c
index b1ac3ca870f2..b9917ea6142d 100644
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -168,10 +168,5 @@ const struct proc_ns_operations utsns_operations = {
 
 void __init uts_ns_init(void)
 {
-	uts_ns_cache = kmem_cache_create_usercopy(
-			"uts_namespace", sizeof(struct uts_namespace), 0,
-			SLAB_PANIC|SLAB_ACCOUNT,
-			offsetof(struct uts_namespace, name),
-			sizeof_field(struct uts_namespace, name),
-			NULL);
+	uts_ns_cache = KMEM_CACHE_USERCOPY(uts_namespace, SLAB_PANIC | SLAB_ACCOUNT, name);
 }
-- 
2.34.1


