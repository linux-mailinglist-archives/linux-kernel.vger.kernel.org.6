Return-Path: <linux-kernel+bounces-421291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E969D89FE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 17:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F928B641ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7FD1B3952;
	Mon, 25 Nov 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KFZmwRKh"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAE1199EA2;
	Mon, 25 Nov 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732548204; cv=fail; b=p83rAuoNEpeNMUlbnJDSQIautQc38b/yYudF9y/fs4vIq8/jHTwLrHCs9V3VywfBKyjRneTV0ptI1CAB1yOCgmFimWtPr9MR5BrWAocFJs8kEd3MOtA6gQFekjmdE5USugPRKcG2ehaKSCNk98gxSxe1HLmsVjHdIQ4p/4W3+RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732548204; c=relaxed/simple;
	bh=tlLPqaHaMntomjcAE24bK2ZHiZySH7Sh0loRlm+0ib0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Gc8QT0q6yf6+dZ5pHQn2bwaCNsE/x6sCXsPiH/jIC0Pzt8+fhxK2LD5B3rUREPpMpgJBRKU2Q1qTsZ1ExWnUVLTPyWmHAR6K4mz+loHqnX/wzTMBL6fo6EwcOkIVFPNdP2jJSLOVvNbshJhockkTZu8OX6mvMOg0gf763wwXgy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KFZmwRKh; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OBUpgMeMwYjzsx5Gz2+XU3djOpM4B2U/nYADmcff2TfrgG8QzzOzcs+pyE2cVT1uw2rgUtwGgP4IlSRq3X7+NHT18kgBhS5xPybJlB5bFQANrfbqEArkfV8G0L2wLA8jxfYfUr7IdpLUYpCxvEonZEbm2Mc5f0UM878xEBZnsFVKr9ViduzxYQoqu/RF7t8XVIg/iprAF6J6MGHZ09/TZS/q6p0U8h9vnTmgjgSVWu9sJMIgVs3N6TSpsfHjvygprRmyVMuJiCCOz8MjeG2wXufOeJ+VohCaec+yrsJWz8QIpIYJOht9Um5OuRNCiV02TiOtvD7miHzKPTxjNTfmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6dC7jxEYlmv0dGTI+wMjcosBhuxuu7KhkiXJ159MKc=;
 b=LyOmZdiSVGYWjULR5V6nWGYxM3bsBus+ZsnX0UuSC4EoNF8QaUzUByoxvv98EOJJOKPOzHBjVT1mRVPmwQiMuI+0GT3CbFF305DPKhA1m+G5B1uid66sUXONNOFsRrX6R2h1yPIHbG0VSIoeIB0TyHQTYgAFSeMupgDiAzZqy+oR/v5ny6In5O6twl0k6PJywqRsIUJwZG/PunVfb6OIrosNui7M5u8p5AS0UNv8+GKVnas3STRUHQEnYbEyj/IdvnXVwGP0zNyBqq37GuVv2+TQh7HHX7jSC9p19vK462+k4xKGeiyoF/dVztsoirJ90pOPG+4W1fOjV3NxwRr8NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6dC7jxEYlmv0dGTI+wMjcosBhuxuu7KhkiXJ159MKc=;
 b=KFZmwRKhmqVWAo6befvstiGyYFVkpHRc5KA4fKDGgEKHw8fdHYhyAHxYejFMATNZ9Ra/E0BoK7ipQ0VrJjji4+Kkd7Y9XQ1EvS/Svc1nsxiVWl/rz80uLAylevzHRCQEJ+yNSnT+JqhFw1Fbl6E/1IHoqOzkq/nyRTByl18mZYKPVSpmYJYpC0HciC4t1oPwPJ2sOIodqvBRxGCgI6WvD9pvHNnZNOse072nsvdHNfOFpaozCn66iXunNLFonDSjczzaLXfKzWxlKzrZex0DkGf2E03TlC0SIc1pHOmMCZiDU0ie7BMqhw01/hf0jyYX/gtjPNhDzEKfTKgpFOb0MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DU4PR04MB10886.eurprd04.prod.outlook.com (2603:10a6:10:580::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Mon, 25 Nov
 2024 15:23:18 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%4]) with mapi id 15.20.8182.019; Mon, 25 Nov 2024
 15:23:18 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	aisheng.dong@nxp.com,
	daniel.baluta@gmail.com,
	laurentiu.mihalcea@nxp.com,
	shengjiu.wang@nxp.com,
	iuliana.prodan@nxp.com,
	a.fatoum@pengutronix.de,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 0/6] Configure imx8mp dsp node for rproc usage
