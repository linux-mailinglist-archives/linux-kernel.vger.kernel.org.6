Return-Path: <linux-kernel+bounces-543133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D99A4D1E3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263393A85F1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 03:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D961B3F3D;
	Tue,  4 Mar 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XzlhFH5Q"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAE13792B;
	Tue,  4 Mar 2025 03:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741057591; cv=fail; b=OOsA05kBw+QrrXTMoHUaZVsYMQ15FPqxHCRpMvMtI2TgwNnlvWAMdvvr6jqOFvTEGLpBPbdwJyAMXtSPhwlVj2Mta0EJhl1YY4SsM1TqTTli6KOrFhGCGa3mk8KVvfy8o8LYQBArKp11XH3UeOBX+2sVggyFvtwoDVjICKFx7OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741057591; c=relaxed/simple;
	bh=Td2ESyhpQpv7+AqczunmSWd+M9BaCCw133OIWakPI7g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CpaXrCsm5gP4T/CHZWwFFh9V6A3/Ry0IaAaeqmMncbLxDdodpSge+7QgOaQx8DfeZ7oApHtjiH7XklS4xYP3gwsJH+04IIhMLnlFOuZ3CuFwmrCbs5UezdibfgNc+wsg/BOP8VAeAwVrGVaKEYB9IhiQ+5kB0A+ur8LEF/geJqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XzlhFH5Q; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWK7WatxR9c3S2YSkK1ybHJuBNfnLsU6IidYciY08HmI1nEucpcAFl3XDNrn6ZEOnzwU+qX59aSLDM3EnZXO4S38IvRmbtZeJ3gj3l4ytaE2rix28ShCv9arjZtuyZ9az9ALslb0uLDHyAA8wyvOkwKgjQh2eM/EpBn8s5TSh793WKiF0QZm2vzMXCPJ7Z6t7BusD1q0CYzkiDGFyrv6GSU2teyWvb/ymeYdvImw0VUb3UnL0k8ANUszZ2dJBtTtpImsxxPoTs+fitpp2Uv0rCysctw5pNqw9d5eYseiO87ds2wfKWboEpMcSoWpk2WPyNDncZKUEuFBuhptfoONiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGi12JGvzOb6N0G9xpktHkewAtxUIteV+ifoJfweIY4=;
 b=XhowrfiOvGisVXTo7uLHIfUv0/sYXgAG1Qq7fZvCVsOlipt9DbKVy3g9At1Qj75FsD/1z+XpVv/FfnEASAmbdop61fe62oYIeG9Cr7L+xoGSEPeo05MEXyZPJWA9jcCw64ttTq4eztUvKz9OciN/dDSHqaInOXc9Ay7EJpG+BEy5T34BXO6qdu2VBLSPO82eYQvD5JhesIks1UNuGWeJAN5nHoLDVzxiYDPZPWxFn4o5KXNkvxmeHVa1VFmeE9iqwDGc45klYkUzQuCnTRJwWJg/NrQ3pfGBIp07XrfPQlEcezRpaBa95eA4zs/zNjwOdTAkk1ZwqcZaEJLZsbvIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGi12JGvzOb6N0G9xpktHkewAtxUIteV+ifoJfweIY4=;
 b=XzlhFH5Qzl2WBrAsqjAD0C6QJ67H1UJ+aZaP4GrXGhtdGil5cMuxjKFkYafULiKrjqx/AKlDmza1pIBCI/C9UWQzOVmk3Nfs+esoWqSVO6lt0tlif0CDy6Jb2Cyc5dXgx0t60cjo51R7CsjHEtiIq6OzX8WxjBiH39u6X/VkvjAubY71FfLXHhV9TZWgI9hTC/oBmzIkZFrybZ/agJ0zXgI+rIiRF9sIdBNkiCAiCRb0vFOOUOZOk1NSx40vdgevNlsXcix+DiaqC/4rxlrreEl/9Gt2ZHbnuBHxGZpe2XW8oI3MYrBBxjqqsPXsS/r7M4fG8K7HhExWc3KrZZM7Fg==
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14) by MAXPR01MB4246.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:4::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Tue, 4 Mar
 2025 03:06:21 +0000
Received: from PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5]) by PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1b4f:5587:7637:c5a5%6]) with mapi id 15.20.8489.028; Tue, 4 Mar 2025
 03:06:21 +0000
Message-ID:
 <PN0PR01MB103931A586C8213740F2496D9FEC82@PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 4 Mar 2025 11:06:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: sophgo: dts: Add spi controller for SG2042
