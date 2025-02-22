Return-Path: <linux-kernel+bounces-527259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B08A408E8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 15:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8C34240F4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73B91552E0;
	Sat, 22 Feb 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ss3kpNc+"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010003.outbound.protection.outlook.com [52.103.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE903C47B;
	Sat, 22 Feb 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233954; cv=fail; b=teX+I+PLPKUFTFTcou57yT6wEb9Mam0Vk5hzhX77R0V5i0Uo1jWAA17AnlNc6x8S4qsxhRStS+/UU+Sjvbo77qcaK+Rk3LNCWPgr4v5OzRyDE6yX4+sj/7yiMxRygBmorh2lG8g1JNOCNzqRntu7YfXo6hKAR+xafWTr1if26pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233954; c=relaxed/simple;
	bh=SUTiMJnsWvPeerE1yKp2mFrsqCSes5YlX6ueMUNLLGc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T4aiNfw/8Ot6vTnx9tsyN43c8AgAMpBWvWAZeghOxI0EZXzV4buj98A12BYziFqHgIuoD2iiAQ3dg8wxVnajPZMi/DznER6xerYFaIejFnIB7N8d9p7UUM1GBE3oKGTdozuxJNBg21mifJ7XmnKjWq1qK/Rj/mXWUQOU9CXaokg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ss3kpNc+; arc=fail smtp.client-ip=52.103.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mn1ICzBjsGjLQKjf1paZF5BIppxgihM04KpUJkvxdzPmuN0kQQjDwbxCcAQchJ3NqjHyRnCV4aKDaYMd3wyZhFyB3OHiGi+HAQVXN3IsuPBepV9xYVd5l1SjkWnOxocX8pjte+c8CJFJVJZ8xyG9rOI7nKGqVIDRS06hm0AZR0rufVbHyc8gHVVeFWayecdZMCfqTnSq1+YcGE17QNSIjV1kPgy1nhUwuFLMCEpJY2IBwlYpNTyikKnB6t/HeNkE/GBS3ngtFpEk/+8k3Hglt/5XqMCOZeOrZfoDi95qLE4O9X3CkT6fjSZ75Ulur+FTnqSrr38B17wQ/G3en+Bilw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnPsGqoP67LHaQ4iRc2SQGYWJe7akT2cZqAq7RCYgX8=;
 b=sSOALJjoxQpJGFBit18LC7eeM2+EvDlDFADE5zJsEsaOmR1rhGb3IAA5uLF7ZU3AQvVRpFO57Ao8/AlCx/j7AGZjUMG5o0vn9otY6VVgqXDRCP8jpzbzy/6YFXsjcXqx3WTcKSr0hYLu65riGT0Tp4KSNHW5HEqaEpRa+bi4zZrzOKpwXuLF38k92TSmefS28c/OrMfmZeAL3Fiiy6f4qoOkxAvzHOdZopBw6xtuTKZbqTPLa03DFc2Vpgxky/3bqGzMKRPZ1YQxn0zI+ofVuyWCbaZuwl6XwCyPtph7VQS2a7qdEqRojy5039Uuha2y/iP7AR9U2zL4djJia8IO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnPsGqoP67LHaQ4iRc2SQGYWJe7akT2cZqAq7RCYgX8=;
 b=Ss3kpNc+zw5iPa7ldS6aUrCMqKWomdyX1dqA3Es+LMltZmx2Hpo7xlQfBDwOoZF1/V+n8yrx0t03s3z3D79nlSUTV8F9Vsg0U/43+x9VCfxYF4ZpDUMJM/MEBDeeHZr/L3Q4B2WypXrzakwtd4F7+iwgzlRiv5lP3KbL78SYbAkG+rn/jq/fa8ry30LZIII/riTkxWKEKESRl1R5WXRX86LZGJgwdegg3QKe4TgvPGXLDUuznlq+GpXfCo7kttHwoHXJoy5Ijmwt29Jya8JEXu2Zpw5/vnvdArb688qMgcQ8KPoKbndcqRax+DBqYONsqZCh4c+ZteOXWWJp4dXQLA==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYVPR01MB10687.jpnprd01.prod.outlook.com (2603:1096:400:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 14:19:08 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 14:19:08 +0000
Message-ID:
 <TYCPR01MB8437AA5D22665A38D56B895698C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sat, 22 Feb 2025 22:19:05 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 william.qiu@starfivetech.com
Subject: Re: [PATCH v2 1/2] riscv: dts: starfive: jh7110-common: increase mmc0
 max-frequency
To: maud_spierings@hotmail.com, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20250222-fml13v01_emmc_speed-v2-0-3ffc5b1f5663@hotmail.com>
 <20250222-fml13v01_emmc_speed-v2-1-3ffc5b1f5663@hotmail.com>
 <TYCPR01MB84379D3E0552FD990424173C98C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <TYCPR01MB84379D3E0552FD990424173C98C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::6) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <5afd7904-4004-4828-a4c6-4dd518460065@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYVPR01MB10687:EE_
