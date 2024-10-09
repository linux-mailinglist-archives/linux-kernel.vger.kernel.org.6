Return-Path: <linux-kernel+bounces-356791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8675E9966B7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02DC3B2901E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C108318E36C;
	Wed,  9 Oct 2024 10:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="HAA0Lzuc"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2066.outbound.protection.outlook.com [40.107.117.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9C418E357
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468715; cv=fail; b=n7V9L6ZH4OBINcciDOzILpOuCm6LUXO2OAV5r7Gfu+2cO5aN0D+nHdLu062GVqrgAJhrgF5hhbIhHYbBUpWkIPdEcyxKLijAR0tkjwtfi6qqEM7E7zlfj+Bpxgmcqs9kWIAuQUOdUCQV80ayiRNWX85+u6Wlxgk1VbXX+N+dpoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468715; c=relaxed/simple;
	bh=PpRvwXD79ZY5Ng2uQXeite65MOpAd9mm1puJUQwUWhI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AdQeeXsayvRlMVjUytALnJD07GowbK0arspfCKU/2PGix2YjgdqFoo5o1SFjUMUu+ntJ6vMeuSWgnGvKUHLcwW2qwk79f/ii2CrNSLm7zRYPrjM3hWuH3gJVIC1VbG6jnIeal0+UXJx/qrbj/78ss4YVk8L9tHk7AHXMk8NiV9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=HAA0Lzuc; arc=fail smtp.client-ip=40.107.117.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRWawf4Nst3EdlOcP6F2NE6Yt0jzoOmvYn0kPgJYqoBRsezUtgJTxSh6/WxCMxDEaeDnVFfJM4rvHoTE3I0k6ZGr1u8DKCQ2Ib7EuStAO1HOTt+JdBm62xm9MDDy+2tfk3NN7MgcAH5lrnW5Bw3sLGvzbZ4nqaSP5jG6QLtQgCAojv5KOgAYqxGF4epkhlfj6pbZnHDhrkkb1caS+sOa+11V98MvPACoC+Sq5afyg9mPp//esoc5vV9WOZtejC7meC0HT8iFWmja/2ZrvhkGRibaKaLcuACkc5Mk29dJwz0DZv2NXPUGHQad3/SilRQtm3LoMk9TWqXNytPT9vmwxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goUSf55hgllp3OjqMieU1ZUpPQF/HnlAaNUU6I/ZMMU=;
 b=o7zxao5GXFpZUHsXnh4/PKT8wzFNOyGMpKqBp68KA2Tv3J7FYaJvs7FHIRoEjxLPSa5t0fu1zZ8Vv6tmldp+fZDNkWkxzNxC2DSJJcS8XbOA5nmtsmXUVtEX9asv1HoK2W1IICs9LZY/QDs0jaUCmX5zaBnCsdUw3QqZdmXTpVq3HbM8RVYpdloHdFouWrsejwKYkaNnoddJauXUXD06qSCayfcAEPhRrk7JmcD+WvyCj6ip0/kWSwrqCXWgDH+GCPxJFWHe/EGnkOOy5F/xbvg5urd4MHlnIvEH9zMhxJcGDuxI0ep6F/XJcdLItAqP87b0/Tb2xlHznfadgqM1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goUSf55hgllp3OjqMieU1ZUpPQF/HnlAaNUU6I/ZMMU=;
 b=HAA0Lzucx41ZFyGcc/+Pd6cQDA9KN6iLE1HpXgwIYgKRcQSCeESqYOeaMknEOnqaZ2iv8G1TDIDlccbPMhw+MhK9mBoH5ASObVNWOm8D6A8Fuf0pC85QMH8vFASSwuSUeBOi/jYSwQw4ZHjtWDXZkk1C4j5qeRCfp2x6D/uhyteUw13sVQzdOSGDfhBMQ9yDKofsCen4yTKJBLhKN40+JN4FqS1y/pv5Q6bge2m1XrnuWmS6Um077RlIKLBCfSc0MzsjtubQpmh7uASaHueLADKrvaX9rtuOTs+RusJJAB0v4TSzf5HfjSZEpG6Ay35JRRgVIywiPNnr5xN9XV80Fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by SEZPR06MB5119.apcprd06.prod.outlook.com (2603:1096:101:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17; Wed, 9 Oct
 2024 10:11:46 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 10:11:46 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
Date: Wed,  9 Oct 2024 04:27:45 -0600
Message-Id: <20241009102745.1390935-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|SEZPR06MB5119:EE_
X-MS-Office365-Filtering-Correlation-Id: 5968b5e9-bb40-4584-d610-08dce84ac857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2FwrC1OVACizeBAIG2dddlUuNf6b5s0hLAAkLNt+zvkYr8s6+GopQaGM9kyl?=
 =?us-ascii?Q?SEYaJVWndrU0OsIfsZUAWl0E/JmvplEqV26wNjrZv389IEUuKJ2V/9HUmIDL?=
 =?us-ascii?Q?fOJhlFVwwQxztD2MF/sEc6j9MELQW7yiPq42IWNKWHXeBmsTbsxCGScZkyPv?=
 =?us-ascii?Q?WBpiCvWc8A3I/eGCJEwo0kcmvfCWcBsq1XnQgnSxT5E/Ofvx2ceDxS1/yNBl?=
 =?us-ascii?Q?BLtev7M93rEShzsC9UnIELKgx6Kc8GHR+KjtHaC9Gr3fGqL6UIK4DtLgSXCs?=
 =?us-ascii?Q?E1SPWZcihhXwomeoGD8W+jkgpU7QinFb1iNGFT47ebbNHe4SK3xytamVGEpc?=
 =?us-ascii?Q?lwMxmGaOzY3aFqXRuFGukgyr+fg8mDATtCggMbrAAMU46+vLrMj2rFJBWRZc?=
 =?us-ascii?Q?w1AvmeDRz7J8rjW3DUgsdDHDcp+EaMiYuYoE0aWtqHvi0wFerEScJmOE6UNn?=
 =?us-ascii?Q?LCb6bmKz3QgGzeIpxdzaSgLDehMvJr/sTJUMT3VqoK0TMeANzUcKDRV2t2XV?=
 =?us-ascii?Q?6OiaoCyNPGP/n+BTvkx00tTb6w7hW3yNrTMEzIKMbDQXRoS1U5/CWLKvD6Vj?=
 =?us-ascii?Q?mEfbJVg2SKQHt2ONROiwerKS3yWzepBNFkBtYcnqKmN3BHlR2rLChhrhq3PX?=
 =?us-ascii?Q?GNsEFOm4VHEg7zRp0+76BmpJNZyB8/eWRRpmSL2dLXW5xxrgZXny8zkx4psQ?=
 =?us-ascii?Q?g8tHBuOufqzzVx15CYZvSlcMJGo8Kdyi9sgFzEghCSHkQxR/xm4GIHGqr5cR?=
 =?us-ascii?Q?2t3zXveD35zDlca7dBzGwz8bpx+ZFez9FnDuFJ9ix49qRY/GJ6iHJ639pmSg?=
 =?us-ascii?Q?SX1g4bjLbtKJWIhuF1y5pxJ4gDdKJ5ECXK17+b3RHOjz595sLBHtXS4UjFPg?=
 =?us-ascii?Q?qr5r/zf36UQjJCoh6MdNL/G9VsoqGKY3JuOd/JUBmxy3Y+C9Y0NkBRGGkPnF?=
 =?us-ascii?Q?z7tbAn5+Q9FCB9ue/Dm/e57jbHozDrbVcFItggeWRCh48UuZDq1Ht/dPFEkU?=
 =?us-ascii?Q?hJMKNwCmvJ+zV1SZwgAu3UbMXiCuL1zlD1AO60uBD5zLrJ5a+djtClNNxGi1?=
 =?us-ascii?Q?GMTD3i3cE/EjdZ/aGSjEb/0INCWJGRUYfinIEBF2XxiMZadGsuDSobpLXQ6l?=
 =?us-ascii?Q?umT6RrcCg/N3pNHLpONju2J5tkqzSDnSNkzTrlrnlK8ZUElo0mogDUJ5/SFl?=
 =?us-ascii?Q?iJ+NoWaqc9BcpsjVtFf2vsGwT9qz7X7itgKx721xjRvdfTYOlLtAe6wr0zEx?=
 =?us-ascii?Q?fj2fSNxVbFhOPviIATb+fDyIHwJCRFZfUCnBraPZDtONeJn+FZGhXDQZooxg?=
 =?us-ascii?Q?lN+9FsUDdBFNWYL5fJ1I68pM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Ufkfb9MtvvJZiqfVpiRzKTLp6z+fOIVDO17ilSbYZKu/ZVQfvcIIibjSY1c?=
 =?us-ascii?Q?SJ5c1I6RrdIbge4hmAsIXxZtZrEEGAXfzY6jG/I9jkpl0LRr0epbMxg3h0/j?=
 =?us-ascii?Q?EqQqLxrKP0/FwQvRGFKm2YNkH3aLWkFAtk+HcKLUYtksUWj6lV38m6dw/Pxs?=
 =?us-ascii?Q?mrNdd36AMy0bWVueBmjIfVGiwGpSr4SitXmdL27zwhUMkGUO8Bnao0pmZGdK?=
 =?us-ascii?Q?H8pvGpN1ZzkgqyZX/NAUEqSgUS5R7y7zC3823nPGh+mc5z7wWYGes25o+Jd2?=
 =?us-ascii?Q?IM4ldiQmE17Houq1wGKXVq14Z7/sJr5HlZ3MRpQWQ7jgi/hPlHLVoCbXu1AX?=
 =?us-ascii?Q?KgZWozHRI7kNg5r++oI1B/0tSXf/FD6p1d1H/khnBOkXu8uFN1PzFq51F4n3?=
 =?us-ascii?Q?woMIxlOBfjlt42LWIURdWkql+D9lEeiVKE4jiPrpVglMAVKUPGPSOFYcXNeL?=
 =?us-ascii?Q?psUYnxcf/NAgbp/QCCsyqx2PV6+oH5EiokHfNTAmj7thVGxIK24/5WYnt5Gv?=
 =?us-ascii?Q?VqiBCWQ4u8paChtQNLac6Mg5NKAEGnPUc1X0LmzJ8fd+zpnaGPhYstjh6eOC?=
 =?us-ascii?Q?9l/PQUAI4pc/8UgaqTXMQESOdy+CpIgUpPe4Enbkv9JUQyv2UruPujg2s1sS?=
 =?us-ascii?Q?JZBp2AkBkCuxnvya6a1m92T4Rp9I23I+j1Pfpq4UHl3JQrnjQ6cCElSoC1s5?=
 =?us-ascii?Q?9em/MbZR0GT9NXzirtY7iQhZPPx/Y56ma5DIQn+VS7kyPoxk186DLLtw5IEI?=
 =?us-ascii?Q?9Ag13oxrT/GStCN27yK8g7X+6K4/XPgV7FoMGJqJSDR2h3d0PAsAwRo95MD0?=
 =?us-ascii?Q?97HuRTu7dnkPfM7MMvL4ctzNFdi8wlLGkCQfajCJ17ugAaG+HTMxAp5nvpgv?=
 =?us-ascii?Q?o45dOhL+ZaeIWCzWHiqiox+VFJq6iSghVqqmb+8jf5E4fXsJXctBsQVDBJW9?=
 =?us-ascii?Q?8UfxqpiFj0f9mhlNk0YQkrM5g7/vvMbwZZee3mNeMlDIfHc7qezU9J0MShFB?=
 =?us-ascii?Q?WMX5QpeMPHjGJ5O1Je0gmttNX+9WM5A0t/CpsTzKkb/Em8DKFSg6X9+jrm4H?=
 =?us-ascii?Q?WHiYVbJYBu6sdLUMHkq3OMWjEQQSLajev5YGxDBjn6cfV1kJSYgetNumlPYW?=
 =?us-ascii?Q?2KyJzzzOyR+3bWw+N2i1x7EAmXOFWwlaevzQiPMcuGXVP7MQGWMqGnqhLU0g?=
 =?us-ascii?Q?joPrtgjRi0Gc3vIXsomhr9oHxtP1QC8e98yjk0bkIhK5cRfVqBKvU/AzI5WL?=
 =?us-ascii?Q?zBIb8sXBPAHeW3eW1ovMAESda6UBBR483qtECwkxzfz4xN48AmfzPasb/K0g?=
 =?us-ascii?Q?6njU6BL/ZDuGfhtxj5DFdgUv4AwsbICGlV9FOf4T3x3wwpXC8QVheOSq1E2I?=
 =?us-ascii?Q?TQT3Rh5RD7ecyruNEIrcCW66RtYHY7q+TdwMf3twHKpH9adhL1+zGj5XTN6Y?=
 =?us-ascii?Q?kFuzE0qAWX+VK6Mf0YGP557OYiLNog0rwckKPPclMrB9n/b4+HpQ2ntY0C58?=
 =?us-ascii?Q?yafFsEDIp3iMUB542FjIMFMYylRIBoa73Ztz08eyV1xOzYUWnmpgznh3s+hX?=
 =?us-ascii?Q?WsLMa1oyK+nKhaeVC9TyfS8s1EzkI/qFXgJI9c+8?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5968b5e9-bb40-4584-d610-08dce84ac857
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:11:46.7583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ingu+5c5PH+kB3/qtq8UNvPZEq0UXGnGN6FcMQKY0TrhoDM+kYTzc9QIpwtxTwpbb3g2wQy3abqpiuc3J0w1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5119

When the free segment is used up during CP disable, many write or
ioctl operations will get ENOSPC error codes, even if there are
still many blocks available. We can reproduce it in the following
steps:

dd if=/dev/zero of=f2fs.img bs=1M count=55
mkfs.f2fs -f f2fs.img
mount f2fs.img f2fs_dir -o checkpoint=disable:10%
cd f2fs_dir
dd if=/dev/zero of=bigfile bs=1M count=50
sync
rm bigfile
i=1; while [[ $i -lt 10000000 ]]; do (file_name=./file$i; dd \
if=/dev/random of=$file_name bs=1M count=0); i=$((i+1)); done
stat -f ./

In f2fs_need_SSR() function, it is allowed to use SSR to allocate
blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
can we judge the number of invalid blocks when free segment is not
enough, and return ENOSPC only if the number of invalid blocks is
also not enough?

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/segment.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71adb4a43bec..9bf0cf3a6a31 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -637,12 +637,33 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
 	return !has_not_enough_free_secs(sbi, freed, needed);
 }
 
+static inline bool has_enough_available_blocks(struct f2fs_sb_info *sbi)
+{
+	unsigned int total_free_blocks = sbi->user_block_count -
+					valid_user_blocks(sbi) -
+					sbi->current_reserved_blocks;
+
+	if (total_free_blocks <= sbi->unusable_block_count)
+		total_free_blocks = 0;
+	else
+		total_free_blocks -= sbi->unusable_block_count;
+
+	if (total_free_blocks > F2FS_OPTION(sbi).root_reserved_blocks)
+		total_free_blocks -= F2FS_OPTION(sbi).root_reserved_blocks;
+	else
+		total_free_blocks = 0;
+
+	return (total_free_blocks > 0) ? true : false;
+}
+
 static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
 {
 	if (likely(!is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
 		return true;
 	if (likely(has_enough_free_secs(sbi, 0, 0)))
 		return true;
+	if (likely(has_enough_available_blocks(sbi)))
+		return true;
 	return false;
 }
 
-- 
2.39.0


