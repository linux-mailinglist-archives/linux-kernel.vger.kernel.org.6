Return-Path: <linux-kernel+bounces-568014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CCA68CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797BD189010A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C0F257425;
	Wed, 19 Mar 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="lXqietPp"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7A256C9F;
	Wed, 19 Mar 2025 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387484; cv=fail; b=IX1WEgZ+8YjngT39M/kj8jR62BVtgli9I4db0R8gKkUNntCKmtYhi1ovM0mtaIfIOvGyKBJ35GhlknwKMIghaz6f/vLczNuyvASb6ERZs6ehi5colN3JsafVFvwx5E4RkQ/BYFJD1k3ISExSoKmdX1Em/xQMM2fLKwK0SWDy2A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387484; c=relaxed/simple;
	bh=VYswblBai4dr0DQ19Hn2P1pTv3IDLFNHhEm0xM+qlu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OrKYfJ+pAT8FeynuHXnmsorm8YItdZivucUqwrp/6KEqHuTg4bQwQY2Uyf9pDq6pfGxvxM9kWykVcodqqlq7HsUefOWLqRVLzwM9E4eZyY4nCqFbblmq6Zm5fSnqHyd0yw6GRkb5aYKBOetDdjBhNhamxtBZKx6d2eqv2/iEtaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=lXqietPp; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI6bETysyJuGgYbE0bHsMUtwYuslBuymRYnAziENnb4M8T8LB/iSHljIjhVXMF3c2Pn3iSOsy+/6P/nF59t+UYWAp+H/n9enLjXxdACVq/merCcZs6q3ljvdMKzyR89xX3QbKll73BGnPD4nTVsOs+CHvGMCQlWHEbepu1EYdIxC736Cw+LNOl0c/PSuBDZizZ4aPFtFMFRaBrT17MzhxiVfLdwgxbGinsyzeAV+FJG3sjXCvDm/3wvqgMgT7hUWJLcWaDlFyCOv9AUhzdKvTEFDMhxrTtnjrsxhXaxZ6AooK2nfvoOLRr98UAsCj3gjIawWNE6UaOfXUbbnLgmq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi+RYLnovjJN1vmRsE8RYoRZQ3czH7JRCfqHQXU+QOo=;
 b=BEeLi38wXK8ygrAK8uy6sKrOE4E54niE8q/8v27S+TGmkZIL7hZ1ImkOQk3MMueP5WOBTlN2Xrc0w/XL15s2SGSVQ6r/ozQSCmIHa33oLcu+uN8WhByU4Bh6AMlmtAp0QiozadcWMgjEDtAnWUTMhJ2FYsxmFb1sk+0Cjffkj/O/8PSEwpCq0hNS5Ug0+6/UWqQ5rgCRGGa4sUNpcQnD2TDlFaFd0WNO4SO05AwK7LMfBs6bG6HfK0+GFJ1hEjYXCfxt1WBDyauq/XbkzWyx5MR2lf/E0yMrBFh96pHHrfwfcGdTHDw3gANTwXVj5NyYM/ZvxHhK9mcnMdCJHZDNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wi+RYLnovjJN1vmRsE8RYoRZQ3czH7JRCfqHQXU+QOo=;
 b=lXqietPpTCUu8LR5BYpuMJLlOhAqwORxiTkMX6sl2+WDBfTPZk7OZZ5mz8bZLrIJZ2pPvCNp0QZjCxgJtgPFXEyhfp7EhmuOLjP22yMivMoqljyv3YEJx74Hhr9SMcgMdW3jHiWXhJnHtj+LH7Pvc3ZOLQlSP9m6h3rVNitZH64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:14 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:14 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 5/8] mfd: ocelot: make ocelot_chip_init() static
