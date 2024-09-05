Return-Path: <linux-kernel+bounces-317284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EB996DBE8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7341C252EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26EC14F70;
	Thu,  5 Sep 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oQkVzoTP"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010005.outbound.protection.outlook.com [52.103.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D217736
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725546868; cv=fail; b=L1tMzylbCJ5TMdQjcoaOD9bob67ELPgQwqXWAjtGaqnJ+7BQGmEJcJqPurPz6ik4zpDBnrXtqhg78cySKt+iEkzxz5RCstwMGjTdfjWCIlHoC/fVQrkbr97dyC02KzZY9mh5FJ7W6EpRW8ssTAub/XkR9M77E+J6e19I8QeaZ6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725546868; c=relaxed/simple;
	bh=6jeAu7gAwN5kTRokBcFHimXu5g+skgCZCQksal4jIkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DlIwIShQPdfJuzOPAYeB+NKkZRJcFhYCLkGmqWHlWoN8wc7M5mZcLngLJB84yHrAtRJCWyhigfiLT2fZQ941EKDuEaxAvx92ZPChA0UTSlxu3bVgaRy32e3uxUg4o0iZmnCIXcYgp1yLwKfbcTAyBAaqMPfC1FlWG5SDWeOK2Z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oQkVzoTP; arc=fail smtp.client-ip=52.103.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL3MPBCsNnsbdEXrzNj3YOdETSARj6SklXUMadhLy+Qx4icYVG9XhYl1ROTJmedICkzIbmtfdfqqlgj0TunxutOdg5ON/J760+odCEO0GZEXxfaqJaPYb5DvaWqm+Jd/w3WtXMUbKq65SIIvL4jHoJqJNL75qfRDX6k1HZoGISfSNUKCVirCcmsqYBD67vM8M0WnXtlNk92c3wYf2gpv+wWe+Fyt5ey3CaAtzYUw4k1LKbMThlcWC2dm0YHnGLT2zimcs+ewvFGyVjG+a7BImRe8N7FLLB+akXW+Ht+uVfvLcs1u2iNZ4uT+1LdAD8G4XypdkbCIpAI686FwyMh2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoEZdwGwZ4s1WtlqHYw4X5+niRHZ0jnYaVj7DKyw+E8=;
 b=SNpgNsL88eslc4S52ljGyIzFkUbdkUy9Cn9vc4CDOmD9BH5EhhS9PWqW9P/CTisGHMHMfBQcOlhBAJbhv1nSmfwcBcq63bhLklrBFVNOfE4GZWEQ7nHnyKjBYZ7gvZmUbHAjZnYfjcSfs8EaaWrDA6hXWLDV1HIaQsXM/PcQV/Nn28zhOOeojd+ThvPUtO/HC4+paeufK9uGGpoQtZ995RrDkvf2XtlX9Ur4uP2R+v5KXds+BiggmBt/3C0xThiFK80gf9U4C5mvXsu1oVnYnZS0cQSzD8kTRi5VoRKdLoqKgALgmVgiUsj79LN551GTx7b3TgSw0EyUT89LUsNzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoEZdwGwZ4s1WtlqHYw4X5+niRHZ0jnYaVj7DKyw+E8=;
 b=oQkVzoTPPAq45mt2OWSp7tI/DkUzWBSp0a+tecnMt1Xmb/r5tTB3mVdNGZUblfcokFC722IBiDSmlCPgvnckeQN2Nl5blSanbgTEP/8Y3dwCgpiyyxtnCJEezbAk2y5Oe9YddpDkBdrMLvkwH1+bH+LtRuRd6VSvAjmbp33nYUzlESmcTX6olpjtemuAKNdpH44GWSwgKSuEmmyULTW7ncAWqxDOhdHKT3IZZcsSwIqXCVyD7i/RHn+mc/CnrlS4IoWAYxS38sfYfFf6DX568pOI6DJ8dkaiFOW471BUqDwfLW3yMjurf2xFrOadBS1X6I9fkwLc2HB+rFq2RVssvQ==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by TYRPR01MB13089.jpnprd01.prod.outlook.com (2603:1096:405:1d0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Thu, 5 Sep
 2024 14:34:24 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%2]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 14:34:24 +0000
