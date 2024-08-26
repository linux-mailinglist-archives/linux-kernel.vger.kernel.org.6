Return-Path: <linux-kernel+bounces-300881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 938C995E9F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1342E1F23A50
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867E1128369;
	Mon, 26 Aug 2024 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bBsnFpig"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2049.outbound.protection.outlook.com [40.107.255.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891682488;
	Mon, 26 Aug 2024 07:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724656060; cv=fail; b=UNl9uawGFhh4fNjuCxr98PbES0JJF0WVxNDin6amvOGO2/bhM37j2uhQHflj7KxLtCYigb2KiKNwlcQkntfbEt/rbdx1GX+1tvmLQ6WYXck7igJ7YTWduQRrG1+kBjyHOv5WqEo/1U1ltRH8iHRi05k5Wi592O0eb2+KlNgzKfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724656060; c=relaxed/simple;
	bh=/BOW4DzCFLJu0kLBeFbgIos/CbmtXXbW2fDhT1PoM1c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Gqm3JlZab55BUBYgDTAyl/86aPVTM/KjFp7yJribm5VYrq2cuh4kOD0ahXCtY5nmaTFSrGioFZHQ2K+x3rPySDMPVS3JNvF7SmoXqFDZVEEZmgSRudbcqLFJgdm2aiNbzTGDo3hryxYP4XEQxNRegt1Tb2xm2+q4BoEt6UJ+/0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bBsnFpig; arc=fail smtp.client-ip=40.107.255.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvQOWG9xbv1zTsXj5PYgKfsK160yiwBVHiQZbaLSjp+xwWkRU/fz3n53Iyi1T11X256d48yfKy3LrQwaJSmwaM4ScQboOt16mjT7lD0A9kz2IYF46lW5ot0CSA7RSp92EXp0vU2V6lsqvpgEstW4hxScJ9BGFiPlwL7lxq/FUA7OXL/HaIh+UI4pi44enj6ZG/R7CGdOcvnma9XM9RsFugYEsMDHKmZngYUOR3ZvKGJB6KiNbeOdpWrncPnaV2QyBcEedGDg9GETmC2jxDDOAqfesg1xhPiQ+yifhBGJNF+TipAK+5CtaDXEfOMt7e3nvs17ev9yGZoFz8tlTHlk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d5DCDW9Agf3G+YLTYCvIXEtXlu4Ndn4w6lfN196Hdc=;
 b=syA2tmQWCgtlVocRZXAj6shJLCBEbqZfWCtkI98t9+Wl2YACXBYMpSeuXE32pymN/+dLdbgjV8d+ijJ4m6Thpd+xkDzRhIf5NMtg6yiTCerljBGSRzLy64wlHmVJx1BRqbHMQCX//JuMNVKoZ9JPC1barCIOWhbPeqOH80O4i3/a/O8Lq5Lq0911wrySfgYeiu/ap26ZqACQblUpgpwwnx8ZIGA+3vAD5ypMDa9ip/DyWBZcf31cKU80mYv77+Ty6DNQYNPLKBHDuQl9goqISiifdlCluAqlvJZVY6jmoPrklENZIcwWgARiS2Y92ugfpeCmQsbwI5Q4OkOSLGBySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d5DCDW9Agf3G+YLTYCvIXEtXlu4Ndn4w6lfN196Hdc=;
 b=bBsnFpig/KLTjOHHUiPLxAu0aIl3pnv016vclAOej784H7gMo6HeIwWrBh3TcSSfi/TttYlRlF9Hergyt/KC7e75+ONwnpYDBhmbROafLCNZH0chcr+vfxriQpCGcE2vECqX7OK/N1UmvbajdE1FkEuP0Y+Lz3MQC+mr3bbcdQTpApkG4WjyeHBJFjt0ogQqum28sDJQw7OGLz0sdJ+BIS1DfB+O1eJDiuq89/ptQJZreYhAwUOS/CShlicJeCzUGGjNBoQiG30CM0GrG4b74MvFdS8bFnHa4Q6eTAXogkia8R3X/nGbKYLQN2m4X5h1TRim3w76Q/T//p025Web6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TY0PR06MB5847.apcprd06.prod.outlook.com (2603:1096:400:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 07:07:36 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 07:07:36 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Bin Liu <b-liu@ti.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v2 5/5] sb: ux500: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 15:07:24 +0800