Date: Wed, 19 Mar 2025 13:30:55 +0100
Message-ID: <20250319123058.452202-6-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::13) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: f493911d-703d-46d1-5beb-08dd66e1f061
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fLccHP+Q222ZCarGuVujr5ZBBIScYrU2824upisjwuBAg9ZoAgkmQzuBqQjK?=
 =?us-ascii?Q?1pRALg+6HCuY2lhGZ69AqtLne6mM0/oHY8S2bytYrT73Zz174e7vEUutQk8z?=
 =?us-ascii?Q?7cKrW/EHQiX9a0xZTv5cLnzVh8BfGKFTcwnuyKby74mL+ZOUhUDLwSGkR5Hr?=
 =?us-ascii?Q?9zl3eZPIEkVMF2xZ6aggm/rGSvEVm9Vb6MPWXaATEs3XWF2WskViSlugtHb2?=
 =?us-ascii?Q?EHVlvtpu6TCHEKUJtPMA5HciAhpDrWUG50ljcP1Py6Swszk7/2/2gK0S+ypE?=
 =?us-ascii?Q?sOMXwp4IB9P8wMsHjt1Nt4y7kJFSAeB1HNtoi1sqYgeqWUsXad9TCOVo6q9R?=
 =?us-ascii?Q?wTt+vNJ4CNlC8VUh8rcdNOMViA7rGNg2SRBG8n0Xsnt+pUElRB+HAG/TVmnG?=
 =?us-ascii?Q?6hc7cW8EugXlf/jJpo4HhzqTio5JxEnPutcgkTn+aX8qIx4mKDCfVBy0H4SP?=
 =?us-ascii?Q?x68N0K5mSbpzqupnXcXfTKrRqHbV6zISKt5g6ATNuOUEd/atWfUwuMd7QAvT?=
 =?us-ascii?Q?q8yC2v34aQjvfuawUut3bvIYB2jni0gkawmJgmLc1nLCBLcZXmoyrebGTG8s?=
 =?us-ascii?Q?qi0gpLC2QdzjZmmngcF0fMDzyOJM0Euw9wK4IAbsXhMBrvdcld23/z9Hk2KV?=
 =?us-ascii?Q?vUSiVmHBV3ZpOAeA35ihFxHp7up6nz5vBsLJ0k0C0dsIkl+8nQUf4suOyX3C?=
 =?us-ascii?Q?RZkJ2bpaBQfU0IKMlx28I1BPPzsFtDCHRyeIqKwS/xlPPAtuSiIiJjvWrotg?=
 =?us-ascii?Q?lA5wHw2PwZs0TEkONFww86NXLrZWGO7GoQlVNo1oqRCmIT5gLHO/JkedYAmg?=
 =?us-ascii?Q?0ly/BvaLSROTb+EwV8tDu8/43YIsA3VFTDW6MvdWMcWUqc4pnoOh/3XNtsHR?=
 =?us-ascii?Q?0903ccDSPRt1lgmFg4FXb3B8u4V0n1sXKEOEjGGEyZmPFR4iZulxcD9WCjoa?=
 =?us-ascii?Q?GN0pkO2o4J/hBK0vevDZNfucMT0Jt41oP+WQXo+dSbZU1pbSKjhuNLTdD9Jy?=
 =?us-ascii?Q?Wt73nfslhaD20wJ/HjLIycUcn2yLC9j8wCoJaElkPQlGphV9e/BuxpTS5Bc2?=
 =?us-ascii?Q?5znErjQd0GQgjWMor1XGNdwjCgCCEpz1TGPrpkMFkFQHx6kRUBlhJtQmZYPh?=
 =?us-ascii?Q?VMS1PtTwcEuVmRLJASIrYacVczybLOAARg0mp3OXK4ILYlaHiXKjQ7MF76pu?=
 =?us-ascii?Q?n7soREkzHw5S3Hcg8nxfrfvp4FEagyCX4mnbLONUaM3Qx7AmZJGHBHp5np61?=
 =?us-ascii?Q?yyTjgphgRvvLJsk399w00cs5p/LiQhW6paXo0WpZl+osOloLpLfLTeb5QBm5?=
 =?us-ascii?Q?mxsroaBtoiRE5hlYoAfHYJGv2ezdAtXMBLvDj01Prs+62xxOifKyAGgJwxn7?=
 =?us-ascii?Q?RiljGSwY3DHrpnDX1Z1U0+gPArnMD2vtbsUHGNa09cp4rAm91x9QwvBEjPW1?=
 =?us-ascii?Q?VUOea4K6b5qQo7mjeZVsC1ytwHJpZ2nL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?shTnIKZPw2zBNCGLxjRkomMnOvukRI3DjD+DgBjSLFHveuXfgMGbdyUT2niS?=
 =?us-ascii?Q?mtlzUw60feLPuu7xXYjO8v//RuzD/bso+Ddsf28O6onDwGC9QTYnWrnC95yL?=
 =?us-ascii?Q?adNG8HWDiYNq0y7HH64GU3zYfHdRZOx6+HoQqKpZJEd1pFJpgK/QzHJ9YwAK?=
 =?us-ascii?Q?iI/y+uNutZCZ9XVqAuB7AHwfFdghqtANFfQsN4PjonEa2Y0d1M7OZTKCbOyT?=
 =?us-ascii?Q?/Hwnd0IlIBfZh64eqPNOlydMs6aJzEaDergmmMgsElU2OdGtj+jaSZOWKrGu?=
 =?us-ascii?Q?MIB9UKv2ymCcBRB4LOQJvuhNEjasgDooR2f46sTq+OAYkn4yyn9/gbyJ7B78?=
 =?us-ascii?Q?K3fIkmUJ8tTN1Klo1Hr1vURT/+Kn3DkBdxGDff2bCaqW8Gpdl1TRvOd87v67?=
 =?us-ascii?Q?kR8nvmWaKlD/A6Bq5XlqyCJxAuMFE7J8Br1GDrU01u1Rjwz4bgsmUYb9ylZN?=
 =?us-ascii?Q?N7rfNLt7mVCZpK6vEtlcV2UzNBHZIoSYQfWMdV1JQR6lQDqYS6nTXYOCxIn0?=
 =?us-ascii?Q?BRr+xj+cncyRd4o/f5u+3gmqMLqt0l6l6B2Run4HZVuwBmo7v3Ont/u/6ILa?=
 =?us-ascii?Q?qZnrB00H24sBMfhPik8QUFDIKBCoHx/FCWrdOANH+9NIFhWmSQftiPzhC8Re?=
 =?us-ascii?Q?XjCfmFt40Y/pmojlhjsjfPxhircOTlZtaJLTw22DKeqtePTkfVuB5jukf+EL?=
 =?us-ascii?Q?0Pi2mI13iBlSF88947mHBF+phQ4R654P0J5Uc4WZVW1eBEHIjLqK+FgTi1Bk?=
 =?us-ascii?Q?7qh42pSaB6ezvxT785Dut1kzkDdx2nz6AD0qcqrHIAXcbvx/cPKZYkZv44dn?=
 =?us-ascii?Q?NZ4dxMA40eBvBC/CckB0mVMXhDxz6Wr/t4yp1xtYiaKOlr/hIzeUdcZ20QUT?=
 =?us-ascii?Q?XZnLhhbDqvU6ZZdLvVnscWGYty5s9vmGBr4C0ZceIg0d2eVBSDHdUtH8oVmP?=
 =?us-ascii?Q?YIouRP0IZor2yPVO4bnjxNi+Ap1FHCYc7F1sVWnPuNH2PzSG42uOax52h6nZ?=
 =?us-ascii?Q?xP+KY26TfJmZCGmKAbMLGExBnxsQEfQSAbeli1iwu0lGQcKp4Tk6d6gVq9vp?=
 =?us-ascii?Q?7ztpXVNQ3AtQjN/JmpTn6TpE9AA+Q/Bj1oK9OCf9w6OQrfumUQ+ppoaQiZLI?=
 =?us-ascii?Q?mkcFU0EP9AcBrxha7L4r46xqXsReUF/kVkWjQ41jkvhgjD1RH1df7otRbMiX?=
 =?us-ascii?Q?mG38lw+FA4PAFpWpQD15ybk6PvXqH085eLw269Kja6eNfuZ5Ryy1sHO/SA2L?=
 =?us-ascii?Q?euUUqbV5uP2aynuPobXq2WaX2NRrA5Gxw9SuG0uXUPcit/2eAoHzCF+0XRZt?=
 =?us-ascii?Q?XsiT01cB2J23yzbBzIs3cQv/bSiwQKMndynTk/x6hByAJ3ukF4W0RUMc+56j?=
 =?us-ascii?Q?mRhVRBLRf97J7SYjuy1+q53FGrtz0etcYdpQaHAV7jDfzhtQH+XPE10Bag7D?=
 =?us-ascii?Q?iUob+0PnMFxwViYk48+RoRATetC8DMTwwPorxTO8ZURNxFWpZk3fey0i4kFI?=
 =?us-ascii?Q?nG8Hyac+OaaO3mQ9QPqp9k3riGLqv5OcN37Dwf3r04v0Y/YAkrIBhAhczztS?=
 =?us-ascii?Q?3OLxnTBBvdZ9FGP/r1DXjb2SeTUOVSxUnsbxY+xRIPS61mqrncokyFeIUArh?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: f493911d-703d-46d1-5beb-08dd66e1f061
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:14.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkDM0xLbu/rO3w+Vl50wpCligEC4p0y3l/2N+s1XIaWRNNQNplP6FrO4e8t+rOUiDItj2bkPZBVJWySQLYsnFQGkTAb2wZB6Zly7RXD+XNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

