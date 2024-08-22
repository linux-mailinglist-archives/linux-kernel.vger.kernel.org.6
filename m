Return-Path: <linux-kernel+bounces-296511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8206D95ABA5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 05:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3941C287223
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 03:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC0355892;
	Thu, 22 Aug 2024 02:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="I3HIzPtT"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2067.outbound.protection.outlook.com [40.107.255.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDB1CA9E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724295471; cv=fail; b=jemgPjaLgavFpiUNHBx6R8Rmex6YzL1L84Ftd9ZZHYlvFdDpUbaYnDzOAD0Xd7c4e2nLG9SOPmwDwK0+VhqiJL8GV48E1lK8FRo9ttYqk4X4lVvUlgw1F3x6CpcbcTjE0M76ow/M6NjDnuU63JCI2mCUCEjGeHarU/eBaQ2ZjLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724295471; c=relaxed/simple;
	bh=On0iClHWMtqVZDKBpntGtqg2Mx/RBJkrvpfsgMnZe68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uU2VWGTlKYKH691tIvMNnlqwS1O6N3WKVRWKOW6ve01QlLtDukYfcZccR3t1YPs30zO1Ztacc/Hk5mzlsxOuiaWbkz7s/jOmQl+pu5duJ0PugtuY+PK3vQDVUFMnMpkFLYOjIZRuz006ZQqZs4ujvWZkPjV/SfaLZaIPR5RLM6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=I3HIzPtT; arc=fail smtp.client-ip=40.107.255.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyhcXbWMstg1CcLfbBbDL6JgdtvDTL4Bqyps3FPlM4J9oYrc6h/VOU91+SaxCw3KA9W4BMaujWGbKOWr29zMT3tFy1+uYsSTziw+WUceLF4r9718IKCUKwEdDSc+UW0cXTPPpgZ2UA33qrunf9abasgC15Jt5Y+5Ok/Oq+6o4cNMBFSssGFg8LBnDOXvYeIr1KRRibL7/FD6ypTl4zETFSsUr44pPLNqZ8aWiBmIseeikZL0eWv1SIosMq3s4FTBX9VInh0KcQrpof52g5wX03bqVDwJu4zzePFrW2itgL/tdBkMgi0icQ9cIQkFlW1gyMKmujA02DHoQ1xFO5hv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME5d8IDO+oD15pb8WpSHXQVX9i5tOY0SpwVRETS+60k=;
 b=SJDu0n3Rf0exwZ5erw/7c5T9ba3vdgsrGvIlVPzo3cEvC2UAbgYPiTyUOEbLBCknGltSNtM6gNsnKFpci8O2pb1ugPV4z+ZsxcVWzguVkE8Lw1wxd+N+PchhZwUgFxVkGwuWgLSwNF39y2tkx5WeLlGHjP08K9XcLcsNG68TgyVss+ahjWHYtrlNyQ5aL5Y+aAxgrTYRHrfJqL6KQMmd2jfC6upbO725MoIizf/tzhuwP/BZpD8i0V/lKjZQnYJDGoRQojn6T0OHTiDYUl9LyjgI40i5MJyVd69kYgvXFsJVXu6DFx3tWmWJfMMM2AGOhps/nvIPHeTbqZ4HyLjyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME5d8IDO+oD15pb8WpSHXQVX9i5tOY0SpwVRETS+60k=;
 b=I3HIzPtTA/Jz75K7Ti9NMHBTEZ7Sb8jgkm6txxtqysLFgjiRo+YVlXTxjtoBVRxOQz7MiVI4bi51AbGwiKVZ8MConWCOd7BIQRMKFDDn8TgVrj/VXByNldYcB0o7r4Vt09itBu1/dxZNPze2m3NYlth3QQ/RxgnAYXeVzWuYwteFHUzY1IhurD2v/Tl7RavCoEkWJV+MeeYOZjbi5G3c3eC57T2sx94U8A+B3rhpKik8vJKBtIokl7SVveaI5HhDg1oI75EAMVom2twyU9nFIpkp8FnW+ESsPbxrzgUnLqQQwdAP2mRwi+jWjE/Eq7KFOiZ4IgMLU2G5lWzGWoTZJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com (2603:1096:301:f4::9)
 by TY0PR06MB5682.apcprd06.prod.outlook.com (2603:1096:400:274::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 02:57:46 +0000
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6]) by PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 02:57:46 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: gregkh@linuxfoundation.org
Cc: soumya.negi97@gmail.com,
	piroyangg@gmail.com,
	andi.shyti@linux.intel.com,
	alexondunkan@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] driver:staging:vme:Remove NULL check of list_entry()