Date: Thu, 5 Sep 2024 22:34:18 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB3322181DE9D456B3255756BCCD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
 <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <CAHp75VeMp9C04iDW5_c9owq3HP=5wvccoOuHwrSQ5SFeV+SRVA@mail.gmail.com>
 <TY2PR01MB3322699682DBE2F13F919F80CD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZtmlCh4NScc25tS2@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZtmlCh4NScc25tS2@smile.fi.intel.com>
X-TMN: [0TZ09YD4OxDxQeeiLZwbOcwXZjZnc8XQhpkCZOqyLjdnonHYPv3c1PKXd9c2TX+Z]
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <ZtnBalKGWcE_zv2j@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|TYRPR01MB13089:EE_
X-MS-Office365-Filtering-Correlation-Id: 8640217a-5eec-4386-9bf3-08dccdb7d633
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|15080799006|5072599009|6090799003|8060799006|1602099012|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info:
	ipug/ffX+FWsFUJiyso//rCl+mQNr0JE7c6nwjFjihCeNEY8sPdajjR3q7t387oCIj9NZzPe2oA5ETzXhWCR8dC6DmZK4xzprI0IicvnLSft8FCExFPd7mt6Q85lidr4///e+s/TygHfQT2TUFuKonvp6TTvnOcr+qGfI4BUEOWee4Dp0lmy8e1vMUhBMxJTArOC/sX3x8q4YupFgjMjPNnbLODaIEvr90X1ae9K2hbX/QQcEKzk44q1yRiHfvGIw/KZLXJBMFgnbcEUycU4nh0+i6Cg2Ryv7Be72+pf9J0KOXR26i+AcOJnAR3erIQDs/YYt5fqE7UFVvX++kpyMr2T6kjBPlFzN+hYFONv34ZMpyI8bRUZ7oUZi+WguzEqyAZhgrDcFLD+tUAkU6X6iiBmbzQ5Nj6vHBZ9Kx/LYIyudxqeiJm0ecqKZSVFQAa8O2ougJfqXuUqYxAm8PPpJVBLk6wG2iSiMipJBlqvpV3HxPV8LRHktkQvhmNm6E0d+4qSPieG4G2U2QbL1fOjOClVwSyNMmAsLZ3yx5RpYo+fG5yleeSxNHfeVm+1V0ff5jbMDuM2ruMpSS92EfqOfu/A0rg+H18BnmqLtzrOkGrHLZhxgz8wPMzk/nJoC7bv86WH9puQsZvcH0mMotC2FpcsCPiOOV1ANpYf/aVLFzStjPjiUtrmpO8k50PwV48rJyITRKDfTWwOKTT+8jQfh8/DEXYlrfEN3GbekGRxXKQhO8bTGgi4lN57iPaeZHnSgC/4o2qPD2G8WQZli/NgYRgaGs9srVMfVXvDam1hQwOrDcn69uNEPYLdYy9Fso5bRWvm2N0aZNyMgzGCscxd+vwShVEjZ6rJNwYY3ckc+afRX4CyqJkJxa3niCidWDu0Gn1v6p0k4dnCkI2/oW458w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWN5RDdZeXlpbzhVODNjYkxqU2FTQUZvUlpnTVZXK0w3WW5lNmwxY3MwSk9j?=
 =?utf-8?B?aDQrdElxMzNSZmg5M3RzR3JLQUswdGJ4SS9uZ3I1dXlJOEtQeFp4SUM2OEFl?=
 =?utf-8?B?NjBIQ3dZbHJCUWhjbjZod09MSjUrM3N2cDNtZEZHQTM3NmxrY2NnZFhTWjFI?=
 =?utf-8?B?RnU2M2NiWWVtQks4dFoyOGpOdDU0cjkyZUw0T2tCdHJ5eXowK0RZdkZud1lG?=
 =?utf-8?B?cm1QYlo4bjJEVHNzZ25VV0hFWGhpU2ZZOXFQMFlDa1hXNVUxdUNQQVUxb2J3?=
 =?utf-8?B?TEZabFZSamNhL3Vielg3cWEvWW1VUVo4Qk9WRTIzMWJJVzQrZ3lwUmtxbktw?=
 =?utf-8?B?TFJIdGN3UG5GTGdYMUc2c0J0V2RDUmg3cnhQRFFuemRrZWY0cXV3bm1NVHh4?=
 =?utf-8?B?QWE1b0EvT3dYUlZvd3c3VGFteXQ5dHNOYnlGaG93cHZCVWo4UFJPWGs1NE9w?=
 =?utf-8?B?eVFka1JoanpmMWpTUXYvUEdHU042MDl0Y3dBRjV2YXU1bDJZTVZUSWpQeWdn?=
 =?utf-8?B?eG0rRTlaQTNSZ0pWMzhDRnZWYVJQK0FrOXFSVm9lTE1GU0tmZUVNakhCQ0s0?=
 =?utf-8?B?Yk9xcTh6RmQyZHRjRllnZ2ZPQXRGOUlhRXgydGhnL3gyYUczYzFOUnhmZWI5?=
 =?utf-8?B?Z0REeGVVZlI1WWg4SjVTMkVLd0wxUXVjaCsvOUlxc1BmU1ZCaFMxa3NXMURH?=
 =?utf-8?B?Vk5vMkgyRDdwcXlKQURubTRQTlllODFTNGNiazJGTlRBMEZmaWJpZWlvUlYx?=
 =?utf-8?B?anRxRlFUWWgzVlVKSHByem9QWHExN3haU2VqSC9PcjBBSEc3QU9lbGI3WjJ0?=
 =?utf-8?B?a0prTlUyazJSQ1FVdEJmSFZQWDZlWnE4Q1dqR1M5NEduaTNvU3RTd1ZMNFpH?=
 =?utf-8?B?OWpyRzU5N21QRStGeTJsQnI3QnVIRVl4VzY0YmZWZ1FkQmRBdTBUcGJIMndG?=
 =?utf-8?B?bFhSR1pESWRlK2F0c05RM1BKWVkxUXJQV0w2ZU5ScnBmQThUWWhSNzJKMSti?=
 =?utf-8?B?QmNSQURvS1dwenVNRXlINEhrR2pOd2d3MU9BanMvVk9WWDFsSHpUWGt0TFVT?=
 =?utf-8?B?LzIxSEp3VWZTQzFMNkxQK1ROV1J5bW5VQVRDdXZsZTREOUtmZVpUWHBWYUQz?=
 =?utf-8?B?SjRvQVVndXFURDdHM20zYnZSK0h2SjcyanV2blU1dkoyQk9Ma3ZLbVZnQWNI?=
 =?utf-8?B?d0ZIZmU3azIxSU9HK0lUay9yMGpJN255aHFOYUJLN2V6ZHhLQzYxOWk1aHJh?=
 =?utf-8?B?TWNwRjVBbkxnR0N2dzRza2FDcWpsVkRKZ0NFNjlUODA0ZEIxUDlUY2xtNEF5?=
 =?utf-8?B?RzVyUVJPUkw5S3lxQlNFdktrWUl3V0V0Y0xwWDBjMVBvbGl0dDhvOTgxOHhs?=
 =?utf-8?B?cUE3VUtkQWtsSVZTZVVkYUF0THJpa0JJUkZZbXRHRFJWT3k1Y2hqakdpVks3?=
 =?utf-8?B?YlNPeGpzR3RQMy9kYjFJcHcwSURZbXpSUm1icHZGUGoyQWVyUDRzOWlTaXRa?=
 =?utf-8?B?Qi9haldEaGJ2MlpYVkE4K2lmb1V5ZXhYZUJuM3hheVpGZDRmMFRMdkRjZmJn?=
 =?utf-8?B?cktXMkNmL0gyN0EzU24ybVh5djAvQjF0aTF0cGJxMXQ0bzJtMmp0bzE3OHRM?=
 =?utf-8?B?WkpXbWV6cGFYSWg1aWFPbFhKSXlrK0lQbVpXL2Z4b2gzSjhVRGt5L1ZLbjZE?=
 =?utf-8?B?ckYvRzdraDlvZUFuNEVsTDFzdmFLRnluejArWXl2Y25yTVgrQ2ZuUXFOQzlM?=
 =?utf-8?Q?tHo/645RxknDS+va1c=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8640217a-5eec-4386-9bf3-08dccdb7d633
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 14:34:24.3091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13089

