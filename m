Return-Path: <linux-kernel+bounces-436649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D1C9E88FB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41758165B80
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 01:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A042921364;
	Mon,  9 Dec 2024 01:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h/XqssA8"
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6031C2BD
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733707664; cv=fail; b=gaWI0cxVUk8aohqpK/kUTns0RJU/rZKVtgG52NPwkypSnMM+87CrsCctBV9K0u7z/mCaySSr4bbXsU1/BAet2QHO/nBrDr5IVp86lETmCH6BSaO3nhRJaKA42/aAv+Qz/+ZDthSinrjqoCqUFYmCi9yU6Z/CuycBj2nqy0DdcMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733707664; c=relaxed/simple;
	bh=7mouwtGHY+2VpIchfdwpVY3BX0SW9XmuvF1useESyHw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wz5I5LjWCY9qNgG/r3I4eMt/EMfZepBw25coygiRwxn8860cCLUIqUn4EJCAKF5sZDXkrY5tPM9Y8jWXgH8rKcss6IhIW8xqZfpMXHTEPnr1zdfXO+w7ygIXVXvAIkEb+0g6dd/MMV/fFQc6N2hSdIGyUWGco89OKtUByw55XYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h/XqssA8; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wh4xZw/2jdnmmzfc7mjwX538FWpCxvK1fK1CpTVic5v0uqebk8QUldXZIB79nCfuvmFKTcaAMMeeIymnvdW3AvYNwAkyjGM/6bFIloc9XYY2h+ZpT36mRqYJMMYUBJb48HeCepP3K0rHsoJOA2eIA3AZKvtuX7R/BTKfkhclD+zSTfduTY4Kc9u5JHLz1z5mOsRmWm3BQJN/vfh0nZV32eI7gvkJuV79ESiRNZM0BkM7HWgd5EpLtpZ5Z3KjWC9dXhaikT5QPzLpYE/kzWOO3/dZk/vzLBupF7bRuSIqd63oG0CJZgNRZGpfl5D6Aklg12jydGPmKIfAc4TlRuoL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yH5+iUuh6HwrWoTm096eHqI+KyNUkZhLDy23CZIFw6Y=;
 b=f9ea2VVTj+EuCQDc0MB41cdcRAl3Efhpod6JSvrK/OjBBuU6dbKYLAdbtHvAP4Y+NzG8YfOd9gzI8Gv+bN4PZDuErQ65L7oDLbaiOS4IKuetLQBGsAKrACOcMYWMyifFbz0txh+GwBgTaaWQ1+xDy8sCVvkfeW6Egp2zeVwF5DnRZxHDbaTwrAVXzJ6MSnaOL8V0yQNzgKLPQytlG22vAr/27TBPqHKXLVPclkRp5UNC5WjIOapXuimP6oRo5FuYb5Kxr5Ib4ukz2r2E5tLAmejYKerXE6Qkuv5kZF9KbrssuMO5VVfVw0CYA5IdNmzxhBdfD3MiSxg+PGZ0CrSR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yH5+iUuh6HwrWoTm096eHqI+KyNUkZhLDy23CZIFw6Y=;
 b=h/XqssA8k21VIBuYmK4D1ZRsyHQSk2Ygm+Zc6ypoDj8IJtI6sFCN7+tJftxIagy8fz9uHiGRFV2WanZ3/2Xs+836tfV62jni5k6lv7KPcVfq9xjj+wzWaV/NnHZM8B/RS/+5UY+xhNUEtnBzpQzmKxJFUmzW2C0kFap/RtoYwymhbWarUD/1wyPqeUHBKN5qz6v/3owpmQugqWgjzPUpVUTCNn5CDi9VSkUCzR2BEpWkmkLcBjf5uncLMDCUjjmdJG+TWb7dX9ztv3OjZuIJZPwLs+GGGGX5nS6fty4LIqFEtbiKOPi5dIxW4EZG0AR0fZCWPlrYFk6oyddDaXwFyg==
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::20)
 by PN2PR01MB10335.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 01:27:37 +0000
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4]) by PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4%4]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 01:27:37 +0000
Message-ID:
 <PNZPR01MB4528266A2E20339C8DFBE389FE3C2@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 9 Dec 2024 09:27:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] WARNING when nvme_probe
