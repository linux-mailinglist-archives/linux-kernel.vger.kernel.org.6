Return-Path: <linux-kernel+bounces-284104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BFE94FCED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689CC1F22789
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E9C176FA4;
	Tue, 13 Aug 2024 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dofJFpjO"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343DD16C684;
	Tue, 13 Aug 2024 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523776; cv=fail; b=pL1mn9jLkP4Frm8E6WJFUMAuj3Su/6AaNAKx4no2IbKTRcV0+0O5cICoMzoTKK2RJh5FFhr0Dju0z+xNhKYYOyMG4FRaNJxqn3RSCM5P1FYIDXdH2bNd/iCARELCyIueJTU0YNHfFyLmeOeQqGh843ngpn1agBRwWVRinK1V/bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523776; c=relaxed/simple;
	bh=jqnhcURtNJOiovOsgPSG7rYNnFEASYVoYjpwPc0VQzQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JUT/szExAbRqYQ974kqsni2lQ5yh0e/1KCA4oAopiBoj1KTA4e7nfRIUkvc6BZhIGgPUNGaMCB9fzcAJivv2RmDKAZN+NDOefDq233WaI0bauAoin3NGEX07vEBmdpqWIfyxDuSwxJOZgTr8AvuV8xwy19Zh+0/pKy9hzXvNjfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dofJFpjO; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmVy9AgFRp45FbC+bS1uwoCuE/8PCZnVG9P3AihL/FbZ/0vA0k4zdDReunnd7zBk/+osmqiIK0LjEEZzM5YSqbDKbEH/gpqLc4VbeHLdQJ1lqh5H0rq3Z2TL0Tq7YOmq5fxvKDyXaTK6e972CbrnGgUueN5OQDda2G1yhN/A0fqp3ph4nmmi00C+XqbcaL0WHVRElt1J8CWc/IXzCmxnMeVVvJ0WFuXCDrNjUpBv7qaIa8wY1LAYW7sr/5V3cilVLLl5Fnpz1NXNvau5BCfeCE01159oDtx34BHwjfXA7kc/erlfFS9a/PekM5le+YQnEjPR28K+sjKoSSiLD4whBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcKd1Hjk23ZmfaDJN1ndkTadZZaMnLMEcP5mF5sDmeM=;
 b=dq0iR0Slvzp/xdsh1TqX95Myf+Ibumfg89Of8GJDU2t9EUB759hNlTqoe7lCkFvO4aFia+xELT8dINyI24x79ROhqoqC89aBMwcFQMXZCfwa5xr8k3YZaTR/t6slRkjfgxk13oaH7MKXSdS5HizqM3wz3io6IAsKL4V5z3OmfORZ5vYRDH/sxdZMVqht5JzOKMXGOsKLb8ggB2iDxMNqXr4bcI746IUosU5bELxfALZBVaBhqadxRZIR9Fq+qIb0mw5qBk7KhBByGIlpg7RzmumNlpHm819BuT/MlqqdULgrCPlObiIL75H3wW2NniMPqK2xkuIgW7l4oKYVrBb0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcKd1Hjk23ZmfaDJN1ndkTadZZaMnLMEcP5mF5sDmeM=;
 b=dofJFpjO9a6DuowERXiBBwSJkfiSw0cWv1MXNvlxosPVEExdEu1ZRtWGXRNgcl+UuSXBogq/KSLoPTzxvPVHxlksoF8Ll5kGb69U97lHB0WTaQkGnBDE0sYkcIsaDB2gG5MYsT9OjMnaaSTo/8FNZnC9sfa8A8m8kQmjmKCulzepiFzJ0nIZ8AgBBp4bIGf3jcBNqEpP40BNsimxfkmGcP9pDZ88Omm5Dp9ZgwGnJMhVlwgCQsYuxQIPF7wd4Ns2H8v3yN/pWNkqQSiP6lKGj5t6JodK/vgoeCtbc4fZGBwSt8x83KSYjqaDZlLsQiM8MrqK0KEwo1tm6QmUWe7Khw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 04:36:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 04:36:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 00:35:12 -0400
