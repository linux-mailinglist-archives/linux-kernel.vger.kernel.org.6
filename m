Return-Path: <linux-kernel+bounces-201857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6098FC446
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9DB288214
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A230191474;
	Wed,  5 Jun 2024 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qxcFtNtf"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FBC191468
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571726; cv=none; b=hx0ClWn2KU9BaPYmSrEVdVv2IGQTa7crWZT8vs3n6vupTa6Q3P63elCOTTvU98zdBrGE1PDfqg0egvDR1l4iKf7EdeDIdSwwpfbkt75A+ZrxvWmWzWABmJ9qP2/TmAgy2dYAbeRWOGOA8YDhSz21nnM/JzZu/HIoD69Ex8McSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571726; c=relaxed/simple;
	bh=SCxsTfzjMuX8t1U69VOCpqhjoMDtoIBWEPozyzP8bk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=axVkz1POcl7VlO7SDKPjMOEjvMOSAuW+3UeUpCqpRmBWwS97tz4/xocWxH1JRbgIsHocIvOYfgWez2FoeaAhF8Tned0rmpdIuvJAkoq5OxOOFXB1Xnx2/vpvhsvfi4YjbttPUyhP0nFQRDLpSx5ebLQv3TqatStu2zcRXpdia14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qxcFtNtf; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717571722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wNm3c6yJSA1CzslM5yifCdzkMkcRenHHavbaO4mwKI=;
	b=qxcFtNtfh4XOLj5fbDe7x94gskzCrv0IXECAZOYe8WkE/kUdaphkQyLX9x1/bqPGakkm66
	qG1VyQRnpT+1yOvZwfIhsDcbUEWqmRY6lsTkfvhHku8VVhUmFlm5BsntZc0p1brvBYdsi/
	mZa9huwlffIJu06AxUx8R5lzWOHx8gY=
X-Envelope-To: penberg@kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: rientjes@google.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: vbabka@suse.cz
X-Envelope-To: chengming.zhou@linux.dev
X-Envelope-To: cl@linux.com
X-Envelope-To: 42.hyeyoo@gmail.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Wed, 05 Jun 2024 15:13:56 +0800
Subject: [PATCH v2 3/3] slab: delete useless RED_INACTIVE and RED_ACTIVE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-b4-slab-debug-v2-3-c535b9cd361c@linux.dev>
References: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
In-Reply-To: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717571706; l=2445;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=SCxsTfzjMuX8t1U69VOCpqhjoMDtoIBWEPozyzP8bk8=;
 b=xtPX9vMkwqmgUtdfVNek9BrOPkMLYsFLuZn30jqV0CJbb33baarp75iix+PtgEHMEQeAQoOPI
 CStzNIZCp8bBqhAhH4N5hrLMahSHW2KmmCWFcqj/P1yTkpDMDZxFsYn
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

These seem useless since we use the SLUB_RED_INACTIVE and SLUB_RED_ACTIVE,
so just delete them, no functional change.

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
index 704c662227e6..0bab0f041ab2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1214,8 +1214,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
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


