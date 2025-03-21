Return-Path: <linux-kernel+bounces-570733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD9FA6B404
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DD3189C749
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DBA1E98EF;
	Fri, 21 Mar 2025 05:23:29 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2130.outbound.protection.partner.outlook.cn [139.219.146.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752101EB198
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534608; cv=fail; b=pL+JpowQhiv1DpRg+O4mwmr4/k0d2a5czNtTvVpJHYF+8vsNwhoF+G4qoRnWZEHbQqrr3c+HR8HPoP0ymU9s60+3tKCow3DIHibWFUeqVakf6J+fllgizcXHulzMD6ZhmwCKvopSzh4/jG3SvwzL+4jr/2ZFIdZSMu4FzL4fUjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534608; c=relaxed/simple;
	bh=flCUevHnuxzARGPEDqeJ8TnyXYBA0Znchg+HcEXeBd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o0neuUNbqr8q0KHR9gqbMSWcMVQae4hLzZWtrGLPPL8+oiLbFRE1aMW8s8eL1fgYeCrag0UdIvJv2LbF42+C9chLNBdoBCaokUV9fTLh7boebDHMiPXcbGPNMpxyeC2oiTZdLaksq7/dojeGpufPIdlCxxZp1WgzDmKHs5OF708=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbXAYphOXZHAdikQeiVhG4yCHKcqTPNsEn0FhUdrRhX9qTYxtVXMNM8RWnbEKf6f6Nz7U1OsEPQAPFDTm5TvSK1O8JZCgq4DrS9VO/alWIhZ7x2VEgwo7tplJIv2CnHwAazJnQrHUCiQfRFfnzY10OOjVFGHE9ueVOv4emg9T8TNLaR+TW7aNTq30nAmTWBzluTEK1Y1SOHBnOuLTmqC/BdjVmHYyTk4zHWf6ioTNy704JfGhI9erar1OhaemYmGBP1uQxBFKTyrV58dBhy+kZMroN/jJ6Hn1Z4jowmOBZkRoEd3lBmfF8pAsV43ofaCac3hc/7otAgYvxq3zhF0IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flCUevHnuxzARGPEDqeJ8TnyXYBA0Znchg+HcEXeBd8=;
 b=iQhTZz1K9c9jjQSuE2Ir6F+HdiOeQQNQd0dK1I1GCXD0kXgGU+EZ14fQdmAslAJ945iXRpqqi2OaGobTVHCdv0+npduNwgAl5oz7ocSql9ri2nmbg17pF1SAHaQ79Xca/NNEftFPhw2rjljPMPBi7jdNTKftLTfNKfvA2PTbubtFka6GiYKfDKY+nlsDQigWd0wLao5GoXekm/clndMu87P4rd7pZBKXYQfHmCCV6AOGYpij6q3CQbWmNJFQnTG9V0oyL2moKBJWAuU8ReBp8IvaMHzodkBdhKXhxzvThng4uVeILPyO0FPLOFft9FdI1xGPs5dOx7iJ6VK5AjyjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9) by ZQ0PR01MB1031.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.31; Fri, 21 Mar
 2025 01:49:21 +0000
Received: from ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 ([fe80::64c5:50d8:4f2c:59aa]) by
 ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn ([fe80::64c5:50d8:4f2c:59aa%7])
 with mapi id 15.20.8511.031; Fri, 21 Mar 2025 01:49:21 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: jirislaby@kernel.org
