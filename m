Return-Path: <linux-kernel+bounces-537898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBFFA4923F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9885F1893A19
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64F1C5D6C;
	Fri, 28 Feb 2025 07:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="apzUy/Xy"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932C70825;
	Fri, 28 Feb 2025 07:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727971; cv=fail; b=oAM08OnSSQ2O5ql7eB7GRXvc2c+c8pq0XwZVxiSWJBeIK5T2KuENd3WGKuvFbviYS9F1ItrDl+ZCfbWs3NjZ7y6VbWJyBnURzl8RJ+wr9FBzpkE55Qz3Qm7YyFBFa54LZ4hFQT/hEXw5p92ujaxXHtGlTxGUWRwCNF1R7803iP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727971; c=relaxed/simple;
	bh=HQMQulr9CR1wkperoOJyeut28nq5Yf3Rm8dYV9b9flg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=P8zSsYWIftOUwTVsgEE5q69W/ThFFjags5XwI+L0oZxo5IvuHX/RHZZjbcXrb4V/HvIEMHK3bUrLyHkHwXao70/1a/yo04KJH7cEb2Gl3MJ022koKTbDQXAWPZofTuSJKHWA5Y3DbRpxrGH19LZ8wmL0XJc6MU6G8HHVEGeBtrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=apzUy/Xy; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFGlyBFllGIfO3ym91lo8y1cJfmHvp8UhxM2Ac+W/pBUT5fa3eg36HWJ7cfMCWqRUgoZIXrxbDIPWtw0cD6PlYpnEZECu19Z0Tk91up6vl8si+WH7Hd5FkxlWtB6B9HYfOR+LAC6KkGE7UjTDFbAejmP5/Csw2oVnXEDa+FeL0way20RXkHM2xu4gSseGRMt5d08J1+iwvaeVMrG2v3j1Z81C9VoGRxiv+uwNF5uTGLWf4PZCtpbLNLZrpNzlShhjgodHa8NTB5I3qTcTAky6C0uRLC15GQNNFihZOtmSXg6QnUViEGDQx8YGnTy/ihi3TIH2yvYScm5YBEv/Yapsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB99H3iWLaBE9lg3YvwK7oaB6E3CfEEEQ5+UTkWmrYk=;
 b=WvUvyDXV7TszeHWDE7VR3nS7y5x9PvO7X6lTGFD9wGil414OU+OwEgOJuBoKJiHTQKAZm7b2ZsmCBgC8RVb6d7sZ4vjglM5R8SVhw9Qfdc2YJZFceMT9cCHmp6j8Bz36FnUfVx6r0z+rWh5OPiJDll0u0Wgvu5U8EWhCmN3P9py0Cc3Gz6MsynvYkhhJG4+u1QVxA40zZk/OOCrrkkYllWrwFzVgMy7pCJHunUerISlONaZ8uU1ZrQtvrIoebFv0zziXOOX7b6+evTkim79UL0M9gBvvXG7hdSfRAWU4ZnZMlXr1qhzoYelduU//E5jYXm+Su5d+5UbvxS2ClJbfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB99H3iWLaBE9lg3YvwK7oaB6E3CfEEEQ5+UTkWmrYk=;
 b=apzUy/XyDsogaC9I42FcHAQNV1PI0TyjOkhEY3IXHrFAbQEK/p0JC5KoaiMg3H/zNps4p8DLdbS4U5062FHeJ3NCFGXxmVpAMX6NPmeh1Qyv9UezlzCIFCoRVFClQOQfH7KL9d1WxsNZ+pVCvV6Bm7thu/bMjKrQKdTz4BD3KCqwRHH/yLb1OZZZPNSAeMTyCiQNSpkO0ppDBhFPzGrfJGptifxugj5Dtd14FSNKBY0rrz8QKhS9PENfLe7/oZsjTwgY1swNpSPBNEDOnya410yBd7Nx+3OhYb4y2ZBMFCVbh9IVXGLWDIGI1wv0/qHxu/vD077bVlw8r9dOMUSUOA==
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:165::9)
 by MA0PR01MB8698.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 07:32:43 +0000
Received: from PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e]) by PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::42b2:a8b0:90c6:201e%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 07:32:43 +0000
Message-ID:
 <PN0PR01MB91667A6458D213413AB64E91FECC2@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 28 Feb 2025 15:32:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: sophgo: sg2042: Add spi devices
To: Yixun Lan <dlan@gentoo.org>, Zixian Zeng <sycamoremoon376@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Inochi Amaoto <inochiama@outlook.com>,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev
References: <20250228-sfg-spi-v1-1-b989aed94911@gmail.com>
 <20250228035507-GYA52348@gentoo>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250228035507-GYA52348@gentoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0129.apcprd02.prod.outlook.com
 (2603:1096:4:188::19) To PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:165::9)