To: Zixian Zeng <sycamoremoon376@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Inochi Amaoto <inochiama@outlook.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com
References: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20250228-sfg-spi-v2-1-8bbf23b85d0e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0019.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::13) To PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1eb::14)
X-Microsoft-Original-Message-ID:
 <5411715a-1ae2-4495-85e3-10cccaa109a3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB10393:EE_|MAXPR01MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd6a081-2c18-43e8-c7aa-08dd5ac98a09
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|6090799003|7092599003|15080799006|8060799006|461199028|41001999003|1602099012|10035399004|4302099013|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amJhQ3ArWW90dzR0dFJDYy9sLy9CUlo1c3RieGs3Q3hWOEdIaHlxVlVIT3lm?=
 =?utf-8?B?Nmo2b3ZuazNwUzhnOWxwWEJJR0luN1dlSTgwUUxKM2tRL215TmpXTG9UdHFS?=
 =?utf-8?B?NTVUWnNRS3JNMWgvZm5kZnRsMnpXbVUrUGprWTR4MDFLUEh5WVVyeUcraTZN?=
 =?utf-8?B?MzAxMnVQbUw2ZCtCMVRxUVc4OUNjaC9IcEN3aC9UWlFyd3N3WFc2VWFlY2o0?=
 =?utf-8?B?K1dJSC96TmdBOTF5QXRyRWNtWTFreTh3QXgxd2JOejNxa3JJeTc0MC9CM2Na?=
 =?utf-8?B?U1c4NW0xSjRlVXA2NWxHbnIzeGVqM1lUK2hCbVRacWFSQzRkeEgvc2VOQm1T?=
 =?utf-8?B?dUhHbmp4d1UwSEJsZmdzelM4TllEa0pMNjM4MzZORGl2UFJiSzJGOFBJWE9B?=
 =?utf-8?B?WnlWNXoxZ1FtL0FrektuMFN6bEx6OG5CNEx4VkNkRjBHeGxFSmFTbW1xS1ZM?=
 =?utf-8?B?T1UvU3kyd3FsemsxRHBEeVAwUWVyd0JEWEJVU3d5Tm9iUlVLbmt2b3o2YU1H?=
 =?utf-8?B?REtpZm1CMmRqdzhjSFFkS25JMkhzQ1FtV01sZnhlYjR4Uk4yT3Ywb2EwbUpF?=
 =?utf-8?B?ZDBPdldsVnlzWStlcHdjaGluZ3RRYmwyVmxnVTJ2YmVJeW5TVklSeWo0U3Vp?=
 =?utf-8?B?b25nQm1jaHFRbGp4ankxTDRBazhhV1dSanFWc3VuekJMclJwbHpMSndJUXIr?=
 =?utf-8?B?UmNoSXpqb0E0NjV2L3NITThBRGFBUnVjTkRnYlhUc3RwNkRQVy9HZGU5Y1oz?=
 =?utf-8?B?dnh4MHNCZ0s2UEdtY2pHcUJCdmZCekVqdldpOFFKOFFBTVFNRHg4bXFEV3hO?=
 =?utf-8?B?OWJ2dW9lN1piVXhhTHNQVGQwZFJNSStZSDlicVNLeDZyM2tzam9Sc0xLWTFw?=
 =?utf-8?B?WGZYb041cEpJVFdkVThnRStySElwWG51dEYxWTNyT0F2WXBaMGp0RDBxbzdq?=
 =?utf-8?B?NFNYc2lTMDFzOGt6YTV2aTBFdXd1NVU5bmk1VTIxSWxFeWEzY1gyamJ5RXNk?=
 =?utf-8?B?a0wxWjM4TEcwTmxxajdrUi9Xc1loU2VyQzJ0VmZsVGduRmZYSmZRM2w4dDdG?=
 =?utf-8?B?clJXbTNaS2xmTEt2ZHArSmhkTGFEclNVNFI1cCsrZjJLYlBOeStHbCs2V3N5?=
 =?utf-8?B?dDZUWTBuSlkvMDRQWFV3VUhQZ3VlQU1MWTh0c2RGNkk2VjFZa0Mra21tcVF1?=
 =?utf-8?B?YlYrcHR1TUtJTU82K2QwMzhxU2J0Y3VKVzhxSDhNYkx1cHh3WWExYnBqc2tu?=
 =?utf-8?B?c1lXZkJLWS9kV0JWWlF6b2ZpbzNzWmp1SEFwek44Ui8wZk04VWdhcllpVmlZ?=
 =?utf-8?B?bDNyRFpYNTBCd0VkQ25udVdGZ2NpMFZlbFZCZEY0T29URjRCeFBVdHN2bU5G?=
 =?utf-8?B?bGp6Z2JHWVMwazRCMFJTTytXeUNBbWhSQXcrTlJhV1Bxa0ZPQWlCTlVDSWZG?=
 =?utf-8?B?cHdJZWlySDZhMlRyVEtSZXdpMW9ld3N0N2xzdkRyc0ZwWk5rendYaE84dXhI?=
 =?utf-8?B?bDIxaXREMzFPSnNnbUZMeDIvTTBRMjZqQUZHbEdxNXBtamE1UzZKWms0UEZp?=
 =?utf-8?B?NWhTL0ZlVDIzVHgzVmhlRENxY2hvUjZxSTU1WUIrb1A1YWVZYitpamhtSFdT?=
 =?utf-8?B?S2oyQlBveUpxRVg5ck9Sc010T1Q4VVNKRHBEdzQyVmNubjFCUUxVWmpaOFJs?=
 =?utf-8?Q?8gwweE0IMAijSmBQ6GGp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnQ0QWJHZENDYmRzdEY0SjhjbDdNOXphMVJ2RnRVQ09uUmdDOGxYK2lqMytt?=
 =?utf-8?B?WkVlWEd1Zjh5WlFKanMwSFlCaTBDcEQ4NDIvSmRIY3FxWHEydzN2dDcyMDRs?=
 =?utf-8?B?bHFoZERPK1gwbHM0emRUb0hyZnhlY2t0N3dWYUE5YlZjemJYdEtoaVdyZDJL?=
 =?utf-8?B?NkI4VHc2Q1hsMnJ6TmF5a0pDNDIwZC8xcnd0NVpWMW1LaWdpQStNMWdnZXpN?=
 =?utf-8?B?RFcrS1RMdEZRNFFZTUt3ZjdYaXRkNnJqVzhMWTNYNmxjcnphbzR4M3hBSHNK?=
 =?utf-8?B?S1YrM1lQSmZnNTRvUWtSdVA0UTAzdUVNTmo5di9Rbm8vTkNWUXh1aFRkcFdm?=
 =?utf-8?B?bFhic3hSUHhWUXRacEZMWmRSTkpTTjgvNlgyRlRTODVOOCtMS1FnMU9Xc2Vm?=
 =?utf-8?B?bWRJRFdkR0haS0tqWkM1dGhlZm5uTjVWQldPQmFURVJGTzJ4cVVsbS9kMldw?=
 =?utf-8?B?MmM3ODJmSkcwZkYwbGovc2U1SGVJQjE1WVFqb2FVR0RZaWxiYWFyRnlIMmJ1?=
 =?utf-8?B?cysxQlphQjBkM3ZJZyttMDFudjN4WWR5L2JwT3Q4b2NTbUVReG40VWNNdE1w?=
 =?utf-8?B?SGgvRFdxMHk2SWlxalRWMjIxNWJuaW9JU3MvdXBKUlI3cmFJRGZ2bzdBOUZu?=
 =?utf-8?B?UHlSVUpza1dMU0EwQktPanBWQzlENkJsY292UzQzT1BrM1NocStTSEp5ajZB?=
 =?utf-8?B?WWNCdG1rRG1OOGoxZ2ZsU25PaWEwdGZ1ekxxTmVSaTFtcFZTK1JZUFhQSjlL?=
 =?utf-8?B?UlZOZWw1ME4vcU41cmxORHdzeW9CaTdyMVVUajc3djU3WG85ZnpPWGlMNElI?=
 =?utf-8?B?ajl1eXFRUUFDNVdxSGtCQU1jdmFxbWVZSWhZbnZGaUx3eWFnSmtQQTZzU3U4?=
 =?utf-8?B?SXJ2eFNDSHM4Y3AwLzdPNjA4eU5LVlhCaHQxS1cyclZFY3hyc0JibkU0UjNm?=
 =?utf-8?B?UDN1QjAvandVckNYeExtTkRZZE5Jd0NwY2c4VURRWGJJbWxXMVliSlZBZEx3?=
 =?utf-8?B?eWdHditDTFVaRWdIdVRLejdacS9kdkplUzdJUXU2MlRGTVVrRHNNalEyM3Zn?=
 =?utf-8?B?NkY5QllBTTBOcmJ3MVZTYmlCd21KR2F2RDAxZlMrclJWeGxORGpOVWcxclFw?=
 =?utf-8?B?R09EV01FT0dFWURqUHkrOHBma0hybU83dGVDTTNCeHRUM1BGcENHUHdTZnFO?=
 =?utf-8?B?c2tjVnBFQ1RZc3ZkNGkycFhpT1BxZ2NWZ081MzlkU0pDdFV3TlZvZVRXL0x1?=
 =?utf-8?B?Mlc1OU9NTGV3eGx2bjVDZkRVU2xySmZvZHZ2TlFTYXR1QjdvcGUrMzNzRk1r?=
 =?utf-8?B?dXpJQzJvWXo0WERRZy9ZRHJKK0RxTnBTcy9hTER3bFZrQUhvZkdGQjBBS1dF?=
 =?utf-8?B?VWk0c2ROeFhsaDVFVkpraVdWVkZDWCtMNWU5OEhWVFQzVUFQcUtjaDhKalV1?=
 =?utf-8?B?WDloRUVyMVFXQnJkNUUwNm5zMjFsQVAwQ21qWG1aU01ZYW5JSDBMQ3VubFY2?=
 =?utf-8?B?ZUJ1eG9Sc0dLV2V3N3lNcWJOZ0R5NlJ3UXJKWFgzd1J0TnRXYS9lWXFGVjNO?=
 =?utf-8?B?NWVSTTBJaG9CSWxyUjVYVW5CbnJTaW8zNlBlUzdnSjVjSWpBS293TXpOcGY3?=
 =?utf-8?B?dTluL3dYSDlOY2tMWEl4UXBycCtFRXNvQU5oTU5uVXl3dGdURHFzaWYzWDA2?=
 =?utf-8?B?VVhjdGtGTVJ0TE5vSjlsWFpRUFAzaE1RajdyK09jL0tZN0RhQ1FRUWtwVnlL?=
 =?utf-8?Q?OOyrVCSW4Hn9FbBKTz83mMX2J0ea1lkXh+capX/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd6a081-2c18-43e8-c7aa-08dd5ac98a09
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB10393.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 03:06:21.1394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4246


