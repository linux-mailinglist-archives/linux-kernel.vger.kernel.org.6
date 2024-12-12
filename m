Return-Path: <linux-kernel+bounces-442409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C22B9EDC69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 01:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D32282FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 00:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8AF6AAD;
	Thu, 12 Dec 2024 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gli8AVjD"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011027.outbound.protection.outlook.com [52.103.67.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B2917555;
	Thu, 12 Dec 2024 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733962774; cv=fail; b=DcYXcLCBuGU6A9C/AIlq6dBlo12Gx0oEhLF3b8SvqzQtbV1kN4YT8TSOwcjEKGZafK+JAcRkHqZ/oWpxa0Qrli1syLrQGIFw4dY3Kb11alQe6/3hGPqHJF+889DfnC81fT2OeoH2ExUltZnbXOy8omuuIwwerfNElUkiXNSWH5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733962774; c=relaxed/simple;
	bh=mWxeJ0FJdZ3J3uXMZHj3X5nNWXkpkS3pGJgXUHmSj6w=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhGDAVQ1NfurP9VXKq2/+UtnD56kf10FRa+BH8PyARZfInMu0zYcjBAbzE6a96ecG5Dtwyf8GbomCbtYo8RpV7nC954F2JUOUqUf235qyIYZZARBIuiBPY6hVNbTVPZy1eIfLE6O9ixZ/CdqJt2PD2EOoE+9o3RVJ/htytGQ0Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gli8AVjD; arc=fail smtp.client-ip=52.103.67.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEEfMBxRzLxI+OnP0F5B4gYKe6IV5xuww8ILOcmdwIlkVRxgohb7v2nQ8Tnpt3aq90TleqoxVOc11bJTmXyOgMPqRqaKSlrv4l1XpqZllG3MckrgZvzknpzXbgCg8Ct5DQ9Ih/ubvkpAVxWmhGM4cgZe4IBeoQwNmFY5GfZAlgske+6pppet+EwLqprJWznv4CYabTOAZqLyiDUSyzQe7d+5GrYGXUl43hPHI/unrZJXLq7JHIlOGJI4L+pmrXfclrR+wsc47/XyJHsp1Ioesmrmk5fgnX2IUm+g1P/hGU/IYkiaN4Q8PaeNlpPGuxNDDXWqgvBq+vb/moslcwrCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1b15VXyTKp9hn3Oi9qj9tJ6Q77OWeGCB8hqP2lCJys=;
 b=GuHdoeXT+9B4msuy6kZnmn4zRGKa+CnybjzRLc3IEO8wxqEHMSAESKK+ubSbpH+BVDdLuLr5p5dooryri2yGayiSugUnKCmoRj4dkSzSStEXoJRgBYTODZd82ZpRPrm9XLcSjPKD4CSgm6ZxrLJPoazAkkW58xUrVasNPwbWxUu4Kv9Rj1aS9n/Xdoj1HXa3p5OioHO07CIrhzmV4wxj9c7keo0LidiwGVYHsOr2Ukny1SveeKtDW7KEgSHdALwqz+53CGv4EnO5wqVUL4YStDli/C8iSQ+a93/qCGnfNgt3GkoO9O9uFR8nCYrzx5x8/AP2fegME8xzvNslO0LG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u1b15VXyTKp9hn3Oi9qj9tJ6Q77OWeGCB8hqP2lCJys=;
 b=gli8AVjDy2tAXGxplxoea01zTjWm3rt9IMEAIL3hE1pIVUicevh5YFiylHtetcvquKY//p0qj1zL4aRhiswFfcADby7LVEtYl1XNamEk2zQlUPoSK24yV7RnOQuG6F8bVf/8O6KSbAYNp+U5elF+FhDVwe+pjgo4OlFjR1lOD+6yeuvCMubn302Uz3N5eVkZumHJ45ieVFf3VY/sIoOmsxCm51zzYWnJYLAHJ5TylV5IHbxRrGtNSmrewJOxB8WapUJHd5ncfA3iJxkelbfBSym1Kgb9IoS7QrvowTnuXAJZccCuypQbeKKivO41yItU4BDQVq1VtXwCqEy+Yeldsg==
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:33::20)
 by PNZPR01MB10640.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 00:19:24 +0000
Received: from PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4]) by PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cfb6:8c54:4902:b1a4%4]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 00:19:24 +0000
Message-ID:
 <PNZPR01MB452875A7236D7A2546EC23B4FE3F2@PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 12 Dec 2024 08:19:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <cover.1733726057.git.unicorn_wang@outlook.com>
 <c882fe329932409131be76ce47b81a6155595ce4.1733726057.git.unicorn_wang@outlook.com>
 <0e50f6e5-2442-40e7-8baa-575f139fad37@wanadoo.fr>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <0e50f6e5-2442-40e7-8baa-575f139fad37@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:33::20)
