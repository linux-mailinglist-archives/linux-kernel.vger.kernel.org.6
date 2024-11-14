Return-Path: <linux-kernel+bounces-409989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7659C9519
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE582812E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C5A1AF0DA;
	Thu, 14 Nov 2024 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PrKWzyAh"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5D1ADFE2
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622547; cv=none; b=OKPo598SeRu35lL1QV/ri31FT4EZbkfqPdJQpTFhDDXir9O9uWr6EGk7dpUA61h+a1/VqytBGFnWYADJxsszxk2M0AtofX4m+s7wmuMdH4PiZUeaR3hupfA63qi2O/m6T4NFB5Y5X92ca8z9LG32gHjDgDGerNDLYw9Yjmu1aGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622547; c=relaxed/simple;
	bh=MYkHd8As34CFbGENrqkCxmOAaeYY73357pJ8flFE+A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StZ02DjAq+92S6rAznmE9KNs/ZApofZ/nfEH/RWEh2PKJmm3sR8K0oBlxn0tWBH61rLgZ+C2MUi8Xy2yiJHJ81b9NxNyFrUQV8g+Rv1taRyHI3KKNWAepsQ5BFm89oUKWdSTASRrwSlPGXnHMJTcAb9b25YgGgdTYMdhjnAID94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PrKWzyAh; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731622543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kg0r27nDHYo0HTdQPuoNFOxroH69LZyYnbGGxN3ORMk=;
	b=PrKWzyAh+NAke01/Vl7QXLJstJ5J69wvo63D0+65cNoS75oyrXbFBI6d7vvRAhT1pYdUCQ
	2VdnLmM9BvS75E+h9nOaSlGhlmzQ1AS6VRy0X4DSVSrktvM75S1r6nbetnhTjeK8i16ti7
	lMBFLcvYP8+6xa7lpCZr316dpWe5wQw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Use str_plural() instead of PLURAL() macro
Date: Thu, 14 Nov 2024 23:14:39 +0100
Message-ID: <20241114221438.38775-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the custom PLURAL() macro and use the str_plural() function
instead.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ext4/orphan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index e5b47dda3317..1320f91c9b3b 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -4,6 +4,7 @@
 #include <linux/fs.h>
 #include <linux/quotaops.h>
 #include <linux/buffer_head.h>
+#include <linux/string_choices.h>
 
 #include "ext4.h"
 #include "ext4_jbd2.h"
@@ -488,14 +489,12 @@ void ext4_orphan_cleanup(struct super_block *sb, struct ext4_super_block *es)
 		}
 	}
 
-#define PLURAL(x) (x), ((x) == 1) ? "" : "s"
-
 	if (nr_orphans)
 		ext4_msg(sb, KERN_INFO, "%d orphan inode%s deleted",
-		       PLURAL(nr_orphans));
+			 nr_orphans, str_plural(nr_orphans));
 	if (nr_truncates)
 		ext4_msg(sb, KERN_INFO, "%d truncate%s cleaned up",
-		       PLURAL(nr_truncates));
+			 nr_truncates, str_plural(nr_truncates));
 #ifdef CONFIG_QUOTA
 	/* Turn off quotas if they were enabled for orphan cleanup */
 	if (quota_update) {
-- 
2.47.0


