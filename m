Return-Path: <linux-kernel+bounces-568670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC643A69929
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9752B8A5E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F341A214222;
	Wed, 19 Mar 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WlhflszX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA3211A24
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412222; cv=fail; b=PcelWEnIbitBPgv8FKUni5mY6tZh7roJX5LpitktYYtsCjWT7prw+VXQc1JssFiCbYNwsN7tKGtDrXegGCW/uW8rN/LrfK+jItAGBBZyt0ev87lJ5VjtJI46/Lw5O2alhIS066Zq5Z1/Lo57/ndo0+AE4UrytqC/4+NAZejd3lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412222; c=relaxed/simple;
	bh=SJELEDpGcOYodGOsAJUN+TQP9INqTp83IeT9MgcvOMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nl4j47fKupepTALwuASLj6BV9rUySwcUA/qZYtAvQ6swZxWaH1Fs5kJTbLxBE3pE4xzJQr7bzMhJtk3oRgEN+fvyjg48DfsDx75tGVm2Fs81IkpVmgG7NEIoNYcrLwQg1UINmoMZ6Ogzo48Q3AYUI6ZM1PS7Nylwkun/z1JYg5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WlhflszX; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4dUnyTuEVtWO5ixBvw1Mlx/mUrHEoRGfYswiiTDW5igzi0YAA7J+qhTKyW1jhapGg7+e6JhwpIf/ZAL6c59IUe7EzCvJeAMFg2yiU3Vlm6EnLyia9MyJSsMfPRi3uiUxhYApcfL7z+jEbufFBTXyiraQRMxsUobD+0XTcvbEApHMTHTAFXywexbOHnRQZAUd0uvAwnKjJvaqoUrsqyoeF/WbrYknGBSVn0olGsReOnmUWZvtppbXhMOuUJtJ+7KWhfmJ9IcnyEDLtcfTUR8iUrXA/dGWM6DoSbbohrItnu8t42sUWMMnzqd0D3StPD4M+xw5gtcnoRj2uNciyPbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4pTY4qimGp+eX/PIhEn6Rb2JoweUqEplJQfgDoLjGM=;
 b=kZQB2Dgm8XbVoZ0op+HJRnhpJALAg//kmIQrrn6AJijxM5d6iEFDzmrIzNn1WlFcBfJ3LKHl8svphY3/ZcBbdvjU6F6HPvhryJc2VK8BfywwabjBlxnOfqG8UNTkdtVIqTzODXPBzZ/09zOAY4IU00qQ/WpUdxxYM0jbXQAQ0VMFIg5JTig7mqzUBw/rzWmgwY/1/9AQvNsx8J51Nba3rlDGqclQkhgaiPGqkDRyMWbr3cfqSuL17z12KcuG3X79xk/8eHaNuqZx4AC82wziazCtTTTm6h92zFbA/z5FZwG4CSQD3hooxYVpnMB4sev3KbDeoV+fvNL1LZakKbZXlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4pTY4qimGp+eX/PIhEn6Rb2JoweUqEplJQfgDoLjGM=;
 b=WlhflszXByX/8Yyxr6+7//rUPB0Vwe1e31YteQOOvwUOGg2WE37BGVqiyHYpBtOmW7w4pcn3ppCd9SNP3Zz0Yvzp37V+vfOnWkjp8h8Zj+wfUrl6zdopUUS9fJNnL3/ELD+uFF//uvPyQG4/Z6oo6OsrQf72QQMGvLt35K76Wlc=
