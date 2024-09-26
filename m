Return-Path: <linux-kernel+bounces-340292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BAB98711F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21CFF1C21630
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D81AC895;
	Thu, 26 Sep 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PLHQwMu5"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2063.outbound.protection.outlook.com [40.107.255.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E4F5647F
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345822; cv=fail; b=JQAWyKTH9hdVgF6wICwvoV9ceJbKMbXyYL0fFptMa8M46AnyZk+3mb6iHwt28JGUdznr++Jtrg9o5rAKxpZYV5f6aCRhU266k279HS2ybM2uzC6CO/yEI8SO+y/rGc3d/YE/+HYBFzUwMFG3a2UzYKcumQ0rs6JZ4bmkPZSY72Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345822; c=relaxed/simple;
	bh=g78h14ZEPt5lFzxHLBi2PHz9JTQmY71vjuA6vYUrj3U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wh0+1X06GsTGosTnzOU+n7CpnyWWKd8V5BfCkqZbEkvuq/5X2LfgfK7ZHfdwyvPLUtSEaSp04VSueQyvF3lE88Un+S+I8FS8SxLMkqdorjcYo6NhByZRmeTdPAsiEjXdsloKB25cJINAcnUSuYVsWNIXCKH6iD/kZExyU260Dtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PLHQwMu5; arc=fail smtp.client-ip=40.107.255.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5WPbnQe+jdY8cvNw/u9av5owQU2FYZ0b5S8tnO5k9VBibwkMHJhT2CFFvqwvBEEaAzUoC9O/um76RQuQvbvzbNjs8GbPJ/GNAvw1/uEHTTUIZHZ0huH9X4FhTaZs86hWHXvDd85oAkgavYiIwxnwGa+qqxRooWuw2ndvj45EsdDGaUxHyfN9Z6pk+ZgyCJjpHFLREifoNRMfkGCkBoLPiRH7pYsdUvxKDvxPr9yWgqATmAHwvZHPsLYOIeJAFcxFArnUfgTGSnL8PfNhMYtiQoxfGodIqJ1Jq0uKtZMNdYnQbDYmOvEgFhcb2eICd92oPGuKMwYuVugd+gnpH7hJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ng0SwqB9uzNvarTBhQR/hbKocOCNili2Thi88HiF78=;
 b=i4Op9IJ8fyxf/J+7Q5fhg6gpvI88UJzDtCSRYUwtEvht/70ixyDqrnPWsaPn8aAMAh5OnC9u2/IEPafemr03RjNVLN6xcVIYQGmbNg/TiNt70hdflXXluwlDEaf3AReZEjQ3FBPPmrDQdC0eRo+KZfE6y8wUQnlbcMz5uUC1iqwnTOGfm/PuOeu74nf8xN3aF3Rz/ex+utmE9jxentkO/yBkcgnjN8D0xH8O+ML6MwqLYddplk4F0GDCdbVxW6OnIJE1tWknPtYF0sDx6/m++sZUTPqYQAcuB0wy8PHbHY1BC3D3vkzxS5JO/yT/XKXSxEf7gQH1k2QblfwkXyTZYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ng0SwqB9uzNvarTBhQR/hbKocOCNili2Thi88HiF78=;
 b=PLHQwMu54C1ARW2hdlN9TXecWHEKVwzSkiq6nw4fB04VxrBZH9UzWbkpswdVQlUf82qwXHGrGLvGqrDnIeXyLf90NhuGrNbA9ggQ6JlE3+O0yNGXaWwbpk6NzZPX0bzxiK/ltH02Qbh4E4fRkWSx/qridxSxaydSOmL7fUuM2MOoQOVOy9KNhr58IOLG8l1BlJ4cOPjNohkKEvepGX8L2wABiBaiQFJKYjj81XmVrkjEyLL+KshnfNGHT7WgU8T+CRCLZhtohVc4oNjH+cmwRYDtl5AiNgkEGJe2yRs5KBCnbQToW2oHc2s/lfW848Md8HfQySQ/0EgK8O3803R7JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by TYZPR06MB5929.apcprd06.prod.outlook.com (2603:1096:400:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 10:16:57 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:16:57 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shen Lichuan <shenlichuan@vivo.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] scripts/spelling.txt: add more spellings corrections
