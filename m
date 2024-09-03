Return-Path: <linux-kernel+bounces-312503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0728B96977F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3714284BA7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65C21C18F;
	Tue,  3 Sep 2024 08:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="heyv9Sb+"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2086.outbound.protection.outlook.com [40.107.215.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A41B984F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352875; cv=fail; b=hM97dVNPMsZiWisd9YyDw9ULt0d+hX92ZsllNfTY01nZvdMvq7eEcG/1NceJpM/m5UTRpCn5/4m5LVn+jfxWIISrcG8MRFrFoY/e/rWqhgQxXDr9uVQ8rSo4a2gVOlO7dq1jdMo7AtfQv0kpYhcl1Dvquwy8KWt8Q2/QsYyLTIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352875; c=relaxed/simple;
	bh=uUUBNRCrgU54Tix3rsOAx0XmKiqEq8HbRkjT/xDsaU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a+QODeGT2EJZswL0pkE6xwO2sn/5+udmZ+PNCOyB6ESds7lg8jx6qI76bo42ZxwNDezo1qZ9f4LjJnssIXunpsxDlnoPvMlE8V8in9PrTkKK5dpTlv/96+ftVDORcdddqh/LVnegkVqwCw5TSAbZGH5cI9PPCtoqAui51dBVj7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=heyv9Sb+; arc=fail smtp.client-ip=40.107.215.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUci4+wLAzbLMF+HpMIw/48nHHJ31Vkdnzw0A6RUjx17512+BftFDQAGwyyGnJmswHitDjY/eZaa0mVeUT9mz3ixSyReOBxn+ggrvBTPls2IPx13BHC/VE2Pq8zImyUD0xMsg6XKLAKiEASGg7/MshF6XmYGP4wQd6YPw45rM/cZf3kTnijT7f95WT1AAexpXb2x2f6Oy1puxgCdtk9+OhXg+LLO5KLx2vlKqHmYZOWerXSAsFXA3GiSCA/rtNpQvgHuvxAEDZ6VZfoKuM61mN5qi5A6HGRjlixoCu46zkd51ax3jQ4xtily2iVy8OEI5oqH8pkbXINPOjSNba+Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97TuGgQIJ8tnYExNPNiZlqOaqsccwOGENwEzsLHQqDQ=;
 b=K7wqLxcOd4WZW5BRhpzZco9VJavIqkVhB+92DhuU1Ls/Fs8dOXe/m/NLeWtW2E+AFfs/7+RYmWyU/lTQbt+uUkBcsgwVTzSsV/YZVfCWbO1w40Z2w7yxJumoefNL4sYcJWBos5iarpc0iXS4h23gtdmvPM5779hr2FNIV1DrqijaP23DMD5NC3rsVI6ae1VtPEkOcDQp/pZC5tPcLN8xVu/QjDxZ9PXq5VZJ43r7/5OPTa8zMHryHfdJ7Myb/thhpiih6adnfquMbPu7STD7q0nJwwEAnyE0mxgsDpAP76KqIU42YPnLjCnLZ+ITj8XybcwlihPqdT2X0Xw2r4RbKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97TuGgQIJ8tnYExNPNiZlqOaqsccwOGENwEzsLHQqDQ=;
 b=heyv9Sb+MjdVXJDLU80upWlErZbvGAVEzItzkWsyAE6QEam6NsuBH9n3BCiFZGMjOZp2P5YXnP24CbwCzU9VDR6CyxqV9TMV1j805o3u+Q1V3OR9yBJKzmj8+7nlPi3qV2Ikx75aWpPR0xfP6CVMVyKnWSo5ZLXg5cT58DfRehuS0Nv1gqwLUEvmomNKAn/KJSmDrX6FW2YuDS+nBRD4dyxnDreHJu+rijJJ031PBP676h7KijQsc/nRBL65km/1XctzOtEQlsFGiLpBHSeSq++SoGfJ1XvPHg6gUBo5PeZ0l9QqFSiE+LyOBGRvQ7fWYCDRiEpvPNQB4DFDCxciXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by SEZPR06MB6253.apcprd06.prod.outlook.com (2603:1096:101:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 08:41:04 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:41:04 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 13/13] f2fs: implement inline tail forward recovery
Date: Tue,  3 Sep 2024 02:54:57 -0600
Message-Id: <b6e9e02244cf2460df1256e257103e2c77fae2a9.1725334811.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1725334811.git.bo.wu@vivo.com>
References: <cover.1725334811.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|SEZPR06MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: af97c900-72dd-49cd-81a5-08dccbf425d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iiCY55HO6OWKFaFv23f4Jamrm/aeUWGDa58FNf8WlM7lIAFRsZjJWwyMWhDO?=
 =?us-ascii?Q?W5221gFCdIICe4PY8834CGrLtOIopaCvlvOFHHR+QhiPWr9uJGp3S5FnYvik?=
 =?us-ascii?Q?STLeNp1dkm8CZOGyKoxgWA34vokDrZ12KiGmKG5dArazqaHP9EbWJe+NGxOU?=
 =?us-ascii?Q?b301uVu2Sjt4YBr/6Jsl2FWKqfcuw3QHpW73C4aCf7K5+AMdEJYfpYhnmJ+f?=
 =?us-ascii?Q?pBoz80flCrvPBox84gLOfnITYwU/vfuBciCT18YpeXmTW9W9dhImMnP0VWUN?=
 =?us-ascii?Q?dYs3XaAz+kwj9LM/IfF/raLpPq+SNDuZ2R8NOgWm2kqbY1HStXgjoxviTCEH?=
 =?us-ascii?Q?pr3sNiSsgXa7J1d06OnE92vToNnO7BapcxK9+2aHOwFeniKR9w5YsYL29IsY?=
 =?us-ascii?Q?aB+NwvMNxpvvUhUSKVHHFaUVR88GyOpc4caXftfBJr2icjrYCP+M+eNlx1Aw?=
 =?us-ascii?Q?0006F2CuloHHmvqp5hQ1rkrDzy7afNs1NqUVaRDV4lqSZAouPlZuE2HXyD7i?=
 =?us-ascii?Q?2U9OoKn37DYbQD6ObEwNy7or+59L+Pa6v5ybIv3APeC31fyBYmUj/jkvqa/+?=
 =?us-ascii?Q?osLqqQ4H3kX/7ad/n+MJIAw3xpJcu9Pm16hAitfrxok/SiOJGeD1VVYd3kG8?=
 =?us-ascii?Q?oiRgJJkN6iXJaB/n5s5udQe5TQ85HYqpsSLKlZ1WUcLP3HhZkozHNJOiuzPn?=
 =?us-ascii?Q?fYJeVsy2pNrOd1B8kMjlSO9SaWeIBMSRxAo4CeI7bSCgqsULIU9EHbSaWP0S?=
 =?us-ascii?Q?32FXu67OldOw/NIQzGfwFgRrmTm9kxUlDqIEIaZpFqOafNyvwBnZ59m+hQKI?=
 =?us-ascii?Q?a+6VISVb6gjxgTV+YLgW2SuuAC6OjoZDCOHf77hOniAc17Bi3F8gMXExRdFM?=
 =?us-ascii?Q?/Biwz/86Ua2tSeW8lFmbcYSNNRC4Azc8hTOJ3IN7SZsuO5yDc/VgzOcniDL4?=
 =?us-ascii?Q?VSxP169Av2G9E2MK32ABtIFRQrQgPchczzMAUNwBA2wjbmaE38T6VNsh4BYx?=
 =?us-ascii?Q?ng+DuefYd7RXdQryZG2j5Ufgbk7HwclNmgbiudUwXfmGtaMn8T5TSkdxObMV?=
 =?us-ascii?Q?gIXMTSXk/RErGxK1n+FRP8OBjw1Mma7g54dokloPG2YuB1ystszaHDN3KhC7?=
 =?us-ascii?Q?og8XmHASb3BxtNzrLZBIBEbWkMdFhHKr1oMhqcDP4BxGNpWNtXg8zhl6JiFp?=
 =?us-ascii?Q?6OJvMqX5/8Q4QPmkEbRuCUOyHH8a70EQ/F9HbSFShWRukhhATCk7QUwUDeRi?=
 =?us-ascii?Q?tJibPLHRugdRJAgSZbOlUuImjKI7sGniqami+Lcs49w5mwUz7UijVE5krdkp?=
 =?us-ascii?Q?OeVFKqNv0uS7bezPSGjnoiXWx4MUkt7/NDU9AFbxMjqUXLB1WxRWB1XNPXYb?=
 =?us-ascii?Q?SyzchwuA3uyA8b8XQAWeMCy0DKEDvRr1EcHt2W3NfQL3U1k86g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBAsvQaWHtNQnr4KBdpA1vGKbOsZQhlkZNgbWoGIpfA46b4yQUA7tZ2xSR6+?=
 =?us-ascii?Q?D9l+yiXMv/OKdzebaK7Yttzlw3AXPIpxC9jejQB/rzQTHmF6PL5LDGFFjGBV?=
 =?us-ascii?Q?Xt1KUN2bh8dUKEyKmMUBEGU5qHa9gS217OrQPV1a/lJ65vRCNRyVZ8ELD9sw?=
 =?us-ascii?Q?8KitufDYTeOl/SyMDdpQnToS+sm7vYPteRzb5gXfh6bCZXkLCGeh4xNwM0XZ?=
 =?us-ascii?Q?D5T6PnJJVHNe2RrD+trwIiHAUXsYllzMxJufSD4CkcDa7h0+N3lnPeso/Ts5?=
 =?us-ascii?Q?RN39wU29jyX983rIiqYJ8HgOnYmGglv5MGdo7zAFlUGJoqztqGs35UR5vSX7?=
 =?us-ascii?Q?BXcXQCumi/9fs7kQ6gE4gW3AxzA+qdWiYE1QPa83B4paFEIdcend8TbPVF90?=
 =?us-ascii?Q?KYTsvgrI13vyPgYUDnuvrU5DupxnBxCHp5Dj1z2dlT/H7GZK4CEOCbfXkGKn?=
 =?us-ascii?Q?xs8tQfcNUVCxAzY0mP7bgoWW0b+3LoStOYBPptm6IBkm2YDCgq2C1vAQWnSN?=
 =?us-ascii?Q?gfczYg0De/qkovI42eYOteNlIe793Ioy7WY0ETdZ+HFaso4ezFnJP7cHp1v1?=
 =?us-ascii?Q?2wqvaiBw2ET2OobkBNDZi381sGkuF4rZ5tjeGBMYTuZlppfOEeFneCoFaX5S?=
 =?us-ascii?Q?Y3KQ+KWFSmHq+3VJjl21OSvytkdgy2Z2vNExxCMGT5K2eypvdqX367odHBGF?=
 =?us-ascii?Q?Vy53l1HcX3MKPs5ajPEYOWPop+DrtANII1SYhDudgAj0RWJXxd2t0S1QVYfH?=
 =?us-ascii?Q?wi8Z7UmHvsgBfvDBD1t8Su1JiGXQ3ljRTfHjidWRvHopFLitGSTKCjDpDhIw?=
 =?us-ascii?Q?jZT6iYOaEsqmJtUWpUXoHKN/gMO+N9fhen+giXgvvSkfLOHfDGSIMz2ZtUGa?=
 =?us-ascii?Q?Wfjn7VcrRpVb4V2FnvHfc8bAThTjd5xwyv/b/9BtgTbbP7PocjhyrVylQCEj?=
 =?us-ascii?Q?ni3IVMrdHty2nccEuxZ5IsnKfY8+iopsSw45Y8e0012eKD9Xf0MDSeWnA+SM?=
 =?us-ascii?Q?Oj3NJUgeShiiH1HXvX1FaJwSuK3hdv8LCv2fSM4SVREONAgTd2AzSQQySbzh?=
 =?us-ascii?Q?Coe+lx8GteJj64QkYwpsZ3iB9cXUXJsHrWWc5xfa/4ZeiBRaISwmTSRP3Dqt?=
 =?us-ascii?Q?MQ3r3p9U1HNOqcpY3MLCOqtQ+/+cdYgbfPUQWfztS8wCPqhj2ALABKcGA8bK?=
 =?us-ascii?Q?ZUn/ggSVaV4WiH6EarZ6G0yFRz3oHMeNjqrwo+Il4UzAjwWSJmycB3Yz7ojC?=
 =?us-ascii?Q?jqlJXbWTGQEmtScZo2YB1VimyCn2vh4A3PEYqt72tSzzptL0GVhvtsozJtzE?=
 =?us-ascii?Q?a/xkLcRGysGsZEVa2AnIfExFfiKNaNGeg+aAtdNAINVyjaUFrAnpcx9hgoYd?=
 =?us-ascii?Q?8dXS8upo2RCbLoPhhow9kNrUe7p6yjJ+bbPL64afaiZi+UZnvrvQ8/q5mkNC?=
 =?us-ascii?Q?2qUEsuGmuwBkiVWsgiKkA2IplzsQ6NG3I8WNOPDqNK1Poe5tgv8xbzptRmPZ?=
 =?us-ascii?Q?kbNApVw12HuHsM+PNs4PjAwk2KSw+3+EXV6adYhy9umPiDN60EsBQl1dgQvu?=
 =?us-ascii?Q?nr30BR0nFpl8sRLLQ71omlybv7VanFgAHd/mCYdm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af97c900-72dd-49cd-81a5-08dccbf425d5
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:41:04.8521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/6rLlN8JJbsBej5p1tmvrCzzOAGldxT3NtrKFSWu5HulQvWrX2QUCyfVn76h1T/XVqY9kFu5dzAE7WsiKZiqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6253

The recovery logic is similar to that of inline data, except that the
inline tail may require recovery of some blocks. This is because the
inline tail has a 16-size block address array, whereas inline data does
not.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h     |  1 +
 fs/f2fs/inline.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/f2fs/recovery.c |  9 +++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f889d97209c7..7d5348e2127b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4217,6 +4217,7 @@ int f2fs_clear_inline_tail(struct inode *inode, bool force);
 int f2fs_try_convert_inline_dir(struct inode *dir, struct dentry *dentry);
 int f2fs_write_inline_data(struct inode *inode, struct page *page);
 int f2fs_recover_inline_data(struct inode *inode, struct page *npage);
+int f2fs_recover_inline_tail(struct inode *inode, struct page *npage);
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
 					struct page **res_page);
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index c2f84f3dde67..003367c4cc2e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -414,6 +414,57 @@ int f2fs_recover_inline_data(struct inode *inode, struct page *npage)
 	return 0;
 }
 