X-Microsoft-Original-Message-ID:
 <2b47b0e7-190f-4307-b662-02c94d9235e6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9166:EE_|MA0PR01MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: 558f637c-ffe7-4e08-e6f4-08dd57ca1679
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|15080799006|7092599003|6090799003|1602099012|3412199025|4302099013|10035399004|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cERUTWhaRlg3M0d2YmRMNGdBYnR5YjVISkNLWlhiNXp0ekZtZy9Vd0hteHVx?=
 =?utf-8?B?NUFiR1Q4TTJOQURBc0ZLVTZYTGw4ZWNxNmZsaWNEd0c1WW5Ka1VnTFJJRmlt?=
 =?utf-8?B?MG02Q0gyM3hYOGFkenpPdmJvMTdUdTY4aXVrUm05d0RMbktISUlkR0Z2eVlD?=
 =?utf-8?B?VnprbzlaNGJqZnZ4VFloaFR0RGdoa3JHcnhhd3R2Njk1RGIveU5kSGpSMDZL?=
 =?utf-8?B?dTZlWkZLVm4wN05RU1VOOURyUlJHaG0rMEVxK0FtTGhhNGtXNHFpQnA0L1Fl?=
 =?utf-8?B?bFNSemF4Mjd1YkswZGVBaGFuWUJJS0ZVYW5GZUIwWHgzR2VNQTBQUWNOZEFn?=
 =?utf-8?B?NExpNTZ1Tk8xQ0gzd3BqbGp1M2J5c0xMMW1LZXJTWHdZd3ZtTlJrNy9FMmE2?=
 =?utf-8?B?MWd0RUEzQWR1OTQrMW11UldGekhYU01FTjZqNTQ0UFBac2d3RDhTRHZ0RGlN?=
 =?utf-8?B?RFNQeERLTlpub0U5Qmw3TW4xYW5Uc2RWWUVtMzFndTRrWS8zdFNwZUlHQVNB?=
 =?utf-8?B?cGx2KzJwM20xcTVVQ0h6Y0hRRXNFcUpzVWRBZlBHUGRYKzF0Nlk1VXVwNGpX?=
 =?utf-8?B?bnZ4MUJHU3c1aGhHcVg0QXJ3RUNXOGhDUTZxNFdDNVdnVmRYaG1iSXpUN25Q?=
 =?utf-8?B?aDQ5aEY0ZllIblpwcjlIdGF6SEs0NTdONm9kWWsxZUllNTJnZnMwK2NKMTFp?=
 =?utf-8?B?U2YwWktjQTVlRjdxbCtnNGpHRGVZRWtUWG52VTZYQ1M1TVJpa0I2RjBuNzZK?=
 =?utf-8?B?eVlJMTFQOUlpMUhBcCs1WGRTZ0trdnJWU3prMXdrZ1hUeHkwVEdaQ0lINmJP?=
 =?utf-8?B?ZUNvQXJEWWdkRmVMSmFGSncxaGFNRHJ5S1pnbUhmaDErYThWU1hIVGlPSkxD?=
 =?utf-8?B?Sm90Y3NCTG5tYlhFMk80OUozK1JVVkxybnVscnBvdUdaTlZwZGZvWXJTaDAy?=
 =?utf-8?B?Y1B2VVdVQ1RNSytWam9DeUI4Rm5DREhkTHlwWUxCeWppWlE4K3ZGZ1BBODZi?=
 =?utf-8?B?Sll4TkJHUW9ZMmVHUnA0NmhZL1BUNUJqVk83cjB6bkw1aVhjdHQrK3hlRmFF?=
 =?utf-8?B?eVk0ZkFUSHo4dktkWWU5UzcxV3pta0k5Z1E3VUhEMUVmTUtxZHJHZEJidEhz?=
 =?utf-8?B?dHZURFAxOGhudlV5cUMrS0l5dW5oRW5BSWNBM1JJNUFDalRPcGpINURHTXpw?=
 =?utf-8?B?c0M5MGZ4YVNLUFN3dTlieER4TzJnVnJmQjVHdGQ2QTVkY28yUzhWTkU4RW9W?=
 =?utf-8?B?QitENHo2clFWYWdjODZ6ODYwTlM5dlJkWXM0OTJEUG10V3VRWU9QTUNkMHA1?=
 =?utf-8?B?VGNIWS9XNjdSSGlIQkdMRHlPU3R5M1djei9waHU3c1RRdGZ4c0s2YVNaMXhm?=
 =?utf-8?B?U09IWG5QbmF2TC8zUEYxdGY5TzF3OCtwOVJ5Ym9RdHRYSzNtTms4Yzc1YkRE?=
 =?utf-8?B?ZUNkT1lnWW5kK3NSaGJTNXhwVmRWbGt3UC96S0RsR2NyMzZValJwV1I5bWkr?=
 =?utf-8?B?YmxvanJvK2VOMWxuSkRzQWhRNDc5T3hCbk1MeVF0aytFVHJ3VHRNTzV4UHdE?=
 =?utf-8?B?YmVwcWV4dW80NG1mSFNoU21MaVFIQmUwaktjR0luQktqdnVuZ0tCNS9teWFt?=
 =?utf-8?Q?EDvCfqFixlzrS9Cxx63egTB6kszaCWu0Qe2hJRDFeNPk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3hsZm52TXg0RGwrNkVzU0xyd1JwdWJvbXVyOFZ5L21pcm1XUTJSVjBpdHZo?=
 =?utf-8?B?bUg1NVpQSG8wQ0JEZXpXRmlxd2owWGRDNnRQdkFFcGh5MjQ4ekwxOHpJWWEr?=
 =?utf-8?B?b0c0Ty9WN2c5QlQyVVM5OTVVYVBzVWdjZW5aWkpZZkFCbHJqZmRUVlFFR09V?=
 =?utf-8?B?VnBOeVV4VTh2MytWYmJFU2JRSE14cTIxaWVUeU12eFFSRnI5dXpMZWJqRGNT?=
 =?utf-8?B?UmVmaElTNEFjdmlSbUpET0VOQ0I5REo5c2dJeDJwK0FvdzNlZnF1UTJIRGZO?=
 =?utf-8?B?bnV2enBvbkR3cEgzL2hYK0k2UE9KbU1NQjFuUUVDc0ljZXVyNXdjNFJ5TnNv?=
 =?utf-8?B?bHRkVE9DYW0wK2E0SzAzOE9xNnZLZGUrNlFBUUcvaEZHbEVaZmRaczlmVjJr?=
 =?utf-8?B?YW4wck9PN3JWbU1JZm5FU2dCL01hZTNXd1hKNTBhRVo0WFA0QlhvUkswNnJi?=
 =?utf-8?B?dFU5c0N1Wm9ocm02VUpJdE5abURldXlmQk9OS3BTMU5taTdpRjNNcmNic05o?=
 =?utf-8?B?aGtnb0ZtRnU4S2Y4TnFLOTI3aEQ5SUNTMFhodExEMjA5TEpodmFodUg4R1ph?=
 =?utf-8?B?TzZ4c0hCdHNNZVRaNGZiWE5rbmhJRnVzRkFqRFdwcnhwa05tSEFYYi9EZnMz?=
 =?utf-8?B?YjRhcnN6MGc0NEdsc0MwZlZaNVh4L3JFQWthK1Bxa1ZPWHFYTm1IMFhaTVRZ?=
 =?utf-8?B?VDl5dnIrckk2TURWb1RFWWZqeis3citmQnptZTRNVUx6K2hJalY5ODJpSWtF?=
 =?utf-8?B?bThjNDlRcUVTNTNCQmdoUTJJWkJEY2FMcm1TY29UMy8yZ0NtaE9lOTYzZTRS?=
 =?utf-8?B?dUl2elkrSnk1SHUrNmFKcjd3WTRmTVp3dVZ3bFR0YlIzeSt4bURXS2loV2Vx?=
 =?utf-8?B?Mk5DRFNKaDJGTEQ1VVE4eHpwREVYcXJHMzBiWC9OVDIrMXI0bnBSRWJncUNR?=
 =?utf-8?B?ZnhBNWc4cjgxUU52dVhvMzhXUnFEWForQjROOTF1RnpDS0Y4TCtsTjAvNzMx?=
 =?utf-8?B?bm4xeFRWK25SR0dhcVY2b3VFRkk5KzNBbmxESjVLOXJ1L3c1ams2d1I0cVZw?=
 =?utf-8?B?aUFhcmNxWnkxb0IxTGgxRERldlo2ZW9pdWc2TEJCdUtkWFE0WXhnT1E0Wmht?=
 =?utf-8?B?czRUSllaQmQ4OVJzRUZsb0thTVlNS25lUVZhbVdOVzM2Y1pKTGpqdFJIbXgx?=
 =?utf-8?B?R01GdEF2ckVFRTloMEtNVHBFSmRVM0JxUUV6elZESlVQQUs2ZTZsUTdvaUhU?=
 =?utf-8?B?NTF3Skg0N2RndmV3OHVKcXdGa1JjUlBsYWJPVVAzbGc1eUdtVFFKanpEeWNu?=
 =?utf-8?B?ZDIvdGF4Rm8vYWpEVGF4WmZobnlvNUs0TTV2SC9VbWF6SlJMa0x3NFlFNm5W?=
 =?utf-8?B?Q3E1aDMyUEkzSThHakFMZks2S242MmVjT29TUHpKVnZmQVk0SUx6eisyZWF3?=
 =?utf-8?B?TlUwMFJxZVhCNHFQbFZ2TklKaGFvQmNxUTJzcmhJMlZpdENxbFdzUGExaktq?=
 =?utf-8?B?YmV1WngzTnVhdHhxNlV2V0llMmpwZUN0ZXJHTGtQbkJXbEZQV1R2SWE1bXVo?=
 =?utf-8?B?MGsvL01IWElrUFhiMjIvcTF0cUpPMHo2MU0rT2pJQzFJbVFZOUg1b0tTb2RO?=
 =?utf-8?B?YlNYQjMySm9Jbm9PN0E3c0tvQzNlQ3Q1eTNJRDZqZjZIRnRPRi8wMjJZN243?=
 =?utf-8?B?cm1MSmpxenJ1RUcwdzhCbFNvdlJTT0JzclFhRkZ0U0hqVjE4VlZnSkY5Q2R0?=
 =?utf-8?Q?Zd7Rm55pUATux+1CkdtoI7d0iR5Mp3IJ/iuTn0v?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558f637c-ffe7-4e08-e6f4-08dd57ca1679
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:32:43.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8698

