Return-Path: <linux-kernel+bounces-292579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04415957170
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292B11C21C02
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6198BFC;
	Mon, 19 Aug 2024 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mGlhZ3Ut"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BEE188003;
	Mon, 19 Aug 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087000; cv=fail; b=oBK6IA7p0q8OSt0o90kyHESRhOR7AiLdunrVmptPU8N+NNZc20nlONR8Vw1mckWmhQQRjScMMj3euBZDo8KlTsZV6XsekBP5QvOMNVgDCcEedQPsWtSZPnmLqoaMisTnQO5d0+3CggOZOVsEqTtk6gUNlR4s9/QT8bwF8zw4s2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087000; c=relaxed/simple;
	bh=Cqr6pSyDI4Ta8qCJdT1hPFGghs/Sc2YI80govxTCjlI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dQg++edT4MYOGjHH3/u8J5i/fGtjJXS9gfehYev4QD9r+6VjcfXqoL5LeJPagb6S7KFZwf7SLsN8Y9fgsv6OYchsmHrv/bHNcE7hQTrhzi6a+m4RLGuA/CC8c5Iee144l4RDyLB7iHAc/vr0h+dMU4T8D+oG3L84HzOoxCEVQxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mGlhZ3Ut; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZbQg4f1WVsGWasqNQ0a6wi8lvmkBo/FVEG+ICXc0zgtrswMf0Leq76/2Vp+leZbMsjiPI3kGU6+QtoUrklhVfW7e/XrUAqb4c/VJDJTw1GIZPDBUU4WiIa83ESXKtJ9gY4qjawFV24Pv7kOv4YGR+LqbbPWT+buxC9hH3448igsgWLp+BzTth4fWa1NJvNcQ6PXBHPOV+Aykkp/elS6KKoNSBGLxZ0QwJSW548HdzprrOcLGckvy3fccaa1dC/6ZQG7r8IDSTGXV0bVwYZlj11ITsL98NyDBbtcUJzecBVFuC1kfVeiZ7F2nlOj90B2al78LoKuRItfTZNrdJOCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7jw1J37Li2TfPMm76ScCvMwZdE3Us3lzgfAckaY5UM=;
 b=yjjLFz3vFbbRb/kKdV8YxKT27mgB5I9dSMyFWzZYK5oyC1s7BtF7WuDC2dK/qu0uipANa3RWPxq+lVV7L+NP2cZu3/QcCU+JyQU9znPbPmvpV7OmnrGiBDV0Gi14iZEX5kRsEM+FonRxRd0PYprB7DAelp68l7FR6rEmncGG/PWi4StUuDcCaPlxmkBmAVMSgmu33+HlTh8Mp6osbJ0BrAcb+GWt2Y/hPlYZR3anLNvxvSapgn6BLs2KfXODa9YlHyGRIsWYIfjeRyQNa/XG11Rpn5MqluoXD2RgXh0Z0tJsanetXmW7yQNTXcTo3C8xVbmNAiQfBKRB0CouzTc+6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7jw1J37Li2TfPMm76ScCvMwZdE3Us3lzgfAckaY5UM=;
 b=mGlhZ3UtoAEOPUuDSRNdJ5Y19PSyfvhQLj6PrrlsqtOD9G1rNv6lLcmrP9G0LBYSga05+S+ieSRRehIDYeRcoUyo1dYiXEASlO9qiOWE3X/utLh8X2vDRY4GqLnrzfB//xKKs38EULerbq/8VG5v11/fExSgvABCSpoR5FNlgxOezuGR2IV6fOIXJcvy7z0rficKpOH4CBRdbQxBOiA0EUb8zOJN0Te9oMqsqcEyvQ1fIqztniHsjKje/RIKkKnqR0bHSZsC8zJjGsNWMM3Dph2m5UvLwK4KJoX1+fWZ/RHdh4kOP3am0128/SnTECTB1hAqsLdNTBvFan+t1OK+vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:12 -0400
