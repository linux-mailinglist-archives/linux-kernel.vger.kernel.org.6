Return-Path: <linux-kernel+bounces-191859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ECC8D1532
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A921C21AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5D773164;
	Tue, 28 May 2024 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GIZhwNmj"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A864D75809
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880686; cv=none; b=UxOdyVyd5a+6u+HryjszIjkC2x1SdxoU1N9ceu9F9SKxDvcCR2lzEMdfX+Cptm/lXSSKvuEq7mKTjhb/yXzhsiGTdztjsqyYXeaosA1ruqDT0sUwLZzsEKwOfhqSONpiV4cN8cXiYHEX/xyt+vHR9ZHHqkDwKfB7/SKIK+zffTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880686; c=relaxed/simple;
	bh=+rkgEJu+y9vxTpB/JnC+X49HMuwavO1IjQ2oUQ25XPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0JJAUsmTy1W21OjbSkSjJafdw7l6SUY5K+WFXINulxfWpdtmyqNs0EpwY2y1rOhlRqv84oMI2tW7zAFwaGdHe+oT244QtsGJJtkxfC5xpxDSucniNLROLTa+7m07NBHH1p+6Wjke0F4DGFk1vdkicYAi51UM6mcSsCKbmMzQsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GIZhwNmj; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716880683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6mzSTL6xyZKONSteLTPcFdPTWlXRiPL9M+VrIHD2DrE=;
	b=GIZhwNmjd1A4KLiPMPJMJwLEdtYLjZEWMLDVF/mgiQC7dRxnpaGjt8gm2zEBpZ2YwPpjxc
	lWXClyUiDYKdNBioPOdE539JD1qfT7toEdPMJALk9hyrilyE2wagz0Qmcv4485nsKcJPEb
	ycRsxGC3SmhpkK1K0MSpAgxvwJFsfYw=
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: roman.gushchin@linux.dev
X-Envelope-To: 42.hyeyoo@gmail.com
X-Envelope-To: iamjoonsoo.kim@lge.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: rientjes@google.com
X-Envelope-To: zhouchengming@bytedance.com
X-Envelope-To: penberg@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: feng.tang@intel.com
X-Envelope-To: cl@linux.com
X-Envelope-To: chengming.zhou@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
Date: Tue, 28 May 2024 15:16:48 +0800
Subject: [PATCH 3/3] slab: delete useless RED_INACTIVE and RED_ACTIVE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-b4-slab-debug-v1-3-8694ef4802df@linux.dev>
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
In-Reply-To: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716880668; l=2445;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=+rkgEJu+y9vxTpB/JnC+X49HMuwavO1IjQ2oUQ25XPg=;
 b=p/Psm2cQFQg7eXrJTvAMRypLyeXst5Pvu3ic2rgJ9awXVqHSyYAR8OY0r0xAZL//twzZAOluA
 tjn4CHCQYdgDf6pSTcOuq72rE4nnzdl+0iwbtPtXtAT5aFmXeza/3jp
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
index b92d9a557852..9af868fa68a4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1216,8 +1216,8 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
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


