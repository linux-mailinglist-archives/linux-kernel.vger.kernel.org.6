Return-Path: <linux-kernel+bounces-403747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F09C3A10
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 09:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A5B28132B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DC216EBEE;
	Mon, 11 Nov 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="udCEJqrp"
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011070.outbound.protection.outlook.com [52.101.129.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0341A15B14B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315115; cv=fail; b=D+C02Z/bkAXOzlwGeTTUMn3K+CTnBdbkgfQHslzEYwUm65NnnRY+3ORjbgh/TO2RUSVGRwRhBnhFsYNoGL8azvzzTh3lhVJQDgoDVqTMEF6OVILj3odvtL0xf7NO5QL3ZQXeonZx8tzYxrtaPsDx2szx8a41M0yGxHSdew1KNCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315115; c=relaxed/simple;
	bh=l2HYRe1yOcyFlJEfgKWo298ZfPJ9/4YR7N0v3e9UBQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h11XiXg/3JjtTIs67jJzIVBfhZMF4MvMR7VJeteogHr7gE+7Z4T9aGUeQyVAqvR4ychd4kzIbozJPo9fsCvejqgHaPfXYQ+woBJXg0K3zt2X4isSnf4E00oLlrycpdpHgng7w9pks+5lSnVhbhTz4MUq7/oE52pwLeycMZkxfmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=udCEJqrp; arc=fail smtp.client-ip=52.101.129.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlGMTv26N1DukiRkuFl1o9U6hHynLOYTiFlgftz7uu9Ohe6j7WQjTy6yeOoZBAIZBKKet4+szupQ3C2WkgWDieBqJibaSFmoqXiJzcRyXnhBIixH+/G5ZFLgql6yaOtTMiVf91ppNAoTJ/va/ELPv0xQEOvX8pOZNqSv+R9Da4V0fbdvwkXpeMeshsdYowHB156/DOFn3Lgnib52hFm5hGJuW5whSWni7Mfxkwmvu1raw3jmeonCWinKMGgLzyalKHu+WxovZwfUTfdAnuCywrtP6xpw5//QSfLtlCA21/9AaD2oXd5XODcCEt12vyNJXh9fHK5waQc/ytIxv31e0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDc9TMGqj+jM3iAPfV5e8BYjhJJ6uyivPzzFrMvJmv4=;
 b=VF1NQi8NLxIUfXy+Lclk+nEVrBQz0uaKB05A3bOqmKG48xEF15MchR3o7F6d13E7yjIdy3s0MZbmnIxsTA7WGfTlNqeiVWT2PAe/+zBQM2nJQlomEC34rPuearVu80Z9OYooXE+Tibq31PQwwjduCJiMaj3SN6zy4s6sPlSV44ZTpVSERhtFqAAnnUB5fBbPOtdMBXvsyjW09T1NCBa6DU+5QmhPpqT63HZNY/qo4/w/fddajLK0Dl/LaMs0rFurQNcX2V6Rzv8LilYHUyUXyZF2kxEwlNwlm3Q5CgTplxxJ+U+H5o6cbgvtm9x+7T0ciKQC8gk0lk4VUPflEC/YEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDc9TMGqj+jM3iAPfV5e8BYjhJJ6uyivPzzFrMvJmv4=;
 b=udCEJqrp6SXrSwIB/iSfpEAWLLYzAjQhLskuST1mtks3vjK/H6AaFsIGya4N0mbafDo4UpG2xWU9/SVraJQI9GPllUSI6VvYsf+tlk0Ql8Vmp/U7mLqWCM+jtzgBGDlEpkX8xXZhC3Q4r7H8RjBe+NFHbBWkebJAyianpVmnZAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by TYZPR02MB7393.apcprd02.prod.outlook.com (2603:1096:405:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 08:51:51 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%7]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 08:51:51 +0000
From: Sheng Yong <shengyong@oppo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>,
	Song Feng <songfeng@oppo.com>,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH 2/2] f2fs: clear SBI_POR_DOING before initing inmem curseg