Subject: [PATCH v2 03/12] arm64: dts: imx: rename gpio hog as <gpio
 name>-hog
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-3-4c428bd11160@nxp.com>
References: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
In-Reply-To: <20240819-imx_warning-v2-0-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=6641;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Cqr6pSyDI4Ta8qCJdT1hPFGghs/Sc2YI80govxTCjlI=;
 b=Sj2ZAmK8ipJ6e/zo8IPQxrh5Dd3wppJf80uLy4fRe4Mk4uzZv2USOPKi6g/oDD46mYOM1M8xU
 fnNTXDt4Sj+CDAQYIq/fEdndY4rU8P7up2GSQMRFyiY2pmPFULGTMhn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8761:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f61428-536d-4549-8c47-08dcc070d1fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG1oazA3YTFxczUybk8vWHVUTE96cmJZVHpHZjVPS1F5TFB5S0t5RGZaTE9Y?=
 =?utf-8?B?dGRSZUZLNjYyeGptbk1OMmZsVXdXU1Fhb0NERGNWWDNqS2VTUnJRcUJlSUcv?=
 =?utf-8?B?cHh0ei9qZ2N3ZGgrL1hwcGRObVBRV2kyWEdXN1JuOXVZMFRENzIwQjN2ODhO?=
 =?utf-8?B?bjNDY1FabWtSTzFMaXFmS0dGK2x0MG9SenVQclhGNkhaYUV6MWpLVmpTRldD?=
 =?utf-8?B?bno3T1dpb2pna3FsZXBFTit5R245dWowVFJGY2hvTXRDWnIxeXdHTWxydWZw?=
 =?utf-8?B?NCthb3VlQVBMcTdzcENEQW1CL0JaNXJYZm0yK25GMmNCM3VHS1M1bU91UHRG?=
 =?utf-8?B?bHJXWXJ5cXh3Y0ZTNTFVTXZyTDkxcTVaL0s3UHoxcVZNY3llMmRtUy81NmJq?=
 =?utf-8?B?NVZHWWNaS3Y4bHVOVUYxWkc2M2MwSWJiSkVCenB5THBYMHhEcHBDNWhKWnk5?=
 =?utf-8?B?VkFJaTdrZWI0ZGxUNkIyTDdkakRGTlBEQm9PSGNWWm1rRzRBbVhKSkU4dk5Q?=
 =?utf-8?B?Q2I5a1k5cDk2aDlRRGJ6WW1Ka29KZ0lMMlY3T2NmVnFENzNaYVphS25RbDNJ?=
 =?utf-8?B?dGRTUTczbHFYOEJxOVlPOUkwUWVWd210YzBzbFpFTzB5MG9ENGVPU2Q3Nkt1?=
 =?utf-8?B?cVd5anMxTk55TUhjOUxwRTdJaFZneXVaV3hCZkdzdk1jbkM4S041VGlVcE5Y?=
 =?utf-8?B?cWNzSmZNdjE4SitRb3B1QVhqelRaMkYzUG9hZ2ZGNlpTdmhzOFRLRGhsNWov?=
 =?utf-8?B?bDRBR1NiZTJmMTB1NWhsbDk5YzVtaStDTDhkUnZwUC91a2NPR01uQkIwRzBk?=
 =?utf-8?B?NXYxaEVkdVFuSFpXMTh2OWc4aENGR3VwckRrRTYyR056MXMzK25rdGo5TkNO?=
 =?utf-8?B?TGFYbUVPS0o3aXZhMHpXc3JDcytKTjhhNW9ld1diY0p6STBXZG5ySHUyV3BK?=
 =?utf-8?B?OCs0UjkxTzN2blh6czc4UlkyVDNGQzlnZEthSS93cTRVTGVveUZMY0d1eEZG?=
 =?utf-8?B?cWU5azkxY1FyY0c0VW1PMUpqU1NCS2ljZjc2bXhCY1pZKy9sUXlrdGhYSzgr?=
 =?utf-8?B?OHYvMEkwN3Ztenl1ZEQyenpzNExTWHVnRC9yNS9BSHJSdUphcUJvaUZCNVI0?=
 =?utf-8?B?ek8yem1kTCtYbGJmaXhGZnp1WlZic2lqTFRmKzJLMlg1bm52KzEyc3U1R0VC?=
 =?utf-8?B?dCtEaXYwOHlsanFXRGNjZUtHYjRMUEVKeEJEbkZ0czJPQjd5NjFZaEhXaE84?=
 =?utf-8?B?SFlaNWlsbDh4NHBvRjF3eStkVU04Qm9CQ1RwQU9sdkVUekVLRE9DeVZ3U1Uw?=
 =?utf-8?B?dHJSNTJqN0lZaXljWkFpRitxRS9EMG9VUDZuMWdFOTREak4zYnNHWUE1MDN3?=
 =?utf-8?B?TDE4dnliUmg2L21uVEVxbERybU9zRE9HbGNhMWppNmZxY3h5UldKbXg1Rlpr?=
 =?utf-8?B?NTNsdnlxeWUxMCtoK21yc1lsUUljRnVXLzgySUNLOVRmQXJRVWlqcEFiL2RN?=
 =?utf-8?B?Smh4MXF6SUhWdG9qVlZldjlGeG0rSlZBeVVsZVgyc3VIbWFaWGFHSnpYTzE3?=
 =?utf-8?B?c2JLL0dINjdGblBVQTBJOVNrWXcvTVdhRlNLUXd3b202dlBsNXcydG5qT2hB?=
 =?utf-8?B?ZklReXFmUkZRV2ZpcTNTNTVpUU1ITzZvbTg5d2dHZU0zQXRMMnlpLzd5NTAw?=
 =?utf-8?B?QkFoajRpWkdXTFFORzVndnNLK3JLQ0xaU0VtKy82NmtNbC82V0JpdUtPOTBF?=
 =?utf-8?B?S08rTlBlbXJyZDRwbUQ2Y0JpMkJHYndTQ3AwRjBWUEt2My8rSlRXWXdnQTBj?=
 =?utf-8?B?d1ZTd2NOam5Cb2dMaHhIc1hSUzUvRm90cmRxNWdSUWdUVlVFZytDZUN4UG4z?=
 =?utf-8?B?UGhlWkdZam1IMzZRMjFoNHJoUlpmd1pHYm1nOVp1TWVmUnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MThhNFVhYUFGTGJXbGVpQ2pyeVZBRmZORVdpNGZ3K2xvQlZNbGlKWE5NQTZE?=
 =?utf-8?B?RjF1Z1JZaDlrUjhkanlyS2JacE5Fb3Q0UWxYb1FnTG9hTHFrU3UveFFIcHBk?=
 =?utf-8?B?MmQyY0oram1pVjlqUmRreFpnRFQyU3pCZTM5Uit1NE1xZnl3K0x0VG91dW5K?=
 =?utf-8?B?VURZUSt0a3RVZXZmTkFGVTdyQ2RydnVYa3AzUmxiZUM5Ly9DS2psMlMramd4?=
 =?utf-8?B?UlgrZDJWSUs0OU9xTHYrZkE5VTNYbXRtMjZ0dE9QbUl3U04wNXM2YkI2TTVy?=
 =?utf-8?B?L2xWKys2Q2Q0Uis3T1pKUnIvYmlDaHV0MzBPMDhyNVdwQlJMUlBlSmxocFVk?=
 =?utf-8?B?YUx4MnFrM3ZKNEVRVWdiRWdyejFlS0R0TG9tNG9ZbERscmR5Q3BEOTVYNjZj?=
 =?utf-8?B?aGJsTVUwV1I1dkxOZmpibUpSckZCOUJHTmdiVWRBTzRUeUZDZFc2TGxWbng1?=
 =?utf-8?B?M0NMcjNTcDFodmZqMVhqbVYwL1o4UlA1emZNcmZieVN4Skd6WDZ6WEUweWc4?=
 =?utf-8?B?azFiNEV2d1UycU9qYjY3WXg4MDE1cmpWOHlycUJpWFU1c2VzWG5KdTdUNlhW?=
 =?utf-8?B?WmgzNExWN0tNdXhOM2RRZHNkYWF3U21keE9ocUQ1YW5IQ252dkV6VUwzYSs1?=
 =?utf-8?B?QWFYd3FvMjRPaGVVanhZWVFJL0N2WWx1ajVRMEJDUnVTcGtjai81cHk0N1VN?=
 =?utf-8?B?amQwcXo0S2JFU1I1VWd3YXBNOHVIV3VWbVZ5NGRCNWNDdzRwZFZ6alM1YzZQ?=
 =?utf-8?B?aDdtdmVnTFZxL2kxckR2WUV2dEZjN3hqdm5LdlJBR2dvK2pCTmVNc3RCQ0hx?=
 =?utf-8?B?cXZta1BaN2xJOUZZcGFoTUJOZlp1ZlRIaGRPa25STTh6aGI4eUNtMWlvUUdP?=
 =?utf-8?B?TGE2REpDZnlrRSs2TXp0RXVpMlBnb25WVGtDSHBLQis0NThZODlFYkVxUlF3?=
 =?utf-8?B?eFF6OXpxMnpGMTFaT2l1WkFvRStOOEtMOG1EdTM5aEVobkRXa3h5cjNVQVpM?=
 =?utf-8?B?eEZuc1gyV2ZYdkFQMGtmVElHTHMyOC90Tk5FTHlYNzZTU2kvU1F3a201S1U0?=
 =?utf-8?B?ZE1yNmFIZ2RsbkhrNGFTWlpmd296b25ja29VTkxsT0NWM2FINzJWY2s1Z3JS?=
 =?utf-8?B?SytrVklDa0NCeEdlZ3pJdEs5UHlid1dJSm8zM1Q2bFNZZTZKY3JXSCt6anZG?=
 =?utf-8?B?elIycmx5U25XOFdRWlVwbnpja2k4N045TmRIN3FZUGZ1RGphTXlQL2ZyTDZ5?=
 =?utf-8?B?TGFleHBLZWpOTzV4L0VMdnMrUjlBUWJ6SjBKeGUvRUxPQ1FYbXR5MTF3QTdF?=
 =?utf-8?B?OUNGVVU4T3JQaE9POUJ4WkNCem85Y1d6ekZHMG5DNUVFMmJvVnp0WTRwemoz?=
 =?utf-8?B?TTllaDM2Vm9VWkZYZktKa2NVUitwRDl5WkQvZGxoR211LzE4QzdQSXNMVlJF?=
 =?utf-8?B?VlRIUjlCUFk1b2tSazZteGZwcjFTU1ZsV3JZaHJyZkY4V2gweExaa0I1R011?=
 =?utf-8?B?ZXdqWDZ3eWErQmRVYitBVlcvSVZScU1lelF4ODRJZzhMQkwwN1BNaWxHOE5H?=
 =?utf-8?B?ZHFaWWNxSWttdnVocXlJMjk0MzFuekwrWVBldEpzK1ZPS3dPcWIxUXQzSDZ5?=
 =?utf-8?B?eTFZQzRMTXdmL2Y0YVNGVEJGblp0QjFMdE82RW5WV3Bya1NMdDdkT2VKZnQ1?=
 =?utf-8?B?TlphNmRaRnpUTkM1U1g4dU1hazB3b3N1UFdNLzZoRk1Oa0thWTJPemF2djZR?=
 =?utf-8?B?MWE1amozYVRCc0RBa0paK1dWYnFPbFFLYVhDTDZkOUpGQkdSR0ZkNkc3em8w?=
 =?utf-8?B?SllydDZuNUt2cnhCWkEySEY0SWhCVkY5SkdUek96cWZGTHdKdTV2RVk1SkxP?=
 =?utf-8?B?M1hrMWhlMnFWM2t1dmhaZFJ1VGxCZUUzUStnV2hlUXA3OFNJRzRKbE5sSkFs?=
 =?utf-8?B?ODMxcU4waHd0QTVqVmJVaW51clJsNjZzalFJUlRPU2tndWJwWG5EZkZxUnN3?=
 =?utf-8?B?UkRzNVRwODdYVmk4RG9oU1NDRWFsT1BqNitCWFFma2Q1R2NlZkZZNTVnbkNL?=
 =?utf-8?B?UEY2T2tiNjM2ZkVQbi9GYzlzSnBIcDllTVJjWFEvL0F2UElTZ3lkOTM2cG5H?=
 =?utf-8?Q?t+xOB54p2MncEz8/d+H02yZRF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f61428-536d-4549-8c47-08dcc070d1fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:17.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ecL0zt+VvR7lDa153pQyUizqrVFbE9lyVtqv3+teFH/1/3hs80EySB/gdL2IhVZ09G9y3c6zGQeeyYgztO0aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Rename admin_led_lower to admin-led-lower-hog.
