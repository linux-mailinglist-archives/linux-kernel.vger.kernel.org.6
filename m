Return-Path: <linux-kernel+bounces-238139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED492440D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83F28B22C32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F851BD51B;
	Tue,  2 Jul 2024 17:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRFUL8Th"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C8846D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 17:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939768; cv=none; b=mreWkbY0rz9TjlRvcj4QTYEm2yUmiYW3Oq4jNWxF3KaXgkngdKyFhNGzfkgdk28QVKUJBVZLJr24XVy+wc6DRu9GXMnMYP9FsuTKQ7svzawtC900VtCsxD1kg3ycpC/i7P6J1avQYLOAi4ARclbd+3e/L9LUJ2BZ3G/jasvAoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939768; c=relaxed/simple;
	bh=xBUA98tyf6ylBYRLd0n+137prDWIkRoJnCa3k2MMHr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lcij5rxA6v80YjYrrdamHNABVOmg4t5Uf0oatM8hkqgHc1hLh6mheFfOccu4XYXoEsHeRIhgTJKhOGDv0MACOsgzP4bzh/apDwknbjxhz+OcX/BuZ/3hu2LaMMGPO+I78HmPxKLx5njW8/APu8rarq0mAgO8Jl7rdsoP++BiLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRFUL8Th; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57ccd1111aeso2521319a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719939765; x=1720544565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdWRMcBmqy1DiRWnbnsFCOE3yjUZS2pxzl1aVaY5jFQ=;
        b=fRFUL8ThI82MbliggiR9tYvCP8l7U7nS3OpTVysesUii/L6NyEpxPPI2y3MgazoXIe
         Kr91i3zVUItXwHfiHJYkQVl6VlIn34vk1zCCXHAeL3SyXUwV0930J1hRoAGr2HL7CxzX
         wml7gm8OB06tUxKY1sKM14kXTUBjkSZuHDE1O7o0duw+m56tbVZiV0BoNaWl7ZPmV61f
         LQYJeZh8aAuJQvEs4wpRrOP8iioRgC/hxJoZxgWoSTWofqslrJ9Cp0uDCSRYwueZ52+Y
         Ed/5oQKNNR1d3riBLzMq5HHOYem288aUsVcYHfrZKvZRoAeMJMRsNtiRhjgs7SU4WcbH
         JVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719939765; x=1720544565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdWRMcBmqy1DiRWnbnsFCOE3yjUZS2pxzl1aVaY5jFQ=;
        b=jyHHe2zz2eWnwbCAxDX+X3iGGI/QrJDTNPlfQ5sIFihVxUXGx4m6gtHVJTnuKu1k5a
         0gdVAzeokQM8ze2dkf/lUkhU+NokgBbrMJwrMIhxDS1i2CH7a4ZNvXiXtuKxIysZxyif
         fDKMAJuuCaGZmMbk76pU9w4e2un2402KbQKe/93yglGYWmt1jz0Hs1OHugwvZZ2+e5zt
         CX8Z9WqPZ/l0bszpPDr8/WDlh+YDwcldkujk4BonbSkh8p8ilX/0eToTbQNi+Bk/MP6j
         pcVcLapfaBhB8YFEuQ9HdUc+xLDp6zskGomXiT9vWNFBJjnn6+NeWCAPk/GBLcXHSCFy
         BaNw==
X-Gm-Message-State: AOJu0YzqwVZOjGJn2Xwk652xdBf0McrpA0zh9I6HC2juo62jbfPYuzVS
	QB310xj8moCbJe8BaaOgAEofEqH9cULbibnMT2gD0FkFq2A0XG6j1TJJciFW
X-Google-Smtp-Source: AGHT+IFUq20jmxB1R5iz3sgtitwunTUAUzES72y1ZknGwt1tDkXm/i1z+O983p90gJBJ57YWptxHSg==
X-Received: by 2002:a05:6402:b44:b0:58b:c86:b230 with SMTP id 4fb4d7f45d1cf-58b0c86b290mr1495274a12.42.1719939764503;
        Tue, 02 Jul 2024 10:02:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:f0d8:7406:5a81:615c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c835c4sm5900767a12.11.2024.07.02.10.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 10:02:43 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH 1/1 RFC v2] drivers: cacheinfo: use __free attribute instead of of_node_put()
