Return-Path: <linux-kernel+bounces-202744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BFC8FD046
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F00301F24D0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 13:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6385ED518;
	Wed,  5 Jun 2024 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b="Hz8jm8bR"
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (mail-fr2deu01on2124.outbound.protection.outlook.com [40.107.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8619D8AB;
	Wed,  5 Jun 2024 13:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.135.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595904; cv=fail; b=UANxam0u46a5HFwgQY0PC+x1GmgU5r/n11g0FCsiAduAOoJHWWmAVH0YlJ2blk/igm//NPHS6mDx2FTugwDWoR3WtSmm/Py3GcCitx3/IH9dX3PFgLulzmsY6EHn78eBmKNFyecY6yW2LECeaY3nMFdsaPNYJbGIIZSWf65CKRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595904; c=relaxed/simple;
	bh=Qa523cvNYunF9epF6FswUyKmGyKOFcbQ/GU8S5EDq2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nIF/YiYOC+I0R9IdPtXJfLA5WJPjunpbsYIg/JGDFX+xIh4k9FAWCpa4WkaKO0LPG7vfn3Nxn2BFWBLHeNhHsKqk7g5UOv7RgGw0idEWIB6tzLuqQcRalNgDBKIF15CWXrwDomBILavqJD95OPdNR/JQPNDP6OklYTGyENBPDxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de; spf=pass smtp.mailfrom=eckelmann.de; dkim=pass (1024-bit key) header.d=eckelmann.de header.i=@eckelmann.de header.b=Hz8jm8bR; arc=fail smtp.client-ip=40.107.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eckelmann.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eckelmann.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqP+nxHXBhRv/7nDwZVFwnZH0s9cx5Oz+nW7AoPgRmY31uWXv9++I61FsuIUcEcmAOvrONbFi0CaUP92as6D+giLfufZ1lglQN99Ul7qdDxi1j708giheaFDKMpoNjkz+WIzGEKvqAxfEi5bru6+ZwFQ9itLGvmCefIjUdvSoBmhXZUlJq0NiM5ZSHvlKrdDiC9jMmPyTAg1w+f+a4JXaLHDU38Z7q6ShAySiDJ+KKgVwFQE9XIjpX7FKk2uNOayTRrp8VfUdVPdVyaXZQHgr/LUixE3Ix84DhEWPe2uj51ZRFo7wZnUvLsDuLKMZym9cgzebSHjH4vnWghLvwOnUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwlAsQ3RRsPhtd1NnZrfvJB/BeCvmWqCrF+YHdD1Pxs=;
 b=Ek3TV6avYzl4Jjro0GKRWjN6ls24GZJP4MB2Aw6L9XOqwdnolSBsqXM8pbFPJUlVpfkgoyO3HG2PBiUrzSuv+16Qmnk89HScdWGQ/QOm++wDc3dsMHjIwU79SSnWQcfByJeAC90auNpybBEMBE4ZXocpIE42du5IilZxzEfBm10n38KanwmiOWsjsB3quiz/J8Z2d21u2fVCunLGjTXBcAiqaGbwrakPrsFrIW9s1PYpP1OR6pzqNipm/oOLIjnIFZhREezNCn7aSpAxZpm4xpDF7Ar99/Qb626pfXkvHJPtutuKAhZy0mE87oZ2mhMExxJUUKRkqt8UnhITeYSMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eckelmann.de; dmarc=pass action=none header.from=eckelmann.de;
 dkim=pass header.d=eckelmann.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=eckelmann.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwlAsQ3RRsPhtd1NnZrfvJB/BeCvmWqCrF+YHdD1Pxs=;
 b=Hz8jm8bR95RwpWsU/WqtF14ZGFZov6R/qH66DLsSBJrPgE0m/AwI1kiwo6Zf90Mx89tHykBs8XJpjJPoQWAOXuh0ACDKXEXHSKmRIwzHS/d5o7t5jJeHAx63mqhB3HX0pNq9FN7Dga2sgMvovRBiHz6sb828zmETltSvhCpCf3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eckelmann.de;
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:da::13)
 by BEZP281MB2818.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16; Wed, 5 Jun
 2024 13:58:16 +0000
Received: from FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7]) by FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 ([fe80::3927:fe99:bb4:1aa7%3]) with mapi id 15.20.7656.012; Wed, 5 Jun 2024
 13:58:15 +0000
