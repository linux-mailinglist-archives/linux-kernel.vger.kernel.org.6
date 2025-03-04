Return-Path: <linux-kernel+bounces-544904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED30A4E658
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3679419C1729
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2042853E1;
	Tue,  4 Mar 2025 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eSloeE0j"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2043.outbound.protection.outlook.com [40.107.22.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14432284B33;
	Tue,  4 Mar 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104868; cv=fail; b=nfcCbfCEueWEu13PcING0lhmczhS3BvDEARXBvHArf5OPVMpOpcAUtU5IOVL5YIm5dGqVlZ7LLg3b8hXnNrPTwlOEjNG2ppfXT5JpQebtZrOP4tN+pmWsKS+YXEPRnj36VlEvpeJBmywWOD0TMb0AV+0/3GDNVqmtw15PexVL0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104868; c=relaxed/simple;
	bh=s5DtNtM/DBpPG6xS7dKX3hpMbVu+mgI2V4hEtsBfKnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CDnuE2uJgPNIAP/o3r/BMjcZfbPs9Qr3tKTiWNPNWwpD3fmDSVUuhQIlZUktPod6UCpa8V2iBEaU7fQnwwgKjb3kIcMN/aXBAP5vuCvaO22rJQO46iL2ipcqOma7pJtjgTtu44a7+/kxVItdlJ8u0eNKYf/K0LlCkF/KzPaZJuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eSloeE0j; arc=fail smtp.client-ip=40.107.22.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsWJrM1qfEdh4QfkrIpec5qguc/KWgfE5ijCyLtED8Z2jEkwCx61tV8wHtcB8aiiBLHYXHBFw4YAKFf6WZw914P8lcerb02OmhrRtiTrQRv+JyNQT5KEH+t5k0lQsD/85GU3A1Acas50ZrWyIl2WwFQlSdydRN0OrpajFS369cJz0VYE7FDMh5tyWu50W+kpQB0oYDNOcIA4W8evxsst8CiYAMnYC6bKEEqIQyQAKz4e0QCkV1ZDcWtkfEasMWDfMT4bZ+RpqZ1XWB4c+7e3Q2XUCc9iMPTXZU3Tr5e0G2YFaaBtgi2LDvkCneCDTlTzfuwGJm4ZHN5rKmDGBlhPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lM9x2SSsdMm8Saao0+gD0PIqDgTvzkqsk5LXS9nvSk=;
 b=k+UzQb+TrWdH4rL0MtWTOK3FO9OmY9Yy5L3XoIkhra4GM2biG0rs+pV6ZxGQ29PE2NgY+Xt8zGdLo23BriIgd4l8hC1Df/AU0xd7pDiT+pm1IcHeJizVaT8Mo0Ft3a4I0hoekVx4na90JWErXmR4WxYhN5tPd0c4pH8xIvp4HFQdxujjdlujmc0jGIuQkJDjRmTKVnpyVOdZYV0x3tPw26tMU3DJ1pQyEt71XGbKH0RB96RmZm9NglhCZruBJaR2MXBn4m65um4EDTSasAgpdacGMqfqPf0/0lFwtZXwb5wmvkJzIFp9b4i2QAW5dirWDCpV0Qmp84AsOIhepfb7Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lM9x2SSsdMm8Saao0+gD0PIqDgTvzkqsk5LXS9nvSk=;
 b=eSloeE0jE7CdL7TbhtXfZtJesiVt9Fk922Z+7/k67umeYpPfzqcTAYc+gKbXcTn05jj03GuXcDfWnL3gKRV8oqphx9lFI9nLxQUK43r9eDOOkEzW8Z/5ylRKtintvq25Gt+lK/hNSw280uFiBeWx1rHlMCQr8NIyBirqxhnD7Vm/X6/vTVro/fJWe8hJjeVc3S2pTidtyvmk2w4Z6UILgys0j5QaHHSJpB2CqIA1OTUw1ZI0UtqKXnqEZjuLWoyL2BugduwiZFCL9LJY/rS4/hJNfpUf5bvFg4XwguDoIf17TbcKnUnOLGqx0bqyntTKX5jVUmp/PKiFE0vfTiGd7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by DU4PR04MB11080.eurprd04.prod.outlook.com (2603:10a6:10:587::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:14:24 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 16:14:24 +0000
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
Subject: [PATCH v3 2/3] hwmon: emc2305: Add OF support
Date: Tue,  4 Mar 2025 18:21:35 +0200
Message-Id: <20250304162136.1963384-3-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
References: <20250304162136.1963384-1-florin.leotescu@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|DU4PR04MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a283e1d-520a-4fcb-44d5-08dd5b37a113
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?BZexjQ/zmNGETj3kjWVKPhEDRnxccuaz4lJXAZegoa+gbRBXFJdGY7Dpvq?=
 =?iso-8859-1?Q?lnvs1WBV+Rzjohi7sPzFqLClwKHisruMztvxYUVEwl47AxO57amntz7ItI?=
 =?iso-8859-1?Q?r7bNnxU8iLdUFRS54voEskOxLRwJLiLkiCM72ZwVcklYvtuP+5y97AlP2s?=
 =?iso-8859-1?Q?alzUJk12unSTVPFCspYCpd3zald+1MA45nCPT+cDry+Yy1ZKfcJsKnKTYT?=
 =?iso-8859-1?Q?/3I/A91BvOTw/NGAEUGDF9nsNG1AwFxzXKZatxVTGE1fETFup0bY9fkUMr?=
 =?iso-8859-1?Q?9/UmRVaWcyhGWRqUU6WI6ow0xT0L4MnjNV/OQgbqi8um0Fa+23YrHk6NGV?=
 =?iso-8859-1?Q?pIOYgU6FhnBZ43ClHr7sv++ZINnRdl5o5aKIV9fjDLmzLgYTpfi25nGs1x?=
 =?iso-8859-1?Q?KMYJWVmbAJZb7hNvMgYfAH2O6kWDdAdmOk2g2scQrdIHQ0twDJd9PxrsYW?=
 =?iso-8859-1?Q?s/pKYDe+LCGMBsuyf3jzpfFdSDpnIjIsHiZoEqdhIdy+HPFH1MktVAFa3G?=
 =?iso-8859-1?Q?j55yVDcvUE5x4WLvABxST4NC0aKFk5rbHJDOxOCCvXiS7uE7exP8pAisoh?=
 =?iso-8859-1?Q?s0/IMMcH6rpJzZ8B0ENUQZhve8OmM7QY5QoWo7GL3c9ix9vykGsdfUBtLU?=
 =?iso-8859-1?Q?xhmHEKznokiOEQEY8buhproKOKzpYZcBEBjiYidz9Choj7u8t9KNQnu3iv?=
 =?iso-8859-1?Q?pB4q6+6qnZph3P8YGHrUxPVEdmNMYViPhS5W6qzTOSAgMBQs3NJt9v/y9U?=
 =?iso-8859-1?Q?6Typ9wnPQLggUWAuRPup/MDEtnsYoPQqWEqE1FyaHWiM9qfGL5BbIC/qqs?=
 =?iso-8859-1?Q?9nPYMlhg4vJ29OTJfa+5kMfWyrpRLv2MqF6LkqKRLohFMWD4AYh6LTLyl7?=
 =?iso-8859-1?Q?rbGqwfzliro02fGZPNw0jez3INp2g6tSXAPdjUUrri0PBEzBtTj2nb42w2?=
 =?iso-8859-1?Q?DDNuRdJmD3PnIKEQEV1G2PNzI6oxUqec9q7c1ie630PpkwnjO6VVy/85lx?=
 =?iso-8859-1?Q?YUpgIO0mr2k9dJopGP3iKmX0Ft59B9KHZxllVC8SKq1wrIFnk0m6Id27va?=
 =?iso-8859-1?Q?hg7K9dVHZnqIfm/++6XTAVLTQIPoVvf7VMhoTInxO/+y0NZepOicSbyPux?=
 =?iso-8859-1?Q?IkVy11xqITooU4+96ErFFg6fcf4xZB+ow35PFowp+N22r79n5g8X6DNORo?=
 =?iso-8859-1?Q?KMCVHfJmCcuCP3U6m7TrgpmIyldTdt9+MuYUEnGwNxKlEONE0maFNPlc/W?=
 =?iso-8859-1?Q?z07lHjnzkB09QFsusLCxGrIxdPpmQDM/xRezEPJYpZKzzTWubS641tK9kc?=
 =?iso-8859-1?Q?4AOzR/GLzqLnX2KKB4ADEfQXD1qCCyLbIuRQzevW6EVJ6NnXMtb/Nm84YL?=
 =?iso-8859-1?Q?oCqR9PEGWfRLK31hHkwK8kU7i0mTDwGRJBJzr5bD58W6bE35N8qaGDTmZ1?=
 =?iso-8859-1?Q?S/pvnIKBYcxXfRWQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?+FKZPWwbyjCY1uxEjoOLmbKUEtS8h/ERSwItDvK1idiwo0gofV+7pK8xe7?=
 =?iso-8859-1?Q?RMysRMbeyztQOX04hV4HJDq/pB48yhAD42YGkCT4BTBsr/lB8HZbZid2rX?=
 =?iso-8859-1?Q?xvj0OF73+HYr+AKsxzmV023vuiaYyL8WDgWvkFR3sTzFPRE39v4O+JuS1x?=
 =?iso-8859-1?Q?0/CvgUO0SzuhfG4NeKKC6Up/NVu0T2NvFF4VeOc5nXx4ydGM1fnqALU31Y?=
 =?iso-8859-1?Q?aNQudb54/CEC2pDfjDd0yLB6n/eOfM3aVyRiUQfE+0lBMMRwyGDEA9f36d?=
 =?iso-8859-1?Q?hXmoTMdVnqTjGUnVRfzl8YpLf5qg1IDlMV7d4ja0I70/berm/Bsa7zkBgO?=
 =?iso-8859-1?Q?guKDsxOk08Z680dEzOR3NF779YLqIOFiPck7er64J3gQhKgZ+eo7DPNQ8Q?=
 =?iso-8859-1?Q?6wAqRYNx7JjqQVV0A2hxNKbYXz8wutKIr4RKkNA9PwBhIXo+S+5WMPpZ+z?=
 =?iso-8859-1?Q?b7ZM31sjJY8Vssks2PqJo8KjYlR2uiEy2Dlt69gsB6lD9AZdmT5aLT0NHG?=
 =?iso-8859-1?Q?ADYnHyKZSik2w/FYk6hqyWDT2+DFYmuQuAtAGUQPQDKB5yvCDdHq5DfcLt?=
 =?iso-8859-1?Q?IIDE9r247Oc6KqMXvb0dmDWv2MPj5UbMKWn+kxXdlseGiOyj0lujV4arWq?=
 =?iso-8859-1?Q?g5K/Pnf4SuxoozI7XcX9vUeqTKv4ueRRTw/IhNGGk0dT/WvbYsJH7wQH8V?=
 =?iso-8859-1?Q?MT9uNVu/Xsaq9s5S7sLL7xnvQt2/1JZDw0tL8em58kjVtDeThfwh3VnijO?=
 =?iso-8859-1?Q?qjwLo3A8gQ2v6NFXa2PS33DC5fJUsK8M1lCsTow7ltS/MjwFQkuf800bbf?=
 =?iso-8859-1?Q?0zQTXJfDo1GYHFTwiBH3s5qIl0ieNBzwKzs+e9jx4gRJtPGPJCkYDo1Ypk?=
 =?iso-8859-1?Q?gQhf8rKtv3cThNDLkd/mRiycdONO3xCbVZBV7s4vyuf3TcmFsyN66VcTnJ?=
 =?iso-8859-1?Q?2/Al0LEEWqdGy6vjzMs9hEdpMCV+EQoQy2OaQZsM6QK/3N0eX7IqUkCB3T?=
 =?iso-8859-1?Q?bCsfkEzZ4MFEUgs6SECTr60g5oLS4yTorpmV0mFlpNTbsYPPN5PNWLMv6E?=
 =?iso-8859-1?Q?76TuzCF1Ol2/o1LJmgu6uArz9SgjtG0sLJsaQO94yD19B/hLY0Or+nA12W?=
 =?iso-8859-1?Q?HsemO0A4nf7Xtq+RgiI9PLoOJQQRNpITkFGD6+3IlzW0iDnw4ADW7d5xGW?=
 =?iso-8859-1?Q?IOfczW8aP6zH02nh/QPadS0ZyO7sNm+GCjcZkJMJuDhuoX+CRx+nMmzu7V?=
 =?iso-8859-1?Q?7LiVkD2NDuYfaqqFiEyxGvbfC3w7osDlnG2BtKSmWx3p9zPUpj4RHFhKgk?=
 =?iso-8859-1?Q?AFmGyQzM+KOuA5P2gX6aEjhHJ0OnHX3or2Z3NvTwioQq8XeL4ZJnAf7d33?=
 =?iso-8859-1?Q?Ckf6wNCpsKUeB0DhrwcZWVDTxhZS3a5sWvW+chdRHMAWhm55tClAieBDd/?=
 =?iso-8859-1?Q?ZLf/iZzplu1rcGZbcT8kzwft2rCep6vCFm6os4s1mNd1pisJvDQynLnETC?=
 =?iso-8859-1?Q?4bLjvtDkxZpUzmosJ7JYlqSuoNqVOctBHD0ayvZUNnIFNoRqzdDRP/it7v?=
 =?iso-8859-1?Q?ekUeRuzq+yWWSHYphFasbvuDAdBcFH/tGSrGzWaEbe+WQxXHORtUXfvViW?=
 =?iso-8859-1?Q?1HQYUYVN3N/Hoi8uYtESlZwUdDiVB5AxMC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a283e1d-520a-4fcb-44d5-08dd5b37a113
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:14:24.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0AY8rRA0f+CmAPel3ytO1LnemwpZ9cSB/2gaXEDeyI2AUMErEsfiwvd+grnuNmmn5ODXj2Q5JlZlS9p3tC2vjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11080

From: Florin Leotescu <florin.leotescu@nxp.com>

Introduce OF support for Microchip emc2301/2/3/5 pwm fan controller.

Signed-off-by: Florin Leotescu <florin.leotescu@nxp.com>
---
 drivers/hwmon/emc2305.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c
index 4d39fbd83769..a236f27c75bc 100644
--- a/drivers/hwmon/emc2305.c
+++ b/drivers/hwmon/emc2305.c
@@ -607,9 +607,19 @@ static void emc2305_remove(struct i2c_client *client)
 		emc2305_unset_tz(dev);
 }
 
+static const struct of_device_id of_emc2305_match_table[] = {
+	{ .compatible = "microchip,emc2301", },
+	{ .compatible = "microchip,emc2302", },
+	{ .compatible = "microchip,emc2303", },
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


