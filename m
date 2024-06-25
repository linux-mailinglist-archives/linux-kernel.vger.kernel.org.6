Return-Path: <linux-kernel+bounces-228654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E490B9164B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A364B27115
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EA4149C58;
	Tue, 25 Jun 2024 10:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="svWpGbYv"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675496CDBA
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309610; cv=none; b=GRvjcNVMWUADJETr9c3W0nVnhqye2a+dZRChNXfuxwHtpgXJ6K35jp9MhfWapy/6RAAIw6k4889Ty7809aPJMh14h3X0XHR4Wz2mhTDaHz6ZgtA8LlzOVQ2t5D34agJ31GbqDAAJ+n+403i6Bub1s7h+K/MAszsxadaIcGcHatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309610; c=relaxed/simple;
	bh=4zszA4SMVIv54uYFhTaWLecq7Lh3LgTqqijXzXbP+F0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoNGRBGZwBOVOkpGYnB0ogsexFognVFk2qe4FvxHfNCoHZP24/bltZdMeZz+R2fTQeRHsOM/3iLTMQsxew5NicpAfRJgcHgCHyUMpd60sNeMy1H57HF6qI8Sqmk9btG51U+Sdk3wgmSdzmOaeghiaZovs7m46YaHBpNoWjlKKXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=svWpGbYv; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id D079B100002;
	Tue, 25 Jun 2024 12:59:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1719309581; bh=OkwuqtpjtxnHwZ9UlQkDEX+6wrYJn7SyMmyp+k1tLtA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=svWpGbYvqpA3xSHGIb3jmR6ZXenCNyfEdf3QtE3UjUWooXBultzXB4PmWY+2UbBl3
	 qQLg2mJyOiqo2LNMGuUt+yhVNx8tWiCCFBFaX5iLVlYHpYeqklDnZ3s7JvrxBUy4M/
	 mCe+CnORTRK8Xx1W+10nMdriDxmaggadAghhYoJ1bUCSaknwxCZ68txIHjeIjIGoA2
	 TlvPVv+k7ACPs9s3dAfeyCTZKUQhgx6+JC5hXQRrfjLkC1k1fSUk8g+RsZ5teilnx2
	 wX2oeub6IEyNBP3WjsfC1FvZ5stlScSxKuHmOPd76GpzicLETuxUyo2tnOj/MaP78Y
	 kPQzUUn9Eh77A==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 25 Jun 2024 12:58:50 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.5) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 12:58:30 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Martyn Welch <martyn.welch@gefanuc.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Soumya Negi <soumya.negi97@gmail.com>, Michael
 Straube <straube.linux@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-staging@lists.linux.dev>, <lvc-project@linuxtesting.org>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2] staging: vme_user: Validate geoid value used for VME window address
Date: Tue, 25 Jun 2024 12:58:04 +0300
Message-ID: <20240625095804.11336-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <9ccf4b68-acd0-465b-a5dd-4aa4569da9ce@suswa.mountain>
References: 
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
X-KSMG-AntiSpam-Lua-Profiles: 186120 [Jun 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1;indico.cern.ch:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/25 02:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/06/25 09:11:00 #25697028
X-KSMG-AntiVirus-Status: Clean, skipped

The address of VME window is either set by jumpers (VME64) or derived from
the slot number (geographical addressing, VME64x) with the formula:
address = slot# * 0x80000
https://indico.cern.ch/event/68278/contributions/1234555/attachments/
1024465/1458672/VMEbus.pdf

slot# value can be set from module parameter 'geoid' which can contain any
value. In this case the value of an arithmetic expression 'slot# * 0x80000'
is a subject to overflow because its operands are not cast to a larger data
type before performing arithmetic.

Validate the provided geoid value using the Geographic Addr Mask.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d22b8ed9a3b0 ("Staging: vme: add Tundra TSI148 VME-PCI Bridge driver")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
v1->v2: Move geoid validation to the probe() function as suggested by Dan

 drivers/staging/vme_user/vme_tsi148.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2ec9c2904404..e7fcbc3f4348 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2448,12 +2448,17 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	data = ioread32be(tsi148_device->base + TSI148_LCSR_VSTAT);
 	dev_info(&pdev->dev, "Board is%s the VME system controller\n",
 		(data & TSI148_LCSR_VSTAT_SCONS) ? "" : " not");
-	if (!geoid)
+	if (!geoid) {
 		dev_info(&pdev->dev, "VME geographical address is %d\n",
 			data & TSI148_LCSR_VSTAT_GA_M);
-	else
+	} else if (geoid & ~TSI148_LCSR_VSTAT_GA_M) {
+		dev_err(&pdev->dev, "VME geographical address is out of range\n");
+		retval = -EINVAL;
+		goto err_crcsr;
+	} else {
 		dev_info(&pdev->dev, "VME geographical address is set to %d\n",
 			geoid);
+	}
 
 	dev_info(&pdev->dev, "VME Write and flush and error check is %s\n",
 		err_chk ? "enabled" : "disabled");
-- 
2.30.2


