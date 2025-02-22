Return-Path: <linux-kernel+bounces-527240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E47A408C9
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D184E7010D2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43305139CE3;
	Sat, 22 Feb 2025 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="W+LgyJl+"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2055.outbound.protection.outlook.com [40.92.58.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F81F5EA;
	Sat, 22 Feb 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740231704; cv=fail; b=ldIhw0YtkIt5ChBm7DQXpR8itBrdImxw1nZt6Dt4yTNavdHZFvujXI5oiNo1G8WFvuam2Lif6NiRgm9PCeFwta+3TlyDt5XSHjUjzJi+NafxvZrHLmq3kowySisOPiDWOZ1OrPLgmr+hQ95YHRMscmvFyOpD+BK4xG0mXIhwDik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740231704; c=relaxed/simple;
	bh=aqPPjn9rBp16C8HxYFWi4A8OX/B9Z7L6AUuyx6a/TzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5SFmm99FyQtl89arCEo3WbhOX+HzcYBRrBxkA5JV5vzg2PEt3DjOy+YR+DkQgPV7vlaXHRZdDE3XI2fEF7EdtVFn662UbpNK1RajLBrlHB1Hfh1OLLHvGHzFWU/DBAMjQmWkSwSgu9OCD9frUKLMsQ6mvsSJWrvLYH+7jLpxMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=W+LgyJl+; arc=fail smtp.client-ip=40.92.58.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBtq4eyxthx3GoGOHi5/ZPL8yIztJnr56KBwKELlcRXuVdc5R5qjV738XvwnIc3seZNAbRuntJlb7y66BOvbp4j/oKgso0O0weLYt8mlnsjgBhl+o+EuP+WTF0uiF2YvxTOg4KEA93rEHFh0/YENC/14LedmqgVhR8ea11TY5NoOKPQf0eDHAgGNxX4zVzQu5FNQ9lqhwyMw8jA8GwugjiKRpQNqYTNM8H5ZHipoAZMIE9leMyHctlDY5GgH7cS9C6d/bWYRllXss2lKgGrdTCKE7kNmoFQx8RfTkZx5Ia9MKUKeKloKd0zczF+rlx/ffmno7Pkrw++xksSJK+byUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgd/wtUZFvAHysLGOijed2FkaBkk1R9UpWPoPw8blO0=;
 b=Ft/Q5o1qDhd4FRbwapDm5aILxDLLYg26LpkEUPzX9xaBaySAMHOnWXdfU68wEaU7laSv3HMbg/TGwrBKa2LClwuLx/ysUkmiiT3oc4MXFVwSeHSYRrJwJ5/IjQhGKyaWyGnpYk9lZovbe59z3b3/FEOoXJPBvLz23L1UOL8pwvWdl1kNMjUa2ZXtxVa6ok1Nhb3ww8NDUHs41UMA4tML/Tah1STMMG1v6LfkqMGV6LXEYtR8isTX8eXzqdd7NTwKasxkaR6BVDXSg3CQCaTXhn/56KcBzjfQBrc592Bq6ch8iuO9fDrdEcGuWQ07YOO76YH/YXDeQxv6VBMqhQFdOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jgd/wtUZFvAHysLGOijed2FkaBkk1R9UpWPoPw8blO0=;
 b=W+LgyJl+MNMjVskcRNyt9HIWb/McC6tIvt4hwT30oQ8a8Msu4gGwVgAHJXBhRFrQV1/tRhoFxUZyudxvM708OLE4rWevlowUYqCWQkOkOVBceU9Si1hwIjZ+6vIsKE7ZkRidIFYHybqu/Wt9yVazbN7anIMrlu0uLTtnIQNdQZ2+OE9oQ5Q6eWGf/IAoHKzDhS3vKkAQQUbdM6GVaxJRTFi72b5xYFAFn+gMi3FlVwvsxo52kX9+sdmqnoRwXuX0vrBEaz5hD42NMuEhzdlvkYRvJfZhvIXpO795Zp2i6cHmb3d8ooOIgrd00ERZTncN8Awx9tHNE9YbBMEguZRv0A==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by DU0P189MB1958.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:34d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Sat, 22 Feb
 2025 13:41:39 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 13:41:39 +0000
Message-ID:
 <AM7P189MB10099904382702C0B00D4D74E3C62@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Sat, 22 Feb 2025 14:41:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: fml13v01: increase eMMC bus speed
To: Shengyu Qu <wiagn233@outlook.com>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215-fml13v01_emmc_speed-v1-1-e3bd224ae0e8@hotmail.com>
 <TYCPR01MB84379C13A329703421086FF298C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <TYCPR01MB84379C13A329703421086FF298C62@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0035.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::18) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <6c1be790-2fc8-4e9a-b5de-3dc4e5600ebd@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|DU0P189MB1958:EE_
