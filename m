Return-Path: <linux-kernel+bounces-301059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D2795EBEC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134511F220DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E68A13CA95;
	Mon, 26 Aug 2024 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="IFWfaGEt"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010010.outbound.protection.outlook.com [52.101.128.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5911F13A88D;
	Mon, 26 Aug 2024 08:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660696; cv=fail; b=HbNxRZwYfWEN5V6lU2I1GXFXyGfmg6Q0PZgc1ABz+XnrZDTgywux2SPgF0j1HQn8A+cLZf4zv68p+ZfGI3hOt+5lMl3JHkVMKExjG5KmHPqXN9Ipzb1gbCJWzcjO1p/EwnV+qkcTk0r9bu1sUWOA8koIcUvAhwzb0v6JbkohKbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660696; c=relaxed/simple;
	bh=lhRHKkMsCs+VvwNGI1rWlr4gSdEFi7M8sMUhMg/oDmE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g4kr7keWq3PXYuRwc3PcR2mI98IcXnqQLexsC6qZiHbYa+GXK9uDmRWuKdky97qWK/fSNFdXvKnlU/Pk2P3VTWegACYMg3GxwtoVGL+3wHuIVRNpI6KANCwZfWeiL/MWcSdC/W7p/P/dKaGynuNutjGHr1D8lUj7Pu4/iKJOHRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=IFWfaGEt; arc=fail smtp.client-ip=52.101.128.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YakNK3PpVR/BOGYOMKqFCeZsRE1XBqxvQGvIWcVWBFCXitmuINJfkpHG/PAl2GJ+JhK8iBzlNbxpO3zyKXngcm9VHfos4Q9fHpYwM6rjXKWUt74PQJ4VdTSpKWHMmhlhEgYjIGsTfqLKxfE6PVQCDSp7OeNvmi9pF4Qi6u7fJdwXETQWUL/kbCdDAnM6l39GGBg2ArQqef7oNDB3Rf9ab22WJaWBzcy2mphsQg6LqielheRtS0Ub1OTdQ6ZdcDBq9vEewlp9Ox2l5y4En0Snd/OAZkOnnDb211uyhUBS20Mr2O7Q6Pf7xxL22Va7jvJGmROoRX9NeRZv00/pQSsxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qePtTVXheWDxDk8UnTBh1LVgdspIxgEpskAK23lNoW8=;
 b=juOL0wDgcLC/R6zF16Vbahxlz5kRz4ARU4XO33OK1xzisQSXfSo2qTr/vjFlyN0zBNGSmULoBvJRkTDrMXV9gGxhwfP44db4qgvgxM01VdzdxVWIZJpyqE2qXnETzwxRX8LBUEoLiW+t3df2Q2n0PLLYogfmnLiX3q6tuF4EyoiJX6VqBi5PSRp57ZQnpBn5vGUx637Dz73hdd6lvLKPyxv74P+LYtOQVZljR0Khcq11uxOpKL3J5hWj/ve6+pXZfbe8PpufoOkny7ARIRWJKxKRMwDqDr30XYhTOPiAdFSwuxC7zNn9wbLVb1z5UubUsrDzCg4x539/8ChnIZSoWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qePtTVXheWDxDk8UnTBh1LVgdspIxgEpskAK23lNoW8=;
 b=IFWfaGEtzZxDo0PiDKSk3EtLBJ1uCwvqb5/I5FYdsAQbJ3anYzNy/RkAosJvWWW+ZNrNBjZohoR2o4TDaPrgy0Khq8uQ2vHy1aJbBuB+ve+XxjwziEh+tL4ZdmUuh4QqNa/9BlYDsUM3jY5GqQW5nPsvjOApvWW8PO/BLqjN2uMmxoRUEoKNnxXMWQAOOvXnSFSDlZ6/LOmcJdh9ZTMKz6u9LuRNTrxxfaUSvZpCoK2LherNNy1t/VoZ2rhow5N8uC9zYJ/1jGqktGMwdeb1uMjzwFeMdU+zG0dZ9CVoXXbAF+Tf/3S0vIT/nII4TZrGzPXifwsLsCsbcCPnwUU26A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB6665.apcprd06.prod.outlook.com (2603:1096:101:17c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 08:24:51 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:24:51 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v3 5/5] sb: ux500: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 16:24:39 +0800
Message-Id: <20240826082439.2393-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826081900.2284-1-liulei.rjpt@vivo.com>
References: <20240826081900.2284-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::10) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 86c2b685-0d2c-4e4d-e7e2-08dcc5a88e31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nw+kp9eV20Z93wuZEIi1ecuDhXIul9qj+/vjvvYFyTqsn7e8q906t9zfOmYm?=
 =?us-ascii?Q?aFKmNOvFQzKYaoTCTBCjJs3VmIDxCNcQ41I6e25XQCkBv7hVSj3zWNBIGJ6w?=
 =?us-ascii?Q?jYZnDQFcvaTbvYJUcnjeZyQe2mvCAGrja6zwk8oaUAw8ETh51toefRCgQaoA?=
 =?us-ascii?Q?5L4bEBHwNDqgwK9A6J728uDHTQ2YedOSDvbB4WOkDQRXkGyiiITCO1Lc7pBr?=
 =?us-ascii?Q?lrsUHA9yH8Qjdy8BOL6T3PxrSwJhmaIqzBBRRUdTpHPYQIpQo42yCmKWPQy6?=
 =?us-ascii?Q?8qi2oZ5/3Hc8H6+Ne8tYB+6ZgL3iIZZCRlGTUp/dRskXMGJ702S6NSqNkorB?=
 =?us-ascii?Q?bHJ3ekTVQYOrWEa1NgjflEY7dKLy8OWmlvgTqLU9QGeVnul3Iy6qUvcjyy9v?=
 =?us-ascii?Q?dzeT/hSHVbLJtAM6Xj+Y5whAcCVl/ZClYkhN9BC2CScDLeGusp1JXniKC7o9?=
 =?us-ascii?Q?LyM7HQx+XwBU0fy+CERbUgy4HQvkXX+ghos6myeF/17NzwAXHGWT+JBf8R9l?=
 =?us-ascii?Q?XITWW+bWkDn8bP7UdDUnsJ15uJgD0t+Z17mLODhMTr5a9vwcFcyiFJxJ/MhE?=
 =?us-ascii?Q?GigQ5y1wxVmAU1xR9TWVncvTkR/vMLeSDJi/0kqYDiLD+n1a53qQUcg4WyiN?=
 =?us-ascii?Q?618TnV1PwecmRsWtezhLEQ0J9vsUcowXTn+iaExLm1O4bER77VLbh4Xe0+O8?=
 =?us-ascii?Q?EJTJ3O/KYOVQDG7VFuGGv9ICOPDKZlHer4Bdnly+XOLruzkKbhG2cxLSV3dj?=
 =?us-ascii?Q?Tx7EAaFKkPysKMSz4Ji/YNad6r7ntqvAoVpEEew/Z+/MlV9QodjnnN/ODuSq?=
 =?us-ascii?Q?j+Aee+IQwXInMBvIDHoFJWzNsyV1MJD87rCsMDUfpBC5OxJDrVGKZ4iILVyA?=
 =?us-ascii?Q?iqXOQZY55QNONxceR56fiKxKAk/0/osVIkc6i6BuiUXzlrId6yOGQgl0E2mO?=
 =?us-ascii?Q?cu946jOT/XV9BSSgEaNRzCKRM8hhCZskw5BOYAl7SbsBXW1U4is+SPSrwFpP?=
 =?us-ascii?Q?Orq9XgvHEczrSza/wq8sxJlFIJ2N88a6xbO37I8hKvoMYjgLUdbh6eeUaBbK?=
 =?us-ascii?Q?av37ijczxFu8xLISJ3z/DEYlIe06+JxnjTRI+3NnBdFC3VEoRWlF9TUDnX5f?=
 =?us-ascii?Q?d4TuE68PHbjcpRi1Y7bRSy858o7MM1jPh5nq+kWZ9CzJppmOFRXWO8j6fS5e?=
 =?us-ascii?Q?NPVzVCHFXxKk1GGkvrsSRxnWeLzNHTVJTuU6HxVdNc56t9/QFED+1cCbghTZ?=
 =?us-ascii?Q?QMusZDSsU57t/JnQevS2qTK+ZU5g6EnO96GjJf3vUO4fCEs82TBAiU+VpE3q?=
 =?us-ascii?Q?d0xXbJ0ahLE+WFxChKQs5L6sqwF13rW/OShhs67S66KkU54UcEC4YcCjZ4qn?=
 =?us-ascii?Q?wfhtmQC3vlb2duQ9LtsinO4uFY3+aqyNsQcVLsgR2MMcmQrY3A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rkJhB8QEIMgbxqS6PF4QEvHAfxkUNpDfeKAi/yzsVR2Nf0/FuizLhCJTGHEk?=
 =?us-ascii?Q?HrcpLTXNKpZKLQak/VEds5ZtB8am0rIGZv7n8OqwqyoteJXQ6Qz7by/B7x7L?=
 =?us-ascii?Q?gF5ZA8QCt/hWslZwwfII59Y3DqudqrFisrHUq8IcR/NanroYOHr+n7w8RzNV?=
 =?us-ascii?Q?gk5Zw99k3dtG3Wh/Q6t+1mcw2kVZ1BYfUWfxmUU/Qsbo8Yo1ErF+87IJfl5F?=
 =?us-ascii?Q?NgT+yPxb8SWLD3yWS6a33uLp4Csiv46BIr8QYotJGKAHg4H+hTEK1MJ96EbV?=
 =?us-ascii?Q?VRKo8ZDSKKNcOU2D0hTEyUg3wgyWXY5G7b/jiBmUkrwd4u4btby0MQAD8ku2?=
 =?us-ascii?Q?tSofHJQdD3G6GuXifi2ONdw4ekrME8uGgyl4bMT+n//9EzueYGpVRd/8aRzr?=
 =?us-ascii?Q?RcD3yIwD2xXcHFI/Lrqq7Ic4w4xu1Rc6Nvr85KKR3gftNa6ttLy3edzyqFp8?=
 =?us-ascii?Q?dTmkwdajIrm2NEpE9NNiTCd0YwKp7U0wL04b3+P7C4/vMNc6tw10dJ6a7ro4?=
 =?us-ascii?Q?nPtq8EcCqw0IFAi5LpZzHlV8hdSSqZtiicqrrpCuhPYHdZvOGZve2oQx+AXS?=
 =?us-ascii?Q?l9raZfjNSFPwx6xMmds2Eo7b+n2/Fgs4utH1MRmr2B6z8ELPb7KKyEwQxTBx?=
 =?us-ascii?Q?hcOD+mZmZzRqlL/Gso3oRxnOt4s+ZZ2pCS3RVTGZAyVhzT5bgNM7VMbdBJ5J?=
 =?us-ascii?Q?CzwKkJyFIC097sEBFFaryzX3hhiRiOzmwlsnl94JEynly5TdrwdPwrmcMgSV?=
 =?us-ascii?Q?ExbZ/iF3CD+Mpj0RTPNuG3MTqTNERqcqa8VOVWNdSLwxNlKxKntHOWHyEZoW?=
 =?us-ascii?Q?YKsgCDb2fhonwUhBseq4KPFCdIYlCokIxN0OOsLrj8lcJU/Qd99/sa+ZC2YT?=
 =?us-ascii?Q?nYuJIAExJChUNcrXQ/q68FyJhvsI4qcbeVRbS3zKjkB2qlJ9Nk1ptfclB1e3?=
 =?us-ascii?Q?VKTtGIOK9ovEHY/sWnirj1xOPKtulfQESqmW3IvPdFV1K5jl/jPPmD81cKgS?=
 =?us-ascii?Q?GAc6x5bmPjrpfwmv+J1k2/trMGmwF8ytFV1+jm4YCw22dwmT50IGN3AJHpCp?=
 =?us-ascii?Q?0xqIHn6tCKbcztrRseL8CKtcxsVC5LKv0sY0dEqpX1G7plzONHRsFwvtQ330?=
 =?us-ascii?Q?dqzBDmnvGs+niRvki+Uej1UWPIDsW4z71mOj4oWc884Xf/Qcj3s6ZQ4hjqTU?=
 =?us-ascii?Q?84KQ7S++qtGwBJmPmlk05oqNufe+v9uYaDgt6m97oli6CGH/6V930XmT8wix?=
 =?us-ascii?Q?Y6udrmJyuC26zf5U/ciRqPoUrRjQxwX0ZdMKvapxj4T5Pxg0tmGpkZiFwG5k?=
 =?us-ascii?Q?65CXJs1Dl56tNDXiaGlvS7zdarQ5j+e2C/D925Kbe0y03mJPnNqc2Uvo909T?=
 =?us-ascii?Q?Xv9Cxq428SxkbS9jNkHguumFCW113x3m8W8IeCcp0KMZD66jDYvvNREvcAE3?=
 =?us-ascii?Q?0uV+6pV1JI0GGqeTfOY7yDoHH2rYiS/o4dGMiTcObEnw99hInmjpPrS6PeN4?=
 =?us-ascii?Q?YgPbJRbXAv1JVjPlLiEKJRietZQKPGO9fwUETD4aRTB+u6Iy308vSKALY9CC?=
 =?us-ascii?Q?+fCjOaNPCzcJW8ohacqYNQhaBHi4tESkQhKaOcqW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c2b685-0d2c-4e4d-e7e2-08dcc5a88e31
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:24:51.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10Oe6WiQspJF94UgmQS4aWfezEiqO/9LhOzKcKzjH8QXqcVXffTJKzWp+/BsS1adsvLUyLl5szhu61jhgoB1kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6665

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v2 -> v3
Fix the email thread.

