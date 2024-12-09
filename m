Return-Path: <linux-kernel+bounces-438192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAAD9E9E01
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673CC1884919
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086D915853B;
	Mon,  9 Dec 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oIFUg6SS"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9C146A63
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768617; cv=fail; b=E9NwVSXPzDrM9V2sKvI0LM+iEMBnpJxIR47mAywz3eGekbi0qbS/lrAvw6Ua78Idk7uEl5aAiVdxlVt1M5nwFYhSa6lFWQUsCvYkP8wUl+Ph3fF7YEi2CG0cHGAxTx/5YkNg1eCqaLlAKfYz4QQghLHdD70WtVUJiV8Lu5XDksI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768617; c=relaxed/simple;
	bh=96Qd2imDOO/hJPD2tLFlHzpPxcCSC74D8pawfbGt/5E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YmzENmyOW/pKWA9Y4npHVWUwaJWNVRDWVjj0X3YPY3N2ueb+HJQoWgWsWO31xa787ZuPUzfz4leA759IDXlx8zmCszMPd3BBnS2ai8rLUH8oLo3Vhi3dt/VaRsVxdFrfjmSxlpG9ieavOXlW5a/+jNYlhusD/vUl2VauK9IeR1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oIFUg6SS; arc=fail smtp.client-ip=40.107.237.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehCNyhfnGLwAUvul9DrmgCXYE4aOv9/Pn9prRVb06aZxAMDR3ezouOzgQZ0ZMDm4fMkDkeqfQr4RJJvm4P1d92HINyN+ttCeiYw/K1h3b8ZsmkpebNQpk23OJMAbA0nQjSyusB5eNaC00W+w0k64KwbiIcSLUnxnddtPvGPVZAxtgz3dtJbO79VW4RV4xrgBOMwK35QU2aB7ugPZDnWCE70OTklVIgccZP8ulWKTT04dwrtOkbt26tSvd02rtexe/fVdFYpHkSNK1ioj4XumBwt6VMBvZ93LtRHriG6v1niZiJPAoEKBzgP/VRPd+DjlgYs39iiF8dNX8kHoMGIMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAdx0sWVrF3tvqmv26fdliHIY7NPMMMmEaI7/QoWy0g=;
 b=xCUvDYZ8c/9ifuhT9cnZHDM2MzVSuXTPD57/Ecpz0YVJvJI+aPKb4CpJuoaWMQ3F6N2XCZFmISL3Ki89oWaU8+ppQFhMFHXvh3cP0fgPsE3WwCQ62djScZHrk3fumoTSuOF+FAmGm3C3acJP38LVhEEuKNcj1xPLNZhv9hqSULY+jkMw4itbjGUWwaRe5q8R7enESB6GOHRIRSk7buc7Zbh6Vo9nTM0h7cTgyDyJ3oFo0NCFEvmiyqZhe7AGJByrLG5WC1F9/vuWaJJTlw7MaIyXb4Bs7+rt8H/+qaNwapYLNlBglo4tur6qmy3wh8poSv0xXHwEMPKCPWk5I7RHuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAdx0sWVrF3tvqmv26fdliHIY7NPMMMmEaI7/QoWy0g=;
 b=oIFUg6SSaRGNPhm6+BYUnHaoDCmZNSlcydcdPuUa4hKGCX8uMKLKuqnj2r0EAXFp4OhYZ+1ec1oli0GUcozhvywOS+mKxfUdQuWZHeG1nXV7H2PVgq+1fj1J+6sWrrjdV5EKqLZartyRj+M4pmUjsNJbrmJpcGlhEAtoBBazlor4nQD9YPD4tmfegIm9pDikAyZeQQi7gyfqmX6myCZ5w55g5k6lplGMs971HRJhFM7zuxdj1IFB7iWOOZhrmmfGRi2nlIVNvvbSlNNDiHtacYRbSUj8r6uWVGhQ4HQPkBdOqQSzYg48M3juxdJnwjid+GnFqQHhVeATv0ZR2HP68Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4487.namprd12.prod.outlook.com (2603:10b6:208:264::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:23:31 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%3]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 18:23:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexander Potapenko <glider@google.com>,
	Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH mm-hotfixes v5 1/2] Introduce cpu_icache_is_aliasing() across all architectures
