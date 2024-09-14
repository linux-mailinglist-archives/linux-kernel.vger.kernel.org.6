Return-Path: <linux-kernel+bounces-329052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153E9978C84
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 715E9B2367D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557C9463;
	Sat, 14 Sep 2024 01:59:12 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D748C1A
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 01:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726279151; cv=none; b=KPYIcFs4TnODzhVe67X8SIDh/de0CA1tsf6vHxHfwhmVVWcJd6XYC44Dz+Ic7tjJGrK/KMbfVupne4sROL0iHJBnSIfuH38d+DHLsOHgoTMdvORO59wvyNlcx7iReataiQdSSBXOpje5BJv/jfFqfy36YIB5kNcUQLv7h0YGiH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726279151; c=relaxed/simple;
	bh=1yef+0DuIca+tWZ9IuqxSd7PV15QdSYIijO0wPid4EQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SNrr6iYYn3tj2KFX0koNchYCkN3ZHAnaLek7ukHz+/UZ7YldF5lTUt/VMtKC67tEmgqYxV1ERm7A4DNxjyy9sACeewjOji4/ZFnr784h8ojgKEHjcDUvb7A5vDm0SWuLQB0RO3+ognPeyfUbO1+RCYN7qeQC8Qnm7FTgACt5yn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4X5DqD4K1xz1S9vR;
	Sat, 14 Sep 2024 09:58:32 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id E0CA21401F4;
	Sat, 14 Sep 2024 09:59:05 +0800 (CST)
Received: from huawei.com (10.173.127.72) by kwepemd200019.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 09:59:05 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>
CC: <willy@infradead.org>, <david@redhat.com>, <linmiaohe@huawei.com>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/huge_memory: ensure huge_zero_folio won't have large_rmappable flag set
Date: Sat, 14 Sep 2024 09:53:06 +0800
Message-ID: <20240914015306.3656791-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200019.china.huawei.com (7.221.188.193)

Ensure huge_zero_folio won't have large_rmappable flag set. So it can be
reported as thp,zero correctly through stable_page_flags().

Fixes: 5691753d73a2 ("mm: convert huge_zero_page to huge_zero_folio")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2a73efea02d7..4e34b7f89daf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -218,6 +218,8 @@ static bool get_huge_zero_page(void)
 		count_vm_event(THP_ZERO_PAGE_ALLOC_FAILED);
 		return false;
 	}
+	/* Ensure zero folio won't have large_rmappable flag set. */
+	folio_clear_large_rmappable(zero_folio);
 	preempt_disable();
 	if (cmpxchg(&huge_zero_folio, NULL, zero_folio)) {
 		preempt_enable();
-- 
2.33.0