To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 akpm@linux-foundation.org, linux-mm@kvack.org, fengchun.li@sophgo.com,
 Inochi Amaoto <inochiama@outlook.com>
References: <PNZPR01MB4528CE2B4B42BD765EC8DDE1FE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB4528980B1F286C5843B70DBFFE322@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
 <Z1UK-1MQEX_IcoL9@kbusch-mbp.dhcp.thefacebook.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <Z1UK-1MQEX_IcoL9@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0160.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::16) To PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:33::20)
X-Microsoft-Original-Message-ID:
 <3c9dbdaf-6eb2-4fd9-816d-a376f79e2031@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNZPR01MB4528:EE_|PN2PR01MB10335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3f4d79-77dc-459c-d637-08dd17f0a9c4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|7092599003|461199028|15080799006|6090799003|19110799003|5072599009|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEZyYWNWRmQwcHRmS3pneGlqQTFEU0o0NmtqSFB6VHdSSHNSZWRxcW9sK25h?=
 =?utf-8?B?YllyT1YwVE52RExJVTNFL21vZjc1Q2o0VG9oamtHamNiRDVTQ3dnZWovUFd2?=
 =?utf-8?B?MXk1WmM3bVluZU5rTXVXWXdWbmtrbStiTk9XZTFxeWRURTVDMmtsUmhvc0Nu?=
 =?utf-8?B?NjIyaXI4d0Faci9mb1pUVHd6Y2JmV2NCNnVBUGJBNFBTWnZGcXVmM2pQT0g1?=
 =?utf-8?B?L016VXVBOFgyMVhUK0h2b0NaQy9zcFg0QzVuK2MrK1E2Z3hwTTBWS2NlWHlt?=
 =?utf-8?B?NmlKaWY1WnpMdDJVU3NOdWdSYW1zZ0V0UmZOQkZwNzRhVTVFUGxBUkhjS0d3?=
 =?utf-8?B?dS9MOEhUWmQ5dk1MZStVejY3d2dzSG9qbmpMSmx4dzd3bCt4N21xVXd2T1Y4?=
 =?utf-8?B?UmJPaGc4MnNKZEU3ZWVvdkRzWFA5cXMvWVhScXNIQTk3Y3JnaDhPWjY1aTZm?=
 =?utf-8?B?ZG51NjRpeEVkKzlSYnBJdVAxekZraklmUndvelgxbFRwYlNPb2RJaENlZ3hj?=
 =?utf-8?B?NnY5OXRHSE5teHFxTXBGTTExaTYxY2xBSXhVZlhRTTR1SmhOS0hNL1FUclhk?=
 =?utf-8?B?eTg2cXdMeTV6RHZYRC91dHNaOWpWdzJhUFJ4NmZjb2hobnNMbmgvcG1wMjJV?=
 =?utf-8?B?VTNSSzlUMWs3ZU1LSVM5bUszbjJ1R1BsbXRJTm9sM29CUDZsQVlManlsYytS?=
 =?utf-8?B?cW5Id003N24wNXh6R2c4YnFXWHRCU0VyeFhSTUtDT3FERjc1dG05R3BUaEt1?=
 =?utf-8?B?dElxcmJvM29WOHJqZnFnUXdmZ1JmaFpCcWVYRlJSWHN3WG9LeVBNWHYxMC9R?=
 =?utf-8?B?clh1UEpFT002UzZYOVZOMjE1SzR4NWVRVFZlYXVkVVM3Sy9FckplYlUvcWtk?=
 =?utf-8?B?ejFxY0JqUkZleWtvZDRyVXQ2WUR5U3lWSm80VjhKNjR3ZWxnVVlSSFlHQllE?=
 =?utf-8?B?eWh4ejlXaEtWdEZJUmpTT3FER3o4UW9Bd3BMeVhqbEVIbHJza3FCSkppTHp2?=
 =?utf-8?B?OVVGcFV6elJOaGJrK2IvWTFLM2RkQ1JEVHFuVmlzd3RhUTRnMVhxTUZmbE1W?=
 =?utf-8?B?ajlwMjhTOTZhcUFocWNocUNWM2dMZVVuL2dqUlBhL1prTkdNSFNDSnhWSHhz?=
 =?utf-8?B?d3RPc3YrWlBzQ0N6SjZ2MHZYKzR2NE45aTlVTVZFV01XSVJaVFJXODEwRWtl?=
 =?utf-8?B?V0dnYTlhRllIUkQydHQ5WGorMmp3UElPUFZHUHhPa1JWS0U0SWRrRkVrM1Iw?=
 =?utf-8?B?Snl1TUZrUzBUdi9lUXExeWJEU1A0N2ZsS09tdEY1aGFIc1cyaUlhNVVuYnYr?=
 =?utf-8?B?ZFA4bEZaRE5CcktabmJlK0ZIVVNjQllub3pRYTB6dUwrVWYzTnBiMjQvRXNB?=
 =?utf-8?B?ZXNQdWhySDFzS2VyWGRFR3V4cXoveHZrV1czSGNGdGpMK0pEdGJCR2RXN29V?=
 =?utf-8?B?aThBZjhuYk9GU2g0YTVadnk5S3FaazNpajJlMUhkL040UkVud2JxSjlJOVhG?=
 =?utf-8?B?b00zOCt4SDNwemVwNFI5Y3djRFJhRjliaE1UVTY1YVJ6cUFQVGx5OEtXM2Rk?=
 =?utf-8?B?ZHVRRjdTK0JhN0NlejU5VFBBZHREeS9kWTFJZWQzLzhpUFY3cy9uaWlwUHdC?=
 =?utf-8?Q?HYiiXGKWop1ToVhcGkZt3yRRTBlvvzV+JZzWqdbeMZZw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXhpdVZGdU9rbG9GbWR3UUtndFdwT1NmSnl0b0IrUnNrdGI1ejRQSm9jR0Vz?=
 =?utf-8?B?OTdaM1lrTEZrenA5U3VoRUxWam9CVEhIcUdHYUtNMEhLUElZYVhKR3ZQaTdt?=
 =?utf-8?B?aC9YbVV6TkFzbVFjUGpIeXJXWkZEMWpyeUZJUVhCVzJOTDVBMUJyZHB6YnNt?=
 =?utf-8?B?dXFLMmNta2RTWWNmTWovdUY1T0VPUkcvZ3FLTXVrc09vK2lkUVhPOGNuMS9B?=
 =?utf-8?B?ODNQeUw5aEZwQkZpQUc5RDNvTmwwbjJiTy90K0d0T3M5OG9vTGlSUUMreGZS?=
 =?utf-8?B?U054SytQcWZlYzllMnMrQUI2MnA3SEljYW43U1BEL0hjWk5wTTkxS2czQjVt?=
 =?utf-8?B?K2pRU2F1QmdsbUNYa3FlblE4QUhBV2dmQ0Z4VVU3OTFnTmlDYUZGR0hHTUsv?=
 =?utf-8?B?N3kwNll5QW5JNmIxL01jd01VMk5LLzR2VTNobFV0cCtMUTk4S0x1MWVvdVFH?=
 =?utf-8?B?L2lLWFZVSW1LYW8ySkZDbjNPdFFUakxPOE9aaFZTNTkvRHZhSGsydkdKbVBF?=
 =?utf-8?B?SUFWbmRDQ0EwTjFnRHQzaVlVWnJDazc5WXN1S2YzR3U2bXUyUVFrd3lBVUtF?=
 =?utf-8?B?QTJQRllqVFZqSnROdk1QbkFEaDRreXBNWE41SGZmWG9JNllJd09kVlFicFRZ?=
 =?utf-8?B?UlVUVXRPc1pVbVB5L3E5YjZXdnQ5WTkyVS9HZ2ViYnZ1ZUgzVzlvSHduWWtQ?=
 =?utf-8?B?SUVTbnFGZG0wdGI3NXRsQkZzbjVqeG9scVMwVWV5VmdKV2ZTTVZaSFdHUmRq?=
 =?utf-8?B?ek1ZY3F2M1JHSHpPalJGbFRVSDRlUTg5MEoyVUpXRU9DZW5tVmlMeVJjb1dx?=
 =?utf-8?B?YS9sZGlVVjFPWHRBTkI2ZVBocldNcFlFUlVhamVrWG5QMDNXRjM5RGMrRG4v?=
 =?utf-8?B?UnBCU2FQWWU3bHVoMHhsS21hazZ0QkhsK1M0L0ZyZmdQRmF3N203K0tRd0d0?=
 =?utf-8?B?R1J5Q3MyQjQ5VlN6TXJzL1BJT2pUTWdpRVlVaHY3OGxtRFBzRmhzWmF1Vnls?=
 =?utf-8?B?OEdlWk9LL0FKUXFKYTZ5YVhJQ0g1TnJPVnhFWktxb0pOK0tCcGxtdnZCUjZ3?=
 =?utf-8?B?aE9JWS8yTXM2VnNqRTg4di9rUTQ4Ym9qUUx2LzJJMytFby9lRERrYUNMWEpo?=
 =?utf-8?B?SDZSL1hDSWpINHdTMC9XaUtoR0tpbE1DcDUwRm11dksrV3U3UkNOMmlaUURw?=
 =?utf-8?B?S2lYaDRKUGNldVNWUWM4V0htQUxTRktVMGRqYjJmaDRrOWp3YU5MbHlnUGpN?=
 =?utf-8?B?T21nNDBSQjAzeFhXYjFScEp2by9UZlZ2VUNyTnVlVk9KcFNLWW91VnJDNzJH?=
 =?utf-8?B?bmtJS0toemhFVW1ienZZbG4zUHVPM0Izblo4MzVaWnkyUHpKaWhoTGtCczd3?=
 =?utf-8?B?QTJGVzNRWDA2WTBvNmQ2ZzlQaDhJdkd6NGhSNi8yTmlrcmx4SGF0T2NJWUdE?=
 =?utf-8?B?V2tKNEhUVnhkYlgzWjY3azdzbWdVWUFjNDhIZGF6UnV3VXFSaWJiQ3NrbmpP?=
 =?utf-8?B?T1RoYjZEajhNMGlRUXhEQSt3M1BPeVFNT1VtQ01pWXR5YUxBNklUczZaVWl1?=
 =?utf-8?B?V1JwdUsrcWtBcTNpUjNJaEtrc2hZVUlnd0M5eHBtNHp5WlpFTVhwY2tMVVRu?=
 =?utf-8?B?SFl4YThuakpJWmtaRmovV0Q4OFBaVEtCRmlsbkE4eEg2VktEVERVWnFpbm8x?=
 =?utf-8?Q?pRYnh1yWLogyT1/IiZ/r?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3f4d79-77dc-459c-d637-08dd17f0a9c4
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 01:27:37.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10335

Hi, Keith, I upgraded to 6.13-rc2, which should contains the patch fix 
you mentioned and it works now.

Thanks,

Chen

On 2024/12/8 10:56, Keith Busch wrote:
> On Sat, Dec 07, 2024 at 12:26:14PM +0800, Chen Wang wrote:
>> On 2024/12/7 12:22, Chen Wang wrote:
>>> When I test with latest 6.13-rc1, I see kernel complains as below, but I
>>> don't see this in 6.12 serials (6.12-rc1 & 6.12-rc7).
>>>
>>> I'm developing PCIe driver and there is a RC switch which has some
>>> devices conneted to, including a  nvme device.
> Thanks for the report. Should be fixed now with this commit:
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=ad0cf42e1fc4810170a8e8e232e85d69073e4d25

