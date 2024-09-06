Return-Path: <linux-kernel+bounces-318107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D08D596E86A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E34D285796
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 03:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130474174C;
	Fri,  6 Sep 2024 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lutN4P2F"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7722E822
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725594671; cv=none; b=LIhq38A5zARlT6fp3otwURfGNbMvwk3FoMkMdfLe+NRNt5/U4Ko1fzWJLbZjHj/Zcinq7AvAbAnW2+MYinVD1JU5wVk9pc/3wUXs0iNVb0DD1XG0eHF5ACVDN2uD0ZgIjZzDAFd//n7IdTIKgPKMhlvMOmHl6tBjv494Zv612Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725594671; c=relaxed/simple;
	bh=+l/PCGk2Tso9ruIPDtTprkBjfTvhfvDJKqYg2TwvZ9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m68ZfYkIT8rTh86PqdgDnMYMcdLxe5cKW9aq1tnqjRfa9vPR3FkgjMV2kt9xxvauT6z0qhyQOgweGM2on37RMJHP5/m/KKq/93xTqpPbzDh+YpmhS/Xltdj5jcOs7a5T5OR86mmHm1OCyIyiqQZ+hzfsKbT22htZvcYj9Ia978Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lutN4P2F; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5dc93fa5639so1002631eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 20:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725594669; x=1726199469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAqeypQfhkuhTUZIBtelAtfJusBm2y6UIbBZ4nA8cGs=;
        b=lutN4P2Fhv8cPcaVh9fs7HZmbTQJDuFV9oQ+j9W2ayisEIjaltS8OPhmDYtr+A0Gen
         2pHO994QTDHbLGQe4byb88sPM3PraQr00y7iRZXGDk74Ay2ggWy9FscwjJERGuvntS8e
         BcBmPt4edqSmyZCPYD7DQuT/zc3lna1+VWR4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725594669; x=1726199469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAqeypQfhkuhTUZIBtelAtfJusBm2y6UIbBZ4nA8cGs=;
        b=u4kr0o4vID1TcN5akJ0jR5mnHv4hehNryCRShvjV2GpEK9R1YZYkE5yrT9dWd5gnYn
         ic/j7cldABtdN/W34+2fljZm7DwQ4jDOooWqxC53RKuuxlSl1sGqWG5jLnQrvH8BlMbR
         ILj/qqBVUT2zlUDcJfaMLDTR0TlTHWQLds+r9kgPybEcxbd8zKMJF3v1iUuklbNwVt8S
         u91d7wU7XbWIkEDF9HGzwq/uMthI58ZfLyzgJbn2XjE2wQ6frwniNYNTWMtg/R0gikbV
         ElGBaqTqvDd7deTTM01Ul9NXll72b4tyyK9ftXPcoUSG4cfHr3eU5q8wPakuizJSaoIN
         PMTg==
X-Forwarded-Encrypted: i=1; AJvYcCVvIxRIiGK92H0l/Mf6m2vaQba4kuFO79L/ADxx2XwfjU9naMXIO+TCDN1IwbII0WCgaTCoFjS1J8u0pi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQ3uKrLI39Bnniwm01PlfLZtFZbIe7KOdT6yPxgWGLeK6zxmG
	oTrmEYdp5CG9GtouCLglf3NlsQxjjTZkKGyQF4QnMi1Q3lcxVIZC+z63BjoY3A==
X-Google-Smtp-Source: AGHT+IGxujtVNLgTvAFObL24ByIGxrPw1YyqA9moK76Vv3qCoroKoAFrwI5Oaw6ioAAzZdAb1HxuHg==
X-Received: by 2002:a05:6870:1697:b0:277:f722:45e1 with SMTP id 586e51a60fabf-27b82e5d645mr1631172fac.17.1725594668906;
        Thu, 05 Sep 2024 20:51:08 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:734f:d85:4585:b52d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718db3b043bsm60307b3a.101.2024.09.05.20.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 20:51:08 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2] zsmalloc: use unique zsmalloc caches names
Date: Fri,  6 Sep 2024 12:45:44 +0900
Message-ID: <20240906035103.2435557-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each zsmalloc pool maintains several named kmem-caches for
zs_handle-s and  zspage-s.  On a system with multiple zsmalloc
pools and CONFIG_DEBUG_VM this triggers kmem_cache_sanity_check():

  kmem_cache of name 'zspage' already exists
  WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
  ...

  kmem_cache of name 'zs_handle' already exists
  WARNING: at mm/slab_common.c:108 do_kmem_cache_create_usercopy+0xb5/0x310
  ...

We provide zram device name when init its zsmalloc pool, so we can
use that same name for zsmalloc caches and, hence, create unique
names that can easily be linked to zram device that has created
them.

So instead of having this

cat /proc/slabinfo
slabinfo - version: 2.1
zspage                46     46    ...
zs_handle            128    128    ...
zspage             34270  34270    ...
zs_handle          34816  34816    ...
zspage                 0      0    ...
zs_handle              0      0    ...

We now have this

cat /proc/slabinfo
slabinfo - version: 2.1
zspage-zram2          46     46    ...
zs_handle-zram2      128    128    ...
zspage-zram0       34270  34270    ...
zs_handle-zram0    34816  34816    ...
zspage-zram1           0      0    ...
zs_handle-zram1        0      0    ...

Fixes: 2e40e163a25a ("zsmalloc: decouple handle and object")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 73a3ec5b21ad..16a07def09c9 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -54,6 +54,7 @@
 #include <linux/vmalloc.h>
 #include <linux/preempt.h>
 #include <linux/spinlock.h>
+#include <linux/sprintf.h>
 #include <linux/shrinker.h>
 #include <linux/types.h>
 #include <linux/debugfs.h>
@@ -293,17 +294,27 @@ static void SetZsPageMovable(struct zs_pool *pool, struct zspage *zspage) {}
 
 static int create_cache(struct zs_pool *pool)
 {
-	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
-					0, 0, NULL);
+	char *name;
+
+	name = kasprintf(GFP_KERNEL, "zs_handle-%s", pool->name);
+	if (!name)
+		return -ENOMEM;
+	pool->handle_cachep = kmem_cache_create(name, ZS_HANDLE_SIZE,
+						0, 0, NULL);
+	kfree(name);
 	if (!pool->handle_cachep)
-		return 1;
+		return -EINVAL;
 
-	pool->zspage_cachep = kmem_cache_create("zspage", sizeof(struct zspage),
-					0, 0, NULL);
+	name = kasprintf(GFP_KERNEL, "zspage-%s", pool->name);
+	if (!name)
+		return -ENOMEM;
+	pool->zspage_cachep = kmem_cache_create(name, sizeof(struct zspage),
+						0, 0, NULL);
+	kfree(name);
 	if (!pool->zspage_cachep) {
 		kmem_cache_destroy(pool->handle_cachep);
 		pool->handle_cachep = NULL;
-		return 1;
+		return -EINVAL;
 	}
 
 	return 0;
-- 
2.46.0.469.g59c65b2a67-goog


