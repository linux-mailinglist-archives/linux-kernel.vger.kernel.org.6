Return-Path: <linux-kernel+bounces-292568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAC60957160
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 436C8B26FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40681891A5;
	Mon, 19 Aug 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmBOXbUE"
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FF181B9A
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086800; cv=none; b=RULXmJx7EqSOmMrc39zHltixAl4AgKplqZJlXW6MK2K2dQzSC0oTqKNZqC2So4LoKb6iBaI7eQu33UMVOwQfHNy4hXVjYB9a9INoZLsSKzJ+FPeYXwmmfHkQ4ZbWXL+1zuvj42fhuWPRkdjGSU5fOyYGeJp5m/TlbvlUFj6vKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086800; c=relaxed/simple;
	bh=r48ooCDVbXnk0XbE6O8YOHRSjTk6VzALjklAU/epoTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nowOL5D6HfJ7Q7OoT9cTHYcEkeA1HwercmZzfxLdT5Fz4IbxvuA1oDFZyjcIe6lggm93THHxEcudHKflwyIUgzbjZcnwLMt3diw1QGsKnailzuD+FOpuLWy3VJxR9sMIi977cUMTC0PhzU1bZql48ONc+PGmhDNjsU0q0BHwXa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmBOXbUE; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724086794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L6fmJLHU2ICDJ8SRtSCreCySm5ljWtPm5ejMXhunTtc=;
	b=GmBOXbUEo+oAh1ZYDKbq4owtpJqNy3Sd74FsbnvHim+fJL5a4pvLVUZer2UCwiC7jebor4
	qfqWA75JMSl7ctV+KrmqEY3MoTXYx3KQNlMchcLFfLO5QqepWooMb4CpJcrkjshs++7Db3
	ypWenZMjIBdKJdv9TXKnUb9KwYVJMII=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: rcu@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] vmalloc: is_vmalloc_addr_inlined()
Date: Mon, 19 Aug 2024 12:59:30 -0400
Message-ID: <20240819165939.745801-5-kent.overstreet@linux.dev>
In-Reply-To: <20240819165939.745801-1-kent.overstreet@linux.dev>
References: <20240819165939.745801-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/mm.h | 7 +++++++
 mm/vmalloc.c       | 4 +---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..e23516d197d7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1193,6 +1193,13 @@ unsigned long vmalloc_to_pfn(const void *addr);
  * is no special casing required.
  */
 #ifdef CONFIG_MMU
+static inline bool is_vmalloc_addr_inlined(const void *x)
+{
+	unsigned long addr = (unsigned long)kasan_reset_tag(x);
+
+	return addr >= VMALLOC_START && addr < VMALLOC_END;
+}
+
 extern bool is_vmalloc_addr(const void *x);
 extern int is_vmalloc_or_module_addr(const void *x);
 #else
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6b783baf12a1..2bba32d54fb6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -78,9 +78,7 @@ static const bool vmap_allow_huge = false;
 
 bool is_vmalloc_addr(const void *x)
 {
-	unsigned long addr = (unsigned long)kasan_reset_tag(x);
-
-	return addr >= VMALLOC_START && addr < VMALLOC_END;
+	return is_vmalloc_addr_inlined(x);
 }
 EXPORT_SYMBOL(is_vmalloc_addr);
 
-- 
2.45.2


