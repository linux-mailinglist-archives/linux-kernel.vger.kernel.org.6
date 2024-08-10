Return-Path: <linux-kernel+bounces-281658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45394D990
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 02:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA7501F226AA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 00:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293E1B969;
	Sat, 10 Aug 2024 00:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RnPHw2gp"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010014.outbound.protection.outlook.com [52.103.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CB4624
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723249970; cv=fail; b=K8zjg8oabBRZs7vFLRJVPpbGEuBY2wniexy0VD1KyV4RygyEUeVfwE4dk4BPT97eZ5HXfxiJiZo3VZdsJDpodsbgrayXM6Lr6aL/nHcU2p8+LP6tXiEIfNN5Q7Ad7H33uiHMhl4znsg/lZmARBOhVB/IcGmnRX7ctrThOYdUkYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723249970; c=relaxed/simple;
	bh=gcu81d+707Ao4lTERj1iNzJLd87PRsJ4xv4nPShH/yI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pSaARjpxol2gAF6nocqXfhrNy4VBGC15FE3e0NXUSkrzVpkGAaN4/9y9ygCY8cNL1MnaYilwN2gvPzhBUR64MUJlRZy/s0WgrWpVUxO/JLD9kRxHADb8WelVgpcqCGaHK6x6Qe/u9rP1yT2vCoNnEdYDVTB+FtiC6lFmCNYkEXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RnPHw2gp; arc=fail smtp.client-ip=52.103.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVNoho16vsymUP5StkS4rIKoBk9FnaSGXN16LfOtiwYI1GbgpPGvA8r2D/xc2K7dg6OVf2X4UUUELNSWje3eBMLtk9pNwBh6hD0fUODWtQsAEJqPbgEP5IujYHjQwppeps9JUzjs8C9NjKkULbrDqlgbm4Cjhiax2ULKHxaik/VZzo5Y7Ot2yjhbg0FGD7aDk8SH3Y31wAONV8A2vaIMBuJWcdS7xwx5JpT4DDvhB6S009B4toqgrVuaCgsBOGF1fNfBSUdPY1kb2KoUghYhO+UnMlVRddtLbQMK9ik/7IQmxYvpOOyc/GH00BxQji+/yVpNkyYc47mhR0Kghs83Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbBMl+snsPCqePB02m6PN1aor1VR7xEqscVzhoPMU3E=;
 b=ivoG1zhYvDy+dbbTwrdaiMFk/9lVTKio8KBr4SKiG1JtSZA8RRnfqAD7sx5fmqvYYiNeB74BclcaeiC/ef5R/xwV/vO6zWgAoWBDmVWyVBwEIZDh0BQHKjV3lmER765H2cu9s+p0XfPo/imXJmjt4U/b3SXSX623ro1mtfsDchSgKzRl3bue09zk0lkrwm3mUGdju3PF74e3UVwAHBg+u1nIE15fm4+jGjTI1DYKd5lKP2edNSXFzatQIAGGiwTNp7jfsEu9DrKasy5QJFI9H7oJSR7tm9wfTXYCJkkJkURlye63w1yCWClHAuuw3jkEEWhsYG3hYAisPvdZUeElDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbBMl+snsPCqePB02m6PN1aor1VR7xEqscVzhoPMU3E=;
 b=RnPHw2gpdtCiE9FoHJE05fzSg8cRu8eBYXLdvqV0W44mhptJ+ihE2PJsYRYtyYKqm6Bv7Rt29hhXbiStSyGyx1ym2v7gdxDdGrcXJwxGtPgR4j6Sada4JxeCA97eZ3aUCo7EziVi0B6JyzGGq1EiFkOjX8ZprltOd6z9U+aS2pp0FSN/IEgjt/rEPR84h51pS1ptPUihJZBPZPTYo9j7Ie3qtiw39mclZgT/lyA+CqLDKD8uXUDcrscdIzcs00owRcfvG0+qlM58ZnaX6UDRhfu8VkWz4JHhehQQYwowfYBZ6sDYcEmJwraUljoMbMczyFH/sNm1+og1rHFaxSYovQ==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by OS3PR01MB8587.jpnprd01.prod.outlook.com (2603:1096:604:19c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Sat, 10 Aug
 2024 00:32:45 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%5]) with mapi id 15.20.7849.014; Sat, 10 Aug 2024
 00:32:45 +0000
