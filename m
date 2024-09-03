Return-Path: <linux-kernel+bounces-312491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED62C969766
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EEF1F250AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBA121C179;
	Tue,  3 Sep 2024 08:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j/bN0Uq1"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC92139C8
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352853; cv=fail; b=o2waREr1DLmWR0SBBw/F2AcsKDFIAehj8oNkaEgEnHYelwtcJRIwXEI8zpidLJzfip57AgGjqd/RWudyzUrgVDxyj78Q7j1yRu8ho2f61tNK7InLYKqfRfq2RDVjh+xCiGAZyBC8wCJjeq1aWa1lt8aylb5pnsMqjeh/E0kmAd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352853; c=relaxed/simple;
	bh=Fmgk2q4p/IwR2wdACxNVa0GZ4upX8qqi13m3lejd2u0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MgBBKpKHtwDJSKDjZ6s+2MGu6aYUrf62//bM12dvGs6TRykSb66ppjN3+aTV+/mUExN+fLrUN3k4DXG/dHPGFXL/QQQBT/HXxOtuUbTlqWmeVHAwd2QxN5c2cmuDJyBH30IeOo+V5frTar2Jx/f0IdFOFEt9eJ5N5ADgw097Zls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j/bN0Uq1; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ecm3IwgMvYZaVLhRNdtClw2QsWMjbfIWje/ZKbU5EWrtp1LkU7CuLqVRsEWuqC8ZRKRK2GiA3Ng5fIP+dcSHXjEjAqD9OzGJ3J4CVJNQz3ZO0lyYdfeJErYPN2fBLLpV5AyuxseYXUg2B9OPgSTVgMyQ4qlcdrlzmN7zHxczA/AgrsTEQ1Wc19Yqlhq2m0FUxh55GaM7Ay/HBzReuR0gRJ0rmvytxSv7bmY3DLSx/qtlyWnLfYZJnoIIS8Lppxvrb+KVBZkVM3on4fFswRrqJmq+9gN08YzPTBpYYNOGkocUX2+sQOGmVDROeyhKhUB3MuXuYSY3GV4tDLqDnwpeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ui23Wl4gzNHQSlumlPbHvIZ7K3txKFrFBs2u97Fs0kA=;
 b=lR81mV6LrddMap61CbynAEF0GxgL/n826Ov6g96R5AS+DTG6GiAzsgqNVvjbBjdCuyNWuvGiuVL8iwuZNdk3SaW+v6UdEwOR/+mLw9qIMvaTwgF8qQMXN0VLIOtp3fBsWwI14tmTuecAxdww1Gh6mFleOCkEIBhUZKbj6TxRysZ/+MOnsRrQoe/Ih0+hmNGqtMd0v70N7w/lPLlgmGb16q5NrS16r4WMFNsVp48PbGSLmr+Kr168VZRaizFnbR2Zv6RlnfrDvqFSIo96mCJZMOiHnyIZUV7p0/Tcp2B6V1qddA91LVJ/Dcy4U7sL/aoiIzPn5hcV3/St8Jlu40BIOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui23Wl4gzNHQSlumlPbHvIZ7K3txKFrFBs2u97Fs0kA=;
 b=j/bN0Uq1us9bBj/ZjmGhiYQGyq8teeBG63xW1H8oApBAqsm8TuRtSoh81uD9vsMP3eQHBFOIj9Dczz1DyjC+JFVHy+F0IPviVNLGGCM9AiS5PFA740KU58plz5aiVj2BVmJlhRs1ItwJZ3oxcwcX6oKuTGUe6Vlfvr3MRGvy2dJa323y5u9UxhjjKU4PHlOftq+MHtgydFxjvacxyRbPEFkzD1IC9eYUxaMXER4dYDwBFjyq3fmfHER3i5pS90UkXvMktpm+La+aQDiyh+lf5iJzDP3r/oPM21fC4lB/GDVXfqmVWgTgtl2mFJjjFgNkHP+Bxrr3iFqIazODhT+i2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR0601MB5536.apcprd06.prod.outlook.com (2603:1096:820:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:40:47 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:40:47 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 02/13] f2fs: add inline tail disk layout definition