Date: Mon, 25 Nov 2024 17:24:20 +0200
Message-ID: <20241125152427.136883-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::13) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DU4PR04MB10886:EE_
X-MS-Office365-Filtering-Correlation-Id: aa21b2dd-c2a1-43f9-dc0e-08dd0d6516be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYj77i17v1GWinmnQgHhsSIDvq77wI9Mp37kTQl089L1wryc80DEeINiUFcg?=
 =?us-ascii?Q?YZZMftIbJqHijM2fHibb18lMbwJhwItm64CqHhOK/5Ag9V6k+lo+uk00Zu2D?=
 =?us-ascii?Q?0R7QeKJY+lDmAtLRzMjengJAdpgA95dkOVRSdZO37fnjVJnHWUPxUZQgD4Pr?=
 =?us-ascii?Q?DGIKUwP4IwrfxlR/1NIsSEyPtdiuPicYWRVJmGcSVk64YNa33QTtcakqm2wb?=
 =?us-ascii?Q?oSpJlflHlMsEeQbSFX0qFbc1ybJ4dSHMLNTWS3OTanI0uRt+vrY1n7/Yko/n?=
 =?us-ascii?Q?mKpf1JAKPbFi8HMHrkeJfVGu6CPKXfaSoPFjk0R0iLqilP0D4B41JEgbVOuR?=
 =?us-ascii?Q?XsUI3jJ3hsiyXeWhYsC1nljAgzq04oHRa/DfL684ygyi98Aed4vJo2eZJkbQ?=
 =?us-ascii?Q?Nf87FhNPIpiMx9UMLpGwfhYVPzOnbacVJaKlLoZtFeaPHx1kg/zNXKitHgm9?=
 =?us-ascii?Q?QwBSwZHcDa7uHeQpXa3MWrx28ju50K33jDwxLXVaSjvXuhOQNXj0hXzztm3w?=
 =?us-ascii?Q?bJpoGPHHl2t4Qzh0NWcpIMWybaCeMwDgFBdq3e9B1jd34GzY3QGfvM3klpcX?=
 =?us-ascii?Q?TCEgj8GIC27PwKb+/oicz369h7VE18gNpvgK+ffz06jvpY0ZF7+s4jQyXK/4?=
 =?us-ascii?Q?kXlssIhyMcrBBoKsb4I+VyU3waTXVKwju15L5GPChvIQ3kXaPJp4MdjEzsaP?=
 =?us-ascii?Q?a8ROAlBwOKRIBVsDvFxF4LBh4sQZ05hKhUT4K59EyfBCXAG2mfdjcq4k/poA?=
 =?us-ascii?Q?LB/xl6ZPls2OckDJ5GY+MhjvGz068rGjPmc/ur0Xv8KGVYIeGbeyKgLmbM31?=
 =?us-ascii?Q?4NQEq6BTXNj/A3d7HYhH9aGcdOj2xi/ARbEXZS1UQkw69pXo+WEBodEh80Vl?=
 =?us-ascii?Q?FXZN/MrRD0zSadv4wlGiLUcjtQrnobZxbRKfMSW63167DB2TsM8V4nL12NMu?=
 =?us-ascii?Q?+XdvtyAUvPtBZiBdI0KMXTl/G1SmzX1K3KCvw1behgf1r/pVpLFENrEJVhRi?=
 =?us-ascii?Q?pedNi05mZxdqEdzXc3FTwKqODfkbgQSULb8L9wbJNKwTxPNk/5AFkPy322uc?=
 =?us-ascii?Q?yeXFvGo0WWQFBMs3X7rTx21LLEWUHrMXb+RXKn4tMuStEEb30PzCC3JwA/zM?=
 =?us-ascii?Q?FKR0Qiu1j3cP/4iXtYE23MixhZOMeTgeb1Mb4W8uXHjTP66LX9qiJdwWGFxn?=
 =?us-ascii?Q?n3NsMduL4T2yVz8+HuAWA5TGiIWrONExk6fYgJeltvgZTcM1lQa2g2kLHmVv?=
 =?us-ascii?Q?wpwEszfD7CI7CTQpAWFNV2tT8VmiOmrvKCmXDjxnhS8GCul6sKcobaA28NhW?=
 =?us-ascii?Q?PuW+WEOdQBdTZGgMWSOuCjg/gRAdtKZV4ic73/yFi40llau9XrsUjN4O0m+9?=
 =?us-ascii?Q?d5IbmOTS5lOTj4pfcvf8CKV+0CfY4cCjQqXkTWJ4SFzio1S1hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMsQgi/MIym+ALDtOlzAAwGTVbFIHMTlelShVsjcCKaU8Gd19kZBlsRWt9+O?=
 =?us-ascii?Q?KH6JWgzB12QcJPQXuEY1LZXUnk8o7gdOFIAKz0bggp/mAd+zj0jRMr1vvvih?=
 =?us-ascii?Q?CYjvKcntVV6c9Y3d9D12EcmCwpSuK4Qi4Js0lxC5KibWK7YbbIfC63Jn5hfh?=
 =?us-ascii?Q?BFldbNlbDaHWjKHDMaq0aRU25l89Z8OsUO+rIlBWXxtXFSSMSgPPbZNMUK+H?=
 =?us-ascii?Q?tUdhZT22Zn4px9y3R5ru5O+bgI7PEyKwMC3Hpr1X/agHgA+bRMElkGK46dFG?=
 =?us-ascii?Q?/B7jcBeXrIwu8ERbnhT/FPjunceJbJ12Sg3A22taDJnviAgYRrDvoqrExIWs?=
 =?us-ascii?Q?p9cFAEwdHQBLS4FW3lMS387Akk0938LVaErl7hgLBHt5gH/MxYjS+ufUXwGq?=
 =?us-ascii?Q?wlXzV2amX1GiZusE8wTppAl1kQCqyzdWxwoA4Dly4nzhwwQFXS2yvzaUub4M?=
 =?us-ascii?Q?42rpTekd+9UsFARtbtKyK1Hv7dApHMhQ4FpEgoiTHwRiVqi9Z/MO81RZWs9W?=
 =?us-ascii?Q?KbeadX/x6OPfLAHvX7ViSpTbE3NHoCNKOmP6qlqG/BCO/XP6jHkoVKDDCF5B?=
 =?us-ascii?Q?eZIJOkduuabjCZk6o6+Jr6ELnZZLcTeHQ1rqxTpcr8CmZPdEea5yEEQQE4sB?=
 =?us-ascii?Q?AiDnf+Y3TP9OvyjOKzvPF9WJXDeGhhSwpEp3ENrX5ZsoYTE+KO/V0o6ehFyt?=
 =?us-ascii?Q?6vLkwonlS887eTQSSNsEQjA4mlaOR7jpIn4arUp0wgECgfw7e1KYPPraUlcV?=
 =?us-ascii?Q?EbtlCtj60MVEimQhh6/r378Qm6jv2l1Suj/cvS0cCsdqbrhzzwodEQe0wu7F?=
 =?us-ascii?Q?akmkhk19yxe6om7AdLnoiCwejCH0yEmYrt175r0hgufM9RTm3SupVVr4nxrz?=
 =?us-ascii?Q?ZmsX61n8CrtG3X10x/YZS/zbNvdgKct2BQaTlEMCNaNTbz6/QUEG01Qq80Wp?=
 =?us-ascii?Q?DCHCT+GIQNdeRqVvNXnLlhL5Q0EJhd4f1TZ2aB+4OZFSg4CB0jVddTRfJ3UT?=
 =?us-ascii?Q?WUFVyuOuYCmIA8e6bWv/0frL7NXpB4kGgt6l2AUnpCY2RTbBbd/eViKGtuxb?=
 =?us-ascii?Q?1MMqHyLlikTcVhFqBtmclyu+Muj1K9gbYOkJj1RPaC0l3MgLRdtjoOksepxQ?=
 =?us-ascii?Q?h5UOqhSGhttcybL3oAYmVT9tN+G9JDCCaeeNcPlJONFH4YvRJ/I+UdiII0DY?=
 =?us-ascii?Q?wucs4Po69X+02GmEBlLhecu6l2v2m+GrSA7aeZArGVigpY3HMlL6S/Ehqnrx?=
 =?us-ascii?Q?1HT/y2h4Tgls+5xomccb8VjOA2PtiXHibe4m6x9hp+cgln3uEJeOP9+/W5td?=
 =?us-ascii?Q?TtivMtrv4NTt3gpe0nHqjXKgD+yPX7wW9njWRCqJkYFVlD8nsNDO4XbLnzdT?=
 =?us-ascii?Q?NnOlsqNmKCO6Fx/bc7b3nGfJyvOrQNYbXYYyJ3KdlK5gUVUfSkmB43AkskOe?=
 =?us-ascii?Q?1ynRK2uYm1dRVc6PWx8h8M7qMfJmMq/RqyaZWBtlKaIgwIQc+riiLGDbQKW8?=
 =?us-ascii?Q?V3clSqaRhy+WUlvBcI4kZAime4MINjDHCJ2V4L/msSF4JCTq7Zpl3hHSb0i5?=
 =?us-ascii?Q?1J3Ho5iK7rUgT1S7ecial9pxI45/SWM5Q+htBVIw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa21b2dd-c2a1-43f9-dc0e-08dd0d6516be
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 15:23:18.3174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfeaMHWgHUDy5GySDJT/qfVF96dCEN1eboa5/VQx+QJUy18us7pSjR8y652Z1xCaK2KkA7wJ3YQ514N0DDL4Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10886

