Return-Path: <linux-kernel+bounces-571357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2CBA6BC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1DB1898305
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335386321;
	Fri, 21 Mar 2025 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BhFDFmz6";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="EfJcY/8X"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66778F32;
	Fri, 21 Mar 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565235; cv=fail; b=inafkadaW8Wp2QYYfT22QOsLySgSJg/5Jyt/nNxV+n0FnX6aI4aqxORISm7BDQj25PvnOUbpgA9zYxAAiMmbeQVtG3GNjvFn+sNwSyfozoay3JWjvtugjRl47ENlUu0p+GJ7WZMT6nzE0VTKsNJY3xvKwIrKtNU7P/XdPkihRM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565235; c=relaxed/simple;
	bh=r3OTvGsGBHnqbgr4dnH/+zfWG7B4CfAd1AFrJkHEGBk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Cy15b0MCk8Jj6O7lFANf+HoDfydNp/EMPFv7xFaqK2PEige3EgOwohVkYydQMIW8/MfVjIFcvHfu52x3Lc8iqA8ZTKZHiDbYjCRJkMawc0ZKYqPFGCnPDURviITwNKpMPRJZfUswJ1tYXHLeEPTpKALT4lD6KgYoZqluG/7GASM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BhFDFmz6; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=EfJcY/8X; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52L7m8O0023619;
	Fri, 21 Mar 2025 08:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=jh3ac17y4vIkB+ti
	h12OywwC5ENbzZ+qhh3ETULvIPg=; b=BhFDFmz6i0ZjQd3bBIZvIx2Q8S8E81Ey
	ZzwLx4+T3TH/8boys1jbu63xjPwH2g3QXH1S1R5MvNUv8yws6YrPfNT4boxWTvYQ
	3Ig9cEuzR00AT1Ox2xRd8rp6WgiVCztknVL1GvhCOeBQ+xNOgf76xbJ6dUjvAcZk
	qkfy2f2Su9/LzYoLhQlWnmxdQarUKP5hl7yFosEpJaYU6OH0kSmEbenasE1AQHvP
	dEPZLsXoJsRQRQ50TeT2kQ1DxFPeHbniuz8vB2Wy50mrc4HPEzE5hCcVJl6eIB2P
	NLyEOsIPDYaTwBRR6v/kOA9xh/mfwE6c5VKnuP6nhk36HhrY3dNOMA==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45h40m0nkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 08:53:34 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qzngeblD+xUgnSig8HrQcHvRrZ2KhUwG4TzTmiHtlc/NrHk64lzuIV83m9iN3oj63Lppa3AHCs/CdFtDXcb+xg9PgZP2TvO5SjodlQMyeM21Qa1g3gHVDXUxSW/FpXS/La4Ized00hVgKpSwo8SGtCVyJjFAlO2U65BVfqrdXWmDtmJdHZk22EiE3UhTu2g1fKMuiBaL9+DWQRq2T2lB/fQYER1crMwfKfoqNfEEBTLQcXa37GllvmCxQf1YIA7FXfXFFlP7CiZ11LiG7kKS4zHvKHRo5cE30ZFXg9MXEAVlRZ0kLqypSo9RS03CdKnV3seAfuQYKF3NGWZUa/VVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh3ac17y4vIkB+tih12OywwC5ENbzZ+qhh3ETULvIPg=;
 b=lpK64FkQDSLXHuW01ojK+LE+OwROy17fxYVyjhlGJkQoQd5RdYZRpe6s77VUWh4guyvIjIOQfJ2qBt15mYt/ZlDYyzqO/UwVaa1Pca3Qh03KO2H2OCKn0c20KEfpnj+ChRGkduBzrpkxTO9CdnexazuAN+9Uoa+utsV4GWpVehtM17+kjsOJzsuGWTCrOIEjXE98B7KXNdosN1HvGiyWLpzsQ6cNM+C3MAPF6B3P1/pxE+gEVfYA3Ts+tSoxCB/eTGsvhBcpN7K+nQ4By1RwZ8s3IJjXSXfeSTd36cxu7l7yi0TUGMAumoyGnDTrTDSwAJ9kUhQQ4t6AyeZsidXN3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh3ac17y4vIkB+tih12OywwC5ENbzZ+qhh3ETULvIPg=;
 b=EfJcY/8XdRy3/3TJftjmTZgskC0dBGhDB5VzT6snnMnwCpekXqA8zTBB6jMAy9MsPkdoEhinkmteiNDwCs006GFjvnGdlmK+gWKDd4/rxcri0RFS1x6K1sQCOFfH1IipmoQQ8h18DT/jymEhdgRKOpPhYycxEY6WgInXQAamtgE=
