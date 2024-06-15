Return-Path: <linux-kernel+bounces-215759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045309096B9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E041C21AB6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D73718037;
	Sat, 15 Jun 2024 08:06:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E33171B0
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 08:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438776; cv=none; b=gYdn5uhA+rb/l1GYMDdJUN5/KI6gj7tTqtguQegEUhJ9HjrgsWWTIQkaTdHnKdz6GJwxgkHoZXF6aIZCHiAo89JQyTul4Sar7MxEueZOyGHGxh25+yWXvaa3fS2Ct7pfVAqpZynmSgMrB7f+s7KcclOSdkjjq0vfOVDoSrBXqrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438776; c=relaxed/simple;
	bh=Sl6y5vSpvo/TDY1A0GnSjLx1TQ3HOsv/EHlKZf9iTdI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EqSfqW4h6N9WR8bauusInt0yanxTj7CHqSzJdQ0THX0uGJ+mt5QTedgLxRfd9U2+N3V4Uvjqw6TAvCOkLrLv1AjzIt7+gnoeBUo/IibT/TJMYlsdbcMODbfWHRiXz2ZbA4ot0CFTusOtlM0bURs9b0NC4mfURl8NJOataDMo2iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W1TBb4mTPzwSS0;
	Sat, 15 Jun 2024 16:01:59 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F40B180064;
	Sat, 15 Jun 2024 16:06:09 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 15 Jun 2024 16:06:09 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <kees@kernel.org>, <song@kernel.org>, <ndesaulniers@google.com>,
	<yonghong.song@linux.dev>, <thunder.leizhen@huawei.com>, <ardb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <zhengyejian1@huawei.com>
Subject: [PATCH] kallsyms: Simply clean get_symbol_pos()
Date: Sat, 15 Jun 2024 16:06:43 +0800
Message-ID: <20240615080643.3865878-1-zhengyejian1@huawei.com>
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
 dggpeml500012.china.huawei.com (7.185.36.15)

'symbol_end' is just for calculating 'symbolsize', so if 'symbolsize'
is NULL, there is no need to find 'symbol_end'. Besides, if 'offset'
is also NULL, there is even no need to assign to 'symbol_start'. So
just do cleanup.

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 kernel/kallsyms.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 22ea19a36e6e..fe6a248d629a 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -322,8 +322,8 @@ static unsigned long get_symbol_pos(unsigned long addr,
 				    unsigned long *symbolsize,
 				    unsigned long *offset)
 {
-	unsigned long symbol_start = 0, symbol_end = 0;
-	unsigned long i, low, high, mid;
+	unsigned long symbol_start;
+	unsigned long low, high, mid;
 
 	/* Do a binary search on the sorted kallsyms_addresses array. */
 	low = 0;
@@ -344,28 +344,35 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	while (low && kallsyms_sym_address(low-1) == kallsyms_sym_address(low))
 		--low;
 
+	if (unlikely(!symbolsize && !offset))
+		return low;
+
 	symbol_start = kallsyms_sym_address(low);
 
-	/* Search for next non-aliased symbol. */
-	for (i = low + 1; i < kallsyms_num_syms; i++) {
-		if (kallsyms_sym_address(i) > symbol_start) {
-			symbol_end = kallsyms_sym_address(i);
-			break;
+	if (symbolsize) {
+		unsigned long symbol_end = 0;
+		unsigned long i;
+
+		/* Search for next non-aliased symbol. */
+		for (i = low + 1; i < kallsyms_num_syms; i++) {
+			if (kallsyms_sym_address(i) > symbol_start) {
+				symbol_end = kallsyms_sym_address(i);
+				break;
+			}
 		}
-	}
 
-	/* If we found no next symbol, we use the end of the section. */
-	if (!symbol_end) {
-		if (is_kernel_inittext(addr))
-			symbol_end = (unsigned long)_einittext;
-		else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
-			symbol_end = (unsigned long)_end;
-		else
-			symbol_end = (unsigned long)_etext;
-	}
+		/* If we found no next symbol, we use the end of the section. */
+		if (!symbol_end) {
+			if (is_kernel_inittext(addr))
+				symbol_end = (unsigned long)_einittext;
+			else if (IS_ENABLED(CONFIG_KALLSYMS_ALL))
+				symbol_end = (unsigned long)_end;
+			else
+				symbol_end = (unsigned long)_etext;
+		}
 
-	if (symbolsize)
 		*symbolsize = symbol_end - symbol_start;
+	}
 	if (offset)
 		*offset = addr - symbol_start;
 
-- 
2.25.1


