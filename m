Return-Path: <linux-kernel+bounces-242393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB8192877F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBCC1C23337
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0908148FE3;
	Fri,  5 Jul 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="MeVV/q/T"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13513146A70
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720177484; cv=none; b=mzoze7iLQQAKkkHkGTr4rqz+hgrXdwLP7VQOU43kwosZH7eCjEESQXnuYRnY2JVYSJDtVNgZLGSA2zOYOErHhCq10o2nFHD2VSmIIBK6fwI+cJi5xFeinws2GhzBG76sBhH4b2NFPaP5joxlbYhBjuZo8b23XEvNEDwm0iN2ErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720177484; c=relaxed/simple;
	bh=y8qVi77ckYkW9scjpifA6YBU/+LYzRWUULo+xlhCkiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ux0QyZ5xlGfEdv5gETVx3Wi4wI+FxCalOWXywwD9jMCDOnwo2RJwh05rnaxszaNENuoKr8haap2A+vp+vtH5IFCsKC3QoYeAr1SHQ0gZyyEPzu/aj9XkbF+n8LNSIl2Lju6UG+3UuG/+c92hFSSwdLyxO/YyKe+FVkHkXAdvZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=MeVV/q/T; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 4A870100004;
	Fri,  5 Jul 2024 14:04:22 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1720177462; bh=SniJIlg0JpEI6DnXcprb6Lcp0NhWTP/XmcYBl44OhjM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MeVV/q/Tyaqa5o+A4EclpxqOtbG+uPemI9a5vSCTsDlC+SlwW9MRuLR9OwL0zvo7h
	 a968TGp6e4zW3+n7W/Ph+71k8TvS37HtlZ4aYxbXRKXdbdCRnf475GYzJ3xf+V3/d0
	 eIB9/WV+S5ns4qdbstqMxEb0HcEaHhjLUI1Ftl4p3oPZ4qxX5DBkiJpB3cPv0ugOjX
	 VUxZ23DGMhIRcr3o54wARAWuspe9aOnaG347MQlfs5cr1DSKEBFxvfx+KQpPiz0cKN
	 u7HZ+843lznW9Up87ucXEqYIkSeS995u86A8g/BzP2yP0RMuNG7D1qimgdVSrnDNd7
	 lAQE22iYKJySA==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri,  5 Jul 2024 14:03:07 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 5 Jul 2024
 14:02:47 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Martyn Welch <martyn.welch@gefanuc.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Soumya Negi <soumya.negi97@gmail.com>, Alexon
 Oliveira <alexondunkan@gmail.com>, Piro Yang <piroyangg@gmail.com>, Andi
 Shyti <andi.shyti@linux.intel.com>, "Ricardo B. Marliere"
	<ricardo@marliere.net>, Jinjie Ruan <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] staging: vme: Remove unneeded check in vme_lm_request()
Date: Fri, 5 Jul 2024 14:02:34 +0300
Message-ID: <20240705110234.14969-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186342 [Jul 05 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/05 10:17:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/07/05 03:12:00 #25860202
X-KSMG-AntiVirus-Status: Clean, skipped

In vme_lm_request() list_for_each() pointer 'lm' is compared to NULL which
is useless.

Fix this issue by removing unneeded check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 42fb503122d8 ("Staging: vme: add VME Location Monitor management mechanism")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/staging/vme_user/vme.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 0cd370ab1008..223c4d607c88 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1445,12 +1445,6 @@ struct vme_resource *vme_lm_request(struct vme_dev *vdev)
 
 	/* Loop through LM resources */
 	list_for_each_entry(lm, &bridge->lm_resources, list) {
-		if (!lm) {
-			dev_err(bridge->parent,
-				"Registered NULL Location Monitor resource\n");
-			continue;
-		}
-
 		/* Find an unlocked controller */
 		mutex_lock(&lm->mtx);
 		if (lm->locked == 0) {
-- 
2.30.2


