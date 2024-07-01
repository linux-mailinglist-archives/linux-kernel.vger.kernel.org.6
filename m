Return-Path: <linux-kernel+bounces-236155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FFF91DE2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F7A6283FCE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB0C1422A6;
	Mon,  1 Jul 2024 11:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="ZxkK6vxn"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2097.outbound.protection.outlook.com [40.107.104.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0311F949;
	Mon,  1 Jul 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833804; cv=fail; b=NtRcARGwWoHiHCszx54XAVNk+42etA8r3GL6bbnG09KNtymcWIOi18hgMCUTyg+UnakdUxCwmJksne7K3V4nNpLPX083iLvj2ErqCUroFQ/cNHVexxPooNlUjb61YGDHvWfSD3hahXwgHdQfYtAXEF4B24gPgWTorEnCvLRrUJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833804; c=relaxed/simple;
	bh=Tk9vnuyjRueNMpc6WTgXkLs8Vd+AbklOYu4Jx3XJF/s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Og1aCXOvgCeQMbJWApyzKqF+BoRAbPH/2iPSYKq2edXBPQokEWQWkZNr2snOgawp2M5xi9oJLWZCJpPPhW5ZoOsNpn3Fe7bvCEedY8OdJc7Vf7mhoXd6IZehuVxbXHDNRnzWp8JKwtZkN0HN6hM5IhGmNEIlEhZZ1R7c63T3xho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=ZxkK6vxn; arc=fail smtp.client-ip=40.107.104.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GniOzA93ss27eB5Z4BfKZnUuxPL/u/Wh9SqAo5h9NU+iT47obQed+R9nrWZfWpczht5eEpAP2fFhB+usdbA2+zQ3uzlM/Uof3HFeXqCkmwmhpLyw3TurJQ/ULS8HGBhyC8NHvEMZsR/VIYmZ3Hvsds52yTTx4ClS+yGaU8jI1OawJ4KeG+rqRtfOGD5U+gsMf/ZFsJoJNP7mEY6kmBq9zceUNKJ32HmekbGSlA1WWSFSKswK3yhZQuFVuBRmefrexC2nCEQ9pE9/0Moyty5k0/bwbzYJB/pYXu4lWzVoaUJbLUUjxTCfrfktzqX8TFxN0ca4IK8gYjdJ39iu15QGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2e/TMYlRqAwKSO3SXveYpdrHqqSLyGXIgKiZIu7SQI=;
 b=YJHuO5y52Rd2Wjw6S2tBrlf/NklSberGd3fyqfR2UmFbEGfTbmNP3hEesxANwaBr3P3S9k0Hr9jxvQF5GuDpXSHTNZlaiYy5JaLqiJiyOyhvd6ShCNPp9mYeUIy3B4OltZYdjoYK1QJj2dZqPdn7/BjvnQy/YkDx6JPV9bdDqIpGZw/GybvdXYzH9nEDpPtw/geQlP8TIVFVDWuWGHiByaqXISc/HSgdC5SsFsqHzN3oBJQV+zcRO3qTruwnwYSFmbxm2aFlok0/0vblYshhFwKxzHSwMjpiGL90xHCXjPDzBoLG4oIjHpuF+diqDJ437WUYoTk25MOEc9bH8lqpTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2e/TMYlRqAwKSO3SXveYpdrHqqSLyGXIgKiZIu7SQI=;
 b=ZxkK6vxnvHXIffkhGvRGndVqyb45fkOc+fl91Hk3Uo9nMmDHigb3jybiEzNGBiohCRvGHf3IN/yINh9NSlSugE+sHI1I4e08MtIHXoKWv3xydG/j+ZGrxaGD5qFWN2Om+T8pEt/pLPuJyuDKmmho1+N87x89fXS5gT+Zxw03syA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by VI2PR04MB10267.eurprd04.prod.outlook.com (2603:10a6:800:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 11:36:40 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 11:36:39 +0000
Message-ID: <3108c6e2-c865-4170-bf23-f45dba429e80@cherry.de>
Date: Mon, 1 Jul 2024 13:36:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hwmon: (amc6821) Drop unnecessary enum chips
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-9-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-9-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0030.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::26) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|VI2PR04MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f6ea37-faeb-40eb-b8fe-08dc99c212cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVBLTFd0RSs3d1lmcjVKOHAwT0hObzVoZlJ1WnFzVElhNTJxZWxmNWl2bG14?=
 =?utf-8?B?aUpqSzlBWXg2ZTRVY3BZdnFSbzZTZDRmOU40cXo4OHNGMlhlWnNnNjlyeVEx?=
 =?utf-8?B?K2w1MEFZYzNBWGF1NG1aY3Z3UzdXSTkzMFVNM1NTd2VhKzNjQWF1VlplR1hK?=
 =?utf-8?B?VHp5WVViTi8yRk1mMjF5TXErVStLOUxPT0o5UlBsWjFYZXBUZ1hIQk9wMkg1?=
 =?utf-8?B?VlNoTDFNem9wU3cyUzZSYUdaS1BaU0NZMTFEUjgzV241UkhkTzhieStZVGsx?=
 =?utf-8?B?RDBGSWIvMlZ6WVJuLzRpV2ZxUjdTYUFWb0Q4V09uYWh4bjg3Z0RyZmRLTStW?=
 =?utf-8?B?UFI5c0xMOHlncitBUzhldmhveDUrYStxMzJ6cU41NUR6ejg2WE5Jd1JRcEJ3?=
 =?utf-8?B?RUR6UkJXYWFxejlJVGFYRnUwUHZiWWRqRHBVQU0yZkVUOVIyaUFiL280Sjll?=
 =?utf-8?B?ZUUyenlqNSs0cjhCRHdOK2xBeUppa2NJOHJyNEJ1SjY4dlV6NzhHeEJ4WWNW?=
 =?utf-8?B?VkJGWGJzUkJaSm9GYXpDSTBNMGNDbnk4NjFnMm54aEpkWXd2cUZjbzJiRTRC?=
 =?utf-8?B?bEJjRmFXZnpJYmtmV2RDdEcycGQ1TVpTTzBKMDBTRGlpalpzTzNhVjNyeHho?=
 =?utf-8?B?YTJVVmVIWEdpU1BDd3ZwQzlMbXhGd3Q0WWkzbFI1cEJPVExXS2Y3ZU1SV3o5?=
 =?utf-8?B?UUg3VmNHcWZJS3lvNFk4SFNNU3BRS1RlRjMrZE43UmpTTExVZDRtNlBNSDBU?=
 =?utf-8?B?cjJDdHFwM255QTJCaFdCYzZqVUE2WTNFUXhUcGN0eFZwbDBNZ29KcXBMTkl2?=
 =?utf-8?B?RTMxM05BaFYxU2pwbzBIa1lhSzdLZDlxdWdZUllXUHJkRVhNSGpxOGNlcDc2?=
 =?utf-8?B?aHJtenFwdFBQaGRBWVJRNnRCQ0lCY0pieVhTZDgyaEt3RzBQNnpUU2gvTUVP?=
 =?utf-8?B?WmRuUTU5eGl6UGFjSExEWnBKUHNMNXVIT2IrSjJvU1ZhTlZNWnB4bkpnNkJ5?=
 =?utf-8?B?emJZcUduQ2VyTk9UWHZWb0xuWVZ1TzFOQ0lMMzE5bkhESVRmWnlpK1JodkVO?=
 =?utf-8?B?NjJtcmxWYUdYcEo0bkUyTXhwMzdjYWVsc1NjM3VhTlFTU3J1MTg2OVZ6WkV4?=
 =?utf-8?B?UXEzcFFWaXBqK2ZMVUxRS0JUUUJXcnhzNENXSnNDR0tUSTIxYUEvOU1mamxl?=
 =?utf-8?B?ZmNtNGpTL1ltc2g5empOYnpLb0dUZUxWTWdxZ095NTFzVCtXMDFsZ1RsKzE5?=
 =?utf-8?B?Vi8wbkZ2WmFCNGh5ZjlTNXFTSEFUcWFMWEZVcjF4V041L3o5TTN2QWRTQ0dH?=
 =?utf-8?B?MTJPSDFMYkJvN3drWWZ1RlBWYkZIU2tDV0tvV2gwMkl6djNSbTU3S3dnak1X?=
 =?utf-8?B?SURhQmc2NjFXUTU4UWhnQkhPaFc0K0hZcG1BTWkwc2pCM3Rld1RIQ0hFd25i?=
 =?utf-8?B?dFpIMWVqamtRdDI4d1ZzeDNQMXExYlNIRVkyaDhBK2F3Z0FNcW11TitlMFVz?=
 =?utf-8?B?OXZ4RlVDaDBGZVpjOXA1VDdSZnE4b0pvNXh1RytPOVJ1YW1LOFJDd29uazRv?=
 =?utf-8?B?Q1VWcmtEWVRTeXd4dWphcUZReTgrRHNUUFFPcWJXRXJudCtJZWUwQWkzc0dp?=
 =?utf-8?B?aU9WcDdhODBUZ21yQkg0ZkRrZ3VOTkVTalMrakJZN2ZkZDY1aU9FSHZWN1Ez?=
 =?utf-8?B?RGZLditFaVJ4ZHk1RjNSZHBtR3pEOVlSbmQyc3dVT0lmM2pEaE5QWDNoY0o0?=
 =?utf-8?B?dWR4dXNiMHhTYXZBQnVpNng5RC9zYnBoa09IQjVJQVZzWXNlM29PYnNKdkNv?=
 =?utf-8?B?MkFVMDU5WXhaWCtpM3NuZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmduUjJGSm1YVlZ1bTFhNWdIcUF2Z2EvQWhYL1Z2dE9odWlPTlViY0FVaXR5?=
 =?utf-8?B?TStRL016aVV4TEsySGoxYzlPMmZKYmsrWEptRVA5d01QSmRZU3FpS21HYitX?=
 =?utf-8?B?cksyczR2dmpOUXRwSEVwKzF3YzZJcmFqallpTmdaMzlENGZranJ4ZlJJcGIr?=
 =?utf-8?B?TDdlUHBrR1FaMXNMVzlrYkFScmNoN3RVd2JBcUFyVlg2c2pzOTAzWVcrdHVB?=
 =?utf-8?B?SW9qQVRmQ3pWSUpxMkJRYitOWmIvWEx1NytBL2JNS2pGMnFkbk5PY2V6c3po?=
 =?utf-8?B?djZiZit3SlVEbmM2YmNUTmxOL1J6cHRWTVAvaUpyR2tobjVTR2xxa3owcGdF?=
 =?utf-8?B?cURtZHMxc09HSHZvZDV0cThUVmhaL0FiUWFybmt6azNMb1A0MVlydkhXUU1x?=
 =?utf-8?B?Q3lYWk9IVXhlSkJHbVQzOGlIeWIvRFhKM29SQnVjWEsya2YzRnNOQlFCVlFF?=
 =?utf-8?B?S055MVgzUm91a3lpVVByelQ1UzVzbFV5eXpyQjZ1dlNQbXRydW82ak5Vem1D?=
 =?utf-8?B?NEFYQzlVb1R2V0xSWWNqVVRFSHhDcnIyM2tRcFdmdGVaQ0tGTVhzaC9IZ0Ns?=
 =?utf-8?B?RVVuTTY0VmVBZlNyOURBZmJ2UjkzWTFnT2xtOGkvWnNhMXNTd2VZcm1hdzRE?=
 =?utf-8?B?Y25HS0RBZ3o0TWRyVFdBSGpkS3NSSTdKR0NaSCtqMGk2dll5NmhHUkpyN0tE?=
 =?utf-8?B?UTBISDVXU3BZTjYxQlNBaEYyT3FiTUo3MW5RQ0RUa0JZQlI3UGFlY0E4OTFp?=
 =?utf-8?B?dDJKUE15NWZHU3VvdzJpQnhISCt5TGtBRWNhaUt4YjdnbFRpeHhKYWVXaUFi?=
 =?utf-8?B?Ulkyd2xuS09rWHVuelJLQ05kMkF2M2x3R1BTRDNINDA2bjFvdlhUZDRPeTc5?=
 =?utf-8?B?bENxRzY2bXBpd0hDWDFqdi83dkZIOUp0SVoxU0FoM0lWL3dXNDNuNGZOOW9K?=
 =?utf-8?B?Y2ptd3lTM1M3Wlp2cGM2QjJ6TDRPQ3c5MkQ1Yk9MRVN0RTl5N1JqbVh4cjdv?=
 =?utf-8?B?a3Q5WHZRUXpJamtlTFhySklpbmtZL1JJRC9jK2FURFF2cGp6VzV1eFNId0pE?=
 =?utf-8?B?TFJZVFBaaU9wSDhTcFFNdHVYWVlONzJmaWluTTVRdUR6dnlSYjVSUEtoV0Yr?=
 =?utf-8?B?S3IvVlRRdm9ZT2hibHBsRktldmZkcm1reVpuTkZLVEZrUVpIdWJ0RkhtYXRR?=
 =?utf-8?B?MTE5bU1YL1ROZVpWd3Z6TklUTi9GSEJuaWFYa3ZubnR0d1l1RHkxcUxzU0Vi?=
 =?utf-8?B?UHdhRU1VM0N2NUZJcEtyNnFoYjBiZDZZYlFNcVN1N0tuUXZwcWJpUDFhTlRQ?=
 =?utf-8?B?QUJGVkdqUDZPV3B6KzNGaXJhZi9BRWhJaXJJWGJlM2V2WGQ0L1ZobExlSm9z?=
 =?utf-8?B?VFZtMDZoS09rOUhpaHhmU05UQlVQbjBwcVRkZjB6Zm43RXlrcVJ6RG1oZ0l1?=
 =?utf-8?B?UzNHSWFaamNLek10RmhaWUF4NTRoSC9ha3RuVnVZU255QmRTNHNYYnlrazhM?=
 =?utf-8?B?ZWovdUxBYVVJN2xFRWpZLyttUVFLL20rREV6T25vYmhERHR5dHRpWlhWb3Bn?=
 =?utf-8?B?c05hSHV5VXBUZkpLOTBVR2tYUmpoa1k3WCtKaTVzQ1pvWnpiL0dYTGRCdUZ2?=
 =?utf-8?B?dFF4c0xhNzBiYytabXFVd3B4TW5xcDNjaVF4SXZ3bmxqcE04VUxDZXN0VmF5?=
 =?utf-8?B?NzNsMzN2b1JGVWZPdVFINGxnT1phMlRMUUFhS2FkQmhKYzBuc3BZbVZTVUdB?=
 =?utf-8?B?dmcvMXcrUXRMM3drc0lxNmpkU3lEQTVuWkdZbTVPbjQ0ZDJxamt5clRlY2w0?=
 =?utf-8?B?ZzFsTkE1cDhxbXlTY3VseXhSaVpsekNmZllQUEpHdGc0OUdINS9QbHRQcUdL?=
 =?utf-8?B?NEpKenJXakIxQ2QvVW1RbUM3bS9uY2xlUjJNMFRGMHltNExsejZFSCtTek9Y?=
 =?utf-8?B?NWtKSU8wOTYxVEtYY25hdHhIYTN4cFYrUHFWcTBWNlZqNnRkdDJJQlVHOVNT?=
 =?utf-8?B?K2NBaC9EUW5nRXBCcmJZRG9rWWNyZmUxVmZYQUh3cS95QVI2eDdSbm5kbVk0?=
 =?utf-8?B?WTh4QmdwMDdveE1BMmY2dGNGc0RFUTNBSzlJWmNvenkrN1E4YXFUSXJTNVlX?=
 =?utf-8?B?V3RseDVtYTBGaUlKakd4L2JLL1YwRHZiMGp5YkR1MFN2ZUJ6MkFjbG5RRkNQ?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f6ea37-faeb-40eb-b8fe-08dc99c212cb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 11:36:39.8954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJkUxtqef0ywzUN9QhC86kE+l1JFhkyx6b3iJO4a81WzcKq6vgwAhnDrCLijHaGTT1MRlsHfPX0dU9sGisrbLw1VqPogLBczFLpTBOi+TAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10267

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> The driver only supports a single chip, so an enum
> to determine the chip type is unnecessary. Drop it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/amc6821.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index 042e2044de7b..ebffc9393c3d 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -36,8 +36,6 @@ module_param(pwminv, int, 0444);
>   static int init = 1; /*Power-on initialization.*/
>   module_param(init, int, 0444);
>   
> -enum chips { amc6821 };
> -
>   #define AMC6821_REG_DEV_ID		0x3D
>   #define AMC6821_REG_COMP_ID		0x3E
>   #define AMC6821_REG_CONF1		0x00
> @@ -943,7 +941,7 @@ static int amc6821_probe(struct i2c_client *client)
>   }
>   
>   static const struct i2c_device_id amc6821_id[] = {
> -	{ "amc6821", amc6821 },
> +	{ "amc6821", 0 },

amc6821_id being a global variable, its content should be initialized by 
the compiler if omitted, and the default value of kernel_ulong_t (aka 
unsigned long) is 0. So I think we could just remove the second 
parameter there.

Doesn't hurt to keep it though and it seems there's a mix of implicit 
and explicit initialization among the i2c kernel drivers, so with that said:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

