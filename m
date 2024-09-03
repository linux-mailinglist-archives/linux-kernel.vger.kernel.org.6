Return-Path: <linux-kernel+bounces-312495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72996976D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001731C21211
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EB719F403;
	Tue,  3 Sep 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mHUkp5t0"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2076.outbound.protection.outlook.com [40.107.117.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858CC3DABF9
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352861; cv=fail; b=YJVVmGSYC/455ydaJFaaGz3obnE4jZAeHVkPtw1pLRg6Q8a11skXHFZdFYagI+EZEeG/M/OnrXpR0q6KWeQ9NYSsh5a7U3DxuiDEAYZJv82wixr0/8ZqSsHpVFQbuezkbKBMsAYY93U+QT9t4IeMkFVS0qXbdM5CCrTsG2cUcyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352861; c=relaxed/simple;
	bh=oTvnXGPqFYJXJb5D0FNjKJpM8OsIgxPtdmVwomCHj4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dfG2DU8WKKr8yyhgaqOlYQM2ip+OhhLYy3UIkvuGSLLifjZfv7u1p8SEvCKfvbIFDQJB0ewbFPmETuh5gvjXTRvpmLHQYvIbpHQ4+mi04IT0NG5cyXdKCMFhYEj6RuTcl8J2DF4EBHerBPfSZNDcXHbTtuorQ6/DEXnh0O2jReQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mHUkp5t0; arc=fail smtp.client-ip=40.107.117.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLNYvWdzs5Q9i/xkS2R6KL4f4ZPwBWYqyuCp2Ut6VElbpovE6+07xYFr9okAC+DzamZ7xnIepbiTDKe1q0AGxqvsuDsHH4xPqwMQfoM0/EkwaL33tLZ+sDJT3UoMZFA9f1pz3vC4wtmsbizJHbMbuuSdO6DD07FCUoimS4s136ga2kMOX30GmB4YliR4ihGtt5/oeW+Me8JdZd4xiLW134k1A/hw75kTZKL6Z9A7oGXk74FFK+5qEETEm5ydHER8bdB9MPzJUpgXqC4FXWyvlOXiMGrUUdegPgxwSmPkqKHpIaB+gFRMgf2YbSM838KnR/H5y/DqY16M1hjkgg2fkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbAYiYW42KdJTqSuWfOstLknlNwHmM+iHowcLx3rDog=;
 b=LyJE3qIExjDnFPKiilSDAF84485s8Nk9bIL6RdPBKjisqo54qcmClyfE8uebHMuaFa5KR4FGA4pOd4aXj75uiVmp4eJMTdHlRBLxnJx4n7biI//H3aZ7pB8Lrk0NufO6LExQC8OrNyPVpPWPKF6EPBGFAr8OiVnb+y1naWKyRh6q5RE+FnBdHhGXkIv7eSgeq+oHjhoZczuZagh9xeQBjuOejQeTfYJoAssIX6d+tohKYtalRTqvVRXr7HwjPn2Awwh/3/sHFkL5CExXAtyi27t7UKyg5HJMHVSiIgo2Fr2HuN9pPeFOdb1pkzpgu70GdE4KFAi9AQVNhRaDz8QOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbAYiYW42KdJTqSuWfOstLknlNwHmM+iHowcLx3rDog=;
 b=mHUkp5t0ccoDnhW5I+lllFVU5ucuzKrdynPU90FgdxvqFonBaJ3FfLBnCBWBltC/6DgASY/em9w6C/N6AFajC8UnmocYIaJy2Ga6GfMHApNVXhWkFkVQ5zYPWF/OqdJzDuumdT7lqkVch4nkzbRui+guMykeFrFlV3i8tuP8RzcDCYpXjsj90Rcz1T0CWuWeX1hVSZAEN7WAbSfS2g6sgQrA3qGS42Mx4FDN8loYfbWg4Ms4DqFE+F2IrV2yJDBnb2rf4vqdchGbubFEzWuWCfxmg7MdpxfB4J/exXIpOiCEXOWNsWTfjnJewPTZTYLcrVbWofmgBFwCzLV8AedM1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by KL1PR0601MB5536.apcprd06.prod.outlook.com (2603:1096:820:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 08:40:53 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 08:40:53 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH 06/13] f2fs: fix address info has been truncated
