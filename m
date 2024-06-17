Return-Path: <linux-kernel+bounces-216551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBEC90A0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED21B21032
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 00:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FF29B0;
	Mon, 17 Jun 2024 00:51:11 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id A0C5C256A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718585471; cv=none; b=EsR0qQW756+z90ovmn97yE9lGickhUUflqWBsaSUnxcZd70nypGC2Os/mVk4X/6Jw5aiqJ70BnbbBZFc3nS61pOu9Q2Y9+rFYVP12sourhslhOjsfV0RtUXoNV/aU65sshWWkzhfQTBdpSx85DK1ITi5FYkir1dv6/g+Tzffky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718585471; c=relaxed/simple;
	bh=OFgcxovlRvwpT0CwjE+H4bQT2gq+ajV5CRw3gfHR+/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oO3UlqhVkLEb7nWiYpzqZiyJOcFJuMX95bzPV6RaKrEtV6CSzsR/LGY1TCvht0g2Pz5Ks4bM/1t3AI3J/t1ULl3FDElmE8OkfpteLr9bey/HX8uZvy+JZviGDnCaYfNdzvJB87/oxSuJi+E4NHbEq+KMBwnjT0Bjg24xNubhFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id E8D2260105B20;
	Mon, 17 Jun 2024 08:50:53 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: christophe.jaillet@wanadoo.fr
Cc: guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lenb@kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [PATCH v2] ACPI /amba: Fix meaningless code for amba_register_dummy_clk()
Date: Mon, 17 Jun 2024 08:50:44 +0800
Message-Id: <20240617005044.246077-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defining `amba_dummy_clk` as static is meaningless.

The amba_register_dummy_clk() function is static and
is called during initialization. I think 'amba_dummy_clk'
should be NULL each time when initializing

Signed-off-by: Youwan Wang <youwan@nfschina.com>
---
 drivers/acpi/arm64/amba.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 60be8ee1dbdc..ef438417cc80 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -35,11 +35,7 @@ static const struct acpi_device_id amba_id_list[] = {
 
 static void amba_register_dummy_clk(void)
 {
-	static struct clk *amba_dummy_clk;
-
-	/* If clock already registered */
-	if (amba_dummy_clk)
-		return;
+	struct clk *amba_dummy_clk;
 
 	amba_dummy_clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, 0, 0);
 	clk_register_clkdev(amba_dummy_clk, "apb_pclk", NULL);
-- 
2.25.1