---
v1 -> v2
Incorrect usage of clk_prepare_enable() should be corrected to
devm_clk_get_enabled().

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/usb/musb/ux500.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/ux500.c b/drivers/usb/musb/ux500.c
index c8d9d2a1d2f0..3be00227a6f0 100644
--- a/drivers/usb/musb/ux500.c
+++ b/drivers/usb/musb/ux500.c
@@ -246,19 +246,13 @@ static int ux500_probe(struct platform_device *pdev)
 		goto err0;
 	}
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(clk);
 		goto err1;
 	}
 
-	ret = clk_prepare_enable(clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to enable clock\n");
-		goto err1;
-	}
-
 	musb->dev.parent		= &pdev->dev;
 	musb->dev.dma_mask		= &pdev->dev.coherent_dma_mask;
 	musb->dev.coherent_dma_mask	= pdev->dev.coherent_dma_mask;
@@ -276,26 +270,23 @@ static int ux500_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err1;
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err1;
 	}
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err2;
+		goto err1;
 	}
 
 	return 0;
 
-err2:
-	clk_disable_unprepare(clk);
-
 err1:
 	platform_device_put(musb);
 
@@ -308,7 +299,6 @@ static void ux500_remove(struct platform_device *pdev)
 	struct ux500_glue	*glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->musb);
-	clk_disable_unprepare(glue->clk);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.34.1


