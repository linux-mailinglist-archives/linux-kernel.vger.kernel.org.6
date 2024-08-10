Return-Path: <linux-kernel+bounces-281760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EC494DAE5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 07:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1265282116
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 05:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E408413C3D5;
	Sat, 10 Aug 2024 05:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eFSJTXBF"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010003.outbound.protection.outlook.com [52.103.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DA13BAE7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267650; cv=fail; b=cLrc+8LCPqU8PtdE93enhUxwgihlMsaI6bUnwHoVvKPTUaOuXGIdIa3G4tPbJroSFlcx2yOX66I2nvPCSoXOyeS6siSQCJakhm32lSvaBWTJ2xq0YWdQsjnVbpKZjG+xGd7gZ0F2DpWbMhNpxELziB6G5wsFpIZwW+sw5TQIwcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267650; c=relaxed/simple;
	bh=KS4PpS6uSNhWKB/kfL/4TsxMI3G3zsQNvGTbGqwUI5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BXt3DLsuL9uQaGVn1U1xkM7IbLFbVWkDjgePFVi8zN5f6E4iU6+t3e83Z+fbV+KvHeN2FhticWKCyqd8mD8znq7+fQX09A0xfdLUr4rkgIkI+W0nVO/6r4TbpsPN9jUeGlwLsGoNbhLaP7LTnxRjoM4lbGYMJDjlJNHqAZqv9Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eFSJTXBF; arc=fail smtp.client-ip=52.103.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mEOGybTMDCp5cWs0GUFzA9D7PHSek9N2Hdc5gOr8zG0ngTHU4DKooxD8l7b+5CijVcNQ//eLJoEiZpIMKe+w2ANBzaN+x5iJOyKpickWD+n4FJtk0xJ58qiJkvXtoVoYuUijafZaH5fcOHWoU4Dgf60JGJkBdf80f54xjKiwDBWgMLTFIgpQ/OUTSkHkUdeXcf6t9I48SFqqQsB0eK4zZd/Te1Gj/Sx39OaV2bVRBY+2Lu4dlsd/LL28F2Ua1+rg1CIH4VYn3MYJMoh034KZYLwWE65DAHGYg8/YIRxRtL+WEDHlbYcNWBc4SZ4Y5mdlmXHdCVuDVlVdtLxAUMqUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+caba/8KxP+2xVUNwvl+BtXOmiGgHjnsVBx68zrG6J0=;
 b=ScZkHg0w8gmbreoan+bef405hHsnxMpbigEgTw6yE6lzdTNtKj0XiKnQd3V05qnwtwPZaa+vlrWRRyEHf7xSS+KmzWdkVlP8cKubprHJzod9aIOFCpRdCxoJxtKT7slTO09gAFs4rZLtfzH9w7n49NDZjpe5AyJk+JeC08lYtGE9rrr24hW4MeeRSmTBYntFLL6bODXO9bUgXWi3UMTXVxd8I4inRaxILoyOH2Y+Psp/MoAqW/z0K1gYyhBoMdUO//U/uWYwaII9qPJbpzjygYS21EpS4KAm2BKO6pch6MwKppPXwLmZQuq5xkujTUALF6eeXlo5A+H7VmlmVzxgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+caba/8KxP+2xVUNwvl+BtXOmiGgHjnsVBx68zrG6J0=;
 b=eFSJTXBFBcyaXBA0ibSkBjYPxens3jIysgB2wtg+xQ101IMYYRhDtOIl1oGirpc6leHpR1xJWqpuu/PhCuOO43IaPdfzZIb2XhP8Mcsy+4YzWgNERtWA1zoT5BE9pLW04q6a6omQwikmGPANVwY+aQiFjCQ726ZZi79AnN8kn7lRt3DFZMX7FEvjXmdfpT7t2qHLkVIdwtajCRqNU7D8Q7Ybt2aev0EjYfEPYcubTmm1j6Ot07KEilTGZVxUXuwxgc8SbS0Ej1xcdOIVLIUz4B4KAsfJLWJfR8dJbQ3hxmDpxnn/8rp0Y/kskpr+Xwu/1XF5Hj+yfZdDyGUb8uKRNg==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by TYCPR01MB8770.jpnprd01.prod.outlook.com (2603:1096:400:18d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sat, 10 Aug
 2024 05:27:24 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%5]) with mapi id 15.20.7849.014; Sat, 10 Aug 2024
 05:27:23 +0000
