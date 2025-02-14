Return-Path: <linux-kernel+bounces-514616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D80AA35952
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C4EC3ADDA7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF836207E13;
	Fri, 14 Feb 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vOgE51Lp"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B921CC57
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522960; cv=fail; b=JeLLSSk7sMyk8XeGqkcdrPy2bbbSX/EW6nrlUZtF5GbzYHRazc+SvDqLpwYCm8T991CMy5UWF4W4tZHwLmCFZ/RCo6TMOLIIjbYbwq/7oD9C3YFZJTMRlwnS6RENUZyvlGzMcu92HWSFrgl+3s7pd1nb4fxYKtFr2Z6lVBWe/gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522960; c=relaxed/simple;
	bh=HNiamShw/wXlXlo+OuYjomkQGO5wGVsSMytlR+Cp1w4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bkssk3mje+hqHFDuge1l3tolptZtBhonqgotXEtiCMaL2lc03j615XIOChve67RI2OO9CsTIdAftxMgj/MjaKTnbn4m9mOwn/NYRYbMyd3R64NkmQ7xWhAUMCdCYezdVZ+OofmNIF8MTycZy5+R43n5GsFQiyQxLTVlulMiiiws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vOgE51Lp; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwpScpMJlfEfwhZt0kSHB++zqghNxgwW/x9eO1OFUIii01qy194CTr9fx2GpQRXme1BPbPe8QsVMv3eSAVcMEhRLL4hx2FdCaHl6KUj3RwnYoJWx4+eaPMBKLr08pYzauSiZaNOjyHGE/iZBpE+Fr5Kkg63u4HE0KcB1jWnZUiJbBaf3Jw8edMk9LZzrG7eojIVLcdKq5i0STUYiPJMuMEhjUTn3y/F1aWcuwUsWav4N7m/UE14cXBYYtyrn+aXOkGTdU4Z4ddc8wJ06rzuLdH2Pclk5QmAsvDuMv3NqwYq5Nr8zl5PMX0LBJJfIIysUhZqobfJCx7OAuDDBz3VXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLJL3Y4EWxuDSI7kGglfp6I2goRDVatFreA596uBmCE=;
 b=W15+6i6u7dq4jm15zPpjIuvWvzHcdBVRwt2jJxXvtbqgcG2ajlIif7w3HmDDA5m5ZjlM4ECAU6/Ha4xbQes/H7PqjTRj17h40ItgnlGbgDM1Ytao54y+egmoyG6zHb60vPX7H/CfuivPylxmAF+Udatvu55VBowUZ1HVMznul2JS6JMgVp9CXBpmnnnlaJ1hDqBiT3/EVWrvRDa2uzotXyr+UA1J06GBqaz8BQOI/Es/MzrTeTYg5wBtaExoSaIA2/kXoCQVK2WmhUH0KNpsrl5WCAvNn7ySXi/amioJedejpGk4KLAPgh1SR8BcCBdw9bRLuERMhhX6lfb6X8IWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLJL3Y4EWxuDSI7kGglfp6I2goRDVatFreA596uBmCE=;
 b=vOgE51Lp+/lgfzBqZq/0MV9K0I4e8SNg4gN4+tnL9HczR1rt4gcC5HMufEqlhH4olhQjXn9QhCefu1/rwBlyUs7L3ApyZmEd/89gpDEiWIgMUiQu4R5sRA8+RTLSRUdDdthugzGnJkglNF05FsnH78CTjkGt6ehDzqwEWGT6g9LBvjGzrvCGktjQD/nWOhh7Uyh6v/Fvya4Qfi1iEh5R2nkcojIJ+cGBwf/4X9cuDmaBWEG8b96aF5W5t6tO2Lr95lfMr56JGplomXwPDUNd1JACPopEsVFrUkYQvd4Dtf+x8CoX8INVx8DfCBIdGpIxY+C5zbAZCrz/WNQmh6Dtxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7368.eurprd04.prod.outlook.com (2603:10a6:10:1ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Fri, 14 Feb
 2025 08:49:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8445.008; Fri, 14 Feb 2025
 08:49:09 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	Peng Fan <peng.fan@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH V4] soc: imx8m: Unregister cpufreq and soc dev in cleanup path
