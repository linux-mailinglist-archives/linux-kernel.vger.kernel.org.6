Return-Path: <linux-kernel+bounces-518520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C53A4A3905F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 02:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C94E16EAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 01:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1529B839F4;
	Tue, 18 Feb 2025 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lsn6LxAW"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084146FBF;
	Tue, 18 Feb 2025 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842034; cv=fail; b=Ry9FzUiERW7S06OucRwiehdmMyKqhWBx3oIDgIi2AHwruyP5Bz2rsdwoNZdsRkk3Y/XdX9so0d9DkYl9/zzyIm8sHYI+YvP9prFQ9A5ajmxxKjFsydCToSoAntvhU00NJlMQlEuBsUe44PbKopYorzrLp/fZjo7jm+96/ScTaME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842034; c=relaxed/simple;
	bh=TYF7WMPJr0lLFofSDxAWNIWT0YU7FFaucjVpvzWFW4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W4isuqbKplQPtk3F7lGyxHyOr89HfKJO5Ahf96yWizUy/UONhlyBkZCTmDj8TzaPY+AWSJtz82PMHrbvIWAtmwT3cnb4out4NbdXf40yyiOOGKtkpGeWA6kOZqSAdkMOFH8AZEA20d2bQIpKiOh2oteCvTrc75g59sMzLFgFdfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lsn6LxAW; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0nGWksqIJMtAoQI8u5ci7gE0MXaLZnO9xC0XxqQAxeD7I1DT8+gSK2nKkWhJ4VZoUX5WmR17oideulePOhSrAoNs19sTjaNLe2Wu5Gr3NxmvA4vVIp3r30fEbzaQcfwIGQF9bIQwgYVkwZwH9gbNPBLuqrHDxCg4q4dZYiJzBx/1BHlJVhq81hxyON1BmKwgvblWP9BXeH1BtH7CibY2hLP7y+wdef4CiXMKRzQ50/SNCHptSfqGjHkemzszQKtuYonS9jUIpkWD3RW1mkp721nc0tKxq9OEM/GNvbo0cBwEShtFjNpyjPeo74ozZ9+BLko6P4aN5ya4REwwtzemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/cZD0zBW/VUird1e1gYx8ddvICYBy0kXFUGorndAow=;
 b=EZD/AMaEKq4kOCpviqWY9h3OF2ji294aze1lKdwBJVOjHDmwGbYj+7m1mZYzOvlrMmsVGCS+j9r2F5KSFcan5yO6f8A6qwDag6J146UGjjtTWEJSb1m6cGbGUVbn7rg0ib1FYFBuYuDxLWQDniNZRS9LKQtd2+qVey3CqMD7UhJ9brhp9R17kE0ObqdBcE9r5bQXtUzlP2io0hGfVKjGNFRDl1UOV9Okb5UkFhXvCLrtSw7RQFw3bGVF2byePLIOr0wTP9CFXptvs8ZE3pH/Jyf0EaNkdUTuvXuGy1VmlEWaSJ5mFH0kLQpNtaWa5+XSVemIKpx3tG6IHPvoRjC5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/cZD0zBW/VUird1e1gYx8ddvICYBy0kXFUGorndAow=;
 b=lsn6LxAWwGDdHq2biGYiTQxVz9LK4J3dWAFyNtj3q+arzygRPTtbkaFz6WmEqyfbJE43ITKLCcYbI8rnxoYY4n7uJ/8bWaSwn8XRXnPAGPk7XdvmN+MyHcCxpsyVtcsCEtwE7PJ/p1qmcJS44AwjYQxFoLiEYIj/LICYOYzAnhaaYL+qrb0y0+U3ibFEbyGungmH+qd2Thrqjy920t71ygywCq18pCOB/u0Q5cGcxpw2m69bPIgf8kwAkTfNmUmwCJhsmKuHTKrrse12s9Lbx8U2Z/dTvzIeZaSR5Jd02clKl13OH4oqbudNzxsmrkN/Jz49yZrewHoFVVtGv2jixg==
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::9)
 by PN2PPF35EA1AEBA.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::58d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 01:26:58 +0000
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee]) by MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee%2]) with mapi id 15.20.8445.020; Tue, 18 Feb 2025
 01:26:57 +0000
