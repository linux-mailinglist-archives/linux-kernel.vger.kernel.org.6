Return-Path: <linux-kernel+bounces-524171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810EAA3E01D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3D923AF0BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF520F062;
	Thu, 20 Feb 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rv+tXiqZ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013066.outbound.protection.outlook.com [52.101.67.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EFF200132;
	Thu, 20 Feb 2025 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740067906; cv=fail; b=hAYlQ0cpmsT/LRAkmpHJp8UWt+roMKU1Gio2IT1HSK6JR/LhMBFm/zGlp9z0ZX9DaCF7I4JgzwHQDDde1sv/PkJiw22j/lk+Qh0kAQmGMwDXM3gRSBErcCjhPpVnWoc8xJE38AtQvkyRvYGudpiLJHFeBD8JKqW6tZUkAx+V7JA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740067906; c=relaxed/simple;
	bh=lTGoGE67IOXkwco1thoVtLrTh1eClnbIL5LATnIRX/E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ir2B5h9xJxTEPV1k53GHatIXnsiB+6SQA1dtMsjsT12gLvw+6wPS/fxXx8rK6HNxp20BBg2YtkSlaM6jc3OnzFu98nR4sqPEogZA3vtacfuFzWuj1+5xMzbe0Vz+56q1CO42r7HEeZtvDzNLfuguhAeZReZ2jCPjiZ8fzXfHyBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rv+tXiqZ; arc=fail smtp.client-ip=52.101.67.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h0JOZAzrH93EkcvIdrqsllTFOPjuu/qajEAvdAlszvqzFi6BlsStJ1f6b79oyThzFlzjrSSZbWRq6cJGA6cYSnuG0N1dp7vrXYVndOYhEyIB4OpeuXD4lhw006L9rqSDBLoiaSt5PYAETsQnNOFU0tkB0S9q3I4ez3LbNMRHgw+PdbilwoupUyuHUQsrdAPFlQgziF8SIobRBNhqF6QsR5xAXRlm1YibV6CA8BSXs/acEcPnNgWoR5luvTEYmjHNAuSJwsBtCqfYsiosyWJW/gcAsZgdV1igr0sXMOQjOnKzgAbdL4m39eqNw9HaBMNIEbVzzxkP/Frg8qskQh49pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6q2aasrqQZxwfQl8JS7h/fvea4UaeV5PZXZanSdfLzA=;
 b=BIj69ekIJGyJvDIMHJwhzQ1Yh7klpqqhj3vgfGMmL8/8D7StyaiR/R3rHtaKeUfUjaCrC7jUN5VvN6rJM1j5iev1kuQkA9LH+RKoLFZSVZuINKAFpDnsHjDkbj3WtN76Y4IX/NyQomeF4hpw9DGCD2ZN4cJDaXVzzMABzBLAEi92oi/uwvtNIMlDb5e8Xgn95EloSmDdgw+unpk/ghA+RkJP/nLyjhYA2eLT9tCUdRsHbskhE0ZR1DOWyTmmGl8bF1hnn4zbG0tdslxIGDr64VRCjJXqm18aBORK2EIhKPR/M/EXou+qrynBd1X0rhH34vkB3mwZJpTiRZZyqu+87A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6q2aasrqQZxwfQl8JS7h/fvea4UaeV5PZXZanSdfLzA=;
 b=Rv+tXiqZTG/NWLe1JH4Tm8L6B18SWI3gKze2arzpvZkdzWctBBs5IzoWZ5lxi9nz8/ybfLgKkIOBF1K26AdlYxDrYfdIjQJLW5oxSBWBCJnQ4SSjE8yI6q0KnErDjnMidgx7daTrGSnunXZJBCZ5DMl4237kAxaIFwkNyyAVd2n4q22TCqRkVNtW4iYHRTxj9K4csmqFbo3dYxrEHlOb97oPQBqm+2ehpRhhoAmyZ8VbuNF4pn5XCQf3mHKOiJ0XJyFNG1OsBTLAWHcRpU/mJmjnxhRSRgnr2MuK939kNn8+f63wqvrVJIYCi5tv3R8DTIWMlgaATxiETvQB/7x+QQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9968.eurprd04.prod.outlook.com (2603:10a6:10:4d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 16:11:42 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 16:11:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 20 Feb 2025 11:11:18 -0500
Subject: [PATCH v3 3/4] arm64: dts: imx95: Add i3c1 and i3c2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-imx95_15x15-v3-3-247777ed91c4@nxp.com>
References: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
In-Reply-To: <20250220-imx95_15x15-v3-0-247777ed91c4@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740067888; l=1691;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=lTGoGE67IOXkwco1thoVtLrTh1eClnbIL5LATnIRX/E=;
 b=mlocwaQSZ5qjWfAkuOsqniskefKu8/BrJibOOF/afXCHTj6QEFlPpwlZOwThIyteBmLwkTIvz
 nwc5v9DJXNmDwBwrzYSwKsbOHXTyWLW7UDkvsZLaIWBxJI/Bn06K/3K
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: 88acec8e-08c6-453d-5b36-08dd51c94371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWt3eVQ2eFc5YURmV1hpZDBldk5nSHJDeForc0FEQytwYTF0QTQ5V3FNM292?=
 =?utf-8?B?WE4rL29DN3BoSTBpb25rRndCdnBDUzFNVkFweWtuWno0VERXN3ZycjY2WWNO?=
 =?utf-8?B?NXkwYUVjeThXTTJEQkR3NXNqZ3dtN2pRTEpHYmlTK2RYMm5HVEpZalJPd1JE?=
 =?utf-8?B?bzJMTURZNTJYUHRwbGNGOFpldTUvQ0RXUTlrQ2FQeEFZN3YrSE9QSGV0dTA4?=
 =?utf-8?B?c05UMWFvQTNadWsyRmVNcFY4eTh2TkduSnhJS0tMTm9FNzVBQ3VnaEFhQXU3?=
 =?utf-8?B?bTEvaTFrSDlOOTFFWkFCVzk1aW5PSDBqTDViU0hPVHJJclNPVks0bEwxVlJa?=
 =?utf-8?B?RHU4Yjl2KzVzeWNsTjNZTzQ3UUdVTXo0Y1M1NVVaK21ySDFKa1B6Sm51Rm45?=
 =?utf-8?B?ZEtmSEZyQnFCOEpFd2RrTDRpRC9zMXBxc05iZllOZzFWd3llQTBxUEpzQ2FC?=
 =?utf-8?B?bndMenZCbzRoL3R0VEdGbnM1Y0xPRjF0YVgxOEt2L0hDelh0TWhqeUo3Z2Vw?=
 =?utf-8?B?b0hTYnIvSFJ3SzlGOXE1ZG1Sbm5ycm1Ra2pqeTBjT0VNZi9jMlRsMXQvaWJo?=
 =?utf-8?B?MVp4Zjh5UGxBQkNFMzUwWFVpTURyWjBIdkhZV05WbnRZL0o1MlBIMlovZjdJ?=
 =?utf-8?B?RFBnUzRHckx6SmQvbkU2akN3UGpLVitiVTRkVTE4dzltWDZIcVM5SGJ5ZnlU?=
 =?utf-8?B?bjAyNVFvWmpRMXZSWXRFSU42OHRCY1lDLzd5MWtIZ01nZzJRU1MzVXBWT1F6?=
 =?utf-8?B?Y1FCbFltbnprN083TnZZUi8zeUo0dlM3VVNyWFpqVE1CUDdrbjhIQzZ5Tlda?=
 =?utf-8?B?SGJGaXl0VVJYWks3L1l5Qk9rWjBVcGk2MjVmVGdTNnp6WEhmbXBreUZCWE1S?=
 =?utf-8?B?OXYySlBxS3gzcURGR2xRcjJmRkVnZWxkbXByY0pqNDRrSkdIaC81Vm56VDlF?=
 =?utf-8?B?d0ZSZnFxN3NHSXVGYWVJSWVhYkNKOVk1VFJRTG1oeUtjdXpLQ0tmTUptemNa?=
 =?utf-8?B?ZlRUclNOcjFZazJleWxQdFVXQ3RJaVAzRk5oSFNiTEpjc29hY0lYUmo0ZnlW?=
 =?utf-8?B?UnhtOGpYcXlScU01RWVxM01jSkY4UkhDMjFCMmgxVW1kQXQxM2tHWEFEUklr?=
 =?utf-8?B?OW5RL1ZWaTZyK2VGWk1pMmFSSyt1M2tmN1dCSGxwajdoMTVmM0Y3ZGlwNHI2?=
 =?utf-8?B?cksyTWppWjgrYzZoYllMajlWRHNpSHF2d0ZHdEZWM3F6SCszMWF3Mm9tcUl2?=
 =?utf-8?B?NklzU3lRNUFhdWUxdTVvVUN1RjlxNzhZOTFIaU56bWRNNlpFSlU2T2pOQ2pK?=
 =?utf-8?B?eE9iNEVYYnQ2Rlg3aXdNaDFVSk5UZHZOWTZKdEFHL3E4YzBXNEREZUdnRTd6?=
 =?utf-8?B?czlRVjBtMGd1aWtPWE9SMVYyU0dDYy9OZHJLQTBxVStKeEZ1UzVtWVAvRlVH?=
 =?utf-8?B?T05Ea2NpZ1RQOG5OUTBxOGtRNDM5aUltSEtuU1l0c3BMS2JLVXBYam9QNUJj?=
 =?utf-8?B?elJZZFpUSEtGOWpJRVFsaUJNcGRTT2JhNVdwUjJ3M1I4ZDNudVpkN1djNTVX?=
 =?utf-8?B?aFRUV3ZPUGJNb3pTanIzV2MyaHpzdFlCa0h5ckFlMVUzUFZjcW02ZWl3MkJh?=
 =?utf-8?B?VkIrK3BrbjhBd3VWRXUvNUplRHJ6dFR3a1RDS2xBUW1Qci9RL3picWVnZkVP?=
 =?utf-8?B?RGNkSlpROFV1RXRxUDR6aE5JY3c3VytId0JaM0tnWC8wQnlrZGQ5YklVcTBo?=
 =?utf-8?B?VEI5VTZWODBHNzEweEhtYlIrbVh4Z0NpYkNmNmhjV0ljdVdtRUhuZHdIY2NN?=
 =?utf-8?B?ZHVLMGN4V0NOQm0yYUtOTHV1YjhlL3o4aTkrS1dEcTkydVBBRVZjSjBEUlI0?=
 =?utf-8?B?Wmg0dEtGNWp2MUszOWNiODdCbWYrZ3pMbkw4RFAxcXBBVnhlQ3pJa1FyY2l6?=
 =?utf-8?Q?h2FIcLlRNhRLBlnwB0YGHaWbJGfftx5O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXg2WTN1UDZUV0YzOXh2THpCRUwwaEdFejlOUkRya1pHMzdHOVliYTFDSHRv?=
 =?utf-8?B?RUhZeTZTdEJaRzNlRk52cWJEcC9TTWxHZVorQno5TjFLTURNT2xlamtvSjVB?=
 =?utf-8?B?d1BXUWhJMm84OVhkZytYcERBTUxCYkpGRE1wdG0vZk9Xc0JjQmJkTWlWdzFE?=
 =?utf-8?B?SDdyS05XR3RQZzhEOVZMNFl1NjZUU2JFT3JjcWkvUjMxVzh1dHYzeE9VYUE3?=
 =?utf-8?B?YkZkeUNSbVRDN3dMSVROaVh4Tm0yMlRIM3phZ3lSQjlKUTQvbENINlppenlP?=
 =?utf-8?B?dHF4cWVKV1UvdnhwSlc5ZDd4QkxFRmxVS1IzQ0dHU1VZeVlXREIxK3FYdEl0?=
 =?utf-8?B?SWtZWDEwYnViZ0dkekRaVUVpejN3QnpXTFFqaHgvTnAxSGJRU1h4eVRvSXY3?=
 =?utf-8?B?MytXUEN4NW5kaFlFVUxXNEJPUGVTeXErcko3YXRwMlJrUWlsM3NYdzBOTlZr?=
 =?utf-8?B?dFAwOHlFOXZUbjFLMlpLeXpuNSt0OXVFQ1o1R2l1L3g2Um0vTVhMczZNb29W?=
 =?utf-8?B?V1YwaHRNNjlkdzJaL21rNHJxbXlMbUM5amgxZ29tZ1M4UkpCSWRHajV3cnd2?=
 =?utf-8?B?ZUR1bmpGazgwc3VWR2tHSXBybkh6UlZvNU1lakNVVTY1a1ZBNXZpZ0VmN093?=
 =?utf-8?B?UWhYb3FPTHB6VE5DZC9ZbHJ4RDN3MGtZQVhmRDJQUXF2R2puM2RnQWxPeWs4?=
 =?utf-8?B?c1hacnNiMzc0QnJseERjZFZ3eUdyWTBSVFhud3lPbXh5aEhGWmtiZUFia1VZ?=
 =?utf-8?B?OGxSMkIwUFhMMHVnaGtPditBWllnSTBGYkg3bmNGL1FqeFZxQnhzSzlNVUYx?=
 =?utf-8?B?MmM1Qk1ZcGFGSHdHcTJWbnp2T3N6bnVYTWxOazl1NktwWDd0WmRUOEpSTXds?=
 =?utf-8?B?VFBCSlAvc2NCSkRSZlBoUnN5dzdZU1NDM0xpb3U2d0NpaGl4VVRrVHg0QmJh?=
 =?utf-8?B?c0NBeTMvUHg4ZUxsNVRKU2hYVTU1NnZqV0tUYU1nMm1MOXpwb1ZYR3lULzc0?=
 =?utf-8?B?REpIY3ZhMG53MUw0amZOOGh6dFQ0aXNEM3RSc01MSlo3a0NsMXIyMDcyMCt4?=
 =?utf-8?B?clpMZForcnQ5cGNHRkhyWU12UlJOTUFzK2p5em9zWHZJOXMzUTVTSitXWDVo?=
 =?utf-8?B?NUxOcStXL2hrcUdORHYyK0lHWjJDcDVEbkFqcWtPbjNYWnAwN3MzaVo1dkY0?=
 =?utf-8?B?R0trMDltRE14NklLd1c4dkgzMXhRN2dtV2p5SWJ6a0g2TWU0Q2FOQjIzZ2RW?=
 =?utf-8?B?MDRyWmcyQ2FUYzQraHVTUXIxclY0d1NLTG93WEF6UVc4M2VCNXVramJJN0Zl?=
 =?utf-8?B?VXZrS2NpRitSaSt1Y0VIZXZ1MjRLSmpDQ1pGd0ZFYmp0Z2x0dktQblF6bld5?=
 =?utf-8?B?UGJtc3c2cVlSblludjdjVFR3ZkxFd2lCU0VIVXg3QUJPa2hvcUUxL0hPNU9N?=
 =?utf-8?B?Tk5Xek5BeTdtUmhGaUMzdWtUakJxbzdBZktORFJHYmJVSU5oR1BMbW40dTdG?=
 =?utf-8?B?QVF6ZTdDUmJLT0dLK09DQW1lSEZTdlVEcE1Qb0NkWENtT0kvc1BaSldoNmZ1?=
 =?utf-8?B?dU5veXU1SWFZNlczQVg2aWQ5SkFjYnIxZkQ4ekFIUHR6cUN4WS9tMkxQdGxE?=
 =?utf-8?B?VHBBQThZdlFialVsc1hpQnNmS21jMTRiMHJEYTBXN0NnbEo0WFZ1d0RncmRY?=
 =?utf-8?B?Z0l6SzNDeTZuS0pTc2hMMzlhSzJ3VXdpTTZlcVVIT29aQ1lHUXAva1FRQzlM?=
 =?utf-8?B?MlZPMUtvYWFBbVEzRlBTc0NoMnpTYm8vc2RZYTZPMUZkUnZSdGdFOUpTMFFu?=
 =?utf-8?B?N21aMEs4WEx0M0FVeld1ZUlFOENITmlGOE4zU09ubUJ0UnZYb0kzUkNJT1ZE?=
 =?utf-8?B?LzRsTEVDRFdRaEFuZFQ1dU8wQ2QvbFdtd3d0RFZ5VGNRKzY0VHFCMUdLQWRP?=
 =?utf-8?B?TG9FdGJqYTRkdEVtNUpoSUpKMVdSS0tlWVFVQXVzSU0ycXp4UE4vMnY3Wndl?=
 =?utf-8?B?WVA2Y2VWSlZzZXlZN1BNMFFkSC92UW55SWZ4S3A4V2Z0UFNoRnpyTHNUN0sv?=
 =?utf-8?B?YTBGcFArNlFPUHVzWUcrTkdNendiaThTcVY4cG40bVQ3dkpERjZRN2RxZWwx?=
 =?utf-8?Q?04YWdBQsmRSZV58bxE0roUuld?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88acec8e-08c6-453d-5b36-08dd51c94371
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 16:11:41.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKRCSR9tHr9kiKKWyunZ9BZoeldrX2qS23bQcKaOpDCUPnz9q+qX0mI9Vj/llFW3oPNYmg850d8fqCnNfxBVkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9968

Add i3c1 and i3c2 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index ce4c0aa70a07f..0f2094d670527 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -673,6 +673,19 @@ tpm6: pwm@42510000 {
 				status = "disabled";
 			};
 
+			i3c2: i3c@42520000 {
+				compatible = "silvaco,i3c-master-v1";
+				reg = <0x42520000 0x10000>;
+				interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+					 <&scmi_clk IMX95_CLK_I3C2>,
+					 <&scmi_clk IMX95_CLK_I3C2SLOW>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
 			lpi2c3: i2c@42530000 {
 				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x42530000 0x10000>;
@@ -1245,6 +1258,19 @@ tpm2: pwm@44320000 {
 				status = "disabled";
 			};
 
+			i3c1: i3c@44330000 {
+				compatible = "silvaco,i3c-master-v1";
+				reg = <0x44330000 0x10000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&scmi_clk IMX95_CLK_BUSAON>,
+					 <&scmi_clk IMX95_CLK_I3C1>,
+					 <&scmi_clk IMX95_CLK_I3C1SLOW>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
 			lpi2c1: i2c@44340000 {
 				compatible = "fsl,imx95-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x44340000 0x10000>;

-- 
2.34.1