On Thu, Sep 05, 2024 at 03:33:14PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 05, 2024 at 07:27:25PM +0800, Zhang Ning wrote:
> > On Wed, Sep 04, 2024 at 05:36:35PM +0300, Andy Shevchenko wrote:
> > > On Wed, Sep 4, 2024 at 5:29 PM Zhang Ning <zhangn1985@outlook.com> wrote:
> > > > On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > > > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > > > > > Hi, Greg & Rafael
> > > > > > > >
> > > > > > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > > > > >
> > > > > > > > after check source code, I find irq for these two devices are 0, when
> > > > > > > > use platform_get_irq, it will alway fail.
> > > > > > > >
> > > > > > > >         if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > > > >                 return -EINVAL;
> > > > > > > >         return ret;
> > > > > > > >
> > > > > > > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > > > > > >
> > > > > > > > I don't know how to write a good solution, thus send an email to you.
> > > > > > >
> > > > > > > Hold on, how the heck you got 0 in the first place?A
> > > > > >
> > > > > > use tmu as an example
> > > > > >
> > > > > > enum bxtwc_irqs_tmu {
> > > > > >         BXTWC_TMU_IRQ = 0,
> > > > > > };
> > > > > >
> > > > > > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> > > > > >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > > > > > };
> > > > > >
> > > > > > static const struct resource tmu_resources[] = {
> > > > > >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > > > > > };
> > > > > >
> > > > > >         {
> > > > > >                 .name = "bxt_wcove_tmu",
> > > > > >                 .num_resources = ARRAY_SIZE(tmu_resources),
> > > > > >                 .resources = tmu_resources,
> > > > > >         },
> > > > > >
> > > > > > this is why I got 0, and I don't do any hack.
> > > > >
> > > > > Thanks for elaboration, I will look at this a bit later (may be next or one
> > > > > after next week, just returned from vacations).
> > > 
> > > >    could you share the patch link to the fix? then I could port it to
> > > >    debian.
> > > 
> > > Sorry I was busy with other stuff (as well), I am still in the middle
> > > of debugging that.
> > > The issue is that the leaf drivers for some reason do not request
> > > proper vIRQ (that should come from the secondary IRQ chip). OTOH there
> > > is only one _similar_ design in the kernel besides this one. And when
> > > I tried to test the version where all this appears, I couldn't boot
> > > (yeah, I spent some time on bisecting things) the board I have (One of
> > > pre-production variants of Intel Joule SoM).
> > 
> > Yes, me too. I'm trying to enable Joule on Debian. thus found this
> > issue. you can use debian sid with linux 6.11 to debug this issue.
> > 
> > and another issue is Joule HDA pci id is removed from Linux kernel, thus
> > no sound, but I don't plan to submit an issue.
> > 
> > > Do you have any (most recent) kernel version that works as expected?
> > I don't try any old kernel, but from git log, I think bad commit is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57129044f5044dcd73c22d91491906104bd331fd`
> 
> No, it does the right thing from architectural point of view. It might be that
> it was never tested or it was a regression somewhere. That's why I wanted to find
> the newest possible kernel that works on that machine.

