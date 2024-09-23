Return-Path: <linux-kernel+bounces-335571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1697E796
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9548D1C21039
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795D188599;
	Mon, 23 Sep 2024 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YKZ2jG0Z"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011023.outbound.protection.outlook.com [52.101.129.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9A2F2D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080419; cv=fail; b=A4Pjvwv1cwSdg5c27LEiNA9J8riMdFpP8IcxdWPmEEhgB9GKoShJnjGTAo8JRvUsA4huRYXHnKjq0W+1TkRCWyF6zWmAsY7WX6MNMEP5KT/vDtt8CBSdvNErAZlEFn+0hYV51v+c/+ha4Wn4FuHbTg2LwVXE2liNVx8OMaCjj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080419; c=relaxed/simple;
	bh=6iJoMCGApKEvBmxXFpRM+1tW0Wm/NkJrmwZV6q3tXbk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=g2dLdfZzWB1jpO9HQ5JG4xOnfTfWVx5a441NSwu71/NB7VwvG5iKtWVlYJVgk4o5R15zZ0QEz+ihxMHcwDICtQZ7+sixX1efk6aq2rRb30j4N8FLO7HHLEaVQWbaefYPWSAH1IojG9/CQ/zakpzXXveMdiOiHgbmAIvBGzLj1dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YKZ2jG0Z; arc=fail smtp.client-ip=52.101.129.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkh3QqQMtmY2vG0r4666jEH50C2uy/aIUOs39JOeU7kJEz338NpFyDb7nye1OnBV+WCeahIAdMsvzC7oD9nW4NQa/GQtZ5DskTTXHuxypyboxIXnaGPgnZp/YgNg8Iz4XVpi7GhSgUw0C3OX4fAJbOQpIKnnY7YPwF4VAS8ORQo+hoXfkFY57VqhPSXMUrB6kbMIgPs9stTxzw0kVThfXbWp5Zgp6213JyZpLIgeAEngXLMC8+Dqf5Bvv3uXpq3Vfl3iCtnv2/dwDODKKh02/3h6cuH9sbB7M0TEhdK7moQ8uAP4IUXeQFSbcfFlso04iWHv1CrT2lLG7MtXvimoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfTttx0oHkrSfZLf5eXWFq8XONAiSv2viBcMv5w5Un0=;
 b=tKwUScloswuKHf69pMDFb1yP6n2jdbYZHA9hOiLvlwmHWgaC05XCcQzLImqnLCVU7G38MbrSU0C0MokxBhqTncnYJmRx6Y/zJehSnFeSbfF5ZJQZ6BGI9ySeog6mdZKuaatVMXClqmbQWtNFsJcmHWK522KcsN+Ny9gyz5LU7ctjZt24SyJaea+feVaF499tdomRUERk3ucPBGblO1m24d6ssivq1sU5lGtnA6BPyRAzvgYXFd8iyKKMzbfCa/TK2aJ2PLJnz2sRHBlchB5hdp3xQuN0nzp7D15n9ou79mt8LMpPPcn3NKoTOalKaOibvk/BurrQL+gGgLyQtaWp5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfTttx0oHkrSfZLf5eXWFq8XONAiSv2viBcMv5w5Un0=;
 b=YKZ2jG0Ziu4AVR7hFp0O60e+VWQdCxTZWhnSZmOzol/iMkhTcZC9ubiHzLVhzifiNQlQ8OrsaprbGlF0U3gokWh7WkJHdvxCsZxZdDHS36WK3VXqyy0yp5GCrN0xVMbnw6hcFE45YOW7A7WOYJjppHhYTkOdmH5n3POq/hQfF9qmneoDjAsaddSeWc+c4OsnXNcQz5l9AsFQe5BR/dmLZlVroI6dXjka8AUWotEf1AU0sLMFA2RXq3uO/u0gTyhDfdYFKSNQMYdO6tF4eh6lVfn6DsgEOKJtD1aIkpZsAOGOibnUlT8M/XrTXPSk6rycicC3awr4VPd00YPbWM4QuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by SEYPR06MB6358.apcprd06.prod.outlook.com (2603:1096:101:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:33:34 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:33:34 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: dwmw2@infradead.org,
	richard@nod.at
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] jffs2: Correct some typos in comments
Date: Mon, 23 Sep 2024 16:33:22 +0800
Message-Id: <20240923083322.13383-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|SEYPR06MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbcf7f7-dfe9-4617-0120-08dcdbaa6966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gY2KafTaqXPEXL8zsoH2s0tIrkc/arUqLWFbua/0SpGOPfGtU1/tXp8mUMVF?=
 =?us-ascii?Q?l6IaRsCSWE2QRwPvQbgPHwBN9m4pa1uTztskBd5y9RAgqE6Yuf+dtJvx2FgP?=
 =?us-ascii?Q?o+e8QUVCJ+f7dUjrufaNJy9yLemnwRDvJI7KyBhl2P2nrACBSewuYxc5ydvD?=
 =?us-ascii?Q?D+ZwE9smr2c0/ZOtEzz6w8JmWJDb9VS4IaVU17MkNTd4lyAAc5o90uuDsMCz?=
 =?us-ascii?Q?6HROwKsATPDnK7l9EOQ/Z7eKca5+ydLPiFi9nIeH3Dvs3DvTwpFJ2mOftyBI?=
 =?us-ascii?Q?f0CugfSmHz8RV3N+nmjW2P9sQRC8Oq1tNSDcNI2r6vAPtGd9yCBWgtRWscjB?=
 =?us-ascii?Q?srBJxxS2woOZcgMAKmnraCfcrWAUL2iQ8WQ1ZKRX5yb9R7dhmR/BTiCBIKO3?=
 =?us-ascii?Q?pqIMCKYsK2j/KPzzJB/E98960F5UJ7Y5GIgXyTAOo3EWTBUV3S9gNkSp09+N?=
 =?us-ascii?Q?94W8+uxzwocysHUaH5c42H83GD0muGItvCo3vbmdnHD6NrsifGUP1EnHbhyf?=
 =?us-ascii?Q?Av/j8/WcI73INmO5H5MK8VqpI+grP1HOWJkJBPDAqwCuwZhBzhcOE3Ad/wds?=
 =?us-ascii?Q?0HdOcx8kMSl1f/L2sIwxo9yN1FHemPO0xhcVBaLaqijJJGX2XBr+JZCn9h4X?=
 =?us-ascii?Q?N5dhNkNumZYt5C/Z6J9Mli2MDt9RVr2Fwu/XaIejtbZxZLV8qbRPT429Q/aY?=
 =?us-ascii?Q?ApQMJ2h+s8lfekz+CjRYYwfBlUKw3ExTAMAUVXvMgSXFMapqK2aP+iX1WRQV?=
 =?us-ascii?Q?jLM+w2aWOmBEmNVR/iJeeR8w5InX/Azr9at+W9l2FFWgO+/UPvUUWmBvrRqM?=
 =?us-ascii?Q?FbmxoHG9QQ3EGciGq+BeqOSk7bFEFomVn2baTXz8gdDbIy0L8iG3SrHuqsRa?=
 =?us-ascii?Q?eQyBExLka5a7nGb/XBz7fVxN2fPBMfmdOMOmT1oDEGqVqL4Wi7V3iYHBX9PW?=
 =?us-ascii?Q?YcklnQSMpy5kvn7ubsW1EdlUEJ+kZAzrbvYz28JWntIK+3eqvNQPQ30I0m3s?=
 =?us-ascii?Q?etHiGuT4Hy65tlrTYfkLbsJiJZmoC4lOdCcbnO0/H0uW71O3PFqlnle1MHLN?=
 =?us-ascii?Q?5YzaxKzlRR9692LN3ScIFhN0AZnnc2DJ2I77RrJxxH8Wv2kQEAZhU2rfLbzp?=
 =?us-ascii?Q?3LY/RaxiftXI/P9pzc2/oYi4qD58LdF1C1Z5pcRTMakdYjUv0ncVSRR9DjUg?=
 =?us-ascii?Q?pz9xuBosbYRkjx7cnbQn2q+JRgBU71KNIm1+uz4s5OQ/VM5q7tfkXhWokFrU?=
 =?us-ascii?Q?3P5yQ4Ozw2ghyyarEYiBKCOcVaG3MqLlhyGP24LW6lu+Dlull/F1Nna2N2Ma?=
 =?us-ascii?Q?sopCgsLODaQ0ELL4OR9nUpX/dHpRsguo9POSbcVuiPpANQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1wDDgbycn/67aFx4qz4ZF0czvLKcEDDqTmpxxW3lZiOPGQyBjLFiz4UoAne?=
 =?us-ascii?Q?MRnOUzq1LUw/CvcYGKHzZJUzZOUOhz1bQEkvyfXUFB6OHfYDFJHmrwuT3IMA?=
 =?us-ascii?Q?v+qM2A756uPYHXB1a6XdGNC2w6Jne9g0MFSXnuMc//C09NDKR+FSW5NmD1Ww?=
 =?us-ascii?Q?mzS8mqQS+sNUDcvkgCnM8flWt5GiWEUSD3Drl6CpualWpidagWBUVmcCZFMk?=
 =?us-ascii?Q?Lyzo5W/u3MK0rHBdd2KyTKZywa+SFCcQfxlRK9MTliqNVlqQb6ZlPdGiraw7?=
 =?us-ascii?Q?2hVww7e91VQnyUMtAkhnloniGSLIiKQ9zoPj/SwJW0TsEAA7m8yuC+7SyUAN?=
 =?us-ascii?Q?QRKxo6G0G+knIFHRUHAj4HU1M20syM22bqObTwjhB8UasrT3hIHiLBMAeCA5?=
 =?us-ascii?Q?/usJkDcwDThvRCE12V2YGjhOurWlyIIK6xRE31KQWjItCrzqKZw9fT+5VYzw?=
 =?us-ascii?Q?sPs0xYnDfHEnFpWXHGcbG2DuxvPF8InRwpsQYxXigxL5PFqlXNXyZ1N6hqH5?=
 =?us-ascii?Q?R/lcTao/gPMjh02jrbeC48kxklJRxoum4HKmluQboFfuLj6ZCwwaHcmrksfS?=
 =?us-ascii?Q?ei6tJPhwQnjBd90/JFbvX4R+4z5w80RgLovJcaJYQZ8LaFH6MqPDY2RxDesQ?=
 =?us-ascii?Q?R7wytK7QUx75hNAsusTS9Qrfal6abg4XRYHf/FNmG6bICsrDoFNhENZh1MFk?=
 =?us-ascii?Q?KOXUYZY2AqLN0Q3vEditTMQAjwnSYICmdAjSJzg1Xd2X0KzSJDg8Ofy/afQV?=
 =?us-ascii?Q?TPWAF13jH4u65Fb0kt1E9VvqB/9pbwdcUI5YcyU04cYEz2yknYKYS7mGF0IC?=
 =?us-ascii?Q?SAaJQTLyRaW2rb4nYwknNFrfBCUGUY3hL3dhuxxbKHZgWqwllRgmyLYuNXOd?=
 =?us-ascii?Q?EYYoyXEisjw5P2P9ZdO4rHX/3a7Nzb5slThzpdl3XKQ6J7/GF1RXA2+L+lhC?=
 =?us-ascii?Q?iSPf+cF66dP5LxB+VdQCd6ka7E/whSYshVkAxffs7SMV90zepXZbsF4TFonw?=
 =?us-ascii?Q?9zznkLNmBAx2SvMlHs3tEI4pLDCJn9pOTwoTSInrzIBve1/jkH6ShfgBbdz/?=
 =?us-ascii?Q?CbKr64b+lCfQTusk8xrTa42a/xeR1i+bW5AwNCm6+D1sJRXEtJP8LGP8dFGX?=
 =?us-ascii?Q?sjHOjPE/qBeL5vpuwURRJklvI7PIkrvDhyLUjt7QsO+obm+KSuIhpe0ztFFa?=
 =?us-ascii?Q?yc8vjDHgIiQhFe+HPGSJ056mDflx+Gn8V/xBPgFTc3w/IQPiQZHnSQB/lDDC?=
 =?us-ascii?Q?ntFQOE9o6u+Vayacbaast0BAltJLGULdnQtqPBgDKTU4t4zOaxNr7yhXHiXV?=
 =?us-ascii?Q?r7x/sXYZK5r9d1kLwHNw4cvY/HfkD3WkXvhMTrIKcDnSjBaOZPORYj6DTWDJ?=
 =?us-ascii?Q?JWleew5vpSAHJGUDEMyJ6XvsJpS05IeNXQJlNKWnLEnpfl5BR2KkXo+oL3NW?=
 =?us-ascii?Q?wt9uyzXmETskis61HN+9r+JNZko7RVDboNmTQ1bEX+4lYGaCFXEJqt1xnbbG?=
 =?us-ascii?Q?GzvTS2uHhA3G01D84FnUu+399aeLZb5O/lZK+jGnGlS1h7AFV83LQETcANMf?=
 =?us-ascii?Q?sqW1NSwSEbk9SGQrxjjyhD+igBAT7qrG6bfnzWaB?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbcf7f7-dfe9-4617-0120-08dcdbaa6966
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:33:34.2880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7BhJDdn3YItu2fe0C2EkYCMaEUne0wRQEBapgNiO0KIoaLqYEWnf3PxagzVxxKISfNY52ljhmj1NxPFW2GVsfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6358