Cc: aaro.koskinen@iki.fi,
	afaerber@suse.de,
	alexandre.belloni@bootlin.com,
	alexandre.torgue@foss.st.com,
	alim.akhtar@samsung.com,
	andreas@kemnade.info,
	andrew@codeconstruct.com.au,
	andrew@lunn.ch,
	angelogioacchino.delregno@collabora.com,
	atenart@kernel.org,
	baruch@tkos.co.il,
	bcm-kernel-feedback-list@broadcom.com,
	benh@kernel.crashing.org,
	changhuang.liang@starfivetech.com,
	chris@zankel.net,
	claudiu.beznea@tuxon.dev,
	daniel@thingy.jp,
	eajames@linux.ibm.com,
	festevam@gmail.com,
	florian.fainelli@broadcom.com,
	gregory.clement@bootlin.com,
	guoren@kernel.org,
	j.neuschaefer@gmx.net,
	jcmvbkbc@gmail.com,
	jernej.skrabec@gmail.com,
	joel@jms.id.au,
	jonas@southpole.se,
	jonathanh@nvidia.com,
	kernel@pengutronix.de,
	khilman@baylibre.com,
	kristo@kernel.org,
	krzk@kernel.org,
	linus.walleij@linaro.org,
	linux-kernel@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	mark-pk.tsai@mediatek.com,
	matthias.bgg@gmail.com,
	maz@kernel.org,
	mcoquelin.stm32@gmail.com,
	michal.simek@amd.com,
	miodrag.dinic@mips.com,
	nicolas.ferre@microchip.com,
	nm@ti.com,
	paul@crapouillou.net,
	piotr.wojtaszczyk@timesys.com,
	qinjian@cqplus1.com,
	rjui@broadcom.com,
	rogerq@kernel.org,
	ryan_chen@aspeedtech.com,
	s.hauer@pengutronix.de,
	samuel@sholland.org,
	sbranden@broadcom.com,
	sebastian.hesselbarth@gmail.com,
	shawnguo@kernel.org,
	shorne@gmail.com,
	ssantosh@kernel.org,
	stefan.kristiansson@saunalahti.fi,
	talel@amazon.com,
	tglx@linutronix.de,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tsbogend@alpha.franken.de,
	vz@mleia.com,
	wens@csie.org