On 2025/2/28 20:40, Zixian Zeng wrote:
> Add spi controllers for SG2042.
>
> SG2042 uses the upstreamed Synopsys DW SPI IP.
>
> Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
> ---
> For this spi controller patch, only bindings are included.
> This is tested on milkv-pioneer board. Using driver/spi/spidev.c
> for creating /dev/spidevX.Y and tools/spi/spidev_test for testing
> functionality.
> ---
> Changes in v2:
> - rebase v1 to sophgo/master(github.com/sophgo/linux.git).
> - order properties in device node.
> - remove unevaluated properties `clock-frequency`.
> - set default status to disable.
> - Link to v1: https://lore.kernel.org/r/20250228-sfg-spi-v1-1-b989aed94911@gmail.com
> ---
>   .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts |  8 +++++++
>   arch/riscv/boot/dts/sophgo/sg2042.dtsi             | 28 ++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> index be596d01ff8d33bcdbe431d9731a55ee190ad5b3..c43a807af2f827b5267afe5e4fdf6e9e857dfa20 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> +++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
> @@ -72,6 +72,14 @@ &uart0 {
>   	status = "okay";
>   };
>   
> +&spi0 {
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	status = "okay";
> +};
> +

Pioneerbox doesn't use these SPI controllers, so just drop this change 
and keep the change for sg2042.dtsi should be fine.