X-Microsoft-Original-Message-ID:
 <bc0e26ce-c3a1-48fc-815c-0038bac3b75e@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PNZPR01MB4528:EE_|PNZPR01MB10640:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5f4197-2b2c-42ff-6167-08dd1a42a06e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599003|6090799003|5072599009|19110799003|8060799006|15080799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T21mUmpkMW1KaWVJZmRTd3NHWUk3Y1JzMFlmMlFmU2N5REdZQ1pnNXMrb2kx?=
 =?utf-8?B?MkE3VTFHc2FFTk11bi9kSzFLMS83OTB6U0dTa21xTURheUF6aUE2WDIvdyto?=
 =?utf-8?B?NVluc1VBUmtHQnpiZE9sTjdnNWtvN2Z6TkE2b2gyY3F4SnUvWWlzK1VYMERu?=
 =?utf-8?B?ekdPWERVeWo5bzhsdnJldDl4MVdyTnIrdFBNWGM0UmRKN0RpZXF0T2IrZDhj?=
 =?utf-8?B?M0dQOG9mOS8zMEY5djJERW1mMkNudlZoU0EwMFVmb2M3Z2Q3RFlEOVpBSUZ1?=
 =?utf-8?B?ejVzczk3NjQvS0tFM3dzZHZRV0w5VWFwYWZHcEJMUWdUS3BVU2NTNERKcVBI?=
 =?utf-8?B?TndGVnd6UitXK1UwQlRrUndDdW9pSFRZUElRN3l6eW11bEJ6ajYydmlUbVhG?=
 =?utf-8?B?RjhON3hKc1ZudjRrMlo3SThlbWdseG5yNEtZU0pwWXhtNkNVczhKQlUzd2F0?=
 =?utf-8?B?NEZ2dVV4QXJrVDlZckFGd2NlTzRlcHVqTnZvYW9Wa2cyaU9hU0IzYm1sdFNu?=
 =?utf-8?B?c2RMbG1XL2p0YXRpWXp1ajRjbDd6Z2lQWnVIa0xoZUZGWVJlZlBWQkJua3Zo?=
 =?utf-8?B?RmQzUFd5a1pqS2lPVDJmSUh1ZnJ3WnNtbTlmaS9WU0p2WHZncDNUY1BtOHVZ?=
 =?utf-8?B?aG05UGNSdlFRcUhSc3dpUHNUVnVwanJYeFlmc2VyMkZoemlnVGg4UDBXbVZo?=
 =?utf-8?B?dWdvWmFzRGV6MUhEYTFxZnZwclErQjBRaVFIanFQV0U5S3gwNGxlamlPblZh?=
 =?utf-8?B?K2d2SFYvblRpUE5sT3pOV283M0I4cSs2VTZWeU1yci9nc2w5dk5KaERPM2Na?=
 =?utf-8?B?UXNiZkVVZ0xpOEYySXY4ZUJzRHcwNmduUFFnTlhDNGVjM3lXb21uc05rUkFP?=
 =?utf-8?B?UDNyRERINEhPdUJiQkpieExLVHpnQktFNG1vYS9FbWxFZGRhQm1sZTNZY2tQ?=
 =?utf-8?B?djhtWUdaSVlCSFV2bExRTGlJaGRIamh3NmNCRXA5WlBTNFc1dzdwSGx3UWxa?=
 =?utf-8?B?SmlBdm9GZUI4M2l4eXlGSEJ3bkdZNUhTTjdRM3I2UXowQzFIZUtTa1crcGF4?=
 =?utf-8?B?MTg0ZFdQeTVOUUxTNnFsUDc1WERFcTdaOXhVTEJEd2ZJRXV2QzI5bzBIcG9y?=
 =?utf-8?B?alI1T1BrUXM4MjhjMjhNVW1tODBQYWRJVUFNNU5vdG40OWRhMXlSUG50dGJl?=
 =?utf-8?B?WDgrWllxams2LzVCcUtYMzVEVGpjR1IxNjNyKzNkS1dVcVUxb2pIanBxSklY?=
 =?utf-8?B?bTJ1UlVEd0pwbEtRRU0zVzVkL2lXNXhSb2VmZmFrNjhqeGkzSnJLSGpSay9S?=
 =?utf-8?B?eld3R3Z2RDlGckNjL0RUTjRvbjRvU0czZFR2emlsRmYvSHBEaHh6cTZHQm5H?=
 =?utf-8?B?dWZlOU1kcU55dUxzWnM5OUJRL3Rpa3JkWjgxZVdQRlNxK1BaSTdWdkpmdjNx?=
 =?utf-8?Q?N68tmNSM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QW9ZOXVHNjlmRkdJaStveTBTOWgwd0tZNlZ4OTNaRVo3Y0xHUU1YOFBhNDVB?=
 =?utf-8?B?czdnZmJINXludXBpTHJMV0tUeUhXZUM1SStqWDBGMXR2dmVjRzFFVnZScVJs?=
 =?utf-8?B?cjkybmVzYlRFRmR0ZG9wSGpKRmJJRWRMS3Q0YVN6UXBNTHU0UmFpRk50WmV5?=
 =?utf-8?B?OEpyYW1OSlRyalR5bThGeFNXckVaVllzeENEcFJpRTJLMHdqY1F2S3FZWWtG?=
 =?utf-8?B?eE9aVkM3aUo0NmFtdldSQXBjTlllaGxac3BrRXE5R2FmUnZDQXN5MS9xaXg0?=
 =?utf-8?B?Y3lmcmtncDBwNXFTbnd5eUFWT0hubFVtM05sNS9BbDJ6RG43ZjJyK0Q0T1RJ?=
 =?utf-8?B?S0NxUmQ3cW8vU2NIM2Fjd3pzWnFscGU4djFWSjZTZndJVitsUnNHZHBBekpE?=
 =?utf-8?B?bEpVQklvR0hHS1FTb20yM3R1UnNBelhaQXF5QjBsKzB1YkFjdjdUZGVqeXNy?=
 =?utf-8?B?TXhhMXBNNmh1NkhIUXBHQTRVem1wczVRaXNRZTRxWHp0eG1HV2Q5NStVYW9i?=
 =?utf-8?B?djZZVm03UkVJM1VlUUxaQ1lwc05TOXJTZTNWWXZBeFI5THQ5WWtVU3U1UjZI?=
 =?utf-8?B?dE44cTA0VVFwNEFob0R5Y1EyT3c2Ynl5cUwxdHNvU3FMWi9kK1MwRS9Wbk9Z?=
 =?utf-8?B?dUNRb3I3ck9GTHBNRnBMMDNaODF1dnRiSDlxc1hVTGM3YXZsR0tESkk1N2Rt?=
 =?utf-8?B?cDZBWGs4T3RKT2huUnFKQjdETlYrNDJqaFNHNjNHYytaRVlqaVhjMUZKV2Rx?=
 =?utf-8?B?dHBLOVQxRWl4Y1ZkdC9wSzJjRVI1UlJIZGRacHpxS25YTyt6RDdXTVQvZVJJ?=
 =?utf-8?B?K0VtK3I0eEQySzh2Tlc3SUFQRFQvWGlNMkk1SXhhbEVOaEhVZ0hqeHlCdmVm?=
 =?utf-8?B?SXpWNmRsTFFERlFxSko2blZzRWQraDZkbXR1a1c4eXVCK1lqaFNYZUQvcTFH?=
 =?utf-8?B?a0dGeXNBbi9wWTlralYzZ3VJdG5lMEZGc2MwbzVsMHRPTVhodmxMNS81YkZv?=
 =?utf-8?B?MmRmK3VtQTR1WCtoTTRtaEh0STRzSUtCWHFwV0VmRTFSWnpqdG42SFpDMXgz?=
 =?utf-8?B?YVZjRDE0WkNRNTNEYXlCZ3RGRExGOUNRSm5WQU45bXhOOFF3UHFBTmJjOUd2?=
 =?utf-8?B?bUZ4SkVjRXc1RFpvK1U3TklqUkU3aGx1QURwa0swNWl5KzB2MTMrS1ZyK1NH?=
 =?utf-8?B?TTB4MDJ0VEwxRmVxcUt5YkVCUkxyVC8vblJtQktjdXNnVE9EaVpqRjh0Qlhx?=
 =?utf-8?B?TlRFMEovaDZCUEg0WWlEbkNURTJkdlN6MFFnUTM0Nm16MjVBTDM5MXFyNmxk?=
 =?utf-8?B?MzN5REU3TWI2ZWhWQmR2d0p4SzRMeDdZUVdYVjFTS0V6S1JWNm81VEdZcmNx?=
 =?utf-8?B?U1RHUTBtd2dLOXArekJQTUMyL29hV1lJS3djbTBrc1FFazNzVWEyRkNLQnVS?=
 =?utf-8?B?blhjamNNQUV1azdXQ1Q0bnVFdzJYV3FwdnNuaHc3VFB1czNud1prK21la2Jv?=
 =?utf-8?B?NmZ1NmFGVnN2endpdWVVM29aeUxHWXNTV3RyY1hCaGJHK1hNbmM1dTlPaGlp?=
 =?utf-8?B?VlI4VVRuaUtRVUtKd3dxbUE5QzIwcGVRa1B3ekNGak5XVk9lRUwvd0E1Zmlw?=
 =?utf-8?B?TW80cmtrWmRjc0RzNzgyVFFaMVo1OGVHSTFhL1pHbkNnTXNBU0F4WnY3bnFl?=
 =?utf-8?Q?BgnreuxVuQipLmA1oT8e?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5f4197-2b2c-42ff-6167-08dd1a42a06e
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4528.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 00:19:22.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB10640


