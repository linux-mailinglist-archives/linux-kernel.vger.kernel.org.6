Return-Path: <linux-kernel+bounces-314817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C096B970
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 12:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA0A1F2947C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230F21CFEC1;
	Wed,  4 Sep 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RNeqIlqg"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013034.outbound.protection.outlook.com [52.101.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EA31D0DC5;
	Wed,  4 Sep 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447352; cv=fail; b=oLwWLEioIowphlJpeOUW/RK03JsJq8lRaYiY5okQPgk5mHX9291Qz/H8k3BbbukHzqgeGcidTHIJsJmvNlc8XhZXobPx8MB77rg9Tgqm9JxuQ/b7Oqvb1fygjGRouoHsa3ZW8PuoV6J8bL5qdIxTtIoTteMmIhtNQUB2ARvwDDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447352; c=relaxed/simple;
	bh=q+gUGy+FmGxk4iq2NML6GEsZRCu6KE/A7UL38oGgx34=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FWHMEy0RzlNnu4IemV9D2xheAE7ewDelJwXcVqWUp1j4JnH35cfFt7fl0JAhT1BJAYFNrKFSaTRZd6bsWFfWFp/N+aY3gdIS74lvpaWpEcAWI3HUrWTwa02Y0GYP6R56qdDFHDDsdfNSQvtM0RVOmx4EPGvmeJXyJ5Z751fmyiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RNeqIlqg; arc=fail smtp.client-ip=52.101.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L582GIwMvagM6aBxk0v7BDV3thXXHjNkFOo1eVUMxkT8DizHhDtaxTY8m8SRAR/szbgMOGtmS9CjtypxitxBr7W2tBU7yVsmSzlV3ypkpJRC1/f7sJVNRCSkNvCZ2RBGcb/Sm98cPiQ5B6cYv/TPOb6NI7HEhTySWPL8We3Euvz2DWepoC5Lbsx3lBlH/DzGAhwOtOPTdkmJoL1niW5/3eE8erPWYxjySmTJwC0Gb9Ptu+L7f05ic01rNZkQrw9S8C2C56VfyLfwiCQIsTCeRDRCYaZy5xoZ32JU0Q9LAi6HI3B9cZ8jm0gAnOs3TZasHk/I7A6K/ajuEY2ZH3Y4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwxzQQZGcmZNJ71J2TrEumWoXPGdP5Wwc3MWbhw1uwc=;
 b=Sf4DDH8W220+QJgyXIyXsmlpYg8ciRXbmztPvxt6oVy9yIkM4JINWUwgM+NLksWtnJK6GzgA8OE8stg1WMKRo3VcMoLQ4x+uvLCWhQ6N8+HQxn0OzsMMX3szSDN8Y9xZssBpbkzHMVtD1tj558zPY72ceiNosRr5aTkFkJVtskFk8t+N6wo1WIWcck0zRCscejoMZ+MyTzWmtbvekjaRMKx2oQRG+PRHcALdN4cgz1bfsG+6pJFA7sVfhWIYou+1HPeBgi70R5kgCjyEJlI7JkqhfDOzL0uD4/nARDJHCh+deZQQ7zBsEucJFW0sLEo73UuePXYGS/KfCO43450kcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwxzQQZGcmZNJ71J2TrEumWoXPGdP5Wwc3MWbhw1uwc=;
 b=RNeqIlqgtMVJL+WEV3KwH2f1G4GrctB/jUHwG7gI2fJb8ywvlEcLMRlQeg0zo9MGF3QdJwLaITG6v4g776wrohuLjtSzUzP8uhMe+3yVwxeGVyHDqQM7fNWvJFWx/v+yusS+3AyJZFwEttK1mP0gvBCCfi6FIUWCzHeH78gCK2TFOjfRHR8SR7bzqcMpCP3K2ZoqQwdteKdhUlx0MZ+Qw+KCGIeSqztrLmaGPTChrWHdP9A5w+jk+NiH5iqu+/bDeHwt7NOfrraRGwIk4x17SrssD9JMzE48Zve4p9qnJOOIpK5z8HR+ujMSskQQacJIF+Hx1d4BrdGkUhS127l13Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU2PR04MB8583.eurprd04.prod.outlook.com (2603:10a6:10:2da::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 10:55:46 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 10:55:46 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Wed, 04 Sep 2024 16:21:20 +0530
Subject: [PATCH v7 4/5] firmware: imx: add driver for NXP EdgeLock Enclave
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
In-Reply-To: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>, 
 Rob Herring <robh+dt@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725447104; l=38286;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=q+gUGy+FmGxk4iq2NML6GEsZRCu6KE/A7UL38oGgx34=;
 b=fXNa2E5n+IWrnA7UYSlUujZB0Ylv64Wm1ds+xIFlNB7DvRBrbTgpmeAIFibpX/wMk+hzAx0BE
 PckTsBoyag+CFac5W1ltsFzYQGEgOrCASVCk/fl5B6EJXCYO3xS7W8+
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|DU2PR04MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 87592c9f-39be-49b1-73f3-08dcccd0212a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVBUcU1xZHhNWUpCaXlDUWt6SEgxRTllWHJjdndLK1pkK0ZXS0puODFHU1Uz?=
 =?utf-8?B?Q0hraUhYbXhnOHhwWlgzVkRpWDc1b3VSR25GYjBsN2U4VnNaMkdmbzNXeWhv?=
 =?utf-8?B?K3pSNFBCNkdtZS9RRTlzQXllZGpwMEpZQnM5WDRKQVV0UVo3TEVpWWFGdk9y?=
 =?utf-8?B?RitibkRzQzhYeHFsY3J2RzRlUkdIdTJHUDNuUjlFWHNiMzZoWHdnZFUzWUJa?=
 =?utf-8?B?ZHZyY1ZTUkNJcnlrSVF3KytzNHBTdHkxTUt1YytpbzZUWS9KZkVPWDlxNmti?=
 =?utf-8?B?VFViMytHOFdTS0IwZFJDSDVmRGlubEZNaWV1eTc0MC8zK2l4cENKaHZYQ2hN?=
 =?utf-8?B?RHRvWnk1ZnJTL2ZKSUljU20wZm0xekYyUy9qTUwxbUlDcGk0aWp5SVAyZFdo?=
 =?utf-8?B?Zjd1SjlMYmdRZUtxbTY5ck5kaFNoNVk3QkR0aldKNmhaYlRabDBjWTFtRTZt?=
 =?utf-8?B?WjRJN1hVaEVCMCtmd3R4R3IwdjhvdXA3RjUzdnR6L2pEeU8yYjFMcmprbWhU?=
 =?utf-8?B?RlVadlR6U2ErcVRsc2JrUStsdVNXWjlTQlRaTUw2bXhVd2lRUUJ6UG5SaDhG?=
 =?utf-8?B?QVhWWHo5eHRDZFI4a1NlRk82UjFLQ3lGUnZMb0lORk0wUys0WUlQM01nODVQ?=
 =?utf-8?B?M25rdFVQNXhJcDFGb3JKTm1MaWtGZUVPL20zV1N5YkFheCtvT3g3bUYxckxw?=
 =?utf-8?B?NHFXMWQ3N0wxaXhDWi91NTBXMlppWiszMDJNRk93L2xkb1F1dHB1eVJ2d01m?=
 =?utf-8?B?UnJoeVFIWGY0VVk2OTZhV2pic2ZJMnRIQWJ3c3FmM0xJMnpjSVhlLzY4Tjlz?=
 =?utf-8?B?UnB3TURXTFBVVzU4VForQlpDRnQzTGYzNkdIcFp0bitZRllwWFRGeUhFZm9u?=
 =?utf-8?B?alQrRWJwdkVOL3Q4SU1Sb09FUGh3ZE81WmYwOEFpTHZGZWpoUUladWlRcHZ6?=
 =?utf-8?B?cWQ0R2pHK0VPYTExRmtqekNNWk82U0hRaEp2SUtNbzVyMnkxOTltK0s2MTR2?=
 =?utf-8?B?UU9oVUFEbmpJaHRDZEtPUHBUckFabFdYVS8yb0l0a3NteldCOGE5NEJ5TmZ0?=
 =?utf-8?B?K0t2ZE1PWGQrd0d3RUh1d0tTdDByWW4rQWJtVVBnZjROMFNZc2lGWmhKZy8x?=
 =?utf-8?B?T0sxQ29GZFlDbmZDZVZ6enVabDNaT2RpTUk5MzlrMWR1NEVhbTZHR2NweHJ3?=
 =?utf-8?B?enBWditIckR4RE1zTlEyZFMzWVZRUytLUW1GOHBzNllkMW9URTFOT211Y092?=
 =?utf-8?B?ZjEybitGcGhnNm80elFPT3NaMVk2NDZYTll1RzA3Wlc3RFhXV2JlM1BtYllr?=
 =?utf-8?B?MGJ5TXZiSDFLcDVUVzQ4Nm1mbGtwenliN3Q5UFhIdFdTdlRHMWFpd0NlMmZJ?=
 =?utf-8?B?VThlTTFsSnZMR0l6NHljWFdwazc2MkVjaEFQNzJ3VnAzbGZya29Oa3B2Nkcv?=
 =?utf-8?B?YzZKVTg2R0ZMa01tZG55ZTIvREdjdTcwbDhPVEsvY1dLOFZNRzBudDh3L0ZS?=
 =?utf-8?B?Y20vTXNwdW9ZQnBkNUxYYUJPVS8rQ0RWNzJGeGtla05pQnJUOWFBR3FLMmd5?=
 =?utf-8?B?UzVtcEgyL3dXK2diV29EZW9rbjlzclRTaElQMnk4bFRKUmNDb1N4bExsdnlz?=
 =?utf-8?B?UlZicjk5TklwYllhWWNqOXJGQ0NwT24xWk16S0pTWTJVOVIyaHV2bHpEMHFD?=
 =?utf-8?B?TGdGNnFLUURwMklwRi85RHlpSm9WMkQvcFAzaFNyTDhrQzdNak5mYWozVWln?=
 =?utf-8?B?MWpHdnFsdWxWK0RmTmhDSFRsaGo2a2FRUGxlbmVsRWJFT0orQjR0RGtVZkgr?=
 =?utf-8?B?cTRrd3J6OGNjdXZVREpzWFFxTTh4VVVUQTkzcXhUREJxNjFtUm5QNGhWRndl?=
 =?utf-8?B?SndsMWpvWURxMG9iajlybUFCTHJaZTdpS3N3dkF1aHIyZmlTcGRzV3ZTZ3Vx?=
 =?utf-8?Q?ZFB23V9g2JU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2pISmN4bGFSdlc3aWtPYXA0TE85VmE0YXRBTDZBWkt5a1gxdUF0SGlHeTBF?=
 =?utf-8?B?QTMwbUM3ZmVoTlBaTGs5VHNGc3ZWZHhyaU9ka3QrZ3Mrd1plaUMwY2kwQTM5?=
 =?utf-8?B?Sk9EWmpNUFJFZURxWk5GS0o1RkxCNFAySjBlZ0dBN2M3S0k0a3VXRU90V0Ft?=
 =?utf-8?B?c0VZaFVoOFRBbzN6citCcTI3bkczN1gwUlN6Tjc0aGJtTkN3TGloaVBEWk5k?=
 =?utf-8?B?a0kzc2Uxei8xTjFoRlhNRlphVlhnZmlvamJHTUYwTThDSEVhRUMzM2VNSzIv?=
 =?utf-8?B?cHhBR2h1Z2h1alNVR2FESEVDZWErYUFZYjJQM01NNkhDRmhrUUtRUjQvL2I0?=
 =?utf-8?B?aTdNYmpGazB5dDlLemxZaEVYaDg2VWNmcnV3RExzd3VGUDhRcUV4M0MralpI?=
 =?utf-8?B?MmJrRHE1QUxZdDJyNm45Mjg4a0NZMElOVURkVVhzZ2UzTFJMRnhTSmtSZFZB?=
 =?utf-8?B?eUFCS25GaktSbEdNVjl3QUxUbkxDeDRPQVhTdkVPSnRwOGV4dzhNb0R2elRC?=
 =?utf-8?B?NXJ6ZUp0N0F5c29zNDdQTk1tUGJCVk1YNnhKWm11OWZiR2M3ODJDUzZWaENP?=
 =?utf-8?B?d3UzbjF6WDIxOHFCVnRtamVHei9kOW9OY1hIQytHTW5YaDlyZEpBcFF0aWkw?=
 =?utf-8?B?SWNrK3RxanJZNkR1YUZKUExEcFFSUVBCN05JUG45Vm9pRUhBYnhsTkVPSXda?=
 =?utf-8?B?OG5PK0ZVTWd2VEpIUVB5STZscUFwOWdhR3YzUkdBdTdHSE1Rc3NGMVhPLzZZ?=
 =?utf-8?B?dEttQ3BoeTZBNHZFVmE3U3VsZGlkM2VCL1Z4M0xzdXlCaURCNlp2YW55YUt5?=
 =?utf-8?B?VnVPa3hScTZ6bzRJc0VadGtvRTZSZkdySnhuNWFVTndONG13c3RVTFJEYXVy?=
 =?utf-8?B?WXJmUXduZWJSaG9UT0lhK3NFOEMxM0p3TDUycXhFeG9BR1dVQ3N0QXhFcEFW?=
 =?utf-8?B?bTB2aDdzK2Q4cTI4QWs1OXg4M0ZZWGpUbm9zVUhXU282QkhMY0NQeDRhaVhG?=
 =?utf-8?B?RllPUS83R284RnBRS3dqVGxWeEZXNXVqdFV5a2MzSFJhVHNTZFFZcER2cUo2?=
 =?utf-8?B?MzBIMlVUTVdhVEdzSE4ycDZpTHpSTTErQmZrK3FWZ1pHWmNCTzFXQTdCcyta?=
 =?utf-8?B?Rlo4OUwyV1VGakR5QlZEN0FCWXJTb1RCcGtZK1dqNTdxc3ZucnFPMlpSUnVO?=
 =?utf-8?B?L0lacWJHSUNzZnFVVkRSQkFvWFA4eENKaS81VUtpdGh0bkFRL0UwU1pDa2ky?=
 =?utf-8?B?QVNiWXl4T2pwSk5WWmF4RHk1dmJmdkpSWm1vcDNKNVIyTDhLbWVmSkZxNS9N?=
 =?utf-8?B?bEc1UktqMEgxN3BhVkJkcERPNEZYQmZGNlc2WFc2OEtsQWUzbzZrb01Ubk13?=
 =?utf-8?B?OG4zRXpCcFpYVEJDMVowWDMwU01MYy9HZURzRUdzT0luZjR0QU1rVW1YcXFJ?=
 =?utf-8?B?aWVWVlp1SlhWcVNNRE9KM0tOSUU1akRSWG1pRmpWUzRpdGVodUt4eU9WWHNQ?=
 =?utf-8?B?WDZXYjBOTDhMWTg5dmtPQkkxRUNoRWpaSFJSWkFUajV3Q1dwdlp5SmJuOFVK?=
 =?utf-8?B?UXBXdWlkK2t1MlNUZFNGcDlYNXRWbEtCUDBra2R4VkViZ09oWXB6V0lNcFB6?=
 =?utf-8?B?Tm8zRHlyMTR5RDJsVGtsMEtnVFU0a0NpRys2MTRmc3JWeC9CZm1HblVneEdH?=
 =?utf-8?B?a3JnWklCUTRGdlVCU0dUY0VQTUNNNm9POHhFQW9Xcmp2UTRzdU02VTI3NnNP?=
 =?utf-8?B?NzA2dnlSVElFTHBEWWRUV1o5Z0ZpRVh0cUtOdER3bnh4S1lPUnhTWXA1bTgr?=
 =?utf-8?B?MkcrUEdRZWh2dlZVRWk5S09HR0JVNW9qZk9CWHVhRG5oSEE5bE9GTEV3M2lR?=
 =?utf-8?B?UTYzWTNTSjJLTk45VXdOZjZjM2o4QXhEcVdPcnhIUjdJWHlQa0ZjdmZnU0ZD?=
 =?utf-8?B?a1NzRmp0MDNZYTVWSDRBMER6Wk94NURuclFFdDdwK2FsNFkzN1QxUG9VMXph?=
 =?utf-8?B?ZE81S1JiV1VkcEtzYlN4L0lmZUpVVnEyZzNkKzhkdFJuSExaeWNuaWFkaG5v?=
 =?utf-8?B?RkVIaEZFUUJsdFhtNldoaUdLRk1NeEVxR2dOM2lQSExzWTFpN0d5R2Y0anV4?=
 =?utf-8?Q?IuZ+11kvnpHE1EgA36bnR/7BB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87592c9f-39be-49b1-73f3-08dcccd0212a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 10:55:46.3865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rc339Og9fhfEfLOhZXXSNF3exTVHSpvXjnaiCBswuURvFfujASSBqAEPWhrkyuKrt3pZPraxvR7pDGJQkP5b8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8583

NXP hardware IP(s) for secure-enclaves like Edgelock Enclave(ELE),
are embedded in the SoC to support the features like HSM, SHE & V2X,
using message based communication interface.

The secure enclave FW communicates on a dedicated messaging unit(MU)
based interface(s) with application core, where kernel is running.
It exists on specific i.MX processors. e.g. i.MX8ULP, i.MX93.

This patch adds the driver for communication interface to secure-enclave,
for exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
Enclave (ELE) from Kernel-space, used by kernel management layers like
- DM-Crypt.

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 drivers/firmware/imx/Kconfig        |  12 +
 drivers/firmware/imx/Makefile       |   2 +
 drivers/firmware/imx/ele_base_msg.c | 286 ++++++++++++++++++++
 drivers/firmware/imx/ele_base_msg.h |  95 +++++++
 drivers/firmware/imx/ele_common.c   | 306 +++++++++++++++++++++
 drivers/firmware/imx/ele_common.h   |  51 ++++
 drivers/firmware/imx/se_ctrl.c      | 515 ++++++++++++++++++++++++++++++++++++
 drivers/firmware/imx/se_ctrl.h      |  99 +++++++
 include/linux/firmware/imx/se_api.h |  14 +
 9 files changed, 1380 insertions(+)

diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index 183613f82a11..0f6877a24f0b 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -22,3 +22,15 @@ config IMX_SCU
 
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
+
+config IMX_SEC_ENCLAVE
+	tristate "i.MX Embedded Secure Enclave - EdgeLock Enclave Firmware driver."
+	depends on IMX_MBOX && ARCH_MXC && ARM64
+	default m if ARCH_MXC
+
+	help
+	  It is possible to use APIs exposed by the iMX Secure Enclave HW IP called:
+	  - EdgeLock Enclave Firmware (for i.MX8ULP, i.MX93),
+	    like base, HSM, V2X & SHE using the SAB protocol via the shared Messaging
+	    Unit. This driver exposes these interfaces via a set of file descriptors
+	    allowing to configure shared memory, send and receive messages.
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8f9f04a513a8..aa9033e0e9e3 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,3 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+sec_enclave-objs		= se_ctrl.o ele_common.o ele_base_msg.o
+obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
diff --git a/drivers/firmware/imx/ele_base_msg.c b/drivers/firmware/imx/ele_base_msg.c
new file mode 100644
index 000000000000..e3e570a25e85
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/types.h>
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/genalloc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+int ele_get_info(struct device *dev, struct ele_dev_info *s_info)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	dma_addr_t get_info_addr = 0;
+	u32 *get_info_data = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		return ret;
+	}
+
+	memset(s_info, 0x0, sizeof(*s_info));
+
+	if (priv->mem_pool)
+		get_info_data = gen_pool_dma_alloc(priv->mem_pool,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr);
+	else
+		get_info_data = dma_alloc_coherent(dev,
+						   ELE_GET_INFO_BUFF_SZ,
+						   &get_info_addr,
+						   GFP_KERNEL);
+	if (!get_info_data) {
+		ret = -ENOMEM;
+		dev_dbg(dev,
+			"%s: Failed to allocate get_info_addr.\n",
+			__func__);
+		return ret;
+	}
+
+	tx_msg = kzalloc(ELE_GET_INFO_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_GET_INFO_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_REQ_MSG_SZ,
+				      true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = upper_32_bits(get_info_addr);
+	tx_msg->data[1] = lower_32_bits(get_info_addr);
+	tx_msg->data[2] = sizeof(*s_info);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_GET_INFO_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_GET_INFO_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_GET_INFO_REQ,
+				      ELE_GET_INFO_RSP_MSG_SZ,
+				      true);
+
+	memcpy(s_info, get_info_data, sizeof(*s_info));
+	priv->imem.state = s_info->d_addn_info.imem_state;
+
+exit:
+	if (priv->mem_pool)
+		gen_pool_free(priv->mem_pool,
+			      (u64) get_info_data,
+			      ELE_GET_INFO_BUFF_SZ);
+	else
+		dma_free_coherent(dev,
+				  ELE_GET_INFO_BUFF_SZ,
+				  get_info_data,
+				  get_info_addr);
+
+	return ret;
+}
+
+int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 *serial_num)
+{
+	struct ele_dev_info s_info = {0};
+	int err = 0;
+
+	err = ele_get_info(dev, &s_info);
+	if (err < 0) {
+		dev_err(dev, "Error");
+		return err;
+	}
+
+	if (soc_rev)
+		*soc_rev = s_info.d_info.soc_rev;
+	if (serial_num)
+		*serial_num = GET_SERIAL_NUM_FROM_UID(s_info.d_info.uid, MAX_UID_SIZE >> 2);
+
+	return err;
+}
+
+int ele_ping(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_PING_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_PING_RSP_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_PING_REQ, ELE_PING_REQ_SZ, true);
+	if (ret) {
+		dev_err(dev, "Error: se_fill_cmd_msg_hdr failed.\n");
+		goto exit;
+	}
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_PING_REQ_SZ,
+			       rx_msg,
+			       ELE_PING_RSP_SZ);
+	if (ret)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_PING_REQ,
+				      ELE_PING_RSP_SZ,
+				      true);
+exit:
+	return ret;
+}
+
+int ele_service_swap(struct device *dev,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_SERVICE_SWAP_REQ_MSG_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_SERVICE_SWAP_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				      (struct se_msg_hdr *)&tx_msg->header,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_REQ_MSG_SZ, true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[0] = flag;
+	tx_msg->data[1] = addr_size;
+	tx_msg->data[2] = ELE_NONE_VAL;
+	tx_msg->data[3] = lower_32_bits(addr);
+	tx_msg->data[4] = se_add_msg_crc((uint32_t *)&tx_msg[0],
+						 ELE_SERVICE_SWAP_REQ_MSG_SZ);
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_SERVICE_SWAP_REQ_MSG_SZ,
+			       rx_msg,
+			       ELE_SERVICE_SWAP_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_SERVICE_SWAP_REQ,
+				      ELE_SERVICE_SWAP_RSP_MSG_SZ,
+				      true);
+	if (ret)
+		goto exit;
+
+	if (flag == ELE_IMEM_EXPORT)
+		ret = rx_msg->data[1];
+	else
+		ret = 0;
+
+exit:
+
+	return ret;
+}
+
+int ele_fw_authenticate(struct device *dev, phys_addr_t addr)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	int ret = 0;
+
+	if (!priv) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	tx_msg = kzalloc(ELE_FW_AUTH_REQ_SZ, GFP_KERNEL);
+	if (!tx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(ELE_FW_AUTH_RSP_MSG_SZ, GFP_KERNEL);
+	if (!rx_msg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = se_fill_cmd_msg_hdr(priv,
+				  (struct se_msg_hdr *)&tx_msg->header,
+				  ELE_FW_AUTH_REQ,
+				  ELE_FW_AUTH_REQ_SZ,
+				  true);
+	if (ret)
+		goto exit;
+
+	tx_msg->data[1] = upper_32_bits(addr);
+	tx_msg->data[0] = lower_32_bits(addr);
+	tx_msg->data[2] = addr;
+
+	ret = ele_msg_send_rcv(priv,
+			       tx_msg,
+			       ELE_FW_AUTH_REQ_SZ,
+			       rx_msg,
+			       ELE_FW_AUTH_RSP_MSG_SZ);
+	if (ret < 0)
+		goto exit;
+
+	ret = se_val_rsp_hdr_n_status(priv,
+				      rx_msg,
+				      ELE_FW_AUTH_REQ,
+				      ELE_FW_AUTH_RSP_MSG_SZ,
+				      true);
+exit:
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_base_msg.h b/drivers/firmware/imx/ele_base_msg.h
new file mode 100644
index 000000000000..88ccfce8c8f7
--- /dev/null
+++ b/drivers/firmware/imx/ele_base_msg.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ *
+ * Header file for the EdgeLock Enclave Base API(s).
+ */
+
+#ifndef ELE_BASE_MSG_H
+#define ELE_BASE_MSG_H
+
+#include <linux/device.h>
+#include <linux/types.h>
+
+#define WORD_SZ				4
+#define ELE_NONE_VAL			0x0
+
+#define ELE_GET_INFO_REQ		0xDA
+#define ELE_GET_INFO_REQ_MSG_SZ		0x10
+#define ELE_GET_INFO_RSP_MSG_SZ		0x08
+
+#define DEFAULT_IMX_SOC_VER		0xA000
+#define SOC_VER_MASK			0xFFFF0000
+#define SOC_ID_MASK			0x0000FFFF
+
+#define MAX_UID_SIZE                     (16)
+#define DEV_GETINFO_ROM_PATCH_SHA_SZ     (32)
+#define DEV_GETINFO_FW_SHA_SZ            (32)
+#define DEV_GETINFO_OEM_SRKH_SZ          (64)
+#define DEV_GETINFO_MIN_VER_MASK	0xFF
+#define DEV_GETINFO_MAJ_VER_MASK	0xFF00
+#define ELE_DEV_INFO_EXTRA_SZ		0x60
+
+struct dev_info {
+	uint8_t  cmd;
+	uint8_t  ver;
+	uint16_t length;
+	uint16_t soc_id;
+	uint16_t soc_rev;
+	uint16_t lmda_val;
+	uint8_t  ssm_state;
+	uint8_t  dev_atts_api_ver;
+	uint8_t  uid[MAX_UID_SIZE];
+	uint8_t  sha_rom_patch[DEV_GETINFO_ROM_PATCH_SHA_SZ];
+	uint8_t  sha_fw[DEV_GETINFO_FW_SHA_SZ];
+};
+
+struct dev_addn_info {
+	uint8_t  oem_srkh[DEV_GETINFO_OEM_SRKH_SZ];
+	uint8_t  trng_state;
+	uint8_t  csal_state;
+	uint8_t  imem_state;
+	uint8_t  reserved2;
+};
+
+struct ele_dev_info {
+	struct dev_info d_info;
+	struct dev_addn_info d_addn_info;
+};
+
+#define ELE_GET_INFO_BUFF_SZ		(sizeof(struct ele_dev_info) \
+						+ ELE_DEV_INFO_EXTRA_SZ)
+
+#define GET_SERIAL_NUM_FROM_UID(x, uid_word_sz) \
+	(((u64)(((u32 *)(x))[(uid_word_sz) - 1]) << 32) | ((u32 *)(x))[0])
+
+#define ELE_DEBUG_DUMP_REQ		0x21
+#define ELE_DEBUG_DUMP_RSP_SZ		0x14
+
+#define ELE_PING_REQ			0x01
+#define ELE_PING_REQ_SZ			0x04
+#define ELE_PING_RSP_SZ			0x08
+
+#define ELE_SERVICE_SWAP_REQ		0xDF
+#define ELE_SERVICE_SWAP_REQ_MSG_SZ	0x18
+#define ELE_SERVICE_SWAP_RSP_MSG_SZ	0x0C
+#define ELE_IMEM_SIZE			0x10000
+#define ELE_IMEM_STATE_OK		0xCA
+#define ELE_IMEM_STATE_BAD		0xFE
+#define ELE_IMEM_STATE_WORD		0x27
+#define ELE_IMEM_STATE_MASK		0x00ff0000
+#define ELE_IMEM_EXPORT			0x1
+#define ELE_IMEM_IMPORT			0x2
+
+#define ELE_FW_AUTH_REQ			0x02
+#define ELE_FW_AUTH_REQ_SZ		0x10
+#define ELE_FW_AUTH_RSP_MSG_SZ		0x08
+
+int ele_get_info(struct device *dev, struct ele_dev_info *s_info);
+int ele_fetch_soc_info(struct device *dev, u16 *soc_rev, u64 *serial_num);
+int ele_ping(struct device *dev);
+int ele_service_swap(struct device *dev,
+		     phys_addr_t addr,
+		     u32 addr_size, u16 flag);
+int ele_fw_authenticate(struct device *dev, phys_addr_t addr);
+#endif
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
new file mode 100644
index 000000000000..a06d7015d3f1
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+
+u32 se_add_msg_crc(u32 *msg, u32 msg_len)
+{
+	u32 nb_words = msg_len / (u32)sizeof(u32);
+	u32 crc = 0;
+	u32 i;
+
+	for (i = 0; i < nb_words - 1; i++)
+		crc ^= *(msg + i);
+
+	return crc;
+}
+
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl)
+{
+	int err = 0;
+
+	err = wait_event_interruptible(se_clbk_hdl->wq,
+				       atomic_read(&se_clbk_hdl->pending_hdr) != 0);
+	if (err < 0)
+		dev_err(priv->dev,
+			"Err[0x%x]:Interrupted by signal.\n",
+			err);
+	else
+		err = se_clbk_hdl->rx_msg_sz;
+
+	atomic_dec(&se_clbk_hdl->pending_hdr);
+
+	return err;
+}
+
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz)
+{
+	struct se_msg_hdr *header;
+	int err;
+
+	header = tx_msg;
+
+	/*
+	 * Check that the size passed as argument matches the size
+	 * carried in the message.
+	 */
+	if (header->size << 2 != tx_msg_sz) {
+		err = -EINVAL;
+		dev_err(priv->dev,
+			"User buf hdr: 0x%x, sz mismatced with input-sz (%d != %d).",
+			*(u32 *)header,
+			header->size << 2, tx_msg_sz);
+		goto exit;
+	}
+	guard(mutex)(&priv->se_if_lock);
+
+	err = mbox_send_message(priv->tx_chan, tx_msg);
+	if (err < 0) {
+		dev_err(priv->dev, "Error: mbox_send_message failure.\n");
+		return err;
+	}
+	err = tx_msg_sz;
+
+exit:
+	return err;
+}
+
+/* API used for send/receive blocking call. */
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz)
+{
+	int err;
+
+	guard(mutex)(&priv->se_if_cmd_lock);
+
+	priv->waiting_rsp_clbk_hdl.rx_msg_sz = exp_rx_msg_sz;
+	priv->waiting_rsp_clbk_hdl.rx_msg = rx_msg;
+
+	err = ele_msg_send(priv, tx_msg, tx_msg_sz);
+	if (err < 0)
+		goto exit;
+
+	err = ele_msg_rcv(priv, &priv->waiting_rsp_clbk_hdl);
+exit:
+	return err;
+}
+
+static bool exception_for_size(struct se_if_priv *priv,
+				struct se_msg_hdr *header)
+{
+	/* List of API(s) that can be accepte variable length
+	 * response buffer.
+	 */
+	if (header->command == ELE_DEBUG_DUMP_REQ &&
+		header->ver == priv->base_api_ver &&
+		header->size >= 0 &&
+		header->size <= ELE_DEBUG_DUMP_RSP_SZ)
+		return true;
+
+	return false;
+}
+
+/*
+ * Callback called by mailbox FW, when data is received.
+ */
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
+{
+	struct se_clbk_handle *se_clbk_hdl;
+	struct device *dev = mbox_cl->dev;
+	struct se_msg_hdr *header;
+	struct se_if_priv *priv;
+	u32 rx_msg_sz;
+
+	priv = dev_get_drvdata(dev);
+
+	/* The function can be called with NULL msg */
+	if (!msg) {
+		dev_err(dev, "Message is invalid\n");
+		return;
+	}
+
+	header = msg;
+	rx_msg_sz = header->size << 2;
+
+	/* Incoming command: wake up the receiver if any. */
+	if (header->tag == priv->cmd_tag) {
+		se_clbk_hdl = &priv->cmd_receiver_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting cmd receiver for mesg header:0x%x.",
+			*(u32 *) header);
+
+		/* Pre-allocated buffer of MAX_NVM_MSG_LEN
+		 * as the NVM command are initiated by FW.
+		 * Size is revealed as part of this call function.
+		 */
+		if (rx_msg_sz > MAX_NVM_MSG_LEN) {
+			dev_err(dev,
+				"CMD-RCVER NVM: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *) header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = MAX_NVM_MSG_LEN;
+		}
+		se_clbk_hdl->rx_msg_sz = rx_msg_sz;
+
+	} else if (header->tag == priv->rsp_tag) {
+		se_clbk_hdl = &priv->waiting_rsp_clbk_hdl;
+		dev_dbg(dev,
+			"Selecting resp waiter for mesg header:0x%x.",
+			*(u32 *) header);
+
+		if (rx_msg_sz != se_clbk_hdl->rx_msg_sz
+				&& !exception_for_size(priv, header)) {
+			dev_err(dev,
+				"Rsp to CMD: hdr(0x%x) with different sz(%d != %d).\n",
+				*(u32 *) header,
+				rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+
+			se_clbk_hdl->rx_msg_sz = min(rx_msg_sz, se_clbk_hdl->rx_msg_sz);
+		}
+	} else {
+		dev_err(dev, "Failed to select a device for message: %.8x\n",
+			*((u32 *) header));
+		return;
+	}
+
+	memcpy(se_clbk_hdl->rx_msg, msg, se_clbk_hdl->rx_msg_sz);
+
+	/* Allow user to read */
+	atomic_inc(&se_clbk_hdl->pending_hdr);
+
+	wake_up_interruptible(&se_clbk_hdl->wq);
+}
+
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    uint8_t msg_id,
+			    uint8_t sz,
+			    bool is_base_api)
+{
+	u32 status;
+	struct se_msg_hdr *header = &msg->header;
+
+	if (header->tag != priv->rsp_tag) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Resp tag mismatch. (0x%x != 0x%x)",
+			msg_id, header->tag, priv->rsp_tag);
+		return -EINVAL;
+	}
+
+	if (header->command != msg_id) {
+		dev_err(priv->dev,
+			"MSG Header: Cmd id mismatch. (0x%x != 0x%x)",
+			header->command, msg_id);
+		return -EINVAL;
+	}
+
+	if (header->size != (sz >> 2)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Cmd size mismatch. (0x%x != 0x%x)",
+			msg_id, header->size, (sz >> 2));
+		return -EINVAL;
+	}
+
+	if (is_base_api && (header->ver != priv->base_api_ver)) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: Base API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->base_api_ver);
+		return -EINVAL;
+	} else if (!is_base_api && header->ver != priv->fw_api_ver) {
+		dev_err(priv->dev,
+			"MSG[0x%x] Hdr: FW API Vers mismatch. (0x%x != 0x%x)",
+			msg_id, header->ver, priv->fw_api_ver);
+		return -EINVAL;
+	}
+
+	status = RES_STATUS(msg->data[0]);
+	if (status != priv->success_tag) {
+		dev_err(priv->dev, "Command Id[%d], Response Failure = 0x%x",
+			header->command, status);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv)
+{
+	int ret;
+
+	/* EXPORT command will save encrypted IMEM to given address,
+	 * so later in resume, IMEM can be restored from the given
+	 * address.
+	 *
+	 * Size must be at least 64 kB.
+	 */
+	ret = ele_service_swap(priv->dev,
+			       priv->imem.phyaddr,
+			       ELE_IMEM_SIZE,
+			       ELE_IMEM_EXPORT);
+	if (ret < 0)
+		dev_err(priv->dev, "Failed to export IMEM\n");
+	else
+		dev_info(priv->dev,
+			"Exported %d bytes of encrypted IMEM\n",
+			ret);
+
+	return ret;
+}
+
+int se_restore_imem_state(struct se_if_priv *priv)
+{
+	struct ele_dev_info s_info;
+	int ret;
+
+	/* get info from ELE */
+	ret = ele_get_info(priv->dev, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		return ret;
+	}
+
+	/* Get IMEM state, if 0xFE then import IMEM */
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_BAD) {
+		/* IMPORT command will restore IMEM from the given
+		 * address, here size is the actual size returned by ELE
+		 * during the export operation
+		 */
+		ret = ele_service_swap(priv->dev,
+				       priv->imem.phyaddr,
+				       priv->imem.size,
+				       ELE_IMEM_IMPORT);
+		if (ret) {
+			dev_err(priv->dev, "Failed to import IMEM\n");
+			goto exit;
+		}
+	} else
+		goto exit;
+
+	/* After importing IMEM, check if IMEM state is equal to 0xCA
+	 * to ensure IMEM is fully loaded and
+	 * ELE functionality can be used.
+	 */
+	ret = ele_get_info(priv->dev, &s_info);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get info from ELE.\n");
+		goto exit;
+	}
+
+	if (s_info.d_addn_info.imem_state == ELE_IMEM_STATE_OK)
+		dev_info(priv->dev, "Successfully restored IMEM\n");
+	else
+		dev_err(priv->dev, "Failed to restore IMEM\n");
+
+exit:
+	return ret;
+}
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
new file mode 100644
index 000000000000..b05d62090337
--- /dev/null
+++ b/drivers/firmware/imx/ele_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+
+#ifndef __ELE_COMMON_H__
+#define __ELE_COMMON_H__
+
+#include "se_ctrl.h"
+
+#define ELE_SUCCESS_IND			0xD6
+
+#define IMX_ELE_FW_DIR                 "imx/ele/"
+
+uint32_t se_add_msg_crc(uint32_t *msg, uint32_t msg_len);
+int ele_msg_rcv(struct se_if_priv *priv,
+		struct se_clbk_handle *se_clbk_hdl);
+int ele_msg_send(struct se_if_priv *priv,
+		 void *tx_msg,
+		 int tx_msg_sz);
+int ele_msg_send_rcv(struct se_if_priv *priv,
+		     void *tx_msg,
+		     int tx_msg_sz,
+		     void *rx_msg,
+		     int exp_rx_msg_sz);
+void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg);
+int se_val_rsp_hdr_n_status(struct se_if_priv *priv,
+			    struct se_api_msg *msg,
+			    uint8_t msg_id,
+			    uint8_t sz,
+			    bool is_base_api);
+
+/* Fill a command message header with a given command ID and length in bytes. */
+static inline int se_fill_cmd_msg_hdr(struct se_if_priv *priv,
+				      struct se_msg_hdr *hdr,
+				      u8 cmd, u32 len,
+				      bool is_base_api)
+{
+	hdr->tag = priv->cmd_tag;
+	hdr->ver = (is_base_api) ? priv->base_api_ver : priv->fw_api_ver;
+	hdr->command = cmd;
+	hdr->size = len >> 2;
+
+	return 0;
+}
+
+int se_save_imem_state(struct se_if_priv *priv);
+int se_restore_imem_state(struct se_if_priv *priv);
+
+#endif /*__ELE_COMMON_H__ */
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
new file mode 100644
index 000000000000..82b9fcf25535
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -0,0 +1,515 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/firmware.h>
+#include <linux/firmware/imx/se_api.h>
+#include <linux/genalloc.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/miscdevice.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+#include "ele_base_msg.h"
+#include "ele_common.h"
+#include "se_ctrl.h"
+
+#define RESERVED_DMA_POOL		BIT(0)
+#define MBOX_TX_NAME			"tx"
+#define MBOX_RX_NAME			"rx"
+
+struct se_if_node_info {
+	u8 se_if_id;
+	u8 se_if_did;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+	u8 *se_name;
+	u8 *pool_name;
+	u8 *prim_fw_nm_in_rfs;
+	u8 *seco_fw_nm_in_rfs;
+	bool soc_register;
+	bool reserved_dma_ranges;
+	int (*se_fetch_soc_info)(struct device *dev, u16 *soc_rev, u64 *serial_num);
+};
+
+struct se_if_node_info_list {
+	u8 num_mu;
+	u16 soc_id;
+	struct se_if_node_info info[];
+};
+
+static const struct se_if_node_info_list imx8ulp_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX8ULP,
+	.info = {
+			{
+			.se_if_id = 2,
+			.se_if_did = 7,
+			.cmd_tag = 0x17,
+			.rsp_tag = 0xe1,
+			.success_tag = ELE_SUCCESS_IND,
+			.base_api_ver = MESSAGING_VERSION_6,
+			.fw_api_ver = MESSAGING_VERSION_7,
+			.se_name = "hsm1",
+			.pool_name = "sram",
+			.prim_fw_nm_in_rfs = IMX_ELE_FW_DIR
+						"mx8ulpa2-ahab-container.img",
+			.seco_fw_nm_in_rfs = IMX_ELE_FW_DIR
+						"mx8ulpa2ext-ahab-container.img",
+			.soc_register = true,
+			.reserved_dma_ranges = true,
+			.se_fetch_soc_info = ele_fetch_soc_info,
+			},
+	},
+};
+
+static const struct se_if_node_info_list imx93_info = {
+	.num_mu = 1,
+	.soc_id = SOC_ID_OF_IMX93,
+	.info = {
+			{
+			.se_if_id = 2,
+			.se_if_did = 3,
+			.cmd_tag = 0x17,
+			.rsp_tag = 0xe1,
+			.success_tag = ELE_SUCCESS_IND,
+			.base_api_ver = MESSAGING_VERSION_6,
+			.fw_api_ver = MESSAGING_VERSION_7,
+			.se_name = "hsm1",
+			.reserved_dma_ranges = true,
+			.soc_register = true,
+			},
+	},
+};
+
+static const struct of_device_id se_match[] = {
+	{ .compatible = "fsl,imx8ulp-se", .data = (void *)&imx8ulp_info},
+	{ .compatible = "fsl,imx93-se", .data = (void *)&imx93_info},
+	{},
+};
+
+static const struct se_if_node_info
+	*get_se_if_node_info(const struct se_if_node_info_list *info_list,
+			      const u32 idx)
+{
+	return &info_list->info[idx];
+}
+
+static int se_soc_info(struct se_if_priv *priv,
+		       const struct se_if_node_info_list *info_list)
+{
+	const struct se_if_node_info *info;
+	struct soc_device_attribute *attr;
+	struct soc_device *sdev;
+	u64 serial_num;
+	u16 soc_rev;
+	int err = 0;
+
+	info = priv->info;
+
+	/* This function should be called once.
+	 * Check if the soc_rev is zero to continue.
+	 */
+	if (priv->soc_rev)
+		return err;
+
+	if (info->se_fetch_soc_info) {
+		err = info->se_fetch_soc_info(priv->dev, &soc_rev, &serial_num);
+		if (err < 0) {
+			dev_err(priv->dev, "Failed to fetch SoC Info.");
+			return err;
+		}
+	} else {
+		dev_err(priv->dev, "Failed to fetch SoC revision.");
+		if (info->soc_register)
+			dev_err(priv->dev, "Failed to do SoC registration.");
+		err = -EINVAL;
+		return err;
+	}
+
+	priv->soc_rev = soc_rev;
+	if (!info->soc_register)
+		return 0;
+
+	attr = devm_kzalloc(priv->dev, sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
+	if (FIELD_GET(DEV_GETINFO_MIN_VER_MASK, soc_rev))
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x.%x",
+						FIELD_GET(DEV_GETINFO_MIN_VER_MASK,
+							  soc_rev),
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  soc_rev));
+	else
+		attr->revision = devm_kasprintf(priv->dev, GFP_KERNEL, "%x",
+						FIELD_GET(DEV_GETINFO_MAJ_VER_MASK,
+							  soc_rev));
+
+	switch (info_list->soc_id) {
+	case SOC_ID_OF_IMX8ULP:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX8ULP");
+		break;
+	case SOC_ID_OF_IMX93:
+		attr->soc_id = devm_kasprintf(priv->dev, GFP_KERNEL,
+					      "i.MX93");
+		break;
+	}
+
+	err = of_property_read_string(of_root, "model",
+				      &attr->machine);
+	if (err)
+		return -EINVAL;
+
+	attr->family = devm_kasprintf(priv->dev, GFP_KERNEL, "Freescale i.MX");
+
+	attr->serial_number
+		= devm_kasprintf(priv->dev, GFP_KERNEL, "%016llX", serial_num);
+
+	sdev = soc_device_register(attr);
+	if (IS_ERR(sdev))
+		return PTR_ERR(sdev);
+
+	return 0;
+}
+
+/* interface for managed res to free a mailbox channel */
+static void if_mbox_free_channel(void *mbox_chan)
+{
+	mbox_free_channel(mbox_chan);
+}
+
+static int se_if_request_channel(struct device *dev,
+				 struct mbox_chan **chan,
+				 struct mbox_client *cl,
+				 const char *name)
+{
+	struct mbox_chan *t_chan;
+	int ret = 0;
+
+	t_chan = mbox_request_channel_byname(cl, name);
+	if (IS_ERR(t_chan)) {
+		ret = PTR_ERR(t_chan);
+		return dev_err_probe(dev, ret,
+				     "Failed to request %s channel.", name);
+	}
+
+	ret = devm_add_action(dev, if_mbox_free_channel, t_chan);
+	if (ret) {
+		dev_err(dev, "failed to add devm removal of mbox %s\n", name);
+		goto exit;
+	}
+
+	*chan = t_chan;
+
+exit:
+	return ret;
+}
+
+static void se_if_probe_cleanup(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct se_if_priv *priv;
+
+	priv = dev_get_drvdata(dev);
+
+	/* In se_if_request_channel(), passed the clean-up functional
+	 * pointer reference as action to devm_add_action().
+	 * No need to free the mbox channels here.
+	 */
+
+	/* free the buffer in se remove, previously allocated
+	 * in se probe to store encrypted IMEM
+	 */
+	if (priv->imem.buf) {
+		dmam_free_coherent(dev,
+				   ELE_IMEM_SIZE,
+				   priv->imem.buf,
+				   priv->imem.phyaddr);
+		priv->imem.buf = NULL;
+	}
+
+	/* No need to check, if reserved memory is allocated
+	 * before calling for its release. Or clearing the
+	 * un-set bit.
+	 */
+	of_reserved_mem_device_release(dev);
+}
+
+static void se_load_firmware(const struct firmware *fw, void *context)
+{
+	struct se_if_priv *priv = context;
+	const struct se_if_node_info *info = priv->info;
+	phys_addr_t se_fw_phyaddr;
+	u8 *se_fw_buf;
+	int ret;
+
+	if (!fw) {
+		if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
+			dev_dbg(priv->dev,
+				 "External FW not found, using ROM FW.\n");
+		else {
+			/*add a bit delay to wait for firmware priv released */
+			msleep(20);
+
+			/* Load firmware one more time if timeout */
+			request_firmware_nowait(THIS_MODULE,
+					FW_ACTION_UEVENT, priv->se_img_file_to_load,
+					priv->dev, GFP_KERNEL, priv,
+					se_load_firmware);
+			priv->fw_fail++;
+			dev_dbg(priv->dev, "Value of retries = 0x%x.\n",
+				priv->fw_fail);
+		}
+
+		return;
+	}
+
+	dev_info(priv->dev, "loading firmware %s\n", priv->se_img_file_to_load);
+
+	/* allocate buffer to store the SE FW */
+	se_fw_buf = dma_alloc_coherent(priv->dev, fw->size,
+			&se_fw_phyaddr, GFP_KERNEL);
+	if (!se_fw_buf)
+		goto exit;
+
+	memcpy(se_fw_buf, fw->data, fw->size);
+	ret = ele_fw_authenticate(priv->dev, se_fw_phyaddr);
+	if (ret < 0)
+		dev_err(priv->dev,
+			"Error %pe: Authenticate & load SE firmware %s.\n",
+			ERR_PTR(ret),
+			priv->se_img_file_to_load);
+
+	dma_free_coherent(priv->dev,
+			fw->size,
+			se_fw_buf,
+			se_fw_phyaddr);
+
+	if (priv->imem.state == ELE_IMEM_STATE_BAD &&
+	    priv->se_img_file_to_load == info->prim_fw_nm_in_rfs) {
+		priv->se_img_file_to_load = info->seco_fw_nm_in_rfs;
+		request_firmware_nowait(THIS_MODULE,
+				FW_ACTION_UEVENT, priv->se_img_file_to_load,
+				priv->dev, GFP_KERNEL, priv,
+				se_load_firmware);
+	}
+
+exit:
+	release_firmware(fw);
+}
+
+static int se_if_probe(struct platform_device *pdev)
+{
+	const struct se_if_node_info_list *info_list;
+	const struct se_if_node_info *info;
+	struct device *dev = &pdev->dev;
+	struct se_if_priv *priv;
+	u32 idx;
+	int ret;
+
+	idx = GET_IDX_FROM_DEV_NODE_NAME(dev->of_node);
+	info_list = device_get_match_data(dev);
+	if (idx >= info_list->num_mu) {
+		dev_err(dev,
+			"Incorrect node name :%s\n",
+			dev->of_node->full_name);
+		dev_err(dev,
+			"%s@<index>, acceptable index range is 0..%d\n",
+			dev->of_node->name,
+			info_list->num_mu - 1);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	info = get_se_if_node_info(info_list, idx);
+	if (!info) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	dev_set_drvdata(dev, priv);
+
+	/* Mailbox client configuration */
+	priv->se_mb_cl.dev		= dev;
+	priv->se_mb_cl.tx_block		= false;
+	priv->se_mb_cl.knows_txdone	= true;
+	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
+
+	ret = se_if_request_channel(dev, &priv->tx_chan,
+			&priv->se_mb_cl, MBOX_TX_NAME);
+	if (ret)
+		goto exit;
+
+	ret = se_if_request_channel(dev, &priv->rx_chan,
+			&priv->se_mb_cl, MBOX_RX_NAME);
+	if (ret)
+		goto exit;
+
+	priv->dev = dev;
+	priv->info = info;
+
+	mutex_init(&priv->se_if_lock);
+	mutex_init(&priv->se_if_cmd_lock);
+
+	atomic_set(&priv->waiting_rsp_clbk_hdl.pending_hdr, 0);
+	init_waitqueue_head(&priv->waiting_rsp_clbk_hdl.wq);
+	atomic_set(&priv->cmd_receiver_clbk_hdl.pending_hdr, 0);
+	init_waitqueue_head(&priv->cmd_receiver_clbk_hdl.wq);
+
+	priv->cmd_tag = info->cmd_tag;
+	priv->rsp_tag = info->rsp_tag;
+	if (info->pool_name) {
+		priv->mem_pool = of_gen_pool_get(dev->of_node,
+						 info->pool_name, 0);
+		if (!priv->mem_pool) {
+			dev_err(dev,
+				"Unable to get sram pool = %s\n",
+				info->pool_name);
+			return 0;
+		}
+	}
+	priv->success_tag = info->success_tag;
+	priv->base_api_ver = info->base_api_ver;
+	priv->fw_api_ver = info->fw_api_ver;
+	spin_lock_init(&priv->lock);
+
+	if (info->reserved_dma_ranges) {
+		ret = of_reserved_mem_device_init(dev);
+		if (ret) {
+			dev_err(dev,
+				"failed to init reserved memory region %d\n",
+				ret);
+			goto exit;
+		}
+	}
+
+	ret = se_soc_info(priv, info_list);
+	if (ret) {
+		dev_err(dev,
+			"failed[%pe] to fetch SoC Info\n", ERR_PTR(ret));
+		goto exit;
+	}
+
+	priv->se_img_file_to_load = info->seco_fw_nm_in_rfs;
+	if (info->prim_fw_nm_in_rfs) {
+		/* allocate buffer where SE store encrypted IMEM */
+		priv->imem.buf = dmam_alloc_coherent(dev, ELE_IMEM_SIZE,
+						     &priv->imem.phyaddr,
+						     GFP_KERNEL);
+		if (!priv->imem.buf) {
+			dev_err(dev,
+				"dmam-alloc-failed: To store encr-IMEM.\n");
+			ret = -ENOMEM;
+			goto exit;
+		}
+		if (priv->imem.state == ELE_IMEM_STATE_BAD)
+			priv->se_img_file_to_load = info->prim_fw_nm_in_rfs;
+	}
+
+	if (priv->se_img_file_to_load) {
+		ret = request_firmware_nowait(THIS_MODULE,
+					      FW_ACTION_UEVENT,
+					      priv->se_img_file_to_load,
+					      dev, GFP_KERNEL, priv,
+					      se_load_firmware);
+		if (ret)
+			dev_warn(dev, "Failed to get firmware [%s].\n",
+				 priv->se_img_file_to_load);
+		ret = 0;
+	}
+
+	dev_info(dev, "i.MX secure-enclave: %s interface to firmware, configured.\n",
+		 info->se_name);
+	return ret;
+
+exit:
+	/* if execution control reaches here, if probe fails.
+	 * hence doing the cleanup
+	 */
+	se_if_probe_cleanup(pdev);
+
+	return ret;
+}
+
+static int se_if_remove(struct platform_device *pdev)
+{
+	se_if_probe_cleanup(pdev);
+
+	return 0;
+}
+
+static int se_suspend(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	const struct se_if_node_info *info = priv->info;
+	int ret = 0;
+
+	if (info && info->prim_fw_nm_in_rfs) {
+		ret = se_save_imem_state(priv);
+		if (ret < 0)
+			goto exit;
+		priv->imem.size = ret;
+	}
+exit:
+	return ret;
+}
+
+static int se_resume(struct device *dev)
+{
+	struct se_if_priv *priv = dev_get_drvdata(dev);
+	const struct se_if_node_info *info = priv->info;
+
+	wake_up_interruptible(&priv->waiting_rsp_clbk_hdl.wq);
+	wake_up_interruptible(&priv->cmd_receiver_clbk_hdl.wq);
+
+	if (info && info->prim_fw_nm_in_rfs)
+		se_restore_imem_state(priv);
+
+	return 0;
+}
+
+static const struct dev_pm_ops se_pm = {
+	RUNTIME_PM_OPS(se_suspend, se_resume, NULL)
+};
+
+static struct platform_driver se_driver = {
+	.driver = {
+		.name = "fsl-se-fw",
+		.of_match_table = se_match,
+		.pm = &se_pm,
+	},
+	.probe = se_if_probe,
+	.remove = se_if_remove,
+};
+MODULE_DEVICE_TABLE(of, se_match);
+
+module_platform_driver(se_driver);
+
+MODULE_AUTHOR("Pankaj Gupta <pankaj.gupta@nxp.com>");
+MODULE_DESCRIPTION("iMX Secure Enclave Driver.");
+MODULE_LICENSE("GPL");
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
new file mode 100644
index 000000000000..95050d3c7c88
--- /dev/null
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef SE_MU_H
+#define SE_MU_H
+
+#include <linux/miscdevice.h>
+#include <linux/semaphore.h>
+#include <linux/mailbox_client.h>
+
+#define MAX_FW_LOAD_RETRIES		50
+
+#define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_NVM_MSG_LEN			(256)
+#define MESSAGING_VERSION_6		0x6
+#define MESSAGING_VERSION_7		0x7
+#define NODE_NAME			"secure-enclave"
+
+#define GET_ASCII_TO_U8(diff, tens_chr, ones_chr) \
+		((diff > 2) ? (((tens_chr - '0') * 10) + (ones_chr - '0')) :\
+		(tens_chr - '0'))
+
+#define GET_IDX_FROM_DEV_NODE_NAME(dev_of_node) \
+		((strlen(dev_of_node->full_name) > strlen(NODE_NAME)) ?\
+		GET_ASCII_TO_U8((strlen(dev_of_node->full_name) - strlen(NODE_NAME)),\
+				dev_of_node->full_name[strlen(NODE_NAME) + 1], \
+				dev_of_node->full_name[strlen(NODE_NAME) + 2]) : 0)
+
+struct se_clbk_handle {
+	wait_queue_head_t wq;
+	atomic_t pending_hdr;
+	u32 rx_msg_sz;
+	/* Assignment of the rx_msg buffer to held till the
+	 * received content as part callback function, is copied.
+	 */
+	struct se_api_msg *rx_msg;
+};
+
+struct se_imem_buf {
+	u8 *buf;
+	phys_addr_t phyaddr;
+	u32 size;
+	u32 state;
+};
+
+/* Header of the messages exchange with the EdgeLock Enclave */
+struct se_msg_hdr {
+	u8 ver;
+	u8 size;
+	u8 command;
+	u8 tag;
+}  __packed;
+
+#define SE_MU_HDR_SZ	4
+
+struct se_api_msg {
+	struct se_msg_hdr header;
+	u32 data[];
+};
+
+struct se_if_priv {
+	struct se_clbk_handle cmd_receiver_clbk_hdl;
+	/* Update to the waiting_rsp_dev, to be protected
+	 * under se_if_lock.
+	 */
+	struct se_clbk_handle waiting_rsp_clbk_hdl;
+	/*
+	 * prevent parallel access to the se interface registers
+	 * e.g. a user trying to send a command while the other one is
+	 * sending a response.
+	 */
+	struct mutex se_if_lock;
+	/*
+	 * prevent a command to be sent on the se interface while another one is
+	 * still processing. (response to a command is allowed)
+	 */
+	struct mutex se_if_cmd_lock;
+	struct device *dev;
+	struct gen_pool *mem_pool;
+	u8 cmd_tag;
+	u8 rsp_tag;
+	u8 success_tag;
+	u8 base_api_ver;
+	u8 fw_api_ver;
+	u32 fw_fail;
+	u16 soc_rev;
+	const void *info;
+
+	struct mbox_client se_mb_cl;
+	struct mbox_chan *tx_chan, *rx_chan;
+
+	spinlock_t lock;
+	struct se_imem_buf imem;
+	u8 *se_img_file_to_load;
+};
+
+#endif
diff --git a/include/linux/firmware/imx/se_api.h b/include/linux/firmware/imx/se_api.h
new file mode 100644
index 000000000000..c47f84906837
--- /dev/null
+++ b/include/linux/firmware/imx/se_api.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __SE_API_H__
+#define __SE_API_H__
+
+#include <linux/types.h>
+
+#define SOC_ID_OF_IMX8ULP		0x084D
+#define SOC_ID_OF_IMX93			0x9300
+
+#endif /* __SE_API_H__ */

-- 
2.34.1


