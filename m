Return-Path: <linux-kernel+bounces-373649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96E9A59CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 07:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36311F21CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D50946B5;
	Mon, 21 Oct 2024 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QZPQX4SD"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020077.outbound.protection.outlook.com [52.101.61.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEDE634
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729489244; cv=fail; b=Uv9AMWaaUmCsGDYbZuJT7RtCAX8me6dyssYzMJ4DAczOTDRdJRGTtL3VB6EhPL9quQpHGkZx4hkRE8zWfKnF/PLhqLwOitcWBJnPFxX4InEDeqgzBviDtQ0pZIgfg5ZxKnsB85w5eny7QcsJsX5J6s7o+BhpbG4u7Piu1Pkmm1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729489244; c=relaxed/simple;
	bh=CTSUsylqKei1MKP+7zw0B8QJJViRmu76Zyn+UrgVm5M=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mLgiCBMMqT2l+0AN70F2TOlx4pNHXsmfVqJW4PGdTZ8zXPP3Xe9m7aTJ3vwsKdF4OBFijm6qoYl2r2JJEk2mKjI+HOoq1pZz+XRnOqaOjJlX/KJaUQOeQX/st2+TLQeYJnF511A9+FXQn6sDUrkNq9YpCxZMSvyHCDDfu86/8dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QZPQX4SD; arc=fail smtp.client-ip=52.101.61.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnp7EYWS+HeypCQtJlHVg5l/nE8hRrDwEouXwCThF/JKQCMXxKRTxmkt2mx54R8Rmu++9Y6V/I/6qxvPJgKdB5xKyUieQlKVajf+yAXboHOVvNzcj41VHns67bUqT7J3v0VkSXAaHcinQIkl0dA3fU9DblgSlKU6mMSauwcK+r62lOT8Un52oXzGdMJyNYpSrrkwQsMBPJXBIXi7kDiveLQsnPWer3BJyiekb0t0AQSApMLSHvZtLFKlg/VVXxgQsJT0VmMduLzIwWpnHPcMEeaUTDTB9l/QbkkvHG28OZ/A8EOZlMQXc0URMxTBH9cOSUf32aAg07oHJqwmC7Fq9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CQsNfjx/IhkKg0ZPpcHM7GTbIkISt3CJbYTz+tebI+Q=;
 b=WcrhFoMhbmoRJ11wdSleIsmAJiUVqguVD1lJbWaKIyNaBwoVDaYC93ldD+z++4iJ9DB4pgrv5HlhQueLhhWdI6PcNQ7ylnyDTTZKxF/qES/5epDtYQ+vUFnYQdkdHMTdJQjsmGqjhKGIu99KABn3u+UAvHyFHEtBCaFbJn/IItm1mK7XMQUnNJ5fwRBVzDv1iRFSGlVlZFdCDOBp92vK9PlE6+tWZxsKy+tc4BLw4GrIhvR3UFpB4NulSkcF6bKx2BaE2nzXwnxLAXAYXj8OPF+hlhCfAg3KLjFA7pfBEPSaBDD4i4DIAxuw6ATPnq0LveZdz117Axt2lOnnVRrtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQsNfjx/IhkKg0ZPpcHM7GTbIkISt3CJbYTz+tebI+Q=;
 b=QZPQX4SD+YA1gmfe+BVS8VKBSotilyiPc5esy7TJAd36ch5UkOvmF02XBW/LoLBWr5ncdRBHcImb0wm/NFYi294r95ahsoSu0CC7jgAxRye5pyZsCyrVsbdpWfhaNeqTd38cuyUwZ+uKxGDG7XUvYEatHnfw4U70Oo8Xtpq5BW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BL1PR01MB7698.prod.exchangelabs.com (2603:10b6:208:395::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14; Mon, 21 Oct 2024 05:40:38 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%6]) with mapi id 15.20.8093.013; Mon, 21 Oct 2024
 05:40:37 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	cl@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	adamli@os.amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH] arm64: set "rodata=on" as default
