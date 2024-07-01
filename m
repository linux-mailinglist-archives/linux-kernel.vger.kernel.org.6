Return-Path: <linux-kernel+bounces-236302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD0591E02E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A04F1F2361B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C2315B0FD;
	Mon,  1 Jul 2024 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b="ToouuUEI"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2110.outbound.protection.outlook.com [40.107.105.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F059912A14C;
	Mon,  1 Jul 2024 13:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719838926; cv=fail; b=YUQLTNHcn/b/yasQ0HbeSnVqF1Eoxr3E6q3TXvYOGXNbMb20fYHHLmEzLrV1VRH9uHlGQtTvZWXhzcks2hlcnNhpwKU8uLJ77/PjDAF31YwljmDLUmD3XyGnr17LYSZ7dCdBPiFCY7UlX7ShJdqobX6GdZmTpMBcpMIjOBvPGNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719838926; c=relaxed/simple;
	bh=Fbq81MEc4lZzgqmp6hKmh0d6Jciu090s65P2s4Qt5xw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SrQPJd+5Bzylk1OaybU6gP5fft9K21h4Qgvve6NWB+mFGXwoV0N/GSyYZvCw0ZY2gHIXg7y1xRD3fZUi7zQy3apt9rev6V2BtMLvSgGb45TM6vT6aSk18aeWtrazjz9WWyfF6EbX73/o269qgndz1PDSEdWA6chbcL1HM0bmBVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de; spf=pass smtp.mailfrom=cherry.de; dkim=pass (1024-bit key) header.d=cherry.de header.i=@cherry.de header.b=ToouuUEI; arc=fail smtp.client-ip=40.107.105.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uxyl2q0ctnjis/fdGBLPVTWMPZhY5hzmnNAqSmlmkcPVT/E2d8XY+eb59CcaXFElIVVZuYLuHrN3Gfop7AD18C7L20LeJ4GsZjWu/02VFMcZSrprRWui7ipt5eWf/Lwr744R4OHAz+l55j207aqKRnEYIyMeM++ChZzammwquYZLg09aq1ARsHbONVtKvi84a39OH1fRxlYmBh22GjBfrDcU3sVT1vU7SB77ArIBOOiga5HEO6LIZe8mCVddnX/YvMHVvd0QReAqdtdVzzMY02u364rmG2rL5tv/iNT7VT8bnfI5UXQ6rA4OutOWyTzKz3/D5GnjBw25uc+iZCzi+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkv71LLhZYrzp+qnA46dCq3+yCjwVvScMIrK0eiKuyc=;
 b=dlD27ciSt3EG0wq1okdVCZ4e5voFB2z8Svp/gKn8+iuc8cSwe6uqj/L8s0fFwjr+kmZAzX1JBLOjiiSyXZc4ZY+Vkqy2y0WL9VNVTcdjw6cK8Ysypj85LTaxyyLv5h2ylElO7RnNXsUR8acc2Helty6vFbc/P8JTedx4EAZA294idA17jhbWaSUzGQVx+Tb/am7x6gSxqrvT9t1TgZ3buFMkdnMWVC340Hyu/V2jDvuFkSeq5OY+DHR9cIa3t3nkktTbxK+uBTM4sJPdyjh0dxTKb1m7XCPcZfpahT6Q+nJU+sJvuuRVcJA0c9mx7pPr08ABxgUb729zQEj/k5NgEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkv71LLhZYrzp+qnA46dCq3+yCjwVvScMIrK0eiKuyc=;
 b=ToouuUEIsRzx7kvbTfRhAtlerL0bQOdukuekG2jzeGvn7PXslDIVnJPBd8pBLnGMg1vrQw++7qOfNxbvlggpO1LKa8ACqCQ/volgbFfh9Ki37gFbBdnQyAAdWidGn1Gga7oh/g8LPQ3PlfppkPbAbv6o0hIINf1OkVkno9tUxgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by PAXPR04MB8623.eurprd04.prod.outlook.com (2603:10a6:102:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 13:01:58 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 13:01:58 +0000
Message-ID: <7a829bf2-c5f6-4234-a224-52328045f581@cherry.de>
Date: Mon, 1 Jul 2024 15:01:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] hwmon: (amc6821) Convert to use regmap
To: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Farouk Bouabid <farouk.bouabid@cherry.de>
References: <20240628151346.1152838-1-linux@roeck-us.net>
 <20240628151346.1152838-10-linux@roeck-us.net>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240628151346.1152838-10-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|PAXPR04MB8623:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a45ea30-2741-4f9f-e221-08dc99cdfdd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWpZeFVZNFJsVnF1aFBMYlMrWFd1bE1xQjROVVdxZkdVR1dkSEsweFhjRlFs?=
 =?utf-8?B?MlR5TjRTUzBKSkZYTmpjSGR5WkhqU0FycTd5MHNORkpzYWVYQnBpSk5PdUNO?=
 =?utf-8?B?WHhEMkQya1pqNDRObTVvK0RzanE2TkR6dTIweGdyOGJMakYwWjJLOUg2eVNt?=
 =?utf-8?B?ZGEzU0JxOWlXZHhEYWtaQXYrMy9LUXBHUTFMVk5PalhCYjNzN3ZmQ25TMUlI?=
 =?utf-8?B?WG1vc2NuWmhNZXdwTkJoaEJCM2VLaWh3N0w2b0lyUG1nRXdjclFBeG1SbFpr?=
 =?utf-8?B?VDlNbnhTdHdJSzVjWHNHRDdhcjNKSk1uOHRoTjc1blYybzBKZU9QaTkvWVpq?=
 =?utf-8?B?SjAxaXlaaGpmNS94UTZLWWRmOXUxYWV1SVp1UmU3ODUvWjB4MzYrcFBhY0ha?=
 =?utf-8?B?Mzg4L0hVRlFFNDVDSGlSTHU5TGpXRlM2NXBJMFNrTzJWdDY2alZjRjc0eW1t?=
 =?utf-8?B?dEJCU3F6eWMxMTk2cVljNXBvNHdjSXNvV2lpeGhEVTgzRGxFVWRHOWh1QjBD?=
 =?utf-8?B?eHM4OTlIV29vYWhoSElENlg4Sk5kQWpmT1V6QXlkWTRpcGxOOXR6M1FpbjNt?=
 =?utf-8?B?SUt0SDdhc29DT1VQV1FXWWtBNkpyRFFZZ1R3WUNHeFJvbk9JSzFMaUFPYjlR?=
 =?utf-8?B?QTFsUklnZ2trdklWdkxoaHBJaUhTdFQxQnBLOW1uY1NZWnRZei9uRTFoalBl?=
 =?utf-8?B?TXlIUnBmK25YV1p0WURPbkt3WjFTUXdBdlZKMWR2WlIwc1ZRL1JldFRSM2s3?=
 =?utf-8?B?STZlamhKc0JrT0RyTmVSMjQySDVUYktnQTl0UmZ6RnEzYlpMLzZxM1dhUXRP?=
 =?utf-8?B?bnM5eG5WeksvRDhhSnFuNUJyT1J4QXkvaGF3VU1zcHMyZFBCa0VqdjBXSlB2?=
 =?utf-8?B?bStFZE03Tkx5MFNsSURrbjhiMS9tcWxXNi9yYmpFT0s4Z3NDSVlmVXVnUnpw?=
 =?utf-8?B?MzZwSnY0VkFDb29jbnJ5T3JXcXUwQUU2UzVWL3lHSjIrYkxJaUthOUFrNnlF?=
 =?utf-8?B?YjVhYk5kUHJGb3AzZWFtUjAwYmkwUHBZYndGTktNcUJsZ1prOE9YM3VTellV?=
 =?utf-8?B?a3FabUV5M2N4VFhFSU9McEJBOVZqdFpQdC9UWThKaE5TbjhsREhjUG9WZkJt?=
 =?utf-8?B?SE9KZDVnU0FoWldYc0VPUml1aWRGTUNHVUdHdUlIdWlmWGFOYk9yRTZrVklM?=
 =?utf-8?B?RTUwVTkvbVF5NmFOZUxRSUoyeGgvLy9XVHB2L05oWEZ6cjlLc1RHcXVRRTh5?=
 =?utf-8?B?R29KL1ZIcnRnQkUyQ3Jvay9BNnhlckhBSk1MM3FaUVdTMzhTdUdMa2V1NTJ2?=
 =?utf-8?B?blM3ei80Zk1zeTdZWHo3T29GM3l5OUFUQmxiUGNKSFM0cms5dWU4L0FKNUIw?=
 =?utf-8?B?SjJMZmRjVExwZ0x5d0hXMjZ2RGM1VTV1MzVoUmtyU25rdW16U2FIWU5QdVNo?=
 =?utf-8?B?YU9PSC9TWnZKdkNoZ2pxemwyNGdzOXI4QU02a3h1ZjI4TGV1bGhtcGRPYnda?=
 =?utf-8?B?ZUJNNzAvUjIxZlhUTHl0blNuUzNaNjNSSFEyUnB3dWMxNEtwdk5EZmRabmF2?=
 =?utf-8?B?NzZoY1h3MTRPbFRWMWxhSlV1dEkzWE9VbE5JbFdUNDZGQ0kzY3pOanpUYkZn?=
 =?utf-8?B?RjRmc3hzRFB4K0RVOGVuZk85QlB2MWdIcVg1Ky95OS9kb2M3ZGFaRy9CMXMr?=
 =?utf-8?B?TjVIbzgwYThoalRVcm11VVVuUHIzNklzbUdyRUF1NTBhMXFsNmNoK1VBV3ZH?=
 =?utf-8?B?TytWdGtoTjRqamw2cEVoOWFGeTk1RXVCU0JURFdLQjJDRTVNYmRaaVNwOXJJ?=
 =?utf-8?B?d2dBRWtVS3NXREhLUGc5QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjBYVW1qVXlzc1VpakRQUWhTWjJKY2Y2V2Q5dVM0VGJYM3RoZDVqTWZMa29p?=
 =?utf-8?B?dElOaVJ2Q1dkT0VyTWRncEwrbkI3aEhSTVY2dEdaS3BSOUl4TVk3S0xRSmJw?=
 =?utf-8?B?a0ltVEZ1Vy9uQWx0ZXVuUS9TVzNLRGlqL3dHSU01OHM3S0JNZGZsZDVtclR5?=
 =?utf-8?B?QncxSnlhSUF4U1N5citqTEhqN0U1UWVoUnFScTBXZTZKK3pyMVA0S1JmTGkz?=
 =?utf-8?B?SXVSZ1RBa3BuRDVLaVlqVnVQT25nVWp4MTFpR1ArV0hHZmZ4QkNoeDFnRytG?=
 =?utf-8?B?cFBFbHZKRThkaUlVMU81YlR0dTkxVmpyZ21tQ09jdEt4WkFVMWoxNU9TSWxN?=
 =?utf-8?B?b0RqRExleWp4ajdBblpOaWgrQldZOXdPOGJoR2hNa1RNK1JCbXZWMk1UNEFH?=
 =?utf-8?B?bFl3V0hFNHcvY1BaZktMeTlpVnZCWXZQUkVaSUg3L2NDNlk5Vk5KaWhoTlBH?=
 =?utf-8?B?Ti9ScEJlRFRzYkpyOTNYdVhCNFRuSzFNR2luTlY5Y29uNmpCTTR6TXcxYUNy?=
 =?utf-8?B?QS8zcXZvL0dIL0V2SFlTZjJCVk9rb3dCWVFKK0RBSEd6dlV0WGtGVENuRTFo?=
 =?utf-8?B?MnVBdDJBbG1sbUhrcFRVbGFRU1Z4UVVCNlltL2swVUVtako1U0ZMNHBXN3hN?=
 =?utf-8?B?b2JyRmNOcm0wMmVoMU8zeGwwTE5tMTNZS1o3M2pFc2M2bWxFT3VPQnA1Vmhw?=
 =?utf-8?B?b2tSQmxmM2U4UGxOaSsybGRDcER0eHNZYVpFWHZsYTcrT1pLbWQ2SHpyMDYr?=
 =?utf-8?B?VXVSL3kvWmp5TjNaYWNSM2xEd2xUZENhRStPSWgwQkpaZ3pNUVBTVGszc0hD?=
 =?utf-8?B?aDV0bllIYTNjOG5LQTg3QTZSZUJGdDZYTEJ2ckNGMTUxcmozY1FTc2NjMzE4?=
 =?utf-8?B?WHNJbXFnTmVnMTVSVHBBR1N1czBjUy9ncmZhbWlMdVUwUVVZQTZBUmFjL0R5?=
 =?utf-8?B?QUUwc3hBZ254b2l2SWVkd2UrR3VNQ2FKdzVBcWhrRVZRL2pzd2diY1VEN2lJ?=
 =?utf-8?B?c1ovWk9uaVFQS2ZiYmh5T3hZSjFUeWdpbWNuYktlTytYM1BibHZNc1l0cjFn?=
 =?utf-8?B?K00xRy96aVQ1VVNJaEdpdFZtVGVacXFobDFHcFhUM2tHdFZYMmVYSUgzRkgx?=
 =?utf-8?B?N0Z6S0FmcUc4clFaWEpqM2trWEEzbE5LTjFkS0RaaThKcGljWW5DUTlPMytt?=
 =?utf-8?B?Yk5sK3JTSU5sY3grUGtwcUhvS21PUXBKNDZGQXFzaWdBVWJ1WkYzSTVQcUZM?=
 =?utf-8?B?dytKM3VZSlcwVkJIYzdVVEppZnVFYVZCMzhnL2FORnhIS21vOEIyNlJNeVFG?=
 =?utf-8?B?VmM4Z0wvWWZoME9VYkthVEZYZVpHR00ybXYvK2pnUWRWZjI0b1h3b3VhZ1Fs?=
 =?utf-8?B?aWhsVEZwaVlFbVNHekovZzlCU3Y1ZXBYNmxHcUYzakowRW5KWnEyNkpsWlhv?=
 =?utf-8?B?T21WR2ZpdFdtRFFJdGtKSW56ZGVpK1ROYjNCeHNBRzZ2R21SMzVGOGhWSEE1?=
 =?utf-8?B?OHM3bk96V2N2d2NTNkxKOWNRdE5KeXZXenh5TWxyZmVNV04xeW5EUSthMXo5?=
 =?utf-8?B?cjBUS0c1enFnYlFlOUF5TmU2UWU0aWQ1L0ZyckZyMFJlSGlpaFZVckFwREZq?=
 =?utf-8?B?UFh2dG5yTW40NjFvUW1ld3NJUUVnTnRQR3hoTDNRb2pvZnQzSnRycW1ER1Zi?=
 =?utf-8?B?NStoVmtmSW5taXJKYzI1VjJkZFByWi9XaEVjNnBqa1NIS0FyVENTNG54Wk1r?=
 =?utf-8?B?c1lSUU8yK1JRdDBncStKL1F4c1R2STVkR1FXK0N2bkFzZWZid1dwT3lsL3lo?=
 =?utf-8?B?eCsvUmZ4WUEycG5KalhUNkpFdG54MS8zTU8vZGVUYkRQdyt0K0xCSHZyWS9J?=
 =?utf-8?B?MnRxZHhOTEViWnd1dXFkUjRWVmwvempuTWtrUVNJWGswRGZWSWdReHRjTlpG?=
 =?utf-8?B?TW1vUjJXSzN0dXhNUnFJMkJBUldxUDdCMlZsSWV6eThNWmFvMHVacDloalZ1?=
 =?utf-8?B?UUtUMUwzOHlCYW15b2dlUlEza24vbVljY2Jnby9lcGM0UkhmWTExbEgvYzBs?=
 =?utf-8?B?ZmlpT3ZiSExwTzl2U3QyODRzcEsweUxONjROVU5jYzEvQ0ZQR29WNHZKZmps?=
 =?utf-8?B?Yi9PN1F3Rm5USDB1bkkzTUZyZmRhRkRadTNUTXNrUkYrSUZMcGdXMHNiQURl?=
 =?utf-8?B?eFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a45ea30-2741-4f9f-e221-08dc99cdfdd9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 13:01:58.7372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /GMknUW93x8m8bPeiNb+haIDJmM6bnDwklUMnbIIaQOHXQ8rTIKd3p9mIs5J/DRVNM1/4LiDT3lFmpybOBbheAK5cgKr40C5R2INzoaax3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8623

Hi Guenter,

On 6/28/24 5:13 PM, Guenter Roeck wrote:
> Use regmap for register accesses and for most caching.
> 
> While at it, use sysfs_emit() instead of sprintf() to write sysfs
> attribute data.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/amc6821.c | 711 +++++++++++++++++++---------------------
>   1 file changed, 330 insertions(+), 381 deletions(-)
> 
> diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
> index ebffc9393c3d..6ffab4288134 100644
> --- a/drivers/hwmon/amc6821.c
> +++ b/drivers/hwmon/amc6821.c
> @@ -14,9 +14,9 @@
>   #include <linux/hwmon-sysfs.h>
>   #include <linux/i2c.h>
>   #include <linux/init.h>
> -#include <linux/jiffies.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   /*
> @@ -44,6 +44,7 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_CONF4		0x04
>   #define AMC6821_REG_STAT1		0x02
>   #define AMC6821_REG_STAT2		0x03
> +#define AMC6821_REG_TEMP_LO		0x06
>   #define AMC6821_REG_TDATA_LOW		0x08
>   #define AMC6821_REG_TDATA_HI		0x09
>   #define AMC6821_REG_LTEMP_HI		0x0A
> @@ -61,11 +62,8 @@ module_param(init, int, 0444);
>   #define AMC6821_REG_DCY_LOW_TEMP	0x21
>   
>   #define AMC6821_REG_TACH_LLIMITL	0x10
> -#define AMC6821_REG_TACH_LLIMITH	0x11
>   #define AMC6821_REG_TACH_HLIMITL	0x12
> -#define AMC6821_REG_TACH_HLIMITH	0x13
>   #define AMC6821_REG_TACH_SETTINGL	0x1e
> -#define AMC6821_REG_TACH_SETTINGH	0x1f
>   
>   #define AMC6821_CONF1_START		BIT(0)
>   #define AMC6821_CONF1_FAN_INT_EN	BIT(1)
> @@ -73,7 +71,7 @@ module_param(init, int, 0444);
>   #define AMC6821_CONF1_PWMINV		BIT(3)
>   #define AMC6821_CONF1_FAN_FAULT_EN	BIT(4)
>   #define AMC6821_CONF1_FDRC0		BIT(5)
> -#define AMC6821_CONF1_FDRC1		BIT(7)
> +#define AMC6821_CONF1_FDRC1		BIT(6)

This should have been squashed with a previous commit.

>   #define AMC6821_CONF1_THERMOVIE		BIT(7)
>   
>   #define AMC6821_CONF2_PWM_EN		BIT(0)
> @@ -130,224 +128,170 @@ static const u8 fan_reg_low[] = {AMC6821_REG_TDATA_LOW,
>   			AMC6821_REG_TACH_HLIMITL,
>   			AMC6821_REG_TACH_SETTINGL, };
>   
> -static const u8 fan_reg_hi[] = {AMC6821_REG_TDATA_HI,
> -			AMC6821_REG_TACH_LLIMITH,
> -			AMC6821_REG_TACH_HLIMITH,
> -			AMC6821_REG_TACH_SETTINGH, };
> -
>   /*
>    * Client data (each client gets its own)
>    */
>   
>   struct amc6821_data {
> -	struct i2c_client *client;
> +	struct regmap *regmap;
>   	struct mutex update_lock;
> -	bool valid; /* false until following fields are valid */
> -	unsigned long last_updated; /* in jiffies */
>   
> -	/* register values */
> -	int temp[TEMP_IDX_LEN];
> -
> -	u16 fan[FAN1_IDX_LEN];
> -	u8 fan1_pulses;
> -
> -	u8 pwm1;
>   	u8 temp1_auto_point_temp[3];
>   	u8 temp2_auto_point_temp[3];
> -	u8 pwm1_auto_point_pwm[3];
> -	u8 pwm1_enable;
> -	u8 pwm1_auto_channels_temp;
> -
> -	u8 stat1;
> -	u8 stat2;
>   };
>   
> -static struct amc6821_data *amc6821_update_device(struct device *dev)
> +static int amc6821_init_auto_point_data(struct amc6821_data *data)
>   {
> -	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int timeout = HZ;
> -	u8 reg;
> -	int i;
> +	struct regmap *regmap = data->regmap;
> +	u32 pwm, regval;
> +	int err;
>   
> -	mutex_lock(&data->update_lock);
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> +	if (err)
> +		return err;
>   
> -	if (time_after(jiffies, data->last_updated + timeout) ||
> -			!data->valid) {
> +	err = regmap_read(regmap, AMC6821_REG_PSV_TEMP, &regval);
> +	if (err)
> +		return err;
> +	data->temp1_auto_point_temp[0] = regval;
> +	data->temp2_auto_point_temp[0] = data->temp1_auto_point_temp[0];
>   
> -		for (i = 0; i < TEMP_IDX_LEN; i++)
> -			data->temp[i] = (int8_t)i2c_smbus_read_byte_data(
> -				client, temp_reg[i]);
> +	err = regmap_read(regmap, AMC6821_REG_LTEMP_FAN_CTRL, &regval);
> +	if (err)
> +		return err;
> +	data->temp1_auto_point_temp[1] = (regval & 0xF8) >> 1;
>   
> -		data->stat1 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT1);
> -		data->stat2 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_STAT2);
> +	regval &= 0x07;
> +	regval = 0x20 >> regval;
> +	if (regval)
> +		data->temp1_auto_point_temp[2] =
> +			data->temp1_auto_point_temp[1] +
> +			(255 - pwm) / regval;
> +	else
> +		data->temp1_auto_point_temp[2] = 255;
>   
> -		data->pwm1 = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_DCY);
> -		for (i = 0; i < FAN1_IDX_LEN; i++) {
> -			data->fan[i] = i2c_smbus_read_byte_data(
> -					client,
> -					fan_reg_low[i]);
> -			data->fan[i] += i2c_smbus_read_byte_data(
> -					client,
> -					fan_reg_hi[i]) << 8;
> -		}
> -		data->fan1_pulses = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_CONF4);
> -		data->fan1_pulses = data->fan1_pulses & AMC6821_CONF4_PSPR ? 4 : 2;
> +	err = regmap_read(regmap, AMC6821_REG_RTEMP_FAN_CTRL, &regval);
> +	if (err)
> +		return err;
>   
> -		data->pwm1_auto_point_pwm[0] = 0;
> -		data->pwm1_auto_point_pwm[2] = 255;
> -		data->pwm1_auto_point_pwm[1] = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_DCY_LOW_TEMP);
> +	data->temp2_auto_point_temp[1] = (regval & 0xF8) >> 1;
> +	regval &= 0x07;
> +	regval = 0x20 >> regval;
>   
> -		data->temp1_auto_point_temp[0] =
> -			i2c_smbus_read_byte_data(client,
> -					AMC6821_REG_PSV_TEMP);
> -		data->temp2_auto_point_temp[0] =
> -				data->temp1_auto_point_temp[0];
> -		reg = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_LTEMP_FAN_CTRL);
> -		data->temp1_auto_point_temp[1] = (reg & 0xF8) >> 1;
> -		reg &= 0x07;
> -		reg = 0x20 >> reg;
> -		if (reg > 0)
> -			data->temp1_auto_point_temp[2] =
> -				data->temp1_auto_point_temp[1] +
> -				(data->pwm1_auto_point_pwm[2] -
> -				data->pwm1_auto_point_pwm[1]) / reg;
> -		else
> -			data->temp1_auto_point_temp[2] = 255;
> +	if (regval)
> +		data->temp2_auto_point_temp[2] =
> +			data->temp2_auto_point_temp[1] +
> +			(255 - pwm) / regval;
> +	else
> +		data->temp2_auto_point_temp[2] = 255;
>   
> -		reg = i2c_smbus_read_byte_data(client,
> -			AMC6821_REG_RTEMP_FAN_CTRL);
> -		data->temp2_auto_point_temp[1] = (reg & 0xF8) >> 1;
> -		reg &= 0x07;
> -		reg = 0x20 >> reg;
> -		if (reg > 0)
> -			data->temp2_auto_point_temp[2] =
> -				data->temp2_auto_point_temp[1] +
> -				(data->pwm1_auto_point_pwm[2] -
> -				data->pwm1_auto_point_pwm[1]) / reg;
> -		else
> -			data->temp2_auto_point_temp[2] = 255;
> -
> -		reg = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
> -		reg = (reg >> 5) & 0x3;
> -		switch (reg) {
> -		case 0: /*open loop: software sets pwm1*/
> -			data->pwm1_auto_channels_temp = 0;
> -			data->pwm1_enable = 1;
> -			break;
> -		case 2: /*closed loop: remote T (temp2)*/
> -			data->pwm1_auto_channels_temp = 2;
> -			data->pwm1_enable = 2;
> -			break;
> -		case 3: /*closed loop: local and remote T (temp2)*/
> -			data->pwm1_auto_channels_temp = 3;
> -			data->pwm1_enable = 3;
> -			break;
> -		case 1: /*
> -			 * semi-open loop: software sets rpm, chip controls
> -			 * pwm1
> -			 */
> -			data->pwm1_auto_channels_temp = 0;
> -			data->pwm1_enable = 4;
> -			break;
> -		}
> -
> -		data->last_updated = jiffies;
> -		data->valid = true;
> -	}
> -	mutex_unlock(&data->update_lock);
> -	return data;
> +	return 0;
>   }
>   
>   static ssize_t temp_show(struct device *dev, struct device_attribute *devattr,
>   			 char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> +	u32 regval;

Why not a u8 directly here? We know single reads are going to return a 
u8 so no need to store more?

I'm not too fluent in type conversion, but maybe even an s8 since this 
is actually what's stored in the register?

> +	int err;
>   
> -	return sprintf(buf, "%d\n", data->temp[ix] * 1000);
> +	err = regmap_read(data->regmap, temp_reg[ix], &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", (int8_t)regval * 1000);

The type casting choice is odd here. Considering we'll be printing an 
int and that 1000 cannot be stored in an int8_t, maybe just cast it to 
an int directly?

>   }
>   
>   static ssize_t temp_store(struct device *dev, struct device_attribute *attr,
>   			  const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	int ix = to_sensor_dev_attr(attr)->index;
>   	long val;
> +	int err;
>   
>   	int ret = kstrtol(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   	val = clamp_val(val / 1000, -128, 127);
>   
> -	mutex_lock(&data->update_lock);
> -	data->temp[ix] = val;
> -	if (i2c_smbus_write_byte_data(client, temp_reg[ix], data->temp[ix])) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		count = -EIO;
> -	}
> -	mutex_unlock(&data->update_lock);
> +	err = regmap_write(data->regmap, temp_reg[ix], val);
> +	if (err)
> +		return err;
> +
>   	return count;
>   }
>   
>   static ssize_t temp_alarm_show(struct device *dev,
>   			       struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> -	u8 flag;
> +	u32 regval, mask, reg;

Why not u8 for regval?

> +	int err;
>   
>   	switch (ix) {
>   	case IDX_TEMP1_MIN:
> -		flag = data->stat1 & AMC6821_STAT1_LTL;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_LTL;
>   		break;
>   	case IDX_TEMP1_MAX:
> -		flag = data->stat1 & AMC6821_STAT1_LTH;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_LTH;
>   		break;
>   	case IDX_TEMP1_CRIT:
> -		flag = data->stat2 & AMC6821_STAT2_LTC;
> +		reg = AMC6821_REG_STAT2;
> +		mask = AMC6821_STAT2_LTC;
>   		break;
>   	case IDX_TEMP2_MIN:
> -		flag = data->stat1 & AMC6821_STAT1_RTL;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_RTL;
>   		break;
>   	case IDX_TEMP2_MAX:
> -		flag = data->stat1 & AMC6821_STAT1_RTH;
> +		reg = AMC6821_REG_STAT1;
> +		mask = AMC6821_STAT1_RTH;
>   		break;
>   	case IDX_TEMP2_CRIT:
> -		flag = data->stat2 & AMC6821_STAT2_RTC;
> +		reg = AMC6821_REG_STAT2;
> +		mask = AMC6821_STAT2_RTC;
>   		break;
>   	default:
>   		dev_dbg(dev, "Unknown attr->index (%d).\n", ix);
>   		return -EINVAL;
>   	}
> -	if (flag)
> -		return sprintf(buf, "1");
> -	else
> -		return sprintf(buf, "0");
> +	err = regmap_read(data->regmap, reg, &regval);
> +	if (err)
> +		return err;
> +	return sysfs_emit(buf, "%d\n", !!(regval & mask));
>   }
>   
>   static ssize_t temp2_fault_show(struct device *dev,
>   				struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	if (data->stat1 & AMC6821_STAT1_RTF)
> -		return sprintf(buf, "1");
> -	else
> -		return sprintf(buf, "0");
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 regval;

Ditto.

> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_RTF));
>   }
>   
>   static ssize_t pwm1_show(struct device *dev, struct device_attribute *devattr,
>   			 char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 regval;

Ditto.

> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_DCY, &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", regval);
>   }
>   
>   static ssize_t pwm1_store(struct device *dev,
> @@ -355,7 +299,6 @@ static ssize_t pwm1_store(struct device *dev,
>   			  size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	long val;
>   	int ret = kstrtol(buf, 10, &val);
>   	if (ret)
> @@ -364,18 +307,38 @@ static ssize_t pwm1_store(struct device *dev,
>   	if (val < 0 || val > 255)
>   		return -EINVAL;
>   
> -	mutex_lock(&data->update_lock);
> -	data->pwm1 = val;
> -	i2c_smbus_write_byte_data(client, AMC6821_REG_DCY, data->pwm1);
> -	mutex_unlock(&data->update_lock);
> +	ret = regmap_write(data->regmap, AMC6821_REG_DCY, val);
> +	if (ret)
> +		return ret;
> +
>   	return count;
>   }
>   
>   static ssize_t pwm1_enable_show(struct device *dev,
>   				struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_enable);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	int err;
> +	u32 val;

Ditto.

> +
> +	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
> +	if (err)
> +		return err;
> +	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> +	case 0:
> +		val = 1;	/* manual */
> +		break;
> +	case AMC6821_CONF1_FDRC0:
> +		val = 4;	/* target rpm (fan1_target) controlled */
> +		break;
> +	case AMC6821_CONF1_FDRC1:
> +		val = 2;	/* remote temp controlled */
> +		break;
> +	default:
> +		val = 3;	/* max(local, remote) temp controlled */
> +		break;
> +	}
> +	return sysfs_emit(buf, "%d\n", val);
>   }
>   
>   static ssize_t pwm1_enable_store(struct device *dev,
> @@ -383,49 +346,37 @@ static ssize_t pwm1_enable_store(struct device *dev,
>   				 const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	long val;
> -	int config = kstrtol(buf, 10, &val);
> -	if (config)
> -		return config;
> +	u32 mask;

Please rename to something else, e.g. val, as this is NOT used as a mask 
but rather the value to write in the masked bitfield (which is hardcoded 
to AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1.

> +	int err;
>   
> -	mutex_lock(&data->update_lock);
> -	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
> -	if (config < 0) {
> -			dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> -			count = config;
> -			goto unlock;
> -	}
> +	err = kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
>   
>   	switch (val) {
>   	case 1:
> -		config &= ~AMC6821_CONF1_FDRC0;
> -		config &= ~AMC6821_CONF1_FDRC1;
> +		mask = 0;
>   		break;
>   	case 2:
> -		config &= ~AMC6821_CONF1_FDRC0;
> -		config |= AMC6821_CONF1_FDRC1;
> +		mask = AMC6821_CONF1_FDRC1;
>   		break;
>   	case 3:
> -		config |= AMC6821_CONF1_FDRC0;
> -		config |= AMC6821_CONF1_FDRC1;
> +		mask = AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1;
>   		break;
>   	case 4:
> -		config |= AMC6821_CONF1_FDRC0;
> -		config &= ~AMC6821_CONF1_FDRC1;
> +		mask = AMC6821_CONF1_FDRC0;
>   		break;
>   	default:
> -		count = -EINVAL;
> -		goto unlock;
> +		return -EINVAL;
>   	}
> -	if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF1, config)) {
> -			dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> -			count = -EIO;
> -	}
> -unlock:
> -	mutex_unlock(&data->update_lock);
> +
> +	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF1,
> +				 AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1,
> +				 mask);
> +	if (err < 0)

