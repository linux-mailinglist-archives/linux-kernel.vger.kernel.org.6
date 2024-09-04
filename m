Return-Path: <linux-kernel+bounces-314104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18FD96AEDE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 04:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E374286465
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810553D967;
	Wed,  4 Sep 2024 02:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HUs6vn7l"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829091EBFEC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 02:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418787; cv=fail; b=TasR9SndkY1LHyehIFsHUh3kyOfYLKBS/aKQliez9v4/+tzWPisypP29Fzixf4rauQnicuTUsQ8sAQyz1As59dXgGeT9alVUAaXyBFpx/fLmtvNXN/8yKh/J8OaZ0y9193oC2Z54h1b25iMeXtADVREMVLgCo4TSya5rOe+zKO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418787; c=relaxed/simple;
	bh=N+lozJS5C0tiRU4SZSKq8wsLidj6AV36ePWIko0Vi/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YITYnSJYuYnMsDKvNPsExskyLkm+B3VQRXzvnbVFjePPT8E9r2nFNeCJCVIRYiL7ioqq+vGYUvBxvOkYHg6e1diDm8GaKNa2Wp0RfPB6T59Xa4coe62V3f0Xffb6HrQTJH9c4p9xsNXPiFqoqGzxrWsr+pQJ20aRoWTHP1KBsQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HUs6vn7l; arc=fail smtp.client-ip=40.107.215.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbxH6xvegEAwg0HOiwEg3pXxmViKMSFi6pzhR4PIX2bMPECl6g4HSKMoYLtyGFBcu0syF+Dq9ejiBLWeZDRKRnFPYA9H5rMFo9n98AfxC1Zw+AV4LIRxgHmxg5uDYSDkBF0yY0xfr9+sAeYPyjN592JX+USb5fp236dqKr0Ukct0w7cuhHtassdy3Iw9UTpC7y0nl6nZtgUU75XULL0GhkvN2kwmcOviU59TrQAJBuU7fjOxzxZvRUjiVtYxLnAnzh3vbc046p/p+8innDoeMB27WxXl0lmQlZoVSJ26S9yonfkXcVwnXc3MT88pMyNb4ru82dNMmaFPsXBJe7dhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UK//Ol2sdhiRHxI6xoVQ6bJnuhXHHxUVvTGFEiF05c=;
 b=ZyKxgCTuoFfV2yWkNmwLrJVkaZWy3acCSf4t4o0cJU1AILgizxAt/v3YF11rpVSrQTjp0VYZG712/Evpv5u1/17DEyDpifRnOlob/dyq99NO5tG4xsW7tKnGywyN4I9E0MqvJH28Eh1/+KbyllbZasXtQGGk+Zlyv2yoGD6IjyYTXMok+o3k6NRFCqXs/Be2cpl45pEkq+Z7mPu7Hja+1IZYU/zMNiFUgACM6kEnC02KTm6P7WDLk42Rp8Lkhckzl3le2KIPMp8vRQsgld8+kGhIKsJglM0cxiy39yxy3NLqEvyFhhs34HwRT3VUBXIf8yPMxHt+vKFvpG6qYPMRvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UK//Ol2sdhiRHxI6xoVQ6bJnuhXHHxUVvTGFEiF05c=;
 b=HUs6vn7lRXCdW5LCWeImvNbaJl7Ym+cf4V74rRwRYJ1y693QQ3hPudzVtqUnpQbTP6BZdCyKB1xRhHTBz/Lw9dUMq0SCpZqkHRABRbUFC6HyZQ+Op9pJqkAI1EomthpmuD3eoxibRj+Cw12EW7/kkQR0T7E/Wke+LV7yEEfZWrOSWyv9CSlXVM5Fb3/x0/3aBwEDVXuhuWtVMn5tpIjO6c/7XVnE+BvAqTKLDGbe9mSUf52dST1Bszc9znrDiM3PtHAa2o2pxXiVkyyQ4C2+eF1SPQN/lIKEqgje/9v4sfHBB+PGI0bXX5md0EbGTkL7X7PUdNAE4AXGnLZp83fAIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR06MB6669.apcprd06.prod.outlook.com (2603:1096:820:fc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 4 Sep
 2024 02:59:41 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 02:59:41 +0000
From: Wu Bo <bo.wu@vivo.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Wu Bo <bo.wu@vivo.com>,
	Wu Bo <wubo.oduw@gmail.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 00/13] f2fs: introduce inline tail
