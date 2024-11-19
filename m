Return-Path: <linux-kernel+bounces-414332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DC79D26D2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95FEEB32A97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB8A1CCB29;
	Tue, 19 Nov 2024 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lx40ZW3e"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69741CC890;
	Tue, 19 Nov 2024 13:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732021590; cv=fail; b=K93QLGhYX954LsSyFFsBPuG9a5DSjrCqFjtW4rbP9kwSaVoBdTG3H3eyogM/OXaKEQLausVJbUO+zgbtg/nyhOjwba5eb+1b6mp6WkHLRUREXPI1icnl1tf42+QHJF9+Udat6yE8RsNDhUA0cRDN3xEqQtZ8BbxVT/unjCfVLmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732021590; c=relaxed/simple;
	bh=9n1l4mlV+/2Yi9zZ4MJH0v6ah7sH8HmBSRJG0J1sczc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fwy4bGysesaxo36/EmjoyNp/0Dt6olAGw0UKySKRuDmZ707wuASbvJYqcKU2Wyzsk2x2Yv2b4QZezzYCqWpK6mBPA5YZwe1yb+WX3NlEyQM0rMCc7hje1EkAjlqQJRzeNx+ePq2r8DYjuUtSCEwgByM/2U4yQlVT45EHH5DPCeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lx40ZW3e; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA49WGpKLMQljpAI1BiTNAqz5gqxGeLvEJXGysJEEf0ezt1zJM3PSk6PywN8f9uESKTGLvHQSbC14taU6h3rvddoGnSEA2V/OElTUC0pTh7cVIe6+JpSETRLJFjiGyfPrbX3DgYwHsc7Dup8h4Ye3bhrE8j0QujOA3k6f1v35wP/xIP+k3VVdxEYvzamYOSlQ6/gE3YwxOVtqJcbtx1A6vgJQz/eOeJXxtFrRv+rsaAo2Ow1y5U9/H+WsCaHBUo2B+d71L8OSGWJghBATzOl8yD8mBqCXAfGvmn2S5U24OJooTXi55CWMTUy5ld3lBDxMURxSRBui1jINPWmVg0hFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oDz3vJb62xJD0+rLWqFj6vddTBOSGL4WKjZfCy4h+A=;
 b=Tle29o1xBfL5bkXJFyzl3baRO755EIZPmw38yBBninho8pTVJBMTqwLLvufXi+rg1WD746PQDU31Q5Q/oPEvzwDZeZH0dPxGK4kpkGubrQ8J21MZq4zSECR6ypqK0pAj/w32gZweQyTnq9rDMVGi0iMsTj6SuWGQYJxTSCOehB2aP99wIBjjG7q5NTbavlI5QtcaZpB8HVIPnUVJkPzXDAKvHkdhPZdJ6I+H1RMc8gmz5sKWZ10cwRCIneHjvUaQG28GogAGmf8XoOg6zOnqdR+gfzOzCYuR1Nd0BiaZHsujXJWRY4/DCfpbC6Dai1I58sKHcAcfuVJ+iVSnzdozxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oDz3vJb62xJD0+rLWqFj6vddTBOSGL4WKjZfCy4h+A=;
 b=lx40ZW3eDUwYVP+vbrZGzVc6KPMBiQFdfzreJUt566/Kvs5BIMN/hNVSE9+a1PoIog9YCtuy3sIM/1XGSujGN3hQcCSeAS85I6a8mpNEezWotrTa4uXDN8RcSM0OSMkPeR8bs35HLFp1Z64S3SG9COmftSfOrJCQgPCPqh3IH4N4x+/66Qi8mPinOc3Puv6TcxBNcd5hJs89Qnf2BHhx4pKuxzVfSOGIvdRsOSGY5fvOXRtD1f6p7KuaQk2JyjZl1S4/ympC1MPr5GB23fPVhpm57BwUY18dEoqB8AEaosbnswlj8DBo2amN46P7NRmlGUCU1gydwzeCPRy97RB0MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 13:06:25 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 13:06:24 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	kernel@pengutronix.de,
	daniel.baluta@gmail.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	aisheng.dong@nxp.com,
	peng.fan@nxp.com,
	iuliana.prodan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH] soc: imx: Add AHB to IP Bridge configuration driver
