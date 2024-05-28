Return-Path: <linux-kernel+bounces-191858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FCB8D1530
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3419284931
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D38D74BE1;
	Tue, 28 May 2024 07:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SEBbDj5i"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9AF7347D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880683; cv=none; b=LDXrAlh2rdGpetqGRBMkHJ8PBiv4jOUQGGpAzFR7rCW6qZMKx7Vf5GZspO8U/G6k5K4cVBhGQxf0IKpiZLRPcv4/ZkiGSPqDG56us4u6igx837RJ0llB9nmPBeiV+2YkjJe7WWqh9KL9Kh2UDgL8zicDFquC/dY+2HPaa35NTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880683; c=relaxed/simple;
	bh=OAs8MxXLtIhTSqTGWgQ7wsTa/TCkscfJBOGmaKB4LwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unFJ3OAmG054JsdWhmiFpYzi9G4UHIW7usk6n3O0IJI7jylVuxoQuXdkFmadTb9khZGtmQyyOJZwTcQ/KjD/Ore37IEdQmiKXB8VeoqMKjVt1KuyoMhQJQmL3vxHoQCaXKSR2A060VEFGfknZkTwNKbcBjQyZ9SfMmH9tzGZ/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SEBbDj5i; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716880679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+MMiU+hJI9q1Zpsvvem9u01PNIF7co9luviAiwm46A=;
	b=SEBbDj5iQ0RtgZMw50efLVdPSDVtXyc5k8515RoFoCTfmT/HtmBY+r+CF75WL1HVTTUUbN
	k6CFFp50+wHvbBXgVcZ0Rz0AcFS6h2MSn0MvT/2hgQ+xH/vXyaMrdUiYEbJst1ffqteTV2
	79h2PGaUF+u3WftcItCTi3AyelEIgfs=
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
Date: Tue, 28 May 2024 15:16:47 +0800
Subject: [PATCH 2/3] slab: don't put freepointer outside of object if only
 orig_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-b4-slab-debug-v1-2-8694ef4802df@linux.dev>
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
In-Reply-To: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716880668; l=989;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=OAs8MxXLtIhTSqTGWgQ7wsTa/TCkscfJBOGmaKB4LwE=;
 b=p4YWEPoHk/1slgsxuoFe3wjzjGAgCTzN7Ezd+jn3y503ZqujeWT7WGSlSNnfWVTLYAXmJ/UQC
 ZITkx44lFWFCzoR5YLWtDFwKy3MXxO+FKc79rS/9mFLv5IInX1yK0ZP
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

The commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
allocated kmalloc space than requested") will extend right redzone
when allocating for orig_size < object_size. So we can't overlay the
freepointer in the object space in this case.

But the code looks like it forgot to check SLAB_RED_ZONE, since there
won't be extended right redzone if only orig_size enabled.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index de57512734ac..b92d9a557852 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5150,7 +5150,7 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->inuse = size;
 
-	if (slub_debug_orig_size(s) ||
+	if (((flags & SLAB_RED_ZONE) && slub_debug_orig_size(s)) ||
 	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
 	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
 	    s->ctor) {

-- 
2.45.1