Message-Id: <20240826070725.1953-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0313.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::8) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TY0PR06MB5847:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a3557c-fca4-47e3-138c-08dcc59dc339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A5f1YQ4fIY41lQscq1p4OMlYmQYcyE+9UBpEVZKE/QVPnoLv5Tia69G12drI?=
 =?us-ascii?Q?iVds7LJegxue+Zut2BThdvk4LLOhJS8wBfAWbJHTjXWGAfzcexyorO6a+GMG?=
 =?us-ascii?Q?k1141hWaf6Bd6mZKJo4d3OVzry25rMS282ThhsKxnth7e1rxiv0m3sm4ImaQ?=
 =?us-ascii?Q?Rvct30lMEYnTBLXji3W0vvAnAshhrhJUW48/Z84KNTILSYs1yG7IM7Snlx/g?=
 =?us-ascii?Q?JSGScCpDj9xowGK6oWOhZFuzKipPX+EqprAD5NP79yCFNAx1fmd1lkGC0ay/?=
 =?us-ascii?Q?THHnF2xcrCwYmesakETyGHTe4oamioqIkVKQBuk2VcCDHSAs2E3uHSK/zEqk?=
 =?us-ascii?Q?FfKA9nUj8Tmu4xxft3nwggzJQkALjWOMlFvuP7zRCDoHirIqjz87E4Dprkuo?=
 =?us-ascii?Q?g7HMIvxa2v/JK/p+z3oyuredNe3gmmIxW3P0fQeDRrXDKT/6ALeuBUBTrIcV?=
 =?us-ascii?Q?uPZRcaCHH+4z/2ffcH83P5SflklKxy8zg7NAmdaVHQ9NujjnOy45wL9fFiwL?=
 =?us-ascii?Q?fhlNdKzdYHsLVV0rDocOla7HJlDNmd9ftvhWdq1szIAGtUAqZ+aGHCHGoxzw?=
 =?us-ascii?Q?4wUKodscloB/PFCEBIu12YbjkMGpkZj7LpXSL/hGCLUjw6GuUcLLFuL7yiAj?=
 =?us-ascii?Q?2qY51sxWvqmT26YaRYE6YDKfpfmHUA0RK8k0t0IijAcKoKah2tt51c5noTI9?=
 =?us-ascii?Q?aBTm2OU2/76cVVLKEQBxbcXwMTAsKSRkihOaW6UebSgWmoNrmLHtljr9aNux?=
 =?us-ascii?Q?RYiIjgI9yaFYU6tPETEXGKOyM91ox2vkx65z15zv5awsq0nAFpIJ1axlNQDg?=
 =?us-ascii?Q?+YJ/yg47mCFn2ZTpnjoBojogSQTpfqGVSSItwlGOt1ch8hWuE9scv831HkZE?=
 =?us-ascii?Q?RfWY+vc38AtTkCyqNITNzzUkyhKg1kAB6eHxWmChaMXcPXbIzouFphgwVt8J?=
 =?us-ascii?Q?v0RnQ86g3cEGIuGsYQCPfGDYOVaxqHuJ59zS3LQJdtvqPtFHKIvK7bS6ecUI?=
 =?us-ascii?Q?jbanktUBaB1yGB8vNo8dtijeTpuZn4ZpmNVDkp+Ir1hT7KDAO/cON8oH67Bb?=
 =?us-ascii?Q?5c7IVeByVkDXioYwIoaqBKoUENSMh48F/HSJF8t947MSn/28Px95rN07Plhm?=
 =?us-ascii?Q?1Dob2y5FkTkxvZcgImRSjDXPq6mgrAxB9y1Bw+S4pxUDysM9pYF1u8O4lW04?=
 =?us-ascii?Q?mZxDBxWHOwMszqGPCNlUyxFcVTiyKJr8ZwcgYNTqgxZOeB1Pjonee2HR1FQq?=
 =?us-ascii?Q?RIykQcOzgTRCOvqcu7Ga154ijB1LYNOhkOSn3CUSntDFUo4PBVVMmWCsEywQ?=
 =?us-ascii?Q?nZR7piFSMJESu9WNJBqslFTblgxPprkmrBLx48SG1axEL6xaT4QHGcbMFJuC?=
 =?us-ascii?Q?l8AFonHUfnZ4Sb05lBMUB2UX1VoUdYUwPstIu9L/c97g4VQdwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xjYZ6WfKHA+TimKFH32BJcMglrz41zmAYyByE692tmhg4DoFjyA/SDiT7w3F?=
 =?us-ascii?Q?rFIYc02yOdo4B0VImT6JL0oe3n2ldegGIjmPklNC8kjyWtJO35Z5JIjqBPaF?=
 =?us-ascii?Q?3dYqzJmSakW7zBD9NkgAGEyG7qh8re1wgdnrHrT+0M3qQ6wOY3fDvXo1hG9g?=
 =?us-ascii?Q?D+p2DuQAUKs6RBGa8mUXb845FgwGE0hzmzbM71FIZNRgR9prOq8X4QdNaMr/?=
 =?us-ascii?Q?02qnT2G+mRH3rr5wblzfM+dySf6k89NWtDfpoeukr9jCIX1KUO6Qabqz25FF?=
 =?us-ascii?Q?0IxtMdTX/V6a7e27otYCQU2MoETLXg9bwV6G/HvwDVnEVUXumqC4l2oklmBt?=
 =?us-ascii?Q?0b9zdWC8flqZfCwRq4rGbsX7WDPmK13SLHpfGX3fx4NV0X88Tw4G5TZUHYvG?=
 =?us-ascii?Q?aBsRdLIQ0BkRPJ6nNyDcyq0p39JuualSFLaPZICgQLbHleiIsoUWle5qIPyZ?=
 =?us-ascii?Q?A7FYJ5VGB4pt18EDIpbkOw6bb/L8e9fE+kG7u1Wf4Y/1+vbaCKxJz5qHULhu?=
 =?us-ascii?Q?lC/V72fASE7QuVRva9zEKsQpagF3DammFGjxc5ckHNIlQke0geUh8+n5xHbs?=
 =?us-ascii?Q?ax7FcRiPdauF2AWIjzJeFw2jmy4WCQU1xvInOaQrk9vKmIf1YTPtB/Am4T4B?=
 =?us-ascii?Q?tBmOkaqhc/L9Jomb0e+DpaKpZ+wJmV6zTPxaU0Y+VHgiam3e97IxMH+GZRy4?=
 =?us-ascii?Q?XwXwGcpaBFZrWL5HD9WfslCH2zHbEErk0j/x+FdKnU5aldPm5OT9nhkxjNFC?=
 =?us-ascii?Q?bA0DzHjow9bdVrIQ1DaPBiye0Hj6aksfNQ/c+sQr9khs2Lpkj2ACByW7tOM+?=
 =?us-ascii?Q?9iuMXwr9J+TFwLM8mm1ZaKxyEKBoG9z81odyCPMmVg8U3pgsA6D1JaesKSNC?=
 =?us-ascii?Q?Pg4zMadoVCDt72060s2pXDwPElEEb1tc0sSdp9J6sJH7QcEjDRaYHEzGiSAl?=
 =?us-ascii?Q?xWmVaNt19/YZ3FDfSbkROF+8pi3u/r7OdfyCsJlhA2zSmRIKgNMGneRkxWty?=
 =?us-ascii?Q?NN54j9CEhwnSXmSZ2vtUxfsJ28QgMPIw+yUBWH117/8RJnDzjMguGgA4IauE?=
 =?us-ascii?Q?qltLUCrTMZA6y9zN4A9PB2rpXZc3VYjgavdYv2Vow0QEQwcukG7ZugS+zxkg?=
 =?us-ascii?Q?MowmOGrRijcd5cXK4EoE4B1zONo62/zar/8dGaJjmRgbzwzasNvBGZgqOXTz?=
 =?us-ascii?Q?mdZLwO7LOwjeJJPxWncUS57d9GAP05OXNUvQWj+qihUSH+BgbBYgpqaglK7v?=
 =?us-ascii?Q?4q2nW7FyoQBADR1b2+Tpl1M6+Xv5YGSqDfsnGO/iBQt0PY41oHXB2xYnMhR0?=
 =?us-ascii?Q?3+gJOMff+Ef3cFQ/Q+t3lMq1UiK3ihKuxVlILd/iwc3QV9hWOJGpIs+X8p5V?=
 =?us-ascii?Q?aSUUwry+4U1pMlulglqSkW3pJLAlQ42MADfiHI6qf2QhwoejFSK029b1bFUq?=
 =?us-ascii?Q?GT5wwh0g/+EB4zSEARoxRKocOAT4K0WtEKL12Skc9f5sa1F/QG/sgT6Q9RDx?=
 =?us-ascii?Q?tFDNXU4ZsnWs6jnASkzJdw/mbJoal0b76OvgZL46Pl6sXl5FQ5MOOTcZt8E9?=
 =?us-ascii?Q?nJ2A90zqu5VMihYR1hc3h9eVc+A7uwzgH6cjDFW6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a3557c-fca4-47e3-138c-08dcc59dc339
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 07:07:36.0616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD2mCVsQ1yvjK96w43/+xpNLYsJjLWcNEXurX8OOmzTL3WtzLGBLu4rlqstqTRs21bQ9tVbR/niSEJdpOtfmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5847

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

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


