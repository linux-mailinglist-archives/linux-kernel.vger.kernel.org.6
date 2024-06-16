Return-Path: <linux-kernel+bounces-216218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32481909CD0
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEA11F214DE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8140E181D03;
	Sun, 16 Jun 2024 09:41:07 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9D59514AB8
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718530867; cv=none; b=ObdZnhSBnwZLbs6YPxxXoa5ZGHt4cNn25O/lUajMUD5uwF3AGlGy5pmxrlfNbkOHLN9qcrD4KSGdfib5evL/Yh4DU6IszE/ObZ8aLubgdxaEp7KoPvu989cyPGeUfTOl8tRsu5+TgBS7WsdY0eRHVe/96CPCbV9POHYVPIJulEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718530867; c=relaxed/simple;
	bh=oCq+SJ4lWxy4rpGjjqT+JfsguC2fKR1voEqDbeeCREs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4cVZjXHOu7m6FjMB9XwjwKDTC5uw+/3nPfDsFaZzpLvzmmcLeyBqK2+Px69RHukBe8l1IKK3x5lvj12msMFqEbbAbrIbwB0KF2XDlEp267kOxH4lYBPHJVvT5GldcwltqRwH4rjh39tzwaKyfpbaCJZKGR7lS8r6iZjD6fbhTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 1782360108551;
	Sun, 16 Jun 2024 17:40:39 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: lpieralisi@kernel.org
Cc: guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lenb@kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [PATCH] ACPI /amba: Fix meaningless code for amba_register_dummy_clk()
Date: Sun, 16 Jun 2024 17:40:30 +0800
Message-Id: <20240616094030.239860-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defining `amba_dummy_clk` as static is meaningless.

Theconditional check `if (amba_dummy_clk)` is intended to
determine whether the clock has already been registered.
However,in this function, the variable `amba_dummy_clk`
will always be NULL.

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


