Return-Path: <linux-kernel+bounces-292578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D43795718F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6907EB29039
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477C6183CC6;
	Mon, 19 Aug 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cBzpnS7K"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D6D186E2E;
	Mon, 19 Aug 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086998; cv=fail; b=ObRDZkvtthiRT+btMRCcZ+rXAh+MNrkilZVfmX92OdZ350GKRoE4Dd7M8nFhK7b0qQPeEi1irwexMeSRKxj6cXOZAVUtHsttZLzVjqFvrxNFN/pMnAp0o72MyQrrX84h/drHKWV4pybJZfAd+BVRc0WQW7JswzUKXycjzMNB9BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086998; c=relaxed/simple;
	bh=PUPXy7pOURsWojytf+kwjMV3QV5rsKqbVIuq7uBP6FU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lrsnN4vKZqHDreZQYcjyxQfXpYGD2xtR+usNxjD2CR7pJWO9l0d1TppzoNhoE40Y8M4r2WcAeTYvqHQgfUnqyGR8yen/XXODfIkvyaMJKnSLRnaGVr4t45SbusONKX7y05x1Nn8DlWJoLsuWxJQ87IVqy5M5eJnj2SG9xfSlk7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cBzpnS7K; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ucy2DSvnsoJsbbF0odCS3kocRwHsh3R/tWso3iheomsW510kvLQBPi5OiT536pDLd/nM9Tqf77ik15GkPqVKXwIkuMIrlvcYs1tyerhwJV/jDF8k65RE4TT+cyfOVjiO3h6BfGYTr1UnjbmhC2dRFscKfn8rqkiR2MmjnzD5q4DEqxwQlxGjiaKW2AYZOlMUm+TZj8y7ZSBjiPS6mnxhFojcBMg7t/568d3IkRapAbmFcdOe1ukjPAFs5ZtLE60VmzHIckIwNi4BDvzwBOjAGT0N6JHP90CBEkIt9+FWONuEmWci/4OJev9ELQH6a7g71EmDf3SOhJlhvNZzqna5qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nG61Mykrvk1tADiF/GuPkzTQ3A+xSMw6GkkIwsvyo0=;
 b=nXs/pofg+RL8YfUJGgch1x6Hh7fj6ZxjDunmvUWnVBPDgvupkCZL6//xtR68BJIdqWoYKFLiRgpltGcfx/13bEMlndJrLht82kSPPimIhQ/J/kL2M3MqMlKs1x5280ec2Ailjsf7YDYosqzrNGwbesuwZMlF5iZhHGjyqEIcIJUwyQMCQULUf/PE0ObmioiX4OAl0zvE9MAZ9b4Plr7Hf0+i/8hDVsIaPhDf6SZllRjbtYIJ0xQvZ2uzsnB4NaZYK5fMat+U71340iiecon76MeMn5SUN+Zp0ulTsqBSOE7DKbZtnZPn7silUY+8ifEI6l1dcgJgxdRcCIDzam2Atw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nG61Mykrvk1tADiF/GuPkzTQ3A+xSMw6GkkIwsvyo0=;
 b=cBzpnS7KzOdCdFNCGl3VQlb1pXZg0gTPD089/VQxetSFMgEoyIq3/T+MAOgqeFgjV8bfZpuaWXCbASfTYvJp8N1/h3mNW0sEtw9isnTxKqWQ8WMhsBHpIEaf3vR5I7a265Hfzm5gR2ByqPtVKumQ2Xw9fSjsQ+2FZvxlv9beSChuEqDtUnwhrjUVpkWAhitUzS3z+BXQwXVaOXwaUeo8lxGtvwTgd5/X/Ebj014YPV8OSzZFt4OPyuyAgCAejmPiyp4FPqRC2L2W/X/OK5nwdc0VGvHgXdVpqNoQhlTa9XwD1S7T3lfkshactV9iOGLEWdouY8jZxm/tKLiqgk2Wuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8761.eurprd04.prod.outlook.com (2603:10a6:20b:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 17:03:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 17:03:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 13:01:11 -0400
Subject: [PATCH v2 02/12] arm64: dts: fsl-ls1043a: move "fsl,ls1043a-qdma"
 ahead "fsl,ls1021a-qdma"
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-imx_warning-v2-2-4c428bd11160@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724086982; l=1102;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=PUPXy7pOURsWojytf+kwjMV3QV5rsKqbVIuq7uBP6FU=;
 b=NqtoUj0l5WqtXgFp45pfnEQaA3K0347NC0odBBgDMWdMFCGVhtvu4jI+oADgirXbVXwCaBN/s
 q2qcI70CxQ2AA1GZi1FIt3j1Y+X18LbapBDi0F+z4Kx/h7Y+rDuxcWk
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
X-MS-Office365-Filtering-Correlation-Id: e39d94d4-b147-406d-5e56-08dcc070cfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cS95b0V5R0FsakhiaFZHUXFJSTAvVFU1OEI3bjFMMzZQUWVyTlpuUG8yMjVq?=
 =?utf-8?B?VlFoUWs1b3pzYTd2WXA5blhzcGVXZGNSbEg0US91MnlWcTZIYnNidzhnYzA3?=
 =?utf-8?B?TjhWSWppOURWVDZXRVZEOHBLMTRSTVphWFZZK3dWMy9MaUFDS2RJc0Vna2sz?=
 =?utf-8?B?cklybXZQL2F5OTFPeVJMMFk5SkRYOWdFSjdFUmxkMXJrMUFwV1o3WEZ5aFJi?=
 =?utf-8?B?NEMwbWF3L2VuYTNHVzFrUE1pUSs0a3JMcGdhTFk4Y1Bnby9NVno4OGg2VDcr?=
 =?utf-8?B?NDJWa1U0eGx2T0hVeGF2UkVYQkxNNVNpYmZ0aGxIQld3TjRVREFLZDMxbi9D?=
 =?utf-8?B?NHFmYUpVOVRIYTEvWWZxU0tiR3MvdnM0QjJidG1pZWoxV0x0YSt4SnJNaExD?=
 =?utf-8?B?RE81Z25iOWdtaGQ3dGkrTzFtc2Faa2d5dGV6QnJRU2o4TStFanJaTm5jSEwx?=
 =?utf-8?B?SGZTRlN0UEFtWFk5Yjc3Tmk0Szc1Nk5UNW5nWHdmbXhVU1F0cUVIZlh4dHBF?=
 =?utf-8?B?NnFnWHdjaS9adWd4WE9OTDNXVVJOYXFMcm5pZisrQXc5KzVPcnVWTHp2WDFJ?=
 =?utf-8?B?d3JwMjZRQkdNYzlTcGJmY3QySUFjUWJGdE1xajNjMXNtOXJNZUJlK3Y1REpo?=
 =?utf-8?B?Q3oxQkpxejVOdUVteTJJbzAwQVJGRHhOU0t6QWpTZ2R1UWpRVUgyT3ByMWNC?=
 =?utf-8?B?QlJkMkRmbmlVNlpMVUR0WGhWWU5Dbks1cHZZWFlFNVlQMkFXekxITS9TdWJB?=
 =?utf-8?B?ekpWdzNtcm9uY2w3TG1vd3lGNFdGNXBoNDhrdDJ0UjZvYlZaMXVrb2ZCOGU2?=
 =?utf-8?B?UTFDYlI1aWxOME5wSW5WUnBmb2FPR2RYTFdJTFRHdjFGbFVkcmk3NHlYa0V1?=
 =?utf-8?B?OW52eXhiT2I2ZXE5aFdicXE1MVAzWFk0UnZtcGdnNTRITzdrK3BvUzA4OUI3?=
 =?utf-8?B?ZVRvWjFWOVhveXhzNkdOZVlDeHRhVU8rMHA3R2lkeSt2UHpTTVVBT2tPOTdJ?=
 =?utf-8?B?ejhsaTdBTHVXbElFMmIxM0hSUHF3MkxoWTNhVU5MSnhxbGpUZWdlVGVBR3hB?=
 =?utf-8?B?amMyaFlabXR4TStiL0ttM3ZqRERZcm5KaGFYc0kvTnRlQjRUR1Z0WnFJT2lO?=
 =?utf-8?B?VEdRS0FWRXNGYVJxcFZsZHpnUVllM2pwVnhWNVdTMmd3dG5tc1VWV25OSFhP?=
 =?utf-8?B?ajh2a0c1YzMvTDI0Q3JkRlhWNG5iT3Nwa3EwMFJlczFFeFVTaENyeVp1cDUw?=
 =?utf-8?B?cGxiNE9OZDAxZWpTbzhRZlNYZ0QyWG05YVdHdGRxazl6K09wbU82N1kyYlpp?=
 =?utf-8?B?M082bXBkNktxMHNKWUFJMGNGVXJibFVnL3RhRC8rWUpkZ1cvTjRLUUExSTkw?=
 =?utf-8?B?Ky84N1FSQ3JvWTlpYk1qZ1ByNndva0RVNVloWWIyZS9TczRmZkVQM3h5RWIv?=
 =?utf-8?B?TmNWd1JYOEhySVcrN3VERCtxREFPZnFwbU5QMU85YXVFdFRJc3lwWmNjV2s3?=
 =?utf-8?B?dURvUHNTRjhsSi9zT1RyVytsWUFDMVBubS9PVGoyV082akdzZHVIOWQyRHN6?=
 =?utf-8?B?TkdsUmlmTjUxZWJLaDVRa3dXZktadTFHc1U0ZVpHSFpsVHg4cjlyM3lCKzln?=
 =?utf-8?B?TXRidGk3VlFJaDd0cWVmUjFBRzV1eEZpQmMwRklsNWk3M3BYamt6emxVZFh1?=
 =?utf-8?B?Zm5KNlE0VEVzZWdhU1JSaVJ5K1E4c29rL3hYMXpKQ25XZHpISU44UldaRHJk?=
 =?utf-8?B?dEN4NTkwTEJ6QWJvQm8xa3VMdmdQSEhuNHJQTkRPNFY2VVdJdEs3aExEQzkz?=
 =?utf-8?B?UFVJVklnMWVBMnl1aFpQRlBaY0NlMWNVcGI3WjJoakhCejFEVEZtOGExcnp5?=
 =?utf-8?B?WURyZzlDbDMxRVorbHlzS1JMSUVCVjRBM3NxSThmOTNMbUE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmZuQlkxMnFzQnpHU2crbTU5d2hSdFcvenNMdkxwL1E5S254MVVzR3B5WC9w?=
 =?utf-8?B?YUY0UWVSd0xNVU8xeCs1NXBRbk5nZVpNemw4RFVzbVdld1R0Rjl6cHFtVEZQ?=
 =?utf-8?B?dTRxL0xqaDR2a3JiZklrMTc1L2tXTHlKN3hKQ1g3R0p4eFlIaDlacGZtb0tE?=
 =?utf-8?B?UTdoM0YzaXU1alpZeUZxYzBONmpIdEdjVkZxbmJDKzlzY1V6c1E4T09HYTFP?=
 =?utf-8?B?a0YxendlbXMzeEtVaVhlcTVaUDdFdDVTUzVLMHk2UEt2c0FFTXZVc015V2RE?=
 =?utf-8?B?cW95VVR2NkowVWFpSXBEMkdWY2xhS04yb29XcnAyS0NDSWpMbHJnbytScGh4?=
 =?utf-8?B?Z0o5TjdGWGhqRVMwdGE5dlBJbGhyRjBCZXJXL1EveUVXR2JNTUg3dnJmUkwy?=
 =?utf-8?B?NWYwZmc1YWF3VTdPbHZNaUx2YWgvN01aWm8yWjV5SFgrZWs0VUVSZy81a2RJ?=
 =?utf-8?B?Z2tQTm5vRDdrZ0l5ejM4aU05eWg3Z21hQjFvelEzZW5ySFZiZGdBN1NLUzlL?=
 =?utf-8?B?VGJPdU5zQzREUDlEYXF0MmdrSnZoVm1RV01ZOUg2ZmIzUVBkMlltd21LMlh2?=
 =?utf-8?B?eXdhUEhTdnorZWhGWEV0OThocDltWEdSRmhmWnU4dXA2MlBFZkNpWEZtMWpq?=
 =?utf-8?B?WXNmZzRtQ1NJaldSc3ZBM1FDU0g0dE5YTEJ1dmRrS0U1eFVobzIzZWFHaXhz?=
 =?utf-8?B?VlcxV3hURmpNM2Z4RWJTTUxkY0F6UXlhRFZjaFB4aDdUYUZEeE1TaWFYRXRY?=
 =?utf-8?B?UnVjU3NHRXNBa2k0cnN5cExNVm1Mc2hrV29wVWdhYWkvZTN1K0hVZE5sQ0lH?=
 =?utf-8?B?bGp5emJ1dmxTeFJ5UU5XNnNnMnNxZ0ZmRHlaL1o3dHRLTndWRVpZbU4wRTBw?=
 =?utf-8?B?TG40KzBzOGlCdHBQclR6YnBaVFY2c3QxOEpnOW9wS2V1b2gybS9BYUtnRllB?=
 =?utf-8?B?aTJMS0FXYThqck95a1E5SXZKUlk0REdJaTZQdUsxYlpscmZOSjFRZnh3SWp5?=
 =?utf-8?B?eE42WHdvYUkwbklQNEhPMzBsUHJSSGVRdi9BLzFTcTM2d2FsdzhuOTJQYm5G?=
 =?utf-8?B?eEdybkhNS21tY2QxaUFFYkEycVpjUnBMODlMdlYxTHJtcHBNUjJwNXQrM2lk?=
 =?utf-8?B?MTlCK1lZRW9tTlQxSVlLMWlhMG1keFVoaC80ZnNOZXk3eU0wT1dIN2R3Rm5J?=
 =?utf-8?B?YXorSEMrUWdkTnRSMUdZS2ZxbHRUVGtPVGFsdjFoYzhMQ2M2dlNRSmNoaW82?=
 =?utf-8?B?cFJUNzhsb1MyWmQ0V0Q0UmpjQW5kU1M4UnlJR3ZkemZVZXFveUQ0aEVqbUI1?=
 =?utf-8?B?MDJPWTNKYThrRVNicXBwY3BTaUNWSzJVUDdMUlFuQ2lyd0hUUml3cEZxNnRZ?=
 =?utf-8?B?RVo5ak5qZXpqT2J4VUFBSHdFdlNQV0ZzY0pFVGY4VFUzUkdTWGVKdzE3MURO?=
 =?utf-8?B?eHNMd1JpaTQ2eWFLVmlDdWp3ZlVxR1crOTNjUUpVenJYYzAyL2ZYMkI4T3R3?=
 =?utf-8?B?aHgvbDMvTlNMNUc5TTZ0b0NUQktjYzNFVFFtMzZFNnJMRmVybjlSOWo5MDNP?=
 =?utf-8?B?Qk5FMkxTbjUzaXZZRkdDUUluei9ISWZwWTVlTDFUQUFqdE1lMHlVUWJsWlJp?=
 =?utf-8?B?T0ZrZHI1cDFLSnprazQrUHNqb2orcDhLTFV3ZUdnd3JiWnh5U2dlV3NWSER3?=
 =?utf-8?B?M2Q3NjZSc2UxMzRua0Z3UWNDWGlwMGl4akJ2aUVNVXZoMWdaNE5URVp1UUJq?=
 =?utf-8?B?eXZ4YnFaaWZaRmFETnhCQ1hsMGp2L28xS3BJRVljZllEMUlSam5POVpvejc5?=
 =?utf-8?B?clZJbHpBdHZUbHpLOUdacmNCWG5TSXJxeVI4T1NsdnB0ekk2ZXlqcWpUcUM5?=
 =?utf-8?B?Wm5XKzVHckdGSCtWR2xKc0ZvQmsyTStDKzMzK1BpWjBKWVJOTWRzVUFhdEcr?=
 =?utf-8?B?a3hKUjkvRXlhbyttK3VKL3UzVVpORlhxNnhLaC9VM1V5MUhaQlhUMDFKTkpk?=
 =?utf-8?B?V2MyYjRPWWVLZFRYSXFuOXRHaHRrdkZPSGtiQlJraWRINVdHcjM4SFJSZ2d0?=
 =?utf-8?B?YnhQUHpvOVRBMHhhUGpvbTdPaXl2U1N4bnpJYlo5VWZkOXdRS2dpMENEb204?=
 =?utf-8?Q?q1m6XOdlTCwGLSC1cA8pgVWH+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39d94d4-b147-406d-5e56-08dcc070cfbb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 17:03:13.4610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GG6C0nuxxNB3IECAHfcohB8Z7zoE7P6OKbtnoOi/Zvt8sVGXBgmfvr2yDfiXSni0sld2yCiP19R0WzqVuJR2RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8761

Move fsl,ls1043a-qdma ahead fallback string fsl,ls1021a-qdma.

Fix warning:
dma-controller@8380000: compatible: 'oneOf' conditional failed, one must be fixed:
        ['fsl,ls1021a-qdma', 'fsl,ls1043a-qdma'] is too long

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index fc38a0e543ab8..c0e3e8fa1e794 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -955,7 +955,7 @@ pcie3: pcie@3600000 {
 		};
 
 		qdma: dma-controller@8380000 {
-			compatible = "fsl,ls1021a-qdma", "fsl,ls1043a-qdma";
+			compatible = "fsl,ls1043a-qdma", "fsl,ls1021a-qdma";
 			reg = <0x0 0x8380000 0x0 0x1000>, /* Controller regs */
 			      <0x0 0x8390000 0x0 0x10000>, /* Status regs */
 			      <0x0 0x83a0000 0x0 0x40000>; /* Block regs */

-- 
2.34.1