Date: Mon, 11 Nov 2024 16:50:58 +0800
Message-Id: <20241111085058.4136077-2-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241111085058.4136077-1-shengyong@oppo.com>
References: <20241111085058.4136077-1-shengyong@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|TYZPR02MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: 2441200c-3616-4e13-163e-08dd022e1560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3CCmO/MHuaDsoC6b8RXD2zCGeQuHNp5+pt0VMdbne7LUC8zCmTxbvoXtld5g?=
 =?us-ascii?Q?ZR7NRirmPcnDPd5/TV/uTiyo2l/H1gTJGrfk96zUo63tZzK2cWukFUhH9nwP?=
 =?us-ascii?Q?m1KZg80HK6mP5Wnkh7R3CBCEfmkqYbl+n646Cf8+AsrbEDKwokVxzyxvdNJT?=
 =?us-ascii?Q?Zi5jolcXkTnIAT1CSiIX/0NxvYWIILmw+N5BA+hjwO1J3TH8qy+zmfh96sSf?=
 =?us-ascii?Q?AbYc4GusoMfIHm5uv3BPYIFxBIadR957N5N9d0I6AF2IsIixWvulaVXQqV9l?=
 =?us-ascii?Q?L2b0rckwXiWQNs+p7l3fcLkda1YcqE7yT7xOyhCD44/ib3kQCV7+OjeQ7wBC?=
 =?us-ascii?Q?9GAeCQEFG1/dgoI0MTdI2Uk9b/+qc/mnpojr5e/Af+2N0UMloizEP+h7ZYq/?=
 =?us-ascii?Q?hhEzOlEd/JEUyyVxznvLXi1zxFGYPj0O7MT2UkCXlAhFlan+YoLGV8epTZ2/?=
 =?us-ascii?Q?tyY1tl8csEbjKwtfM5AdFhVgfrJZr/jufv4HQMSqmGo8RSI0dOtpuFE7oAkR?=
 =?us-ascii?Q?BgAPztR7LyX/3NFdIpB26w5cuBmf4HnHNaCWLBtBCrGeNqpHRc+gCjwSi5Za?=
 =?us-ascii?Q?aJUdMp9wxLxPANMJtscpI0+aCH6FZi2JnxIKvLWInhjkM9j9BUyopxKdZq1a?=
 =?us-ascii?Q?nywcsEW0U21xWB6gpglcAznupehZO79PLO5JKuTSxyCr6riXgUFabFEHru6r?=
 =?us-ascii?Q?1BW0kAt7yQo3bd05oDWpn8YFBSyVANDA5Wlbw0sMiLFQis6gY1mMCJs2XMKO?=
 =?us-ascii?Q?D2VmtaDvhKQZDZbnqORy8jE5MEvyeZARU6mJkSi5bA/6RNcfp0nfXD4y/Guu?=
 =?us-ascii?Q?KS93FA1ZOgD2PcvRyCcDj/AnuWyYa5miFnkEkI49RH+ftjLndFX9w5JDVBgr?=
 =?us-ascii?Q?LqfZK2zUomofJYF0bPo5NwmpAhvJDWtnfWOHRZi6QAcbrP5/RWUIZNh8ToNl?=
 =?us-ascii?Q?wFhdUTrqacB5mCiQmWxecFwttbe7355S+IVAB34IjqqvX2votNlGVioQRw6o?=
 =?us-ascii?Q?qgs4RKs/a5+OjEEWGqgoxDLjhJVj+kieuxYxWekHzUfoCgqF7G5Izi4oGO8M?=
 =?us-ascii?Q?/xlb7JfKK3uNE/nFKjy32Jhx86Xr5BdaU8QmXj4bZrnFHgb2Q/957/Gsf2kt?=
 =?us-ascii?Q?afHpMB7VKrZ3DqYo+62fmVXSsSXKEpED+E5vITapfalh4zPjFbeyg+qxJjzj?=
 =?us-ascii?Q?6kNMnEhe9AmqPqvFD2FPUf6kdt1HSRGDxXWnoRDPr/+eCtw1hgNozrtvbATx?=
 =?us-ascii?Q?ruVvMZUxH+2ioyQGuJ6ESMi86KJvMCjYX7akIAy1qFfdSfETCf3u9+qt/aD3?=
 =?us-ascii?Q?19NYpV9eLp/m6Ej80E2JxCRUW/ewatVBf/3P6OyO21abBgfqq5iBBht5M51g?=
 =?us-ascii?Q?m9PTcg0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hgBik2bP1X4YYg6pYeyq27Gyl92ufjIsuFApEyuQWS52wNEscvpF1feQ4iz?=
 =?us-ascii?Q?hpXO+/G8Hb28QlVmfYv+NYy6jjmu+hZo1yWzatHs3SeCw+Awj5nXh9FA3lKR?=
 =?us-ascii?Q?2AQVOuAYSs10+bWY9in4T7l7OXFCxwg3PJtfszoNmNeM5dXAPvdLl1Qoxcjl?=
 =?us-ascii?Q?GjlNx42xNIiGguuZiBkQtDsdscZ8btdJQyCFgbviKeswpxoYWRc4PmmpJb/z?=
 =?us-ascii?Q?vSnOgpxFXj21K4COI811aeB5cyVFpg7hXY5FvMBR4vyn6AHUwNvFkehuWpVc?=
 =?us-ascii?Q?cw3vjn17rSEEIBc2RhmKJ9C4eRHaUElod6V//SWWjpA774DxMW8bSzQMwp3W?=
 =?us-ascii?Q?CTD5H+xJEQ3V9Z/SuMsuuTyrsdG6XvrZWyRQcmdd+e4ttCX2bxRktior04bo?=
 =?us-ascii?Q?8Rd+9jK0pAPcq3DkpTEXnHR+vV1a7lfetg2MhS/MWlsaGIdpu1WMl+/+cuou?=
 =?us-ascii?Q?C/r/I96b9HxE9909kyZDqq9PCll4f923f2vK2Y0PpFyb5AEqwCOcF3hBwR2x?=
 =?us-ascii?Q?poKebC32E89rzDgrBQZH08zy4JySIAutcZER914CitEiEC+2Q6RC43doxQ1r?=
 =?us-ascii?Q?n7KEYnFKk4nBK6e7m31B+NroYEXRSY9WJU8Cwigt2lbYusaKHU1KG1wjVo4S?=
 =?us-ascii?Q?NJnp+U/NlgQAyCIGfg+bqnz5uhPF9/duMDw5J8gLQ1ev3IfSI+erIxGye2rz?=
 =?us-ascii?Q?1UYN3astYvBtfDsepypCnilJ1XDow0nNb8ezD0Uo2IdIgj6SyPLYMrU9fc9I?=
 =?us-ascii?Q?K4NgSVW42/j4KK4K+tmw/hlL/rwr6qyBAB87aKYjCldtVcqrryu0SN8Uhm89?=
 =?us-ascii?Q?TTBVq1K5DrUcMw9U/2nQ5ZtkwXTOcfwu3dScjFZvggNe/JGu7fzHxNpnt/ZX?=
 =?us-ascii?Q?/RckwvLo/itpco+QN3Glu8a3ky9LX8ATFi//IdN0SmxDjYLieiZ98nepLBJf?=
 =?us-ascii?Q?6RfmuZ367p2edWNakyplNqz1lPaEwLy8EMD1jFePq0RK9fekpG2bnFioR6sV?=
 =?us-ascii?Q?qxwVQ03S8jKN7nk3mxDgcjRlWu1Ii93rmpB8wg0Ii1bo6bf2uZ031L+uhVJj?=
 =?us-ascii?Q?sG663gpDeYkvGxYgovusiO8BRikQhMLMII4/XlqlwalewgyBQr9fXXDKb6+g?=
 =?us-ascii?Q?EuUBmItccU/YGc3yf4V3Cg8qKLVT9bjQQ0H5XhkSlZaaRs5ss2yHGnhrpDVj?=
 =?us-ascii?Q?i/k31Q3F3CFIA+SOCPuq2/hdCIP5r3e350Ky89z3GYs/HdhTBvnl2HyYp6TO?=
 =?us-ascii?Q?ZkG14KiNIbes1U0UK+jkmL/Yiwvk7NJ0nIav5GUV2SeQyJfd6bWwRDC228y9?=
 =?us-ascii?Q?AZ2yNs5bj+bICIzqhJz/XJ48m00zWiIo5KS1QMKJzhH3Q2pgK7WP70K1REF+?=
 =?us-ascii?Q?F0CsWOnVdx+Es6A0WT1KbCt55W2HZAGnJh/QvbqJ3v5nQXjDkgW2tW8NklYc?=
 =?us-ascii?Q?5BNk7S7OZ3euuhsf9Rj+p7HpK8kusnaJVyZEsHkiW+HDynvk2YfcsLYtFIVV?=
 =?us-ascii?Q?o7Ww0XRHp223ru5v1CZdAxN6bUsRgIcH/QQsEkNAUFHQay6ElkNj093OBYuq?=
 =?us-ascii?Q?TuFRtVUti2hH/Jf6Grsn6L4e83geNtiKMoAKiU83?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2441200c-3616-4e13-163e-08dd022e1560
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 08:51:50.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tE6ZC4yJ+6u75R3hCovFS4V4ApjcW4J7pk4VXRtrDF/48amrIDhXmodOwnfO3em8FiwSV6CvGKkhbQqmH7uboA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB7393

SBI_POR_DOING can be cleared after recovery is completed, so that
changes made before recovery can be persistent, and subsequent
errors can be recorded into cp/sb.

Signed-off-by: Song Feng <songfeng@oppo.com>
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 42224c71ae20..92e93899c033 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4756,13 +4756,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	if (err)
 		goto free_meta;
 
+	/* f2fs_recover_fsync_data() cleared this already */
+	clear_sbi_flag(sbi, SBI_POR_DOING);
+
 	err = f2fs_init_inmem_curseg(sbi);
 	if (err)
 		goto sync_free_meta;
 
-	/* f2fs_recover_fsync_data() cleared this already */
-	clear_sbi_flag(sbi, SBI_POR_DOING);
-
 	if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = f2fs_disable_checkpoint(sbi);
 		if (err)
-- 
2.40.1