Date: Sat, 10 Aug 2024 08:32:39 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB33220011C5C0D630FD83EC64CDBB2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrYjLdPryElDubaM@smile.fi.intel.com>
X-TMN: [m2v5J/L7/F5/Sg7QHwyrNJl2nLTcNwEkdbTqqqt29XGmblZd7d5GNDwVxN1hEK0m]
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <Zra1J6b_hQ2KLwd5@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|OS3PR01MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 81278dba-e525-4df6-c46c-08dcb8d3f3db
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|461199028|15080799003|5072599009|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	wltQpBO3A/aMv9o+5GR1maCm1YlRNkuMKg5variF6yJrCzxxZhCXuf0D4/w7DxA3OrqO0aEIARZ+AcZeua6qVrYc8dekeyhfe1avmQbUcgIa6mMFDPvWJ1mf35ibaxlriUMuKw/Npyl1Uy6xQfHkItynsg6xUc44IUOexHGYXi36TbqEoWUW8JDEreHYXCMOm7IRu5hdNz8jreLv7lZtQfjTh/N4wHxGD8zSPcIu4JYSKZPa3Ag8BP7u4bK56QAwoqGVJN6HIeioqs7X4IDIC91Eqp1vwT3dDCjgkiNjAFBHBh+nLPnF6Ee9llwOhFgVXZapIIw9vpa456y/e3JXwxolPPhFPxHjs6SH7VlWbVPRMGCmwam//BJ30YiBMAXoeQeTisZ1FD+olNM8f9G2CwE+lS0+mURfwnCIlNIj0F1mOT3nBR4moZfOPwd/HVU/L2ExFNjNr6weGHct82yirEWW+QyEi24HEUwd+xV8z+YR5OjpQmn6djyN9cHwF+rbrUOlUyDNIfZa59fPPn63fUfYD0nkUK05Emgp15gQvT8Wy9MIQwU8zCuW8du5DI061vv+gAXk9NFF6/HA/EoAKzKtu+0n2cHqazax0GPGHqmEOkZvc6cnK6hKa6IuB67E1pWD0qm1mbxg0om0+9j3IEW53F0na6UdJRM1uLk7ZrIrlK5hCgmIqrr8c5Z0TayvxyvMDSaE8g783cFkUUTp+qL4bQjL0gS/P9LC55GlUVCxo1KaUDm1OjcCqFCPNJS9xz4dnEXaKwdVRUCaYy0A/pi2G1tEokBImnAkWrEYYcHxFTGFkNuQ7vszc/OqjGg10HYRZ3rKuqfA45BGVbjhh7189YSOuam2MVJRs9ZpM4hCDSyCmBjckp2EvLNrgDl1
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dysvdUFLczdjTmtoMGtJQzNkVWdOR3ZEV0ZXcmtiU0RoTDRMd0VpTWtuYmYw?=
 =?utf-8?B?cnh5QjBBaVMwVUJBMUVVam40Ly9TdkhXUUtybytseEdLTjAzZzM0b2pXelha?=
 =?utf-8?B?aGRCajdXaytOMnVJZ2R2bkoyTDIvWUI3WXBUWXlNWkpRZzZ6YjN0TWdTTjR4?=
 =?utf-8?B?KzlGZE1MQUVFc0N1S0tPQUxSTzRta0ZtTDJJK1creGMyUnV0bWFNSFFNUTcw?=
 =?utf-8?B?NURmNWhQUS9SMGhETnp5aDZCT1dOa0xhOTZHMDhmMHBjcGlxN1RYMytDSVhH?=
 =?utf-8?B?Z20rZVBaUGYvQUNxczNRZUtDVlcxT3g0T0NRZ3VPVmpwZk1QcmJTVXdGdXVN?=
 =?utf-8?B?UnlnNDB0QnIzVHpKZkg2OXN4c1BRejRsbE9zRWRCZnRpc2duTSt6VlB5R2tk?=
 =?utf-8?B?a2xzRFdPMldzazloemlnaWQrbXdqalUyQ0pnajllMUozMllKMC9YU2FGZG1L?=
 =?utf-8?B?azNhcjhpanlhanYvc1l0UjFRY3FpWjZPNUV6N25jNXlFYjRpeVpsMUtLZWdo?=
 =?utf-8?B?NE50by9jeHAxVHRZTllwM3p5cEhhKzZybUl4c1gzalA2TE1rOVNQZWFlRmJP?=
 =?utf-8?B?MDYwTHhiU1pDYnI3QVVzam9jV3MvMVFveDhJOGtucDlYaVFrZDA2MjV2VEw3?=
 =?utf-8?B?ek5FWDVSdTJzKzBieTdPTHI0N04zM3BkS1Y3OXBLZEcxVmIvRUVWY3dQSUto?=
 =?utf-8?B?bktNUlg4YXR4ZVB2MXMwdzF3ZUYyTGsrSGQ1ZUxPOHUrVHdNdXc4amtrTHJ4?=
 =?utf-8?B?UzRDU28yWk14M3FWdkpWcDJwU1BENkVYTzhSVTdiZ0VkMGpFd2RsOGJkcUk1?=
 =?utf-8?B?blF0NVJsMU05bnFWTGo1OXZIdFJ0by9RY2lqTUdFRXkvV05ndTN4TG8vZDZX?=
 =?utf-8?B?UkZkUFgvTDU1OUo4ZFVoV1FQTzkvM2NFVGxabm14eTlKNGFYYyt1cXZMd2dH?=
 =?utf-8?B?K01aMlE2Y3k0VjRtT3pHMjFKTUt4eUw1UVVDVCtmZmdCcjNneU1XVFJlbjFv?=
 =?utf-8?B?MUFDODZsNk1mV0pQNGpFRW84UXVQcDJVMklMTTlnT0hxcWtvR0FJWTVXMFJj?=
 =?utf-8?B?cHBhV1pzeTVUZjdSMW9DeUFwRjNMUHVjU2ZDckZrcE8wMWRIb3d3QnlhNzVW?=
 =?utf-8?B?ejV5N0cvbi9kMUZ5aStNOHpSWklCWStyZzhQSTFVNXRXNkhNM2xKWGRmTmFI?=
 =?utf-8?B?S20zZW1LZm84cEFpc1p0QXNacktyZUhYSG9scHlVSk5ZVGVCNUxobzE4bzRx?=
 =?utf-8?B?Z21pdldCR3VFUDN6TmVWMGtNZFJnQ2FKUEhyeHFyYVRBVm1RR1Axd2RkN2xS?=
 =?utf-8?B?ODYwcUM2a2dXNkcrNUQvQnVkR0ViQm5wa0JoYUZQQUhhUFlKUjU2am9rUENG?=
 =?utf-8?B?WUJoR09oQzN4aGg1L0pOTmFWWmF2REpTZFMzYlBxSTR3VXZ3NjZtaUxaK3lZ?=
 =?utf-8?B?c3dKR29rV1pPWURyMFNtVFNnK3NlOGoxaFVYOHNzN1dpY1pZZXJsM1cwdXJB?=
 =?utf-8?B?SnhqUlFoQkVhejFZZGg4MVZYdzdvdDAxWWtmOVZucTNGYnZGWG55bWRUZTU2?=
 =?utf-8?B?dGRZZG1mekt1aGZ1K3JUZDFyZllkQ3I3UG5ETnJRV0lTQmlkbk1xR3MyZ21J?=
 =?utf-8?B?cmVTc0lpK0RJOExlN3RWaFcydUE1MWtsZnRvSzlrc1JFMWFxU25MUlZITzJM?=
 =?utf-8?B?T2dKT3JnOUdHd1ZtRlQyRXQvdkpIbEFHZHVwWGFnS21rRW8vMVVYREtEc1FE?=
 =?utf-8?Q?+QDEpLTJvroA/CGecM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81278dba-e525-4df6-c46c-08dcb8d3f3db
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 00:32:45.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8587

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

is it good to set BXTWC_TMU_IRQ = 1?

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

