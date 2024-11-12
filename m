Return-Path: <linux-kernel+bounces-406527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B64D9C6071
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B8E2851E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F421744B;
	Tue, 12 Nov 2024 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YxZJ5DeX"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341E92170D3
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436304; cv=none; b=M1HpftaDZup6FB8X50HezNXLZVoyB0UOCouEFFo/XRIX5M9cllbLQXulZkmd4f0BME+cT2zwMcQlEI5OQg+a/AaKQdMf6DpHZXXl0dl11U/ABGtRV2TXDtID9vklB3eUu6s41n0thH1R2zv/U1gDK+I7C5fCfC9sAeGe6rJq2Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436304; c=relaxed/simple;
	bh=muS5YqxBg1X4aKFuoG3dKehUBVF2a3t+rvoZaz64Fy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXgsmLCivxKBVS7YJe90RjRp3T+WQpZ8fSaT4AJgfNSHHYwhQXURD95DuRj7bEWT0vGvKqTIhqhVJMOdagznW07oYeXDjyEA7f1WCsrblR6Q0E7lOPkGe+aVwM6T4KqjSfciUtAVN+eNTolr6ws0fXkIatDBYL5PaDMbw4ZpYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YxZJ5DeX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731436300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0hPGUSawC3wfWVUaw8imv0OPqbrEwJlGlsqYQZ9dtME=;
	b=YxZJ5DeXQCszRej4fDorjEZSMYJ72k/sG0pUZPjWHKvAo7y0NNk458TBedYu/ez7YpWImb
	1FhJ48RFUHTxQwwIk60kpQ9rVwGEYbPRUcCEIWY4nmtT/VlKr6gWfubiua+qKSmxC8+p03
	0Y7dmQyxzYmxs58A2p+EuFQC8vI15QI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] jffs2: Use str_yes_no() helper function
Date: Tue, 12 Nov 2024 19:31:11 +0100
Message-ID: <20241112183113.173127-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/jffs2/nodemgmt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/jffs2/nodemgmt.c b/fs/jffs2/nodemgmt.c
index bbab2bdc71b6..69569864630e 100644
--- a/fs/jffs2/nodemgmt.c
+++ b/fs/jffs2/nodemgmt.c
@@ -15,6 +15,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/compiler.h>
 #include <linux/sched/signal.h>
+#include <linux/string_choices.h>
 #include "nodelist.h"
 #include "debug.h"
 
@@ -317,9 +318,9 @@ static int jffs2_find_nextblock(struct jffs2_sb_info *c)
 			   And there's no space left. At all. */
 			pr_crit("Argh. No free space left for GC. nr_erasing_blocks is %d. nr_free_blocks is %d. (erasableempty: %s, erasingempty: %s, erasependingempty: %s)\n",
 				c->nr_erasing_blocks, c->nr_free_blocks,
-				list_empty(&c->erasable_list) ? "yes" : "no",
-				list_empty(&c->erasing_list) ? "yes" : "no",
-				list_empty(&c->erase_pending_list) ? "yes" : "no");
+				str_yes_no(list_empty(&c->erasable_list)),
+				str_yes_no(list_empty(&c->erasing_list)),
+				str_yes_no(list_empty(&c->erase_pending_list)));
 			return -ENOSPC;
 		}
 
@@ -883,7 +884,7 @@ int jffs2_thread_should_wake(struct jffs2_sb_info *c)
 
 	jffs2_dbg(1, "%s(): nr_free_blocks %d, nr_erasing_blocks %d, dirty_size 0x%x, vdirty_blocks %d: %s\n",
 		  __func__, c->nr_free_blocks, c->nr_erasing_blocks,
-		  c->dirty_size, nr_very_dirty, ret ? "yes" : "no");
+		  c->dirty_size, nr_very_dirty, str_yes_no(ret));
 
 	return ret;
 }
-- 
2.47.0


