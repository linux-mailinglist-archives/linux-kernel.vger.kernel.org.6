Return-Path: <linux-kernel+bounces-559726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721CFA5F891
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 078D44218F7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCF52686B0;
	Thu, 13 Mar 2025 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="HCVI4BmP"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BE125FA25
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876598; cv=fail; b=sy9hDNkxJMNHBvmLxYvcgWpeWe3ixfEzQLxiqK63DbDfU/ODDXA0qt1V3ms6cHxgA67L9dPPI3yFcTWiAAphnkd45y21VVneGTNcMJ9bpodTrVg39GaHtvqc1eVrVCcnY1D4MthnOd/zTefZs4QstGk1FWU65zx14+Nv0SKuVcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876598; c=relaxed/simple;
	bh=89jEjtGfo67g6FNtG9Z9dVy+pejGaTR49wk2jnBg9w8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=buoPn7t+kQByy3o65DDtSAGFjopqnvyZQ7BYTuYRIcc8c2CqyEtLDMBOJkWe/eeyX8g1pbzKi575G/4ztVK9lJ4wS4dhjnSfObRlQOxcms0FqePsjIYAAofeQ8X953LC/hUQ1RIpTAWbj8Am+pshYk7b309DPL4U/2JH8ZD1O24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=HCVI4BmP; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUZXEnmwhx/IG/Cren3KZPhMgE8WZbKYjpemnphFp4sH4HCaOe9CuiLpeJd5mol1GR5no7WAegnAnoC9H2XwsvQD9VS4MQgcJXknkqObYqwZGV6xdqq4IUIiqu/mIJ103HGnJ0YCw2DiRumqfj7Ce9II62ScE9qvHibrwT6tb3qmcFknm4trU0peSarcqQUKzbJPhPi+vpKl9NSudarPGt/PRtBqk6WyCzxta51byCUqcky5eLixEQlFSk7F/T/ukPpVJ093Db3fl/uWh2jjfbC3+yaIEqesDI9X34gwnQbScqDKA5ko9Qwtc9BP05PgJgN2NAOCO2B1eo1SC+41Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xngPVxr2MxMdXucQSY0euHk0TTBBOgseOjN/U9ucs0=;
 b=A9bQDXi/fOtf6PQhgQ0ehFC4SVIzV8FqVETsB456nhxcQcs2TxC61nZDsM+I8pAlOPZ2ECnRyMhizccdN+jF8xl+Kdzeak1ezdEHklSSZPmF7ap/dI8moxctrR/5qLedmInfKFkzBnDKXQ9jMPx6+g3Rr5a7d9u+s7ZZA/DOektTW5axXwxuUVqMM/wy6e6kBxYDKTJWscAtYBsJGK2aHg/dOKRecplInnQYbnlSpVAJzYBfr0vgD7FTWKH9svscUeCBe8UkiwsclRmrmcUrOb9VQmmpiCUcsht2ZHB9uHpwTMD9PwRrSIJGS74zhaxtIkIciTxP9FEUmGbHwDjRRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xngPVxr2MxMdXucQSY0euHk0TTBBOgseOjN/U9ucs0=;
 b=HCVI4BmPVsdCVr4J3bh2nbqkR8SOh9ieCWMdUCRf4CanQqTYEgCc6eFVcezhq5A5ji6bBoxqYSRGcLREljljFdB9++uFW7KqNftMr2UoDgST967ah8geBCZJoaFofeLQwf+YzcqYFj39HmWb/VhwxIsPk9cJ3F9MdcXe6rJj1P8=
