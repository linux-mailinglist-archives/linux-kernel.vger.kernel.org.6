Return-Path: <linux-kernel+bounces-287670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BF8952B25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F4283A29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDA01BDABD;
	Thu, 15 Aug 2024 08:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WyuUO3nU"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2078.outbound.protection.outlook.com [40.107.215.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857719D8BA
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 08:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710715; cv=fail; b=gh961lkMb4mD2OvRRufzy1VRYIYiG7rYUR5bKb/Mo+u/sF/7V9AqHnmCsJcvi1qYxQ6C5ag2CNVR3nVp+g9gzeA+6gMDAGKeiz1zcvWIg2udTiXRBsRPHbuYaWpejkFH1avxYb5NHXJSpv2opWybMDuFjl13w4McAD9Se1spG4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710715; c=relaxed/simple;
	bh=6JuXInb68ZzOLYrfNVAEae878bSJCuINg3B9SfDJBok=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qiMh7XQQGWODR8wD0ITHoeEKmCx6r6rVmSSolbYBmFa4+/ktxNuOU0bzBorEq0LCZ9+r9EeP1quB9XqNtNty7ANeEMG/SpxZN5m3psmPWDFRcimXgGU8bc5IJ8L45kgyLrak0Z5WKm3d5gxEwE2meza5q7y90qWFItoSCO1WIms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WyuUO3nU; arc=fail smtp.client-ip=40.107.215.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSYHykAy7lOrqdulq3G2j/sBZrY9fi3IItROfO1BVOnEAg/AJ7waCZBPugj8pi+8X5j496F7Ij6Zw+6Ag1dESa7qkRKPIaJ7YR4IObhoR12lQXbz/JI1yToiX13XFDEjG2xmqCmtD7rz1SmvjPKt0sH3S9uJ7Guv9BQ1rp+1NiwDUKWNOehjFPNiKE9DGT2qOiiFVENdUAdpCQxEFjyp61YJq5MP+6gLRFTGiB0JQYcsMOGKt8Oq3YKOpL74x2XEx+d11Gb2ETDmDkuPsHCow5G1Re+Qkk4CP0ExU/f8A7GHMu6uCg5S9iZ2xSSjO5H0Xgv3qJTYgmhIub9llLQzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/HbH+lqCRD7KxTiNVT+iMr7LtMJnifp7MQgXFCwqt0=;
 b=PBTltKHhFu6piQbCGsSQziwHTy/y5QTg/1rEUCAZ/koh8Tk4WA3G8lPpDisJDlTXp0xENldgw7+j8JAzMqqDuzpfUsrT8qulJ409hVR6Ht+7YqWUUXCs5nJZeBdsg2zH6pMDfkwxaOm5/+V2+JxLYNAa3MRqik/V+7ziwDgNc662pVph1gOuTT2jfjlbjDW4yPUlUbKQIkb9PhEce4FD6wtDwbfUAF0W1r0Y63pst0VZG7zBJkDj8p9lldD6Vi8HThq5ojGbh5xpn7AnL4gcBsWpwcuiq801vRUU7+xyLEAisX5wWW6KFcGUNkxFTfWTIg+zHb6nW8CbzMaQfZ9sSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/HbH+lqCRD7KxTiNVT+iMr7LtMJnifp7MQgXFCwqt0=;
 b=WyuUO3nU5/S0+8sdk1wGdtscRrhk3GbtOKKwSnroII3ZqAnITimIBAuUHG+QDWC88kNA212fIjXigCVo5vI5i7S2JUZh4j1oqrZJveWUg8EBgK+FPTOGfU6WwetLcVaQBX8Ms8tq0oHxllLS4Jrih8Wq/zXDlL4VoZtCF/AJvmDlo2LZYaAnyg/Lp1TwCfumiaHz2K8HMII/efs8Xo5ZhGt3O19+te6wHp40yc69ouShEnTam8Mlmoip+zQUATMreVU50HXiNqdDsDTxbCj+B7Os5wAGVOeggzYeexMuVSrPADYV514kiy6YpwB3MFjgDTSBKsQGpw1WOXyM+qZZWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB6376.apcprd06.prod.outlook.com (2603:1096:101:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 08:31:46 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 08:31:45 +0000
From: Huan Yang <link@vivo.com>
To: usamaarif642@gmail.com,
	yuzhao@google.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] mm: move the easily assessable conditions forward
