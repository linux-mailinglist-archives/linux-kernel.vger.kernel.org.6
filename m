Return-Path: <linux-kernel+bounces-342844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF83D989385
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 09:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8151F236E3
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 07:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002F13B286;
	Sun, 29 Sep 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="bJ3a8iEz"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBE1F95A
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727595871; cv=fail; b=W0ptsADd4IN8wQ7R/VVvu2WfaU+HXPyXNer10lprK+xVVlczbjh67B+7uk0IsexQwarc/jHn+tg14NRYiDp33WXuUk5+2dWlmyYZyL8pSVcdV5FLz5XAGB1HgcyunozDkY6vESt30ngAQHK7sh8Zwy8s2UZWzJxpBQXL+XYAVFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727595871; c=relaxed/simple;
	bh=kgvyB18JMJNIMFSYWZWrs983TIQ0fthq1JwK9UjkmiE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gMNjCe34VbokAzEChPLxZo0BkWh8t/MPHEPxcKgYqBdakVUlCMh19XS2S4xq3olfSPRfrEpfg7XTG6fjOUJpCW80iYW6dKiJbf8ct/RzpKO4gqkrGXw/VaDZnGbILX9FHonPxLeXNQ13w4UWzcMh+T6mkDMf1wowF4fZHybT0MY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=bJ3a8iEz; arc=fail smtp.client-ip=40.107.117.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnmTc2y2kvWEzCTGGPwqdJdMfhRNyrcvoqer1nBhsCe7OCQozHOU2c8EqoAEMlw/WLeM3Lpp4fdpjR5KIbhh8DwOHmggBZiEaYWqmr1Z7J+f73+0Nv6gorJEAfP5fDA3XXO3m4XGfh1A9awBeG/vUlhj/gTSox/xY5qZ+pfCnGgT2OrgJckH9oq1bEVm9kEvZzuMMZWCfCrU3912f6NEsxqAq7FRmvN8myIpovIomTAqDXQKE01tDrquLfszSxsAlqWINMHiZxQ31l/uQeS6V6Km1G1cEcArZVBf6Z//bAKbhajQVlUgj40spwI28RfFonNzkqfK5suhOevfn8OX7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va1upUG9uBPKoq4dK3vKX6KJ5qfvwL8khIyV+isnF6Q=;
 b=s9H8L8C2ZfJZtAqXuq/VKrKfYVt7hLVuFArG4HWgK3ook2fwX1RJaO09+FMI2GV/5xYS2mxCxbqndl7XAeV92GXkdcMhm50603REDnTA1nEKd+93uxYK6PNVUJP2IvDcg4mK4Fvs40JVju7VzOlrFb+ftSEhuyRqt2jZ5UMYkhL4Trdrci/cOb2z4oI75nBX5gbVDmed6r6u3j1PLjCktM/kXij69UwRa3bNQHGS6GxTynNDk49syIxc7+p1H0t86LBiaUpgFsJgLnNpJRMwp4Ts7rrLN4+2sV3nGE6lB8CrW7MxnoI1jnCK7mQqef8FWKfrx37RHgWoPV8+6ql/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va1upUG9uBPKoq4dK3vKX6KJ5qfvwL8khIyV+isnF6Q=;
 b=bJ3a8iEzzixcRiIkKxP4QrTdSZbQEyNvjuXnk+JWT1XPo1EABqP4fYlvOzK7DRR2PEOIT7gQFi7WqksDKhDvY3VidzXDy8oK/Al7RddolGsA3ZHNQ/xq17wsgb+6EBtcDTYU/IJgbHWUyckeRi1YHzovdGz6bt1BdAjAigNogn5SG+M3c0rEodCgjbJX61/YalrsQc2Dcd688PGJHhzjhTzH3MtSUqSd66xPdeAyJQpKDjWve4+LlDKxnZYil8WRlrmeVkDg+Qg9HdAmG1hBUDtGGWx7voylHT5c59WI4vx5+3lgvI7FTlJ85Ns4ySYUhmXnZweqXUjilzuG6iPmoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com (2603:1096:101:228::14)
 by KL1PR0601MB5511.apcprd06.prod.outlook.com (2603:1096:820:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.25; Sun, 29 Sep
 2024 07:44:25 +0000
Received: from SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0]) by SEZPR06MB7140.apcprd06.prod.outlook.com
 ([fe80::9eaf:17a9:78b4:67c0%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 07:44:25 +0000
From: Qi Han <hanqi@vivo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Qi Han <hanqi@vivo.com>
Subject: [PATCH v2] f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks
Date: Sun, 29 Sep 2024 02:00:10 -0600
Message-Id: <20240929080011.3802327-1-hanqi@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0223.apcprd06.prod.outlook.com
 (2603:1096:4:68::31) To SEZPR06MB7140.apcprd06.prod.outlook.com
 (2603:1096:101:228::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB7140:EE_|KL1PR0601MB5511:EE_
X-MS-Office365-Filtering-Correlation-Id: 03895c3c-a19c-4351-44c2-08dce05a8a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KPMkcNd9979i7+zo4JWXJioIX0gu50cE1Qe0MgA51WiPa+jBlysCmQX7fejt?=
 =?us-ascii?Q?Imcmc6esAEIs5Hp0MTTRYQp3M7qFVFEpgiIP587OMqZhZfXalm3Vq62fpkT6?=
 =?us-ascii?Q?72BtSCD9rKainDnPHUa9qokIVqn6zi76lPiPUFQJ/pQGhe2JFU4DBHDBDrY3?=
 =?us-ascii?Q?iE89mU7UU7CN4p4zlaX/VrcEr1R7Kw9FpIB7dJIwjBzlEiwgT7eTWznm41fd?=
 =?us-ascii?Q?Fq2jUl+RYQLNuIJvJF0wiSPlC9vxeuJZzoe5bMPBAE6WSbDOsRz72ArAp1lv?=
 =?us-ascii?Q?kQf2GXzRhmmH2ePJH14/b2Q/3qgKh3tbMCdxb8qNzkYa54RV0+eVeBhOJ/ri?=
 =?us-ascii?Q?Ze4S6Za91HYguNUf8filrKcpNEcZmVKk/nZjLwje4Y4fF8F6KOlzKzZ+Quko?=
 =?us-ascii?Q?UOK6mbfbLcJ30kpFukO3euZSTTFVrBb9FIGjVxZt0mCRMqssp+bzlFhgTVVt?=
 =?us-ascii?Q?jGPeo380bV1u/04CDZnoxO7LsXuKsQUTUUpkcp/WYiuo1wEY13zNy1nDzrgH?=
 =?us-ascii?Q?lJUJDNRerxO32gTHXquwd68sxb//Q0lYF9m7i1CFFCDjha8GAYerv2PaD76i?=
 =?us-ascii?Q?eeqwhaevlbMLvkne1su6a3nELA8ePWXTX4LRn2tuHH8aZ9ptJJbxKSVnIt4p?=
 =?us-ascii?Q?QP99zREhkEMryT+MIq2s/55r5xl8xu4plpWP1gcaeqappbnlxevzfiSMg6dB?=
 =?us-ascii?Q?gteuScJTzMEIN3gxHwdjNSNSd99qjsXoC6RQeyJj3ioIo6SFPtY8lHL7X312?=
 =?us-ascii?Q?FTiaE3UxLMYgftA7YnHGb1CHoqeeX4Z+RNx0Wu2ecbKeOxp8D80RKG7V3ntd?=
 =?us-ascii?Q?agFnHlhe6Wddw1AD+OVMmEnsPSKbMvKbQ5iMlV+C9B+uG01oQa7utFicP8nb?=
 =?us-ascii?Q?BLWDhzyK1DHIR9Jo3SU5ekFtWqhM39SBJ/sMkoxNk2UG8gFZGxpFUM2cDboF?=
 =?us-ascii?Q?KyuoJEwGGNr0ZPI3ZH7lGRljGYmgNt/Zxn3EP6vgeWhzlPu9Ec2R8wQwZNF+?=
 =?us-ascii?Q?M72doCc8qkFYBor6cNboTKZxCBw94fPr4Ozq3ip6rwjeoKDHow7QpvRJeqtZ?=
 =?us-ascii?Q?9d+Vylf1zJdsQlOBvhgMwpzAd9qQb3j09GDvRAxrbfIdrQAMPqhcU4B65FKi?=
 =?us-ascii?Q?tUxS0yuS6q703d5KNJJHHl1yMSHzM9bk2Gnbf1nOow78Qw/wSgehOnDSS2My?=
 =?us-ascii?Q?6y9+Qn/M3pxhKmhpQKMv2+B2wWnFqhLZgpIZnhACxqGOfU7Zoi7VltbCXLDk?=
 =?us-ascii?Q?u5S10UdTAavqXNwFmlJ7vlj4aXkhSxGg3/xKPFl2y2ulvIIAK1GjkjnwhItj?=
 =?us-ascii?Q?kwQTWxkS3TGSFgx/uNAIN1Ats2GpDld3pOVfE+NZozxcbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB7140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EbTvQ6VHhjNIPLenyG/4J3252sC3xSyV48+CselibUKy9Cb8+JjRRFtaAhVS?=
 =?us-ascii?Q?fu/ZSeNmIQT+OG5kPypNM84sXQQdw6rf/jfq8m5EPlXJw3OCuWh3DGO2HUe1?=
 =?us-ascii?Q?vQDLChfIkXisK50QD80BP4QUNl+sJAT9QtNY/g8xbL+YjdFN5nYiZvqBDYgV?=
 =?us-ascii?Q?rohDZKBtnJ40eHxA0BMhqT9wZ85TtwkFP2pRJzLzhN+/7PbT3r+BUb/dnb0W?=
 =?us-ascii?Q?kZ9hX5821sbKMMFMpiY10k571etgTA5Pn+l+QaF4EA3BrZkPnsRgjiMIQrQM?=
 =?us-ascii?Q?xCvre/zWsZ4AZN0fDzYtDGrHDSuqtvOY3KiuuXUUBVnaCSGTiIVfZ7EAscd0?=
 =?us-ascii?Q?LK8DuxlIsufLhW857AWzAV9mhkbjesVPLz5SXzGNBN3yAtjUXX5ILakC2jMI?=
 =?us-ascii?Q?rvavu7rBPGhFDMnm20UcMmOFvnT6Ji94GcXyqLqSlvcF1YnaLpoHkpHIBL3y?=
 =?us-ascii?Q?+BWN42g1hNPkgrZPvGsflKRwv0lJg9l1VrwQhe+lW4s7OxWwoJ3sDKlWMTk+?=
 =?us-ascii?Q?zVjbo3haFqiao4i+fVEfJDUP5rc1W2ja9FUSEkbKoQaWN9Tn9+qcnF/pp5Nl?=
 =?us-ascii?Q?UaX3OBCXi7knyf8SJjP1uZMMiIz8RUZXIidPuDGoOmU4NQjS0Tgq2DpE1bUj?=
 =?us-ascii?Q?YQrg0T4HJZSVOOx4D0QlXmcHl9oScHDVECSsUVzGz7XRZXdIwFJ2tJWMFmXs?=
 =?us-ascii?Q?svVqCnk4BTp5p5wQMjBQSaVJoCfCixPiw3yyKvvjSF1mOyP+0jL7C2e2zQ0o?=
 =?us-ascii?Q?vBCr7kfiZ0siV46AMK5xbsquhC9LZmNLwmm6qhD5rzwhv5Yw1kdZvlYzGGLP?=
 =?us-ascii?Q?roebCt/6wlMgno+YsJ/x8QEMDURczz7IUdm3i/x5EGy44dz8cPoM3D05P4NI?=
 =?us-ascii?Q?k180YeqMLrnPk6Oo9Z2UepFepNUEoaAmR2hBGdzD7RfWaxyebFBhAiuCb3Zo?=
 =?us-ascii?Q?gsA1zglZVHcxbZBUqMh9i9Sthy7+y9dDudsCJmDC7xfVwb6MJv42DFkR8Bwn?=
 =?us-ascii?Q?WL0NkTAfzDqTonWXuZ3KUQqd2Fp/PmAnFOt+QmB6pcL4DUjACvUMIc5GulBb?=
 =?us-ascii?Q?2mffHW/NjQqGmlsJ+PhMWhtuBqUZ5dwsTv8MuDAPYMFDZH3NJo+se4RfefH3?=
 =?us-ascii?Q?eft6/KO69WFhuwaq2I2Lk6MVNGn5WAuX9Wlwtyj2pGKdOoWAcZ1NGLeqc4Ts?=
 =?us-ascii?Q?O4/JrKad6zQ2MSbYGSI7LFj6+fZzq0odGcMJysv1mO+bwEMJTJNLbwsSGoZ1?=
 =?us-ascii?Q?Pf2n6oe83jNK+VegHM2BJz1wreX+BkwwYlLNoxBI3UMh0xD8qehEc/64eMHi?=
 =?us-ascii?Q?22xKQsiv6HzhOnIXoPnBgaj4gusVKm7QcaRbiLCKW3qscfgl+VQNZ8tGyVBW?=
 =?us-ascii?Q?zZLZMlPTGtewubnzmovvg/hhWfnJvOoUe+k0hcjbtqyOXgml6q2HciidmsTM?=
 =?us-ascii?Q?If96volR+XsbkxilE/jqnBoTFqadKEe2A0tPud4b14iUcJyYtkHbinm+Xx3S?=
 =?us-ascii?Q?UBzjdtMR2oJF+8m+dWmqoPRga3Qnhj29VzqzjbRHMjiaOvP237Ca7jiOpxBk?=
 =?us-ascii?Q?bP9qwczHtTltXNGwmxM3gu9+DKbN47CKN8crxnEC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03895c3c-a19c-4351-44c2-08dce05a8a76
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 07:44:25.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0jnw2MkhPcUTKbJ+8C8v1vbiFVuP+jcPCdmq7xBKzCCOkUt2oC7Y9jLLfk/nPKL1Zn+E4H+PBAxcCT5CYUfGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5511

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
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9ae54c4c72fe..71d5ded9eeda 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3792,7 +3792,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 		to_reserved = cluster_size - compr_blocks - reserved;
 
 		/* for the case all blocks in cluster were reserved */
-		if (to_reserved == 1) {
+		if (reserved && to_reserved == 1) {
 			dn->ofs_in_node += cluster_size;
 			goto next;
 		}
-- 
2.39.0


