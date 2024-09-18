Return-Path: <linux-kernel+bounces-332237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A2A97B716
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C461F23B94
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45683291E;
	Wed, 18 Sep 2024 03:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j8E9/aP5"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010024.outbound.protection.outlook.com [52.101.128.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA30AD21;
	Wed, 18 Sep 2024 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726630532; cv=fail; b=heBLzuNCFWLsgO3UdxThTKHNS6PCG4DMA6ukCH7veJvCwRdI6ojLKe6AY3BDI8AQsOeAcY1E+WKQEPynT+o1M0HPwfQW5EC05D/FFWWOGkCZclZS0blvBqy/dtAqctB+6xjd8b0JGGApC6w8FX5hUGHu+4uGhn/pPrJbtk1QskI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726630532; c=relaxed/simple;
	bh=DWiCf7lv/Eu2isujiFJcaDnu/FmMXGvxGCqNTMTQGhE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rbvwBDEHw47lAMuJMTRAUJDKWUGhFOHmgd2wCMzFoY+gRS1L4kx7gcusuLw6V65JkSA5AErxbnhuxu41/9ZtFu2xQNUN5zSy4TbBMXZl00NGjC4hpWFk2UcX1IPyhcVdsg2WJms4hpNsjmhTnxbdJ9OisPE/dXk84Upne9rJibM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j8E9/aP5; arc=fail smtp.client-ip=52.101.128.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtcx1TST94aB/c5ALWv8DGO3BrWIEnHxnQmYEkCm8EyALRuJclQGVkB4BlmjTUzIDHUE9demnc7KPykrHso/92nUnfAQTYChcAX1HlggJ+07kvBl0LEoXYBp8qc9WS6Ben5lEe1/NrMEC0hsKpddnJYGiZQZOxsQLRv4GGn500Yriza31ih4dlw6ECStzLOUMtOLrCqC1v01MfzNxMXXsNUd9xyAw7dd4cRFKrP1gMgQ5aIbFWCE9uYHJSfYprh/VSa/kNQDfTqPaCevPsVn4Yhb7ppOWCSy28GQpBNrT80iJ9K0228Qz+Ubmd5ePyJOBQG3W1svmUZzmXWvOd5Hyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pb4mjHIm+5Sxcey5z9trHIdihm2qlaFBMZoF2L9iGqo=;
 b=IvBQAwKbJPY/Q65xWtUoGw9xXpjrQxpIXOzpuGa9ritVTJv1/cH3KdNotXGHFjt5q/w5bvRCcaSGdnpiW3aJ/wYFC8sx4F4QFDlG4n8KJdDXStfbP8ZrhXwhWKCugFrTc2ZUjHirhiNZBjUHO9236djiUA0y7dkb2/LwTJxk5I7Z1JNrheoXoIlYR/+L5IKcckr+v1wbbtO9RwjIBrO6LmEk4Swwd0KDNF7HsN/QwkBLM4MBb32Db87i98qBPpTRdPXikfGzEW0WMA844uWKzqgCI61vl6pq7N2Bpfsb/Xs8uwpa06KRZBsrQrR6zWLSZH5ODYR+JZjtB7IThqRplQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pb4mjHIm+5Sxcey5z9trHIdihm2qlaFBMZoF2L9iGqo=;
 b=j8E9/aP5hwNUnEkt2y1eolHOV/1vUr+v34j3VVhWbeKwMEUhe/NGW7lX9dEwmJGpjIiuC61vMnoZ15FdR5YwDSHb8cqf5tFDBPSpwei9epS4JaO9Lj9AclDNFsVbtm7D3PYLXeQ3FsN9uucRVV+2J2MguTydy1DHBsW+HGyjGld1J7W3gQ09IWF8jMwTxsj8RsNwrGEzGosoJSZDsS9bjpG/NfeF5T1iQfiJwCSOTDOL12GAFsSI0XEBXZ/4TPGejplxsuITZTliXTD68k7dSyEiCLr2FcnzyykRP23pQ0s3hifF2O4N9TluaCkbtd++Ej7DQtHK16Ck48Ru3yXYhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEZPR06MB5023.apcprd06.prod.outlook.com (2603:1096:101:47::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 03:35:24 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 03:35:24 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: ythsu0511@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] hwmon: Convert comma to semicolon
