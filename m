Return-Path: <linux-kernel+bounces-243129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A00192922A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF3B1C2119A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD204D599;
	Sat,  6 Jul 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="emjuXHve"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2079.outbound.protection.outlook.com [40.107.215.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA144C3D0
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 09:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720257415; cv=fail; b=N6//Z6pXpiyh6zpya9j2fOGaMTRMXZXGfyLzqkhREM4C3U9KhlZoyzWF7rxGb5QXyZmcgqO6fEOOJ5YXiHM+DJPyQgXje7m3Mv40fjd81FdeCu88y1fieRBiT9hwUd48Nvb9HOllv+UpryawSbxUKxwlk2lM0UMPWuY12K6ShcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720257415; c=relaxed/simple;
	bh=7YrBdxNjpEcrivp/hp7bbPmDqnd0XfEQUHa/wQ0YopU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j8mded//ZFZuo9ADU7zBIwTM6D5frZj/yWxZZRMX+3aWDDzIyDn8dQlS9fCFxtropmAB+zFWARdK9YCjoyrkf+9MmLhWHzhCael954XhYEWbOMAX18wX6NJiPcu0RtuiEymH0T4RuMKOGZPPMqdoKdis/2H+7ByJ+ReN8rvmKK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=emjuXHve; arc=fail smtp.client-ip=40.107.215.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf8JQfnQVdZnlfHmaU5pEAlhkRcPNMwLaZyF2IAe6C86GAmcrnlFMjJ8OQKs3t8pcjG1qyvFR4YHWLap6Ael7HoxEMK2q8BQrbSOYT7CRoqv6eVtvhrkfXPsHTzPn5/Ub8FFY8XIfX2OEd/j5ZiRPHACmLqhNQdJhaJKnrDVgbGQotI6RPYE53bF1WFkfLBLirkAqEuBni8uJ0tDFGFejHV2WUxMMCK1LjS0+D4aHyAfvqA97xoEH/LjAGkTobNR2sYSk+yo8stv/UXV1R1e4JEIvPfPDWcCvW9sN3FMjFArfEExDtA5ZChrH67krp/0zSiAenwoCAHZS2sYUlWIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr7eZ/umvFI0IK9ZzBZgID/XxpUUHRanXPRA45J0FEU=;
 b=ixh8/IT4E6U1H5OPS3sWgPEH83sA+MpxkShw83OzhN2KAdqff30t9c7qVGIFemLFvkR7lxStM239YpqTu9ROaD6b2jPFVn1/cVJpA+b6KGcAdMm6UABqNJ68oEeW1qXIFJjzuN36w3xKwclh/eyLpJ/nuC2qaglJwswWUHsB3vku7y5E+45Aia/Gpzbg2rdyK1rh2Iy28IOzUAKzZQ46H8KbdxO/MgfzEC/IFvH+TKPt51lJiVYN+RL4zPsxHD7YIOYuVKlrIPZuP6Ebk7/1FquHOAAYqsAbzSMcmX/DuzRCsWGs/p4jbUS88gmazYc5W/rkM8iCjleEmXO7Sa5Ymg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr7eZ/umvFI0IK9ZzBZgID/XxpUUHRanXPRA45J0FEU=;
 b=emjuXHveK+451Lt2dOdADeUoXC9W2rqCqTccMks6CcSWQqueKBVsXkHTZC8ubd/8ClwJqGBe1ER51QKqS9KgDoKZCo9cy3pIHFf9RLdks2k+TyM30mjb4LL2E50qOE4S+hCtbzSUp+e/ajzLR2kwGSFP0dyGoJIcvoZGTUnlzLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com (2603:1096:101:6b::10)
 by SI2PR02MB5516.apcprd02.prod.outlook.com (2603:1096:4:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Sat, 6 Jul
 2024 09:16:50 +0000
Received: from SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796]) by SEYPR02MB6014.apcprd02.prod.outlook.com
 ([fe80::bb06:c283:a50:7796%7]) with mapi id 15.20.7741.029; Sat, 6 Jul 2024
 09:16:50 +0000