Date: Mon, 21 Oct 2024 13:39:48 +0800
Message-Id: <20241021053948.5848-1-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::17) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BL1PR01MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: b04f67da-ac86-40eb-7fa8-08dcf192e3d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DmtExvhIoXfu2aKqPoIkcB8YV4ORunkT3b6TmmWIUjPN8O0WXEr7lD3W0Kcz?=
 =?us-ascii?Q?vKXEsTQfxt2AxXxSQimnjw4AuMU0fGV9wT9dP8TJUTetjFR19+LI2n9NT3XR?=
 =?us-ascii?Q?WEb+IIXp619cf7T+mztmpmlSV50d+PpEnjbB6FCUJQfqvfRj7G85Mb4QuxdQ?=
 =?us-ascii?Q?EM1qJyrRN7y176VgpyZ72FtukNKUfy7UbTVIttrO5J4js/YhEgXwwrSgaSiE?=
 =?us-ascii?Q?I54ZyrSsu9UjT3ba2uc93wW4I0s8g2Fv+7XCJz58PHoX/piNSesVDNdLPnDK?=
 =?us-ascii?Q?xNFLRQIAj9HXtxiNzUegjRjFpD5IjbWLCyg4DfivAbFkEdarZETme3aCNc03?=
 =?us-ascii?Q?hOOvHAnbmkK5PHgfWMF3cg3otSy2Q/SGx9tNaBRCECVbdgzhL0AAEYMXKj2x?=
 =?us-ascii?Q?QM3vKxE4FG1ce7YDKddoav3fgOtBx8EivaCUZQ/rSDvwfAUq3sUD5L6NPWqK?=
 =?us-ascii?Q?qgFko7sC0WUSMshXRwUJt55pACXAxuWMG9qLn1w78ATMHhcgiDZHHtddXnOq?=
 =?us-ascii?Q?Kqey+aphhu/+CMSseH3RDWlwAFQ8NDl5nfvshjiNqBQ39o5LLiT5j7m34dFN?=
 =?us-ascii?Q?vH4RU1vYRbH0M4/62wrCWx5Z+7OqR0c9qu1fSuSyFN3E0Eo84zCQPjcI3Ny5?=
 =?us-ascii?Q?JWTCG4QbjAembDyX0QwRXeSTc5sqGq+nNhhI6qNlnDMIn/yeKrjBOoml+E5n?=
 =?us-ascii?Q?F24181Fd2CaGNY9pN9qyrN34ntndbY6wGnVNSPTo7bSXYx1uMJiecUKGsPES?=
 =?us-ascii?Q?l8uTi/wmR4zP60TrEQJF96EkFPVAfrjVG/mZ0SbI/7s3mJVdzewGlVrU+VLc?=
 =?us-ascii?Q?+GHMczl/Trj45Y71aq+9hm8fZl0uHNFipwu5tQtsMxUkg9mjnle5smwgU9Nj?=
 =?us-ascii?Q?PSwNjOTGswZUZtH/wYmJaAuVe3J5xO7ytajEqdzJ4XBTR2e3kIduiC0Gz/Ws?=
 =?us-ascii?Q?9A3pUg16My8COJKtzEkeOJu1Y3bD1+46qV3yxqw+BbLNb2Ns+ylJj1lncfow?=
 =?us-ascii?Q?AlItv7sV04NCj7WiFDOy07u2wHoFeoYeFYALWosZBVRp9fRFwT8ce97DvFuF?=
 =?us-ascii?Q?mbk3lFOPqoNqDoVBf4eW9jiD0eDSXUWbPrGWWtHPP8fM5tpIh05nRYxGtjDp?=
 =?us-ascii?Q?krbQrF5T6PQlG5aCt5DaKb3GPDo/LXqBySsTrzN9aE882OgtSovc2MF9wNXu?=
 =?us-ascii?Q?zp7qwIYuy/y5yzATH1RkeskpuLJiEcQYyznOW1SCA26yA/6QN8tH60diUx3V?=
 =?us-ascii?Q?LHbwOH8TnXqNUU8ATsinX/azkFfNunfMZyQyEybJDbx7xUWZYzMt/Z2BHAzf?=
 =?us-ascii?Q?lqmxYW4HYcuVo5bxO5yDOPh84VIjDyKDxHZs71+5dnjTwTQvFTAO6TsZehzF?=
 =?us-ascii?Q?Pn5+E6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KyFUknUO9EdGuBsI6dT5I01S7XNz51XhE6P8AQNs4m72Whsynip0HPKCbTXT?=
 =?us-ascii?Q?x726ixkbkanyJr9ZYO1J03kwZXCJSTQIEZzGRatJi4ydxt9Gn/YwryIONe7H?=
 =?us-ascii?Q?TiVchxKhbyqGUoH/00Mwf4OIjifp7nH/+/tw9+qRc1Wfl/k5/wDF2FUeN1e4?=
 =?us-ascii?Q?j5i0UkBcmyyLOGtREUH1GYwYnhM+3jRivV2Qt1ttFpscjCreWRnDdJ/7ZpDF?=
 =?us-ascii?Q?k22cZs128z+1BgSW47M8x1wxEUGq+Ma7ee46LE6TRuKCg+YrGicw7uTXZThM?=
 =?us-ascii?Q?GbjEgGn/ripD4w4dwglY44LOVVPRrGy8/AWnOv58PLRNNB+5L+D0AHUX4XWJ?=
 =?us-ascii?Q?FGNo4GyjiuyB8sKqr1+LV9hCIALx+GKPaaMU62xf9S8N9J332ysL3je54pU9?=
 =?us-ascii?Q?nU0q2cqNL6e7DVfofTumcdvL3qFZpjbTj1dgeDgz1YNErZZcC55jBv3HB+rD?=
 =?us-ascii?Q?dK/hjhJfwrJL/gdwyQZ9fLbAI0xIZQrM/GDo5gQvJzarbGOxJbkaTjCJIyQc?=
 =?us-ascii?Q?xszgwUwq4J0EMmQ5zHH0rX9AmjLjVTPx0Ut0/K85pX0jPR98s2Qpno0xitd+?=
 =?us-ascii?Q?ni8Z2IkDSgvn5K1bnjNi1IV6JS7DZxJbA+KtyKsqW5PwouI5Gj4I6eKyeUR3?=
 =?us-ascii?Q?u+BYHK+Mg1CL5CoD16onm8GkzDSPeny/euonrLogNn+MB9BE5OyGdHpdJLYG?=
 =?us-ascii?Q?MLlXKhbXAnpNjqfONQUw/ZjJaOpDqegFyfJDxX42UP1JxFeUtIAjxhwdrIlx?=
 =?us-ascii?Q?xYj8+48a8XV074qKkSOKycWTa2lFEEHlvx2Q+saIOGvLSiP2PZnSyCLSJ7LY?=
 =?us-ascii?Q?HUHUjUQaENeZ8rF8rMGa9DIxakgFXwhdbjWiTFx9+AM9NbOoYjfP8c/3a7/d?=
 =?us-ascii?Q?S6PRI90fHx+NMeQzU8s+03agRlZuIIIWPx4mZXzN6iJ0e8aXGCjUiypM/zLe?=
 =?us-ascii?Q?mOVt7xXva3ljHe0FjEYlmK4L1NvRejo1q2OWByZPZ+E6CWfuib5UxeTwrjuI?=
 =?us-ascii?Q?PmuDGXJP/PJ29xJ9LCuZL0LVJ+uw4VkRh3XcvSp6feRhRJIvxwCIFKrZnCRl?=
 =?us-ascii?Q?8wtG0CCElpclsVOM8c8K/REWqxHw0BJbSJCCGTD+9qUQbxfQlD8OKnOlusfM?=
 =?us-ascii?Q?2mPGZvTjHIxd1lMOeOLivrMP4mv1VzmTe48NKtjiaDI/8Zj3uaM+Qjc2sogp?=
 =?us-ascii?Q?pINSHVLSwVzkOkh3gKTWxt3GefYdMPCK4xs9T2utpbZPcwPdaj02hnP8mef1?=
 =?us-ascii?Q?C+kisEkDmItrL0ZB3tt8WGzsdroeGXiFfJJntrq1kfz2wp2a0SLJ6Zv9vYyj?=
 =?us-ascii?Q?KR4jTtWGSTxC8Eyl8G+wpF+pPl+LPSgtJC1YcfKG4niihmYtDSc4GGy0GbG6?=
 =?us-ascii?Q?8veiW64UG1dDN05FEEUXcMo2I3EeoewocjR1fS/SW+fXTMBI3EXNQMPdxoKM?=
 =?us-ascii?Q?dkwf+ABjmnCNsOKZdPaC3YsXPqUn1cgieN2S7WkvMyvpI5rn1v00kJIPQ4pP?=
 =?us-ascii?Q?sZYC83+N5HcTlOZ8Ei4dDRLoT6QE9fFbd5JOzANrzJB1Vj7Zo5oO0dnTOah0?=
 =?us-ascii?Q?danZjJWJzNmDexBKgSn1YjALjicBq6Fq+Z9ydBpiLe9qCtVthF5LOtdYMc/+?=
 =?us-ascii?Q?qmhgy30tQY+xk9Q6tIxe4Kc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b04f67da-ac86-40eb-7fa8-08dcf192e3d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 05:40:37.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oa0JfyOUfhDXtTFXckLmEo9KYjQunFlMULF3nMLV/mAu9AQ1wWZH9ZW+0kwvmDGM16A5y3r5JdPsJPBJ8AkP/eAnzYbj/OoT0rXkbSPNNoVBrSr02SxWdyf67ESzTyt1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7698

