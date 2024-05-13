Return-Path: <linux-kernel+bounces-177328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9708C3CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292BE1F21CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149D147C9A;
	Mon, 13 May 2024 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx5o+0Uv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40151147C63
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587998; cv=none; b=tKWRhZ9wSSaMHv9OH6/Sl7Wh2w5x2vB1Dy28RSw1oieFlFDuy4Q4JOeGiZb6v4fO6XsQHp3mlhjyAzloYn2n3z3bLUz09SCB2JzLC6oHMBf/VOcBPgK2K6rvwEEgBalpod8ullk93fZN6vX+EnG+63HvVaJjuvr/BCBdvpVMmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587998; c=relaxed/simple;
	bh=8rQNnlpHNwSiby7H2KfOJ545BmEBEQbSDs3gFqf7ryE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bnI76sie5DpsfWocuzQAJ3rltHyNX4z/Z5scxxo1lZUgej+1BW8rvjsOlIXBanDFQcrh16gDhZd9HlB2YaknG9gv8C8LoJR6mq5nXtHENy1iioRuxwk9u6W3nbdUBH6OjC00dcpraOFYkLXtkglzN7fTiO5pJMY3u1+4Oz9yR6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx5o+0Uv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so13396005e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587995; x=1716192795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KjI2GIzbNeY5mYmEJBzlwq8aj+x1UHEKf/2QoRMS7Cs=;
        b=Tx5o+0UvrfIe/CofrsmD/lehG7oTjpJtTWWSlzySl7G/CygVmhWepYMiCkTHSVbYDj
         Kl4fhlzkv6T9ByUwTK8aBQ5AHoYLsgrZ1frgggBpv3K2fx40iO+5QLJbFcoFEB8L8iST
         cpxkLYyiTkJTOE3EOSOa5CiTfg0YsvgT9vNbtB9NS4cwImnOd46jwUnTzH4Vyp61IJtr
         7xggBl5OPhGjeHquS+nx7xB7vFR/DKWBymjJb8NmIWKblc54eqmwRSD6l1/ZD1IjZG4O
         CyGrUDe71qZ3P+jjFweP5OHNf7zcblIH6jsTpXunW7a3hZPXh46XLWMLwzwqXR2/6E4g
         0uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587995; x=1716192795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KjI2GIzbNeY5mYmEJBzlwq8aj+x1UHEKf/2QoRMS7Cs=;
        b=nBO7wJKgoUMxP/wWcdP/9twy6v8TpMuWQ15eIoXSeFJhs+Q8DjIsKq9P0UsdMS0bkh
         nMd8GSd3syaDCv7hfGOMn+XiqcygGSF2MU8bmFMBBrT/sYkplJSp/+ANGA3BMoclmC8r
         nZHsF46NNPmtGsVr9XjMu1DlbpJo1jEQJjYVFW1WYjL9m15vDW86MvVzAdSLsB362Pvs
         AYKKw9SZIFYFyCNXCh4wYNye77V4fwpxPpbVaRmhjMVJcduJu1jlEjpf6+W4SyfPij1O
         7kwtYDgrV1Wq67vHaTV+04W01uVP+QVk6YpUG/JgaI1ICLT5wBgf2EqiU2FDhD36zExT
         dCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpiIMaSJgK1Vw86yEvbDMVvH8ExsqX4nKSCSW1RgBs3dgU3rNwoGhTL8sYZxMdhV8e/Hr5qOYvIC9KbEagEwxDlLqQMJunkHqaxKgx
X-Gm-Message-State: AOJu0YzPKWCyaMtkSu51tsg0yofuVlOhvSl4b71abo47V3XILd7HhbDy
	bdarj6v1vcxHFUR6Ew0p/+TLJijw5VZ+nvWFo7xc3O0Qsze+AaqWFMgLNG5f/UY=
X-Google-Smtp-Source: AGHT+IGTEXWrUQ7VGUcVeKG0+Ho7vHvmqvLjvCgT6L/7ToRERkrjvg7sB944hy/FRrFnxQ2sXbBaag==
X-Received: by 2002:a05:600c:4fc9:b0:41c:1434:f571 with SMTP id 5b1f17b1804b1-41feac59deemr67598535e9.37.1715587994435;
        Mon, 13 May 2024 01:13:14 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:c88b:6249:b2f4:9ae2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77f8sm10399563f8f.54.2024.05.13.01.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:13:14 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: vincenzo.mezzela@gmail.com,
	gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 2/2 v4] drivers: arch_topology: use __free attribute instead of of_node_put()
Date: Mon, 13 May 2024 10:13:04 +0200
Message-Id: <20240513081304.499915-3-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513081304.499915-1-vincenzo.mezzela@gmail.com>
References: <20240501094313.407820-1-vincenzo.mezzela@gmail.com>
 <20240513081304.499915-1-vincenzo.mezzela@gmail.com>
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

The declaration of the device_node used within the do-while loops is
moved directly within the loop so that the resource is automatically
freed at the end of each iteration.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/arch_topology.c | 56 +++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 0115011b7a99..93c9f0499694 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -8,6 +8,7 @@
 
 #include <linux/acpi.h>
 #include <linux/cacheinfo.h>
