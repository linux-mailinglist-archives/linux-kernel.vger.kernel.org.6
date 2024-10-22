Return-Path: <linux-kernel+bounces-375954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009C89A9DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 10:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59274B22616
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D42190045;
	Tue, 22 Oct 2024 08:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="W7PlVoqu"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011005.outbound.protection.outlook.com [52.101.129.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8989218859B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587556; cv=fail; b=YiswJ4QA3/vJat9Bom3FmRxbouN2St056oFcyifB453HjQ3ihxDijkjbUB92rDL6EJK5r1rPXl+kKSnJgw3gXZhj1IDxr3qqBN3atDGx9isAjJBAfJEqGcLU0OZZzmONINtsXi6t3KTdSIv8IcjU8/jq4CjyBLowMBlzinXPIYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587556; c=relaxed/simple;
	bh=owHFzBSF0pJGCAYy2oO0p4RupYbglwLpQ7CZNOgY9BI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nyFsCB78AJyaG0LeZNkACgSWMwQf7veBzb9iZt+nKJrBBgCCsreFtEDJt1VCmtci2+snyhbSSbZL3DZDFqmvxljrCyBExv8aCmchpBZ6Jnad3DT9GT5HJPHjFUNjPLGmvfUcYmYE857BqLMlE1j4QNB+Yiw9juCopDC11Z/QHNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=W7PlVoqu; arc=fail smtp.client-ip=52.101.129.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrVMp89xpiL4Jq/sGYitxsy4bqiwIhSBTxpt+IW2n6A3rzGOesfR8sy1zBK5JQ8oVWw3MJCwEKjAWrbi2h/O3WNi3Q4zMmnmzU/MAuaG+QOuHT7RC+YBcJy7Wq5FJ8bB6hT2UK1X1Dola2freYKEgEbqZ/hUBDKTR4gMY/aLLZqz87doxI71LmHd+9sY1qdp5f9R7PZxk1OqVDbswTzusPXrKrl6GrL/4mleNhzAgveHOCBXgZEZKN+FEvDatzjLo+AKvxVny9p15zO4v0cdvRIiZDpgIWlbaB4d1Qtr9s2x/efIezBcCnvEQdOKW1+ORU+qr4Msul3Ita9dTNdehQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0YZGuPz4Edh9o/BFrP4xxZ84krhcxxNoOoFa0LR6QQ=;
 b=Y2ANsg2CYoKDlvktBLJFV0HEu9HqW+oUxIV8N7FtNmo7s+yPLvZaVI+fQlhWaTPVjJux221fdLFk93JHSaEJK2Q3CvbclhtsOmOBkY+M7zBnkBkWIBCyAMyVTV6RojvDai8dpaSxRy7iTUVyn8nqzngsLdcpcMsIIYTw+Aex+aFeEMyqgGVQjEp1uK06JfE86cME8v4up72G8wYKfrc0+boDzU2XXVea/UEqE+obxt+ZsL8TsD4N4rMkoDQLjmEl4S/gosAZz7G/XqIn/J8sXeyA1Dz7wF6V3lJX3QnernDs6IFNSQtV5O4ydQEGS522hh5nvxOuBU3C0fs6LvdF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0YZGuPz4Edh9o/BFrP4xxZ84krhcxxNoOoFa0LR6QQ=;
 b=W7PlVoquMql3Cd5z/pEhkE6C3KteZ+Xm09NiFyjiRdN++E1VrgmVr/vBx+dj8BTXCYP0Af+cyhKrMy4nsY+KystbZr4CYODZJ4bQVE9VuKWDqm+7i4i6L9im28+6/et5Wm8b9pnEXK0mDqQAsMt4n3inwTwBOFcb7RA0NZu14LFhlbKv8WhKEnYdBflG9kqW6aZ0XaZ2O232YD0RFplndq31VvEY3l7IcDcMmAQTzlZ7qCR1cE8z2RQOAXDUlyFkotbC5Gth6T8G6q/NdJgni0/9W7hIJ27YT/u7TdjXfFAG/Yc+Rfg+ClcZ9BnKU1usxwtlXnjI/fCsNiP+7yZT6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by SEZPR06MB7079.apcprd06.prod.outlook.com (2603:1096:101:1f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 08:59:09 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 08:59:09 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v2] f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable
Date: Tue, 22 Oct 2024 03:15:25 -0600
Message-Id: <20241022091525.1808542-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|SEZPR06MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0235061f-1caf-41dc-d356-08dcf277ca4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2gXnGt3jcmQLiTVaCu5X+fkd4EuK7Nwv3kILtvlKGQItp/PC+T5IcQLkUA24?=
 =?us-ascii?Q?3+bWLk7shhr+q/18a4tRS2iBE5mEWW0ekphxlkbWy3E1O+04TE2hmBM0X5Pn?=
 =?us-ascii?Q?l0wszXyLo0uKrm/JK+HGehcFcW75/MdHFKs/wsysIfmG7i3O/wcelA+Mf2Lp?=
 =?us-ascii?Q?51hFjCZ2wTT9zdONWzkuTtgE36Z21GCEXvQdpXJXx4ifEOD3f6zXSNiMs8jp?=
 =?us-ascii?Q?wVC2EC/I/VwmCTv6Jv6Z+K5BXK2cHmymmboT8cgDhea8PUlpXefHgXm2smvQ?=
 =?us-ascii?Q?VVR6Q37xWlBxDB2uJrp/SJnUO2Q9BH0RPYAgHzg05IwcJPd33956jTTgLUEj?=
 =?us-ascii?Q?BNQnRzA5i3EpsBZkPg9h1iJ4iT6NuTTaXRBDHGz2ZJ6YKIrGvJXPVZ9JkFRe?=
 =?us-ascii?Q?drasRN3EiYbaZyVgs9kkG3CI0vi3PIRj6eqc7895Mort8eal/Itm+tUySjgm?=
 =?us-ascii?Q?K5zJLkh4QO/ztuKHwF6yptH1HUjnsbCYhEyoGBXx6bufxAIg8f8gv7uZ+mBb?=
 =?us-ascii?Q?OVJAxU9heQhepnB6OQDdXyWe0BN+HvNcHjshjIgq9v0sOo+rM4ORx5SzDRfq?=
 =?us-ascii?Q?z4FSSVWg9ZvjIs5fi9REb56KdW9ojqabIxoD2gKK4P2DD36epgbffg+KK0dx?=
 =?us-ascii?Q?0pvwTuZcJFbqQKNMTlNEvGoJX523kTCTfmVPu/KsAZn4HTFFBotLOSSJmYGD?=
 =?us-ascii?Q?+6wK/nnGnApooZy4UmqMCZ9J57FEXwOhsADIlBc+qCAhhfX8Ovpc7dfNrniM?=
 =?us-ascii?Q?+KjnLbj53IlXxnBrgefwOEC4LHO4j5oOIDgnrmCC/q6SeQrqRWUTRvQF+XFQ?=
 =?us-ascii?Q?OaahAM2U6oZg/2qa8ZiPERJNYzcSuc7pXt+nqBbhZE6D7c2/irPw3LP1yqdp?=
 =?us-ascii?Q?514PeEfEdRtHG502xF054Xvvt/eQxghTMUuyM8b/x5dTtIvXBAPB2VtAUIin?=
 =?us-ascii?Q?dFPAveh4EMNBlPlB8ikDV1HMdZgIf5Mo+h/0a/IFwPLNotXAwlmZdGln1nZB?=
 =?us-ascii?Q?KOJxKIFStIIngxomV1Py1gHLsNZ/mFtdsRTmZp1oCSdCuKsrd3iRP06obglV?=
 =?us-ascii?Q?1XeEXR54w/drLZ/4IdwIGXwUQ8Jh1kQd0HN3sdVDpIB9Ff3Pqc5dvHTByAkd?=
 =?us-ascii?Q?jjzS7M40yzwzCsVHuqGwWCA0qPBnOqnW7ytRyvkETeMErckPFUxLqoRugtWW?=
 =?us-ascii?Q?ua8B00smSypF290upg2lgE/OCvhea9vIze7eEMbj+3IIXK1a2tLRgadbk1bM?=
 =?us-ascii?Q?iVNJqWTXTU52/ZEmyqe4z3v5rJcCoOwuTXRr4FGblBO268Tw+/r2GmTQOxKM?=
 =?us-ascii?Q?0KP3PEtEplC9Y5jN0atDBDHudKr0Ujb7gDP6eTNm9SrpKL99IxFGGbiDIesD?=
 =?us-ascii?Q?t+qEExY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SNoERFoZYjZJCEFQGBiaX4SUBX524f1vqOHUrZYoSK/S0NZ6ajJAUNeo8VBF?=
 =?us-ascii?Q?xYtKtQGG0UKjqFVudmc1dNgSw5zV9mayAgDjB1p7m8IEaU3TPK0GxMnVzjPd?=
 =?us-ascii?Q?X1JL6DTQiTL4GJHJd9KILsOKyviOpwNgvxVmhjkB+GlAE+oQumJG6DbGao+v?=
 =?us-ascii?Q?r8aCOPcCB+71/mOtuBWsp8axT1hSno6I8rt9fGob4Vpo7d6DCwOZcQtbKUt7?=
 =?us-ascii?Q?gl6U0+8Y4fEQN57QFX/HrCDpSbNrsWep5+POGJoLU/hmkCTiYs5YPJbe3735?=
 =?us-ascii?Q?y+LAQzGelZYzDO4B8SfqE5CbUGmh2NmVVLXCGF7Va+0pJTjUIrDd6ibdE8SK?=
 =?us-ascii?Q?dKgTMAA1BsDSOJ1sHP7xKY5OfZ/EI94d1CqqX6HWA2o5xjb5iyz8JJTwG5Gb?=
 =?us-ascii?Q?R1UmlubRz8f2h1BoCnH5z5/cX7KtA+bnKJNw2nhaZf41QccyMDfgxrtFoBAf?=
 =?us-ascii?Q?OHN/0XJR2lTqoySdasklIj8P1VINaWPlCYBmFXFER+Zi2T9+CotCONrRkZEX?=
 =?us-ascii?Q?MLfpax149o1lbb/3ZxkbRGiByxszEuSvl2VjvOFOWJkv7gJPyIjPMBGok8Qf?=
 =?us-ascii?Q?JLO8Ps6okGSLkWHClxdges3Z24CaaiwR3XnDHXg6Oobq2EkTpFPDRMqarPse?=
 =?us-ascii?Q?vDIo0oad5PkXI2ybJkodK/D2I9fmQ3sW1QaVhq5ncXo0e+i50VMjUTMKgf9q?=
 =?us-ascii?Q?e0qq/WmfkxbYP7JVJppvaPhsCysZ5KEcRJEJRcyc4j7xGvBLSTx0lc90yED9?=
 =?us-ascii?Q?LI4qWzZCbSmkj4PUQtJoyfOC/55RsPNJ/rKrH6IoEv1SIxEoy/oiM3nY/clu?=
 =?us-ascii?Q?Bag9HOmCBDNb+n244cr31e0z9Q1IhcIHtfwAdhXYtWCuh36qrzx77qm1psU4?=
 =?us-ascii?Q?NbSSk3QnjfN5xQwmqwyg5PhEM+6pFSREXoy2yPXBuWEibg2ZWnqQu8AmsNr6?=
 =?us-ascii?Q?QgW0rk+nYEMeIb7oMKtiBSRB5NylK0EPFjIdxq1MuR+qElPjiQe7lmZf/fks?=
 =?us-ascii?Q?OmLX28DNxGsq7XDDyXG216DpAuzkrrGD68Y0LvguNzhnL2w0nqKF802c5Si5?=
 =?us-ascii?Q?ejDrhc0NM4v1wHUAgezQSPOEflyh4lYLaZAr4H74LuPK2QWwA8SGNDbbNTig?=
 =?us-ascii?Q?hV76LdUVc1BdJbL+FfsL1YaUo+vo+IqT6dVj3cIFTNUUAgvFSrZc+sh392OQ?=
 =?us-ascii?Q?uXBHP5j2dGvyZyqdUgP1Q4tP2m8qtHKBikwgsQpm/rIFNBaiVLhWCwXuuSrq?=
 =?us-ascii?Q?BaoK0PjvBIzQGG/WUQ5vUpd2wsYgoCGYAnSmK8qu2g/lH7Za6qY67tNKzRnw?=
 =?us-ascii?Q?jrHGCwdUoskJsCGBExYnwET0Y0z7NIwJdTadeclCLa1GhkRki1zGUIwYUxOL?=
 =?us-ascii?Q?Nz+jZ//xoty2I+KIEJ8fqzxv/ljJYiRwUrbJEyWKsDpSgow3Mt75sCCKlT1x?=
 =?us-ascii?Q?mveLYeqDNm5iQMigFUlTij/m78Rnkjcsc2OeSUD4dLFAJyk1RHopccffTmqr?=
 =?us-ascii?Q?+XHmHAx0cQKB7y2qE7tDxbtsGGcgMM4JD4J3S+r+dCtpETaA0HgkXOvfjkll?=
 =?us-ascii?Q?qDQ3gaM/vet4+TEtvyf9R4bs6dBRpHUqQ0hX7zR3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0235061f-1caf-41dc-d356-08dcf277ca4b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 08:59:09.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rGC8dfLJIZRZx8j/DqamAxwsPoRV/U3tdU/Y2XwK6trCsfUMejfKY+tzyzcrGYqf6dzkq6BCjwMFcvUQCmZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7079

When the free segment is used up during CP disable, many write or
ioctl operations will get ENOSPC error codes, even if there are
still many blocks available. We can reproduce it in the following
steps:

dd if=/dev/zero of=f2fs.img bs=1M count=65
mkfs.f2fs -f f2fs.img
mount f2fs.img f2fs_dir -o checkpoint=disable:10%
cd f2fs_dir
i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; dd \
if=/dev/random of=$file_name bs=1M count=2); i=$((i+1)); done
sync
i=1 ; while [[ $i -lt 50 ]] ; do (file_name=./2M_file$i ; truncate \
-s 1K $file_name); i=$((i+1)); done
sync
i=1; while [[ $i -lt 10000000 ]]; do (file_name=./file$i; dd \
if=/dev/random of=$file_name bs=1M count=0); i=$((i+1)); done

In f2fs_need_SSR() function, it is allowed to use SSR to allocate
blocks when CP is disabled, so in f2fs_is_checkpoint_ready function,
can we judge the number of invalid blocks when free segment is not
enough, and return ENOSPC only if the number of invalid blocks is
also not enough?

Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/segment.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 71adb4a43bec..b7af84a07435 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -637,12 +637,31 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
 	return !has_not_enough_free_secs(sbi, freed, needed);
 }
 
+static inline bool has_enough_free_blks(struct f2fs_sb_info *sbi)
+{
+	long long total_free_blocks = 0;
+	block_t avail_user_block_count;
+	block_t valid_block_count;
+
+	spin_lock(&sbi->stat_lock);
+
+	avail_user_block_count = get_available_block_count(sbi, NULL, true);
+	valid_block_count = valid_user_blocks(sbi);
+	total_free_blocks = avail_user_block_count - valid_block_count;
+
+	spin_unlock(&sbi->stat_lock);
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
+	if (likely(has_enough_free_blks(sbi)))
+		return true;
 	return false;
 }
 
-- 
2.39.0


