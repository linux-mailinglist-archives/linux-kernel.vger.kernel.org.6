Return-Path: <linux-kernel+bounces-170185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C775E8BD2FA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D36B2810D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8715746A;
	Mon,  6 May 2024 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jLpsBhWQ"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C7156F46
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715013636; cv=fail; b=d1x3054B2W3/OXKuW9w3ZRWwmXeJ3ZcJVMpRF9hct2yqhrcpFAvBuQsREmnuT7qLHYmEpeTF3URcNeicXtrl7EV/9SYzdRCfqzfhnyLuxDX6Vjj7PWk4WeulN5dA6Tc+efmP3AT/24qG5JIoyKF7ZkYDGT36yeAyofowlxaJC9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715013636; c=relaxed/simple;
	bh=VbdnczW4le22G6E9BysHvW8S1V4llGJr0NVfCVxNEd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qa8BL+6xol9xRvD08sggupubuDU9Snh2qZXDlDPMmQIWjVGJMecCoNHDVQRyhLDcj1q0YDbityz4RwI5UElUtI0iJMrRolYUt9yS8jAMUungQVJwv9mTdFLDpXxr7steieefXw/o1yxjTvdk4QVrhyJPQTOlBArhxqlKkOobkjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jLpsBhWQ; arc=fail smtp.client-ip=40.107.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwVUGCCC3t0KsPFijnDflNxBgLPfKq0zz6KCkYH4T6JQZi3jdA/RVGY8PRej4ZZMIlUS5lHomYjfEPQoE2PvgtdOAWcagKjKyaZLTkkEI4Rc1R9G1pjEmjnIQXvH5lIdWlTPXSerCoi93khj71epUxRpmStA1vZmLSW3aessGA1U54wJ41kihVMIm6niqxbMQbRSKOK1FL+IV7JlDrc5Kh2l4WWH1+ItTWJWdWaX+73INdNtItvcX52W+DfJr9bNlWqgVKjbl9Qdg2DsHBOkLpleHoAFkdNN5GQ1jyVJt/EAdTFK21AvGUvHHVDc893aZYWJ0p4x8jeWXQls5ZdNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbvQuI+RZS4jJsJ68lAJ22P2VWHR5xpSScaRT/EAudg=;
 b=RnyJjj61NuzfWFjnSiW2mSLRIGG9sXf8+gEtk9c+xUC4ztL7CSSqYGO6Qu7aF0oGeExa7RLtra9RUh1X4zOa32MGiLyLz1xtuTag1e/WbzjMSj4gWovcOc+2mFroWO/QZYDlrs2yU5WRvfZG0TPtrX+JHcZz08BYe/h5V1kXY8/nJXgmj4C2MHwndpRiEucK9wo4nMMLUMFJ0/dsch3dRFl7/WvOSJ2AwgjwRKTIh0cn+jT44lIHDpObxpxGTlUQKD7abXLHQwc6vO+VKCtufQFRxMcFVmOHMdkUmdM0Y97R5KvTaXFcW/+YMo27CeC1uUOlp+oTLVrImKeOPq/dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbvQuI+RZS4jJsJ68lAJ22P2VWHR5xpSScaRT/EAudg=;
 b=jLpsBhWQ3QIV30M2iKKrBb6SN+wMTf9JjzeAUrZvIbG139ihkUL993dtbC+Q1A60BoEuu10fNCQhmmHwl6ckAy1/mxrHqxk2VDtkvFEoJV9ZpEgM2cDLlZLxXfUQ2b6o9o1bYt+mmhrvtM4AZxhBuORr9MVAnvonJYDLRPQPjJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9049.eurprd04.prod.outlook.com (2603:10a6:10:2e4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 16:40:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7544.039; Mon, 6 May 2024
 16:40:30 +0000
From: Frank Li <Frank.Li@nxp.com>
To: miquel.raynal@bootlin.com
Cc: Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] i3c: master: svc: fix invalidate IBI type and miss call client IBI handler
Date: Mon,  6 May 2024 12:40:09 -0400
Message-Id: <20240506164009.21375-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506164009.21375-1-Frank.Li@nxp.com>
References: <20240506164009.21375-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0296.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcc8de6-610e-4adf-8555-08dc6deb3e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|376005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QIQdGs/fhdrvuxoLLcYgHHoSVoEID3uUucIGDYLkh1aRq3S2ZWiHPbVf5DDN?=
 =?us-ascii?Q?zsU+08jZGEUkGitGVdWBSOWADU6atV1UnNRf9Y74boX/PGy3BUNkf1d0KxU5?=
 =?us-ascii?Q?fIe6CKCGNKjwmRLRWp+dYwRkYn93XiX/5lUhfrGAkh5dNsnhaSnw37bn9jUk?=
 =?us-ascii?Q?Nmcb856o0g3qYtb4qI60PfUCCR+zjDVzRuiQra6s2MDouYRAsaOxV5PgJHTa?=
 =?us-ascii?Q?v+82NtrbAcCn2+lI8WFHweIotuqpmf7/zA2wqNaIpuUjXYrVx02I6+rids9C?=
 =?us-ascii?Q?TX9urn/s8z3XfHzFpgYd2ux8B8Nl4fjENXXNprU5aZTiAYJgXe7qIkx0MYyD?=
 =?us-ascii?Q?DrYr6VRd19O9u03uJyUr9R4HzcxcUc5WQ63EaSRiHItQusYb9TvItlbxtY/S?=
 =?us-ascii?Q?fLgg5lRQvHwmy/BO2fPob9OIyBLJr3U4fhvMmD3dvfx6Q3+jCCf5AMV88Bzh?=
 =?us-ascii?Q?1lgbLi5zuktE+kFPcCCDoFSTJmLeQwMFcdEcyh5CJMS78/s4Eeiq/in/gROv?=
 =?us-ascii?Q?4IUPhKg9FFBiZQkPO/dMRsLRomTAr7skzPvdf5bwQryy2WjVo7Xwp4prsXo+?=
 =?us-ascii?Q?Fk4Z+3pHWdNjrN6fFcyL7bpdg2qJeT+/lmUO5UgDVvwYMg+2WeHR7z0D+vrP?=
 =?us-ascii?Q?7W3S2EM1th/94+AZboTctyROnA642n2kWKCXDht99QPkXd26Cd2phi8SDket?=
 =?us-ascii?Q?6AQSz9coRVzF8TkPxm0FW4NTvq/Bwfagp35FwGstgfDpMfMsB9UucEe9/PPd?=
 =?us-ascii?Q?w6XUsUOdUwZ72WW9G/0KLnCFLT5se3QhrWUn6gC87iGDhFALe9gM4RbRdfS0?=
 =?us-ascii?Q?38NoaPSe1Z26IW9L/9mWEqn8ozGtrEx7MuaMSu2ZlcsvrM94wTl6RclVxsUT?=
 =?us-ascii?Q?5WngGhXbm4CQpQ3j8tO0JyBRE6KdmF7xPbcqPfd+TXXVYjW4GtAUNle5k50o?=
 =?us-ascii?Q?tZYs/a/wx+6rwYs2sAWCDJGVksdJJNJbwHQla7mswxqnPccAgdlur9ie7VOj?=
 =?us-ascii?Q?MZF2iYBpwCFP3NbtMrOMcPGipFYBFc1wfJmETHYBaK8WaczjEzQq3D/1oAgW?=
 =?us-ascii?Q?+lm/XEw9n0BnRNTNYC+PWWQuCn6iuhttCWENT+VcJO/E7CaMrbRuheVUjkG1?=
 =?us-ascii?Q?ifhak8GMg1gtub+/tp1V7ovj2T0WfBwtoh16/xrXcwaA5TPU1E6o0ZQj2rY4?=
 =?us-ascii?Q?OD3UnfA1Wel5X16W6UIQUf5pSt6UlFcGoszYrw5oKxMOYoZPQwMDlxBYnk5D?=
 =?us-ascii?Q?NWcQaz8wzBefgyEB1sK6yuwKRRQk/W3SYzyR9o/g18B6k21o7PEBhbnTjtL0?=
 =?us-ascii?Q?QKjMPEvt4zPiDSLBVo/I2ZJ18agmU/nb9fSUfHLSStNLbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kqzO3sLF9Ga6mbYlSA96/3EfqPyW4taSin6j7wnUDiWgje8XrTlnW3qLLJKl?=
 =?us-ascii?Q?Jtj3AedJACBo0e8S13V864Brhqrv1McPMCNjvP8h81e8IHXW2MAs3FwTv3pJ?=
 =?us-ascii?Q?NrhX54IZXfxM/9O8pS8FUxMUQvGbwIBO+ewXAJnrh7EDq6NLHnnjqTQfXvA8?=
 =?us-ascii?Q?rtTQT4Pa/xImQYDjjGycFWiebEZ4BaiM3cRaFSM0GdU8yJadsUXikadpe5Py?=
 =?us-ascii?Q?dSRw6tdsNw0AI2pIcDILgu4jhot0XOf53K3cWVnJAMyw/CWMkqIqsbxLu87R?=
 =?us-ascii?Q?k1wQ4uJdM9vUWQxXen06TPcU0wGyVqyDvUDX13rHxcoqcKsmvFke5BIqOCkT?=
 =?us-ascii?Q?yn++rrD3HYRoU5yyt9oKfKhi6XjcTJkNf1/QGWbucZ6hGC+x1Q7A6Gg14usd?=
 =?us-ascii?Q?jzHxEj+I69ZXHCfIsAWLJzOi/RwtcsOj4HpyJvVemNh63Mq+ilIJrPUMAGxY?=
 =?us-ascii?Q?j5eMxl6Kk8bcBIIvv62E15ZbIy61UsW6AvUrWnMy6d3a4fYAXzY8L6RD0Acn?=
 =?us-ascii?Q?GRBR7ou4QSR3xDZ6rAk9ZpX/6N/Evu6kR2WlAfpjmTHY3lr6i1vtCxsPjnh+?=
 =?us-ascii?Q?th58916bXM+gRwm94UbfuJsMC4Y6FA8PCM5FxT6UTwXnd7mk7BrpcyZLa/jD?=
 =?us-ascii?Q?NmLhXHUBeN7vUFV0RMnY6QXXa3zv46Vcl0rZmErBacH0p73CVgoMXMmF8yJj?=
 =?us-ascii?Q?I37mP86MJ5Nnu8FoRALJOdhuOJk7OEjRGHN9NhliVejGA1BRq7mTX/1DFsyJ?=
 =?us-ascii?Q?CL0NSGJ4KpLkxN99DqJpMyB8lvNaINGZzcz5cmH0uEMWHY24cY/jFsLCJXvh?=
 =?us-ascii?Q?UbIIZe6AHd7GNQiokWVBcyB0cGzx6uVF5tPw+5PYESdbC8zcMRum7aNb9Jk0?=
 =?us-ascii?Q?2KYle0adciGGxZ+5LEESlFxQ95HnTp8EA+jL+gRz7DIGydlchusoO1Y/uG06?=
 =?us-ascii?Q?HJeH7xNSuIO0GTPgXf11p0cBpnxl1qd0twJgEJxStVjaLSRkcDhnFzvEzoPO?=
 =?us-ascii?Q?Y7+hySOopf3kQS/Z1bSUMkbRXb6t4I7pbkHcqxAuXffoL2N/iC5Y8ei4fSdV?=
 =?us-ascii?Q?jTeVxkKfbf4bVJxrk7UZ4AWkU5X4UjRw2Pml649Jv5FgFEabGd5yp+XsxnuI?=
 =?us-ascii?Q?m04085x7XR9oYC8v71MFHtSXJzhpj9dwDoyHDL/sNfwq4dayVYJMuODH1QHF?=
 =?us-ascii?Q?drWTHFq6OwMmMeIQieGvgSNQLpB1sz3BTtyyCyYkJz09g4Hm47UqOKQoIELB?=
 =?us-ascii?Q?A6oc/u1MIFP1EYuO2M6D8XUCtX+MFpDDNyFp5wDZW6mvEISzirspgM85SkWd?=
 =?us-ascii?Q?CK1Zo+cnjJSPNKZd7tJikRA2JehyILfHcbtmA1t04IZcKI5h5iqD3mB4MuV7?=
 =?us-ascii?Q?1i1v8ehGYTmPWrjz3Zgh8kkNJCDqsOEfIEBrpBuKc8LXUCMM3l61XVjRKsuV?=
 =?us-ascii?Q?ZhG32tzWG0qjHSLHi6bRdsp60hWkXzHeLsd+h41yyXtjJ65eajZpe+sBBcCG?=
 =?us-ascii?Q?jjtgBa47tBxGFSYCWTl56NE8u3fhu7cujfi9TpUY0uoSYQ5LLg5mG1987dg6?=
 =?us-ascii?Q?gnr+FyzqGZGlmY877K4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcc8de6-610e-4adf-8555-08dc6deb3e24
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 16:40:30.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U23bqU1BIpZ0WIQDYK5bwhEH++OLpwlLD045WtK4EgkOcqU5vqVvPb0W0scYClNdPttYGKBkCI83BXNTu6tMWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9049

