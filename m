Return-Path: <linux-kernel+bounces-277604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4EA94A393
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3C41F22C5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47E1C9EC6;
	Wed,  7 Aug 2024 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmaX4Fyg"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EBD1C9DDE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021674; cv=none; b=ag1+jKs+yZAKsN3088jPkxbMquI/O7olXDppy/uBxgGbN8xUnJJxfNIuvkASWGJevkACxao3a49bhoa3nB09P4UMjDzOX/nzB2WiLDWOPH9P9HbUwBI3VegBGtZIth66G3Kfq2xhPSU9A8yFYse6HQ3qgiZ3BSqa90AP+fcwLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021674; c=relaxed/simple;
	bh=qwNB2tjS13f2zdPuw8e/z1JrEZSg+Ef+xOcyvFNduPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTWy43Yuzci6xZtgFj1URShKNbrjIXSbesfTlUeFNK/CXAcYnA0mMiPr4gwjGSti2wA1Y3aAT/Op2FSkGuv7cLGgxV6DKpJEDrKle1RzBP1LQuvB06/TrhiLpu3L6h9av6cgDx5jaqBhfWb3TAaARSjjvsvjOJSjtsGtWQFrAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmaX4Fyg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so2459354e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723021671; x=1723626471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C9aekX4Ai49itZEMXwDFZ07/9+NmTVOLMBb1LFbpcmU=;
        b=DmaX4Fyg1BJtHdfuk9BAmP4npNgPWDVOgRMBysXgeR6pVQ+OEHfafG/lqFKt20IFFh
         rs5td+3bbJFvCg0DsXEBOvMtgIQ1MhiMhNi3wP0qFCOlsOLNz+1DG1T9+eAMD7MsXTD3
         P10WhP2MzvjjbLGsSPYKbLhUfFSyMzPymRpj3SCe4LEGxasRF/zwiSqfLRWEtZyzGor8
         +J8r+UHExNZPU8J68twYZLqnBqP0q6UN5hXOsk0RwuF7BTHASAPMX4v9Dq6nOLZkor7E
         u/d0xssF3UTOpuMYhm+NAZHVUKQiP+v3r2PqaTVQloySsStKy3piCP/jczpjltfJvZmW
         lKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723021671; x=1723626471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9aekX4Ai49itZEMXwDFZ07/9+NmTVOLMBb1LFbpcmU=;
        b=FQaW/6vfricph/+ousCiWOV69bERZ+2inTdpqwbiZhHjiCT/KaM+bExK1ZNQn9GSDp
         esX9uXz9Upgfo4MyJsZZ1wFaN4zurAHMrcAO2kiuqKisbtEe8daoYC1TVjtMEEWGs4IZ
         wDNDulmQt/4Zx6kR7E2OTa1oAfJTruShKUC+PRFvQ8vmrfBCKPMKMf/6MWCpH1C02JoG
         E+fuB98+CnONXo1IU0xNCqKlrzJ10WF9FazIKPT0/XhY4tvsOhnKSxxQ4GD2/uB3/Bfv
         pilwz3UprcGdgQuOxiBtkVwbLz2FGQN2XchmuMYQhBkdbKoSUB8njnyu3PJbzwcBJF8k
         T1hg==
X-Forwarded-Encrypted: i=1; AJvYcCX8GaOJBnlm1Rrso9y+sVCQEUHnLu77DRPNMRidmryRlaKS57/g2iI6sNKwKAYxqd8zGeYuopq8BBeypeewYWgdCn/6uUXW6s3A/hvC
X-Gm-Message-State: AOJu0YwbAdE/86Y/woCRZpDVlgkyiu6KwI52FlBDsTei7P+iADy0vh4L
	CqudccAay0YfuJdiYkfGxZherwEdv6lE3/c6njvMVjoeIMitE6Vt
X-Google-Smtp-Source: AGHT+IG9tMVI6f5eJFxMYkpEPA7ctok0k184c63EXvKfi0/ajz/LpIWYpZT0XkILF/xv7TPfyZB4IA==
X-Received: by 2002:a05:6512:239e:b0:530:ae22:a6f0 with SMTP id 2adb3069b0e04-530bb3929c7mr13275760e87.5.1723021670163;
        Wed, 07 Aug 2024 02:07:50 -0700 (PDT)
Received: from PC-PEDRO-ARCH.lan ([2001:818:e92f:6400:96b:aa92:afc0:2d3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd26fc0bsm15368722f8f.117.2024.08.07.02.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:07:49 -0700 (PDT)
From: Pedro Falcato <pedro.falcato@gmail.com>
To: Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Pedro Falcato <pedro.falcato@gmail.com>
Subject: [PATCH v2] slab: Warn on duplicate cache names when DEBUG_VM=y
Date: Wed,  7 Aug 2024 10:07:46 +0100
Message-ID: <20240807090746.2146479-1-pedro.falcato@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Duplicate slab cache names can create havoc for userspace tooling that
expects slab cache names to be unique. This is a reasonable expectation.

Sadly, too many duplicate name problems are out there in the wild, so
simply pr_warn instead of pr_err() + failing the sanity check.

Link: https://lore.kernel.org/linux-fsdevel/2d1d053da1cafb3e7940c4f25952da4f0af34e38.1722293276.git.osandov@fb.com/
Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
---
v2:
 - Replace the pr_err() + failure with a simple pr_warn

Contrary to Vlastimil's suggestion, we don't seem to require a refcount
== 0 check, because shutdown_cache already synchronously deletes the cache from the list (even reusing
the same list_head for TYPESAFE_BY_RCU).

 mm/slab_common.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b..1abe6a577d5 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -88,6 +88,19 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
 EXPORT_SYMBOL(kmem_cache_size);
 
 #ifdef CONFIG_DEBUG_VM
+
+static bool kmem_cache_is_duplicate_name(const char *name)
+{
+	struct kmem_cache *s;
+
+	list_for_each_entry(s, &slab_caches, list) {
+		if (!strcmp(s->name, name))
+			return true;
+	}
+
+	return false;
+}
+
 static int kmem_cache_sanity_check(const char *name, unsigned int size)
 {
 	if (!name || in_interrupt() || size > KMALLOC_MAX_SIZE) {
@@ -95,6 +108,11 @@ static int kmem_cache_sanity_check(const char *name, unsigned int size)
 		return -EINVAL;
 	}
 
+	if (kmem_cache_is_duplicate_name(name)) {
+		/* Duplicate names will confuse slabtop, et al */
+		pr_warn("%s: name %s already exists as a cache\n", __func__, name);
+	}
+
 	WARN_ON(strchr(name, ' '));	/* It confuses parsers */
 	return 0;
 }
-- 
2.46.0


