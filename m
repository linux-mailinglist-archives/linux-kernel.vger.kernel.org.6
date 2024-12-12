Return-Path: <linux-kernel+bounces-442761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C689EE139
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C31162445
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9732B20E6ED;
	Thu, 12 Dec 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Grnk0G9F"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2056.outbound.protection.outlook.com [40.107.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A1620E30F;
	Thu, 12 Dec 2024 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733991918; cv=fail; b=nc4gIJbxcKwAmsQ/LzvNkQJaRYA/s0339WscJIwT/oBt9EQTkk7+ij7EJNKk3/ms/egcUyIbFgFrHvZ7NZdLmy6lcNYSln1/4IRgLfymZNR+tNavhpHvkggTadjOT+ZUbQemxMA1cYl+tDMpC4WxyqiwjQGkKl909CxK87/rH7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733991918; c=relaxed/simple;
	bh=uvbE/xmDKz+0tlvSgE3aoVj+50MLTfFDaYIVxixzIIw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ISie6B1rLpLd6u6cH8reGSqqbFBOfnAn4PeigD61HWgxUfnuorrgzYicwm3qCWM9FvGfS75xqZG3o+GUV+N5Fa/G8CTQL+t3HIA8NhVTYo4quHhWDYW2H0Qpi3abqOPobZH34zHdtf9kRSYzJX8Wv6fg7ABViAdYPxX3TGA5oh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Grnk0G9F; arc=fail smtp.client-ip=40.107.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5o38Im1t0ljGJtJt/pxX2R6zNs9c/zdV02GWAlMppGmSQRdK4LRo1aY3TqM5MxCqKzuZhofyseucE2yZho1WX/9Xh8KPxPgtULfI+0TGhMkprrtXRFwUULw2ObiuX2xGQs83Gml4NSS0cEIxI9FBmA87+SgVa5+Nkt/D3xRsVrCZ28uhBGm0sbYTt6m26CvAQItHXGmhA4iyORJd77SDQVs3bI0by3tTyJTK8KCQe5FtW+12aAzN7ni4KAleBmLOw7aWOJ9xIaXGM6H4HF+nInnjOYM6jDz0HY6LAUWRbcK4MYo/hcGncXbkVvFP8ybwMd1Bd3Sz9u1d6qA68K5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7+vfDFtMGi9jxvlpkmEJanflaWo/l8zwRJ67GIl0uSQ=;
 b=HtsiUkIyLlrcbRqK/oe6Ao79OwO/ZRqp0h1Jcip5tySY2T8OkCZvebmgyPMIGy9GFCJfQwjjHx4araL0SMEATi5nCBqMEqay5GpgnKMEHe8jZIweAyiVbxyWOkVGzqDKJO+CDG3Xnj4YjSXscgKMMa8H8A6sI8C88IKWAgonMfCdGhVB91TXsi62vT12l3GzN8+d1qD0GJrvEoMBY5g3M3tM+5DvqxA6X6QisKN7Bwd+jw1Wrbm0HrioTZjwh7RjVZr/cPJ8yF9RUYKAkGqa+6AzFqKAPwfoa5ICkuKC6+n+hp0berexZm3x/5vzPkKknsX8/lR8S3ljwTdBlE1wNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7+vfDFtMGi9jxvlpkmEJanflaWo/l8zwRJ67GIl0uSQ=;
 b=Grnk0G9FOFBwj1XGTcbgQpj90fur1I1SnV0pcZZIOLB++BNGKBYcSE7/mbvnmUjcgXSf3joHpCRaOsjJZMlX+kawOH1bJmaOCczTthPVCSEJlMlNHC0WE20vhdjkWob0MsjLVA8w5RYI06M7+KotfSK/gv+UWxPy1quooU/jBg/gh/TRGiDsSTypZ9amb8pm+Mj8gJ3lipblztTbIMPhcYn3x0XRrcouzpY3ysw6K5VnCTzntprNvivUU6mMDJ6NSfJWsSkMZ149oV4yCvpDVRHmyKnhbkKwvDyPQx/Wi8FcFGX7ZEIwTfvuA652YZv2GSxWW+/sAuu507GCk2zpag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PR3PR04MB7323.eurprd04.prod.outlook.com (2603:10a6:102:88::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 08:25:12 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 08:25:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 12 Dec 2024 16:24:41 +0800
Subject: [PATCH 1/2] dt-bindings: nvmem: imx-ocotp: Introduce
 #access-controller-cells
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-imx-ocotp-v1-1-198bb0af86a0@nxp.com>
References: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
In-Reply-To: <20241212-imx-ocotp-v1-0-198bb0af86a0@nxp.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733991891; l=3973;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=20rdcKqrSVYlqX+82KfkjLM6DPdHqIKtDAQ345wUgBM=;
 b=q47tND2W4Z6/ixNIGGJ8bwkJ90vGP8AepGMvEDvDYjnM1HiJhlrVxtYPkCmz7j6e2FGP4AUxi
 UOUauNDwBJ+D0SKDCV7srtZ8bI3eSz1Kkgq/7Ehl4wX0gKpDIe3du+d
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PR3PR04MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b9ea33-f85f-48e0-1788-08dd1a867f53
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWZ1ZGFYQW9MMWViKytsWXZiWUZ3RVFoQmJESGtla211NXlUSnBDYTZXZzh1?=
 =?utf-8?B?clpPTWhQUkR6d0xYNHV1K3Zpa0dHOFpXUUs4KzEwQm5YcUQ0bGNRKzhnbjZ6?=
 =?utf-8?B?YjNNSmxLVlppMGQ5UFlub0x4SnVRYzVhZlFMY0lHVVJyZ09GZWErdzVvSGw2?=
 =?utf-8?B?Y3NRSC8zaW5obG1JYmV6MDZkWTkzL0lUdDNlSEZ4djlwL2FwY0U3ci9aMWlT?=
 =?utf-8?B?UHRhYUkyWFVzejIzR3ZsY3hnODYzYVVMcUJPTTJPdk1SZ2hGeUhCRGVFUGNt?=
 =?utf-8?B?d1NzM2VZUGZFcUw5Rmw0bHlmeDlNdHF1UlNZdzdibDQwN3hIelpwZ0RFRk84?=
 =?utf-8?B?NXpLTmJBU0JRUVRkeElsUHNYWjQzb243UWdSWEQwb056YnhaWG1ZejdYZjhC?=
 =?utf-8?B?M1hiTEgzbDlPM0FEelBZM1paMmRuZGF4K1N6QS9RUjFCTDJtck9mMnpmRDFI?=
 =?utf-8?B?cXlBNGNuN2pQa2ZGb0lMRWUxMmFSMzFNODVXcTNCbm1SOFFGbTFQYlF3YVJq?=
 =?utf-8?B?T1lWaXJJQWxmTDhtRStSdDc3YVU2Vkt5OWRIRXNHc3llUlVrR0NibFozbndI?=
 =?utf-8?B?dm14WGNJdWNsVWU2U0d5c01GcFhTY0RqVzNYZE9YOEI5S1FZVUxZazVEdXM2?=
 =?utf-8?B?WFhTMVI1R2VGTXFpLy9NK1hwbHNORXdjQmpCSDFxVW1WT0dwWnM3N1cyenk1?=
 =?utf-8?B?NjNhLzNpUGJBbzRaaFNxekRLL1V6N05uOTcvUHZHNnhwcWxMMTF1OW1tYk1Z?=
 =?utf-8?B?clZnNExaVExJZER0ejNBblgwVUZaK0ZtcmpZV1VtZXluU0RjUkxFS05SMzFR?=
 =?utf-8?B?bUtGUXpxZUJmb3JMbEdraEJvKzBtRlUzWUd5OTkwVDBwcTRYOGViLzNTNTIv?=
 =?utf-8?B?MUsrOW9Xc09haSthd2ZqeGJLZTJmWldxSVNYYVM4dDU4VW9OcHRweGkwWTVS?=
 =?utf-8?B?Y1BxajZTSGE2Mkt4U2Zjbk9nOHhJMk15VDE2MGVTUzVPdk9xZFVxR0tLbGNw?=
 =?utf-8?B?NEUvSkNuOVk0UURUaXNSQVVsUVl5UjZQTWZGR1dGcHhiWTc0MlpFdXJvWDZN?=
 =?utf-8?B?bitKTGhKK3hqZGdxdTBnczJJVkZDK3I4SjR1QjJMVjdoRXBPZGQzbGtFV25S?=
 =?utf-8?B?T01hSFBhd0VMcjBhSWozU2pKeFB0ZGxRU2tiUnMrR2NDMnkzWTQ4QURPZW9L?=
 =?utf-8?B?d0FiWTAzYmZUZHpSd0RabDUzQWNNTVRRZkQycE1VMGN0L3Fjc2FIK001ODBi?=
 =?utf-8?B?WFI1RC9NankwLzZzYjZaY2dyZjR1eDZEOHRQd2dGVkswb0dKTTBGanQzbXdC?=
 =?utf-8?B?aWEyUEFsV01MVzlUa1BuVHlEMzRBbEVqNWtHc1JHK0djem5rL2IxUzlCNE43?=
 =?utf-8?B?dXZ4OGpqTmxTQUliMFFYbnd5NHpxYS9QR0t3ZG5IOFhmWmtZKzZrU3lmem9r?=
 =?utf-8?B?bG5PYnZwSkdJYlExeks2OGZkK3VuS1BlZHNKQUVlWXU4UEZHdnh0RHFLTGF2?=
 =?utf-8?B?RU9sQk1hT2dvNjBEVi9VSmpra1FkbElOWmdsUDhrb1doNEp0VkpOeUpKTWtL?=
 =?utf-8?B?dHMrOGNqSVRGbW1OOStqRmd3WkdTeTZjYVNxc0taVlEvekkybGVjdGNKYStp?=
 =?utf-8?B?WVc1elZBb3dadjlvTW9TbjNBTGh5S1J5eHovYVAzVUlUTU0yMGIwUVVnSDll?=
 =?utf-8?B?c0U3UExhTmVZYjh5RHpkSzliWCs2QWFXZnowV0tVMVVneWRUNjJja3VsOUJr?=
 =?utf-8?B?YWlqYy9XUFpvVndDa2UrUityVE9ydVNnNHJ6eXFCM01iL3dsUjF4eGU2Q2dU?=
 =?utf-8?B?ZFdtbW1BaHh2bHNwayt6VHNSTDhzNkExNGpHTDFnZmxrb0F1aXZ6d0VKOXc4?=
 =?utf-8?B?NHhUWndTbnY2Y3hBS2k4dTIzWEpWM1pnaWJBMlBNaFk0Z1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty81blkzSERQTjdkeUhyd2kvb3RLL1RqdTR0bENTaVNka3dvcmtCdXVpNWFR?=
 =?utf-8?B?cnNGMDEzZ3lrTkI4ZSt5dTdWQ0RMam1wS05zUmkxSDdoK3QzZzdtdXZ4L01Y?=
 =?utf-8?B?V0JaUy9OOGRobDRKWko0VCtkUk9PbUlwblpydDExSWpYTGFMalV2ZmowM2Fa?=
 =?utf-8?B?QTFpUUJjYWQ5d3BVR1FDeExTM3FEMjZ2bEk5ZmVMN2RBVFRwZ0dIeHFTZy81?=
 =?utf-8?B?N2ZVOHQzS0VtL2RDWEFCMk9oNTNYNUtxMWJvRFdHQ0VHTGpwdzRmTWpuekQ3?=
 =?utf-8?B?MjI2bStOR1JKYzIxSk5HQ2pQS1V2dHFTRUwvQVRYZlFwdURmWXpGdkxncmJp?=
 =?utf-8?B?S0V1eXRZLzJZc1B0UzkxUVVzQUpZWG1iUlp1QWFJMlJ6L0ZDK1VuOGwvMTNJ?=
 =?utf-8?B?V3JFUW43M3FUZTJGNjF2Nm9iVlVzNjJDVzhCVjBqbURocnR1OXV0dEhRc1U3?=
 =?utf-8?B?OVVCOWlyekhwdmhCZSsxdUVwVURWbGhVS1ozZHlpeTFoM0RxVXIyU21ob0hI?=
 =?utf-8?B?clBTbFZMRDc1UHZadlZyOXpvYzNTamE2SzZtdWw0azMyZ003YW80a2VIM3hB?=
 =?utf-8?B?SEtPc0NST2FueisyRDVkcFdIdDRDNTM4ZHBWZE5qUG9wdHk4VWZjMVNWaE8w?=
 =?utf-8?B?QTBhV0xHRDJBcTdYRnBmZEF2MStSNVhicldsS2VUVWpYcTZDR2EyVFdTUjZQ?=
 =?utf-8?B?S1dWU2YxYVV3eG9pRndKQU45N0R5bmdxUGNUWkp0TVVudkh6SnB1Q3h5R21J?=
 =?utf-8?B?SHJvaGZFNkpoVEhrdWt5ek54bi8rU3ZzTEl5UzRZTzI0NFNkV2ZidC8vRUV1?=
 =?utf-8?B?bGJ6a2tqMGRmTVpJVW50c3JMZTlFTko2U3ZpNWhaZ0lwRGdKVTVneGZnVkdH?=
 =?utf-8?B?cHlpdllsTm5YRmx5Z00vNkVTenk4ZmV4dWV5NmJIbi83bVpCVUl6ZkdTSG5i?=
 =?utf-8?B?d1R2R1h6cEtZdXFSUWRKQnpkdEhYY3pNMTlvNmlzWkNxMElGRmRrWVo3Y2RB?=
 =?utf-8?B?RFJkNHV5cUE3d3JsUGZadXF4MDI2VHJNMzRScXhkbkp1UitMeGxTdkR3NFY1?=
 =?utf-8?B?OGJMcmp5ei93SVV2TzdSbFI5OE85S09KK21SaG1nL0xSdXkrMXBDcnZoTVJL?=
 =?utf-8?B?S29weldMa2FZVHc1ZWVCeHlCays4aGM5MVRtb044WW5ROUh4M2FYbGJMdXll?=
 =?utf-8?B?VDVzNEE3ZDlzWGFLWUdBMVpyMnZyNEt3cUZFMEpHQVA4NHp5OURldDdlSW5i?=
 =?utf-8?B?dlBvOFM2Nnk3ZzVBcXN0RFE3T1ZNak5xVjc4UGx2NDBwSUJxVEpYZWlsWnVH?=
 =?utf-8?B?YlVtUUdJcE1QazVPUW9SNlQ5ZjBwOFVrTHMxdDN4am9MVzRkNngrQkE4ZDNG?=
 =?utf-8?B?STFCNGs1YmpoUTR6ZUlWcVE5YnJRUGJKMWgvdCtXNzgydHJYUUYyQ0x0d1FH?=
 =?utf-8?B?N1pFbmE3cktIUGtIYTM0OTcweU8zczMwQU9qUFN0REVWWkJXaDNIVDFPNHhR?=
 =?utf-8?B?cVRGY3RxWTNDR2hnSmtIb0JkN3NENTYrM1E3VDE1UjdLbnlYUlllVkxCS0Mv?=
 =?utf-8?B?Q0dERDlGWTVJdkhqNWFlOFNpWGVKMjMrclYrdDM5aEpEWmpiUVNEci9ySERa?=
 =?utf-8?B?SXI4VTBzUmVoL1FrckZacWxpUXdUSVc3T0trb2NBMWs1T1Uva0VhM25DRHoy?=
 =?utf-8?B?OHYyQmh4QUZ2S1dlbFhnQjA2YXoxZ29HcXV1SjNjdUF6aDRWR0M3YnJxZ0ox?=
 =?utf-8?B?RjRPcHIwUEdxWmJrS2pCVXR4bDgxV0xubThtdmlRNGVpVjM5WW42UitiSmdK?=
 =?utf-8?B?aUJ2WnFYcGNDaFNwcjlidkdPd1QveHFHQWRUMzFXaklrdWJqS0t1TmtIL1p4?=
 =?utf-8?B?ZXRhRzR4NEQzSkJpU0h3Q0l1Q1BMc05qR0RNazFHNmxITG8xZGZwL2NGcEll?=
 =?utf-8?B?SXVycDNMaFdZRDI4ZTYrYnJsMW1JVTFVRGZIUVFreXN5ckdjTXk1aEsyVk1H?=
 =?utf-8?B?dVBhVjQrNmI2dm02eWNOcnBaZFRvTXc4TC91QVp4Zk81WjEvSWViRnY1NWlN?=
 =?utf-8?B?YlZaZmIrUWw5SFJJVTBTRnJmNVpqejU2YTNlSENtYkZvTlFwSGV1R0I2RjhS?=
 =?utf-8?Q?rduBO5v8DF+xu5t4cNqZBkSe/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b9ea33-f85f-48e0-1788-08dd1a867f53
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 08:25:12.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCA+YSQV6kcOHQd7FRtBaC1x0MyYvIClyB+sBrY4qzA43KIcq3L2Pw8OgHChfG1taAetAxT9wuJmUPWH1CZgaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7323

From: Peng Fan <peng.fan@nxp.com>

Introduce "#access-controller-cells" to make OCOTP be an accessing
controller, because i.MX Family OCOTP supports a specific peripheral
or function being fused which means being disabled.

Add the i.MX[95,93] OCOTP gate index.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |  5 +++
 include/dt-bindings/nvmem/fsl,imx93-ocotp.h        | 24 ++++++++++++
 include/dt-bindings/nvmem/fsl,imx95-ocotp.h        | 43 ++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index b2cb76cf9053a883a158acaf5eaa108895818afc..c78e202ced22f1c278f7be827b71ba434832d2a7 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -54,6 +54,11 @@ properties:
   clocks:
     maxItems: 1
 
+  "#access-controller-cells":
+    const: 1
+    description:
+      Contains the gate ID associated to the peripheral.
+
 required:
   - "#address-cells"
   - "#size-cells"
diff --git a/include/dt-bindings/nvmem/fsl,imx93-ocotp.h b/include/dt-bindings/nvmem/fsl,imx93-ocotp.h
new file mode 100644
index 0000000000000000000000000000000000000000..6ef525173845fd4ee0e847cf5a17e53a14f71362
--- /dev/null
+++ b/include/dt-bindings/nvmem/fsl,imx93-ocotp.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _DT_BINDINGS_NVMEM_IMX93_OTPC_H
+#define _DT_BINDINGS_NVMEM_IMX93_OTPC_H
+
+#define IMX93_OCOTP_NPU_GATE		0
+#define IMX93_OCOTP_A550_GATE		1
+#define IMX93_OCOTP_A551_GATE		2
+#define IMX93_OCOTP_M33_GATE		3
+#define IMX93_OCOTP_CAN1_FD_GATE	4
+#define IMX93_OCOTP_CAN2_FD_GATE	5
+#define IMX93_OCOTP_CAN1_GATE		6
+#define IMX93_OCOTP_CAN2_GATE		7
+#define IMX93_OCOTP_USB1_GATE		8
+#define IMX93_OCOTP_USB2_GATE		9
+#define IMX93_OCOTP_ENET1_GATE		10
+#define IMX93_OCOTP_ENET2_GATE		11
+#define IMX93_OCOTP_PXP_GATE		12
+#define IMX93_OCOTP_MIPI_CSI1_GATE	13
+#define IMX93_OCOTP_MIPI_DSI1_GATE	14
+#define IMX93_OCOTP_LVDS1_GATE		15
+#define IMX93_OCOTP_ADC1_GATE		16
+
+#endif
diff --git a/include/dt-bindings/nvmem/fsl,imx95-ocotp.h b/include/dt-bindings/nvmem/fsl,imx95-ocotp.h
new file mode 100644
index 0000000000000000000000000000000000000000..2d21d1f690974d0215c71352168378a150f489af
--- /dev/null
+++ b/include/dt-bindings/nvmem/fsl,imx95-ocotp.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef _DT_BINDINGS_NVMEM_IMX95_OTPC_H
+#define _DT_BINDINGS_NVMEM_IMX95_OTPC_H
+
+#define IMX95_OCOTP_CANFD1_GATE		0
+#define IMX95_OCOTP_CANFD2_GATE		1
+#define IMX95_OCOTP_CANFD3_GATE		2
+#define IMX95_OCOTP_CANFD4_GATE		3
+#define IMX95_OCOTP_CANFD5_GATE		4
+#define IMX95_OCOTP_CAN1_GATE		5
+#define IMX95_OCOTP_CAN2_GATE		6
+#define IMX95_OCOTP_CAN3_GATE		7
+#define IMX95_OCOTP_CAN4_GATE		8
+#define IMX95_OCOTP_CAN5_GATE		9
+#define IMX95_OCOTP_NPU_GATE		10
+#define IMX95_OCOTP_A550_GATE		11
+#define IMX95_OCOTP_A551_GATE		12
+#define IMX95_OCOTP_A552_GATE		13
+#define IMX95_OCOTP_A553_GATE		14
+#define IMX95_OCOTP_A554_GATE		15
+#define IMX95_OCOTP_A555_GATE		16
+#define IMX95_OCOTP_M7_GATE		17
+#define IMX95_OCOTP_DCSS_GATE		18
+#define IMX95_OCOTP_LVDS1_GATE		19
+#define IMX95_OCOTP_ISP_GATE		20
+#define IMX95_OCOTP_USB1_GATE		21
+#define IMX95_OCOTP_USB2_GATE		22
+#define IMX95_OCOTP_NETC_GATE		23
+#define IMX95_OCOTP_PCIE1_GATE		24
+#define IMX95_OCOTP_PCIE2_GATE		25
+#define IMX95_OCOTP_ADC1_GATE		26
+#define IMX95_OCOTP_EARC_RX_GATE	27
+#define IMX95_OCOTP_GPU3D_GATE		28
+#define IMX95_OCOTP_VPU_GATE		29
+#define IMX95_OCOTP_JPEG_ENC_GATE	30
+#define IMX95_OCOTP_JPEG_DEC_GATE	31
+#define IMX95_OCOTP_MIPI_CSI1_GATE	32
+#define IMX95_OCOTP_MIPI_CSI2_GATE	33
+#define IMX95_OCOTP_MIPI_DSI1_GATE	34
+#define IMX95_OCOTP_V2X_GATE		35
+
+#endif

-- 
2.37.1


