Return-Path: <linux-kernel+bounces-201856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3EE8FC445
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DCD28798C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8B3DAC17;
	Wed,  5 Jun 2024 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fD/gfTPv"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF5321C190
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571722; cv=none; b=V9zDfgK1s14Z1ZjdpUQACLSvUMGSdzeVbJzMVEE3vuKu2bIOH8OM5/JtGivhc9U8I4DlblPR4OnmcTtlZdNLw7Qf0zAUH1W5iPVjLWxJzw1ZcTzmf7fJfUyaHHigoLuOY1WR8N/uyVgSs+CQfo3/9g6OARVdWatugyUvQlvUVdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571722; c=relaxed/simple;
	bh=MNPWcriUGn3mWR3ZY0iN2pkP7N14YS8clJZTFwJ05Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJBeLtzsfU/TSCa4IqTGkVrQhbsdHQ8L+fmvWx1/mOsJtrvinO8wDREr7Hnku15cKMYgOsIrtVYu9ZHCh38Q0QwIphUhYjL3qYGtUbkAMXwPLeCJvRfHKlGEPcqZrn6EbpiLYekkEkDBCPwJvowbcsnVtz2wtqlMAbc5sHLJXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fD/gfTPv; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717571718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPq/L6362zO9SgmJGiWknKOMwYQmxGr9076aQ1KsSus=;
	b=fD/gfTPvByekqdPzbiQjtEmLUAWXvovHbJ2ABuWxUjXekFVDifvCZ/KC/eGVUL2r73UWM2
	BToI9v2Umvq9kMjCwaLswi1i1LdYrCqFycgwbmsbcjOS9iNqcMuQOjTEA00kCo56W4/xe0
	TBDiewQOm6Ov6ROZbaCG024Ktj+JAVw=
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
Date: Wed, 05 Jun 2024 15:13:55 +0800
Subject: [PATCH v2 2/3] slab: don't put freepointer outside of object if
 only orig_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-b4-slab-debug-v2-2-c535b9cd361c@linux.dev>
References: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
In-Reply-To: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717571706; l=2011;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=MNPWcriUGn3mWR3ZY0iN2pkP7N14YS8clJZTFwJ05Yw=;
 b=JB87AMt4zBO1QCf3L4tRwQF9EA4xx2dZLiX0nJN+Hd6lO7YDGPItst49BP1FaILquk6qB3pCC
 OPGGuLZwQkWCl0tN4tMtmzN0tCz5DSTScx5I6gNc8W5wzQjDtYx7ySh
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

The commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
allocated kmalloc space than requested") will extend right redzone
when allocating for orig_size < object_size. So we can't overlay the
freepointer in the object space in this case.

But the code looks like it forgot to check SLAB_RED_ZONE, since there
won't be extended right redzone if only orig_size enabled.

As we are here, make this complex conditional expressions a little
prettier and add some comments about extending right redzone when
slub_debug_orig_size() enabled.

Reviewed-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7fbd5ce4320a..704c662227e6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5152,10 +5152,9 @@ static int calculate_sizes(struct kmem_cache *s)
 	 */
 	s->inuse = size;
 
-	if (slub_debug_orig_size(s) ||
-	    (flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) ||
-	    ((flags & SLAB_RED_ZONE) && s->object_size < sizeof(void *)) ||
-	    s->ctor) {
+	if ((flags & (SLAB_TYPESAFE_BY_RCU | SLAB_POISON)) || s->ctor ||
+	    ((flags & SLAB_RED_ZONE) &&
+	     (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {
 		/*
 		 * Relocate free pointer after the object if it is not
 		 * permitted to overwrite the first word of the object on
@@ -5163,7 +5162,9 @@ static int calculate_sizes(struct kmem_cache *s)
 		 *
 		 * This is the case if we do RCU, have a constructor or
 		 * destructor, are poisoning the objects, or are
-		 * redzoning an object smaller than sizeof(void *).
+		 * redzoning an object smaller than sizeof(void *) or are
+		 * redzoning an object with slub_debug_orig_size() enabled,
+		 * in which case the right redzone may be extended.
 		 *
 		 * The assumption that s->offset >= s->inuse means free
 		 * pointer is outside of the object is used in the

-- 
2.45.1