Date: Tue,  3 Sep 2024 02:54:46 -0600
Message-Id: <8532545a0f982fe320105ee61cb7ac32319781d9.1725334811.git.bo.wu@vivo.com>
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
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|KL1PR0601MB5536:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f67a4f5-ff9c-4492-c36c-08dccbf41bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mMFUyC/YL2tfBBm6bOlsNkhZgIJlK3RcckA9BoDdEH/Vmius45jVKwk/+rLj?=
 =?us-ascii?Q?A8qYeN/HPeYJu2lBB4Toh1LH2Ify/PzF/tDyUB7t0Ky8qEAQgM5TqyHNHgO1?=
 =?us-ascii?Q?/hjqWe+N6IE1/gulZi55BImjOU9iFoPP6bBf8+2XEViF5fhTyBjP7mLeFzD5?=
 =?us-ascii?Q?StF6J/uI4nIoJD2hoQKs5oeX6BBEtRbriGDNMwcssTMbHs3n4zEAM9+03eyU?=
 =?us-ascii?Q?rOFgoTIUHvdx/9O3Nye6oRTTl8FOeJbkgnAoag5+Hb9sErPGJ5UPPVQFvg5y?=
 =?us-ascii?Q?Rm611cBonb65HfNWozbUr7vOJYRTmwnpbC5SozKkA1ZwC3pDoiHCvwyvLof+?=
 =?us-ascii?Q?TAP4crZZU7tDTFNE2lWXs+ZCSw1wkdvMMh88CSjeGv7cWLXr3ueJTJpNxc2m?=
 =?us-ascii?Q?qFsmoFSpPPk6Bt063EIaEu5QX2i1rFYhnWzPO8Y//uhQegD75u5w7d+Z4p2T?=
 =?us-ascii?Q?1BYHcFrD0ivoc0Ki8iY2EHtXM6UIshbuuZYrmhKVUvrfjaVU2VukZClKmRZ5?=
 =?us-ascii?Q?+e22LpKeii60zS1HATh6viEwKShJS3N/0n4LcQbFy6ZbYnoXPtL1GUK5c7ZC?=
 =?us-ascii?Q?rmamDTeQUFJTQEk7yxNeGOcp70lg/WTU7KdaUZf+Yazsk4v9QGMGwxlKYW9W?=
 =?us-ascii?Q?GVDFPNnUL8DP8OJvAiIKbEncn5z7k/2rCTyk/2C93qYSt7nA++fcovwqwOz5?=
 =?us-ascii?Q?4n4IktiQkk59RVDgAdq4S26HOoXhJHnJei9iqSYYknvgdaNEXUXDNifWZnpT?=
 =?us-ascii?Q?Q3UJ54tiXYv4Hzv8uxnzQdhce+zku961wVG8MB+LkuUZ4wdgcgormlWtFt/s?=
 =?us-ascii?Q?c9xuu1f2d6hToSUWotrCPwtuNsOo71qYqz/faKLKL28E4AsnBvb+ujevu3y+?=
 =?us-ascii?Q?nsiSLCMTYCu2V20lRXqASPhZN8Ork+Isbe2NtDBhYknBz1uHSmiku2iLL6+A?=
 =?us-ascii?Q?o9B7jFG3kTI3Xo39qvt2offd/aXnXbK4Z+a+KU1E0HW+D/qUOkGDpgqVJrjr?=
 =?us-ascii?Q?xru/mWeFIP9b+DuxcMAePb+TC6swRNL2DdrNcAIvm7gzCgBxhmywzedJuMaf?=
 =?us-ascii?Q?OX+E/S7PPfjoM+pQFJzEEMveSIN6iP0PpmS9VOmJ4I2Te1zkqutPvBQfaRcO?=
 =?us-ascii?Q?UHWpJAQj1unoOXhBpU5qWTRiyiN+v2wLhCRx+xL9b+M+HAyREO9bMrPgRFti?=
 =?us-ascii?Q?nOLYCrxSrynu3Bz+4X3m1QGPT46PKJhDe1SletpOUleg/q1KaB+A1vRDfBEN?=
 =?us-ascii?Q?PNsDcYe73uR61BzWM5xVjsEGCRRM/RHTVdgKbRJvKHwKmHszQ65mPGm2jNBv?=
 =?us-ascii?Q?A0N3jj4O+zsoNQMhsXhssnuJx7CM7D9yGwDo109yjfkFf9KZXAv6ot6R3Km5?=
 =?us-ascii?Q?Gq/23GITo9Duj9At9nOFqAnZrxTpdBrfYjzTTI6cu3J0RhcqfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sh646lUbRfujZmXtTvHmp2dKKdT1hPuhpeeiMMcFhpEIfvTIg66Mnq+VPJO/?=
 =?us-ascii?Q?b5d1xLcg7A9Li790luE912cgfwLTLyGqRGW4otZOV9zYS7FakGKFvd6cQmv+?=
 =?us-ascii?Q?xbxy09wnYP2caOMDU/iHhFEqFr+wBrx+JMJo5UgXKYs8/paK0yxkhmqEgg+q?=
 =?us-ascii?Q?t9ayXR/NFoXD/xpZhwln7/X8BVDBGTYhmsFReo8hTOn7NC3Gf0X+gZ4bDJGB?=
 =?us-ascii?Q?U1EVoSoZjevXBRJzbqZTguKYtHqA8ZP8vsoieeXvcF/XEvtf/ev326Pten7n?=
 =?us-ascii?Q?OzzAaytyxaV+OdYty4QReATDKFMgwpd0i7EImOZdq3H5Qjv+3CT6qodHrzxd?=
 =?us-ascii?Q?dyDAK/U41BiwS2Rfz/L+/iLuPxj8PfAGwXVyfKjki+Q0EUdnBvpW8XBJp5+b?=
 =?us-ascii?Q?CgiY4erNwXglQeOF7jSM39zgoBmJlPhlHDfk8PHScq76zZoXUVNQQEbrejN4?=
 =?us-ascii?Q?EWiVRyVZ3bFhoF47xEqEIt8UWeABSbZ4Q9RDghRQaKeJgkDEi6FhO1lfMSSc?=
 =?us-ascii?Q?h8ay/KvKtZet3qCudLwfFmpEDNlFjsTPv+eOgmWZ9x1vYDmw8moeofg3Pc72?=
 =?us-ascii?Q?uNPZKy/1f3oAuNMDv78Z7mbxobe+zIS9Ksyr8EQEQ/9jGZPL0wStW2svAz3i?=
 =?us-ascii?Q?bm6Vnqf93MZtu4Ihf1yu8UR+9546qTwLnnSxpH7OwzDO6XVBrGHdkyT/5vmY?=
 =?us-ascii?Q?sTElstdfoHNSVIdovwSAha32Lt4IEb9eYbiI/J42HKrgxYSudbYwrYO6QY0a?=
 =?us-ascii?Q?DZAr42jGH1gWQnzYIYlQotjieskXYmFHcKi2v+1IMMOWWqKTsn9adhvSUtiX?=
 =?us-ascii?Q?uaRtwq+Bx7u7zJTH10LL/co2N9GI7NiYs6mXt1Ou4ZRASy3CwPnPoUOvOn/e?=
 =?us-ascii?Q?8W/OYUxskxZTMHOf4BP7liZ+1OJ6os5hSF157ZoOVuOb8U9N42MRPXM5yj3Q?=
 =?us-ascii?Q?w8C8GjEc/SCTx//RFyI53f/Oj7UYWKZas2iHFbIdpB/4iZL8ycwuCBKeW3Vn?=
 =?us-ascii?Q?aeTtM51OjjLHA7f99EXf6u05aqlMupHrh4tyOUNopO0CilGemfI1wErwZUsq?=
 =?us-ascii?Q?d7Abqfw/JySGYc5qUlEVar7338R1+D2ECWYYTOiuXSom80CwJtviGjKPcUSf?=
 =?us-ascii?Q?HJF7SlVOiUl09X7TYUSPSCT/jTAJSew371fqnWawsoRvm5Tj6TWPz3f/IUz8?=
 =?us-ascii?Q?C8TdlzzBCN2tV67P2yGCVJf1stM679N3JpckJ3rI3WZLh+Tl7IEJtZD5x4Hu?=
 =?us-ascii?Q?mOPhRp/j4HPEPIzVXDK9WwRX35+pwwXuSCt7/TMvUsIsLyJD9S8g1fJnE58N?=
 =?us-ascii?Q?6Tqk3malPU1yjnPRco08w3Wn8worYyS+TYxtDr2MhH6Uzau/8v+pqnxu/pMC?=
 =?us-ascii?Q?UI9xJeo7QXpEq/316ZdP9K4CIL5JfvCAIvpn6UoiwTrgGDUlasDg+eP1qS1t?=
 =?us-ascii?Q?3EpUNB3p+/BwoKxspLpQs0EiSW/vpohcM3vjMgeeudNqVlW8Ky+kRX1pkEaT?=
 =?us-ascii?Q?mpQxUXbfidWvIeM74pE6uj9V/drk5HD7XH0dBx6SJSwbWujl3sxjZEGJH0Gv?=
 =?us-ascii?Q?F4l3S3rVEElSST9vbq1ICorMfEarOYHKHomSP76J?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f67a4f5-ff9c-4492-c36c-08dccbf41bb1
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:40:47.8495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duoZgJC24oROR0nSBnlPl7mv9KLrIj0M7YGZTZWEVeleu0mFzF2R6pe58Y3mCCUFpMhkXUvFRSIPikcuMOWFQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5536

