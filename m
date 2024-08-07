Return-Path: <linux-kernel+bounces-278089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B0194AAB5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9710283D00
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458912CDBA;
	Wed,  7 Aug 2024 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H2sXuelx"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011033.outbound.protection.outlook.com [52.101.70.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B93129E93;
	Wed,  7 Aug 2024 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723042358; cv=fail; b=OW2GAMIt/4t6IFSptdzIJGcNpJA/vrbVITQ2fPTXRwpXaWcOYukAN6lxTwTtMxTDjjrhhP/5IpAQ0jglHWL01EcZtU0X/AflCMqx3YlCOyPcp0pBLnM0y1GuMHR7hjoucTT9zDyeAZ1E0f4e+O66YLbExdRuQdQ4ewSt5mUKRoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723042358; c=relaxed/simple;
	bh=VD25HOBvNKftREXeFQ7O2XTiwzY4dfr/JNchbklw86Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fj/FSnUydOaO7LCJxkEjQJt/zEQVWrcE3giFcSUYzMbBZ/ZhxKp0TFZeokc5j0VLLqQU3Pe83RYDSE+1MwIzuOvScu2018rmi2FxOwmSQFhlOj7sDmlp4wGUzzxa/rGU7ga4LfoLhELORj0YP6U6KJQttJ70Jm5/cUTXnmJFSu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H2sXuelx; arc=fail smtp.client-ip=52.101.70.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrkysSiOJVYRGYAmCf62jeU3zyBTMZnxlhTJ/+ybRNHkMpkm07DaW4Umm9HQrF6EKlhil40WbGsjBhzsOg3sCBcaF5Tq2mqiy+9vu2fJMs5K6N9DJaMzbSrV3q2lcq2aA3pjBa984EN80ezEEKNOqRcgdWDKuE84mXKvrDUNmX0QUR/veRjfIDvXdNmwbqqv/dMVFZ14HVajqVgnSLWM2YiE1/M+icXmI1IlAhWx4nl7GffKmAiz0N1j6oHlrF0yfPf9VTqYCAWJObJReN+Df869sdOY/SwgAytklXtC24/xYHpFKRjfOXE3tKIvr7Y2F1zNihcaoNZfPH0cwVQ3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9Ohgtj7TFvwAsj/np3is4K6zu6EI+i33fZ0Rk5pozQ=;
 b=TLbW3eLV/4dq+aVEdsyrCaDNVeOpnhtVf65tVmMRTLfgDjbQ0NVWCtXvjLHqrAnquK0x23dombhu3R6zYr7GEy9kDnBU6YZGrVmlFPqgcLOZxrnCqffKVagy6TlxF6CbHOGt3OLOsvVcO3a2Xr177FFdDqmehK640Ku4xthPTs/r3+XI8tZ7q4NBL1a2xdnC6gYUimp0Mqk2OcRZy/miT9dtmmqla3N4ElkZrfWABEuHoqz8S89cnXhaQMIrPThQmJKcVigD+x8HiV3ME/kWNqJsLYRhDBZeUZpzN7KHazY88JEIZWZ1Z/T6Sl4XeujAB7N3oVdBmiKS1O4GjKz0qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9Ohgtj7TFvwAsj/np3is4K6zu6EI+i33fZ0Rk5pozQ=;
 b=H2sXuelxT4sZXtAcGq2TQEqY3VKiODs1nn3GhcI1S68v7woIZsfz+jJsUMT0dPlOQdx0IRx6BeRuaHGKzROysopNK58LGpDsyjKyFVWqBMmF3X21KmbARAmvrhx1vNaCPjncldHOAY3SGrpQTSHAGrr0PeBwBu12iyMErfV8yhZ+Ps6GfuYb/3TxjBLsPaWjqqeghGWhyFADvEcWv7EHqFGPu3P6eLAWGxYk3rCpOp+9rxfKyPyhhN3xypLl2nIBrJpi/SaTbZb33IKDcUkEDgfD/4zeMUR/vi5phk2QYmdHKOQdI/RR6X/hmI297oDaYqtcAYkHIYpNvCHDcMoNVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7113.eurprd04.prod.outlook.com (2603:10a6:10:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.27; Wed, 7 Aug
 2024 14:52:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 14:52:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Aug 2024 10:52:09 -0400
Subject: [PATCH v2 6/6] arm64: dts: imx8mm-phygate: fix typo pinctrcl-0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-fsl_dts_warning-v2-6-89e08c38831a@nxp.com>
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
In-Reply-To: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723042332; l=1913;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VD25HOBvNKftREXeFQ7O2XTiwzY4dfr/JNchbklw86Q=;
 b=UYrzkzkSTMiTRWDQzVpR2oAlxlhdvwxe9o5Yz3rhtPubUlX+ypeV6zJMen7ggBsiogT5D2TG0
 gcdxhH2Px+bAyx4AjaVsWT530YBXMHe/9FQkBzGHl4z9XN9OfiCqiTd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc62e7a-6d26-42ee-fd21-08dcb6f091e7
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QjQxcjdNbktYNTM5dTEwTGN3RWIxcG1yb1FpSThEZldxa3R4RDJuM2p0N0s1?=
 =?utf-8?B?QTBzL2NWeU5OaTZHdk8zb3hYK1E3SmI5TGxqdjVsQzdHcTdOdHFPSzJydFpl?=
 =?utf-8?B?bXovbWlNbXVHWitRYVdvazJHZkJLRGxaTWhRaTBMYUZ2RXFIN3o0M2ZqUDJN?=
 =?utf-8?B?QTQ2aDFOVkNRQjRBblpuUDlLSlFhOFlPOHBYSm45SzZKNlFuYWM4RHd4L01U?=
 =?utf-8?B?UmhVQ2ozbjFGQVFrRlB0cEcrWis4ZzZseE5lQXRTMmZYOWJIaElPYWUzajFN?=
 =?utf-8?B?cVFvQURGMTZmM0RVRkxmTU0xNlRJbDA2MlhTT29jaE9Uc292dnZTbmc3NUJL?=
 =?utf-8?B?Z1ZuQ0o5OGZkWXRqY1NKWHJvT3lFeDVUeUVmYlhDejF3MmVrTjhwR2FCc3FH?=
 =?utf-8?B?UkhKSDNRZ3I2M3JaM0FJKzhOaUFvTXZVRjlQUGpGRVhpQVFkSkx2OVo3bkh2?=
 =?utf-8?B?RW9tcnE4VTBCUS9wbEM0eFlBUkt4UVFyZEsvd0lWK3JFSGtVSDR0T0xkRzN4?=
 =?utf-8?B?RVNnZFhuQTlqTnhobzR3aW01MDhzaFhjVkY4bTNHZVdWL3UrQWg0dzFzZmxC?=
 =?utf-8?B?QmExdVBVZDd5N1IyWGNBZ2NTNWFGVXRpZG81b0t0ZmJTYzFGdUN6U0tXR0VO?=
 =?utf-8?B?em1pOXhJK1RUVkV2dTVmQlRTd0ZOT2F1Q3huTDJlU3VzYllGdnRtVkFLeFE5?=
 =?utf-8?B?SFNCL25oaUhsNnZrOWFmemxSR2taTjIrZ3NCUTJrKzRDSnc2TUNONU9tTVBs?=
 =?utf-8?B?M2N2N1I1Rlc1MmlRRFdBVEk1YjhtTmovWk56NE9XbDgzUkZCRHdoL1NsaStj?=
 =?utf-8?B?OCtnRUtCcEIxaUNjVEJTQTU5bUdranREdFFrVXZTMlhtaTF6VW9ENmh2QTV0?=
 =?utf-8?B?UThLNHdJT254ejgzWU52K24ycUQxdTJGQi81U3phOFRxL1dtZ2hCd1NzUm9h?=
 =?utf-8?B?bFBRc1BPa3BqLzZLZVk3U2V3R0tHNUFxc0l6SlVpaG1tRjRJeVA5UU8vZVdB?=
 =?utf-8?B?N3VMT21NWTVlRUdGU2RtTWJCVFpRTitDSDNBNWFnMEIvV2ttZDRDSGZjT3ZS?=
 =?utf-8?B?cjdLdUl3RWlISW1LMkdJQVduUWF2ODM5NW00SXc1cUFaRGpZTno3Vm5lMTVv?=
 =?utf-8?B?azhBRUVMOE9XWTlhRXR6ZUZ4RStTZWNIZkZreVFScVlzRjJlSEYvVnlzYlhy?=
 =?utf-8?B?V3d2MmtSRS91SDBzRlBPY1dkenArZ01RMzFuVWpQaXQxajQwTDgzWTVGZDNl?=
 =?utf-8?B?VU51ZVVyUlF6Q3YzSTdJQ0czYTZMaUxUOGRxak5Hb3lpdGdCWEpsYXF3dnVl?=
 =?utf-8?B?Tm5iRmhCakd2TTVRbHNFaXdqVHRoMHlnL0NqRUtDbi9EMllUbmtXc0k4bGZw?=
 =?utf-8?B?YjFZUlJHVzhicEJlaGhneDZxa3FJaXIzUXBBUm11U1d2RVZ2RW9SOGRMemRJ?=
 =?utf-8?B?OU5reW0xVW9GUi9wVUI4K0RkQTlZV0pTQ3NRK1RaVXdOa0RPT1NadmZzdkN1?=
 =?utf-8?B?a1MwdUR4eGd5RmhtSXprT2RXNUg4c1FWZk9qeUNPU0RDTDFvZXpsM2docVNt?=
 =?utf-8?B?c0JNaDZEQWthTExqZjF2c2FwQ3RCcDVRQ29HNWtUcXoxb3BLTkJGMWRIc0hz?=
 =?utf-8?B?TkVXTGU2R3F2dFZsZGc3OWlwa25pQTh3bTVjZ3RlVHJqcXJ6NndqZ1JDazZr?=
 =?utf-8?B?OGVMaitQdTFTTC9hV3lJUFdHT0xNRkN3NVZZSENuZldvNVAva0VNcXJyU3Ns?=
 =?utf-8?B?amZYcmQvOFRxTXFDb3VEOGJXaXA2YVJrOWUyamc5T2JSekRqSkRVa2tpMkt2?=
 =?utf-8?Q?wa/eE/KVVUuJPRbzFWxjthLietMAWGPngrt5s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OUc0dHcycUlaWVFWQVJlckZ3NFozR1hhelBZaXhBTFd3YXZTazNmVTNRM1Zk?=
 =?utf-8?B?clJic3owOVlYdndQWmpSMEMyQzdudTJSQ2wxWlpzZGpqZGRwOHJKdVZPYnRJ?=
 =?utf-8?B?cTlRNktmOHNJMmJsdnhEd1cyMHNFNDhFWHM3WnFXYllDSUxvanNucjFCZXJa?=
 =?utf-8?B?NGZkVEpIS3hyZjRVVEIvZG56ajlERkxaZERuMGJmWWYzUVZXVW4yV1lzaHhP?=
 =?utf-8?B?QTM1L2pWMUFWUGJUODhmQytNRkFsQzRMcmVVMUdXNVpQSW1zbFU1dkpkbjAr?=
 =?utf-8?B?TGFmTDV0VXNuOENBb1RrcUNUU2hXTG5icEs5N1lRWStxQkhNaWFnWllnVDNH?=
 =?utf-8?B?aWJNQzU5TktPVmtISWdjRGNsQmpveENJNnh1QmdGYjRKUlYreUhuVDZZdHlw?=
 =?utf-8?B?SnhZNVhsRmtUVEt1RXpya2h4YitrVHVhR3pWcklHU1VHRXU2Y3lFWjRNZ0o3?=
 =?utf-8?B?dFpJYkgxZ1ZsWUJOLzVzRHhMeUxOZVU3aUhPcVZVOHVMQ29LUEJCaVZEZGJm?=
 =?utf-8?B?T1oxczFlODB4a2owMmNRSndqZFZFdEZNR2xER1IydlpueU1EK1FPeWZIelBN?=
 =?utf-8?B?VlQ2Vk1sSlFpa1ZkMlgyUWJKb2VGZEhsbjh4aUgyQjZ6bjRXL2NXaW1IdHkz?=
 =?utf-8?B?S0cyUmZndXBwc1J1Z1didytOTTdBR3o4VWJJZnNSRGJZeTZqbEh1b0U4YlNK?=
 =?utf-8?B?MUt1RUNBeDBHR0p4THZTMm5IdXg2Ymc5SHpHdzZNemtjelppRjFObHJBMkI3?=
 =?utf-8?B?TzcrN09wVkExekh3bzlRQWQ5VG9udkJqNlQzZHdWSnBFSk5LNW9mQ1lOdHlD?=
 =?utf-8?B?N3Y5R1FkWVNtcWRZdC9GZTZ0bkhwMXV5ZGQ0YnNOblplbWMvT1MyUnNjUjZo?=
 =?utf-8?B?enpYVHFGaE12MEU4MGZUL2ZHVEVBS0RDMGpiTzJqK3AyRk10LzBTeG5pbVFR?=
 =?utf-8?B?eFY2OGZjY2RTS3hrVHpFRG9mMWx5bm9OZFFyL0FacVBBeE9DT0wrcUU2NGlP?=
 =?utf-8?B?RDRNc01xenlXWXpIMk5EeFlwQTBxeThFNG5HdmwzKzdaSGU2RzZhRTlxK0dn?=
 =?utf-8?B?MEl0MlNyTDlwb0hGZnFYaUtQemR2QzRqdFZ6MS9FSGlLZThIYWM2Vy94Mytk?=
 =?utf-8?B?UnBlMnMvZG81anNWWHh4Tk5SSFpZWHYrZkltYnQxSnFGV05KbEIxd0VWZ3pT?=
 =?utf-8?B?dEhRdWhCMlhHc01UTW1wajlzTEFEWUpyV09xUkVOdXZDbE4wb2NRNlY1MFIx?=
 =?utf-8?B?KzNPeVRDajJSK2o0cUtXaS9GWTVTamMzSHFWd3FBVjlUWnR3SDE5ejVab1N4?=
 =?utf-8?B?T2pRczY2R1o0LzhQNnNBSXh5bWxnR3hYNkZZVXJna28vSHU2ZHlIV0FwemZp?=
 =?utf-8?B?ZlBzT055ZUQ5RkhSZFA4YUFmTSt1Vk1DVXhNbS8zNXhiRzFYZXpSKzRPSDdY?=
 =?utf-8?B?QURxODUwaUxwZ0Z3REV2TEFwK1FTcTBWRVArNXdmb2xhd3M2cFNYUjJFbUNz?=
 =?utf-8?B?TkwvemF1cnhkK1VTbDVjLzFZbStMZ2JlSUdEcnVRbjI3MXV1bmlQaVlncDJI?=
 =?utf-8?B?OWt4bzBEMW5Kc21ST0ZENUMvUmRpSm9zUGZqMU82WkREUHpOS0tqeDU0VlBD?=
 =?utf-8?B?M2xlNWgzNTIrRXFiVDlvVXJHaWE1Zm5UZEtRUm1taG0zc21tMmE5UzBKSkg0?=
 =?utf-8?B?VGNLZ1VMb1Q5U24yaXJiYjREL2RDc2NhTkVqNFRvNzM5c21MeStYdVFMekM5?=
 =?utf-8?B?TlE1Rm9Na0tJTzhKT21xVS84Rll5cEMyN2ttbGprUW1JUGpsN3c4N0xmcE95?=
 =?utf-8?B?K2UxU05PUVhaTFFwc3Q0Znl6RXhRUCtCbzZFdzRRNVM5V3NkVGhPK3g2aEZo?=
 =?utf-8?B?SjhQUXBiVmZiMEZGc0gzdUdsd2w4WGwydVZCUHM3SVVSeEg3TW4rd1ExTmdR?=
 =?utf-8?B?Q0VpMzIzSE9uU3V2L1NSYWhBaXVrWlQ1eXh1WEhZSGphQ2J6aEJrZ1pDZ1Jq?=
 =?utf-8?B?RUNxRS8yKzl0K2xhU3RyTEJGbmtaVUVWNGplVE5ybUV3YXltcVlWYUdScnVh?=
 =?utf-8?B?SWZCQWt1VjFSZnE5LzN3S3I0dDA0N2FZdjJibXVSTFM0ME1FVnFXRVhLS3RE?=
 =?utf-8?Q?uaRs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc62e7a-6d26-42ee-fd21-08dcb6f091e7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 14:52:33.7140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMQVgpFmxyLbtcwhOTiPsbbNEwe8yTpLNpsVfpv2xaMyl/l6s5OdgJzD7A5suXHeg/5vIo/OEYaJJfnNt5s7/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7113

Fix typo pinctrcl-0 with pinctrl-0.
Fix below warning:

arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtb: gpio@30220000: 'pinctrl-0' is a dependency of 'pinctrl-names'
        from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#
arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtb: uart4_rs485_en: $nodename:0: 'uart4_rs485_en' does not match '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$

Fixes: 8d97083c0b5d ("arm64: dts: phygate-tauri-l: add overlays for RS232 and RS485")
Reviewed-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso | 2 +-
 arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
index 9dd0703423635..f1f38b739ef76 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso
@@ -16,7 +16,7 @@
 
 &gpio3 {
 	pinctrl-names = "default";
-	pinctrcl-0 = <&pinctrl_gpio3_hog>;
+	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
 	uart4_rs485_en {
 		gpio-hog;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
index 045cd8082781c..1d8951e1a47e8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso
@@ -17,7 +17,7 @@
 
 &gpio3 {
 	pinctrl-names = "default";
-	pinctrcl-0 = <&pinctrl_gpio3_hog>;
+	pinctrl-0 = <&pinctrl_gpio3_hog>;
 
 	uart4_rs485_en {
 		gpio-hog;

-- 
2.34.1