Date: Thu, 26 Sep 2024 18:16:15 +0800
Message-Id: <20240926101617.3988613-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0184.apcprd06.prod.outlook.com (2603:1096:4:1::16)
 To TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|TYZPR06MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e9b860e-0f1a-4c68-7452-08dcde1459ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wssRbU6KVeiJYvdMZUdhZVhY+ffPr9HzKGtROoDmIUiuDfDarQuUdM+H3438?=
 =?us-ascii?Q?ZG86r0SPBwoQYabu7DWJ5hC7S7mLEvPMYTG0RavtrW2VF0Qb0QYgb+iT6GvS?=
 =?us-ascii?Q?Sg5uowcz6nwTzZ389MvpknAcY5XCMlHHRXfsTeoE8btJjvh4r+Qhetye71DE?=
 =?us-ascii?Q?Dj7hZyOnI1ffYfineJucHL//H/vy6l5ax6MsDTvxGUyssRxm57uAsZCD22lo?=
 =?us-ascii?Q?Mved+VbbitOkZT/8kJcoAGiVtxHOls/VVnmxB1k5tfaRx+u++KZWP+CZuGKa?=
 =?us-ascii?Q?rGRd1+E6T4nqvUrYYesj2Ro2e10+T4iK52NHR8kBoxmTIj/TcMU1ZsWzt+DS?=
 =?us-ascii?Q?RYivPbxQvSTNYyAfwE/olyQ+rzctkgpiWW6HVF6Tmrcy0oAf2vfDwBbX3h2O?=
 =?us-ascii?Q?r9mthoHbm84wZ38kGfHeEWJkLmRb3rhiYX5Zd/9Z9bplMhVfvEaU4vRFUQ4l?=
 =?us-ascii?Q?/CBt2rDztJzTX12pOmfnOt9eHE+Kc3BbXa2z3e6Ab6o3jZPwjMLrvQ+d7AW9?=
 =?us-ascii?Q?DjAKCYPQ8iAd7iSNVk7JT2rw8d+bpHs9jMzkDAIfgNkfyQOn8kQ0lyXpd1PD?=
 =?us-ascii?Q?zvzKrkeA18SEHJX1HXyOozWG1GbrS3MEZqwMZ7aRuDEwjFUcEkpJQUak6c9J?=
 =?us-ascii?Q?ARCzeMexL3jCLj0CETQluy0U8F2hnD0emmM+hyZbXrBQPmnuhWGQiEkWOEFi?=
 =?us-ascii?Q?ifP5jKP2eKojA5vsBCVfpUkZuscCnZOxWQ64aUrUs9KjH7r+eb0DHPVyIuoi?=
 =?us-ascii?Q?lQnbECiak05nLS83HeMiVgAyotgbQ4h3/6GaxU4CHv2n6iL/msemYtsE50Qu?=
 =?us-ascii?Q?+KQGuRBPqA3AgJWc1yJ4W0E36wOHIj/MkifPP9/qE8kfdWPln807bk7UcUZA?=
 =?us-ascii?Q?def2dYzS5VKHoP/q6qdnG5N4+yHvaNphbFppNygjCorZwcaOZ8PvZI9cBoA2?=
 =?us-ascii?Q?olikIsWK1A+8B7hvkwdaL75lp4okFr/4BIODsLAgCbPq1tSD5g52di7waSr2?=
 =?us-ascii?Q?MaDzMvJdngxeYpfLtHtomDmvudXPVpDbd5cIJBB7BAHJtUqE4YBB0BGp519k?=
 =?us-ascii?Q?5IXFj1B3pgYHfndPP0TdxOsjl1pa/3akeQOW3RvpoPnQUm97t2rlKR2IGWR/?=
 =?us-ascii?Q?2UhnIjF/uhGv51J8eLGk2XzY208HWUtph+lTbNLEDxLuWrz5a45/CXfMgzZz?=
 =?us-ascii?Q?kmS3ppymI2e2UjJ+108w5Da3kV49xqLMhHBh5GsK63jdtb4wcRwtC4Cl/3Gs?=
 =?us-ascii?Q?tZU6KQeXB2zIPSfAOzkX5Ixbgw9HJUBl2B+kIe8D9uaWh5NOfAMDjtPBRCBi?=
 =?us-ascii?Q?3b26O9WyD9ppoeuYdG1Mjp+7QssNWdprb14T5oUJ2ZjXqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LXl/EGmaHrxbpBW/q/y+FpBFJjwqtLqsAUJyzp5yxTjZ1tVVB1QtncF5EkbN?=
 =?us-ascii?Q?lf7oj7mTSxy+KQCTgjO9UrizLWIjEiKkT4BzpBp8fuV8Q/AHenOCdEzFZgLQ?=
 =?us-ascii?Q?EM2ALLyYOnvaOAufgRx96cuFxEhKcZw2N0OQPItzDU354Dx0kohJ/EAFkgfZ?=
 =?us-ascii?Q?EUj7AsqxRqOAXm1kF/iPVLT8B4dA192a6uDb0RrU8MS/qFE5dC14qTSOGr8Z?=
 =?us-ascii?Q?mna2urEE926zcpj22POElQBERS8RHH41q3ocQMfPf+rR/wnkMu98Yc4mNrxd?=
 =?us-ascii?Q?2/D0swOZ9pT4LH/gslWpsB8IxdMm/5NA/seaG3OwBYjpVJwfGdQ4KNi09yfT?=
 =?us-ascii?Q?me3/INJVCiFojIANpN8ZuSfQ+iMBII7X1rTWGpIOolOo073F2Z4dCCRmXu/y?=
 =?us-ascii?Q?Pdk1GMVrbiYtl5+ddNpx27hlSSfVSA/QiUDHloabHQNBXwZqVC/oAkRSuvNZ?=
 =?us-ascii?Q?sAePU/23WXsI792dYORTd1eyuuBFEKVURivfOz76tIWGbapiSBrkP7hzy4KW?=
 =?us-ascii?Q?MIiLLJf5S3ipyWuU/QKh31Xsg8mkqkVjpPLJ3q5hpEfK24NjoLG6+6tymm2u?=
 =?us-ascii?Q?ebm6munmTYosQYpDCIwnhxJM17xktppCXNQgtOekD59ROPHN09KQxj2/6nLk?=
 =?us-ascii?Q?OTTB70dXBXRQL2t3BVS2Xx82D1+iMBkf3Mj+qaBv3/QlwbpgaXYxIn8h/9EY?=
 =?us-ascii?Q?GOCAohvgsWSk0YByp7bc5Rawp2tqWWyEnU8Zn/R3U0gFw5OA+DLiHecheRqF?=
 =?us-ascii?Q?gEE3fZv4atnc01zCOTYOfzJ31YZyChZg+ig8WhU1LuKdQy6Z5QgHXF4ltwsc?=
 =?us-ascii?Q?MZHVCRY7P0gwWo7W876YTZB0tqYknKzx8B9Rc7cU5YsMi/OSMTUNmboXSLQ3?=
 =?us-ascii?Q?g9+FZjMOVn0t4IrBdGxtiJacOrXN3jI5LoAb8vEGSkXgOKVuEdSOQPozdXwd?=
 =?us-ascii?Q?IYQX9AR8iR0fQmc/ZVVaw0iqyL3FOrJHhV8Kki4S9DVijPhK0WrXH1EVn9lE?=
 =?us-ascii?Q?7vNYliAFsyuNw/eYsrm1UQrhcrmn7m7/LZLvV6bpeJaEP4sKedshDi3DgAQi?=
 =?us-ascii?Q?uBGNASlfnQxb9qYWKZhOzPPFMiQ7rQrvfGsn6Qn5Q0WaAOt9ToxliM+3E4ez?=
 =?us-ascii?Q?QyBLwuWczW2AoZOmMObzZTUUE9UoSf0powA2jSUoqJqiSp/gD+xDOX/Dn0Gi?=
 =?us-ascii?Q?XSs+w6qyW01/2CtxPDXS3FAV1HB04f5ZD4HSFPn8MJs8ggP37J2g96IPnduF?=
 =?us-ascii?Q?8NqI54HWaAAxg8FRPbIoWYu42w/xKrUfQJq/DDP799x/tuRs3MbYowVFkMZ3?=
 =?us-ascii?Q?SUCNs+vpEUKVTDSBGrJoCM42MYV/qvV18nuDbgrJDQ3ZB9crBGkfIWMRf/hg?=
 =?us-ascii?Q?OQOF/DqEVNukbpoe5/DVsBwaBu5VWy9Fz3be0At3TB2wvbAorUoHw76qpZJH?=
 =?us-ascii?Q?TQZcGvfSLSHKkBSqMk32hnoE1Eva3sb9w+q6M7C1oy2vnIU+ZfkiCX05XEhu?=
 =?us-ascii?Q?PdTw8g9REzwHldY+wuNNHbzilpzy8TpH1SORHE3++rKninnhTOqNKsG20AZB?=
 =?us-ascii?Q?QmpCk/p9w+I6+fkNameyF6PEffLZ1IxSMpwMutEr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9b860e-0f1a-4c68-7452-08dcde1459ee
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:16:57.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmKQbndBzdPro6Ch3VnEOQPv+y1465xyd5uYv++K4+sfwymLQAFtGoSZVRZbLQJTP/ayAFkrdkIkN87jZEyGwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5929