Subject: [PATCH v2 21/57] irqdomain: irqchip: Switch to irq_domain_create_*()
Date: Thu, 20 Mar 2025 18:49:10 -0700
Message-Id: <20250321014910.4881-1-changhuang.liang@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250319092951.37667-22-jirislaby@kernel.org>
References: <20250319092951.37667-22-jirislaby@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::7) To ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB1302:EE_|ZQ0PR01MB1031:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5e90eb-b248-48c1-b087-08dd681a997a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|41320700013|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	2wtQXeVgvORC58eu5YRFh3qEakw7KGR/aifOmCu6jm35iPVzfMninPlQQenopt+apxrCEK7ctO9F808FECjq5dW/XmkePknIAgY0Ged2HlSSnZkmfbK7hBNnAULv5PtOMnXx1fpevmqI7EDhLeNw9eMxJNj6pbSaZeQbY8lg6twEO41qe5yHAILY+BMo8OSztihHFUK0qzuri+WPYCm0eqJttNX8izmKQ6he08/Jp8YjPdYzXgxaRkX5oRIn7bzGH2OvmQVuYdjAi+TwAa40pJxhgkzxhBCeFCE0OIOoM02CMf3dEpsea5Xl4rtZzs5qoBAVlNu3Tk5MrD78A40+FA5VsbRfhmwywBun7ByZBZ9w56DPa1/H/cXCKJ/aJF/WTVEW4oiwSnJ0mn2Q3MtB+ClV0fGPJIm8JQW0+5lwK4MSy+jD5vC8aELUzYZXFEvP4rpDMwpk9qFpHlGRKNEdSmiLLmiwH/9CZSxlVnCq3ZsShL5YUS+Sq3wD6Uqkh9InzJ1jx1gF1sqn8d4+6hEpPMzt97bSP8J6V4s2wTNi73Gqz2I8I3653fOM6SKklscarJuaQyxAVUjdnadbTDg04fySr+3G5yIw6w4R6gqcJEo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(41320700013)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhUeN75Te7I0dqzLT6YaaRTwt6JJOWHVQ2Qs4oLwxN0TEZ3NW1WO6SXgzSKz?=
 =?us-ascii?Q?MfU51V6VgEpWAmFsM0LfyWVRt+vcN7a19/EUbqyoKc1Zl37Tz2Yb053KztE5?=
 =?us-ascii?Q?1Rup+WvX1UbNfZcngPqy9JjRUxQSG/I4GsagGAZKqKPg0tY/EATOO79FUtRr?=
 =?us-ascii?Q?tD/J9bFzBghVnb36cWDYS9PUGXI8jcS/CfVWAJzPGFbrG02Zop2s+GIdk55O?=
 =?us-ascii?Q?M0ntA6x/3UdrgBbHXE8vi2zF7th3XvZAwDn1dVikCu1t/GUla7t275oaQ4J7?=
 =?us-ascii?Q?wUsCGRy+qRcSxBBa8wdenN0axPNbTCKat8cKsQkbjYJGgCkaiU1FNzxeRZwA?=
 =?us-ascii?Q?KdPArzpxiRj7m+om/3lmpwHD+8122UAg+JvJDlbDYqKmvahP+D+h9Rez1ZYv?=
 =?us-ascii?Q?ewz8WbuH7R5aJKwyrI4wCsHn6KUaXfYguxxqe5T+f8dlEP103Ia8BwcKp36s?=
 =?us-ascii?Q?p6aCErrb+g5IkwNA7f39MxwCUIZDcJgPO2eCJTShnphwA341W5AMpWpG8/Ht?=
 =?us-ascii?Q?f7FTaD46oAsKaRFQV95qAnHf7sG6atI1w01nZh302gIy12TV+T1+GR+XP4hX?=
 =?us-ascii?Q?6HuiRjvHtO+cu/GO3PHnJy61/6gD6GfLJYAbJcyTt+329EYC6FO47+LrxTfe?=
 =?us-ascii?Q?FT4n6YU5OVWF6ufGxT/z45urBlemMmAlGYXnQxc4a52RadRHOB1QhU89kvWc?=
 =?us-ascii?Q?8eL5kgp7TP+9TD4LdOj4Yv+n9r3YEW012ysObig26Y9S7MsKCIvf2+w+/9E2?=
 =?us-ascii?Q?ZOVJ6WTcaH9RzjwjYFUCSgHbWUe31Y4IFRyAECiM+FZyXriienISM6g2utlc?=
 =?us-ascii?Q?Ch8/uu76EVlFay9iqwGunPZeQ5d6R+ZIDnwvR6DvGcVGrpK1yg4ySn42eLMy?=
 =?us-ascii?Q?iSTiqaJDlTx01JjbpqSg42Q0x3zAYcR1yt4ZwK12F55oweUARtdP3KmzNwzp?=
 =?us-ascii?Q?obK2Vql5TqjwCJjgHDsz2tmztSq8CsXIRkbwKKcpJGuEs0xRwFd8zucNrQuO?=
 =?us-ascii?Q?mDqYYD9ZH7miqs3RKfX2yNRrZI6iggdWuqLfC6qjuEW1mJyVIXlw8Tbwv5h2?=
 =?us-ascii?Q?wSjl2w6xwZY6Zh0nKL3tz036whSCgBTYa7MjqminxgQWGXlqYacnpM6HUCJl?=
 =?us-ascii?Q?yoXYY4P5K7jEKiqkOHOCGGeAr2ZLHST6TxvplaqGe0HsgD9aZ7zhvtyYrC6j?=
 =?us-ascii?Q?eba7oJlS+Xtk8l4mfXn+3C5ZHEMLrmTrdfS63+6/dYRN8Ay9/nMWBgJyzo3d?=
 =?us-ascii?Q?ijya/SUnvu2jk7/UuNf95/F6DUxa5sWnnpA/ktzf0ofEnCEySJE3AqbfB+8G?=
 =?us-ascii?Q?cqf03BvP34sPqY7qIASedrktuuXEPnr4E96pQW+hz6MOifxHWhKDAkN1yXjT?=
 =?us-ascii?Q?MOLnBbKI+ox4tmO4xTz1PyvmjZae4xdgh573M4URGgPg+0P1BBnUOmv2LGeg?=
 =?us-ascii?Q?y+JlUz+CYjtOKCoNUdzlO5cH7Wczw5HAuBGw4326k4UpMwhznFyi9h6g3dAz?=
 =?us-ascii?Q?LSIKtGo3NEOjdg91uzJ/XB+b9ddTJ/rKI+qpl1xHJJab2y29poIQ9hdJ6xS3?=
 =?us-ascii?Q?tHyyC/SyzNET/oWzX8SCqTbhCqljvXqi8foN/cxEBp3V+L9mYV+WyKUN2VYf?=
 =?us-ascii?Q?kvPbJ7fhYo5oiQglxlOwEJg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5e90eb-b248-48c1-b087-08dd681a997a
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB1302.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 01:49:21.2384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tg2jGYCCdoqpFvUXna0JyqJOsCn1DIzt5EQbYKt9ONvIRNe+dEtdCZFyjI5UpkA3i+BwW7faprTpEeJvfJMtjfRWVVtE1RKWZlIHYAjS3N6cOGAmJYCDLzNcS9+W1ACJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1031

> irq_domain_add_*() interfaces are going away as being obsolete now.
> Switch to the preferred irq_domain_create_*() ones. Those differ in the
> node parameter: They take more generic struct fwnode_handle instead of
> struct device_node. Therefore, of_fwnode_handle() is added around the
> original parameter.
>
> Note some of the users can likely use dev->fwnode directly instead of
> indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
> guaranteed to be set for all, so this has to be investigated on case to
> case basis (by people who can actually test with the HW).
>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>

for starfive-jh8100:

Acked-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Best Regards,
Changhuang

