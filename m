Return-Path: <linux-kernel+bounces-383105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D940B9B1762
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24052834BE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AF01D31A8;
	Sat, 26 Oct 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T9S6nQ7p"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C8217F29
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729941602; cv=none; b=a4SY+YVLRRQyJqhdU4z/p/mxZsY97Q9u38YtPmudW61mM5XRPgq/9b0acHkVMDCqIUcKKsZ+1ur5Typv6J9wS9/Wm3dceFltg51y50GtGoRnMO6Z0n87HbyC2PIhaVOVQawbyaKDY7gJymX5YA+UQYgjeDj6wBh337YAQxQFNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729941602; c=relaxed/simple;
	bh=Wr90PPyGj7oE1usB14FF2SfQPgY14nFNS9y+LVpn1ZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NSAuVXgIpqd1eRAThX/1BQSlLp87XW922oBJSWmJBlUmM2jpiYHiB+Fj3cpl7Sh4KdsDx8k6yLVVzDEHqFp3y0u9ijfp71Q/SO4QjmN0RUDZN91t71ns9uvDwQtPtWZi+5SN2m10FFh1jDe/VyC7MFfAiH27mslOfRRYXEf6spA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T9S6nQ7p; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729941597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YkfR3XXa1FN60hHxLp7IUWUPbFEEJE5jIJYSvpSonkU=;
	b=T9S6nQ7pMxzKS/ITlvNfmuC9+YWt/ZyasqB7YFPs7PW2GATPVzp4wySy3ctLgWua2ZHAXn
	YHhvRz12UYYpK9npneY7pSUUDTJt1NjTTcxFjjoa5FvCWPWYssm0oLUWi4pXaCqQBdIM8O
	mtB4g9gsEgS2pey0NO0+YwMbTAlZquk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Zhihao Cheng <chengzhihao1@huawei.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] jffs2: Use str_yes_no() helper function
Date: Sat, 26 Oct 2024 13:19:01 +0200
Message-ID: <20241026111903.112647-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

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