Date: Tue,  2 Jul 2024 19:02:41 +0200
Message-ID: <20240702170241.104934-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240622152526.131974-2-vincenzo.mezzela@gmail.com>
References: <20240622152526.131974-2-vincenzo.mezzela@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the __free attribute for scope-based resource management.
Resources allocated with __free are automatically released at the end of
the scope. This enhancement aims to mitigate memory management issues
associated with forgetting to release resources by utilizing __free
instead of of_node_put().

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
changes in v2:
- fixed coding style that was triggering checkpatch.pl
---
 drivers/base/cacheinfo.c | 41 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 23b8cba4a2a3..acab52dd7fb8 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -202,29 +202,24 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 
 static int cache_setup_of_node(unsigned int cpu)
 {
-	struct device_node *np, *prev;
 	struct cacheinfo *this_leaf;
 	unsigned int index = 0;
 
-	np = of_cpu_device_node_get(cpu);
+	struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
 	if (!np) {
 		pr_err("Failed to find cpu%d device node\n", cpu);
 		return -ENOENT;
 	}
 
 	if (!of_check_cache_nodes(np)) {
-		of_node_put(np);
 		return -ENOENT;
 	}
 
-	prev = np;
-
 	while (index < cache_leaves(cpu)) {
 		this_leaf = per_cpu_cacheinfo_idx(cpu, index);
 		if (this_leaf->level != 1) {
+			struct device_node *prev __free(device_node) = np;
 			np = of_find_next_cache_node(np);
-			of_node_put(prev);
-			prev = np;
 			if (!np)
 				break;
 		}
@@ -233,8 +228,6 @@ static int cache_setup_of_node(unsigned int cpu)
 		index++;
 	}
 
-	of_node_put(np);
-
 	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
 		return -ENOENT;
 
@@ -243,17 +236,14 @@ static int cache_setup_of_node(unsigned int cpu)
 
 static bool of_check_cache_nodes(struct device_node *np)
 {
-	struct device_node *next;
-
 	if (of_property_present(np, "cache-size")   ||
 	    of_property_present(np, "i-cache-size") ||
 	    of_property_present(np, "d-cache-size") ||
 	    of_property_present(np, "cache-unified"))
 		return true;
 
-	next = of_find_next_cache_node(np);
+	struct device_node *next __free(device_node) = of_find_next_cache_node(np);
 	if (next) {
-		of_node_put(next);
 		return true;
 	}
 
@@ -287,12 +277,10 @@ static int of_count_cache_leaves(struct device_node *np)
 int init_of_cache_level(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct device_node *np = of_cpu_device_node_get(cpu);
-	struct device_node *prev = NULL;
+	struct device_node *np __free(device_node) = of_cpu_device_node_get(cpu);
 	unsigned int levels = 0, leaves, level;
 
 	if (!of_check_cache_nodes(np)) {
-		of_node_put(np);
 		return -ENOENT;
 	}
 
@@ -300,30 +288,27 @@ int init_of_cache_level(unsigned int cpu)
 	if (leaves > 0)
 		levels = 1;
 
-	prev = np;
-	while ((np = of_find_next_cache_node(np))) {
-		of_node_put(prev);
-		prev = np;
+	while (1) {
+		struct device_node *prev __free(device_node) = np;
+		np = of_find_next_cache_node(np);
+		if (!np)
+			break;
+
 		if (!of_device_is_compatible(np, "cache"))
-			goto err_out;
+			return -EINVAL;
 		if (of_property_read_u32(np, "cache-level", &level))
-			goto err_out;
+			return -EINVAL;
 		if (level <= levels)
-			goto err_out;
+			return -EINVAL;
 
 		leaves += of_count_cache_leaves(np);
 		levels = level;
 	}
 
-	of_node_put(np);
 	this_cpu_ci->num_levels = levels;
 	this_cpu_ci->num_leaves = leaves;
 
 	return 0;
-
-err_out:
-	of_node_put(np);
-	return -EINVAL;
 }
 
 #else
-- 
2.43.0


