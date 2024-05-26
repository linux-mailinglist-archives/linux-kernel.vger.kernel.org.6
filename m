Return-Path: <linux-kernel+bounces-189619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80C8CF2F8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040121C21171
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0737A8F55;
	Sun, 26 May 2024 09:14:01 +0000 (UTC)
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFDC127
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716714840; cv=none; b=Z+5ylQ1Qs2jMr808ilSJ0/GWFb6IlyKwHJDzPVl+hRWTVO/HnqSI9T2ZvXQbQcb3dyk2A0WM5aDqKRc84zhFPe0m/n3LrB146apCQwrrGdYOTFAEsvC3bGvMNWFpqgXXk4lK28kYnpZ8En76Q+17Tla+6OmPO9bhz8pc/JvDGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716714840; c=relaxed/simple;
	bh=C8JQotXcCEh+n6ZOa/LrEKqVY+A0QN/hL4MpagrOa58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLPeAwVVOdCvbBCBr0mdw7E7U/N7ad6Avv5qYSmWJEc9wojLySVDcuDmezzobclCdGWYVWzerUYeFvLaYV3Vc31GIpVLxvLa+4qRuxA4KE8EbOoSSTzB6BZu+mzYVVBLLiROgE7b0+gW9IEvF5FTK3gM+Y3rxDbOkd1KzZrtdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bupt.edu.cn; spf=pass smtp.mailfrom=bupt.edu.cn; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bupt.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bupt.edu.cn
X-QQ-mid: bizesmtpsz3t1716714709t2lavnv
X-QQ-Originating-IP: 4jd4VgiZHqDRJBPef916JUc5sCSVYoGPF/ZanX1vCnI=
Received: from localhost.localdomain ( [106.39.130.126])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 26 May 2024 17:11:47 +0800 (CST)
X-QQ-SSF: 01400000000000B0H000000A0000000
X-QQ-FEAT: sIC5bdVBDEwH+6QNlD20XNhiR0sE1y7zhYDTJD7e88qY2LueeJzpoIrSNSdLB
	xGp2iKqNd2uRvg06G0ks53lNQmja/i5NLX+bfMIKkm/FyWtV3XmPZWCG/nepqzuRagw41rd
	1c8A1vJIbawL5dpSk/DjeAO6PPszWD8t+fNzPeZq/2iDaX4HlSonczmaURfFnMX5YPibyaO
	yYgxcUUIaTMZptOkUBDUM3BVPuemDiA75v6YcxDR9z1fhY/wEMgV+GCuP1vs+AxpeUtvbXN
	dYllxgwehG5h1NcsG7x38bhgEJKPzyBpYVWajWOVYABhQ3Xwcr4JMP/ruEHJ+DTA4KUDM1s
	dvjk1kxoNWpbNVkrP3OeVxGpH4rhxsRncAZhrhyeXk3EU/7jUjryX9OLLQMyhh9c/xn8FXT
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 4278875160939651111
From: nova@bupt.edu.cn
To: linux-kernel@vger.kernel.org
Cc: rafael@kernel.org,
	lenb@kernel.org,
	MuelNova <n@ova.moe>
Subject: [PATCH] ACPI: resource: Do IRQ override on MECHREVO Yilong15 Series GM5HG0A
Date: Sun, 26 May 2024 17:11:25 +0800
Message-ID: <198DF8EDEF8996EE+20240526091125.43899-1-nova@bupt.edu.cn>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:bupt.edu.cn:qybglogicsvrgz:qybglogicsvrgz7a-0

From: MuelNova <n@ova.moe>

MECHREVO Yilong15 Serie has a DSDT table that describes IRQ 1 as ActiveLow
while the kernel is overriding it to Edge_High. This prevents the internal
keyboard from working. This patch prevents this issue by adding this laptop
to the override table that prevents the kernel from overriding this IRQ

Signed-off-by: MuelNova <n@ova.moe>
---
 drivers/acpi/resource.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index b5bf8b81a..fed3c5e1b 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -540,6 +540,12 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
  * to have a working keyboard.
  */
 static const struct dmi_system_id irq1_edge_low_force_override[] = {
+	{
+		/* MECHREVO Yilong15 Series GM5HG0A */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5HG0A"),
+		},
+	},
 	{
 		/* XMG APEX 17 (M23) */
 		.matches = {
-- 
2.45.1


