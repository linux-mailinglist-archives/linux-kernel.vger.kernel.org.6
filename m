Return-Path: <linux-kernel+bounces-205616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAEA8FFE2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189531F216E8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D4F15B122;
	Fri,  7 Jun 2024 08:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GTo9ZKZ0"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A5015B13C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 08:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749655; cv=none; b=CP1Qcs3e0Su+lfa/h/616iECBDlQpcDB75Tt2O3OI9yyE/2qdhCJgSU4o2BbckLqz6RDp8tE/3102AYjFCbylSHANpMnivz8kuT/ZcJpz4TzIZ9JthmJ5KhHn21QKZfCpUoHkoK4GpW+fFhRnZE7j/klQfm1wc9rRn3axb5f/YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749655; c=relaxed/simple;
	bh=jNo30y7XyYnMpzRv5EeQvmszAtqnlzceibCy6q+bczY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nJelS8Rgk+IcPg/RiGXsuT5gsqKyAZrp0LD82S8o4VAwSYHRnP8mWAzKV/Dn7gnKEtAD1q2kdH6d0SIt1hxjVAFrXwlhGYo6Ym/Y5pAq1iJXD4brz79tF0vilpp1o8jYhqLqDD09xEznd5TnHNcIBvkIgr9AgMG//NiUHnLHaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GTo9ZKZ0; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717749652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co4mRSLXEk4/0neADLChuXkANUmkwfIKXrx3b3r5sIM=;
	b=GTo9ZKZ0MUU5l0W21DXR9nh5FY/hFlzuv0JZ0Cf62BpcKJ4253EFjtFkJoqeO0z0kAg6/4
	3NfxFcj6/UzN2GcLdP7LGjocwmvmAnG+M3XYUthkWTaQFM3smEXquqUD+B2QRjnA2GWYKk
	eRxtY4oCemD/tBZDlf621DBgIo/4wYY=
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
Date: Fri, 07 Jun 2024 16:40:12 +0800
Subject: [PATCH v3 1/3] slab: make check_object() more consistent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
In-Reply-To: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717749639; l=5212;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=jNo30y7XyYnMpzRv5EeQvmszAtqnlzceibCy6q+bczY=;
 b=8qobh7yV/EnGOH6lDYM9lDREVDzGWVOsOySTHnQsWoLnsOeHzxJrjXV2T3JsZ2PAXn4oGYipV
 AYtq3WlnERSB1Bo10ITWmgVmU5ScGQ4Pe9KFgy6nOFFCRbNmnLBn9Yl
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

Now check_object() calls check_bytes_and_report() multiple times to
check every section of the object it cares about, like left and right
redzones, object poison, paddings poison and freepointer. It will
abort the checking process and return 0 once it finds an error.

There are two inconsistencies in check_object(), which are alignment
padding checking and object padding checking. We only print the error
messages but don't return 0 to tell callers that something is wrong
and needs to be handled. Please see alloc_debug_processing() and
free_debug_processing() for details.

We want to do all checks without skipping, so use a local variable
"ret" to save each check result and change check_bytes_and_report() to
only report specific error findings. Then at end of check_object(),
print the trailer once if any found an error.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 62 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..45f89d4bb687 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -788,8 +788,24 @@ static bool slab_add_kunit_errors(void)
 	kunit_put_resource(resource);
 	return true;
 }
+
+static bool slab_in_kunit_test(void)
+{
+	struct kunit_resource *resource;
+
+	if (!kunit_get_current_test())
+		return false;
+
+	resource = kunit_find_named_resource(current->kunit_test, "slab_errors");
+	if (!resource)
+		return false;
+
+	kunit_put_resource(resource);
+	return true;
+}
 #else
 static inline bool slab_add_kunit_errors(void) { return false; }
+static inline bool slab_in_kunit_test(void) { return false; }
 #endif
 
 static inline unsigned int size_from_object(struct kmem_cache *s)
@@ -1192,8 +1208,6 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
-	print_trailer(s, slab, object);
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
@@ -1302,15 +1316,16 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 	u8 *p = object;
 	u8 *endobject = object + s->object_size;
 	unsigned int orig_size, kasan_meta_size;
+	int ret = 1;
 
 	if (s->flags & SLAB_RED_ZONE) {
 		if (!check_bytes_and_report(s, slab, object, "Left Redzone",
 			object - s->red_left_pad, val, s->red_left_pad))
-			return 0;
+			ret = 0;
 
 		if (!check_bytes_and_report(s, slab, object, "Right Redzone",
 			endobject, val, s->inuse - s->object_size))
-			return 0;
+			ret = 0;
 
 		if (slub_debug_orig_size(s) && val == SLUB_RED_ACTIVE) {
 			orig_size = get_orig_size(s, object);
@@ -1319,14 +1334,15 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 				!check_bytes_and_report(s, slab, object,
 					"kmalloc Redzone", p + orig_size,
 					val, s->object_size - orig_size)) {
-				return 0;
+				ret = 0;
 			}
 		}
 	} else {
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
-			check_bytes_and_report(s, slab, p, "Alignment padding",
+			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
-				s->inuse - s->object_size);
+				s->inuse - s->object_size))
+				ret = 0;
 		}
 	}
 
@@ -1342,27 +1358,25 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 			    !check_bytes_and_report(s, slab, p, "Poison",
 					p + kasan_meta_size, POISON_FREE,
 					s->object_size - kasan_meta_size - 1))
-				return 0;
+				ret = 0;
 			if (kasan_meta_size < s->object_size &&
 			    !check_bytes_and_report(s, slab, p, "End Poison",
 					p + s->object_size - 1, POISON_END, 1))
-				return 0;
+				ret = 0;
 		}
 		/*
 		 * check_pad_bytes cleans up on its own.
 		 */
-		check_pad_bytes(s, slab, p);
+		if (!check_pad_bytes(s, slab, p))
+			ret = 0;
 	}
 
-	if (!freeptr_outside_object(s) && val == SLUB_RED_ACTIVE)
-		/*
-		 * Object and freepointer overlap. Cannot check
-		 * freepointer while object is allocated.
-		 */
-		return 1;
-
-	/* Check free pointer validity */
-	if (!check_valid_pointer(s, slab, get_freepointer(s, p))) {
+	/*
+	 * Cannot check freepointer while object is allocated if
+	 * object and freepointer overlap.
+	 */
+	if ((freeptr_outside_object(s) || val != SLUB_RED_ACTIVE) &&
+	    !check_valid_pointer(s, slab, get_freepointer(s, p))) {
 		object_err(s, slab, p, "Freepointer corrupt");
 		/*
 		 * No choice but to zap it and thus lose the remainder
@@ -1370,9 +1384,15 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		 * another error because the object count is now wrong.
 		 */
 		set_freepointer(s, p, NULL);
-		return 0;
+		ret = 0;
 	}
-	return 1;
+
+	if (!ret && !slab_in_kunit_test()) {
+		print_trailer(s, slab, object);
+		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+	}
+
+	return ret;
 }
 
 static int check_slab(struct kmem_cache *s, struct slab *slab)

-- 
2.45.1