Thanks,

Chen

>   / {
>   	thermal-zones {
>   		soc-thermal {
> diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> index e62ac51ac55abd922b5ef796ba8c2196383850c4..500645147b1f8ed0a08ad3cafb38ea79cf57d737 100644
> --- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> +++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
> @@ -545,5 +545,33 @@ sd: mmc@704002b000 {
>   				      "timer";
>   			status = "disabled";
>   		};
> +
> +		spi0: spi@7040004000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x70 0x40004000 0x00 0x1000>;
> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
> +					<&clkgen GATE_CLK_SYSDMA_AXI>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <110 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			num-cs = <0x02>;
> +			resets = <&rstgen RST_SPI0>;
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@7040005000 {
> +			compatible = "snps,dw-apb-ssi";
> +			reg = <0x70 0x40005000 0x00 0x1000>;
> +			clocks = <&clkgen GATE_CLK_APB_SPI>,
> +					<&clkgen GATE_CLK_SYSDMA_AXI>;
> +			interrupt-parent = <&intc>;
> +			interrupts = <111 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <0x01>;
> +			#size-cells = <0x00>;
> +			num-cs = <0x02>;
> +			resets = <&rstgen RST_SPI1>;
> +			status = "disabled";
> +		};
>   	};
>   };
>
> ---
> base-commit: aa5ee7180ec41bb77c3e327e95d119f2294babea
> change-id: 20250228-sfg-spi-e3f2aeca09ab
>
> Best regards,

