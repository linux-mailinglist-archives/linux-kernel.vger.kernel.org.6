Return-Path: <linux-kernel+bounces-250228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E492F575
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13881F22566
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 06:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED3413D606;
	Fri, 12 Jul 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TcSCgGsE"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011029.outbound.protection.outlook.com [52.101.70.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF3113D8A6;
	Fri, 12 Jul 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720765411; cv=fail; b=JkHNa6CoiyVM4gxM39U5Wk6iIMc1gGDqcTPMt2rBXsk756hhqDqLRB9qm/PKTzQUKlwSVAM5nrcDpjqyvmkW2Oz5avSyLqlfAYxPcIZ22mucEsCghYxIW/sJrfNsNxl3yhOROqvqcWrKRDwcSsRBVrc9KWzO3/pAyoN2WhOo71U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720765411; c=relaxed/simple;
	bh=/nxstPxF3o1S44yVoWukS18LDGly5k3bs7qlPg/JwaQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UEQ1bzGro2CCswpdzCsK6VrOQmsGXQwGsnzyFJG9LClwN41RQ/tn6Xekgqk5caqOyLPB/oQRYhtE/luWJ7ZivmpY+Y1bqbjgQuU5xgu3LqHUvGxv5XKTxoZ7mLrPxzQmjsVdQkpeTr73glLiHtlkvojRnbVboH+bVWVVsIh/Ojg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TcSCgGsE; arc=fail smtp.client-ip=52.101.70.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AcnFGBZ1wOYW1GVBuSzmWxxyQgtyGzsRJjqIaK1Gd/22Zp26M2EoXS3TbNBUT828mIkNo0U466TT489H5bRhkl9SMrYagLPedTfwR08FUD2nMXyn7fXCngt5xen30ln7kvf7XdeSdl0uHMT1+3ukzYx/4vCNdhIcK6AKGsttMru4PatZIwfaDjDqNbxMW2nlhVjOLBEVa67tD60k+5r6yiUBryxdy7srwjSQNSgOrue66mV1vbdSClQbIX+MQ9uAeYeMqK98CyBp3REatvXRAPncUwasKCPOf8SaOe6ItVQslbEHspHdjLfM8Z6xIhCfTcfk7cA/SYlQ9zZzEnJEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCUmpo2s1rxaQvZph1haymn+Lxzniat2JXypac0pinY=;
 b=wwwoRV7UAStsUI8BvinfBGeEa0va1vrhqamVjevGgKkPfyZCT4vV8B/zFlhC6A1ITZuXhh+osLgLCpcD3Ia+uOkoXua2loYkuSLTZW8MMwYAstvytbDu5lVBTx95zW4s/mUXkoK4mR3+75faTAvNVR0KbTNACgzljvmwPL/2tmzKMybZ8u9cz/PUqqwpx+EooNdz+ppeXew95fWQk3M3t3JGOI0PGyh6MWOh1NiUJZ/w7uqCl6vWGk1a6nmAnqpRsCvfxMQ/H+3VHEN/AxJqiFWmUIwILYJ9uGfKdOAFUsFS8qjbVRQseW2haeV7lZOkrL75r23Cd5AeWdmnm2o2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCUmpo2s1rxaQvZph1haymn+Lxzniat2JXypac0pinY=;
 b=TcSCgGsEw5AaPSXGpwCrO6OgRNAuMGd9ZZexRhrBdeZbBUpCWTbDZURxXiuz5i+xmRfJeZIvNW8TIl+naub0lJsy+gI8u12XbdG/+joKLJcIw1yjF3ljYRm2o3EEaWQlgfLBaPc0pJg3wuGIYI0+rfxqzd5rxEI0mBUVk65Lwcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Fri, 12 Jul
 2024 06:23:27 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 06:23:27 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Fri, 12 Jul 2024 11:49:58 +0530