Date: Fri, 14 Feb 2025 16:47:51 +0800
Message-Id: <20250214084751.2975503-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0020.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 4490cf5c-aadd-4678-6fc6-08dd4cd47293
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JtTGCh132cPuvOhdM78RuNgbdQNOVRNzkHw2Hi5JM5t5wIZ4ZoIg70M2ceOT?=
 =?us-ascii?Q?pSDZgzV6I84SUjxo8u5tjXhtSudYqLZ69noPQoV0okkwus9Y5pm8C22yLThZ?=
 =?us-ascii?Q?gvri99nfM3SxUd58UkRRZC+spz5jHhm357wtnCaIq4d/1mvO+Z7ro9uFZVq7?=
 =?us-ascii?Q?vqdWKEtVDYWxvd5FWPRhlHzSVJ0SO698DS55e1aWcwvfVZ/Y12XcS1Dph1Mw?=
 =?us-ascii?Q?CMYlH5va2fB6gzIaT2N84V2G6q7dOOITKDEun9gW/xea+cKsT+YGXSqho7Ri?=
 =?us-ascii?Q?zdv3gns6AYBpStDWqHyHmu8bOHXgYhrvU/Djntk7d720fqRfgnEwEn627BkK?=
 =?us-ascii?Q?IEVlyXC8Ez1bcV6mEHMXLSEnoYCBCQWdOUB10T6PYbMTVGxxgcqdXBVAg1lY?=
 =?us-ascii?Q?zzSVcQnwGx0inK4S+yewCvOv36pLRTKq4PH33z3b2mmv55y389kPH0xZBlQI?=
 =?us-ascii?Q?v75dTVqPcqRjrN4zOaHmwF06yUW+AcerHdBqcpT8Fo8xUcq0qV/C8zmxRWvA?=
 =?us-ascii?Q?D9MhQCpcq95eXbdW6So11qL+H5Ua1RNHRhdDiXZ6ZaG3dzm4zO6TaHdX994+?=
 =?us-ascii?Q?iXt/Db7LO1xnKkgLbs4/+7a3mMIWnIRdcukLrXjrYjoe1f4EXrp5fLHdKJul?=
 =?us-ascii?Q?b8GHS84l25jYDFK15qQT/l2x2R4bUtfA+R/fdBtReX6LF6SDXOaemb/nHekU?=
 =?us-ascii?Q?h6vgzi88LbeGdKRbFr+vI6NRTx5CfyBBKdA7DrVYYZwzeOaN8aBkVyy3K23I?=
 =?us-ascii?Q?vCrPqiF97rD9RkV1aJUNkA4Yk78onija2C09Yh6WZ56b+oehVqtHLBg4DWZj?=
 =?us-ascii?Q?ylak4J6NI/POWPN4NJdqdNyieLwDIBVAoE+IEbzbzsx3rKGbuGRTKCc7KsOR?=
 =?us-ascii?Q?5TL+HTkGdUCHdnCRs2RgaNyzNQHLIQD6FDzuBrPo2ILzjohCKTEa65C+x+MX?=
 =?us-ascii?Q?wcm+KwP1ChZ4OHGk2Fx4U3lA2tXZQAHiVgnQ3box+dnG2/W78V7JYTmuF957?=
 =?us-ascii?Q?oZ7PUzS3l/YyoIkxyA8a/IhnACRLcOLMlOjL9yietqkDhvrBC3A5zav5GknF?=
 =?us-ascii?Q?1WHARfWe/r5FcMdeuEoFvd/pAW3jausHip2RbuYXCVrmymd2U4yBvGKCS1L9?=
 =?us-ascii?Q?XQlzVwCqNAerY3Wi7T/BliJ/0aSXItmzRVbDH2npHDacofYap6SwiNh8sJT8?=
 =?us-ascii?Q?Q9UBK52bwl1M9zEr9FKLkDiwchKHzKGnTu1n5nuMcT2kCDKTTHmfZFmpIv0g?=
 =?us-ascii?Q?pWVq3PoAExzGP3zmci8ruDOpR38yKX6EwpOihicuBrUED5MsO/AdzOhl6UO5?=
 =?us-ascii?Q?N/3o8PJMA3sU9ZMly0ZiX/E2DEXC6cjpqhQPw4rH66cwkTnAvM7jGDYDtEl7?=
 =?us-ascii?Q?YhHDcYrJwysloE4oewanbcr822W3EN7stZiA7Dj4y5BhnqBLG1rFiCypIWoD?=
 =?us-ascii?Q?kra+2Oekj+n1eu2ZE1Ij/gDTbefDBgQ3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zMrM1Dtv1c25D7cKANgXtYUdvCwAWjhzf6VG486ul/o/GQs2nr8md40cYL5Z?=
 =?us-ascii?Q?SVeA5YO9m/+yQ2K4UvVTjs5/RYIWj8J0Zsft57l0VAYE6oYE0ma5JsIGjzyI?=
 =?us-ascii?Q?KmaZU5tJT4IHgZAwTnf/NUX+ZjkOYlIf5S+b2lpbc0gHpiNCKCpyhpFwTH0Y?=
 =?us-ascii?Q?KMLEtf2ts11DWjd1XG5Xc39LcKUF7MtSfgVfvCrlUv+DcyZmpjpNai9UFYRM?=
 =?us-ascii?Q?GJNDY3PHK04IjIB1U8RDzOaFIjBrpsu9MRSdC+bSaIsghtx4QG4PX5+hY1mm?=
 =?us-ascii?Q?P3ZEaSi8XC3AG/T2RRXoYpvlE8MHWRrMKPhHqk/KF8nE3ututpeIuaauR5Ft?=
 =?us-ascii?Q?NfrtgwKgSxD+Re85CEtriFjnlMhFBam8dUBAm73qE43mzSxFySYXZ/JBT2CP?=
 =?us-ascii?Q?FBi+Jrf4nOaijcwCI4GG1N+wEXiGM6DCZq3oqHAKotNTzYvkTI8Mea48Q+z5?=
 =?us-ascii?Q?RO1yOptKpdkTZ12JSl0ucN7mfFH8OvdMz97Yyo6hdUt71QV1i1vB15RBJxl7?=
 =?us-ascii?Q?MNtZbbfL3Uh2pxGoASRTXoa1UWED/oBsO26i4ik4xdmkticyBcwxxadbCg9b?=
 =?us-ascii?Q?d7bqcWYEA4jlz7YBxaVZbbXP061hdltLGL6+PrfAVbj4PLbUj4yNhUMpAvtU?=
 =?us-ascii?Q?l+z4ILSugZy6nJkBtxcxjvRCLEKk5bHHeJO/JLH7h+WM6lVjGNUaHNTw2psE?=
 =?us-ascii?Q?aHJXBa5PSx+kZ/UMO6m+GHFvz0aZHRnEZEHLMM2DtDqIOwYQdXZS67A2hsLR?=
 =?us-ascii?Q?2wlJKmQKAFGwdQUNWPfMKJwx1ZrJbAyNl7i/qMfXe62646nJ0H1q3MkSlfdU?=
 =?us-ascii?Q?He5LAvGdZvnymuBh71BvzK6mHvSrHW8t7vwqrvg9Nn5a4I1OgiwIPaEU9OE5?=
 =?us-ascii?Q?PiBtWyerz3DcavnFZPBAc4Riw/iqvza91D2xdoSSIH/IWtlmnSLSkUmCZ1dZ?=
 =?us-ascii?Q?5dkpXCxeyNNbToyI9OBeFvVC3C801Dys6xPqwp9WtpMq3QMaZNZ4t5AEi+yU?=
 =?us-ascii?Q?0WfqxWZGCzgrMx3peZUfeuv6njqNaahIr7b44ajolX5QebT3vHIDf9zFyqBQ?=
 =?us-ascii?Q?Gv2suSYUKjbAp1WTxZ+QLXSFPpzrEN1mBgcTkEp/nGn+hY5v9s2TaxnrkQ7Y?=
 =?us-ascii?Q?jfdssEyghhE3YT2HC9Ae6WQc4oGm5Uy8SGmyUsULsINSySqObV6JBbRSt1br?=
 =?us-ascii?Q?hzLMDDz+wLTHUQ1o1j5YoeC89TS6Bys862bqEzw6kb4smgEXNqnjDhaBgkKP?=
 =?us-ascii?Q?eZtx67H2gVGBTrbf7AjVqG/Co9/fS2NURN5KOLgUUupR8fDMkTwOwmoq5CKz?=
 =?us-ascii?Q?4kvdNOvyTzuHviwoAYCoPptAu/g4Sja/lPZrvwDAWUVGOXUkcTXhEmRH44sO?=
 =?us-ascii?Q?UmGai/hLlPosbNEYUSUQ1JQSpKzPC7z9l54/Dd1u9K0UTIYEvzGXQlW4UQMd?=
 =?us-ascii?Q?8JgC4R4E4/d4injZxn0dyRwX8BqQ0uVoBNSSsrGcOe+1fxHDEjbvSt4JgtuT?=
 =?us-ascii?Q?OfgKtrQZZwfaze2sIuSlZugIAVo9LkPj24Du895h965wZyetO8ErUiLu30uJ?=
 =?us-ascii?Q?7ZXwXbXX1esxLGrAQjDQH/vDPTLeHqjAABIE8IUX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4490cf5c-aadd-4678-6fc6-08dd4cd47293
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 08:49:09.8271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvjcg/9RrBruMvjEIsO0KJWD2KU6HVGdin7b5jJ9gmhlkG4llYzBOFIEsVG00vwNsSu+XOiRWO2q8M29odwoKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7368

