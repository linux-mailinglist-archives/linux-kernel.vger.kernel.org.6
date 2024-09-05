Return-Path: <linux-kernel+bounces-316923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FE996D710
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 164C81C23289
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B2219939E;
	Thu,  5 Sep 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="f+W1TD/U"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazolkn19010005.outbound.protection.outlook.com [52.103.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F56198E6E
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725535656; cv=fail; b=AavYdm1jhCQpm2QWPiJVPrJ0oXr2mvxQkde+mMO5+8EuOlf6JuwxuPN9n20QCrAPr4TcZAFTS75ipHChqWDG7uoLopNU8Qsx071BSGV3qUlJYplUejcGQxlvnM6DlvGhnjkWV3YA6NLi7heUiCnzH2X+h9ngq/M9WZ4nGdj81tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725535656; c=relaxed/simple;
	bh=2ojlqh8wpkyPqesOMhUp3KqVUts2lMlCqrbi8SeG9i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=onXK8R8kXUIDEoKhMgQqB0OfCMCstbATkIsEBPTsOmhcYKr0i8PGtwmpR0nuPIm03DPqaNE9Mk/U70K4JmSH2TCoDfMwj9eX4QOmjiovu/sYL5NQR6r1XykZo/i/qBenho1iW/8KB8hCEKtC5O5q17H/eYYawmBPk5BT6y9kbmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=f+W1TD/U; arc=fail smtp.client-ip=52.103.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wBRH0Xrxujbtuzp27O2g643iWQuiwZAL6mMnSnQfF7B4ZcIPdmSLO+SVBBHhBeEUoyDHl1C/e5jC+6/UhnB8/lgqDsYF9MTRmCW6JjtWnHYRJHvarkGLCl8fmW1cybolHlAVIlf4dP/SwPz23BlgiNZJBhE5hxwz5ui3sUrYR3cn4+uWKoNEajKv+vKJIeJLxuesZ/zDROS23QiOcoJNjp/NVQpCNkMV6wtRDq6j8I7jRVIqtT7zk6QHkWyl8R/48MKcqls5+08RCVZYFTGX29MjzyB6PEOC9nRxcu3HHeqPrwxF81m6CJAUPPuAsDYDdDNX7WEmvEEeSMFMrM7psg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/f0InqJiENQvoxy5zV5yVX51yyH1Q7Dbv2MLsohHj60=;
 b=p/JaJaFC6g2NFmUs2UYOMQ0XpUSNCwSNCV+aFtXSrSoUQICijeFyXom3hLLP2wIzgCf8t4KKeN6SSTwWCZqmrTfe5yejb6YBXCXAptYFpWOCmC3b9BAdQ/OtpiaOuj4yY+uAzoCMGriX+OAWfVq4Txams5jL3Jl3cz1CDofYepvjgNrCu07+P1bzHX+DBSKYaIyc6Q/dkWQ0QMFfGsE4FUyVxzh5/03IUbQHopkDknUUbwg4EDaZxiS8xCPChrf/JBcfx0ANpYAVHLbdLH2E46CYuAKw4syFAay7i8s700e4gE8LDK5UgvLGVd5tdlDrKMmAAphjcKSKO+tSzSZuAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f0InqJiENQvoxy5zV5yVX51yyH1Q7Dbv2MLsohHj60=;
 b=f+W1TD/UgTnPlgz5FEar5ekgSYHnccYIdakMNcLWXepln9y8VakbtAMoDTcqKZ52tVbaAzNN9yX6W0imN2xq/0guMmejadDU1el+120uoyVQccfYqEwWuAbzoC6sVigNqiSsvMbNmHV7L/yE5/KghfTr76nLPmDLeD3DuIi5fzSlOLatvgoAAxcaH/jSDouDns4aISP6p6sMrJimGpEAQWhGx8rOeIfOtozmJ3SRsK3bUTiTOBtA0AR/VfoN9ZmwAz2xA7MMB44UG2uwEcPQRZH9kLZGtipjzi0QfLox/lFq/TvHeoOBDPJfszDvxmAYg8IAE/IHXR0M3yAfBPaJjA==
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com (2603:1096:404:d8::12)
 by TYCPR01MB11972.jpnprd01.prod.outlook.com (2603:1096:400:3e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 11:27:31 +0000
Received: from TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d]) by TY2PR01MB3322.jpnprd01.prod.outlook.com
 ([fe80::2580:b866:1150:d0d%2]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 11:27:31 +0000
Date: Thu, 5 Sep 2024 19:27:25 +0800
From: Zhang Ning <zhangn1985@outlook.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: mfd: intel_soc_pmic_bxtwc: irq 0 issue, tmu and typec components
 fail to probe.
Message-ID:
 <TY2PR01MB3322699682DBE2F13F919F80CD9D2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
References: <TY2PR01MB3322FEDCDC048B7D3794F922CDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYMne34hVa33qKf@smile.fi.intel.com>
 <TY2PR01MB33222D8BE4B1107EB3A1917FCDBA2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <ZrYjLdPryElDubaM@smile.fi.intel.com>
 <TY2PR01MB33224CE088EF01D57DE1BABFCD9C2@TY2PR01MB3322.jpnprd01.prod.outlook.com>
 <CAHp75VeMp9C04iDW5_c9owq3HP=5wvccoOuHwrSQ5SFeV+SRVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeMp9C04iDW5_c9owq3HP=5wvccoOuHwrSQ5SFeV+SRVA@mail.gmail.com>
X-TMN: [kgMbt1+gQ+dPsM1+yIF1wAK3Li5nmPFWtYPq/K61QT24q4umKG5t6MIbQJgXaFJi]
X-ClientProxiedBy: KL1PR0401CA0005.apcprd04.prod.outlook.com
 (2603:1096:820:f::10) To TY2PR01MB3322.jpnprd01.prod.outlook.com
 (2603:1096:404:d8::12)
X-Microsoft-Original-Message-ID: <ZtmVnQ-wgoP_2gtv@orangepipc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR01MB3322:EE_|TYCPR01MB11972:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3d4ce0-e4d3-45dd-bde6-08dccd9dbb05
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799003|15080799006|5072599009|8060799006|6090799003|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	1G4ZZC7X2mfU7Vlp/N/cPkdfMbw75M2yp29w0owapFTrs7ICa9iX8APGZtvDZnvMI5nOAI1SA6PXF7RiUXvkYUaEGQdhxPd8RWzVLL4dovUBqd5QUrXZViVn8Cpe9xuDZ2HHmBMJAvm83UpzI4suthGuZ9iYUSoZ6o/40IoYCDHzHG/rz5yp2pHeueuWheqN1oLkZNCuxLLopwSjeM1SgTeVzp19j3gPoshVWzcKrJEHOXPc+H/G/a1aULYdEN11SttaA+CpTQJDOE5Df9+uj0ETIhYswzudrxSeJ069QUQBScjaw0IUGO730YcefbhkbHFTEReyMvlbN5e5wwy0IMnTwE3IaXD+xwVYl5JbPR80uReKzwJkmkoAsU94zHWgEDJZA7eS/COjKWajvwuZrcrIZYfME4J2TYRvpR85bUmZkcXn9ECj9ftlE67SD8MAcvVV37JQm1GIFV0HCpLYJPnAh3lweL6jU73t1W50m6BA7KO63xEnVkI6buL4PYysxU1+EHpUrPI1e1kjJqkA7K9RXv4xJMbTXZeZdzjUho6qpOPsIOKYw/QU4MbgE2wul2a7iCHOlnsAr5LZgdoJaBGZeBG74RTXlohnzqlo1mWTUDRypzn3RzT0gmvrdWMpHk0IJjvlpFJBTXI5hO9R/K/7Jq2HIYoLsebPHisJhcMTyj5dBWvFwoTEQkQ0Mt4Nv8yoB15ZHlkNfYQ/M9OHaSiYlRYW7PMdt9F2EPQluJFu2b053JZU2+RkZeoPpcLSjIZkjMYZZyWjiTYVl773Oh/wFkpEfwUl6ViDRpW1YmlPjF5KHWENm3pmNJv7RrIg3CDTzyl9bMNUgtB6pNlrBFljwcPF+3+0S9yI7NSMhvtqoS/Rud/B+Hm4tjBkIjHX9RFXbVFCGs1G+Q0XjCn+Tg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmROcmpyZC9FS0JOVEYyNFF1b3FCUzl0eFd5YlBxRWZ1aXVmZFFaSVBVU3Ru?=
 =?utf-8?B?elBGR2psTllyQmVScG1JaUlmN0pnd0cvQU0xNlg4WDk3eE5VTTNQMEJIL1ZH?=
 =?utf-8?B?MWZMNUxWR3NXWHZMODNKSXJIZ21ET1M5T2I0RzA5U3lKZUN4SjdMeG43RFB1?=
 =?utf-8?B?Uk9pYVpaS0ZzTkVMckUySHdVQTBhNTg4WThrSkhSK1BkTFhiS1dOTXdsaGQy?=
 =?utf-8?B?KytkcEIvaFFkdlp5Q1gvdWpEaForallsTHc4SitKOFRmaWpuTUtVVjk5VHJB?=
 =?utf-8?B?WW91RmNlcWpUUTZRR2tnM1BDaDlub1lBOFpVQVhsUm4yV3ZaeTV5UmZMKzVW?=
 =?utf-8?B?M29ITW5BRExEM2FNRHpxaDF6QmZEMzB2RFhuQWE4RThMYjlqK2N6cEc2d21O?=
 =?utf-8?B?UzRPRGZwYW1NL29Hd1B4U0N2RmQ5WVZxd2piTkkzNTB2Sm1veDQvWjZWR3h3?=
 =?utf-8?B?d2JtYmJOWENoNVVmNlUzbVdtcWV2SjVOZlFXeVZvcWUvSEZUWVFCUjh3K0Vh?=
 =?utf-8?B?RVZiM0JkemFSTEF3aTk2bzhJYXNPdUhSN0dIMXpscStRVERLQW1TVUlFbVM4?=
 =?utf-8?B?bVdpZUhWZVBzdVhhOFZvLzZDaXByMEtLMVBJNCtCM0pQODErak1vdEJPUlZW?=
 =?utf-8?B?ODgwcmYwdnRyWWdRTDdtSFJFVVdvOHBYZHJJVlhTZFI1ZExseDBHOS9RQy84?=
 =?utf-8?B?UmV0dVA2bnZ1MURnc0tibDRWVXRTaHNNRTdqcEJGOG1wTTRKaUwyM3pxK3FV?=
 =?utf-8?B?UVlQZXpXK2REQlJNcTZ1dndWNEkzR3NxVldQc0d6eHFCRU5IK3Z4UzZtSS9S?=
 =?utf-8?B?eVl4YkR5czdlTTQrV0liRU5GUFBzR1Z0Njg4QURPN3RPcldwN2hMS2ZZeDZO?=
 =?utf-8?B?NW5yV0lSOUlVNll3UXB3TW5rTVB4WjNETHBBMjU1Wmx6SXV3N0NJQzZmQkVO?=
 =?utf-8?B?cFpPd1E4TlNqSG1vajZMVkxIakk0YlBXeVp2Zkt5Y0tNRzVURk9JM0hUSDJ6?=
 =?utf-8?B?V3JNSk9oRGNnajRCWVN3VzR5cHFNOXRzbUIxaHhYQjFkQlUzY1ZmTHEra2Jw?=
 =?utf-8?B?Y1NveFB5bWNRbUVVTW93R0xkeVdpVzJWL24vOVVTMVJmai9tenlPdTJPQTVo?=
 =?utf-8?B?Y0VUL0gwYWljeTdtVFlxSHAzWVg3T3UrS0tka1VEZkJodGVUYzhxdFhjSjAz?=
 =?utf-8?B?Q1BhbVdlMWlLNFRsVXRwWUR6SnNXSkl0NGdUSU5maEcrTEljSW9QNFdRZkxE?=
 =?utf-8?B?a0pkUmI1MHR0dnNCYzVQenZJamRRN1dPQjZkaGIxbmx4SDNzM0h4T09YSmI3?=
 =?utf-8?B?R0VtREcvNXBxSzViVmYrK1FBUTl5MzZTY05xbU1zQVBabkk1SDdZYS9sbXA0?=
 =?utf-8?B?S3FpeEQ3ZGU1UUVHQ0ZBQWF1Tnp2bjdrZ3FEWkZPMisxMy9jTGN2UjQ3elRu?=
 =?utf-8?B?eGo3UEkvaXRBb2hDdHdHT0dOaFFaTytTTVl3Qk1RY2NjMEkwZ0Y1b2N2d1d1?=
 =?utf-8?B?WGJMTG43YTBwUngyZmxUdnUwNU5sYndFR3ZsWVFsMnhSNlhPaWZ1UnZrM21V?=
 =?utf-8?B?bC9rNEZ3MGE1M3RjSTNqNFQvRmFjTlV2dDZuMEdjYStPcjI2anlkK2p4UUZV?=
 =?utf-8?B?QUdPY0lNb2hMb3g2Ry9XVEFJY1BMMDNIaForV1BOOGxIaHR3UVJkdVBObzdw?=
 =?utf-8?B?SExwVHYxQWNDY2tOZ0tLVkgxZTJuaWdTN3ZYZ3ZUcDVsQy8rMkd1NHRaSnlk?=
 =?utf-8?Q?A7ou/uVMh1qNXlKwcg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3d4ce0-e4d3-45dd-bde6-08dccd9dbb05
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3322.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 11:27:31.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11972

On Wed, Sep 04, 2024 at 05:36:35PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 4, 2024 at 5:29 PM Zhang Ning <zhangn1985@outlook.com> wrote:
> > On Fri, Aug 09, 2024 at 05:09:49PM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 09, 2024 at 08:53:24PM +0800, Zhang Ning wrote:
> > > > On Fri, Aug 09, 2024 at 03:33:33PM +0300, Andy Shevchenko wrote:
> > > > > On Fri, Aug 09, 2024 at 08:02:43PM +0800, Zhang Ning wrote:
> > > > > > Hi, Greg & Rafael
> > > > > >
> > > > > > recently, when I try to enable mfd components for intel_soc_pmic_bxtwc
> > > > > > for debian kernel[0]. I find tmu and typec failed to probe.
> > > > > >
> > > > > > after check source code, I find irq for these two devices are 0, when
> > > > > > use platform_get_irq, it will alway fail.
> > > > > >
> > > > > >         if (WARN(!ret, "0 is an invalid IRQ number\n"))
> > > > > >                 return -EINVAL;
> > > > > >         return ret;
> > > > > >
> > > > > > My workaround for debian is to hardcode irq to 0, instead to use api.
> > > > > >
> > > > > > I don't know how to write a good solution, thus send an email to you.
> > > > >
> > > > > Hold on, how the heck you got 0 in the first place?A
> > > >
> > > > use tmu as an example
> > > >
> > > > enum bxtwc_irqs_tmu {
> > > >         BXTWC_TMU_IRQ = 0,
> > > > };
> > > >
> > > > static const struct regmap_irq bxtwc_regmap_irqs_tmu[] = {
> > > >         REGMAP_IRQ_REG(BXTWC_TMU_IRQ, 0, GENMASK(2, 1)),
> > > > };
> > > >
> > > > static const struct resource tmu_resources[] = {
> > > >         DEFINE_RES_IRQ_NAMED(BXTWC_TMU_IRQ, "TMU"),
> > > > };
> > > >
> > > >         {
> > > >                 .name = "bxt_wcove_tmu",
> > > >                 .num_resources = ARRAY_SIZE(tmu_resources),
> > > >                 .resources = tmu_resources,
> > > >         },
> > > >
> > > > this is why I got 0, and I don't do any hack.
> > >
> > > Thanks for elaboration, I will look at this a bit later (may be next or one
> > > after next week, just returned from vacations).
> 
> >    could you share the patch link to the fix? then I could port it to
> >    debian.
> 
> Sorry I was busy with other stuff (as well), I am still in the middle
> of debugging that.
> The issue is that the leaf drivers for some reason do not request
> proper vIRQ (that should come from the secondary IRQ chip). OTOH there
> is only one _similar_ design in the kernel besides this one. And when
> I tried to test the version where all this appears, I couldn't boot
> (yeah, I spent some time on bisecting things) the board I have (One of
> pre-production variants of Intel Joule SoM).

Yes, me too. I'm trying to enable Joule on Debian. thus found this
issue. you can use debian sid with linux 6.11 to debug this issue.

and another issue is Joule HDA pci id is removed from Linux kernel, thus
no sound, but I don't plan to submit an issue.

> 
> Do you have any (most recent) kernel version that works as expected?
I don't try any old kernel, but from git log, I think bad commit is:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57129044f5044dcd73c22d91491906104bd331fd`


> 
> > > > > > [0]: https://salsa.debian.org/kernel-team/linux/-/merge_requests/1156/diffs
> 
> -- 
> With Best Regards,
> Andy Shevchenko

