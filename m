Return-Path: <linux-kernel+bounces-277092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB751949C49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 01:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C65C284B1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F125176228;
	Tue,  6 Aug 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBduNJUK"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE7158DC0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 23:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986820; cv=none; b=iSbPSNGNlnIfLDkIt13p095aKlnkAymCcy+Eh2bZzM9HAAnbBdL942lo2rwTnYst4ZDopLmqvgjY5H7KD8FENOx5Yu8qhCpFouflnU3xtmPo5qYqyYUuWyBm7TFDSNNgk8Isuh3xjoCp97nLmHjMsIaNrhyvliSnaQWr7pZoSe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986820; c=relaxed/simple;
	bh=UWh5YGePP5Ny2O9u1IrWk3OwzQBnlSDgER6TdIIY0TU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qoTS7A/b3Fv1GiZEd9cHF1krc2z73Z+8KPRMyFN5GAOotoQwZVte5/Hxt5w4DenY70Wkamuy9Pcnqt3KR06O257lBkR79qH1A0nsdOX9DG0ebPsyVesODdWOguuTo379nsQ2j7OKS4Vr3wl/yDOps5N10giDGB1AUTVKT4WKx3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBduNJUK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--axelrasmussen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6643016423fso30283447b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 16:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722986818; x=1723591618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b0aPvkt5h9A2E+umL0pkphP872PICLMo5TUgyHEuDTA=;
        b=NBduNJUKpWbBmTGUtmxL43ddrA2SQqtMUDhSTTIzfp38/Jgufl2r0rGhnTcczQJtMv
         ef95SW7QtgrxaWy/z7V51sXWVytSABZn4PrSLLS62EfpZXpkzUnT59WkdU5csjCbpgOO
         5isFFifwwpDMxHlTeeb0x/u4tIH0N0krf5La6pUSvDAN6Ag1QmTExow82J6BfsyzPXvd
         O/o9dSdGtkQZquTXMToE6pDlCyE7TJRPf3580WkmZ65B8z2lbc0Y+FcJjFgyDtcJ8ZZv
         BrhKl6bp6VPYAZPbQOSj19azRBCAiMzwgtdLsSaSjxsTDsQfvCOlbAv5CWdxtrqdiSQx
         Dq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722986818; x=1723591618;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0aPvkt5h9A2E+umL0pkphP872PICLMo5TUgyHEuDTA=;
        b=rIkWxL5AbV1MliovT8FaZ/ZcsRi86dOCMUhUBB/vFOn0KPE9ijuNXZcCxt06PYiLO2
         B8N0XHJa/oyuKQ1pO6JlBwKJgKHnf8FOPnUpEtvWW6ryDrUuegMHnN0XmRB9WGIT9mUY
         ZJG1okfi8VkFDyAppy0FBmYwt7WEZXIaCHllz9S4y/UhYM3vXYH8FFBvNbEDPZzxb1hx
         u3DKi0TWCeEfkZJHKaOz8AJz927xoqkE/s7BpDX5kFwsd4CH+9HC4cxTQAOxpOH0AGX9
         CBfZLoiqsmkden1JzXgVtwpqncZTrVL+v5h2f/kpDd6pOmzGKcE+YRivw2BeyrC84Cdf
         6rVA==
X-Gm-Message-State: AOJu0Yx0Q2OpeMhP6UKHez66rHfbnl741wMdwo7MCWxf7QAa8mXWVwPD
	h3og/xroGoKAUIEt+6amXdQ2txcy/TU9h8HgMMACItYeSrzwYgkJM+uk0lJUU0gTHO+ewtmTMya
	Xf54nBcxVwZwouqnFeEujzHNwKB1m7g==
X-Google-Smtp-Source: AGHT+IGO/DKXmMym7DGlZY511GOLd3Iy1MHKCPdnNLPCdGXOEBfIkai43Xinu+xxlo+4tXTL7Lrm5w3X1+SwJOvIZ8h2
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:3bdc:f263:106d:f85e])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:2605:b0:e05:a1b5:adc0 with
 SMTP id 3f1490d57ef6-e0bde423771mr446254276.10.1722986818062; Tue, 06 Aug
 2024 16:26:58 -0700 (PDT)
Date: Tue,  6 Aug 2024 16:26:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806232649.3258741-1-axelrasmussen@google.com>
Subject: [PATCH] mm, slub: print CPU id on slab OOM
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

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index c9d8a2497fd6..7148047998de 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3422,7 +3422,8 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 	if ((gfpflags & __GFP_NOWARN) || !__ratelimit(&slub_oom_rs))
 		return;
 
-	pr_warn("SLUB: Unable to allocate memory on node %d, gfp=%#x(%pGg)\n",
+	pr_warn("SLUB: Unable to allocate memory for CPU %u on node %d, gfp=%#x(%pGg)\n",
+		preemptible() ? raw_smp_processor_id() : smp_processor_id(),
 		nid, gfpflags, &gfpflags);
 	pr_warn("  cache: %s, object size: %u, buffer size: %u, default order: %u, min order: %u\n",
 		s->name, s->object_size, s->size, oo_order(s->oo),
-- 
2.46.0.rc2.264.g509ed76dc8-goog


