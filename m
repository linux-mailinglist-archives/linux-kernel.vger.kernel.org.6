Return-Path: <linux-kernel+bounces-361655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FE99AAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035D11F21AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317261C68BF;
	Fri, 11 Oct 2024 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HHnHdyM3"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2072.outbound.protection.outlook.com [40.107.249.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6938DF9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671210; cv=fail; b=O2PQ0dIxmd3/Ficl9s1BY9RcB0KDjcFqqsrp4mtc4L1vyEXZ+ObDeitThBU5gBzUm6Finqc1ApRcOA3Io14Ak9/2p7uI2Pv7xf3QQb7sMrQrUUb2GLcWfM7qr6LFYZq7dRTq76L0QsMAsT781MyxwFJSN7p0r4LtWp+AVzMk2hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671210; c=relaxed/simple;
	bh=5IoBanGrqphrbUsjzF+QgKbshHG5E1ryNOE7MZoSBFg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c3sLBGv0lXLdPq8QzOFg1ig9JpWrKMPstTKKO+3CcKdlaoaVjBPBJQkgpJk+fA6fztcZ9jwyD6kVf4zuZqJ5ZzDM+EKe9bCs1R2ACE9PESsXR3LhIZV0EwO9VrV0e7LXzdF6QxCeb4B5EIiIw+tjzgdEq74nLHc3uucbDZYxXaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HHnHdyM3; arc=fail smtp.client-ip=40.107.249.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKGNPHosVqLsvjbfzBCXOeMf17rlE+niKvMPi9hA6bo4Xyw8OtqThETAnP3i+lclWG1odzIdSBZtpFn0VwouR/2jtJcaX0d4oMQ6Igau2L98YPRCcGD33gTweSmuxx1xjleXw4xaMfuLp40y0vHt9dirMkrOPUzfXh+TzVl9AhD0f8VSqzcaHz3XZibn+QhiPvlHKvtgkHv1HZbeuyT18YYHZOApNzC3vUHFVl+z3MWRdyQwVCgZl2g6plpTFgMO2FdDYTLJa+Owwv5dpvE8tAPwdDlniIT4HcSDD7Qzrg2IJ+0Wbkt8Gy5kQ0cdh3pnS+QDw529Jl/4Ga+b9AgBYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wd4CNz8cCk+L+fhgI2chcn6YiK4VuiNGrvdgclep7kk=;
 b=td6Qye48SLHYM2WFAdLWI4tDCDbamxed8sYmXI2xL1pF+K+5vmjyp9y8zj59+V6+OFN8GK7QJYBC4cXUZesgdEIAZhvHtAZ04r9YJS3suhvIaq8QGK9YS/yQqHD6lOlrFV1MyM4OYPFQ7jBNrpJZLU1IZcDABhC4B3V+l3RxaHADtpeVnITf1Z+TKQro2HmVCyTwTHyvdBh9MDTmuZ5RFoY4bFNkBl2nOr/FbwDMN+mIYzZIK4Q/NfGKepR9Sz8eXrXsaZEhcU92i1X6swmGtTBLjrg0HwIc+WgnpbkcuuEBuFzRSiu7Ax0LuvM08IPVNkB1Jlya6lJLlzMJCU2OSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wd4CNz8cCk+L+fhgI2chcn6YiK4VuiNGrvdgclep7kk=;
 b=HHnHdyM3s0GrlpjHogcqFp+CKX7tJi5nmdqWkv0w79dnQnWnLdXRzjdoqEKySyOg3oOj/zbh6Ng9tDIrppoS6JXYTTRtC1zSRt9pRVXk7rwuAOm6kw4wj6vK7wJl79PFa4VbToHSd1AhQX5yqXDlwsRZSbWCaBXA8IHGHN8GI/AiVrLJrvRMIW7rFzTm6PP/1NnkZCZZgIk0mDEvVECQUpKovEBESfOIZXH22NWZIOPHejXskfbF7xUT3wMc4PBADQnJEDmf3bt++lH6SMJXnIi3xSxVmDjvUJHFM9COm0dAVaSRa8KcE09x34X7JMIYfDS4kg+FSTXgNQjvWyfssg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DU2PR04MB8821.eurprd04.prod.outlook.com (2603:10a6:10:2e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 18:26:44 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8048.018; Fri, 11 Oct 2024
 18:26:44 +0000
From: Han Xu <han.xu@nxp.com>
To:
Cc: miquel.raynal@bootlin.com,
	imx@lists.linux.dev,
	linux-mtd@lists.infradead.org,
	Han Xu <han.xu@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: add mailing list for GPMI NAND driver
Date: Fri, 11 Oct 2024 13:26:03 -0500
Message-Id: <20241011182603.346435-1-han.xu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:806:28::21) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DU2PR04MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a318017-bf60-4e91-2e8f-08dcea22421d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8/ZzSebw68xpD/dP7+wFyvS8SmLRpBhbfC8LbGRRNnxtTgVqz/QlO86l/17r?=
 =?us-ascii?Q?d+SxtxMDi7l3WyjFNpNXGmwh6HUfMzou0eIlk7vtbBfseeR+tMD+8J3mqmdv?=
 =?us-ascii?Q?40G01tmlTj8xXuXHB811b9A5dakQWzRZes50LMU3/eRtGAq0UwweEM/QrkST?=
 =?us-ascii?Q?k5KizjILNHJM6C+2OH61LAkNQtkS83ZANpI1PRy6BeN/DxWGAp8gN2PdbUjd?=
 =?us-ascii?Q?4JWVphUpg8RGI6S7VT6Ed0ruyOg33VxYe7OXBQIeHRbd8fr8uOwkTV+W/eYM?=
 =?us-ascii?Q?kGQfhtxCarz2cLIPucDfXFUHT/kY9E5BKqjJVCszJQwoPH8dRUdcWW3gLwXZ?=
 =?us-ascii?Q?8urfR9dnq9uZ6V5fBWUE52mlXqC5X/m96NgGEDSr3vclFwe/Rgx9bNjQ6BLy?=
 =?us-ascii?Q?tyWi+6wf7hXNT73Zxht5+pdUWdAJbsjwp32d9Fz88aXKCxVbDM+X6dum1oXp?=
 =?us-ascii?Q?ICM9WuvHqvm9ZLkFhY1jN94m8mqCGuAvroHrntF1EahuYQITQeE0Yavxx7Ld?=
 =?us-ascii?Q?2AVH4TKL+W5JVZ5kZwVr9iipww6MiWXnmULejQ5BxxzK54yU+UsMGL6w9UHx?=
 =?us-ascii?Q?D5EWk9jWwEsSXbbd6+ppeFhLrs9QoJAqj0V9N0NM/XUaUN3NFXoS7Y+y6xAg?=
 =?us-ascii?Q?ruzfg8tazoUuJhh4K3O6fbJTo5pZ5FApZwx1oq8pKQ421mviaDlPyqnZEdQ8?=
 =?us-ascii?Q?En0t940p0feRfw4IU0JIQXe6UG65zVg5KOJfB5tr/KYONObedUTdxwpeWJC6?=
 =?us-ascii?Q?9eiwXZ7m09qFBmF03qSMrQT2GiboAv07GZZ70HQdoR0QJ0OkAUMHTmfp6dOA?=
 =?us-ascii?Q?eRn5sx9tYSI3Bix8iAA8zgU99JipycztWkREDVJeSxq9NDoOxw2W5fxbAvLe?=
 =?us-ascii?Q?gm3AcVA2lqYeZX3fI1o2KekkBde1sbOLlAZcNIv3IzqVDEIL2sMCJVKBiQ2P?=
 =?us-ascii?Q?s7BOeq1fgoc0XWSzURVn5BTETWGokVW3avPFL4xfmVVg6kxb4kFZTl5Y2+Ns?=
 =?us-ascii?Q?VfR/smcLnxCNRu9WE0EKnSfqiLFOK7aMKIGFgOkdAjlJieeDEIeHVnnGHr04?=
 =?us-ascii?Q?WiExLxy5PaNQa0/jk+Tm+eXb4pGEij8QY/18Ex1fOSzZ/RDKjiZ30//wRKYf?=
 =?us-ascii?Q?NFY45z4oOvedsVZxgMyXXmJHZeXX5pFxYpnjPj/jZXdq/ujP0vHykNI5xFyA?=
 =?us-ascii?Q?t8j48fRY9nQc1E5X85vjKRf2ceSEjxoJBxQFukNf8KNSZrQl0za/jy8dpX6i?=
 =?us-ascii?Q?2xCCEFRIwnMPym/A3zZOkpTBOb6Yd/8j9z5mDra8bQV5y7HHwjW+jyidXV9J?=
 =?us-ascii?Q?LSSLlDHmPXQP60h16VhBRkZweIDyVGVtFF0AWIT15xps2g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q+yi51soj4rUJqVi64GA5XkzUJ7ooN+DpjNhBX4RQR0NP4Aw6DCcEriwYDiY?=
 =?us-ascii?Q?moSKVrhqHZjsSXfLqO577Eq8GrEw9EIi4Mwi75oZf62RSmBLSbX7LWvDAsHa?=
 =?us-ascii?Q?PbQml9cira09izWyRD+tgEcL/1CF0L8kwbXfk6+sSUY2OR2YOuCGq/lINF4E?=
 =?us-ascii?Q?71odQedTB2f26Ev3UJ4UXthwfwbOSDQV2Bp4ybeE3mYnABwbDXAqoq6Xx2/X?=
 =?us-ascii?Q?pPLUE7b5v4YEoT1PNwQeLUw0scLeiotYWpIxipDkTmwrAiHvdkPS19FGNntH?=
 =?us-ascii?Q?141D32nd5cAHSUVMSW7fY6sq4JCFX8rngqgajyezC2fRM+gm+EkwUcJf4MSi?=
 =?us-ascii?Q?B4gyDQ4zeWlNR/xLyYCQDn9Du3RlDfnRBa3sGY23mVNHvB3ADLsv1KWDSZaW?=
 =?us-ascii?Q?YHZCVYzNrtHj/YjLmlbxUXmodcpRHzNaaE641SlJASEm8G3W1ki+8O2mNFDH?=
 =?us-ascii?Q?JsJZtlE1jzg/UHTih8lr+d7dIJWj3wPmMvcXfCvvl5uBAqbY1o1Idz+BGsxI?=
 =?us-ascii?Q?MpBoAu6osElk10qFg7M129DPgjHHdjOZ5afRcNAQgrjonkh29tWC/s1aF2gW?=
 =?us-ascii?Q?TNHRIizVtoAKMM8+4y6XvWccz49mGV4/U7hyMQBbpae9ux87TeCjKs7UX4Rr?=
 =?us-ascii?Q?9OzenOwVPlrwDU2lak18hsA64qz/TAp2raOm6tryAf1IHHjOKhOsrh3jZY8F?=
 =?us-ascii?Q?iTWTvmA/INRqFUaZ0g8w2o44WxDd2ap2OGjGusbv7O8HYcoH1fh38T/Lvhsc?=
 =?us-ascii?Q?L//EpGi9DXjjtTGEpOlXEPlsAUD//p9bibMH+3hjOg4wn0mw2wPfBbxPpLj+?=
 =?us-ascii?Q?N/yPID9zE19oo+G9OY1fVq3uTtmPHeL3DLU/37cFNO1Yhmet8iCEEZxj2XXB?=
 =?us-ascii?Q?g2uR59xRPcrSZSscp6uutig0S0nlD2CPw+flxx5leBo+JYqwmEK0KZHelCaH?=
 =?us-ascii?Q?EGKn7K2LXBuzvjcCl1htOAWvvt2fYHGOpZw09SRDJtJbWBdc4WjRykz1/e5+?=
 =?us-ascii?Q?xGBkliE5LA7BfhtdKf70Nq5Fy82EHyzJ8vbw+VvAwfN5ozerIxbFH60yn0F/?=
 =?us-ascii?Q?KCcoGp2CumqLs4QJItRDI9/3cmVyw/SRaKL1YlfCQ9xOw8fFCGmq5L2MBQM1?=
 =?us-ascii?Q?ulotPvrtoucvHQ7dPUlBpYBEALHKnFH1WFxBL+rNnUX5ZuBLLLgKRplajwJJ?=
 =?us-ascii?Q?LfRGZ4LWosK7+suTD/5U/CWOhN2oszB83btI1OCDt4dI4sXiLEi0fAk8Xu9w?=
 =?us-ascii?Q?YGP/pOR/EEuOp6XTPhRHZaUCQUbpG5GZxYabA6yvEKaRJ40Xl8SfotNWT/cM?=
 =?us-ascii?Q?fPxioppboDxWiPKZKp4i1DXhhb/ggMiNvs3SweznkFEHR4Xn4DBHEgOgHEdI?=
 =?us-ascii?Q?DrEcyx2EfJnVLnV+8FjXixSKsRa/ltCuL7gKgpPuxysO+JxZyMWpdFU5el17?=
 =?us-ascii?Q?uzacCF6FqT9P4DJeCwuRg8GcnWMWTQEraAWQFGjQ0Z3QpSIR5nEMf5/Ka/Js?=
 =?us-ascii?Q?ckHdROyb6s6HYrLbcEGgNE8UgIVOQQXHLuQt6MSaFkggGrdAUgvCF1jQsmrz?=
 =?us-ascii?Q?kVsQ1x2QzFgM+VqZQ2+fEfvB5wm/rQ7vGBLUlhTp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a318017-bf60-4e91-2e8f-08dcea22421d
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 18:26:44.2136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Rj+T/7hEqliMOxBjNW6d0cM+phBEeJNIuJcOKyPilbsFUv6WIfO55ZrWCAAqK+X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8821

Add the imx@lists.linux.dev mailing list for the GPMI NAND driver.

Signed-off-by: Han Xu <han.xu@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..ee80982bd991 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8888,6 +8888,7 @@ F:	drivers/net/ethernet/freescale/gianfar*
 
 FREESCALE GPMI NAND DRIVER
 M:	Han Xu <han.xu@nxp.com>
+L:	imx@lists.linux.dev
 L:	linux-mtd@lists.infradead.org
 S:	Maintained
 F:	drivers/mtd/nand/raw/gpmi-nand/*
-- 
2.34.1


