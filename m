Return-Path: <linux-kernel+bounces-294622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F23795904F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0E9E1F23EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF70A1C8223;
	Tue, 20 Aug 2024 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Q41xTiBr"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11020104.outbound.protection.outlook.com [52.101.51.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6D1C7B6A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191976; cv=fail; b=fYxyeKMOFZCzZYWS498ZnlDBavERt1/xsY3DEK1I8U2pG0YOC4o0+U/twJuS3c7tqe4gDChd/6dzhawyq43f32CL9B5AceFccvU7dXl/5WmtyuWGAzTMxtY31941FpLNAaBbJn0n+PLKBUGcuCOTH2Sp2lO5FIx6LWlOJ0JB6dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191976; c=relaxed/simple;
	bh=82mcS+XS+UvoJ8KYOIsDqQgKbtbByTioTJlyxsy1nsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmS0iAXhpHmD/4aBYBf+cGoQDjg72XxDZTBc085gBBxZR+n7K7u+T+rmmHhsP15M2EpZz0wRpLKy1pxBxs5bhsUnrdvs2pFbGV7wD/9fwZOK09AJrvEL9+CONGQYcIfg+9u1TsJ1BeBge/j6ZvtSQymffqJMTfcltJzrjiJiZCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Q41xTiBr; arc=fail smtp.client-ip=52.101.51.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8aZDxJW0ev6YWRqfSohfa4BR3FNcs+JD8qGKWx4M9QKn3S3m1Wy0lRjxj2cq43hoF3Y6XGaQUWhSSJR3WQ9d7jtdpGiMu0kbNhlmzSx8Ok8MfT1hc+4igQNSPOCH7N4SSREgD+TNZyVa3oXNnBwdBMCUeTeUufPjbbGHZ0Q6ZadE1XkUL4BVarM5kzWLdr/03EBWcMeSiZ+5LYOWAiUUCyDxWlxLr4MlranYXUc8p6jzOlPK4y8e864QaICasC0dL2buaklGiXasPn5i2y4CpeAx6RUXSgWfLl/xta0LK8KNvwctM/mBF/CMUGmKtpzKX6oRBSJNEpLf1euM02CNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnKaon/i5khsMvYjzdfUM5lmYxTQtdiWRewc7JQ6JmM=;
 b=ec2I2blbk+IqM6SUDdd9N57WNjf6vcJQrPIxskVGfCgeWDqhIKuK2xsXojSZFvzX5i4l7w9ieDduySTmZD67VWLEnwTtOApRUielWy1gkyzkighimUQ1U5WIbpIAkz8P261WUwWgs2mNNQ8sat47ZBtsFm2JkZkEKuXdSo0Vc2MfARRc4bwt5ibnSeT/3RT4P8SRW+QlDEjZ1HfL+x3U1H3YHRP9FeTCqf3eZGnwc8DaBgAAh5A9sO3ZONZQzW2phNiCCH4DMZ+Fr0H2NNRfdhLPnkDldY4NlksoCk669uZZ8xfBTcrfASzTHubYFB2i3Ay4+4mCbI51exstEzhjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnKaon/i5khsMvYjzdfUM5lmYxTQtdiWRewc7JQ6JmM=;
 b=Q41xTiBrKf1LMoiAUJ9bveDrAiAfLm5BkC5HmIa3wGZwgXQHXfyorRP0LTaPAcYheHXQu1Lc1oxEJ/Bnl9LFfnZMiKK8KqD2vVacUobKfB/31pO/hWZkjnS+xhDV9uuoNhSiGlTHOHBIRLGDekZgarfRRq7nLLJyuWz7MruokUg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 22:12:52 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 22:12:51 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	ilkka@os.ampercomputing.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
