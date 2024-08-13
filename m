Return-Path: <linux-kernel+bounces-284096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DB994FCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379451C21B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E886F2F3;
	Tue, 13 Aug 2024 04:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lCFaUeQx"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0D457CBE;
	Tue, 13 Aug 2024 04:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523747; cv=fail; b=KOvzWJeTXe6AXOiv0JWzHyqDyxOAEUZQow16hzDkHYm8lHZXyEBu8evk0RqC8JhyH3zYTUbeIVWB3nM/g+cBvCnl6yA3CnIkS6C1MaOWxq1wnqNlPWECfEUKUCAph72JptSsXICZph2I8qxkcX6SvC1wnt7NsKqyAUQyqrPyqQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523747; c=relaxed/simple;
	bh=kclyjxQw4lOyqZNnPuFTpYDPOubLym7HM2leNTo8O6E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Jqlri1ABDle0dq8so5fzkO1EXjbkvyukKs7eROV77h5MUAypGalt68yjrQPGImHhXb3jv98V1bR8ZDnUVjLJ3VCRM4FaDcTnoHvSWEWrB1IoXokPYSlKn6kerPBcwQnvfOwb4UXjQj3dJ5/kkuw9ItcXCXapBWgu5+4EHdh8d9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lCFaUeQx; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxOVFQx14LmjKLIIC825K56bTGTM21TA3/aDd4S8oV2iFoynWtp5BZmywd8qgXXnchwm3mnA5a7KDTNK4R5s4ay+XDeVCp+iRWFuSVmaF5C1cnRsu7N4mQI1uS7rB8AR86RyMt7ymDEyuCCr4YGXW4aHk/M9AOXUEzt+CNpuT+faUgXaSnbTie/oz7kvG7FkG8sniam7CJYtOIlYztLtj6CgDaku5glqrCuvIz5sL8iJyYRE1WGqh7b+e8KkABBmAPEEJQNrDr6D7maXKhXAJMoVjwo4T+ywZ0Z+ZVlyxkA3u98nU8LO6S7M8YqHCD5+lIMA5BFOYwBZifDju3TZ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRmVkQSu4oBQXXYgcwN3vzY749nustUShudhz4ZofVU=;
 b=Q6GhuahQ5CMib7H5KhTGyFPgPgbEegZS0xUPu3NxnWQqWev3Wn+PX7EhQnAiBgnbybx2uVRWIcAIE1zLXg+5vnNfD6HJ1qj//Y329BdT2blZkL0L86k4TyLD7i0wYZZmyrCtsOR7Q8kN/O9lWTJvD7D0WhJRPFr3R/AAydY33uh/Xc7uM3CCmyYF/GxUQiC26jS8fFkuI8tWsirVfd8F8mFWNnt/QtZfistSLvDsLDjROTyQsaHLVPkr0TIq1ttv0vmYxH0ilhaCxWBTlilJK9afG1nd4mX9SQiDvGteNtEN2DqcedQTY/f8IuMHC+4U0kn+ADMVl06qY9oIbXiYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRmVkQSu4oBQXXYgcwN3vzY749nustUShudhz4ZofVU=;
 b=lCFaUeQxopzaOqKBr1cmFnEmi/odRUaVcUlgo8cxAmFyYgYT9LiLOXLkj2ubiBSdzjlDGkmVvqqEZWL9y+Aj4RvBIQO4X/I+9saEJQUsxyckaDSAtO0B4KT3KuF2DXdX2JjG8GyqACEFXuHu2h60n55KdCTgdQxrsfhaExT4mw4dv9DEDVUYqWmDlBTdNPy+7+6v2uiHvZek7dpKxkSXtOU5enEiXWjwJSkbjYc2xUEq00ipYWaVdeTRWdYSuyG72/BdFgTS0eDBTeLHuncSyhcTfq2UlWuf4vlSB/3JAdjP5MekanOkyhHv7QKMuu5NDsPsdwJicRNRTl7zi+j28Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10321.eurprd04.prod.outlook.com (2603:10a6:102:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:35:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:35:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:04 -0400
Subject: [PATCH 09/17] arm64: dts: fsl-ls1028: add missed supply for wm8904
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-9-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
In-Reply-To: <20240813-imx_warning-v1-0-3494426aea09@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Gregor Herburger <gregor.herburger@ew.tq-group.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=1365;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=kclyjxQw4lOyqZNnPuFTpYDPOubLym7HM2leNTo8O6E=;
 b=DSCMVsVYo/cULrSxjpiwHQpbu+ayvFRPmnJA5eko7/SBPHNK7dqq+iqw/lC7H9a1tnd5KhI+2
 XYM1cUrL4g/DCoT+jfYN8FgPqoIkb/tcbNHNEyFEYZZe/qzgu8VQC2x
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:217::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10321:EE_
X-MS-Office365-Filtering-Correlation-Id: a16660e6-fc55-4559-bdd3-08dcbb516417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SzNlbDJubnNXZUgrbytLdEhjdVA0QmdZQnpFbjFDTWkzSG43MlZsY2NydzZ0?=
 =?utf-8?B?K2RxVU5wTFVaOVg5TjFMb3ROallpRDZqaDZ4bEhaOXZEWC94ZDdhNU10Y0Jk?=
 =?utf-8?B?MUpyZmROSmZncm0zMmhodEF0MlpLUDNMU0t0K21IczR5S2tzdXowMWZBMzBZ?=
 =?utf-8?B?K0p6bHJwTVljMHJYZ01qMHZyR3gvck11TkdzdFd6U1F4TXllSUlPYVNkc2Uz?=
 =?utf-8?B?bjZNbitzODd2VUJsem81SzVBVHF3Z3FqQkM3aWJPS1NLblJSUzg3VC9oQms3?=
 =?utf-8?B?RmdXQnN1NkxxdXFKUUY1Y2l5N0RMNkx0d01GVU5mN0pnNnJlMSthUVFmYkFj?=
 =?utf-8?B?L0UzRFdYMXVSY1dZa1FzK1ZSZ0dmU1hoSkJoZVZXMVJ3TFErMmJLcnh5Z1FY?=
 =?utf-8?B?cFo0elJIYm45WE5FMy9POUFSQTlhMEgvMlZteERQSnB3MU5kOW0rS1JPeVo4?=
 =?utf-8?B?MDh4bTNZcFYyLy9hK1Z5dzVBTm5mSWF6YUJPMWsyMkZ6VStYZXE4K3ZINjBK?=
 =?utf-8?B?cEF4aHpZVTF2U2NpWkdFcW92eEpET0UzaEM0ejdtQVFxS1ZEQ2RNZzcxMHRi?=
 =?utf-8?B?TGpoSkZLUXZYL1hVaGpRZ1l1Vi9IWlYzd2svU2JzOG4rT3J0SXBRMlBXWk4y?=
 =?utf-8?B?RjYwTEJleE5Yd2xnU3EzeUg4emVDS2ZZU0JSQy9NRDQxTVcrOGdra1E5emZs?=
 =?utf-8?B?RURFQ20wUGVBUWY4MGVMbWVZcHFlT0lwQzllQTB1MmpuRGZHQWtzSkJReWhz?=
 =?utf-8?B?MG5DaGhDdXpjRlcwdTRqbVhuQUtBTURBZ0pNc0ZkN2V1YXZmMzAzUE5YcG9z?=
 =?utf-8?B?SlZSVWhDL1JIY3FtdjBWakozek9hY1RhbkdIV0JlU2Z2UEZxL3Z2MXNYQTZG?=
 =?utf-8?B?aFpHajd6MTZlaEh5NFFNMkxBcTJqSnJwd3djYnR6ZGFyMm5KSjBvZ2t3MWRP?=
 =?utf-8?B?WTIvR1BSRlNocFZiRHBYWEcwcXhHcENEOXlIYWFWOXZudStNMEUyelpWOGlt?=
 =?utf-8?B?cTQ0WjA5V1pIN2UxQnJpNVZQSWxrdlZxNjk1Vm9ROUxna3RHMDFWMnJBMXdt?=
 =?utf-8?B?amNVNnBnd2hLb3RzejdFUVFMNVQvMXgrYTBKaDJLK2lvWC9tdGNma3FNc1M5?=
 =?utf-8?B?YmJwaS9sZEJRK2dKWlkvTDUzZnhiMWxWUGpBTFlQc2pLRGNHUVhkTVZDcTVO?=
 =?utf-8?B?cFhQd2MwV1daVGdHQ1NUUmh6RnBmUzAxM09mMHRUT25oR3k3VjkrK0RNRktw?=
 =?utf-8?B?Um0rL1RybXNtdTRTc0ZnOVN4b1hCdWhQem5nRGtTQ2E2cUdsQ2xtaU5ZYWpC?=
 =?utf-8?B?K0dRU1orZk5uT0NxdGlMd3ZJS3p2aVRIdytPekY0OU9MbzkzMzlpVUl5OW5B?=
 =?utf-8?B?anE5SVVVUFdWYTh4OUJldUNkTFNDVTI4M3lHWTQ3bDJ6aE85aGk1eWJXY1ZW?=
 =?utf-8?B?aTcwYjJnWENrbXRYNzIyOHBydjc5YTZJNVN3NnB0TDN2QlJmODREYWsySURI?=
 =?utf-8?B?bkxMZHJPTFlwYmZQcXFueUYrRkxwTkI5b2k0NWFkdEMzNy9TamhTd3lrSFNK?=
 =?utf-8?B?RjFQckNyMjBQdkY1aXluSnltNkdxdmVLcEVIMERoMVY2WG5HYW1uUEE3RXp4?=
 =?utf-8?B?TnFydUdrNFZ0ZW9JREQ3M2ZBYmtobERpTlAybDV0U1BRSXMxQlhSalJKZEpU?=
 =?utf-8?B?M2E0ZGRkZVhleEZHV1BJb2J3b3hwSGMvTmVES3BiY21uMUlraStEZzV0dHhh?=
 =?utf-8?B?RmxSV1JwbFh2azVNY0lOcTNyZ21HS05lUlNsekNOQVhpeEVoU1lKdE5KdWFt?=
 =?utf-8?B?UmZyRmhXUEZWTFBCSVErTmcwbjlEei9FYUZVNzUwQWRsZVNrblZSanpvb0d3?=
 =?utf-8?B?czRSZ08yWW5LZVJLODFJdFZGWXVPemt6VG5HQjRWa2VqZXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXhhaHI5RXhYc0FCekkzdE5oZHFTcFVqRXo4eXNna0RmSXJIL3JHNUJUZGNl?=
 =?utf-8?B?UCtmV3pJOHQ1UVNnankyTDcxeWpqZXlCMjdYMHppS252OUFwK1ZoL3pTUnhX?=
 =?utf-8?B?U2RYTkU1V2F1TXBpOElGbmliUFJya091Q0QrN0xMOVc4aXVTaGdJSmh2RWt6?=
 =?utf-8?B?bkpVeTRzUmR0bmgrQ25ieS9CelM4cFQ3MS94a3VLSGFybFE3eGJvRzNNZ29m?=
 =?utf-8?B?cGdHemZHRk41N2Vkc08vS2NCb2xwcWptdFFuSGxRenFsOUxuMlFJbXpBdWhn?=
 =?utf-8?B?Qllxa01wdVBqMGpxdzZJTnY3Q1NtRVBtbnZnSVpLbWVFcERVVFpJVVM0b0pT?=
 =?utf-8?B?OWxTalhSZWV5bFhGM3Z6QldnaWZrOHIxclhRcTk1OGhTWDd2Tk55M0c1SFh2?=
 =?utf-8?B?UDhlN1BRVUlGY2N4ODhXWG8va3VmWjg3cmMyRXpiR2VLcTRMbFZuQjZEL3Ni?=
 =?utf-8?B?UGdjRlNWQlEzaHRSbnI1cXFNdWx6SlE4SlE1L0E0cXpIUGpRdW84cUJnNjBE?=
 =?utf-8?B?VXNZaGxselZmUERDR0dqVlllTWtyMWM0THBtVGZTak1lcFljbU43NlcvVVlo?=
 =?utf-8?B?T3dTbTVWOWdHcVBiekkvTmxXQTNpQlpIaitUem1jTVZSQXk1RXc2MVRKaity?=
 =?utf-8?B?dEF0NzhSSTVqeVB0WW1jYkJidTNEUURZcUdpUEFaOXhuZFlia1JnU0NkR0lh?=
 =?utf-8?B?NGdGNHc5ZFl5STFUVzkrcEozOGtmKzZ4LzRDSFV3L3Vuc0ZDUlUxRHZBUXN1?=
 =?utf-8?B?aFJBa1FKWS93QWFjb1VFSWRpV2JOcXVtb2RLcEpZbm9LRTRITlZsOExUWDdr?=
 =?utf-8?B?MkkxdjM0NE10RE9VTmVXSkZLcVVCVG1aTXZyOUZJdkhVaFZJSGtvK1ZPLzhJ?=
 =?utf-8?B?R1ZhYVVZaGZwVEUzS0ZqNGY0MkIzNjZWVW1BMmQwRkcrOEJRcTBZOGpzdnBT?=
 =?utf-8?B?WHl6dythdHE5U3hOZjVnWXdmRWlORnl4OHlnL3lXcFNoREgyOFFOL2Jsd0Nv?=
 =?utf-8?B?ZitLZHljRHExQ0tCdWttaW52aGEzcXdDRW5WNVVwT2gwM2VxVHZhc0hJYWpu?=
 =?utf-8?B?cFd0Y2FwVmNlV0Y0cFdiUGtaZGZMQklrSG5IUFg3YXRORkFnQzB0VTE2Yk02?=
 =?utf-8?B?UFRTQW9LdkZtZWJhZ21JS0FBU1I0YllhNGQ3RmxGcXozdHdGRGRzRkk0dnlY?=
 =?utf-8?B?SGswWTNrcHhna2NjL21qSC9NZFRPaDc4L1U1SjJ0NDJVWFZHbDl0SHFtQ1NG?=
 =?utf-8?B?UlNQWUQ0Q1YxYldGU2Z4MjRwK2U5aEovb1Zhd3ROUXovaXFlUktvbGdpZjlW?=
 =?utf-8?B?SWVuZDc5cHBWeGRaSzNtTmFCZzM0Z3hveW5PNHY1Y09iZUJ2ZjZveVNtR0Y0?=
 =?utf-8?B?MmdMcjA2bHBZVVJwdEZPU29SWmcrL0J0aWdkMlNJTjRObkY5WXhON2cwQnFn?=
 =?utf-8?B?TnI1VFFJTGYzU0N5aFhQU3ZFanhaR0hodXYrTitDOCtra0ZTajZ1NWtqSkRQ?=
 =?utf-8?B?dmNtcUxiWEhDWmhIM0FuTWlYOXFwL2VRTkdkMjlBMThCVlBHd1NZYk5oUWRu?=
 =?utf-8?B?Y0JSdDNWQmpxRm41WFZ4OGVNTE5NSk5ybEFWbVQyaW1maTcvbFJXZ09KNllD?=
 =?utf-8?B?b2l1eHhmTUVTRjFBSmpHV3UzdnZSL1VmMVZwRDVGcnUrWXpSTUFZdU1qV3hw?=
 =?utf-8?B?QTdrT0sxZXBPaW4wWWNYdS8zSTFVa1RzRGEwNHdwME5EU1l3eVRlTHdkY0JC?=
 =?utf-8?B?NmNQR2hhb1ZENnE0Q1JNemxFVnVpWHRIN29LTXlPRWs5aTE3eFh2MVoxejdJ?=
 =?utf-8?B?UFZrNVgvaktDZFNxczM1UkRCeHhwS0JOMytJcWZtRkRHY3Y4TE1jWGZSNVN1?=
 =?utf-8?B?b2pQZitUb3pzVzZYYXJsUklyOEQ5MTQybVFkV1NicW5Vcm1PaXlMQjZiMTU5?=
 =?utf-8?B?VXcvMnBLdi9nRFEvcytncDFGWHRkM3B4QjVlQlUvWmVjZy9jbXdtQzZOaDl6?=
 =?utf-8?B?SGphK0tWTWtQUG4zU3BQMXcxWGZIRVF0aTl5M1VLWk14UG5aSjdxa2l0M3ZO?=
 =?utf-8?B?ZkRpRlA4ZHpKT2NkRXFYUWZOVmNWTUhUbHFpYlhpaVJPa2piR0VTNmF2cUd4?=
 =?utf-8?Q?BS0qxHDxlXHQVDilUGIUwQDLb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16660e6-fc55-4559-bdd3-08dcbb516417
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:35:42.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 948GcCHBADbxnxKMXiyVklsdjBh/K70QRYlagUEzycFq0mvle/xNdoHZqJWV4PeztYzESzGUGm442TwCzDP9CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10321

Add A(CP, DB, DC, MIC)VDD-supply for wm8904 to fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb:
	audio-codec@1a: 'AVDD-supply' is a required property

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
index 195bdbafdf7c9..d9fac647f4327 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
@@ -26,6 +26,13 @@ pwm-fan {
 		cooling-levels = <1 128 192 255>;
 	};
 
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	sound {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -107,6 +114,11 @@ wm8904: audio-codec@1a {
 		clock-names = "mclk";
 		assigned-clocks = <&mclk>;
 		assigned-clock-rates = <1250000>;
+		AVDD-supply = <&reg_3p3v>;
+		CPVDD-supply = <&reg_3p3v>;
+		DBVDD-supply = <&reg_3p3v>;
+		DCVDD-supply = <&reg_3p3v>;
+		MICVDD-supply = <&reg_3p3v>;
 	};
 };
 

-- 
2.34.1


