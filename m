Return-Path: <linux-kernel+bounces-177327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A68C3CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D32D282035
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6370147C72;
	Mon, 13 May 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ftQ4qj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFB01474B2
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587996; cv=none; b=R0zA2g0TPz7VUq7joUSO6xuRBksnD4WtnJjAhmWguC0uK9lofeypyl6ma1+gWna3D7fQBHhiMIc8KORkRSGsRTxxBKHUzTznczr3TFEYIOsrObdOmqZ+B8g4ifrWvbBNLkyy//drKFtDj3gAmmHTfYj5/TFHnCd1TQB2Qz6pqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587996; c=relaxed/simple;
	bh=Na3kXLkRn57AYhgOBHgrLyZdlf9VwDpzCo459lFXX8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sbcuKhGTZoUvJa7A6+0EWb7w3bo+j4Eb1UO2ezB0f9KhPi/MeyRbu6KDi52TUCBN4PwY5nh3jFYiV/BLxVTGlFt4K5zAXbia3ZH/605mn0N8L4QjDqYHwQJEn1xnQ0QC1rWRIjRUY9QRUFHyUofBjrsGKQSP7r7A2RqRTSukJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9ftQ4qj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ff5e3d86aso18213165e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715587993; x=1716192793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLJtQN7Bc5zh6oDDzuNRzBN4QxI3AOSG3b/sB8YLz6M=;
        b=W9ftQ4qj4y+NJ9x4+z62Wl/LS45zIoQbtdPxyVPHbNz661qn5WeI5FstpJH4gK4fSX
         S+1/mnUsqYdlxhXZB16zylZAa7mQe3aZ4nFgaPPgwed9d9DB95wNN7dWRhIPAWv2tXGq
         273nb5lKTK5QYd1iAHu3CvcPS1n7/AHSArBsUXCq/HNRFE1w2OTw4O3KbZnlOtQ/obn+
         q/NlDqnFp1N+tF5Rw6T8XA1GL0UlY8KPTUGIDBP9FM20Mklm3DFyG2P+tv7te8lnclLK
         Ls2EClG/oQ6aSVOb4p7J06AH4sZKeRldn+NRieAgt4bxsf5ZK/FYpLMFT51i6wZT1Nfp
         lfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715587993; x=1716192793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLJtQN7Bc5zh6oDDzuNRzBN4QxI3AOSG3b/sB8YLz6M=;
        b=CQOpMuY4nVQj29GC954xRi3PFL2JpbayCqhRCN/rIvARrkEJXZUlWzrWN3I5jYFy7q
         JvzD8VQLRMkjin4rtI+goQyXoXT51hJc8cWH+krnxR+/NOcr5/WTAbSSl2t7NB76UEJy
         DYzSaUer+jkwh2Rn0Ig1ivVCDLBtXZPttAkF2Vy/7EMIf7al3LzscdRwojyC0l+GabvR
         ADJ22u1znYnLaBHcu88+3tffMKQONc1a4wgOfqo8hgGvidlDMXchtfswLVWp34pO4dhW
         JZHlzvr/4VUZtKSUzkkSJFIDRZGKMoMEAK1KXzsL4Fdi1WhdxrmhAbs/DVj0fCa09BSo
         GBWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwgIHZZj4kGBXtvvq+VCfXw0j418x5Kh0lJOIWcKVdWR8pLt3nYX3YR0Ef0LIAs9qhEwLADJCECCD9yljU5Hv5zXXs8jAWikucw7zn
X-Gm-Message-State: AOJu0Yx9U63OJj04k3a+aA8FTFh8Hli+6WWLqup95fNLJqWNrnDovWQ1
	M/egODaOiGS39W5K4oRxeHLB0bkYg2OBtTNM1KkC0FXNEV3SpLMi
X-Google-Smtp-Source: AGHT+IEff/OUcRTtaHMDUkIg3FlBxHKlEVq2xT3oVi1BqZHgzE8YwBVHHRU+ACmnKhc/MU/T+/bM/A==
X-Received: by 2002:a05:600c:314e:b0:41a:bdaf:8c78 with SMTP id 5b1f17b1804b1-41fea931891mr65664035e9.8.1715587992498;
        Mon, 13 May 2024 01:13:12 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:c88b:6249:b2f4:9ae2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a77f8sm10399563f8f.54.2024.05.13.01.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:13:12 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: sudeep.holla@arm.com
Cc: vincenzo.mezzela@gmail.com,
	gregkh@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 1/2 v4] drivers: arch_topology: Refactor do-while loops
Date: Mon, 13 May 2024 10:13:03 +0200
Message-Id: <20240513081304.499915-2-vincenzo.mezzela@gmail.com>
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

