Return-Path: <linux-kernel+bounces-550559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF383A5611B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A41A1894AA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 06:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2754719DFB4;
	Fri,  7 Mar 2025 06:47:28 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7391922C6;
	Fri,  7 Mar 2025 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330047; cv=none; b=b0W2s30DVako/ix3oIwX2Nzw6yDJ8AjAG/6gKtAMJh95pbW8d3G9SzuSEV3FqBjYEUfyYcSgG0oWv8Dg3ENUCjFJQJuVmAmhB//nwpqA33XdbTaX+542M9VTqJmtr09Fa7KqghAJ1GndMnpZz0tRJmQgL412e3PZDNtkJ9124QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330047; c=relaxed/simple;
	bh=eO668JLCfJpEysgWJQQjSXlLFojaqRfazrBWsM4cyNk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TgsAi9U1YzXrWDQGFmx6Ho77GvVktZJ4lsO5Zy0C9Y1a2FkT/KOOqsLrOsRsvnMFKUqgzlYq1Dgf8TEVT1GwE3B3pGFRXz2QHOG6jEJtIV6jJgbod4okC/JaozK62OWUGfp7v8jgOZY9bUs5zk9fugzxdxpSnp0rEj7NDpREviA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from jtjnmail201605.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503071447099282;
        Fri, 07 Mar 2025 14:47:09 +0800
Received: from locahost.localdomain (10.94.18.189) by
 jtjnmail201605.home.langchao.com (10.100.2.5) with Microsoft SMTP Server id
 15.1.2507.39; Fri, 7 Mar 2025 14:47:10 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>, <duje.mihanovic@skole.hr>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Charles Han
	<hanchunchao@inspur.com>
Subject: [PATCH] clk: mmp: Fix NULL vs IS_ERR() check
Date: Fri, 7 Mar 2025 14:47:07 +0800
Message-ID: <20250307064708.209511-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
tUid: 2025307144709e6bed258d99392093fb99a7af2477bb7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The devm_kzalloc() function returns NULL on error, not error pointers.
Fix the check.

Fixes: 03437e857b0a ("clk: mmp: Add Marvell PXA1908 APMU driver")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 drivers/clk/mmp/clk-pxa1908-apmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-pxa1908-apmu.c b/drivers/clk/mmp/clk-pxa1908-apmu.c
index 8cfb1258202f..d3a070687fc5 100644
--- a/drivers/clk/mmp/clk-pxa1908-apmu.c
+++ b/drivers/clk/mmp/clk-pxa1908-apmu.c
@@ -87,8 +87,8 @@ static int pxa1908_apmu_probe(struct platform_device *pdev)
 	struct pxa1908_clk_unit *pxa_unit;
 
 	pxa_unit = devm_kzalloc(&pdev->dev, sizeof(*pxa_unit), GFP_KERNEL);
-	if (IS_ERR(pxa_unit))
-		return PTR_ERR(pxa_unit);
+	if (!pxa_unit)
+		return -ENOMEM;
 
 	pxa_unit->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pxa_unit->base))
-- 
2.43.0


