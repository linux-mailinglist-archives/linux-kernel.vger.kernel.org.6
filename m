Return-Path: <linux-kernel+bounces-291350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E101195611D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 779F61F21571
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695034E1B3;
	Mon, 19 Aug 2024 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrZoyfIn"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197D83FB9F;
	Mon, 19 Aug 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034721; cv=none; b=AkPrOQ0NvaWzqvZ6pANCg0npFKp4SmvFwV76NLwkIXtoZcdVkVpqQrEM1167sRMNd2TT9wp3cB0UdodsOO0gXPW8D4lAxUyZsnVY7FnX0+4DbFLMiiTyL5iUfZa2iK7ae++OycVdtJNLofYnX1wQ6cnlcWXtMMf50nYgLakHrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034721; c=relaxed/simple;
	bh=zy/HiLlGI/671eeY/clWWemO6VZMEviQAxIY7uwADFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EHWb9MJxZnkDKkZekmeQZ7IiIYGVQQraGQyKIawL+29BMKo4Ob41S3zm/hSwmld2cKKzVgP0Vm0/vy6mCByj+DnBAy9yuBKA8mY9wZn0/vFwD4rHFv0XhqMdpvHstymNgDlAspyqSRj/FZDW1B6FI25VhhTOxddqJWUEw9czfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrZoyfIn; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf84c3d043so11287136d6.3;
        Sun, 18 Aug 2024 19:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724034719; x=1724639519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eO6lPMqYWNsw0u0kOe6TeGUxnE5KvmwuKqe4o/pamZ4=;
        b=XrZoyfInGURukwRRnH8B8V2sMFAwTX1M+46opVIQ0UAxiJeOf0nfMlnKEXTfKTln/v
         xOBLIQhEI1hE8CO1JZM2eZVeibuf24+zuhcR2qMw0P1ymHv8PdzdwAh/BwRSrv6zMVoE
         +LtVsYeV8SO2y02/OrU93jbSx8r++ZiAo7BaTVbFQUBqCc1xzlMTeynPzkJ+KbDPGAaJ
         xF+F+g3FuKBGWSvqki/FYsYOBd+b3FPOudwvuHrXKbiE41sBoJND+xKmItrNpbFmwtGE
         cqM0a4fpD2jX+zIcwCdJ9nvQptwm42rraa3nWw1+YLN1wByt+4piphZkpEXR1I8pzLXm
         4QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034719; x=1724639519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eO6lPMqYWNsw0u0kOe6TeGUxnE5KvmwuKqe4o/pamZ4=;
        b=Jgn0AchhCu16KCeuKyKphEc7TF2WXK+oYKnJQPtJOB1ArxAS0GHH7rtrTRjkJ1eslV
         dyzpvph7O1bcbaI+MbGFjE9U81Xw0xmsGDgXMPIsA09yT9y6Scx0Sw0GNGXinMRxBNHj
         MidMzfS1iGvxHNFQ7FoDKVbEHRzIv+8ARcDpZFHMo93VlI1nLJbVgKm5y9FO7MVezoD6
         dGP1oKu60tFwI4o6oTBIDqGzN+42lWqwY8rQ1p+le5da11xT3hMhWd90Z5Iogv0y7F7S
         Jdo8PDzKuKZm+3REzXuRqeDvOmfpTl/i7F4bUQeodnbRPYbGLhXweX0yOULJ0XRsOXng
         5Hgw==
X-Forwarded-Encrypted: i=1; AJvYcCVj28SeGZZBtYMf6CjvkbnesIZK79cov+moL2kuhM4HdQCqI/wrhPTPB0bwsHCJoCWzBecZYn3eOESVApCRqBgueJE3Wd1BZkwaxKPKekQDyLuU6Iivft2x+kG2ZijP1GAPbwAHeZQ5
X-Gm-Message-State: AOJu0YwwGnaofuErrmAYd4QqoK5zOqd/bU85T9HCdNcj1p/r4TtV7q4n
	G0qx9rajAAOCgYEgUb8/Nq+tzrQJwHvwcObMAM3P32DWf3fWDi2q