This patch adds several common typo patterns to the scripts/spelling.txt
file to ensure checkpatch.pl can detect and prevent these typos in the
future.

This update helps improve code quality by preventing recurring typos.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 scripts/spelling.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index 554329a074ce..fe25bf3b605a 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -141,6 +141,7 @@ anomoly||anomaly
 anonynous||anonymous
 anway||anyway
 aplication||application
+apeared||appeared
 appearence||appearance
 applicaion||application
 appliction||application
@@ -155,6 +156,7 @@ apropriate||appropriate
 aquainted||acquainted
 aquired||acquired
 aquisition||acquisition
+aquires||acquires
 arbitary||arbitrary
 architechture||architecture
 archtecture||architecture
@@ -185,10 +187,12 @@ assotiated||associated
 asssert||assert
 assum||assume
 assumtpion||assumption
+asume||assume
 asuming||assuming
 asycronous||asynchronous
 asychronous||asynchronous
 asynchnous||asynchronous
+asynchrnous||asynchronous
 asynchronus||asynchronous
 asynchromous||asynchronous
 asymetric||asymmetric
@@ -269,6 +273,7 @@ caculate||calculate
 caculation||calculation
 cadidate||candidate
 cahces||caches
+calcluate||calculate
 calender||calendar
 calescing||coalescing
 calibraiton||calibration
