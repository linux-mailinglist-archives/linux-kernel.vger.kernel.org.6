Return-Path: <linux-kernel+bounces-408480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 610989C7F55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD0F1F23164
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08CFC8E0;
	Thu, 14 Nov 2024 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IxtMUofi"
Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011031.outbound.protection.outlook.com [52.103.67.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F55A94A;
	Thu, 14 Nov 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543636; cv=fail; b=ugtab35kXNJW7nsCQ2wmzPW1nTdbF65LAQl8mM0eU5yL2gIeYUwkGccepN7ewF0OdAIKIQnffZdpim3+kbHhHneODUqJUGmf2oW9QzCrKG0MuaUOgYxG1xuZY0LZXtAAfRG9AA90AODcUthLtKlWUGjgYvtRLvmlUZbT6583wOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543636; c=relaxed/simple;
	bh=jK/dSZ2F4lEK4QkVAEXL1NM1lPTGsArKhz7t3wg6UX4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RQzu4MrMcV3wurp0uWKQmWLBoLf9B5jIDhe8UxKzwocP11DzNV4NCYcsYf6PWB6igQheTTfqIREBXXAE5fhNgRK+4guf6LtExhdFhO9CCQ10oNFXnjX2RgTm+si0bcxxEcAH9+8Wz3elZFOwDyi3WyI4ADvsj/FBbOJoO6BvO2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IxtMUofi; arc=fail smtp.client-ip=52.103.67.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQBC7A/Jv91XNgv0A2YETLSFU3UFo3LrDRHd9Y//c8qR2GnPzu/4+GAE2vLPJfcQZYQab1s8FWzpsU/FwoYH1Cl2tweMw8MdBw9DbJQeMOZiyBcCRYHBmi2tIRm87EsMIXJe2JeZI2ZSS0Lf/dkP4P+o2k5vbb2H8jb0mZ19WmisS4et9GQvr/DP1lmqMbfwsvzVw7RMDqIwXoJ0BcaJuOJMBKaH9HHSBNKrgbo0SgHm5Ueko+gxV9ZqKgYILo2EWug5kk4yfLUKX2cFt0YfGBuodFbKqU4+S33Ppb5aOUJZ7PvNLfnHwJAV3XfLY/l1O7h36WtJQim3BJQeXR+LSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/BkUPvSyrplt8lfkKG6NAeenLW0g0tWCPgMHWDXbZk=;
 b=U/05X9FVkAulZtXyT3sRs1BV/ecnJNoEbUN184BvX73dDRQZ9f3xmhDiYb31pi1AAd7eN482kzNhHdJQYVDEkKwfe86qBPQxAdwmmCgZQtTwFf3LY28GAUBzJXAF3ZfhdH++1lHr6zWgiwlQHBc3Xxm1BD1CHaJQvpA970jNPfPvA9c9ZvIaa2P6GxOaeB8thVK6yR/gzqPQUZkJ469tgpayYLSmsxsk+362oZETcWjzat4QJXGM78vNuwbpfl9w5yKlB6kOIQllj+HQbUY5JSS9VF314aAlvXiQAgNAoW/4bQF61ts9gJrgcXLqtuBFMn1ZgKrzVfw6NpscazwjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/BkUPvSyrplt8lfkKG6NAeenLW0g0tWCPgMHWDXbZk=;
 b=IxtMUofi07Ug00xKHL3HHy3kvoBZSMte8puEnn/Q8HQdfOn8u6o7wENJBxLJTogP2YTeNpstwd1o6ePOO8/S07cZpYEiwwL4LbLP/f2K0+kmifb6OxRCWjGT4WR+M06l8LSXCVfCPxcL8Sw+PX5CJZ0gMln2ln+6rr5GWQDL6Z94+DxeeP3+yE0vBkLfDVk50zvqEYpy0pje3q3aKN0X9josWIhXLEhpP/VvPl9vhyKPMCVmQIufIiDfbfH90Y5W8DBPYlL2nWedLBgmwBn+L+G2Yy4NR4YDrfzc7J5ZougtORaFvS1C9IvOCs6izBfto2QVD2RiKwwJY2gd9RFkMQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN0P287MB1096.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 00:20:27 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 00:20:27 +0000
Message-ID:
 <MA0P287MB2822B7CFC338C7AED1F0A549FE5B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 14 Nov 2024 08:20:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Thomas Gleixner <tglx@linutronix.de>, Chen Wang <unicornxw@gmail.com>,
 u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 conor+dt@kernel.org, guoren@kernel.org, inochiama@outlook.com,
 krzk+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
 robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <cover.1731296803.git.unicorn_wang@outlook.com>
 <8076fe2af9f2b007a42c986ed193ba50ff674bfa.1731296803.git.unicorn_wang@outlook.com>
 <87cyizmzhf.ffs@tglx>
 <PN1P287MB28185C9DA26A773775BDC4C6FE5A2@PN1P287MB2818.INDP287.PROD.OUTLOOK.COM>
 <87v7wrkv4v.ffs@tglx>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <87v7wrkv4v.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <2496a1b0-b13d-4757-bbd3-a39f2726e933@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN0P287MB1096:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e0cd67-7aad-4838-e417-08dd0442239a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|6090799003|5072599009|19110799003|461199028|8060799006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3RpMGlWa25wQTZ3eFhrNFpsZk43YTdLQW5YSUUwcDFOZzF3anZHa2RSMDRy?=
 =?utf-8?B?Zm9QMUtQaERFVGppMDRQZEN5S1BMbTFzRTgzcVlHWU1mWGlhcnlTY2FPMEdM?=
 =?utf-8?B?eWRzVW5NNmR4MllFbnVndFBGOGNVd2RWcHhxRkE2ZFZWNWlTczBVbnlMaW55?=
 =?utf-8?B?RG1sRk4wWTREa1Y2bXRpRyt1UTUyMWJtdmFpMEVWT3dlcEoycm9BMlhuTGQ5?=
 =?utf-8?B?cDB3WmdkTzBYZld1OUsydlRXL3E4cElFTFVGYmpOWXBvRi91bFFIZHJzNS9p?=
 =?utf-8?B?SGRSNDl2RnF5MHhFbDJNV1g3R29KQzZYbmMzTGhVakN1U3NyZ0p1MjU1bnJC?=
 =?utf-8?B?L0h6ZjV2OWRCOG1SZGkyT1d4RE5CQ0FROFQyNE9adnlnUko0RXprTEFUb2d5?=
 =?utf-8?B?Z0ROYnRNZnpwcDZZNytheDZKTmhHaGVOY0QwVmp3NVlYUzl0VWVzZ0NQRGZR?=
 =?utf-8?B?Y1d4UFJTejBpNUFyZVFJQ0RaWS92QUgyb2ZZN3RscDhtZHc2c0JxKzNxZTBq?=
 =?utf-8?B?UG1VWEdXWjJxNGRCTDBkaVZIWWVLOXdFcjQ3VXJFUmFyZldPc00xNU5kcWJj?=
 =?utf-8?B?ci84L1EvazIzb1hkb0JKSTVwbnBrNVQrT3Z2RGszQ29xc3A4QnA4YWdyS3pG?=
 =?utf-8?B?d0dMV04xaHd0Y2ZvYnNyYU9MRVNWZXRyaHBJR0xhb3lmQ3UzQ1I0L2hZMnlT?=
 =?utf-8?B?ek5qN3BjME9OMVZKampBTlAvSllMZGVuWVAyVTVoSHVyRVNXblFXQjRsaVdu?=
 =?utf-8?B?ck85RllSam1OUE5JdDE2dlRXQ3B6WGFrOGRIUlp6WWpKRUNuQnR0cVRmR2c5?=
 =?utf-8?B?Q0thU0FOMWZ4SFBhSkgvSzZLODNYVVlBVFpGWmpLRHdTS3BqWGpNTm5UVmtZ?=
 =?utf-8?B?MkQyODJiV3FUc1hiYkNMemh5SXVKRTJ6RThpQ1ExZFBJdzJGV214NW9tZGM5?=
 =?utf-8?B?SWNGM3QyVkZ0cnBBeXNERHV3WUxRTFUwV2RaMTZ6YmV4TG8yTnNYTmpxVzl0?=
 =?utf-8?B?TEtWTGNYL09oR2lkcHNNZ3p4WFRlQkx2VERlNkVIZE1HVkZ3TCtqb2xKRXFY?=
 =?utf-8?B?SnFnRi9pV2k5UFFjbnlBc3MweWJwK042QzBBUmJxMkJtZE1OY0wxbG5Qekhu?=
 =?utf-8?B?SmF5Z2FXcmZGMDFKV0Q2WTlJRGF6ZUw1QVVIdTFhTUhsblM5T2xxcHR1N2I2?=
 =?utf-8?B?ekFkcG96UlY4OG1RV2MvcHVBRml1RmZ6SXo0VWg3ZHkxajRlK25EU3diOEhF?=
 =?utf-8?B?Rm1xRWUwS3VDS1FudHNiS2dPOUlpQTBKMUZ2YUJxYmd1MTk3WWxpaTBVT09Z?=
 =?utf-8?B?d3lzQTQyMkZEeTdaRUVhak9xZFM4M1lTczdkUlBvdktvWHNuTXpINXBCUWps?=
 =?utf-8?B?WTIva0MwNFFSZU14cFM4V0VKSmx6NDRRZzhNTU1Oam1TV01CTWdKYzVjM1Nq?=
 =?utf-8?Q?L3SwemHV?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpVQXI1a2dXS0lUVnozSVp0aXlyb0JCUm1Yc0hJSVg0MUc4S1JXMTFQSERO?=
 =?utf-8?B?MnlVa1VpVDVYRHljdVk3V21GWmN0N1g1cTBSRWFGeXk1eHVROU4xemJDTmpM?=
 =?utf-8?B?YnJrcSt2NUprU1llZng4cTVqZkJPM0pqenNPT2hQK3V3ZWhZSW9kanVDNkth?=
 =?utf-8?B?dXRsRnArL1JRVG5oUUdmOVRiUkMyTjd5eVU2eHQrR1JWTG5GZTEzUSs4R1Br?=
 =?utf-8?B?dktOZjJxS3VIZkZhV3hPUC95Mml0SE5sWms2eTl0dWI5MzF3aEx4RjBiRE12?=
 =?utf-8?B?TG9uQzZVeW1WRFJ1V25FUUg2enowaDhXMzVxREM4c2sxcFpYOXdpVkVSazAr?=
 =?utf-8?B?UmpTK09UNVp5cDV4RUFqZmw4VUYraEk3VXBBWUd5STZpTFJONzZWN1pMNytW?=
 =?utf-8?B?TnhoYytTSDUvaktJOHVFcnlUMUd3NmdURVd0V1IxTHBPbXU0eERBQXdhait5?=
 =?utf-8?B?NjJsdlNSYU5RQlVSZWJybFdvRkZOcGVtd1FsZUpMbVZ4aHJ2dElwUk9BS2px?=
 =?utf-8?B?WTNNckRXWVpLWGthWHE5QjhTd0RPR21aRDk4alUrQ3BRSUpJQzdHbkhSQ0ZW?=
 =?utf-8?B?YUhyWk0vZ2xQbmNwSjB4Tk00bmZTc2VSWU02SExXTHBnZUNoREUrQ3k2SWI2?=
 =?utf-8?B?RTZIb09GUnRrT2ZXeG1TZTJXWjRwVU1BVHRXMU1zRWJ4NGF4QU04WnlQM1NH?=
 =?utf-8?B?cFdpZ0JTYWt6TGlPVGVHUzh3S2NialV4OFhLM0ZsalZXdFRqUTVoUnYySEdE?=
 =?utf-8?B?WHdQTWJoYlJnSEF4YXFvWVJ2WnNTV1VMUmxERXBHMkhhejRmZUJGMWxFaHY1?=
 =?utf-8?B?VVFEaVVNalVvSUhicTljNzBaQWN6L3phajFNWVk2TlZ6UTl6U3kxcy8vRE9O?=
 =?utf-8?B?YlNUREcyOERhR2hCZE00Q1hKM0lia3Q5NXU3NnlWMWg0LzRpOWhMa2lHejkx?=
 =?utf-8?B?L0w2Q1hSMkJtRkpMc2hORFVuQktEVkR2NzFrcCsrOUtuZFdoQUpXR3dYSzNp?=
 =?utf-8?B?amdzU1RuRW42WDhEM25aZnVIdGg0NklHSWdFN3I0VEl3NDJhUzR2SXdrWHhm?=
 =?utf-8?B?dzg2SVI1TUtsMWNVclhCVUF2d0NkL2doenBOZnppRkxiUjdIWVhXOHE1MzQz?=
 =?utf-8?B?ejBqTVRtT0xkb291MytsOWh4ZkF6eXZHaGNnbENsNzZ4NVhUbkthS2svemZL?=
 =?utf-8?B?cUZVcUl4NUcvQWlvcklRWVZmZzUvZytDSzIrVjAzSmFhMHBRVUExeVJTVkd2?=
 =?utf-8?B?d29uWDVLRFBKSi9qd3ZKdTNEK2g5dmhkbFdzT3NJaHVOM0tsNFh4Ujc2NWNo?=
 =?utf-8?B?QVg5VzNxNUtvL2tKUnl0cVBnSVFlbmZnSnJ5bm1KZjJlL1I2UmFEZjB2K0hH?=
 =?utf-8?B?eDc0K2oybjRVUjRUR2ZUUVpIbklyYjlISHBCSXFUMWMzRFZwekxrS2dsNXJB?=
 =?utf-8?B?QUdMbjRBYzFHdmViQW0rU3ovaVo1ZGFyWmlzeDJ6RWVxV3hsVWdnZDBxYmNW?=
 =?utf-8?B?T09ibU15SituL1Z6WUlIcTdScGxhdHBEQkpZNGVieWlSM1U5T1MxbGVabHFI?=
 =?utf-8?B?UXNMVy80Z1czem9GbHFsOUNVUnRqRVBLanhhakJ1Y0pOSHBkN1JYSmx4Wnpk?=
 =?utf-8?B?WmxPWXROMDhUQ2l2TjlXcU9DbFRMV3ZkR1VZUTlOYW1ZY1hHcWR3TVlGOFZ5?=
 =?utf-8?Q?K2HNwNXyU8nUQD42/PAu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e0cd67-7aad-4838-e417-08dd0442239a
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 00:20:27.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1096


On 2024/11/13 23:31, Thomas Gleixner wrote:
> On Wed, Nov 13 2024 at 14:43, Chen Wang wrote:
>> On 2024/11/13 14:14, Thomas Gleixner wrote:
>>>> +
>>>> +	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, priv->num_irqs,
>>>> +						    fwnode,
>>>> +						    &pch_msi_middle_domain_ops,
>>>> +						    priv);
>>> So now you have created a domain. How is that supposed to be used by the
>>> PCI layer?
>> Here I create the domain and attached it to the fwnode. In PCI driver,
>> it can set this msi controller as its ""interrupt-parent" and find the
>> domain attached as below:
>>
>> static int pcie_probe(struct platform_device *pdev)
>> {
>>       struct device *dev = &pdev->dev;
>>       parent_node = of_irq_find_parent(dev->of_node);
>>       parent_domain = irq_find_host(parent_node);
>>       ...
>> }
> I assume you then want to create a global PCI/MSI domain via
> pci_msi_create_irq_domain(), right?
Yes, I am writing another pcie driver, which will call 
pci_msi_create_irq_domain() to create a child domain of this middle_domain.
>
> That's not the preferred way to do that. Any new implementation should
> use the MSI parent model, where each PCI device creates it's own per
> device MSI domain with the MSI interrupt controller as parent
> domain.
>
> There is a library with helper functions, irq-msi-lib.[ch]. See
> gicv2m_allocate_domains() or pch_msi_init_domains() for reference.

Thanks, I will check this out.

Regards,

Chen

>
> Thanks
>
>          tglx

