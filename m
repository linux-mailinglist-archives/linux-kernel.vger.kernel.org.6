Return-Path: <linux-kernel+bounces-298989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE595CEBA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF97283FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCE918BC1C;
	Fri, 23 Aug 2024 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JsKSWHrm"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2070.outbound.protection.outlook.com [40.107.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F26918BB91
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421714; cv=fail; b=fxS42MarWhIRjDJeJI1rIP1LGhO8eqGviE3f4x6LmwW+QrDL8wOqp1Ak5YPeu66VFyK2020/kf0hbY6RZ+nqAJu/zeakxlEqOkVQi57J7sfJIANd0Ot8ywVDK4kXERFIpqFRZElIrNLtRyzbMRqUt7bekf6Yt0s1y1CmmkGyXS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421714; c=relaxed/simple;
	bh=kSchDAPbiY4TPfWYxv1cmuRJYUGpwxDdi+9adZQs0S4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OTpeS0ObK5zcCendil6d9zwPg6WQ2HYjQ8w60QGBxRLQV63z18OwaOUjytRsiiBsDK4PYLHDj4ZKOQBTJ2iYhbsnqzhR+wlN8/OXTLFFKXC/Zqvrgfl2TBHIjGITKkN/9KT5nIh0akmCOWKTy2NynOCYEggQB0uczeWxLbEEDIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JsKSWHrm; arc=fail smtp.client-ip=40.107.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPLBN9uOIsvRgKUQdtxZPbr/f7jyta+kq/n/G0I7FXYxdU1BsduEKj4+XQL4GIQJ/MHijMQa3rOX3AnEA2lMU3amWSAHuQ+qVKAH80gDDYYpNrcw7o8hzf6vGm4yJHd1tDcZUPLcMFcxC7Kz/K/fRp+k1ijyYmkr6PbQMlfoq6qTSY2HYs/0UMWTpEBY5ULM48uq8WMTGR9jxS6CVFpghF7JYC0hVSboQyD+ySNCSSrcfB7XIxPutzOy7fP7itYkgvWlB3oG63tmr43FWE+vA2/ogrPQPQ/NCm6ko2RQJPh5rakSWeE7VOqYfukDoatuz2H89Xub6QkRqCqIBwkhPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXYoMV2Du+s+82HmC1q3+f3kEqfji82ljdp88SSmQ0g=;
 b=IFlRXg7Kzi/4QQl4JnX7Ib51PhCcqwr01IoS84xUa9dYtAQ0HxTh6FKoniVj4mqW4W17+MUAU/QPFIzjOaIMtO5u5osY26WSIubbHYVb6A6VVvwshDxd/FI/4U6w8xmDniA2R+tP8KhInfewHO4/l6cttxn/me7ZCWTFLjjVFXCMLwzAljNgfHqD9i0QuD2Q3bZfOz4H4RnhB8UhYCcw2GY3c9L7OYYONZV22MOHDgzekAR78HJblELOQHNoAN3UXJYA5zPnHRg8tZW/WhYqavx//sd5RQ4dQg7UHzZ4vu42hF52W+mf4YWMiGcui6nMh5dplf6uiMGrITCpcGN0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXYoMV2Du+s+82HmC1q3+f3kEqfji82ljdp88SSmQ0g=;
 b=JsKSWHrmMitjGj1bswyqimpNZ79yKoXJ8dse1v0NDz206/wNYCOQRfWAvLPZ7/AbA0IFhRZcTMPh8qTG+mREULU4fOFxQuagEUu5bIpnWH2aQeONgpeRvsalE6+Ke3mlZzwg+nlfSeO465qq61ZN2wH/yZfVNUuQzIrBhWbRM7mJpaOJfCCCB4xQk4FpP87j41PYIGqTxQjZE3uKjYO3hrGfH1Zpr1jU7YlpofQYh5+o43AkxL2lg3FF/oZcSSo2pK1MnNrOENr3IbAA2R2y878PttkTJyQIYTBoZFb/W0DTiK5Uht6U2c5cg5tiBDBp08cuf4C5N7TrFjUFG+jS5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5458.apcprd06.prod.outlook.com (2603:1096:400:329::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 23 Aug
 2024 14:01:47 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7875.019; Fri, 23 Aug 2024
 14:01:47 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	oe-lkp@lists.linux.dev,
	oliver.sang@intel.com
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
Date: Fri, 23 Aug 2024 22:01:39 +0800
Message-ID: <20240823140139.263-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5458:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d981a2-47e0-4b6e-4b31-08dcc37c20f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGJzcnQk/WyzBpgOeAsJ+HizYvditsQV0CWQY799cPxR7RJXrpRDkLORNiPd?=
 =?us-ascii?Q?Kw2v48biug1/dXpJMJcLsWivSXd81+YWQY/N51e/taqixgHuFuKxtv6CUEGM?=
 =?us-ascii?Q?lKANAzDS79z/d2Vau0HbdjFQwYE+dH8+9TGjbVsynQfB+uDCRTxvpHfnec8X?=
 =?us-ascii?Q?rKBNhZyj2/RaWRey830+MsEnK2OzDQmMngf1h60PNQmfJ9QWs/4Lzs6aoCfO?=
 =?us-ascii?Q?ooHsqm0AgmZRA+q47gMEw80bZv0NOJVawRyzjez4StAHS7ZrjJj0ES2YU0YS?=
 =?us-ascii?Q?YzYgECW1+qdKeMscHrnFNxMIfi2TJzRfsaolQUJBtPLQUI0V620CEMldmhxq?=
 =?us-ascii?Q?GlbCPN4YK3xkrXilIXVhT2u9P29pJ941tgA4/AuWn7lqLfsLrDiDm1sUoXPl?=
 =?us-ascii?Q?xdLPdyk1kmKLuB7YARCZc+1rNWuzl1d2o/4GN2VF9OFkrmRhkzh8CMk2c1GB?=
 =?us-ascii?Q?yDwrah62K4reHdqqrfe4P+gGZMj2+V2dtze+QEPNwXbQV0XhMycLB/eCck/r?=
 =?us-ascii?Q?6Y8uiVRKFBYHHxFw116/nnLviJe6PX/0XIIUak9mBeO1JPtsGugB6sUmyt1c?=
 =?us-ascii?Q?RJj6EnQNC/1NYzDrvSZFF8hkhjtGA9cgOe4AJWkABG9k8jSFataTQlHOY69w?=
 =?us-ascii?Q?8J0GNFEN7+hrkyqn4McuY2+3QnWC8mOFYZr2KtBOWMD3ZKsndYpXE3UN2X+c?=
 =?us-ascii?Q?Y/1uzupFTYA1NcYYe72zy88vxD4pQ700O/0l/lQExpmO1sFnWH6Li/cfn9k5?=
 =?us-ascii?Q?/OatD1Zc45swnURB5V1MhZvv2s7JsSkQvN4FFcUwOYTt9WVrCLxF+S1NKQjq?=
 =?us-ascii?Q?i++9eOsiXmAfVAbn8Sj47XPoONfiUwEqH0X1QMOJPrAFeXmTz+g7YPOC5+dV?=
 =?us-ascii?Q?+CnCet9ON62j1P7hxkljJS7OPkca+tA+f5XGI6vESBHH4IyiXtinY+JyD37Z?=
 =?us-ascii?Q?nXJtpBoelolBk3UtmKeqEnWm927IBlLzC1/2rvVkm7pEO6kXgTPWtla1mGnM?=
 =?us-ascii?Q?wTDRY9CIhE7cNnMOlXZkTvX3Hb01/cmvwal5L4fsdAvJYdsyzzDoaGbqNkwk?=
 =?us-ascii?Q?040CgJt3mPdhcSVsJmhiNLPfx6VZ0x89RSp1CQiOk0OBJqIuOsOd3hxKOvo9?=
 =?us-ascii?Q?PjXcKYc5+2yYoPVCYuy7qqZy2T8MGjDaFJvMset8wHAtP4Pt6GdELaixmNey?=
 =?us-ascii?Q?JLfL5dLetBMsG4H2ux2LmQav8B8ykj0OVtjWteNOICFAHUsSiG5XqEje0Foy?=
 =?us-ascii?Q?ZFXi2F46TP5qPerBrUNFbocNe+bcamcbprt+Ib3tq/HF4oibv8xJlH5WtstD?=
 =?us-ascii?Q?nrK7Pid/Ea8NOF7EW6u02FUsdq/rguHF1kbFGDE610tkGaAIbYzhT+fSTxfJ?=
 =?us-ascii?Q?+anWMtc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nf1OKzOQDbttDWAyNybyY7L1f9R6MmvzAwxDALq6AxtNa7iqC5AVaFGgHcZe?=
 =?us-ascii?Q?COS45G2wNrf9tCQ0Ty4VcYFEdSror0ghg4r9UCjyvqbIHhLVGpc74O3W/Rsb?=
 =?us-ascii?Q?PrkS3ERmBaDpZFqS/2Y9jsRrhFzJsBPln1COOxPB37svTPwmbeVeOqLWdVET?=
 =?us-ascii?Q?2qlUc8hXYvvovv12lLBUDCK0akrAS7X9/bZLPSimNoil8K7OJrtm6XlKg8vL?=
 =?us-ascii?Q?DImz9+ynye7L002LKYtJ251wK6QEEPwM40h/K9VLzJCx7QgI5KGa75ITkXvU?=
 =?us-ascii?Q?J5xEgFJyvjrJbICR/lRaKgPSA9afg9vaK9sALKrc1UbhYFF9WmllmJnHM2fq?=
 =?us-ascii?Q?BPqxSpfVNtMv7ofjRQYvy98UevwG22lQgUxlRlAuFqXrzxe2n10TB5iws8+7?=
 =?us-ascii?Q?xZdKKgKyhHMiEHVMKJiIChRFs0kzLFswEmcHpIGVrbz+5VxM+B0Ym5cxyaQr?=
 =?us-ascii?Q?DNlxxVQR1DABs6dTZ5e0lFmeD/Ycdbpyx4nolqYznpJTPbPbzz0QoYnO0S0y?=
 =?us-ascii?Q?RtJoeXVIcUSdRiRSm1R0KkGIbdNN5TSDu8UFc8iJvic7okcvJ7kbT5cr8qR1?=
 =?us-ascii?Q?6VVM5zqeLXmsB3No/KZBlbAYk47k1wm+RxnWPBQC0M51FXmBAKhQ/Cn1ePQn?=
 =?us-ascii?Q?1DwgHnRKBGeG/7ZoiumepMS2d/8T/KWU23/erFTkimmsZ94eQojiBxT6Fvsn?=
 =?us-ascii?Q?rMJILRrXorltrDU/lyr44F0ckpp4aBzouPwTytRklmsonqPwmNsCwGGTgHUL?=
 =?us-ascii?Q?qmM4jfPHcXi0Qd0s56UeR8apZ1vM1xIXL6CDDMk7MVmOKcOd1A88hOk6Q5M2?=
 =?us-ascii?Q?anu17GfwgItJ+eJZkN5SpcAl7BqxKC3OxkSnbULCMDGPw1WLSQcEAAi0CLv6?=
 =?us-ascii?Q?nssYN96i8jLw7lkOMdHX+5fkXKvE6e8Su9YEqgypgPVFl47kQJ9HgZifdVRU?=
 =?us-ascii?Q?uF/2e6xkM1a5hXJY0sfqTd1oOgFziXCogQ1ZUeAbuMqu6MeT+Qez0UnkI26H?=
 =?us-ascii?Q?q5Dr/HqNx52AHJIUjuadIeymVpmoNsrbZ905Z/Wps8gPCJ8tPVJvGjoWokMD?=
 =?us-ascii?Q?I5PpSJ1pcc78XlUILcTLC3l+zpxJpiS+Jp/4gZRcCCi7q4udjz73ysI54nSj?=
 =?us-ascii?Q?bEKfdZXkz5t9PVbggE18qcAaI3UH5YOw+HbqgWI8MNMEQAmmMab2l8FkZRsU?=
 =?us-ascii?Q?rMVO8iWz6Bpj7cOqBfgB3y+8AeCNB5lkoKjvsaXCanp9Rw8faEnu/fuX4Ipj?=
 =?us-ascii?Q?iEMdQzvKRKF/JnFjRndwAXYGluPo9+StYwM4NWgWcfUsHvArGaxChGtvWxDS?=
 =?us-ascii?Q?QRcGdiTZmDBkAIt4B7baMxTvtoznk8JVmjH9SF3Op6py3CJBidWaa2vGmYLY?=
 =?us-ascii?Q?DvRY0y3+kKHwfBKZUTlSyU3WghXMXW6GRr3xQdJ6OyLXu2R1wfEBEZ+V0M6e?=
 =?us-ascii?Q?AXIzRh5WfqwxFKsh31rB3himDohTCWRPYPXrvHcAnPIQY+3S5jDApN+2brtg?=
 =?us-ascii?Q?yYeqhAgXtcCdXOimE6UHKP2vOmtw6u03XOjBL910n9bgM5nfeTchnChz64Tv?=
 =?us-ascii?Q?I5RagnPL2AKjntj5TFEOTqEwfyPmC5Zr99qIFkgh?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d981a2-47e0-4b6e-4b31-08dcc37c20f6
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 14:01:47.7181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OAwoFbyNH1+rUlHs8jHGVm+giW5LE17RP/2zNqh0GuBzkLcW/ieFJK96/GoXjemFUAZa4xZWQ3LqVVfBRz6HIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5458

After CoWed by do_wp_page, the vma established a new mapping relationship
with the CoWed folio instead of the non-CoWed folio. However, regarding
the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
not same, the avc binding relationship between them will no longer be
needed, so it is issue for the avc binding relationship still existing
between them.

This patch will remove the avc binding relationship between vma and the
non-CoWed folio's anon_vma, which each has their own independent
anon_vma. It can also alleviates rmap overhead simultaneously.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
-v2:
 * Solve the kernel test robot noticed "WARNING"
   Reported-by: kernel test robot <oliver.sang@intel.com>
   Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
 * Update comments to more accurately describe this patch.

-v1:
 https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/

 include/linux/rmap.h |  1 +
 mm/memory.c          |  8 +++++++
 mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 91b5935e8485..8607d28a3146
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
 	folio_remove_rmap_ptes(folio, page, 1, vma)
 void folio_remove_rmap_pmd(struct folio *, struct page *,
 		struct vm_area_struct *);
+void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
 
 void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
 		unsigned long address, rmap_t flags);
