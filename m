Return-Path: <linux-kernel+bounces-201854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC968FC442
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7260A1C20AC0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A6BA3F;
	Wed,  5 Jun 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hhHWEWVF"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168418F2E6
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571719; cv=none; b=Kc16hnBpVBqDpdGhNDYPV+lbrHrKcY4vJKrGlRylUGoeG571mT5kmRq9i6MwAajzzapulqZHfWTQgkVsi76ql/7AaOpV71Db5nm41C37QA6w+DRKyHcXIhf01Al3FELCEsxZxdDxoM3T3p6KA6WdkeAkfk+JHysa6bs4HYr+rO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571719; c=relaxed/simple;
	bh=3cTrYeTDe9+jjlLFE6XBms49kHUBVAiJ7qH4E3ODf64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQdnRJ6AjfFBZsyWhAvYr7Bqi0Zy5TmikmXp57/220HhWfLOSjDz89dnQHSduZ/OkN/mRhlwQYvW/FJR1ca3FniWri7vi/CaSAu/FJxNR/BiwePI8ekH+z5SVNIIZ5eJiCboQUgpjJZoy7ryqbPDpa+Ltly2oXj6GYRXEgpTWEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hhHWEWVF; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mm@kvack.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717571714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2D+pNylnFjf5RG+qfCtOObjK/w47If89gLDNwIIJVTc=;
	b=hhHWEWVF9i+5tyUIHca/gW8RdqsCWpblWwJQnToMHatTd8h4pcxUN1YuhUvXBbREOpNnm+
	CaKmK2Pznxt7Avi8g2Hl9oaY7jAajLkDwXzifia3Vo2DNtzgqEppM/UbR3dUJaqh/1t7WU
	O302CuBLMisFIbutmrMhjbbFv5YyN2s=
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
Date: Wed, 05 Jun 2024 15:13:54 +0800
Subject: [PATCH v2 1/3] slab: make check_object() more consistent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-b4-slab-debug-v2-1-c535b9cd361c@linux.dev>
References: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
In-Reply-To: <20240605-b4-slab-debug-v2-0-c535b9cd361c@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717571706; l=4614;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=3cTrYeTDe9+jjlLFE6XBms49kHUBVAiJ7qH4E3ODf64=;
 b=NGXpVPgGWULyXod3B7d12LvFUNBu+MBjXZjftR3heWmAb8bzcA1Sl0+XZPCvnewHGl93bJ6g4
 ahzgjdKSLyxDAA5uw4eIFV6hJ25w/L0b/lGmdcZ4IpjpiOAEOrP+CvS
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

If the above inconsistencies are not intentional, we should fix it.
And we want to do all checks without skipping, so use a local variable
"ret" to save each check result and change check_bytes_and_report() to
only report specific error findings. Then at end of check_object(),
print the trailer once if any found an error.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..7fbd5ce4320a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1192,8 +1192,6 @@ static int check_bytes_and_report(struct kmem_cache *s, struct slab *slab,
 	pr_err("0x%p-0x%p @offset=%tu. First byte 0x%x instead of 0x%x\n",
 					fault, end - 1, fault - addr,
 					fault[0], value);
-	print_trailer(s, slab, object);
-	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 
 skip_bug_print:
 	restore_bytes(s, what, value, fault, end);
@@ -1302,15 +1300,16 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
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
@@ -1319,14 +1318,15 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
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
 
@@ -1342,27 +1342,25 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
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
+	if (!freeptr_outside_object(s) && val == SLUB_RED_ACTIVE &&
+	    !check_valid_pointer(s, slab, get_freepointer(s, p))) {
 		object_err(s, slab, p, "Freepointer corrupt");
 		/*
 		 * No choice but to zap it and thus lose the remainder
@@ -1370,9 +1368,14 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		 * another error because the object count is now wrong.
 		 */
 		set_freepointer(s, p, NULL);
-		return 0;
 	}
-	return 1;
+
+	if (!ret && !slab_add_kunit_errors()) {
+		print_trailer(s, slab, object);
+		add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
+	}
+
+	return ret;
 }
 
 static int check_slab(struct kmem_cache *s, struct slab *slab)

-- 
2.45.1