Date: Tue,  3 Sep 2024 21:14:44 -0600
Message-Id: <20240904031444.3413285-1-bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240903162930.GA2743@sol.localdomain>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::15)
 To PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR06MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f324ab-1585-4098-ff9a-08dccc8d9f1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+rXj71Yyby8zowipryRYfACwYv7rnnXXAUwY6S9KOFRQ1TgPsK/VsE+Uzxad?=
 =?us-ascii?Q?Pa0y0TSP+rTdD7j0S1uzZQ2jHz4l8cfqRmfJMdtKWsVWUJ/MJGn64fOtWLrp?=
 =?us-ascii?Q?jnqHUSyLDaONsFxb28pr8DPCmhr2EB06wFH9v/qQro5SK6zQTpXjRJC21LOq?=
 =?us-ascii?Q?pBRDU32pCGUxi70pAS8r/Z51YLuuou7hE7tb3edZkPJp1NbIq8FpfLDo3xQT?=
 =?us-ascii?Q?XGc5jVvlQiJkKnz5ri9ngB9E8be2qQ2ypm7rFwOIGF9XEHV6tgWqJNTt3mZ9?=
 =?us-ascii?Q?k3Rm4YtEIX4N5PHMxVlK86zzJJDo1rB5SPbrh5C5FNF5gPK46zi/YqPq9Xkk?=
 =?us-ascii?Q?7uD4dlaBIwtWIZLtZ3VQP8PFmynBl5svcdjyTAT68BuOQlVzjz5y5qBGF7nH?=
 =?us-ascii?Q?/+mmVzrD9I/ECEL9XNFAqE0hW0SO3GBtRq7+l4u7Bu4Kd0WUOgshZAOMBOOD?=
 =?us-ascii?Q?xhtLIPQ2ohYRipx4gmCGzG3CunWYJPTHVGSifrfXvC9zM/JFFEIc+0Lua733?=
 =?us-ascii?Q?yW4SXTa0MFic0fWELw2wGTkySJyG/aUdm1HhCWEl+oFSCtaUTNq9C+U2b1Gc?=
 =?us-ascii?Q?EUSJanwGpyoZYiizf+nJh04gKISQjBwx4pULSiejLoQx4ptXCbXBIl5C+2qD?=
 =?us-ascii?Q?h1NSamx1aSp/L/s9+pooQJCvuRhaJwN+tpPp51il0J/IRUYGRI+1SGFBFnsQ?=
 =?us-ascii?Q?4RLFyimO+ux3MXiKNQhTI5m9wtVlxZnq3jTBf28riEHojNd+0ZrTGdALau/R?=
 =?us-ascii?Q?+3zO/a/n395K0D6kqv9sDUqUaZLyqPcpLor6vYNzZaaF1y3ZI/6Z009obLlu?=
 =?us-ascii?Q?WTZ+qEwJtBEsNuUsPoa3nfxBgAlFLFAnNJiUbRq0RaqDwEE4aM1B6jfDRgSC?=
 =?us-ascii?Q?ucYPPTaZ9XGxxqNWvSCxzUEabqCDg/ATe1WWVXRha/Kh584L/GFB1vuY/QHH?=
 =?us-ascii?Q?B5x7VhU7Phiu5kaILaH2PL7UEfR/E5Oo0PuOjwgM19eK6eNSggKSiXTkFbzl?=
 =?us-ascii?Q?iNp5XmLbare1VcDrdJl2fUWP5xiRbCDeirxjf12oDqS27BGjS/Tc1LMBlbgU?=
 =?us-ascii?Q?t3Ad+nOUusA12UH7Hq+sh9igBQgt6PsSAmBwR1isctfi6PfdOzu76b/6Wrs/?=
 =?us-ascii?Q?FsnKk8ehc+aZ8SLASNKU2VmNIj/sDyWch8Xb4n1pOp03osTnvMsinN9drn5H?=
 =?us-ascii?Q?JkU4Vp6kKgdpaea3no0RYfULNntpmA1SHJa20uWyUoP+s3peMGkzLI3KYgtF?=
 =?us-ascii?Q?AXh1FV80NOG2Oa5/Fwsgkhew4xGe4ivdIJWn8wtGwZlWUPZKInqxzysGYPVB?=
 =?us-ascii?Q?Aalam1n2HbLE5twTFsc1A2ksVVnJ7+mLyJPkyY9TI7HX9uIcvzmEN39CL1Xx?=
 =?us-ascii?Q?hZ0FmIrlaQGNgccH3mlyk1b8hPWpHlB5kuQPG5Nlklq3Ug2LKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sdIBQii2c7kBFXKAssp5xO6tlDuAQtaYRX2FayQ4SSm0gVD/axNaW1aH0clm?=
 =?us-ascii?Q?4MY3+ZS7//ZgzpkEY8A34df9KEsZcuIqBDaRA0Zf/7+rWbZgZI97VR5X6+bz?=
 =?us-ascii?Q?4FInzSwPSKtX6u9HQMkcM3JvbVDXYCFNB0hCy0DBHUaGDcsLDsQ+k+qUPuHq?=
 =?us-ascii?Q?UTJ9pv6FEkJ83NC+0r5nrOITuw7TyYM0nhUmfkt8eP/zXO8UZIpwhrj79T/3?=
 =?us-ascii?Q?rQyScuCl2liRkgFei+t8pCKQFX/oB916z8Iv/4PS4TXjjbpNtQbaWyVrQuNL?=
 =?us-ascii?Q?mUWFAkIzYoLS0JRP7TRoe1bto/s8y+A5PpZyQJQO+FkjnAjrNyfuxYONa1+M?=
 =?us-ascii?Q?g5S7w3JVA0J/D0Fs5Isvycx5NIMeCL2+gtNO91zYKp6wlQK27snWXLS7lu4P?=
 =?us-ascii?Q?cUaB0gHfLyP/XSdvE+Zmy9PEXTgayQLj8dbQlnExpN0KJFN+BbEzZl6XpwGb?=
 =?us-ascii?Q?bNSmHdtNz0HFThz+6LgDzC3bzOMJleAUSYXgUlJR7JEHSuHUqanOmsF0P0Jz?=
 =?us-ascii?Q?E/+rYUFxOOva7nawMTEebTGr6sAYe3ZXZpVXg5+l23JKz0U6bCABJ/uylo8q?=
 =?us-ascii?Q?fAJV2s6EA3BCIroOTdhklQQO0O4M3W7JKALymib46FOkoiw9LSkCqCsXlr9H?=
 =?us-ascii?Q?Ui0QwIhRrOPFgewFh9i8YFrk8bc2L96t7Y4aP8d+Ms2NIx1wyutbiccb3W9E?=
 =?us-ascii?Q?Nh++TkU+2Kz3eqV547LR1TZmJ654fXH4IW48vbU3NqLB52X6KNaFJORsPjF1?=
 =?us-ascii?Q?8WUo76YoSn8+E9qxbiIN27WV1EVXDKtw/b0XtIbIKFtj+AtXZGCWlGC2XGzY?=
 =?us-ascii?Q?YaWsZcsOd0llh/XWwiwbb86deuOscgT0AH66SFRO3YbbThUog5bNBfumbYP6?=
 =?us-ascii?Q?I6ftWnZu0lHcR0eYjPojbNbarb0kpBH8ta28iC6jhDkLAfd7MWbYCmSGKhYb?=
 =?us-ascii?Q?ulgoiRlcj3Zfn9Abz/0/qq2kOlbaQmHlg6ldpEsTQ9zBkMdOjBC+N7SC3xw6?=
 =?us-ascii?Q?LASW0d342YM6Am4dG6acFELsuCF66A97b+R1YSMhVOyjLdKawlWuQYwYVvwo?=
 =?us-ascii?Q?T5auC8CieUGdTBGO6eQwmzDugSiEdy6Y64wpqTd4UPHImJ9+70krkx2FEU7Q?=
 =?us-ascii?Q?vueSMMg250qacq9Rv13RikAu5QjVUDJ9hTHYmdCm99RXWSJbLVy39l04SOfW?=
 =?us-ascii?Q?Vrk35e0P9mHYa68CakGPLXlu06KFlw87IfVoNSG5G3dRWWsuBdCyGsZdpB4L?=
 =?us-ascii?Q?0wMFZ3WDfEhn5X/YVrxK66BAHapB/Ixd8Y76SRKXrEi96lGiNTA3RLBNXpKW?=
 =?us-ascii?Q?klOx2GSBcI5Rw+8VuD6NVuI+i9IA6Hsif//I2vUx5qWoVxHGleo4ISdGFkPy?=
 =?us-ascii?Q?b+UT+4Ng1qsiL5riuO57UQhKQp4S6vatRSxVdDpjg1LTtn9dBB3HY/1iph1J?=
 =?us-ascii?Q?4WTeZ8fUvyEtZCpphM+RJgT/sU/3hu5Fc1+7M2/U9KT05dsz5NQRr62XIh+q?=
 =?us-ascii?Q?GSgtBaeK5WFrpOAsFN2OMTvMpMLu6dfBt5sWJfaShPWsNF4RWA+vqTd/dS0u?=
 =?us-ascii?Q?oKYeamSg4SlBM5mH7LTOkAHY+9/kwNvozJ/Mhz7d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f324ab-1585-4098-ff9a-08dccc8d9f1b
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:59:41.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQdGm07gpz8bfJhHTHHGIWGW9uDHsfQ+QCH1hu/GgjIZ6W1rJ+qNJU4ao4w2c7MSr2/UwbW8UCvSKFLaukp6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6669