Message-ID:
 <MA0PR01MB567177477265296E3EDC3E94FEFA2@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 18 Feb 2025 09:26:54 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2042 MSI
To: Rob Herring <robh@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
 samuel.holland@sifive.com, christophe.jaillet@wanadoo.fr
References: <cover.1736921549.git.unicorn_wang@outlook.com>
 <c9dd12c3ad77b13dcdfbf4accd51e92e6ea2a4a9.1736921549.git.unicorn_wang@outlook.com>
 <20250123212938.GA390972-robh@kernel.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250123212938.GA390972-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::9)
X-Microsoft-Original-Message-ID:
 <3bd05418-7c01-43be-a705-bc7a806b275c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5671:EE_|PN2PPF35EA1AEBA:EE_
X-MS-Office365-Filtering-Correlation-Id: 8653b430-cdc5-4607-2d00-08dd4fbb55e9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|461199028|7092599003|15080799006|6090799003|8060799006|440099028|3412199025|10035399004|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0kwZkFLdFBSVWZkdXhYODZ4VGR2YjhuL0c0UXFMTVhlOWtMb09zMXFidmY2?=
 =?utf-8?B?V0VHVHhMN1NlZE1oVFY2QzdoWHVDRVVmbHp2QzJLUVBraVNGWk9GNmplQS9y?=
 =?utf-8?B?SEwrUnhnMHBONngxN3p3clR5QVpUaDJGYko3RE9EYW82WlhxNng5NmppaU0w?=
 =?utf-8?B?d25abis3QW90WE9xeG1raXpqMFZzK2FMK25BSGFZVUdJcndWSHZZZmpjZkV5?=
 =?utf-8?B?VlljTFhROGpFZGptVmN6MkVzc25UWWtoV0F2ZXRTMmNQbGMrcWdnYitLem9t?=
 =?utf-8?B?Vkc4TDNYYU1rUjlNbEdnL21YUUovUDFmTEd0VW9hQ2JvbDVSd3dSdjVEVzdq?=
 =?utf-8?B?ckJDd0hIbDBsNkc1NjBIb2dYai9mUnFYNDNxd0NQSDRRcUZWK2lFOC9tdVFZ?=
 =?utf-8?B?MmpJWTVXN05FM3ljU01uNWtWd01iZW9kbjZvQXhENUw0TXUvMEN6NlpUZUh6?=
 =?utf-8?B?QUxjaDk5QWMrNy9qeE84Y2FRSndoTDZVdHRpeW1VMHY0bWxWTWYwdW52QlFR?=
 =?utf-8?B?QkFOQmF5Y082MFBUT2JaZVI2d2RCZUtkL0N6eVgwVEVQd1NjWk9udzF5clVu?=
 =?utf-8?B?WFh3R2Ywc2dLeVh4SHZmTGFObGpaUWs2dUZKWmdNUG9SOTVQcHUrMStEVkdU?=
 =?utf-8?B?S05nN05oSFczQTdMRUZJMFpVcHdYOGJpMG1aWkt0cjJOT09HMng1YUNMNGVh?=
 =?utf-8?B?ZHNlMUZqUUJkUVA2K0hhMGlKVWJDYTZhazdpZ25KZkFRSDQvd1E4d3VRQ0RF?=
 =?utf-8?B?azNjV2d2UEZmQkVoNldlbTRocThBYTB3aUFTditVZSsxRGd5enRpTnYzNTZa?=
 =?utf-8?B?L3BkbldGaWpKVHQ2MzI4QjBEc1dLTUxmVitwSXZRdGp1R3VHR3JvUjRsc3VK?=
 =?utf-8?B?WjJYcFBmemQrT1dMKzBJZEtkOXdVbU5vOVgwamRXTVBPc0xjdEpWYkdMY1Qv?=
 =?utf-8?B?K0ZOS2d6cGZhOGN2YTcvZG9rdE5BWkFNblJ5M3NUUVlIbWZaUEJsSjRnRlRJ?=
 =?utf-8?B?NU5tcnlueGxveHdBUjlSUkVFUzJ6Q1BSUnorMWlWRDYzWEJOSDF2cUQ0U0pi?=
 =?utf-8?B?TTNUMCswdjFoKzltQSt3eDlOMm1SRTlEU0diemplRVBqdVFRVmw4aFIwQVlK?=
 =?utf-8?B?bFBDMDduZTVTV3IrUnJuVWtlYTNlVEN4eEpUVGNVQXRRZEhmcVRjNzZkVGRn?=
 =?utf-8?B?Q2RmME42VkRlM0VmM3BWNlNtUXR6N0RDYmUzS01UZk04Z0ZCYnYyTWJXdzhB?=
 =?utf-8?B?ei9NaklYRW1XV0ZRenNyczNoRmppNG9Sa200RTdKQ2tSemtnMTJOY0RrM1NO?=
 =?utf-8?B?QTgvVXBrWnF5emNOQURKOW1tZ2JaaXJDckFjblQrRlZOUzA3Ky9pbnFLdk1u?=
 =?utf-8?B?MTUxdDU3V0l6MjdERnVNUm1MdHd5VnNpcWdxWEhCT0lrMTNDeEozY2s0SXg0?=
 =?utf-8?B?T3hKTTFvUVc2Yk9KZUpuck4wd3JRSy9mSmIyenUzMmxGbXBQOHM1aWFVeEx5?=
 =?utf-8?B?Ni95UVlMNFZiSmFLeWdDa2VPR2NibnAvblRoWnQwcjNPckZmaitkaVlJc3FX?=
 =?utf-8?Q?1EGdva6W2Lh4o4YarQjxSVFNLuWXLFvHEnuCc8+w7Jq7f+?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ck9rMHAvYVREMWp0Y1QrQ3NSektWZnk3bi96ZE1HbnhQK2JGdzJLTFVMUU5m?=
 =?utf-8?B?QXlCSUx1UFBTWHlDM2sycXNULy9hWjdTenlKV2ZZcDkwSGhVV2RPVlplSVl0?=
 =?utf-8?B?VUZPVnVxQUlDMzZDbXpseHliNm5KaTBCZHBRNUNpelcrTUJveWc2dDZ6NnpH?=
 =?utf-8?B?dzVVNW1MRVVYS2xmN0hjdWZQMGpxMk9BNG5DcDdlMmhNUk9uOXFVR0txbExE?=
 =?utf-8?B?N0Nza3N2c0ttNlBVb044OTFYekxXT1hZVjVRM2NtUGRuYkhlVS83dXlBSzIy?=
 =?utf-8?B?RVhvYjRZck8rRWE5QXlGaDkvTHM3Rno3bXJpVjRrbEhQMDlQMmlZNWVTeGJ1?=
 =?utf-8?B?UC84QjN1MnFHQkdJTGxKeG52SHIzWTV0ajE2RGhZYXFxQXlDdVVWa0JQTXZr?=
 =?utf-8?B?MG9wT2pkWlloOTZPdnp0UW5YbWtSS3M4OGpiMWk3VFhRQnVIM0Z4N1dFWmhP?=
 =?utf-8?B?cjdWaFFaTXUxVTQ2a3RhREp6TUJ1b1lZdUU2bjIvMm4ramhWSkdQWnU4VUFk?=
 =?utf-8?B?dmtDd1h5OGs3Rnc0MDVIQ1RyOC9DaHZWbmJLb0xKZGhJWEVoN0RUNHJMdTFH?=
 =?utf-8?B?NUYxQlJxclVUdzlVVUo0Si84TUloNjQvTGovWHlsTHVNR1RRVUt2WGZPZDcw?=
 =?utf-8?B?OVdnQUhkMmhtbVRnQmt1SWVzUHg5Nm0yNFd1RWdiVEdBbUFWdDVzL1NSRS9R?=
 =?utf-8?B?bGVEb2tmL2R4ZElvWjl2NUdtb1MxQUpORWQzeW9Pb3ltQjlKdjhtSWNrSWl0?=
 =?utf-8?B?RlBQaGwrWEMyQS9tZmYvME5sMDN2YWw5M1duVFBpWXRJZmlRQlJKM1NmYk1N?=
 =?utf-8?B?dC9HRS80MThUMEVONG1WRDBCbzRvVk9BakdNQ1BFdEFFVEVMbi82ZnROQmdQ?=
 =?utf-8?B?SUphV2FWQm1kQmdKNkU1bUFXME5yUUVPMGpoS0FUQlZwR3I4amo0QmVCYncw?=
 =?utf-8?B?a1FXN3ZxR1VFMDNaWkNxZ2JHeHZCMnNNNjJ1NFJlaFYvaXNUVTdRVHk5c1dw?=
 =?utf-8?B?dTBmbVd1ZGpXR2R3ZnNuTHVmVFU4Uk9VZWl1SnpPVkROMWZUeFBqZTdCYnVK?=
 =?utf-8?B?Um10ZS82SEREeE4zV2dPNWlKN3pncmZtQkZwTmhkbnVVTUVrQ0U4VTRqc0pJ?=
 =?utf-8?B?N01ZSklKQmRRMzFQVlFLNkNFUFhGRVkzdHlkM3JxWWM3WmlOc1NZb3hYVFRH?=
 =?utf-8?B?NCszODBhQWpYQWlBa3NnNFEzOG1BK3J1Rm56YmlOYlB5Mzk4QzhnSCsydE1p?=
 =?utf-8?B?QjlLUmk2Yzc4TXpsVjNDaSt1RTVIME1qNGVhamhtVC9UYytubFFqeWJ4ZURs?=
 =?utf-8?B?cElOM2JoOWpocXpmQlJiVFlpeVY1Y3d1VzN5SE9JaDdNQW5ZWXRDd0k2cnds?=
 =?utf-8?B?KzRBYWtkNm16RjN1alJKK1RVMHJGVnVOQUZiNmgrRzBuNHliMGJQdHNCd1ZF?=
 =?utf-8?B?elJNL25Fd2dYUVI1NVl0SHVTNUlVZEppRlQ5OUNySzQzUjZHdGFPNEV3Rzcw?=
 =?utf-8?B?YlgzL0kramFGT2JnYW9GVUV0ZEc4U3U5djdvT3RZaENteFVQMGV1cUU2Z0Vp?=
 =?utf-8?B?aUtvMnpkZVVjZDJpekNKc2RUVVlUdFNqdXhyZm1Ddi9RUDh3VlRWRGRzQkJr?=
 =?utf-8?B?RzhnaG1xNkJveExPQ08xNUhEbGNnNHUxM2JzcS9pL2l3a3BWeHZPSFZ4d0hq?=
 =?utf-8?B?WDYwSHFyd3AxbDhKZC91RVVKdURlUEdadmFTVWNsUENEalBOTVdOcWh3Tlhq?=
 =?utf-8?Q?nugD56iSf8BkzH6f2pdoJtRmNrzSK4UvHHTQyyb?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8653b430-cdc5-4607-2d00-08dd4fbb55e9
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 01:26:57.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF35EA1AEBA