Received: from DS7PR03CA0061.namprd03.prod.outlook.com (2603:10b6:5:3bb::6) by
 CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 19:23:34 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::b7) by DS7PR03CA0061.outlook.office365.com
 (2603:10b6:5:3bb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 19:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:34 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:25 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-mm@kvack.org>, <ziy@nvidia.com>
CC: <AneeshKumar.KizhakeVeetil@arm.com>, <baolin.wang@linux.alibaba.com>,
	<bharata@amd.com>, <david@redhat.com>, <gregory.price@memverge.com>,
	<honggyu.kim@sk.com>, <jane.chu@oracle.com>, <jhubbard@nvidia.com>,
	<jon.grimm@amd.com>, <k.shutemov@gmail.com>, <leesuyeon0506@gmail.com>,
	<leillc@google.com>, <liam.howlett@oracle.com>,
	<linux-kernel@vger.kernel.org>, <mel.gorman@gmail.com>,
	<Michael.Day@amd.com>, <Raghavendra.KodsaraThimmappa@amd.com>,
	<riel@surriel.com>, <rientjes@google.com>, <santosh.shukla@amd.com>,
	<shivankg@amd.com>, <shy828301@gmail.com>, <sj@kernel.org>,
	<wangkefeng.wang@huawei.com>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <anannara@amd.com>, <wei.huang2@amd.com>,
	<Jonathan.Cameron@huawei.com>, <hyeonggon.yoo@sk.com>, <byungchul@sk.com>
Subject: [PATCH RFC V2 3/9] mm: batch folio copying during migration
Date: Wed, 19 Mar 2025 19:22:06 +0000
Message-ID: <20250319192211.10092-4-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250319192211.10092-1-shivankg@amd.com>
References: <20250319192211.10092-1-shivankg@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eba36b8-6c5c-4688-3f01-08dd671b8a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5K5op3W+FPxeOfUYOGxG0vXfoJ+uNKB5RMlWqQIu6QsHSFIfHWlmjyJKGEF8?=
 =?us-ascii?Q?C5hQw3aos53j5x0zVfoLuM8nLbR0CcNnEHlj7VqXqKhrhfTuPby1mBAl3y5W?=
 =?us-ascii?Q?VizIqWGcYuJdb9ij4utyC18JyH5gBYcnROFfNleg4wn97khtluO7m/nVKCpY?=
 =?us-ascii?Q?HGi/gT+fZ1Xv4Lbn9wHuW/xwfklOz58zW0cssENnvPoFkCTiyhE1RuUXDO9w?=
 =?us-ascii?Q?ONvBCLVLns2jB6P9GrKbxV+IJLn+V9YtA3zJnD+8SqQZ5vGPLYN2GxNHPCiz?=
 =?us-ascii?Q?2F+ZMADtcuSXh2tKzwXgA9eytdOVNODXlMLDshytuy3fJ26vem4AXdnAdbiL?=
 =?us-ascii?Q?2iQ6U2Yotll/zH5iLM3+I5CAzqkOdycmND4GHO/1mL3/uhuXenZqLH2OBhJU?=
 =?us-ascii?Q?g1PnkpTjH3sIlwJJOH1dY2l5f/BORbqUi9dN/fxOHJXzRWceoEC3qC7Pzxa5?=
 =?us-ascii?Q?K4Z2qtkUaDAqBYhdpYHLUp2rpVrhHOY4kIcEcZWpwDOaWuMBFs05HcHbXy1+?=
 =?us-ascii?Q?rZ837z+MFm2tIXowTKVSeScxFzRo3FxCEAeqhQM4CQJ5DNXvXjPSjPlFzNjj?=
 =?us-ascii?Q?vHc7Xsxb2hoYnRaUkqsxGQbGeIsPeabfz4xE2lHj3JfG53PW30Q3kmghjUam?=
 =?us-ascii?Q?VDKB7ARqfThSa+OnNN+pmAKwB3M+xerW8igwzAqHI8r2EBjBB3k/+/xZ0ZEU?=
 =?us-ascii?Q?zKLxF8PJlOhL0aOI2IWRVWtUeEDUSjvjbuJJ0+qnkEjySvdTDuxXrq57xG5l?=
 =?us-ascii?Q?gnz0JjjTiZxAzxwqe1nItN8FkRQVJnJSNAreOeMQtUR79OWTjEDy+N/BblST?=
 =?us-ascii?Q?qkQ4IhpwJdundh9xCIzM4e0JsBtX/0+emORifrZc6McCClbpl4TmgeLSysTo?=
 =?us-ascii?Q?FwMSr1j8tXpe2BiRQN9B5UcBMpw39g1jbht5APM0NsdtcWv3htsnDzACw8yH?=
 =?us-ascii?Q?joleOq4lEgnuPbL1RL4TbTUydqHx51ebDZaJmg0kGgznbs5BW0VnzVa2mA1a?=
 =?us-ascii?Q?vNcouFCRxgNyfNN7amv4QIB9xwU/IhFKxYj6B5QYLdm6RwDTrBlsISd0dMSH?=
 =?us-ascii?Q?OYLAgHv/d8iD4VTStY5qvtqzaWA+eTC4e1u/FaxzzV/9/CvbscdZLeLZTpuo?=
 =?us-ascii?Q?yd/tG4PK40y4nsZZz2Q16YtSo3r278MsSbrOsNXP8e2xbbSsNF/VwUPBA9Nn?=
 =?us-ascii?Q?z9kjPZYgS/umjdTVKWCyNCeaeb/Lb+1C9b28HfuTDuuZLalaHMg3VK+/mvA2?=
 =?us-ascii?Q?mmu3g5lFVGBjjCbc2Hp5sq2SF1o8HRZuNMNyZBwX6UR1azYbm5y76NPIcCd6?=
 =?us-ascii?Q?pyjowq+L3vUmt6ckT4b8R+ZrjN0vPW1WbKe8kWjo6/R6Bbxgz6tcQ48iVaF0?=
 =?us-ascii?Q?egbwLlXYc8CuqfnoK3fxWXm69SBsdbDpNoYLnyWT3tT46aPd6UIY1nd/NA+s?=
 =?us-ascii?Q?W8J9Nk62NmUNG/Ja8Y65DwWLBMdd5K1KIkVzqiAcoIzXEJJUTGJbNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:34.0682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eba36b8-6c5c-4688-3f01-08dd671b8a85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

Introduce the folios_copy() and folios_mc_copy() to copy the folio content
from the list of src folios to the list of dst folios.

This is preparatory patch for batch page migration offloading.

Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/mm.h |  4 ++++
 mm/util.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8483e09aeb2c..612cba3d3dac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1301,7 +1301,11 @@ void __folio_put(struct folio *folio);
 
 void split_page(struct page *page, unsigned int order);
 void folio_copy(struct folio *dst, struct folio *src);
+void folios_copy(struct list_head *dst_list, struct list_head *src_list,
+		 int __maybe_unused folios_cnt);
 int folio_mc_copy(struct folio *dst, struct folio *src);
+int folios_mc_copy(struct list_head *dst_list, struct list_head *src_list,
+		 int __maybe_unused folios_cnt);
 
 unsigned long nr_free_buffer_pages(void);
 
diff --git a/mm/util.c b/mm/util.c
index 8c965474d329..5d00d4c5b2dd 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -908,6 +908,47 @@ int folio_mc_copy(struct folio *dst, struct folio *src)
 }
 EXPORT_SYMBOL(folio_mc_copy);
 
