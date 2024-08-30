Return-Path: <linux-kernel+bounces-308344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4E965A8E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EBF1F223E3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7FB16DC24;
	Fri, 30 Aug 2024 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="M+5ZVQAm"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010042.outbound.protection.outlook.com [52.101.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016D1531C9
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007150; cv=fail; b=o4tIhdoHfj+HMm69L7E/3rVz7knTPNLdpf6LJGFRt78U1rbPrEVId8FuYjrtVdT7XnNZFUIsLGGSGvimKTIH/uSaH6hutFnuO3CDhnic/XLioMxcLOwNcWPoQNk41N0ugnVosuzVn8CqcK78C2VEL3RTVH/SfH7Wi/1mD/cp1+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007150; c=relaxed/simple;
	bh=N34Tb/dEetY0woA/0DKW3EsUGaAuqleF5bmyfeo3Xnc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DDXbZ9BUgRB0rPQx24A3fMr1110xjdtN/djdqHgoituj45LvK7YviBERFX7nrkx77L/oMcTTRTEK7ihGAMAfn79mclsT3Q50gzbL+2KaznjJ7d8H6UpoLsSWkMUHJyW4OTQZOuCBshCsgYpk+kjqWqyOchr09jEkviW1lIIZvyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=M+5ZVQAm; arc=fail smtp.client-ip=52.101.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+SZF83SW7Uxx1t1H5UaG6kEGYG26HUkNREXGfvwMG1qXxvFI0qf/eotTwec1WsBGJnQ1mLJZ+EBMcBa2HffLJe/G4JiVi2AuQJ0oPLZfvcCGGkzVmsIF27zSwWYNwip0xM/nZhFsiH4lD+qxBscf2bg4yzkU6U3owGioqIoRDFHFwugETAte/xnAnSAW4DvyVU7oCicttyvtRWyqGy+nQTjt/P8TrClCTYMt3OZEALFajHg7TMqdFo6guUZ9SAJR/xhXJ3gc5bg1pCWolwOq4rHUZlX+NNM874WYdFAPlT1T3ipFVfdDlxkjMvEobsisxbEPsCrFTB2qVnS9xrOZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWWyAT3MXY6BrjQfs8QtakqWLfG80EKKOnRhEwwnmgs=;
 b=sZjRRCg2OqqFrxkykvcX42OlT04YRKbv2BB57fugQRfXtXnNODCfNauFcSb/0BskF2lQzeKIrT6VSBOlehu2fHvraPRuUtqoc4XkfKwLco8VkiCabQxihifcQpbk8LFbsAgoElzbNHHIJ9Tgo3rBB6fYvkp2HiLtnLqP7zXiDpxBqsF/e2NaqmdMNxa/mDoeaRsdvGM/+eWvvnoLQ/ObsSgcF/6UssR3jPp2knUPf8eIHsTaztQtdy3WOHrubAVdAWu4HnepvCit1hBC1Z4h0c5WoEu7Dfqo7m2u7w/jPmJ3z0oLzxuAIcWC9qXHZ4J0Nk9YhzboFsEKe1fbpZd+uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWWyAT3MXY6BrjQfs8QtakqWLfG80EKKOnRhEwwnmgs=;
 b=M+5ZVQAmxPjxkGRZbKDtJp282wNO0LTh399AuA3Ugg0q+igM9Ed5t3Cu3FloATYi3Dla9UiFj6igpCjBvRaRSSd/K+B0B5d1HUBQYXv8l1wAwwFnxq1yBwrEvQA9EksBpSZqtHh2p5fXCTEY/gFEgerCGN0QWCRJ1I9QF2VYf5QvliJcTx8VTqcQSbT5wcyuiGND1XB82MmxTLlAl+jjlNE10zc5xR6oeD3ofOhXRyJLGRhLoy9mmBESq9T0bTXQrQHXZG7fCmP6zUkyK3Bi8gsVdqs5k/NNeb+zq3VMCWlHLg1b391YLuLA8g0i8zs/cz/yIccDWoByYGeuUXkuIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB6454.apcprd06.prod.outlook.com (2603:1096:101:173::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Fri, 30 Aug
 2024 08:39:03 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 08:39:03 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: haver@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] misc: genwqe: Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 16:38:51 +0800
Message-Id: <20240830083851.25241-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e903566-369c-4da1-09c8-08dcc8cf3391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pXJ2N00iUy8oVMNdHm21IrD2vuEfJx6sG/q32x5+tc4foZnuA+i2np9dltE/?=
 =?us-ascii?Q?j9nDCXZCzWZnQD+rpcvBF3/wo2amEIqn32HPMdZ/5MtghQZfEF5XeTuYG6lt?=
 =?us-ascii?Q?/9ut71ZZe7JZbA+gkG5vJkjS02H8UW2QkJj4XN5I9wiq5ygtNxvYopi2JKkn?=
 =?us-ascii?Q?d1SMiny3CHkurTsIeBgP0ug7LJzg2qE+ninwCvYSlEF89x+8qWO66RngjZMM?=
 =?us-ascii?Q?AU7o70R3nl3Se8wdvsBzxDfUq+lAEw13gKpGc9Hu2RZVKSys9KKcH2SPurmS?=
 =?us-ascii?Q?0oL2pALnZpFKfCm9QagBZVs85Pmkj5GJ2IaeS484VsmXPZDLigcv8/HuS0Tm?=
 =?us-ascii?Q?sl8nauhC1vPuw2XyA6LiRYz5PtSJcqCcESMaR2xRWjGlC6YMsd0/LKPT6Klx?=
 =?us-ascii?Q?1DfDXInrx4GdZUH3m64u2Dx8SeKzQhKvWy9NNHMKpLLGTtJQFa984DfO43Wj?=
 =?us-ascii?Q?xtCz9XJvW4D7C4wmW4y3ADXWt5EZ781Ez+LmoB4yapYor4KeflZsAy/YO66y?=
 =?us-ascii?Q?ZzV48l41AaBvmsq42pGYJjXkreLkzsHoq0wo/+apVsTFm5oN7YP8HNJgQBuN?=
 =?us-ascii?Q?XZxMrXhtjeamhTmahzM8+8EZA4/v4AoDisgwRbsP0+2BFJlz/HE8k68N+BEd?=
 =?us-ascii?Q?EilOIgw2PrX5t0RgL/O+geKdoqkm4UP/xGhGOYh7QM03F7IKE/NAQ805UXp4?=
 =?us-ascii?Q?Tp3TE/7fCSDEMMmsb4K3IQuJrqUD1KxlJd3l8OfLQv9pA4a3Hn/8WYN0ni2U?=
 =?us-ascii?Q?BY0QwWWiSRRbY/A86tLYtDynLDffozOPkDS91IIfhH5G78+xQLSq1tX4iOj/?=
 =?us-ascii?Q?jUWKVlFCygoj7GXBkpNdBHH/EHXjcY9uHLt0Y9fRctk0mB1EsgdRp1Zudl3y?=
 =?us-ascii?Q?T6OUTIYo23lZoFcB839pxDkML/kplhcR4ZdomQJh1tdTUs4nl9FSYPh1+E77?=
 =?us-ascii?Q?4lXjo18PD42KrFwfx0vpKg86NlH+/UeOZaO/9xWdnqSZJQNB3cEqd6QCQbil?=
 =?us-ascii?Q?k7qbAzVSkHO44X6r4e22+X5WyL523d6A17RN8Ajc81C6JhEwgPMvc2+FDxl2?=
 =?us-ascii?Q?hifSK89pIORT6iBD/dLFzNQHVkxNACszx9JM2gvHIlE5Z+oV3DVNvCQwKxlp?=
 =?us-ascii?Q?DaGPM0vcpzo81IiajMAIa1h72qgv3xOztqecVqgHevgyKbOJylz5koKMMRfE?=
 =?us-ascii?Q?uhVHw3lSgi8w5Ii4b1Fo1oQjvbG7/Hg3Rv9gnU+GFPxgb1zj8OBt85lHct1+?=
 =?us-ascii?Q?q93ZUfR5I1jtzFkqwP45qhuofGVup3CfTbPgza/OFUCW6/7OY5fTscHPwD/E?=
 =?us-ascii?Q?zLMFapLJW/NizEQJPxL+jmE2Q9OK6BgpJC+FVhhelPqI4LTlQC9Ne+rW3Wc3?=
 =?us-ascii?Q?HoYJpcoVFHfrReb6a/POO4ecSG8A2oPHKlGZ+sY1MAlQ7UVGOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xnq+4QK8ebjpg6mlUJjfRq2pLVBjKl2F0/ywy4OuNscTfzWxHTzX56pLK+R4?=
 =?us-ascii?Q?d9hVU2u3HBE91qIx4eV+E6FSrqpD2pT0r04XdDPAAvPmKDyiTqi0evzs39om?=
 =?us-ascii?Q?CAp8iy+Hss+OuhLR4XlwOG768XuvG7aQaHaqdGFeBAcRdYtg54HRttsQUnrv?=
 =?us-ascii?Q?NiOOJl1bIHmNMyDWjZRj0WkCS9vWjqlGv5qrY/fGurM2/9zy9v+4ZI4TY8hl?=
 =?us-ascii?Q?EiU1dg9o/EuihNAe3RtgQIK5GO/TTT+D7ZsH6HhBg8tE9omD/a2++1Qv9vVo?=
 =?us-ascii?Q?snAQg8k0EIqKs5hbcPERmNpa6QuA/PTUEzkHHJIjiyspkzJIDPLyy+FReZyF?=
 =?us-ascii?Q?xKC+pVkjUjMyNjXe6gfwoR2ncl47p+mEl1eCqdk5pcaHUe8DI9qS/ZXycmTL?=
 =?us-ascii?Q?dQikJA280q1edid+2nRzsj27qDmaJpOtBkPNL3R6yIBxPPkEdVul4YlEWnvV?=
 =?us-ascii?Q?KS28cGtdgyZ7Dk/0n9yidkJlywduRFjI+I9lhCzrPcsP4X7VEi7W6x7SIeAm?=
 =?us-ascii?Q?GG6bJYhoelzFBRRxXNRO4kupWpZObP+O6RBMBLQiNPpv6KIScMFxYX0xis58?=
 =?us-ascii?Q?giMKJ7LSfSPKld4eOtjf2aZhDpJqhoKdFQC4SBUf4M6G2P/ZjntoWc4NP2Wu?=
 =?us-ascii?Q?BfxPoe/afXHy+9PgsoaAA/by1Qe2YA1cPz/Hz2P1z56aoJ9Vlzktu/Rn1Fzh?=
 =?us-ascii?Q?SC3rHVNhyvZPWbaokOmW0ytpN0DZycNWPQG+jTALspPUf8M9cQI9SH1BngsM?=
 =?us-ascii?Q?k0H43IkuWOTpxUu8aLnAW6ihfn5jqCcAMJnqUCcX7XwczvY5mQ3TwrF/W9jF?=
 =?us-ascii?Q?iycY5mZ/KfQeh2DZCIKw3hpEuHMNjuLvToHh87RF8wYRBaUpB+Uj6edxuYmH?=
 =?us-ascii?Q?15n9tuGi5ePMRwsFmHhNN83wpyv7UYurYbHSLXcDa5NJsRavcFKVoSitXg/G?=
 =?us-ascii?Q?rRhlqnVUB2c6BnX+QaV250Orq51+UuVG/GmBzJb2NuC8ZXktHjDeiDT9Kn51?=
 =?us-ascii?Q?ys4O1RXdrEH04THB09U1L8lAMgNFsJ4nhxFvNb+IjypiwAfeZ47Iz6/XLWPv?=
 =?us-ascii?Q?H9pxDUu1WLuY/vKtbO15IGSayoeGg7W7rG2njLRXYjEN2wrlvMNQ27xOpn3M?=
 =?us-ascii?Q?vjyL2Jx03Hsk6OIIsj1+7otjYby+FLsIM4zWNwi3c2vIP093vgUbR3gINtQV?=
 =?us-ascii?Q?f35r665DlrlsUQuJi/1+ENL6puP9c7uX/aeDZJ/5f2tnbumCSi71+RTfV7gA?=
 =?us-ascii?Q?4jZeg5hoJnkBocDZj64W+mAfCvTqYEPotEQyG5iTgoj21TZVePSSIIPLhE1f?=
 =?us-ascii?Q?vxA2W5oyaVFYJYKXTIvrq+89MCwI6bEPDK7NNCj7hHCn/5bY8jWbJV7xxpqu?=
 =?us-ascii?Q?Hu3ToKiEW0dQjKkSz4p8fFfiQdTQxUHLns5sGZNyRm6iWVoyR6OQ/Ibp2YX2?=
 =?us-ascii?Q?SwgkgaWr3b4xJypPC17cjxeq9O9JnwjdMw4LHxBqO/ebejPQhoYtrv60pkQJ?=
 =?us-ascii?Q?ySaCJJyJv/YlHsdwdIKgJBCWivJum1EcS7WbAv8MNRVxbVqsI1WWQhnzX/vT?=
 =?us-ascii?Q?lvz1XdJE+wP09oKouGQI796eZosemrtEbmLnsN60?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e903566-369c-4da1-09c8-08dcc8cf3391
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 08:39:03.0548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6qBlDVXQUKoqAmyuhJ3qZ8LRLcuN6vJKFjYmTWmUMS/T/789RDRiAOT+E8dEFAc5ODeRCtIzEQ8yVqPMw9G2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6454

Use dev_err_probe() to simplify the error path and unify a message
template.

Using this helper is totally fine even if err is known to never
be -EPROBE_DEFER.

The benefit compared to a normal dev_err() is the standardized format
of the error code, it being emitted symbolically and the fact that
the error code is returned which allows more compact error paths.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/misc/genwqe/card_base.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 224a7e97cbea..4e882bff7ee5 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1185,35 +1185,32 @@ static int genwqe_probe(struct pci_dev *pci_dev,
 	genwqe_init_crc32();
 
 	cd = genwqe_dev_alloc();
-	if (IS_ERR(cd)) {
-		dev_err(&pci_dev->dev, "err: could not alloc mem (err=%d)!\n",
-			(int)PTR_ERR(cd));
-		return PTR_ERR(cd);
-	}
+	if (IS_ERR(cd))
+		return dev_err_probe(&pci_dev->dev, PTR_ERR(cd),
+				     "could not alloc mem\n");
 
 	dev_set_drvdata(&pci_dev->dev, cd);
 	cd->pci_dev = pci_dev;
 
 	err = genwqe_pci_setup(cd);
 	if (err < 0) {
-		dev_err(&pci_dev->dev,
-			"err: problems with PCI setup (err=%d)\n", err);
+		dev_err_probe(&pci_dev->dev, err,
+			      "problems with PCI setup\n");
 		goto out_free_dev;
 	}
 
 	err = genwqe_start(cd);
 	if (err < 0) {
-		dev_err(&pci_dev->dev,
-			"err: cannot start card services! (err=%d)\n", err);
+		dev_err_probe(&pci_dev->dev, err,
+			      "cannot start card services!\n");
 		goto out_pci_remove;
 	}
 
 	if (genwqe_is_privileged(cd)) {
 		err = genwqe_health_check_start(cd);
 		if (err < 0) {
-			dev_err(&pci_dev->dev,
-				"err: cannot start health checking! (err=%d)\n",
-				err);
+			dev_err_probe(&pci_dev->dev, err,
+				      "cannot start health checking!\n");
 			goto out_stop_services;
 		}
 	}
-- 
2.17.1


