Return-Path: <linux-kernel+bounces-340183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2640986F7D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 548C1B2449C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F61898F0;
	Thu, 26 Sep 2024 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XyAlFe5K"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011003.outbound.protection.outlook.com [52.101.70.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C54F208CA;
	Thu, 26 Sep 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341400; cv=fail; b=PFyuQemHEtEekyBkNrwYfw5UuLPYwfKDUIrH8KHItatEO45wwMXaT44HwkxooDmGljdZkR8tH1SKGjQbWwVqBHmWzDJSx1e9+RTKNP3qHco4H2Wdk23Qv2mcPtGgF6GJe0ztUOxNhofhuP7Y6gpkQgI6089GpEp3844ik6oRpm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341400; c=relaxed/simple;
	bh=ootiN2LTWWbeihhdQUVdCF1VM+mny3+SG9L6h+dshSk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LTsVtsqBu05E+6cRofp4W/grzPU25P6eXg7SQtTCdP+9P+KLtAhEX0GSM5azWy3dF2ShpwO3DLbibctCh1TftWjkrHb62g4ZEowDODnebEfiD9rZV2M2/5LgWi4sBd+XgfP7ojbCiNjzCo2ladZAQ3eeS1u2PTbt2NwElgR+Xks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XyAlFe5K; arc=fail smtp.client-ip=52.101.70.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YHgH+ZqxSuh33B1xDsowwmTRWNrbF67NLzo1JbTICMmK663WGxgcNODYyl0YJ8gyhXe+F37N8XZ6mPBK15tOgnAHfwvFejaaKmoii9vJoqA7xrYvPqZJfGQRyydkTVlTto27MOT2XsuGnQImXz42tqKr7UNDjNYpRGXEUqtWPJ2c7pT+JchH64EsnsvB0UsMxIixDllAuzASByhUyC47XLFIOIqdIzharg1/ClRQmftwxPUiFA/lIsWgvddRGXz+IYnVy0gUlaJuECSjSrh1HvBKe3w/XHc7ivh1ngy0OJrRB2/4GpUYL1k0xgtpCECPvH4l1Y4sJ7buQl3fMr5/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5reBg9mlys23xscMX4L7pKjIdvqgZ+x9V+jgATpCDE=;
 b=XCkSIgSOKv7gt9MF7X3CZt/FD+cDgUdDu7Hvi61n3S9OqA4dqG/Pb3TSQkGcUgk0ySW6xoxMP/Gfzr96uagox7Z6EJq0HZAmMBsM0AaXGHCj5IwOt43qcj/iKZn+rlJiqGZ2jotVvm7j/R15qXgoiVK+0yo4JbHe4Mmyw/LrA6erdvSfcT6Wjs2P1KDMzZmWf02eJzWK2fwvmtcJYeOGV0pYsPHMOKONRNIdGQKPCnHXiGteqBiMnuW1zhrC25/9LRk4DZujT0ky8GLChx0JYFOgOTXqgKGtDh/vh31qYQtntGBVA8GCLR3dYQ1WB+jbaDqQEAQ7Y3MPtMNBlavKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5reBg9mlys23xscMX4L7pKjIdvqgZ+x9V+jgATpCDE=;
 b=XyAlFe5KyqPzJli9kh8aHUMmnpS643wnoyEFgSht5SalCO5CXoJwH7QtoR9jy9q7tw6mvKXCrL1VImGSdBsuYmdrtEGdX9FFhJOKaCD/4V6owj7wMsP5Uakh9yqDTmVpFEX+ieIIHiOg790Jw2aN7xWSeilbFxXs+gIfq8+Pa00RkmTMIWhr4eph+Dxnfok433wcKoIdaU1wUiB9smtfn4oBwC7eb3zrBZl3ARE2zJDxD53yeNekszFuNldIu/IKJ9FS3Idjr4RAR1hXV3HOFEJGxXVkS+B1nq2ZkzbVUN3Rbh6xLziC7cA2ESZ1DwW1xO4FvLTyBDDxqsg8M1UQig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AS8PR04MB7670.eurprd04.prod.outlook.com (2603:10a6:20b:297::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20; Thu, 26 Sep
 2024 09:03:08 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%6]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 09:03:08 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org
Cc: sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com,
	peter.ujfalusi@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH] ASoC: SOF: ipc3: Use standard dev_dbg API
