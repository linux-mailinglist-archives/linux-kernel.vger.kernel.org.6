Return-Path: <linux-kernel+bounces-375187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B80169A9232
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A07E282310
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB7D1FCC7F;
	Mon, 21 Oct 2024 21:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWbs23gt"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6899110A3E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546872; cv=none; b=dWoVBVXk3M5aRLCwQAhOyxdCbJtnp0TCkoveKytZbOtCqfvKew/4za/4jXiR12XSHQWAmxZOzXl97E8lAdl4izCAQRArVkIeJ2QlRLKGl+RmeWSDFocPPEN9QQseCE3Fgi8KhJyEAoZhXhh9YPPVoIsy6iPUkSZPmF85F5/hr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546872; c=relaxed/simple;
	bh=Vu2gsAxf0dhG5W2BO19GkT8dkXyehrOKBr4iwvk+XLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gNkIkr0el9yRFYRHI6r6uZPMmzAnvHWqqWX7v3uuurgoCOdk7rmL+iwvqsyirQKT5jNptdqwqLCCsVFpFks7RIQS7+NTdwgBd3vSFpMiz+0N7XibnNzx/7arjAQ2WvByGv2Mz5HKSECiEDNn63G4vOLVSEYaPg1HJcNCupIw5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CWbs23gt; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729546868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0H5zrIEbBaEH50QdMDQ/dbUbUI4Gwpqx77GNINb7n3U=;
	b=CWbs23gtMAEGFY0uLPOsBXaKS5B2A/2X6kJBc5VTUdu0YnwEVxeIfUHBu1nrbbCgMvhUEN
	zgduNwXffadkcbE015K05T/ASJAgSN2ladFEgQi3iIYGOGeKkIDA5VOFHy88mUMvJrCHUD
	kJL73W9i1bJv3Xw2OXcVOuzMiPL/VnQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs: Use str_yes_no() helper function in btrfs_dump_free_space()
Date: Mon, 21 Oct 2024 23:40:22 +0200
Message-ID: <20241021214022.31010-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() and str_no_yes()
helper functions.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/btrfs/free-space-cache.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index f4bcb2530660..122dbfdec41e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -11,6 +11,7 @@
 #include <linux/ratelimit.h>
 #include <linux/error-injection.h>
 #include <linux/sched/mm.h>
+#include <linux/string_choices.h>
 #include "ctree.h"
 #include "fs.h"
 #include "messages.h"
@@ -2936,12 +2937,11 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 		if (info->bytes >= bytes && !block_group->ro)
 			count++;
 		btrfs_crit(fs_info, "entry offset %llu, bytes %llu, bitmap %s",
-			   info->offset, info->bytes,
-		       (info->bitmap) ? "yes" : "no");
+			   info->offset, info->bytes, str_yes_no(info->bitmap));
 	}
 	spin_unlock(&ctl->tree_lock);
 	btrfs_info(fs_info, "block group has cluster?: %s",
-	       list_empty(&block_group->cluster_list) ? "no" : "yes");
+	       str_no_yes(list_empty(&block_group->cluster_list)));
 	btrfs_info(fs_info,
 		   "%d free space entries at or bigger than %llu bytes",
 		   count, bytes);
-- 
2.47.0


