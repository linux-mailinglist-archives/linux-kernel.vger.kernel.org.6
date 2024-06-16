Return-Path: <linux-kernel+bounces-216228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C3E909CE6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 12:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F7FB20F24
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 10:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52921186E20;
	Sun, 16 Jun 2024 10:01:12 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id DDD7238FB9
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718532071; cv=none; b=eK7mpbDj/2IfMAygj8wRHlNHXIo6kwn2HV/wTibKAqkUCw0gYAZqNat6mXEgDlUCCQHO4ZVRgmcvivxXXksEAulCoqAX2EKho4RCpuO62BlQ27re39cXTmF7GcuomampPvzswE/Vylt/KQHND3WF6Dkyt9yApamF/a/pni6moGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718532071; c=relaxed/simple;
	bh=0473JU1BJafx5e2towRftHm+FalquHy8iAMTjhmGmQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BRjnpYaTlKiG7XF9PSuCOtl2rMJ0NFXq+lHlaY5a/5d69I6T+XM38gK7ESiPY5g+SBl2wACY+9dDEKakYdEeOEoXs9tO0SQQErIozRFIgtfkjnHiZ4xp9+8Ad+oPFt6GL6B2VWSmBBmOnqtG0tHYjZ+EiX+ISgQGgNntFRaTGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [103.163.180.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3D8EE60108B70;
	Sun, 16 Jun 2024 18:01:02 +0800 (CST)
X-MD-Sfrom: youwan@nfschina.com
X-MD-SrcIP: 103.163.180.2
From: Youwan Wang <youwan@nfschina.com>
To: lpieralisi@kernel.org
Cc: guohanjun@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	lenb@kernel.org,
	Youwan Wang <youwan@nfschina.com>
Subject: [PATCH v1] ACPI /amba: Fix meaningless code for amba_register_dummy_clk()
Date: Sun, 16 Jun 2024 18:00:54 +0800
Message-Id: <20240616100054.241482-1-youwan@nfschina.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Defining `amba_dummy_clk` as static is meaningless.

The conditional check `if (amba_dummy_clk)` is intended to
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


