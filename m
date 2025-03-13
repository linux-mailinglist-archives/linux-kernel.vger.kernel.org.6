Return-Path: <linux-kernel+bounces-559521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29372A5F4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B30DD7A4421
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A926773B;
	Thu, 13 Mar 2025 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ihhrHNVe"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F9542052;
	Thu, 13 Mar 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870240; cv=fail; b=J39WWM8si78zwcm9DNxa0NlRu5YXr/dQClsAYRufgEhkVPhuwSyzKTVlcBUHt6fqVibAHMj4d0ckHbxD1mjRx3UpEcILBQlCG8F0bSrw3zqp7ynjvPAQ9IOYgu29Doc1JYzBImx+hmCp9oqCq7OpN9njx2lA67L3IpeM2gLx+bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870240; c=relaxed/simple;
	bh=vlEGH5x8xykCw8Dt+5D0pVQ8Li4avl0fuqM+C8uBWO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hUBk/qgfzbzlFQtqv9PCipceK2hh1WOy8dR/oh6j/6GUMmecHh6HD+DYmfKjDoA4bNa/f1kOBDdyXWQxqzpRCqyKoegxIH33Dt2CQ1jZGMhwZpTl+MoxuGf2d+Wei8jcaYsSzImms/MC61rYjLcGDVaCKaItRB+rO2/qaJ2OZv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ihhrHNVe; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wNgtmMpnPRYl6RLKmycRTS98iJw5jScKq8PXLLeH4FGy6U8pTkZT95fQwvbgq3iLsYnuMhhcCXIP7NxqTo1Z3yi6d2xB6GXs+RrWcIcn7ZapCDhJl7DJKUWk4zwjzfYYJ3J8+G68Z3Ta69zwYDxzntRatrxGF70HQqWUygpFDm35thHejTENON+ZToc87CknYYCwhwk/kSfduqI+uzziEmj/7SLKesumGt6VrTaIYUxUS6yQeakKLrkQRjN7EhrrtaHDk8yvDxer+a1PfeTbQOp788vDCHTyr0QGokvyT6YGipuIW+dPyEblbxXHhpyOp49UC3YMPDRxkTZbwtVhcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSpVhAQyitF3FW0kCmejXRNUU2Iqy32KiojROFtez4s=;
 b=dioQRKGGAAzJuKHPAd0FpmeUMVt0aSLMGdxBqeHWMt0YvDadDKrvN5HhN5j34FCbqmaQLaFOiLwoxcE3JWqvlabJlPHIsbvBq+xuqfoxEf2RJ2GhG1a8CsEfsg3w/owkKbiuheYVvcTxdS2l3ayWyeWSVpI/MVQIljr8OVUAiMMiUiNrD50Z10u6mtYh1zrSE7rw3uv7LG7y5smOroQlOt4UE2XajeprnQ4FQo9LIJorXwYBVNRq1qfnUJ4dRnf7/Ef02trOmzbrz9JHVtNkV77NIygrGyWJP3mbHD7a+Pl4BgCCujSbZ8gJuxcITr1mZb0vKd7fiQTrVMPFlvYKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSpVhAQyitF3FW0kCmejXRNUU2Iqy32KiojROFtez4s=;
 b=ihhrHNVe3Q9GwQ9WYU+l9PiDBRMcMbD7xmHsh2CnPS6iwVKo+i0KHLA4z7YniJ4tcZZvOQn0oM+f10Y22OvXMPERwDtKB++VSFkgvcFP5Gx3jFi5V2WsUTiQugGOSh/hznXYp9PschMHdT9rXHFkhkko63V5bBanTtY4QVsZmHlFVZuU2lG86KsQyq96FOXRggszYEr8MCXOoZ4P/CHDegdTxliZEw3Fje/0Va0QjZ46cAlb3k4mt6quTuGLV11PPLcdUSaL3f4u3C7Eipd47GNMMYdc6Vi+4EBu3wKrw7anK4ephWHcRGd8b3YA7uU4T58k8fA9POGQ7/a68EOMWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by VI2PR04MB11025.eurprd04.prod.outlook.com (2603:10a6:800:277::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 12:50:35 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 12:50:35 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v4 2/3] hwmon: emc2305: Add OF support
