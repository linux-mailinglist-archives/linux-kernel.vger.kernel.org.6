Return-Path: <linux-kernel+bounces-216648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F3790A29A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B921F22D30
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8F17BB18;
	Mon, 17 Jun 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bsZMb1mI"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB91176ABF;
	Mon, 17 Jun 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592466; cv=fail; b=q5nxFlVWpZ0GQrYCEjXkMCWA4pZ45SMrJgqcRyjmRE4vGiIJu2A2QcY0oRdV5zLoyxHW4oizgWaB5FG6l4w59wYr5abNpED0KV3oTN1KBcSASnsk+tVBs4DmEj7XcD1vFjfVk7hXpFPZieuwVM3frjS13/bfPzP0WDOSydU2weM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592466; c=relaxed/simple;
	bh=xDHthho3clLMwVkgJtffn/O2I4fbcl26gyOATRJQtI4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dRQLMs5wTu/gFKPpWuwsa/aAzKQNO0eGxumTZR1pzLnvzQ7VtEnGxq4OrVfFIIe56rwR8ITvmMezMDrNF088gxnyTaYn0TdLGiRgzQZhKOLRMxJBfVZ0IhPXc5oKXYkk1Of2GEHlXkG6eiDfyUD+LlbZobN//UJbNi++lUuU4E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bsZMb1mI; arc=fail smtp.client-ip=40.107.6.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyNR3M6tMkKaOfQA7ptzLGO6kmrutkm+vOMjQstoJC5LqVd6RFqsPWzyrTVl7ouaVEM7xDQ3VWQ2OdfC45urizFyCIrWYdRSrzIaZ1YsvPugseQ65atHfyx4Ezg+mWBy3u3gLAwwCShp+6GfqSTLhCktOeM8jb1a0zlaJWDskBaIuUApLpl0Wlv8gdAp27ods+02diuGRUMht3BtGZZQIE/GUFogw4eXh+8PfPPIXuh/T30ZzEy2G5vN8wRDrSSIISaTE12FYx2AFB6oh53hfNrMRKDhdzKZhFEk9mO939G8lwo+5lb4IFH1bhVZlmWwF9LYcZs1y6oAerPZ6bgk2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=E953QszWj29uEcNO2X23HPuBm4YZEUCISepODr5yfjXvPB7C7iyvVcyL6LpwTxA4a3gZuSoPbUZtyFFR7ryjv7ecQ16jFndmBeOymbzH0ngXf2qMNXv1D9Q5TLfkxGKsSj26hqhUUOI9IRRFC2Pcp2Fv7cVZr0j8AuDywcPBDMi83uMZ5mAcTMBgsDnGA2fQh4ddy/AiecdjyKbM3ZhtKTjdM45AsGDaTNqi/Q2YE9em/B7cFnhalf9j06v4OFCPO6InRssrX4yFQEvb6ZeDcRzHgw1IOA06Eg5hVIvoPmHqzeDO26kwD+mTQuVAzOPWw2YcRgdKhImrftDXPzHG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3LuyELaiSC0sVNX2XPvkzFPVBktsV4F8YpUGnJ4zDs=;
 b=bsZMb1mIoCGGCzfbBefb1SGDxAPeNDibRg7stvUyFG/4wrMIo+QW+sQDxXjU/KQ3E5JOH4GBO9JLtB1DOvPFNehYM8umAqEWjaLNWLM2tbxJquffbnKpD03JnvPZrZYf6oF3e4aMGI/v1+mvhoSwP9ocuHO0QjTn3iGmCdPTlA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS4PR04MB9482.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 02:47:41 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 02:47:41 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 17 Jun 2024 10:56:35 +0800