In an In-Band Interrupt (IBI) handle, the code logic is as follows:

1: writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI | SVC_I3C_MCTRL_IBIRESP_AUTO,
	  master->regs + SVC_I3C_MCTRL);

2: ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
                                    SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
	...
3: ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
   ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);

SVC_I3C_MSTATUS_IBIWON may be set before step 1. Thus, step 2 will return
immediately, and the I3C controller has not sent out the 9th SCL yet.
Consequently, ibitype and ibiaddr are 0, resulting in an unknown IBI type
occurrence and missing call I3C client driver's IBI handler.

A typical case is that SVC_I3C_MSTATUS_IBIWON is set when an IBI occurs
during the controller send start frame in svc_i3c_master_xfer().

Clear SVC_I3C_MSTATUS_IBIWON before issue SVC_I3C_MCTRL_REQUEST_AUTO_IBI
to fix this issue.

Cc: stable@vger.kernel.org
Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI happen during start frame")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - improve comments.

 drivers/i3c/master/svc-i3c-master.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 94e4954509558..032fe032ec433 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -415,6 +415,19 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	int ret;
 
 	mutex_lock(&master->lock);
+	/*
+	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
+	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
+	 * ibitype will be 0 since it was last updated only after the 8th SCL
+	 * cycle, leading to missed client IBI handlers.
+	 *
+	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
+	 * at svc_i3c_master_priv_xfers().
+	 *
+	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_IBI.
+	 */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
 	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
 	       SVC_I3C_MCTRL_IBIRESP_AUTO,
@@ -429,9 +442,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		goto reenable_ibis;
 	}
 
-	/* Clear the interrupt status */
-	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
-
 	status = readl(master->regs + SVC_I3C_MSTATUS);
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
 	ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
-- 
2.34.1