X-MS-Office365-Filtering-Correlation-Id: c28749d7-794c-4502-fe94-08dd534bdf08
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|19110799003|6090799003|461199028|7092599003|15080799006|10035399004|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlB2elRPaHJ1bGdHdnlab1NmWEFkY3NlNkFaSTBlZURNanV3S2J3aFQ4Mktw?=
 =?utf-8?B?RldlSEE5amt5Smcwa1BqUVREcnh4Z1drME52OUpmcmIwRWhoKzlYQTFjTi9R?=
 =?utf-8?B?RWJnMUp1dUJ3YzBCZCt3K1pYMDFNL0wrYktoaXd3NUl4L1c0TjFpTXcyV2lm?=
 =?utf-8?B?M2p0YnVlVVpmRjJrVE9aYWN0OU9NNGRkcUdFd1dISVJ3QWdjTnI2OHBaWmhs?=
 =?utf-8?B?SHZBR2RJY1pYeHo0TlVlZUZvY1FzdFVTaGd2Q2hyVCtwVEZsMnB4RzQ2bGZT?=
 =?utf-8?B?SWNJS1MrWGd4bHZscW4wOW9kRk1QTWVMejlVQmN6WmltWk9TUmI2VWFuRy9H?=
 =?utf-8?B?REM4d0dLQXVrWTJjNEtqYVEra0lZa3JhVURmU2MxckRtaTBwWXZTbVRYcFh6?=
 =?utf-8?B?MXF1SWI5b3lMdDh1c0c0eE1LWWdweXRNY0FTR0grZlVWV3RFQXpLZlNhRUF4?=
 =?utf-8?B?UjRFZzluS0M4UlJmSG5TdjNRS0E2UWhwd1A3akxrMDdPS2w1QXh0TTUzdWtZ?=
 =?utf-8?B?V0pITXZKQ1BlYW9GTzNKZWlOd1FWc3pFNXU0Ym9kSy80T2RrUlpXd3Q3dkY0?=
 =?utf-8?B?MzZwQ0JyNWxiKzRVTm5JWHAyaWxyU3RMbHV3Nm96c3lyc0pqelNmbTcxN2ps?=
 =?utf-8?B?R2QvZzNPOWh6TE9IZFJYZEpzTGRCdWhwS3ZHMmRkNDJzUlVjT3hZZTlzZ00w?=
 =?utf-8?B?S2F5N0N3dDVTRlNDUFpYdG80Q3BFbVNITWZjT01iRUFiZ1ppNlVmZFFtUVZO?=
 =?utf-8?B?Y01EbXRoUHJBcGdTMkJuTUJaS25DTXlRaVhSSkw1bmllQ1Vpb0ZIRU55V28y?=
 =?utf-8?B?d1pNM3lqTlFsVTFEUDl1cFlFTFFOT0wvdUsyc0xkZkZocUN2UHJuOTlIWUNx?=
 =?utf-8?B?cHJSQWZMUVluL25JUFZEc0IyS1BjL2dSMFM2U0dJaitPQmFZbGhvMTNJbGtS?=
 =?utf-8?B?dDQyZjdCMFBOMEY3Mi9TTjQxZDBJbTBOb01VNUQ0NHorenFEbUI0NlYxQUxD?=
 =?utf-8?B?czQ4L255R2RvcTlyV3U3QzMwRkRqaUkvcnQrb0xYQXJLcklnbnZ4cnY5QW9n?=
 =?utf-8?B?M0szOEt6a3dOaFhWK1lMZ0oyelkvdFVlYk9vNUh3UmRxVHNmdm53b3YwYmxq?=
 =?utf-8?B?eUN5QVJVNkJORjZ4R3N6cll5Z2NWdWQ5OXFzVExQUFZKUUFLdW5YbE5qWWlJ?=
 =?utf-8?B?cmFEeENGRWM5c2JTb1RydTNlbitWT3F5QnZTT2h0ajNqNGphSUY2aklSUXM2?=
 =?utf-8?B?Lzl3RmEwRWlGNHhWY29Ua2pDdm90bGxNaXpaTWhzNE94YnFiQ1RVdzBaM1ZZ?=
 =?utf-8?B?TlBWcGVGWjRZV1JxaTV5TDhOM2poeDlzaEJsWFcydUxpZ1BNdjFZUnZ1Ymgz?=
 =?utf-8?B?eS9tT0VITnllL0o2S1NnSWUzNHc0aWo1b0dVM1kyN1JBZmh1NmM0NVpkN3hz?=
 =?utf-8?B?YTg5bkRhdnB6Wm9Wb2dkODJibENjUUt0cm5lbnVzSklHQTl1RjNwL0Z1VklK?=
 =?utf-8?B?MHJ0SHE4R0RhZ0pEREVsSWdHS1lEdjZJRkJua0dLQld5S1hVemhKeG1laElU?=
 =?utf-8?Q?X8UmUnWvWOayJWaDiTpoLHOOPhv4d5KOIKnKKhF4akFKoG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWxpTDdQVmd5T1N1c2VYbFlLVE9TcmdNMUVCQmRuYjI3ZzQyOEtGNUFVV3Bx?=
 =?utf-8?B?RmJuYkJiaVVPNUhpZEhnakRUYjRwY2V4WDN6TVROem1wU3VTVzF4amEva3Vx?=
 =?utf-8?B?MUhRMjJrUXR1dHFOcS8ydVU1MExXRE5sOWtUdll1S0xlcWVRSzBoYjZITXhh?=
 =?utf-8?B?azY3NmdyZis3TjB5VHRnRnNkNndEVVpDdnhZMHUrTlhQeXg1bG1hTVVKS1hr?=
 =?utf-8?B?UVFIMldOUmtldUFDeEk1eUVqdmk3NklkVWEvbG5qQkloOVV4NDlhSnhPV3ZJ?=
 =?utf-8?B?ZlRJWDhMWEUxL3AyVzZMend5cGtDd3cwNjVOYllMR1ZuY2llREVKZTR2WmFQ?=
 =?utf-8?B?YVNRaDh4ZlQzMko1NTE2RXlQWlFXZm03WEdPRURzZ3MybTdTYW1ySlM5a0NE?=
 =?utf-8?B?RzVYZ3BiZzcvR0VTblZOT3dOSkF4M2E1Q2FFQUxtWWNuSkIwaUZmUnVPZERG?=
 =?utf-8?B?d1BRbEh1UjFpcXluNlRZQzE2SFlpdmZTM1h3cjV1NVBTS3V2RldTWXdjc1U2?=
 =?utf-8?B?eG8yRzYrOGxmQWpFTEpsVDJmME1hc25WTkFvMkFKQUZreml6bFBkMVhCODZq?=
 =?utf-8?B?WnlMNHlILy9CdDVYbDFZdUExLysrTWVlQjJIUS9XUFBYbS9vWTdDSC9zZWtw?=
 =?utf-8?B?NnAyQmNTK0I1SDhkV29iYVgxclkwZk1SbGMrL2JPZmN2alBacjdNcUdzY091?=
 =?utf-8?B?akF0RXJUbkNERW9hUkozMlpkWGFjaXBVVzJjNGh5SVc4clB2TFhINWJlNG1h?=
 =?utf-8?B?Z29JOVRwN3hqMURMcnBLUlhVcnhDY1JrbVBvRlVsYk0wRitRWG5ndit3eFJs?=
 =?utf-8?B?MDhKVU81YW9CdUpQWHJpRlVhVlRsQ3AxRHdyNjAvUWhwZGMwd3BjYTlhY3FU?=
 =?utf-8?B?SlRJbG5mbE5FVXNBZnA4L0ZpMGxaRFVZQ3JYelNFSjl2WDVNWkVsYXVRRSt5?=
 =?utf-8?B?MnFaajNIMEYydTZiUUN2MUd2MWllMmFTNDlBL0JnYWJ1clV2UDFzdlhxcmZO?=
 =?utf-8?B?UzJJbUo2cEFEM3d4Qy8yMVA1RGZQQUlCWHBaUG0zYnZhaVZMRnUyd0RSS2lh?=
 =?utf-8?B?MGFhUTdmOUpYa3ZsUDU3azFPMmc4aFpsNHl1T3FiRFIrSlJUc0xRV1A5bHRF?=
 =?utf-8?B?UHZpYVI0M1lXNnNiQkZyRUpQY05pRW4rbkVaMEY5cEFwQzBqR3V3cHpCVVds?=
 =?utf-8?B?K3I3emIvZWJmZlVaVzhXdkkwZWRyOHA2NmlxU29vZmJXNGd2ZjZrQU0xUmtt?=
 =?utf-8?B?ZGR3MGN5eHZ5cmw5VWt3WWh0c2xzYzFFYTNaazR6aHlMRy9JT0h0OWxLbGp3?=
 =?utf-8?B?azNGRWk0QklFc1lDU2E3NWdESEJDMDZROGI4bkJXbFZTT1ZGNzIvek9wUDFG?=
 =?utf-8?B?RWZWOHI2Q2RUN28xOVhXcm5YSWVWdWNveTljaFViTlg4cVhtbVZwTGFnQW42?=
 =?utf-8?B?M2tuRDdNVWhscWh2VE1sSW93UVEyQmZpWnQwUmtBK3hoRi9sZXhCVldlZXV3?=
 =?utf-8?B?UVlidEtUNUVqNzlWb0hsM2FxYWZ5SjlPMXZqNi9xQ01BcmJBMjZ1TE1Ea2p5?=
 =?utf-8?B?eDVpQURQblg4Zmc1ZHRBT3lrU0VJNXJzVFRNcnl2SXkwMm5rRnF5ajFGanI3?=
 =?utf-8?B?cUx3dURiWjFFNTM3MHNUOTI3cjBDK3pCWmx5SVlNclZnd0NRc1NKWWtCS3Zn?=
 =?utf-8?B?NWRhZ3lVY1k1VStYeFBBbk5jT0JSSDVSZTFDNTI3SE1QUHMvUHA3U1ZVY2R5?=
 =?utf-8?Q?Lj86A2bCqXTPB2KHSU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28749d7-794c-4502-fe94-08dd534bdf08
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 14:19:08.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10687

