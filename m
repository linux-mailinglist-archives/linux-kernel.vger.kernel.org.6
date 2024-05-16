Return-Path: <linux-kernel+bounces-180783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78E08C72FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 10:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064711C21929
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C8713FD93;
	Thu, 16 May 2024 08:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SzuByIOC"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011004.outbound.protection.outlook.com [52.101.128.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFA6D1AF
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848792; cv=fail; b=YV02AOOqk/vKrmwNIUBtBfq6I3osDLmOWvCUc7juYpE0djq2XUqqWdhO6iIaujmuMCTiuR/Z4mwpss2Lb0qtgdu5+oCw1tfWczJn5JGeJxhS/l2Cl5+2mlplZVP4aVGl7Oe0im9Tl6cV32m+c090foqpPJ2yCPGbE0c1StUYkAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848792; c=relaxed/simple;
	bh=vVMSxH49n1Je0L2U96e1/7KwCHf9D9nCgySB8/fB0n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p9ANwsTtdTnipCN2j4lFR6RGstBzb+ecezbl1ut29OJ/fUsLWyf8O/NRLhScctpeDEjGLzWmNwmnfR8l0tcuVYYQaWxzDgs382uIFe/mAPzTpjdDfXOkqIi7wPqWhCLrCio8vER3sTlDt6zp2OxXf2l5Lgz4UHFaMpuYZSQaSzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SzuByIOC; arc=fail smtp.client-ip=52.101.128.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jn+JQ4xvUJBTO/ktGO15guDZOKNaShqT5JpYTJsIZANl5CfJm/S92pG0RCymKSjEOW2zPY1cAkkyoGFIiQPRpOXFvgQB2U+vOA6JY4XUbLg6oPIvvtZiIZj28o7MCxqub1jWOehrdJ+0xZGVtiAISOBCLShz7AuwSGCbtFqfYp0PQ/JFOKDLcGln1qM9TpVOXDfX3WcQzV8gKhK4pTDPMb8pjUsUfldCYS+R6TjbwZbHX2oA7ZZhVDIubMF33DxCVD02oc2ukgYDHxkhF9Aj1q+/cof6qCb8C7+MA17SI8iH4d+QCEtmlhxWayzJ0OGxWIFZf5gahGa8a7xGGBz6BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BFb4KK/7iOGZ/8lBVNyO+BHBdlvtgiLf/PaYIVzPAok=;
 b=P4t3Ui5xc0uGxd+8QI3dgKYxQebdlzqZKhCAkj2oSPQrhZHMHe/JBJLvpo4B6wqe8SeRsahRCfNmubx9iHzeABeKf86OmV4OBxqFGNAiz890qCRQfQrlc2zfS2dS5DsCbr3kBCVIy1+enjEtTUidUg2TaSlGwP+rvVTF7yUGJLakunw93mUnYllD1pvQKXqW/+r2Rog5JK65lfO+4KstLQ3fSVKpCLS2jdSWpCUBVVUvad4DQTCh4vv6sg9z9phAZi86JZz+UMN8+F/McuU+ReLwkR3fYQ0rHwtvtqYU65YkhABUQyAMYl7rLrX703ZX135juAxsEdG6COW3VrJc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BFb4KK/7iOGZ/8lBVNyO+BHBdlvtgiLf/PaYIVzPAok=;
 b=SzuByIOC7NKdOmDMM/UAsNAFwb8QMrjQ+LxHT+h7Ak76B0crgzDVB8LAlnstCLvQxl1I+qllXALyMjDAKE6UGQoVb7bzM6KMoqJK3ZwmzluJWAaRi1uvHl68gZUWb+0lletORdGgylcCmNhnOsLNPNg7BFTa+LPpCschrr+HpH3yfT4f2ycxC7EvK5H1DzfgxmA+H3NCtAyNsOdkSZoQBZUWe79wT3tW5B3BEX1bWxTv+I2+FWsvujdpLHg0QzwQS0L4BLNXJ3Ut+29gf/Qa7MguQS+c+ya4V99htMX5AtnFydaB2Bl0zboZO+DoSSORAnQYtePJ07MeSh/Mr61EfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR0601MB5861.apcprd06.prod.outlook.com (2603:1096:820:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 08:39:44 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:39:44 +0000
From: Wu Bo <bo.wu@vivo.com>
To: chao@kernel.org
Cc: bo.wu@vivo.com,
	jaegeuk@kernel.org,
	liaoyuanhong@vivo.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs:modify the entering condition for f2fs_migrate_blocks()
Date: Thu, 16 May 2024 02:53:06 -0600
Message-Id: <20240516085306.1785679-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c9c8b609-68b8-4f44-98eb-8d04e1a270fb@kernel.org>
References: <c9c8b609-68b8-4f44-98eb-8d04e1a270fb@kernel.org>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR0601MB5861:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e795c68-7e6c-4e68-36c5-08dc7583bbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|52116005|1800799015|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LUSHNZgTBf4wBBd9Mce8EfV0wdmk1ufon2dcWYKjmD2xupX5N0ZUPGgWaJHw?=
 =?us-ascii?Q?3wlRd14WsaXA9VbjAqly7dOaZ0HrrsOCYfo7ZyX86WFuX1GaK/A4QHxjfeuB?=
 =?us-ascii?Q?+SxOizjDMoWsdvypfG2Bzy/bSzy2zPMy2kXzHFLV43AFcPXYvsM9WMLcml0I?=
 =?us-ascii?Q?IFInxKBbvYIe7JExnwnrhMBtHwXkiwyEM0qpsoWQSfHmh4fdn8emw/7F0U7d?=
 =?us-ascii?Q?+u6khfEEcfALMda/m6cKCh9Gfjb6WtYT+JBcsG8kUdoOd1odiQ4j3szh9kNC?=
 =?us-ascii?Q?MxeF4SqhoD44aVLxh4FIArNGda/jYfCnXtHsPTJstWRgBiCz0Bd/cjjvc5bU?=
 =?us-ascii?Q?et8Jgg85rndP/xv4HNky5K5Cdt9v6X2EpkA/UW9fYng9V97aRg+CYWoqaG2v?=
 =?us-ascii?Q?TtjWlIu3PvNfkQSjejagsc+ZXVbAkiH3PuUt8Saz2isXbt+0J0eQcXmCcHr2?=
 =?us-ascii?Q?+ZxLmL0F1IcQhIkVqy0Mmz/3UMSKNXy5W9ogzIrHM5+G9GeQk+VGdRf4/Cbb?=
 =?us-ascii?Q?GqUVVkqaBdT+HanUK5tpriVDOJnW1WGE4uW4FZGoJSn9eSKUllUb+1QrJUMP?=
 =?us-ascii?Q?ulTSSH0ynPpOxC6stLeYiP2dIEAjak3mnB4lTm1woSmrmutWb2iTy3QPb0uy?=
 =?us-ascii?Q?ftM63ziDjfOGYze1+2gI1wctZE6E8u6yZmTcTN2hNgZnvp81H4UEm6zr/nuC?=
 =?us-ascii?Q?MCiAVN1sFsBxgoXuw3ngXmvPSfxi2aZW2ozbY1FtBDHhLkaLgCMcx1br6z05?=
 =?us-ascii?Q?p4OnDB0q0W70ciksS4IkjKqYXInjBhgyQuIAj01VDiZu3OXnw8C1ndJhqggU?=
 =?us-ascii?Q?Ll0MzCiMzgw8lLQuvEEnlKzb57PJBDEFc2LpgBBclXzfqqTW7PPuprY+5hsg?=
 =?us-ascii?Q?ZFh9ptVdHkE94uUM6uWvp2CG9gv6cA/aSGGwOF/CYxZ1OUJPtIaIBVm7MYZL?=
 =?us-ascii?Q?QAD+Bj3eOcCGsIh4HKMFbL9TuDF2j8yWaZwpObOQpgA+3TeFas/313Av4Ibi?=
 =?us-ascii?Q?qv5vUG9Jd6maSVR/wYMpg0buX1St+AL1j5fz0BjCSllsl4wk61vaJirCwQ03?=
 =?us-ascii?Q?buOad6KqToYDXFF4wipv8w6+zdnS3OOT10xhQg8j1xxLNMghJ1VVL8/HVsdn?=
 =?us-ascii?Q?4/SZuWdUI9GCzA/vBCGaqjvc1ZdqDFfLHf5FJdH+nFQIflCJQOFKuex/FfpN?=
 =?us-ascii?Q?aQlBV3dWyWb5BBxw+QYAuRzcOyk5ShPTzujN6VHud+TNNAMY6F+pJ01TwOFt?=
 =?us-ascii?Q?ZglxSMf6l7PuPcde9XZlHtpPpNMycqum4s6mGjUcMg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BOwlpTfkcNJsl+zt5TyP3B5+Ap0zYIaDtppnTxx3WnLWnWlg0XxVnK9HAxy1?=
 =?us-ascii?Q?olih9ADn1XmPGqfMitxqGCLhZ5ZZwVao2UZJ7eAf50PtGCU8X2AjiV7espdZ?=
 =?us-ascii?Q?9hg6wHJ9yCM1133BC1d59ruu9QipHHeHZn4NoQ90lcSsUtkuXAYnG7eMHL9K?=
 =?us-ascii?Q?UlHBf6jmnYGGWIgdn7hC43a2EQzl/FhBro/3FXMC3E6ZHLcd3nTQAdU+qnmC?=
 =?us-ascii?Q?eocenY3M2E82q5a3/TduF+69irufHcUN8sj9livBB8aNUDwjadQC68QkYIao?=
 =?us-ascii?Q?38ALERbVW7mtYFzEw44NRvw/LwgUGnukzlUHx9uJKJG7Mua23rgUxVte6Qms?=
 =?us-ascii?Q?/S9WxM2Y3Kgc5REMokq0/XSbZP96iMhGhXr9ztwj8UR4E1ZIlSpsPzmzHroc?=
 =?us-ascii?Q?ZbvRdR3FbBZvGiqZNXC2GkSF3EU8b04/jCI02/es/oB1VjCUgoyscq6so2p1?=
 =?us-ascii?Q?HG46W2P9jTjaJjp4CapeApq0qvg4yWuUiikA4tSukFXhQjkzeT/OH67K9ScF?=
 =?us-ascii?Q?xFe2iyLpd+M5HR9TTb/2cq5KAVptALp/xyDUOHKk1wy7VbryQXRT13L+cxpy?=
 =?us-ascii?Q?voSXeLPMn97tCMD8Voka+FYjdY6mKL3WxEjO6H2tOaJlqj4EmEtQJ5ugLrSG?=
 =?us-ascii?Q?YstuWGDToZveT/VJBekcGSsdbedWZNNjYgUL9FxSuGoVvpzYvvfb57o3X83o?=
 =?us-ascii?Q?iqlX/Sj8magFKdVu9oxysep/3hWRkU6cB0wbw+Z2asvYZ8IR3ukkx3rB+9N5?=
 =?us-ascii?Q?N3P2m/3Wk/rtvMJ0jhjg0Leq0DokG0POqMJpX2e+ZloqfLxMdnc1JH+fyNPv?=
 =?us-ascii?Q?+P4C9RLelBm5OpN+IIcweF68DybT7vMmiXlv6+uIJZ9WDBc2CM8XxFFy8PWq?=
 =?us-ascii?Q?2CZ1hdPFHs5tVPaUu635Q4Pv10W8Zc+wWW5Jf40SRgzeri/gJJdcjkxa5SsH?=
 =?us-ascii?Q?uWAfhP5BlZoyUem6YpwwTYNA4nE3L2JbkRqGCa1SP30546WLIhE89/eV+ZtY?=
 =?us-ascii?Q?URUUkxSuNgc9O3bl9qUljQxEtYgqruKMBK66huENh0bowIBtzjy7c00bYfAt?=
 =?us-ascii?Q?CbyPQE3al4NpsCyQE2piUmTzxOfVrvtkqEHW2F2J7E9NNJ28uES/2ZnHCy8W?=
 =?us-ascii?Q?Rh+NtX4RbAiOgAgYsG66lDSNTu93zNK+p6v6JeyqFF5oIYghMTgJ6keeHs3S?=
 =?us-ascii?Q?/XAYIDlfPjHb7HfWunjTiujaGlEsPEhmhvTz/+dAXKZwjTNW7kc7Ig4HzIco?=
 =?us-ascii?Q?457oi1DmIho/xnFJ3875hOlPhCS4rEEu8DXo+8/fRgrGyByb4H/dDUaYXXCH?=
 =?us-ascii?Q?8WZZNQWwmQZogCfV6BBBhjy871ntLTvF1qmdhlBrGfWzJQrXg+1hkjahXr/Y?=
 =?us-ascii?Q?NjYl9a3THxi4Iwj7s8qUTXXt+UaFIG95zWZjsxtEmgZGhTTFH9OUmDhhmeiC?=
 =?us-ascii?Q?+yfY6l8zbsHQqpzYgyBbl1M8gal+PUzp6s9HGjDZJpaqDzYyJHzAl20S0IMw?=
 =?us-ascii?Q?h65Wo9ir7W0aaM5dJ4THO+a2VFBKGjvT6YNH675/xN5Q6iMMsFLP0BpPobKi?=
 =?us-ascii?Q?y3YLmdSV6Jl76ALK3pNjjnU1bYii8Z9JiOoNnI+d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e795c68-7e6c-4e68-36c5-08dc7583bbd2
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:39:43.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRwE8IYbMXpZLghR6EUkpRmaBQB3pgrUe72qgJnhR2CRZrxpiG4sB1aSauoxFREWDqJOBS3VxX1tmZU2Vx0Kbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5861

On Thu, May 16, 2024 at 04:06:34PM +0800, Chao Yu wrote:
> On 2024/5/15 16:24, Liao Yuanhong wrote:
> > Currently, when we allocating a swap file on zone UFS, this file will
> > created on conventional UFS. If the swap file size is not aligned with the
> > zone size, the last extent will enter f2fs_migrate_blocks(), resulting in
> > significant additional I/O overhead and prolonged lock occupancy. In most
> > cases, this is unnecessary, because on Conventional UFS, as long as the
> > start block of the swap file is aligned with zone, it is sequentially
> > aligned.To circumvent this issue, we have altered the conditions for
> > entering f2fs_migrate_blocks(). Now, if the start block of the last extent
> > is aligned with the start of zone, we avoids entering
> > f2fs_migrate_blocks().
> 
> Hi,
> 
> Is it possible that we can pin swapfile, and fallocate on it aligned to
> zone size, then mkswap and swapon?

User can't see if the device is zoned device. And if f2fs fallocate to align
size to zone size, too much space may be wasted? Some zoned devices has a very
large zone size(>1G)

> 
> Thanks,
> 
> > 
> > Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> > Signed-off-by: Wu Bo <bo.wu@vivo.com>
> > ---
> >   fs/f2fs/data.c | 23 +++++++++++++++++++++--
> >   1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index 50ceb25b3..4d58fb6c2 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -3925,10 +3925,12 @@ static int check_swap_activate(struct swap_info_struct *sis,
> >          block_t pblock;
> >          block_t lowest_pblock = -1;
> >          block_t highest_pblock = 0;
> > +       block_t blk_start;
> >          int nr_extents = 0;
> >          unsigned int nr_pblocks;
> >          unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
> >          unsigned int not_aligned = 0;
> > +       unsigned int cur_sec;
> >          int ret = 0;
> > 
> >          /*
> > @@ -3965,23 +3967,39 @@ static int check_swap_activate(struct swap_info_struct *sis,
> >                  pblock = map.m_pblk;
> >                  nr_pblocks = map.m_len;
> > 
> > -               if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
> > +               blk_start = pblock - SM_I(sbi)->main_blkaddr;
> > +
> > +               if (blk_start % blks_per_sec ||
> >                                  nr_pblocks % blks_per_sec ||
> >                                  !f2fs_valid_pinned_area(sbi, pblock)) {
> >                          bool last_extent = false;
> > 
> >                          not_aligned++;
> > 
> > +                       cur_sec = (blk_start + nr_pblocks) / BLKS_PER_SEC(sbi);
> >                          nr_pblocks = roundup(nr_pblocks, blks_per_sec);
> > -                       if (cur_lblock + nr_pblocks > sis->max)
> > +                       if (cur_lblock + nr_pblocks > sis->max) {
> >                                  nr_pblocks -= blks_per_sec;
> > 
> > +                               /* the start address is aligned to section */
> > +                               if (!(blk_start % blks_per_sec))
> > +                                       last_extent = true;
> > +                       }
> > +
> >                          /* this extent is last one */
> >                          if (!nr_pblocks) {
> >                                  nr_pblocks = last_lblock - cur_lblock;
> >                                  last_extent = true;
> >                          }
> > 
> > +                       /*
> > +                        * the last extent which located on conventional UFS doesn't
> > +                        * need migrate
> > +                        */
> > +                       if (last_extent && f2fs_sb_has_blkzoned(sbi) &&
> > +                               cur_sec < GET_SEC_FROM_SEG(sbi, first_zoned_segno(sbi)))
> > +                               goto next;
> > +
> >                          ret = f2fs_migrate_blocks(inode, cur_lblock,
> >                                                          nr_pblocks);
> >                          if (ret) {
> > @@ -3994,6 +4012,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
> >                                  goto retry;
> >                  }
> > 
> > +next:
> >                  if (cur_lblock + nr_pblocks >= sis->max)
> >                          nr_pblocks = sis->max - cur_lblock;
> > 
> > --
> > 2.25.1
> > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

