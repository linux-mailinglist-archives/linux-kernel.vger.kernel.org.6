Return-Path: <linux-kernel+bounces-446834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEE99F29BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 06:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E30164188
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 05:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E231C54B3;
	Mon, 16 Dec 2024 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EHnVRQZx"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8F157469;
	Mon, 16 Dec 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328292; cv=fail; b=EsrUigY5/lkf3CvoxfFBakhCQc7G4QPXyxCZwvdGywb2GfRAlLIB8P5LYeUCEF5ClRM8HbIbG4NYT+NrPMhr4gFx4t2FNqC8mqzFBPjuJ77QeEKsdgHuzDmoGwDt/WAcKKMnljmGqqB+B7TkYHGBxpghdt/R1o/xTyG6boidEl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328292; c=relaxed/simple;
	bh=ERsy99c9/haej4bAt9y8KZ8m02Z4vFZLpuoeigaewAc=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sib3Q/S+ZNF7LjTUBdzLnFCsEiS3vZUGw2kSxcURLkRpMH6v8wbdTtVCp3BZVJ254wAcKrBqhrzXrYCjgyK3GPWFV+bbssLHKmKkx8/c5p1guf99V/GIJYS9m0Qa47Jrz8yImBtMP0pV680YKfW6mOvM/mKk+KtQV5ANXQHznzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EHnVRQZx; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RIsYDwD/vnYb0odDBLoA94TDOvCERKPiDnCXamioD1V4XG2Q6b+vFrLFGXMZZRSVsFvY0CdK+03MfjymW1YSODjJFLcWSvJCSXZHX0LDoTEl0VGSZ2T/+IblAdBtQj/2I5z5Yr2MRPzIFNqdxuyyx+5m6h+KO2Fh7n+lkvzxGf5b6Y3ih47yCNP6voqWUze8tYtq+8IGbepsPiETv8pAdZpK6CO3AeUpKY0eO+kGP8KHn4T4+wy0avuqKEYs0PJ98/Aw67yLwwM2SsWGHxii943cpjpv36dMRU41aZWEbWmRN+kChArPQxKnnzjujYezTmOfb9eFiynlE83VqB5O/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juw8M7ZGVqKGSgKzLyVYutaTwvxORSm1wTOcOj+AIJo=;
 b=exnW9tHHUNz5qjpR1jXGwAs+SfBLI2KSsBWccib9x6lsWAMvtuxhgH8Qym1+fZD5qD6F6HRZM6KtZlnjFiVnzmQeKCk3QKeZuNgg05D37mlLyW0OkWysEgMiY43ANxCncRmFEKQrUGucSvIGvNOmTwqvG16vJ6RnfUUD9ovcAsmw8dYkEEpIV4uTM6F2R/2aV7VEoTQgiPV3Po2bFg1y3xZji5t1H+t431+55cmr20j2IcYviwmqVk7dpZ+VrqYIbZcXkRCsP+R98+xolAGPhAStgPbYojEcP6Kbj/7nmNaNbQ9uVtDkBpfUmsSDH7vy4fgjl3WItzKq42M77eRYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juw8M7ZGVqKGSgKzLyVYutaTwvxORSm1wTOcOj+AIJo=;
 b=EHnVRQZxp1uABm0MjHb9qexm49HGWPQb4wKDdiBzfODqfbl6iO69Y2wh8bKbuLTm8LEOndSno46IliTeWMNoCd4qnFXJkVUfCDTcR+y/IzYNyIly3kqin89QRFS7SIQWh6Rn5Y3e4CLmZ5ZQGE15aJCRaBeMOmaEWhAxbRZknVjSuWpP4motZBxRMxc2RTa3rdzA/Mu8uCBhh+pWRz9PbQm3PJc/nGn6V8tqi1anpRuhf//2k5AovIdQFpTp2G4/U9AxWF5RldWu2vbOleYoDVbVPrSik4DWHpFFNvcSasI32/HDhE4GQS3quAFBBdvkNoy7V/pkzayFKCjJSw1gSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by AS1PR04MB9240.eurprd04.prod.outlook.com (2603:10a6:20b:4c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Mon, 16 Dec
 2024 05:51:27 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::7be0:296:768c:e891%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 05:51:27 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Subject: [PATCH v2] ALSA: compress_offload: import namespace DMA_BUF