When inline tail is enabled, use a compact block address array. And the
rest space is used to save file tail data. The layout of an inode block
as following:

| inode block     | 4096 |     inline tail enable    |
| --------------- | ---- | --------------------------|
| inode info      | 360  |                           |
| --------------- | ---- | --------------------------|
|                 |      | extra info         | 0~36 |
|                 |      | **compact_addr[16] | 64   |
| addr table[923] | 3692 | reserved           | 4    |
|                 |      | **tail data        |      |
|                 |      | inline_xattr       | 200  |
| --------------- | ---- | --------------------------|
| nid table[5]    | 20   |
| node footer     | 24   |

So if we define compact address array size is 16, then we can have
3392~3428 bytes to store tail data.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/f2fs.h  | 27 ++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  6 ++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3956740ca7e2..e02a6619b90a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -476,12 +476,17 @@ static inline bool __has_cursum_space(struct f2fs_journal *journal,
 
 /* for inline stuff */
 #define DEF_INLINE_RESERVED_SIZE	1
+#define COMPACT_ADDRS_PER_INODE		16
 static inline int get_extra_isize(struct inode *inode);
 static inline int get_inline_xattr_addrs(struct inode *inode);
+static inline int get_reserved_addrs(struct inode *inode);
 #define MAX_INLINE_DATA(inode)	(sizeof(__le32) *			\
 				(CUR_ADDRS_PER_INODE(inode) -		\
 				get_inline_xattr_addrs(inode) -	\
-				DEF_INLINE_RESERVED_SIZE))
+				get_reserved_addrs(inode)))
+
+#define MAX_INLINE_TAIL(inode)	(MAX_INLINE_DATA(inode) + \
+		(PAGE_SIZE * COMPACT_ADDRS_PER_INODE))
 
 /* for inline dir */
 #define NR_INLINE_DENTRY(inode)	(MAX_INLINE_DATA(inode) * BITS_PER_BYTE / \
