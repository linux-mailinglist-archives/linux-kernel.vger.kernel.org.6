Return-Path: <linux-kernel+bounces-274974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C785B947EFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1766AB22BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315E01422BD;
	Mon,  5 Aug 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iKoZwQun"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011005.outbound.protection.outlook.com [52.101.129.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1047B1514E1
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722874091; cv=fail; b=NPpikx9lfubS6XVvdGSsDEDF0IgYX/rI4yiJKy6dH+IZxKui5MCEFgLybKEeFiP/cB0yxLohqgbnSd4gOeNTx+vVAYqnBdsF5Hhm4EnWCRjvcROViuJSTiUHP7xe80xC0XN3KFgF53s+Yany178yPlqH/lWZCq3xG/d8WGeugCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722874091; c=relaxed/simple;
	bh=S8oJ6DkE9nuuBgb/+4nouSjF5TlNMzSXV6FtNaUXLS0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WHx19uh+8Te1ngK4BBV23WXfnYZYxBiou1Gq8tOP9GhTuzTItei783eBo8slo3+IgwWXVWq1HlW6jfrVZ26+5nRVSJrEwwd+u9vtyALvs5R2kWo68XdsnFlVsl9/3nXLYP0frC6ONcvw/wKN+TXPH5Nr5niPFrXL4LyZLHEnO/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iKoZwQun; arc=fail smtp.client-ip=52.101.129.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w04zAj1I84Uj/r8HdA1+uVOo2/EFm+W1AK1C1qlFTM6UKTDTsKkb0JXeBWcFtcvoMZu0ozwphNCZlNafq8TeFObWSWOEu3kENun/5aUQf77q+jEe5Z4n7Mjxg+R95ITiQexPjYJky5u0LFQYf8R2YTcXZ/SF4ZVincG083/lMOhFSilKsQsaHxQB1jREmlJedyBRwt2FAV6KNDmfR9I/pzywoO2kImeqPScL5UJGl92ixEhEmHZ1+H5v/3nf9YVIFmCWg9yD0yt9TL2+9QolVC8i/SJCfEyfVR2m7ODvVmlTnyk1mxhH8WLcBwCKH7ZAPuPXqrCQ4M5epcv8tevPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKrcm7D1+w1/f9EZUAes0m1eh314T9WAUIVPzQ6rzNE=;
 b=eMjeJLhSOVmt0dcWw8MSVlBhlH84UhusQXrNmv0V+6CRQSHp2i4ca5Ei3usDW5oHddojvVh7VpjEOAfFW10c9H/GMqRzdSLzvy+AxI6MpbFMNW9HEa/Oy6ZlrheUuUHLnnAcuaCiIEDZmnpjGaI7lZfpq0V0Jo5oe8hRoeb9vZEOL87jn7tTp5//TeeVNWHJUOgA2cgpFVao5t32eHPyUUkZdOl8TP5umVw3EdJsrYY3R7jTdqvvcih1Vl8Zaej1G0nnbASNDApOI6dsPHOOgHNhcWgGndOqCAx8ZiC/u0Qa1TyrJTcxqDwwzb206ZDZBV0ut6t+RX5EBwmKgB9iRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKrcm7D1+w1/f9EZUAes0m1eh314T9WAUIVPzQ6rzNE=;
 b=iKoZwQunSCnhOawB4eT3/b17sYlHr7yCxW6vgb65MMsgz8u9YTIWB8nHVQhfN3djd7o+yd2mAoqYrM74SNO0qQMSSGDfHhFbYnceW7zK8CHiLKnunmuHMAYO7DnmbZjO4SKJG2jCn8+AqhZ2z+plk00noybYV2hzXq7w/0eKu5zldFXe1xThyhqBvmoDI1LsZf93+87Hc1rcihATI1wFUwbL0DFrNmPhIZOj9RIPQWBpo2qzYVklKADUKjOJc8jY+JdlnLHQJozbTF4wrXrL9xp229eF5x1cnc8rZ8CKq+VXTq5SohrcPgmfvMHg8AndPOwDm1jc52tHkrGWsd2R2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR0601MB5614.apcprd06.prod.outlook.com (2603:1096:820:9b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 16:08:02 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 16:08:02 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Barry Song <21cnbao@gmail.com>,
	Chris Li <chrisl@kernel.org>,
	Zhiguo Jiang <justinjiang@vivo.com>
Cc: opensource.kernel@vivo.com
Subject: [PATCH] mm: swap: mTHP frees entries as a whole
Date: Tue,  6 Aug 2024 00:07:54 +0800
Message-ID: <20240805160754.1081-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR0601MB5614:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a9ac8c-f468-44f0-ce2d-08dcb568c86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?unWLF5sZ7htz6RNjFL5dhoNaqrGdeUTsHB3u2nIo8DuMZ849iec6yErurkjG?=
 =?us-ascii?Q?Njwbsv+QqYXKnugAxU47U9g/Go/oC5x7NmyAE0vcDrG5R6Bed2sOwVWbJJpp?=
 =?us-ascii?Q?PbsQGd5urRnAxi0NlWndxmMfh9mpzZsK3aByCwnpB1OlFwkvpyW/rHgrPm9v?=
 =?us-ascii?Q?zhfK5xMKwUr/UtVUhyJlr4ZxQAFgWdXjDBAJavosdYXjjK1eSwXGTxI5W4aW?=
 =?us-ascii?Q?eEBZLQOLPcrA2mKlAbHg5OMcYToVXf6uSBTaIJR4IvIBoqPiwEhqMYYk9mSZ?=
 =?us-ascii?Q?Nq/m0wuMXgJZyWKN0I816zho/i4PnmksXSIAhJPfaW8oUFmI+EdLElIvjmPY?=
 =?us-ascii?Q?tpT99hb7p4QZC+i/K9PF0VVaPyHuEWwkf5nYAiPnYrK3WOPrBHqSq6HiXWnP?=
 =?us-ascii?Q?fS7yzpAVNxu2iHs5HAGETkHT1G69oJMYoLQoK8e/EaTyCOqhfzN98/QbBGgH?=
 =?us-ascii?Q?yr8QvgLIGXKtp9VpKoDxA6uwWJ+BtjPXVR0umHlMenRXuN9lyncrtJ5AW4X9?=
 =?us-ascii?Q?AXinnq7H6Hls8D9Qw++WhNPoskw1Cnf9Wra++gPEKy7ZB+L6448w1IINJ2AD?=
 =?us-ascii?Q?sC36IotD+8DlPmvkYAivbT0P8RnWP+wvC0QmHf4Gb2L+fyvTPc1llGYdxuyo?=
 =?us-ascii?Q?h5M3+RUqQczZ7PxoXP4xUQsBEW8vCClPP/F6OlOOd1mf48uO20BvgVyCrQzQ?=
 =?us-ascii?Q?MlWf4Eys2o0eWm16RfHe3dJWWxtggzeF5w6kwKrJvH9iLDQ7W2VToIFZFBVK?=
 =?us-ascii?Q?2VlUcFQ7i2XrxvKj0FhhzCDsCkj+H+CXwIAOpZQJNB4zwACRFDc1K0PgZcFz?=
 =?us-ascii?Q?h3u7PKMFalX/DeUomg0MmR7P3BD/1pgGlHx0vmY5bugnC1/9VUO1DVvPbUbL?=
 =?us-ascii?Q?C+UIRQH8TvvZTgx0wBYPqdlC05DELrOC3c/67x5aPmaxRYKaeHM2JpBBL0Sr?=
 =?us-ascii?Q?36wFvBFMnb7VAiqELWpmEGOVlc8Yo3Lf0ZA0WrhrJSuvmwGHN9kGjYcH/ZA4?=
 =?us-ascii?Q?ZhKgUqCLkcVAk30xyujJC5QP9OPVAUxvevdYQfAgoST0IUXnRfOrft7SA5Zs?=
 =?us-ascii?Q?qQavoA0fuT7i2nrB/fQMkL+LfqcvtTtCrNaGKzfx8Gbah2M2egGhxzODeel1?=
 =?us-ascii?Q?FjqVByx6vkMmJ6r8bViVR7XBLj7JFwpLJXvGnuugceJJ5PelbL4WHfp3UEab?=
 =?us-ascii?Q?FwXLVjVRTEgezl9PyJSsvivQbB29P5tLBRUcjlGnTv7H49hUyPFLMolRufU3?=
 =?us-ascii?Q?H2NQkotOSZmYkK2FhpbU/utTcsoAIee00KQLqjiVq45Wh/0nkyJaDL2y6ODF?=
 =?us-ascii?Q?UdMjqptpdrfGMPj5kyUc6FhJoWz/i3Y0IA4S3WQ65noejEKUncYZhFMaekQP?=
 =?us-ascii?Q?IltZEJMc8B7WWKsW+/gXBE9+hUc1cn+hSpENjLMkjQZGReNiAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Apbgo0TE4k9ZcgKsCJz+x2crfOwA5J7XuIMSjH2DKX9ZeenM1k/L7bRbXskl?=
 =?us-ascii?Q?3N4GIp4MoMiWqrTSVD1Aku/lgn1Qa0JatFTGDZbmYtp/9lNJTGfMOXyaW0Lc?=
 =?us-ascii?Q?7z3SslWRIkyTb3ajONcLB6tGDNfjQ9Aj29cVwf47AUAqWqGfJi6RRxCUJFI1?=
 =?us-ascii?Q?yQt3a/jzCxZz05Iw7PrInYFltp9eouihl6LJEOB5CiX16vRvEG01S8gNkQAt?=
 =?us-ascii?Q?GxsPCE3xs3ODy7xEC+/NfzLKozzVUKm+G9u18M6kbMORv7icqXtAqpMTdb1e?=
 =?us-ascii?Q?n+9E4H68j4q0rvv+QVhOG/O7PFVWvCCnn59Bi+heNcKU7Hg1/ul0QFVDt4oV?=
 =?us-ascii?Q?DSn8dbXHbD60uelMaJK40/vu1VvrlO8S3blnkbppcnMWyIhUEQywYybl9rCN?=
 =?us-ascii?Q?HuNnr1H7pVc3fdiXpZmeoKzopIMEIrxHDFfvb+j7IbYNgTR3daRvQj1/oHJF?=
 =?us-ascii?Q?jRh8M83PwlsnwWXAXIoAKT6Z+LdREOIe2buptV1d4bkWCGUJpq6zBwMhKjVZ?=
 =?us-ascii?Q?bB3Z3LeJ7Q7L6xYqx2gKMT0njaKKECYs2qOGICye4xJNbo7NV6Zus0F3bkzk?=
 =?us-ascii?Q?4bcMwSv0Lm2Uhq3ClxtoiTvnea/7QnwigSSnolECJAxwLuhZ4VX/goHBGdcX?=
 =?us-ascii?Q?SI3t4y1vEE2nQQSbTTeQgf+6KjFN9cwfoKkT78ATMVjU6cCYXSuk0HcEYMQ9?=
 =?us-ascii?Q?fXSahqGbCoiPsapIMevi4FKu6Nh/LK+/KR3cfRR6XJ++M5kg6m6z5zEMwSPp?=
 =?us-ascii?Q?0wpY8aTL9gfB0NDN0+IH9CaOlsU0fdmIcCYB/XcySxMsvlgQ/TYzNoHch05u?=
 =?us-ascii?Q?uuj/Y6Iz3/ZEpYLX3ya8O6quM62osEAenP5ghmaLjQ6qGJp/qI8CG0qJs2A4?=
 =?us-ascii?Q?v1kw2qFT8Q4AFhimoTKuhQBQAf2yTomx2BpCePTS69h1gmLL7+ZXgw3nsPGk?=
 =?us-ascii?Q?n0EzQ83qdSGu2sGXhoddg5pKkrqIIr2eWH24HOpCmembjoLFsMgLNT6KT9S1?=
 =?us-ascii?Q?TKs1BAImCD43bfM/0lv45l3wTUgIyJYlyYmKN683I8w75kOOEnzh4nndVz9x?=
 =?us-ascii?Q?wswDcsOPLkwsqzgIWRabRN3IL4P+UfZVSiQgQkBgAHSwRQV2MbTVpgaItc14?=
 =?us-ascii?Q?pyjPLFXqyi+9wFnkb4M3fMnV5KqKvuWUHTeVu4llCZP3f0CjahVicqDimI1u?=
 =?us-ascii?Q?fUPC6urWZMm4E73zGb+FZLcW8Iu0kN2gLUcnROm5PIKMia7shWbTp9TcBznR?=
 =?us-ascii?Q?B/hQpGKJGG6djEvrVejJYk+5ZzuhxfV/djDT96/QZKuLH1focj13m60eqLC/?=
 =?us-ascii?Q?wbk3NpHSUOQPvmpxhfta8U1Zm3VuJQBnp1Dh/PGyQXp1P+z+zrGL2OeOOKsU?=
 =?us-ascii?Q?GyoVnA73XkT4xVQ1/si6nrNMsmvc+FW9jqV3n04T92G2pa2XCazdek32wUWa?=
 =?us-ascii?Q?1xyvxJ75P1GQHl2N/OR2jnk3/lrExM0SJGrSLmCaMVjjpvU4bL/R+beS7yjd?=
 =?us-ascii?Q?FomnluOyO0vftqUPtecd0YzNSaQKazZZ18nWuL2cnckEwFD3oKP0CLq2iLWQ?=
 =?us-ascii?Q?hH30ORFrdyJgrOetPt/ZYva/6RIYsoex0I1435sj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a9ac8c-f468-44f0-ce2d-08dcb568c86f
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 16:08:02.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L53GOATE5PQehqAvjgFB5UFjbtsJu94D6c2LQmCCOloLrmXjInPRSnFJ3IWfFk1VRpv20UPg0uJGXDygyv/Qkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5614

Support mTHP's attempt to free swap entries as a whole, which can avoid
frequent swap_info locking for every individual entry in
swapcache_free_entries(). When the swap_map count values corresponding
to all contiguous entries are all zero excluding SWAP_HAS_CACHE, the
entries will be freed directly by skippping percpu swp_slots caches.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/swapfile.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ea023fc25d08..829fb4cfb6ec
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1493,6 +1493,58 @@ static void swap_entry_range_free(struct swap_info_struct *p, swp_entry_t entry,
 	swap_range_free(p, offset, nr_pages);
 }
 
+/*
+ * Free the contiguous swap entries as a whole, caller have to
+ * ensure all entries belong to the same folio.
+ */
+static void swap_entry_range_check_and_free(struct swap_info_struct *p,
+				  swp_entry_t entry, int nr, bool *any_only_cache)
+{
+	const unsigned long start_offset = swp_offset(entry);
+	const unsigned long end_offset = start_offset + nr;
+	unsigned long offset;
+	DECLARE_BITMAP(to_free, SWAPFILE_CLUSTER) = { 0 };
+	struct swap_cluster_info *ci;
+	int i = 0, nr_setbits = 0;
+	unsigned char count;
+
+	/*
+	 * Free and check swap_map count values corresponding to all contiguous
+	 * entries in the whole folio range.
+	 */
+	WARN_ON_ONCE(nr > SWAPFILE_CLUSTER);
+	ci = lock_cluster_or_swap_info(p, start_offset);
+	for (offset = start_offset; offset < end_offset; offset++, i++) {
+		if (data_race(p->swap_map[offset])) {
+			count = __swap_entry_free_locked(p, offset, 1);
+			if (!count) {
+				bitmap_set(to_free, i, 1);
+				nr_setbits++;
+			} else if (count == SWAP_HAS_CACHE) {
+				*any_only_cache = true;
+			}
+		} else {
+			WARN_ON_ONCE(1);
+		}
+	}
+	unlock_cluster_or_swap_info(p, ci);
+
+	/*
+	 * If the swap_map count values corresponding to all contiguous entries are
+	 * all zero excluding SWAP_HAS_CACHE, the entries will be freed directly by
+	 * skippping percpu swp_slots caches, which can avoid frequent swap_info
+	 * locking for every individual entry.
+	 */
+	if (nr > 1 && nr_setbits == nr) {
+		spin_lock(&p->lock);
+		swap_entry_range_free(p, entry, nr);
+		spin_unlock(&p->lock);
+	} else {
+		for_each_set_bit(i, to_free, SWAPFILE_CLUSTER)
+			free_swap_slot(swp_entry(p->type, start_offset + i));
+	}
+}
+
 static void cluster_swap_free_nr(struct swap_info_struct *sis,
 		unsigned long offset, int nr_pages,
 		unsigned char usage)
@@ -1808,6 +1860,14 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 	if (WARN_ON(end_offset > si->max))
 		goto out;
 
+	/*
+	 * Try to free all contiguous entries about mTHP as a whole.
+	 */
+	if (IS_ENABLED(CONFIG_THP_SWAP) && nr > 1) {
+		swap_entry_range_check_and_free(si, entry, nr, &any_only_cache);
+		goto free_cache;
+	}
+
 	/*
 	 * First free all entries in the range.
 	 */
@@ -1821,6 +1881,7 @@ void free_swap_and_cache_nr(swp_entry_t entry, int nr)
 		}
 	}
 
+free_cache:
 	/*
 	 * Short-circuit the below loop if none of the entries had their
 	 * reference drop to zero.
-- 
2.39.0


