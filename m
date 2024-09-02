Return-Path: <linux-kernel+bounces-311044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E1968442
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4231D2842A4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE3A1D27BB;
	Mon,  2 Sep 2024 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eq+6fZoR"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4D187872;
	Mon,  2 Sep 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271864; cv=fail; b=q7Zv+IHFw47m3yoXsjzne5SXriLknteldWWxeHBoObaFssq4m/8tejG1iL6To7D6cWbInqVtT579kekdK2HxjN/XGsIdZQ5ogKyVPWFZKi/tIc/5D4YZT1qG1lYWv6IVabQQoM07OaUbg0snt3MdV7rR6A6x1CriYBLX8P9MnL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271864; c=relaxed/simple;
	bh=1DZSX8IQiSvGaYZuA0r5nnSqDSxAiIuXs6fnmC24Gps=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dFij7ZriVQ17IiRo0kJeyb2zcnfiKESeCzZDvRW0I4Svi/6i1p6UtLOBsLT2BYO39cXPEj8qTKrBne7kd9qY4Zm+dkJ5mhXLuIQmhf8ZXZh2DdZMKcXPKretkId0IilrtYFykBgWJmd0v9jV+mV+VtH8iCydn7ehGb8RVueODAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=eq+6fZoR; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgsiSQ1OfkEVEeFl94IqaoMSVM7DqwzPankkEPKiOPdyZ9fRSgZ0K5tdJBObYpcldcpw6rYDROK8KNZn/b/n5PQBa7o5zfOalWRS5bReF86n+VWyldvqoc00WKiHs0524Rf8GQoI6vBJj12TxtRWIH5ceQ4/Nj2pGKQsekg8Q092Waf7mpVrUOm+mivWW2tWKBtgcAfIVoe+oyh1zBcD1R0IXpbyWcqJ6IpOmwq2+cFotKrxyxJpAQhj/V5XHlKkTpAHtoPHcfZ4dGFofYvuNFS5KWQQ/nkGXCKvmPrrVQCJpa6uKaUSlNqiJdUc7NAWENKH2OPHKROtt1ciC+xC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWJS9qCYhBLqOQHrN3mOoXQ2VIQ+JYtGCEgIr7A/qbo=;
 b=aeDyKTY+VKS6eO95v/3NsG2ft4dwym219aCvNOS6jLVq90VNoH0BfpoX17gWCtXMurA6lqWv+E7wCpp5ZQ5clK9e/7XeP7BPRxZvcLs/5G/d/cx9fnVcIxmVNRypwleEtOR1ZlYWy2jMHFeVSFrtzB5DS4hwYTTLIG3qedx+QqDh4cYWnCpd1xCw38UkTcJ9lTv+RunxUbnjUJ2RBjkSHnZxi1hGX/xmXKaEF+NwLkxPXrri1BwGBOzXnlK/LNT4XZGboK7pc6ZxrqkjcbNGxLpubAdy0Dih/nSmw9T+3vpB0/tb35InFPYTzVD98WdyaJ9OMeT+IKZhXwf7HBh6Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWJS9qCYhBLqOQHrN3mOoXQ2VIQ+JYtGCEgIr7A/qbo=;
 b=eq+6fZoRdNw/n6NTT8KiFRITmLkgU1eWMKnkpNLbDDY2a+9S9sGGNJeHrBhL05HUq14KSrb7MJPGHylUzTdP6Wh0Rj5SxDgTr8luMZq+hx+VvDP2YbF0j3JRMAcBGu2QSWTGdZ7pjjJfGixFmNSZU+F5z3KTZCsuoZDKxuCC/gb1vJx9H1gZgjG0kJ9lGUcXg5cDPzykSHCSk6vdEQqZ/mcpqqJtaiu/5FK3+doR7GTl47TbRBB5/EAdHrX4bizZKJr+TI73d8gBP8RmfyhV9X5nMizbAQ9C4Decep2Tslsm+alJcTUsI6GqJ95Zk8GxY6aEGN2TOOd7XWl9kM8AGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:11:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:11:00 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:29 +0800