Date: Mon,  9 Dec 2024 13:23:25 -0500
Message-ID: <20241209182326.2955963-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:52f::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ae158c4-94fe-46ef-abc7-08dd187e9560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LCmJh8lpaxhrcTddInlNGX9+TRdJCXDqgdNrz9EeWcUEWBiQnWP5dW4myYdK?=
 =?us-ascii?Q?Hj42dJXnQA1+d30qgsHPfZ6iemhSUAIMtto7yR+T8JmHmpFK4OTu6UxquBh4?=
 =?us-ascii?Q?5FCNkp+4B5tVTGIYn0CtACwWFeHGMN0ASUzRiRqhJHtghc1OFUp6dsNXy/EN?=
 =?us-ascii?Q?7MONo0d+U0zhOQyS6h5rWDCeG3uwgRLCKA/NUbJbdBjVbMmNgnmRrHquX69+?=
 =?us-ascii?Q?W3sVNzGV5hoTtB405EfY+OaZgYsTGZnHwDADvvl3plxlb/pXabPF3X9Hb1uE?=
 =?us-ascii?Q?kl+9J5Z/vZBTWRpZjys8kEZIjzVs0PgRzK82Y/PuMOaMtDPqXjYJmLqyyx0z?=
 =?us-ascii?Q?oEs0fM0zUNSmCGT4Lb6WiCjLMpHskkLXzcL51ujGIpc5WnWheYwBUOHoteRE?=
 =?us-ascii?Q?3kFeRp/LD8dpL4/GUjCcM9mXkK7eA86Q2+s9VcamYEC2CPtOY+N/IiOzn756?=
 =?us-ascii?Q?6a/Y5WoKyHKzvBPC/UUisgZY29hn/5o2CQTrtDv/QFqykKSRBGfHq+IPNz9s?=
 =?us-ascii?Q?ZyM9aIwB8L4q4srdg9M6Jj4F0i42praoxvXTLE3XZSg3Q2iD2k4QYb4jylOD?=
 =?us-ascii?Q?qD+4XgFrAUm7+WHE5CPBISLUgFEmyqhC4IIr+oHsLS7cCZsCD1RmU2vqeSPU?=
 =?us-ascii?Q?Yk7YQ/lHlK4w795TltZE5Usr3UW43HKtuiafAznCNJwQFdL70I2L0aPjmMn/?=
 =?us-ascii?Q?kLkh8NGzI0EKeEm0RM+Qpp9KlU2+AFwOENFfINfn/4GZGMtfaN7vEG9z6Ad9?=
 =?us-ascii?Q?BJR+Oj5b/Bl7wEi7uneF2uLvSBJqmRdnN+6EaBAFu7E1bVHb6633Gyr4gO4m?=
 =?us-ascii?Q?s7esFBRCVpF1unx9iSz6X8f8KDvn+WusZdwqc6sQv5Be1m7fTDNgzMUdzVJI?=
 =?us-ascii?Q?6MT2fgfiCjyQ4qu0tN8hqODrXKCPF3cKu+cbghtB+ZXfC5qC1xPbZCEfY+eW?=
 =?us-ascii?Q?HrBYvsSNTG+1iYLDlgaA/KfKGk8zHLCTnTcxu7liJp7asV7akMYfYEI3T84p?=
 =?us-ascii?Q?O4IUKnhbRasX1MAdTdTlVfhktOgkDYT3nQh8jU1tY+AMeqFcCryEDHpXoKOg?=
 =?us-ascii?Q?Mw/oAduKy3hrUzo//1jmsEtSd2tdkeuVBXiGn6kXRUWH9UUjJEB6gUTKOhiZ?=
 =?us-ascii?Q?kL3KFZU/HfNytvOYQHkY1zl9fDzpkEkdjPAxr6452SACVjCNtGmmDChn0t9W?=
 =?us-ascii?Q?FFdbYMhReIttGt09YtX3Enrap5ZFwDvpVv2ABJYo5aReVdSlFmgI8MfbR/Xv?=
 =?us-ascii?Q?WRKkaR2QP2PsR2W0CoYbuCdF4bXec6Y6p+4IsQiN4Mdvas9mnPTzxP3O9yFY?=
 =?us-ascii?Q?NCx4CpqvxLZPo6InDf3/mtc9FzCyg3BLDJzQE1RB0cE88Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTposcWj02qdxUeG3tW4gFkweDYh89wik2tTj1v1O18LmvhXXZavFxMMmjgJ?=
 =?us-ascii?Q?kTaRUw9aed1zRLR3Ueu48hpasrPR40HzhuE/1j6DWreImQanqhFAKYFOw8SD?=
 =?us-ascii?Q?ZvbkAEctPnJXDGi+SDavuJP8rr3ufTDG3gQZ+TVvrMmsBGQSk2xUsrJlQjY8?=
 =?us-ascii?Q?csnHr+56+2NPBYecI2PVzFVv2RprzARcluoMAt3vPywuDdQRF2xVVWCRhO9C?=
 =?us-ascii?Q?eGEgB9LqYroa++SMXZyOXnHf6w57IH7sKJo9KM1odLe1uaOrHyssBNUdfNXS?=
 =?us-ascii?Q?NgskTfVqSyt7KO0OakqmL5GH1cB1VZCwZs3oDWmLoIE2N+iNV/4KSAR6ii7B?=
 =?us-ascii?Q?cQgyNx3jxhgiP48KeL/Re93RjMUFwUJB9mBpIr3VdMc/MuHKTY6/o50TIead?=
 =?us-ascii?Q?HbqVxrRKxVfIMNNfGUl/Dp/sJD7rk9XuWCc4QOrMZVps3//LVldyeRbADCPa?=
 =?us-ascii?Q?WX5fNVbw7LeAM4ZAZ6aM7rE36LmaisTCidI+rPKqMJcruWSxXILkyv0lfxaX?=
 =?us-ascii?Q?beWV97bfH4V8F1vMqRRiUhnxiGsSJ/AGv+eZrW8SvhKh95Cta9X9Fm7foQlD?=
 =?us-ascii?Q?4Lg64EbglnYenqn8RUEL0D75d2I1NAcGK4SKpjftOwNzVB2qlvy0d6YQ+Nx7?=
 =?us-ascii?Q?HHome1RERWLlYu61COZmen3tziWV4cn1+jWlprvrmHN01XaJ6k7OVOa1Rpo9?=
 =?us-ascii?Q?hOR/3t1R4UQTtlqBeHJbSqOWRdR2JbgW6wmxea/pTgKRyaDmPi+xRpdfGB6b?=
 =?us-ascii?Q?eaBgKXbRukPelGZMzmEONcY27vFxko79YhC319jZFXkFQ9WfJnqrS8YwCFnL?=
 =?us-ascii?Q?GFIpEqL510SaWQz7VrgagbD0wr+SdEqLobNM9nauMd5HBzNSLB6b/JurWt/P?=
 =?us-ascii?Q?tlADPmTKpyAKUZJ5HAfatLk4nf6gQ2OzM6qRGrem5CmZ3wGMit7DIzemTm6t?=
 =?us-ascii?Q?HorcImDi7AUaqZ5lO8ONneGNU0Jro6xs9GlEcc51Gpt8UIV90SXT4aJ/PWZ0?=
 =?us-ascii?Q?ciqBhCmcl/qR0gFBn1Tlv+amj3R65KgFDVx/sV+mIjdsMkOIfY5c63MYdLct?=
 =?us-ascii?Q?+181ZQtWeFLoulS+HCqB2cdJtdTiudyXW7U43ijoB8yAR4rPAynYBk4ojeHZ?=
 =?us-ascii?Q?Jkx/JYkDPMjvfoDINFb1JRvIjpKC5qOihpj+vK1zXcufxFNMPMPtHMOk6Jzv?=
 =?us-ascii?Q?OlLxIjUZ6myZlqOndavTRA9u782sIrrQcFmPzAt0tHlBpQgPoZFi/vtqpqzb?=
 =?us-ascii?Q?yk9kbkstVY7g71aWD6SwqELeEcHTIuYtAsNVPlN8QAO437Uxxh+Oe+V0wUJA?=
 =?us-ascii?Q?KJmlllgtjmtRtS9Knn/HMOubLlzCVMZlebSUntCcBep5sugCxMRjodcn2258?=
 =?us-ascii?Q?RMPlhhQNo/hGzCgRVt58PMJGMNIAKoZVNYesW2mu2FrIPcOqvrg4ttVOLlrV?=
 =?us-ascii?Q?l+yf5engreS84EJnu1GouBA6BUm6f9fg1bNDY0MWqaNlKrmJ3Q+BtXEgR7dg?=
 =?us-ascii?Q?WUl78TNcXu+Sj519UHSUDJ7h3DO4meFfY+ZjxuVHOt/4c7czekpYPQh9FqlJ?=
 =?us-ascii?Q?+mxelPIJy0TJsz/coxc1xsJQsj/K6OEMiAfxGSF2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae158c4-94fe-46ef-abc7-08dd187e9560
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:23:30.8779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQZh3n0iHd2oti9m0bS/qgdp5J2Fw0Zjqg5TTB2Q5k/W6ya9cNwi5/U4V1VdlO+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4487