Received: from DU2PR04CA0231.eurprd04.prod.outlook.com (2603:10a6:10:2b1::26)
 by PA6PR03MB10244.eurprd03.prod.outlook.com (2603:10a6:102:3d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 14:36:29 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::5d) by DU2PR04CA0231.outlook.office365.com
 (2603:10a6:10:2b1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Thu,
 13 Mar 2025 14:36:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 14:36:28 +0000
Received: from N9W6SW14.arri.de (10.30.5.19) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 13 Mar
 2025 15:36:27 +0100
From: Christian Eggers <ceggers@arri.de>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Douglas Anderson <dianders@chromium.org>
CC: <linux-kernel@vger.kernel.org>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH] regulator: core: move warning message below EPROBE_DEFER
Date: Thu, 13 Mar 2025 15:36:21 +0100
Message-ID: <20250313143621.29454-1-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|PA6PR03MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb3217a-9ca4-4c23-1956-08dd623c70b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bwBgl/Qran1cDiz7fbUCSUbFbpHHiiLAQsPSRupsagjDt6/WsYgc0WgZsabj?=
 =?us-ascii?Q?TOQMl7vqK5jy7gfLyt1osLv46feLwtFOLJuv3BbG1cUCq8SWLpnsBRcrQGAr?=
 =?us-ascii?Q?jSYamPDts3njH7Ok8FwRzMpKFQRWNcBU+c5dZNCDkr0lhTWYWbFqsS3F6VLx?=
 =?us-ascii?Q?n643ikCP0e9QCWTsSuKYA4FZ6N8YByDLiHeMEEl4E4eF/XeVM/2SFr1gTMTk?=
 =?us-ascii?Q?gtSS148y4jKENDo+kQGhZVy1uHNr/XHrFJBWL51G8I2hkMrd/5YAqR2+OO5a?=
 =?us-ascii?Q?oTKITxcas/zrcrKvlPohHJxkKrtmIPuCx2Mb2R2a3tx86m4Ulb286uapinxn?=
 =?us-ascii?Q?s8Pk8xx7OA5dKSijCLaX/XVpzxATdYVSO49i4s2dTrP7c7vMwujn5qLX2GSC?=
 =?us-ascii?Q?p+FmVCqII7It6QI8NDS6x4Dzsrid+mfHdSi4v2wVLJA9Hw398qXx58Z+k2gg?=
 =?us-ascii?Q?yfWUVBvkS+6SGmuPlWSidFN70AJhexjcjvShoqvz84bAjGyXOsluqyTMDG/0?=
 =?us-ascii?Q?Nxx+sXFB0v3V3txOTfBZ9yHaO+XwgaIVxfy6BPg2zSSLkn1kwx1tuzQKJoWF?=
 =?us-ascii?Q?E4l5uAl9qoSTbAKeFLrDYE5GsHPlauS7/RDg9JFdENTOiEjDPypA+E9pyQmc?=
 =?us-ascii?Q?Z3ck+BuaDtfuXYcR1+VH52UP1z9BSLC7U+8AJYotSPeimYooHUhnOib6C4n+?=
 =?us-ascii?Q?1GpxUXG+W6QTT2K5myVy6SUHDUvkCY0kC3pZ8QhsWGNfbANwthq3Y9dBn19E?=
 =?us-ascii?Q?nw5/8Pzay48Ku9dibE0bn94nH6eOGrRxFLfcEojVSprsUqPrNu+YJz1wRe56?=
 =?us-ascii?Q?3dkivhJjaF3a2/HnNLaHYM8cPChi/iQuVFiRZ0mor7GA/CdUWvsaneVMHIzk?=
 =?us-ascii?Q?noB2uJNIid6EdR6ne+EpHFaNZXOlt0FqeaY+L/drcyY+tuAkr5vC+yzJoCE7?=
 =?us-ascii?Q?rbqGArwlqeJMWsGh8zbK2uKmW0X/79+UzW8DIE15vkvWnKUoGziQhTPvJWoY?=
 =?us-ascii?Q?y13lBB+ICRc9KCrcvD4l/T6ocD6QI2cSirgUkIt26kVTD38AOMRCKsgT/o04?=
 =?us-ascii?Q?m2r/wzMvEke/RknOQX2RqT+QiY8a/FvUkXeaWw+O1GWAVlAXBMycKGmeFRBL?=
 =?us-ascii?Q?zfjro/cyz9Lir1shC6JVcdaeYydkiWiK0IPhfAt7r4DdnbBS28ZAcyXBPgMs?=
 =?us-ascii?Q?+ukXAj3l3U0W9M11szWzJJk18hVY2s4dGiBt4W9THABHkkKccSbA0/+GarZL?=
 =?us-ascii?Q?Gnnlwl83QxOI9qg8VTsEGL09lWCfozVrRQpLypIp7WBLCBfGxDMMIbejqBU8?=
 =?us-ascii?Q?xrz7v2GQDjIrBIDEzMB2EaqpnFyh713I/2doRIaX2fTkqxbGrnOojaufbCEO?=
 =?us-ascii?Q?wVT9JrDwWARWJ7AsHTdxmxYWMgxdPsZgOIDvOc9+j5HbzzTAhRespKyVrqu6?=
 =?us-ascii?Q?JrjxsPxS0Qzg/JKUPeAEE6qX96SLPfT+wc1SvUoHW2lJs6C4kMM6Vg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 14:36:28.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb3217a-9ca4-4c23-1956-08dd623c70b3
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10244

Avoid getting extra "supply XXX not found, using dummy regulator"
messages at startup (in case that the dummy regulator has not fully been
probed at this time).

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Christian Eggers <ceggers@arri.de>
---
 drivers/regulator/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4276493ce7c6..4d0f13899e6b 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2219,10 +2219,10 @@ struct regulator *_regulator_get_common(struct regulator_dev *rdev, struct devic
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
 			if (!rdev)
 				return ERR_PTR(-EPROBE_DEFER);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			get_device(&rdev->dev);
 			break;
 
-- 
2.44.1


