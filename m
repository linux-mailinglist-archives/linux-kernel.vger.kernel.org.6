Return-Path: <linux-kernel+bounces-515985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76937A36BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 04:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1BC18961E6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 03:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B462978F4B;
	Sat, 15 Feb 2025 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ld8EM/0n"
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010003.outbound.protection.outlook.com [52.103.68.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C8213CA93;
	Sat, 15 Feb 2025 03:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739590595; cv=fail; b=aVw9j8nFWNlUQ5jy44jkQhlPuaLkSo341MIMIVqSPMiPqpVgwM5pTfzRIPrGqIGDTgCOOzaPYNM1IWRwVGad1300LCM7Q3XV26vIGY0IvwQN2dbTv8ymoGHpkQJMeH7Hchx+na5juwDfoSmimAfcY0qXox1dAxzS7y7KsYKYhPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739590595; c=relaxed/simple;
	bh=9c8xJCLU6r1qUyuaKl5G4Bv/MxUinw2x8FmM2d4Xpw0=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GywuM2ysFG+jsksJfGJj1dP6a3BpukTk0OM4tlsHFzOM8qd8N+B3muy08U0WEIoNoqI3Bjuo12QztIoURERFHwQp912hYW+Y9yhFGvP7fQ07fbocG/aczA1q6FUsRenW/kq/6qFKyTxouHvRTL5Q6y+F4wJmwhit7ggR1cCZkTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ld8EM/0n; arc=fail smtp.client-ip=52.103.68.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+e+iM30vWNuX4q0Syoy91ZBoSF+s+d9SP9ImT8mvjwLLxehVrnDWsgWZuGkgLj0QRgUgLFKrpCqU6XLevmlMf1eRP1firbA6Srg5kTFzKbHqfZrLYqiwKO8fVOmFst3KbHxgqjzOguwjD8SEdmpeocFGIuaXCoxt4VhO0AMxbDJx8znRsRloXZGD+Dxzu6YseSX2zOXW4lyWhvZx5owcK5epg33OafJf06a+ShsN+yxOdB6aoSasvJUpPGeZOVNu7SUuNR57OKN37T0IeoRlqSlTf/Oujk8aFY1YrdoGw1D8Xbdbu9pINgd76sB0+yRmz1JkcBSd6S7bPiJLko8YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7oObg47Zwe4DptfKpfAC33aXHqv7Gf6c0ZqQSHML0Y=;
 b=g6n/A+/QeE+FY2cOFE0Fa/tM9aIBF1uDwejjdb6uKsyUejUsUe8mqYuTd2H7O1jWYq4BWXuaUIjaiSN+Sb54aAFDoMeJzNJ4Qh+tVVkhP/CjzFfNQk3v8YClzr7w91u/HlMGaRt7wBG6q0XUlDpm0PyC1bDZ7Fk7F457sY+tN2zvKS5273HcOfEcOlRDshj7hHjoK/n3JiBoY/1WM0MK50B/UyFjuwvhTbG5esdmlwhAPXldwvBdpQAeGxi4Hkr2ttogMOnIb49TfZivh5/78dMFSXz0uLQG38ibcamC5mV4ZKuO6THBW7VK9Cgy9mNSDDhA6rGdJRaZePqkEYXZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7oObg47Zwe4DptfKpfAC33aXHqv7Gf6c0ZqQSHML0Y=;
 b=ld8EM/0nmbG6ig1gtA18C4Y3j3gvyQvMf7+uWdzwQk1m+I6Scv51K2a5Wyi2JoC0tZSJXx5P5/FCjiVW15910RPdsm785btXHJQivHe6Z4U9dsuPCzPebmlLr7OhWGOrTJL84+aweo5rT2EqeZcZ9H8PzZkkSnElKb7xwbmA+BJkxILOpMMi0CXiBPAZoP+WLF8DR2SeakynlGa1Emv2ZPXEYkHgwyUrI1mYaUYGC9fXm9anPK0gy8CvTarQGTgqw1wTqvwOG9qYpRmlv0nxNzAIjWN6dLN10AH4i4CBPUeW+4eIP4V66YGewJlEh3YX6e5u113FJp6gd3t7O1K7Ew==
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6e::9)
 by PN0PR01MB5971.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:67::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sat, 15 Feb
 2025 03:36:25 +0000
