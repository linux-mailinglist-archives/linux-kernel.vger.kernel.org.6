Return-Path: <linux-kernel+bounces-295080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9FB959665
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90D92866B4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACD21C3301;
	Wed, 21 Aug 2024 07:54:53 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405781C32F9
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226893; cv=none; b=IwPj/dL1UP6k6Gd3xZWVTPRDs/AWvwE4QhyP7ZBz2cBkESEDFPc4EtM6p8wqcK9glTd6jGcu5rqLsCxlm99KVzCljNR3IQBBSBRyvcLfbqoiat058d0Hcx5uKvK9/IueIctMDIvB9j2WLh7spMYgMddvgaum0iQlRqfvz4NNqOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226893; c=relaxed/simple;
	bh=ehnzRacGYsLSTMSoBRgaj4cdsfx2PZHPLztzOSDIcw4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGq5god/BIfylmwkI/zscphodunwI55tBo8/QT9QBZYB4O9lCTCFIS1M55+YWkvQVo9A+0SbYuegibh+zymuJnnxYCdSQVYwsm97uU8vkXkQp3RKqljytrBy+pejrAQYijQvuTuDNrKLCaDSvFke7D9PhNWPD8u4j1W4I4WvSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wpdq3022DzhY1k;
	Wed, 21 Aug 2024 15:52:47 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 81A0618009B;
	Wed, 21 Aug 2024 15:54:47 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 15:54:47 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mm/page_poison: slightly optimize check_poison_mem()
Date: Wed, 21 Aug 2024 15:53:11 +0800
Message-ID: <20240821075311.1953-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)

When the debug information needs to be suppressed due to ratelimit,
it is unnecessary to determine the end of the corrupted memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 mm/page_poison.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/page_poison.c b/mm/page_poison.c
index 3e9037363cf9d85..23fa799214720f1 100644
--- a/mm/page_poison.c
+++ b/mm/page_poison.c
@@ -55,14 +55,15 @@ static void check_poison_mem(struct page *page, unsigned char *mem, size_t bytes
 	if (!start)
 		return;
 
+	if (!__ratelimit(&ratelimit))
+		return;
+
 	for (end = mem + bytes - 1; end > start; end--) {
 		if (*end != PAGE_POISON)
 			break;
 	}
 
-	if (!__ratelimit(&ratelimit))
-		return;
-	else if (start == end && single_bit_flip(*start, PAGE_POISON))
+	if (start == end && single_bit_flip(*start, PAGE_POISON))
 		pr_err("pagealloc: single bit error\n");
 	else
 		pr_err("pagealloc: memory corruption\n");
-- 
2.34.1