Refactor do-while loops to move break condition within the loop's scope.
This modification is in preparation to move the declaration of the
device_node directly within the loop and take advantage of the automatic
cleanup feature provided by the __free(device_node) attribute.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/arch_topology.c | 107 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 024b78a0cfc1..0115011b7a99 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -543,23 +543,24 @@ static int __init parse_core(struct device_node *core, int package_id,
 	do {
 		snprintf(name, sizeof(name), "thread%d", i);
 		t = of_get_child_by_name(core, name);
-		if (t) {
-			leaf = false;
-			cpu = get_cpu_for_node(t);
-			if (cpu >= 0) {
-				cpu_topology[cpu].package_id = package_id;
-				cpu_topology[cpu].cluster_id = cluster_id;
-				cpu_topology[cpu].core_id = core_id;
-				cpu_topology[cpu].thread_id = i;
-			} else if (cpu != -ENODEV) {
-				pr_err("%pOF: Can't get CPU for thread\n", t);
-				of_node_put(t);
-				return -EINVAL;
-			}
+		if (!t)
+			break;
+
+		leaf = false;
+		cpu = get_cpu_for_node(t);
+		if (cpu >= 0) {
+			cpu_topology[cpu].package_id = package_id;
+			cpu_topology[cpu].cluster_id = cluster_id;
+			cpu_topology[cpu].core_id = core_id;
+			cpu_topology[cpu].thread_id = i;
+		} else if (cpu != -ENODEV) {
+			pr_err("%pOF: Can't get CPU for thread\n", t);
 			of_node_put(t);
+			return -EINVAL;
 		}
+		of_node_put(t);
 		i++;
-	} while (t);
+	} while (1);
 
 	cpu = get_cpu_for_node(core);
 	if (cpu >= 0) {
@@ -599,48 +600,48 @@ static int __init parse_cluster(struct device_node *cluster, int package_id,
 	do {
 		snprintf(name, sizeof(name), "cluster%d", i);
 		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			leaf = false;
-			ret = parse_cluster(c, package_id, i, depth + 1);
-			if (depth > 0)
-				pr_warn("Topology for clusters of clusters not yet supported\n");
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
+		if (!c)
+			break;
+
+		leaf = false;
+		ret = parse_cluster(c, package_id, i, depth + 1);
+		if (depth > 0)
+			pr_warn("Topology for clusters of clusters not yet supported\n");
+		of_node_put(c);
+		if (ret != 0)
+			return ret;
 		i++;
-	} while (c);
+	} while (1);
 
 	/* Now check for cores */
 	i = 0;
 	do {
 		snprintf(name, sizeof(name), "core%d", i);
 		c = of_get_child_by_name(cluster, name);
-		if (c) {
-			has_cores = true;
-
-			if (depth == 0) {
-				pr_err("%pOF: cpu-map children should be clusters\n",
-				       c);
-				of_node_put(c);
-				return -EINVAL;
-			}
+		if (!c)
+			break;
 
-			if (leaf) {
-				ret = parse_core(c, package_id, cluster_id,
-						 core_id++);
-			} else {
-				pr_err("%pOF: Non-leaf cluster with core %s\n",
-				       cluster, name);
-				ret = -EINVAL;
-			}
+		has_cores = true;
 
+		if (depth == 0) {
+			pr_err("%pOF: cpu-map children should be clusters\n", c);
 			of_node_put(c);
-			if (ret != 0)
-				return ret;
+			return -EINVAL;
 		}
+
+		if (leaf) {
+			ret = parse_core(c, package_id, cluster_id, core_id++);
+		} else {
+			pr_err("%pOF: Non-leaf cluster with core %s\n",
+			       cluster, name);
+			ret = -EINVAL;
+		}
+
+		of_node_put(c);
+		if (ret != 0)
+			return ret;
 		i++;
-	} while (c);
+	} while (1);
 
 	if (leaf && !has_cores)
 		pr_warn("%pOF: empty cluster\n", cluster);
@@ -658,15 +659,17 @@ static int __init parse_socket(struct device_node *socket)
 	do {
 		snprintf(name, sizeof(name), "socket%d", package_id);
 		c = of_get_child_by_name(socket, name);
-		if (c) {
-			has_socket = true;
-			ret = parse_cluster(c, package_id, -1, 0);
-			of_node_put(c);
-			if (ret != 0)
-				return ret;
-		}
+		if (!c)
+			break;
+
+		has_socket = true;
+		ret = parse_cluster(c, package_id, -1, 0);
+		of_node_put(c);
+		if (ret != 0)
+			return ret;
+
 		package_id++;
-	} while (c);
+	} while (1);
 
 	if (!has_socket)
 		ret = parse_cluster(socket, 0, -1, 0);
-- 
2.34.1