Subject: [PATCH 17/17] arm64: dts: imx8mm-beacon-kit: reorder reg-names cec
 and edid of hdmi@3d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-imx_warning-v1-17-3494426aea09@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723523705; l=2050;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jqnhcURtNJOiovOsgPSG7rYNnFEASYVoYjpwPc0VQzQ=;
 b=lWtHUL+CDCuOq8CvmU2X5a5b2NjEwfe7I0AIMKgdhaQJWolfPMPZSVEz0bPBvBV3FtHcoBcOz
 JTmBlRTdlUFA3N1U1Qzp0HjMUuQF4Yn80l+/02d7i7lIML5sqhYWvQR
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 276d5b23-e138-4a9b-61b9-08dcbb51762f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MkdaUDlYdUd3ME1oZVRaWlFhWXV3VzZFUzdTZVI4NWw0TlBTRUNCQkN6ZVMy?=
 =?utf-8?B?WE1sQnNwZU5kMnIvRDIzYi9UTGJhNzlCV0RPcUVOOVE2bktCT1ZzZnZnaFZk?=
 =?utf-8?B?WDR2Z2J6bW8xdzJEZnB4b0todUJOZWltbS9PdGNHUnpMMnU1VlBDQ1YvU0VE?=
 =?utf-8?B?Z0FKUlRvU3JrTm80dXdyWERlYVQzQ2R3Qkhta3A2YU9WRFAzTW1ZdFlzakJO?=
 =?utf-8?B?UVZqcE9TT0xlcGwxVjBUSlhnWktURjVqV1k5WTBzSzE0dFBNRTcvRkRKeHRq?=
 =?utf-8?B?VzYvcXhIWkUvNDlvSHdiYkZlaFhlcjVlY29aUndNc29xZmVabDE4bEV3SGlQ?=
 =?utf-8?B?MDlaN2xPWCtuUXd4bVM0Y2xnTkZMZUNIMFpuSW9UcHVEeWgwbVNVRzdQMkhR?=
 =?utf-8?B?MHBDZzJVcmxXY0F5WVBkWjM3TmhJRU5DczNkeng4eVVNNXN0R25tdnUyeTgx?=
 =?utf-8?B?QU1YNC9LcXZ5czVFNC9kMkxlYy9lMzBiWUNsaFdpRG1Gc1BLQW5GRFpnQ05V?=
 =?utf-8?B?RkdxQUJDWk1vWjFtWHRMWHBwSVZQME1Dd1NYUkxObnJza2JHSlBJUllGU05v?=
 =?utf-8?B?YmQycTlVbHF0aitMdmFUQzVHQjlNeUR1QkxreHBoNTNqNmg0d3h2STl0WEh2?=
 =?utf-8?B?R2VBKytSQmhYOXQ5cFJxR0VmdWNYRnQvSGVkVHVEZkxaR1RWMWpGTnByVkFE?=
 =?utf-8?B?ek9JY1JiMG1aUVZScWpQUzIyZzl0c0FSdjNWeHA4cWhUajNmdmh4Q3lEWDBM?=
 =?utf-8?B?YytER0RBSUFFOURqTm0xTmNUVkRBeEhMK0V4ZEpvVUhBNVB2cUtML3NwSG9w?=
 =?utf-8?B?TmR1WTlhSVRCcWg5c0tUTUIwWG13VjBBQmFaMklYN1ZDbjVoNkdxNHNrN0NB?=
 =?utf-8?B?UVUvdURuQjNpcW8ySDFwTENVbFZEOVJwNENnVU1BdkpJT3ZJVTdGNkhyYmJn?=
 =?utf-8?B?MDhCUzZaVDRTOHdzeERSUFo0TmtyeGxEK1A0MEMxcUdGNEJtVTUzR3NDM0J5?=
 =?utf-8?B?bkFhUEk0UE1ZcklqL3JYbWhVdHQ3WjdtRkJZRk9CR2VZa2RuVFRSbE1EaG0y?=
 =?utf-8?B?Q0hvZDJubTRPeXkvQmZ6TmlVMzg3VGV6TVhmcHp2dXkzQWhEcEx3ZWRiUVJ6?=
 =?utf-8?B?MkJvdVk5VkZ1WjF3TnlFWUtLUS9LcTZ0Z050WHBvaUZSQkE4R3FsSjBNWWlq?=
 =?utf-8?B?dENTM0h1TWpSSTNOdVB1dFdhN3N6NFJXdG1aUXVINWl6dXQySTJNQ1g2TEN2?=
 =?utf-8?B?aHZHTllzSURMYzVwWlpGQ1RDOUR1MFlyTjNnbGtDaHVSc2pxa0l2Z1U3SURH?=
 =?utf-8?B?VnlkVGQ1UnM4Z1lrcG1QdkxJd1VTSHFFZXFMSnFrYUdVazhOQnV3b1FQY2Zz?=
 =?utf-8?B?RVh5bFZXdFF0dXJjWExZa3dRazdYY01Pd1RuNjlTSkRQMFRGSE9mOGZIRVJC?=
 =?utf-8?B?TXp4OW9oS2l5ODZoNUhvYzVzYTNUL0pDRnhseE13ajN2aGpnRVYvY200clJD?=
 =?utf-8?B?VkRGdW82dEgzTmtDd1YvS0R0TEljWTk2TGs0UXZ1SkgwcGs1MVRqVElWRmZt?=
 =?utf-8?B?TmpmOVljanoyeU11SjFZemViWTMzSkVvSWp2bnFnZzBTK0crQy9uVXh2S2ZC?=
 =?utf-8?B?V056Nm5sUThQaXIrL3l0LzRsVTc0ZGtNekN2YnowWFdrMDVCdUtpeDlpUGtH?=
 =?utf-8?B?L25Rb29kNDlaNTZybk1FY05zK202VG5MdFp4VDhSUXhVa2ZBU2lFd0VCM3gr?=
 =?utf-8?B?RG1rN29pKzdHdkQrWSttYVovbGlUN1hhalpZUDZ1MmV5MXRnL0RFdm1FakZG?=
 =?utf-8?Q?3oHNr5FUJWB+/O2m1Iz73GdRXID7O1xje5T0Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmppRmIvSks4WDJHRm1odGVEOURaK2xaZHFsOXUvd1VpckNHSjhmZnFDU0R3?=
 =?utf-8?B?N0VVQ3RWc0p3bE1kV05ycmtVV0JvTy9kWDdLbGUxUldUZS8vSHZXV1NVRkQw?=
 =?utf-8?B?eHdIbFBERCtZbzg5WUJUaURkL3Y3NjhKUEgxTU9wc1ZwUHV6anVSanN2WW0x?=
 =?utf-8?B?bStaN05DcTVtYjM2N1ZMWFRGRDU0blF2VVZRdDF2S3ZCbGpxK0ppV05LSjVR?=
 =?utf-8?B?OUh5V01IcVRaZm81SWpoUHU2N3V5M2FxMGZ3bU1HelR1Rkl1a05nSVkrTGZh?=
 =?utf-8?B?eWt1R1RFUTgwM2YrYWFTbkp4RkJnb2ZNUVNRVmROMnFBb1JnRE9zRWlEZU45?=
 =?utf-8?B?RmR6ZWZpb3E1eG9qbE1rWWxrYUxjWFAyWW9oaW01a1NVMjJSQ21GZG5iQkRz?=
 =?utf-8?B?bEVzRHlETjk2Zk51ZEplK2RnVHY0bzBCaTNyMkc0eUI1bk01UGx4UXBOSERR?=
 =?utf-8?B?czNaeFg5dkJ1MjQvYk1VbzVhRDA3ZkJPU1R5WEcxRThwOUtuWnNBQktGUTEv?=
 =?utf-8?B?OHBPNjVrcDdYcWxxSk13UlkybFB2QU9KV3E3V2dyaUZ1VGVBQ3V1VFBWRzV0?=
 =?utf-8?B?TXhGQVhUVXJmZk9Qa2hYL1ZuMXdta1I3QytRM2NidlFxRjZ4VUcyckdNdjNo?=
 =?utf-8?B?RXlwSkFLanExaURTSTRHVVBFUi8rcVBoZmZxRjJlclljMlBYZExHNXBKSUpJ?=
 =?utf-8?B?QTBsOFRyVVJLMzJWTjczaUhSOEJmakV2aGNVMWNhYjZ6TXNSTmdSVUpybmhi?=
 =?utf-8?B?S3JKOTlCTG9tZjBuQVVnNVlLaC9GQTJqZGIxUmVMZElNQjU0eUE1dFFHLzd6?=
 =?utf-8?B?Q2ZQNTFjZ2p5bW9lSGZYeis5Q2dEYlozVHdnRFlhTVdtbkZoU0ltVFU0Z0hi?=
 =?utf-8?B?WnZUUXdtOGJEcmxuazFvU0F5SUZPeGFQTUJDdG1IbncrS2pkVWpNdVZLdUFL?=
 =?utf-8?B?NHJpa3FYcktGMGYzNDl6Q2l3QmYzcnprMkhYV21KMEllczV3ZHg5Smxnd2Jw?=
 =?utf-8?B?dkZibzlWRjh5ZjBjeTZocW9raFc0d291MnlhWjZBc1RGaU45K1REQlNGNFcr?=
 =?utf-8?B?QzBFMmt2bFhwRjhBQ0lJcmlBcGRXUm9JVWhvUm5PNzcrZEVYWWJJZlBzMWtr?=
 =?utf-8?B?a1pnWnZsWnRMdDZoUjVjT091VnEzck9rTFhiZG9zalMvbFcwdTBGRmM1L1Jp?=
 =?utf-8?B?cjdFSWk4ZHhOajk1VVJ1SlpzLzZNSkNlSU9HZnk2TW9UMGQwZGhKQk9jajlv?=
 =?utf-8?B?TjM4VlRDYTJPMlNFdEJaN2dqVEh3TStTMTdEL0xqQ0lkWm9jaHVmY1Y1TmNy?=
 =?utf-8?B?Vk1pTHIrYnNmZFVRdEpwbzBLWjc5cHhQWFZBSDJpYW1ici9GODMrVHdSTmJV?=
 =?utf-8?B?K2taNkpiK3pmWk9YSForRHBaK2tYalRDTlVhdFNsRzRQU2ZWdHFwRTIxaGJH?=
 =?utf-8?B?RXdLVjJaQk91VUkwSzhVSzEvTEtJbVc0M1lGb2pZdEhWUUg0YkoxYkVpdGEz?=
 =?utf-8?B?ZUorZ0hqRWFuNFkvYmdZTTZPZkdqc0VYY1l6c3RGZTZwdVRZTTJZbVFXNFFJ?=
 =?utf-8?B?RWQ5VmI1SllXaUdEM1hTaStOK1FUcVU5bnVKc2dtazZMaW5zQzdvSk1JQ0g3?=
 =?utf-8?B?ZnZEMjVLREV2V1pKZ3BVdGtUL1J0RHkwb29DcEZwaHc0WjA4RDVlM1hma0pU?=
 =?utf-8?B?dGZBMTRJc00wR01YcUV1ak55Y2loL2hmbnNVd1F5bHV2UlFRNHoyQzdPNnF0?=
 =?utf-8?B?b3VPVXl6NW9tWGVPN1N4dHc0eXM0RFN5YzNZRmw2Q1RhcC94UFZhM2hRUFZt?=
 =?utf-8?B?Z3pTaThMc0YyMGJwaldjdENSMXIrc0dUQUNZZ1V0Nkd6RUplSUJ1QkFncXdq?=
 =?utf-8?B?WmlVeHU3bCtVRE9ZQjUzcEN5eHpVeUhURk9NSlg1c1pUcjUxM29xRWlKUnpu?=
 =?utf-8?B?QnNVaU9ieVRxR2J3SnZVVC9lSklzMEdGbjhySmkxeXBWSmV5QUsyaktPelNu?=
 =?utf-8?B?WTFQSlhDWmNQZ1dVajBwaWVHT1R2VlVQbVNNakFsRFBEVFl6dUlsNGtrdVI1?=
 =?utf-8?B?bnRZY2hDMTc3MnNyR29lajZwdzhGUTdDZElBUUVWQTFka3AvVTBRUDNSd3NP?=
 =?utf-8?Q?Qq5MJM4Qyzad4nnLec/6Zu6fZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276d5b23-e138-4a9b-61b9-08dcbb51762f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 04:36:12.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghF4B/Ei09QZHnKTkxLGuIc3XhWNsudZuQqUf3q6Af//dKj2Vuxjn6unG6J4AG3UzYhyMu06BwFCLTyaPeuZ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066

