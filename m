Return-Path: <linux-kernel+bounces-314436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541FF96B336
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C781F252AF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51689148304;
	Wed,  4 Sep 2024 07:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oJbTP+xk"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F38D15E88
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435975; cv=none; b=oxFzMaumIqUEpp/NL5c4i9Rf+Bpskx36rpTHf2IGbYfin9nPtf5NJFS+T5BWn3ZYZ79RIIOFtoCOtr1lhbcdzFFz8XLpClbJWruWyVM9KFP5YZRp/48UGIfLDfd41xqWUBOZ5wHsKC8qSoIKj8cbfbGgTP3ZwLNzLexIRGGDkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435975; c=relaxed/simple;
	bh=saKLRVtdGYq1KKGeZtElmBGRZYGRwvqXEt+5HMBUNxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZPGnC33Rn7zLstawIyrbimh9GKfk43LQmlWVNXq3HIW0lFYE4oBdkwXIML5eG5xRvOGOuyGYVE5tmEIayCJVKGbJtzb0WWLgcNQk0SkqgTVIS83Apt+et7mcUqdy2l8XTW78Xjn/e0+2wttjQEc8AtxbKiFMf65tYSz+BA0suI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oJbTP+xk; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jk8fe
	xfZEn7Heh+nv5LLKvbujnEfLBEC6g0IUs8GINg=; b=oJbTP+xkQjBKvRkmR38tp
	O7d6QnpanQc0Pyao7S+TYSExyx0fLz4bj1J7rhHnDTXww/mQ2m8IQYPkA5xtAwqq
	DHbOpRUMWv+u7XugnH4i1TXUeLzBwHdodpgV1VpZG1nNhfZ01257Xh1dvgAZhR0J
	iwxm1//hwvktyJjR+RpwRc=
Received: from localhost (unknown [101.132.132.191])
	by gzga-smtp-mta-g3-5 (Coremail) with SMTP id _____wCn7y32DthmZiNYLA--.29731S2;
	Wed, 04 Sep 2024 15:40:39 +0800 (CST)
From: Xavier <xavier_qy@163.com>
To: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Xavier <xavier_qy@163.com>
Subject: [PATCH v1] mm/slab: Optimize the code logic in find_mergeable()
Date: Wed,  4 Sep 2024 15:40:37 +0800
Message-Id: <20240904074037.710692-1-xavier_qy@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn7y32DthmZiNYLA--.29731S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF1UWryxWw4rAr4UCw4Uurg_yoWftrc_Zr
	4vvw13CFn7Xr1akFn2vrW5WFW5ua4vvr17W342qF43trW2yr4UZ3ykZFykWFZ5W3yxZrZx
	Z3yDAry5Wr17GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRNlksDUUUUU==
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZR05EGXAnsRC8wAEsb

We can first assess the flags, if it's unmergeable, there's no need
to calculate the size and align.

Signed-off-by: Xavier <xavier_qy@163.com>
---
 mm/slab_common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8..aaf5989f7ffe 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -169,14 +169,15 @@ struct kmem_cache *find_mergeable(unsigned int size, unsigned int align,
 	if (ctor)
 		return NULL;
 
-	size = ALIGN(size, sizeof(void *));
-	align = calculate_alignment(flags, align, size);
-	size = ALIGN(size, align);
 	flags = kmem_cache_flags(flags, name);
 
 	if (flags & SLAB_NEVER_MERGE)
 		return NULL;
 
+	size = ALIGN(size, sizeof(void *));
+	align = calculate_alignment(flags, align, size);
+	size = ALIGN(size, align);
+
 	list_for_each_entry_reverse(s, &slab_caches, list) {
 		if (slab_unmergeable(s))
 			continue;
-- 
2.45.2