+int f2fs_recover_inline_tail(struct inode *inode, struct page *npage)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_inode *ri = NULL;
+	void *src_addr, *dst_addr;
+	struct page *ipage;
+
+	if (IS_INODE(npage))
+		ri = F2FS_INODE(npage);
+
+	if (f2fs_has_inline_tail(inode) &&
+			ri && (ri->i_flags & F2FS_INLINE_TAIL)) {
+process_inline:
+		if (!(ri->i_inline & F2FS_DATA_EXIST))
+			return 0;
+
+		ipage = f2fs_get_node_page(sbi, inode->i_ino);
+		if (IS_ERR(ipage))
+			return PTR_ERR(ipage);
+
+		f2fs_wait_on_page_writeback(ipage, NODE, true, true);
+
+		src_addr = inline_data_addr(inode, npage);
+		dst_addr = inline_data_addr(inode, ipage);
+		memcpy(dst_addr, src_addr, MAX_INLINE_DATA(inode));
+
+		set_inode_flag(inode, FI_DATA_EXIST);
+
+		set_page_dirty(ipage);
+		f2fs_put_page(ipage, 1);
+		return 0;
+	}
+
+	if (f2fs_has_inline_tail(inode)) {
+		ipage = f2fs_get_node_page(sbi, inode->i_ino);
+		if (IS_ERR(ipage))
+			return PTR_ERR(ipage);
+		f2fs_truncate_inline_inode(inode, ipage, 0);
+		clear_inode_flag(inode, FI_INLINE_TAIL);
+		f2fs_put_page(ipage, 1);
+	} else if (ri && (ri->i_inline & F2FS_INLINE_TAIL)) {
+		int ret;
+
+		ret = f2fs_truncate_blocks(inode,
+				COMPACT_ADDRS_PER_INODE >> PAGE_SHIFT, false);
+		if (ret)
+			return ret;
+		goto process_inline;
+	}
+	return 0;
+}
 struct f2fs_dir_entry *f2fs_find_in_inline_dir(struct inode *dir,
 					const struct f2fs_filename *fname,
 					struct page **res_page)
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 9756f0f2b7f7..d73a557b82d9 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -645,9 +645,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		goto out;
 	}
 
+	err = f2fs_recover_inline_tail(inode, page);
+	if (err)
+		goto out;
+
 	/* step 3: recover data indices */
 	start = f2fs_start_bidx_of_node(ofs_of_node(page), inode);
-	end = start + ADDRS_PER_PAGE(page, inode);
+	if (f2fs_has_inline_tail(inode))
+		end = COMPACT_ADDRS_PER_INODE;
+	else
+		end = start + ADDRS_PER_PAGE(page, inode);
 
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 retry_dn:
-- 
2.35.3