Date: Mon, 16 Dec 2024 13:50:53 +0800
Message-Id: <20241216055053.234914-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|AS1PR04MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: cb167e9e-e5d1-42e9-d1cb-08dd1d95aeac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VFv9m6Nea+BAZ5w9cdSuVj+HBV5Fxt7ykcrk9tiG1K1UITko7toxbHYwXRl5?=
 =?us-ascii?Q?n2NPt18ptAgNIj9gk5ozMX4wvxF2j+2e89NTc9qZp/AUIS2oX/MObZrUmKwq?=
 =?us-ascii?Q?6w9T033oaqzXlvR30deFbj2AlKRLV5wv1lsMGrdQhoeYu9nDLiThNqSAuPRw?=
 =?us-ascii?Q?sWAHpFxEu2/yHuaot0fwXHaHjplrzEMqAx692EgTTYoFH2kWCabTSbZofUmy?=
 =?us-ascii?Q?9K8DLOJ1DpRZYwajhIeH4+7XljCN8JJbCl/YmWelbJOnOXldDFAOkf/SsMJc?=
 =?us-ascii?Q?d4BAu0LfPA8TpRxp6a/przp6rZXm6Ojevh4sj9SLosdZTtz7jxMwkWe1nGrV?=
 =?us-ascii?Q?BD4xOOnl/08rr+IGgkImhDVZGVFSQJQ/mP1ISTu3nYJmpUyBKTgH1XomJsMR?=
 =?us-ascii?Q?sUO5lMKtG0/9Go3MHvRFMsuAzwu6FmAcYm0JbUCMelh/su/aWqcTq6IvFgZv?=
 =?us-ascii?Q?o5sVNub7rTnlMV4x910ukoRKuNQgqw0G7FJBRA4Dd/AG+Enp1VuQeG58EZd1?=
 =?us-ascii?Q?4x12BMMe3tVKlY4TThctvrDX8csRo8k/v3ucb9Yo+ovM26KCITAjtFL/YlVt?=
 =?us-ascii?Q?iln9bvIGk5lXVsv3hsGSnmVyk0WrsUYSjNoPbPRvc3n7z5R0AXwXKR7Ja9GI?=
 =?us-ascii?Q?nZjf7we8iLmmvu9IQhsUpng88shEPgVaa3DxfxthYQ9Lfa90szbW0Pi9Ex6D?=
 =?us-ascii?Q?SlTkc38OGoujEJY9JfLRlPyMZ/Ml5hLA12dUzGIwLE/fR1wbLKOR7AsacY24?=
 =?us-ascii?Q?36Emz/n4P4B/B0Nka4FFKYDY65QT/8dGYyZfshD6kxzlhdDqCoxIgx30n15/?=
 =?us-ascii?Q?F8gsCfVMErblpnDhO61opbhnANnXc20yKd+2ksoYWUryspFXMxPtzjqHTTIG?=
 =?us-ascii?Q?3Sf7puHEzPOEwiNdCTAxGE52toH82Idq97HZtQW14NpwgB5SsZpXQYyY76L5?=
 =?us-ascii?Q?warviIEXGu4FJ7oTBPv6ggE1SsPWk+hgACK23RI1EsPR0UngOBUop2H+xALL?=
 =?us-ascii?Q?w0eFaRMrz9z+AwIxgZjp8HaYtrdgcubpUW/aApclLyK5UMhyos3B8hEjW1cv?=
 =?us-ascii?Q?oHpwtzdi6BR63Tif3VTAlTE/L8Tt0HC6+gqpX5jRw76zKP7CGhyPjypxUoZY?=
 =?us-ascii?Q?Bmon7CmdA1L85H+knntnqAzebN9HOE503as8PWBhepOTFccB9jbHCxOZr/Hu?=
 =?us-ascii?Q?bPlpG3gNzeXAWrIfxolTkgr8zHIZZ0KuEg8qA3DCcTcd2T98wRa3bMttPZFi?=
 =?us-ascii?Q?y4wODevSOj9vjdR7VL6HPZt0rDeGbTAgRkONyP2yTJSv0edpsmib7F93wGBJ?=
 =?us-ascii?Q?cYQnqWeVGKIyjsbUkCJO/B0FAzrICu4/pgYjtLrvJyaRqF1Iz2bc8vx/e0IC?=
 =?us-ascii?Q?h0MweYaYDqOoZb3jQL55Pubh5UhwEsiKB4sLp1EYq+Njx+gBGcpr6i8UESEL?=
 =?us-ascii?Q?ya4OXwcgjhCw5fy+su0pVztCX9IFcHjy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YFGHd7FG4MP33/zRKQOPg9MhJ1RRuf79FzyXJmA603xeDGdzwbE1LCRS3lPx?=
 =?us-ascii?Q?4T6jw+0U9AFnNnyqorDdaNhFH6mPxv1gt0pbHsByks9hmuzxO2ldZ0jtEMKC?=
 =?us-ascii?Q?JRSUEgRf4MJ8n83hJWUqVGihFphxXUoscudJq5dyeMd0CgN//4Oby76/0KDd?=
 =?us-ascii?Q?5gB9gS2CsAf3SAGwSrN6lqb0L3ZGg1W3UEjSfPOdQbqNkYf6J2rWxsEeLSyj?=
 =?us-ascii?Q?E+SRUNxds6wrOoqgja373E2DbfB5Q3IDF8RDskz3nZhutNTZ7EpoYS23fXBl?=
 =?us-ascii?Q?r9VLydJsHMUN+anc0vP2C63MKOliQGtA/S/CtuShhM+rQFokynQU4F97Auiz?=
 =?us-ascii?Q?zsCatv0aPi5C7S6tW1OQ+k9UqJQHfwmdVYorumn4qs9fs+/F32Q8dzaF1YYf?=
 =?us-ascii?Q?2SZPssEYp5uTYHzLjzF41L76/jBAIMiRU915EV21epWKs5xUFwGdMCeMhp7D?=
 =?us-ascii?Q?k+v4DLYNI23IAu0UiNhy6P2qjowsCTyB70RCGZuk1EAgBQyHrZzsz2sx2uXJ?=
 =?us-ascii?Q?i9ul97RAjVIla1v/wu5AaGhDpcacgFiFtF2EnHWObDQSPU4CCFEKVQ8ZRJAW?=
 =?us-ascii?Q?/f6iRWpnbSu00al/huA6E4VAZcO3zDgubT+OCBPLxWmeLuMxW1CBlWiyKv56?=
 =?us-ascii?Q?cQSQd2+DIqkZfd7BQ66PiEgUzYsxUHDCaJGFExrEco36X/Yt/cl5KD1mtvNn?=
 =?us-ascii?Q?K7H1OzvG+WGU5v87HhPv6zb2ZOushhTtEKOCMiAI3lVq4TV82rPkEqPMP84H?=
 =?us-ascii?Q?0TKTssZ6fQDrddyZktkZIJPPWF3f3zHKygvaxp3TXlf9Y8O4GtZAGSdBUpGj?=
 =?us-ascii?Q?qEI0chLzIr73WPnZVO/GfBlnVGE6GXAT0LmX+ycdE7V7BxlxHhLEZv5rcYre?=
 =?us-ascii?Q?7uL6WBQAte3qOII7nwMS3V6RMrMavYucwlPaMCpWwq/ubv0OmCehumBVXN52?=
 =?us-ascii?Q?xzd57HksWHx+3jTLIb4Fv5LxE6jZJ1AyjzasEx1eJrkpO3T5ZSPaqIGYoF76?=
 =?us-ascii?Q?FS/u2GrZ+vYGVOpWSRLhv+V81q3a2W4PSmuIPLC18XHIpnoG40tK65ewNl5p?=
 =?us-ascii?Q?xgiDae/QJ9bX88zmzZHhHFBiISk4HEcwZmtCVtZAjOC596xxu/dI6qqozqyJ?=
 =?us-ascii?Q?6GtNV1M1/MSmNpBnq3Rt1e62bfO/V0PiPU3XJ2wG5UQH0WiHphCe+VF4YDca?=
 =?us-ascii?Q?yqpvrgK1ZhM8kjB0DFdojiqCc1e6kcZdPddBTsx5ZMjhy+PkXsC6hh3gqmkx?=
 =?us-ascii?Q?JFU/Z15vL6t/CXEGRj6akZgGwvTt5stD9z0S4aV1eIIl4Wel6MAsPcAKUsa3?=
 =?us-ascii?Q?etsLK6UQWszaGblbWox/m8juxZBhZF4eyJCYvKckWRFeDSo8tndv5bLc0AQl?=
 =?us-ascii?Q?wgowX82gWpq4s253LyIHA1NK0m0I1umqF3LH6c20Qu2H1J1Q1pKI64qzK++1?=
 =?us-ascii?Q?Qc3MxZ0bIQXwBu5Yp8KTAU41xtMvnhyCQ9LveQNPccqRb928RHtUpgcy3wi3?=
 =?us-ascii?Q?+cBARgfnXGWtuo4lCH8/Qw0v8j5np/PqeRjEIJE9cNhmJil7a9T8hBpvQUpT?=
 =?us-ascii?Q?0/cFB77Ob4la2tGlq26cKUt2LWLRLbzJArcUzy1I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb167e9e-e5d1-42e9-d1cb-08dd1d95aeac
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 05:51:27.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klGhadc6p7bO1DWpRsBV15jB1eOvUb1N9ieHuScVZB8nrfncVTyydzMEC70q3PQkG5sVA7pWjSavNbKnh/dD7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9240

Fix below warning:
WARNING: modpost: module snd-compress uses symbol dma_buf_put from namespace DMA_BUF, but does not import it.
WARNING: modpost: module snd-compress uses symbol dma_buf_fd from namespace DMA_BUF, but does not import it.
WARNING: modpost: module snd-compress uses symbol dma_buf_get from namespace DMA_BUF, but does not import it.

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202412150026.EMUdbO09-lkp@intel.com/
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- add Fixes tag

 sound/core/compress_offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 8a14707a16bb..dadf074359ec 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -993,6 +993,8 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
 
 #if IS_ENABLED(CONFIG_SND_COMPRESS_ACCEL)
 
+MODULE_IMPORT_NS("DMA_BUF");
+
 static struct snd_compr_task_runtime *
 snd_compr_find_task(struct snd_compr_stream *stream, __u64 seqno)
 {
-- 
2.37.1