X-MS-Office365-Filtering-Correlation-Id: aebe3219-8a46-459b-b363-08dd5346a227
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|8060799006|5072599009|461199028|15080799006|4302099013|3412199025|440099028|10035399004|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHRnVERFYTdXOWx0RDB6WVVVOFptV1VkUU50ZGk2OU9hV3JpZjNoOW5CREZO?=
 =?utf-8?B?VjlsWHo1K2J1azhaZWk1SkJIVElnSnA0TVNzandiOXhkTEQvaW5udlpFSEZi?=
 =?utf-8?B?ZWYzNXBCWVpTS0pYYTk3WWtCUk9TeHVza2E5eFptdXNBa3V0N0hSUzZNMjNU?=
 =?utf-8?B?bjFZamdhZE96aXpuVlhRV3FmSHZLWVRvZHUrOWloZlJRRmdKVHMzL05GYkUw?=
 =?utf-8?B?RW01eHU2V0labGxBaG96OWNSczZMck5TV3BJT0NtQzl6bmlSRUtpQ1B6N0ts?=
 =?utf-8?B?cTFEU0ZNZWlEVkpjUjl5VmNhb1UrelpRdFVHTTVIY3ViY1dPWkY5Ly8rVTMw?=
 =?utf-8?B?bWpDckc4L2NsQUMxOHFXSGJCV2piQmprRHN6YTRQYUJScURtZGVDME1hT1Vi?=
 =?utf-8?B?c2h4RDdzdUdqN0VWZUg2MlBMQ1RuOUZEcmJlQWR2d0h5YVMycExjY1lVc3p4?=
 =?utf-8?B?Q1VuTk1XT2VjT2RqWUo0dUZaRHpyM3JGOU1VbHRGSFZPOHJ2bFJmTllBcFli?=
 =?utf-8?B?UllFcWgzL0htVU1MeEx3S0k4UldSNXJQNU1LOW9HSFNFWmtQcG9EL25VczY3?=
 =?utf-8?B?YWRXckxnZHlscTB3Mmk2Rzg1dkNvUlZnMEtleDhRVi9BQlpxSFFTdUxuWEd3?=
 =?utf-8?B?dDYrVVNKRkMwa29NMFpJRm1hclJJeWYrT2t0MVVWTCtwL1ViSFV0RWRpZ3RZ?=
 =?utf-8?B?ZzdkendqRVBQdExId09WN2NWTDlvTnZDeDRlSjA1N0NlcEpCdDcxRWROaW0x?=
 =?utf-8?B?UDlGaDE0dXNleEtpOU9NTmhHdi9rTDA1MUZBKzd5cWNpYW9aRFJxNlN0QytH?=
 =?utf-8?B?SDlIeU1KR2xCZVdYSzVvdmZXOVhQaWxRK01ObTRjZ0dWdDREMHVyWHhDLzRR?=
 =?utf-8?B?ZU5pSEkrUlZJblpVVVk2TkMwTmNxQ2tDM2NIRVY4TWo5OElQTE5CTmdLbVNr?=
 =?utf-8?B?K3dHMGdwbjgrZzBkclkyUFpRQTljaEdISzk1R3BRU2t2ZVU5VzdENVlOZlJZ?=
 =?utf-8?B?SGNrQTU5aE00K1NoOTZiZDV6dURxSjlpemJtV0wrWWhjN0lndWthL1Y5aWVl?=
 =?utf-8?B?L0oxcnEzUnRaUUZwbjlzZUpFKzR2eGNQeW5VZjhwSEtiUHN1bnhmT1hiaVV3?=
 =?utf-8?B?OE9VM090WTIwaW45Q3QzQ09QRTVDYkJ2K01BaVpZeW9xNERUbXhCUzJ1ekVr?=
 =?utf-8?B?OGxYY1RPRGZudFpLRWdodDNGNjRvT0FwVUhidmlSM3BaWUpBNFpqTmxyVExH?=
 =?utf-8?B?Tm1xSHdzOVBnMlVjWUtPUlpxQVRSam50R1FpcCtWMmV4UGVGK2dDUHBuMDdr?=
 =?utf-8?B?MkdPTEtXWFdFaHpDZFptNHAvM2M2Z3djZGFrNk1ZdkN6UU1HRkp2UDc0WXl6?=
 =?utf-8?B?SWpyWXdWenRRbmtLQTFzVzNRQVlQdzVQR0k5Zysxa2tCZm4zZjNHeTdtMGxr?=
 =?utf-8?B?TXl3ZURFY3lpNWJBdkZxRzNKa2lLQTZ6T3pCSlNOYm1BZ2w2aHJ3UXRoVFhr?=
 =?utf-8?B?cE0vMmtCYktBVmJBaGEveUdwZGFBaENPejZXZDY3RE8rQ1IxZE9IcUxkWW1o?=
 =?utf-8?Q?ot11Cp49P0bW1/bRvh4PYihF5QwSRqn58V4chsIoM9W0at?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dElBb01UNTNLRW50Ly93SWh5eVBTNjhVNTJjMVl6K242S3JKdlVZR3k5VXdp?=
 =?utf-8?B?MlZxZi9vN05Sa3Q2VWJKZzNLOEhBUFBQek1yTFVhRnppTkxnQy9VSzYzRWpx?=
 =?utf-8?B?SGNoWWtpc1FFVGlxOHVRcXVRWi9XVVIzbmlGeWYxdDBid0tZSVRmWlRnYy85?=
 =?utf-8?B?c3N0VWpXQjFQL1RIdEhGUnZMaHcrQytSaDQzd0pvQWVBRStHS0FsMTAyRmxQ?=
 =?utf-8?B?QlMyRFVRU0o2akVuV1gzcHFIRkZWMHlWVVljVDZiUWJCeUVhU0lSclVHVkwz?=
 =?utf-8?B?elRXdlc1UFFOdUpJN2NvQlR0c0FiRFRwQVBENlVSakwxUnBNNSt6RnBzWEZw?=
 =?utf-8?B?LzJicXZGNFVrNm9UdlVPaVBUaFQxTklMU0wrUFVpUC92bDZzNFhOUWl5ZXc0?=
 =?utf-8?B?SkdyZ3pCNXVBZG0vOFUxVXkvVXg3cHBKRkFNa2dGb2ZqUCtUNVkzRE5RMEp2?=
 =?utf-8?B?REdRM0VLUnlyTFZIekZlLzhmNnhaWWJ0R254RWh2QWhFdjdPWTA2OU91VVRP?=
 =?utf-8?B?d1B1bEduU3Y1UlBuWGJ2NEp4cUhsRUZSTWQ1bkJ0dWo2djFNSTVQNTVDL3Jt?=
 =?utf-8?B?VUNFZWFHL3FYSitoQVh2bnVCaVUrTWw3QWtSTDhEVlN1VFdBK3hrZmRNOFd1?=
 =?utf-8?B?WHVDM1VIRGlLZWFhNXV3a0pzVGxXVURNUDdtcjhmb3dXcmZZN1JQQ1RKaUpM?=
 =?utf-8?B?emRnb2pjdmQ2MTlsa1hDNFprdlBWMCtqWUhsSnVIbmdSNFBjMEFBZEk0TTJk?=
 =?utf-8?B?V05sNmF3N0JMU2pjb29jc0p4ZkVoOE12MnJTd3FGQXdyQ1RweVJUbmw0MUZP?=
 =?utf-8?B?WkpQNmVHVDhLYU9UYnlFVU1uZ3NxRmcxcUk1cm5IU2tnOEFZbnZTN3ZEMlUr?=
 =?utf-8?B?eUJ5ZjI0MlM3dnJEdW1mbTRVSnU0ZHdaK091bHprYXM2M0RXNXZuUjBDSjZ5?=
 =?utf-8?B?bUtYY2kvdUExWmNvWFl6VHhuZXZjYTNQbUJ4cGE5Z1poQU9RN0ptNTJCOS9Y?=
 =?utf-8?B?OG1qTEVtcWlPd3FHSEgvKzhidmpkVjRrM1NyeTdkUHpVMXZJWUVvQ0VyeTgr?=
 =?utf-8?B?VlB2UnVBMnNPMW9mek5TSjhob3ZzS0VmZlpNNlp6UkpLaDBUTDgzOVdWbGtE?=
 =?utf-8?B?anZpQXhDTy8vRmdIMzNWMW5OeVN0RmQrTHlHVVNPL2ZoMkZMNnBHNi9NY2JC?=
 =?utf-8?B?M1BiMXAydnhhYUtCcFRJeG5ZTm81bTEyeG0xamZ4YzRmY2d5VkFHSy9zSXYx?=
 =?utf-8?B?dlFGL1RhUGlTU3BmclN3NVF2dlFUTFM3UHFOSmdBY3ZPNzE3UXFlREZCeW4r?=
 =?utf-8?B?WG45NlY0QjN5NitjeEh2eDhIajkvSGpvUnF0NXpjUWpReHIrMGxmazdLMENO?=
 =?utf-8?B?Yk9iZkVWdFBnR3hDMXlUVjExNi9ZMXViWlZpV0l5ZDNtMFlZc2hnYU1yMmYy?=
 =?utf-8?B?VzczeWpHTjEydjFsL0s0NjNKUnRybzVFcXJWRjlKTzRuY3NjZzNPOXhNb2ZO?=
 =?utf-8?B?UUhOdlRUZXp4Ylc1NXQ0ZDEvcFVFL0NRa1FCWnRGbEhpajFyYTkvM3pVSE9w?=
 =?utf-8?B?a0FxRitmaFkxc2VwSzRCVVJUUHllOWkzUE1tNW9PK25QRy9KTXRoSUpFRGw5?=
 =?utf-8?B?VFJQd1NHZzhrWGQyellJc3VVVi8vSDBiTGNoSkwzTEdyMDhMOVB2cFRLSnM1?=
 =?utf-8?B?aEt0bWlvM1ZSVzN6ak92VmNMNTJqMytsTUkyQzVpM2cvcjhxMitsa3lmZDVy?=
 =?utf-8?Q?JoBy4qU+xJEGb5JFMtiKD6Sxm8jGSc+nonBnOzN?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: aebe3219-8a46-459b-b363-08dd5346a227
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 13:41:39.1791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB1958