Date: Thu, 26 Sep 2024 12:02:52 +0300
Message-Id: <20240926090252.106040-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AS8PR04MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b45ed7-d890-491e-087c-08dcde0a0a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lsp2LplSgNIL+UmjN0oirtPqZ+64pvsPX/pS1JnpsFBWiVaDteIr6HsKiIqR?=
 =?us-ascii?Q?MFrYEQyY+6NdX/dOQPbR3j7hKSK6oCFwYfRZwQncdJzJBUr82N6LM02tyX0v?=
 =?us-ascii?Q?i8oovvZIZYFch15N1LC+AUI0kCYxiXRJgzhqBVw5caUu+msdHX80QLc9PKzf?=
 =?us-ascii?Q?LLKAbgkn482TTgVuD2bQAjYht+sLleVRSnIc+OzyaFXt2pZFNOATPROjgMGp?=
 =?us-ascii?Q?aAt3OwhthnUkAkDYR2UEe6MyAhGlUCQfp3oGjZXPaNBTENMAGCQ5Jj2QE2gv?=
 =?us-ascii?Q?gReoM2uIws/p2E2XH5H0stretH/3gtqPUKB5DmwKluDhUolTSFOs1DiNA8dy?=
 =?us-ascii?Q?jzdObSM2gUUEYa/zocEDcDwVtXKzySQhMjEteKDl13i8dQPBD0gZGbu7kZEU?=
 =?us-ascii?Q?WXbHXin15a39YrPB5US5Aubu6IsFd1s+m2t8SxhxmBQ1pIQ2alDNCQ8ijRCw?=
 =?us-ascii?Q?OeCV4G5KptTzzm5uLCRq4LPf43bYKusDpNoSGwNO5JTqw+qqrDw/LRRK43zG?=
 =?us-ascii?Q?inK5bmnh1pTx/DAr5urKBwSSWy2TinYW0VRYJSuD48sRIpyGfw7STvsBn19u?=
 =?us-ascii?Q?2NePYw3k4BPE8TjtRJpqhQ/ldugVdww88vDY5BraA9qgIQM3Q6ex+AVkrqUh?=
 =?us-ascii?Q?ZEjNVyn5e6hOp/eYkDI/wagGI4H4rUuQUue0lJPJsLk05jW6vQ6fojKFrlf4?=
 =?us-ascii?Q?wwpgWyat5uSCzGC+adCmOFOWQoxQyQDk1jDcCVtMTbUHKQ3O+zoZkUVG+zJK?=
 =?us-ascii?Q?eop+fOUVyEWJYHEgIVt6lgcjUp32EVwsODcaRrD30AYUex6UP34n3dj4CidZ?=
 =?us-ascii?Q?QkurWs4L/+Z8Q2ALKYR+y8t9VWpytZayyBWKHC2XoAFkPqdgnSzwcQ0f5b2+?=
 =?us-ascii?Q?qrj7u6x8z4t7XQbMHy0VPVWpeyt1x+LDyduFUQSnb1LDntEIJj2lpCF4VpIO?=
 =?us-ascii?Q?QX4oXWTFHKO5s5hPOlhWpwO9rxhPAkkEfaYzPIGc/dxYx4BfF7rY1ssgsBNg?=
 =?us-ascii?Q?oaObYwty7kDxiY4LYMSRhqrxmxnOD2Eh5nK26s4e8Fu+K2ovA2hvqWJlpKgi?=
 =?us-ascii?Q?nFopGNMWegRiRqMqYOUp0FFxHiL1l/LJOswvsWP/eAF8KL86YjY1viAUvHW4?=
 =?us-ascii?Q?/0z2/VpI/dR4t6RRtML0lY5l4PAJN3wD7zflTPr7FzOa9Kv+YjAhlQaj6GCM?=
 =?us-ascii?Q?deQpu7nc74whGo6TPZJx71NpmbpkN+R3bn5gCUiKFEpwErkcuWHSgXVhPg/l?=
 =?us-ascii?Q?F6dgPCrdIL8ropkJ2RpJYdXZvfdY9u7vt7q5JoBprhr6EMvpfIOcms4aKCcH?=
 =?us-ascii?Q?UX96TOZ7mmaSYjrtsMKf/v0cEm67TjTfJaEBhZRsYm7+SO3SRg2rCQS8FFEj?=
 =?us-ascii?Q?ihoaRSy3Wq++npHTZp95GYtHAOX6ykXAaBfS1w27vAlnwCQwpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J4bdfFxs/hSkqxc2qisSPxTw/kaGoKUuKMKwPYuzjbNnZAXW2OmbPDw9ezKL?=
 =?us-ascii?Q?dhaahM1k2gRKZd4Fe0bn5sPLkKGUZOGyZrgcCGA0B5xnvuKfP+Ks7oU16a0U?=
 =?us-ascii?Q?wF9h/MV1Wx1O8LUX13iUPYNWTvwLC/F71V/e921ppmikBKgihHN6IDGxzUBS?=
 =?us-ascii?Q?Bfy85mTzXUNKnwJDJHbGtdCVX4mBkAMcS7a0LQJ3sM3KBAw3dIY9lmnnMLik?=
 =?us-ascii?Q?rzBi7SHbFzYY0VjYtO2U4GZGMk+Wl4SKRyCYry0z8bC1P5Bj540ZBbrcYjQV?=
 =?us-ascii?Q?JoduE7ycRG+OCATD8vGL+igWckLDXQ2gm/a5LM2bd8wEWEBgNF1RcjjXpL1F?=
 =?us-ascii?Q?HCSFghyXyxNxHXAtJ9PVTHnD/zeJbSP59BVQexcaL94/fMLee9GtYOAikCPD?=
 =?us-ascii?Q?nFPTV2QHdXzHxvw8um9AsYNqQ3U8041XbZvUrmJHz9B3Zo4+IhdCUrGN/4bA?=
 =?us-ascii?Q?eMYyDJHzorOwU1DriRCY/JHpK9U03jMTpVMb/GkxU6rxBNMH/VEr/kH+VQ+B?=
 =?us-ascii?Q?07dtP3cU8KWdJ5yNr5kEgMPu/XktVu6bmOoyqE317KAlfnhJ4nx/pxh1Gtf/?=
 =?us-ascii?Q?Huz/IQP0PxM2zU42xqSqEw10Zuv6fGDbIUICclqkJoRb79ElwouQuyg3Xnhz?=
 =?us-ascii?Q?iS+LUKf93P/MZ1lh1s4wvcgWWH9c6o8a04BVplC/zdIiHRChV4qV1M8/80Da?=
 =?us-ascii?Q?3H7EOwbYjyrTYtH8SrWU1yX4Xyxy5E7N6FOAN8CZ7X/nBgPjO1158X9a4VrG?=
 =?us-ascii?Q?0f6VeJ51CfsXlXy4MNB/mTlz+8iQvvvLECGzIpbUvi6TbzyyvXEEQ+GLzol9?=
 =?us-ascii?Q?JaD9wEDynfQnMiOFqwOgdYVzc1pkfzaWsaZbFOK3pGL/tfOIbHACiBJfd8AR?=
 =?us-ascii?Q?FmWvNwY3OdXsgFGiJa17Zw+4K2PPVHqDFPdRuw8QS29m6NbWHimbIzCKIRBh?=
 =?us-ascii?Q?3MueDEtyMB3HblmydGqB823bhy5D7wKM1PonrLpOTW9TT2clBNpAnvWZGEWY?=
 =?us-ascii?Q?nf1LSMMI5bp/VZ92lRpJ3Be/FqPfcoPjzXaKvoVhLpSONA8YvdF104u5kKkC?=
 =?us-ascii?Q?DNWjpmVLaIBUAw9alpxXKYLxfM+fW0ECJiRu2CRFa2MIh8T2xj1PN9fuel+a?=
 =?us-ascii?Q?ljRadvjvDkpo+qmEB6UPk2Y1QzuoL6MFRasPppLQJ38gLU4/cYuoCiU3yjoy?=
 =?us-ascii?Q?cqjQKAIuqRMlUd3yFq1J8DEmb6KZrAu1TqNdrEUt5uI6EYq5Jzs9ZRcx7FYY?=
 =?us-ascii?Q?Aq+Z1aejSbVdR6LT5t7aGadIQmAxYDsV8l1gTEeQtGS9q/o5KsF0UPN/VhtF?=
 =?us-ascii?Q?Zne1eZiKRtt7AwnRq2RWo+ogwmmOjjTxcu5ydraxIwtKNThH6jlTYNdfy2+/?=
 =?us-ascii?Q?Ec8JzBM3SFLeopmMlkzcYJa6iTPYedsAVme+cF30E4Fj5uV3V05IYZlKtZWt?=
 =?us-ascii?Q?dKz0NiV03VMgo62cWlfqYq4aGL48qO9iObxlXOCkwy0L8f3NiEmu100c032w?=
 =?us-ascii?Q?eUBv4UwvgF4E+ptNQAhwSVEBvzYoEBAJwY6YDaQnt5TBc6EtkRWB7GtgeFn3?=
 =?us-ascii?Q?sh/YhkL3V7HxyA0TXZUJErJftyQLPyP2RR5xR1v/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b45ed7-d890-491e-087c-08dcde0a0a08
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 09:03:08.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oay3uKG1aHiwRDSGTVvbHIIApkW983Bu6Lf/BzyjaQ8iLLUd5uiXvxGRjcV7KcGgMIRsxYz5nNjhusIs8WtJLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7670

Use standard dev_dbg API because it gives better debugging
information and allows dynamic control of prints.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/sof/ipc3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc3.c b/sound/soc/sof/ipc3.c
index 83c22d4a4830..7de5e3d285e7 100644
--- a/sound/soc/sof/ipc3.c
+++ b/sound/soc/sof/ipc3.c
@@ -226,7 +226,7 @@ static inline void ipc3_log_header(struct device *dev, u8 *text, u32 cmd)
 static void sof_ipc3_dump_payload(struct snd_sof_dev *sdev,
 				  void *ipc_data, size_t size)
 {
-	printk(KERN_DEBUG "Size of payload following the header: %zu\n", size);
+	dev_dbg(sdev->dev, "Size of payload following the header: %zu\n", size);
 	print_hex_dump_debug("Message payload: ", DUMP_PREFIX_OFFSET,
 			     16, 4, ipc_data, size, false);
 }
-- 
2.25.1