from the first point btx pmic driver merged to mainline kernel:

enum bxtwc_irqs_level2 {
	/* Level 2 */
	BXTWC_THRM0_IRQ = 0,
	BXTWC_THRM1_IRQ,
	BXTWC_THRM2_IRQ,
	BXTWC_BCU_IRQ,
	BXTWC_ADC_IRQ,
	BXTWC_CHGR0_IRQ,
	BXTWC_CHGR1_IRQ,
	BXTWC_GPIO0_IRQ,
	BXTWC_GPIO1_IRQ,
	BXTWC_CRIT_IRQ,
};

static const struct regmap_irq bxtwc_regmap_irqs_level2[] = {
	REGMAP_IRQ_REG(BXTWC_THRM0_IRQ, 0, 0xff),
	REGMAP_IRQ_REG(BXTWC_THRM1_IRQ, 1, 0xbf),


static struct resource thermal_resources[] = {
	DEFINE_RES_IRQ(BXTWC_THRM0_IRQ),
	DEFINE_RES_IRQ(BXTWC_THRM1_IRQ),
	DEFINE_RES_IRQ(BXTWC_THRM2_IRQ),
};

it would meet irq 0 issue. 

another Intel pmic driver: intel_soc_pmic_chtdc_ti.c

enum {
	CHTDC_TI_PWRBTN = 0,	/* power button */
	CHTDC_TI_DIETMPWARN,	/* thermal */
	CHTDC_TI_ADCCMPL,	/* ADC */
	/* No IRQ 3 */
	CHTDC_TI_VBATLOW = 4,	/* battery */
	CHTDC_TI_VBUSDET,	/* power source */
	/* No IRQ 6 */
	CHTDC_TI_CCEOCAL = 7,	/* battery */
};

static const struct resource power_button_resources[] = {
	DEFINE_RES_IRQ(CHTDC_TI_PWRBTN),
};

static struct mfd_cell chtdc_ti_dev[] = {
	{
		.name = "chtdc_ti_pwrbtn",
		.num_resources = ARRAY_SIZE(power_button_resources),
		.resources = power_button_resources,
	}, {

#define DEFINE_RES_IRQ_NAMED(_irq, _name)                               \
        DEFINE_RES_NAMED((_irq), 1, (_name), IORESOURCE_IRQ)
#define DEFINE_RES_IRQ(_irq)                                            \
        DEFINE_RES_IRQ_NAMED((_irq), NULL)

in this driver, CHTDC_TI_PWRBTN is 0, thus chtdc_ti_pwrbtn will also got
irq 0 issue.


I think it's very easy to find lot of drivers have irq 0 issue, not only
intel drivers.

wm8994 driver as example:

in wm8994-irq.c

static const struct regmap_irq wm8994_irqs[] = {
	[WM8994_IRQ_TEMP_SHUT] = {
		.reg_offset = 1,
		.mask = WM8994_TEMP_SHUT_EINT,
	},

WM8994_IRQ_TEMP_SHUT is 0

static const struct resource wm8994_codec_resources[] = {
	{
		.start = WM8994_IRQ_TEMP_SHUT,
		.end   = WM8994_IRQ_TEMP_WARN,
		.flags = IORESOURCE_IRQ,
	},
};


static const struct mfd_cell wm8994_devs[] = {
	{
		.name = "wm8994-codec",
		.num_resources = ARRAY_SIZE(wm8994_codec_resources),
		.resources = wm8994_codec_resources,
	},

in the wm8994 codec driver:

	wm8994_request_irq(wm8994->wm8994, WM8994_IRQ_TEMP_SHUT,
			   wm8994_temp_shut, "Thermal shutdown", component);



static inline int wm8994_request_irq(struct wm8994 *wm8994, int irq,
                                     irq_handler_t handler, const char *name,
                                     void *data)
{
        if (!wm8994->irq_data)
                return -EINVAL;
        return request_threaded_irq(regmap_irq_get_virq(wm8994->irq_data, irq),
                                    NULL, handler, IRQF_TRIGGER_RISING, name,
                                    data);
}


lucky is wm8994 codec driver doesn't catch the return value.



> 
> > > > > > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