Date: Wed, 5 Jun 2024 15:58:13 +0200
From: Thorsten Scherer <T.Scherer@eckelmann.de>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Marek Vasut <marex@denx.de>, Imre Kaloz <kaloz@openwrt.org>, 
	Andrew Lunn <andrew@lunn.ch>, Flavio Suligoi <f.suligoi@asem.it>, kernel@pengutronix.de
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
Message-ID: <kl4ikwh4fpkhhlpneuujyk2j4a2byif7l27n7kgb4pm72hb4an@akhbc4jg6hyq>
References: <20240604074231.1874972-1-mwalle@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240604074231.1874972-1-mwalle@kernel.org>
X-ClientProxiedBy: FR0P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::7) To FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:da::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR4P281MB3510:EE_|BEZP281MB2818:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3b2fb4-22b0-44ac-d533-08dc85678bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?z4A+iw6TaV5A1B6xs3B1c3fMWmesqUjx5ejE+5wlPBDYIctLxVyPIhhzB5?=
 =?iso-8859-1?Q?87VwvdpdyEaHsYpFsMsKRDBEO8mIPWaPuVGF8zdJ+iDZEFQL4eVNIQB5ke?=
 =?iso-8859-1?Q?PoLzaX2deWlhULgoV3/tuv0bqcqX4qrKmgcHd8I1mNtmA1KjXvWzdMoz5J?=
 =?iso-8859-1?Q?rYox04jSrz5pQA1V9YxlXQ23JKXkgawKVuSoIac8bPAhHjhVqBAc1BsT4l?=
 =?iso-8859-1?Q?VjP8rqrx6+C547OA2rJPSEzvmk9E74q1bAOb100GE5umj7GXt+vefOYp1Z?=
 =?iso-8859-1?Q?UCjbhy7cn2nTGmycxPOMKqsA9wO4wC+dKlzJV1BPfdjMz1b1ONauSajvzx?=
 =?iso-8859-1?Q?cD3Xl4Zp4cYMrbUL2Jd+hp7bhDRfW2COP6H/LtN08J9Jf9fAVxPaobZODM?=
 =?iso-8859-1?Q?UjzcTYyRzcTXl0ZbUYQGpYjdidUNoCMfx2vfsV/x98Tj1unpR8H7LWDPt7?=
 =?iso-8859-1?Q?7godlLZV2Wf1zWFZSgzwZzA222HgZ4Z+CVyZF888kj85IQ4+p/bvNFwsTy?=
 =?iso-8859-1?Q?zTDDOwqUhimuC90M8YvUayVljZEbQ0YsILSYSGaJaGfin4HUyz9+pAC/B7?=
 =?iso-8859-1?Q?ZrMT9BpNHI9to7XKF7OE/YITGI3nexoV4vXbAm+i57lUyxBgrqyh88W49Y?=
 =?iso-8859-1?Q?EFP6tNy/DkpEjGyan8PQc9RHSjJ0XxUTxxtAeIzceWXOiOSNovV6OyIk1k?=
 =?iso-8859-1?Q?KaJLwZPcuc9avAONXuua152XlAG/PL3nAjXDH34vB6GH9O0+1cDOLtjye/?=
 =?iso-8859-1?Q?YzJMZX++6+CMcbsQhQ/a3q4dl0SLlZCEM4kbOcNuhqSONsUbhQ4M/+LfGR?=
 =?iso-8859-1?Q?6wbEY28X46J4GzKpJg++7RWupCuCGYkX/98YgSpL0jZBkFKryHtvMOcN1V?=
 =?iso-8859-1?Q?VK/wrjHJivER5Kjgu5xvdwY9EYaZybSsNXqD4GzOhA/bi39VYwD4oGM0cF?=
 =?iso-8859-1?Q?nGRIGxByY2zP3siEzh6KZ8d/mnKOHG6uusjhAOuwbkITPwgZe8Az3yW3rV?=
 =?iso-8859-1?Q?t+OcQmCo6zH6GKZ0rxDKCg23hVzYr0ViMeWDqa5GIBJ59K6kYgxVd4DCIe?=
 =?iso-8859-1?Q?/OxpeeAz++LB6ZAoyv7Xp+6+hh0JHdZ34nxSerXcE1B8/LIEgWdsIrqJB9?=
 =?iso-8859-1?Q?fj6W+qaXE4rk1TtcxyqnBvPaosWpEBiu1gQ+tMGZZc6cX4SVCWE62SuJpa?=
 =?iso-8859-1?Q?d8mYoxcPPVx2dOnxRffxiXf20Yn/n3N8AFgysEGmWje6+BgZZemCEoMgnk?=
 =?iso-8859-1?Q?Px1s3tclkc93Bbdo7B1CCVj4kWkoXQFB22XeImNU7cwyHlHfrXpwBwo8Cc?=
 =?iso-8859-1?Q?OMrOhhQ9+F4RFWabERDImcev6Bj88J/G0H/nq9unYuKwTdLGsR69NebvBO?=
 =?iso-8859-1?Q?X49W1rrKrw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?VPWNx8kTR4i5MiLtcQgPhetgtd+fIQExJlYnVEeldHJ1uZAGXzc3hd4pJG?=
 =?iso-8859-1?Q?cCheBTNla+YeRo6p2O1Bqids/8UQxNyh9yawL0O8pd5MqnjkTt8smusH/j?=
 =?iso-8859-1?Q?qBbbwGnZgI/o1D4ouTYVUUbN7NCwzjarG+9PypfhlTAa/bCRElDslstuyR?=
 =?iso-8859-1?Q?2e/TwFTHBwJKWNlq/xeHHBP0WubdIspD5mxFpMQJD3MbV8QEeYskx3+Kb0?=
 =?iso-8859-1?Q?q3iWyP8lAAz/59XM29hM/v1Jsv77Fb6+EmiE+2KsC/APRSBRP1DUB3cOqs?=
 =?iso-8859-1?Q?VGyx9vTbxWIVlBaB0TJWVGxQMONGc21GNcPE6LAn5PSBPLmdP91/9czl6h?=
 =?iso-8859-1?Q?dvR+QiFvshkS4Ay/fSYjMqVkZhunIVWPPuJXo/J5zKWbbgwxtQ2PsKng4t?=
 =?iso-8859-1?Q?O+it1Woc5SfVK8HletH/NmWAqUYWwARY6A4FQQuT8gj6CLvimIq51emYJ9?=
 =?iso-8859-1?Q?b1esgO0QOzqGXl1DmxhPPM6w7xsjzLAlBYK8DQHtPW1DfiLCJ+UplBjbjK?=
 =?iso-8859-1?Q?IE8UkMiFBaG7f6X1xdwZBUBrvftvhxhv6o22687xp+uuTv9DnT0D/jQ/JL?=
 =?iso-8859-1?Q?bwSlkan7GgtzdGFBHYT9NcG/x6y6U5a3Pz0ajJq4qQgLpH9BLlINne5YIJ?=
 =?iso-8859-1?Q?fo5I52GzyZogvUGtLCtjkTnsiPFuxYqp4lOVQIqXlsvH2Daq6h2r82I8gl?=
 =?iso-8859-1?Q?lpj3E4TC3gnGwmFNUCRJfNvN0wlNYSPXaVsG4lJLsqn1nvVNyIBssIemkg?=
 =?iso-8859-1?Q?DCk5iEPWRkxK3RJlJBGWxYmeiUUh3qT9YOLVGQW0nuVnuOO8JODOF2+e+J?=
 =?iso-8859-1?Q?/dUugaVgBcnY1FBxRgBrD4q/5pG+DKK58kdz8YaIIRfXld6/8drTV02ElP?=
 =?iso-8859-1?Q?lGIq7GWiBp1vEjn1ZAXHqrHiKAvC1UEJdGAf3lqYt2qj1gKA8ahrEebXWW?=
 =?iso-8859-1?Q?8CKRCAbehyH8YO10YXVd501PIZ3GGWz41YEUSybaVypUUtl1AmERewusOV?=
 =?iso-8859-1?Q?rIgdWDyQ2VAF70mu7bUjx1qK62zTFlqk8l1yHXgM1kC9/Jt0Irm4H5tjvk?=
 =?iso-8859-1?Q?CPGFXqn6Yq+Padr2rwNb3mSBVfGVvictOfUUsve/i53SDGCnfKBlERtqFR?=
 =?iso-8859-1?Q?xoEculziTVe3E6rXQ/ssOlVy9Bnq6LS2L1/4doKidsN7flV1EzHX8uvEpN?=
 =?iso-8859-1?Q?YBht8Pb5lpAFyP95J/dS0jBU+sAudjJ2NTL1gU5LQ2MhB5a81XrN1LTk/9?=
 =?iso-8859-1?Q?YJqqCeaTkaTAeKdrIwY/pGuJrhB4ZzxmMsGVRnxkhGjYDtUwjVt6EeGzI4?=
 =?iso-8859-1?Q?V0cdV+mdKTh2/ol22LJUP0E1J7EJSVyV0qPan9Lk3ePmk9PJyNNaGBZVro?=
 =?iso-8859-1?Q?Q5Ja2/apSx+Sqz2W2PVgegygBQW3T9dQ6cQYqbLagQRKAMaBrL10kmEDZU?=
 =?iso-8859-1?Q?0z/fY9nKMpvxSmDJf6VOPHy50legoJTeRsjbz9lfEHTNyShyGSyHoAQZdv?=
 =?iso-8859-1?Q?H+gqBcGJgCx41RI5Ee5LOsAGgGKqDQBT+LBQCuxZtxsLALNFTEbifVFWFx?=
 =?iso-8859-1?Q?Egy3fDUDwBPjT3FNnKY40p1jTmcyQ+1mIJUfD7xCjSfyoy8at8Jq1vK+Lg?=
 =?iso-8859-1?Q?m9yr00akZbQP85uaYw/G7txyvTPTJq9K32eBYPMPmztjToCqfnN3YR6egJ?=
 =?iso-8859-1?Q?/iMO3iDumhN5P/PTfyO65BUtpu2tHcLAahmAbUnB?=
