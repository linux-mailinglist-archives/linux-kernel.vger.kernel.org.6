Return-Path: <linux-kernel+bounces-324175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F619748E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 05:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFD41F2724E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AC513C810;
	Wed, 11 Sep 2024 03:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="naKQ+KNy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2047.outbound.protection.outlook.com [40.107.117.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2C913B5BD
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726026242; cv=fail; b=G2QrgIBQhUFFk7YrHGwoGeVmz51J5imkmwN51icnDeYkPIHXxK+erdCxftUzMuN59RtxyVOkCxm76JNhAcpPTHTUxoE1eMt40/mYHwoh4WnTZeAVGz8FH0ybjCtRbjoMk54c30musff2lLpds9kw73ZnMgZzX/DYYELQInjvlFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726026242; c=relaxed/simple;
	bh=4b21qwXYmc6BNWSeLiCzttwLnHxTk3EYJG6mv1Wxsy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qBmrpDTbifZIewcA+W7nuVMNctzMWI/5AnQ9o+V7DkqCoh797RhMWz7zRit5IBctyax2SkmCEMuvhjSxRFrtSmNAsNGMsTkwRdIgef0ccjO6IUGbhpK+TSatIbi6wFOMWgfl9GGYebJ9YAsIIecL9XpDUnNVuJ/JFZjv3/ScMm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=naKQ+KNy; arc=fail smtp.client-ip=40.107.117.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZgyVmNgmBfJ+7r3/AeKuDruuwGwjoo5+R/BipKBUnRqoISC3LRFlOwQcSpj0tIYx+gO1KY8+3ABMMmH41b8U43Rl9eI80x7BiDy3SnxQQV4XEF4vGxEVZGO31SSX1UruaCjxIJ3RZAAJKWcDLsTklvglaM9D3qLc/4qyCHcrEEfMwfdFqYl4dQTs/FQcrhY3j8AEvYTdPpHltPNixXEzdITdclg5H85nfmGzeih0f9g7Ykokm1dYqF8b43YxkRm+g8HyGTkhnoiJed/g87VEruCr8toUFeC9Zedxy5RsM0unV4Mr5fA1BHLSJuX18DBVEEYkwPjReBxJfEDjb5ltw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/598dfLJPy+7sPDqd8Q4BZGjCDpXKKLbaoHLDkGjkWk=;
 b=fYMiaqLP7sJ1DLz5VqnH3vnk7asm2w4OzLIpoFGCCrZ2MJ/i0FhpSpCSIH/1e80Odhw+R7fG0pgVMkQToQqvM+ShtBB8C8tAHacufswwI3JT2PZoGFep7Z49ts2jlsjCrxtAkdv0ptmrnOea725LIMiGC0Sx+Sj4YJS37nxnPdRff5D71agIyuNGpG+dJdQ+lm/WMHxIkXw8TDyjHzTMRplW4B33mO6fl3LVWYFgfatF54FZGrXRGZ3y1ZSh3WvNX7ea6ZBAxbTO3dTbxTtqruHnMCItddAG5bpD+Q79CvluX6vfbt/DOkF40FL22TuJBQA/QzKyszInNJ7/yyLgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/598dfLJPy+7sPDqd8Q4BZGjCDpXKKLbaoHLDkGjkWk=;
 b=naKQ+KNy7lB0LmMIhSQv4chHha5Q13OASrIPMSfOm1cQsAujAEVXRVflXIRnrWeBQGUGdLU5B1vJr1Mg3npqRDTmIGy7zsvG5gSyfkaWr4wAtbOi4AK/ZASf7Jceux2P2UXHyrLBA+KCy7S5Z16PdIKb4wk+8k9LzUlB+ECv3+yCkHMq82QHZTZhKpFG+dCqR7kpRVp/dpmvJ66K95VIw1QbQESVc85GTKgVJE+Yeb+GjoOmBjY8niQqsvAKi5XcF5Tg7lqjcoiCYC9CnU3WT0x9ZoDJiMGYomxQJ9/VIYt6Z0SsI/Nctlplmb0Vijf5HJy1spcoieQZjPmt0gVIiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com (2603:1096:301:89::11)
 by JH0PR06MB6917.apcprd06.prod.outlook.com (2603:1096:990:67::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Wed, 11 Sep
 2024 03:43:49 +0000
Received: from PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5]) by PSAPR06MB4486.apcprd06.prod.outlook.com
 ([fe80::43cb:1332:afef:81e5%4]) with mapi id 15.20.7962.016; Wed, 11 Sep 2024
 03:43:48 +0000
From: Wu Bo <bo.wu@vivo.com>
To: linux-kernel@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Wu Bo <wubo.oduw@gmail.com>,
	Wu Bo <bo.wu@vivo.com>