From: Sheng Yong <shengyong@oppo.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Sheng Yong <shengyong@oppo.com>
Subject: [PATCH] f2fs: fix start segno of large section
Date: Sat,  6 Jul 2024 17:16:34 +0800
Message-Id: <20240706091634.1970874-1-shengyong@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SEYPR02MB6014.apcprd02.prod.outlook.com
 (2603:1096:101:6b::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR02MB6014:EE_|SI2PR02MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: f3dc83b9-a9c5-4deb-c331-08dc9d9c5e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0m/CugkZVU+lFjPw6Mg7h8ot3hJG1DlVB8lXSfS8qk9Wb/yGGHNUSZ73ydk5?=
 =?us-ascii?Q?w/i1l71eySMQh5s49aOxb7kGC16G7oFw9o3jJkEX0ktA35HcTU0AM3kWOPDY?=
 =?us-ascii?Q?KkzHJMWVD1NRKYlT8tDcbxex9EP5CJDOYqbJ+x9a9wsxD4ocvPUD324/tYbs?=
 =?us-ascii?Q?m9t0hDSPfPBkWc+YGWZ0+n0NtdlR9iv676czrngYfnCp/FrlLgwt3yvoRZoh?=
 =?us-ascii?Q?439sRHFFwWK6RSp7dy6YCgwTgBVTjcmh+3iZSLvg77U0AsOfExtk6x7MH4wd?=
 =?us-ascii?Q?9QhPt8IG2mGVK6g86SqO9Rj7VurE3ZyYSCsyn+/rPHea/mrkyjAAG9S8lL0E?=
 =?us-ascii?Q?sHlg6Yz9L6TzHsuCV/Tgo/Z3nh/Pi3DBpVgDtEtLMg16BiaxM2GzC0rT93Bw?=
 =?us-ascii?Q?A16vNMhVJ4GUQRaTnvPxG22HFj+DIyN/IaJeBrB5Ii2mhVr9SJxAuuo0mqCw?=
 =?us-ascii?Q?RqRZmVKui0UQlB2fKuWxWnEYUKmq6+/CZaskpZbxitnBph3ztf24lIeNaxLB?=
 =?us-ascii?Q?APOe+WbDCDbE6urWuTx5OhsyJpfJF6COr6iO3PUH0bWMGMTuW+tmsnsY8VnL?=
 =?us-ascii?Q?0niIieJuITfDMpyuexSNCsavZ/AvIh8zJf4speOeqVtLlxfUrwKo2HTPwoXh?=
 =?us-ascii?Q?rvM6CVQjF1NjpCHuUvdbVFFbXhweCBRV2pPbf6xEoilf7UZ0WHxl+0aZyUGq?=
 =?us-ascii?Q?vbYsMkAlPUYXlrFspS2U31sfHNQvJzjkCmisejzFx9On8m5lOp2Np+bAZ6at?=
 =?us-ascii?Q?jtrIEQdnYTq70AXSHDGTqmDB8bKzpdQizqPFYx6TM60KDar4l4somNluti+I?=
 =?us-ascii?Q?YbdbN7X+73n5cZRI4i3LobdjYbKiHXMF4xjWXP5NGn+LUZNNkaz0t/TO4zEg?=
 =?us-ascii?Q?AD1M5t4AMudUxy3Njn8gT1FOihc2OwmAlvPu6trkOrkITauDg07THNwgLah+?=
 =?us-ascii?Q?sbwKVy/dS+5SyS6hhJsRW+tKuR2iC33YqpYRsLs0ST6neyrleqg2Ouc9o8d1?=
 =?us-ascii?Q?xHHr2JoLUQ3Tlr58LnVh77QPfWYn8ZfGct9mRlKi+fvhPM8ptDLff9peY2i7?=
 =?us-ascii?Q?Lzxu+a6LdEKk2KAhEwVjJcmZytGxN4A+elkNGdVwQWM6KUtrTg3b7Il3rdRh?=
 =?us-ascii?Q?EfuP+T/XdLHvnxa+NsYd0FwRKyNTli0Am0FUoPglLbZO/5RwPyRVmaJ3BxXL?=
 =?us-ascii?Q?9PbRGSSZhM55P8MhsjH69PZri6CbK2cG0ZK7VevrZUmjJ1mUqCg2HXjoyba3?=
 =?us-ascii?Q?IpgUuu4Aron/J3QUDhrYYBhywdGVHKWHLr2TDAhty8nLcWmRhVLidr5g/QiD?=
 =?us-ascii?Q?fnPaBJeZorN5GRas7cAlxlWEgk+Wusl7Tyt59mKRUJDIhsWQzhumObOEUt0B?=
 =?us-ascii?Q?vKPhfyj4pykf2Im1tf19yFIYbM8nvEGLgpKsY5fXYQvFISvpfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6014.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLuhIzNn4/dI5hZns2nm1NeUd205L++8Nf+m4UQERMCPXzSY+LtU6nwGqmQY?=
 =?us-ascii?Q?rk1Wk5cLJHZBi6XFs52wFWrYCWEKRKJc1e3xpEeKhYsQqdryz7xjEZ5G1ymO?=
 =?us-ascii?Q?V2oGeT+J/qCJgB1xH8ZLVtBg5E9k3JCL5TR2SclS/9MO6RgZIvxXm2fbJkGX?=
 =?us-ascii?Q?lxUW8kqAttxk2rffhJ4JU3AdMQcImZ+hkzvLwBOeihVfY/tvjIQbeljh0qAp?=
 =?us-ascii?Q?0OZNTHXfarm9j4jdKcpIJwkJKp7ti4SfoEJhSmYWjPkvcQ387eKRamZ407L3?=
 =?us-ascii?Q?TX2wbn85OGRYV62M2Ll62UOJ5MC780beYyYWTgbdd0IzBpAfDJrkMpJSQnrt?=
 =?us-ascii?Q?gK3jg0EC85moWfCtLeQjJOyTnh2JiX7P4cPOOqAQqaXA6qP5BFldnJKIeIBi?=
 =?us-ascii?Q?bR3qkjZFFskUVzm2h8DZakEb/66x90P35LAIE33tdAqFA7/hY1DoxxA43MPV?=
 =?us-ascii?Q?VG0/6MU8L7exHczROVH3wrcQyBJY+3LrxRj+LmYt7wyB8xIltP8+M0sxIuis?=
 =?us-ascii?Q?sq0YjKWtEf6FPZmSwzXg2xAbf4GMI3cdh6BUTcfZAKKOTdEvWDcFrITH8z21?=
 =?us-ascii?Q?YyYIMBEnAwjBxxhPoJjEUl5+RagGrnRdOTAU7jjv612U3SiqdgUogSxgK/gD?=
 =?us-ascii?Q?/5fvR2thIxckeGOTk3lLAoxSk4c2XD4oQWwEDMqa29q0sp0DFl0bvaroB0fE?=
 =?us-ascii?Q?tNSoBn/xg6NSPITIQliOHZm7081PjUP07V0vGoAI12A/5JKnJywwIvrSn+g8?=
 =?us-ascii?Q?SK/nk0/CjAWZGULyPfmAeKd/zqhQoZof4KqMdQhXsmqRG7g5LYrs63IShYSC?=
 =?us-ascii?Q?Npw6dn4ejj06JidtSlosj/PNx+WcHhcNMKlwZQzb7Oi09w14TfkeaSKGbbTF?=
 =?us-ascii?Q?2gWFBnGWIry01SKPoZHoqrlW+8feky3vCx+nrDrf/E9XMYU2OKNDFpOihuE5?=
 =?us-ascii?Q?ARxG4X5NLzVzosoR2y50ghK4Y+RltZo22wk6TDILrKCQ+vc5uSBL/ktBLWs9?=
 =?us-ascii?Q?zlcPBvH1MAFMDtvSFHd7RALnl4zY9G9+x6ISfUvW4AXlMkzycQu6IzDqKpav?=
 =?us-ascii?Q?VICEDj1/KLzcg7GJFupIV8jLF3R7w/9Cn8zs7J23oBEJTSWnwizI9dSKzucO?=
 =?us-ascii?Q?FeSPT+jcsHxIV1WfB+kH4zyZzCAmWvJns+6v6Ae91AbXaFPX47HEIJwG8stG?=
 =?us-ascii?Q?HW2kCaBAGEThpqH/bd32kD9AD/8FZMlxRWqIysX6f7tMhXu1gdtkQFuuBzdc?=
 =?us-ascii?Q?XrrzANgeGfQQB3dWRkJmIadcMpWvB0Q/AgKcF6jXh5sKvuLHIhYWRDOkXqx1?=
 =?us-ascii?Q?fSySxeuN/DNdiS6R3Jvsmjjhk0IiWvLSFPIon28Aa/SasYSFO76i+OQIuaZ8?=
 =?us-ascii?Q?EzMGarZEp//nGTT35mKoW/AeDoDoBtVoahvg3LOclCqEu0iaQQ12TyJWLGNq?=
 =?us-ascii?Q?PRx9Jo/eTvS2bs2NBj8H7D9HnvPqqeWQSEdohjoZYyq8FCOxZfP/N438ZMwf?=
 =?us-ascii?Q?Fq0OEgEFr0O4vEtNQmwkxMAQAq2wFGogZ/zHsM2tME9HpEUx8iTYDg41LdDv?=
 =?us-ascii?Q?yhnBT/0a5BuaTRvZWqmNrP8HueYUXqlgCKq9lBr9?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3dc83b9-a9c5-4deb-c331-08dc9d9c5e12
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6014.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2024 09:16:50.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2LFMH+LlWgoESV4HjamyR9Mkrc7m14gmpnNgJWRy1UU9H8rrNYnQwPwOkc0NOVPF4W0blPAyDhvjFqLW2MostA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5516

get_ckpt_valid_blocks() checks valid ckpt blocks in current section.
It counts all vblocks from the first to the last segment in the
large section. However, START_SEGNO() is used to get the first segno
in an SIT block. This patch fixes that to get the correct start segno.

Fixes: 61461fc921b7 ("f2fs: fix to avoid touching checkpointed data in get_victim()")
Signed-off-by: Sheng Yong <shengyong@oppo.com>
---
 fs/f2fs/segment.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index e1c0f418aa11..6ed5bc811d2c 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -347,7 +347,8 @@ static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
 				unsigned int segno, bool use_section)
 {
 	if (use_section && __is_large_section(sbi)) {
-		unsigned int start_segno = START_SEGNO(segno);
+		unsigned int start_segno = segno / SEGS_PER_SEC(sbi) *
+							SEGS_PER_SEC(sbi);
 		unsigned int blocks = 0;
 		int i;
 
-- 
2.40.1