Date: Tue, 19 Nov 2024 15:07:26 +0200
Message-ID: <20241119130726.2761726-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|AM8PR04MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c052d7-9873-4f49-6fdc-08dd089af830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7UQ7XFMP6/SXWFAkcy1XYt+GLRX+vJmASw+2KMiCA4LeV5M9SuZNYdKXMlv9?=
 =?us-ascii?Q?2Q5e+IhqkM8CVRIc+/ZOejQdFM5kY3Rrjo9gaEOph/jTOT3Et5gjjPo89h2I?=
 =?us-ascii?Q?24gfb/6AjjeLu7WGbYUWTrnlZssJMRzz5mDwq0w15T0I0Ru+LusZ65gDM5F6?=
 =?us-ascii?Q?PE5U9wQRgTyhv/n/S2nrDAmFlGNnjKumCRpWTROqI/LWI5THhiwp1IHSBHp3?=
 =?us-ascii?Q?nj+dpPIE3ROHhiFrewFozkzI1I/MLyikoUbgAG/YAe6dc9/EmRvdk3ge80VZ?=
 =?us-ascii?Q?hJqyL525GbjoUgDvsJ+/VN8/n9pRuLJdYuLZjUbAGTr55KeqQzmPIhrLVLm1?=
 =?us-ascii?Q?ijDwFCG5QdoeAU1NHqayPmgY17RfHWeSJbvQveCeLNEOqnPCK40qs+r5J4uC?=
 =?us-ascii?Q?ZoY3cP1ZfpEtvmE1zfydN3P7P2OIzLSjLS6E0Nm4Eh6B1pL4gvbgfyjlBCst?=
 =?us-ascii?Q?bbDX9NPMD7tGlhRKXKKM4ZzQm0ykGj5XqxK4wAA3EwyUCP6mKdTQ6FDIeSFg?=
 =?us-ascii?Q?a5KUccwq3rQLFwy/X/lYRll5t/OUpSSbMAW9/Lk2wxcV5r2IMAmxgIgVFQzn?=
 =?us-ascii?Q?00O+fEsk1zZ8D6u9v0w84bXvynenxu9zripJcaC4vtG+2nRBIT6dXgPj8/Xz?=
 =?us-ascii?Q?1L+w3oG5qGvQruCa+QbJw4lF4+S3tM2dbsj/G4ZecjExDK7xAHIlYKNKnQuZ?=
 =?us-ascii?Q?3YcIDiQBffgnzBlnz2Eu7Rnx8qYIOAVtxVwowuJ7frOYtKbdh1Buz60p8pwL?=
 =?us-ascii?Q?CFPiDjdi3Yviya+RoxUK+fqge6LhFqgjQzXMgqmpEa6vbWzHy7sBBOqQ9EtH?=
 =?us-ascii?Q?eEmc12sHUIbJtMjDTqz2A8zVFrYsav5cCV7c1P9G2+v839aL4qr7v/ZC9IFA?=
 =?us-ascii?Q?pgpS7PDdeHt5xRn8hlHCtuQI8flxuCKWGj22XXyEtkVDgWEFkq2Krv9wEvMI?=
 =?us-ascii?Q?APtNwaCai9Vk5/Lw+NfatzX+meNkL1qQsrY50E948SipkKuNII6Wc1UPf2cb?=
 =?us-ascii?Q?0GvNINDj3pCZSjrevAAidsmDGvyTmvASYTpKI6E1nDF3JYpModyFxZRWtBdP?=
 =?us-ascii?Q?lpn03mFoDK0h4wM0Risq68wWNnz763UHaZl8O1UXrYWBoaYkr836gXDLk+JI?=
 =?us-ascii?Q?+KBheroDMrLUjwpqHeGY0ZPlzpgGXQarV1+epuc6DIhAmKWWv7uuSwdED9nK?=
 =?us-ascii?Q?ykxEa4QVrwRsNdZUAyv3Ralez+j9FhszknOh8wKjko/BYLHdrj2caililYxY?=
 =?us-ascii?Q?Z+vP3CUkxYQsJiY1wmf/+yTCiKFpEvuxfv7PwpMSh7lKafPwwyF+TSPgvetv?=
 =?us-ascii?Q?cZpgTSkxExtQzpEU6wt/em5UOYxBGe5JwgqtIRLBQzpfSkjuGaYGoLekv0O7?=
 =?us-ascii?Q?x56ra4c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/RB+UETIxtH9XD/lG2OgXfFaTxktwjtuYiwhB/UDEVJs/7o9o9Z9wwswz3ux?=
 =?us-ascii?Q?p4HAouKreyOhPocodHB++WGyAxBL+bgCfk/K8H1dzI4C8ESEVpYwilVQ1oE6?=
 =?us-ascii?Q?SI6fJiyFQ80tFBFY7YWcz7eAh6Wwt+ZKXHzUK8XdmLb+Jswtra6bTV+KLc0q?=
 =?us-ascii?Q?Ch+O95onhLT1o4+ddMWwdqSDiZu3yI0VBpD+ROLHNZLyyR7xtnaUQU6JAW8B?=
 =?us-ascii?Q?SqgUicrbanvFaMSeQ44SOKe0prttLUfDXjHaDlnbv7YyEUSiS3t8+1GNxMqP?=
 =?us-ascii?Q?zeqKr2nKUJelPxHW7fSLz5aNVQEBenXJRmXvitxfu3aZedysUKfsjTVssFrx?=
 =?us-ascii?Q?KjImzqSvnTGvNSiojxEDoWUpK9QW5qh/B6ADdMdG945IGmCsfipoG6bfnz63?=
 =?us-ascii?Q?o15bP0GOe0aRmSbTPCRgOrBZxXZUYMsm/ykc3+4jzN14nIANQECi0NFDH5el?=
 =?us-ascii?Q?crGX/ansOqTyC6VQj5GFEgN48+OJF9zxoRH0FlsSC4luXmbYEabUGnfi+AM2?=
 =?us-ascii?Q?kzUOWFWjHIcvziXY73pVLOGB48IiVEjw4tfC3JGB1BBIumT5OqAvfd8a72VR?=
 =?us-ascii?Q?JSql8seWjLyMRphpxc4tQnEk+GrOwOaVdU6W+MaPR0uRuItyFTMgGwv8mbkn?=
 =?us-ascii?Q?v1G8DUi6S0TCR9osnBgb37dnqQu7mHQnxvInuiA3qG+9wTTep9dNnXdCIuAW?=
 =?us-ascii?Q?av0yEncP7H3X9O+pwNfNzv80hHF5BZCXprIgvzzpvsAERcVbW5WQ1MARSpy4?=
 =?us-ascii?Q?lZtJV+YKDWjp5n1AdQl7NUwMm7IWQ736ofeikYiwZGFVA+sqXAUf6lu/VJxA?=
 =?us-ascii?Q?dIRtPIM/Bwvx3mdbmhdYBPc5ICyQyJgr7rgPWyfPPuiK+aO/XrZxB8NwcP3f?=
 =?us-ascii?Q?Gz09vte5/2YcJ3/zlRsuNfYxQ6Hq+DbfAEQZqwVV8noJeQVR/ODn716jVDSy?=
 =?us-ascii?Q?qYauB0gk7LcRVfsMR0ZPaHd1QsoPxPns1lPQ9/M0S7AZZO3nWKwRDQ1po2Nv?=
 =?us-ascii?Q?L/xroett9mmMopKLaVfSk2rHZahEx5kSTi+16lND5IAHaveoUNVxuZ6qx/q2?=
 =?us-ascii?Q?wJUNMFczM6tNuCXRGJKNf8TUWaImbufpiKPMl4YHUj9feJww71zav2Nob7mG?=
 =?us-ascii?Q?QtwGPMq/5KccwFP8NfdmRRT+eEto5FI/EX4gHSns4FLbdckztHVXGdR6BMUj?=
 =?us-ascii?Q?JvqjXxtZe4GIjvsNvRRwaZAgEMwCxDBmi87Cdf5e6BZwBBIGoVxlgcco9U/Y?=
 =?us-ascii?Q?wiXQDlpeTarwSXiYRiR938dOfH8WDlOBGhlBgLDgoiTE7wGNCNUI5gPh3yHQ?=
 =?us-ascii?Q?axVCuxt53zzZNNCFu8WntW81kObPa4WATz9r0z0xyf53yDcC3+I4ODrO3h7K?=
 =?us-ascii?Q?0kC5UHc+uZ+z1a+4uAtPJ83dequh9nDtU/GQEwTjHShrUlswtnDyeHqy4hY4?=
 =?us-ascii?Q?UfyzriH1BxOj67ESfRQZf0rSCKPUcKbhKlN7DMpZCMP8wcb0TXME2IHrLg8w?=
 =?us-ascii?Q?FzSjvorPwq61BmrPVqo/T6x1VWT7VaGEj8p+HO49ig7JMa4EBibIezj6BcPD?=
 =?us-ascii?Q?KuGXuE5+yKbwvAWWVELUpmYp4DAgtA3C76e6Krto?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c052d7-9873-4f49-6fdc-08dd089af830
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:06:24.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J581ZOHHKYXqq43+ChvA5THjZtuPGk0NBdem47Zd8oszLVdKHHeiojU4k2R1SrEKX43lBe+YOG57FxQWKHR30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7284

