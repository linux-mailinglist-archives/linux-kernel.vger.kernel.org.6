Return-Path: <linux-kernel+bounces-405435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3819C5154
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDBCB23DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C45B20C00D;
	Tue, 12 Nov 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pRx0hkJD"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2043.outbound.protection.outlook.com [40.107.255.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC720BB48
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731401873; cv=fail; b=DpkfQxzh8hoC5R66YWxV1Z8I5WZ+ffzjph27IbUsEon3vGmfXEFAS2/FvGZQgE6EgVCQPslKiDAu3MhEm5BbsVEGio8oEnHKs0/+/GeJnTGwejH9RMtrzjJQYdSB4l3NF9umAF3VYA5s8PPmuVyLMxHLQA7DHQA7qq3VFrvwH0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731401873; c=relaxed/simple;
	bh=6nEMVpPDNp3Ovu8kzTZCMOFCWs8kWiKCv8W4deelwG4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EKnw3r1wIW9j5fq20aF0PukQ53/lnGabxO5xpc6oLttQ0k97ylx3tPqB04LKPUkkNj9wlsuQWiUgAr8+GKSprSNuCkbUMdF1MymzW+zReZgO0m/hrr5Xx6ksmOnjHxwVwI3t6sLQpeNO85yMrjn6nqp0tFbjxgxuFLHCIAP/JMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pRx0hkJD; arc=fail smtp.client-ip=40.107.255.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2VLKgvwSe+kUsjXV58WxXMVsMaeNAMrY66KtqbyM0BgM79xR8E6/1p+oNIYBCbYo2YbYqIGtTad+XTUj4P3KR6DgTDJY2O51oIkUC9ZsWD5a1Jjbe3GI9V7DCE5tNtFwX3+yxtkGPyC5+Q123SPuq2U6WeUCfDyQJuY847eBF8aGGe+9oz+u77n2Yv4I28mAj7Zbokyix+ghhKP7PVj6UScSP8yIlZDfZWlXjWpvU4wsggP4+oYSxJZO9knYT4swoWEBcOOpniT9La1qDs5RfuQDwctpglwmoJsWOg3Y1W+C9SW/uZpqiWK8sgLXOc3FHfhM6gTyxvh57sQ86APDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24ZOW0JU3Sad33+xS6L1LE1wp9c1QdTX19KQJR9Yy4s=;
 b=Tjiupx7RnM2f9xhdJY5Lz0jA3vA3vdACzBbGR61EsCdqoCcbN4AGESBGMU9XmLSr3+6kSR+4XSY/ZBpuGicQh64jo/l3tMhn/uxFm/2coegnu+T9MOwCT/oMxnLUWgIyoJtUrrtFLRjA3MsCey4jcsyYEdnbtfzkv/1IwYmTKesWQQAtIfhIAh+9luoeboPBxvM2Od7dDAvdjbN1bPRBH/jt3Aj1KkkpfUOpSornEBe13dUNmsJ3S+lT/KGLrpgjO4zmaausE7+cCMMK5X8S8dqd7WZEr292PAEizkROOorJqblJjsqpeYUD+tEwdfny8NbthfH/ajhVJs0rFh/OTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24ZOW0JU3Sad33+xS6L1LE1wp9c1QdTX19KQJR9Yy4s=;
 b=pRx0hkJD4Qy1Qpkuk3PRn54uT2JPpd6SxNUwBQFDJJDfznf6ll3KvA8zeqfM0A0dqiwv5F3uckepKFYKd32H+Xb2Ws3ci1c/IYWBxegHtpsJ1XOot4TJetJTJSgKanaBVG5Ff1ZpnZ4ECbk0VLo5nJmDPuvsCOU3aGR7e4QTuyh/HykMjQsRXEISkkagY5rFyrLAUxr/LmKHoTtMcW3QYQv/NyzRr9kG3ir7Dg7+zhlMP0ds+C4rbrTBQtC4xVwTAhjNie5ijFMyHWtuvsIx2oc72ZbukS4DcyxdlDGxM4Tq3Ycf0xxUIrVcdcrb4Fc5lSlX8dcWAzEq5LLAbNrqCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com (2603:1096:405:b5::13)
 by SEYPR06MB6661.apcprd06.prod.outlook.com (2603:1096:101:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Tue, 12 Nov
 2024 08:57:39 +0000
Received: from TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b]) by TYZPR06MB7096.apcprd06.prod.outlook.com
 ([fe80::6c3a:9f76:c4a5:c2b%6]) with mapi id 15.20.8158.011; Tue, 12 Nov 2024
 08:57:39 +0000
