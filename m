Return-Path: <linux-kernel+bounces-272879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BB8946231
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 19:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DAFB21B5D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821B01F61C;
	Fri,  2 Aug 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gPONwnhh"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B412E16BE14
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722618066; cv=fail; b=hhQ8RfAvzd2a1xF28PJUOebNWa5aLRm4kzVu0/p0/z5V/bAk6HevMNPpcYGpxROJZdUgkA2+jcFf/dbw0eGyGZ1qaoVnBJKMt3+Vq/IVh0NHFiYyf4OBu+/STEkWStndf9Aaozg09RmD2h90tREbkLuGK7+qdEhfofe6tUbuN9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722618066; c=relaxed/simple;
	bh=eF56HF5tAL06gaLRQFAx2/hUdVVqvDEmDOfGQX+IecI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YkbxqsRZPRoSOj3II9EeJjUPRiqg+ITXHG4nAWC3XF1cZWCjBJK7usgfEhEiXGQ6UU66r95xo566RA76IEcxG8cbyeAlS/tiE8nXEOWOTvXO4Y1u7wUB2NDku0+b08lm5it7f0HAZq9Xf5wfqTZVLVqat3n0xzSIUnoTXkK5/yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gPONwnhh; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFQUu/i3IYgg2TCJR6dg2hVUtbxF5086TZUZ2PwyWPB7XL3jCsIvWX4CGi6RWCiaYF5j5mvUFF882WyBr4DxftHF6utLrTXiMtxrw6SDWlIsHOsM6N3+Xo15AnRbAVDUZhttVqJi5C+3sPH4cOcWLW3UjEZBSbAAwxnYsg3fleP1wWEhIs44eW85ksO4jfH5ADiLHKdR8PaRXQRY2J01mDXqu5IQxi8NcWDUXB1hOqa0SO/K5ZJUVvEGauiNE0xWvxojkjUW8NMIp5n6o6Tk5M/SezTW5zYZKjPktESG6DGEnQsgki9MfihZupPErIoAu9DZIpt8bWx+YWVG9D93+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQ6f5uwX2rUvdY4UFWIukT6zPlzeQvKl96SX4qqxlJo=;
 b=Fm/y1cN7RxPQ+FW5ADpL3XGdwCg/ENp0eiicbMSGEo76XDf+sjY3cDgmT15WJ9KOdAmBdUkuNgTxpIH0H/hvaDeHwSE3Gs5hZ6S1gZz7CsKuVonZyJQK/zZgkar/C+0URcP81+NOOKMJvDZAHwCckK8ROt6avqJaI66DxioCR3NwT8/H6OOU7pLn4uQIGDVN3+0UUOoYqEggtpSFC7Ht9uxYS1buk/84Diy66LoSJv9QUGq7Y6z9lu5M5FwvYoKXdNQQJ3p8KpMTg4uhizqJIIb0Q4hcRi1lyZiUKCZ80iyPlM0qvmqDO5pQRkjWENpDFZh+6ba8cXO9MOM2mxXAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ6f5uwX2rUvdY4UFWIukT6zPlzeQvKl96SX4qqxlJo=;
 b=gPONwnhhmdY/+rlVZDaaludzI40P6zWsdFMA0eZO7vyyavqjFkrTObqcsdrjRj7+YgZg7j81yvgdnXua0rhiNoY0OSuEh7n97WM+HdvOtPzwvDgwm5RNFmKT/YxlEw5Mv8XJTAXMxLLC8TESlQJTQVPzsyyf+1Mt/x1yRgVnUX64M9QgcMyeJWVTJVKp7u/VaikQm2J497I/JX+jbUVK2SuzwA4QPHOt4GVCCpC0FECEjZx7aCKP4Wnjp/EQs7Oyl5qx3nFl5uVV1c02fd1o7AgxfKyt8SiNUUFnRlu+F3JAxixGPGm6KRQmggBizzkm4pfWzfNm0ux4L75DU3UM2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9336.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Fri, 2 Aug
 2024 17:00:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 17:00:59 +0000
From: Frank Li <Frank.Li@nxp.com>
To: arnd@arndb.de
Cc: Frank.li@nxp.com,
	akpm@linux-foundation.org,
	ast@kernel.org,
	imx@lists.linux.dev,
	jgg@ziepe.ca,
	kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	schnelle@linux.ibm.com