+#include <linux/cleanup.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
@@ -513,10 +514,10 @@ core_initcall(free_raw_capacity);
  */
 static int __init get_cpu_for_node(struct device_node *node)
 {
-	struct device_node *cpu_node;
 	int cpu;
+	struct device_node *cpu_node __free(device_node) =
+		of_parse_phandle(node, "cpu", 0);
 
-	cpu_node = of_parse_phandle(node, "cpu", 0);
 	if (!cpu_node)
 		return -1;
 
@@ -527,7 +528,6 @@ static int __init get_cpu_for_node(struct device_node *node)
 		pr_info("CPU node for %pOF exist but the possible cpu range is :%*pbl\n",
 			cpu_node, cpumask_pr_args(cpu_possible_mask));
 
-	of_node_put(cpu_node);
 	return cpu;
 }
 
@@ -538,11 +538,12 @@ static int __init parse_core(struct device_node *core, int package_id,
 	bool leaf = true;
 	int i = 0;
 	int cpu;
-	struct device_node *t;
 
 	do {
 		snprintf(name, sizeof(name), "thread%d", i);
-		t = of_get_child_by_name(core, name);
+		struct device_node *t __free(device_node) =
+			of_get_child_by_name(core, name);
+
 		if (!t)
 			break;
 
@@ -555,10 +556,8 @@ static int __init parse_core(struct device_node *core, int package_id,
 			cpu_topology[cpu].thread_id = i;
 		} else if (cpu != -ENODEV) {
 			pr_err("%pOF: Can't get CPU for thread\n", t);
-			of_node_put(t);
 			return -EINVAL;
 		}
-		of_node_put(t);
 		i++;
 	} while (1);
 
@@ -587,7 +586,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	char name[20];
 	bool leaf = true;
 	bool has_cores = false;
-	struct device_node *c;
 	int core_id = 0;
 	int i, ret;
 
@@ -599,7 +597,9 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "cluster%d", i);
-		c = of_get_child_by_name(cluster, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
+
 		if (!c)
 			break;
 
@@ -607,7 +607,6 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 		ret = parse_cluster(c, package_id, i, depth + 1);
 		if (depth > 0)
 			pr_warn("Topology for clusters of clusters not yet supported\n");
-		of_node_put(c);
 		if (ret != 0)
 			return ret;
 		i++;
@@ -617,7 +616,9 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "core%d", i);
-		c = of_get_child_by_name(cluster, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(cluster, name);
+
 		if (!c)
 			break;
 
@@ -625,21 +626,19 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 
 		if (depth == 0) {
 			pr_err("%pOF: cpu-map children should be clusters\n", c);
-			of_node_put(c);
 			return -EINVAL;
 		}
 
 		if (leaf) {
 			ret = parse_core(c, package_id, cluster_id, core_id++);
+			if (ret != 0)
+				return ret;
 		} else {
 			pr_err("%pOF: Non-leaf cluster with core %s\n",
 			       cluster, name);
-			ret = -EINVAL;
+			return -EINVAL;
 		}
 
-		of_node_put(c);
-		if (ret != 0)
-			return ret;
 		i++;
 	} while (1);
 
@@ -652,19 +651,19 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 static int __init parse_socket(struct device_node *socket)
 {
 	char name[20];
-	struct device_node *c;
 	bool has_socket = false;
 	int package_id = 0, ret;
 
 	do {
 		snprintf(name, sizeof(name), "socket%d", package_id);
-		c = of_get_child_by_name(socket, name);
+		struct device_node *c __free(device_node) =
+			of_get_child_by_name(socket, name);
+
 		if (!c)
 			break;
 
 		has_socket = true;
 		ret = parse_cluster(c, package_id, -1, 0);
-		of_node_put(c);
 		if (ret != 0)
 			return ret;
 
@@ -679,11 +678,11 @@ static int __init parse_socket(struct device_node *socket)
 
 static int __init parse_dt_topology(void)
 {
-	struct device_node *cn, *map;
 	int ret = 0;
 	int cpu;
+	struct device_node *cn __free(device_node) =
+		of_find_node_by_path("/cpus");
 
-	cn = of_find_node_by_path("/cpus");
 	if (!cn) {
 		pr_err("No CPU information found in DT\n");
 		return 0;
@@ -693,13 +692,15 @@ static int __init parse_dt_topology(void)
 	 * When topology is provided cpu-map is essentially a root
 	 * cluster with restricted subnodes.
 	 */
-	map = of_get_child_by_name(cn, "cpu-map");
+	struct device_node *map __free(device_node) =
+		of_get_child_by_name(cn, "cpu-map");
+
 	if (!map)
-		goto out;
+		return ret;
 
 	ret = parse_socket(map);
 	if (ret != 0)
-		goto out_map;
+		return ret;
 
 	topology_normalize_cpu_scale();
 
@@ -709,14 +710,9 @@ static int __init parse_dt_topology(void)
 	 */
 	for_each_possible_cpu(cpu)
 		if (cpu_topology[cpu].package_id < 0) {
-			ret = -EINVAL;
-			break;
+			return -EINVAL;
 		}
 
-out_map:
-	of_node_put(map);
-out:
-	of_node_put(cn);
 	return ret;
 }
 #endif
-- 
2.34.1


