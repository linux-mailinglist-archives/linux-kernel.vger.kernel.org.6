Return-Path: <linux-kernel+bounces-287343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C946A9526B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 02:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4651B1F22828
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 00:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16CD18D62C;
	Thu, 15 Aug 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l+QyjyW8"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2013.outbound.protection.outlook.com [40.92.103.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A186F2E6
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 00:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680608; cv=fail; b=I/c7oKMVvv+c7OR2K2abJFiyL5y+jCGn8/52ROkhwcd9PqRlWFGWA4p0ovj9voM7VIPQCV1eBM9DBaaT1ddhIrQFgvzWb7IuvTsegQaNATGWQRvFoMUXnedfEtpPvDvbn4SlWW94qxcYbCQRCuwsgxz2S3p0h/RPJk5Y8XFzwZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680608; c=relaxed/simple;
	bh=G1LrIettfPGbaJZ2rxdMSWvQcyy+YTVCktaV2odHEPc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ic6+3BoduVw0tGsqfNacjvhAxwgm/d3fQejkWGv6UxZGj6I02OH4AocV4SqEI9YmZQv0qyuWVRlXBxuU5+wUJDauUUFcXkhHw4HbaZejoeBaOjHle0Puk4lAqPymo2HkH9Bhvr/+As9Uu33ILKlFMPhf4wNuWPbqJzd5HWtISiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l+QyjyW8; arc=fail smtp.client-ip=40.92.103.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqeV3zNuZGjEbl9mMl6edkMl3zkr4kh/LyScvbKtw7mm8l5iakN2rUZYPDg6wVawc77J2AXBrzNN6z3nfvLhALwIIBoQlKliaaLhsBVZhn02zW9/o0VOooTxCNI8ccqKx7eyCsq6ILXW6yhkTZwlcgIlS60xUWiTahCOrwqFZtj8SpiHgc8fEhK2F9fX1HIoYkv1ZNu1hr6lt3dMDZQbNpDtJGBUVxnZwJ5iYZAfKGj2gYXCK1kp1RbSZ7/sfuTnx+hyusw+XI3P26f6/Bo3yTtif2ovCV9sZfj6KfDHAyUwXD1mpFOYj16vPLzyxR7pcRRDs+uwUagkI/2UPYJ3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTDXUA/mAedWXhR5N/JhEyxOXhEDKKJa2nqY2tONm88=;
 b=w/L1a0gCI8krQplvNY3v5GcEVU9JAoXIJAZ/fUbrKUzlbfPKtlSkwO3nOgWIocEzULwt9ywtT19P46zREJDQIflznen7kMOZqLv3BQfl0YXAnolWxof+WJYGQTrJ2utkdgEHnNLUObwIo0N+I0GCfGPvacmidi89UjKlTc8UM4N3tnS7WPlZetvI71eHebAOCwg3B7uMd/PTtjKHi/0FKk8ZiJJOKFhWc4YpNlSknxoZD+Ce0nG7liSx+3yX07XRpcCBZcKrRXPVlWO3y1eHZoDtnBSHdIOzEt5dx46mGiDruNdVajatPaNNHGkeT18l18Hr+SMkdZptnAuBPQNdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTDXUA/mAedWXhR5N/JhEyxOXhEDKKJa2nqY2tONm88=;
 b=l+QyjyW8Vo5hI3fAyyAW0DL0Ci2y0skJoyiU+A4gAkpZc0hFIhWUmhdGthnofE69bGyw/pQh9LH2+DNdO0EKJjJCZyouZyD6LNcpJpGFqJ9xC+H5GdVXONr+DoFrSA13BTZ4lzKeRCJVBcQS8lvNCG2m5fbjeNV0BuF0b9zl2B0/wkw1TWf0cOeurERCGxF0d6xQuVs7RntUfDWjdkuzeBuIi8cSENjyCnGmi2hqol29PKMZXQNDmtxjKhoUvUf7dibCL3oKL9Fs8DsJMxNS1pS1yvGBbJIV4mBh8/cx4tj8EfWjAWxEzhaj87tOXAKe3kBM3KMsxlkC0AejbEi5Xw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB1739.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Thu, 15 Aug
 2024 00:09:53 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 00:09:53 +0000
Message-ID:
 <MA0P287MB28220A185F2EC2E4E86479ABFE802@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 15 Aug 2024 08:09:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: defconfig: sophgo: enable clks for sg2042
From: Chen Wang <unicorn_wang@outlook.com>
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Chen Wang <unicornxw@gmail.com>, paul.walmsley@sifive.com,
 aou@eecs.berkeley.edu, inochiama@outlook.com, conor.dooley@microchip.com,
 guoren@kernel.org, emil.renner.berthing@canonical.com,
 apatel@ventanamicro.com, hal.feng@starfivetech.com, dfustini@baylibre.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, haijiao.liu@sophgo.com,
 xiaoguang.xing@sophgo.com
