Return-Path: <linux-kernel+bounces-257911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C1F9380BF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B79428172C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A857829C;
	Sat, 20 Jul 2024 10:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="uyJ8AaST"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2047.outbound.protection.outlook.com [40.107.255.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0A9449
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721471663; cv=fail; b=PyP8rn1DQ9AWYr2Lj8vz5gpt4EVHO2icMgLEOUQMA/KUfSc8wuR88zfF6fY0TvsP8WaeZKkVDlzzo1jWH9HXxEyv/MKpJVVH+yeq4Asdx0YAGoy7XY1bcvvRw0DhIGjVd5HPDb46Wo/AIf1YfDeOVxWgclOlfzJMGuXC7LLV9ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721471663; c=relaxed/simple;
	bh=qcHldZGw811tEbtgcWD2yfA/HH//7QlYBC91tWCUzkk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=X+jR0iOVTKNxtsz7uXlJxVxRO9xfhOwhIFMQIMbArxgf4JapD0MX/tNqVozAq+mehjQa8Yf6t499Y19qggTMhvPKqutp+ujRV3HDgLXKa7h/CARoNSdcQMw1ygsrh1fxuS2bd7+mV164UONwoemSk5T8BdtRbV8Dy4WKhRkItqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=uyJ8AaST; arc=fail smtp.client-ip=40.107.255.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfseHttwX6JO+iGqBgOASwTLQHJNGdGKrP4kEc0PnMCkyYkizpS71ZXROsUFEblmdGxMFAhD8r5MhjwHivuZ1x7byqUjYqwT41xk0Btn3zSaNbPbG4is8oQnMt4Iui+5LJuxGAagxLG7wX0dc9h2+c8lNTpLKjVz56g432kiHOe1A+S9v80sXTia3aVJyjHdj+mC98hyBLzSCOkASFnNKdnUTqIvkunmZcJgbCeMQ+y1lrJDh/n4RmK0vDntX8bCzAZphGtBrsvFRnuy+LEbu7UiDBkvfeB97kz3z1AgOdWXUn0L7Sl1gHFR1i4CK3YJ8CcOsxmWp4RmIgFj+dlpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+CcTzxFnSc0blY69GjJxpN+CCB0nM3YiiWH2jUP8rY=;
 b=T8m0v6c/pB0K4rz4/3Pmh2dKxOBxwq5b4PLNUQOktk4mlku8bLVFJoWGr+p1kdZZt0f2G+CAU9hrMcRcjr1H7NdxXOIjTq3VpOn1TtDA2xYK+qDY3BclVuvcRM+t/pXbFk/XNQlCHJ6U666LGCdDdqEOPRk/J/b5r6LbO5Nk6mrWZ7AfslRW84dyiaOvfCxAs3BqhfKxo0lw95O78BkIyudYdsPKExehx2UzXr60WsstFjZug3qbu3Lz1zW8FueUu78UQ1Denono41It/bgG5jb5TtFNHpFkWqt7HmDMOCNKoaZH1MjxVL3iyGuUPN5zTHcJ543nIdMx0QnmEPAdXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+CcTzxFnSc0blY69GjJxpN+CCB0nM3YiiWH2jUP8rY=;
 b=uyJ8AaSTWXp2i/Qg/2yyTIkSPZBtpV3bTrqpCOjC0GUaVBdiGiBEE91PyDJSrNdOfU7jQypvyRZ9pMN9TKq651NaSY/5gqQz5OawEVPnbkAPlrEOyaRj48jMvzrsDl84pPINoZ0GeJuwp2xlps2JRU40hqWVrvQLQgW8KOrNlzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by SG2PR02MB5652.apcprd02.prod.outlook.com (2603:1096:4:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Sat, 20 Jul
 2024 10:34:19 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9%7]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 10:34:19 +0000
From: Yongpeng Yang <yangyongpeng1@oppo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH] f2fs: free victim_secmap when pinned_secmap allocation fails
Date: Sat, 20 Jul 2024 18:33:49 +0800
Message-Id: <20240720103349.3347764-1-yangyongpeng1@oppo.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:3:17::21) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|SG2PR02MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4a8f67-c9c4-4431-f734-08dca8a782e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+i6YL20BFSmKDHX93t+qDaQTN70KFbH5FPpkq+Z6nyh3yB+cF3gcYpRGR8Tq?=
 =?us-ascii?Q?19cfsO4cpORIX/lrpUn49c8zNQEL4Ji8mBvOFxxP8xljQ/fNkFeVFJw4/w/F?=
 =?us-ascii?Q?WX7yfDwGeMsR0j99U1NgAB+++aMOmhRi7yVCMbza64okXVKZAYrpXbFQosZm?=
 =?us-ascii?Q?dhQBoWTXEeGqPTEnXLmbcXSjM3NgOJp3aQLgIXooS2ixIQEbTKfd++8Kwso+?=
 =?us-ascii?Q?GhSduvIlH4gu60YlfxGT98AsU3EHYFvGLN7SkRRjx5q4eaGIWzNvgMp4cbqP?=
 =?us-ascii?Q?ZxG/U+TCiHF0+ELtPhjU7m62ISvitg5vQxce+O9jZm5sBCluznODP//wsTeV?=
 =?us-ascii?Q?25+UhkraltgqUU3Yp2JXxKfFbpCtZNpwIKqUPMOetH2W7HpQdNyUEvHabHab?=
 =?us-ascii?Q?eHa15fz1vfSPpz6Yfn1jOtgFUZ/F3cbZyRumRsHHnBIpt+3bnykb749k8Ka+?=
 =?us-ascii?Q?Y3hXpAUIDVLvjE7+8xPRXzjDgC1jfIP2ymoE3QlrF72z2WaEsFUeD5tVP+s6?=
 =?us-ascii?Q?OCFSvXHVLCBIIRLJ2boG1sOAjt9HsiSw90P4TQhIejHhOfpgwl7EEAKJ/XlL?=
 =?us-ascii?Q?sAaFhq6WIgV1672gxnWmy6zawYQnixdov47QB4eAXeOitRBSd5BeutSzu6kU?=
 =?us-ascii?Q?Z12onrw/k2tN+AIuydh52Tu+E2z95ptq5EerHcw44vk7uU+Ws4yGGQc2qfk1?=
 =?us-ascii?Q?aZKi0c2/3mmg2DT8F0Q9Xywp212+4mipHdAl3963wVscUZv0uEuq3/eCJnbp?=
 =?us-ascii?Q?u6IMC0LW2lgnkaCU/tp9W47xVS3mruybmxilmPl4wdXey4JL5X+4Wu5b3mFN?=
 =?us-ascii?Q?eEtQHKXLsXkIfy33/P2yCgnb2CanzHrmVuYA52pmCdO9QAG/lEHElgXN1L+j?=
 =?us-ascii?Q?b+3eWQZErD94CDxvppALyUbsK680l3Q11JTIfMRdDxmPNowwT1yegqzphR4n?=
 =?us-ascii?Q?Pk9lQuysBF5K1Cb/WjKXBxtm9Nx28/URfJpoMkIGpQG106be8/Vanb+Ho6/H?=
 =?us-ascii?Q?7w3sXLC4fgPNtdVr5Pq6D/0+zNHrh9a6f1zMNqkm55J3usMQ1FCmKSpd8q4D?=
 =?us-ascii?Q?QbkM36Nle95qkp9R9HDH2TjCWAfs6lAni+gDjOrgY0j6LoNbbbRSnedKQ6Ap?=
 =?us-ascii?Q?zjlFbUVeGMY7K17jy9cDOwUutIQzIdP6HAG0lmuq9Wf5BOwIRTKL1laUlmni?=
 =?us-ascii?Q?BR1MQZmlBWFvzzmvBVtmH3wlKqCPBFhaMaWEeoQ0MqIoIjq2wLkBCajUb76s?=
 =?us-ascii?Q?d9APavA6Z1HErnh0eE+/0fnzLJLS5HxD/8qjqBem1TJ/oTpIJzr9DO9DGmtR?=
 =?us-ascii?Q?oBfNvf2tBiBIgfx8KGwBYYf9IkalMFxmKyeL5XKJ8uJWRdPspIYPFXEykfJm?=
 =?us-ascii?Q?Cr01kcECDaVLkZokTG51q/BwKpOq6GxC0zFr3ZaaFAmVbpENAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeE+D24m2cuf9fto/39C57u5MTnCMmF1zIQb2vXj4w1FFn862jdU/gNNBmWu?=
 =?us-ascii?Q?VwynnF5SKHeIir9NNMPw4X/h8zBazFuzor3wkRb5K5uOjMNaZR/iAe77K/8q?=
 =?us-ascii?Q?vKlsm8Qo2lV4/F7Cz0lFzfBP9ZzBGQRRN9UJ/EGK4uXmfvfhYtQZA5fHLvcv?=
 =?us-ascii?Q?rEfac2HkI0oaxYnVkJOltdIOivj3lzdaziMuEaGqIJKwMB+45EFSKdqk6XW5?=
 =?us-ascii?Q?Ae4PCN5mpmI6ou5lEXWJmhnGgLsjGJqRtdHHhO/ay6oxOHYvEx4wtFXnKCkc?=
 =?us-ascii?Q?XbZ550FsM05lvxICZKu1E1sBCphTySLTP35aMYm+O+31cIjT9di6qXx4TIXB?=
 =?us-ascii?Q?zjqj0hWFwaRtcVX+9ivtr3kHmhA0N/ZYtHtwGlm8gtbA8GIkcOuZzHCNy1Em?=
 =?us-ascii?Q?NvzElOBceEnYPiwSj5MhWhjYa9vUiOMrdJPGznvVCaiDv4NsuanYRPoeZNUE?=
 =?us-ascii?Q?dYRRnIQKU4vDYuzI4mqf7Z592hkghLxhVRsDyVZayb3NLt1yIm7zpZPUOEnO?=
 =?us-ascii?Q?ieCaBPug1VHwavQpwxlvXnWXCrgeShb2WrTE634xlW3KnNL5JakOhDjzg1Eo?=
 =?us-ascii?Q?BH7Z2TJJS78UfhkyccotY8rx7JO8qS/TFxwbQQDxGJvshVeH+WuIZxmzUVTg?=
 =?us-ascii?Q?fU39ZAslxXo7gBKLynw/LyUMpP7RY3396LL7CwtBX7bbb7ESw50Asz7gRb8v?=
 =?us-ascii?Q?GeintbdfzR82+1ymxJVbQ2ZM4/qGfJcHJdUQ6s4F8wnx+RCbFQAYcsW67g2n?=
 =?us-ascii?Q?VM9srY40ubbsgrjEtpqn9PlwT8Bmd7WKia6qB75fZ/IW9nrxAiFmtDHeW817?=
 =?us-ascii?Q?8TmcTqK7B2f/OR1Tuwv5rryA6cVKTCsv4EP4LNsEWmBcDYLS4EfngCN14/Cd?=
 =?us-ascii?Q?hOdmer4aRN1xr66rnmnGD90A05PildgCHSptOoTmKQuSn9uzD/87+dvdMp/b?=
 =?us-ascii?Q?zo9NdzhWr/o61Y0ajSOCnfa/LpRBSJY/8SyMPYCdRiKuTUlXiJwMZmZX+TlX?=
 =?us-ascii?Q?jZCX+VxRQHptB7FS0nxbIvLF+DYBDRyFO9G0zMlBxqrKH9fOdXl1iD29ZHSL?=
 =?us-ascii?Q?MCVXxSWxP+TgyiCG4ErOM7Ulp52/Q66vUZ3yHXEuBz0gD+RF7QDb8owSHEDQ?=
 =?us-ascii?Q?0O4g8EXsC00LOoM++mbYGnxvNWVQz941yHYquptEtkuVzRWByQUUN616RXQd?=
 =?us-ascii?Q?8K6l9o+M8Vs1rZz1l1LVn7DY5pCz3B90t2Re+DcEhcFEkoe5v+36cSp1jqGw?=
 =?us-ascii?Q?oy7PRCnjTckuUD8dmreQBFRG9z18tBjw57zc5QMCG5lTTNMjiJAYB1vvtpFP?=
 =?us-ascii?Q?y/5OAMn2zEBxJO1G/FKF9uBDt8jNWNV+6btT04RYu1hB/ltBgLOeGG4TeUJh?=
 =?us-ascii?Q?OHF2w2IhO055rCYW19JzaCU678bB5TDC7wfUslbwZgc8F1aFDVHjk4lqNOAi?=
 =?us-ascii?Q?i9jUlk+yQwMf8TsmlwOEplD7Qz4/n20xI12GlNN7cmhc8+4sIrFPubHKqr4J?=
 =?us-ascii?Q?5iUKX5ypf0AuKgVZgh5fV3Fv/Kf9HTfPjeDY6FyUfOr5i+Nw47DwkIulMVgU?=
 =?us-ascii?Q?R6wrqon6D5EkCV6Vo11KCI90/NqVPvWw8y7+OCTLSE3CgC1J7JF9gZ3UzbVT?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4a8f67-c9c4-4431-f734-08dca8a782e3
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 10:34:19.1041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jiyg4KD24FZsps9riCwuih/5JuveIfJTkQtdvxwy+4ckWPtU1tfk94R9rWEE2Fz5VphL8iL7LyWxW4BnmRvlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB5652

In the init_victim_secmap function, if the allocation of
dirty_i->pinned_secmap fails, dirty_i->victim_secmap is not
freed, which can cause a memory leak.

Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
---
 fs/f2fs/segment.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 78c3198a6308..1e784ea3dbb4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4971,8 +4971,10 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
-	if (!dirty_i->pinned_secmap)
+	if (!dirty_i->pinned_secmap) {
+		kvfree(dirty_i->victim_secmap);
 		return -ENOMEM;
+	}
 
 	dirty_i->pinned_secmap_cnt = 0;
 	dirty_i->enable_pin_section = true;
-- 
2.40.1