Subject: [PATCH v5 3/5] arm64: dts: imx8ulp-evk: add nxp secure enclave
 firmware
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-imx-se-if-v5-3-66a79903a872@nxp.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
In-Reply-To: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720765211; l=2656;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=/nxstPxF3o1S44yVoWukS18LDGly5k3bs7qlPg/JwaQ=;
 b=2flAusf8jll/j58NrDz+W1Yn3A/pXNJ5Pt7lTrC6zOlLFYYocmqOlnh4V1O9Tm1FEEvjddl1y
 b43txi9juCIBmTWkKfUvNWHGzRjirTy4D/IWfBNzauPLUGDXtD5TK/C
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f3cf48-09da-4f00-8922-08dca23b245b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkFpWFkyMHRKaDRCcGRtdmVpckJZcU1mMjhwWXYxRlJMbW0xa0s5MVpIMTZP?=
 =?utf-8?B?QWZwSC9KZmhLZ21HbnhLNDQwdDNTZVJnY2pEeDRXb3pCU2JjQ3RrT3pGRTBJ?=
 =?utf-8?B?QTM4U2w2SU91QlQzTmQ3Y0dEUDh0eFhzVHF3Y2tuUGIydnJqQVJGS3krVysv?=
 =?utf-8?B?OFBHUXRkQnlqQkNsTmtvbXNLcXNkMjZrSWZ2aWZuRjVHZE94RktyRWNHTitD?=
 =?utf-8?B?bFF5dXM2VDROdEFHTlVDMTdhb2NxVjVkOFB4YWk0S0JZRTlDbGlYRWxvM1BD?=
 =?utf-8?B?ZkFsOWJMcVVCTDJRZlAyRWxjeTVMVldsL1AzR0VXbk9nQ2ZZMFp0ZjZDb3lF?=
 =?utf-8?B?M3RsSCt6MENDOW5EWjZqUGpIL05uYzJBaE5vT2c4aFZzTk5vcFpNZDdjSzRz?=
 =?utf-8?B?bzgwS3BQQ0wwWXdmMTcyQndsZWhINHRRNkZERnJPM1QwWVlFR2lxaGlUN3RQ?=
 =?utf-8?B?VHMzSmhrNEN5Z2sxc0p0ZEQ4L1E3dXhKUDBVcUpuRHRIK3lyNDRaOWQ2VkZ2?=
 =?utf-8?B?eXFTN1dHb3NISW51RmdZV0JpaXIrV2UyZ3JZdDUrODVsV1VWb0QrQlNMZVR2?=
 =?utf-8?B?b1JPbmU5MlI4dG4rQnZDb3VYVjhCT2djZTlWTVhnd29sQ01oMTFaTC9JSmFZ?=
 =?utf-8?B?NnArMTNMeFhFbHMyRjh1THhvSWdSK3EyYjAxdlN5aWRKV3pzMWhZbmtQa0la?=
 =?utf-8?B?bmlnTkczUXFwaG1FbENVL3BnQ1QzQlhDYVhNazBDR1BJcE52MHNVMzIrVVhI?=
 =?utf-8?B?Znl0M1BDLzVyTDVGSkFrUThSSjJHZ2tVcFRnb0IrbWI0RTc1S01Ec1h4WUd3?=
 =?utf-8?B?YkFXM2V4eGd5eDMwWDNTMWZCVHlrWFBFb2J4bnJuUXUyQXh0WENFZXBlZ25Z?=
 =?utf-8?B?Zlp4bnhodlZxQkdUUDF1MmZmVE5ua2k5b2E4VW8vcUFtNHdxVE9JdVNkazZF?=
 =?utf-8?B?cFNSaVJNU1JwMWtjOGFuakp0YWJlWjYxeHdhSXlyVVRRb1FGSWdXVEt3TXRa?=
 =?utf-8?B?R0xxV2VyUU9kNnRMTUpFeTFkL2Z6MVBzTFkwZ3ZDc3hjeTViQVVsZWdrNHlS?=
 =?utf-8?B?U1FpUWk4SkZqK0xocnpxaVJzU0hyWTRsaGVGNXd3eld1aW9ZSS9UTGc3bXdp?=
 =?utf-8?B?Zm5qL05NSzZNUVczVTFjTmk0RU1MQzdWdEZyQTVkT1p1SW9XL3VaYkYvdHYz?=
 =?utf-8?B?SUJCd2dvT3NGT0RwRDllWlB1UGNhUHkwV0hRM2w5b09jTXIzQW1aNWhXcEVo?=
 =?utf-8?B?WjJkUUZlejUyVUx2eE9QK3JUUHM2N2FJMmFxVDJuYklCNUhaOVg4UFFYQkRa?=
 =?utf-8?B?d1l4OGFTQlhxZ1M0WWdaVzkrN0ZaQjgrTVFaYVdxOTNZNkU1T2FXUnd1RUlQ?=
 =?utf-8?B?WXRGN3BwUWNwY3dVZWIwTURoaEV3L1JBUUNpcXQ5TzE4Mk9ia0FyL1pqT1lU?=
 =?utf-8?B?MTgzRDBiQ2szWUp1NDFTNlNqV0x1L0JGNzd3OFhGV2RXTE5KQ2U3NDBBSnhu?=
 =?utf-8?B?SFlWMHRWdCtKNG1QaGVVeWg5UXRnVDhBNENsaDBlQUowQ3VlRHVLUGt4Rm45?=
 =?utf-8?B?NGJ4MDI2VmdpbmNuRFlrOTBZVUNHVGxCQjNBbXVRMCtaV2VKMi83M0pNcWNX?=
 =?utf-8?B?alN6Y2FLZzdkSEdsYzYvektUejgwS1dBbTJsK05OdEFZaUlISkRTbXBWWU1B?=
 =?utf-8?B?a3lTSys5M3RpRGJFVmI0ZmZ1amdLS1RkWFdFT2g3MWNEa1ZVUFF4SEdpTnJK?=
 =?utf-8?B?bnpOSzJnQ1BVRTF2YWwvakZFd01lc1RSRU9HN2ZBTW84eUVBdmMwSkN3QXU2?=
 =?utf-8?B?MkFjRDdqMFl0S0JlMWVPbmZ2ZUpCSW1rUjR6T0tYMW5zWno5Y1lxajQzb2dH?=
 =?utf-8?B?Y3ZObUVwb2dWbEZzd0JnT2RJNEVSZXpkSFVsam1FQk03elZhSWRodDEvS3Bw?=
 =?utf-8?Q?p2XTyWLUfL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3ArbW1lL0IvbnhlM1VhT2NQMDVEdE1PK0hQZzhiRFNTSmVHVzcyaHprSHZp?=
 =?utf-8?B?OWlkVElqVGdraGpNZkJQVkpjRlFqalVFQWs4TXU1dHhWR05PS2xuYmJxNlNt?=
 =?utf-8?B?aDFhcGdJTTJhYVVIRGNlN0JSSmdmQjRUUVBJRG1kd29kODNOKzhCdEVyc2Z6?=
 =?utf-8?B?Wk92QytQekRRS2psVUFRRHN5amI0MTVHMlc0N0hQYmV6K2x6NEVSTERRT3B5?=
 =?utf-8?B?Z0QyVktvYzFiY2RmTG5tMHVKSEV3RlpJS1JWbkV0VlIvRWtvS3FyQlo2a0xU?=
 =?utf-8?B?QWhjZnBpc2FZMVpka1pBOWs3SnNyb1JlbEhNUTBOMDkweDFINDJWVlZpOFNL?=
 =?utf-8?B?bjJGTUcwemw3Q0w3dnpwZUtBa3JCZHcwUUJqZUkzamY2eXJGMXl4cHJ2SFM1?=
 =?utf-8?B?K0VibDE4VW5iZzZqOTY1Y2FFUzJTVzJxUW5RZEs1SUl3a1BQbGtiNGNsMGRV?=
 =?utf-8?B?Y29mT211ZDM2RTZOVm9uTHV3TVhZYUZudG9kS0VXUTBYUFJhUVhnWEdCRldy?=
 =?utf-8?B?R3ZnRCs3ZGxLeU4xNVRadnllWHNNZDJ3OUl3Yzg5MWljZ0NoMmJLOUR4QmlI?=
 =?utf-8?B?b0ZqMlMwNnVaMHR2a3F6SEo2SVpjUXlCQVNJMXdJUjVIdnk4SW8zbHRmdFF2?=
 =?utf-8?B?R0JjZUx2aSt6VFRCZUpjZGFsOHRFVTBVejZXdll1WEowR3ZYamxnRkVUT1do?=
 =?utf-8?B?QVdTZlVXb1pOQ0g3d0tJbU5JOGJxdXNGMVVBUHNtb0F3Mm0relV2OGtJVUFB?=
 =?utf-8?B?Vk5aMVFjUFIwUFJ2UEgxYUNZd2tkaW5Fd0F3UUlZS1RaUjFETUVsZE42alV6?=
 =?utf-8?B?U0lrdGduSUxZeld3SnJDOXAzczIyMHhMekJDeVZsYlFnZjllZ3p4S2V3YlNR?=
 =?utf-8?B?VWFMTzhyY1l4dTMzdzZtaXhHQW5kaHVjUHVJRlRmenp2cmZnNE4yTGUvay9F?=
 =?utf-8?B?ZDRmVEY4WFE3VHlKU1c4amRlZlFoSGEyZFNuM0JGWFZibzJ6c2g4L0tvRm9P?=
 =?utf-8?B?alNtQTN0cGhsaGRmcFF4M1BQcUo4TW96Y3dKcGZBZzBlS09lRDJGVk50QWhF?=
 =?utf-8?B?TmhXQ3R1eXZJaE9LOGxWM1ZENmFmY1FEMS9MY01wNmFRNHUrcG4xcXdQaExm?=
 =?utf-8?B?cHFoQXpVZThSTHlIa0dGZTY0R3BhcE45S1lCcTk5NVg2U0NTVTkzY1prSk8v?=
 =?utf-8?B?cDZHMjJmTm1KZVQ1NThCVGJxS1dUc2FzZENncDBZeFhBVHp1MjB1OGtlS3V0?=
 =?utf-8?B?WFVyaEl5Nlpsc0cwNEtOT2I2SjNlbW1TM2ZVNXdEZzRXTUkrWHEyKzJ2Q1VH?=
 =?utf-8?B?dFZRbXZnNThaaCtRYmZtbm13RGdqUnRNbHUvZ20rb2NYZHczQlF1bmQyWDdn?=
 =?utf-8?B?YUlRaTQ1ZGwva09GazlJbmdsbGxBeXlnN1FWRWpDWUV6a2VxYlJPSDZjc0s5?=
 =?utf-8?B?VjNmM2t4b3kwWEI5a3hNUG81N0kzYVdCQ1RZdU9zNVZDaHVQV2xydHc1Nk5l?=
 =?utf-8?B?TkZRL1J5eU1pUWhReHRjNjFGZDNuZEZVMHplTGlHOGNMTjJsUGk4bEIzWW1J?=
 =?utf-8?B?WTRqOXE1QVoyWVF1TmptUDNwSEozV05OMVZ5Nm9lYUdOK1FEWkdZWXVnN1dK?=
 =?utf-8?B?RkpHT3VFMjhtUENkV2ErakRPdm10bFVWaWFEL2c5K3F4UmV2OWtveURpMlB6?=
 =?utf-8?B?cUxSUWpwVEo0U3poVDAydjF5bWxkTmdGVitsSUpiVjc4b05la1lzODJGb1N6?=
 =?utf-8?B?YlJYQ3lqY2tzN25sai84eHRpaEVTR3dNYXBWRjZSMGFEbVh1c3U1c2thTy9V?=
 =?utf-8?B?MW9iVTFkMXJHMTJmalQ4OHFUR1ZNWVdmZ2M4NTV3S0k2SndaNnBOeExQVE1O?=
 =?utf-8?B?Rk1XNURSTndJZU1XZ0pJQUhlWW0yUDFEQ3RmV3BSLzRaaFo0dmgrR1FJdEZz?=
 =?utf-8?B?Z1l6QWNoeUkzSHFGQjlYRloxTnJNeEtZRjVwaXNUV1I3bUpRNlhIUEgwS0JJ?=
 =?utf-8?B?anJ2dG5HcGd1REZHcTlCSDdKdll0eEJkalliSXlEYjRaeWtWTnQ3aE43L2Fn?=
 =?utf-8?B?c0MramVqRGZXNXpKb29ldys5bU9JaU5iMjNNcGZjenpUam94NzlEMVBuSVRu?=
 =?utf-8?Q?ognuo1H9q9ReS9nxM2DvbPG+s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f3cf48-09da-4f00-8922-08dca23b245b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 06:23:27.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec/NF8S4XsjLmRjcUcxqNIynfmwS9pVLv2bmttZS8KeJ5Njf4pIpVvIgwojug3lMC2K6j/ui5wWliTssyyYlPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