References: <20240805023320.1287061-1-unicornxw@gmail.com>
 <MA0P287MB28229593FA53BF75C625B468FEBA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB28229593FA53BF75C625B468FEBA2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [l98F+scGuG9+dVuar1Kxm4LHNVU/T99F]
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0f93bcac-8126-4de9-9913-93909c5d45ea@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB1739:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc071fc-7224-4cde-1dcb-08dcbcbe9664
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799003|5072599009|19110799003|8060799006|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	r00DrKNbiWnNNIEvXiJUo4vZFrrkFJyydpmmIPtnLiOTvEEa+isXwTDV3savODSaCYuzZYmeZYInFS3fYstRmMfVCRowb+KPjmyonMmlMYOkX6IzA5gsb0FmCNFnOfvhO9RbDhnncT2CKia05RLVxTFTIgpSzBChtYM94qocfwPdG/n53bx9CMFXfwWBQ9ByWDuCXKlOBvvG0xTYYAc2//eP88e6htQ0Z8U8XilVwF4xX9mCEbacUe9wQsw/teX5CefTeYLXmc/3rjMbuKMqGJ5Z8AbXOsx/bz6D2X1kOQ7zzMcpt7aNklie+bsutkX92OKSfE3xB24GuDgiroRTEJiOgQ14jkgea/pRyJwS5d1/D9RDaARMXm4+KrRGxUI24s7BERzu70zT6q8mqZFuyq8hDtUugP8sLKQdLrslheGN5Tyb++BKf3gIjx6EtUE6+o5dQSqEk+ToeRpfC/I3WD591cqt9t4HRq5NHt/FoZ9F3UB0/K2D59HaHRoSLZSry17byZueEcL/vLmgK68KDrfEjW0y8Z2YfSPz4omFB/Ma4sqR9Dv58myGXPQmD+UGDLo5WvecsOE6I+vmRZlMXXWL72lsaVoPTLNMLcaTOpQ+Fc0o2wg6NnvT7oByCDGAVl3SkoxaJ5kg4k3UxkyNjHiQCZooNMLUw8H0ZrUEHnQMnJdohGW9wLC4pQ2u3IQ/a15h3qx4F8pfbRCkixA0V1MvuKOtz3ZdJZ47XB4f+z3+v7VeL3t/nQjAJYn/2EJpulvTMTn+OwtfDGRC1nH35JRLtHWyxXjnhWPszad5liqgBZ/CTvKKTYmOx6HBgqeG/tAnGWvAT4ZVsfXcv5Jg6/lJI09RVPWX7ITenRFbwqfJoE/Sbgy7v588DjkInHlJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJOQ1hrK2VESW5kLzF2TWZFc0RxZTMzMHIzMDhmS3E4NXIvcm9LN2hnMUNE?=
 =?utf-8?B?ei9OUkRZMTF4ZUF6M3pxYVlJOU1XNWljY3R0TTNnYk9WRjBMVXlyTUs0c09m?=
 =?utf-8?B?NU5PenhMUWsxdk9MWXhzUzh1TzRDT0hwemZHWVJEemhqR1FDRkd2QW9nT3ov?=
 =?utf-8?B?UkhZTk1QOU1xTWdZNm1Qa2l0YXhQM0VtVEFIWkdUKzZETjVoVlZKN1lTbTY3?=
 =?utf-8?B?M3puMDkrbjZTUHhaRERRWVl0VHVjMkpVdHN3OHJIL0JZaVVqRHJzZjIwYkVK?=
 =?utf-8?B?czZyNWNVVm1BV1NaRkNabkFmdEl5Q3VLOXBUNzhldm8yUXF2WlJsV0J0VmxW?=
 =?utf-8?B?bWJtcXNFbThNODA0TFg4NHduSjBTbVoxQjcyTEo0TkdFM2VmMWNaUTJZa3kw?=
 =?utf-8?B?eEpHRFFWM0x0V2pGdmFWQUJ2M1JZaTZhRUlGaldWWFMzM2lLdVZJb0ZTNkE0?=
 =?utf-8?B?QXlqZUR5Q2dMemFucEFMMGVRaDhnMUM0OUg0b1RnMkUxc1JaMzlLOTBXSmpu?=
 =?utf-8?B?UUczRXZPZnN1VjlYdm5rTis4eHBJbUkwRklSMWVRZ2NxV2pNT2s2WVRzc2xE?=
 =?utf-8?B?aHNzZm9zVUIrZGhCUEpxUXdBRjdpSUtnSXk0OEZGU2Qvcm9TcTBWa2Q2cjg2?=
 =?utf-8?B?c2h4OUFDNC9BUlRXWmJ3R054MXNmejlXTnRaMlM4VjhKM0o5ZkpsZVRTcGRR?=
 =?utf-8?B?b1h0K3pvNzlWT0U3b05vVDNJZkNub0xJbEdETlEvME1yZ0NjNnh2dXNVdHZ3?=
 =?utf-8?B?ak4zYmdKcm11Zk9RVDh6dERGZEVFMDljOEQzR3VDSGVBL3BHNkpVWENCakRG?=
 =?utf-8?B?YWVESGMybyswcm9lcjJqenRMMkgybHBZYUN5ZERlSzdjaytPcjJNVVQwZWRG?=
 =?utf-8?B?U2ZmNVIrekhVN2RGUW1uSWUzYkVRbnhveXpWeG9aN3M1ZVh0dEJTTFhmbVFu?=
 =?utf-8?B?Q2pPYzZhMGFha05HVEd6dm8xdk5lUDlQbmg2M09qek9xTmRsazZGd1JIQWJT?=
 =?utf-8?B?Q2NqT0ZQVjlVR2ZRS2J1THhNVUR4NzVJNUVRNkF3N2N3Qi9uNndBZVJ1VHMw?=
 =?utf-8?B?b0NrT1VJaE10ZC9SSnlubGRET2tLdlhSZVdPaFBTN1puTFlRZXA4WEFSYlVL?=
 =?utf-8?B?ZkhhVGw2TmtyaFpHUmNtSWhlcFBzMGM4aFNKN0Q4bUVWZ2JUaHUrUkFPY0o1?=
 =?utf-8?B?Z2ZnVmtHSWk0U05xYXdMMVBVTFVBbzAvQVZtS2JENmRjWDVrQTNIWHh0OENZ?=
 =?utf-8?B?RVFPdFBmUkdROEFaL2xaaXlFTXA2V2N4NFh3SnJhUDhYeEV5eUlEekJLY0pT?=
 =?utf-8?B?dVFjcUEvRzJQWXNzYjZWNUFJRytOQytLSDkzZGhmRk9PMTVEcEYrb0NmRitx?=
 =?utf-8?B?NnBZOHlMdEhQZ05xamZncUJNaml2N3JrRzQ4YjFGSTZ4VENLNEtVT1JpQnR2?=
 =?utf-8?B?OE1yczEyYnhRdVVSU3dMSjRPRzVVNklGNHBpc2dLa1R5ZUtxSE9CRWhNZXNR?=
 =?utf-8?B?d3ZxRVZ4NlljZ1dUYUhTRllTVVhuT25zQzZlMGdySVhuN1NaUEI5bW4ydEZ6?=
 =?utf-8?B?Um8vZWM3OHk1enZQYVNnajVxYkVSZDFVMEpQN2pDR3lHWFJaYm1YL0F5d2c2?=
 =?utf-8?B?cjNmK05CeCtFSHozTGZKMkxhK1VhNjFSaVh2ZHpxSmpUclBCRG81cWJNR1hm?=
 =?utf-8?Q?+nZG5Vwy17jQeth78nou?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc071fc-7224-4cde-1dcb-08dcbcbe9664
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:09:53.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB1739