Now only called from within ocelot-core.c.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/ocelot-core.c | 3 +--
 drivers/mfd/ocelot.h      | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/ocelot-core.c b/drivers/mfd/ocelot-core.c
index c0ab5492c83f9..c00d30dbfca82 100644
--- a/drivers/mfd/ocelot-core.c
+++ b/drivers/mfd/ocelot-core.c
@@ -98,7 +98,7 @@ static int ocelot_gcb_chip_rst_status(struct ocelot_ddata *ddata)
 	return val;
 }
 
-int ocelot_chip_reset(struct device *dev)
+static int ocelot_chip_reset(struct device *dev)
 {
 	struct ocelot_ddata *ddata = dev_get_drvdata(dev);
 	int ret, val;
@@ -124,7 +124,6 @@ int ocelot_chip_reset(struct device *dev)
 	return readx_poll_timeout(ocelot_gcb_chip_rst_status, ddata, val, !val,
 				  VSC7512_GCB_RST_SLEEP_US, VSC7512_GCB_RST_TIMEOUT_US);
 }
-EXPORT_SYMBOL_NS(ocelot_chip_reset, "MFD_OCELOT");
 
 static const struct resource vsc7512_gcb_resource =
 	DEFINE_RES_REG_NAMED(VSC7512_CHIP_REGS_RES_START,
diff --git a/drivers/mfd/ocelot.h b/drivers/mfd/ocelot.h
index 5aa6589b9038e..f1272a359ef47 100644
--- a/drivers/mfd/ocelot.h
+++ b/drivers/mfd/ocelot.h
@@ -34,7 +34,6 @@ struct ocelot_ddata {
 	void *dummy_buf;
 };
 
-int ocelot_chip_reset(struct device *dev);
 int ocelot_core_init(struct device *dev);
 
 #endif
-- 
2.49.0