Subject: [PATCH 3/5] Force MAPPING_TYPE__IDENTIY for PIE
Date: Tue, 20 Aug 2024 16:11:33 -0600
Message-Id: <95df5a08acc2c87e8ff9e374f9ae1c56cdc59470.1724104248.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: c74c6fa3-09b9-4f21-e66e-08dcc1653bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cquTa7cVo/m9tg9nPmamJxEBSrgm4xcCoYIf7BlWyiUOnL228b2s+6MINac/?=
 =?us-ascii?Q?aCtgENtPhQh71kShQlTLlVUYC6SPsCkJbSff+UM/B0ig9XzSPf3bo2RsohWX?=
 =?us-ascii?Q?9OTjztaD5+PJ7KwkTDRtPnu9LUea0kzP/eaNNA0/VACOaL6lIiI6ckzV1oPi?=
 =?us-ascii?Q?h1m0ADZnMg3FKiR+p6EmXmQoIHNBLtrwdZfaLHeosagYSqIw5G1Dwl1TmHpE?=
 =?us-ascii?Q?o8jsuv+GOPuja8+MKpUUpnGM6VCy+EVP0eYTTBVHD318oyy5GCwibFbSI6CU?=
 =?us-ascii?Q?G/+/PIDGQzi7z0cwSdsYvJmPBp7zNI1ohPwnF5oroKkuX8E1X//P3QgSgPxT?=
 =?us-ascii?Q?FI9pleMk1hCcZ7PV2jsMRzjIUK/dvoDuejbhT/Gg4lJ2e45RC05gfGJQA71C?=
 =?us-ascii?Q?V5e33/dXr9BrJXfHkkD5JLnUiwvcgjbdBnV6sQ1lsWuVp1uhYat57nbET3DV?=
 =?us-ascii?Q?jFjibmST6hZ1Zf4AN2mgBKPoqsSPyUS0tj6rTtkqVhZDDeMJvqIhl6sDgQe3?=
 =?us-ascii?Q?Bu5JvLYUK5xdM4XKIH+yHSdAvljUlOfJTva3MiUbYvzBhbA+ZUolINdX4PN9?=
 =?us-ascii?Q?5SiG309xpBgDBhzm83cEhejePKMoYfQRjHMsW9qO1mPcul++PwTtyWWvpCGz?=
 =?us-ascii?Q?M1WTVba/W/8Etch4HGbgXzzF/IDxdvxGMs29ELbo7z2mSlQjhKTTgMdAiApc?=
 =?us-ascii?Q?huxVMCvPL1MHRUmftgarsQSWuiXlchef2ndWNMT66b58SXhptzwt4MwdBHg3?=
 =?us-ascii?Q?CSUtc9OuoBNd8qe6F0ijPY6lTPplZirFJ6aatyDWwiCpTisR0zJf6LosVE+G?=
 =?us-ascii?Q?ENonyNNzIXxFaKqGW593r135Rbg/6zShPc/C0H6AQ7ZoMHIaeFIQvLkCAhhF?=
 =?us-ascii?Q?9EHcg8m6hHHXj3eDj1h9KN1dgQlqhbZtsyLlBcQpbbUiJEX3QDVhLk95ajR4?=
 =?us-ascii?Q?OyB6o8O8sSvd5hXVmgkp9TA1k4Dmj0k11GJVUJB3RyePFey6Mnav7ULYOLSe?=
 =?us-ascii?Q?pMeJpon2RoxvaG2a3TXhWHTWM5I/H0t0/DHTzI2fEcSWl1MPIkkQwdv1ZQyD?=
 =?us-ascii?Q?rVtIcjMPGTSGTrr5I9PYjrp160/62nLwMP5WX3Hs/mRsPoLwFGBQ58qacYGl?=
 =?us-ascii?Q?JTWISgsm7xvj+PouLvEVhjQazwyUQGewwMtHjFXt6wGSOAlWqP5x3KuwudLN?=
 =?us-ascii?Q?BTN+0q8LUjQNJEtzq9xpCBDQSBC+GDwdH04UFGuqQ76StLFR4quYrPFYQbnh?=
 =?us-ascii?Q?LywXnZg+hq+ScuK+E9nnSWTWootnh3Ve1GAZR91TOfjkg/8fEr7x3PCukIqz?=
 =?us-ascii?Q?uz05RsoDN2WF0ievpjoMi8fkSfxXPMryJa4cerbr8CC7EMaZats2aATc9HFV?=
 =?us-ascii?Q?24NgUddTqs4i0wq24bToaRonpuR/bMq9zdgBuZmc1igTHNrhKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TPoN0oDE22x64H/9mDQb9MGEQXNRFwJZVqR+J+QDFWi0Tl34C1CZ4pCoh09P?=
 =?us-ascii?Q?ZAXe3tlUwDD/3HHOF7EuzFMZhe/Ka6VADeA4JpYYSVV2K80/xEJW5ohYfezn?=
 =?us-ascii?Q?COVqWdYYlw6cfiwJrAlktdg7xdihHfea8O7mjJ0QdIDXtv37M7ORaI5LGKcB?=
 =?us-ascii?Q?5m4L64awcyHqFWbF5khoXQTIXzYgleOJVZVfrJhi7mfh2LDd8p4N7yUx/BDo?=
 =?us-ascii?Q?tBtb7R/8yuWu1tDKmvz49sLVMJE2gaoP7sjJyf+keb6z3HaKs1dbYOjRP0qE?=
 =?us-ascii?Q?fUB/BTRFyNjCrzR5cp2mtME1tBvs6iezKtxN+i2LIwY1q1ffbFz7s9qcj3NS?=
 =?us-ascii?Q?VUmKQbdYrZOX/VVqQXG+LojclGf2+Tf5p8KAa5RYqU7ZZXGNrFjC13ezpnuB?=
 =?us-ascii?Q?mRPlMK0I7w3wiXQAhwQ3aTdReTgYfVytuw/7YqsTtsNCdWrDyaYmIVBIe9ru?=
 =?us-ascii?Q?oQ9m0houZwIKXC3mZLUJNR72BDnuBpk9EslP62owZeV8lTyvzvSAgXttD91Q?=
 =?us-ascii?Q?xRIR/j1zfaV+bX9Lf99oHBRDOarP7LsCLikLXcoFNhu3j/KUY2PC9AvWHM9T?=
 =?us-ascii?Q?y0LXYhEqFZi5IhYV6kGAUt2yXZs+1Kjx06KmVWGvlsIpHNRO1c5nGDQa7eZ3?=
 =?us-ascii?Q?MT3Uiy+zdLR/PI9YR3HquuIjo78iZMcb9FA1n1Io8vsscGOMLP59xrD+r2Id?=
 =?us-ascii?Q?lf+5Aq3HO+5RbRGC8QqqM600236mEU4P7ay41ttkSbzGuhW31Sm6FeS+zx4d?=
 =?us-ascii?Q?qs8VZTDoQlM6EcqHl7S7xKV7zFSEz8AUcDnqFtbGK02X9TN2bejQuSW6SmxS?=
 =?us-ascii?Q?vAey4FWjh9f+F77wZ4FC9l9pwx2KIvWHgJUMkXP0gjdrsdDty40Iwh3a4uVN?=
 =?us-ascii?Q?ysm/Ux7MjBz+r7nm+95j5EzXYsF17Sg+B9pco7L6DYtmMYb1DJ6v2BOpdflb?=
 =?us-ascii?Q?+qKWugqgf5a8Li0g9jL8gqobMWJgdtVnyi9G+dGYQrwIdnn4bWSjAX1wdzWT?=
 =?us-ascii?Q?TG8ResEvOlz5YK+reYABqmn8kvycG4N3wIymAsKnNKILigk7tjcZ78HrvPgc?=
 =?us-ascii?Q?9ouKGzqxN9wqW4DePhRmEa332ZtqY43Sauk5WYgb0g4pP8oK7kRTtoVcbOJu?=
 =?us-ascii?Q?CpWWLtBvKCvLFqX0TVxc5sJpx4VxoxcDAZ6KFbSOAuIHg2xRskhIXwOCJPky?=
 =?us-ascii?Q?49kVoVsPvhtv0RB56uuT35Gfsb/fVlPW5sSy5X/NszI7xR1RY5uHfOD/dpzP?=
 =?us-ascii?Q?/jaY+9QCWc5wFfwPHHzeckHiX3lkDzj+8tOKZN28k7J9KtrNTqtagDrl/Vx/?=
 =?us-ascii?Q?e2rmTgj/QomPFX4vWWX+IgujsVg7t+IAIAJM6oPi7iNyGNAGEn+EcSaiSdXO?=
 =?us-ascii?Q?gA/p4UY5lw6m5ro/X6unYnid7OJxB2RNyXTzItV4EZ2MqHqoHav7QgYyGO8m?=
 =?us-ascii?Q?lrUvaAyZH7Q5ukESwStTdUi/sx39DC7f+7rHqCvDqS87uXLPYd8ngjEmIHVN?=
 =?us-ascii?Q?a2zObhxe0WE8z7uyJ97IVU2oaT/fBBMqXyKEZ6FfOhfsskYX+ZFZbLxAS4k8?=
 =?us-ascii?Q?9bLFsw0nxHg3swMRPa9VcVfQ6fATHMYj1TtnoEJiqirDkM+S8e6F+FmP7F45?=
 =?us-ascii?Q?xdlt4FEcW2VetZKVo7D9jfUeD38c9u7Hj7Ij4ETJ1Tsx?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c74c6fa3-09b9-4f21-e66e-08dcc1653bb0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:51.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ymjk2DJIFpTxvrIYlAhVTn9iTLxaNYW4dNBob2Gcn5gC4/NZ2Ws/lfDXJcnNCuNkJRmtqC2ACWyQcttbtsVa3OmWea2gUbKDfcTK0y/71fQ3zQS/GuJFBI1QL5nypg8W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>

Use dso__is_pie() to check whether the DSO file is a Position
Independent Executable (PIE). If PIE, change the MAPPING_TYPE to
MAPPING_TYPE__IDENTITY so a zero map pgoff (text offset) is passed
into the script.

Signed-off-by: steve.c.clevenger.ampere <scclevenger@os.amperecomputing.com>
---
 tools/perf/util/map.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index e1d14936a60d..df7c06fc373e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -171,8 +171,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		assert(!dso__kernel(dso));
 		map__init(result, start, start + len, pgoff, dso);
 
+		if (map->pgoff && !no_dso)
+			no_dso = dso__is_pie(dso);	// PIE check
+
 		if (anon || no_dso) {
-			map->mapping_type = MAPPING_TYPE__IDENTITY;
+			map__set_mapping_type(map, MAPPING_TYPE__IDENTITY);
 
 			/*
 			 * Set memory without DSO as loaded. All map__find_*
-- 
2.25.1


