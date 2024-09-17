Return-Path: <linux-kernel+bounces-331963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC3D97B378
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D851F24083
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1F61922C7;
	Tue, 17 Sep 2024 17:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gjg/VqjV"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3568248C
	for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2024 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726593424; cv=none; b=bHo9W+GpOx5rK/LC6CjpXiYzg6pAM5wpo+dHe/hI4OrQ2zOrbe+ZH3vpOlIfrXAmmAuoL/r3BFqPzgt2obhfkKQS/bl+Bfo+cbgU/pMOG1P6Kxspuuht1hHKtQB1ymyAP0DdfQuTJM94R1Iqq/40eQLKDrD+/8uKuiUpC80JSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726593424; c=relaxed/simple;
	bh=4OTQw0h9H/yoof5Xg5qCdnpWj75jxgcB/HR/anjpiMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE+Tm+5DAY+m3H/ICdh/ljsswqspBYtuutg1pDinqSCzERZHLJMl0uPxSGMlkJhX5NuptVa3CAMDkp8v+AU2YpoOWPbPOReb6YcUytVmzVX3pwwweCdUsTxoBQMHZGp9+T2n4ggLdZKKuCxg6mbh/71OSqrizuFdhDlwmk18Ttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gjg/VqjV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HAZ2gf022504;
	Tue, 17 Sep 2024 17:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=4CA/GbBpZcW7x
	BCC/dhWueIg7omYTIpwTZqviEF8mh8=; b=gjg/VqjVSivIFuRjdhzA/L0+AQHtO
	8MerM7lIlKIZoiiq/xa5c48cNxBH+ySYFQDC66YOBG2iqRa03YzUPsFYrzETyxIS
	2DY2FxNLMDp3mCX0PNjrTM7tzqfH6aT3DIGeJ1aRZ/uJxN+R2MFBNlBMpzBHTxhf
	gAEHhcqExPgOG9wpcXAKJRxfgWDNEM1cXYR95Ib4lQVSJ9t69FEy+J1JSgRCpfXA
	KkqK08tSVO4jpo+d1XiOxqGbA9MKomjHr+gfsiYu/HeeC2f+LjRbfDOt60ceno0L
	qZCFFfNTqb8hePbgkAynW+lDi40kJsiCn/0p0E258LKz9TZnk7N/fjxUg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3ud9hgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48HG0bdj000765;
	Tue, 17 Sep 2024 17:16:50 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntq6erm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 17:16:50 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48HHGmdD27263696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Sep 2024 17:16:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBBB758065;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E84C58061;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.93.228])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Sep 2024 17:16:48 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@codeconstruct.com.au, eajames@linux.ibm.com,
        ninad@linux.ibm.com
Subject: [PATCH 04/15] fsi: core: Use a defined value for default echo delay
Date: Tue, 17 Sep 2024 12:16:36 -0500
Message-ID: <20240917171647.1403910-5-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240917171647.1403910-1-eajames@linux.ibm.com>
References: <20240917171647.1403910-1-eajames@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uj8m_XFtxUkVY3lRHQytmOS2vYWE4KD1
X-Proofpoint-ORIG-GUID: uj8m_XFtxUkVY3lRHQytmOS2vYWE4KD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409170122

Avoid hardcoding '16' several times.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-core.c  | 6 +++---
 drivers/fsi/fsi-slave.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
index 788b721a7d60..3ddf518c6a19 100644
--- a/drivers/fsi/fsi-core.c
+++ b/drivers/fsi/fsi-core.c
@@ -1008,8 +1008,8 @@ static int fsi_slave_init(struct fsi_master *master, int link, uint8_t id)
 	slave->link = link;
 	slave->id = id;
 	slave->size = FSI_SLAVE_SIZE_23b;
-	slave->t_send_delay = 16;
-	slave->t_echo_delay = 16;
+	slave->t_send_delay = FSI_SMODE_SD_DEFAULT;
+	slave->t_echo_delay = FSI_SMODE_ED_DEFAULT;
 
 	/* Get chip ID if any */
 	slave->chip_id = -1;
@@ -1160,7 +1160,7 @@ static int fsi_master_break(struct fsi_master *master, int link)
 	if (master->send_break)
 		rc = master->send_break(master, link);
 	if (master->link_config)
-		master->link_config(master, link, 16, 16);
+		master->link_config(master, link, FSI_SMODE_SD_DEFAULT, FSI_SMODE_ED_DEFAULT);
 
 	return rc;
 }
diff --git a/drivers/fsi/fsi-slave.h b/drivers/fsi/fsi-slave.h
index f6cca04131a9..45190b06fa02 100644
--- a/drivers/fsi/fsi-slave.h
+++ b/drivers/fsi/fsi-slave.h
@@ -42,8 +42,10 @@
 #define FSI_SMODE_SID_BREAK	3		/* ID after break command */
 #define FSI_SMODE_ED_SHIFT	20		/* Echo delay shift */
 #define FSI_SMODE_ED_MASK	0xf		/* Echo delay mask */
+#define FSI_SMODE_ED_DEFAULT	 16		/* Default echo delay */
 #define FSI_SMODE_SD_SHIFT	16		/* Send delay shift */
 #define FSI_SMODE_SD_MASK	0xf		/* Send delay mask */
+#define FSI_SMODE_SD_DEFAULT	 16		/* Default send delay */
 #define FSI_SMODE_LBCRR_SHIFT	8		/* Clk ratio shift */
 #define FSI_SMODE_LBCRR_MASK	0xf		/* Clk ratio mask */
 
-- 
2.43.0