@@ -805,6 +810,7 @@ enum {
 	FI_ATOMIC_COMMITTED,	/* indicate atomic commit completed except disk sync */
 	FI_ATOMIC_REPLACE,	/* indicate atomic replace */
 	FI_OPENED_FILE,		/* indicate file has been opened */
+	FI_INLINE_TAIL,		/* used for inline tail */
 	FI_MAX,			/* max flag, never be used */
 };
 
@@ -3002,6 +3008,7 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_CASEFOLD_FL		0x40000000 /* Casefolded file */
+#define F2FS_INLINE_TAIL		0x80000000 /* Has inline tail */
 
 #define F2FS_QUOTA_DEFAULT_FL		(F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL)
 
@@ -3263,6 +3270,11 @@ static inline int f2fs_has_inline_data(struct inode *inode)
 	return is_inode_flag_set(inode, FI_INLINE_DATA);
 }
 
+static inline int f2fs_has_inline_tail(struct inode *inode)
+{
+	return is_inode_flag_set(inode, FI_INLINE_TAIL);
+}
+
 static inline int f2fs_exist_data(struct inode *inode)
 {
 	return is_inode_flag_set(inode, FI_DATA_EXIST);
@@ -3299,6 +3311,9 @@ static inline void *inline_data_addr(struct inode *inode, struct page *page)
 {
 	__le32 *addr = get_dnode_addr(inode, page);
 
+	if (f2fs_has_inline_tail(inode))
+		addr += COMPACT_ADDRS_PER_INODE;
+
 	return (void *)(addr + DEF_INLINE_RESERVED_SIZE);
 }
 
@@ -3428,6 +3443,16 @@ static inline int get_extra_isize(struct inode *inode)
 	return F2FS_I(inode)->i_extra_isize / sizeof(__le32);
 }
 
+static inline int get_reserved_addrs(struct inode *inode)
+{
+	int size = DEF_INLINE_RESERVED_SIZE;
+
+	if (f2fs_has_inline_tail(inode))
+		size += COMPACT_ADDRS_PER_INODE;
+
+	return size;
+}
+
 static inline int get_inline_xattr_addrs(struct inode *inode)
 {
 	return F2FS_I(inode)->i_inline_xattr_size;
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index aef57172014f..88dfcf16da0e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -425,6 +425,8 @@ static int do_read_inode(struct inode *inode)
 	fi->i_dir_level = ri->i_dir_level;
 
 	get_inline_info(inode, ri);
+	if (fi->i_flags & F2FS_INLINE_TAIL)
+		set_bit(FI_INLINE_TAIL, fi->flags);
 
 	fi->i_extra_isize = f2fs_has_extra_attr(inode) ?
 					le16_to_cpu(ri->i_extra_isize) : 0;
@@ -666,6 +668,10 @@ void f2fs_update_inode(struct inode *inode, struct page *node_page)
 		memset(&ri->i_ext, 0, sizeof(ri->i_ext));
 	}
 	set_raw_inline(inode, ri);
+	if (is_inode_flag_set(inode, FI_INLINE_TAIL))
+		F2FS_I(inode)->i_flags |= F2FS_INLINE_TAIL;
+	else
+		F2FS_I(inode)->i_flags &= ~F2FS_INLINE_TAIL;
 
 	ri->i_atime = cpu_to_le64(inode_get_atime_sec(inode));
 	ri->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
-- 
2.35.3


