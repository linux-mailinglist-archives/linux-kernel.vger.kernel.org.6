Return-Path: <linux-kernel+bounces-426991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404029DFAF5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE33162EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6181F9404;
	Mon,  2 Dec 2024 07:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="leAk48J1"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010048.outbound.protection.outlook.com [52.101.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C674C85
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733123690; cv=fail; b=q38NcKwCTfiiq2WLNAOQuScGObIrxrsjmne93c4go/vjtMJXdMifRv3zzcUk7jeSJcJCXmi/jIX5qm/WmKc3NyY2OXyc8j9TENne0aVb0U2hWY0eDKYCUrJTDwxZsRlBCDusPXL8JcW0cfKnrv6qhSNdqfTZ4CM6f/k2Cny53kU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733123690; c=relaxed/simple;
	bh=iiqdeXq/2VsUQOq08SqlYvVQqTaIZbONOll9crWg/6w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F2rLLE1PsXVWAFvDLzWmWaCh3tAmTfA98hlD/stEr0guy6Iscxm2nQv9y+9PHJ6LPk40A1ZmZf5SArxmXS2hzblaDMSK627uynNFoFAPB8/uVTkXnbJzsbnr7WTMm1MsMp5hXJn9ZWY30dK2gqtlj27Og4rbo6K0rstNsIRSJx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=leAk48J1; arc=fail smtp.client-ip=52.101.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNAmr2H4pi207/elJJMbk8Aoyi/x3YOpA5xaj5HzLQYUbc7QUm49mmpBpdq6QgL3yBU7HP4X0wxuqsnVkjQL4KAZCd7RSIqaPJ8lvYOlnCFEDuKEsGqFv5NDGSxBNw9Rqh+63zGqcS45vlsKUotdUCRU1EDuGz42ZRlpqHmnymjptKXMYh1ah+EPnwoyM5nJv0JxQRUsgmV2Wa6gD979PaSu3vHiDn3iqN4XMeYqhqrLBjISp6FEkMBPt7gcpTl7MYByOCisUUFAYujPQuK4HoR7bhNXHG/CezLFo71FMEb3nMLfkK+2bNfqDITs4BUVxFBZL4Ff/Bz4GqwLMttRSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJ8j74xFhKJ5aFO8qW4k6RauWvZxd1TfmRmaQrCJXkY=;
 b=U+tS9YVKzF5o+iOvyiRtvPSsMUScrA339TyecivHn3awmn367b4Uin0QwXtnHqaxSuObOxW0NntoodmEmVfGRr2hEpZn03WkMS1YZdXHpqBQ8SKfh3k/dfsfR55nr6w0gtKBPYJhtcxj0lKFy7ueu5p4L8vHVNCVXIMZ8UxpjQp/76h26XWyjL6OakCx5u+z2UYjsSmLhutprQ8pfps/pERIMG+yRAtJCpv6CbHQGqvrMHqJ8fnMhZ7XYi7vZ+bOOLNy/H4Q1rphE5i1bmMnvFSVm/ZfiBvbbd+8Go0Xf1hQJMTEyyQjpzP/zMBNZ5PgtD+6Bzhs2fFtQETIyBiFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJ8j74xFhKJ5aFO8qW4k6RauWvZxd1TfmRmaQrCJXkY=;
 b=leAk48J1sUV3jxzlGKTs+lA99CaE9ijh6UryyzsCnPLq2Mc1rSkvQ2MZRxy/r2113+TOY26DMrwA3U7XZ4FFlnFcfWp8olAJuI8Xza0hwUgVmTLhDjg5CDXbNuMxJnIcYf41fK5yACYWRMDV4Mj5VmiBrUW/rfAW53lvn1ilA/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com (2603:1096:301:90::7)
 by JH0PR02MB7069.apcprd02.prod.outlook.com (2603:1096:990:4e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 2 Dec
 2024 07:14:44 +0000
Received: from PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9]) by PSAPR02MB4727.apcprd02.prod.outlook.com
 ([fe80::a138:e48f:965e:36f9%4]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 07:14:44 +0000
From: Yongpeng Yang <yangyongpeng1@oppo.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: [PATCH] f2fs: The GC triggered by ioctl also needs to mark the segno as victim
Date: Mon,  2 Dec 2024 15:12:59 +0800
Message-Id: <20241202071259.2643959-1-yangyongpeng1@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:4:91::16) To PSAPR02MB4727.apcprd02.prod.outlook.com
 (2603:1096:301:90::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PSAPR02MB4727:EE_|JH0PR02MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: ca44669a-1be0-4d4a-e805-08dd12a0feed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3EkiGgGcvWGTq41njC+zkDJnRMbeB+8sIsoy2h/0rX3i7b6ksiA54SIbJYJ1?=
 =?us-ascii?Q?2Yy9fg6OhKIW6oNljMf3lJ7bQnZe/2Z8NbBYPXx/nF3KOT6LgCx2BWsNPJsc?=
 =?us-ascii?Q?Hr5EUniL/SWrzEbtsqs1xFvlQjoeEPsC2HcByZnJFjPcMDAMls2yMYQaYoVm?=
 =?us-ascii?Q?Nhzo3AndKaaNJC8BJkeLYx2aoU0gzxQRCc1rAp9uQ2neK+ZGjorHQB196SR0?=
 =?us-ascii?Q?l9MNtGVc+4WuSiGYiBkNmdoj/kF2cZhPyfWjNXXtB8noIZQWpVNbkwSnYNLt?=
 =?us-ascii?Q?20KzPEDzlRKiVXY5I2LcRwufINyM/aTkpiBC+4onhjPhKS8NUkhGGys6CAmF?=
 =?us-ascii?Q?gt8BG9DqusKXLjXdH6+2WczqFdA4n2TagOvI6FcLzoe13IOUnmit9975W4Mx?=
 =?us-ascii?Q?K51ZshRMiO7Fj13zXRobotYIM/8dKRD907CJ9Yoh5M/J5v1ta9Wq+sNV3o3n?=
 =?us-ascii?Q?paOPQoQUcOay73J/cKGV+YEFmM6pjNi6crgfKYuVPlozM6BXtc9xFx8QGZr7?=
 =?us-ascii?Q?i52OmGsTyULEJ2taT13qqcd2UEphTQ6EGeBxn+zGD0NFVMH8zlAaasnS7IuZ?=
 =?us-ascii?Q?gXkFV8nJo6pGmoyfzPwtx5ghmqC7rc3beKNrWbRP482REIQuRTlHrH46J7WF?=
 =?us-ascii?Q?3ydcihVIz41I7IbWVGJAtAOCNe5q5KgVMRpxsFZMS2LYBaCCDoOHSYONOJqo?=
 =?us-ascii?Q?kXxsfIBnkvjZl/qsYDwkSs7XGX181gTwdtS1Z7BA8KozCl2v2InlKFscA6TQ?=
 =?us-ascii?Q?s5++v6uagcJoZYkDvWDdYtAa/LNSXsC5FtTueYxV1K58735fC4qgQqtyZX7k?=
 =?us-ascii?Q?O/Q8wvCiDtmV4uiFErR0OIDylWWgSlfUR4qtcxBCKPX4qla6eJ9hWivAaqhH?=
 =?us-ascii?Q?w9rUIYuEFJtmV3+HBtjUoY+pPCJrdQw3p+GQ33wfk8Oqkox9QDTpPp51vpyL?=
 =?us-ascii?Q?1JQiiBaMMFYXIbfXX1fz52ReRjmIFo2gf0FUhBzuurl0qYoN9DJieJmiWp7q?=
 =?us-ascii?Q?q6fLbHVD+2suCyyIRbf4unaWoxOEpHNccrHgla6QVhNolnBVKl/DuXIovaeh?=
 =?us-ascii?Q?CFatTq1XnXxAc5W5LAK7jACEJfTnlcwbszR0NJ3fjpFhInri7bjiYelHg8Je?=
 =?us-ascii?Q?phr9RohlDvTf7WDx5SL8p1kXBG87rtmBNCy1FiRDsx2KA7SFGfMKwGc67qtv?=
 =?us-ascii?Q?2TlvgO47BDNEu9704ccyxDYHS2J0obORGy/SH71nK95ZLm1r4k/Z1uofQiuG?=
 =?us-ascii?Q?rrM8txcJ3mGeBg5vRv869GvWi0T39PwF2eSjVU9xVL61qr0L7qW7OxqTjq1F?=
 =?us-ascii?Q?Lp5X/OXg9DdNveOkdwmT0qO4+vUfaJ4kql+LDxO9wV3QbDfY7/sPoBi6+Xsv?=
 =?us-ascii?Q?wSkhwZZ5+M5eGMvklKJzYQqWHyC8/UGEbTfKsUKsrv3jawBiew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR02MB4727.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tL7qnF6YwFWqxV7Jv4aw8ORUdlyEuXUhFa7OEx0RaNHXXPiiABs29GgNUlyr?=
 =?us-ascii?Q?It9PqAmQc1JcpyMhygA20nFTocoBWA8stIthYJlIiAiK416sqPrUbV4GB/6b?=
 =?us-ascii?Q?S6oDGbhlor2jQMg9gHMMiqgXp/6P7VUvwGkT8wdrns5jQ+zH1isfRNcNdoRV?=
 =?us-ascii?Q?9l+OW2vszBRZUno6ktQZFQHKNRcCSOQXRbvPlv999F5YRzIH+IigOcRdQR8f?=
 =?us-ascii?Q?ESRq6aPMKYiFh8f+thN7rUXDG8UjEDUYEbvhb+PyayuI6nXZECe58qASTtdY?=
 =?us-ascii?Q?TYj1cBLMSd/ZUhJ/kPFgwehz9YtOq0yD1+eEQsorVFSQc0+gZn0jahRj5bi3?=
 =?us-ascii?Q?21TlnA2spiys9Z8Uj+6SvUYRkOsS/0ShfhUrrI4XnEu70NGQOfiUZijAl+g5?=
 =?us-ascii?Q?zzdxfptFXRSZdAGyudP+vrQ4gPFl3jkC/DhG+DOEwa4IV0EokfI5mM0z9jNH?=
 =?us-ascii?Q?FDjl5HR1XtDm+n/9+Grnl1w7QrBh0G9qq3sh55SRJZDDpe2o/Z8AQW1PaqCK?=
 =?us-ascii?Q?urCmWnvSWGd0EfZHvTvV7aRTtK+qyGwh3SA9xAVDwGuOdDj0vwyxha+D5stY?=
 =?us-ascii?Q?9qco3taAcEVSrO6u737NNtnus+/a7wK5ZePk3Tqgevcrto+dzS+ltLtvMfVb?=
 =?us-ascii?Q?2I0vj7bjMgHEDCTzO6/z43YqjJlXJwPPU3y4xj/0QHIxDMhJ9QOfYPOjlpHq?=
 =?us-ascii?Q?cmfA/6c6aZPrAs5TybG++EPxHeA3EoDlWsOgSoOyEE3WFq0I7PSdlei/abPs?=
 =?us-ascii?Q?os4O+cMHnrVNa1TNq+EIt3MAOL8xFrMYukubF7Zn2/u43bnO980C1rNdTMaB?=
 =?us-ascii?Q?5JD02HrzVRQgXSOrC1kYgw8DidAQQ+GNFBUN/iJnnMWEnwmNHjz8WA5cAUU8?=
 =?us-ascii?Q?mUtTRvRg/F26gbYhDGnp64VfTe04pFcxTVjw6dUrO1CF4VuRHSBjtFo1bvBs?=
 =?us-ascii?Q?n2//5efY44Vu1SwxjkLUP3EZXSXyFskIV/y9Q+lvS9HvEMUbo+i4//G7mPZj?=
 =?us-ascii?Q?EPrqfPYam6khS/u/Eefqc50l3q4s0KJteVG4BJh3eqHAxYjZYwISo4iYeP3x?=
 =?us-ascii?Q?fCMHuVf89x12AWY0COG1A19YE6byp6dH0bPI9QK9cbtZWCEShZ5pU3wsk0T8?=
 =?us-ascii?Q?5uW/FviIRoq5Zmx5YlKAoJHPirAK+l+YaRDW8tvYLk9tUXLe+I7fGF8PHNUj?=
 =?us-ascii?Q?DzXgGly5nKOlncNYRxNX5jofovX5V+eW/jMG8bXTwe9KMA1jN8oqOMDf9WnB?=
 =?us-ascii?Q?d/hSVJkRqCasDoRzAOf9mt9W7VDB3jdo+g5T07sFf+rq+r3vnoMRG3jWS7Ii?=
 =?us-ascii?Q?8b28pfdym1YKP7Yd3vd8SSiLXAOWgnl95tlSm7t0RffP1Vw6YauHri8KeHf2?=
 =?us-ascii?Q?+tYk48nNIiFm3OuNIb8hX2/XMb87PLStK9ikL6Fz2bKNJ/wP5iTVtLDO4tyZ?=
 =?us-ascii?Q?PofAwZRxoHZQ69WL2bggEQuFzCsGHTSo8GbFLkjRVoY4xgtRhWfCCYUJUaYq?=
 =?us-ascii?Q?zlJ+O/rBHI2ceia8KCviR8fDJ2crSc3h85UG1jyyjHlaeJTs5B9uMwsJIXB0?=
 =?us-ascii?Q?D7L7te2J677TjoUeLp4MFTusKmVO3w3rWnKBUXK/FGvGtVmsojT5391dmwV2?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca44669a-1be0-4d4a-e805-08dd12a0feed
X-MS-Exchange-CrossTenant-AuthSource: PSAPR02MB4727.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 07:14:44.0525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYMSSrnK/eUDS4WXQMojsEuqnawS0oL4wJgRFb64szSyiGrWoZZFvpnaDdb9zMWq3m9IEeKsh12xRTAyTPyPtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR02MB7069

In SSR mode, the segment selected for allocation might be the same as
the target segment of the GC triggered by ioctl, resulting in the GC
moving the CURSEG_I(sbi, type)->segno.

Fixes: e066b83c9b40 ("f2fs: add ioctl to flush data from faster device to cold area")
Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
---
 fs/f2fs/gc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3e1b6d2ff3a7..8029369bb71d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -806,11 +806,14 @@ int f2fs_get_victim(struct f2fs_sb_info *sbi, unsigned int *result,
 			goto out;
 		}
 
-		if (sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result)))
+		if (sec_usage_check(sbi, GET_SEC_FROM_SEG(sbi, *result))) {
 			ret = -EBUSY;
-		else
-			p.min_segno = *result;
-		goto out;
+			goto out;
+		}
+		if (gc_type == FG_GC)
+			clear_bit(GET_SEC_FROM_SEG(sbi, *result), dirty_i->victim_secmap);
+		p.min_segno = *result;
+		goto got_result;
 	}
 
 	ret = -ENODATA;
-- 
2.34.1