Date: Thu, 15 Aug 2024 16:31:01 +0800
Message-ID: <20240815083102.653820-1-link@vivo.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3effba-cddf-47d9-8910-08dcbd04b29b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GT3leGEl6odkCYBn9bxEnWE/74+6aH/UWCDox+sf0FzwL2OApi6/DQ+HcuUP?=
 =?us-ascii?Q?0kauypAvB5ev4Sh9MqmsciENATXL6Fo1+nyuAPAjUUqhwC4dkbfSh7g8u0E7?=
 =?us-ascii?Q?LcTwZ9P9f9Uxfo6YVWu5x5mpnlsS1ODtXxwcUCuww/RwHtnZvukroMHEqGT1?=
 =?us-ascii?Q?wK+BI6B62fVbLmcIK8gSVUajYe0gdKYl2ShLhs5q4UDXaq2CDRkclGqfz03A?=
 =?us-ascii?Q?7niIXWh+yYAlhDZP/QDYql1eQkjtFrpuF2asJKQPCdNBOYVVLnFrl3zaiLJG?=
 =?us-ascii?Q?AjgVryOqHoVmMDg9UhcKibF9Omwt9RnT46W+78XzHN6mi+a68vZeKTyf6pJ4?=
 =?us-ascii?Q?2D8+gFDAoUzMVPTlP+c6CXjmCfF0yUIx3kKe8dAP0o/pA8QsPCL16uhuUA+L?=
 =?us-ascii?Q?SmMHUKEC3ZhKpHEs8jM4r1BzJD4w17coeghpWF+8I+hNefk0XVO7Jz7UV+bk?=
 =?us-ascii?Q?YgCdPe0fPqqBG/tFriesBQ4gWW4HdkfoybTFUpI7UaNb9qWpDGK1jU+gjGSk?=
 =?us-ascii?Q?lf2s/U5WOYL8Intb0ycbyo/+ANDGBF/sdUxQBVm0ZPCgSQ3aU5SJHfTmvyvQ?=
 =?us-ascii?Q?rEISV9oHmbjHgbFmniRsmphPVUSmbeskAbtjMWMfa8w+VLGQBfcwwF5TSaQg?=
 =?us-ascii?Q?OSxIM0PaRVbQajYJzYvksCJMg5A7Ey0isePpcJ4pBEs/2M35ywBTFBTaDcOo?=
 =?us-ascii?Q?ndR70wkfElmJChkCboi0UkTMNPCNR1VHAf5FByCJcE60A4eUAnQadzytytcx?=
 =?us-ascii?Q?hvDGUSWV4myjem+BiObw2HaH1ftAZ0ACxWFligJmCiIUz3xtlDMB9o+dsQsX?=
 =?us-ascii?Q?dsxMVCpmZ6eAM+cr4uTugEHpYPPqTRJGnet/Q25LHOHX+Ep8iiIqpuZahzqW?=
 =?us-ascii?Q?sLDSXbmKYklFVAAUp1kjKfpM5bP8lzr0pfVy19xhxoCHeCdM5CyztBlocv2G?=
 =?us-ascii?Q?H2itKnulHRpPlOMRksYb0BGdewNDmXwEYhabCfQmTQPXTCPSc3kLQDnT5BkF?=
 =?us-ascii?Q?yn3+NvNU5rAbLV0YB/napv9pHjbFbP1B3hEChFgUSGvvvsbHERbTJfrEM9ai?=
 =?us-ascii?Q?ocRfn/ralzSkK0LaTqHIKcWEoPVMJcSkoF0mpblFaUQd9ZPYuG3e1VM3t4Yn?=
 =?us-ascii?Q?k1TcpxhY8+Cdw2PHhlALgnn6CGMOU6RfNCo6fjwSGvpIhUqV32b2+BQBiP1k?=
 =?us-ascii?Q?iPZKboAZBH7BuTSoF9yfWyKJ7sQ3HmwDI+NF4ViiYf8sY/JC1CJiBk62t4Wo?=
 =?us-ascii?Q?7UcZSx+3OduL47zwuX+GpnBIAv4Wb4++CNOb9LOZQMfdhed2X3VJ6V79r5Jk?=
 =?us-ascii?Q?BxRo495yesRo6Zxr1Jrd6enxNh0qId/rnikUiw6tkO3sDwsm2eEvbckluc8w?=
 =?us-ascii?Q?efff8q9SsMHwbpn9vp3KlDssJgg1+3V+ISm2wnn3F9YYhD+0Yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VgAVad5Jzn1kZ0f51fBomYKiWJsOF1bvVJEbqo6DdSYDcQnD8zuy6wiu0hts?=
 =?us-ascii?Q?hsBUWXeEhWaQ9nGRfbtkZzmqqiBNYJhzm56wQNL2JjSQRwMOaUVfajy8oKyp?=
 =?us-ascii?Q?ipc9pNaWveS+9yFiilFZn7HbqgIhRHyLvvM+uSzKxrtQt2sLXnrs70d2W9rB?=
 =?us-ascii?Q?G4inTmWYZ34YUhInNQkH+y6MB0R7jWeKwKQ6JzvecQzuE4uINU05W9buNl62?=
 =?us-ascii?Q?WsMGNUULT0LAE6qq7ii/BfwFaAZQblAe1OX9Yy81H8fm4WA+EDsE2t+e+Xyv?=
 =?us-ascii?Q?I90vuD0yXmH31kaY6/dml2NrDLyRkP3cE/pJqjPNig4kO55A8k3Goc5DKNPU?=
 =?us-ascii?Q?fA6rSV18AAoX/nVDEsw+Sn0Udm/Yx4TAmNpbgqwMaJRw2pQtrxa6VUibb4u1?=
 =?us-ascii?Q?GNnbaI+UDK9JFimMtYWtSIjcP1QrTDtCrlWg7fBtD5fflCDTrfIZ/XkOH2fV?=
 =?us-ascii?Q?6uuzIPvAmGo82ECDuS2nhN3VloHi6/vhjGyE3yyvrZLBxCyiGIXDfgtCJueE?=
 =?us-ascii?Q?gfT7F14s3i8Iz2Cuijp7fuFB4hJzYPCcKxV15w0y4osP4oIaPYUj8A0jD0Gf?=
 =?us-ascii?Q?dV3pdyFrRNlP77CtoaIPvQD9QnSfjpeGWztL7Gu/YGgLssuUPMlwMogRq6TP?=
 =?us-ascii?Q?O312QA4i6C1qfH8J2cQuQy2jqdt/ZCFuz/ZA/QZAxrynpf/DF4dqF/A2Hb/z?=
 =?us-ascii?Q?CBC3BnxDMBSXYQvkh4267jBUvZpLCeJSYhiBnZmR2bzVMv76HloAlEuvFYzi?=
 =?us-ascii?Q?07neSh57W43MGGzmgEV1nPTG+zHgKGCjX4yaV3jDbCyuzLMTqFy92omivhrh?=
 =?us-ascii?Q?7hNXl1YaaFLcOoL01xdF3BzeS3YfVxt2PgbtvyxT1SwQ75b3tbqH/34hvZJa?=
 =?us-ascii?Q?6Ilhz6ic9HxZSsEiCHhbqhkzUHkF4SmNmrW7xNUdK0poxDqQZE9APTNtEc3z?=
 =?us-ascii?Q?ys1ymKAj6OLKnD9RzCca9ZZeYGr3IMmQOSPuLaq5/sPiDA62TRk126t205tp?=
 =?us-ascii?Q?tZrN/oxyB80vmaqqgjc5jdhnqiwldjJtuTFVhmNDz23S+94I6wmEyl7gr6Pz?=
 =?us-ascii?Q?RGZbGFNEIcRraB5N8JiRQbB9WLa/wzqg4mip5/IlOWW8xhbYPDsVP7iplSz2?=
 =?us-ascii?Q?WnAjRQ+MZSWAPE8cC1uecUhnlbNTcSIfL8UrvYurcLouIygeac86d16Sw4p3?=
 =?us-ascii?Q?USQsaEwYcR94CM/GqdBc1sG73XEfCQ2plBJ+tr847CYOSm/VKcds/J11xJ9q?=
 =?us-ascii?Q?ejF0uZshxlHlHNeEijZMCLI1zkWoIIjVkTOFO0NYwxDRMmj96Fo7zmyZTCiQ?=
 =?us-ascii?Q?3wu/Dus5CixaOj2Ov+e5UtUOxY86mJ97exJmWIJfhPQSZ7H3AzODKW2lJh1j?=
 =?us-ascii?Q?Hh7gLieiS28Nh6Nd2+F4/r9YwxjAfLx10W1d6htKGDaWcAhsmriMbfmAI0E5?=
 =?us-ascii?Q?cd8P9mflQ4cgqsNUwcJ8pxKYNVT501gw62snCj0ozpXgFb8W/yacH9BU6eYT?=
 =?us-ascii?Q?5MYCBEQhFiQTvzL5Ovkm/x8h7itb5iG6zDQeoIdz+ByIC3foDPLV6Fqeb7xj?=
 =?us-ascii?Q?ISLRfo3vYeoU/WDT5yaZGhXvk2xiujUexzjTum5S?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3effba-cddf-47d9-8910-08dcbd04b29b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 08:31:45.6176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvW9+QH5i9/Ke0W2fTe1pvKzW0xYYMzBSTPHKODVG1teWgBEnRok/yaxsV7/YrHc+GWsVDlAil9XiQ4a4nu0Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6376

Current try_to_map_unused_to_zeropage try to use shared zero page to
save some memory of sub page.

If forbids zeropage, no need to do anything rather than attempting to
assess wthether to use it afterwards.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/migrate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6e32098ac2dc..d71cc4ff190f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -192,6 +192,9 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
 
+	if (mm_forbids_zeropage(pvmw->vma->vm_mm))
+		return false;
+
 	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
 		return false;
 
@@ -204,7 +207,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
 	kunmap_local(addr);
 
-	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))
+	if (contains_data)
 		return false;
 
 	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),

base-commit: edd1ec2e3a9f5de7fb267a3af73e4f00e7e052b7
-- 
2.45.2