This is a RFC patch in order to allow AHB to IP Bridge (AIPSTZ)
configuration to be restored after a suspend/resume operation.

This is particularly useful for aips5 bus where the aipstz
configuration is lost at suspend.

In order to configure aipstz bridge we register a platform driver
that will set default configuration permission at probe.

Because AIPS configuration is lost at suspend/resume time we register
a power notifier callback that will take care of re-initializing the
configuration at resume.

More details about AHB to IP Bridge:

This peripheral is designated as the bridge between AHB bus and
peripherals with the lower bandwidth IP Slave (IPS) buses.

The bridge is responsible  for indicating to IPS peripherals if
an access is in supervisor or user mode. It may block user mode
accesses to certain IPS peripherals or it may allow the individual
IPS peripherals to determine if user mode accesses are allowed.

The bridge supports the notion of "trusted" masters for security
purposes. Masters may be individually designated as trusted for
reads, writes or both.

Even more details (including register description) can be found
in Chapter 4.7 AHB to IP Bridge (AIPSTZ)
of i.MX8M Plus Application Processor Reference Manual.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---

This RFC patch is to get your opinion on the direction on how should
we proceed with handling configuration registers for this kind of
device.

It registers itself as a platform driver at boot time and then is probed
once the dts node is discovered.

TBD:
- device tree binding file
- enhance error checking
- is this the correct way to handle this kind of "peripheral".

 arch/arm64/boot/dts/freescale/imx8mp.dtsi |   7 ++
 drivers/soc/imx/aipstz.c                  | 114 ++++++++++++++++++++++
 2 files changed, 121 insertions(+)
 create mode 100644 drivers/soc/imx/aipstz.c

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e0d3b8cba221..7775f5f58036 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1406,6 +1406,13 @@ aips5: bus@30c00000 {
 			#size-cells = <1>;
 			ranges;
 
+			aipstz5: bridge@30df0000 {
+				compatible = "fsl,imx8mp-aipstz";
+				reg = <0x30df0000 0x10000>;
+				power-domains = <&pgc_audio>;
+				status = "okay";
+			};
+
 			spba-bus@30c00000 {
 				compatible = "fsl,spba-bus", "simple-bus";
 				reg = <0x30c00000 0x100000>;
diff --git a/drivers/soc/imx/aipstz.c b/drivers/soc/imx/aipstz.c
new file mode 100644
index 000000000000..49a619f17dda
--- /dev/null
+++ b/drivers/soc/imx/aipstz.c
@@ -0,0 +1,114 @@
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#define DRV_NAME "aips-bridge"
+
+#define AIPSTZ_MPR0		0x0
+#define AIPSTZ_MPR1		0x4
+
+#define AIPSTZ_OPACR_NUM	(0x5)
+#define OPACR_OFFSET(i)		((i) * 4 + 0x40)
+
+struct aipstz_drv {
+	void __iomem *base;
+	struct notifier_block power_nb;
+	struct aipstz_cfg *cfg;
+};
+
+struct aipstz_cfg {
+	uint32_t mpr0;
+	uint32_t mpr1;
+	uint32_t opacr[AIPSTZ_OPACR_NUM];
+};
+
+static struct aipstz_cfg aipstz5 = {
+	0x77777777,
+	0x77777777,
+	.opacr = {0x0, 0x0, 0x0, 0x0, 0x0}
+};
+
+static void imx_aipstz_config_init(const struct aipstz_drv *drv)
+
+{
+	const struct aipstz_cfg *aipstz = drv->cfg;
+
+	writel(aipstz->mpr0, drv->base + AIPSTZ_MPR0);
+	writel(aipstz->mpr1, drv->base + AIPSTZ_MPR1);
+
+	for (int i = 0; i < AIPSTZ_OPACR_NUM; i++)
+		writel(aipstz->opacr[i], drv->base + OPACR_OFFSET(i));
+}
+
+static int aipstz_power_notifier(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct aipstz_drv *drv = container_of(nb, struct aipstz_drv, power_nb);
+
+	if (action != GENPD_NOTIFY_ON)
+		return NOTIFY_OK;
+
+	imx_aipstz_config_init(drv);
+
+	return NOTIFY_OK;
+}
+
+static int aipstz_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct aipstz_drv *drv;
+
+	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	drv->base = of_iomap(pdev->dev.of_node, 0);
+	drv->power_nb.notifier_call = aipstz_power_notifier;
+	drv->cfg = &aipstz5;
+
+	imx_aipstz_config_init(drv);
+
+	if (dev->pm_domain)
+		dev_pm_genpd_add_notifier(dev, &drv->power_nb);
+
+	dev_set_drvdata(dev, drv);
+
+	return 0;
+}
+
+static const struct of_device_id aipstz_of_match[] = {
+	{.compatible = "fsl,imx8mp-aipstz", },
+	{}
+};
+
+static struct platform_driver aipstz_driver = {
+	.probe =  aipstz_probe,
+	.driver = {
+		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(aipstz_of_match),
+	},
+};
+
+static int __init aipstz_driver_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&aipstz_driver);
+	if (ret) {
+		pr_err("Failed to register aipstz platform driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+device_initcall(aipstz_driver_init);
+
+MODULE_DESCRIPTION("i.MX8 AIPS bus configuration driver");
+MODULE_AUTHOR("Daniel Baluta <daniel.baluta@nxp.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.43.0


