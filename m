Return-Path: <linux-kernel+bounces-180350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB58C6D53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFDA1C221DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B4B15B542;
	Wed, 15 May 2024 20:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDClOATh"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0615B14E;
	Wed, 15 May 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805333; cv=none; b=aDoGSUBhGVFsmMgQpyuBga88oIcZzG37SgXctVoksmNYDzVUkjBTxbedxDactg+Z5nX5gDXETFa0LvEiugsu1w2R8ZZ9IBJJmTEw79FXgV7ZcG8mmWsjrNhd2G6rR6PdMJrbpW6/ysLkVNkE5LvXRSZRt9CzC4Sh8TdwP5o1g9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805333; c=relaxed/simple;
	bh=VbGJP2NaAz4tBqRFEIPiguZVuuL1Evp7KZQ6dB94Z3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bWOIwOyVLfjxwlkgZPXom/ZHBuFarYUqkF1lwLfZANos2BvEhfuZdOhlBe/BsKtVYqy8pCQPmuJdbVwhZxgP/zZEsX4BRCsMSgN18ueGWMb5GGRXOAp9T/6tPID0e0uUnwnttgzt5YJnjlTRU6tsyp/eR7i6NulN7QAnm2VqAQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDClOATh; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso3257313b3a.1;
        Wed, 15 May 2024 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715805331; x=1716410131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EhDrIIYuqrWkc8JCUvRQERr8uFUaepc3V2Gr+6xnLX4=;
        b=dDClOATh6LxoRt6euC9hn3ObXHpBScNM6Qhj3zA04Lq/0Dj/1P/cLca3hRCFPy8KQP
         n/5q89DZrmMws50grmEXZfy7FJ08OjM1KPiNK/O3B07IseNh1TEfj9G4CmmmryDTR0Yr
         v0KqnYSRCp7t6CVvKlublPtf7B+Z19JFsVXB/gbdqmdako4Ve5I6Ob1UVv8qwABYAwn2
         eurWwCj12GPsu3t1SwGgLnSj79f/RSN92577pP+2l/JxPKFNaZ/wtE6hHsP0bKxF9+iA
         wPfMdqc+lAGGeDkIMDkVBBQsqh0fJrBwrrcRZ7Jzz2IfIpQbXkvnoz4HYvY8QgtTqWY0
         R2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715805331; x=1716410131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhDrIIYuqrWkc8JCUvRQERr8uFUaepc3V2Gr+6xnLX4=;
        b=BM+WTbNQkqKsDceKrXrdpPZR6ytkd+n3CR8sFuSaWGTlpsL2fXifraJ+TDVAbcYRlr
         gDhLIlLXYFYziOPgOV/kLceptyyxffW0Xfuf+XMVr6kqE2lacHYbyf62kizHBM94dpuj
         GmexUXEvGE8UsjCQQUXtck52pLWU3KknONAvRjKwaTPLvWaMo2iwzaJuTYd+T0oSXHjz
         QY8cq9Rs33qG1vZ/zzbnmJ2q4dEXzbvyHHHMDoK1AkivSgMX0yu9CFgT5kicVLG+fULm
         qhzP4tm+OD9SYhbQmpwMKdvl1/LjZxgY0O81wdkPrQFiv5D7WhcpWFqShcrCGQAsfpy0
         kQaA==
X-Forwarded-Encrypted: i=1; AJvYcCUwK9B90Qdok1xFWx/V1wbfQMck9HcEaIF7HmCjUF5Da/KkB0f1UErKK6mfQ0cGBAdwkPZNlYIJTZK9t/xuPveH+sTEzwI/MbYeC9xm
X-Gm-Message-State: AOJu0YzyWT/+QVGIy4+KBCV07OfQVBzfefDF3UzjEOI2RvIYIkpBbF3n
	A4n9XjZVs1GOxD3jB8GgRTplZ4Np7NryekXm4sQpwlOxYGkAD4uf