Subject: [PATCH v2 1/1] linux/io.h: Add cleanup defination for iounmap() and memunmap()
Date: Fri,  2 Aug 2024 13:00:43 -0400
Message-Id: <20240802170043.2809545-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9336:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bd5fd8-b47c-4863-99d1-08dcb314aef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?61JVnO4kLkaivqAPF3SwXMR8lO4hyE4Ipm/DEmLN/YdzfXnKtXtgoGy7w4m8?=
 =?us-ascii?Q?IyVWcoNNdPj5QsKAdSgr+tm5o9lCRN/MWX5O9xWujhWyvANayF18yQIbCEag?=
 =?us-ascii?Q?h/towJEQA2lk8ZC96ai89PymqEgVt+LJXWTNQPM1ObDzFta8q6b7DY6kYlkG?=
 =?us-ascii?Q?K1UdrnC0YdJAunC/iP7TPhkUiGiYGQn8gUKJ5CLz7WKUqSy9jFGRBYA0Xgyb?=
 =?us-ascii?Q?sVOO63EDdrCfdav+rZNICBlmFG9Rqps+mAINadNFgedbq/Pk4huOWeNk32++?=
 =?us-ascii?Q?YN4KaGtCfNvdjBFfQE9SdeA5zAtQxEEQFTRbJCrsXTnL3h6pkuyGcQDQWzMc?=
 =?us-ascii?Q?WG41yDp4YOMkxVYSyhWecVhUgPEpCSXz0OFrTqvS1MSIsTI6i49HF/meKpyB?=
 =?us-ascii?Q?c+5mn/Gqw/3JM+zrSGuKXeZocUydojmmrAF8lPvhesqHsplzRUJl4W5ET2la?=
 =?us-ascii?Q?Iak4TiploU3RzbSO5t28vBWWux8auGe2UGozh+BS4nyKF8LL9nffiZk/eNgY?=
 =?us-ascii?Q?teaOG40srgiGeM6uHUZDPbbUuanT/sjOiIIvoVp1o+88uMGGlVWt3FZLc/mT?=
 =?us-ascii?Q?5hPhuRSq0QS7axs+JFv96l7mJVn/nO48yo6wLpR//Do4vpEHr/C8rQKQ7xQA?=
 =?us-ascii?Q?CnZHC1m3fe+sItpN15HMs3WJ3raf2PPEMcOjkQnbG0gZ3+rT6VWt0GUSnebC?=
 =?us-ascii?Q?fO6wDs+3oU8CxLeA9QRaFd3v7MkbTvHU92cr1kKW7dOK8WqDuink1+ghiPHG?=
 =?us-ascii?Q?B3LNdvGo5AfOCtYGyCDr5lQQCQVbSm17sh+GMMbzpMJ/ChWLOJQeXlBrs184?=
 =?us-ascii?Q?JeLJzwKyNmr/J4CVkKUyAPNO+qrBqmZ7yIUGchzhUnG7U3JSCuo21k0fc+GM?=
 =?us-ascii?Q?O68H8ScakwZXMLYintzLjHqTblHDF/WM0CggZtSyZUdv0S2sbptsWPX0vmgT?=
 =?us-ascii?Q?Bspo6s+5V7Iq1JJytxbctOVPAhx11hXXBPnhOFEjB5ZZeiFK5BNhMhZ4n2mC?=
 =?us-ascii?Q?XEOpRWZDF+PNQokcpSUTzp9KzATrGVf+1jKsHmfj+4Lmd7Mv6BLmTM15BHT6?=
 =?us-ascii?Q?NlkJcdVtvGTO7BsTzdgep1xMlHKCJlNY8ehIioL+KeVVdWyOvQMov5MCobgt?=
 =?us-ascii?Q?uExe491zL/VJFp7Z47g9ZdyPyy1sJ7KNbqdnsXFfnW5ULI87W4BhAU9gjdyO?=
 =?us-ascii?Q?WIF8EdkxOJhuAVe1BvqwJQAy9U8pHOupA2b3RHhOUUYILLwd3LiR2WEdZmVs?=
 =?us-ascii?Q?qzkgAahTxXxk4F5rAM3cr7Agp5NkFn+nV+CYpNPr8z66xb36MpWp7BgLYhmF?=
 =?us-ascii?Q?XrTCOk37uE6LeAvwrtaL1wG9iGqa6Pt5dLTX2Vb+vQAloShi+3v+YEHhHE7H?=
 =?us-ascii?Q?szc1z3c+afYk0oEzcHfsvcP5aX5OIEuYttEhjXAIViWZBpTX4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VId6XCArZU9ttazUI9rg6Z/QAEQizsx9PD7A1Mv9F6vJ15bRwGWybV20d4d4?=
 =?us-ascii?Q?W+RlnbXQyAVvzzIDGRKh4p97zHpGuL6+fuh47I6JOxMuETzp5QycXvBEMGRK?=
 =?us-ascii?Q?AyeHy2fqf+weAZP2uLFO6WsEA5TnOYpN63VokzUnOL8GC64dKTsDcaDBYfp+?=
 =?us-ascii?Q?Ln0sUH3h2m8bj9z60mW4zh8MmTfaXjCWPJOXY+F7fYiTa5Fv2xv+L9r/rIYo?=
 =?us-ascii?Q?Ba+z8boAy93oqCRimKBRxn120zE1ekbuOb3AhLBIGt3PvVbUp5aYlFlh07rp?=
 =?us-ascii?Q?iM8Y244PTcwFGbhy1Vg1CJttsDb/QrVZBfAkzqAI5rta4W+jLGdduii1AHwq?=
 =?us-ascii?Q?Ulw2LU7zWmRqUqx6y4xG6u0MQKsoWkvam/PQ33aKBTbpsuOe+WEPBEL8kxjc?=
 =?us-ascii?Q?7q+oZCFzZiOGTY5icrZLEkVcPrE97q35S5rfkfJo2LN4nripWWsunNuIaNt4?=
 =?us-ascii?Q?1gVVp0D9EcLooizaXWvn0nhyhY48v7EMzU8NRIdBf3DWIF95GLfXE23FdD+J?=
 =?us-ascii?Q?W7lVNjhoj1uEEaUnoOcsr/x/fqxBQab2oz2S4N+TNiS6Uxd66ep0z+UoApmq?=
 =?us-ascii?Q?TRyJBne5u3AbJikD7Fu3m26LDp8eRfhW2qRiU4SPZnwx+HwzF/LQDPSJZLG7?=
 =?us-ascii?Q?XbxAzst52SJ31n5EV3q45Nje0nsWkg8KKfOGDtQUvJknwu0B1VMHTjF/WISS?=
 =?us-ascii?Q?cUHsDwEi8HmpbnF7jIP7ZbNhHtm2qkEMZyk6z98ifrpTPjK/OUb/ucTSECNJ?=
 =?us-ascii?Q?mKMsgZmRQ/cYOywAzPGCbDXP1LmBMEvvaJ/iWLyLsTpl0FzushHhiTfk9S3W?=
 =?us-ascii?Q?ORa+jpxHMbiI5E6oSsgpnEA2y7tjoN4yfTE7ucTim3YIdf6gtVxCE5HYUDtX?=
 =?us-ascii?Q?156QakssmZJtxDZ3QH9qT7gTQnABsOTttVIqjeOZS0LUC0WNA99Hx93RORWa?=
 =?us-ascii?Q?H9O5uoRYPzH2gR1K0EZ2YwxixukRGyj4Wpnxf72XSpbZEtmDcXg9nYmN4M5Y?=
 =?us-ascii?Q?CEjSIlqS8qRHOy5SSHRUWGWe6aItFAErG20P512WVsxs0lCPIVxCX6wnIy0X?=
 =?us-ascii?Q?KQPRSEA4jcWXepfPU0ijiaDUKR/z+NB08TS95y58ul7AWxdMKGHOhF1KjilY?=
 =?us-ascii?Q?fTceYvZO9AmY5/XXIzxi5qQ2xoqZihU+QS3cHAiSCaIBI2GGqVdXLirPL9lY?=
 =?us-ascii?Q?10n2EwhJQ6LVRGkzopyeEbtV7dhdBrLlNvW5lLCSRPGE08cLMup3b2uXV+7E?=
 =?us-ascii?Q?C5kcyZJohLhJRDg9z0fW8PRoG3nKcywoZOsCkWp1l99bpsscux/Gzr+u8sNw?=
 =?us-ascii?Q?5bvcmrdWIB3EKUTFMJAHETRHxpdM0sSZlE6wWvM865VpphCTDBIjlAAo8apw?=
 =?us-ascii?Q?1m9pbc4fveeJCW80ssq1Ki1tI0Hm1WpV5B3ayNO2nBwZ013+dGSWzUC3Ibr2?=
 =?us-ascii?Q?pTDzeHjSyOkXqGZAdi554nwntr1vwCiFs0RhadDR1Xk1urvhHgsJ5fGMzsK3?=
 =?us-ascii?Q?YQzIlRhOhw8DYO9matQY0hbp+vQKHS3xuzZV3EZFFtJ/NvHk5di9TxQ1AgVB?=
 =?us-ascii?Q?7P510BKuAoveX0fxKF0geMEO831I8TKmqs4G4enm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bd5fd8-b47c-4863-99d1-08dcb314aef5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 17:00:59.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4P8YTlLgZ7agqQ74NnLflgMP/rypCCnT0V9Hi2ZymnoIpiU3qp4PPTgze9pbKk2j7riosj9eJHHXdO6YhgNBUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9336

Add DEFINE_FREE for iounmap() and memunmap() to support scope based
cleanup.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Remove IS_ERR_OR_NULL() and just simple use !(_T)
---
 include/linux/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/io.h b/include/linux/io.h
index 59ec5eea696c4..4cce787d52805 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -163,6 +163,9 @@ enum {
 void *memremap(resource_size_t offset, size_t size, unsigned long flags);
 void memunmap(void *addr);
 
+DEFINE_FREE(iounmap, void __iomem *, if (!(_T)) iounmap(_T))
+DEFINE_FREE(memunmap, void *, if (!(_T)) memunmap(_T))
+
 /*
  * On x86 PAT systems we have memory tracking that keeps track of
  * the allowed mappings on memory ranges. This tracking works for
-- 
2.34.1


