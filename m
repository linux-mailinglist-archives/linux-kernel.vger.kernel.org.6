Return-Path: <linux-kernel+bounces-191857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E9A8D152F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 09:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA723B23011
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CEC7346D;
	Tue, 28 May 2024 07:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WeqnOlZv"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D554A71750
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880679; cv=none; b=braezDNJI2EHQhWEUyyu/0Va5tgCdaNVbAK27Tui3qP+UZaOcuj07V86AgpAIP6whNsQYyIJuIJOK3GaOu5hyC016NkMnB4jv14qpn4NuI5JZSzy5NH4Xqk3J3UDVnpBU9u857GVUW62YT0olKs2ZC6fr9Q695nSji8QgYKzDWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880679; c=relaxed/simple;
	bh=rHIF8qKq64R0lpw1VUx1Im5wOBmo7sC3YG3g7WqN2W4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdRThPGb4q6mMkRh6kojNv+jGpp2cgavC63VM7mRPNJHl7TG/cTtbKNFcWHqNakokaZaj47pZblhUYk4opJkXIrHZ3UuyJuvHVWallzzaVWz6sKD0/W/sk0sM5j/lwnCn8MphkXT6A6tXtPPhC3PIpf7BhnhQIKwUAf4uj5shVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WeqnOlZv; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: vbabka@suse.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716880675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMaSIU7JsGNs76Hq+XgMuzCoHf1FVSkJsmdl8eAubO4=;
	b=WeqnOlZv3cipOkQLZEMYBJArodWtyhIDRCTMWRq0PRFeDjk3ZR1BdAluGReAhpv4Ay2tWP
	ogZI+JWC1KW9+PFe5Un8C2lv+0ZmAJDJIXH4E808ZgEWP/yNaAFb5Wy2toIcXbf6D72iZj
	ccazgpEZSopK0HkDfZbGPibChtZ7Vng=
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
Date: Tue, 28 May 2024 15:16:46 +0800
Subject: [PATCH 1/3] slab: check the return value of
 check_bytes_and_report()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240528-b4-slab-debug-v1-1-8694ef4802df@linux.dev>
References: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
In-Reply-To: <20240528-b4-slab-debug-v1-0-8694ef4802df@linux.dev>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 zhouchengming@bytedance.com, Chengming Zhou <chengming.zhou@linux.dev>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716880668; l=849;
 i=chengming.zhou@linux.dev; s=20240508; h=from:subject:message-id;
 bh=rHIF8qKq64R0lpw1VUx1Im5wOBmo7sC3YG3g7WqN2W4=;
 b=KJKqsIabP6pZlL1NYn7OTAWboJRqdoyJ8ZW0qMpjhV9mc2wAbh48bk+//KvkAukAJAN2//aQ+
 /iKLywB2qyNCAETzun7+8brQxfX5pTJ4TN3Sfo0EQwOhRl5cMfyQGAf
X-Developer-Key: i=chengming.zhou@linux.dev; a=ed25519;
 pk=kx40VUetZeR6MuiqrM7kPCcGakk1md0Az5qHwb6gBdU=
X-Migadu-Flow: FLOW_OUT

All check_bytes_and_report() callers have checked its return value except
for this one. We should also check its return value here obviously, so
fix it.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0809760cf789..de57512734ac 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1324,9 +1324,10 @@ static int check_object(struct kmem_cache *s, struct slab *slab,
 		}
 	} else {
 		if ((s->flags & SLAB_POISON) && s->object_size < s->inuse) {
-			check_bytes_and_report(s, slab, p, "Alignment padding",
+			if (!check_bytes_and_report(s, slab, p, "Alignment padding",
 				endobject, POISON_INUSE,
-				s->inuse - s->object_size);
+				s->inuse - s->object_size))
+				return 0;
 		}
 	}
 

-- 
2.45.1