@@ -331,6 +336,7 @@ chouse||chose
 circumvernt||circumvent
 claread||cleared
 clared||cleared
+clearify||clarify
 closeing||closing
 clustred||clustered
 cnfiguration||configuration
@@ -379,12 +385,14 @@ comsumed||consumed
 comunicate||communicate
 comunication||communication
 conbination||combination
+concurent||concurrent
 conditionaly||conditionally
 conditon||condition
 condtion||condition
 condtional||conditional
 conected||connected
 conector||connector
+configed||configured
 configration||configuration
 configred||configured
 configuartion||configuration
@@ -394,6 +402,7 @@ configuratoin||configuration
 configuraton||configuration
 configuretion||configuration
 configutation||configuration
+congiuration||configuration
 conider||consider
 conjuction||conjunction
 connecetd||connected
@@ -403,6 +412,7 @@ connnection||connection
 connnections||connections
 consistancy||consistency
 consistant||consistent
+consits||consists
 containes||contains
 containts||contains
 contaisn||contains
@@ -452,6 +462,7 @@ decendants||descendants
 decompres||decompress
 decsribed||described
 decription||description
+detault||default
 dectected||detected
 defailt||default
 deferal||deferral
@@ -487,6 +498,7 @@ depreacte||deprecate
 desactivate||deactivate
 desciptor||descriptor
 desciptors||descriptors