In commit eacd0e950dc2 ("ARC: [mm] Lazy D-cache flush (non aliasing
VIPT)"), arc adds the need to flush dcache to make icache see the code
page change. This also requires special handling for
clear_user_(high)page(). Introduce cpu_icache_is_aliasing() to make
MM code query special clear_user_(high)page() easier. This will be used
by the following commit.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/arc/Kconfig                 | 1 +
 arch/arc/include/asm/cachetype.h | 8 ++++++++
 include/linux/cacheinfo.h        | 6 ++++++
 3 files changed, 15 insertions(+)
 create mode 100644 arch/arc/include/asm/cachetype.h

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 5b2488142041..e96935373796 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/cachetype.h b/arch/arc/include/asm/cachetype.h
new file mode 100644
index 000000000000..acd3b6cb4bf5
--- /dev/null
+++ b/arch/arc/include/asm/cachetype.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_ARC_CACHETYPE_H
+#define __ASM_ARC_CACHETYPE_H
+
+#define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing()	true
+
+#endif
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 108060612bb8..7ad736538649 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -155,8 +155,14 @@ static inline int get_cpu_cacheinfo_id(int cpu, int level)
 
 #ifndef CONFIG_ARCH_HAS_CPU_CACHE_ALIASING
 #define cpu_dcache_is_aliasing()	false
+#define cpu_icache_is_aliasing()	cpu_dcache_is_aliasing()
 #else
 #include <asm/cachetype.h>
+
+#ifndef cpu_icache_is_aliasing
+#define cpu_icache_is_aliasing()	cpu_dcache_is_aliasing()
+#endif
+
 #endif
 
 #endif /* _LINUX_CACHEINFO_H */
-- 
2.45.2


