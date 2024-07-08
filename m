Return-Path: <linux-kernel+bounces-243817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4288929B05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 05:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512AD281237
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 03:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B07563CB;
	Mon,  8 Jul 2024 03:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RU9GPRMs"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E423D2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 03:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720408534; cv=fail; b=RTThzvgxBmrbKRUP5nbq//La8TQpIeG1C7QKyUnSYoEvLP8cw7ge/ncQcid/mjHEkGyi9Kb4c0c9wU14FBx4r9d4ZUjvJWOYymwa4kHsS/KS1ZTgLRhYT3XcYbp+/WbTOonwyk663allm0f0j+BbcBzwYSg/mk6U3Ok2vGIvV34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720408534; c=relaxed/simple;
	bh=jgVzwMYgFtnHLnrK/HLNoJ48u6EaYobYEvYfx5ZaAWM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gIupaiMXpI+BCW9lK9htpT/stJRC9N+V7z+8XYlLDbh4sITlO8PsmKgaZwQGKDZSxuHTefCfXA+9UzOD1AoHh2Z9YBSb+ZEUHavwUFnHNB2i782+dkeMkF/N+uh+ef/PFWILw8zvQreMOKv/w4Q9yunbWIcFh2xKTx8LDYtRqr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RU9GPRMs; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0NM8fZIVL6FKh8K5TsS/dyvvxgS7I78YbyrOvGd7t4Xc950ggeu+dmFbrp6XisiqStKKaHVwqPe2bcfn+SJqS5HU8AbwG4nljc51xZ3siAu/2+AWlk2XhhhEbtwr4fKI+KokqZlDHQpBSOIiYL/Q7XFMu2fm+M1v+XBSMuc0lb84rC24h/UFAMT0rwA4fqC05lyW0bN6jC0CAggsNK0IAIGwiXIWZuOY6AGpl+XMsTKsh8pHNngNL8Sd5iNlu0WEL+24qf6Xx9G50PSyoVRGRBCrQ+k2RANl8e6Aj0ZQiC52do/71OqIU1Umz1MoZ2/WovBAltoR8rTuyV/v0Mdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPFP51JCeqfAvS9UIvZ0yuvgLIug3a2MS+BuOmMlhZ8=;
 b=X1ic23yorM94ujta36yMzVxDmSC+oI38T8WZRiZuoSVpzbS0stfTJuypxraZmDEzYQgYMFSW5+enEBGGtb0KH0AsnWdjA31QKJHxZognR6Rfy1kqadjwUnlDSkHJXPLLxE4MALRSs/8YLWtSI3zY8z16sJ7CdeDIYJl+XEnrANjDSrVLKYXuUSGVSLwiFVlQx8DR+96RK/Yno71dLUMUvUwvYJ1f2AzjfFtsTXcAAXkjUjnMB8L6Lq1dAXhb1CzHaA3iunMTWv+nKfdgDnPI53+SA2kC+RGSMlV7+fe//1XxhPbVhrEWEQXDo/fp3FolFDhnd0mXd79BkPeYbsrfsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPFP51JCeqfAvS9UIvZ0yuvgLIug3a2MS+BuOmMlhZ8=;
 b=RU9GPRMs3UTNfEx18BhU+2CPzOzuNCSxBXOHBrXh48FWDFJDCWGYBFKJ6GWK2gDjopAzL9r9dzDK1bj9ShV78P36mYuW1G4Bp9oS+k68F5CAH34z9qeBC5VDLM+1TYjKCYVFRqjG/v8IBOHyXMiZEnRMtNalp+9fehe501NOk6GxKC4okEeB2AaY9rRo03Nib1rQogluuQ5NcLGwA7Ib6gGQIpGCNoBx9+BFnKAruLuxxK7YVOgVlFk+1irI0NOK94mYP9A2jSph0QattZENGLBFAEomsjA4nSKMMC5gw06ay1vI9/cjLe4C8cd2KgeJKVlAaOJlJl+ZYb71qCWMNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB6671.apcprd06.prod.outlook.com (2603:1096:820:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 03:15:26 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 03:15:26 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <baohua@kernel.org>
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>,
	Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
Subject: [PATCH v4] mm: shrink skip folio mapped by an exiting task
Date: Mon,  8 Jul 2024 11:15:17 +0800
Message-ID: <20240708031517.856-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a714525-60e2-4b9f-c3d7-08dc9efc368c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g1E0nYwG6xIDHerYzkJqRerDL+Q2lH5uRwCEVFIkApjO2bANv9hulh6yJKWq?=
 =?us-ascii?Q?9cwf1uvrMEkU1dpSxd0DIU0R7eq84Cy0uQaZTZ3B5SJvE3UAjqgj5p7CYli2?=
 =?us-ascii?Q?jdQ/7Rrtb9+UvNZiReHrMxxOHJcwZIZOGvLp+q5i/FI+yCB5AuS/IUJnQPi5?=
 =?us-ascii?Q?U/Z0J4BHtxQ8HuM3J9hoYs+24Ke7FamZv7TxQ5pF0tqB8QHn2okOMXVcdEKj?=
 =?us-ascii?Q?vQQ3ygPPhjruLNK9JI20pa/AnZcH+8PN/K5v8pYSAYqK78rDEoTMVmYeTDes?=
 =?us-ascii?Q?odDIAiEvVSRK6W33Kd+D0lOz0hH9Fh6x6Jm0eNkFGzaxHer1yrQTYoueNkav?=
 =?us-ascii?Q?0pWIofTUM1PnC5EjHLpszeubO4UWAeSaXIVj3aT6TzHXJvx3IC752/LqF5iJ?=
 =?us-ascii?Q?6AaVDr1x9+b3+aAZxFcxIc16boA6p8f3jx9+Iy8IkY67ncqKdegyE5CeHkLi?=
 =?us-ascii?Q?k74GbxUx/Z6XF5uuKCvniiPJmcFMGPK4jNQBSIL0ggQGW8ElYArb/xySPD2v?=
 =?us-ascii?Q?HGvn5g2y6PxmcK/TMyD+2+1okjIQYm1bbKMMJTCLzcaVXAf2kwxNCHITX3O+?=
 =?us-ascii?Q?U5LmBq7d8CegnMWXdDuM0Iwt5S3UWUT3TVCpRvm8jMD/PL4fXEZFaEnj9Ghh?=
 =?us-ascii?Q?HnVUVL2C7ebamhxm//WSpfwGFzJGFI2VieikJzjH50GPo84BoO4E5ZVWAcr5?=
 =?us-ascii?Q?cN09/oThRJCK7paRDrqcG4fhS1ml/b/dZjUPBrkYylZmiCOokiHNE4AbBDWu?=
 =?us-ascii?Q?YyXNnuI0XCXE3hSFkHt6xlkIDEHfrSjbhelvQDQucdAvWQaC7O/ooX0Az8Dm?=
 =?us-ascii?Q?1uH2yuQjj6nQaFETCI6uKrkjiGV7NXvT/Q1MdPO3z42+KkBBykZvrd+tEG4o?=
 =?us-ascii?Q?/Nw4YnW7lniaZH0YdmF+v9lPa8D1oULevkaEcgebk24muN+OY88aZwypqHIl?=
 =?us-ascii?Q?RrodXnnLRVHB1TMNBXrDrllr82MVzi+AyxCBq/xgYFzbM70y50QDYc7uuZ4F?=
 =?us-ascii?Q?dKNDbNr+HFuHj+jwaW+MptDkFd34tVeyLe0UL8Rr+M0JTdHxd46+EjxH37b2?=
 =?us-ascii?Q?ayEHL/DfUZPLDiyjjdKpPUlsWDmSO6cCUo2OBqEKroowjJpjOcKVXXdqzS5G?=
 =?us-ascii?Q?8UbldvykOHnE/pu32bulAmu3JrMU26QxUX+5WtqbRF6xgKZ1Bu6RXylkhOYl?=
 =?us-ascii?Q?ukkKkXQrnF2xAVDQMZuPoFmwnryfmbU1sNeiedChZx969FisogKBMnnjS46C?=
 =?us-ascii?Q?TyFRNhLHMRw7W+8W3re5bBKvxTJk40s3H/06DkUC9LzNYJdf/ajjnslrtjXy?=
 =?us-ascii?Q?HmaJCGGAcwLOxLDmyR2CS/axh1f5JvFatJL6NSZidFRqmOaUFuNLdqe3ElCQ?=
 =?us-ascii?Q?Xp+QWrjFQUbc9ulkUreMHZO9ql9o8EOIqPyfWlU1vg6+zZy36Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nmjxn9WuargAL7rrS91QPpwGwkXLcYGAqrpDFN8sgKXmHHeOZwURbdwcYUKB?=
 =?us-ascii?Q?wBZe/NiADPL2S+6/QJTIIr32lax4Gf8W18ayuo6CBXQjiHRrqbV/78Fjwe6S?=
 =?us-ascii?Q?/lMVDsUf+kxoVYGvksxH5CqSW5xBbrgWEIiALD06+v3YGGokP1N2Dkbc+2Kf?=
 =?us-ascii?Q?7VE7w/boPGoUvzW5QYCDjek9cKMuKjjlqrRf4P3hPVoaeO69lLssfvDJK3BJ?=
 =?us-ascii?Q?TtCC4OX7WOoXrQ4Q8PDTwHIwZGSD/BqYe1ua9xZi8WAdLQ2DQJwMVtzUQI1/?=
 =?us-ascii?Q?mao9TkaN+TiEUZwaImn+TycOcuTrFiF/t/v6SXEByNKYCt2A7zTMcVBxzWcW?=
 =?us-ascii?Q?kkNoPjXmIRLQZfgUgCEQ9xqyEeLdqF9ayAZ5ijHSqpy04TKxb+d7WFBO2sn4?=
 =?us-ascii?Q?uwpcCe4x0Aw+mIQWyf0xiQSM2vzMcKFFKngg7ydPEjasSkVpb3PBZVFs7u/J?=
 =?us-ascii?Q?7tV3HeGi8tWu9vRZ4nBkblrDlVhhUdptT17mk01jsDkfc3GnMTbFmP1QexY+?=
 =?us-ascii?Q?yWWYAxuLRuC1HCoKYX6Wm0SZjoRbObeVsJHW7phV5j0wTXtKdrBlxGSlij/H?=
 =?us-ascii?Q?kyTEZR4xVgg/G7Xrnq8/k4WckL7+qjV82qtJEV/8FsOzODIO5RHbzmJOhVdu?=
 =?us-ascii?Q?RlVfd2J1JiLUm/dP1eo8UqWchuEEeOCDB/6AuBY34VM6SYitRk/CDQYKVER1?=
 =?us-ascii?Q?+Ev5AZ1D1dyRNJE/AuymG16uHrRtsq6lj/FA7MXQxoKsbDCU+Pwe8PryQm6Z?=
 =?us-ascii?Q?63nLkaoto0cnbxxvp0HlGIShlj0//t33Djrn48pc8bFP2t/4RWB+mDIRMh3q?=
 =?us-ascii?Q?69j/8+Zu8FK+IYQcw1fSg0DHFEidoDz+EPI56CPzcg5SDskqKzTVR56VOOOi?=
 =?us-ascii?Q?Zz3+obhmzHDRSRcmdOpu5owUodz94+xjGALanHDKSxMk3LmqbmZbPaxuRZpp?=
 =?us-ascii?Q?F/xE72xmdOcao4ee563h5mYqMmuc9Hak44Q1gK8791vtzToxo2ASo65qKTAJ?=
 =?us-ascii?Q?u1MHiVHf3D7Xn5as8ks9EebSRVx4uxsyp861orxw9r9bMtA6pwRKj6mHN2ss?=
 =?us-ascii?Q?ylDUVr7f7rwIdzW5R3wbZS/UChlnVVS6W/8x0X5YxU+0mZxee7JD81IrvJOd?=
 =?us-ascii?Q?oXX8zmjHiy62VGKQKM1PcRbatmp/WErChLFSVjkQyx4Ov6K/XLCjJa6vBlOJ?=
 =?us-ascii?Q?moBfpLEsH8dO73uJEUX8t8H8Z+m0n9J9k9zOYPRiIvXqcek07cF1STLNk4zW?=
 =?us-ascii?Q?QkUOmkvLHX/JP/fAA8yJvo1ssQWei0KcKKe/WI8lzWvp6H0FTk8WKxJ9/+F/?=
 =?us-ascii?Q?Q69Bnv0KRyez7+lID4WHHsLguYF68gwtolj4ZqwQ8CgMDWdeOdphak2jKWKT?=
 =?us-ascii?Q?P/ziG7sU8EL2b+JIC6OItBdGghKj2irQ8+bexPNv1hObNJdjI35HsCQbmo58?=
 =?us-ascii?Q?JkiFd+NPvIuw+P8dm2F2Y42OBEFEesTtiPlEID4jDgSTh+DIchGFYjE0wEwr?=
 =?us-ascii?Q?I9c5qXHb7QMok4aCc6MPFPX5Jrsyojl2suCjqquM8pm+0L1nnBTTdAZf/Rtc?=
 =?us-ascii?Q?qst+8sTapHrNRRdFZkIRp7zzIv+HmjIHjEj/TgiZ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a714525-60e2-4b9f-c3d7-08dc9efc368c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 03:15:26.4752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79mFgI30Cv5rq6kftCVkOy6a7WLrJVrYiKDM/I4Kb0bKcLUgNmje4x58K4aVc8gYSCNBwYUvw/75d+kN+FPfpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6671

If an anon folio reclaimed by shrink_inactive_list is mapped by an
exiting task, this anon folio will be firstly swaped-out into
swapspace in shrink flow and then this swap folio is freed in task
exit flow. But if this folio mapped by an exiting task can skip
shrink and be freed directly in task exiting flow, which will save
swap-out time and alleviate the load of the tasks exiting process.
The file folio is also similar.

And when system is low memory, it more likely to occur, because more
backend applidatuions will be killed.

This patch can alleviate the cpu load of the tasks exiting process.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.corp-partner.google.com>
---

Change log:
v3->v4:
1.Modify that the unshared folios mapped only in exiting task are skip.
v2->v3:
Nothing.
v1->v2:
1.The VM_EXITING added in v1 patch is removed, because it will fail
to compile in 32-bit system.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/rmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
 mode change 100644 => 100755 mm/rmap.c

diff --git a/mm/rmap.c b/mm/rmap.c
index 26806b49a86f..16b7ed04bcbe
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -843,6 +843,16 @@ static bool folio_referenced_one(struct folio *folio,
 	int referenced = 0;
 	unsigned long start = address, ptes = 0;
 
+	/* Skip the unshared folios mapped only by the single
+	 * exiting process.
+	 */
+	if ((!atomic_read(&vma->vm_mm->mm_users) ||
+		test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
+		!test_bit(VM_SHARED, &vma->vm_flags)) {
+		pra->referenced = -1;
+		return false;
+	}
+
 	while (page_vma_mapped_walk(&pvmw)) {
 		address = pvmw.address;
 
-- 
2.39.0


