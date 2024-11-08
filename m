Return-Path: <linux-kernel+bounces-402268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC889C25A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C85051C22A78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED871AA1E9;
	Fri,  8 Nov 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtbpW1AJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE6A15C0;
	Fri,  8 Nov 2024 19:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094668; cv=none; b=elwwwhl1NaC8VI63oSt+87T9nOY7tn9ZuBomav6UpbD+NevjhzGNQDUjk68uujuAzWA5oZ5a5NlJtT3FwJMhi0geMt+E50Od6aIhk/2qSExrqZ7ZA11gBumJrhG5X8R0PUnBABvzG0i65vVIGb9TSI65/OajRVmy0sQUogdjKPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094668; c=relaxed/simple;
	bh=beJdDC1LOLBDQ38ZZ8eQVeZ1R6yOokwQEBTUvMo8XDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/KvuAEKF7g4k4/rvCmx/DQHA/UH4EK7k13rYWTI5vAk3lJdmpIiE58ZaWYO8PJ4CvJpXyheZXKaP21denC2/drHFoHtqPjqXgzgVjk+BTZfBjEQl1dMQ68w4gjTMGCX331EvDT+B/oP2+VdxM7rLiLlKYz8WIMRC6Yc5Dz+WyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtbpW1AJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B6FC4CECD;
	Fri,  8 Nov 2024 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731094667;
	bh=beJdDC1LOLBDQ38ZZ8eQVeZ1R6yOokwQEBTUvMo8XDU=;
	h=From:To:Cc:Subject:Date:From;
	b=rtbpW1AJ8rh9mt673tzNxfOB+NumOLS21SUxGtfMWyDM4rO1KPoNSlHNCfN7g43bM
	 mYubRKTKzUMnzsjUqGMnRFhC55wH5gI6MNinFWt3ucL7guPB6x3CoAVgpGLrQ88AL1
	 oDYrUScHn+PvOa8Uyw07V8hyzwKzISiT6YE3zNBUtwb4H2WWIw1ATCV5LBsGFi2KIN
	 n0DXcXLyRNfV2ZwwTSyWWMX5YxotgftBBIOSABLYWmK8OHAGpS74KFHxiweAiPZaLH
	 FbhrNAsLm093octeqf1VtWknBkvziL/O9nNMJeSUQlK2ZgrOnqaWBiSkfqaKXs9bAB
	 sEAvdPwY489nA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Steven Price <steven.price@arm.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] of/address: Rework bus matching to avoid warnings
Date: Fri,  8 Nov 2024 13:35:48 -0600
Message-ID: <20241108193547.2647986-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With warnings added for deprecated #address-cells/#size-cells handling,
the DT address handling code causes warnings when used on nodes with no
address. This happens frequently with calls to of_platform_populate() as
it is perfectly acceptable to have devices without a 'reg' property. The
desired behavior is to just silently return an error when retrieving an
address.

The warnings can be avoided by checking for "#address-cells" presence
first and checking for an address property before fetching
"#address-cells" and "#size-cells".

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Steven Price <steven.price@arm.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Here's a proper patch for the record. Going into my next branch now.

 drivers/of/address.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 824bb449e007..c5b925ac469f 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -333,7 +333,11 @@ static unsigned int of_bus_isa_get_flags(const __be32 *addr)
 
 static int of_bus_default_flags_match(struct device_node *np)
 {
-	return of_bus_n_addr_cells(np) == 3;
+	/*
+	 * Check for presence first since of_bus_n_addr_cells() will warn when
+	 * walking parent nodes.
+	 */
+	return of_property_present(np, "#address-cells") && (of_bus_n_addr_cells(np) == 3);
 }
 
 /*
@@ -701,16 +705,16 @@ const __be32 *__of_get_address(struct device_node *dev, int index, int bar_no,
 	if (strcmp(bus->name, "pci") && (bar_no >= 0))
 		return NULL;
 
-	bus->count_cells(dev, &na, &ns);
-	if (!OF_CHECK_ADDR_COUNT(na))
-		return NULL;
-
 	/* Get "reg" or "assigned-addresses" property */
 	prop = of_get_property(dev, bus->addresses, &psize);
 	if (prop == NULL)
 		return NULL;
 	psize /= 4;
 
+	bus->count_cells(dev, &na, &ns);
+	if (!OF_CHECK_ADDR_COUNT(na))
+		return NULL;
+
 	onesize = na + ns;
 	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++) {
 		u32 val = be32_to_cpu(prop[0]);
-- 
2.45.2