Rename gpio rs485_en as rs485-en-hog.
Rename gpio uart4_rs485_en to uart4-rs485-en-hog.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: gpio@76:
  'admin_led_lower' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb:
  gpio@30230000: 'rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtb:
  gpio@30220000: 'uart4_rs485_en' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts                   | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso  | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso      | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso      | 4 ++--
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index d4867d6cf47cd..57f2082143c8a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -220,7 +220,7 @@ sfpgpio: gpio@76 {
 		#gpio-cells = <2>;
 		gpio-controller;
 
-		admin_led_lower {
+		admin-led-lower-hog {
 			gpio-hog;
 			gpios = <13 GPIO_ACTIVE_HIGH>;
 			output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
index f1f38b739ef76..78f4e8d5814da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
@@ -18,7 +18,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
-	uart4_rs485_en {
+	uart4-rs485-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
index 1d8951e1a47e8..66288948bdd39 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
@@ -19,7 +19,7 @@ &gpio3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
-	uart4_rs485_en {
+	uart4-rs485-en-hog {
 		gpio-hog;
 		gpios = <20 GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
index 47d3c0c49e8a0..bb2056746f8c9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
index 7fcd8c851159a..45ac8bdce8699 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
index b19e38fc27bae..30aa620d7004d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
index c0f6aece844a0..b1a9f35e1dfa7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
@@ -16,7 +16,7 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
index e909cbd8db4bc..44ebc0a58c51a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-low;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
index 1508cb5175b3e..2f8a7ac408739 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
@@ -19,14 +19,14 @@
 /plugin/;
 
 &gpio4 {
-	rs485_en {
+	rs485-en-hog {
 		gpio-hog;
 		gpios = <0 GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "rs485_en";
 	};
 
-	rs485_hd {
+	rs485-hd-hog {
 		gpio-hog;
 		gpios = <2 GPIO_ACTIVE_HIGH>;
 		output-high;

-- 
2.34.1