Hi, Palmer,

Could you please pick this into riscv/for-next?

Thanks,

Chen

On 2024/8/9 14:26, Chen Wang wrote:
>
> On 2024/8/5 10:33, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Enable clk generators for sg2042 due to many peripherals rely on
>> these clocks.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   arch/riscv/configs/defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
>> index 0d678325444f..d43a028909e5 100644
>> --- a/arch/riscv/configs/defconfig
>> +++ b/arch/riscv/configs/defconfig
>> @@ -249,6 +249,9 @@ CONFIG_VIRTIO_BALLOON=y
>>   CONFIG_VIRTIO_INPUT=y
>>   CONFIG_VIRTIO_MMIO=y
>>   CONFIG_CLK_SOPHGO_CV1800=y
>> +CONFIG_CLK_SOPHGO_SG2042_PLL=y
>> +CONFIG_CLK_SOPHGO_SG2042_CLKGEN=y
>> +CONFIG_CLK_SOPHGO_SG2042_RPGATE=y
>>   CONFIG_SUN8I_DE2_CCU=m
>>   CONFIG_RENESAS_OSTM=y
>>   CONFIG_SUN50I_IOMMU=y
>>
>> base-commit: de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed
>
> Hi，Palmer,
>
> Could you please have a look on this patch and pick it for next tree? 
> These clk drivers are required for sg2042 to boot into minimal console.
>
> Thanks,
>
> Chen
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

