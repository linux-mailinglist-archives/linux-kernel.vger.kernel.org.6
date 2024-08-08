Return-Path: <linux-kernel+bounces-278938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B62A94B6D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 08:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4187C1C20F11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BA187858;
	Thu,  8 Aug 2024 06:37:24 +0000 (UTC)
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A118757C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723099044; cv=none; b=HmKE9yMDllNZigp8aJfhIVRK1uY6KOH9GsuXN1NbiQK40xPU57c+mlwuCj244YADFEjc2WDBVbExnX8G2Zi5xlY1FtWWBzv97RckjNP1aZe7NMbCfN3LChrTH3MtJFL3tmqcMyWPaBSajwxk83odfJlWBrYYpYQefznfkf+MiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723099044; c=relaxed/simple;
	bh=lWR1cBBrULhROUtGjFTJhUdql0gi9RC2aHiK6ahMmmo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dCnnZehwaOtVuq7lBosutHhR3jW2MGArhB9N2ZRmL0/CL1ieCMxMmueFQIF+QhIyutMTnhCJvt5zWQBtX13u4A3ZYgDYm8KXzT4jwyGLgun5xSGnX/CzGqt76AJzlOpXKg7H4ZmooFmWObhhB1IoDRa6c8ud4MdDuXur+1WO2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai; spf=pass smtp.mailfrom=inceptio.ai; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inceptio.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inceptio.ai
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1063868|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00221276-5.47829e-05-0.997732;FP=13169772904607972790|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=junjie.wan@inceptio.ai;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.YlWs5Rv_1723099018;
Received: from localhost.localdomain(mailfrom:junjie.wan@inceptio.ai fp:SMTPD_---.YlWs5Rv_1723099018)
          by smtp.aliyun-inc.com;
          Thu, 08 Aug 2024 14:37:10 +0800
From: Wan Junjie <junjie.wan@inceptio.ai>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bus: fsl-mc: fix GET/SET_TAILDROP command ids
Date: Thu,  8 Aug 2024 14:36:58 +0800
Message-Id: <20240808063658.2364343-1-junjie.wan@inceptio.ai>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: d67cc29e6d1f ("bus: fsl-mc: list more commands as accepted through the ioctl")

Command ids for taildrop get/set can not pass the check when
running a restool. Correct them according to the user manual.

Signed-off-by: Wan Junjie <junjie.wan@inceptio.ai>
---
 drivers/bus/fsl-mc/fsl-mc-uapi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-uapi.c
index 9c4c1395fcdb..a376ec661653 100644
--- a/drivers/bus/fsl-mc/fsl-mc-uapi.c
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -275,13 +275,13 @@ static struct fsl_mc_cmd_desc fsl_mc_accepted_cmds[] = {
 		.size = 8,
 	},
 	[DPSW_GET_TAILDROP] = {
-		.cmdid_value = 0x0A80,
+		.cmdid_value = 0x0A90,
 		.cmdid_mask = 0xFFF0,
 		.token = true,
 		.size = 14,
 	},
 	[DPSW_SET_TAILDROP] = {
-		.cmdid_value = 0x0A90,
+		.cmdid_value = 0x0A80,
 		.cmdid_mask = 0xFFF0,
 		.token = true,
 		.size = 24,
-- 
2.25.1


