Return-Path: <linux-kernel+bounces-315287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C73296C071
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C931C251CC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601401DB93C;
	Wed,  4 Sep 2024 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="g5Puya6G"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010012.outbound.protection.outlook.com [52.103.66.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF601D88D0
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725460159; cv=fail; b=n6R2K3qhw0ApjryHStdljMm9xPFil6WlZ5rx1eB0woRfNJN0fgdwLRFMDnHISt1w5H517OtKUM1FwUZHAcKjr0bsTGp/EBtGnQxENTmMACalrzbW0oMhRFD8NRlavNWCwMGKE4fOjFOuwqWyD9Og8S4Av418YadKNvmS0NRxPSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725460159; c=relaxed/simple;
	bh=Wn7SaFJkR7t4V0OhpCQK8E9/IX6D1h3qz6y8fv9Swlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gFOct85Rou1toZT9o7waxsmE9LdKfBVeFaUu7tHGeOGlN5eqTeDOSQwwFKzcBGcZAg/uB0WNGWjOWXrkf5LzlCIVjVucigaXFbW/GmQmdXOnAputkbiPvd4BNItS/wYUW8ckf2Q17YQBDhlzQKf3+5AJGtA/jj2zpF0iIU4Ff3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=g5Puya6G; arc=fail smtp.client-ip=52.103.66.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X95k98e2tgSeiMYq7Xl76lzHyc+rLjyddUo9VDN6I9SQCc6i2w+0rp8rl31LboMcmOitxA6vZn+d+f20yE3/QYzGJ8phhW8vuzmdhmdamRyiiLzAC+gXjBidgF7WzGUkn6Lqj11BIGEKiWN14h4ND/hrALXJhCbnCpNP05vwcojzcuCs2dQPT0i1A2cIQFyFaOYTKB0dUUMvr7kMzV5ge7+RDQuEr/BCTWUyss+WSq7UwG122/ViWaDigKBAX+u3pVe7TVYeGsuPIdM+Vy9hiYamnTnFmPbDSJNnjSCEa3D3CS8cx2/EeVFXFTUfEKm1PB6f+x9faf5a4LvQhEXOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzEtR+UnVptGRns0Q9DZmZ5Xvo7QuVJ0Sk/h1dcj6XE=;
 b=d0Bh1cM5MdSyBQM/Pp7pF053BDCmi82xYEqjafxixBEB4WkuAsUanHzWlioWqmxuxSb7EljRtsvD8P53ZkXnGnySKu0hGwZ0u+AMzXpLoEx3bnoM8zi2H0bcQVleqWjEXeiYYDfFSmRgHVsooEr0NKAOlWDxwSNog5IygQUdp5fx9e51upAjr34U/oq+CQlrSS/5xtdYtDIPYcMTP9uNye8JkzZ1SS6+/hLrGlQfndZ8tMrwr8VzajOZZXCDOowBzivw9UUc2cOQzmxS04wT+wvlfrkkzFh0bDyyy9XeePQlasayVmrodhJWrFp65B9CZnXboXkakovMyUrOF67Smg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzEtR+UnVptGRns0Q9DZmZ5Xvo7QuVJ0Sk/h1dcj6XE=;
 b=g5Puya6GhLk3yVXx+2Ny4cme66h1unG1QBGxhEPqIosKSbAUZFzQ68GHAKFsaD/JR2UZ+UaR4CGquXyqR4wF2qCzWhSe2qpkhFAyE5BS9kfqZFH9kx06EkOnhubtWHUUJX6vKKdzHdpvTnhymKHPRo1/J1/rxRuD69cvM6Jdej9SCXUGFhh1LOeUWhDCs9A93XlhGcdOFU8EcDzyFD3pMZYm7PCNkcanXhu0DvW8uWMLY/mBcY1a8ylY4HjPGFi8O61OxXKVAWjqaMgyKJm/OH03e0i6lFJ5IceeTcYkwB+RIkxTGO9T+8Zl0fbXvijAjNJl1sCdrXwYKYjkGX/yYg==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by OS0PR01MB5524.jpnprd01.prod.outlook.com (2603:1096:604:a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 14:29:15 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%2]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:29:14 +0000
Date: Wed, 4 Sep 2024 22:29:03 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrYjLdPryElDubaM@smile.fi.intel.com>
X-TMN: [4WPer8m+AN6QQ0oGBnSjNwcz9SC5BVo1bujXgeuA9qjcHvnszsU40gfuL7nd3/ra]
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <Zthur4E1DrOFUZfk@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|OS0PR01MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f4110f-40a5-4ec6-278d-08dcccedf04d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|15080799006|19110799003|8060799006|8022599003|461199028|1602099012|4302099013|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	WkhkDbtvQWWFbrSslTzzY7K2el8AzBHVf5If+va3CL57Mx8JvVy+C5WMPFHzvVui00lT70Vg6ny8GUfDtfzg14Egr3UwIP5SNPW+TrkStd83z3VLFx7MIduDrxy3/DS5V+pKf+RxJKulMESgsniHKSqZO79qs/ZDRwSA4Th1fJI/nW8wUCUwb1Z0Pc2nmxsMltMk4TMkfsrM03PATBofa15+3QsG/xxOI9CB+vyVatTutAjy+dnvJbbThQegf4aV2bqfmfYWMksRqk+1qb70JOdqIDxXC262O+2Qfn3SZCL3MdbVc9kW6iI5ClfADwEV1hWw4IZbAtCVCXl2Pzq5VgtrUs9CAgeXP6FSIpB2adoavNykInZC2IRRB4eg+lZDvpsrTwIIHQqsSHwmPBdcy0QdLrJu0Ng52/3RCKiyx2N2RK1vexKbK1+dDnU7TyDRoJ1G8yiyYW9rQg3qHGpsJUDUJ9o/kCbLTZPqmA6q+h68sfVbx+uJd34kdo4+HoSjUS0PYTjljDSAuBqPTDy98k3rXyj8Dm7XIXcXg6ic44p+QTkmGxwe9Op7ikeTN/PjJsPVCJPz4fdefY681uBSFvhriJetptu6mCf9Rq/5CyQlM24lzKpP5QOI6MR+t0ildGNg5QvbBS1ktBP9j+TLYxYaDFpKGBvKHocXolIZYNkGTK8oUmJAYHF4Tco4GWvY4ui4HxOB9aNfTzeLjWmfzMm1dBo6nNcl639LQ3WV1tKvjhCLHaRGSBPkpWvriIfoAEP++mVz8Lsfr+ialiokMIyoHaQZKN8U2IBiPCmcn9wyjiVJdN1QFjX3KLkNmlaWniUM6m0hzrRy6c9k5VeZhHlSkrr4Wc6VGdrw5Zp4fJn42ZhgRYsXk+xvC/qaipauDIoyXQ+K1jdMN68RXtCTrfihCTCVEFMwF3R/uaSn+HU=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TThsdmdJOXpicHpFSGRYcDFvZDhIdVlPajh5cmVOcjMxZGtxbkpSVzRGaTEr?=
 =?utf-8?B?SFBtZkJEWTZ6SUN3TDErc2wweWs1VHFVWW95VktkSU1hL0tBanBoSDJNM25J?=
 =?utf-8?B?bndCMGlYRDR5a29lVkF3ZFUrRjg5VUdybGR0cnIxN1VzVEpDMWw3dnZLWmZz?=
 =?utf-8?B?NjU4RkJ6SFFOZHduNG9LNDRyTGh0RTErTEYyMXNoUGNremFMQmo1NWJyYXJX?=
 =?utf-8?B?YVZCalBUUGtEMTBjUytIczB2NDRIUkNZcGh3ZSsyT3h5d3BHTUNQZ2x5dmlF?=
 =?utf-8?B?VmFudzVtUkhkR3EvbDM5dlVOQmtwejJ3Tkxzb0hldXJ0cWFoVm9oTnptOGZp?=
 =?utf-8?B?amdnaGk1TGFneW9NYzFJdVB3cW1XNEY2dWxCc3NyVnE4VWRxeDdMaC9WL3Bm?=
 =?utf-8?B?andqQjQ4OE5uRmd2czNlOUxuQmNzODRLTkpQdk0yTXg5dk1iQS90ZkxvZ3gz?=
 =?utf-8?B?dEovS1paWDJzTTdkY0Y1eFpQb1A0bTlidm5Fd21PYWtMeVE4MlVNaGVDVk5I?=
 =?utf-8?B?VXVEeXhrWnRCbU9TOW1jK3IzNVQ1QldPVXJxZDlSenRGQ05uMGRZQ3RSM0Ir?=
 =?utf-8?B?Y2xHQ2llQ2d3aFRGQUV6aTAyaHMzbUhhY0JocTRuNlRTNTh4d3NOMGRvK3ds?=
 =?utf-8?B?elpvVCtBamR3aS9mS0pxQ3JidzZmUEE1MFIzZVRJZmhQdUlZYlF6YVh2QkZD?=
 =?utf-8?B?R2RaRWRhY3NKVk5HZjA0aWgyQUpEOGtSS1liMmQzMlZHUEpTenJ5SmF6TUsw?=
 =?utf-8?B?U3pIbmVVOFRCRSs5WHdBT29LcVZic1pPY040emlqWExFblNTMy9NOGgvdkVC?=
 =?utf-8?B?MzFXeHdWWjlJd0JkdnlVUVV2eldGcGY1WTZ3RC9mbHF5M3N1R3FBS09DZkRt?=
 =?utf-8?B?QkM5QnVLd1FwODBET1pXZHlVUWRic0ZDUEluZjRqV1Ura0Z3QnpMYUs3dEo0?=
 =?utf-8?B?aUVVdzJlVStjUjVjT2hacWVHRTlzMzg0Q0tieW9Sc1pUVkt0c2g4Mk1DNGFp?=
 =?utf-8?B?dTVTK2N5TlBpN0RZUGcvbks5NC9TaTlEUTR1RjFSdDdtTW0xaFp3Mk11UVFO?=
 =?utf-8?B?NTRrZkhOUytMbG5MNDZKV29wR0FzanNFajY1QXRZdHM2YzVjREpnUDRvL2FO?=
 =?utf-8?B?TWgxV0M1QldqTmt4VkVnKzdaMllJVWQ2dlY2Y09oSTcvYWJYOUFLeTVoU2dk?=
 =?utf-8?B?OFExVWU5ZG0vbzBPaGxDQUR0WEZGbXpheFh0a2dCc1Npa0dCcmRveEUvVFor?=
 =?utf-8?B?UDY0OGhSaTZjb2pFV3o0bTdWSEw1UlJPeVZ2eS9vYUdqcitLZW04dE9vMWlV?=
 =?utf-8?B?ay90SVd1WXhNSVB6RWJBc3I4bXQrUXVIeCtvNU5ZODVHdWxmdGhqdG1jbm41?=
 =?utf-8?B?TUljdVhNdjBPTmd1WlFpYThRdjFJcDF1OWc0Wkg3ckoxMnFyUUFVTEs5MHU2?=
 =?utf-8?B?OHpDNmliL2xHeHdwbTdvV05XVXRsUElkWnVaMERBK21ib09rNDlhcDNybVV4?=
 =?utf-8?B?cElubm81Z21LanNHRHlUZVcvU0tVRkdvWGJ1MEc1cisybVhWb3ZLS3ZtZkpP?=
 =?utf-8?B?SGs3eUppY3dqbVZBTUI1eUFFdUZqdlBhQkZzeDJXcDFHa29ZdVVldnZIYmpZ?=
 =?utf-8?B?ZmtHOHN1S09IemhSMnJNSUJtWmZJeEZLRFY4TWN2SVVSVkhyRnYySjk1ZjZH?=
 =?utf-8?B?dXNuMnp1dllHWmdpSlpMeERQOEE3Q3N0Tmd2d3FkY1d5NXVDSEMyVkNmUTRu?=
 =?utf-8?Q?8GEg0hfCfaZJm2sziw=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f4110f-40a5-4ec6-278d-08dcccedf04d
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:29:14.1223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5524

On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > Hi, Greg & Rafael
> > > > 
> > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > 
> > > > after check source code, I find irq for these two devices are 0, when
> > > > use platform_get_irq, it will alway fail.
> > > > 
> > > > 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > 		return -EINVAL;
> > > > 	return ret;
> > > > 
> > > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > > 
> > > > I don't know how to write a good solution, thus send an email to you.
> > > 
> > > Hold on, how the heck you got 0 in the first place?A
> > 
> > use tmu as an example
> > 
> > enum bxtwc_irqs_tmu {
> >         BXTWC_TMU_IRQ = 0,
> > };
> > 
> > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > };
> > 
> > static const struct resource tmu_resources[] = {
> >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > };
> > 
> >         {
> >                 .name = "bxt_wcove_tmu",
> >                 .num_resources = ARRAY_SIZE(tmu_resources),
> >                 .resources = tmu_resources,
> >         },
> > 
> > this is why I got 0, and I don't do any hack.
> 
> Thanks for elaboration, I will look at this a bit later (may be next or one
> after next week, just returned from vacations).

Hi, Andy
   could you share the patch link to the fix? then I could port it to
   debian.

   Thank you.


> 
> > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

