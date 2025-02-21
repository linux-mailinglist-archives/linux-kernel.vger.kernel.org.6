Return-Path: <linux-kernel+bounces-526246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72990A3FBF4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC48C188233D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887741F3D58;
	Fri, 21 Feb 2025 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="cJhi/8p9"
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012018.outbound.protection.outlook.com [52.101.71.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FB91D5173
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156197; cv=fail; b=Ie21aq9w2YNozOAxZvaDBCwwNIWt1DTygwuPZ/UisFppvrlKLPn+GNqTUEB4LsEoSjFm3C8EmNRg2PQkdq7KU6wLl9SCbFERBzXA23eJ7PHcvoCot3VuL3kaxJep2HsG7umB8S910ZpZyqGK77xG2cPVL+jRBgMoNV54KmMPLqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156197; c=relaxed/simple;
	bh=CC3QXrqnzILOQvmEOG76g6aZkvWGbNmrrzBmwdxaZwg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fxu/wpWs4OK5h8PK4E1QFDaR8r2M3I/WzmevqKa2TJBxSL2ZayrSqHR/nvhepayMY9rCMH0PyulES6z5RkgI7siHVHTRrzF6ncmtiQ3AvDpsnB3R8bBewZN/X3xaEwRAtAS7s6mKSYNu71SX93QkQJJB0n9gvqa6ROls9XWkTXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=cJhi/8p9; arc=fail smtp.client-ip=52.101.71.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KolwSOFB8VcZotSPc43J42cddI7h17UqaJUWbghie5eg2WdgTIbQ4304kxdZMVA++U72yqXKyM8gducF2KDylCNEqWe9PP0fLJUWwh2Z0s57xon7rFi6X9SjDcnSCujXvszEa71GOGWEkFOOqKERMARI79kR1r+1BD3j5z7fNx4Q6TaoiPRFPs9oBLzsXMr3qkb++mgcmw63a7+YQjcgOMLe30Vjg+n6tKKZ9z5mpgCM1ipXuzJGUFE1JrsnCIkAwjDBt6Yc2ov9ytcntqZlNS+PF1m4UqicoVpXE0Lkr8RRdSpRnEz8nKGNF4+8adfl4x3ykf9iH11M37AmJFfxBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpvRZBc03WYLxBkAToNkySPoK3wj6Q2kj1RyRliAYyc=;
 b=uf79qsRy9Mz6Ek7JZwERJB81EN5HOziQsjSeoOybtf29neE15nvcbO2KUQWaw0rAH58N0ORve3MmMtg2kYjmKWbB3k1+0HypSL9WtHBmXcW2dCe3KIo6RvGvnwpLBBWz9HR2Gd8t7vW81hZkYDOUAdW30aSvQtjzH0nKkgWViT2cmvYoVYrDDzOyEc8EDbC1RB31jUVbk/13lqVL4M1nsHKo/tI5Y+HCqDKcxuiqaaiXHrL3WRtBXn9+Bve7NcrXE14m8DRxVu+j5TLEEa5Yg10na9X5KBfcVsvxNsmA+gGBKp70yRM0XC4dHMM+kATh0rnkYSK2X6QqeFIrpDUNiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpvRZBc03WYLxBkAToNkySPoK3wj6Q2kj1RyRliAYyc=;
 b=cJhi/8p9laMSHV3LQv1rZUorReFFts1c1jSyadNxSJc+K7fyP9ustMaVOZby9LGbA2ASOEWA7Cd+9SHIkqZH8KPRcJSiVYOqkhV/FW/ndJ4vMQQc/ubTf9pyXUK3VuzHPOvYTkUTeyKGdr2hDi5o2XIGDaGSFqS76jiJqV/hklA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 16:43:11 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Fri, 21 Feb 2025
 16:43:11 +0000
Message-ID: <c50c6053-4569-44b0-943d-5450960be147@cherry.de>
Date: Fri, 21 Feb 2025 17:43:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: dts: rockchip: add usb typec host support to
 rk3588-jaguar
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>,
 Chen-Yu Tsai <wens@csie.org>
References: <20250218211044.2256762-1-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250218211044.2256762-1-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a807193-fc0c-4eee-d168-08dd5296d2b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWE3bHBMR2J1MklwVnZ1alFZNE43WUxoWU0ybjNQWDRrSFBrY21pU1ZYOE1k?=
 =?utf-8?B?UjluMDVKMGhRak1QVTZhdkNUbG9idU1EVlhEMndnZURBS0VvU3R5aXc5UE9Z?=
 =?utf-8?B?N3MxanJYcUZGdm1IUm1FamNuTUdoVkpPbEFyaTdWUFMwR2N2VDlsSG9QTDlN?=
 =?utf-8?B?bnBsQ1ZERkNORmphOE00cVBWL3NHTzVTTEIyVnlBMmd0cnlOZzVRNVJNeHg2?=
 =?utf-8?B?aEJzeEhHMzlRdjFySlh1cUhnblVTRldrZEF6Um1rd3pkMlNycy8xYXRXYUFB?=
 =?utf-8?B?ekFHU2Q0ak9nc2VORWdNbWlJTFVUTDg0TTR5VjhYNXJTSDlBbEtOZUtmanEy?=
 =?utf-8?B?VzQzenh5WWh6djJ1NitHbFBnWUJ1cFhRbTZQNXY5Ukx2M1Y1Tk9Qbm45dnky?=
 =?utf-8?B?RFYvaHBCaW1yTi8vWTdQd1l1ckFzN1hiWDNTUjJ1N0lXaE1hWlc2Zi9GN3gw?=
 =?utf-8?B?YkhGTkh1bnh6Unl2Vnpab2dSMUJQcXpFWUZ3NDRHK2k3RU5EM3lsU3B1VHdN?=
 =?utf-8?B?cHBYc0VneU9DaFBFbkNkTlFCdnY3bmY2cEg4NkpLVC9aSmMxVkw2Z1ZkMDM1?=
 =?utf-8?B?eXQ5alo2cE5pelNob1UrTitmYXU2SHBqdEQ4emYveGJ2VHd5eTRoN1ZnMlBk?=
 =?utf-8?B?QXFxVHVkK0k5bzNuczZXVENTblBkNzNwK0Q0MzdGbTBGeUY2OWZvb2NKdmI5?=
 =?utf-8?B?Ym5QbWpVVk9uUDFQTHUzSTJSRWJHQ2RJUzZBYUtMUFc2bnFzZk1Vdzl4WWZQ?=
 =?utf-8?B?VFJybFB0M0d4VXd6NW1xdDBROEVDRnAwMUhTYnQxMTR4R3RwcGxZM1NYYmFU?=
 =?utf-8?B?cW5tWUhsckhzQllKOHNaQXhHaFBUNWtscU5NN2FBYllrVk1QcTJlK3R1cHZx?=
 =?utf-8?B?NUVyUEZtNlFDLzE2YnV3WXlZdTZqYlVkL0VCeXpMdGtkTzFpTzhLYW9hb1RB?=
 =?utf-8?B?S1dSdUpyK2YrZGdFbTk0cEsvMUQwQnNvdWtrcWVwUHBFQXJRNEM0YkxYenN2?=
 =?utf-8?B?N0pHZSs0TXE5SkNyLy9SZFM0ZDUrR29YMHdVWVFPUDdRTDEwOXkxYXpYRnlT?=
 =?utf-8?B?K2J6NnprdDBHTy8vTHdMbkZaeUVhdDVRZnRDTkVqRkJEN1E1MDdRbnRjYVN2?=
 =?utf-8?B?S3ViUGFjM2phbkR1c0V1aFNaUkwyeTZjUXFHVEpYaklNV1VBT3pJTi8rcEhY?=
 =?utf-8?B?Y3JSL2pqYzB0ZHdVSU5aWWZ6RXhRQkJKR2tJSm5wQThjTGt3MTZlMVEyN1lE?=
 =?utf-8?B?M1V0UnJDdDJmaTVFYS9udHpoYnUyWGpHSll5Z0xpTGZYQmVnWEx2ZjI0eEdr?=
 =?utf-8?B?bzkxVkdTdldwK3p5VlBBZHNxanNNUWt1bHJDSENHcThDanp3dUJLazhJRmZw?=
 =?utf-8?B?QWRDMjYvdCtqclZPS0tkMmV4em0va3pMSXpHNmR2QU03Nkk5MHR2emE1bFhQ?=
 =?utf-8?B?bTA5ZytOQkE1UlM4RFQrS0NtMm1Sc2NjRkY4NmE3UllTTlIzeS85Z1YycXVk?=
 =?utf-8?B?NEExUGt6Qlhwa1hodVZPL0hXQ2RVeHBibjlLaHR4UGFnT09MSlFkTVFQUGty?=
 =?utf-8?B?OWw1K2NBMEhEMXdCNEdXa2Voa1h2TElXUlljS2NVSU0xemVLdWZ2Z1pzNm1k?=
 =?utf-8?B?RlFWNkpCWFRUdVJyR0NaSHFnd0lncUpTdmRUOEZ2V01VZEVUR3RWelBZY3ow?=
 =?utf-8?B?OUc5OGwya0YzdHVleUZVcWQ2R3o2eGNUNTE3L3BaekZXamN3NExISkthWXpM?=
 =?utf-8?B?U001YXIxYmJsTytDTXVHQmdtbDJyTW5rR2xlRWQySGZWYUNFNWZMTXZERzlM?=
 =?utf-8?B?a2c0dFN5QkNiajBCTVF0S21uaU5LZGF0blEvMWQvUjUxK0JZWEZkWlNtZlFu?=
 =?utf-8?Q?rHa1yJc2CO+le?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2RYaFdSSmxoUWZvUk9aK3hpWkdNb2FDVWUwdnZKV3B2ZU55emVES0hORGk5?=
 =?utf-8?B?RkF4cFM3eHdQR3JIenVENSs3OWdjU0RHbWcrL1R5c3YrR284d0xsRWwvMFpC?=
 =?utf-8?B?SmlQbUdEcXcxSEovc1FqUVFZOThCc1JSdFducnM3QVlPQ28vSi9NQkFmbnpT?=
 =?utf-8?B?cWxna2FHanV6MDdnRzBPbFI3ekdONGZSZHdBdjJUMlErY3dqYUQ2WVhDdUZW?=
 =?utf-8?B?OENWTnZOenZ1WTN0NHozRmhnRWtOWGJYOVBZRjJHSGw4S0haZHdhelZHUS9R?=
 =?utf-8?B?a0REazJDRWR6V0JaWDI5QUJTUkRBRmtFcERFZ3MxMnZYZ2txcTM5UjdmVGdK?=
 =?utf-8?B?RmFsZnZVcVM3VC9RZzlXT3dLajgwUHJTdTluZUppNmdxR3NWN2w5ZDUzcm1n?=
 =?utf-8?B?Z2JPNlhPM0ZkSG1PMExBSmN2L0VvSU9vT3VGeCtJcGNYclV4L3dseFVCNXFz?=
 =?utf-8?B?SUVZQk5NOXkvOERrd2owR0pKeExrZU9zSStpaVVzRnpZU2JIVDY3Z1FPNk5v?=
 =?utf-8?B?N2VYcktIZ0FlYUVUREYra3J0VWlYQmtZT09JWXBtTFhLeTNQNitHVGo2Ukcz?=
 =?utf-8?B?L01aZzhNYnZpd3JnNWdJdWxDZUMzNU4rU21UMFlSUVpMUEtZSWRIRGpHVHk0?=
 =?utf-8?B?dFRzLzNja1BJUEdHK01BYkM4czBRZmRjcmVOQzV0Vy9VRVdoek0xV3gwSjZy?=
 =?utf-8?B?ZDl2U1c0Zm5ycm9hb1BaUTZWVnZvOUJGa3orV3JUZm8zOU5FS084cHVyYUtT?=
 =?utf-8?B?WEkvYlV0T3VlNi9odmY1Tkl5MU5oSEZ5VlY3SjlUeWhlcmthS0xXZkhzR1ZB?=
 =?utf-8?B?V25OU25FQllzK1FzWmlBcUFNZnllNFlCbHRuU3NvZkM3Q01vUC93bGc5K3Bm?=
 =?utf-8?B?SWRjZ0pZcmM2NXFCWUpsSGg1SktBelFhNWsxWWZXRXhlbnhnL0RlMFFPRVVV?=
 =?utf-8?B?ZVNwTWZMeGVZTU1udEt1RFlBYlhSTUd0cUdXRnUyNkw2K3BQV040cVFDNUMv?=
 =?utf-8?B?TE5TRzlhbWIwSThmakxld3l6L05wZXozWlN2ODRUYUs4WFN0aDI2aUhhVlB6?=
 =?utf-8?B?RWRJbURUNXlDdEpBMkthN0dIdTBQVmFyTk5LdGpkT2dlc0k1aHlWYnNiRy90?=
 =?utf-8?B?QkN5eGk5RGhjNEtmR2pKUzB2WHBCMjNNeUY0aFVKUFdheXljaDdKWXpKNjJk?=
 =?utf-8?B?Yk90bzhETERkVmx0Nlp3SDE4cENtL1dqdThMRlY0akZ6ZitXNGs2b0c3aHM5?=
 =?utf-8?B?YS9VbWFVcFpzc3k1dCsyMVFJclFXenFaaVRHNDlvanR1ZFBoYml3d2lOVEN1?=
 =?utf-8?B?bjU1eXFYZWovLytERDVITERUaW1lNlEzQlBzc09ZWmgzckc3WDZkbHUxQ2VX?=
 =?utf-8?B?SlhmL0pvZGpHa0p0ZHAyOUttYnJIU3lmaHA0WGorWGxuS2dvYndiZ21xMFNp?=
 =?utf-8?B?L0hHMWtDUWNYNXZPcmw2REdrSkdVSmpnZlNRbmFNLy9qcjYwL1owbWRrMEk0?=
 =?utf-8?B?Zjh0NlBTNFpvQ010K09hR21VT2hHenloTnhVcUtwRXpDcHQyNHJJS1dVWWQv?=
 =?utf-8?B?cm94eUd0TmZMNDhIeUtCUHJVYVJGTm1zdEdLY1Y2YW5BNjRBODVrT0wxRFJ5?=
 =?utf-8?B?UU9TYmdrY2pKdTNXajdnbk5WOGwwV1lqdDVYQWRKbzlneDB6cW1EMW5ORlQw?=
 =?utf-8?B?RmZWbkdvR1ZxNXpueXdXWmp0WmROdWozbnJMNGxucUthNWJsc1pDamE2dE8r?=
 =?utf-8?B?eVpjRGhPcHlML1FpKyt6ZWtoVFFPbktKZDFZaUdYenRybmFWa05ldGpqRURa?=
 =?utf-8?B?UmFyekoyZW5kenRpbCt0WGh0a1kzU3pObyt5ZFREZkRKZTNsMXdjRVA0ODVt?=
 =?utf-8?B?ZGtpTjJFd1dvM1J3NVRUOEw4VmpPMFNDWW9PQmVkYms1RTU1bHlhcmdrV2lS?=
 =?utf-8?B?Ym1hV2ZOakNQWktzUE5uUG5IM1UzZDIxdXNwTmhQV1hXQy8rYVdqUUFpVXJv?=
 =?utf-8?B?TGhOdlpINUw2TjFJUFZwMEhOaWFXcEFkbHVxNDFMTG5mb2ozRXdBdWh5UHM4?=
 =?utf-8?B?WVFmaTJLQlNIWlVyY3EzUEI4MFNIZjl1NGk2V2Rad2VRamdBU3lQTnZuRXFN?=
 =?utf-8?B?QlBKSS9nN1BCWkljb2QxcjlyNEVwT3hvOC84QXBrcjZtY0VPanhJcGo4MHNY?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a807193-fc0c-4eee-d168-08dd5296d2b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:43:11.2921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DSD+1cYwzHPPv6ulxQfjT2IexAnJBOiSVHZ3cvBGs/ShxxRB9AcLC6be5tO6BPfdETiGj8C+ZzdR7oDxezvZRarfRFP1CpZGFWjILIx3+4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9630

Hi Heiko,

On 2/18/25 10:10 PM, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> 
> Jaguar has two type-c ports connected to fusb302 controllers that can
> work both in host and device mode and can also run in display-port
> altmode.
> 
> While these ports can work in dual-role data mode, they do not support
> powering the device itself as power-sink. This causes issues because
> the current infrastructure does not cope well with dual-role data
> without dual-role power.
> 
> So add the necessary nodes for the type-c controllers as well
> as enable the relevant core usb nodes, but limit the mode to host-mode
> for now until we figure out device mode.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

While the USB functionality does work for both ports, and the 
orientation is properly reported, it seems like there may be some issue 
with how the PHY or controller interacts with that info because I do not 
get USB3 speeds when the device is inserted in reverse orientation, 
while I do when it's in normal orientation.

I assume that's the case for the Rock 5 ITX and Orange Pi 5+ as well and 
probably has nothing to do with the DT?

Should we go still go on with trying to merge this patch knowing that? I 
mean USB2 is still better than no USB at all :)

+Cc Chen-Yu, owner of an Orange Pi 5+, who may be able to confirm the 
issue is widespread.

Cheers,
Quentin

