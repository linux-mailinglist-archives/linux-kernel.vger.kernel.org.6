Return-Path: <linux-kernel+bounces-414924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42779D2F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0589CB24D07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE201D27A0;
	Tue, 19 Nov 2024 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="b483+4Sw"
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11021126.outbound.protection.outlook.com [40.93.199.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7971D26F1
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.199.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732046979; cv=fail; b=PaERNbmVCOEjoTC/s9McGXxxebPiXW85yz7K5NDHd0Wp9kQ0MxVlkSydfICA/QL16MZ/whyPb877A03REmIt26QQVqNIOhtDOcruZYaKfk59tdNPfJC43AI4JZkxEExw0C5csBm4r1iqwqBy+87GBR9lwchSAq+YUnfOEjWTVbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732046979; c=relaxed/simple;
	bh=KdBvzfzn14qc1IeJkHx4E+SceESN5NeNu2lOTsoKrf0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=IjYCLUP9T+lspO0Rq0u/4rGAoNTrdcIC+dUPWpS9H0MKApgueYTtGEDGT624GHzS6QqyU4E+8eABpuu3I52ATUg/lxK5MAT0F7SUm2KUMI0c9lUuU0+YAAyk1QXC6+cHMOpxZd73EdyXzePEWjPM/dRm9HBSfMwPkJ478YvQCHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=b483+4Sw; arc=fail smtp.client-ip=40.93.199.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9W9TvU6z8wfmwY1naF/PdWW8NyBSnrW4wmXz2c6K1ITF0nuax8wohgVCgyPEgJuTznBBKABkDxyWu9P29j0E0SChozOgMtVVCKUzhMg8AjsDOyHtVpGgdAyOhvjtbvGcUeWohK9Yo4mzxGfTJPPi+ISVU/D40pV15rZOrhPX+AyywTx7Ics30wJWAXXx+D+DN4g9Pmdf+UNprUBfGkdOkfMG+Kw+GfKl3VhPOBszr5j/lExyor/27vUmB1omc9eKhoHls+HTWzREHzqe/6/y1Yc6QKdPWtXSjeuoODzFyzcJRbqEYnY/rxuhiIu9JeU2uilELSsmuz46uCPNsnEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyYmh25NfnRbNK5V0OBox36zmkdRcEDANamgeVO2zZA=;
 b=xwJao7w1sxeXc4VCuv3GUfUDcZrmNT8nUB+9e5M4Sa4M3PeEEKDTBlk7jv1yNcn5lC9p8c5+/hcRMbwrE1yVSO22LfYikonOYrNOBD3EbtD0vnDm6te8JjPqhsTV10WftWGpSs5A8VFt4O5KqQtl1dgPVaMdyjf8oWpsqx9O+y1ky91U2C6G5N/QkfYnqL7DsbOh4PAVbPVrQtmpDXy0Do4NBkP/eaF+E0ePpRbEPHU6G/nLKqI/+dHJFmatWAJtbweQ1dA52BGh70FxBX1CgDK1BVTiQagK8kxRA3VDJrXbE2xgKsCt+Jyg1hN4hisKt5eSrbIswSEAG8m3C7Pyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyYmh25NfnRbNK5V0OBox36zmkdRcEDANamgeVO2zZA=;
 b=b483+4Swq+mjN0GcYYLdjxjponEALyw2ky60yQ8CqsHcC1NZHxEG7RAX37FRaBbo2QzWkmXVww5Q1yGZEpxYI/SEBgp4DO73Gk5nCs7nKnqkAc/NygVOZ/Huk9317y1b1BTSMbXwDzWuhaULypydJttr2yzXwVUt0gP+vJydL68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 DM8PR01MB6982.prod.exchangelabs.com (2603:10b6:8:17::20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.13; Tue, 19 Nov 2024 20:09:28 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8182.013; Tue, 19 Nov 2024
 20:09:27 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6.13-rc1] arm64: mte: set VM_MTE_ALLOWED for hugetlbfs at correct place
Date: Tue, 19 Nov 2024 12:09:14 -0800
Message-ID: <20241119200914.1145249-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0063.namprd03.prod.outlook.com
 (2603:10b6:610:cc::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|DM8PR01MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d353aa7-7755-4d38-57c6-08dd08d611fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QVcF46Byvz3krYZkXcfrpHjHlb7AT+wKn42jlQ+TVYS3AB5hENTOS/M6GmiU?=
 =?us-ascii?Q?D/oUUsCxY/nJNm9Des4Hfap5GI+1YgqP9lZRVlxBSxFuCD+HOC/IVncjxqfd?=
 =?us-ascii?Q?wSClfrTtCa0sXaTxgErHoYP6/MFy7v7XoLdW78eHxXHCnf1IjpshYdR438Bd?=
 =?us-ascii?Q?9ot9VIx70AvWb7RFTmlWmlaN72Ye7mpzUtsOmCRkFkEYpC9alnYbJdofk74Z?=
 =?us-ascii?Q?aUdfdyVvuSUHctg1OjYzK34aRBj7xyrxv7rhu20a+PtKQL2As8gc9SGrZEW0?=
 =?us-ascii?Q?Fli9LC+ioHz76Yfp1FzRrYt+O4P9sZhVLkTeChYRcvwWF2yFICRGBnVN3ivm?=
 =?us-ascii?Q?7qdiYF62x2Lwj0AxgWvP60wopL9R2qhWY5RsIsBzyLKDA2v02FRzKQjnT0eL?=
 =?us-ascii?Q?/DTnur9QZ2OYoK+h7tz2HQSCMePcNdsY4XWY8b3jgIpRvvBpvxIMuWluuK7c?=
 =?us-ascii?Q?do4T4Wz63gbPd86a2zsM45UjFbh1nJG4XCoXPnN+OClOnXpdDuwx4DTDlhAM?=
 =?us-ascii?Q?u6uzTyvrx4ejHbKlrQ9J+Apxpip/QqkvQyOVsOnQ4rayP3vsJ1jyHb6YO+JP?=
 =?us-ascii?Q?ufGoXrd08r67qG36xeGsbgegz706uhINY41KqLLTbR6tFDpGtvTaZzctU1S6?=
 =?us-ascii?Q?OjtwRWbIhBfJOKNWpUt3nB7uFFeSF1isKtvbd95vkL0l2CFXmLG5pTj0o6VZ?=
 =?us-ascii?Q?hjMQd7wZxUFOmLBxfBkaq2dVcEf9fHYTLoE92g2P5ktltNi2xGwX5l7FqDRu?=
 =?us-ascii?Q?tAFI0O+StUEnQwTP/NL6ne7LPpkOMM9E6UzeP5sUuwvfR+Z4SFI0rcDCwwdr?=
 =?us-ascii?Q?ukzVtP9/T8cBr7/GIyUW5rZElrRkPkYqItZzkjXTeeldqTAh0JiKHBgYq1e3?=
 =?us-ascii?Q?2TZ9xxa4Sqk2fK2/GG1HZry4v14Ln55RtaDKR/0JislbXcB1My07j2yIeIcl?=
 =?us-ascii?Q?6MjGep+oqedrgt5Zlz0nsVaz41lImVpzcmczQC2YHf1SUX0t5uUcdurQGOlL?=
 =?us-ascii?Q?dmdrsoehhIB+qHlxPwinAA6st8ov6z3rAfyTyw9873SOJLUAQYDctoelkc8i?=
 =?us-ascii?Q?Bav1MHRS+lh2wYqGdBEhNLCBMlQtURhNQQ9qcTDwgeSdlUHxpNTA6irZOyEu?=
 =?us-ascii?Q?jGvfukQ/jk2ZF6AwYUnBUD2ixkU9i0LFODvHPQbNQugiH8ty4EcG7UQAo56+?=
 =?us-ascii?Q?AgxHBFdSYk3eEf3CFQDq07DKvYw2JpQUz50RnfzF6/yweUiRusGrVui5uaCE?=
 =?us-ascii?Q?UQ3w5e1rj1pgwSYzoOT2i+h7LJ1XF5rZn1EMTym72JdmFApDXaS3zvNvUo5+?=
 =?us-ascii?Q?f2KNbQFXnoEckvtslq6fWu5QvdwBnThtEsqZge3EOe1aGxv3UK0M7zoziwdY?=
 =?us-ascii?Q?j9Sqxn0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhQYYCK1rMBNJ3xBZUCOQ3cZtqrGHkn0g2lCfCV7DMUQIlcBHckzACZUjB1y?=
 =?us-ascii?Q?nbQylxEvg8VmdP/g1T6sBLOf/I5M5zVB5iolv2+ghkeR4cmrXYPaBOxDscll?=
 =?us-ascii?Q?Myoxes7MCUf60rA9EvFDrnygfP/seOQsyRQP/TeQ6CscuFeN895MC8rybxSR?=
 =?us-ascii?Q?uZ9Sm9tzc4ihvZy0kwRavkDFcknSmVgpCGe7RRxjIlD/bT55gFrdGZAwXN9Y?=
 =?us-ascii?Q?/wAxoY/+EDauukoEsS9j5x/wL62RfV3yXeRyV2ecXEyjP6AS73WzQRMHO4Bl?=
 =?us-ascii?Q?ZNChu55h4ZAFQmTLfbz70bd/MhFCKO1Uzx9eWlRhcYiTkJPFyWgTtQPlzNal?=
 =?us-ascii?Q?yYV90CWKXOpiafa+9v4FnolL7h0M0urXBJb3DZoclcvHDFhug0b1SLu4MDZf?=
 =?us-ascii?Q?EYYV+9qFNMCKlWSPGKvP4+leVG7JSyQFfZ64E8e1LS6Iqvp6qUZTfttw1ZO6?=
 =?us-ascii?Q?kzpS21jdwi2A2VytLimpWsn3MGN36bCkD/qbAG9Zvue7o29bnYejxgkaRF3s?=
 =?us-ascii?Q?6jF6efhIaJZar98rEB6mlmhzhxOCzCeJzRAMGVy5hod51ZDPQFvWnr63jglV?=
 =?us-ascii?Q?i1LswrfJ5ijWl5jLKlg0fRKttfhy90lw0PLR5JT5uCM/29OfNIQLggbMdByc?=
 =?us-ascii?Q?JJmbwzGNLYODW3nAP8RLkxCX4xAwVEoq2X7U2bgPPMxy3aIQHWEzQzUQo1PE?=
 =?us-ascii?Q?kIc2InyPfVWzIi2XepLwNxu1cCmNkElZQAbf8n6sj1u0dCzgXbB6uBINQ2UJ?=
 =?us-ascii?Q?RyHZAQBVm936di++zgalAci4ZKzU7RtWPVzTc2e5Y+lYw+D9V1RSwhgK4PLe?=
 =?us-ascii?Q?GkScGe1ycdmxbtxr6OO0wlw5vMo1fI7+ZIoLbdpYwNQ3JGqB06M7965S2Do+?=
 =?us-ascii?Q?QiIAHe2gonsvaj5QSq6LLZoA3uJLykKSmWPa1r2leCFSlcM0wcbJQeMsuoNH?=
 =?us-ascii?Q?mJ4WurVMptFvvSNw80WXyn0MgoxCYXp9bZvammGwPliqOODQ9eUFHlJr2s+b?=
 =?us-ascii?Q?BK/qYFZ+HU9hPoNps5Xxp0xborFd8eIk4n77+kS3faml63aeK/OWgEReZn+D?=
 =?us-ascii?Q?+2/+d9HeKV2XJqHS6pAM9BTIfZOuU32qcejwr8YtK6HUbICxakA1bn9dIfWu?=
 =?us-ascii?Q?Q6Wb0j4xoy2CCMpPtmemTtYXVdJMR0yC3kqo8FJ+GTnLw6Ie2X5eI7IwtHAT?=
 =?us-ascii?Q?rJbgVKzLS1kJilZFGFGmaDcAA7FFX/gCoetrpkGT9UlpVCoxfmZjSbvNKGGG?=
 =?us-ascii?Q?qad8XxNs0S/g7kjnqAjoSKdhIARhe/BkOL4ViXmmw0o74Qw921lzRn4flGuc?=
 =?us-ascii?Q?OzmIELks8xjm9cqT8cO1c72zDppennrTsoYTtl04JaLm0zdTImzooxHGs5MA?=
 =?us-ascii?Q?qeGhMnA7elmKqhYCxW3feoJcjLTmW8hhblOM29hR1qnoF1w4oE9tWI5KBLad?=
 =?us-ascii?Q?B0GPvnD5CJiAlqIqw0JP7d3BAsHnS9McbPMOBzGdxzlYkXBoifiU2SBl2b5E?=
 =?us-ascii?Q?OIkTtG7JD3V2uia8HQnsYvQnXNoQaV38csXJmeO40Hb2+a2PmceQAeuJZG0D?=
 =?us-ascii?Q?+r4SRpcIf1kAe2h7aVz5NlUH/dj4XeOc8/WR85UpnFekvWO28+UxUpe5cBpw?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d353aa7-7755-4d38-57c6-08dd08d611fa
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 20:09:27.6996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARdCuwl0L3ubguoduY0qyBlPlDbXkWcBj7VHyAsxXG0fuGoJV+MWfrcGVvtXI/0MzbfNSLJk4R4T8gY61Y/4bXZ7cgBcz0iZ62qxvqFfjUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB6982

The commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
behaviour") moved vm flags validation before fop->mmap for file
mappings.  But when commit 25c17c4b55de ("hugetlb: arm64: add mte support")
was rebased on top of it, the hugetlbfs part was missed.  Mmapping
hugetlbfs file may not have MAP_HUGETLB set.

Fixes: 25c17c4b55de ("hugetlb: arm64: add mte support")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/mman.h | 3 ++-
 fs/hugetlbfs/inode.c          | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 1d53022fc7e1..21df8bbd2668 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -7,6 +7,7 @@
 #ifndef BUILD_VDSO
 #include <linux/compiler.h>
 #include <linux/fs.h>
+#include <linux/hugetlb.h>
 #include <linux/shmem_fs.h>
 #include <linux/types.h>
 
@@ -44,7 +45,7 @@ static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
 	if (system_supports_mte()) {
 		if (flags & (MAP_ANONYMOUS | MAP_HUGETLB))
 			return VM_MTE_ALLOWED;
-		if (shmem_file(file))
+		if (shmem_file(file) || is_file_hugepages(file))
 			return VM_MTE_ALLOWED;
 	}
 
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 1bbf783b244a..2dea122e5b93 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -113,7 +113,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
+	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
 	vma->vm_ops = &hugetlb_vm_ops;
 
 	ret = seal_check_write(info->seals, vma);
-- 
2.41.0


