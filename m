Return-Path: <linux-kernel+bounces-395124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 244E89BB8D8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9861F22E28
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 15:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826711C07E6;
	Mon,  4 Nov 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BQF9DHyh"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2074.outbound.protection.outlook.com [40.107.103.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7751C07C5;
	Mon,  4 Nov 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733819; cv=fail; b=u/SLQULNYhh/fPCYZAWtzH8etnW2G0NRILH0lebGqsRU/1HwdDmZnmdOk+O1EGjln8SzS+l9ba/t7GE0yb2qh0lfJQUzUvdnqBpt4r6GbYu65aaUZ12ChzB7CuwCdvQW0WLd6WBZQjlK+caECpsvfFTauZJILZEB2iWVjAsDKOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733819; c=relaxed/simple;
	bh=8bCTvi7AgU4MQ5HET0AOHmcMvn388Mh4NN86zRFZhtg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cDgJTKTrOyfqQd9oi8v1TjSuKv87y4HayiHOYaLzcbsghhuQWJXMCAsgv7lrT9ZjPNs/FaoAcbbr2HdjI4FZMA/CMXohSd7ryzxWiSD7qxxsBdh6iZT2zkUAgE6rRq5A1j/rSeVj3ZQcuZWpshah9BXTNfTXp87+aJlczGWIQyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BQF9DHyh; arc=fail smtp.client-ip=40.107.103.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoDa1DVslTmEVJWWsJFRbWivK9dA3uR009V3ahEx2bkv210CJ8FsvZWtKtzTX6RhujNU3LYZUw0DMknC0wNKujluOv65k+aOphbCIq2LdjYG9qUJheM/7dss4DwpcqlakD7GgnB94B3LQvJucg4jy9VYch6CmdY+EdT2VpyAOBRkjp4tQSH/dNS3lFTExJpeVmxLFTHu9/aJKdaEx5bGBXxkOdcZ5AUC/tjNi88af36YMjkxgIEEXlnXd3rDZ6RqbaPC6J6Qao4i66jSPeOwBd4wFdUHXNI8AtlZSoX06M2wiueeq17SJKPajHtqqe3R/hkZvcWPEbNH/NWoQFiOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZoRgTn45yJn+Pnp3LFTUwhkGYSMYn5cLf7fH4YbYkY=;
 b=VGSrsAY2twtXEKswrDfqihV/6l72Pvpxp43hxJNddbf7huiTzmQd1tegM/omsUmlUBgyrifXMOOHMc//sk+OMiKDI1p+i+CcwqTBRTqLypoVkoD08Qz+1y/ZYAi/FxcLvN4iOfhkLkbE1swH3cM8srdfGAMfQ+XIYb3tA9NWVi3eb4GcSg3nmUPrj+MKyD7Lwzx5WWvbIk3nPwvuRwWmU1xb2jl8pSKVEhbsPln2DPBQ98EewQD3ZWkekWzKcBkMVM4PC7ao3HEX78uTw8eFVRPxLgx6jckQmWirvhBQRvCC/tpEQXjlU4qlWqrm+gKMRumuqxElGXuoBbES5ZBfHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZoRgTn45yJn+Pnp3LFTUwhkGYSMYn5cLf7fH4YbYkY=;
 b=BQF9DHyhW6SRHJSKPcbeAIbhOmYEfsetcUnyU24xW+aD5wnKBPcTWfNAbLe47GE3RTdUXGY/RTZ7XritO0DTlh8iwkd6VvagdtjODOUFCNaq7qOfj2TloKv/NFpGCaAtNtZ1cZhUfPoSpv8CX2m/m1pwEdHfSzBjMWC22yU0dJYQNea5OO+8z3mmtMHQV8iGvxgA0XRK2VChyco0ZAl4ydGvukIr2TdswaYYeVSjmVL8OSImdGi2I42jR5lmRjIl/AtTjog6+jVLVkVMyUmQeTF3RAW7YZftT3nFfMpMCfS12Ei3XNOM+bhByKzE8sTxH1MgsAmdGw8KMmD1GskcOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 15:23:34 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 15:23:34 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Mon, 04 Nov 2024 20:48:39 +0530