diff --git a/mm/memory.c b/mm/memory.c
index 93c0c25433d0..4c89cb1cb73e
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 			 * old page will be flushed before it can be reused.
 			 */
 			folio_remove_rmap_pte(old_folio, vmf->page, vma);
+
+			/*
+			 * If the new_folio's anon_vma is different from the
+			 * old_folio's anon_vma, the avc binding relationship
+			 * between vma and the old_folio's anon_vma is removed,
+			 * avoiding rmap redundant overhead.
+			 */
+			folio_remove_anon_avc(old_folio, vma);
 		}
 
 		/* Free the old page.. */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1103a536e474..4c339c571ea6
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
 #endif
 }
 
+/**
+ * folio_remove_anon_avc - remove the avc binding relationship between
+ * folio and vma with different anon_vmas.
+ * @folio:	The folio with anon_vma to remove the binded avc from
+ * @vma:	The vm area to remove the binded avc with folio's anon_vma
+ *
+ * The caller is currently used for CoWed scene.
+ */
+void folio_remove_anon_avc(struct folio *folio,
+		struct vm_area_struct *vma)
+{
+	struct anon_vma *anon_vma = folio_anon_vma(folio);
+	pgoff_t pgoff_start, pgoff_end;
+	struct anon_vma_chain *avc;
+
+	/*
+	 * Ensure that the vma's anon_vma and the folio's
+	 * anon_vma exist and are not same.
+	 */
+	if (!folio_test_anon(folio) || unlikely(!anon_vma) ||
+	    anon_vma == vma->anon_vma)
+		return;
+
+	pgoff_start = folio_pgoff(folio);
+	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
+
+	if (!anon_vma_trylock_write(anon_vma))
+		return;
+
+	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
+			pgoff_start, pgoff_end) {
+		/*
+		 * Find the avc associated with vma from the folio's
+		 * anon_vma and remove it.
+		 */
+		if (avc->vma == vma) {
+			anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
+			/*
+			 * When removing the avc with anon_vma that is
+			 * different from the parent anon_vma from parent
+			 * anon_vma->rb_root, the parent->num_children
+			 * count value is needed to reduce one.
+			 */
+			anon_vma->parent->num_children--;
+
+			list_del(&avc->same_vma);
+			anon_vma_chain_free(avc);
+			break;
+		}
+	}
+	anon_vma_unlock_write(anon_vma);
+}
+
 static __always_inline void __folio_remove_rmap(struct folio *folio,
 		struct page *page, int nr_pages, struct vm_area_struct *vma,
 		enum rmap_level level)
-- 
2.39.0