Received: from MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee]) by MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::6e06:bc2e:85c0:c2ee%2]) with mapi id 15.20.8445.017; Sat, 15 Feb 2025
 03:36:25 +0000
Message-ID:
 <MA0PR01MB5671D5D25616BABA0E7F60F4FEF92@MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 15 Feb 2025 11:36:18 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] irqchip: Add the Sophgo SG2042 MSI interrupt
 controller
To: Inochi Amaoto <inochiama@gmail.com>
References: <cover.1736921549.git.unicorn_wang@outlook.com>
 <b5c2f13aa94f68c3415a1292678e16db33f291cd.1736921549.git.unicorn_wang@outlook.com>
 <dh645pyvtylcxjcjjcdl7xttpp4qmtjouapifaql4lniab3qjo@lqmwytf5q35c>
Cc: Chen Wang <unicornxw@gmail.com>, u.kleine-koenig@baylibre.com,
 aou@eecs.berkeley.edu, arnd@arndb.de, conor+dt@kernel.org,
 guoren@kernel.org, inochiama@outlook.com, krzk+dt@kernel.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org,
 tglx@linutronix.de, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com,
 samuel.holland@sifive.com, christophe.jaillet@wanadoo.fr
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <dh645pyvtylcxjcjjcdl7xttpp4qmtjouapifaql4lniab3qjo@lqmwytf5q35c>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:6e::9)
X-Microsoft-Original-Message-ID:
 <489db8ba-491c-4c13-a6dd-02c607a980d4@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0PR01MB5671:EE_|PN0PR01MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: 8703d8e1-42a7-443f-89b6-08dd4d71ec30
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|8060799006|5072599009|7092599003|461199028|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEhVaUdLR0sxUk5uNzQxSE40ME1yR21RUnd5ZWtCTC9yYjZuVHgvSXFZcVRK?=
 =?utf-8?B?Tm82cWRvZ2VQaEJEeFo1RHdwb0l6dmtDOVZyOUZmK2tTbnRJSGlKODdVeFg4?=
 =?utf-8?B?RlpCMGVSNXY2US9hRW5DdW9mZVZhZDI3R1pXUTlteVVtVDVwWExUNXhmeVFW?=
 =?utf-8?B?ZXpLaS9wWkF5TjFQUUhYTjdadHJxcCszZzA1ODRRU2xnalV3emRHdUU2V0xn?=
 =?utf-8?B?VFFTRHdVRUpvNDlEdHc2c0JOV2xza1orL3NsNjNtMS9DSUtueHdZdXlvOG9P?=
 =?utf-8?B?Wjd3MERZT2ExaXQ2QXd4RDlFL3Jxa2NHbkpwRlhnemFicmc3VFY0dVk5NjJG?=
 =?utf-8?B?TlZmcDcydVdIODZNMlJNNDZ0ZG4rd3IydkxTYVZ5bEZpdWdGZjduSUVjMGk5?=
 =?utf-8?B?bXpHaE9jMkxlTTVqK01SdkJGNE9aLytub25WN1dhNlg2TTBnajQrdzAveWhl?=
 =?utf-8?B?c1VGd2xHbFJ1ZzM5Q2Z3aUkrVEpwaFhoNW9CV0lWUnlNZ1g0cUVxVW1iYlNr?=
 =?utf-8?B?Q3VZUkt0MVZpQXhnWkNjbXVLWGc4YVArQUVoamVCa3VSd0FWTElXS21NRzVp?=
 =?utf-8?B?Q1lyTGt0aE1ERTgyVVM0d25xT2k1aTVJRnN1K1pCRnlMakt1YW9oM3RVSkxE?=
 =?utf-8?B?dTlNVEg4MjNkZm9JaXBlVWhEd2pTeFYxbXMxR1FlRmFGNytKVENWOGhyeUll?=
 =?utf-8?B?U2lsTFhyR1V0SGZPY29HWGxCM05mbmxweGZpQUQ5MS9GRnNSOE9xVUtLNE1M?=
 =?utf-8?B?OTJyemNtQjRWU3ROdnQwcWJZMDdBUkhHYlloL3c2RGs3Q0p6TDMzc2xJUWZx?=
 =?utf-8?B?Qnd3L3l3dGwrSlNPVGt3RVVYcjg5bWNuTHh0V3R2TEprWVNSQzh5YmN1K091?=
 =?utf-8?B?a3UvaXBFNnE1RFdXcGh6Tis2VlA2aUc2TmlsbEorYm5oNE9pQTc3d292ZXhX?=
 =?utf-8?B?QXBGclFuaWxsUTg1emhwNyt3TkVyRTdPUWpCVUthMHdyTXRQREY2blVKY09T?=
 =?utf-8?B?VmJEbzZOL25USzF1WUU3Y2ZCbWc2c0JZQnIxbXBadDJ2ZEYzT1ZXTGVkNUhi?=
 =?utf-8?B?ams1ZlZjT203b3FtU2d6K1puNHVlUmV2S3U2SU9naGlXb0JMMjJienVUbVk4?=
 =?utf-8?B?SVRKNXVnMW5sbXkxeFd3eTNwUnQ1eFQ3NFZCVlR1NUlTaWdxcEo1VFNOVE0w?=
 =?utf-8?B?eE9vRkhkalJaU1ZvdTRiamR3VzJ6Q1NZTHpGTnBzVjJQZzJ1ZFJTNXRka0ZE?=
 =?utf-8?B?N3M3eUpHNDdPN0dxQkcwVVcxL0I3SldGc0FTa2tMRmVmZXl5eTd1RHEzK1E2?=
 =?utf-8?B?bEVrbU1ZTVIyZlZGSFRSbkN4enZxZDFEQyt1UFlXemt2YUhGUzZsWG16VURI?=
 =?utf-8?B?SExjS01ibk9BVVpwRUoxUnA0bytsSkdpWnZLVDhYYkVpazlHS3EveG5oYVF6?=
 =?utf-8?B?SmV5RlpBVzNsVG42VzBJS2RVazNJc2drNHk5bVpPMkV5dCt2YmxCK1gxQnQx?=
 =?utf-8?Q?WFXXkI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFISVlwZ2ZDTGtTeEpTOWc0M2xwcG9NVHBPZWFoMWZ4cm9rbGpaeDFZRzBv?=
 =?utf-8?B?eTd6MGFuempETEp1c0czZmlmTWJCYlJEbmJiSHJ2cXJTKytmR0R1OFMwUmdm?=
 =?utf-8?B?SWtNZlZmNHplQkd2UkZJeHNEcnFZMERpdkVjNXFRT28yQisxSkpJTS8vTGQx?=
 =?utf-8?B?cEZLWlI4RmVkbTJQUDdMWUxOYkVaRGxFTk0rcVRoakIrNzRHUWdXT3hKQmdP?=
 =?utf-8?B?c0NBQlhxbnhBdUZobG1Jd1ZFREVXUVpVcWcxOEJEMDBQWFVpTHRqQlV6R2Ux?=
 =?utf-8?B?RW9hV3BNSXNWVGlZdFF2bjQwbklPVDZPK1g2NHJMVk91OGVMQ28yRWhISnJO?=
 =?utf-8?B?Q0RCOEt6UFlURXJ1aXB6UGZsQ040VEU4aDlDTy9jQjlvWHd1SytRWDA2RE52?=
 =?utf-8?B?TkZHMnBmcTNIOENuK042bU5jVksyOCtlZ3Y5TU1JMFZFTkttRjc5M1RPR3lh?=
 =?utf-8?B?MU9BSXZiYWtCMDNLUytWOEhmSWR3eTNhcVFyV3UwbFVXR2VyQnFyRDZ0Qld1?=
 =?utf-8?B?S0pIQVNhdHVXZG5OQVIxbUFxL2lHNUl5WlZTVnFXZ1FyVjFtTUczUHZGMGM5?=
 =?utf-8?B?eUFiVy9IT3hFcWRXdm1ST2t0Tkw5WWxrVDVSeXJ0TzY3eTlJYngxRWFRbGpI?=
 =?utf-8?B?QmIwN2JodEt2Tml6UjFheVpYNG9SVGdlZnNCTFNON2hOaUtPZWVCbVNyWnpw?=
 =?utf-8?B?RkJrYTUvbjgxbUs0V2RpcXRSR1VNNW9hZzBRNSs2TlVNTUNvL3JOZWdYakNU?=
 =?utf-8?B?SzdpdDN6WTFmWXRYUzNPUnZDWFhKNlJKVTRFQXN0bHN1UFdVVms2UXZGRi9v?=
 =?utf-8?B?TGRQQmRGNjVLemt6WGtBbEVRRFluVG91SjVzUWNQcFRLSWNNdEtjY1NpdDBp?=
 =?utf-8?B?ZVJuQjd2OHFoR2ZTU0pYQjgxQ3NtR1hmSnZGZFZTK2w4L2FxZlVuYVhhSFF5?=
 =?utf-8?B?UnoxelNLVVRmZWdaTWdvTmZ2S0puYVZwNWQ5TTJ2TlYyQ3A5VzVEWVdad1gy?=
 =?utf-8?B?dy83T0t6dC80N1hkS2tocUxid0FaUGpIU295M1lNNXJKYWRSanhtUXRhZDk5?=
 =?utf-8?B?UEtOVE14eCtOaTFyM2cwYUZPQ2NhQ09tVk92ejZmY25yWnQ2YTgzQTMwSUtk?=
 =?utf-8?B?YkYrY3YyOWFvSG52bzVaMEJxTExSRVg0SUZDNjVKZWwyOWRVTHh4NkVBclNV?=
 =?utf-8?B?dGxEZUVXalY0cXdxeGFBRG9CQVkydTgrYjRZMTRvTTB5eTNyQ1dmd0hrd2RQ?=
 =?utf-8?B?eXR3YnNDVkFmZGwvSUVwbUVDblVnbktKL2ZRRUIrMEZyUmxtN2Z2ajNWbWt1?=
 =?utf-8?B?NXRWVzFnb3JZQnpRNzEwSWZqcXY0azJLZlk1blRiVzc3djZyT2kxcG1iWlor?=
 =?utf-8?B?dUwvd3JrbjRBblJ1U2JRSEgzNUpDRkp2UlF0alc4MEhjRlVXRXpoTFljdXk0?=
 =?utf-8?B?OHdBei82TGdZc3NSRnF0VFpSbUlvT25vNWhSWFZHNzhGSnphei9tMnJYdktI?=
 =?utf-8?B?RVBFeXM2SCtaZkFDNE92aUZiQm5XeE9ScDVEZlZJc1FEdURVUW1oSWxOL2x2?=
 =?utf-8?B?TWEvVURhUU1RZ3VvMWVJSzUzaUE0U0M3WDZ6TUZRZy9PeEVYZllIRXRsNWdJ?=
 =?utf-8?B?RlM4eFp4czR1Sm00NnpyZGNJSVpFYjVLUHJXeVYxTkw5WjAvV1dmNy8zWTRr?=
 =?utf-8?B?cEtIamxCeStSR0lHSFExOG1rTHRnd0FzWW1BVUhDdjUxUEc0aitTaTNZSTJZ?=
 =?utf-8?Q?qgMYWZrRUUAdBcO5CJ/AIFmNlTaqk/4Texn0MI3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8703d8e1-42a7-443f-89b6-08dd4d71ec30
X-MS-Exchange-CrossTenant-AuthSource: MA0PR01MB5671.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2025 03:36:24.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB5971


On 2025/2/15 9:09, Inochi Amaoto wrote:
> On Wed, Jan 15, 2025 at 02:33:45PM +0800, Chen Wang wrote:
[......]
>> +	middle_domain = irq_domain_create_hierarchy(plic_domain, 0, data->num_irqs,
>> +						    fwnode,
>> +						    &sg2042_msi_middle_domain_ops,
>> +						    data);
> Use irq_domain_create_hierarchy

What's the difference?

[......]



