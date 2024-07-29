Return-Path: <linux-kernel+bounces-266259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C804593FD43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57559B21E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D916F0C5;
	Mon, 29 Jul 2024 18:22:32 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA91E49B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277351; cv=none; b=FBhYp1cvqWbrEVetKOmRF07od8AM4ls0J6T1TyxxNlo4qX0kgVbnYoQ5go3CHbNB4IZA4uHO3QZmDTxKF2UyBJ+eOFlWToyGLxlZjXvxtH7vumYR3vYc7Aq1I14Db8WRibCaiyznR9Ltzgl+zCtrH6EhkaCsy4XOy4Vh+FIYqQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277351; c=relaxed/simple;
	bh=iJeW6z66lfMizNZ7812hx1FRV+TFj4yox8mHWfyYRDk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gCkz5WHSth3sjkcqpFFd+8iqGXSz0kwvMi4ywjeI35RTllc6rTqND8t9MiejxC1j2QVNnhkksPNlO3it00M0Kw29LT+/2hw++RkF6xo3nO+ipIPRFVWy/7X34c2GU0I19rS1xZUpE4mA7E/MrW+qIdUq07RFnOWDUq5Sbz0f5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sYUy1-000000002Aa-1F2I;
	Mon, 29 Jul 2024 14:19:29 -0400
Date: Mon, 29 Jul 2024 14:19:28 -0400
From: Rik van Riel <riel@surriel.com>
To: clm@meta.com
Cc: Pekka Enberg <penberg@kernel.org>, Christoph Lameter <cl@linux.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, kernel-team@meta.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>, David
 Rientjes <rientjes@google.com>
Subject: [PATCH] mm,slub: do not call do_slab_free for kfence object
Message-ID: <20240729141928.4545a093@imladris.surriel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

In 782f8906f805 the freeing of kfence objects was moved from deep
inside do_free_slab to the wrapper functions outside. This is a nice
change, but unfortunately it missed one spot in __kmem_cache_free_bulk.

This results in a crash like this:

BUG skbuff_head_cache (Tainted: G S  B       E     ): Padding overwritten. 0xffff88907fea0f00-0xffff88907fea0fff @offset=3840

slab_err (mm/slub.c:1129)
free_to_partial_list (mm/slub.c:? mm/slub.c:4036)
slab_pad_check (mm/slub.c:864 mm/slub.c:1290)
check_slab (mm/slub.c:?)
free_to_partial_list (mm/slub.c:3171 mm/slub.c:4036)
kmem_cache_alloc_bulk (mm/slub.c:? mm/slub.c:4495 mm/slub.c:4586 mm/slub.c:4635)
napi_build_skb (net/core/skbuff.c:348 net/core/skbuff.c:527 net/core/skbuff.c:549)

All the other callers to do_free_slab appear to be ok.

Add a kfence_free check in __kmem_cache_free_bulk to avoid the crash.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 782f8906f805 ("mm/slub: free KFENCE objects in slab_free_hook()")
Cc: stable@kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 mm/slub.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 3520acaf9afa..c9d8a2497fd6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4690,6 +4690,9 @@ static void __kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 		if (!df.slab)
 			continue;
 
+		if (kfence_free(df.freelist))
+			continue;
+
 		do_slab_free(df.s, df.slab, df.freelist, df.tail, df.cnt,
 			     _RET_IP_);
 	} while (likely(size));
-- 
2.45.2


