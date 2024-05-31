Return-Path: <linux-kernel+bounces-196115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA5C8D577F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEB21F22F9A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BCA1B812;
	Fri, 31 May 2024 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI26qUWy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9217C6D;
	Fri, 31 May 2024 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717117419; cv=none; b=c5Uqrt5O8wQ4jwTt/vEejbiTtU0Zjua/EEs++elnjkZOZBoosa2C2e1DFItdGFqt4r9UoyUximDTKpdxlJ6vR6HRayxNg17OIu6GpOf7s96REJPV5+TjytuYD1/vP82Vgdw3q/5N8cQTIbvuVFsiVE01EwkGv5bzAkJe/8FcVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717117419; c=relaxed/simple;
	bh=ik9ydv5c3BxcmGg8fcLt+9GYSjVnAYx1psftIjNfik4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C9VKGLiFL6AibcI4AL7ulmmUzmx7O71BIF2E9IxhAUY2QM+U7OHcVWxp+lVyZ+YBsh7DZMy9Ei8KW9vkVanVwN4yUHpyB5cvtemxIKBaedSGtWL4kHrR6LmzEihGe3TCuuoSH1etpEAQu5xwytp6aznp3I6URHjMdDUFxWnhBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI26qUWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C1BC32789;
	Fri, 31 May 2024 01:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717117419;
	bh=ik9ydv5c3BxcmGg8fcLt+9GYSjVnAYx1psftIjNfik4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NI26qUWyeeAnslPtlkblIf6qyOrCZz0WLSxyv0JKaoHOd6GJfKyPdvVaEqIRyUoOx
	 7+9oeQ2u5MRwfOjLqLqAZF+LmkHLdTTpw7e7YAterUUvA9Ek4+47WqUxFsbxpecU55
	 gjWtZ7Mq8XOA/psurUbJZMtx2MJfiE2UVCB/eFSMRpmG94vSEaGCEsE6G2raFD1JqS
	 OpQ4lZ9ugqeixo9tAaIn2I2eURVI8MULDvtu/4KuiAnBYWPg9ybZxdaXxX7T8jJKkh
	 +VCgXLChoSm93ktv3R7ZsX+WuNGojejRUfzJIQZ5u/ZuIn8RiMYvAvfGPtCu0bTrqY
	 XiDONCu5R7w3g==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 30 May 2024 20:03:29 -0500
Subject: [PATCH 3/3] of/irq: Use of_bus_n_addr_cells() to retrieve
 "#address-cells"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-dt-interrupt-map-fix-v1-3-2331d8732f08@kernel.org>
References: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
In-Reply-To: <20240530-dt-interrupt-map-fix-v1-0-2331d8732f08@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14-dev

of_irq_parse_raw() is open coding what of_bus_n_addr_cells() does, so
replace it with of_bus_n_addr_cells().

Note that the original code would use 2 cells if #address-cells was not
found. That doesn't match the default of 1 for anything but Sparc which
doesn't use this code.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/of/irq.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 462375b293e4..d81ee880a553 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -165,10 +165,10 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
-	struct device_node *ipar, *tnode, *old = NULL;
+	struct device_node *ipar, *tnode;
 	__be32 initial_match_array[MAX_PHANDLE_ARGS];
 	const __be32 *match_array = initial_match_array;
-	const __be32 *tmp, dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
+	const __be32 dummy_imask[] = { [0 ... MAX_PHANDLE_ARGS] = cpu_to_be32(~0) };
 	u32 intsize = 1, addrsize;
 	int i, rc = -EINVAL;
 
@@ -202,16 +202,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 	/* Look for this #address-cells. We have to implement the old linux
 	 * trick of looking for the parent here as some device-trees rely on it
 	 */
-	old = of_node_get(ipar);
-	do {
-		tmp = of_get_property(old, "#address-cells", NULL);
-		tnode = of_get_parent(old);
-		of_node_put(old);
-		old = tnode;
-	} while (old && tmp == NULL);
-	of_node_put(old);
-	old = NULL;
-	addrsize = (tmp == NULL) ? 2 : be32_to_cpu(*tmp);
+	addrsize = of_bus_n_addr_cells(ipar);
 
 	pr_debug(" -> addrsize=%d\n", addrsize);
 

-- 
2.43.0