From: Peng Fan <peng.fan@nxp.com>

Unregister the cpufreq device and soc device when resource unwinding,
otherwise there will be warning when do removing test:
sysfs: cannot create duplicate filename '/devices/platform/imx-cpufreq-dt'
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.13.0-rc1-next-20241204
Hardware name: NXP i.MX8MPlus EVK board (DT)

Fixes: 9cc832d37799 ("soc: imx8m: Probe the SoC driver as platform driver")
Cc: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Check return value of cpufreq_dev

V3:
 Per Marco, drop remove function, use devm_add_action and update the patch
 title accordingly.

V2:
 Add err check when create the cpufreq platform device
 https://lore.kernel.org/all/20241217015826.1374497-1-peng.fan@oss.nxp.com/

 drivers/soc/imx/soc-imx8m.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 8ac7658e3d52..c65bcc6a1266 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -192,9 +192,20 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	devm_kasprintf((dev), GFP_KERNEL, "%d.%d", ((soc_rev) >> 4) & 0xf, (soc_rev) & 0xf) : \
 	"unknown"
 
+static void imx8m_unregister_soc(void *data)
+{
+	soc_device_unregister(data);
+}
+
+static void imx8m_unregister_cpufreq(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
+	struct platform_device *cpufreq_dev;
 	const struct imx8_soc_data *data;
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
@@ -239,11 +250,22 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return PTR_ERR(soc_dev);
 
+	ret = devm_add_action(dev, imx8m_unregister_soc, soc_dev);
+	if (ret)
+		return ret;
+
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
 
-	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
+		cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+		if (IS_ERR(cpufreq_dev))
+			return dev_err_probe(dev, PTR_ERR(cpufreq_dev),
+					     "Failed to register imx-cpufreq-dev device\n");
+		ret = devm_add_action(dev, imx8m_unregister_cpufreq, cpufreq_dev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.37.1


