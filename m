Return-Path: <linux-kernel+bounces-295063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC3959653
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7F30285BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2C1B2503;
	Wed, 21 Aug 2024 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ZWhpVq6H"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010024.outbound.protection.outlook.com [52.101.128.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C21ACE1D
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225970; cv=fail; b=iX0aIOh+wKWAKwI8/xVzwBNIlaFrplJHc72HUUAvTPzOE3GHxrFoohyP7XtM8F6G4wVxE6GSY2YlajeFo4m2TZzlHSm9qDqlRofDyzAF2ZK36ZNmjvEIrWiab1aVNZcez2S51j/WtzoPXabsMcqPBAZGCSFILjE+GomtdEStSI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225970; c=relaxed/simple;
	bh=cvc8iMXaRSJLfPYVVknwDZ8VUIjfFXM+8YLrYTKmQp0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kCHWg3LDOidRGm20CAOaNJTe9jfnCC0gkeZKWlhPSiVdzJqEnZIhXEvWi8aR84t2VeluSeyk2FlG0ApL6H70E6VA+4kyA7OcovTR9PBWAjNl6Hem5aJS5ZHI4auuLXfmn4DHSIMQKNjQDZyxGyWzCimz9rAmLmOxrDxsCReL6Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ZWhpVq6H; arc=fail smtp.client-ip=52.101.128.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf+e8WNagZ4Dgb+7IzUHv5Tr2TlXC9rYHFwkPyqppEtaAyUuYKb8afNfThX7lTn6Vb708UupFTwzAuEx6G2pGIUJ5R9/ffBBOxJ7VzRhqaQdl98rrjWfhJRHPi86W091VpbihHlygfGYPsGkvpORaK+ZMNBjiZhCYu/BqslEU+sCmXH9KgH2ILhJfON1PVibk4ei539fl65L4SRK8pUT0KcYKfifi5pFi7i2IKL/oIB8RX1BToH0rHOdmJoa13LawbjfxiPDNQBDJ83uPtcHmZ1rfO5MEFFoyjjnrIek6ksCZGizM3LvcA0zMJR48ZjzghWTvLcqzUsv/dj89TshRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAEPkgHJDmOUFDBSc+gdxyhLl7U/t3X4LWXNUCLQe7c=;
 b=KzLNxGITfKWFmtDkkFQiF8NLPgWvRNGJnNJeajhOQc3inz9KIh1JAfPt1gHK3qQv3PwgspjhEYdjQpC7af7tOdFPTJ4KfqaecPmUmw+EZsIZ3rdzK1WRpdpJbgnlaXvxU4m0ZtNCgbz8vKf3pQlP09XQg60IBV3r4nmpx6JIev0MFAOk0cplfzIR+f29bSvswUOOSNk4e2JPSVa9S9IAVbomDE4YJ2Z7z1N2i4ZDT9ydgrTxPHZvEbMtw2zsQgjkdim2S5bixBb+6wzB6T6WooUlZFHG05iZKzlXpq3HvRx3/wiUZGhI/n+ebADayJzqfHTi5VUTgtwQmbEIBLK37Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAEPkgHJDmOUFDBSc+gdxyhLl7U/t3X4LWXNUCLQe7c=;
 b=ZWhpVq6HElnmvfugKeXmew4FdfTJ/964M8TTcBDpSqZ/5RLDfG3fHBBAza2WVFQyCN2soszdUZBDRmJA7F8IDE3Guk5lmyJLGMBKlRj0RF8WBb+rGgBkWKqTNsOUXihe+t6+hlxws6XwQDL1FexHyXAYYFGAkC6NyupRMzqpcNHBvqUuU0+Q/Gux3p33UY86PfPzfflC6bXaOTp/ZK7w7JnJNbpyuQlA64s5qacTnfhPs6fpzsNoBLYhu7nBrDRVDSAHi5nPGmvrpuOhTim4k5ch9kOvuPIK7MRIpBVAwkrQR883Fd6rekctPj1uZoeR2ofpwdmdAEzhC+PaY9TsbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYSPR06MB7257.apcprd06.prod.outlook.com (2603:1096:405:81::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 07:39:25 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:39:25 +0000
From: Yang Ruibin <11162571@vivo.com>
To: Sebastian Reichel <sre@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Yang Ruibin <11162571@vivo.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] drivers:controllers:Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Wed, 21 Aug 2024 03:39:14 -0400
Message-Id: <20240821073916.10165-1-11162571@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::12) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYSPR06MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: b368b7c4-7112-425b-8850-08dcc1b46132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014|81742002;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G7B0+teuZNESfo9vbKR0b4SEQr32EV0Ubgvm4x7VyEdK3Y8xHtfnMvdllUZM?=
 =?us-ascii?Q?1PGoSiyyubQuMQivK2rLqzCOREKfjUjBAGOS4hwpTyg2pWX9WLr76B22/CUO?=
 =?us-ascii?Q?7RDzobgn/wqYnLjYbN/1KetN4WuJTkPnoUYOq9Rj5hEJ3x2KfZUDAChjCnN7?=
 =?us-ascii?Q?L+J9wUFLtC6qq5kme8jPQSV/0PMUr/GwuHtmxUB1jBdX+JCTBOiJktYXgMmE?=
 =?us-ascii?Q?9eE2IvMtKEmITxu+5nUCYlSlNqb5K0uZbKlyMbGZNzgZXVZ5vp3866vlAiaX?=
 =?us-ascii?Q?JmTdZa++OMDBX6c24qpMSHH891e6BUYX20EgMGMY56IQ9IjqA6Mj3hjItYf8?=
 =?us-ascii?Q?kPjaUfDhjNUjLeEahnXBj8uBnHy0RaeyTSdbQG3NQij9x+JxFlekkCskGJBZ?=
 =?us-ascii?Q?pP3LOTFAxOKQhluKArcG58aBH1yKm0nNKZCd3D4gXmz9N1YQkuns8uNXz/Vz?=
 =?us-ascii?Q?O1mL80Exs3ahmGKRQe9qYsMd++FutzxvV9RWGcpgN6S18H0Ozqz8k4fovJf4?=
 =?us-ascii?Q?qkjzd+S7NR2Gn7NR458Z6Kko7Z7laTMXSi/d0HDOUqhSpbG7V915bkNEDspH?=
 =?us-ascii?Q?cBixIIAIMLP3MdLt2DSDkniAPDPXyIeEl6E9km6hd5/4tk25bvysgRxD3M0W?=
 =?us-ascii?Q?54UQ0InY+bqO0T5nUGeLYqo4Wx1crIM9/fNevNe/CQqNw1Ag4hhpz8QBivAc?=
 =?us-ascii?Q?KooR6BgRfep4lXQfRatHYS+2EsiG7XMslOlUSKDOi2u/9EJkNGIQzuTd7+Fd?=
 =?us-ascii?Q?6Xcs7xcLqxSFJvZAEOvRsPxLLBKehdG7ZqeJa7eJma2h5RMS73tWw6QGIudJ?=
 =?us-ascii?Q?6sqI20eAVNRttyBlZhOZEmjJ9n7Gh1kkq/Ohw1M2lFVZvxOrFeigDiGXrEZd?=
 =?us-ascii?Q?z+CZqufiHLhSbqIc7bl8Z3+4IaxjOVTObdF7ILRJBDYIckc2dpCIssS6JeKP?=
 =?us-ascii?Q?wL+evchiUbBLgxJwBmubhWplU12RPLP1LvOCwu6R788aYDdxp+ox8I+p+AuJ?=
 =?us-ascii?Q?1A1mscPqpRp3EIC4H2HwSTRUACkKsw3lojpDyWucas6NwFU12zgx5lzZFrfP?=
 =?us-ascii?Q?3WkbGW9sq5nG9d0VpUrisb9oDCd1AxEGpQV5kcZkGkE7tYyCVPBBePkEunPd?=
 =?us-ascii?Q?W7SlQZxFezNjqVI+CMsDBE/W+rFDJj3YE5i1cQJTB/OJwZ38DuevoCitCnB1?=
 =?us-ascii?Q?ZGUA3Haz631Y16xgh5wl1C4phhl3GT6eaJDAp3k+rcIt2f9OK+BoMDXFFzIt?=
 =?us-ascii?Q?xwPH6UDyKxySmWT5ODjnOgKC7lXh2N2HQUtXmftUo3YTzjhc9dTIZJDKqHgt?=
 =?us-ascii?Q?66pI8ODz5kBZSm1B3vxDDmctCaW90L0IR2lq75Y99mPirbLV9pNzaJY1gkDF?=
 =?us-ascii?Q?dDs/A0uVP+b4lJF+EWan5Nn5cIdXCZGVwIiVswlpdFNcxLTxjjSRJzmEPbGc?=
 =?us-ascii?Q?NJ2LKFloVjo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+1t6JBDkw3dmSQI2PgEArnW8Ov4/Dx6IKcIOXas1XUS9DIqX4/4hDVXpLv1d?=
 =?us-ascii?Q?KH1bIParlqSV7siDw4LPXKPIJKQFDUpSTf7qmFjoGaMjM2JDufMaGWeibUUo?=
 =?us-ascii?Q?F2IEPrGEg7PyEEmt6TzjhQ+wRdpFvj9s1snTIT0j3Be+HCyyfftqKV5zQBZH?=
 =?us-ascii?Q?oDhIPY5RimHZBAq3N4LHrHtXdPQPOFyo+B4Erhba7Cbl9mbqQfrIu10pTvls?=
 =?us-ascii?Q?qyKtbWuF20ngyOF0FCxc7EPXtp8EbYUFQMfxiqTpq93qO1bMFEXZAI1/3/6D?=
 =?us-ascii?Q?N7/trlSbwwEDx/K8Mxcm1fpcgsjWOv6Xij8Y6Sw5xtJMWoQk/nXzHRDA5hVO?=
 =?us-ascii?Q?MrEIbI1kNx8GfSLLSo1yYe4FGOYCl6V2ZbGJkiUnaVsVi9ZaSFTbRQB6Q9E+?=
 =?us-ascii?Q?zSgzgn4rKcspZXFMmw9G/KstmOgUJYR5labUeO2AfxnuBXawHL49qarbIy3V?=
 =?us-ascii?Q?qFDXPq0WOQEmlEygdGN5YL1NX30MsUpO3JX6QRToddSAtxd1Q7P9SXEi2arv?=
 =?us-ascii?Q?vnlRLvPRwouuHzRSt0fDdDuvktvYIgws0dvhW4PO3+HC71CBFYI4kIW7As7m?=
 =?us-ascii?Q?XArcYqvIwbmItEkcAng66ZVl3x7tdtGDbTo3F3nKcxUUo30C4jgW3jgub0b2?=
 =?us-ascii?Q?TxNKzeUMst6FwvxAfDCzi4nePRDSWZdz4Eq3DMhJeERep696onj77p/jWl7o?=
 =?us-ascii?Q?B98QGNFv9o+X7OMZ2RLGHIo1hNTc89OzLc5nIq5okq9DH16gW2ltPb5KWfhX?=
 =?us-ascii?Q?KqaLdKOqflS/SNLJW8p/KP5RmR3+FKNaDs7kuRgmwD/xUb6mO9dm5AFZQPDi?=
 =?us-ascii?Q?5NozrAqRAS6QXKiezxfYEN0OEHzAfrMFc13tLoK69lcPfSBhBrdn2iaY0s1L?=
 =?us-ascii?Q?CDq6Cark0dtNzSr8S91QdzlXN5m2k95vVPrIsolGyv4XV+am4znN8GnQ/udg?=
 =?us-ascii?Q?odovEDGvf9heAfWeEIdiFb9B55a/meQM6cyGG47deoaRbwJgJwOMYrh3NsVV?=
 =?us-ascii?Q?phBPjrEqFVWOa++qdz803lHEKpodRZQCamB9CDBvX9GTtYilgl6/18OGxSIw?=
 =?us-ascii?Q?W2hJoiVbrkfGKyXzCpVP8mdTSDFdhkEh7VWUUWsAdNOVIeyUQG/tmhAghxjC?=
 =?us-ascii?Q?todjb0U3Sn6OISF/L7R2iKDfbuIeEcbOrSE2wDoTNu0jKdswBCimJ2JDL7GT?=
 =?us-ascii?Q?9mEjjO8RuSOxSh7bl7HuLLlQxJnu/DQ1RsyWAjbJFc1qht+1q8Hx2eDzUNh3?=
 =?us-ascii?Q?s50iX34HVjitwqEwlQm8STDevvjkYTFHUjGykqsxPT0OJ5AI3Obhjmhlg8xc?=
 =?us-ascii?Q?hcWMMLpFdST8C/mvR52alHwO/SA8IMuZ4HN62We93iy52DBCOibhFqiWEwr2?=
 =?us-ascii?Q?m+BCRKd70R9Zwut3Ck4A1PVLqCBux2Va0WldlKxiYf/9CflNIMopDnmpX3VW?=
 =?us-ascii?Q?M2ijrB11uqCFk6nd9aVLFbBUZc28IZpKzuiCi4+PiSI6SeJXbieTxuk/73RC?=
 =?us-ascii?Q?cOj7oqixK84gBckOK/Q5N7avN7aqJKZFm7SC1xWELme5vFzff1fv1OkpwmSx?=
 =?us-ascii?Q?4WJ4MD0D/fiE04vf6DTpYCbLAt4k07l3wgb1sXOc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b368b7c4-7112-425b-8850-08dcc1b46132
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 07:39:25.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y44PW4IGD9jQUIj/dVPBFYIJG7yI7v50VAbQCpcU3qcXUafzwDgVK/gTbKvJp+pPjAgYqakobgSuk+WhLpHcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB7257

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Signed-off-by: Yang Ruibin <11162571@vivo.com>
---
 drivers/hsi/controllers/omap_ssi_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 3140990a6164..f85d56e85c0f 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -116,14 +116,14 @@ static int ssi_debug_add_ctrl(struct hsi_controller *ssi)
 
 	/* SSI controller */
 	omap_ssi->dir = debugfs_create_dir(dev_name(&ssi->device), NULL);
-	if (!omap_ssi->dir)
+	if (IS_ERR(omap_ssi->dir))
 		return -ENOMEM;
 
 	debugfs_create_file("regs", S_IRUGO, omap_ssi->dir, ssi,
 								&ssi_regs_fops);
 	/* SSI GDD (DMA) */
 	dir = debugfs_create_dir("gdd", omap_ssi->dir);
-	if (!dir)
+	if (IS_ERR(dir))
 		goto rback;
 	debugfs_create_file("regs", S_IRUGO, dir, ssi, &ssi_gdd_regs_fops);
 
-- 
2.34.1


