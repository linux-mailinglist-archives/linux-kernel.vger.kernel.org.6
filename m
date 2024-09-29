Return-Path: <linux-kernel+bounces-342756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 182ED9892A6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 094261C2200B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 02:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B686F17C68;
	Sun, 29 Sep 2024 02:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CClrub7N"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2080.outbound.protection.outlook.com [40.107.117.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3DB667
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727576883; cv=fail; b=KUp1k6JXhY4hYH3Gd62L4yUaZM4ClZPPJP4YNk1AjXqmVkWDkRo1JSPvhjubj6a1Rl5otPFAuFpcHXyZ3DKJvgY1cLzEWw1bFbMBM62HMT8PSjKfjDDJr7ZQi1+ewyVA6CbfKk6wgwxvt/WEqf0N/KuHBwXXtzVSadT5zbsnNN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727576883; c=relaxed/simple;
	bh=P42MEYv9htaAGMvuf5fv0ahmKa/onMAY9SqCN2F1HL0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lHqd8YiBRNCSSlzZaOOkquDjRqlvQYxo5cnhoThY3tEQgeAKlTyEfp08VIRIZSz4MewMX5CvkIWNjXsPoOPCDbTFLhEpSoTg7qPN4UMpDFH0V155eBqFrl0BefSNKRBpB94aYKnzAaG8BP6dmmj/1j+7DCUH0PTAfmDTXbmuxuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CClrub7N; arc=fail smtp.client-ip=40.107.117.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gl1lI39Gid8tOynzr0uyBENXEjkSN9oznuecpmOf+MkN4XVcCtnWOipmypIhuK8lRhXwqfwfFihobujSCOwhNUjJyxZBwRuMqWTe+KkkreVGeLf/9UUVwraWPdqBjF30pPHTIAH8yMRmGbmG097MAAstDEmSRwyctPHQc46tur4FfqiPHEULbleWB7idCySsTT2kv8x0JNQyI9SSV5iqhf6ZzRra0o7QZAkxelmGU6ZgptgqN9q1HgdQrPg4EwLsVLVkEFcqleuEmzKGICTDORFo8XMDrVRRCH92GW5YYint1AYeRA6piGYbgEjVz6FAExpKm+CNtF+30KDireAmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XoFp0nePSas7xgzmyhzjFsHoKiflz+dMvPuW83tUaGs=;
 b=E6uUC+FmRtiySuQhNjxRkzG63VjPfBSFw7EU51J0E8hmL5O/EGZG37Jd6FioW0u6mTSi4i9AnQGm93rl/rL4y0wBTzxJn4s7O02T+MZXvTDtbGH8WPX7zjl+g5P9Vg9WQmLohL+xehl0d7DcnwXcCNZ4Ll7BZMhQAoxUNWvTZBIn3y6PpYdtyZxsO0mhi9WPmrBQDSNrB28a2TbmOki+4YeJa0f9VBi3vJmnwgB+RrF5ofOFG+RsIXeep9txkTuPxN+gfryi3viXnz9TWvLX0dChzl5SDhS0W3dLuHT+/HpgSpZ7EHDnfR9dUEjKoo3H6R8e+ewr9qbyews/yZyeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoFp0nePSas7xgzmyhzjFsHoKiflz+dMvPuW83tUaGs=;
 b=CClrub7NZk7XHeDsUDNhcS/v9R77DebKkXJY6dH82ASgO5DRJg+HsRYdjRj212WRtki1t+ejzz/hK+Wn9DxWVS7Nv9Ft09af/tyXhwhEWkl8Rbdo4OenPbqo83Kv3z467hWlNC6HmAWMarwMCkByYqxY9s8FIXT4+WPhJmfpCRQwDbNNZYI6y8laIzhMF81ku5h7QFgDOnGPgD4uf9vEweOXibc/vfkDINnwOFIiNHSdn7mIT948A0sW6Xat8Fs3wVqj6/Oteqww465X8vPI6/i/TXpYKFf+z/GCfNg28lWxSpzcX+4yhlb1wBlB952g06m2Hkp01eVMKIeLujHvZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by SEZPR06MB6119.apcprd06.prod.outlook.com (2603:1096:101:e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 02:27:58 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 02:27:58 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH] f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks
