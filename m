Return-Path: <linux-kernel+bounces-196114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F98D577D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81311F22D76
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB50617554;
	Fri, 31 May 2024 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbZ2ocmr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274F1EEBA;
	Fri, 31 May 2024 01:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117418; cv=none; b=JJTX/IEmBeVqEPWkIx5+uBranSUeyvhFBnJGgnorC7dAGWTcx5Hy2lZhOWeKvo4QU3r1JAhEafX9lJCST6cKTEAxQhdoIVURLEmqWSMMMhTP30uh0rJ7EhrHRTtMEJIJ966RJmipwnTBhZW+r7rXh7+vQmXc7YttX8e0ovnSH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117418; c=relaxed/simple;
	bh=TBi8BiVNfed7a3wLohEOqAfZBAjmUXKDQITmxlZkrSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XXCBw6XTnXkHlqaPU9J7ac3PczKUrbr3vwRzcycw/fQyEa13tGzbs203k6T35NceaoNQ7W7XktFVqwxtvGmURoBZ7zBLGQFeQ25DlToBcmERhrbswRV87lo9TleSmzh3TQwUzW9ttZdioShuwLO4MXUmTQPR3Mvccump6gi7yxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbZ2ocmr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9C0C32789;
	Fri, 31 May 2024 01:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117417;
	bh=TBi8BiVNfed7a3wLohEOqAfZBAjmUXKDQITmxlZkrSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fbZ2ocmr2pO4+9KIvoZiSh2nbnmh1KrrQTtyfraADcqRxrTVQY+321sjiJHkJsrZL
	 lEJYXiARvf3jrS9etlJJcs1GFhMLaMmDTOUVEKSUxGalp68oymgdtuytqZ1Emrl8bv
	 t+gOvrZhLugtX8itN0wapYNqV5RWmQXzLBwTo30UA2j55Yr0PkARUio0wiJjsrD+BD
	 YhZujCwU+3FIJXVzIoxRPlSpNTALoGHt9sbroGr1jtUAN2NKWRnD5AULcicNKx7C81
	 DlHe1hEWP9aX5QHWq39mPupaj+BUJ4uDAdAUNm0hXj+DMq5Cp3PnBbSiV8REI5wcx1
	 rCrT4HiT5wuIg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 30 May 2024 20:03:28 -0500
Subject: [PATCH 2/3] of: Add missing locking to
 of_(bus_)?n_(size|addr)_cells()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-dt-interrupt-map-fix-v1-2-2331d8732f08@kernel.org>
References: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
In-Reply-To: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14-dev

When accessing parent/child/sibling pointers the DT spinlock needs to
be held. The of_(bus_)?n_(size|addr)_cells() functions are missing that
when walking up the parent nodes. In reality, it rarely matters as most
nodes are static.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/base.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 20603d3c9931..61fff13bbee5 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -91,8 +91,8 @@ int of_bus_n_addr_cells(struct device_node *np)
 {
 	u32 cells;
 
-	for (; np; np = np->parent)
-		if (!of_property_read_u32(np, "#address-cells", &cells))
+	for_each_parent_of_node_scoped(parent, np)
+		if (!of_property_read_u32(parent, "#address-cells", &cells))
 			return cells;
 
 	/* No #address-cells property for the root node */
@@ -101,10 +101,9 @@ int of_bus_n_addr_cells(struct device_node *np)
 
 int of_n_addr_cells(struct device_node *np)
 {
-	if (np->parent)
-		np = np->parent;
+	struct device_node *parent __free(device_node) = of_get_parent(np);
 
-	return of_bus_n_addr_cells(np);
+	return of_bus_n_addr_cells(parent);
 }
 EXPORT_SYMBOL(of_n_addr_cells);
 
@@ -112,8 +111,8 @@ int of_bus_n_size_cells(struct device_node *np)
 {
 	u32 cells;
 
-	for (; np; np = np->parent)
-		if (!of_property_read_u32(np, "#size-cells", &cells))
+	for_each_parent_of_node_scoped(parent, np)
+		if (!of_property_read_u32(parent, "#size-cells", &cells))
 			return cells;
 
 	/* No #size-cells property for the root node */
@@ -122,10 +121,9 @@ int of_bus_n_size_cells(struct device_node *np)
 
 int of_n_size_cells(struct device_node *np)
 {
-	if (np->parent)
-		np = np->parent;
+	struct device_node *parent __free(device_node) = of_get_parent(np);
 
-	return of_bus_n_size_cells(np);
+	return of_bus_n_size_cells(parent);
 }
 EXPORT_SYMBOL(of_n_size_cells);
 

-- 
2.43.0