Add support for NXP secure enclave called EdgeLock Enclave
firmware (se-fw) for imx8ulp-evk.

EdgeLock Enclave has a hardware limitation of restricted access to DDR
address: 0x80000000 to 0xAFFFFFFF, so reserve 1MB of DDR memory region
from 0x80000000.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 17 ++++++++++++++++-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    | 14 ++++++++++++--
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 24bb253b938d..ca8958f28a83 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 /dts-v1/;
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_if0 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c460afaa76f5..cfa6d30a890e 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Copyright 2021 NXP
+ * Copyright 2021, 2024 NXP
  */
 
 #include <dt-bindings/clock/imx8ulp-clock.h>
@@ -152,7 +152,7 @@ sosc: clock-sosc {
 		#clock-cells = <0>;
 	};
 
-	sram@2201f000 {
+	sram0: sram@2201f000 {
 		compatible = "mmio-sram";
 		reg = <0x0 0x2201f000 0x0 0x1000>;
 
@@ -167,6 +167,8 @@ scmi_buf: scmi-sram-section@0 {
 	};
 
 	firmware {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		scmi {
 			compatible = "arm,scmi-smc";
 			arm,smc-id = <0xc20000fe>;
@@ -184,6 +186,14 @@ scmi_sensor: protocol@15 {
 				#thermal-sensor-cells = <1>;
 			};
 		};
+
+		ele_if0: firmware@0 {
+			 compatible = "fsl,imx8ulp-se";
+			 reg = <0x0>;
+			 mbox-names = "tx", "rx";
+			 mboxes = <&s4muap 0 0>, <&s4muap 1 0>;
+			 sram = <&sram0>;
+		 };
 	};
 
 	cm33: remoteproc-cm33 {

-- 
2.34.1


