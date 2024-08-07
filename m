Return-Path: <linux-kernel+bounces-278559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6836994B1CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FCF1C21997
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F89614A61A;
	Wed,  7 Aug 2024 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOtQZCh1"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33E149C6C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065197; cv=none; b=TPR+PefIGjSUVqPamdB26FC4zKKpaTWlwyxMUdSX+TTWXjEaMzHnNxOiulh+KiJ97Ok1jaHypX+PtAv+2G7gsbMBqWUMYYTS9ytmwO1wQgQmqw4VxEY3dLxkq4O57dcRxTRUGTLN8IB2c735ZbCeu/TWbHX+EYE+W56oV6CdQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065197; c=relaxed/simple;
	bh=VIi/luW+740g41qtqCw+3x4Oo+hIBneAV0ddLEMtIyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRB652+ie5xeG0zV34FF8LlKf3dDwbU6dbaKBzvpZMcJPYEzNmpBL/nfFLGF1d+utmlHaEdo7i71Z+Jy0+y/kGAx1yj54gzULKu8uifFoVQ2YjuJJD+ZMmXmIUEv/9sK34ngsgDuoMFcpLm2D5mV0XFy0f2QIpNSHJmBJt+yLYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOtQZCh1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-426526d30aaso1918455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723065194; x=1723669994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0V+Hy2pcZNl8i2NdiK8iQy154jgjW7kCAAavfYbuDD4=;
        b=KOtQZCh1mxwUJF9f50MZbTqkvohQ3FinZ4iLsoD2lA4N0pVcaG7Hw7+YeijceugdBZ
         ycOHNxB2hiKfdRFuutLlIft/xDA6I5h+MxRmmVCDZp5t8a1fX3WozwFnyfkLMUQAAORY
         /4qCCrwJifPh6xWdhDvmmp/hp+YTPKD4gtHsbdrk5aoZsocz4E3ZjH3cq3u0HSQV2PbJ
         3uGbLZVWU0HpjL/UvI7yPYqY/lCnwVPM22McHywbIYAYRywpfPMTSk85NZU+3/5W4Fss
         /gC+igZ7IUulPJCJRO29i+792Wwdk+zNf8eTn1SaaHu8MawT+m+WQAkPIFmT32YfmniE
         ps2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723065194; x=1723669994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0V+Hy2pcZNl8i2NdiK8iQy154jgjW7kCAAavfYbuDD4=;
        b=iScK3timBZnJ/U/usxs3sn6KoZYNT8H+8tX/I9I/TTS5uu+VXOIsE9+PLGls4G62xz
         opkZNT8MC5vDfBmbPIQvbQEWODJOjSkmTlKJ9UMctSEQrATHt2/Ypq3uXjyFCh4sIPL6
         ByG5N0kgDIglzKDluejczWyD7lZUFmewlql51fO8q5mmeO1xZwGJN+oiv+Ol29AOw4eD
         1FAhfNaExTBpLdkwRiYEsCFiNWphknBTPs7eLHan3FqmUx2M829mwdAo8X/tB12Gd+lj
         KR6R/TPPu3AksrSOjh7w8GukoqAgSGb1oDWs/7o4O9d/ZheL4cZ2hcb9RfD8h9aaVqhH
         sSag==
X-Forwarded-Encrypted: i=1; AJvYcCXkeTWdoLXE/OB52g/rqbQf7kc3wIjzkHTHbYZcIsvZzPuoBDFndVjzCQBDaA/AUCHRwR5TAXFZlSieYKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5wOvE8NkZ9Uwa1SjI+bo/pidL+/8HU7RWvCwOEYh/f7ryAguM
	2fxxnWJh6M92y59cq7udAr9A2jjaenu3+pWLRDrcoc+lWkKuG2YV
X-Google-Smtp-Source: AGHT+IGZXVkwP2NuFsG+OgPnqn7B/IU0ZazKLTjqwmDHjbu0OXQttrn5KJCkW1Fvqzp67cidEsfQug==
X-Received: by 2002:a05:600c:4f0d:b0:428:52a:3580 with SMTP id 5b1f17b1804b1-4290aee04b7mr104415e9.3.1723065193882;
        Wed, 07 Aug 2024 14:13:13 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm45869525e9.23.2024.08.07.14.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 14:13:13 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oliver.sang@intel.com,
	torvalds@linux-foundation.org,
	jeffxu@google.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2 1/6] mm: Move can_modify_vma to mm/internal.h
Date: Wed,  7 Aug 2024 22:13:04 +0100
Message-ID: <20240807211309.2729719-2-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807211309.2729719-1-pedro.falcato@gmail.com>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move can_modify_vma to internal.h so it can be inlined properly (with
the intent to remove can_modify_mm callsites).

Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
 mm/internal.h | 24 ++++++++++++++++++++++++
 mm/mseal.c    | 17 -----------------
 2 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac..90f50f3c4cf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1353,6 +1353,24 @@ static inline int can_do_mseal(unsigned long flags)
 	return 0;
 }
 
+static inline bool vma_is_sealed(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & VM_SEALED);
+}
+
+/*
+ * check if a vma is sealed for modification.
+ * return true, if modification is allowed.
+ */
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	if (unlikely(vma_is_sealed(vma)))
+		return false;
+
+	return true;
+}
+
+
 bool can_modify_mm(struct mm_struct *mm, unsigned long start,
 		unsigned long end);
 bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
@@ -1374,6 +1392,12 @@ static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
 {
 	return true;
 }
+
+static inline bool can_modify_vma(struct vm_area_struct *vma)
+{
+	return true;
+}
+
 #endif
 
 #ifdef CONFIG_SHRINKER_DEBUG
diff --git a/mm/mseal.c b/mm/mseal.c
index bf783bba8ed..4591ae8d29c 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -16,28 +16,11 @@
 #include <linux/sched.h>
 #include "internal.h"
 
-static inline bool vma_is_sealed(struct vm_area_struct *vma)
-{
-	return (vma->vm_flags & VM_SEALED);
-}
-
 static inline void set_vma_sealed(struct vm_area_struct *vma)
 {
 	vm_flags_set(vma, VM_SEALED);
 }
 
-/*
- * check if a vma is sealed for modification.
- * return true, if modification is allowed.
- */
-static bool can_modify_vma(struct vm_area_struct *vma)
-{
-	if (unlikely(vma_is_sealed(vma)))
-		return false;
-
-	return true;
-}
-
 static bool is_madv_discard(int behavior)
 {
 	return	behavior &
-- 
2.46.0