Date: Sat, 28 Sep 2024 20:43:43 -0600
Message-Id: <20240929024343.3763975-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0117.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::15) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|SEZPR06MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cc14f2-97aa-4a91-e79a-08dce02e5530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s43XswHeOtrTclNG5yBB3pTcWv/pV8ER8fT0nJl19qcT/KN6MoRkAeMVDcF6?=
 =?us-ascii?Q?RP48lqZ4E5BNTkMv9B9Mm7gkYY8bcEmNy1+0uwksfBTEumX3jzjhvHFu0rT8?=
 =?us-ascii?Q?ZnGHr3vS+k27R8QwkigRYyhgN458qarHOTKgS+E436y303RuXLv4dFaJGeJl?=
 =?us-ascii?Q?gRGJdwZaz6ZPhJtm6JDStZPj/rlCPNajuAHXyxL6CTz1zNUiCEXcC2RqoZ0U?=
 =?us-ascii?Q?eJvTkNgB+7HsWP17Xlhqq11uWSnLy6tCNv2wrmsu6J/csJU1VGm4cEwhc8jW?=
 =?us-ascii?Q?ZEYTR7ib8k9bZS6eZTWuKb8NvoF6C9PaDivnJBscLby6aZeibizoZQ/lMMdQ?=
 =?us-ascii?Q?HcbMxopQeHzmQw8nbVm3dwXgdB6EmpUyBzKM9iHqVoLOZy1VkSZQzkY+tpfe?=
 =?us-ascii?Q?NpHT7PeVNgGGVOJ9aKs6V0lJpToi5g/gZ42h4d/QqVG9lryGPOS4fobtlYJL?=
 =?us-ascii?Q?U8vQ6edkDZSrxGpD7b9+N3qmbk4kAPqvkMvK4V8iyUmzVQ5cMkeiik1RMxEN?=
 =?us-ascii?Q?D8SntFE989t6wAXuFnDzdFg7Cb6M6VJ/LBGKLQXA4wsCdPe5dpTShuOf80WD?=
 =?us-ascii?Q?+GajUwR00xoI7tqrJx4Q3G1Zy8goVWz+xK3wuwkLXNv41nu8yj55t2V+RmOI?=
 =?us-ascii?Q?kfEqxT0/Gtpp8rGZ+oxNFP1gKZQieidvzqLHypdxWx7/YZTCCaNrfB3t0t0b?=
 =?us-ascii?Q?q0JpLkzKQHf0onGeKQLZZO+oTALL/lLwE5pIfwxq4CbFr9IBvHsh2U9kvPRs?=
 =?us-ascii?Q?IJo+ApU+4Mj5bIfZl0XDwldgnpiJoEFJmfa/5BfoRDg0gtZLeDBAX2DY5Imc?=
 =?us-ascii?Q?hKUcuH6FbjjuHORtaJcjF/NSIWJ9ZdwwfQBM+v1DFQqAzVRNyMYzPNMptglk?=
 =?us-ascii?Q?PX/KiLf9jJApEis8U1DGHzytjl0i4/xjw6U4sdlJKNK1HgTzQfqS6ktAb8R1?=
 =?us-ascii?Q?8e8PCjalGJYlAUfXr9VNuVgHRf7ISEzRrGrGClKnBuHimLpurK3Kri1xTy3v?=
 =?us-ascii?Q?jKdrpvKtNLIsiqkhT1cyeqgqWfjUwL8Ta5X0pokRnwVndnl46Bg3f2t/OQ7M?=
 =?us-ascii?Q?G+k7MryTLA2tvNo/nbHBmwuR+np+uYySrf6PPD6R9OjIeygVHEzeSXbR1jKv?=
 =?us-ascii?Q?KOsDnrOcN5EHjxCw/SXVjxtv1HOAzLMEt/4pGE9vgKg+WOfhWOl97eLAshhk?=
 =?us-ascii?Q?xxU9LVogJbo4t0eoeIEL/DUTBbEN2VBEDgjkpIrFwCgPPRPPD42OI2Mj7COR?=
 =?us-ascii?Q?LvuRuMO3iTcHtL9c4Ql52kxxpjAGEzieoxIVrXi+PH37SNlQLu2tmLku2Amn?=
 =?us-ascii?Q?ktgWZIkafHWlxVTGxzu27EqHGyooSDo6bWF0wQFnd6rY6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a4svtNH9uHUQB2wCYY0ec0ibTRCEJIsACS/DOY4zmQbSwPamd00Wf0Wn/stp?=
 =?us-ascii?Q?23OJNuRWS0p3diX6T6on72H72Wc9RcuINWiM9m6z3jzfVZbBnpLTgKohFwoo?=
 =?us-ascii?Q?NtJFOMuFyoF1icW02RR3E+wiiNLsRyXDn/gILDHTGpAFst3G0yAPhEnxeeSe?=
 =?us-ascii?Q?lWEEgemirPjjoaoaEGAd8BUzUUlp+v60SAExIuOZywJd6Wsljapj08w65jYv?=
 =?us-ascii?Q?avQAhNcmWDFTFX3t+iEN2+pKXfnWfntcx01US7uUgq34TFZww5buOf3d/wTt?=
 =?us-ascii?Q?jUtLyVaewozg9tCKmPswMuNrTorFTDmeA7NgNzM9wWhBjI7y+o+nbeBER4KB?=
 =?us-ascii?Q?C275IDhHiBRmNUidBgyJf8E7n54NAGpUh/MwYbmtkCFOGeGyOD8AmEq08vCR?=
 =?us-ascii?Q?bykGHSEVBbdGxPTd9fJUvuJVKmY18gK2S7eJUWgcpdgCR8jBQ29RnoDpOZe8?=
 =?us-ascii?Q?xSOAAaBNZ2Ophz4s61q/FvnWgw//jQ6BsAePeMZelejfArwVhsbEkgJZAoqg?=
 =?us-ascii?Q?wQbR0GUx6DBZ7lq1r7xqcipeaKWyjhYQKqfoPfpf9l2UeNwDCwoxYswEWKfP?=
 =?us-ascii?Q?SQmFaUQNekv7xoxJnE/6CGTRINpRF3oxNEZsX92M2jxNra4B79I0fBpGJiFC?=
 =?us-ascii?Q?bBsR/pG6wfy0irn+8R5JkFb7YqagVaOCp7advo6gQ0d4QFjqgK1rIBo6Io/e?=
 =?us-ascii?Q?y4IKo2T8x3QdvtexY6VaMMDx2xFoOOW5d6b72J1mNT6f/YxvAUbQItKOOfY3?=
 =?us-ascii?Q?teYyqfHQSEVImcKmsisg0+ckPUXkHv6H5Z5r7AEJSP+dVOx8HVKjeoVGtIos?=
 =?us-ascii?Q?YeG8PK8gTvetxfoMXifqbJK7RVRXuEoXc8EV5wWlYSWB7pF6V0WeR4Dy0u8m?=
 =?us-ascii?Q?5uRaGUvUjkqqIFaRdCXMOGvXilBTt842mt8cE7bbv+s1sE5dLo0lAXH2QU+I?=
 =?us-ascii?Q?UyqdaedNqtkBfs1dw/6mEl1iJFiTV3lx/pKNmm3yWDMbViuhSGGh/tYawONe?=
 =?us-ascii?Q?UfcsD9EpBN+DMUh9ANrYBwpAyCTKGZVVB6afLCjSCCEz/adSQI4tmbpLDt9M?=
 =?us-ascii?Q?DCC5xzGpmMRXJnktS8uL2UIBdIgm/nUZRcmcmMROb4JGb9sAFKojClNx+vFP?=
 =?us-ascii?Q?hqz5+03njiZNCrfc15Jvf2fhOZxeASfInLzTrY71nIHXrY4raZhRUTTwrhYn?=
 =?us-ascii?Q?U9F2/7xVXYXlmh7Vh1DQJwGyFmtZ4lchdOH7xxpdMJdUNA5W677Dd1/yn/Li?=
 =?us-ascii?Q?hRpHXatJb85EIH9FovfR4IX3OiLFn0lG/KGakSufvBLr64zCm0kbZGI4LS7y?=
 =?us-ascii?Q?xH12u8gYXabiLUSa5zyvanY+naXqdJDTzrZ9qcQfwLJL4oyqZy4POfDKM9bv?=
 =?us-ascii?Q?0zrczRFZJpN14+B9gjfp+kwr04ITZMrkbeSiI7vlFrGAKuv4TRLVsC6bOQ4T?=
 =?us-ascii?Q?vJxmZW2PHg/hxpmaF8Ov9J+M1H8v/VQ5DsOEN+0Cjj9iRZb5DkICPYI2B3Jv?=
 =?us-ascii?Q?DNky5M/fuiAG6F4f9eSppz367Py5QyNAyM2cL/f8jGNex7Ai0VsT4LIPJAiE?=
 =?us-ascii?Q?/Ceg6Sa+X4/LdN5siaLixyXX71g6bmTjlni5I1M6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cc14f2-97aa-4a91-e79a-08dce02e5530
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 02:27:58.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sEy447GypYBzIGD3XoKWMUy9ZM4jCNc7ap+ZTRlxbaloOGK3aaqAZf02oHxMS2A0y0t2tiq0Dr5Cm3Q1PNmmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6119

