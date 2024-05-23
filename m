Return-Path: <linux-kernel+bounces-187136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CF68CCDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD522830C7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1659A13CF85;
	Thu, 23 May 2024 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx+JSwDM"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA713BAC6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451305; cv=none; b=MW8cn76wfP72U26KLLQ3hF3UKpvd1hXGMp4tkvgKGQ1y+bTHe5AZ7nIZRjUIOlsJkku0EmRe0i6b2jKxGw167jdSFw9PsoimiXy0Gu7+VRk3axZyY6nhzyHTuqGaoDmxl+eN3quf3NYjluuvyL8xfr+oe/YAWkiMW3suwKZ+cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451305; c=relaxed/simple;
	bh=lr4bUWphsJyZbNUKRRfYxfYiaz4mun/8WN1QLLNsFNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggJTIuVPEX71h8UVorjDV0u7ec+Bp73Lc9rr5D73pbCxpeq7Q03t6lOq1uehSRPM3JvdBuX9TOTLzYk1vhNGu+16MzYaSXkQCXOkUN3Txx0HUG/VygGK7LqgIitbe8vfhTzint8FkZJ6e6Q7evR5zfZR8YYDlWlhJyMq6UkqZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx+JSwDM; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4201986d60aso14575295e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716451302; x=1717056102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJJ6AuEpcS/RPE/CUPbVaVlAztUWI2Z2Lb/LJ9UyRY0=;
        b=Xx+JSwDMN+vSuKKj7f75DDuMLrIvYrEIIAqKizjoYxUwixjJYP+3F9mWli4VYf1nRB
         gyrnB8NDCAWRoF7DlQLlK/jHLs5JgKx/oyohM/q4iffqDV4f2ynnEyXAjpz41tXdUsZo
         SrCCN1DEIpfp5WahHGJrD5TvAPuSYZ/zXDLQPdzQT8/DntSd+XOABDZPZJaSUbA+zALO
         QPEmRv0kgJbUSvLIxnqgpoVuSBtXKF9kkBxcXrMDOBRojqwiTKd5uoyrDApPAVo7Kx3J
         QOxyGYPVp67w9JBzz+u2oOBPWfR73a6baYe1D5SYFvUId55vbRIJbFo7MaHX6eyQiW5y
         PQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451302; x=1717056102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJJ6AuEpcS/RPE/CUPbVaVlAztUWI2Z2Lb/LJ9UyRY0=;
        b=M/CFXtXqj9FwmTDWwgmg/gq5DyV8C45+OakbX38m6CdLJUUqEgULj99y42QEFLD6A1
         IX8hQBLpL4Zwx7tHcYDefdI2FIxTTWMFrMSSlY+lW7HDCDs9L5F68a/lbg8RxLtn0hak
         do3kjBphdipIIy//oI1qnxVvyICXYQi7r7JLAAH7MReKMHz8nx8zlw/tabFA+f/xmy4a
         rItkawh/H/bCQlQIovbfG/64jSO+Spuk7vaHxrMBlKTnmulLZITD8HTP6PdENFmVXoeX
         t9ZkP2yO/hJ73o4ejr96CGXnQdpfwZA/3QusgN4pViSfGe7ROzXyizCH4XK5ZyceIc6o
         WtgA==
X-Forwarded-Encrypted: i=1; AJvYcCVVa+CCSjFS8Q9meBM8Z28Kbb1CddySQ4pmo1QPsryPtjbdxrluBhmQVABtuq3A9JTWmUrwGjX7kSbL03ezSLPM6ZTRXRTHY1mu4xPA
X-Gm-Message-State: AOJu0YyvSDb7sqbzvEYFueYeWjqnXDAIMjzaW9giYHVpG3sM5cDF67pA
	gs5bNuXeH6y/RTGJhbfHvLq4ECAxK7m2g3J6Y0EE8dskjr2IEEmT
X-Google-Smtp-Source: AGHT+IGxf8z+KBReL8dDRkf+3eZRAAFo/WXe1J5r3DlWJfOpykLJKaaRPtQPIQdbgfq4TfYmqGXuIg==
X-Received: by 2002:a05:600c:4fc7:b0:41b:fbec:a53a with SMTP id 5b1f17b1804b1-420fd30e19dmr32547545e9.16.1716451301860;
        Thu, 23 May 2024 01:01:41 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1548bsm17489045e9.11.2024.05.23.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:01:41 -0700 (PDT)
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
Subject: [PATCH 2/2] mm/vmalloc: Use __this_cpu_try_cmpxchg() in preload_this_cpu_lock()
Date: Thu, 23 May 2024 10:00:32 +0200
Message-ID: <20240523080136.9863-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523080136.9863-1-ubizjak@gmail.com>
References: <20240523080136.9863-1-ubizjak@gmail.com>
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
 mm/vmalloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6641be0ca80b..0120faee5471 100644
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
2.45.1


