Return-Path: <linux-kernel+bounces-571653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39097A6C038
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A80A07AB84D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C59922D4E1;
	Fri, 21 Mar 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RQlj3h8q";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="imyEzbi+"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD4D22CBE4;
	Fri, 21 Mar 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575198; cv=fail; b=p2BoxX15V0pJUpoV4ViljBSJnbqC9Oh0aefYuPDvLAL8ocb+UmR58YHlZk6uRKhAsaYAcpov7Go9ZtF2Onl2ClO5W4g4IX/2Y26VXpnaTUAWn/9nkobRqspy1G4nPjEEgm9NqYNP+snlQWNS8yUBrDVJVTubsOnU0W1M1BdR9rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575198; c=relaxed/simple;
	bh=u11iIfydieEEXrNHuJeYNgeICbJmVhpwCDzkc8VFeV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZgWfjz6K4QBxngFgimhDIEYUKpfL6NUM7FlcYVek4AU5oHci00WyQfONWHdwxEhwBMwiLPzHMiF4lLZRB2D3LoHefR8bUPx5aNkDxliwXhjvIP6wphU1t710300M0ItvJzIhmdDmfEX3zMQTUPo/N1z/bc2ZKwG/0aQJPEw7scI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=RQlj3h8q; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=imyEzbi+; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7jNnv019850;
	Fri, 21 Mar 2025 11:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=f477woEGjffaseZW
	3/eQnsrB+nus71tPR8ljlCWHOsM=; b=RQlj3h8qSpxojUcYmZQw5EuR4IY4Mj5f
	+b+hUj3J3ae/fN0RvWH6eho4NkHFXI6UuPSy6yujsLR+sslsZsUSOZbGHqoMMyBN
	XJRdETl+BI4/GFlNUUpS8hlxEajghZZh1V1n0k/vxwCg1+HPwlaTCJtc9AcmvqG+
	LLEGHOKmqXYoCxgl3IRA7va8bvop80WL4LZRwBNG3I6+ITXN3NemQwYoMVBZjGNu
	X6ePpp3mUcwrWcYSeYL0/yFbL5EWSeNLQURR3VgYt50NnVIFpFJVg3oT9IO90mT4
	dEo41EpM07oPtwOwOgA8zDEIZusD3bhuUIQjbFXtZfL6iRtmGCro9A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45h40m11yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 11:39:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpgB+LgQtmCKKBgk3gQNIexvJD0MIYYMFLcFt2iISf7DjB8ncBiAW7bRjUiBNIHWZZDK2NlVQt/srpGPzQGIm73HAAfyz+WrnG+EMre4qcwlm0VJpYtTeqqU4QebEGhBwerrtxfKCHid9RztVAxXtfr+qQS/cx9dsjPFowKnoKJkKZHmZwOVVaDPAJvQyg1Kr6oc3wCUcCL2FjPHWkAjpw8bG/29NiabPkcvAGOMPcp3txZC2Dw0tNYm4DU3sZU/0stNJhmE/In0ChZN3TXfdQngo+PJP9CgcL/Ox0BcBkA//lGh+qlHlAJYNgA8juGKzniASURegssH27M+868wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f477woEGjffaseZW3/eQnsrB+nus71tPR8ljlCWHOsM=;
 b=RpWUgILjpDNTnSDnbv/QKLwOJMz/k6mpMTKWi/PEtxEqxspK9XMJN7CT8wDpBW3X8UGxYe9I8Rtz+vSHe3iSRcUu/J16o0++3N0FTDWIS/qJOrF2DU4TQjCcSyEY3Fmvkh3D2jUHGFp2CGGKZGS0gpKjeP/R2Bn5ws7EjyDiS8NAueGJU5sFlCN3u7gPFffy4abYeyiB0wD3CSJCqrOiMS2TPuSup9TXV/8pTmBXWhEPoFAfO87ZJYmeBN2toQcjaqLF2CILHCoqhyS2Atex7cxUlJPi3oEbW8vtsW+HOXf2lk30EN5KhauI5FLjZ8AQ22rE36JNc6MxGBokrDTHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=temperror action=none header.from=opensource.cirrus.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f477woEGjffaseZW3/eQnsrB+nus71tPR8ljlCWHOsM=;
 b=imyEzbi+CoO5rJn2SPii8G7gtIrGtlfZSIHHd2cjaQ5QowQypjBagVWp+XgippjBEHprj+VvDtHpGjUYE0p8dtuvw5CqBXREViPrWpBmO35FXLZHcNlkXJnrrd1z4t2hbHXkGsFc0Ea1ndCTHOb5CaXO4ijQd4QTeFh2eEuis9k=
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by PH0PR19MB4892.namprd19.prod.outlook.com (2603:10b6:510:94::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 16:39:31 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e8) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Fri,
 21 Mar 2025 16:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 84.19.233.75) smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=opensource.cirrus.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cirrus.com: DNS Timeout)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 16:39:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E8D85406540;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AE296820244;
	Fri, 21 Mar 2025 16:39:28 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH 0/3] Add DAPM/ASoC helpers to create SDCA drivers