Subject: [PATCH v2 13/13] f2fs: implement inline tail forward recovery
Date: Tue, 10 Sep 2024 21:57:26 -0600
Message-Id: <57e1dbb2f348ab61cbc82be7161d788a08b5fbed.1726024117.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1726024116.git.bo.wu@vivo.com>
References: <cover.1726024116.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To PSAPR06MB4486.apcprd06.prod.outlook.com
 (2603:1096:301:89::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR06MB4486:EE_|JH0PR06MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af2ed3b-d4ad-4a41-ebcf-08dcd213f211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Z14hrNdP5kQoHyEezs+IzxGoUduxWny3QmImpxu37CjUxFzwDFIq43eGACg?=
 =?us-ascii?Q?BQS+s2B0NeyYlQNgN6+CWzuud5DNB+aHR5FqXS7btXAZdQ43Um9JNzM5aWH5?=
 =?us-ascii?Q?zabBZyW191jYq9rpctpkgn6CEX+bbbJr3sbcrG09uYT3/hm8OLyzvOhWlVqE?=
 =?us-ascii?Q?rDp/o3AvVhSJD85x5fLa3KJwR0Z+a6iKdFQfvd07dFL5qqX8spw0anMcuxB/?=
 =?us-ascii?Q?0tS9Feem8Rb1X2LPttuxJc34RD+6K0B5vshm8RX6noF4Kkhffsuyv6N8pLPn?=
 =?us-ascii?Q?9o2ShU9DrVwbQB8ofAnOGGV+WkKVzRaH8X2gKeUN34HHlv9LajxqNNXCG6Zw?=
 =?us-ascii?Q?CCp0ugyH/gBbCXc487Vi6CQ5geeXHEROwZkGCVutDDt8h9/W/1CVlpMxWlIW?=
 =?us-ascii?Q?HwyTsikDZqSj8ExjieVY7JHHGAIjFzI/W751VNcKHlRw/IC1djU1P7Oh20qQ?=
 =?us-ascii?Q?CRY8Mcnnprygwk2eDXee3i2+AZ3k0TX0XB8Qznm+3QFrwlZZ2c34SHPkiiUl?=
 =?us-ascii?Q?YktcDJ4rsYeKFuov4sDsblBJbJ4p+SwbzuUjXbPdpDDlxj+T4jXjiBV3EBwA?=
 =?us-ascii?Q?3z9TcFfcTe7ZQY214KgIiPVc/JnFk2GzfKa7npTMfhDKJbyf7OM8iiXmNcyW?=
 =?us-ascii?Q?ykPD5rp9jhnsTmNR+Lx0vv9HEYtOgvfIKlNf3U+MAeMV079e720TfN+laWzx?=
 =?us-ascii?Q?p15TR1ERnsqlVSjpInvBanNll+jC+qGnzR9bfQ+Ni1n45pLndzS9BFUXh8dH?=
 =?us-ascii?Q?RiRda4sjpuuo3kSfbPpGG9ZfHzbtPEiVm5OWeLtCc51tfXU20Ark6K+P9SEA?=
 =?us-ascii?Q?MeGQ0IjTpPq6+F5tzOT37zjYagmBSWL4X2bnVtArwr0BMvOwhrtxGTM+Bg4p?=
 =?us-ascii?Q?jHp6mZtceoFzzcboA+cYLSBoXAkdoSPFtaYQoga7CMR/YbtzHydo5yo+vjp5?=
 =?us-ascii?Q?HvsxXgZmOYuCK1kJfMQ1vdqxbwCvm4yW6gmnZog6A4lZu4u7B4jt9MuouXMv?=
 =?us-ascii?Q?JZ2WG9iPPRnhbVKFOoAGzmjBYCJlTrttNQ158/vMCcOlND8o9yzxvKHwnPmL?=
 =?us-ascii?Q?3iHsXuq0M5jM9BPia5OyX2xfScEqILKaqYatfgjbfkp35/SK8yMvdGr4NUoW?=
 =?us-ascii?Q?YJ+ZPtgvKC/mHE1Ihnk4iVmPdsRummNWDnYvHjkwwaimOFOULiowv8Gt1RUv?=
 =?us-ascii?Q?psdAmcU1gmLWvvS+gSKv0GG84CuyOvA3ged6jQzmlPF1ulHyR+oyYa5Tcgwq?=
 =?us-ascii?Q?R5jK4Z2l4ShGmBHrKyJ1WdG7l/whGDyah/0a26ZqBmx3kDFFapInAR+mZt7u?=
 =?us-ascii?Q?zIRfsU7xzRfAVm66mMAplS7NRVJ/ybo6GBon8W8lJzbsOnZOURhsHRl0HCgF?=
 =?us-ascii?Q?wGTxIo0wkl+YpNoXDOZ7QD6lchZXIn/WW554dpKMoPlctk2Mmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4486.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?czu8XGCwmSm2Vv/o6eGzVGOBRlIrmCGFMpH9UlB2aebllBZLndqvOPBifXLm?=
 =?us-ascii?Q?DO/EnS7orxqGh+0Iu0NHNHirHpYxkpyLyGv70qP0orcePqX3dF+LSX3fbsJd?=
 =?us-ascii?Q?v57yfEXkKIguKQ9+7VXRjJaFVzYZ5yMFTJk8ExcbdgdeMkbRufKsoMF+6TbQ?=
 =?us-ascii?Q?pw1pmnBiBWDlBtSKhK/f76DNmdIl+JpWcDhSP8SGI57MwvCetRAJH4AS5miC?=
 =?us-ascii?Q?LE0H7NSrQhMhBRI+fj9PrrlL3KaOIkA1/5ZwguzoY4AuxKHr/QoQuV+6GwQW?=
 =?us-ascii?Q?unINca7mxCKXgKf0xGkz+QWOldVoSTvyS2YY6/PWt5zjztqoj9+LIPlpGsjK?=
 =?us-ascii?Q?kjZ5TyXZPWBmj1V+8gKDbkaRdjZpIQMCYvCAoiT1h0kR4zljymy6NgCoczES?=
 =?us-ascii?Q?fzMRL3tsSlsB7wM7oM/R66HXZjyjA5/COprsw5ZOdIobD6qSTRb3lD1erzY4?=
 =?us-ascii?Q?0xrRLYcO2asgKYu5Q4Uz4W7PCc3otQxIfb3hKX55+0ydPSlRG4GSJBpzaXNA?=
 =?us-ascii?Q?1TmgpuGyD6WcznCd6y7mrto7ionLO/MvaSj/pUO+1PLMVxqSGP/vyJqZbviK?=
 =?us-ascii?Q?KB3hRHLjuKmbPBshBP50nffmQ/O/u7S+6NO/OaBHD2Dn8uEFxM1qvhxYN9zi?=
 =?us-ascii?Q?cgf2AZ9dpTmgQYqvSGEM6nVU+ucwL3VNL3Ui9y9rLIo24xt3vJKW+1gAI4FO?=
 =?us-ascii?Q?6EdqfHoFjtMZMN1m6TEMf/PIilE75RqxN/lmolx5yYOgH81DGdMXFegE0Uet?=
 =?us-ascii?Q?v+cgn6qk9rq7DV9qJkP9sDzitz5qq1lpj+L0PXRj3qEe/MRW85YqxPVZkEWV?=
 =?us-ascii?Q?XK66r6vTRcAcPAPm2/+bCjartrAh6JSdajPpZKJHO4JAGxwr+IWBRGu8RuR5?=
 =?us-ascii?Q?tC/30eeI3GAMOMFh6MjjuZFbIHe9WcO1sb9EskH90ejgcxJlacCnd5yYCF9J?=
 =?us-ascii?Q?HPHSXK4DaV4V1J51we5+Q8uOMNkboOuKLuW1heFlvSFar05ZeALZebTbSLhr?=
 =?us-ascii?Q?x2Px86NZmcNzVx8OHPeYzN8PlHDwQa53fzmn4KQORKfWz/UyTTUrV0yOfPgP?=
 =?us-ascii?Q?wr8XPUm0IGVPRBHPip6FyaEoqajX9I8ycS2hYRbWHrhNvRT+auy0izB/dH+r?=
 =?us-ascii?Q?7dO3bamKhFRlyqI1D1FXn0erT3K71N4pBXu2SE1yExPrK6Pb3ngKYgMrTefE?=
 =?us-ascii?Q?9Z71jHRcq/engCXv0h9j4Kx9suLhHR2h6pthqOSxsMRGxqXs1stBwcQt0qov?=
 =?us-ascii?Q?GG0mOhXzqmeVmlCvQoVC/fn01/ICF9f7JsHOtkX4znVUXKBrwclfP0nHjCKN?=
 =?us-ascii?Q?nEZhdjn5eu0NAG+sDF9NOX93rZBOfeNYvPHb+EFsqVIFeAvt2MDmQmgl8Knq?=
 =?us-ascii?Q?FPGNcUCya+o2hCsKYRP1SlaHW1MZ2GjFzy5J5IBgaKOAfmxkUkhBZ//hFPiF?=
 =?us-ascii?Q?wvXxopX31i1H3p/3L7Nyj0KX06QdEQryHJVcZnFBDaukSyjtH0OCROH3mQ9y?=
 =?us-ascii?Q?TYRte7Q5h8qzSMg0AW9rsOV/j1Fs356z2NNAkQOSGllYu4P9SbWoAXHhzeAG?=
 =?us-ascii?Q?2awPX4e/UtSyrrW97vIjij/PLK+c/h43O2AW4BF6?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af2ed3b-d4ad-4a41-ebcf-08dcd213f211
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4486.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 03:43:48.8654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACRkSFC6+7TSsZkqWtLOu+LTU7rH5+DjtfkV7Twz8OuLjsTuOAU/02b8CU8gwllDyEB5bu3pQLzvihpVBeEl0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6917

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
index c2f84f3dde67..76e0ff62be51 100644
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
+			ri && (le32_to_cpu(ri->i_flags) & F2FS_INLINE_TAIL)) {
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
+	} else if (ri && (le32_to_cpu(ri->i_inline) & F2FS_INLINE_TAIL)) {
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