Aside comments from Yixuan, appending more ...

Change title to: "[PATCH] riscv: sophgo: dts: Add spi controller for SG2042"

The prefix sequence is required from my previous review experience, and 
we are adding controller node.

On 2025/2/28 11:55, Yixun Lan wrote:
> Hi Zixian:
>
> On 10:47 Fri 28 Feb     , Zixian Zeng wrote:
>> Add spi devices for the sg2042 soc.
Change to:

```
Add spi controllers for SG2042.


SG2042 uses the upstreamed Synopsys DW SPI IP.

```

This way, everyone can better understand why "snps,dw-apb-ssi" is used 
in the code.
>>
>> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
>> ---
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> index 0fca16c469cc95aa897b6b57e0a287a687b4d251..d413daa47cf081f23284851db1eeceb3a157e9c0 100644
>> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
>> @@ -800,5 +800,35 @@ flash@0 {
>>   				compatible = "jedec,spi-nor";
>>   			};
>>   		};
>> +
>> +		spi0: spi@7040004000 {
Order the nodes please, see 
https://docs.kernel.org/devicetree/bindings/dts-coding-style.html#order-of-nodes.
>> +			compatible = "snps,dw-apb-ssi";
>> +			#address-cells = <0x01>;
>> +			#size-cells = <0x00>;
>> +			reg = <0x70 0x40004000 0x00 0x1000>;
> for consistency, I'd suggest moving 'reg' info above '#address-cells'
>
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
>> +					<&clkgen GATE_CLK_SYSDMA_AXI>;
>> +			clock-frequency = <250000000>;

Have you run dtb check at your side before sending out the patch? I ran 
and got following errors:

```

/home/u/ws/dev-linux/out-linux/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dtb: 
spi@7040004000: Unevaluated properties are not allowed 
('clock-frequency' was unexpected)
     from schema $id: 
http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#
/home/u/ws/dev-linux/out-linux/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dtb: 
spi@7040005000: Unevaluated properties are not allowed 
('clock-frequency' was unexpected)
     from schema $id: 
http://devicetree.org/schemas/spi/snps,dw-apb-ssi.yaml#

```

You can run `make CHECK_DTBS=y W=1 sophgo/sg2042-milkv-pioneer.dtb`.


> ditto, move clock above interrupt
>
>> +			resets = <&rstgen RST_SPI0>;
>> +			num-cs = <0x02>;
>> +			status = "okay";
> in dtsi file, please make status disabled by default, then enable it at board file
>
>> +		};
>> +
>> +		spi1: spi@7040005000 {
>> +			compatible = "snps,dw-apb-ssi";
>> +			#address-cells = <0x01>;
>> +			#size-cells = <0x00>;
>> +			reg = <0x70 0x40005000 0x00 0x1000>;
>> +			interrupt-parent = <&intc>;
>> +			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
>> +					<&clkgen GATE_CLK_SYSDMA_AXI>;
>> +			clock-frequency = <250000000>;
>> +			resets = <&rstgen RST_SPI1>;
>> +			num-cs = <0x02>;
>> +			status = "okay";
>> +		};
>>   	};
>>   };
>>
>> ---
>> base-commit: 9ef5d3235d41a6f5230d3ddf5eb994483853b3e8
What's this base? I can not see it in lastest master. Make sure your 
patch is based on the lastest master or at least an official RC tag such 
as v6.14-rcX.
>> change-id: 20250228-sfg-spi-e3f2aeca09ab
>>
>> Best regards,
>> -- 
>> Zixian Zeng <sycamoremoon376@gmail.com>
>>