Subject: [PATCH v7 1/3] dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-imx95-dts-v3-v7-1-488b52e10862@nxp.com>
References: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
In-Reply-To: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Peng Fan <peng.fan@nxp.com>, Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718593010; l=938;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=hxkVlQeaJgJhLHSlZ83jW3veqMTWVj/bEjw+HMyTvrY=;
 b=OEdIil4yEIH2z2tC+nlblgGrW5GWuaASY1oAIKvaB+IBgM3WAVouTsUmzzLMtuos3Qc2nF6wZ
 m3BKE/lmhgXCyHO78v1BFst0tx6GAzbT0WIT7QTlDOOvHECzYGU4wiO
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:3:17::35) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|AS4PR04MB9482:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c0dac2-4c8d-4199-8680-08dc8e77db5f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|7416011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEVLb0FENUVudzFvaVNCMm1NZEtvbXdLcFdrOGpOaUtsV1ZQd3ZIUkhXeDAv?=
 =?utf-8?B?dU55Vk5yMk5XRWphOC83dEN1bytZUjVtZmNTTnQ5ak9pZzlrbU1sMUF5dk1o?=
 =?utf-8?B?K21ZenNlWkViQ0NybGlkWThuTHNaU3RUSEczK2E0anVCWWovQkllS0hqRGhm?=
 =?utf-8?B?cnBTejY1ZUE1OW1MTUVJczFPdnBsMDJCV2l2azZBYUpuY2Z3Zld0dUFKUlJl?=
 =?utf-8?B?bi9wakxDRmJKU1lnL3BuNnVqM1ZRUTFocXY4N1dvMHl1Z2pGVDlDaTMzWER4?=
 =?utf-8?B?c045TWs4RjBDSk1KU1pYblByUGpRbjZFR3VXSExLdTVnU2YvQTRFYTdqNllX?=
 =?utf-8?B?ckZrR1V2Q2tVd3RMVWtEc01nNjhPdlpBOXo4dm1ZM2hxK2ZPMFRTRHpVV3hz?=
 =?utf-8?B?TWEwRHI2dHkvWCtLUWloY09xWjNucXY1QjRWV1phRUdRS0NPQ2huTlNqcXl4?=
 =?utf-8?B?MENlTk40ZlVkMEdzcXFDVnVBbXMvNlU5Y0dXbXIwU2wyTFZJQmJ6WGNtWFcr?=
 =?utf-8?B?Vk1MRU9DVHNjOW9sbUIxVXNneGlqNlRyOHZXandqMHhyYjVDNEw4WjNTWW84?=
 =?utf-8?B?NjY5dG5ycDkxVFh1L2JNTUI3ZzdpS0FNNzJpQnllb1hDSGlJMmp4OWlpVGdV?=
 =?utf-8?B?N1V1QlRaVk1hdXF0em4xaStxYmFxRFE5UkZRNkwzU1lMWFIyTmp5RE9LOXRm?=
 =?utf-8?B?OE1wV2dQQUVIOGFiVThVOHMxVitzbitBbWJvVVdKZDBKSVhmSHd1N0hmYkxD?=
 =?utf-8?B?Z2NpUDhkMkhKNHI5RUIwN3hwK0xrellMdXVhOUcxWW80V0xBRVFsNGJwS3p1?=
 =?utf-8?B?elZ4M3c0NmFGSVMrVzd3aGNCY2ZwRjQyOTFBdngzazRrbUFUWXJvWUdFMHdN?=
 =?utf-8?B?TFpQNDQyQm5XYUwvNDVRc1hOOWZGbElUZlhxM0s2RmRUS2dncTFUQkJ1TWFX?=
 =?utf-8?B?ZHVDcWpiaVAxQTNUc0hMYVY3dURnQytqSVpYbmxlZDdRRjRJenMyWFJkZmxO?=
 =?utf-8?B?SjA0eW1KUHQ0eGdpMDNXb2ZmTVRpS0tOY2tMY1RhYUFjN0tJbTZCWVJiSGRG?=
 =?utf-8?B?M21HUk94dk1Mc2N2RWpGcTlEK0wxeG9PMU9YMmRST3FSUXlVa3lyckFBeUNl?=
 =?utf-8?B?ODVjUzYwYzZtK3NjZUZDdkgxU2NHanN5eWZmclp5cytxU201TGhHTExwakdo?=
 =?utf-8?B?RGtSSEx0eWdoQXlqYXZ6VGY2UVZSSkJJdnpqbGhEa0tqZ1hLd3lvMGlNRDF2?=
 =?utf-8?B?SzVhSEZhTldQbjBHd3V3TnplTmZ3cGtZdVdqc2dqb0U0ZFBSbWlZeXNOOXl5?=
 =?utf-8?B?LzhvN0I1RFhDMlVjdkJ3Q29pV1o1TSsvNFZxcStRVzVjbGoyaEI5N3VwNVJY?=
 =?utf-8?B?R1l4NFFnckxtTGNrTUQ5TTNTUXc5TEdsL2FvY3NQajhVUkNsdEc2Mi83dFp5?=
 =?utf-8?B?Z1hPck1RUHRjaWcrVEhPcW81eTNtUDZlUVRBeGdIc2hnd2VyYnFLcmRONDNq?=
 =?utf-8?B?QW55Ulk2blFOY1hjVXVMcmF1NVVzbG1wRnZrQnMrV2RWNUxOOGpsWXJPekY1?=
 =?utf-8?B?Z2pmKzEzZzZya3JjKy9DY2g3dlA0VW8vOGFvUzdXVE9ER1c3SkZNMENjN2Mz?=
 =?utf-8?B?a0xMTUpLdjRzTmI4TVFmQVU1REMvaWFyQlEzbXJUT28rTmptSEZwdzJ0bkly?=
 =?utf-8?B?TUhRMldtNFdXQk1xbUgzRDJmOHBvOUlhTUxwdmlmeXNSeU1kYkZjcVVWTmZx?=
 =?utf-8?B?b29mZXVHWHBiaWx2R2ZBSkdSMGZ3R2EyOHNybGMxbFovU2RZN202eWFRcVFD?=
 =?utf-8?Q?/pL7b7XiE+Msk7Lomop8xBZA0/yTfhIWbPtSM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(7416011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlBjalFNcm1UZGs3Z29KNnNYV2lGR3V2Nk9qZG02MG1BbS9Hai9sdWp4QVlS?=
 =?utf-8?B?T0diTllmNlYvcTVoR09EdUt3OWFhaWN3RURFZkVRUUhhMC84ZFlncjBwdDE4?=
 =?utf-8?B?dWJoTmtkNnUzcXhtU05xOHkyZUJxbXNaQUpaS3RFVkE5OE5vZGVBQldLMWpm?=
 =?utf-8?B?dUdtRGs1Tk0vRkVIelVaYzFFaWFJSWZSWklma0NCalVQOGUrbnlnaTJDV1Yv?=
 =?utf-8?B?c0N3d2NVbk5Qa1VWQ2tNaTRWQ2wxUXRzOElDaFN4M0pDTzljYklqS29BRnpX?=
 =?utf-8?B?b3l2S2hTYkFLOTlaTlJ0T2diZFpqaUpFd2Z3b2tKVVlnMVN6YTdoUWRrWVpY?=
 =?utf-8?B?aytydU5maWtKUGJpTGdQOUxIdTRNaHF0T2IzTkhWRVJYMFltYy9iZmxwWDRs?=
 =?utf-8?B?Ky9iL3lpWW1pRzBENDhYNGptQUh2QU5jcDN4RE1uOW84YU4wVGl6czRvRmxO?=
 =?utf-8?B?eVBlcklVeGNKRm1zY1ZWYjhYVXIwem1XRHpCZE82MUlYZ05TOGhnRWlyVG5Z?=
 =?utf-8?B?MEJscXlKcFEwYmlMdy9EN1VaV2E1aFdaVHFMNEFoQjhCT2FuMlhOSGFVbjh1?=
 =?utf-8?B?bWNkSUNueS9BdzkrYzRieGczWEhDL0ZyR2pKQTZjZU9EcnNOd0hONUczOGFY?=
 =?utf-8?B?N2dXVFZuZDFVY2JlZFBPckMwTTEwWnk2ZmExZ0l5Smd6Y0lOK3MraVZCa2FY?=
 =?utf-8?B?OW8yYVVYZFIzMUtXSnZJcWh2d3IxVmd6Vk03UXd0aDl2ejhUVCtPWi9CUlVR?=
 =?utf-8?B?WHFYWkxtWTNQUzRVZW4yRmlTQ1lhMEJFczRNVU85ZlMrOU1zcVNBUEhMTDVL?=
 =?utf-8?B?K0EwRG1Xcll6ZnVickJnZDg2elpwd0g1d2N1L3gwTlZndHVKUjZRdXFydEFH?=
 =?utf-8?B?dVhTQ0lxSkFWV1JVNE1NNkFYR3l1YTlpOHNNK3RLV1dNSkw2S0w0SHVLdXFR?=
 =?utf-8?B?MU45QTBoVXJkZXFhUWt5N3dBNjFtS3g5REpUcXJSaUVveVN3K25ZckZZbFBU?=
 =?utf-8?B?bmJTQlJ4UFdULzhIV2xJbU5Zc2p4cUhrejFxemkwVWwvN1k5SXFPdGJXazdC?=
 =?utf-8?B?M1RDem5jM2tCY1ZERi9yUUdwRlcvdXRKS2ZxdktTYVNQNUZWbzJITXdvb0NR?=
 =?utf-8?B?dXZjRmZ1M3Y1dEVwOUxUZnRydU5UdmtKU3VseEdiczNCaHcrMU12c0Znemx5?=
 =?utf-8?B?TGMvQnRDd1hmVkpYTEdDUzFhSXEwUytyaTF3eExkMDN6NzdjdW5yeXlNTVhL?=
 =?utf-8?B?OFBTVThINVY5VzlSVmNGOFVESUR5dmFoKzNHcUhnWUNOcmFPQUN6SHoyQUlU?=
 =?utf-8?B?aXJkc1ZKMGUvUjdyWm5HdVo1UEZPNCtZL2hkRXZRcFNJTXY3R29HQmM2d2Fq?=
 =?utf-8?B?eUVTVjlPZ2VXaHBwdFZQeEgzTisyUWtXNG9HanZwWjVkcUZYaXJPclAyQnBi?=
 =?utf-8?B?VlpYdXdGZ0prQml0MThEU2Z1Z2Q0YS9HYjZTWExUNlRycGZxNDJaRjJEbGdh?=
 =?utf-8?B?cCtCakF2TWdWTnlGNGt6MHVDZW11SnNxZmxNQlZzenRTSklJWThRNmxYZVJm?=
 =?utf-8?B?bGxhM2h1SjZTeDlaZ3ZSTG9OYjZXVFZrMnd4dTVvL3RVQzlLSTdXcmhOUkVu?=
 =?utf-8?B?VlhuQkpGdWZRNTRYR3NiZCtXTGVEdlhXQlRtYW5xdGMvSGwxeUQzV1RnQmlj?=
 =?utf-8?B?bFh4aUxGQkxDc2hadWpvVVlKVk9FUzA4M1RKZVBKT2hTTjJneXRvWHlpWDVS?=
 =?utf-8?B?T0FrcWsyV0ZnMmZpTjNMZGR6d2tuZGo3MlFrSEowS29FRTZDVnczc1cydWtj?=
 =?utf-8?B?NmU5QjhTQkozWlMrSzhtZkNRakExZGNxeG1pWDhyT3pqdWQ2Q1ZxWmtBTlJR?=
 =?utf-8?B?aE5pRGhkdWNidzQ0V3lOTnlKaXNwOWs1SzgwOVo0ellmeTBjZ0t0S0x0TDNS?=
 =?utf-8?B?TUxOMUNWTVFLcjJKakhubG5rR3ZZeXRVWVJDYkxLZlczcWluMVhnbk1tYUQ3?=
 =?utf-8?B?cFdpcHh2WTVSaW1oOHBmRUQ5a0YwNlJDbGgxMVBVOGpOL2lNNXkxZ09iRkRG?=
 =?utf-8?B?NXdwV0VURVN4OERrQVZ6Z0VDUW1BelMwOUZIK09YTTRFb3FPR25KVUFqQm5M?=
 =?utf-8?Q?zqDuJtyQFNsOQNjR3bY0KFuc4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c0dac2-4c8d-4199-8680-08dc8e77db5f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 02:47:41.4011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUJhjOT0NYN5cVz0nHRawcslOg++gygW4YBuacfedwwa/qyrHJ5j6YdJ6R+KcGo9b+pZx3GyZZETlFgEUBl9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9482

From: Peng Fan <peng.fan@nxp.com>

Add DT compatible string for NXP i.MX95 19x19 EVK board.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6d185d09cb6a..5c9014087c17 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1275,6 +1275,12 @@ properties:
               - fsl,imx93-11x11-evk       # i.MX93 11x11 EVK Board
           - const: fsl,imx93
 
+      - description: i.MX95 based Boards
+        items:
+          - enum:
+              - fsl,imx95-19x19-evk       # i.MX95 19x19 EVK Board
+          - const: fsl,imx95
+
       - description: i.MXRT1050 based Boards
         items:
           - enum:

-- 
2.37.1