+descritpor||descriptor
 descripto||descriptor
 descripton||description
 descrition||description
@@ -601,6 +613,7 @@ enchanced||enhanced
 encorporating||incorporating
 encrupted||encrypted
 encrypiton||encryption
+encryped||encrypted
 encryptio||encryption
 endianess||endianness
 enpoint||endpoint
@@ -630,6 +643,7 @@ etsbalishment||establishment
 evalute||evaluate
 evalutes||evaluates
 evalution||evaluation
+evaulated||evaluated
 excecutable||executable
 excceed||exceed
 exceded||exceeded
@@ -650,6 +664,7 @@ exlcude||exclude
 exlcuding||excluding
 exlcusive||exclusive
 exlusive||exclusive
+exlicitly||explicitly
 exmaple||example
 expecially||especially
 experies||expires
@@ -834,6 +849,7 @@ informations||information
 informtion||information
 infromation||information
 ingore||ignore
+inheritence||inheritance
 inital||initial
 initalized||initialized
 initalised||initialized
@@ -878,6 +894,7 @@ interoprability||interoperability
 interuupt||interrupt
 interupt||interrupt
 interupts||interrupts
+interurpt||interrupt
 interrface||interface
 interrrupt||interrupt
 interrup||interrupt
@@ -925,6 +942,7 @@ jumpimng||jumping
 juse||just
 jus||just
 kown||known
+lable||label
 langage||language
 langauage||language
 langauge||language
@@ -995,6 +1013,7 @@ metdata||metadata
 micropone||microphone
 microprocesspr||microprocessor
 migrateable||migratable
+miliseconds||milliseconds
 millenium||millennium
 milliseonds||milliseconds
 minimim||minimum
@@ -1132,6 +1151,7 @@ palne||plane
 paramameters||parameters
 paramaters||parameters
 paramater||parameter
+paramenters||parameters
 parametes||parameters
 parametised||parametrised
 paramter||parameter
@@ -1177,9 +1197,11 @@ poiter||pointer
 posible||possible
 positon||position
 possibilites||possibilities
+postion||position
 potocol||protocol
 powerfull||powerful
 pramater||parameter
+preambule||preamble
 preamle||preamble
 preample||preamble
 preapre||prepare
@@ -1269,6 +1291,7 @@ raoming||roaming
 reasearcher||researcher
 reasearchers||researchers
 reasearch||research
+recalcualte||recalculate
 receieve||receive
 recepient||recipient
 recevied||received
@@ -1291,6 +1314,7 @@ refcounf||refcount
 refence||reference
 refered||referred
 referenace||reference
+refererence||reference
 refering||referring
 refernces||references
 refernnce||reference
@@ -1315,12 +1339,14 @@ reloade||reload
 remoote||remote
 remore||remote
 removeable||removable
+repective||respective
 repectively||respectively
 replacable||replaceable
 replacments||replacements
 replys||replies
 reponse||response
 representaion||representation
+repsonse||response
 reqeust||request
 reqister||register
 requed||requeued
@@ -1444,6 +1470,7 @@ soluation||solution
 souce||source
 speach||speech
 specfic||specific
+specfication||specification
 specfield||specified
 speciefied||specified
 specifc||specific
@@ -1544,6 +1571,7 @@ syncronus||synchronous
 syste||system
 sytem||system
 sythesis||synthesis
+tagert||target
 taht||that
 tained||tainted
 tarffic||traffic
@@ -1574,6 +1602,7 @@ tiggers||triggers
 tiggered||triggered
 tipically||typically
 timeing||timing
+timming||timing
 timout||timeout
 tmis||this
 toogle||toggle
@@ -1597,8 +1626,10 @@ transision||transition
 transistioned||transitioned
 transmittd||transmitted
 transormed||transformed
+trasaction||transaction
 trasfer||transfer
 trasmission||transmission
+trasmitter||transmitter
 treshold||threshold
 triggerd||triggered
 trigerred||triggered
-- 
2.34.1


