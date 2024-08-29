Return-Path: <linux-kernel+bounces-306432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7DF963EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D9FB22CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0918C34D;
	Thu, 29 Aug 2024 08:47:59 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E5615666A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724921279; cv=none; b=shYvkfPlheU/Z4E/ZCTJ+diG3MqCv8XhSlH0REQFDiaesXm9aC+VBfJaX51tmLmOO1v1WEXTRkJHmRkAaYam/aTnpyahZedCw2qX5+YgqVZbn8BsGtUDaTQK9qtdTmGsRhmWVrfmRepUU2BD7rbnNuBbu/cS4JmVa+B0ZYiNDF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724921279; c=relaxed/simple;
	bh=68BG5uiEx3FsWZGMHxYsCWxXUTRCeyAjNYiFWt8yWjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FHCtHkZfH09W9Hrqpyof6r6TqalKCDNb/jghd7Pe8aFiY9Y5AJe6LSBypeWgKMdtq04O/oIRx+1lcRdbpr6GmEsUgKbMPV9/Ey67Oxahs2MKyhyuhtABklnxn83Y8NFDKUDh1GkX86ukT6kBWJMzAwQonMF19VX6iRpP3w14OpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WvZfk2lWJz1j7hn;
	Thu, 29 Aug 2024 16:47:42 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id AD57A1A0188;
	Thu, 29 Aug 2024 16:47:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 29 Aug
 2024 16:47:54 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux-kernel@vger.kernel.org>, <dave@nullcore.net>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next RESEND] uts: Use KMEM_CACHE_USERCOPY() helper
Date: Thu, 29 Aug 2024 16:55:52 +0800
Message-ID: <20240829085552.157119-1-ruanjinjie@huawei.com>
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


