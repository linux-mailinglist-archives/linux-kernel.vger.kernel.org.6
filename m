Return-Path: <linux-kernel+bounces-192562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78538D1F1F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE801F2373E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51F5170855;
	Tue, 28 May 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1gYFjtG"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB8E170841
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716907447; cv=none; b=gujVqo7w781GJYATKSLp2vsA1aqZFvx9/TLEiXk0BmCL/9xMcJWSsuEJxqiCBPwg/ZIfz0tm5liXcIghCjwhmbm65E9UejSrPk7v2TLwMPluy1QLnX69899VahE0nGLZu0u/94dz05hFKt+6JntossAAiiA0Nr7/9EwO+iMam9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716907447; c=relaxed/simple;
	bh=XEgoDy6TdaH9VTRy5NifDWwtS+K5TBajp8VDOwsV714=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITF3VPav6lKq5xvg61sYL57cpz8juPXWNWK5NxDnZEWeu1A84qFNzzfIdcx7GMq4E6VThsHloAABimlDLn+Be2MhRRLx4MznBd2RtGg8w3J0stry3jnj2KNMV/DaH6F194R289R2QTBqMqRj2EwqXCkrYiEJSTC4QmRk513fcCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I1gYFjtG; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so12972341fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716907444; x=1717512244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNJyQBEZIlvY5qkox0e9QbOH8UJx4eH8/3j/qt71lDE=;
        b=I1gYFjtGpXE8MfenarjVL/PKutL2qWRMdjKS2DLv+tPVFRreYiLmkuu0ql/0QkYULk
         AnXey+vbONlvFW8J+0V0xaf9ToLOflgIdOIyP/MNCu82RmJoZFSWQF25lRMhU/Sa6U+I
         UeIOZea6ASX9AVhiWJ/BNisflY/9XLMHwYAqoHyoDdHAV9LPyOl6mg93a6XXTgXU8LOA
         NJasiNgHqFYQFr0F93LudOJSwBz9+hYEMu4krG9EbzfSqGVKFN8Bliv3OBDsVAlGIi31
         4uyPvCDY/VV/hEvZ+xIvT6TWOHe6ScLEaOjCa3RKrb/PI/lJxrl0Yp3EiYfeXiZNxL7B
         xfwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716907444; x=1717512244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNJyQBEZIlvY5qkox0e9QbOH8UJx4eH8/3j/qt71lDE=;
        b=GAHnh7lYPk9oJv3Up8lu7WU0fyJWozbdoFlxz42Uv3ESvG+63KLJNa5pF9ORWXAxhr
         NybukHcgxB3x85RAkChfhRvFRS2guI2kVuRLIdRcpCaddjWLjesHNNiHws+lWcndydr+
         y8HKh6qGtrTbdCjTVP8HJAsqYxiNDXPNsstsYK9LnNMKS8UJKgkKDxlIHAGIzZDpz4YA
         il6FtdLwZ02YWYuPifLs8AP01+yJqkalw+s7pRHsZxhcDqxJtaaSpeLvIXp0QmpI9drx
         6OHj1QlA9ftUcKSXY1o0QgoxgHLP4MY19HH8QPhsayN702BLhRmg/UVBVvhpOXi1SLZT
         epQw==
X-Forwarded-Encrypted: i=1; AJvYcCVBQynclmtH3IAqR+vedbo5oX/qoBx2YKZBV7dBWM8hJSBGJTexZSydvMN+xq2U2X8mOAP0l+sPQqrrXCR5wULLTtvoMBXSVLH4VWiF
X-Gm-Message-State: AOJu0Yy4Jsrtr33Gblgjyx1/qQ47MW9gNZ5sTpBJinSyGj1AA2tbabRx
	yAhONzgqlX5V//O73hqODLhvtW3l9eAlIPVhWb1tekxYwGmxBjJd
X-Google-Smtp-Source: AGHT+IH9fcX9h8dAddsirOf8W9e2zRkjaMX3KHnPUQQFi9/AO0LjE/tHFGuIEkZAFmGJ+xwruFYb9w==
X-Received: by 2002:a2e:9e04:0:b0:2d8:5fe6:820d with SMTP id 38308e7fff4ca-2e95b0411c8mr97696731fa.11.1716907441945;
        Tue, 28 May 2024 07:44:01 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c817ad3sm629797966b.16.2024.05.28.07.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:44:01 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>
Subject: [PATCH v2 2/2] mm/vmalloc: Use __this_cpu_try_cmpxchg() in preload_this_cpu_lock()
Date: Tue, 28 May 2024 16:43:14 +0200
Message-ID: <20240528144345.5980-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240528144345.5980-1-ubizjak@gmail.com>
References: <20240528144345.5980-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __this_cpu_try_cmpxchg() instead of
__this_cpu_cmpxchg (*ptr, old, new) == old in
preload_this_cpu_lock().  x86 CMPXCHG instruction returns
success in ZF flag, so this change saves a compare after cmpxchg.

The generated code improves from:

    4bb6:	48 85 f6             	test   %rsi,%rsi
    4bb9:	0f 84 10 fa ff ff    	je     45cf <...>
    4bbf:	4c 89 e8             	mov    %r13,%rax
    4bc2:	65 48 0f b1 35 00 00 	cmpxchg %rsi,%gs:0x0(%rip)
    4bc9:	00 00
    4bcb:	48 85 c0             	test   %rax,%rax
    4bce:	0f 84 fb f9 ff ff    	je     45cf <...>

to:

    4bb6:	48 85 f6             	test   %rsi,%rsi
    4bb9:	0f 84 10 fa ff ff    	je     45cf <...>
    4bbf:	4c 89 e8             	mov    %r13,%rax
    4bc2:	65 48 0f b1 35 00 00 	cmpxchg %rsi,%gs:0x0(%rip)
    4bc9:	00 00
    4bcb:	0f 84 fe f9 ff ff    	je     45cf <...>

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
---
v2: Show generated code improvement in the commit message.
---
 mm/vmalloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d3aa2dc88a8..4f34d935d648 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1816,7 +1816,7 @@ static void free_vmap_area(struct vmap_area *va)
 static inline void
 preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 {
-	struct vmap_area *va = NULL;
+	struct vmap_area *va = NULL, *tmp;
 
 	/*
 	 * Preload this CPU with one extra vmap_area object. It is used
@@ -1832,7 +1832,8 @@ preload_this_cpu_lock(spinlock_t *lock, gfp_t gfp_mask, int node)
 
 	spin_lock(lock);
 
-	if (va && __this_cpu_cmpxchg(ne_fit_preload_node, NULL, va))
+	tmp = NULL;
+	if (va && !__this_cpu_try_cmpxchg(ne_fit_preload_node, &tmp, va))
 		kmem_cache_free(vmap_area_cachep, va);
 }
 
-- 
2.42.0