After release a file and subsequently reserve it, the FSCK flag is set
when the file is deleted, as shown in the following backtrace:

F2FS-fs (dm-48): Inconsistent i_blocks, ino:401231, iblocks:1448, sectors:1472
fs_rec_info_write_type+0x58/0x274
f2fs_rec_info_write+0x1c/0x2c
set_sbi_flag+0x74/0x98
dec_valid_block_count+0x150/0x190
f2fs_truncate_data_blocks_range+0x2d4/0x3cc
f2fs_do_truncate_blocks+0x2fc/0x5f0
f2fs_truncate_blocks+0x68/0x100
f2fs_truncate+0x80/0x128
f2fs_evict_inode+0x1a4/0x794
evict+0xd4/0x280
iput+0x238/0x284
do_unlinkat+0x1ac/0x298
__arm64_sys_unlinkat+0x48/0x68
invoke_syscall+0x58/0x11c

For clusters of the following type, i_blocks are decremented by 1 and
i_compr_blocks are incremented by 7 in release_compress_blocks, while
updates to i_blocks and i_compr_blocks are skipped in reserve_compress_blocks.

raw node:
D D D D D D D D
after compress:
C D D D D D D D
after reserve:
C D D D D D D D

Let's update i_blocks and i_compr_blocks properly in reserve_compress_blocks.

Fixes: eb8fbaa53374 ("f2fs: compress: fix to check unreleased compressed cluster")
Signed-off-by: Qi Han <hanqi@vivo.com>
---
 fs/f2fs/file.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9ae54c4c72fe..7500b4067996 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3791,12 +3791,6 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 		to_reserved = cluster_size - compr_blocks - reserved;
 
-		/* for the case all blocks in cluster were reserved */
-		if (to_reserved == 1) {
-			dn->ofs_in_node += cluster_size;
-			goto next;
-		}
-
 		ret = inc_valid_block_count(sbi, dn->inode,
 						&to_reserved, false);
 		if (unlikely(ret))
-- 
2.39.0