Fixed some confusing spelling errors, the details are as follows:

-in the code comments:
	wating		-> waiting
	succefully	-> successfully

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 fs/jffs2/gc.c        | 2 +-
 fs/jffs2/readinode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/gc.c b/fs/jffs2/gc.c
index 822949d0eb00..1b833bbffcf5 100644
--- a/fs/jffs2/gc.c
+++ b/fs/jffs2/gc.c
@@ -82,7 +82,7 @@ static struct jffs2_eraseblock *jffs2_find_gc_block(struct jffs2_sb_info *c)
 
 		nextlist = &c->erasable_list;
 	} else if (!list_empty(&c->erasable_pending_wbuf_list)) {
-		/* There are blocks are wating for the wbuf sync */
+		/* There are blocks are waiting for the wbuf sync */
 		jffs2_dbg(1, "Synching wbuf in order to reuse erasable_pending_wbuf_list blocks\n");
 		spin_unlock(&c->erase_completion_lock);
 		jffs2_flush_wbuf_pad(c);
diff --git a/fs/jffs2/readinode.c b/fs/jffs2/readinode.c
index 03b4f99614be..f987f78a894e 100644
--- a/fs/jffs2/readinode.c
+++ b/fs/jffs2/readinode.c
@@ -72,7 +72,7 @@ static int check_node_data(struct jffs2_sb_info *c, struct jffs2_tmp_dnode_info
 		if (err != -EOPNOTSUPP)
 			JFFS2_WARNING("MTD point failed: error code %d.\n", err);
 	} else
-		pointed = 1; /* succefully pointed to device */
+		pointed = 1; /* successfully pointed to device */
 #endif
 
 	if (!pointed) {
-- 
2.17.1