X-Google-Smtp-Source: AGHT+IGNG9vxDFxLwp6LH6gHm98AbumciP+UKQShkj+bs5fdr5dQCOqFsqwOOMWP9Hvs4t2YHLHiLg==
X-Received: by 2002:a05:6214:588e:b0:6bf:894e:7964 with SMTP id 6a1803df08f44-6bf894e7aabmr54977146d6.57.1724034718766;
        Sun, 18 Aug 2024 19:31:58 -0700 (PDT)
Received: from localhost (fwdproxy-ash-012.fbsv.net. [2a03:2880:20ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf763cb74fsm36274866d6.112.2024.08.18.19.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:31:58 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 6/6] mm: add sysfs entry to disable splitting underused THPs
Date: Mon, 19 Aug 2024 03:30:59 +0100
Message-ID: <20240819023145.2415299-7-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819023145.2415299-1-usamaarif642@gmail.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If disabled, THPs faulted in or collapsed will not be added to
_deferred_list, and therefore won't be considered for splitting under
memory pressure if underused.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 Documentation/admin-guide/mm/transhuge.rst | 10 +++++++++
 mm/huge_memory.c                           | 26 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 40741b892aff..02ae7bc9efbd 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -202,6 +202,16 @@ PMD-mappable transparent hugepage::
 
 	cat /sys/kernel/mm/transparent_hugepage/hpage_pmd_size
 
+All THPs at fault and collapse time will be added to _deferred_list,
+and will therefore be split under memory presure if they are considered
+"underused". A THP is underused if the number of zero-filled pages in
+the THP is above max_ptes_none (see below). It is possible to disable
+this behaviour by writing 0 to shrink_underused, and enable it by writing
+1 to it::
+
+	echo 0 > /sys/kernel/mm/transparent_hugepage/shrink_underused
+	echo 1 > /sys/kernel/mm/transparent_hugepage/shrink_underused
+
 khugepaged will be automatically started when PMD-sized THP is enabled
 (either of the per-size anon control or the top-level control are set
 to "always" or "madvise"), and it'll be automatically shutdown when
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f5363cf900f9..5d67d3b3c1b2 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -74,6 +74,7 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
 					  struct shrink_control *sc);
 static unsigned long deferred_split_scan(struct shrinker *shrink,
 					 struct shrink_control *sc);
+static bool split_underused_thp = true;
 
 static atomic_t huge_zero_refcount;
 struct folio *huge_zero_folio __read_mostly;
@@ -439,6 +440,27 @@ static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 static struct kobj_attribute hpage_pmd_size_attr =
 	__ATTR_RO(hpage_pmd_size);
 
+static ssize_t split_underused_thp_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", split_underused_thp);
+}
+
+static ssize_t split_underused_thp_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t count)
+{
+	int err = kstrtobool(buf, &split_underused_thp);
+
+	if (err < 0)
+		return err;
+
+	return count;
+}
+
+static struct kobj_attribute split_underused_thp_attr = __ATTR(
+	shrink_underused, 0644, split_underused_thp_show, split_underused_thp_store);
+
 static struct attribute *hugepage_attr[] = {
 	&enabled_attr.attr,
 	&defrag_attr.attr,
@@ -447,6 +469,7 @@ static struct attribute *hugepage_attr[] = {
 #ifdef CONFIG_SHMEM
 	&shmem_enabled_attr.attr,
 #endif
+	&split_underused_thp_attr.attr,
 	NULL,
 };
 
@@ -3477,6 +3500,9 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	if (folio_order(folio) <= 1)
 		return;
 
+	if (!partially_mapped && !split_underused_thp)
+		return;
+
 	/*
 	 * The try_to_unmap() in page reclaim path might reach here too,
 	 * this may cause a race condition to corrupt deferred split queue.
-- 
2.43.5