X-Google-Smtp-Source: AGHT+IF0o6WWf6UvTgF3lWv/RBGNu8xNI5DYiRd/Nmjl4X7DaPdiPg7wEsbu3KkqXkQYPdMRaVvzdw==
X-Received: by 2002:a05:6a00:98d:b0:6f4:9fc7:d239 with SMTP id d2e1a72fcca58-6f4c9334e39mr31522883b3a.14.1715805331160;
        Wed, 15 May 2024 13:35:31 -0700 (PDT)
Received: from localhost.localdomain ([106.195.57.212])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a66691sm11892785b3a.16.2024.05.15.13.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 13:35:30 -0700 (PDT)
From: Shresth Prasad <shresthprasad7@gmail.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	julia.lawall@inria.fr,
	Shresth Prasad <shresthprasad7@gmail.com>
Subject: [PATCH][next] of: property: Remove calls to of_node_put
Date: Thu, 16 May 2024 01:59:17 +0530
Message-ID: <20240515202915.16214-3-shresthprasad7@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add __free cleanup handler to some variable initialisations, which
ensures that the resource is freed as soon as the variable goes out of
scope. Thus removing the need to manually free up the resource using
of_node_put.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
I had submitted a similar patch a couple weeks ago addressing the same 
issue, but as it turns out I wasn't thorough enough and had left a couple
instances.

I hope this isn't too big an issue.
---
 drivers/of/property.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 17b294e16c56..96a74f6a8d64 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -773,15 +773,14 @@ EXPORT_SYMBOL(of_graph_get_port_parent);
 struct device_node *of_graph_get_remote_port_parent(
 			       const struct device_node *node)
 {
-	struct device_node *np, *pp;
+	struct device_node *pp;
 
 	/* Get remote endpoint node. */
-	np = of_graph_get_remote_endpoint(node);
+	struct device_node *np __free(device_node) =
+			    of_graph_get_remote_endpoint(node);
 
 	pp = of_graph_get_port_parent(np);
 
-	of_node_put(np);
-
 	return pp;
 }
 EXPORT_SYMBOL(of_graph_get_remote_port_parent);
@@ -835,17 +834,18 @@ EXPORT_SYMBOL(of_graph_get_endpoint_count);
 struct device_node *of_graph_get_remote_node(const struct device_node *node,
 					     u32 port, u32 endpoint)
 {
-	struct device_node *endpoint_node, *remote;
+	struct device_node *endpoint_node __free(device_node) =
+			    of_graph_get_endpoint_by_regs(node, port, endpoint);
+
+	struct device_node *remote __free(device_node) =
+			    of_graph_get_remote_port_parent(endpoint_node);
 
-	endpoint_node = of_graph_get_endpoint_by_regs(node, port, endpoint);
 	if (!endpoint_node) {
 		pr_debug("no valid endpoint (%d, %d) for node %pOF\n",
 			 port, endpoint, node);
 		return NULL;
 	}
 
-	remote = of_graph_get_remote_port_parent(endpoint_node);
-	of_node_put(endpoint_node);
 	if (!remote) {
 		pr_debug("no valid remote node\n");
 		return NULL;
@@ -853,7 +853,6 @@ struct device_node *of_graph_get_remote_node(const struct device_node *node,
 
 	if (!of_device_is_available(remote)) {
 		pr_debug("not available for remote node\n");
-		of_node_put(remote);
 		return NULL;
 	}
 
@@ -1064,19 +1063,15 @@ static void of_link_to_phandle(struct device_node *con_np,
 			      struct device_node *sup_np,
 			      u8 flags)
 {
-	struct device_node *tmp_np = of_node_get(sup_np);
+	struct device_node *tmp_np __free(device_node) = of_node_get(sup_np);
 
 	/* Check that sup_np and its ancestors are available. */
 	while (tmp_np) {
-		if (of_fwnode_handle(tmp_np)->dev) {
-			of_node_put(tmp_np);
+		if (of_fwnode_handle(tmp_np)->dev)
 			break;
-		}
 
-		if (!of_device_is_available(tmp_np)) {
-			of_node_put(tmp_np);
+		if (!of_device_is_available(tmp_np))
 			return;
-		}
 
 		tmp_np = of_get_next_parent(tmp_np);
 	}
-- 
2.45.1


