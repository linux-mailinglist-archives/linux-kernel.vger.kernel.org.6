Return-Path: <linux-kernel+bounces-211061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6706D904CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136A91F24AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61316D4FC;
	Wed, 12 Jun 2024 07:22:41 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C516C44C;
	Wed, 12 Jun 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176961; cv=none; b=mfDYu0R4WtNvGURVeRYXaX9eqrVImIE7kMGds6tSWjf2QBLv6RUWObg+qxM4zuwqxv01LZeH31mLbcPDc9QXEHG+oiEoWk2jd06VFe32Wgy8+37dhkllKZUxoGgssMWsAC4KhlZ8k1puC0AVaYAOCH1RDNO8irk9lsRtke8/Hng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176961; c=relaxed/simple;
	bh=WHHs7idYRzoEGuXmcyZ8bcVwyBbgz6mH+0HZTrbe8Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX/KmiyzxAqDzkRrtKKrXxCdRMCeCy4rAwKOfQg440ljlt+0bS1+r+WkUle1xliXyDLc8zMym8//p2TcuVl/fQAMWXYVxhjiML45aAf2TV1ADB2O0WWSAqIrW1iRT1lzEY/yrE+xemnK+fIt0+JrrMJp6KI60rUH8gWYDbCyCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VzcMq6SsNz1JChd;
	Wed, 12 Jun 2024 15:18:31 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 664BB180AA6;
	Wed, 12 Jun 2024 15:22:22 +0800 (CST)
Received: from huawei.com (10.173.127.72) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Jun
 2024 15:22:21 +0800
From: Miaohe Lin <linmiaohe@huawei.com>
To: <akpm@linux-foundation.org>, <tony.luck@intel.com>, <bp@alien8.de>
CC: <nao.horiguchi@gmail.com>, <linmiaohe@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
Subject: [PATCH v3 06/13] mm/memory-failure: remove confusing initialization to count
Date: Wed, 12 Jun 2024 15:18:28 +0800
Message-ID: <20240612071835.157004-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240612071835.157004-1-linmiaohe@huawei.com>
References: <20240612071835.157004-1-linmiaohe@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

It's meaningless and confusing to init local variable count to 1.
Remove it. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ec482524158e..339752d768d8 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2542,7 +2542,7 @@ int unpoison_memory(unsigned long pfn)
 	struct folio *folio;
 	struct page *p;
 	int ret = -EBUSY, ghp;
-	unsigned long count = 1;
+	unsigned long count;
 	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
 					DEFAULT_RATELIMIT_BURST);
-- 
2.33.0