X-OriginatorOrg: eckelmann.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3b2fb4-22b0-44ac-d533-08dc85678bcb
X-MS-Exchange-CrossTenant-AuthSource: FR4P281MB3510.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 13:58:15.4414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 62e24f58-823c-4d73-8ff2-db0a5f20156c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ant1Xzzqw1IoUKjbDo+yUKCfjleZhMlsenm/g21E/O9LVLgQzZMZw+X33LlAaqCSzI+y8l9+whOm/Cmv9SUbEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2818

Hello,

in the past I more actively worked on the ci4x10.  That changed after switc=
hing
departments.  Anyway, I thought maybe it's useful if I share my point of vi=
ew.

On Tue, Jun 04, 2024 at 09:42:31AM +0200, Michael Walle wrote:
> These devices are more like an AT25 compatible EEPROM instead of
> flashes. Like an EEPROM the user doesn't need to explicitly erase the
> memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
> (flash) driver, one should instead use the at25 EEPROM driver.
>=20
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

You cannot reach Uwe via this address anymore.

IMHO missing in this discussion is=20

    kernel@pengutronix.de

, which I added to CC.

> Cc: Thorsten Scherer <t.scherer@eckelmann.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Flavio Suligoi <f.suligoi@asem.it>
> ---
> The referenced binding only supports the true AT25 compatible EEPROMs
> where you have to specify additional properties like size and page size
> or cypress FRAM devices where all the properties are discovered by the
> driver. I don't have the actual hardware, therefore I can't work on a
> proper driver and binding. But I really want to deprecate the use of
> these EEPROM like devices in SPI-NOR. So as a first step, mark the
> devices in the DT bindings as deprecated.
>=20
> There are three in-tree users of this. I hope I've CCed all the relevant
> people. With the switch to the at25 driver also comes a user-space
> facing change: there is no more MTD device. Instead there is an "eeprom"
> file in /sys now, just like for every other EEPROM.

