Return-Path: <linux-kernel+bounces-206495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C071F900A8E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AAEB22258
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA019B59B;
	Fri,  7 Jun 2024 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhb/g4TH"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606A19007A
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717778039; cv=none; b=JD19MlMzDxyFsVvveA/3UGGGrIKfEkWrKqlmHdoSLk4wnM8I0Oy/qxiiwn+PIdSqccePRucT/B1iJtGo85Goj4W9DrIEya9CY+smDZEtNU2NySLFtG16VNpsicmW0K8vzGNMJHj2EEA/Q+ZRysrb8jZ1UogWNHJiZzsO1dY8tTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717778039; c=relaxed/simple;
	bh=BNC1Z95f8uiQ8K8aPXBGm6Vdmian+P1RGAxtQhFOi80=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PMO5wUStQ7yQ+Gy8IJLygYxSZnnma1XEwOio9hKm3BT/lX8ltaspgrNbqC8Dt5Lud/v2uMhtdEuQqDEPq4zH8xcpO5lacFI8Qb++Bq/3cdIHXGDkpfkiPGrVMbVfjJDeVY7E7IT5R73/3AytVp9u3AQL8rssBsQ7iLn6tnsdTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhb/g4TH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eaa80cb573so26993541fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717778036; x=1718382836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ktuw6zxI+M+O56fZozxk8JtRul2b0L3ekJGX5mYuYns=;
        b=nhb/g4THEEwG08LYa6YucV78tVjnA3PhXnDHqT+TTcX+DRo2gcYm5Kl0NQlNemRP0S
         f+yR6+tp/ZZFgOzK4gM7ieOAYnPuBj+3NwEFt7TFnFEDaGWbw/RgZe5BxNdrWbwiQDf+
         MSRnEGVGd+BhSdYKhlMX3uI78bM9GQRie9DLXAL8KBl2uQBcSYGWQIbNVp/KlnAQXss+
         mDPnhF9Ggv5j/lmXBOPwfGvZnL4V6jQZlAAR4TH6I0V3UhuoZ5bHcHPRkE/Bh8IKTEYs
         jSa6f0fPAgU4B5TIiAtMLPZSIZjReTU4a2CYNL+2eiyKEhNP+2x/PVArbk+MYozUqptI
         pzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717778036; x=1718382836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ktuw6zxI+M+O56fZozxk8JtRul2b0L3ekJGX5mYuYns=;
        b=bST3xy1pSb7v6y2oR8wTJAja+ubNRXuAuyRsOy9eSeApnTishf9n1sIHFZ4PCPSn1V
         R32uddmcUSTF6S1dfiIDXs4pfy7zL3pZrobvAKuddGL4F3nAi0s2YXXb/g83jHXf2i7B
         esr/HTwTq+HvxbEW7ilv/LtkKZrxWoXkDkp2dqZa0nRocKIdduMmsLCPAecZ8a7BfX42
         l7HZ2cpON1LPvBKo/mgLWmbd+wa9VRbLknLBUaguFa++gWWWJFPga0eXS5467HVYbwcL
         8jYJoDG0enimr8CL7eziUhiXYspeDFJuK/uDIYpcrsxSHkGsNbZcTdjQEyUZnuDPPsL+
         aefQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5lgnmOcE2rkOTdHiMro6BCbOGNoXYFj+FT4Xz+BMIRO920Hk2oEViv5KS/885W8ZuX5ZMrBGQkTcb+l7YTw8f5WKL6vnbAom2jrZ5
X-Gm-Message-State: AOJu0YyVA2PJXx92YUiv4WZKCM0FMl46/OX7ERaWGO82gL+gGhdQ+J0o
	KOsBEOt21mRP20ryO6sZhnJL8rmvnJ47tWwZTti3+lkWmv+UPYug
X-Google-Smtp-Source: AGHT+IEOYrqwvr0uEqyvOCJYjOz3auyroh/ag3BaxTAiF5HPtxeqBq73ZOyZ01c275WEGA5c+e21lA==
X-Received: by 2002:a2e:a443:0:b0:2e9:768a:12ae with SMTP id 38308e7fff4ca-2eadce33be3mr19533271fa.22.1717778035376;
        Fri, 07 Jun 2024 09:33:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:ac9:e686:17a2:25c2:1b0c:3c07])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae0cc355sm3032715a12.33.2024.06.07.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 09:33:54 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	sudeep.holla@arm.com
Cc: vincenzo.mezzela@gmail.com,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH 1/2 v4 RESEND] drivers: arch_topology: Refactor do-while loops
Date: Fri,  7 Jun 2024 18:33:49 +0200
Message-Id: <20240607163350.392971-2-vincenzo.mezzela@gmail.com>
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

Refactor do-while loops to move break condition within the loop's scope.
This modification is in preparation to move the declaration of the
device_node directly within the loop and take advantage of the automatic
cleanup feature provided by the __free(device_node) attribute.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 drivers/base/arch_topology.c | 107 ++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index c66d070207a0..583f11bd4d2e 100644
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