On 2024/12/12 0:32, Christophe JAILLET wrote:
> Le 09/12/2024 à 08:12, Chen Wang a écrit :
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add driver for Sophgo SG2042 MSI interrupt controller.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>
> ...
>
>> +#define SG2042_VECTOR_MIN    64
>> +#define SG2042_VECTOR_MAX    95
>
> ...
>
>> +static struct irq_chip sg2042_msi_middle_irq_chip = {
>
> const?
Yes, I will add this in next version, thanks.
>
>> +    .name            = "SG2042 MSI",
>> +    .irq_ack        = sg2042_msi_irq_ack,
>> +    .irq_mask        = irq_chip_mask_parent,
>> +    .irq_unmask        = irq_chip_unmask_parent,
>> +#ifdef CONFIG_SMP
>> +    .irq_set_affinity    = irq_chip_set_affinity_parent,
>> +#endif
>> +    .irq_compose_msi_msg    = sg2042_msi_irq_compose_msi_msg,
>> +};
>
> ...
>
>> +static int sg2042_msi_probe(struct platform_device *pdev)
>> +{
>> +    struct of_phandle_args args = {};
>> +    struct sg2042_msi_data *data;
>> +    int ret;
>> +
>> +    data = devm_kzalloc(&pdev->dev, sizeof(struct sg2042_msi_data), 
>> GFP_KERNEL);
>> +    if (!data)
>> +        return -ENOMEM;
>> +
>> +    data->reg_clr = devm_platform_ioremap_resource_byname(pdev, "clr");
>> +    if (IS_ERR(data->reg_clr)) {
>> +        dev_err(&pdev->dev, "Failed to map clear register\n");
>> +        return PTR_ERR(data->reg_clr);
>> +    }
>> +
>> +    if (of_property_read_u64(pdev->dev.of_node, 
>> "sophgo,msi-doorbell-addr",
>> +                 &data->doorbell_addr)) {
>> +        dev_err(&pdev->dev, "Unable to parse MSI doorbell addr\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = of_parse_phandle_with_args(pdev->dev.of_node, "msi-ranges",
>> +                     "#interrupt-cells", 0, &args);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Unable to parse MSI vec base\n");
>> +        return ret;
>> +    }
>> +    data->irq_first = (u32)args.args[0];
>> +
>> +    ret = of_property_read_u32_index(pdev->dev.of_node, "msi-ranges",
>> +                     args.args_count + 1, &data->num_irqs);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Unable to parse MSI vec number\n");
>> +        return ret;
>> +    }
>> +
>> +    if (data->irq_first < SG2042_VECTOR_MIN ||
>> +        (data->irq_first + data->num_irqs - 1) > SG2042_VECTOR_MAX) {
>> +        dev_err(&pdev->dev, "msi-ranges is incorrect!\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    mutex_init(&data->msi_map_lock);
>> +
>> +    data->msi_map = bitmap_zalloc(data->num_irqs, GFP_KERNEL);
>
> IIUC, num_irqs is between 0 and (SG2042_VECTOR_MAX - 
> SG2042_VECTOR_MIN) (maybe + or -1).
> So around 32.
>
> Would it make sence to use DECLARE_BITMAP(msi_map, <correct_size>) in 
> sg2042_msi_data to avoid this allocation and an indirection at runtime?

This is also a good choice. I will double check this.

Thanks,

Chen

>
>> +    if (!data->msi_map)
>> +        return -ENOMEM;
>> +
>> +    ret = sg2042_msi_init_domains(data, pdev->dev.of_node);
>> +    if (ret)
>> +        bitmap_free(data->msi_map);
>> +
>> +    return ret;
>> +}
>
> ...
>
> CJ