DSP found in i.MX8MP SOC can be used by multiple frameworks in order to
enable various applications:
        - rproc/rpmsg framework, used to load for example Zephyr samples
        - Sound Open Firmware, used to enable various audio processing
          pipelines.

Current dsp node was configured with SOF in mind but it doesn't work
well with imx8mp-evk dts. SOF controls audio IPs from firmware side
while imx8mp-evk preffers to control audio IPs from Linux side.

So, configure 'dsp' node to be used with rproc scenario and later will
add a separate dts or an overlay to configure the node for SOF.

This patch series configures and enables dsp node to be used with rproc.

Changes since v1:
	- document syscon compatible as pointed by Peng Fan
        - do not disable dsp_reserved node in the dtsi file as pointed
          by Ahmad Fatoum.

Daniel Baluta (6):
  arm64: dts: imx8mp: Add mu2 root clock
  arm64: dts: imx8mp: Configure dsp node for rproc usage
  arm64: dts: imx8mp: Add DSP clocks
  dt-bindings: clock: imx8mp: Add syscon compatible
  arm64: dts: imx8mp: Add fsl,dsp-ctrl property for dsp
  arm64: dts: Add dsp rproc related mem regions

 .../bindings/clock/imx8mp-audiomix.yaml       |  4 +++-
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts  | 10 +++++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     | 22 ++++++++++++-------
 3 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.43.0


