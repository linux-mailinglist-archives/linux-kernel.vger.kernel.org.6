Return-Path: <linux-kernel+bounces-287222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C1B9524F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 23:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD091F23B2D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70AC1C825B;
	Wed, 14 Aug 2024 21:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8QD38p3"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3727346D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723672247; cv=none; b=tPlXuY2B3dEYFtR5WaxhrA7j/tiGpK0BaSSGNR2i6cUmoQjRcHf0GoTXjVp8gAzw+cxEn9r1ywgLmMh/s6Zd8U2X33KugB9szBJSRlKSTbmntZghCR15qPsUkWCP0qfT+MBvP6FriKXqPPK7K5ZM300D5YNsn/8QWXOKx/MQpY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723672247; c=relaxed/simple;
	bh=AL+CWCALiP3MXUkJVHBts4/InTBLTS6tYlJCFYmKGr0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=N9hjSnE8i3wpLjWWKCNWRsawVqrVS/sE5NjSM2xAGrnTa+mJHfFoDYQk8En++3zJVg2V7Wru3W0xZ9BED5A0S3N5FolG3P69esYt/FxE1XYy+/bA41fHdKBMiPMhmTg3FiOeoukxpLGnl7mNrlkQFOan1/iKooC01Alw663/2NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8QD38p3; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-68f95e37bbfso8673577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723672244; x=1724277044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k5OX94grY8hyL7diumJH+t2unjjn6ITYGDaDXBZM2Bc=;
        b=y8QD38p3R3zg35s30tottgFfrse7EZNA9d0Oqst/5VEit7/RVte6WBcqPWKbAsd9oW
         1Nqj8tK+GswYTbTW9FDtif91TI+qf0jcAZ4nTm7QtNyf6Le7+BvKZk315mKtuR13XZQj
         UVVJ7wHlOYxisgJCKTbBxbxd4wA0DtASEKjqwLeogJa4hAtOfARdq6TgcjECx6XIgfrA
         f+oed9tIYsCOkfhU9DjT8N2YwjGjINfMHhUYqL94Tr0dhQDOP91W9s2SWgNr03IakWKz
         A1Cw7WVjiny3Nek7b7y4VOTbcoy7kT8bmMOul9bhPlFjABpuWuOgEA1ezzn4Ml85MhkM
         3YaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723672244; x=1724277044;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k5OX94grY8hyL7diumJH+t2unjjn6ITYGDaDXBZM2Bc=;
        b=iDMwq2eq9uiPJ6ZyjKPqIKr1Wj7OgMS6Kkl3rkx8vu9Gyalv0i8kqC1JIoWG87vzkJ
         b0VYShl40THHYFvZoKv8VMaKszPL4ZS0T0woq74K7Icv9zQRPambJD2xQEDgn/DTGTt7
         ISrj0lCUaMkpPU/pIh2KyxSCkcNvVGmzpGjIhAInS+WMh2f29RVODB1fgXrpftoUH2Nq
         6q65Rm3J7QDsIGqC3dG8pj4BQ7Ejuowc/pFsYjfJ4j0tJiR/3rDvFt/YGt10j3pSREk/
         hQkQHHtNG8r5Vpqi4vBabfgsBjy6hp+Z/24WxMz3+Kysj6Do+cAEUaDmlMzOOo4kQFFE
         1K/g==
X-Gm-Message-State: AOJu0Yy76uzCmNCEGGxxR5zj9eNCioh1mbGUGOZRYTbyUJzs9vOkRPkm
	u7RSu/m/eTe18VYDxdbPljsRvmgRuRZlFWkwe4/7lbJbgNRJuaUG32PQGSxyJuyvofkfGMDYjv3
	lDfHpPCOJQeuhjtsHAymmKf++qj4odw==
X-Google-Smtp-Source: AGHT+IFPiDdFGR1aWZK85BEwSg325PLhNL0DGuA2zOO5ph8zaDBTexAvMLjut8J5+Akgj8EA9C7pKmbXjhCEWEp3KNhg
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:b717:ce18:c4e5:73ba])
 (user=axelrasmussen job=sendgmr) by 2002:a0d:c9c3:0:b0:673:b39a:92ce with
 SMTP id 00721157ae682-6ac9621a45amr1249407b3.3.1723672244595; Wed, 14 Aug
 2024 14:50:44 -0700 (PDT)
Date: Wed, 14 Aug 2024 14:50:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240814215037.1870645-1-axelrasmussen@google.com>
Subject: [PATCH v2] mm, slub: print CPU id (and its node) on slab OOM
From: Axel Rasmussen <axelrasmussen@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"

Depending on how remote_node_defrag_ratio is configured, allocations can
end up in this path as a result of the local node being OOM, despite the
allocation overall being unconstrained (node == -1).

When we print a warning, printing the current CPU makes that situation
more clear (i.e., you can immediately see which node's OOM status
matters for the allocation at hand).

Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..3088260bf75d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3416,14 +3416,15 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 {
 	static DEFINE_RATELIMIT_STATE(slub_oom_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
+	int cpu = raw_smp_processor_id();
 	int node;
 	struct kmem_cache_node *n;
 
 	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
 		return;
 
-	pr_warn("SLUB: Unable to allocate memory on node %d, gfp=%#x(%pGg)\n",
-		nid, gfpflags, &gfpflags);
+	pr_warn("SLUB: Unable to allocate memory on CPU %u (of node %d) on node %d, gfp=%#x(%pGg)\n",
+		cpu, cpu_to_node(cpu), nid, gfpflags, &gfpflags);
 	pr_warn("  cache: %s, object size: %u, buffer size: %u, default order: %u, min order: %u\n",
 		s->name, s->object_size, s->size, oo_order(s->oo),
 		oo_order(s->min));
-- 
2.46.0.184.g6999bdac58-goog


