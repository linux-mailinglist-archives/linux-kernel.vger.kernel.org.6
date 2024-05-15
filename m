Return-Path: <linux-kernel+bounces-179643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EB8C62AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC32281EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCA4CB2E;
	Wed, 15 May 2024 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Nx7FRiyg"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2042.outbound.protection.outlook.com [40.107.255.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5FE495CB
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761143; cv=fail; b=kD8wB/h3cnIsMhil04sMRSfiPFNAzhKDTfUf36ZpvY9SoTzb0anDynHgavfp7qAcs8MA66uowtbEodfth37frGR9aQd4Il2PUxEE0YLS1+RaLsUAyr33UxGlMc5kPGS2gXXuGSJ3tolM9nL5JZB68ISKKajtAC6OaBCmt1Llubw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761143; c=relaxed/simple;
	bh=goq9FJJADDPVc9N6gqvoxl19lEkJBBqL4D/jbukQG6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sNbF3vMXv205Ami+eed2gAbhMH12eX32wr7wZJ4GNx9w8Wtb/QFFMPeSqWjCkCMv0RZrOVQJ2rUUUSTADcX/wBhfFlVmQhuHC2oOYFhCwPCgFt0SZoQgCvOPhW34atteTTPuOqF/RrgEY3wOInPS/TbBFx89E75274NJxlkVcLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Nx7FRiyg; arc=fail smtp.client-ip=40.107.255.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSeB+s2VTOqOYVFza1RwVKg/NnZIk4M1sjcRFYszZOOOomvdq+Bg1Nyjw5gWzoq//N2p4sF95z0QA7fqajq3qkfftTeSERjqi0qlKp3TU+/Q9r8EYm87hSOi07xg4XtKICP+PCDn5IWSwMhAt3Hl98+kxA9o+R6fn+3/Fq4TfMzhbaIf/JFmrozfqUTl2e0WqJDYUPfPPdl2Ap7Ei6IQ6CoGPoxCTskIV0ilp5lpWjYA83yIgJ62ZMJBFG9+Hy6uNr2c2c+fvmCjKAAe5zZT3BbaNNDSCOqQbYf/qe8SLaYwRNNTbnHTf5Il54RHt6IgiBxqr36zw40zTHFxUG9r3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbFyjNVGelCwLfedlifeGWAHCQ8q1btaMqi6L1e6Fag=;
 b=NLkb9j86AWxOZ3QCnP90i9FLT6scW6f+jzbFEGWXoFSwNEUQ2JkDMtvtCjewfYUdBTfUL3p4z6auw241U0a69NXvNpxT8Sr1D7cR5fCn8FR+JFeSnKTIGdYEkyhQDDchn6Y7A0y5SI6SVDK96LeBboXlBEi1+pYFOTJD+dNDLxS0pnOm9YA9rGA0BlvK/S/1fUrQGBkJpCHG5avYtw8U/ClFUWbWHStEZKllhUJFKTFn7KCSebsEUH6Z0ee7+8voTmy7CAcWJBhbEz7zoHIt+9SslBTbxh+KU9Jj8XdSz6skwIbjWwBjvGxFuchqPvamyzzNTBGNWK5DLS5U3xDjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbFyjNVGelCwLfedlifeGWAHCQ8q1btaMqi6L1e6Fag=;
 b=Nx7FRiygVvhHqupFeJx641KBnecwNwcadbbN6VtWyvc422P5Yh3GO5Q9ihUJRZYc+xX+U9w/Nmh+3vbm5bx8WOjQpwluBaaStYhriEDNVCm5m8/4Lo4qYaKNj8/QMnBHgyjuCcT8U0F3aICCSyNNubRXSWt+CEn8s8rRU8pmp7GVoP1lSerrBTOGMrqcegPb9ivRSikVgkl543bpJF19tLpMYCGSNs71J6zQVfcD/RsyjUwPjYDd9w2zvftoY7B6Oc+OZvOeONFTqXyegLadp9krg8dNt+Qou2KXYriuIzsPA1g37fTzZ4wljtFFbftUkpKCoAKibwq+qHh3F26fIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SI2PR06MB5044.apcprd06.prod.outlook.com (2603:1096:4:1a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 08:18:58 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 08:18:58 +0000
From: Wu Bo <bo.wu@vivo.com>
To: chao@kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix to avoid racing in between read and OPU dio write
Date: Wed, 15 May 2024 02:32:19 -0600
Message-Id: <20240515083219.1601289-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240510023906.281700-1-chao@kernel.org>
References: <20240510023906.281700-1-chao@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SI2PR06MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: c39aba8d-0796-4560-0434-08dc74b7ab21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ee4fU4J1uZSje5YKH2d1MUi7e38J7XSvz7ciDCyQvR8Ql0x0Tojky0wvVrX?=
 =?us-ascii?Q?5CyV6qM1/vjG+JrSqmp6mLph0HmpmsE91wePlDuVbWpo+244Zh9452gc26Wh?=
 =?us-ascii?Q?AJg8hbCna1VlvPPdajRnGEoacc5yalnUQ8Y2C2Tcd5ZRLnKG25NSbU+RiKTa?=
 =?us-ascii?Q?6ou0qTsT41L9ibgwaakuB1WhTJ5JvLhUhL31/VAViT1fwPLP+RvD6PTHQLIo?=
 =?us-ascii?Q?CSVSfbhlmd7p3hSji7JLBXfhBgPhrNes6oWFfzPb9prYhVIwh0Un+qCBfVzY?=
 =?us-ascii?Q?h0uXjHHAADikSSow1g5E0wX/QHG5o5oabo/3EwF6QBieIJUt/1Xh/uA5l8OD?=
 =?us-ascii?Q?ciZiLebD1FHnSzOdYPtGiMh7Q9wCkkprY+apEoXnj2QEbfjTjHG1GinqpV0N?=
 =?us-ascii?Q?z2N+fd48x1kmWvoOcIInTgvkMSUZJ9vhYaKzK+Sjx7yYulhNrFQzvG7Woxae?=
 =?us-ascii?Q?msf3Ui0KSo6u6ZQBdzFldZR5HSgLKuB4xPMb8uJcOqWTvZ2IUvq5YzlrKmZ6?=
 =?us-ascii?Q?bTVtU5Rmi1AvqXIWdOs5MLm7WiG7sukRumt5IYleMkhlvnLM4hQfN6Z9VcKO?=
 =?us-ascii?Q?afKMG6jxq4YxI7s7uLNUC7ZgdN+jerxeGFMADKaMiwVRUCaWHI9oBt+4fM6w?=
 =?us-ascii?Q?8c+PVXA+iBN7YFuEPD/tcEkP/HLlnm0eufBhHGa7KQNyN7MMA9Qfo5p+nx+U?=
 =?us-ascii?Q?BOOe0J6DhqomirWunoFCcb/vFOAOO4rZgzfaOReelBdU2gJjsPSSuMZBo/0v?=
 =?us-ascii?Q?pws71KprqTxSVouZQbd4e9Vf0TfqQ75x2ZOEue+QDwkM5w4Fm/0/afkQ2HKo?=
 =?us-ascii?Q?c+A9by46KsE9g66sVIeD+TKo4MJ3ay3Iv/CIjFruonRE2uFT4UHpOqEG0Ssb?=
 =?us-ascii?Q?bAVtE2cu6FNAHAVNZAGdl2ppz8bZ+QUn3D5uiiDojfC6fq5+LR9/pb1Alz68?=
 =?us-ascii?Q?UkJhvCc5MyjATKGoCIZIykf5XtqtTvjR/L2Eu9atcesVbOGqeTLDBwkS3Als?=
 =?us-ascii?Q?cQGW9LBSUtb5ui28+tQeHocR3mrvnnNrOGqe7yijc4Dl9mb91DzT7jy0nsoO?=
 =?us-ascii?Q?C6cyltebkRSzVLZEfDEOUfaoFPB9K5oMwLvQ/uGVWydWG8vQN/9DMm1OVfxZ?=
 =?us-ascii?Q?0BfasQjgtcf07yGoWE9Afsh+8QJ3A6xe9TPPyT9jv1HKlp2CsXPv3SUOw3tf?=
 =?us-ascii?Q?FdGHKm/MXGOuUelIpQXO2/b/c2ttkBvaKre1z4hyZ0G2BMuUorNTM72GsuDn?=
 =?us-ascii?Q?SQ/JdXba/3L8WDCUoCO3AWsgmbcCKkSvnMXUYOlar5uRwYDHf+bOH0Aw/4x2?=
 =?us-ascii?Q?mcaLthrzSjDm+en8n73bqXbIRPlDmRRQWOpKFNKkMy4n0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Fpy1A5edgFvgx/7NkzNUhsBP/IBM+wtUCTsql+nYFnPulJf56A6ZpebgGV7?=
 =?us-ascii?Q?asWMBgPbHhyLdTitivVyEs1L7nphATsMNnHV7ihm8ZcfNbdLhFnQSqAE7ETm?=
 =?us-ascii?Q?dtQX4fsuShM0qRleYzUbtTdjr11aoABswjs3JWNxQmoeB8ntabBL89eSHbhz?=
 =?us-ascii?Q?yFkA1+tNAP3z/D/aB5nMu0OAnRwpDzKQBrC+Ap2kTquyL2IP26cojSycJoO+?=
 =?us-ascii?Q?Qob1jYOWgdGAJqT4U9tf8od8t2ZqIjN8YITtypS8ZMK3N/0iTsFPpC0iYfnh?=
 =?us-ascii?Q?TN4+LfTKNSUyG8Y94CmFTBCUbvUdVMdSR1B2Yz8q93IF8Fz9N9rcA672K5v+?=
 =?us-ascii?Q?U+W9ZIYytJt1+5+2/bXmH2Zuz+q23u041rOaufRDVcgg6qcykRcODI3wzx9j?=
 =?us-ascii?Q?3kyZDc5GrCIl/EtGTR1pkqMe6+HZmW0KpZM3jUvvyyNAawARH7m9yaH2G9QY?=
 =?us-ascii?Q?gZuj9gr/0pf+HFh2SeUgMWPjk3dfKpQw12t1uZAEJ78xS3yj0amWxwneES8/?=
 =?us-ascii?Q?2AMN8ZdjMNwSSK9tLRJS0JDeAJODZlCzRcev7mBVvrWdIxSrkMBrlSDQ1RQi?=
 =?us-ascii?Q?axmdy/2REX1YF6PMc+eve0r2dR9Yn5bRwvYyBBBp0zdKIV5rkXFzayYyiUpi?=
 =?us-ascii?Q?lp2EionLKrpoiF8uf+cvEJ7mc3aBL+wYLdkEPv55mVOOi/L/ugxUB4CDyZhP?=
 =?us-ascii?Q?MqMuXcmwLmN2xTPP14ktpter8kkURFO5w7EMEw/Gi/i2C56ocQRmI60TqPBE?=
 =?us-ascii?Q?xTDuITiu7cM+dK19/kEGdD96B6BxckFMZ15NtjNpABSwcjGGv4V4nXxIFsXe?=
 =?us-ascii?Q?btNflT7NSne2B1B+oKDwMklTO8KKJ8cD5TBLVla83G7EUmCftcGEqURD+wZH?=
 =?us-ascii?Q?bZOVWlWjZ/m3E8kW/yJ06MiyegYGWcP4dFBfrB55qYNi7BPl0DU2iUCDqPGh?=
 =?us-ascii?Q?OBOX/4GBU9EO5jnHsvuTGfaL9gZ6FrPwfw3botb2E9achv1yVOJwE5MKXvP4?=
 =?us-ascii?Q?Dekdn3admifRuUMFOfiFHLF16ajqaGo8GzoKU4ERtA/85qRHmSmcdZhJ+aZ+?=
 =?us-ascii?Q?3GICh4k5tGZjWVupxQ+U1PTskwNfCT+2Hge6YjZ+yrJZPVM6wIY7fYEGyO45?=
 =?us-ascii?Q?QEQBvRq/KMO7zHX9JXTx8HMR7ZjybNCmUGvA95cikw0ns4Av0hwqZa7IDXoN?=
 =?us-ascii?Q?v7UiW7OgpZuCwtUK5fknRT8Ja9yfMuxp3TgMNC8cDQUYUhEjdKNqwE1BvUS6?=
 =?us-ascii?Q?Zm4RJHZ25GCKZFYD7uCrsD9MplDJ0PHmEtSOcV/2AFBYP4/609oJspt7y/Cz?=
 =?us-ascii?Q?1nW1rseSZIciEhbw+B6Ijj9qYk2ohJjRrvlJ5kLdkEFMXhPS7HWIVgr48rk/?=
 =?us-ascii?Q?bKjH1eX0INNSGPfxGPYIJbuzCQpxpp1saMjWWwVsT2ilRLmCehEi6YM+7m5w?=
 =?us-ascii?Q?UzwGDDaS06eHajVeobomeqRxiPM7g2I7Oq9IKtioxY4pSeKMbdLSKKXNqwDk?=
 =?us-ascii?Q?BVJx+5GS6CD4xh5lxxoIf4iWPcfMQ/hYb3Mm+vMkFmp0HMhHs9NwMZPJ/HJi?=
 =?us-ascii?Q?f9Xuhy+gjs+gks4aMdx724T260y6PGy5VmXgmGeW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39aba8d-0796-4560-0434-08dc74b7ab21
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 08:18:58.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABc+2a7k5c3oupb8qj/foDiIhE5Db9XzLCW53eoy/NKR6LHBNaHJ/YAHaBf9zY1NnWqh6/GDn8aTJRH/eY84Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5044

On Fri, May 10, 2024 at 10:39:06AM +0800, Chao Yu wrote:
> If lfs mode is on, buffered read may race w/ OPU dio write as below,
> it may cause buffered read hits unwritten data unexpectly, and for
> dio read, the race condition exists as well.
> 
> Thread A			Thread B
> - f2fs_file_write_iter
>  - f2fs_dio_write_iter
>   - __iomap_dio_rw
>    - f2fs_iomap_begin
>     - f2fs_map_blocks
>      - __allocate_data_block
>       - allocated blkaddr #x
>        - iomap_dio_submit_bio
> 				- f2fs_file_read_iter
> 				 - filemap_read
> 				  - f2fs_read_data_folio
> 				   - f2fs_mpage_readpages
> 				    - f2fs_map_blocks
> 				     : get blkaddr #x
> 				    - f2fs_submit_read_bio
> 				IRQ
> 				- f2fs_read_end_io
> 				 : read IO on blkaddr #x complete
> IRQ
> - iomap_dio_bio_end_io
>  : direct write IO on blkaddr #x complete
> 
Looks like every COW filesystem would meet this situation. What's the solution
of other FS?
> This patch introduces a new per-inode i_opu_rwsem lock to avoid
> such race condition.
> 