Date: Fri, 21 Mar 2025 16:39:25 +0000
Message-Id: <20250321163928.793301-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|PH0PR19MB4892:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd1da291-413a-4d30-6ce3-08dd6896f3f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2krrG8wulOvWIAA3tMtSCHKEtCu4p40ZnIofHZ4I+K3QLlWGSpKWIdIU2Dtc?=
 =?us-ascii?Q?SEI9qzmNhdP6tv+bAMMmofkX9sJ7iZxEk92/HaxMDn3Bwdegqprc3LLZ5Xf5?=
 =?us-ascii?Q?vlXxHzdscwtJAXWrFzw23RUQtUfgKFE9cY2H3lBRpg2yCS28rcuuzAKNq8jn?=
 =?us-ascii?Q?fpYHnFpvi5NNWxOQab0tAjpKSKShoy0fWaYfLLbw65uRJgw8z42DVypcsAaO?=
 =?us-ascii?Q?c/ZNO2vapFelNZX6jT6WNXQFVXj8vRsbSSd++9lhZZQCmzXK8bfbJ4Un8iZG?=
 =?us-ascii?Q?UvSgBZV8/4/skiv1M3sAhfm8ukEwy/1ZPknnJfBeIVoMmBZm6SNGCtVA2Cew?=
 =?us-ascii?Q?36ngcEW6ckG+lULRH2/2+nYFSX3GMzt0qVJerTMWsu6foLH4XL2KDurdQEFH?=
 =?us-ascii?Q?LSpztcLzVxlP7Ur+eAIBL+05JSAf0oKskpCs2DZKKhQlL8mw/8kQHBxtHCN8?=
 =?us-ascii?Q?v/hP3xRaVMkkhySjhMKHtMgLX2FiUhTrOq4jMVVgFGtxEPGyfegePIOciGf/?=
 =?us-ascii?Q?DiAICmJcyi1qlmEyHRNbKwm2C945+xvrSuzlUsT+NdLLUXvschDcsjZYnvgv?=
 =?us-ascii?Q?/NH0x2p+duZ9Y09yopZyPbWKJeYOzATdIVBQTa0bFnQSpvVaVlN50pir0Xk7?=
 =?us-ascii?Q?9tg61q47t9Ytft5RCWxnNGa7PICx74Cqq/wz1sOlEFY1ORlqMpDQpI5fGaFG?=
 =?us-ascii?Q?pbu0XQcC8Eez0k6aKbl3NRtOX4r9jpLj0ho0hOjjM3iGJ9axi4XZ5qZnPc3k?=
 =?us-ascii?Q?zB8qrm9R7dCeS9lbMxvFhnFQqAjbJMnAWZAiOS/iZx6Mm5I5g+nsNZg/gjFZ?=
 =?us-ascii?Q?STAoTaszsPDaYDmzYJarz23YOH4Yec+p2GdgvEstv1R2uO3F4sBjBQkKYbvv?=
 =?us-ascii?Q?YnWv0/nN/n91qCDEXKOgWnwoUIpBZF9i30tnDNWclXlmjSlFe+ynRdfhVg3A?=
 =?us-ascii?Q?vfx0RvlV7Pp0GlVyjm0T71JaR+bnIzW80jXAVGzXbPK+jlEgcN/CyZl2c8WB?=
 =?us-ascii?Q?ZayVEYX8cW292dkNoUsGvdp33QO2yIafzxoFhyD4KfZLP6TF2wqRZicFfoJh?=
 =?us-ascii?Q?LS6HBtGWWwvIxGjI4bDL8jIe48fCkOggllWfFXX6BCIb9VOHSRzCS7pZ7jlH?=
 =?us-ascii?Q?q7V7TmcdiVB6W7BCgCJoAjVFWNR3nv609O/IObIyvC2k5CMU0yritO3b/dKN?=
 =?us-ascii?Q?f/mJz990Fr0F51BnBJfVeJIghqOzZQ6H15R7E4GAWpN2RqVBkLmV1x6b/eB1?=
 =?us-ascii?Q?1cm09LwjmlP2vMIFlj45xWCxP/Pw3aDapf1WXKwFJsI6LYtsz4KPTVtgJLxL?=
 =?us-ascii?Q?qw/MGevmYD0ymw/BP1CgXJHM1MoJx9tqhERFxNcVbV+7TL01y4riywvD12nG?=
 =?us-ascii?Q?8ndIT4s4LG2Kuj60STNc8kSj7KN3hgFGA0LrNxUvsyXp8jJ3hKENqrqaJ6HL?=
 =?us-ascii?Q?iYbQt1c5BlzabKXVAgAaKZmyTrTABPsqAhotAzaZCvNp6IAxWz58pOE8mOve?=
 =?us-ascii?Q?7S7sPKyjzhTxJiE=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 16:39:30.1909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1da291-413a-4d30-6ce3-08dd6896f3f7
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4892
X-Proofpoint-GUID: DgchTayQSDKF96Lj9AuY-4i_BDwOWSYD
X-Authority-Analysis: v=2.4 cv=DdkXqutW c=1 sm=1 tr=0 ts=67dd9647 cx=c_pps a=gaH0ZU3udx4N2M5FeSqnRg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=hulU0MfjRZACQXYr7gAA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: DgchTayQSDKF96Lj9AuY-4i_BDwOWSYD
X-Proofpoint-Spam-Reason: safe