Shouldn't we check for err != 0 (so err) instead to be consistent with 
the rest of the code base in the driver?

> +		return err;
> +
>   	return count;
>   }
>   
> @@ -433,8 +384,27 @@ static ssize_t pwm1_auto_channels_temp_show(struct device *dev,
>   					    struct device_attribute *devattr,
>   					    char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_auto_channels_temp);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 val;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_CONF1, &val);
> +	if (err)
> +		return err;
> +	switch (val & (AMC6821_CONF1_FDRC0 | AMC6821_CONF1_FDRC1)) {
> +	case 0:
> +	case AMC6821_CONF1_FDRC0:
> +		val = 0;	/* manual or target rpm controlled */
> +		break;
> +	case AMC6821_CONF1_FDRC1:
> +		val = 2;	/* remote temp controlled */
> +		break;
> +	default:
> +		val = 3;	/* max(local, remote) temp controlled */
> +		break;
> +	}
> +
> +	return sprintf(buf, "%d\n", val);
>   }
>   
>   static ssize_t temp_auto_point_temp_show(struct device *dev,
> @@ -443,7 +413,8 @@ static ssize_t temp_auto_point_temp_show(struct device *dev,
>   {
>   	int ix = to_sensor_dev_attr_2(devattr)->index;
>   	int nr = to_sensor_dev_attr_2(devattr)->nr;
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +
>   	switch (nr) {
>   	case 1:
>   		return sprintf(buf, "%d\n",
> @@ -461,44 +432,59 @@ static ssize_t pwm1_auto_point_pwm_show(struct device *dev,
>   					struct device_attribute *devattr,
>   					char *buf)
>   {
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm1_auto_point_pwm[ix]);
> +	u32 val;
> +	int err;
> +
> +	switch (ix) {
> +	case 0:
> +		val = 0;
> +		break;
> +	case 1:
> +		err = regmap_read(data->regmap, AMC6821_REG_DCY_LOW_TEMP, &val);
> +		if (err)
> +			return err;
> +		break;
> +	default:
> +		val = 255;
> +		break;
> +	}
> +	return sysfs_emit(buf, "%d\n", val);
>   }
>   
> -static inline ssize_t set_slope_register(struct i2c_client *client,
> -		u8 reg,
> -		u8 dpwm,
> -		u8 *ptemp)
> +static inline int set_slope_register(struct regmap *regmap,
> +				     u8 reg, u8 *ptemp)
>   {
> -	int dt;
> -	u8 tmp;
> +	u8 tmp, dpwm;
> +	int err, dt;
> +	u32 pwm;
>   
> -	dt = ptemp[2]-ptemp[1];
> +	err = regmap_read(regmap, AMC6821_REG_DCY_LOW_TEMP, &pwm);
> +	if (err)
> +		return err;
> +
> +	dpwm = 255 - pwm;
> +
> +	dt = ptemp[2] - ptemp[1];
>   	for (tmp = 4; tmp > 0; tmp--) {
>   		if (dt * (0x20 >> tmp) >= dpwm)
>   			break;
>   	}
>   	tmp |= (ptemp[1] & 0x7C) << 1;
> -	if (i2c_smbus_write_byte_data(client,
> -			reg, tmp)) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		return -EIO;
> -	}
> -	return 0;
> +	return regmap_write(regmap, reg, tmp);
>   }
>   
>   static ssize_t temp_auto_point_temp_store(struct device *dev,
>   					  struct device_attribute *attr,
>   					  const char *buf, size_t count)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	struct i2c_client *client = data->client;
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	struct regmap *regmap = data->regmap;
>   	int ix = to_sensor_dev_attr_2(attr)->index;
>   	int nr = to_sensor_dev_attr_2(attr)->nr;
>   	u8 *ptemp;
>   	u8 reg;
> -	int dpwm;
>   	long val;
>   	int ret = kstrtol(buf, 10, &val);
>   	if (ret)
> @@ -519,7 +505,6 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>   	}
>   
>   	mutex_lock(&data->update_lock);
> -	data->valid = false;
>   
>   	switch (ix) {
>   	case 0:
> @@ -528,13 +513,9 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>   		ptemp[0] = clamp_val(ptemp[0], 0,
>   				     data->temp2_auto_point_temp[1]);
>   		ptemp[0] = clamp_val(ptemp[0], 0, 63);
> -		if (i2c_smbus_write_byte_data(
> -					client,
> -					AMC6821_REG_PSV_TEMP,
> -					ptemp[0])) {
> -				dev_err(&client->dev,
> -					"Register write error, aborting.\n");
> -				count = -EIO;
> +		if (regmap_write(regmap, AMC6821_REG_PSV_TEMP, ptemp[0])) {
> +			dev_err(dev, "Register write error, aborting.\n");
> +			count = -EIO;
>   		}
>   		goto EXIT;
>   	case 1:
> @@ -550,8 +531,7 @@ static ssize_t temp_auto_point_temp_store(struct device *dev,
>   		count = -EINVAL;
>   		goto EXIT;
>   	}
> -	dpwm = data->pwm1_auto_point_pwm[2] - data->pwm1_auto_point_pwm[1];
> -	if (set_slope_register(client, reg, dpwm, ptemp))
> +	if (set_slope_register(regmap, reg, ptemp))
>   		count = -EIO;
>   
>   EXIT:
> @@ -564,38 +544,37 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   					 const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	int dpwm;
> -	unsigned long val;
> -	int ret = kstrtoul(buf, 10, &val);
> +	struct regmap *regmap = data->regmap;
> +	long val;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &val);
>   	if (ret)
>   		return ret;
>   
> -	if (val > 255)
> +	if (val > 254)

I think this should have been squashed with an earlier commit?

>   		return -EINVAL;
>   
>   	mutex_lock(&data->update_lock);
> -	data->pwm1_auto_point_pwm[1] = val;
> -	if (i2c_smbus_write_byte_data(client, AMC6821_REG_DCY_LOW_TEMP,
> -			data->pwm1_auto_point_pwm[1])) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		count = -EIO;
> -		goto EXIT;
> +
> +	ret = regmap_write(regmap, AMC6821_REG_DCY_LOW_TEMP, val);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = set_slope_register(regmap, AMC6821_REG_LTEMP_FAN_CTRL,
> +				 data->temp1_auto_point_temp);
> +	if (ret) {
> +		count = ret;
> +		goto unlock;
>   	}
> -	dpwm = data->pwm1_auto_point_pwm[2] - data->pwm1_auto_point_pwm[1];
> -	if (set_slope_register(client, AMC6821_REG_LTEMP_FAN_CTRL, dpwm,
> -			data->temp1_auto_point_temp)) {
> -		count = -EIO;
> -		goto EXIT;
> -	}
> -	if (set_slope_register(client, AMC6821_REG_RTEMP_FAN_CTRL, dpwm,
> -			data->temp2_auto_point_temp)) {
> -		count = -EIO;
> -		goto EXIT;
> +	ret = set_slope_register(regmap, AMC6821_REG_RTEMP_FAN_CTRL,
> +				 data->temp2_auto_point_temp);
> +	if (ret) {
> +		count = ret;
> +		goto unlock;
>   	}
>   
> -EXIT:
> -	data->valid = false;
> +unlock:
>   	mutex_unlock(&data->update_lock);
>   	return count;
>   }
> @@ -603,58 +582,72 @@ static ssize_t pwm1_auto_point_pwm_store(struct device *dev,
>   static ssize_t fan_show(struct device *dev, struct device_attribute *devattr,
>   			char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
>   	int ix = to_sensor_dev_attr(devattr)->index;
> -	if (0 == data->fan[ix])
> -		return sprintf(buf, "6000000");
> -	return sprintf(buf, "%d\n", (int)(6000000 / data->fan[ix]));
> +	u32 regval;
> +	u8 regs[2];

Can't this be a u16 directly.......

> +	int err;
> +
> +	err = regmap_bulk_read(data->regmap, fan_reg_low[ix], regs, 2);
> +	if (err)
> +		return err;
> +	regval = (regs[1] << 8) | regs[0];
> +


..... to avoid doing this here?

> +	return sysfs_emit(buf, "%d\n", 6000000 / (regval ? : 1));
>   }
>   
>   static ssize_t fan1_fault_show(struct device *dev,
>   			       struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	if (data->stat1 & AMC6821_STAT1_FANS)
> -		return sprintf(buf, "1");
> -	else
> -		return sprintf(buf, "0");
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 regval;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_STAT1, &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", !!(regval & AMC6821_STAT1_FANS));
>   }
>   
>   static ssize_t fan_store(struct device *dev, struct device_attribute *attr,
>   			 const char *buf, size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
> -	long val;
>   	int ix = to_sensor_dev_attr(attr)->index;
> -	int ret = kstrtol(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -	val = val < 1 ? 0xFFFF : 6000000 / val;
> +	u8 regs[2];

Ditto.

> +	long val;
> +	int err;
> +
> +	err = kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	val = val < 1 ? 0xFFFF : 6000000 / val;
> +	val = clamp_val(val, 0, 0xFFFF);
> +
> +	regs[0] = val & 0xff;
> +	regs[1] = val >> 8;
> +

to avoid this here.

> +	err = regmap_bulk_write(data->regmap, fan_reg_low[ix], regs, 2);
> +	if (err)
> +		return err;
>   
> -	mutex_lock(&data->update_lock);
> -	data->fan[ix] = (u16)clamp_val(val, 0, 0xFFFF);
> -	if (i2c_smbus_write_byte_data(client, fan_reg_low[ix],
> -			data->fan[ix] & 0xFF)) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		count = -EIO;
> -		goto EXIT;
> -	}
> -	if (i2c_smbus_write_byte_data(client,
> -			fan_reg_hi[ix], data->fan[ix] >> 8)) {
> -		dev_err(&client->dev, "Register write error, aborting.\n");
> -		count = -EIO;
> -	}
> -EXIT:
> -	mutex_unlock(&data->update_lock);
>   	return count;
>   }
>   
>   static ssize_t fan1_pulses_show(struct device *dev,
>   				struct device_attribute *devattr, char *buf)
>   {
> -	struct amc6821_data *data = amc6821_update_device(dev);
> -	return sprintf(buf, "%d\n", data->fan1_pulses);
> +	struct amc6821_data *data = dev_get_drvdata(dev);
> +	u32 regval;
> +	int err;
> +
> +	err = regmap_read(data->regmap, AMC6821_REG_CONF4, &regval);
> +	if (err)
> +		return err;
> +
> +	return sysfs_emit(buf, "%d\n", (regval & AMC6821_CONF4_PSPR) ? 4 : 2);
>   }
>   
>   static ssize_t fan1_pulses_store(struct device *dev,
> @@ -662,40 +655,22 @@ static ssize_t fan1_pulses_store(struct device *dev,
>   				 size_t count)
>   {
>   	struct amc6821_data *data = dev_get_drvdata(dev);
> -	struct i2c_client *client = data->client;
>   	long val;
> -	int config = kstrtol(buf, 10, &val);
> -	if (config)
> -		return config;
> +	int err;
> +
> +	err = kstrtol(buf, 10, &val);
> +	if (err)
> +		return err;
> +
> +	if (val != 2 && val != 4)
> +		return -EINVAL;
> +
> +	err = regmap_update_bits(data->regmap, AMC6821_REG_CONF4,
> +				 AMC6821_CONF4_PSPR,
> +				 val == 4 ? AMC6821_CONF4_PSPR : 0);
> +	if (err)
> +		return err;
>   
> -	mutex_lock(&data->update_lock);
> -	config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF4);
> -	if (config < 0) {
> -		dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> -		count = config;
> -		goto EXIT;
> -	}
> -	switch (val) {
> -	case 2:
> -		config &= ~AMC6821_CONF4_PSPR;
> -		data->fan1_pulses = 2;
> -		break;
> -	case 4:
> -		config |= AMC6821_CONF4_PSPR;
> -		data->fan1_pulses = 4;
> -		break;
> -	default:
> -		count = -EINVAL;
> -		goto EXIT;
> -	}
> -	if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF4, config)) {
> -		dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> -		count = -EIO;
> -	}
> -EXIT:
> -	mutex_unlock(&data->update_lock);
>   	return count;
>   }
>   
> @@ -827,110 +802,84 @@ static int amc6821_detect(
>   	return 0;
>   }
>   
> -static int amc6821_init_client(struct i2c_client *client)
> +static int amc6821_init_client(struct amc6821_data *data)
>   {
> -	int config;
> -	int err = -EIO;
> +	struct regmap *regmap = data->regmap;
> +	int err;
> +
> +	err = amc6821_init_auto_point_data(data);
> +	if (err)
> +		return err;
>   
>   	if (init) {
> -		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF4);
> -
> -		if (config < 0) {
> -				dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> -				return err;
> -		}
> -
> -		config |= AMC6821_CONF4_MODE;
> -
> -		if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF4,
> -				config)) {
> -			dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> +		err = regmap_set_bits(regmap, AMC6821_REG_CONF4, AMC6821_CONF4_MODE);
> +		if (err)
>   			return err;
> -		}
> -
> -		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF3);
> -
> -		if (config < 0) {
> -			dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> +		err = regmap_clear_bits(regmap, AMC6821_REG_CONF3, AMC6821_CONF3_THERM_FAN_EN);
> +		if (err)
>   			return err;
> -		}
> -
> -		dev_info(&client->dev, "Revision %d\n", config & 0x0f);
> -
> -		config &= ~AMC6821_CONF3_THERM_FAN_EN;
> -
> -		if (i2c_smbus_write_byte_data(client, AMC6821_REG_CONF3,
> -				config)) {
> -			dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> +		err = regmap_clear_bits(regmap, AMC6821_REG_CONF2,
> +					AMC6821_CONF2_RTFIE |
> +					AMC6821_CONF2_LTOIE |
> +					AMC6821_CONF2_RTOIE);
> +		if (err)
>   			return err;
> -		}
>   
> -		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF2);
> -
> -		if (config < 0) {
> -			dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> +		err = regmap_update_bits(regmap, AMC6821_REG_CONF1,
> +					 AMC6821_CONF1_THERMOVIE | AMC6821_CONF1_FANIE |
> +					 AMC6821_CONF1_START | AMC6821_CONF1_PWMINV,
> +					 AMC6821_CONF1_START |
> +					 (pwminv ? AMC6821_CONF1_PWMINV : 0));
> +		if (err)
>   			return err;
> -		}
> -
> -		config &= ~AMC6821_CONF2_RTFIE;
> -		config &= ~AMC6821_CONF2_LTOIE;
> -		config &= ~AMC6821_CONF2_RTOIE;
> -		if (i2c_smbus_write_byte_data(client,
> -				AMC6821_REG_CONF2, config)) {
> -			dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> -			return err;
> -		}
> -
> -		config = i2c_smbus_read_byte_data(client, AMC6821_REG_CONF1);
> -
> -		if (config < 0) {
> -			dev_err(&client->dev,
> -			"Error reading configuration register, aborting.\n");
> -			return err;
> -		}
> -
> -		config &= ~AMC6821_CONF1_THERMOVIE;
> -		config &= ~AMC6821_CONF1_FANIE;
> -		config |= AMC6821_CONF1_START;
> -		if (pwminv)
> -			config |= AMC6821_CONF1_PWMINV;
> -		else
> -			config &= ~AMC6821_CONF1_PWMINV;
> -
> -		if (i2c_smbus_write_byte_data(
> -				client, AMC6821_REG_CONF1, config)) {
> -			dev_err(&client->dev,
> -			"Configuration register write error, aborting.\n");
> -			return err;
> -		}
>   	}
>   	return 0;
>   }
>   
> +static bool amc6821_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case AMC6821_REG_STAT1:
> +	case AMC6821_REG_STAT2:
> +	case AMC6821_REG_TEMP_LO:
> +	case AMC6821_REG_TDATA_LOW: > +	case AMC6821_REG_LTEMP_HI:
> +	case AMC6821_REG_RTEMP_HI:
> +	case AMC6821_REG_TDATA_HI:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config amc6821_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AMC6821_REG_CONF3,
> +	.volatile_reg = amc6821_volatile_reg,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
>   static int amc6821_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
>   	struct amc6821_data *data;
>   	struct device *hwmon_dev;
> +	struct regmap *regmap;

Save this variable by using data->client directly?

Cheers,
Quentin