Date: Sat, 10 Aug 2024 13:27:18 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB3322AAB13DBBB16C334A5D39CDBB2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrYjLdPryElDubaM@smile.fi.intel.com>
X-TMN: [SUatFyrhMS3YXTPyLAbZ5s1gYV+wyeO4RLRfstUnssWfZaXAKO1gQn3Z5XzhtlmD]
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <Zrb6Nr9ajon7V5Am@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|TYCPR01MB8770:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae10af7-dd76-4f3a-8917-08dcb8fd1d0e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799003|5072599009|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	2XRbDbO2SpZ2+8c0gzDVqwqNL53znN3in1O8g7g8hjPMFpf+bByWwyRaMBMWV15CMLo+fWPAaGznhQZV/J2hFBxVV3Eh7lI8WGPKUz2zabT19iVgesSo2uestLllNAV6dIPwK0Vv46A1XFsG7A3pSH10K6aCi4TvTjISVhoKUXHCf4IFAoKeSPb2PFfaU5mNWUeyWuwJKSaJGd3mF51UDYsnPZC2xYVUwymZZ5RpMNauNjys2DF0w4NfhHct1WTv+rARNImPQQyVXO3jJ8chbQOeiEIf/c4ewpEgmfD5HZjnuFeg309l5aLeycf7Jj//WfZnmHSmEfGhyUG0IsNcqfOtLhRAtpb97zci7Qg6hSgo9ERhpUZGsrCVOr6pTdbXa94IINPRtawn51whKbjina6J0EhGl5MA6ez3dDnW2GEn3P7TImKOYUx1Y7J5XuiqPXbnO4YPhCijaubySrFwsor9s7CfJqB1DqtTep3wy5lZ2hM4IZxVy9ZjpKqBrH5MMJVUbw7aI83i/YYlRnzVHXaQeZzh2dyI3pn6pJ+1Q/qbg76mXaBtWMccJtqsvVmSoQlly8n7s4f4OMr/lUwXgijH24zMOItVB2Qv7r6lUNYQbqwOn9sTdzSTFUpAjJLJfiJ0rAILy/ruo8+XKo5dvaVTmLFomaFt8LobVI89tMTgLrjpd3ui8KU/a8ewy8DVUQIiokbvdIo/oLPrBnXuAYy63B1Vf2H0/NtLFIwaUV+GPqT1aO9yjeXa2d4rWcUdGq8Xt578cKEg1BdvTbv1icBmVo3LWNZelGLH/bgU/97IavAQ+qb1NFboiieRduR0ajG4RqBTm1aoCW3ieqh1pRY6Q0jsf3Wpmtz8icRkznch7EOI8qSuPOv+c3OPBGcJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGlBaXlXWkxHczB0bVFYcWtFRkNyM2FIbklESmFTOXRtaVY1ZXhNVWlSVWt2?=
 =?utf-8?B?QWk4TStWc2dpVFhVcnF5STVMRUE0UWpSTFZoV29NU2RzdW1wVmJTTXdLL09p?=
 =?utf-8?B?Ty9BWVM2NTBnZUN6bzF0SEQrSnp2dDJBYzlocEwyOXQ1OVN6S1AyejFWOFBF?=
 =?utf-8?B?OTBkYS9kc3ZpNFlvWTd0aW53US8wdmoyL2VvTjBiUDlqRXVaTmxuTWtPK2NT?=
 =?utf-8?B?c2FLUFlNZExNYnkzS05DMFRTN0RjK0tNbUxLak1iMTcyRnpjcnN4ZFVmSWpZ?=
 =?utf-8?B?SXhwOWZuSWhJRE5ybkhuVmtkamxpV3RlOEdXYXJENk9COEY5WkVtc3QwVXNm?=
 =?utf-8?B?c3p0VjVKcHRySTkrS04xWVlTYjh2RTdqYUg4WlBlcy9SaXFKS3dIN2FJVDYv?=
 =?utf-8?B?UUdmSDdJNmtsQTFjVUh3MWZxZWZrUHpXcGZ2dUxXSDZqMGtqazlQd3VlZVN6?=
 =?utf-8?B?SG1Rb3QwZWRZQVhZVzJSVFJVbFMxYk1ZaGYyb2tYQVo1QlhuRUtuazlLL25z?=
 =?utf-8?B?WUo3cHNXa296dDhidUlpWDlNcE45MW5BRmI4aWJUTk1IRFBzbTM0Mld4d2VD?=
 =?utf-8?B?N0F5RXprVnlZTk9xd1N1NGVZWVRiZzBWZXllQ2FZY0E2S0xyRWVRSzU5Vm5a?=
 =?utf-8?B?dTRnZVMxSzJxVDJoTG5aY01hQ3N0Z1UrZE1keFAreFdITVVVRUJMZVNxM1VM?=
 =?utf-8?B?NG5KZENVZ3E4TWM1NndCM01CV21hVUxnSXUrNnh1U1hadUxPNk1iU2NneTE1?=
 =?utf-8?B?dzlSNENPeFpzTHU3ZVpkc2l2enFIY2RLUE5YYlg3UHlyZU85Y2VxeTJ4ZjE5?=
 =?utf-8?B?R2E0Nnd5c1A0aEZONittM2Naamg0bEZacnUvNzhGdUlFWG15SmhhRzNoczVR?=
 =?utf-8?B?RDhzUEp6blp4K292enpkajN1aTR3RUowdkJJMGFRUGlmS2JnbVlTK3BtbWsr?=
 =?utf-8?B?c1ZyWmFuOFJxOWpNR1pjRE9LSlBTV3VqWkE3UUpDc0twQVUzSGVTUWFIQ0g1?=
 =?utf-8?B?SGpBRGdCV282T0VCODNrb0Z1WDdMd1ZYWW1ZM3A3WGxsd2I2NUtiT3ZIalgy?=
 =?utf-8?B?WGtJQXpzNVBUT1N3M1BVMzkyaWR3d1Q4bmFjSk1pZlUrb1ZqMzBldHd6Yitu?=
 =?utf-8?B?c09HeGpTR1I1TkJyd3c3K3lTUTl0MVlEMGh3RFgxcW02bC8waWFxYkdhN2pt?=
 =?utf-8?B?R01lUkNSM2M1YVlYbUNwRDZwUkpxdGpWYVNuTlFQeE9iakpLdkVIY1gyQ0th?=
 =?utf-8?B?V0sxamg0bm1UT3Z3SVdLZFAxUU5uL2RaRTV4MzdwL2diK1ljMkRKbzhaVzJs?=
 =?utf-8?B?WXQ2Y3REc1k0SHBuTmVmS281ekxmNWFuSUZraWZmV3dvVnlJQkZINVVtNGw1?=
 =?utf-8?B?bE5PdmRiVDZSMk1BRmtnK21raFhaQnBQdWhIVDJ1eFhVYXViSmhLZ1pvNUdX?=
 =?utf-8?B?aU5NcHNSWkJwYWI1N0RLeTJmeXdQbUFaRmZ3akRzYW5yOUNiQS9MWVViQnNX?=
 =?utf-8?B?bzlCMnRScldmdzU3bXJPTnpIb0V4RE9ZUXpQbUI0cGM1WkF6bHNqQmdPdVR5?=
 =?utf-8?B?cTBBNTJzaEw0YStEUTFOb21mNHVqRXhKemZtMTFWWU52QlhZaVZ1U2Z5WVZG?=
 =?utf-8?B?Wm1OaTRNMTd0YTY0cnpETUd1SnVkRDd4MkJIOEEvRXlhS0RzNk9LaFUrcjlt?=
 =?utf-8?B?T1Roek9GblpIbEsxZzQ5RnRPUmlJVHQwQTZFZUhUeXovM2Z2LytVbnp0R29O?=
 =?utf-8?Q?j78IKrP/ReaqeqGuog=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae10af7-dd76-4f3a-8917-08dcb8fd1d0e
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 05:27:23.7049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8770

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
Hi, Greg
	One more question, I don't understand why 0 is not a valid IRQ
	number for platform device?


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
> 
> > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