On Tue, Sep 03, 2024 at 09:29:30AM -0700, Eric Biggers via Linux-f2fs-devel wrote:
> On Tue, Sep 03, 2024 at 02:54:44AM -0600, Wu Bo via Linux-f2fs-devel wrote:
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
> >   Failures: generic/050 generic/064 generic/250 generic/252 generic/563
> >       generic/735
> >       Totals: 607 tests, 213 skipped, 30 failures, 0 errors, 579s
> > 
> > Wu Bo (13):
> >   f2fs: add inline tail mount option
> >   f2fs: add inline tail disk layout definition
> >   f2fs: implement inline tail write & truncate
> >   f2fs: implement inline tail read & fiemap
> >   f2fs: set inline tail flag when create inode
> >   f2fs: fix address info has been truncated
> >   f2fs: support seek for inline tail
> >   f2fs: convert inline tail when inode expand
> >   f2fs: fix data loss during inline tail writing
> >   f2fs: avoid inlining quota files
> >   f2fs: fix inline tail data lost
> >   f2fs: convert inline tails to avoid potential issues
> >   f2fs: implement inline tail forward recovery
> > 
> >  fs/f2fs/data.c     |  93 +++++++++++++++++++++++++-
> >  fs/f2fs/f2fs.h     |  46 ++++++++++++-
> >  fs/f2fs/file.c     |  85 +++++++++++++++++++++++-
> >  fs/f2fs/inline.c   | 159 +++++++++++++++++++++++++++++++++++++++------
> >  fs/f2fs/inode.c    |   6 ++
> >  fs/f2fs/namei.c    |   3 +
> >  fs/f2fs/node.c     |   6 +-
> >  fs/f2fs/recovery.c |   9 ++-
> >  fs/f2fs/super.c    |  25 +++++++
> >  fs/f2fs/verity.c   |   4 ++
> >  10 files changed, 409 insertions(+), 27 deletions(-)
> 
> This is disabled on encrypted files, right?

Yes, conditions for enabling inline tail are the same as for inline
data now.

Thanks
> 
> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