Date: Tue,  3 Sep 2024 02:54:50 -0600
Message-Id: <99802996a3f4a0c2d89c79ec17be94e9c62ff8b6.1725334811.git.bo.wu@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8a036e1-d5e5-4348-ee76-08dccbf41f24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kPE636QvGLMjWMxvJ88pIlDX3uR1YzQdPJfjYhp41DzUdmbsvL1Y5/hCLKHL?=
 =?us-ascii?Q?Si4DJA+/5AASyxHGyl9pks0zzms9CQhDH2eNqEjLmFfswWECxtop8e/K+2bo?=
 =?us-ascii?Q?olwfWJmIfGkeNMnQ8XyTI/OiPz9tLb88P/J/bu7tjUx+Rfs+ofrspFjT/Ll5?=
 =?us-ascii?Q?ZDAoedo9kDfVNTDIRKRnIo2zsd5nlnYpKWMu1JRkpxvjiKOeki9tj0ItqUlz?=
 =?us-ascii?Q?QZhn0goZtUfgqRneHzzMjcivzR03GW/MGmVUmTJ9trXfM8Nrt3FjY71S0T1E?=
 =?us-ascii?Q?4dCoV+0mjWRjrKitUP24mYZII0m7Qz6qzrbdDotOnZc1ZzGru/UEuy97LOnR?=
 =?us-ascii?Q?h5H/XwNzHNzqgLgpbnDHuQlHNVpbdocjqiUnPwT3XN+iVVIJYw+drsalP1mE?=
 =?us-ascii?Q?svalUIWhUehYGl3ACwCYrBb1Lyo/q7z8Hc8z5L7lk9Y70sc3uVVtOX5pMe1C?=
 =?us-ascii?Q?mx/CZyfvZuNw3y6T6vwKmVaPDBj41oXA7FTIQQvsNWS1OWp3kaa2UT6sliZD?=
 =?us-ascii?Q?DZmjWRJoxaVS1wWNet2PH3fZTDGiGGK6VjBUicie+vLGMD2ko7j0bAB7/qJ3?=
 =?us-ascii?Q?461/ADg9HDF3nSO7VWErx7Su0Ce8a5bhh7Ngata2Ztt4D2H+8VAc9IfvLrtF?=
 =?us-ascii?Q?NJKDojGTFXak7uRrACu9uRTCSZmA7x9lSRtnEP4/MWCIDIcOcDPHPaPhaa4i?=
 =?us-ascii?Q?dHSPRpNxsmOyNEj8/+ZvGkKiUz++ZnAndsd0SSP+Eq0ALu52pwfG+z3PpkPh?=
 =?us-ascii?Q?dYDecUKOM0dH4lhLqQVmAKDt9TLi10ODPKTXozn6psFvUSWCpf/Z6afu8WR8?=
 =?us-ascii?Q?LY0pPDG9vfbXfoe+jp3QhDJE53e5jH8w0IZw80oaaWWZV3eabqxGYY8+6Fnh?=
 =?us-ascii?Q?KwiF5/PmtHiUj1cUy+GBa7z8PPDGg7b5vvx0WN1QmmYFHNYdeOpxAbqPIDub?=
 =?us-ascii?Q?y/DLe+SIXswGzMXzXEnvkGg9arPzLyPoc4fERQJek3CQ0Cvr1y8AJgCi5V9m?=
 =?us-ascii?Q?Id80gXo6JbXHYDYo9KXHvBmZuc3krkkZYbFh9ugJzz+HIsYEHeq1cflPDHzw?=
 =?us-ascii?Q?8qa9Op2M96+FJRG2tAZvLs/akOEpdBeV9DIAnSphBdmtC5fOXkWfJWNfO80h?=
 =?us-ascii?Q?eNJjjSIGRxNxEhtK8NgjCzHwTE1DUqHQCnFWczlVJFZZAWwfBTPeqsk48O7F?=
 =?us-ascii?Q?BZNjTK2RRtSTTYXjx/gAFdCMsvQO0L20ItfGohM19dJBSgI4vSvoy+rmVy16?=
 =?us-ascii?Q?qU2Ocy1YXXLj5JBQoxKpHJW8fdfIcrhlimvOYJs6s1lumsfAvhuuRdiQPxX4?=
 =?us-ascii?Q?YO5XbUVDLq/3XjpoApuiEJgdV/+h/uh526mCz1CLZdj6SO/RJQ8cj4QemNio?=
 =?us-ascii?Q?bu/j8CidcYNVzyafVTLzeIRKuHcFCWbbiYejmBwT2VzTNt9q/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YBAQveSXN1QuUhs23v3+7NNGpiNiPFrcOKW6OVKAhiQAcRNDqPzMJuZmzJUU?=
 =?us-ascii?Q?DwJ+jsTJtWliS8n8Yt4tx1ACAJ4jIKKXZdWJ6x5TG5U/xwsSwn/G22NrD25M?=
 =?us-ascii?Q?KUMmQNXJmCoKupxG1GcItu+XB5ioT4Gdsrqz7LL4XW4MZdXDEhk0NP76ErvV?=
 =?us-ascii?Q?1O+lYtjqBLIYfmmpxgn/0s98mxOL8nSONvjk2PNpzPhWSEZdiDTJ+qSFTVX6?=
 =?us-ascii?Q?ypBjvofkWrK9D1ad0cRaocrJLG+CO0/sw2F40zIlJQ34sDJ0W4vVQ70gp5rw?=
 =?us-ascii?Q?Y6ovxExzVUFptmM3/9TDPhEvHAfre+0kh/VrBkyGkFFU9KDKVAqRqyj9g8jy?=
 =?us-ascii?Q?KYOzXVATrZLBxJ4zU4LSoYj+fBesWMept99OGPEEqzaWxlamNfT+NoEyoH7N?=
 =?us-ascii?Q?t7zDf1Z5sC4Z06sKpvSXwIuuFG6YIbhf5ohL+Daly/8rN6S/LbwjpgvzFpA+?=
 =?us-ascii?Q?DxXcKZw5eN/2A9fM+0Cddz8iIcQBfGpx9IXVYjQtx7PVN6cWKQ1mtpFL0wou?=
 =?us-ascii?Q?nHuQ6TFY5QaZd3SZvYe9Tkfn3wohLEPw15jGKdxZgN0MAz3jwq51/vqIx25o?=
 =?us-ascii?Q?Ri1DHBZHDoDoAHOHaaMPXYi4y3Kjg8p4AmrmGlq5JG7jvTFTNBEMfUblIakc?=
 =?us-ascii?Q?oPvMiA91qIXmM8NYTJ+c9+ZkBifb0g4h4LuKYBwPrGxaRQdRgV5uxQE6e9jo?=
 =?us-ascii?Q?edAorL/I/EpFoyvIpk1O8RHg9ct72Hh8Svr7XHwoWCiWVy+IsxE2g4efVbCK?=
 =?us-ascii?Q?YtEoxp7VmxEChXcgSF9fuptMHzGxyeGmxYtpALpngfOMR5kVlDqMI5AFccGC?=
 =?us-ascii?Q?i7Iawg9DyHttHapQjpQ1iW7Nr3NCYcvf8/AAIk0iUuuPk4y7VXqdR03alzNQ?=
 =?us-ascii?Q?IHldKTpCMC3tES0SS5njyy25DpXMosGZND7MrrlLQtm8RJCgbc7INHUMvo4W?=
 =?us-ascii?Q?V1UDsCUh8OPQodSdA86I/ZcpXRMCKkpfK/dqZb4RnspEOn0wWZ+6oOSU8UYJ?=
 =?us-ascii?Q?lsXa2iuVtBcuykMvunrjCMYZMqbKWK46i5fz8+NQgDMdeBGlM4K4q37j/qx4?=
 =?us-ascii?Q?GPJLYxMRUwR44x2s/oGhnnOp75/awHIGUOXsrsuVvcYEqFyDO7A4WhzNIdzG?=
 =?us-ascii?Q?GgTon3YUL3LAyyrPyS5dM15HQcgH39vhsnhfcnLRY9xN18Z0KjPV6vyEzJ5d?=
 =?us-ascii?Q?tN7bYrw2TuMC7YP4hICXrbWwg08E8oYHIw3oU/8ooc1FAQqK+h3XRPnK4hxF?=
 =?us-ascii?Q?RD3MskNMKfvATQKAus2csOXJTtHfNMUIjmnfe4pmvJ5ZMcXJnlufslSrJvtL?=
 =?us-ascii?Q?P/Los8WpniCW+Ty7nSc2lx/JoHkKpuSZGd95DW2Kw/zwLeLDjOAOh5NYYR9r?=
 =?us-ascii?Q?T/a4LpNlYASFz8waIcU74TzAD2ttEnb6d3iDyPrHR/WxU8qWDtD//5oPybxR?=
 =?us-ascii?Q?wCO5WUsm7WmmzQvIoECF+ldJyFZibEHvJSWEFJsbj9E4T8Nlidiq47NsB7qB?=
 =?us-ascii?Q?et4VxoFXL9q3L6mN+JVSJ4oLxWKu0mLCYOozZ7qNMSZiVYEWtWVvIXQhvktZ?=
 =?us-ascii?Q?qpJ57IU+wTSvh6Cp215Dlqo4pgfgAYGjsjMbn8+y?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a036e1-d5e5-4348-ee76-08dccbf41f24
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 08:40:53.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2R+OGMIPFY3hd6NYOTZ2HPdGhEqBnoriz/fkF7xzPrigj0yif4GRa0I7XkLANc//DfqUJaVzVvRbuGA0xYRpsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5536

If there is no data inline, the address table should not be truncate,
in case there may be reserved address info.

Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 fs/f2fs/inline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 30b18053e784..a542956d618a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -224,7 +224,8 @@ int f2fs_clear_inline_tail(struct inode *inode, bool force)
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
-	f2fs_truncate_inline_inode(inode, ipage, 0);
+	if (f2fs_exist_data(inode))
+		f2fs_truncate_inline_inode(inode, ipage, 0);
 	clear_page_private_inline(ipage);
 
 	if (force || end_index >= COMPACT_ADDRS_PER_INODE)
-- 
2.35.3


