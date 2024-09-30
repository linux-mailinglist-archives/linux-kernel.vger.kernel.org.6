Return-Path: <linux-kernel+bounces-343655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B39989DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 11:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7098B237E1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652A18B47E;
	Mon, 30 Sep 2024 09:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lz7JRPyb"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011054.outbound.protection.outlook.com [52.101.70.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62B18A6BE;
	Mon, 30 Sep 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687652; cv=fail; b=DuYgLWasSu632z2rNBzpL8TCTKdwcGwJY/YfMtzRMu5m3+xaQEOE1jBoCs/IlgrZZVLQofg4PD8OcC2+5a4a47SIsQJFoG3q57mnwe5NS7dGuuIViPIR5sPkvMbQaGbAoU1zy5k0qllCfokMuf1eujL2VuwoQH2OzCuXW39MKEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687652; c=relaxed/simple;
	bh=IWQmxUJQH1+wyKTZpdLdosaXTRPHHiOtS1Ji8/a1k28=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EzepU2i8vfc5xfGAQ4CqJ2UdkQifCY4hiPG2kp5PB0g5Gl845PXOEndZjGL6kCH/nrrkCqG3BPDLfBfYfk8JJMuu7oTauMSEuNClzq3Zr8+togFxj16wzfSejFhRQZdaWQbQQCgB2YI+dpgAGCn6DVou1Dg5kkj75UxAoD9u8Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=lz7JRPyb; arc=fail smtp.client-ip=52.101.70.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/S5084/Vw77jFCBdFXjFPcefuZcc94uXKtSDlXtboh1fXWyDvq2Tpw+yIOUmafVPK57+RIO+4h/hq3Dj0kea1kzSD9cLSfGyBxb7n3t4q2Rl8UUH9psgJ2zo+p9ZedhFkT7ztew1ylHUsuKdBSRcXPrZH6uzGmJ1K5aH+lQL/HExOD/69+tRQQGfrQmJ+LyS2OHU9fXyOdcIO5Nwl37as6iKEGkF6cCGJkCTK+3mozFknmIY82/xqteLzuDs84Z57GabnPEhJMObDkwBWQOXWukgle7lmGkatjLn+v69ihGZef7HMxAfWXx0wIKyv6k30A8uKtt6C/+dCCIkaOdVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJxXxrlHpwX/Eu/ZiLTbL4cMsexhdhsIJLEthRe+9nA=;
 b=g6M+a8hxCRH5/PuLe01eYEHCEvnoctncSTbLNWIwQprnsfWMOP12Y0xtXL1Z9m2wWpsZSD5dB0t2e6bBo/Ct0/aA/sKI+/oaKifxVGDqr6OhvIgWEsB2Uf7SvAO4IBbaKxNoNG+DFtq6OoUBeMd6VFx4kaz96tI3IRMGIHdZGVejLFww0hpJLmFE7HDZ6tXqqrR0Kk75TALgKvHObBdYgy2y5LJR3NPkhwh3AWXPOpP1YLbFhiGSqrBtcC/I7v1g8CX3a1iXSeQ9vTs2DiCneOg26h1hdXmtvntAaGtcyE3lm2gfjkWXFiaL01nwKbJQbf5hRJSBn2Fkao1ZTB6J1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJxXxrlHpwX/Eu/ZiLTbL4cMsexhdhsIJLEthRe+9nA=;
 b=lz7JRPybhoRcrpZAK7Jz8X5SzmJKuOka2tk7l1gCViHiglusFqBpQZSH5ObNaRtmF/jBDWclF84IFcCb1xuxHJIZMRWD4zhvbTmwxXhYJwFalg3Z85HxitfSUKKA1wT8Ve4BXCFjzJYOvPiiftnZrpo1SZ+pryf/1Ai17DQ+JAEGs+EM8RbQCXFVeDO+Q/8FJgpzAJshQOF58AT71bpwqG4oPOGMzmohqcBo3OXu4fPN7sDBLbpuWgxTMhlHplBgyQsCnMXl7lGMNaeCT74ThUorHv91HdIojx/Y4s0sGfwwTOcwbimHg00f/CXZUmZkVQ3j5Fu5fgqYyZxDM3da2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9173.eurprd04.prod.outlook.com (2603:10a6:20b:448::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 30 Sep
 2024 09:13:54 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 09:13:54 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 30 Sep 2024 17:22:25 +0800
Subject: [PATCH v2 2/3] mtd: spi-nor: support vcc-supply regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-spi-v2-2-ed7f6bcbe0df@nxp.com>
References: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
In-Reply-To: <20240930-spi-v2-0-ed7f6bcbe0df@nxp.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727688153; l=996;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=dVCNuxQH9oNdFfF5MUkgWc3vVRweKipeFuo1LvEXrzs=;
 b=bR8UGuXmbJo6ucaUTXB5Ri2jK2TqHJcrvfJ9PkDVOqmld5U412wSFY53kUJtRMMKgp5QG7b6q
 ZtCmBHxRbl5DH/BZKc5Ix8KbdxI1LWSf2q4aAq2Rb9ctQGoPvqMVOCS
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9173:EE_
X-MS-Office365-Filtering-Correlation-Id: f755ef97-398c-4c49-5778-08dce13034fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDIrZWlTU0RYYVphNjVZdE1NRndYNVRUNGR0bWpnRHFMNXNzblo4a283SHVF?=
 =?utf-8?B?ZFlSZ1ZJVkdnMmVRcitrU25GaFNFLzFnTW9ESWNiMEVTam5XblIxbWNYUXlD?=
 =?utf-8?B?VTByc3V6R3d1Q3YzS1BKYUNoUmh2bzVoRk9PVnVTZGN1VWxZTjhkczMydDRj?=
 =?utf-8?B?WnBmbTA3UUt2Uk82cVBqMTI4SERjdjNnTUtJaUk1cldUTGhOT1hDUm9QTDQ2?=
 =?utf-8?B?QkhaWWYrMTZTbkNEN2ZGTFJIMktHQkFBRUdFWVRrSy80SnpvRVUxcGM0di9E?=
 =?utf-8?B?cjl4bFRPSDlldXVrUm1Qd09VVGdFbnBabUlYdEg1bVB5bW8yb29IUU44MWI3?=
 =?utf-8?B?R3Y3NmNQNDVGSVZKdEoxL3ptRCszQ3lBTUtqZVd0UzQ2N2trV1BaQXhORVVu?=
 =?utf-8?B?ZHoyTzdDRGFaV2NPU2xHeXZlelRQZFpNRHRtZmdkcjV5bXdZQTFtNXF0b0Qz?=
 =?utf-8?B?SEdEeGkrNUVPU3BNb2hNbm53cGtKdnVMWEZDUzNrWXorRmpUODFId2ZwQjJN?=
 =?utf-8?B?NzBYb3JmdElJNERsYlZQQXJsQmJndnpnT0R3cUhYK3FLaURrNElyRU03eGhI?=
 =?utf-8?B?THJqUk1OcHp6WTBVdjdPV01wVStXVDRrWVU0TnhpczYwNU1wVGVoRCtVbmdG?=
 =?utf-8?B?MXhJZUU2S1llczJZTTA1alRWajlHKzBKbkdHdWtUbFlsSFZ3cFRhNEN1V1Z4?=
 =?utf-8?B?RXZCNFZ5ZGRWUVk5N29jblJyNXdCeHF4R09hb1lGK2tkZ250RTVIT3BRT0hD?=
 =?utf-8?B?QUtNc0Y3ZkhCd3dIeStlb0JTdGZHT25KUlcxRUM0VUtMY0Y4N3dSMkd6cE1D?=
 =?utf-8?B?alhtdk5STkNqVGwwVHI0S0xSU3lxOFZVUmVyNGZSVWZTNEY2WWsxaG5aRFpo?=
 =?utf-8?B?bnBpcXZhdTZjcHhnckY4UlFmSy9tR2JnYk5VMnNuWE9tc0VBQkUwbytmNTU4?=
 =?utf-8?B?UkxHSm5KK3hlUnNrdHR5aXNqQlp3djByb2ZzTHIrbW5GaklpTm1sT1RMK2Rp?=
 =?utf-8?B?Z2d1bXJDZm13WVFzWUttY0syLyt5K2E1V3RYRHJsT21lTjRRZFRmVENmTzU0?=
 =?utf-8?B?MjgrZ01zSEdFZGxXL0pmN3Vma0QwSG8zd2lRL1plMXhsa29sRDI2WEZtQ1Zm?=
 =?utf-8?B?RzNYb1YyYm5aaWpaZ3FPenVyQUFqUHR2b3dLaUNkL3Mrcmt6bGhKVVVVSFhF?=
 =?utf-8?B?cW5PZHh5bjdZNU85N2N5SU4xQ1NlMStCbkNqdlRjMWZrNkxxbjBFY1JRSm5G?=
 =?utf-8?B?VEF5VjgrTlh1T1V0OVJjV3lKNEtoaHRkejlETEl2MWo1RzZNZ1pnaVI3dFFM?=
 =?utf-8?B?UnZhT0lVV2JEVUw5dWRHZE8yTThNNThMU0V3S1Q2ZEMxai9rQWZ6NWh0M0pE?=
 =?utf-8?B?a3hKNUU5Z3F6VkdDeERIV1BTUXJzOE9TS0pmMVVmQWVGclpGeGVDTmZabDNT?=
 =?utf-8?B?L1JtMDU1Q3FqVnNqOCthWVlicmJsWUV4b2NLMHIvc1dmL1M0SVUyVEJhcFpV?=
 =?utf-8?B?OHVGVnhKWUFyOU9DQTNQdjJDS0VPVUVqd2dlUTlWb2JxakJ2U2t4MCtXQ0lQ?=
 =?utf-8?B?d082QjZHbWZTMGJpQ3NySXpaQmpFZWRWc0QzV0p1eGlnYk56aDUrV0o5TUZ4?=
 =?utf-8?B?K2Q3Mi9tRkpjTTRkTW8rMDdjSk1SZzFGMDZYVDREVkRzY282MlhPd1hQN3p6?=
 =?utf-8?B?TlJ6VGNoTENvWmovSjFFSWhmT1BQbzdaL2xSR0Q2aUZIc3l0eFpyL0Q0bVA5?=
 =?utf-8?B?WFBNc2VlZG9ZcWNWM0xqSVp6QS81SzRzZ1NuTDNzRG5GVFFrdENNd1JIWVRD?=
 =?utf-8?B?TFdTajMrdDY0cHhlS09WTWc3SDdtSVZQYmlyenR3Z3NBMUd1a0Z3SUM4QWZa?=
 =?utf-8?B?SGU2b255SXhaR0JXOHNjc2xMdE02S0lXSTE5Mk9HempFVmt3Vyt5YmN3TEVt?=
 =?utf-8?Q?SiaxHQRjohA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVYzV1kzeFhqRzkzNGZzWGxBcC84WVp5TEEzczlCbVNyM1dVdFFOTEJMSkhK?=
 =?utf-8?B?dTAvVGVVTTRxOVh4MFVmanBERWlReUw5bGp4NGdRNzJEeVloT1JCMUtYNW1P?=
 =?utf-8?B?Q0NLYnVhaHFjVG5DQzBaVjh4blN0bWkxWnRzQmJjdUNsRDltcm91S1ZXY1Zn?=
 =?utf-8?B?SmxlQVR3VzJDNndsVFFSNHdIQktRd1hadnZsWFZlSDd2cVFtUVdTRzFHNDk5?=
 =?utf-8?B?MTNFUXBjWUQ2VUlrNWZCSUlzcjJRcWdLck9JVk5GRlkvUnk3bmdVSzMyNkpF?=
 =?utf-8?B?UDd0TFBKZ0lRWVdSekEzOWpUZEVOVVBKQjNpVVVoUm9HWVAwL0hDZmlTdHRD?=
 =?utf-8?B?Qy8wSE5wSExNaWY0dlVST2dGaCtJU1VMQmVuQ1UrelJkUjZDWEtjQWxKOXF2?=
 =?utf-8?B?aXBYRUZUVysyS0ZmRUxxenlwOVRncEdNSXRVY0F4c0xrL1RWcy9sOWwrajZt?=
 =?utf-8?B?ekJBOFMwbzcrT052N0pDODNjcE9tZnV0MVBrcnhLTC8rOWhPdGtpUy81c2VZ?=
 =?utf-8?B?RVkyVVFRS1ZPMzc2WFVLZlM4RWZQK1hqdmJnQXBNS3hxUmMzbE91WjBBak1B?=
 =?utf-8?B?RWJoQkZrVDJOYnVGTEl3Y25nQzhQR1lhSXNHeEV1akMyQXU1Ny8zRHFURTFI?=
 =?utf-8?B?cDhSNDdvRWlNK05paG5nanZybXZWZmdMYzBZQ2F3UGNDNnVvMnJkUXVmN1B5?=
 =?utf-8?B?RUgrVlFMYTE4alc5S3F4aENtRHJnTE9TTVpRaGZrVVFmb045UW5aaDhxSkwz?=
 =?utf-8?B?WEZwZG5ZMFJPTkIvaC9VR0lKd3JZQjZ0VlUzVVh3UjQvTE1TVDBodUF3ek9Q?=
 =?utf-8?B?b0FUbjRBRU83NnRNSERSbEszQ3pOcmJkeXVVQXd0SWRzZXdrWDN1OWlMcC9x?=
 =?utf-8?B?Ry9XbzVIeVMxZmhHdHJQODlHQmQ3dTdqWTZmMlFYd0MwTDZYMytBMkhWSTFa?=
 =?utf-8?B?UXYzSTM3ZUNQYjBoVUE5UnFtSEpnZ2pYMmVkY2NyQXJaRXh2T2JjcHlVcEQw?=
 =?utf-8?B?N01NWGNLeitFZkxOaFFOazk5enpkUDJBSS8weFVBWW5kVnpCemlIWGtWK0ta?=
 =?utf-8?B?aW5iSmZwbTlINnUvS29Vc2xxd0lYdThmVzBBOTFCU3NXNHNNNy9acy9UMnh5?=
 =?utf-8?B?TlZlMWJacEcwTG14eGFaNUhYMTJlY0ZCZlNQcTk2V0ZIMmxPUWQyZGpKa1pz?=
 =?utf-8?B?Zk5JMDltVUFBUm8rbWNjVFlJZFkra3dSYW1Gemszb2VpbHlYb0RRWDd5Y1A1?=
 =?utf-8?B?d2Y4dUVQN0RxeklsRDY4dGJVVGUyajRsdmtNeTRsejF5djNUNXhPZkxmSzdj?=
 =?utf-8?B?RGlyS2s3cDFlYTY4MVZsV0hXYk4zd1FUa0NvWUZhZ3phV3VRNHNXY3VJT0xX?=
 =?utf-8?B?VnRlZFRXaE9sYlBNVWVxemRPcmFHSDhkbmpidHZlZ2dUTEozdEV1Rzc2ODVv?=
 =?utf-8?B?c294aEM1MFNUQkdEYlNpMkMxcUU1U0VzTWtOUFZ1aWRtY0ZobHhvT0U0MmpI?=
 =?utf-8?B?cjNDalkxQjB3UjVua3hub0V2Y0kyRlNjWDhLL25DT3pLcERDaThjY2ZGNy8x?=
 =?utf-8?B?RDBveHRrOC9qSW40N3lLU1VjdnVOLzZGdHdiMzVIejBxWTZXc05Kc0lPQ3Bp?=
 =?utf-8?B?NCs0OFhtNGVtNlErS2tHYlYwaVlKcjFqa21RRWtyTC82QUQ1clZOL0RnbHhv?=
 =?utf-8?B?WlFldkZnOU1HQTB1clpKRExhWk4vNy9LVkxTR2N6WUh4ZVBPQXZrSlFaaGEv?=
 =?utf-8?B?NUZRYlpMWmlZaW0wQys1TFRnOC9sMVNGWGY2ZFlkQWFlUzEyQ0J6c0Y3Z2ll?=
 =?utf-8?B?OWxpOHh5cEQvT0Fkc3NyRk9qaGw3ZmVYTDhjYnB6bnFKUEtGUDhnd0ptWGZv?=
 =?utf-8?B?Snc4TXN6SlV6TVEwMW55SVcrcXZINmovL1lUbEdOYXJxNFhjR3kwNEJ6dHdT?=
 =?utf-8?B?dVRMWlpFdnBuZjNYSXhoaXV5bFFTUmMzWm5oV2RFdG9FQ296Z3U2Z2pRbDJ3?=
 =?utf-8?B?Z1ZZN2l5T0xzbU1xckorNndFTXNuR2MxRHFSMTFtUGM5Sjh3Wm1ic1h1dzFC?=
 =?utf-8?B?TEVyQ2M3dFNGZGs3VVIvNWpSdVdmVDlxdm5SRTU2ckN5OGtPUHE1TzJxQUh0?=
 =?utf-8?Q?+ynJjKBtl4Y6ugCOkRo5TLSUR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f755ef97-398c-4c49-5778-08dce13034fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 09:13:54.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxK/NdDT5iH+5A1ApJGD4Rm/dmIuVSayVJVIgbfj4k7ZpylebPDk1mK3JzQkL7UtadW+fCby0/nT1ZIydHe97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9173

From: Peng Fan <peng.fan@nxp.com>

SPI NOR flashes needs power supply to work properly. The power supply
maybe software controllable per board design. So add the support
for an vcc-supply regulator.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mtd/spi-nor/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9d6e85bf227b..5249c8b13916 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/spi-nor.h>
 #include <linux/mutex.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -3462,6 +3463,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	if (!nor->bouncebuf)
 		return -ENOMEM;
 
+	ret = devm_regulator_get_enable(dev, "vcc");
+	if (ret)
+		return ret;
+
 	ret = spi_nor_hw_reset(nor);
 	if (ret)
 		return ret;

-- 
2.37.1