+/**
+ * folios_copy - Copy the contents of list of folios.
+ * @dst_list: Folios to copy to.
+ * @src_list: Folios to copy from.
+ *
+ * The folio contents are copied from @src_list to @dst_list.
+ * Assume the caller has validated that lists are not empty and both lists
+ * have equal number of folios. This may sleep.
+ */
+void folios_copy(struct list_head *dst_list, struct list_head *src_list,
+		 int __maybe_unused folios_cnt)
+{
+	struct folio *src, *dst;
+
+	dst = list_first_entry(dst_list, struct folio, lru);
+	list_for_each_entry(src, src_list, lru) {
+		cond_resched();
+		folio_copy(dst, src);
+		dst = list_next_entry(dst, lru);
+	}
+}
+
+int folios_mc_copy(struct list_head *dst_list, struct list_head *src_list,
+		 int __maybe_unused folios_cnt)
+{
+	struct folio *src, *dst;
+	int ret;
+
+	dst = list_first_entry(dst_list, struct folio, lru);
+	list_for_each_entry(src, src_list, lru) {
+		cond_resched();
+		ret = folio_mc_copy(dst, src);
+		if (ret)
+			return ret;
+		dst = list_next_entry(dst, lru);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(folios_mc_copy);
+
 int sysctl_overcommit_memory __read_mostly = OVERCOMMIT_GUESS;
 int sysctl_overcommit_ratio __read_mostly = 50;
 unsigned long sysctl_overcommit_kbytes __read_mostly;
-- 
2.34.1