Received: from SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30)
 by DS7PR19MB6095.namprd19.prod.outlook.com (2603:10b6:8:82::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Fri, 21 Mar 2025 13:53:27 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::ed) by SN7PR04CA0025.outlook.office365.com
 (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Fri,
 21 Mar 2025 13:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Fri, 21 Mar 2025 13:53:25 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 37E3B406540;
	Fri, 21 Mar 2025 13:53:24 +0000 (UTC)
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 11BB8820244;
	Fri, 21 Mar 2025 13:53:24 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, pierre-louis.bossart@linux.dev,
        yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: [PATCH] ASoC: SDCA: Correct handling of selected mode DisCo property
Date: Fri, 21 Mar 2025 13:53:24 +0000
Message-Id: <20250321135324.380237-1-ckeepax@opensource.cirrus.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS7PR19MB6095:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8115fffc-b47a-4230-66b1-08dd687fc0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|61400799027|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JVKfF1ng5UNh/IxSx0LO1DXc2zHLebpqBhKDIShbkwG6KhYKU6TNfhs/xxaI?=
 =?us-ascii?Q?qS9V6ehFb42xmb6ZqQVQ8DQsDmj7fvn2cC8fNlfUOyv7nGROt91UnC3D4E3g?=
 =?us-ascii?Q?6ISoxtuyQAzSZG7fDN3gDXuRQOz1oBjkhc/uzxXx3mZxA8xwZfRFvU6taLSy?=
 =?us-ascii?Q?xymiyZZ/UXqF8YQUNbOYNFWfERX2bJB6EXsYOBzQqoZ05aNZ9fyqQuqbGU8P?=
 =?us-ascii?Q?RC/t56UETnJj2OGsu8UC484utGyGxADXOsH5KUYeLfB4fNlIpx9577k1BB/W?=
 =?us-ascii?Q?8/vJQJwtLZHdxT0k9cyipFL8uVOoWOdYAuxZ3l2l9oWkqKp44MLqNhdayiDC?=
 =?us-ascii?Q?riDB8xs89BdvQoH1XaX6BYyR6+3syV9QpV1rdwlnQYakUIaQuAuIe7t4rv69?=
 =?us-ascii?Q?C2j39pblUihk9dJPQCXxOMCfRhhiJx2Pa3pz7BqnPFy+GPQ3K/nIL1qsqDEb?=
 =?us-ascii?Q?Boxv6dnPunCniy2/GYmWR2wNKQnWenOLPrw86j9qpAZCyy1/sK3gsSt1TizJ?=
 =?us-ascii?Q?wS8RoGage5VUiZZoer3W2TKGpmyBdIhdK7zmaIruCWgpjQwCzc337BbrKksA?=
 =?us-ascii?Q?j4vEtG5eewMec7SQbST1a8y4r5cmBMEJ7r72lycpkTe0yymRucBCBHbDoX3g?=
 =?us-ascii?Q?XwjYRni6pLN0dVUbjSPWxZ3XeBD0yc6LhfAB6tuFNgJWU4p4WWEhZFLOf/Tt?=
 =?us-ascii?Q?bSgyli8p12rbhkSJMuP1y7R+1l4xfEPfaBx0gHCa8sAAr/Jui5dsvtfFd3CY?=
 =?us-ascii?Q?fpD3hV1o7rJ+os1H1x4KE/EXS0BmdDFIZ35dfSPu+iKHfvmU0J4+BCfXlF9d?=
 =?us-ascii?Q?9DCQpWe4cTmoyw7lxL8DmOxteOahCB/Yi6RC2O7iJeXVmFk9+LrRKnqwEYID?=
 =?us-ascii?Q?8y/k1Cl/7nrxQcqkRPFFQZaEWNVnH9MmHPJvnLutfW7HzGwVkRCDzhwt2d47?=
 =?us-ascii?Q?XVUklcTvhLpXFPnTNIewSpqYXhiLh2FL/Msr+G5Ydirv3LwMWHBsbOYMtl8E?=
 =?us-ascii?Q?mSLQG2FDbELh8bYajm2GO6skLoZK5DAb+IlY2K16FfDRXNeaFUiskeN3sqvA?=
 =?us-ascii?Q?EEHCuEpmYCZ8ztz493+jONqkL+OyCPblvzem9IGMQTVuc4dngj+1JOpnHwq5?=
 =?us-ascii?Q?FFNSKMTAP+nP7aX6yMYfQ+8m2RCoXvASasGFLI9wagAxsNCYVnyqGkSSoRvf?=
 =?us-ascii?Q?EwB/Ap+iYnNcvkcAiz6Fl2t/65MK66nQe6T1cGo8JIz4jQVgDz1MV/OHdyBk?=
 =?us-ascii?Q?hcXZY5zx9KIn6/TBJjKphE6lvSgl6ikz9JSoeRW9ZprdbghuVCSydFyRLsC4?=
 =?us-ascii?Q?P71iggt4M+Qzt+P0XxaWSavGLhvUexvydXrdOsKLfrhv80fThbFvXupBh9m6?=
 =?us-ascii?Q?gJcEw4Yi3IHTgZfB+mYV9hBR4/GkvTi9Y/M1S/QSy1NRrtyKq0q2bEWSdkzQ?=
 =?us-ascii?Q?1xxEv0YwnnAYPFueHZZVFpYEQ3KyQFi0BmvF3/tSd/NtDdIeMVuMbZpwIBLA?=
 =?us-ascii?Q?bxY3Vri1QJGSP9Y=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(61400799027)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 13:53:25.6390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8115fffc-b47a-4230-66b1-08dd687fc0ad
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB6095
X-Proofpoint-GUID: AI5xvY5BYkCLldCU91Crlf6xONtTmoM8
X-Authority-Analysis: v=2.4 cv=DdkXqutW c=1 sm=1 tr=0 ts=67dd6f5e cx=c_pps a=SX8rmsjRxG1z7ITso5uGAQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=Vs1iUdzkB0EA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=aFORnpe9vv2NHjhfobcA:9 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: AI5xvY5BYkCLldCU91Crlf6xONtTmoM8
X-Proofpoint-Spam-Reason: safe

mipi-sdca-ge-selectedmode-controls-affected is actually required by the
specification so the code should return an error if it is missing.

Reported-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Fixes: d1cd13f80dc6 ("ASoC: SDCA: Add support for GE Entity properties")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sdca/sdca_functions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index c8efdc5301b53..493f390f087ad 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -1159,7 +1159,7 @@ static int find_sdca_entity_ge(struct device *dev,
 
 	num_affected = fwnode_property_count_u8(entity_node,
 						"mipi-sdca-ge-selectedmode-controls-affected");
-	if (!num_affected || num_affected == -EINVAL) {
+	if (!num_affected) {
 		return 0;
 	} else if (num_affected < 0) {
 		dev_err(dev, "%s: failed to read affected controls: %d\n",
-- 
2.39.5