Date: Thu, 22 Aug 2024 10:57:36 +0800
Message-Id: <20240822025736.1208339-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0155.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::17) To PUZPR06MB5724.apcprd06.prod.outlook.com
 (2603:1096:301:f4::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5724:EE_|TY0PR06MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: e98db61a-5e5f-4608-ce03-08dcc2563348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2NEB4onlB3PeypQIkBRDlqvoPkQxI2wHdBudqbRX9ra3erJ5Cy/SMRC2sWtw?=
 =?us-ascii?Q?61Fb2s6ppsphAdocz8bhhZQkWOqG98LPavmhv3fYObMPNysVwrdeplij+HNz?=
 =?us-ascii?Q?Mulg6Oj6BPqpvMK9BSDSuRVBUdnaI4CyXLD6OsIg3RlokQDfxOVHjmUeDp7A?=
 =?us-ascii?Q?JF3RKngUTZ+36LwbzJ/To+UmVqFrMdvFkeNoKPnPRYxNDHb8f+vWcyQKEodX?=
 =?us-ascii?Q?dBRAl4awbA8jH9Q7KUacjnCPq9W1Ldi0o6G+2DcoiDEC8NMsHqJNMalHV2dB?=
 =?us-ascii?Q?AUOP3XVAsIFGe9DeFamqEMEY5ZQiWF+GwlTdoN6SlQMJYduxpjUkmBY8V0OT?=
 =?us-ascii?Q?PGgmTV80oPTCKIjkk1ygxEvbxr/+2kzl5AU8fYhTot61fGnX39TuKmMapfbD?=
 =?us-ascii?Q?CgzcgfbX04UCgiVqsPteY3EWEb+OMvSjDTgbXT7KDplwtRwiAarN2LJM+ipB?=
 =?us-ascii?Q?LIkfXER3uSFk01arbUdFijlAhR337ofc/71g0HKPJzVRSHVcEGz+VVIvRuwm?=
 =?us-ascii?Q?b7BqpQR3PE0noeABBcRBSGr2d12rNhghGiq10JKhhae0HUpKOOXXZoRxiKiV?=
 =?us-ascii?Q?e/oinlUfTUVhb5jb6ZdaP7xWhscpfhoR1hm7gfQ/g+hBiR01l8wRziZ/qSQh?=
 =?us-ascii?Q?ScLAahZYFQe4Wcipvnx+TaVAcwHCUtiHXImQli41JNwCtK+DrXt25SGZCQXx?=
 =?us-ascii?Q?mANLUY8tOYoA1gJuziGEdCoUphihvPGWgog7jsMdPR7Vl/R7O6oI4e4wVquP?=
 =?us-ascii?Q?fMSM/FPBRWmEw+moqQJnXDVRPc+iZFtV/zlvo7T8BIauQwfbHoS7x3neL5kH?=
 =?us-ascii?Q?mKO2uM/SbuLaPXEKTN/S4n6ar/kzInIwj5Wzk2jkG3QwBzbjrKHk9Eta0uFn?=
 =?us-ascii?Q?R0mjxDsIbUsuP34IesTw2iGJDVfdW0p6EJwSVu3np8awsTyL2O8JUfCCRYG9?=
 =?us-ascii?Q?I2lh/RgPF/mtCFhQlxpfuhdD4JEj4RK9tpW3xCYyyyAEH/xEPPyRP4HSF8kA?=
 =?us-ascii?Q?gZRr3dvO0ROgq8okXht4dxGxHQHLtaII9TmlOXiY3LG2HGcGw8cRGlG7wvZu?=
 =?us-ascii?Q?Omo2lW7dHp7aO/InQhen+sH2QFypBvtNRAlCwlT/LWvHZ52fivrfEq+bPstY?=
 =?us-ascii?Q?rAJD7bgZL5QyEXp+97ZmVhIz05hnBkVCOLk3GsryKhHzoHDbxJidiZfpdKga?=
 =?us-ascii?Q?E6QaPSfH3mRhNMY4h9bmGD9B+nxaZZVK+XvHX7oMc+L4oh5FvVF4EQUoGorD?=
 =?us-ascii?Q?0TyXYd9aM4+3EsECg2YDiNAuOzBOFO5+9ldLvWodnL1wF/LgObw1hhdiH2Oo?=
 =?us-ascii?Q?wXVvQ9u8g6dAFgadjQ5D/pCvOwNRIw77r0D2DJquHW4k8ZYd14fUbCZYKYBy?=
 =?us-ascii?Q?f2QQ5vcJakMFWHurhSjfhuc+jEWnVgcg627K6egQmr3X5AYDPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5724.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwZSysb7ho43/j8k8753Wx/3WnLAhG/lFMZXD/B78qIMQ8uyNIA1HDHG2/E/?=
 =?us-ascii?Q?gXUcj9leexy2uM4BCuRBHruQkYTs9qNmr5OCz/pepvkkrAfKrbFAztgwO7M/?=
 =?us-ascii?Q?E4m4AT3I/qJ4c+tZqShOkcqKemtSYQb3c3QwAYS9wSr8/re+VPnu4XwzMryz?=
 =?us-ascii?Q?qdwl0g/5eLEBllkw1s4FznvgWDsOaPZ3EUDypfNvIo/IGGuyoUTNEgusKQq3?=
 =?us-ascii?Q?QaQt+NO1jI/Y3db1lM4bfZLqONG8J1zZ5/eZZBQi6cICGJIE3b7p/Bhwa6yE?=
 =?us-ascii?Q?Gcr/p8UJElZlcorr5vMj4q/DRxzgr7L9lfXr2hkvFVWV+RP3+EmjunqMl7Dg?=
 =?us-ascii?Q?oU/UY23BFd/t7D+3OCid0TsfESYsv/AdYDf/aIYpm90CXokReqIAsIOppBw4?=
 =?us-ascii?Q?ElD/1k3vqDyMheXxTfbua8tlYPb0p9UGHaJkO6nMiedWvrHLzqe5iMuqu3vb?=
 =?us-ascii?Q?zxK6ERTR9H8WUP6r7C0gXNGb6nVz+04rzbr+isAI0KpMvvCYJ0sg8lJsYNNB?=
 =?us-ascii?Q?qCaAdtEjlUSahgzAn9Urdx0qQbhrpLXeFah6UtXGkVWvItg4ccn8+RyAWk7k?=
 =?us-ascii?Q?75+HjOseAIYa2yb/mn5joPIjRByobEadoBerk6lvu+ZT/3+iQQzlD4yNCmwA?=
 =?us-ascii?Q?PUE3+fgmPRnpe0XzakgowImWyZIxX7QOg9WaXVOiS9qYgnm59H9+BEBSSMOG?=
 =?us-ascii?Q?bhS8ShVt50FNvNWWJgT/YVOURmnEqGSsJ7A7L1UObFXuw/u/H5lscpdA1VeZ?=
 =?us-ascii?Q?yJZ3Edan/mkjGY2GtMST84wMKoPqeexMWiKY82FdqESqNoJEJm65JMLewLzk?=
 =?us-ascii?Q?KS5DHNftc8thQbP1leKtyBj1dRGbs8IaYwSGEGCiZD3eyq6pMQzfMMZP7I3m?=
 =?us-ascii?Q?dpkAx12Fobp+Y0BYnAfBN/aYd+/h1u1c9KJpfRqvyPI695mJIIkkQqyjmkCQ?=
 =?us-ascii?Q?HUBJSspKU2v7eUR3hJwA6+EdRUzkLtCuQAVpE4JIfBbJ081kRxpjY8dc2XKR?=
 =?us-ascii?Q?vxWjNgIfl+POVLFnwZapWA2xhHyqhDgp/mE6ME+jhYgj37M3A5N7sWm/IUzA?=
 =?us-ascii?Q?ElzEoJVg8PzTpBiui0L49YHDhxVW6Z9+/PYNMT+lk3JrZ4O/bhqLu8qepy+6?=
 =?us-ascii?Q?RT1AgLOkM2d6kZevCZdX8DneUJj86+g23uzpEzp8R9ksDtFUCQ9wy//CMS82?=
 =?us-ascii?Q?HuUVa4ntAdDp19Jk36Zd9GYdXCF1jBCKAW9mL3tkTiyEPUrnInATOfuev/Lb?=
 =?us-ascii?Q?D8Qrzs2JnF46fSeY8hqvGGRvrJM7UenUGiwHbSVQmHmeAi6Xr9XwDdRgaL0P?=
 =?us-ascii?Q?Gr7b9kGyJI8lj8+q9LGavTWyODhgTtX4EPaGhMuC2uc/LaiJpDF9/TVOCsjl?=
 =?us-ascii?Q?GtVt+xJN0EZ8uBe9burJ7QiB3/C1d+1nO3ODAfZnEgY6K0AZ5C/fkpHEqzza?=
 =?us-ascii?Q?JlV7Pvw7QO0Eyv/0Th276WMUnRwBn5LjceaaSItPl6sKmWf7msyu+m1CeKCn?=
 =?us-ascii?Q?votEl3BCuDWvrPejiw/7+zld6DZ1PsEF3fpYVG5Ruk183EeZy2GI1mDwe109?=
 =?us-ascii?Q?4NwvvcZnVeSqVLQeqIaeGZ3BYi431yv8VyAIiaoV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98db61a-5e5f-4608-ce03-08dcc2563348
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5724.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 02:57:46.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQY7a4xK20QhtVObD0LrFODetDMSp6NNT/lMQ8WVsrWYhaLjOSbn5vSmwKZ/k1uXGtpksIJPYSP1L48W3z62YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5682

list_entry() will never return a NULL pointer, thus remove the
check.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 drivers/staging/vme_user/vme.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 218b19db6dac..42304c9f83a2 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -416,10 +416,6 @@ void vme_slave_free(struct vme_resource *resource)
 
 	slave_image = list_entry(resource->entry, struct vme_slave_resource,
 				 list);
-	if (!slave_image) {
-		dev_err(bridge->parent, "Can't find slave resource\n");
-		return;
-	}
 
 	/* Unlock image */
 	mutex_lock(&slave_image->mtx);
@@ -794,10 +790,6 @@ void vme_master_free(struct vme_resource *resource)
 
 	master_image = list_entry(resource->entry, struct vme_master_resource,
 				  list);
-	if (!master_image) {
-		dev_err(bridge->parent, "Can't find master resource\n");
-		return;
-	}
 
 	/* Unlock image */
 	spin_lock(&master_image->lock);
-- 
2.34.1