From: Chunhai Guo <guochunhai@vivo.com>
To: xiang@kernel.org
Cc: chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com,
	dhavale@google.com,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Chunhai Guo <guochunhai@vivo.com>
Subject: [PATCH] erofs: add sysfs node to drop all compression-related caches
Date: Tue, 12 Nov 2024 02:14:03 -0700
Message-Id: <20241112091403.586545-1-guochunhai@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To TYZPR06MB7096.apcprd06.prod.outlook.com
 (2603:1096:405:b5::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB7096:EE_|SEYPR06MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f98fa1f-48e2-4aee-0f61-08dd02f80f93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Kjpyz0x5A5MqfFolAdcyxSMv6M41A4KEBt9ykzASQfLxKg5T1vVbPmMk5EF?=
 =?us-ascii?Q?oM0/+zjmmKxEVxc6Nf3aMiWJDgWv5ClsWJIF0e1VhKe4cE6chyfh0reCW8en?=
 =?us-ascii?Q?ucIrzze4rdUkN89WZX11PfIKFBVAoyaSZSTEJjQ7m4rA7Pp3gm5Setcbj7Mb?=
 =?us-ascii?Q?q3bHE4KwCEKhRKPCeCzFO83Kq/Q7Q2oIaPoIJL3Vobxb22z4iymy0Hhhnyfw?=
 =?us-ascii?Q?XqAzxOVc7KihqTiMkbQZK6qHTZUKJQaqXnbN1hEn/KjITvV5pfiHJTYUwthn?=
 =?us-ascii?Q?1OPMAa+XW974P20mY2OQRf9qxCWAG4XQ1oHNlUWNIjx7xESj52LGf2v8CWYT?=
 =?us-ascii?Q?Sm3NS/ombHNmve/le5oC2JizQUIJecPLliE4xPBgJNaoSXtx6ePhvmtz8ixn?=
 =?us-ascii?Q?t53QmQANUjHNsO6OwFNPJvMDhsxiJgx1b3005+0jegXCpNPW8vztozG+oouS?=
 =?us-ascii?Q?nMDlT1sJ+8XFa2H7+tj5ASdTR6NhIYr2FTt+xlCp8TUCY11S5dLcqlcvVdlr?=
 =?us-ascii?Q?ZTwLKb2kIWpaa3tXIfI33mKwOL5g13wlLCv2dJmmhymkBkmsleACGXPYdqiF?=
 =?us-ascii?Q?N7tnCtCW/dFomF16EB6jrsTbNVJrTCBOBPleP8ny4ks53XV/wKhGWck2L1rm?=
 =?us-ascii?Q?s1mp5zVpzQdGvlnXJEWAq75iMJSMpAiTQ71uy43NfntcltK4Pjsdfy3pybJR?=
 =?us-ascii?Q?R8mbTYinfrQeU4Y7IKBaRLjD3Qc+z1rPDUzgXbWUuUifNSGuKtMXcUDxJBfw?=
 =?us-ascii?Q?GATlzagH/Os7r+4wXV567K1Hr9FmUeZsRqgB38itA2rr5yMftYSpJtSovNJA?=
 =?us-ascii?Q?fd4V4525N9JR8mqX5d4H3ea6BB19grB0mraRyuNWACzbZhGU7MQ0BGJq9Aa9?=
 =?us-ascii?Q?y67F9sew3VCkg50O2YN4MRjB0P66bKJ4zaWeGbffc/xBPz4K74JPVddynNZG?=
 =?us-ascii?Q?ZOdcxQjMEFdvxDJV/QD/gFTgRjURpFqCwyrvlmmOGXOZMlNLzU9Hkqmk8jZd?=
 =?us-ascii?Q?bX1qugUUTKd6wCUIGuseyEe+OoKRop0t8/tKLO7IQDbhMjAx6dX0Yfou8mN2?=
 =?us-ascii?Q?ck3SPn9cqLWRxT0h75W/usZ+6F04cIJfT2d0E3ilhGBwiIfOaHIA+onI+La6?=
 =?us-ascii?Q?4ho0noQ4bAiqo8bY34jW38EiKdRTeLvPOGvGHmoUJfDrF77c4GBN9wCHgJzB?=
 =?us-ascii?Q?LG5NFB1fJwGBUnWSG4ikNrO1WD0sf+SvD3AR5NGKz7SpKfKapVR+RLko0Xhb?=
 =?us-ascii?Q?S5GWrRSKgv1xUk+xoCSyJy+fYZkqYC2rLVu5hUjFZn3WYwCXfu62qoz+Otvx?=
 =?us-ascii?Q?qb9/+xoVkP8piG67KihAnliR/Nj46v9JiUwZgWOLecapoSfUITqMSR9GqjQn?=
 =?us-ascii?Q?aR00lus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB7096.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCJXjDkroxk8CvMxIC8nd+1McmcqZeRjkY7kbu9cLfrchuqTleYagl6TcF2T?=
 =?us-ascii?Q?8l7z0MC1MUi502mZ+my3+CBFc1pHNnJ4oAMkL4VD3DBDj79cX3/q1a6Vmd/V?=
 =?us-ascii?Q?2qyBPULTjhd1UknkDhwKYvAeS2BdabRtaLKY6R9d+9j1u/nGnQub4J6PfQ8S?=
 =?us-ascii?Q?wcXfxNQzBfBz2DQ615t1qa0w8FoVzidYwGuXch2oSM29sDRt99yBot2wdGYd?=
 =?us-ascii?Q?Ugnbq/FM9KLDT62irSpCcUjxM09BAS1ndVOzP2ERZzRgOBYjFv06RHT9WTmN?=
 =?us-ascii?Q?VlqFdMf2jEiuwFS+s2rnD7VqFha22mQ+MFDOryQJ//j9kEKYhNUa3SeaD+Ka?=
 =?us-ascii?Q?qBBc/+Gy99BOIsjRAZqDfszZQHO9aUAmQYurcR2JvfTwdaVAW8pZkPcF9I5A?=
 =?us-ascii?Q?fZwKklUiGQdXYFdOhP50vGofNsY4awI1sa03jH8ULeT+Qgc7KV2R2vrkQ4sO?=
 =?us-ascii?Q?xnTClTcrRjbhdmEeccE/J0IfiS0d5WloMIlPRTktkWt5zA1wECfjprbxn0MB?=
 =?us-ascii?Q?JfPD8sNpl8fcjVzDpvoDsIfHGh3JBHLM/H8RIIW8Ro1jdmaXRdPXkID0YAMU?=
 =?us-ascii?Q?SBIYXCBaWigbVyznZRgL+NcPFI8KJiNZQRbbXKVoS5yI9nlLhq3Cv5Rzwsdb?=
 =?us-ascii?Q?E6huWJdM0IkktX6As/vHMaFdJWpoXGN5w7tL4a5trXLXgvzbqq0TfBBNoMZU?=
 =?us-ascii?Q?FZgcThRXEkwR8owcfF72lMiZR2Ngz8UlWE5S6SwE+HRCBBlXkSBHYjU1bLx/?=
 =?us-ascii?Q?yrtY3XNVLXnd6ObFaOIFkMiOfVMVAAepuC4TuBoBiqo/FqVNKKln3PsOmgGw?=
 =?us-ascii?Q?AW+aXz/btakXJedhvMAD1S1/I2eUI1bKn0hGNc/fytvWbZx3bx35vGkw+N74?=
 =?us-ascii?Q?Hg1XRCXc/2wp+Xh1ITosLyVDN44y3NC4+dXUuC3u3gPVzeGm+uJGrsa5sl/Y?=
 =?us-ascii?Q?7lvcCIEtwGJmFXaDuRYUaGBF0io4PI723VpYs6k5qngYqwQYXh6wezwBjztS?=
 =?us-ascii?Q?h8rz6+an3hAzDD9+6u7uhbPAyNzLhDTitx/X07R0zMgfrdmhzGDJkOFZHQSP?=
 =?us-ascii?Q?guKwWUVJKGwUMmlGfSlfMuDRtJaxJYZtXyiwqGnUbMQ3K9FKF1hSFdksRqmk?=
 =?us-ascii?Q?2ZczfS9FFFcOiYY45jrTx7Roy0VevIgVOGbK6sHawDwDV5d/wEK533n7Bhfu?=
 =?us-ascii?Q?wTB6MgPPkSCdRduaRNuFJaJXGy5qyTsj9uzgYn5o9GsO8+NIO0EQAmqV2rcT?=
 =?us-ascii?Q?k/jFHbF74mnayFlryOQpOPbzEv+9ECQYqkSEz6J/8z8sO2pGJ06H6d5tNUWX?=
 =?us-ascii?Q?TTDtR2XGoKndBa66qyg5RdpCyhxtwpstJhfKeCxv0P/1BAXyvU48po/vhgxX?=
 =?us-ascii?Q?6cCJ3sTAoJB5SZYavN62Kx1t4DTIaSuSqxsnEpZYYpaSaqKtpCEjQnPHo8nJ?=
 =?us-ascii?Q?CfaRdsVr96Hpx4nBpwx5SE4Zdi9js+1lb7q1O6cM6g5IhGUlCiKBSIWLE5jP?=
 =?us-ascii?Q?EQ3z2QJPco5bh+qw9aSJlr68bqLqk1OYBRaNj/U/+Syb/PAv7gMssQMl9vvV?=
 =?us-ascii?Q?YxTyFc5+iyxzw9mfdDqQLsxsGleNpPk4sZDSiKpm?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f98fa1f-48e2-4aee-0f61-08dd02f80f93
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7096.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:57:39.5149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQbCPOTRxgR6qlvck3jN8ahdhV5plRJA1hAI5BGcLl2Wf6RTNC+o3hXSP3uI1BYA4gYAGLPAA1v6xoPI+63w/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6661

Add a sysfs node to drop all compression-related caches, including
pclusters and attached compressed pages.

Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs |  7 +++++++
 fs/erofs/sysfs.c                         | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 284224d1b56f..b66a3f6d3fdf 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -16,3 +16,10 @@ Description:	Control strategy of sync decompression:
 		  readahead on atomic contexts only.
 		- 1 (force on): enable for readpage and readahead.
 		- 2 (force off): disable for all situations.
+
+What:		/sys/fs/erofs/<disk>/drop_caches
+Date:		November 2024
+Contact:	"Guo Chunhai" <guochunhai@vivo.com>
+Description:	Writing 1 to this will cause the erofs to drop all
+		compression-related caches, including pclusters and attached
+		compressed pages. Any other value is invalid.
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 63cffd0fd261..f068f01437d5 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -10,6 +10,7 @@
 
 enum {
 	attr_feature,
+	attr_drop_caches,
 	attr_pointer_ui,
 	attr_pointer_bool,
 };
@@ -57,11 +58,13 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #ifdef CONFIG_EROFS_FS_ZIP
 EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+EROFS_ATTR_FUNC(drop_caches, 0200);
 #endif
 
 static struct attribute *erofs_attrs[] = {
 #ifdef CONFIG_EROFS_FS_ZIP
 	ATTR_LIST(sync_decompress),
+	ATTR_LIST(drop_caches),
 #endif
 	NULL,
 };
@@ -163,6 +166,14 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return -EINVAL;
 		*(bool *)ptr = !!t;
 		return len;
+	case attr_drop_caches:
+		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		if (ret)
+			return ret;
+		if (t != 1)
+			return -EINVAL;
+		z_erofs_shrink_scan(sbi, ~0UL);
+		return len;
 	}
 	return 0;
 }
-- 
2.34.1