Change reg-names order to fix below warning:
arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb: hdmi@3d: reg-names:1: 'edid' was expected
        from schema $id: http://devicetree.org/schemas/display/bridge/adi,adv7533.yaml#
arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dtb: hdmi@3d: reg-names:2: 'cec' was expected
        from schema $id: http://devicetree.org/schemas/display/bridge/adi,adv7533.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts | 4 ++--
 arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
index 905c98cb080d2..97ff1ddd63188 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dts
@@ -62,8 +62,8 @@ adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hdmi_bridge>;
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>, <0x3e>, <0x3c>, <0x3f>;
+		reg-names = "main", "edid", "cec", "packet";
 		adi,dsi-lanes = <4>;
 		avdd-supply = <&reg_hdmi>;
 		a2vdd-supply = <&reg_hdmi>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
index bbd80896db964..1df5ceb113879 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-kit.dts
@@ -62,8 +62,8 @@ adv_bridge: hdmi@3d {
 		compatible = "adi,adv7535";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_hdmi_bridge>;
-		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
-		reg-names = "main", "cec", "edid", "packet";
+		reg = <0x3d>, <0x3e>, <0x3c>, <0x3f>;
+		reg-names = "main", "edid", "cec", "packet";
 		adi,dsi-lanes = <4>;
 		avdd-supply = <&reg_hdmi>;
 		a2vdd-supply = <&reg_hdmi>;

-- 
2.34.1


