Return-Path: <linux-kernel+bounces-206496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23675900A8F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0045284665
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB719B5BB;
	Fri,  7 Jun 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbVK9Q/t"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8564F19B3F6
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778040; cv=none; b=q9uFdwEALrO29lna/8UP6BWbxRfZMLKSihbsIIZfXEQmy0zaJvpycAz+6EzodLS05M6CF4IjHdif+Z/AQax2jnABqNgblkzbK0Vg51qiwGPpZViztNEgh+SVJdgQdSz3iDr0RlbYI+CrPR71eQUnt3I8NDM4MlvWbpJk6FpXXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778040; c=relaxed/simple;
	bh=Rw/yQU4SQECgSFkVagrrG+DKRyohNhv3ZOmdBmgXr5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiPLrItnNskZYjeDlfep9xhhuR44yYyoVTox5IVyBrZ4F+5K3iOcijSkJNBW4X/FJxpe38jbf/RqvxXziHV8JygpyB869x+FJfC5Ib2Q1q9WPwcRFGIXEG2knnEy6rFtSzAgFZg9TpwT6ZWVFp9s03raMS2cMmBcaAFHpvl2KHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbVK9Q/t; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a2f032007so2967699a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717778037; x=1718382837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUlrcyXqHPisdOR1gYbfhNfAfonQ36aa9TUXeHIP7cM=;
        b=NbVK9Q/txkqfBV24f582PRvun2A+9OLUKzY9lFF57KVYplWbin0+NwuG7EcdAvAxYZ
         XJyIYjiGITMg2XVvAa3U5G9PDBsfAt+0EcR/3KxlAi6FRBg5bdDNc74YvC5CqkvATs/s
         aoaJkudOjp+uC1p/X41dgaw53ZH+VB24p2hbWf4rbQe6TLC71m3DpjxcQlzwlHNEnU7p
         hK7vKHhpht7oI/kk5SV9lJnMjc7sdSVWmhcc0RJGqpM04FDMD4Euhbpf4+jjI7Sa20Bj
         f2UmrtD1pwDCD4SjNaJhQwwOyRfWcZbgAQzfDdIPVYZUEr1f974xhHSGZSYH/RH1if1D
         NK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717778037; x=1718382837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUlrcyXqHPisdOR1gYbfhNfAfonQ36aa9TUXeHIP7cM=;
        b=i5EFEjGSKbZSNbCb2TQi9FpLSuvxaxTgDoR10ylC1nocsUm0+/DAr9Bf/8mEKzykw+
         zxWxHNep+/sQbLw2LK+W7daEgimzeMhb9Wi+pg6n3DLhGZUx/xFKyWVXJv7rAU9NPjzG
         ZtrPvzxXLU5Gr+Gl7Heyk6ouM4RxtlmCQ0zRQVrsN8ePgsN/idNQalllBUyLG/904DhG
         rM9ZJqmZF8Oergkzlo3+MN/pjEVtht78nq64IKgguyscC+yc5SepaY0d3K5hZP3Ccj7h
         jVHD6/ce+7aH4ph0G30CWQI1FjOiB7guwWyRhqI1IwGHK3WIRNDwwPybtPDiTGzly1Yc
         eYtA==
X-Forwarded-Encrypted: i=1; AJvYcCXPTDsfBPtdSaa+dsSA+KwsZClG/i3/t1SUrau6q/YklgiwWJy9YwFRLBYfP+TLI8rw/eL+5jv0BkObkS8cDDxlIv21W35Qrucs+oaE
X-Gm-Message-State: AOJu0YzcvyS/NMrnWBLB/VTY+ienlRW5A37YfOnQ2Ofv+8abpZSn1yfR
	4mb5GORKLn3ZwYL3CdZe0nJytb7MNCGJ2m17XqFwCA6SxPffNALt
X-Google-Smtp-Source: AGHT+IGR9NKO5efJ0RzKvH1rbvh2TMToeq9ABS5xgp1TI7WnqoMrkOMUR2oOQc3zd8Ub4Qy47Q+OZQ==
X-Received: by 2002:a50:bb49:0:b0:57a:2f68:fe7b with SMTP id 4fb4d7f45d1cf-57c509898c8mr1935409a12.31.1717778036833;
        Fri, 07 Jun 2024 09:33:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:17a2:25c2:1b0c:3c07])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0cc355sm3032715a12.33.2024.06.07.09.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:33:56 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	sudeep.holla@arm.com
Cc: vincenzo.mezzela@gmail.com,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 2/2 v4 RESEND] drivers: arch_topology: use __free attribute instead of of_node_put()
Date: Fri,  7 Jun 2024 18:33:50 +0200
Message-Id: <20240607163350.392971-3-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607163350.392971-1-vincenzo.mezzela@gmail.com>
References: <20240607163350.392971-1-vincenzo.mezzela@gmail.com>
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

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/arch_topology.c | 56 +++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 583f11bd4d2e..75fcb75d5515 100644
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