Subject: [PATCH v10 2/5] dt-bindings: arm: fsl: add imx-se-fw binding doc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-imx-se-if-v10-2-bf06083cc97f@nxp.com>
References: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
In-Reply-To: <20241104-imx-se-if-v10-0-bf06083cc97f@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730733536; l=3191;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=8bCTvi7AgU4MQ5HET0AOHmcMvn388Mh4NN86zRFZhtg=;
 b=7pHuoG8IOMl++mOl4QWTdnALzR8eAMOle8Yde5ntbi5N25PkWuLmNt09CvnkTglRGMw5jgBWs
 s5pNgBQtqSQB52+RHfevhxn+5/ERRh6B0lXgBnyanK+vR/J76ExNpry
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AM9PR04MB8604.eurprd04.prod.outlook.com
 (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: 32096de2-68c3-4955-6117-08dcfce4a587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTRpWmpJb29XUWk0d2RMS08xWE1DUXZ0M1hOSGlKQ0xycEw1TFgyS0pJc1pG?=
 =?utf-8?B?dXJINk5MSFRJRkNCeVZsSkgwZVE0WSttdjZFcW9nL2tVYVRWZG9NRktqRnVJ?=
 =?utf-8?B?WnpjQ2ZJRmZLSmVMendUZ1VKU05peGVHb2JpekgzbDhWZ1Rmb1k1N1NNalln?=
 =?utf-8?B?NTdiUXE0VU5oSEFWWDVkM1ozN2tzNnB3YWhlakl3VFlRY3Z3Uk5ubW51VUF1?=
 =?utf-8?B?U2U4WkU0QU9DMjJWeVliSXRLMVBqbWJYUHNCNXlsdndseWxEdWduU3RrTmdz?=
 =?utf-8?B?SXNLSlh5eDk2MWJlSXFBQVZPbzRQUjdKTSsyaVJVZC9PblIxK1ZvNkJ0NWQy?=
 =?utf-8?B?SVZaRmdnZ3JRTHhuSlUwcUkyYzNxOFJuSUJEZkc2QjhGN0syRVZtSkFXc0Vx?=
 =?utf-8?B?Z1BrL0hkeHdSdUpoZmdjN3NnRWRRRE1KU2FyRkwrbDFlTC9zNmEyTi8vVkQ3?=
 =?utf-8?B?Mk1oVmdaZ1g3bjAza0Vudm5NdUNIUGpoVGp1OC9sUnh5Qm5YajZkeEwwa09s?=
 =?utf-8?B?YmRIUktGK0czR3l5enRoRG1zV2hjamdzQURDOHNIdEhwUkxsQ0pIMVRWTlM2?=
 =?utf-8?B?by9DcWc1RjBNZUJ5ODB2OGtvQ2dobSt1TGFZNWVTUWtudkdTeW9pWE44NlBn?=
 =?utf-8?B?czN2Qm00OXZ0SVVHYzNnTXdXRXQ4WUxsRUdTUkVyTkZBcE4rWmQwQkpRVWhN?=
 =?utf-8?B?L1Z4eTIxTUwwU2xXcHRiTmFoVXZPTFd2d1JaRkttalc2d2s5YlJmb1ZxRDRB?=
 =?utf-8?B?TmxjTmM0UW5EbGZiSmdmOVJzNjBnYzJOVlB2TncyUnhMdDBjaXNHMkh1UGN6?=
 =?utf-8?B?Z2hKWjR5cllOZTFXZ2ZPWkxEalIzUVZIbVhsT08xdzVvbVFpSW44dWVVbVBz?=
 =?utf-8?B?NzQxa1pYMTlVV0NSNFpuS3JWSU91RzBuMHFxZEY2UDR5T3puRzN5d001S1BX?=
 =?utf-8?B?bmlHUTVPM0tWbDhVRERHTTE4VnFqWUVYUEtJSVJVN0ZxN25Qc083VVNhQWJN?=
 =?utf-8?B?WXVkTFNRdHQ2bThEQWQyWE9iTE5Bam1ZeWdpcGFjZVZEa2hqMFkwejJiR0Q3?=
 =?utf-8?B?OFdWM2tWcUUzV0NlanRFSzAvdzc3Qys2NTdzRnBSL09oZ1Uyb1dESmtuTHBJ?=
 =?utf-8?B?MUlsVEExajU5alBQUXJ0TnR4eU1uMndaNlZCU3VQSWRuZkZwenczT045U01X?=
 =?utf-8?B?WFNxeURSMGdKSllTZE1rUktndEhNTTIwNHplQTFSSG92MnlVM3RHQ1VHYnp5?=
 =?utf-8?B?K2hac29XaEw3bXhIS1NVQW5aSkNRMjdaV2VyTmlZRHRLSFlFaTlsMTVWSXNC?=
 =?utf-8?B?R1BrMERUMzZlWmpPWTRaMmloZVEvSUdOVHcyN0F0WEh3K2JXUm92UEJBblhh?=
 =?utf-8?B?RGdIZkJaVm9HcWtsT2pXSWlLWm9oWUNtWGNzbm11YUpTc1RCcG5IZHdDWWd0?=
 =?utf-8?B?TlF5SktwdnNPNjFZMVVrMDR2UzJHQU1qcHNiWDNkZVNycnNVWGJKL3VtdUw0?=
 =?utf-8?B?bDNEZ296WnJlelR3L2UyODRaKzZSeFVWdGxHL0E2dk81dVROTUtuQ3A0ZkUz?=
 =?utf-8?B?dGZGWVNNTFo0b0d3L0NoMFdhYXowbGpSemtCWUR3SXg0d0NINzQzM1RKODNy?=
 =?utf-8?B?WlgvZkZ1U1RDMC83UStydzdUeFhwQ1dQemVCVTczZTNDMFY2UmE2N1dGN3VI?=
 =?utf-8?B?NEZvYnpkNXY5WkxPb2syOWlVZ0RoOW02a0M4U1daMTFnZXkwUGFCa09HQk1u?=
 =?utf-8?Q?KQwCj9xHaC5hBjNFrTAK0C0yvxUR2LVD+qdW0P1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzZtWS9HckJKT1FwcXJoTVZZRzNEOGlOUy94NWo1L1FoL2w2TkFhMXhGbks1?=
 =?utf-8?B?U1hRSkgyQTdMaWkva3ZieCszbU1XSUkrdXl6Tk5vRkNHaXZaRTIwc2xpSVlQ?=
 =?utf-8?B?eGpaNmlRNEdDbTBYQlVOL3VEZTBmZ1hmZWlDOWRaSVhObW0wVnJYK3ZSVmtO?=
 =?utf-8?B?bTd1TERvalhaQjltNldlRnpPNG9LbVFoUmhKTW5uRlR5VGFOYlVVUGhpY1JQ?=
 =?utf-8?B?NWFMeUhOc0dkOTdpUkhzU2Npc3grc1A0VGcvU0ZNV0lESGNrWlZGSjAxZWdq?=
 =?utf-8?B?SFM0OXpCSVpPakZuQXVrM1k1V0hqQ2llRG85NVlKUTVHWFNGaTlIZlBmeHNH?=
 =?utf-8?B?djAvLzlVQzYwQTBtdVZaa1c4ZHM4R3NjSytGSlBDa20zQVpmUTBZTWRIc1dj?=
 =?utf-8?B?dXBSaXYraXhCRG1xeTVZbVo4WXJYdWJvMW1MelQ4SENIcEhEbXo5QUZqanY3?=
 =?utf-8?B?TTlrc0NQMnAwcXVlRS80NlVjdThZZm5GWVBOQ25QWHFxT0Y5VXRMVVB5b0tQ?=
 =?utf-8?B?a290c2R2ZU8vWHVzVnRCblJZODZnNURHOUdqRklCZkpRbytzdDVuNnRXWVBP?=
 =?utf-8?B?K0p1MXZyKzAvSFpIdmRjRkkwSm9hankyTkx6RHNiajBEd2JTY0FJN2Y1NGxP?=
 =?utf-8?B?aDN5U1NYQVNtZ2Rlc2VxUlNZQytyakhXU2ZqVVNXVE5JcE1TWmovWXJZaDlG?=
 =?utf-8?B?UXhJZkk0M1hhTnhYenNzWHkwcjdPU25Ednh4NVJ2UC9rVGpRMmFQalJqNkhV?=
 =?utf-8?B?bnlFN3piSHlMbXpxeVNmRkM0bUZYOFBaZm5oaXAzYkVUdnVRVzJlRHJoV1lu?=
 =?utf-8?B?YWNYY1gybGw2SUgvRmFJb0pBcjUxdUVHenNRY2VXT2R2aENmMzZ5MzhIcXNE?=
 =?utf-8?B?VHo5eU5oRzd5MnRhZWJIdkNCMHQvczFGTE1idkwwZkcwRHdKZlFaOW9iaDZC?=
 =?utf-8?B?d1dMNjZNMDN5NFZtSTYvNFVoYW9sNmxRaHlSanY1VDRsNGE5OGRoUXFrOWh3?=
 =?utf-8?B?OEttdkZReFpQOXRKS1FERExQRCsxZG1iY0gxVWRuSXhFcXBITmdna0x5RTZz?=
 =?utf-8?B?U2F2NEpvVjlsbExKM2pnN0pHTlNZZFdtMzJBbTI1MERzWnlQemtBMmdhd0R1?=
 =?utf-8?B?aGFVb3RpbUZ1TnpLRS83RkNaaWJoMEtxZ3I5UFd1TVcxODVUcEN3STR4TFho?=
 =?utf-8?B?eUNrdXRzWHJ1QlY5elVXYzQ1b21xRW9ZNGhpNTB0bFRYdEpEU3VZK1gzM3Mv?=
 =?utf-8?B?ZDdzN3VSbXo1MUpKQkdDVjhPRTV5cUR0UnljREw3NFIxdzZESjRCNHp2L0lK?=
 =?utf-8?B?cVYzMzVTWkpsVlZkNHVFcm05R043ZXdYV0I0ZDNld2xrOHhSVllpYWY4L05o?=
 =?utf-8?B?MDlaMTZ0WXZNck1lcEIxK3JsMG1hcXVFWVBoSHRYTDRLVUNJZnFEVDI0dW1h?=
 =?utf-8?B?QkJIbDRMSkowUEY2ZUJSUVQyU0JCZEdtN0FYMDdPYmRCTmtmVU1lbGVnWUNQ?=
 =?utf-8?B?d0QxNmZSN0RlSmRHaFBROXplME5LZDJQRTFGTVl4S1ZPQkdSSEpCTGs3bm5w?=
 =?utf-8?B?cEp4YzBCWHNzWUtKNWlZaGx2cjRSODZyT2FRNElPR2Ivd2dKUkdTeTBIbEdM?=
 =?utf-8?B?QS9hTit1OEl2MTlMQmY0Q3ZnNUNxekozRW0rZ1krTHRPM2FHaXVqQk9OWWt0?=
 =?utf-8?B?bDlJU2djQ2dZcG9CZkpwMUl4Rm9PZzhzbXo4UWQrbHhmTjAxanoyME51ekZW?=
 =?utf-8?B?a0lGRWF0RkpxTWRoaWdnS2lQSjFUZ3JiT3ZMa0V0TkpaNHFRZW1lbVdnT3Zv?=
 =?utf-8?B?aCtKRmFkOUVBSjljRzRTRGFsb0k5a1d5VTZnTlphM3FKaFVuaVVsOGQyRVhs?=
 =?utf-8?B?QlFoZElTZmtmdkVSM1FEOGNwTkNqTmQwbHFwd281bDhkRWI3S2ZvVUZSckF2?=
 =?utf-8?B?cnRxMGhsSkNsZTdLY1R4R09HZEZBNWtRdGo3UzhmSEI1WDJRU09nWXF5bFZ1?=
 =?utf-8?B?aWt6LzUwTjRFcExkYTkxSU5xbm5TeHBmcEx6VmlsNjJDTjBEL2dXTjdNRkZD?=
 =?utf-8?B?ZFZ2TjdxY29WQkxPRnlGTklxN1MwaXhYczg2bkI5Q1NiaEo0YlllenQwZ1pa?=
 =?utf-8?Q?BtVAk0SsEA+AYD+mM9aCmHAsJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32096de2-68c3-4955-6117-08dcfce4a587
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 15:23:34.0996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWTThdlEnvRYC2twCNQJFrfdEryKDAhUvKO0TtJ84X3biBMaixyXDaEu9P1T2hWr+tatUHEcbAKe0YPpE+3Xbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
creates an embedded secure enclave within the SoC boundary to enable
features like:
- HSM
- SHE
- V2X

Secure-Enclave(s) communication interface are typically via message
unit, i.e., based on mailbox linux kernel driver. This driver enables
communication ensuring well defined message sequence protocol between
Application Core and enclave's firmware.

Driver configures multiple misc-device on the MU, for multiple
user-space applications, to be able to communicate over single MU.

It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Conor Dooley <conor@kernel.org>
---
 .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
new file mode 100644
index 000000000000..0b617f61640f
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/firmware/fsl,imx-se.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
+
+maintainers:
+  - Pankaj Gupta <pankaj.gupta@nxp.com>
+
+description: |
+  NXP's SoC may contain one or multiple embedded secure-enclave HW
+  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
+  enables features like
+    - Hardware Security Module (HSM),
+    - Security Hardware Extension (SHE), and
+    - Vehicular to Anything (V2X)
+
+  Communication interface to the secure-enclaves(se) is based on the
+  messaging unit(s).
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8ulp-se
+      - fsl,imx93-se
+      - fsl,imx95-se
+
+  mboxes:
+    items:
+      - description: mailbox phandle to send message to se firmware
+      - description: mailbox phandle to receive message from se firmware
+
+  mbox-names:
+    items:
+      - const: tx
+      - const: rx
+
+  memory-region:
+    maxItems: 1
+
+  sram:
+    maxItems: 1
+
+required:
+  - compatible
+  - mboxes
+  - mbox-names
+
+allOf:
+  # memory-region
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+              - fsl,imx93-se
+    then:
+      required:
+        - memory-region
+    else:
+      properties:
+        memory-region: false
+
+  # sram
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-se
+    then:
+      required:
+        - sram
+
+    else:
+      properties:
+        sram: false
+
+additionalProperties: false
+
+examples:
+  - |
+    secure-enclave {
+      compatible = "fsl,imx95-se";
+      mboxes = <&ele_mu0 0 0>, <&ele_mu0 1 0>;
+      mbox-names = "tx", "rx";
+    };
+...

-- 
2.34.1