From Documentation/admin-guide/kernel-parameters.txt, we know that:
 rodata=	[KNL,EARLY]
	on	Mark read-only kernel memory as read-only (default).
	off	Leave read-only kernel memory writable for debugging.
	full	Mark read-only kernel memory and aliases as read-only
		[arm64]

So the "rodata=on" is the default.

But the current code does not follow the document, it makes "rodata=full"
as the default.

After patch
  commit acfa60dbe038 ("arm64: mm: Fix "rodata=on" when CONFIG_RODATA_FULL_DEFAULT_ENABLED=y")
the "rodata=on" can works fine now.

The "rodata=on" can provide us more block mappings and contiguous hits
to map the linear region which minimize the TLB footprint. And the
linear aliases of pages belonging to read-only mappings in vmalloc
region are also marked as read-only now.

This patch disables RODATA_FULL_DEFAULT_ENABLED by default,
so the default value:
     rodata_full=false, rodata_enabled=true
then the default behavior follows the "rodata=on".
And we can get better performance with the "rodata=on" as the default
too.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd9df6dcc593..6f30f749156e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1649,7 +1649,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
 
 config RODATA_FULL_DEFAULT_ENABLED
 	bool "Apply r/o permissions of VM areas also to their linear aliases"
-	default y
 	help
 	  Apply read-only attributes of VM areas to the linear alias of
 	  the backing pages as well. This prevents code or read-only data
-- 
2.40.1