Date: Thu, 13 Mar 2025 14:57:45 +0200
Message-Id: <20250313125746.2901904-3-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
References: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM8P190CA0025.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::30) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|VI2PR04MB11025:EE_
X-MS-Office365-Filtering-Correlation-Id: 710fce2b-fdbd-4eaa-c5f0-08dd622da5e2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?gumDQBV3QuXbHLRvyJAwY39j2GsB8O+199rxtNfCMSBf7ztKNYSgswrg68?=
 =?iso-8859-1?Q?eKiMTwaYCX2KeugAIwL0n8mFrRIzC+5+OIQyGNwUoylV9+uV8D8M3fwJhL?=
 =?iso-8859-1?Q?0w/HHsR0nsKbIDq6sPxpnx3YwBvBd1tKsVWsr1zj2kszORp2D3axWVS4Xy?=
 =?iso-8859-1?Q?jk/8wuGuH7wRxPRJ2QV3+Px9B3mv5u+XYK2oeuQtLtDpnK/4IVfdQd0pgw?=
 =?iso-8859-1?Q?zXYVpoIQk4CfR9ASR8dp45PSZYolSD6eUfebjsnBSv9gbPdyBYDUvxCyHv?=
 =?iso-8859-1?Q?clu7nCcJcROOV85BovnM8r2o1AW8k1awN68n9wRreylkSucGvLApagK588?=
 =?iso-8859-1?Q?ajxj9SFrFxRfpXVEl16usc9oqFpl58KK2aXvxtiHTFJ7J6Fq9veDl/Ydw7?=
 =?iso-8859-1?Q?W3eXEj8hPMZ1W88IDiPNYSr7BI8pSP63y9qzOZL6PpSscfuLYoweabiuAj?=
 =?iso-8859-1?Q?lQWklsnxC3CfM5Y/hxud/19ZWB3Z3IyfHyW6iVb2b5a1I6HaxkqtAlj/Ts?=
 =?iso-8859-1?Q?qwiid33EcgufS3QNlQalA9D5Qt5Ytd2ue9YCXcaYfHlmNHcySpY8tT88xQ?=
 =?iso-8859-1?Q?KXz8/VBcsaahPsUM2KGDyKg6ClTmTxsu7WWDsihcMShxFgzE8OiUBWka5j?=
 =?iso-8859-1?Q?JUqFsrVMJQ7wiIEsQYiZmBFntpV/PxJCUNKuYw3eLCqsPZzGbPW9y7shB+?=
 =?iso-8859-1?Q?nUw5bgC5Yrewkz+pf7qQdeIEuGSot4ZSus1eXulSqV87bDG/2X/RfjJsK+?=
 =?iso-8859-1?Q?GAwSHZ+TXD/zWyNqDKkk5NouUzQ4Jv5RUczklC3QSo9moHKmUlaTn49xmI?=
 =?iso-8859-1?Q?Haj+mYZdBPDRJd+H2jcS2ZqAHqF9v40uUCGLod6B9QjPoaIyfaVNlKQlcV?=
 =?iso-8859-1?Q?Tef2BDv5r1n660chgfNpdWXOxU2BnoCvq4dkSpQdQjvCJiXGs612V4SPBC?=
 =?iso-8859-1?Q?/Te380DvW8ynx3EEr0CCdG1Lb0sGgb6TvqDtP/ZVQp0p3LMLup60CrF/oM?=
 =?iso-8859-1?Q?+8ymFEkfenoyaqYYXeXaj+JfSKYJ5fWArNxLWD1WJzZ5y3GJivaiLPdRoc?=
 =?iso-8859-1?Q?/SLyhdMHxFeUemcS97Q5Jcy65sRP06Csvg3oxCABNL7BNyyODP61mfYM4X?=
 =?iso-8859-1?Q?ISKLz+H/B5utIBJjFgyMkX14OxIhw0VrvrzVE2G5+R4rEqHfz1li9oEL5s?=
 =?iso-8859-1?Q?axKt7pH66w77vF8rihTcSswqYunASQvfRq1oh90dTDOtZyCBIP58Czm5x1?=
 =?iso-8859-1?Q?PuyVCRnQs/r6zvgHJ8mxSH+z1eN6On9YSZ38to6FyflSCnCEY9xEfBC8gc?=
 =?iso-8859-1?Q?ib9Hj2qAeZEN2Wl1ZWDf4b0hWowL2hXNIjhO7q+Ol0Kvkh6uAOtOpgmLip?=
 =?iso-8859-1?Q?kUgNdjRTOCrk/hL99kUxH0enNXJ94SeBlh95YlT1reaGnM3tal9lziPJPd?=
 =?iso-8859-1?Q?WlcMgVQGRD462vVu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?ueKEY1FSM1rII16NwejIoxa+D/eSNCxUWfkTU+wpPhMaXOPvAjDLz9dEmy?=
 =?iso-8859-1?Q?Vs/9VYwyoY1RPkKk8zRMTXhJVkhhPtNbAIFOlrg+2KyKVvpiFnXRxX2xwK?=
 =?iso-8859-1?Q?h9INc+PP7Z1HQjGAbbomIUi1BG6h7Tul6kl4NW49qNR4uA3VPltFCcDwse?=
 =?iso-8859-1?Q?uWOMuiA7OwHwaTqBY5/G1Pb07u5yZPFjq4XOsGsHSkrNs4pc43NT+YFimO?=
 =?iso-8859-1?Q?uBIAGFuaJ4Se3GEo9h8oKGux6W26RMZzcU3w+JxF6EZlb2wdjqpLdcPw4p?=
 =?iso-8859-1?Q?jsbWwtKtJTrGld2GhimH48q/WRjNKx8ks+t2OnRA6RVxprlvmspqjdkmv0?=
 =?iso-8859-1?Q?4FbvO9W/TbqvNSvxQWtJ/LUJl7tFGYbicoMcb3YfRu3gDjR4MZJyX3fhOM?=
 =?iso-8859-1?Q?NBp9fpooRWoTdUVY7W9siFAWsy7rf+A+uiC4lEVXtRIEksYditM0qiPtm9?=
 =?iso-8859-1?Q?BWxFNr1Ac1Vp2uB0agzxTCzUOZt8C5cc+5Jy0FddMkORLxx1uV/KlVmewT?=
 =?iso-8859-1?Q?CmD1HIX2djimXWez+z+vV2magN/D58nnmwqtELFWnAEqYtkzYgP7qrEJS3?=
 =?iso-8859-1?Q?RzXn4sSOCQuCG/y43Bcs/oH/3kCLfmiZN33zdO8v3jue6gHMNvsK5swpgM?=
 =?iso-8859-1?Q?YiGOhZA5qAwVj9jEoUQLWr8LunfTnwVxnwj3xDvR/btmsUdPgzV6rZ5rWl?=
 =?iso-8859-1?Q?1Oci6BW8gOs2RfpUa8pEcPPO16l1u8P3fWPHfWgpsJWcqvacLVyHPjC8DF?=
 =?iso-8859-1?Q?Skh/RcVSinWgpkZc2PhqmRyVNov8QL8QmGpIWDgfsYEI7rVMRjGOEFVcOX?=
 =?iso-8859-1?Q?eo1nm6AQ2GLCTuu0AB8XGMdLDcHoaHkWjb9aegx0pFJ4ECES7c8i+HwRwS?=
 =?iso-8859-1?Q?CbyUW2FKMsIGHJi7Q/e5NvnqQdwUI/WTVx3rCkQQWRWJl1Nc4LG9IFzJO5?=
 =?iso-8859-1?Q?ZHguqfpjOr8NeiDGfhX/4UfaTYfeWCwObTKBgD2IuSbQHhOy1djMwOfdAi?=
 =?iso-8859-1?Q?+QzATVpedUIij2z3fD7/m7uF+0exOpiz7A2ackjc/XbOsM1ClCbdB9ZitU?=
 =?iso-8859-1?Q?r5hXuXLjle7Ysvc2Ll8vDZoIVAm5aYHzBSB2yg3N1GycJc1reSg67xF0f3?=
 =?iso-8859-1?Q?S+53Sh//e3R1RLweixXJkkaxYyJj/tekiYfAPYdYvIyeSIXSWWIRZBAZdt?=
 =?iso-8859-1?Q?67Cg+v4jCzfPanDnLamG6ik3yjUxZfdSNPuuilXhFtoXhJ57m7b4K/o+v/?=
 =?iso-8859-1?Q?xtxPK2Qe/7N6cjuxI9iyO9yrm+R3x3srOuBJnh92fpBg7ehoUljFfRk9pG?=
 =?iso-8859-1?Q?YmAbZIhFGY3AVXxYXUkdR5ISWiWT5eFmj6vuPKwC96nPBJfZs4tYm9Dp6Z?=
 =?iso-8859-1?Q?bZMdr8ZlLpXSpyUQp0HQdT43+uVKF9Ae4YUb52cbMfGuKKBk3SwIh1qorh?=
 =?iso-8859-1?Q?PRfDQFLfKzyWy1rvSLl+twBXnMojvSPIsAq9yda/aECaTJOF0u0NxXmCvX?=
 =?iso-8859-1?Q?WqzlwM8o8Nz78hKGJBMLRAebIp8NQtiI1lYVyf1mCLth+crt66Rcf6gnSj?=
 =?iso-8859-1?Q?OJk39nC6hdZw4gWJ57+RGA+IJYiCSI6kfQuetsU270AgGyeJCPLMGfYqjT?=
 =?iso-8859-1?Q?JqhKoWD6cSYN04arHodU7pH4btbIglNIfQuG84uFPkp1sWGa5ppz7XYg?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710fce2b-fdbd-4eaa-c5f0-08dd622da5e2
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:50:35.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFZ1ADvpyQJE7T5q4VDApM9EHL1kDb9EE1JYWqwo04Cieuo7NaQ3rbPA+BRHdP52CAQYH+jqhB6pqYFcSuhk0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11025

From: Florin Leotescu <florin.leotescu@nxp.com>

Introduce OF support for Microchip emc2305 pwm fan controller.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 drivers/hwmon/emc2305.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 4d39fbd83769..f8a4c76fcadd 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -607,9 +607,16 @@ static void emc2305_remove(struct i2c_client *client)
 		emc2305_unset_tz(dev);
 }
 
+static const struct of_device_id of_emc2305_match_table[] = {
+	{ .compatible = "microchip,emc2305", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_emc2305_match_table);
+
 static struct i2c_driver emc2305_driver = {
 	.driver = {
 		.name = "emc2305",
+		.of_match_table = of_emc2305_match_table,
 	},
 	.probe = emc2305_probe,
 	.remove	  = emc2305_remove,
-- 
2.34.1