Subject: [PATCH 7/7] arm64: dts: freescale: imx95-19x19-evk: add lpi2c[5,6]
 and sub-nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-7-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272374; l=2753;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=WYRaLiM/Cb4fxjepabZ4BHNUcNHSVGYo0CPKW5VPn5U=;
 b=8UIciWvLT2QMyGPnH0kMN5Ck/yuwrNJ0i++BGRKTUPWa2p7Ksv+6UdmwCdmHtLLkYP3Wj1nXv
 cq5+gy9gB/DCQheMyNrSxxl0DHA3RrzqLVfCqPDOxJNyGw6LZAYvxdl
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: 07775ac6-5a21-4268-15f2-08dccb378b93
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?US81QVVrTXJJcjFLQ3BkN2grRXhraHM5Y2p4RWx5dEQxcGhIdWlpWnQ1M0Fy?=
 =?utf-8?B?ckNDbE41SUF1SmthSGl0M3o1eFJ4YmErVmo3aDY1Q1MvQ3dZVytFVkRmemdp?=
 =?utf-8?B?enJXVS9zS1FrWkJWLzlvdUhwU1d1dENpbFdFZjZaNlBxYmhFRzdGOWpwMVlW?=
 =?utf-8?B?NituU2FTTTJCSk5TbzNoSE92dUtSWE91bWh2b1VUamNOYmJNSHFCdlZ3NkJR?=
 =?utf-8?B?Ym1XMVJhWTBnNzFWNTVsTFFHUXQ0SmNTMkFzTlNNMzUvRHRkcmpPU2Fjb3po?=
 =?utf-8?B?Y2RRaXRnQmRjUWltL2haWFcyeVE1bnhpbGtVcUZjckdPZm01STNVbGl2TjNv?=
 =?utf-8?B?SXY1b3hEa3JKT2kzakExVUVUbEZvS0dCRzluTVprbGtBYVBNODRtOHoyOEFh?=
 =?utf-8?B?V0hzZWNIQVdPS0J6V0FSWlJGSXVncmJFNEY2UjZjNWg0Zlo1SkVIRmZZWUI4?=
 =?utf-8?B?NDJVNUVvWlpJVTlpT0xWSlBsaVRRWHpGalpDdXU1Tm81MUZVMWR1WGM0Nk9N?=
 =?utf-8?B?enVxam1SRS9WTEhZdWkzd09xTDlpbmgvcTY1TVpVMTNicWZKMndRVTcvemsx?=
 =?utf-8?B?bUFHYVpVRkZxWlg4ZHVWT0ZXZWtHQ3JLTGRPTjRHVXhhaWZJZVJwdGpiY3g5?=
 =?utf-8?B?VGhlTG1wbTVMbU5QS1dsWGhqdjFjM2VQV3Y2VlRMa2NJV0d5VDE5WmF0eEtj?=
 =?utf-8?B?cDU4MFNVYSs5VmVyTCs2ZFJnVnlsK2NDckdBOUw1VnNpaGJFaExOWnZLMC9x?=
 =?utf-8?B?WWJBUFZESis1UFZSeWtNZDdQNW1icTd6ckhxWllxWU5GNWRkMzR0TFk1MXV5?=
 =?utf-8?B?aUg0YURENS9VZ0Zvb0JkNXRsTlBTT3BEeEFrMHVnVllyd2tmeXFCa21KbXRK?=
 =?utf-8?B?UTkvZmlqZ0xsZUFQbUlIRStBSHN0RGJDdTF2UTlvSlIyTUJUWk1VbSs3YXpB?=
 =?utf-8?B?YUVwUDRHbEZXKzlKaUZlWUpwRC85TmtLUUZNQk9tLzY5d1BQdE14azg5WEJT?=
 =?utf-8?B?RS94dHFTRXNKZUxCM2ViN0VVY1dUNzdyUEhCaDVGRTNYQXIyZ0t2QkNyeFlQ?=
 =?utf-8?B?S2xPY1ZKOGMxVVY0eTMvcXplbXl0dXUyMUhnQktlTk9BRTNld3BwUEhZZWg5?=
 =?utf-8?B?NGpUQjhHeEdqbGMyYmJENWxWdzdDelptUHVuWEtYWGExeTc2NHBtcmN2TklB?=
 =?utf-8?B?bnBmT3R2R1JGMHZ6bVZuRkhNSkJNVjRXR0J4clc3aTV4QWV2MDYySWpYdkcy?=
 =?utf-8?B?NGhYQ0ppUlRqVWZETWozUmE1NCtXT0E0cGVUdmtrcVFoUHFSOVlvUllmOEZz?=
 =?utf-8?B?blo0eDRuOGFFT1lnUFZyci9BeE5LbE5scDdtaEhCa3R6U2lIL1NTN0RtVHFN?=
 =?utf-8?B?dGRpbVQ1cHdWS2NJeEwxaEluU1Zwb2RmbHBsalJjVjQwRXhYaGZ4OUFYbEhB?=
 =?utf-8?B?dWV0Q1dPYzlHVE9id3YwdHpzby90dUsrbkpyZm5CQ0FyMWY0OStjUFJES01y?=
 =?utf-8?B?MTdlVVdDMDhrNDUwem9aQzZleFFhYjVvOWx4azZHaVJXOHVOVmxJNFZBb09m?=
 =?utf-8?B?OGhHY2czUytnZ1dKNm9oZGZDcDJnM0RWK2l5LzFPVXRxbWsyb0kyNGtVVjhC?=
 =?utf-8?B?WDZ3WWRIWnJGemo5Wk1wWHZ4Ujd4Nm1JZXVxTUxlVzRPdENOSXdZK3R6MzMr?=
 =?utf-8?B?VHFFWnJ1OXduN3RnczhQTFNQUm5OTUJJZUxyTUNKUjRyUFgzeGtlcTYwQkN0?=
 =?utf-8?B?MFVwRUpkbGFPOUFxalVEVGN4Z21RekR0UG9QbU1MV2JiUGtvM2hPUjhGK0I4?=
 =?utf-8?B?NTQrblZjUUF4YjJsb3NvK2JsNk5rY1doblJlcXZiRlh6UlNkb3d1WHdkMU1T?=
 =?utf-8?B?ejJTdHlYYU5EaC84a0ZaZDdxYmNQTTNHMTVzU3VaVXZOYnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2JRTUQyZVVRV29oaEVvcXI3TFJHTUNjOU9VMXZuYXlJRGlKWHArS2MzdDZo?=
 =?utf-8?B?RGs1ZlpUUU9vd0VpclhNcld1dWUrTVk5WnZtZlZvMStXR1U2S0FvcmI2dGNX?=
 =?utf-8?B?NkxTcXhkSzZvRkNXZys3V0xKanNwY2UySm9MV2tkbitOZzdNYlZjTkxuWmg2?=
 =?utf-8?B?NHByNkJ4bzk5bitsS2hZUktmY21HZTE1VFVZWlErcDcwQWJQaHZ4Zzl2MGpo?=
 =?utf-8?B?dXU5V0Q1QkIvWEpFUFpkbjJrSWJxaHdhOWwrcjFXbG5qalhCUWlrNE0yUVlX?=
 =?utf-8?B?czE0bGZ6cmR5NnlZSXhpMjNJdmRVR2lQNkFkdTJBZ1l6OVc4aFdlQlBxNTMy?=
 =?utf-8?B?bDI2aVB5VDFscXZBK2p3ZzhjdmdKYTh0UmVqeVpVTEZFUXFxblpDaThGMG9K?=
 =?utf-8?B?cWpKd0FNQ01uZTBMVWJCTWYvM2xZNm9PU2FvVFQ4bUF3Wi9mcC9xVEdxOTRj?=
 =?utf-8?B?V1I2ejZwNXd2TFh0MGIwYnNWaDU1SHdaSUxoOTI1KzN0MjNzN2w2L3R6L1lV?=
 =?utf-8?B?VnV4VGQzcC8zZitHMSszR0c3U0xkTlRJZXhMTkJlZUh4TmxlNEpsZ3pHa1ps?=
 =?utf-8?B?NisrdEY5UjdjRGs0cVBnWTBSWkJwbHFKdDNvVklCWE9HbWhyTkliTXVVUmVL?=
 =?utf-8?B?L2tsVGsyZnlDNHRPRlBFVWxLQWM3elo3MW5pYWZ3Wkx0dGg0SHFWaWpQeDcx?=
 =?utf-8?B?TzFLaXgwU2VqMVFZcUIxU3ZwQmpEV3NET1NyTWE0SFE3eVdSd3BzeTVBaFpi?=
 =?utf-8?B?YnhoK2t5aHBUcjFDdHVSWXk5MlZ3VitQKytOY0xEL3ZYOW5DTEdrNGNNc2hr?=
 =?utf-8?B?TEpCQytHMzd0MXhFaUxKb1dOSURmem1tWmZUeEN2ZXdKbk91REtBTjFITkNn?=
 =?utf-8?B?NlFSc2diNWdhTmdMNitqTnlzQzV3Y0YvRkIvQk5hTHRabzNndVhBRmsvcXFz?=
 =?utf-8?B?VkZ4R3h3M3VkNlZyZW9xdE1oRnFqcnhOaUs0TStOMG55VDd2YlRJL0piRlpT?=
 =?utf-8?B?cEV0WEF6b3dlYXVNZ2E5MVRxaTRHNm9xc3gzVEw5TGhsOW93eXdDOUg0SU1O?=
 =?utf-8?B?N0N3OEhPQS9ZTmhVZ1kzSlJwdzV3VXhyQWo5Und4cWhvNFp0UlFObmhwSmpX?=
 =?utf-8?B?eE1nd2RGUUpIMkZrREM4bmo1Ykl5eEZxMXdaMGx0QVNzaWYvRERIVWFFL3pV?=
 =?utf-8?B?dFd5cElHWllXZ0JMeG9vcFhuSlJSci9hTEJGMmZ6QU5yOGU0SC90dVVtYm1Z?=
 =?utf-8?B?b0hCMDlVYndWY2NHL2NTMzNTV0dabWthVzRVaXgwTm9aOTNkRW5weXcxRXV5?=
 =?utf-8?B?NlBITmduWkxkeERSdFdFbWgzeW9iSlJzaWhyalBuVWNIZWMxZUhNRjlva0dU?=
 =?utf-8?B?THJxd3YvdUZ6cDcwNFphekF2WUFnZnoxVHdwNVl5ekJOSm8rVGNQM05yWm9T?=
 =?utf-8?B?eWZaOWd6S3JpZXB2eFAyV1A3ZGU0eXZicEhuUk1sZVFMMzliYzJhZGhVaVpB?=
 =?utf-8?B?c3FmUHBvTGlGT0hqZ3ZsWHBMRFpqWjZpZ0dEbkluSC9DeWZDTVBCckp4L01Z?=
 =?utf-8?B?am1leUpSMXhDMm9RRU1MRXJrWnduRUFtbFpwN0hxS0EyRVpqS2tsNTREZ3gy?=
 =?utf-8?B?eWxDT2xuRjhYb0IrTUltOVlsbytlM1I2Yy9LejRUcHJZTW5DZ1hUY3ZNeVpP?=
 =?utf-8?B?ZE9SRC9QbWNKUGk3KzdMaWhuMCt0eWVxcVUveHN3L29YV0h4bzFTbHRtKzJs?=
 =?utf-8?B?c0doQXlmMjM3Q1hDenkvQSs5QllFZzQ1aTlFMjhzZmMxOFo0cE5Qb0MrVzZh?=
 =?utf-8?B?NElDT0F0aU0wMGVvSGJkVW5GNFNzdnBhOVFqSE1IY2dTaWV5Y09VOHJaOEE1?=
 =?utf-8?B?eWhkcXdhSVBuUFZtalVDSWNvWVBUeFdQay95WXFKTDVuaHEyaFhBQ0xZZHlk?=
 =?utf-8?B?cXBQbE9qdXdCQktsZW04eW5QK3BERlh4Vi81ZHlzNmFCYmd2RVdjNmF1Z01T?=
 =?utf-8?B?TXAwc2pOOGxqK2dhNDlodlV1TUwyQUNTTkREbnRTSThUaWhFN1UzWXRxQmRy?=
 =?utf-8?B?dHVOSS80UVJHejFNa1hERG1kQ29lNDFxUWNKQXJvdzBYY29MRG1oR0J4S1dx?=
 =?utf-8?Q?PVVHUv9htTNx8ildI3R2eH2uA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07775ac6-5a21-4268-15f2-08dccb378b93
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:11:00.5876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IQL/Q6wSV5+/m17ocvmkG3Xl5dcSOpgI9HkThJHU76gVhP6Yz3Kof0I+CzJC8cQjJ8L4gV5UqWA5biD4iTvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