My vague memory tells me (at least some of) the domain specific application=
s
running on ci4x10 rely on MTD(block?) devices.  So this change would break
user-space.

> Marek already expressed, that the sps1 dts can likely be removed
> altogether. I'd like to hear from the other board DTS maintainers if
> they seem some problems moving to the EEPROM interface - or maybe that
> device isn't used at all anyway. So in the end, we can hopefully move
> all the users over to the at25 driver.

The ci4x10 is still being used and sold.  Right now I do not have a clear
view on the implications of moving to that driver.  I'd like to invest some
time to sharpen my picture (or find the person that claims responsibility),=
 but
this will propably not happen this week.

Hope this helps.

Best regards
Thorsten

> ---
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/D=
ocumentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index 6e3afb42926e..2dccb6b049ea 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -21,7 +21,6 @@ properties:
>                (m25p(40|80|16|32|64|128)|\
>                n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
>                atmel,at25df(321a|641|081a)|\
> -              everspin,mr25h(10|40|128|256)|\
>                (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|25635=
e)|\
>                (mxicy|macronix),mx25u(4033|4035)|\
>                (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
> @@ -42,6 +41,14 @@ properties:
>                - spansion,s25fs512s
>            - const: jedec,spi-nor
>        - const: jedec,spi-nor
> +
> +      # Deprecated bindings
> +      - items:
> +          - pattern: "^everspin,mr25h(10|40|128|256)$"
> +          - const: jedec,spi-nor
> +        description:
> +          Deprecated binding, use Documentation/devicetree/bindings/eepr=
om/at25.yaml.
> +        deprecated: true
>      description:
>        SPI NOR flashes compatible with the JEDEC SFDP standard or which m=
ay be
>        identified with the READ ID opcode (0x9F) do not deserve a specifi=
c
> --=20
> 2.39.2
>=20

