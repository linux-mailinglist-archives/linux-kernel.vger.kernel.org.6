Return-Path: <linux-kernel+bounces-205617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCB08FFE2B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114251C2303A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D615B14E;
	Fri,  7 Jun 2024 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e9yKJrsJ"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BF15B145
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749660; cv=none; b=sPRbT/jV7WZMdt8c16BjNCVOZ1OI8CPa+v+9s6+L0/0k9GLY4DWWUfYUJQ5RclwBXlRrFsjKhuQAi2JC5XQyqRmBm0fYg5WI+AqvTik8qCZBbJl5V0IKXfHwgI8j1z4gfFgeUFOiQsH3y49vv77168G4frEg0NxG4DIaAekTxAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749660; c=relaxed/simple;
	bh=bn0rvFBpWAZhns05Xqu0KeFYe1or4fDM7A08yx3Psto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkrKxVwI7r4R3FIqTIoB3grlke0H8AHCm+8bFx1v9IG1msWQONMojapXp85ujqHFCJX0ISjrKwldklgfM9WsINh2geY9dLuxfZM26cyvwZOiLuRR1I6XK1+fpcYzZ1FfawDsmUC+PdPc02gW7nIQ0fYZGHLENsy4uvMsBVb5dm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e9yKJrsJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717749656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8yWyiipM81e8Qi1LyYy64GATjSdpFn6JGZvmprGhI=;
	b=e9yKJrsJCyHtaE6gVXuVQZ6ME1Lqhp0vXYf9L7qHjqQAGh3lA2m35CXSJdRDlg51u2z+fz
	DZKQxelkJdemyDRYlVnekXq5f1oKkkhvCyqyoU8/3lhbDj6e3gmI9F7aSeBwYif1fA1uMC
	VB8TpBNhvx+5rjqXmLu5oO2tH5/6fBM=
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
Date: Fri, 07 Jun 2024 16:40:13 +0800
Subject: [PATCH v3 2/3] slab: don't put freepointer outside of object if
 only orig_size
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-b4-slab-debug-v3-2-bb2a326c4ceb@linux.dev>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
In-Reply-To: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717749639; l=2058;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=bn0rvFBpWAZhns05Xqu0KeFYe1or4fDM7A08yx3Psto=;
 b=EuZ0xsakv2Ol3sPIh0H8VsgQnTrIw6dnox/41Kp96uAXgh1BW2zow6fYw1U6Rfy0z1KMEzF+T
 lLAWR3T1+rZBIqhuQg+F2qjIYANliGwimvM7/uSh7c6p94F5n11MfVY
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 45f89d4bb687..1551a0345650 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5169,10 +5169,9 @@ static int calculate_sizes(struct kmem_cache *s)
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
@@ -5180,7 +5179,9 @@ static int calculate_sizes(struct kmem_cache *s)
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