Date: Wed, 18 Sep 2024 11:35:12 +0800
Message-Id: <20240918033512.9351-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::18)
 To SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEZPR06MB5023:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff4c9e1-3c5c-4e8e-9b68-08dcd792ee28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Sjaac9UW55NqLvR5RgR/SVEdLfbM3RsgEmo02gF4rp9KsrxGGamTTE8bXBG?=
 =?us-ascii?Q?2UxRMqtRU2eCfKX9k8W7BB0u+DJhWvbwzJH0Zvhr2bLmvzdqo+6EUPGUrtRs?=
 =?us-ascii?Q?DP7+OOU471ZFdSSusfIR/BFVFILW4GcXnzsz7ow/iTS4KJ4SSTZAtD8935aZ?=
 =?us-ascii?Q?9xF8Phd/uAoIirMwj5InxPpT5EABjySV3pnzpZGu619X36EhbKSdmROfUvxd?=
 =?us-ascii?Q?dRamhdDqFIImJ7WNkg2V7Bqfr6XIFjbMHQdz8Tcm01hPhblQy2roIjdPukxH?=
 =?us-ascii?Q?P6CNd78F7mB8dtnuTpWhiZU0dqi7Ctm4DOUHH/RnVQrBD4alrO4vZKfv0onY?=
 =?us-ascii?Q?bP4kOkZr8jvqxQvscHhN5uH+06Q/zIMSg7/8D8/1GL69bUqvCcDOTLl8D4i+?=
 =?us-ascii?Q?oDtlzIfhRO05cPuVfT/8Vr5D2jLz1PPENmsTPI22Cp3djQtCabvF7mZ0chnV?=
 =?us-ascii?Q?iojpsdPk4KcmCDGwsiRgSMX2H1gbl2osW2J+KwWGikHHigMR7OZYYvs5nSAi?=
 =?us-ascii?Q?76yntZa6dii5LAoQ7On3F/AQqZ3eedIt5HUV4j8pOCvBX/kmnku8w08H8mwA?=
 =?us-ascii?Q?74e1fj4frtNOoB+QleoZNafXjSXOmb9rxEZ0P0/PjU52fSMHdEekO3hPgDpx?=
 =?us-ascii?Q?SC5XlAPsaDGwWNKTG/kjB3JvR77FhlYR6hy18GZLZx+YxbPUcez47Vo5nJYw?=
 =?us-ascii?Q?uf9DQ4a2EhHu1BYiDlozWWcJYm439dvyc4RAUlKOxeB/Tmoq0Ykwi4eswE/V?=
 =?us-ascii?Q?smt6eg9s3h7tvaks1O0QKuXFYjV/u+wfdB3htZYFFvHRaQzGcWIQyZXnqsAJ?=
 =?us-ascii?Q?EID8nOO2Hbb9wRHZpoglnk1iIr4e03NIZWM2XnQ7hS11OfbQDux8aOV5zOIZ?=
 =?us-ascii?Q?t7uvb9OtkADIZExPpf8EBBf/pA+fIYBxO7rVNsiTcNlXpcY6+79NcYlOHJep?=
 =?us-ascii?Q?LYfmXFKTFGVqUFs7GldNKUibuaRopNd839BhksbI6Ulp2aDa9L/P8f7D56wO?=
 =?us-ascii?Q?1uYRATlr3b2o6411sxKv8SY/HuUaboN7VLkkzE/aVFOKkhQF2DKxK/e56Gor?=
 =?us-ascii?Q?4n35AccBiVAqGfBg53DYuCWH1659EIXX72eYQidmS1Hu7YRbZ/yLRKtPjvJw?=
 =?us-ascii?Q?4hdSfL7JXaFtqclEI1ug4QLOaTCaDtI6+D5QNTQ0SlIAy9tNYegXm85BnjzA?=
 =?us-ascii?Q?/sBJ2lTILBbPgw4vLXPl2hdU2r8pQvAQG1YOaPMSHsT45hXpQE5ZmPYK7N+H?=
 =?us-ascii?Q?mF9nN1RSv4mVZ4Nuh9yimABYCCYflg34aDJ0qACec/4wZ30tIgS5KbXpXlGT?=
 =?us-ascii?Q?tZpZ8/3gqe9/uNevAE8kuFuSYYVfNt3qZOoP75H6n41CkqPoyYRpOrDaR+zP?=
 =?us-ascii?Q?nISBc4t4fv+lEZB9RMt91y0lFc0QskvfQ4QrNeU4cfzUnZ6jwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qXnAVqPS8EQH3t9kiG/Q2SUdhGc4StWCXQkanJIppG9wIaeVzAXOv9kVsBcI?=
 =?us-ascii?Q?Z4ZxZo45GB6WIKBG3Ww88fq/oyCcG8hiQHSOgsFkua9ZhyPMPhypX+4AaU81?=
 =?us-ascii?Q?wENRNhMsGMbJ9kUFKGPq0aQ69+TD4nHsDqnaUgG5UAh3777bCI9wfxzw34Df?=
 =?us-ascii?Q?7TbF4dJgi5lj/PYmNVjOukqFQy4tBFMysnSMalY74ItMw/4aSDOK34Inrqs8?=
 =?us-ascii?Q?Dw2uJ926SwVqARiFLshMJPJL91VC9Xp7qi9gxjXOWLw0sNjCOlRDirYqntfY?=
 =?us-ascii?Q?mauu353AN8diLRGY4nK4TX4iEKyvEslN0S7i25ABBiqXVkJ9WyS1qVFaEdrr?=
 =?us-ascii?Q?4m/5HmnG+xwa9v0Ck0BsbW96z0PqAoyMU6KTiglu3CjFL4pEp+uWgH47ij+5?=
 =?us-ascii?Q?rJDqZYotOxeJjuDXs6jxa6hogguqPs2BIAwxbouKE7DT3TieRBPbTTUeYIYJ?=
 =?us-ascii?Q?ReUYHALNw1zQyLzNkL19xezhR8Fi9qRdwM1FPSmLt1QotMKDtVA7Kmtl+DNV?=
 =?us-ascii?Q?Beb+v7Kim7CcTtBtkQSx+783cDkvgHhpXcys9kozcUGolEoo5F0GbMUjhV1f?=
 =?us-ascii?Q?5XEM9P9TOO8kxVnXtTFwUTH2BvrbeCMs1KX2mnxzzIFnIWArAc/ynvW+Me/V?=
 =?us-ascii?Q?i3UUrUlkPpJ0EsUE+aU+UV1T0dfV5hduy4wyNaYrMkWW6OcFNFJ5H/ojPaxS?=
 =?us-ascii?Q?uebLV9L1TIxV4MBRMeQH9hKBp6D84Vd8Ef/X+YDfKXJSEsRwvw2D1uJ2rLOv?=
 =?us-ascii?Q?UXDnzIqn9nkxTPT1hW0qeViWDfm3GFMUxuG5UzxiiZTh3kd9JEddW0HI2HYl?=
 =?us-ascii?Q?0h7cPUBcN4aPhE7K32mtmF28L0naq61Tk6qO2YWpGGCZwkR43ju3fOFasEcq?=
 =?us-ascii?Q?F8WC4LmyYjF3fm2M+TLVYY+C5Z1n2nqygh8qDoFTWXd88tlA7t4YNkJr15QC?=
 =?us-ascii?Q?1SgQ8AgyzzmZnCvQKX44Zn3aP+xoqFAKgXZfMeaY8ldnJlknNPs3XhzT/tJk?=
 =?us-ascii?Q?0MWqIv3CKgi5sUu1lI4VE+zgzgI3XaT2HMrBGMAmfyW+2o6t/QEOPwkuQ08l?=
 =?us-ascii?Q?Rjc8ONTueDxWqPWmt+8CkAatabisxw6MzOYpc99LggtJ9pc7FLSJj7Atfe7x?=
 =?us-ascii?Q?OvlSkrkxcolw4QJOdW3V8k3arDkN06tKd7z0u+SIsANrR8y/ZoHFTV0vl2Gq?=
 =?us-ascii?Q?XJ78pIYWsW5GAXGgsHrPc9iA/+dTxpdUGvg7j+XpidOA615tLKoa5oosCVGS?=
 =?us-ascii?Q?7pa+6pw1WsDYB8HGzxDl1QFsV/NFQCADSXlbxMDCRg4YoZbfHdPHnB87HD8A?=
 =?us-ascii?Q?+KBW7Y6Q/bReBFxR9OhyT2yhIhSTOCWIg+apDNwSNQspTOwwaTZVKOajjgtA?=
 =?us-ascii?Q?A6MFXcIy0l3TcI3eEIxtm+VaKjKtUvGM3IlmOm23kzEqPbd79caSfwiiGtfx?=
 =?us-ascii?Q?BTOBqDtS9YVrvZ0ylsbFiDOvJ4UbnG2EL0cuDDBjpWqEquI0Q4x0u1czo41V?=
 =?us-ascii?Q?OlSjlbIu4+dKYzPGGAGiFcC6jgCXQxpndetC5XOKy8OyzPiYE7psbURrsN0B?=
 =?us-ascii?Q?oz5CTNP+hOqRF60f8bQHsSAFdUOBuxflBg6OlcjH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff4c9e1-3c5c-4e8e-9b68-08dcd792ee28
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 03:35:24.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fVwRmLybrDyeI83rUZq64N7dVbMxQkGcbGrEzzfUFob84AKsND0d/FfI1BDnus7N7HWawRQr49BtMu1Eotnzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5023

To ensure code clarity and prevent potential errors, it's advisable
to employ the ';' as a statement separator, except when ',' are
intentionally used for specific purposes.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/hwmon/pmbus/mpq8785.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/mpq8785.c b/drivers/hwmon/pmbus/mpq8785.c
index 7f87e117b49d..0d16491cd770 100644
--- a/drivers/hwmon/pmbus/mpq8785.c
+++ b/drivers/hwmon/pmbus/mpq8785.c
@@ -22,7 +22,7 @@ static int mpq8785_identify(struct i2c_client *client,
 		break;
 	case 1:
 	case 2:
-		info->format[PSC_VOLTAGE_OUT] = direct,
+		info->format[PSC_VOLTAGE_OUT] = direct;
 		info->m[PSC_VOLTAGE_OUT] = 64;
 		info->b[PSC_VOLTAGE_OUT] = 0;
 		info->R[PSC_VOLTAGE_OUT] = 1;
-- 
2.17.1


