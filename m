Return-Path: <linux-kernel+bounces-205618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC2D8FFE2C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C551F247A9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C35715B54A;
	Fri,  7 Jun 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FRcixKR6"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD8815B135
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749664; cv=none; b=AJ+sR37+Vf90N/ea3cGEYCITfHAmyizaqz0t8vr1ajyzc6iw3MKfJbwyJtcSRQuAZPJKDJz+ig64iNBIZrBv2CLvU8kAw5j2mUtH3QSnN+UpzBbR2j6yTBrEHtkOZruLMvaxDah9hYpmhO+z6JBI90kP65LvF40eKCr5geONNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749664; c=relaxed/simple;
	bh=HrPAwtMOeYeTV8i4zs/HyF+XzjWDLITsYcMCCwBJKjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKN2DyxFXal/YQU9Y7zW5ddGkLtVYMIvPvr5zeo/8aUYsM3dLa0ymt0uL0vDOG4CCWR97yRgFKhYrX0LrEbFImlUdgwyP+PghCjtLynqMNmx7yrelWtwv4ZmElEFbw6/tlOmnuVr1MUGRENQkfTrH6sFvkmShU0VJFfAwR9FOGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FRcixKR6; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717749660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ry4pUT0wLp2rsQ9gaswXTMi4aahc6CD0b0+IGJL1qoc=;
	b=FRcixKR6sKrZnRAihVBRcSYK+FzLr1DTKGdjp7gt7YjG5xNLhkZKrAE/H76ecCGUaGvyEl
	+Q/8BaJeIRX2/qAySlikCNZYqDOygv5xawpTX5p4zGCiiOujXilQsF0sT6oyL3SNYihAuY
	OqAYNTMpowc1/RKf+uZ2zKUROli77is=
X-Envelope-To: cl@linux.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: penberg@kernel.org
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Fri, 07 Jun 2024 16:40:14 +0800
Subject: [PATCH v3 3/3] slab: delete useless RED_INACTIVE and RED_ACTIVE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-b4-slab-debug-v3-3-bb2a326c4ceb@linux.dev>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
In-Reply-To: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717749639; l=2492;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=HrPAwtMOeYeTV8i4zs/HyF+XzjWDLITsYcMCCwBJKjk=;
 b=0CWA1/J60O55kCn+Cliv8N6QcksKBT2/nb1uYUtntzcYzA4/3nHZS/oGeU/wqaO43cxUe9VK3
 x/KnumkFAuTCC+ZC6HiCZJwshbZvD3XI8TRNVUKnUxr7RfCfVjRiD/G
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

These seem useless since we use the SLUB_RED_INACTIVE and SLUB_RED_ACTIVE,
so just delete them, no functional change.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 include/linux/poison.h       | 7 ++-----
 mm/slub.c                    | 4 ++--
 tools/include/linux/poison.h | 7 ++-----
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/linux/poison.h b/include/linux/poison.h
index 1f0ee2459f2a..9c1a035af97c 100644
--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -38,11 +38,8 @@
  * Magic nums for obj red zoning.
  * Placed in the first word before and the first word after an obj.
  */
-#define	RED_INACTIVE	0x09F911029D74E35BULL	/* when obj is inactive */
-#define	RED_ACTIVE	0xD84156C5635688C0ULL	/* when obj is active */
-
-#define SLUB_RED_INACTIVE	0xbb
-#define SLUB_RED_ACTIVE		0xcc
+#define SLUB_RED_INACTIVE	0xbb	/* when obj is inactive */
+#define SLUB_RED_ACTIVE		0xcc	/* when obj is active */
 
 /* ...and for poisoning */
 #define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */
diff --git a/mm/slub.c b/mm/slub.c
index 1551a0345650..efa7c88d8d8c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1230,8 +1230,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
  * 	Padding is extended by another word if Redzoning is enabled and
  * 	object_size == inuse.
  *
- * 	We fill with 0xbb (RED_INACTIVE) for inactive objects and with
- * 	0xcc (RED_ACTIVE) for objects in use.
+ * 	We fill with 0xbb (SLUB_RED_INACTIVE) for inactive objects and with
+ * 	0xcc (SLUB_RED_ACTIVE) for objects in use.
  *
  * object + s->inuse
  * 	Meta data starts here.
diff --git a/tools/include/linux/poison.h b/tools/include/linux/poison.h
index 2e6338ac5eed..e530e54046c9 100644
--- a/tools/include/linux/poison.h
+++ b/tools/include/linux/poison.h
@@ -47,11 +47,8 @@
  * Magic nums for obj red zoning.
  * Placed in the first word before and the first word after an obj.
  */
-#define	RED_INACTIVE	0x09F911029D74E35BULL	/* when obj is inactive */
-#define	RED_ACTIVE	0xD84156C5635688C0ULL	/* when obj is active */
-
-#define SLUB_RED_INACTIVE	0xbb
-#define SLUB_RED_ACTIVE		0xcc
+#define SLUB_RED_INACTIVE	0xbb	/* when obj is inactive */
+#define SLUB_RED_ACTIVE		0xcc	/* when obj is active */
 
 /* ...and for poisoning */
 #define	POISON_INUSE	0x5a	/* for use-uninitialised poisoning */

-- 
2.45.1


