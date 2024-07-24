Return-Path: <linux-kernel+bounces-261202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BB593B41A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AE3282304
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A5215DBD8;
	Wed, 24 Jul 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WXS+PVjc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EDB15B963
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721835978; cv=fail; b=TGomCqYjnx5Q/JrvmZq/bCZvzxPjr3IP8NO7rTNnFNvw1RZaKvWwgUVtMPKe43ilaGQ4/NCOjHec+seGKEHxtIl0HjWTVFZgjddwwakoj1MkHxjJ7MFXAjR/rWeZaDKQbV8qRNN8+mjPEO+JU5E6AZuq/qXrE9eJhICEU+04W1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721835978; c=relaxed/simple;
	bh=/8gjfrLEbeqdvh2UWIsUOXSQLlEPInExNiw2wP5o2A0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dvt4BcyMK22zAH9OzDHjBHiMTYkyRtcLO9vSbWyRzGmmjXLN6XhiIuhOfMef6obDsxYP5Ke0qmD+oiBPa27P+bKmMEFPqgqfeObSgmr31S71WuubMvoikSpJNCK1s999ujFVc+SGqinLc+B80KZmxaaO2TwOejk3ZUlBZ1Ltsac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WXS+PVjc; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0hKXhIP09WxodGn6dj/F/2R7F/tPyOq+aFChGYKTdnmgQAD/z9+K/bt7W7fliVSEBekpKnsLX8dlSfet/MGHj5CGGvbuvx7R1Rc8zS1cEcHtmCGPGba2+LmmMX8qu5YqMiUuzI5mQ7PdQCi3qwCYoQxj57nNZKyYfjdMDqbCpaZiENY872WayDD2vTUsDPduLQdtNNBKPvauEqK9ME0TzMLNToOtoMjo1+Hve2N924cUPNgL068ZWu+ZIOMFh9gg+PXuqHStsFGCAzCVZ8SsHLfJBA8yALxUMihVonKI5OReEMlhj2dpJ5nHRjwyBVVrObQTvnYDN7hlkMgu0EI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H5YFp3nwDhvmKVPeBWxGQWI1IbbbTbtrRrxup0oAxQ=;
 b=qewuBOKZP4RwYXwcnEPATi8Fd20Hl0DoONQDXPQwHSJAQv2FOpBiIvL5H64RKRX7Dm+3yeRiPynKcaGS4OZj2i0GETyspxkNURVnU3ZfsErHQYOXVTTmzVOvv/i8AlD3m+Kw+5WW30XZPGOKbuUh3opcZdO6UCdT8L6wmxC6qKGnTFGGPjnHDBv5AWC4DB8+iehXbLzvJgMaXiA7DpxWhTcMmNeMXuf/LxrbPBwrW6OikhhVVq7Vs1yFlhHtR1O7ljd4ZDtR8ee6qxLQ9E4dAONslMmB/Jugbv0RDDnBEDuVZBo2xWe0R1SUbEPyrg8gAIc5Hq/PJj4l/sNhra02XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H5YFp3nwDhvmKVPeBWxGQWI1IbbbTbtrRrxup0oAxQ=;
 b=WXS+PVjcKeqRF4jjgO7iLt8go+BMayzwf66w2IzcZOH/ExyldavC95D+dYBbybfiNtEBFDDIXOowTLOF4lv/awJtouyi/+5CjLzvLQkXgypCk3j35jyA4x0tLlat7nZ1ajz70gHu3zcAQ64iudMH4JJThDzm785h7z8Lcd+N93JCgexehoqDziPn9Es5wwpnBoKt/ug+klbb2F4zl7RdKP+POdset6eF2OaTh2oh0Yybugkq4QhPqZUQId53pAAgsL9X4/zL1GMFf1BBMWZ8PBHn43osGn0YcCSC3KNaHrcqxLdUkZvTQrE/THkTgqxXIgwYvZ3TshzBACEUi9tYLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8599.eurprd04.prod.outlook.com (2603:10a6:10:2da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 15:46:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 15:46:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 24 Jul 2024 11:45:47 -0400
Subject: [PATCH 2/7] i3c: master: Replace hard code 2 with macro
 I3C_ADDR_SLOT_BITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240724-i3c_fix-v1-2-bfa500b023d6@nxp.com>
References: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
In-Reply-To: <20240724-i3c_fix-v1-0-bfa500b023d6@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721835962; l=1901;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/8gjfrLEbeqdvh2UWIsUOXSQLlEPInExNiw2wP5o2A0=;
 b=o3K+zGhp85Eo5QVg5L9biEGZcoVSDJXgyOoSG1pJZaeva+eIH2wEx1039sM8ZAULgIcYz9q/n
 zWlMN0WXdfhBxRe9XBnrX4yMFMzy578s75fzlZ2Vo22QPmPZngeO1Qn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8599:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af0900b-d7da-4119-c89e-08dcabf7be49
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Yk9kRU9NYzFyLzRVd3BWZnJxdnNkRnRUQS9KVERIa0k2NVNrU0svd0FiMWs5?=
 =?utf-8?B?R200eituRHJ3Ym4zMkdKL0Z6OXcwV0h5Z1dNa09TYUkrcHo1eE41bmY5TW5P?=
 =?utf-8?B?aEdoRjJ3bWNFK0lXYkVVVnIrN1U0TU5HRkEwZ1VLaEVGWXhKQlpXUk0zM2dB?=
 =?utf-8?B?WkVKcmxvNi9PV1ltaWd6V2psbWVWeE1OK2cxWS9EdHRLRkZTVlVrLzBXYm05?=
 =?utf-8?B?N2xuOFdsK0phNm94MVNUaHlLVGJiNkFncXhVQ0RYTm1iRy9iMFNQK0N3UGp1?=
 =?utf-8?B?VGttU0J5b0xiMzZqNGdXOTE2OUpsdUdpQUQyYk1wNG92cG5DM2RLaWsxUnAy?=
 =?utf-8?B?b2NJNG9ranRvc1UxNWJxcTJRa2RSNXZTLzFTWGNsNXI3dEV3eTFMTzhlR2Uv?=
 =?utf-8?B?TGVwVHBnRS9DM0dra2svOHdYMS9YMnZZV3BBd0RFQzh6dGpoK0s5Y2l6ZHpO?=
 =?utf-8?B?bTBLdWIyWDRicFBqOGhlSndSK2ZhNHJBQnI2anBzUG5TWnFWOEdlSDFVTFJ6?=
 =?utf-8?B?NDdxN0o4UVc1VGJUT2xialFnQnQxZnZMSC9NbGEyKzF1SDZOQVh3aEQvMzh1?=
 =?utf-8?B?NFI4TEpGTE5LNE8zZ2VXR3lQSnQ4cWJ3c0xCQjBiTlFvVTZLVlR1cmlYQmVD?=
 =?utf-8?B?a2dWL1hWSVFmbmFFa29RSjlJVlZ1TVpOcUZ4UzRHcEhzZjUxTHNLM1BQSVJN?=
 =?utf-8?B?aHdzUC9VOGFKd0pveGI0WFFNQjY2YVh4RWQ1aFR4MlVjQk5uaDJTeUVFRHZh?=
 =?utf-8?B?T2QwT1FlaCszZHVqRGNycTVLQ3BtK29sZEo5SmkwdTN4cjRwTzFpZFA2aUh4?=
 =?utf-8?B?VjUrUEdVbXRkZzViNEFtK1I5MmlxMThVTEZCMGtkMW5qR2x6UUZlS0djQnVl?=
 =?utf-8?B?b1hRTWhPbG9GdVV6dWYydTd3WTJCK2haNHJ3ZWltMEVKQnB3cHdMeXFpOVhP?=
 =?utf-8?B?eldHQWg1Y1BvNnpFVlBueHVkdGN4TlpLMGxmZ2tJZnVBM3VtdVVGdkVIbVFh?=
 =?utf-8?B?bHU4bEdBTjNmdkVSRzdKNFAyaFgxS3ZzWXNsTDBnTHJQK0dYN0tBNDA5N0hW?=
 =?utf-8?B?Z3NCT25SU2JlcTZQL2EzdENaOTlvL25WRWx3OGtmSEo0bEVuSkVnVFBqVkxG?=
 =?utf-8?B?d0NoYzBSMFBWOTNwNmVyNTlYWmtMVnczRTRDNWI2QWFZQ2VNanVHcCtzczNQ?=
 =?utf-8?B?NEwxaC9RMmVvN1plVi85cVUwVG10YWsraGxZbS8vbU9nNUZodGN4KzBlaFFq?=
 =?utf-8?B?Qjc2U3BBY2Z1d3g1Tk80ckYzUW9qYXpaTlIyeis3bkRUeGRKbnA5djhiTWta?=
 =?utf-8?B?OGVRQjdVbDZLTGl2eGZaS0VScHhtTyt2UUNTcUVtRFJLWmsxL1l5VFFobGJR?=
 =?utf-8?B?cHQyWmJaNG1Pd1dac1c2YmVqVjhTZy9HYlBPbFFWYUtUdFF0cWpRL3hqSEVI?=
 =?utf-8?B?QkJ2THJ4aGRidnovVS9XRXJEeFpJdC9MM2RsQzZlalFmVHlreHpKQ253SnFD?=
 =?utf-8?B?bWxWN2tzU0JWSGdFRmJtbE5wYmZRZ1NqeGlMYTdEOGNzQjZWeGx3VDRXV09w?=
 =?utf-8?B?Z3VoRzBWMnVtajg0QXBvbHRCNk1uRG1xbHBQc1ZPVFRjZ0JVa1lKVkorVU5o?=
 =?utf-8?B?Z0htQ052bXN1NXF0RVdrMk1ZQXFabWx2SGNKaEFZTEZlZzRnME4xcHZidDdK?=
 =?utf-8?B?bmlKY0pKN1BJTjJJblZYZTkrVzhaMkh5SzJqaU1QVmYySm5TN2F3N2pJMDRi?=
 =?utf-8?B?M3BkRHpUa2FIU1kxRlFTdG1HSDAxR2U2NlAxVG5vbmVhNWJmenFOT1IwVDAw?=
 =?utf-8?B?Q3hPSTlUWmZzNjV3OGpMTFNQOTlNTDRYbnNJbUxDdm1Ra1oxSFppaVBQdHFT?=
 =?utf-8?B?YTZXMkNIWmhZNEE3bUNPd0FmaS9hQmQ2aW9icEJSRXBNWWc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHp4L21oUkVvN2EyM2FOVHdDQkNLSTM3M3ltZFN2RmVoTE1obHZEMHRPNlRl?=
 =?utf-8?B?Y20zZm5LNk0wck00a2ZBQkppZVlrRHNHSGxpTDViekIvRjJOS2NIcU9qWGY4?=
 =?utf-8?B?TW5NMHBkYVZsb2pIMUFBSU5NMkZVdnpsQklpNGMxeDJzMjFwRHRob0hrL0tm?=
 =?utf-8?B?MHU5cHBKTktkdWxTTXdjaTVRQ21zU2tNU2FUbllTOWRTRmJWRkw5eUJvVTFa?=
 =?utf-8?B?Q0xlOXROd3ZCMXQwNFVkRnBJdnZEanBVTFVOOVhQTm5ZZkthUFZXRjV5SURK?=
 =?utf-8?B?bE4rcGo3bkM0YkhEdTNvNWI3Vll4OVRKeHEwVm9VbWRmTG53YjJZQVBVNXRM?=
 =?utf-8?B?NFcybWViVjdTUkhQY0Q1b1lJY0hDUlNPTmZPSk9mNlRkR1hQYkhQUmRmQi92?=
 =?utf-8?B?dkZlTlpDVnpOT25OcGU1OXhpQk8zZjVHVzR1SmFUWjcxRlN1NE5ZZE0zSDE1?=
 =?utf-8?B?NFJJb3VDRlNOMHU1Nnk4Mzk4bkFRaVJhTFJQTVliUEJvYm9IRlhVY1dQZ1JB?=
 =?utf-8?B?cUJBeGlHaG5nSjRrNFc5Y1k4SnBaVHczakZHM0lORXpha0NybTYwazA1Smh2?=
 =?utf-8?B?eUpEMk52WWVZNnlwSVluR2pXNzdkdHFubUVpTlFOakQ2QXNHTGRrdkhISG91?=
 =?utf-8?B?U3FWQ2FzanF1dmZlc3NSdTFqZWpoeUlRaFlSL1IyWXhjV3RuRWE4Zk5qSWMr?=
 =?utf-8?B?bitHTGkwakFiVXJOdk1KT3R0L2tNL0NGNXBuTXlneGZIMkNHMzIraDdLc3da?=
 =?utf-8?B?by91YkUwYzJkVnRRNDZRaUc2OWV2b2xvNThtK0RoQzZod2ZSOGpnTEcza21Z?=
 =?utf-8?B?Vm4wdnRFbVBBd2F6cWh4Q2I0bGNvUFY3NUFkQnBNV3FPNFNHUWJwNmpDSXkr?=
 =?utf-8?B?UktQQ285WThYbU94S1JRdDVyZHI0NHQ4Mm04bEtEeHpuTVFPekUyb01KYmVu?=
 =?utf-8?B?QjN0L0VEM2dYemtWNTVzVGNHTWVKTURGZExtNFlURzdBa0h3V2xhNDVkNnNZ?=
 =?utf-8?B?aUMwZ09KeGF5VHA2SUU4aTlzR29LZG1DTXhjdHNsUWhKc3NhWG9aU2pPYWds?=
 =?utf-8?B?N28wMmhZNzdMTDl2OU4xK21qTXU3WFVKR0JVNlZROVJmV2J1MUhEQkR5TEpF?=
 =?utf-8?B?RmtncXJTb2x5Z3RtMmhaQVdIampSR1hKTk1DRHdMSGY1TFJQcVNySmhWZUdQ?=
 =?utf-8?B?QU43bitHbENRay9sejlQVkV5STBEUFVBUTg1L0Y4Q0d4TGdnSmExaUhlUzJU?=
 =?utf-8?B?RW02ckR2emQvd2NFK2hxZVdhUmx5V3laOGpEbmdOOWs0VW1pSzlhaEJpaGNn?=
 =?utf-8?B?dzFiS24xL3EyUWJxclJiQXFnMWVoc3pYS3gxQzFSUm40T1NKVHNnUVhjNU1I?=
 =?utf-8?B?Wnl4ZzllYVhRV1g5SnNHSE5Yd2ZsUFhScXZ2VldXelZHQ2ZMdldBUit1eGlT?=
 =?utf-8?B?L041YUhqSmZzL0dlWVZ3enV3RW5NZ1VFUS9PUFBhWnExZTNJV3dJYzJjREU2?=
 =?utf-8?B?c29RSmszZlhhckxaUGFJRVNYeldpbytpblhrRStnMVY2bjRyRW1HY0xUa1dx?=
 =?utf-8?B?cU9nbG4xWnkxT0FYZnRFY1lwWlpUT0JkTzcxQzk4dDY4c1JmVnV2WTJrNTFB?=
 =?utf-8?B?QjhTUUZGNmtSNjVldlQ5dGp0MkhVK2huY2hGZjdvUDJIZmpscWw0bkYyT3Ra?=
 =?utf-8?B?Y3VQQnFGdENOMURscndkUEo1Nmx5UnlISENhTnVJSmpMVkpDTlpzVmg1cGVi?=
 =?utf-8?B?WEwwZ2dhUTdLTGYyQ3dzald1MHlJRTNNN2VXWXlzZUV0a3RVQUZFVkdpa0NJ?=
 =?utf-8?B?MlVVS0l5bDBwblNYS2FJbVdKanJucXZHTEJ5bXRXaCtTNWJXbDFhbHpsbDZB?=
 =?utf-8?B?OTdaSXVzUUFIU2MrK3FOWWRLM2NJN2VlMWlXbE1TU2lwdzN3K0tLUDNQVmM3?=
 =?utf-8?B?U0Z6MlFJd2JVcU5rZ3FPckcxMStPaWhxekxkcmtaT2VoQU84dUpFS0xueVRa?=
 =?utf-8?B?MDNmWVR5SExZOTgrSzN5Z3BVR0s1Y25wTEhoRm80ZTNnZmdRK1c4Z29DL0Uw?=
 =?utf-8?B?RFZWZU45QXY2NTQyVnkzRGIrMFJacW8vR09PS1Z4YnN5ZDRVVk41eWw5Z0Yv?=
 =?utf-8?Q?xIHRAVgs7h03EzxXHG4ean3/L?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af0900b-d7da-4119-c89e-08dcabf7be49
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 15:46:11.8621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qt1hYMUyq/SuY+qoVFOVUPtmeSrXen+RLaOTzmEoXxLE0T6ONukBxNMLMb0/jWcB4DggwNwUPjr5pnikcaTZEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8599

Replace the hardcoded value 2, which indicates 2 bits for I3C address
status, with the predefined macro I3C_ADDR_SLOT_BITS.

Improve maintainability and extensibility of the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master.c       | 4 ++--
 include/linux/i3c/master.h | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 852b32178b722..85c737554c940 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -348,7 +348,7 @@ static enum i3c_addr_slot_status
 i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 
 	if (addr > I2C_MAX_ADDR)
 		return I3C_ADDR_SLOT_RSVD;
@@ -362,7 +362,7 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 					 enum i3c_addr_slot_status status)
 {
-	int bitpos = addr * 2;
+	int bitpos = addr * I3C_ADDR_SLOT_BITS;
 	unsigned long *ptr;
 
 	if (addr > I2C_MAX_ADDR)
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 074f632868d98..4601b6957f799 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -299,6 +299,8 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
 };
 
+#define I3C_ADDR_SLOT_BITS 2
+
 /**
  * struct i3c_bus - I3C bus object
  * @cur_master: I3C master currently driving the bus. Since I3C is multi-master
@@ -340,7 +342,7 @@ enum i3c_addr_slot_status {
 struct i3c_bus {
 	struct i3c_dev_desc *cur_master;
 	int id;
-	unsigned long addrslots[((I2C_MAX_ADDR + 1) * 2) / BITS_PER_LONG];
+	unsigned long addrslots[((I2C_MAX_ADDR + 1) * I3C_ADDR_SLOT_BITS) / BITS_PER_LONG];
 	enum i3c_bus_mode mode;
 	struct {
 		unsigned long i3c;

-- 
2.34.1