Just sent out v2 before I saw this

On 2/22/25 1:54 PM, Shengyu Qu wrote:
> Hi,
>
> The clock speed limit here seems because of some clock HW issues:
> https://github.com/torvalds/linux/commit/af571133f7ae028ec9b5fdab78f483af13bf28d3 
>

Hmm I don't quite understand the issue from that commit message, but 
yeah if there is some hardware issue we should probably see if we can 
get some input on this. It seems fine so far on my end.


> Maybe we need some assist from Starfive guys?
>
> Best regards,
> Shengyu
>
>
> 在 2025/2/15 17:46, Maud Spierings via B4 Relay 写道:
>> From: Maud Spierings <maud_spierings@hotmail.com>
>>
>> The assigned clock speed of 50 MHz is and max-frequency of 100MHz are
>> limitting this interface which is SDIO 5.0 capable. Sadly at 200MHz it
>> fails to mount an eMMC drive, 150MHz (really 132 MHz) is the highest it
>> was able to get.
>>
>> This improves the seq read/write performance by 2x~
>>
>> Signed-off-by: Maud Spierings <maud_spierings@hotmail.com>
>> ---
>> I put this in this specific dts instead of the common one as I cannot
>> test if other boards are also able to handle these speeds.
>>
>> This patch depends on [1]
>>
>> [1]: 
>> https://lore.kernel.org/all/20250207093618.126636-1-sandie.cao@deepcomputing.io/
>> ---
>>   arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts | 5 
>> +++++
>>   1 file changed, 5 insertions(+)
>>
>>
>> ---
>> base-commit: 0bc08ec1ff5a32449d2b04704173dbf3ebd6b014
>> change-id: 20250215-fml13v01_emmc_speed-67812bd9b404
>>
>> Best regards,
>>
>> diff --git 
>> a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts 
>> b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
>> index 
>> 8d9ce8b69a71be78ca57618ae842c9f415648450..1f4bac9f89463a6af844b8f1743bdfa659e612ab 
>> 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
>> @@ -11,6 +11,11 @@ / {
>>       compatible = "deepcomputing,fml13v01", "starfive,jh7110";
>>   };
>>   +&mmc0 {
>> +    max-frequency = <200000000>;
>> +    assigned-clock-rates = <150000000>;
>> +};
>> +
>>   &pcie1 {
>>       perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
>>       phys = <&pciephy1>;
>