Add helper functions to add DAPM widgets, routes, ALSA controls,
and DAI drivers, these will be used to create SDCA function device
drivers.

This series should provide most of the core functionality needed to
get a device registered and have a working DAPM graph within the
device. There are some features that still need additional work, these
are marked with FIXMEs in the code. The two main things are SDCA
Clock Muxes (not used in our devices and needs some ASoC core work),
and better support for more complex SDCA volume control definitions
(our parts have fairly simple volumes, and SDCA has a large amount of
flexibility in how the volume control is specified).

The next steps in the process are to add helpers for the DAI ops
themselves, some IRQ handling, and firmware download. And finally we
should be able to actually add the SDCA class driver itself.

Thanks,
Charles

Charles Keepax (3):
  ASoC: SDCA: Create DAPM widgets and routes from DisCo
  ASoC: SDCA: Create ALSA controls from DisCo
  ASoC: SDCA: Create DAI drivers from DisCo

 include/sound/sdca_asoc.h     |   42 ++
 include/sound/sdca_function.h |   69 ++
 sound/soc/sdca/Makefile       |    2 +-
 sound/soc/sdca/sdca_asoc.c    | 1183 +++++++++++++++++++++++++++++++++
 4 files changed, 1295 insertions(+), 1 deletion(-)
 create mode 100644 include/sound/sdca_asoc.h
 create mode 100644 sound/soc/sdca/sdca_asoc.c

-- 
2.39.5


