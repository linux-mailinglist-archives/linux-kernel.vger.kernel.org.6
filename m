Return-Path: <linux-kernel+bounces-329060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 330A8978CC5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582971C25424
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B07D517;
	Sat, 14 Sep 2024 02:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="A/p+zxtE"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010064.outbound.protection.outlook.com [52.101.128.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FB17D2
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280764; cv=fail; b=FpoFMY92eEVOEwdKjnpk0BW0IuLoWZeB84g2blNyGTN3z56X6IumyExcDKwokcQ+qrY/b7Y6Lg7rOYhtouUyW64vSyYvJnHQRUqy7/+pM6UMdZfc31atkdFj6FIK4uJTBjAjSXcqc6+eiJ97OihZUXOoVwckVh4cFjfgBTVXbVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280764; c=relaxed/simple;
	bh=1uRaZ+wEUKc74950pEMbb6q5lkYKy73Q+TuvmPnyJY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cQjolP9uQk8O7s83+iS8z5hVWIzicHUBOy+Fi+NCZxlBFtgdD3+1X4OTMxXNrYLQ2vjse83RchycipjbG3NzS5IwvclpNAtY6Z2BQ0JSU3CxQtocMoG1JHGDZxTG4bTWsONs+sjtT9WLPWRe4MkoNsBYDCj5T2A5XguBMORxhuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=A/p+zxtE; arc=fail smtp.client-ip=52.101.128.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoNFq4rOyVoZxGefZ5jxn0mrYVL20osXoqCgfWvDjfHOOCr+XPDf5ORLHMmEndYXgPTOOvu2uBtKqX1Emoyknh6fOZHxWKKqRRqVVnHP6KGLiCvzbb1iYoTYc+8tMlDEdyJPhC7HLDyO/9KlJEdZpC6g7smJ1wQrhd8G/DZDrBqTgGRJJoe/R1odYbZsm1OfeqrHUoPVqnpPJHuNdH6olwa5cX2vD9KLx+owJEfv9iXZG7gN76pN6lr6ISlVPzuY9Hh6bG8QeKinhbJDWe0PWyLSCJ86u+dbIB+r/ofE6Dl04wCL78HgV5cqxruab3BUWOG+K4EOR7evvawGFFLtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pio+PDgpZPTm5IaYPbHQozhDpQ3yA8h9lb/sdXdJxm4=;
 b=liMUPvPEGfdrckaFPPllDYLxE+kxmXvlCPkonsJT7UrGqqlKE/9Bgf9NBqgKtCYhzQ1fMr2hOQ58KxEQloKdlSwoC1upZODOgBhS6r3FxbP/qOXQS4AUOjvJnTS4NUp3YeG3nHHcENKj+gJQ41uEU9DUzZmgb04+lF93bYiLPMg5AspczDBsaIJzSnFWOP1/JhHOTaTuSZfY/LcBybHnBI4GxF4v15ELEDX3qRXYt6LX3uMgHsaZ1NjHAg2l/xiKKgWX2iPcKnVnWOtIEHgQrHDvY9eb8/GmHZycM2X3thM5U5taF3CMgmx0b9tDMdXdSJmJyPu02Ufpo4rllzNNkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pio+PDgpZPTm5IaYPbHQozhDpQ3yA8h9lb/sdXdJxm4=;
 b=A/p+zxtEe1uisVwj0Pr8flFCo1VwtCkSSi+VuoFu1TtteKuJbQ0VAsjoGVJjdKODnjvGUG0BnAxJkmBACqaP1r0K1rk9lYqTcw0pRTiuvG/F+4dnLIDI82lxYG8ykMVZtNSgJ04kNltCT0t+zRg+TykXZNEeUehR8G35He/C7yMOdFWUVp4xNWczhUo1NIC2AUxZfb1ncVUCEn2PyQvf1KzZwbKlhaZ+w+/3kz5FB3cf/eCLLWPoOy0UEe8I8ZXgd6K2alQqtUtHKDowlCrXh9rQl6/v/VmKbSkT/HcB0v4/Gnd21vcuDeifQ7Eu+HcuI5JJgmSJvOmwHBImPCUUpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEYPR06MB6454.apcprd06.prod.outlook.com (2603:1096:101:173::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Sat, 14 Sep
 2024 02:25:56 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 02:25:55 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Chao Yu <chao@kernel.org>
Cc: Wu Bo <bo.wu@vivo.com>,
	linux-kernel@vger.kernel.org,
	Wu Bo <wubo.oduw@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2 00/13] f2fs: introduce inline tail
Date: Fri, 13 Sep 2024 20:41:12 -0600
Message-Id: <20240914024112.1069698-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <679c7dae-91c4-4ad0-a2cb-55dc92b47fd4@kernel.org>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0191.apcprd04.prod.outlook.com
 (2603:1096:4:14::29) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEYPR06MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dcc8640-60d3-4344-1c96-08dcd4648fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mqdC6e1sL+d5on4xJmK5eryn8uD/rm5EG9pxLecuk3ZwJayj5ZkD768AqC1L?=
 =?us-ascii?Q?wqsYe5ly0MEnYg6aLkfxIaaf1H7ernALInA2EVh8LWCw/Brv5u0qUeY3kM2x?=
 =?us-ascii?Q?kL4GDS1LcmbrSCaHCAQ8+xv8/xVACwgfByFIM9cxbmS5iGG7uikhuwmAGkvG?=
 =?us-ascii?Q?VhJRQsBwCqtAbLDV9p2rsT/fs5aAWUudPi8N7M6fzI8S735LW0yHe2DSOLgD?=
 =?us-ascii?Q?JpdmMcxMQ+wXbKjnCY5R9UOwOzmRroZ5/PmA3523VlEkExexJ//9H3+nIFIm?=
 =?us-ascii?Q?y88A6KHamRI1NLSaadhN+ds6zDMBEpCPnQjcCtK3FVrxUVoywIJ8980u3sFD?=
 =?us-ascii?Q?aPviMiLhGktNXx3Euwp1tE+/utFam7IM86baHfk2bfPgbE8a+kPWHppn/CIn?=
 =?us-ascii?Q?radViho8rHi1ghwLiH5UcKNynINgp9MiIcUDmV3LurNaeEeG1XppGjcPDaee?=
 =?us-ascii?Q?aZ3mfCmkD2xg6McfrLxSsHxTolrxEe16RjVRy+Qw+5i9ATH1kP4DO9oFKmaZ?=
 =?us-ascii?Q?kvvLIfajEkndw22PenG2SzRlVE8ewr1GM77qtyrTNXEBBi9/gp3vMkZJk8bC?=
 =?us-ascii?Q?0n2stcUNAtIUhZcyp0fxFODj9iNFTwQ6S3l2Cms6/0397sgHd9ucaWVOZOeS?=
 =?us-ascii?Q?rDjDZ9uS9iNsccYqvFlneNIj1Vt2VhHY1YXkW5+TYSsOCITIypUFTyNpeAMU?=
 =?us-ascii?Q?OjV6GeCe4ygFPjVqEZNqtVj2u5WOjj7PfkmLkGIe2DshECjHxWup1M2Pl8MJ?=
 =?us-ascii?Q?IROL0L4USZv73By747P2MkfBObxbUxyny6fyaPKfY1hX96Z55Oe+Qfmeii7Y?=
 =?us-ascii?Q?0OL1m+cplqfalVAMdR8WCs9VkGPgEaOI7Te8SLAjFsMdPFYBEaoIqxWwwc7T?=
 =?us-ascii?Q?/x+fU0LL8o1i7/J7lHeJ7OBFPF3jVmH7txvBfSqA4Ijj/vdPkEfqFuYVdZND?=
 =?us-ascii?Q?F4NWGfvgMXKmQkF8Z8pQLXNOAuKbdJw1VWN7htkpMsqelNPM4pw6Lhpz1r4G?=
 =?us-ascii?Q?kewimrYvqqv1AJbttXcnIC1W4dBQmxkbvOQRqoiXNcGmTLgifR/TTn5D9OzW?=
 =?us-ascii?Q?vGgsbhuLR69N6fybSXyKYSuot+V6oDOlG4VczJTqFq5Vr9ErNmwufTU/lVyx?=
 =?us-ascii?Q?8W/OH7JbaVhN2fdU3ojH6VCiGM2+vusEnfXqhul+vPJbfjfaxvyaaR/R2nGa?=
 =?us-ascii?Q?ASOjwWyTp/q2rbu2XLuezUpWDoGtMvx7f3cMuom8nPkzS0HJPI3e8XU2187q?=
 =?us-ascii?Q?V+xA4wlp5G/0c/l0LUsO6pEMbJacCvJKvKEIshGCfQFZK+9WpnOIcBQqnfwa?=
 =?us-ascii?Q?tPgY9Y0UTxxJeN83U3QmZbCJ4BJMdBqgtxGnYMpTTPBlhifs1IK9osyiKEs3?=
 =?us-ascii?Q?+YT933ocABr4zYBr03DYpHdhlgC11CiWPyWAx0jjqoI6puU+EQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1TRy5MAFYn60EoD6oOOy9UrylNwIBIfWaGWKlggZDL4Nm97K3d6Tjas3pqCF?=
 =?us-ascii?Q?7z/D0hcW6oeOnkgtRNFDODZYQpV/rrD5ZDxo4h2LrBXO2gu2hyHHPOqRipoo?=
 =?us-ascii?Q?FQMWlY43ieHaxMY5X5vR/fUYmT8iCgGbaG17+7vmsTBOSSHYyeCEoDSKsktB?=
 =?us-ascii?Q?6cvnhqs2bJz5oyVhAoaKMVW7VGYRylNXEIZZVAXekY5w16aGWl585Z9fDTXN?=
 =?us-ascii?Q?qBwI583xi2IzKn3glfiR8M92ypd6ydJcRsuvBNZdPgcASen93v1I0q/FNe9M?=
 =?us-ascii?Q?plKloq9wz14MBzb0iZAoySC4EA1kzzq2JV+akn/KBLQUpsolVuzFtnyihMg5?=
 =?us-ascii?Q?IZao26KrIXbdlxl8HZI71r5NktMkBj0iIrWCcFV4U5ZKRFcCCMlWrqqbRlxl?=
 =?us-ascii?Q?1pNP8ZeJtblTyQWyHCjnBDxkqBmg07no1zgXvuot6dsOZ/pnHohUz6nN7slK?=
 =?us-ascii?Q?ume+YxbhwT0Kl9G1/jQwuO3lFp1O6uhSU1HJvCSQwKUzoDG57IeRSgDncgcU?=
 =?us-ascii?Q?FKlK9CBL0xXiItW1L9TQwrFv1YzBgbmSu19zx0mnEfItyixxIs2jztjDOJpB?=
 =?us-ascii?Q?IXyBm/RPt4tE7TDcYglipBAhvnR8hHfzqWEwN88gW/ecSjhD41urRcQiWAJI?=
 =?us-ascii?Q?knoTYtp14PAm3gr1llJ0GTkDyhdWXLoK++gz+9FV5TENQhLqCws42gj5x+cH?=
 =?us-ascii?Q?LaZTZGcQ2OTAthMQk4Z1OzMjPaG6uLZk4SiKaKgVYB3aXpKcocDEHucptWvW?=
 =?us-ascii?Q?xJFDT/48gADHnYGeTqZzkmIw+eTXkiB9wR5qe4ozhanVhQZl1YaUaX6Rk3Er?=
 =?us-ascii?Q?/lShpr8XmKnSK99x0jefmeP1ov/DtgNU+kq4DO12eR4wUWPPTUqRShn11/Dh?=
 =?us-ascii?Q?eUnz2e67yUuovLGh1kOaWwZe9i+ElICVHE/cFm6ONEszCSg+d+ZyGEQ68+Dg?=
 =?us-ascii?Q?V9AjsYRNePMRlXDa6Olc4+jkP1NKcAchxoXb8f9lh8mKbV5axh/jeAbGR1Sj?=
 =?us-ascii?Q?0E2oGSmFS/Q26qrskqTfL/nSXtmsP3dqYPwWTbCU1oAsWT8ywuB7kZTzDZ4D?=
 =?us-ascii?Q?HS2r0JcpOF8GxTZzKKCsDQKmva5IMWyQ7gdrl1pMtfRakGC4TsQK1gr9psUO?=
 =?us-ascii?Q?vW54tVEa19OJ0XU9TABCQiMBIvVK4mj0tgDk9hrjEbOePzgc6z2hk16jgPpz?=
 =?us-ascii?Q?z4RuPmIuY4oBIbkOG+MiDaOM83SZSbyEG5txbzBYXSWIQCskTpGNuUejfbEd?=
 =?us-ascii?Q?PTXyC8phaFXVyX+IYXq0XREYSw+9zwGoVbMARnDQe4Bykt9JpQM3K/bmuRsB?=
 =?us-ascii?Q?QeMCmtwICEldQ1ONG1HFoKFgjx7UGUlT11woyRem5uodofcL7WdIFpwwsA5l?=
 =?us-ascii?Q?b22L3kqt49W0KoaWIvX+88kKIyE+2Uy8kJjMXJNiDbyCLOLH85H1qbniy32S?=
 =?us-ascii?Q?6WFB7DikiaJzd1QsN3QpPoqfNURDgYQNeOTIskJVdEGuZ8uIUz3lTHV8AvZ6?=
 =?us-ascii?Q?2IVvGL83RR79o0sFjN5R1YsT/R2epv5VcQfD83D7p6IqmlzPwF6zTYCtph2p?=
 =?us-ascii?Q?F+sBpm/Az89qSiZIU3+0zaM1Tw6VyUohsEefk7pT?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dcc8640-60d3-4344-1c96-08dcd4648fd0
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 02:25:55.6573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xM6Ya2yZT2DWsA84gEiQL62Y+sWP8Jtulxhy7jU+UtlWwguNHorpr64lDnSTApJoyAUTsP9V5KdlxY8UJ1hqUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6454

On Thu, Sep 12, 2024 at 03:14:24PM +0800, Chao Yu via Linux-f2fs-devel wrote:
> On 2024/9/11 11:57, Wu Bo wrote:
> > The inode in F2FS occupies an entire 4k block. For many small files, this means
> > they consume much more space than their actual size. Therefore, there is
> > significant potential to better utilize the inode block space.
> > 
> > Currently, F2FS has two features to make use of the inode block space: inline
> > data and inline xattr.
> > 
> > Inline data stores file which size is smaller then 3.5k in inode block. However,
> > for slightly larger small files, there still have much waste.
> > For example, a 5k file requires 3 blocks, totaling 12k of space, which is
> > more than twice the size of the file itself!
> > 
> > Additionally, the end of a file often does not occupy an entire block. If we can
> > store the end of the file data within the inode block, we can save an entire
> > block for the file. This is particularly important for small files.
> > 
> > In fact, the current inline data is a special case of inline tail, and
> > inline tail is an extension of inline data.
> > 
> > To make it simple, inline tail only on small files(<64k). And for larger files,
> > inline tails don't provide any significant benefits.
> > 
> > The layout of an inline tail inode block is following:
> > 
> > | inode block     | 4096 |     inline tail enable    |
> > | --------------- | ---- | --------------------------|
> > | inode info      | 360  |                           |
> > | --------------- | ---- | --------------------------|
> > |                 |      | extra info         | 0~36 |
> > |                 |      | **compact_addr[16] | 64   |
> > | addr table[923] | 3692 | reserved           | 4    |
> > |                 |      | **tail data        |      |
> > |                 |      | inline_xattr       | 200  |
> > | --------------- | ---- | --------------------------|
> > | nid table[5]    | 20   |
> > | node footer     | 24   |
> > 
> > F2fs-tools to support inline tail:
> > https://lore.kernel.org/linux-f2fs-devel/20240903075931.3339584-1-bo.wu@vivo.com
> > 
> > I tested inline tail by copying the source code of Linux 6.9.7. The storage
> > space was reduced by approximately 8%. Additionally, due to the reduced IO, the
> > copy time also reduced by around 10%.
> > 
> > This patch series has been tested with xfstests by running 'kvm-xfstests -c f2fs
> > -g quick' both with and without the patch; no regressions were observed.
> > The test result is:
> > f2fs/default: 583 tests, 6 failures, 213 skipped, 650 seconds
> >    Failures: generic/050 generic/064 generic/250 generic/252 generic/563
> >        generic/735
> >        Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s
> 
> MKFS_OPTIONS  -- -O extra_attr,encrypt,inode_checksum,flexible_inline_xattr,inode_crtime,verity,compression -f /dev/vdc
> MOUNT_OPTIONS -- -o acl,user_xattr -o discard,inline_tail /dev/vdc /mnt/scratch_f2fs

Hi Chao,

I used the default cfg to run xfstest-bld and didn't encounter the failed
failures. This suggests the issue might be related to these additional options.
However, I'm not sure how to include these options when running xfstest-bld.
Could you let me know how to add them?

Thanks

> 
> Before:
> Failures: generic/042 generic/050 generic/250 generic/252 generic/270 generic/389 generic/563 generic/700 generic/735
> Failed 9 of 746 tests
> 
> After:
> Failures: generic/042 generic/050 generic/125 generic/250 generic/252 generic/270 generic/389 generic/418 generic/551 generic/563 generic/700 generic/735
> Failed 12 of 746 tests
> 
> Failures: f2fs/004
> 
> Can you please check failed testcases?
> 
> Thanks,
> 
> > 
> > ---
> > v2:
> > - fix ARCH=arc build warning
> > 
> > ---
> > Wu Bo (13):
> >    f2fs: add inline tail mount option
> >    f2fs: add inline tail disk layout definition
> >    f2fs: implement inline tail write & truncate
> >    f2fs: implement inline tail read & fiemap
> >    f2fs: set inline tail flag when create inode
> >    f2fs: fix address info has been truncated
> >    f2fs: support seek for inline tail
> >    f2fs: convert inline tail when inode expand
> >    f2fs: fix data loss during inline tail writing
> >    f2fs: avoid inlining quota files
> >    f2fs: fix inline tail data lost
> >    f2fs: convert inline tails to avoid potential issues
> >    f2fs: implement inline tail forward recovery
> > 
> >   fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
> >   fs/f2fs/f2fs.h     |  46 ++++++++++++-
> >   fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
> >   fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++------
> >   fs/f2fs/inode.c    |   6 ++
> >   fs/f2fs/namei.c    |   3 +
> >   fs/f2fs/node.c     |   6 +-
> >   fs/f2fs/recovery.c |   9 ++-
> >   fs/f2fs/super.c    |  25 +++++++
> >   fs/f2fs/verity.c   |   4 ++
> >   10 files changed, 409 insertions(+), 27 deletions(-)
> > 
> > 
> > base-commit: 67784a74e258a467225f0e68335df77acd67b7ab
> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

