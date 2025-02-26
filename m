Return-Path: <linux-kernel+bounces-534105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38732A462EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A2127A3224
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E8218C32C;
	Wed, 26 Feb 2025 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="E1bKTT32"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475815C0
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580233; cv=fail; b=meuua4cJCa2qSugQW4yqN6+Yr29wkXsVkWnVmKqlTUuFmomPJVHqQILr5PhsmJpZGKEK+34L6KuRj3dO8wRuHw2c1kSfnY1nDmAXHY3yPGGauU/XL/veReWd2ZsnfLQJ58X9HZ3vUp8k9dLVTSKtgkFuncqxJttn/b6IsCzvIQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580233; c=relaxed/simple;
	bh=DXiOa70sPKIZvYoMAR/gbEaxKVz0IyEw5cptiuWOMP4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PWkN7WngyxryB5wyj6MsN8/CpVbyFsfUbTwOwOGRpiBUbvfRNfPYPbOh3Ivz3dqS7gqUWfW8O+KKAwANXlr1ieA7KEuyMDxrwG3jCJv7+iPuSh8+RLWCXFQGBdlENpXEkNrlSKHfIPDX0DOv6nGPUef5MF+9PJ4Fb5QBa71p+Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=E1bKTT32; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzWjQgItlbSm+ErQ0PQ/DdoA024A5vlIQNdeoVDuNjqkld9UYbW+uOUCExUbXmjP7h+SjlUrYIapn1Tt87qw6+NqiAlm0lduztNI+PCTRyHpGWizGBbJLwke0ZNh4sQlYFFEkqVcbqvY44T0yO4f9jsDOz4jp9VJtqxi9n80JU3+dIIHtxGmJAsZWTkbmKnPKD1Dkfy4pRb+uiSodmFnmnF5AumNGLnjNBSoh3aZYP0LZ6MoalFgHWUlzpDS80ZQDkcsD48B59PadgalllRvZlvdKeqGBaaODGdy7INO5Xa0f93Aw4fJPMlKMXeasDW4cqZ/zMCs0YLNiCr5dGBBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQUiUOp4KHECH8yKudw1C5wiww3Njc9SPtpPl3W8k10=;
 b=uJbdwydNLsBcXzZgc0bO2Cu88AcuVEqiS7uiYthvNMjQNJd/v1gKWllV1+13nY8uo19v2qWNwswugzbHoV9bN7PFl32bHsjlqswA1lG/l024mr8Pzb5valbszgq3IzdtUy2czPQUdTp42eZIzZNiCZ2D8lW/7fm6cV1T4E02IrTB5wPcCxNmnUHJgiz0rUrRhXbKq1QV9BcyOWzXGNOq8OasMpX3UxKyoUY2VrV5DhRAE0LPe/R0OT7uHEJJTMb2PuypXA5fo1GHQq6tIr20yCVOl6KkZ/OvdSK8eur5Kd55d+EfQonk1msexC6CKbjnom9lmlG26kcrmpIZ12veRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQUiUOp4KHECH8yKudw1C5wiww3Njc9SPtpPl3W8k10=;
 b=E1bKTT32DG+VKESbQJjv/HVQYMzSYONLMdwz/yfxnh0VmDzuAO2tQFAIRoHOBmrbUdJXyHQXBQwGNvSBE777TiuQBDOFDlGBdWvdPQaBtBue60NFFqq4HWRpD1AePpQd/StiOgb/KMQbdAFlu2NKkuzbcmf9X4e2Hf4hQjkBNQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB6914.eurprd04.prod.outlook.com (2603:10a6:208:189::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Wed, 26 Feb
 2025 14:30:27 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 14:30:27 +0000
Message-ID: <b793928e-8310-4bba-a9d1-50d30f898c17@cherry.de>
Date: Wed, 26 Feb 2025 15:30:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, lukasz.czechowski@thaumatec.com,
 Heiko Stuebner <heiko.stuebner@cherry.de>
References: <20250226102507.3743437-1-heiko@sntech.de>
 <28a16ca5-42f7-4aa1-9bc7-fc6b72364556@cherry.de> <3119048.xgJ6IN8ObU@diego>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <3119048.xgJ6IN8ObU@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b4d8a1-693d-4e38-186b-08dd56721d22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UXhWcXUrOWVOSjZUSXY4blFhMVR2OXdhaW5McnNMWkdrRHV4Wk81emRmM1hh?=
 =?utf-8?B?djh3M3VXVnl5WE9tcDNyYUk1SGI4cnorWWI2WkVKY2tEYk9sRkNRTC9XNFJr?=
 =?utf-8?B?TkZxdk9OenA2a3BFU1JxTm9WQktXbnQ4dWM4RVF0ZGVzUTQyaVFQdjEwVjI1?=
 =?utf-8?B?S1JqcmJ5ZGdaU0FhY2F2RkZNU2h3RStEYVZpZ0NjcUVZY2Vjc0piTjFMdlYr?=
 =?utf-8?B?TVNOQVF4ak9wMDUzNWthNDROaU1pNjZEYUJ4d1RSQ2gwaFpWVFZxdUhNUitL?=
 =?utf-8?B?RWlmSkd6MzRMckxMTXFSNDRlbmZjVzdsK0tRa2svRDdwUkpqb2I3alRGRzRr?=
 =?utf-8?B?bzJRaFZEWldpQld6YVJIeXFURStDUnM0V0grVU1YTUpubnFPdXl5dDBjemtB?=
 =?utf-8?B?NWt6aGdINVJlTmJGN2pzejJJTVlJb1dzWXROeG1leEJoVnZJV1BJcS9CRm90?=
 =?utf-8?B?Y3BNK1VCNTVkaGg3UThOeXZEb1dJZE5jOXNTajZIdU05SWRsY2ovZXZDRlE5?=
 =?utf-8?B?QlR0TVY3ZmljSnBiQzNmTFg3K1hsTE45R3Yvb1p4K0trOEExZ1ZLcnJUanZa?=
 =?utf-8?B?blRFeTRrdEVBOUMrRHpraWlhR2tMWXVMOWh6bFJjL01pY2tmL3NPMGsrRGV6?=
 =?utf-8?B?eWEvSnJOQzFQVjhpejJhanpWdnRpUCtkYUkwdjV2eFlhdXh4cndYT0QzN3Rm?=
 =?utf-8?B?eXQzNzVXMVRsQkdtTnBqRXVNN281QWE4TkVEcGtESVdNTEorcGFETDV6MW9r?=
 =?utf-8?B?Wm5UODg1ZDhkQml5L1VscXJzMVJsYWNIUysrQmtCZEhLV3Jza3NUV3RTNXVY?=
 =?utf-8?B?V1R1ek0veW1MOENxL2hxREVaTUFLdHpxaTZnS0FRWmdta2VVM0NBYTV2QlJX?=
 =?utf-8?B?d3BXN3pBcGRjSDVJYytqUFFXeURBVWxsWnVCcTVXUzE0YmdETFpBVUY3ZXFu?=
 =?utf-8?B?YUY3blBMMVJpL3hOZitZbUVNekFtcVQ4UGZXNXpRUFJicEJUWmFWYk9LRU1N?=
 =?utf-8?B?VVdpa1hobk15ZE00VEVwangyMk1vU2RBSmJoWXlKY2RtOFJ1Qis3bkRxVG54?=
 =?utf-8?B?amg4OFdGTjVLdlZWRElSYWhWVWJ4MGNQOVRXYzFIdzJJaXNBcXkzeHkydkZP?=
 =?utf-8?B?NXBmR21oZlpJWndHc2ZoRUsrSmlrL3dOZ2g4dG1nNXlVazhPVUFWSkNUaEFJ?=
 =?utf-8?B?Y0hzNTBtWWZTaUJ5b2VGSm5hbE5QeEJwUEtKVWJuNyt2b3hWR1J5czZnNHYy?=
 =?utf-8?B?MXhFb1VLU0owMzhOZ0tCMmRMd3dLbVBnbEh5SlZ3cFBvKzI5R2hrdFljTFlY?=
 =?utf-8?B?dTBEbCsxeTVkbG9rZmoyUmZFK3BBSVk1cnpDZEFVVWQ2c0xDcWc5SW41YlRT?=
 =?utf-8?B?OG1NdDlxdEpGWXJSMHdQRDV1T1N4NWIzUXJUWndPREI4MWpNNkI5eitQTk4x?=
 =?utf-8?B?VzRMUmhFRURvdGN0bW8ycWIwRlE0WGwwaWtQUEJ5R09ua21wVjRDay9FTmNm?=
 =?utf-8?B?d0wwb0hzOU5Vcm1kbWplTHVSTUVaeHY5UVo2dm44STUxdTBXMzdSZFh4eTI1?=
 =?utf-8?B?eCttb3czbUhZRnBTZi9LSXNtaWk4aDZpT2lrY0xzN3NGQzFlbThEVkc3SURw?=
 =?utf-8?B?LytaRFNZeDBkZlA0d29jS2ZEODcyZGVmaXFDbFNtazNHc2NPRkE3TncrcUQz?=
 =?utf-8?B?WmxTRGhtekF4OWkrUTE3NmliSVhlc2VoWng2U1hWZVQ0TXZSV0tOd0gzSVZE?=
 =?utf-8?B?M0ZIWnVROG5TNlI2OEFOZVFBSzZISWs0QXZYeDdLUGxRTStGZ3Z1ZG9jY0Nw?=
 =?utf-8?B?T0Z5R2cySGFUeCt5UzkvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdQbW9IdVRRb1RwZTdFWDRtYzVqcTR3Z3dzbWJ2bHJJbmZFaHd4d1g3T0VC?=
 =?utf-8?B?MTFiRkhtRUdLVUhyb2JaQzVYUE5iYTJIZWFaTmhVMXlMOGwrSWNxQ0F3S3FT?=
 =?utf-8?B?UXVNaGpud3BvVUVqajFpQzdQbXNNYmhHWVd5bXc5L3ozb2JOMURYbDB5dVFh?=
 =?utf-8?B?dGsxMzFERnZMSHc4d3QyQlBwQWhNM1dEWVFUWG9VcStWZmphcytlV2U4UnhE?=
 =?utf-8?B?ZDFwTDZyMUJLUTRraGczSGorSk15SzBJSzZyVUhwRzdzZE1UZFNmRUljMTVN?=
 =?utf-8?B?MGxRRlAyc296cUM3YjJlYkpYck40MDhVUnkwOXVCK1ZtQklZV2l3WHR0b0FN?=
 =?utf-8?B?aVc5SUorb3MwcHJqZmxMWGlqQUxkaythK2JwaVhPMjk1TkFaMHRzaVNxRXJy?=
 =?utf-8?B?MmlWUCt4M1dQaUpTZ2NaMWJMTG1KMWlsN0VRTnVmNXJnNXNuTVFtZTF1ak1q?=
 =?utf-8?B?aFUvM1RXM1BpaiswRXdBRVpmWEVvS0djWEJiOUoxMHR0cUd4dHc0czVvWGRZ?=
 =?utf-8?B?VXVORlBRcjJtY3NzYVFlTFFXNG5HQUcxRlRLMkYwQmpWVEVHdWVNbnU0SzFR?=
 =?utf-8?B?dE1oVUpoRGRVUWpzUU95YmZCTnBFVzRDSFNFdDAvaDlZbUVwNUxqc1FjTWQw?=
 =?utf-8?B?M0Rzd3V5ZXBDai9jbXNXdHRQSnIvMGpuSVJNVGlzWHFpaUhIQk5xQktqbUVi?=
 =?utf-8?B?ZjdZZnB6dnQ1UUhObXV5MkM1STg5WlJsM3AwZXFjaXBlOU44ODBLNE93NXRu?=
 =?utf-8?B?aHhkbStHWVhjZXU2aGQ5UERRWEF5dG9JVmszZkFjaGNlcmpNVk9HdzVaUEVp?=
 =?utf-8?B?ZTUyM3NQYkRLNmhvdTU3NXlXSmdjc29NNkZRWVY4Qk8wZC9XN0tYbTRQOVpZ?=
 =?utf-8?B?bzE4YlFPNUd2MVM5a1ZCVDFMMU9WL1dRd0lEOXFUVDVVWmpibjl0L1hVM3Bv?=
 =?utf-8?B?VWJFazEyS0kvU3VRRkloQWpqR0RnTjJxK1RhaUVMRkVzMlc3eVUwaTZiWmpj?=
 =?utf-8?B?QnowMlNSU3RxQVY4MHRqN09jNnVIaFJPajAwbWRHQmRQcWw5N0ZQSHB0RDZj?=
 =?utf-8?B?YUd4QTl1bWNaSWxpK2lTZGs2VDdjdEdDR0lFMXB2dS9scHJXcVI4VHRSbFFN?=
 =?utf-8?B?OE9YWEhuK29SVDZaWFJVOHVlRXV3bXhwRTNLRGlramJDN1RrSTk0OHdtM09O?=
 =?utf-8?B?Q2VOZlpOaE9IanpXUkNQUkxnaHVrbVN3RTRLMmNtVnhGTXZkTkJRclk4eldD?=
 =?utf-8?B?VFc3MTlpd2xqYlRUaUdBUzNMdDdMMEllVFRRTWFndHVseEU5eUgxQyt2amlI?=
 =?utf-8?B?dGpZVDh1aEIzUnZpRzRFODAwcVNFMmFRNEhuNTcvM0U0MDZaNHB0R05DNTJH?=
 =?utf-8?B?dmlNY0xqdVpXSU8xUGFpNm53REtHOVpMQWtRcmxXb1VidHBrendaTkZjaEVW?=
 =?utf-8?B?dFIvMHAyQlNPdkpuOEdabEEyMWFJWS9vNDBTR1BHamtrczlPbDIrV0RDVThM?=
 =?utf-8?B?cFdjQWhzU0p1TFB1SlhaR3lYNFBHU1BaMkVBc1pWKzdVQkkwSGtRQnlrYzlm?=
 =?utf-8?B?ZXUybWNUZm9FazBEWlRUd2ZMeUwyQVFoenBoa1J4c2RBc0MyRTBmQWpQZVhT?=
 =?utf-8?B?WitUS2JVVFRUUFJVSnZpbHBRc0toQkEwdVhmcEMvQVpGYzFxV2FIZFpoU2pl?=
 =?utf-8?B?UmIrcVVLRktoU0dHcktDYTNLa01Jbkl3TEcvdnZUL240bVVOd0xwanR6b3dl?=
 =?utf-8?B?SUhlY1RHZWVLN3RDZWN3MHllR001SmtJMTl6dE9PZ2lWWmhVelZtY1ljbkZT?=
 =?utf-8?B?NXhrdTg4VVcxSzVkWm9sK0VNYkt4YTNIZXhqMTZ1RjdFUUMrSWFjaXhHS0ll?=
 =?utf-8?B?QWhKQ1JYd2w3UVB0V3poWDFJaS9YQWVNVEZGYUxCakw0bkJDQUhQZFF0Vy9m?=
 =?utf-8?B?TlMvL01NeFV6NGo3a3MvYTcvUHVTcjdaWG5mV0RMUDhiTGtTNEhkMVB6TTdt?=
 =?utf-8?B?cG9DaC9ZSG9SSUNKK3l0MkMzb0UyaFJBV3RabEtsZVRsWFJXTFJSWUgvb0Jr?=
 =?utf-8?B?TFJDVFJkbFB2S2RRQmtGSDZzMWFRcjQ2a1NmOXlKMzAvdXVId3pRa1ZSZGZo?=
 =?utf-8?B?cFBES1ZxQ2J5Ukd0MWluVENiNE1UaFBFRGlBVEtnbGRqR3UxYVpKbFNxMVJU?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b4d8a1-693d-4e38-186b-08dd56721d22
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 14:30:27.2839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fPnhnfse73J5KItDhpWNMtUz+5zEPf1I0kFiN+++yoKPRNp5RUOPWk3PxOGBu0ritHcO3sSZgSWu+6DY96pEwyopkHm35t07o7eAdZWeoJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6914

Hi Heiko,

On 2/26/25 2:27 PM, Heiko Stübner wrote:
> Am Mittwoch, 26. Februar 2025, 14:17:37 MEZ schrieb Quentin Schulz:
>> Hi Heiko,
>>
>> On 2/26/25 11:25 AM, Heiko Stuebner wrote:
>>> From: Heiko Stuebner <heiko.stuebner@cherry.de>
>>>
>>> Jaguar has two type-c ports connected to fusb302 controllers that can
>>> work both in host and device mode and can also run in display-port
>>> altmode.
>>>
>>> While these ports can work in dual-role data mode, they do not support
>>> powering the device itself as power-sink. This causes issues because
>>> the current infrastructure does not cope well with dual-role data
>>> without dual-role power.
>>>
>>> So add the necessary nodes for the type-c controllers as well
>>> as enable the relevant core usb nodes, but limit the mode to host-mode
>>> for now until we figure out device mode.
>>>
>>
>> We're not limiting the mode to host-mode anymore in v3.
>>
>> I tested and indeed peripheral mode doesn't work. While my ACM gadget
>> device is created, I cannot communicate with it.
>>
>> Maybe reword in the commit log that only host mode is supported even
>> though we don't enforce it?
>>
>> The USB2-only issue I experienced in v2 has been fixed with:
>> https://lore.kernel.org/linux-rockchip/20250226103810.3746018-1-heiko@sntech.de/T/#t
>>
>> Tested-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> See below for further comments.
>>
>>> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
>>> ---
>>> changes in v3:
>>> - more review comments from Quentin
>>>     (sbu-pin pinctrl, comments)
>>> changes in v2:
>>> - address review comments from Quentin
>>>     (comments, pinctrl, sbu-gpios and much more)
>>>
>>>    .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 218 ++++++++++++++++++
>>>    1 file changed, 218 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
>>> index 20b566d4168f..5dbcdf67f0a5 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
>> [...]
>>> @@ -483,6 +583,26 @@ pcie30x4_waken_m0: pcie30x4-waken-m0 {
>>>    			rockchip,pins = <0 RK_PC7 12 &pcfg_pull_none>;
>>>    		};
>>>    	};
>>> +
>>> +	usb3 {
>>> +		cc_int1: cc-int1 {
>>> +			rockchip,pins = <4 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +
>>> +		cc_int2: cc-int2 {
>>> +			rockchip,pins = <4 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +
>>> +		typec0_sbu_pins: typec0-sbu-pins {
>>
>> Please rename to typec<x>_sbu_dc_pins as they aren't SBU pins, they are
>> pins for DC coupling of SBU as far as I could tell from the DT binding.
>>
>>> +			rockchip,pins = <4 RK_PB0 RK_FUNC_GPIO &pcfg_pull_none>,
>>> +					<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>> +
>>> +		typec1_sbu_pins: typec1-sbu-pins {
>>> +			rockchip,pins = <0 RK_PD4 RK_FUNC_GPIO &pcfg_pull_none>,
>>> +					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
>>> +		};
>>
>> We're the first ones to declare a pinmux/pinconf for the SBU-DC pins and
>> I'm not too sure if we should let them "float" or not. The default
>> pinconf for those pins is PD, so maybe we should keep that PD. (For C1
>> they are PU).
>>
>> Rock 5 ITX routes the SBU-DC pins to GPIOs whose pinconf defaults to PU.
>> CM3588 from FriendlyElec, Orange Pi 5, Orange Pi 5 Plus and NanoPC-T6
>> use GPIOs whose pinconf defaults to PD.
>>
>> I don't see external HW PU/PD in our or their designs so I would
>> recommend to respect the default pinconf and put PD for the sbu-dc pins
>> for USB-C0 and PU for USB-C1?
> 
> But if you're worried about behaviour wrt. floating, having them pulled in
> different direction for typec0 and typec1 also wouldn't result in differing
> behaviour?
> 

That's fair. I just really don't know what they are supposed to be when 
not driven :)

> Also the pins are output-only, so the phy will always set them in some way?
> 

That's true, there would only be a small time frame between the pinctrl 
setting the pinconf and the USBDP PHY driver deactivating them (logical 
low) since that's done as part of the probe of the device. I assume it 
really doesn't matter which state they are before being driven because 
nothing from the USB/DP stack is being run at that point?

> But now you made me looks things up ;-)
> 
> For the TS3USBCA4 USB Type-C SBU Multiplexer [0], the sbu pins on it are
> described as "This pin has an internal nominally 1.6-MΩ pull-down resistor."
> 
> In the block-diagram of the NX20P0407 Protection IC [1], it also looks like
> a pull down is the config of choice.
> 

Yeah but we have neither of those on our design, the SBU are directly 
connected to the USB-C jack without any IC in-between. So I wouldn't 
trust what one IC defines as internal resistor?

So I guess, fine for the no-PU/PD pinconf, but I would really appreciate 
the renaming of the pinmux to include _dc in it and specify in the 
commit log that peripheral mode doesn't work yet.

With that,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