Sry I forgot to cc actually.

在 2025/2/22 22:17, Shengyu Qu 写道:
> Hi,
> 
> Let's continue our discussion here.
> 
> Will EMMC speed increase if we only apply patch 1?
> 
> Also, about your clock-rates modification in patch 2, I CCed William Qiu
> so that we might get some more information about this.
> 
> Besides I've done a speed test with unlimitied clock-rates and an early
> state of SOC clock driver on visionfive 2 when I was working on AXP15060
> driver before: http://forum.rvspace.org/t/question-about-sd-card- 
> speed/1741/21
> 
> Best regards,
> Shengyu
> 
> 在 2025/2/22 21:34, Maud Spierings via B4 Relay 写道:
>> From: Maud Spierings <maud_spierings@hotmail.com>
>>
>> This sdio interface is capable of more than 100 MHz as already indicated
>> by the cap_hs200-1_8v attribute. Increase the max-frequency to 200 MHz
>> so users of this dtsi can increase their SDIO bus speed.
>>
>> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
>> ---
>>   arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/ 
>> riscv/boot/dts/starfive/jh7110-common.dtsi
>> index 
>> dd2eefc295e5c8b568a02104ec2189e66b378904..19ca8dc24617c2ad565a4a9b2d9af9bd9491f22e 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
>> @@ -258,7 +258,7 @@ &i2c6 {
>>   };
>>   &mmc0 {
>> -    max-frequency = <100000000>;
>> +    max-frequency = <200000000>;
>>       assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
>>       assigned-clock-rates = <50000000>;
>>       bus-width = <8>;
>>
> 