From: Peng Fan <peng.fan@nxp.com>

Add LPI2C[5,6] and the gpio expander subnodes.
Since we are at here, also add the alias for all lpi2c and gpio nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 69 +++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index 5101cd171e09..64e9caf3089e 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -22,6 +22,19 @@ / {
 	compatible = "fsl,imx95-19x19-evk", "fsl,imx95";
 
 	aliases {
+		gpio0 = &gpio1;
+		gpio1 = &gpio2;
+		gpio2 = &gpio3;
+		gpio3 = &gpio4;
+		gpio4 = &gpio5;
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		serial0 = &lpuart1;
@@ -241,6 +254,42 @@ i2c4_gpio_expander_21: gpio@21 {
 	};
 };
 
+&lpi2c5 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c5>;
+	status = "okay";
+
+	i2c5_pcal6408: i2c5-gpio@21 {
+		compatible = "nxp,pcal6408";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
+&lpi2c6 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c6>;
+	status = "okay";
+
+	i2c6_pcal6416: i2c6-gpio@21 {
+		compatible = "nxp,pcal6416";
+		reg = <0x21>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <28 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6416>;
+		vcc-supply = <&reg_3p3v>;
+	};
+};
+
 &lpi2c7 {
 	clock-frequency = <1000000>;
 	pinctrl-names = "default";
@@ -427,6 +476,20 @@ IMX95_PAD_GPIO_IO31__LPI2C4_SCL			0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c5: lpi2c5grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO22__LPI2C5_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO23__LPI2C5_SCL			0x40000b9e
+		>;
+	};
+
+	pinctrl_lpi2c6: lpi2c6grp {
+		fsl,pins = <
+			IMX95_PAD_GPIO_IO02__LPI2C6_SDA			0x40000b9e
+			IMX95_PAD_GPIO_IO03__LPI2C6_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_lpi2c7: lpi2c7grp {
 		fsl,pins = <
 			IMX95_PAD_GPIO_IO08__LPI2C7_SDA			0x40000b9e
@@ -446,6 +509,12 @@ IMX95_PAD_GPIO_IO35__HSIOMIX_TOP_PCIE2_CLKREQ_B		0x4000031e
 		>;
 	};
 
+	pinctrl_pcal6416: pcal6416grp {
+		fsl,pins = <
+			IMX95_PAD_CCM_CLKO3__GPIO4_IO_BIT28			0x31e
+		>;
+	};
+
 	pinctrl_pdm: pdmgrp {
 		fsl,pins = <
 			IMX95_PAD_PDM_CLK__AONMIX_TOP_PDM_CLK				0x31e

-- 
2.37.1