hello, Rob,

On 2025/1/24 5:29, Rob Herring wrote:
> On Wed, Jan 15, 2025 at 02:33:23PM +0800, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add binding for Sophgo SG2042 MSI controller.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../sophgo,sg2042-msi.yaml                    | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
>> new file mode 100644
>> index 000000000000..f641df191787
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/sophgo,sg2042-msi.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/sophgo,sg2042-msi.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 MSI Controller
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description:
>> +  This interrupt controller is in Sophgo SG2042 for transforming interrupts from
>> +  PCIe MSI to PLIC interrupts.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupts.yaml#
> Drop this.

I find if we drop this line, dtb check will report "Unevaluated 
properties are not allowed ('interrupt-parent' was unexpected)"

Do we still need to keep this?

Thanks,

Chen

>> +  - $ref: /schemas/interrupt-controller/msi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-msi
>> +
>> +  reg:
>> +    items:
>> +      - description: msi doorbell address
>> +      - description: clear register
>> +
>> +  reg-names:
>> +    items:
>> +      - const: doorbell
>> +      - const: clr
>> +
>> +  msi-controller: true
>> +
>> +  msi-ranges:
>> +    maxItems: 1
> You need #msi-cells.
OK, will add this.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - msi-controller
>> +  - msi-ranges
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    msi-controller@30000000 {
>> +      compatible = "sophgo,sg2042-msi";
>> +      reg = <0x30000000 0x4>, <0x30000008 0x4>;
>> +      reg-names = "doorbell", "clr";
>> +      msi-controller;
>> +      msi-ranges = <&plic 64 IRQ_TYPE_LEVEL_HIGH 32>;
>> +      interrupt-parent = <&plic>;
>> +    };
>> -- 
>> 2.34.1
>>

