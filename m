Return-Path: <linux-kernel+bounces-568669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E26AA6991C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8B467AEADE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8021420B;
	Wed, 19 Mar 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qeGOLX6i"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ADB2135DD
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742412213; cv=fail; b=Omx5QINgPrUUBIkCaGwt/3sA7DjlghkcEkbrHYhe/6FQ0l0P/SYkk4NqO8Cdxo3QrZmdnoLdKA8VJdVOTCehl9DZFxjV+facB6kXi1Ue4B3oH9kMYzwI7mzvnn2std42gFu8VTR3o5ZBXRa/8x41PAct8TCMFZRQs/3AWTQ57b4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742412213; c=relaxed/simple;
	bh=sp3U8H9H6FcRtylpSfqWW+tzI68zWa3aEkPvuPUj6/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugkSIqArtXJBPnCF5NtMtl47cSMNRBe6HF+DquLJ+9NVlc+r2cKSaxyCKlFq3p/hBGSQXIfL4tlQK4kwlHFHzR7izezZtiGgsG1idPbmsVj38rPvtqH2+Q2SfJLB0oZVw3N+UU46Xljl2QZgP/WBf/e9Y2mXUP0rs7nRSTI9G+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qeGOLX6i; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qWvpPFWSghZpx18cZKyIHWG1NgS9cWN6z3l+oQn0V1C/89RZh94bnmjvCrf5hg5RJm6IwlIeypVYYChFPgEc8PG2v7SfazhJAXKaZ2+HOahyymok6QY5XgVPLZfGvP8G+L25siTzlSzM1HcXmFuu3IB+bHFqO0Eum7mrkO8/N6ICqPUUtLuyKcv6uTQGa8ZwYnMUR5Amz071WZoAE2VOxv5/Son3l/67kI/nf+tS7Q4ZCHgDSrlhBZjKLoN0lhw/b3fseW5VJkDeZSFwA6Y2eCsMfzepEwjzZRwQmAPCpXW5evqdb72eCdumXj8PfmjWnWeh4WU0NOgNYT4dnsD9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+H8IxYYIa9GO9xurZ2fEGRkp5bA92jEu5XUKX/h7S5M=;
 b=FO8fdlAbAx25OO/NgOlXFEilYXqm7J8V3mF13OmFVU5ttqq7JnlZK94FLOUlEAw61J3lme/tIRqAuRL2Sb+7bWKzwMV+hO9TxhWRlc7l5bMLusF09f+Py5K+QM+niQIlCKRVY54u7gFEOXK+SROWsQS1kzmlD1XS3b9oGkMlrWsvDmGs7/eTBpg2bSB+nw7oz/5mWWaxR4bV9PFUyRSuQFOloYoiYIaCWaUZ5JHWWFzvvyIIMnkbdsZJosoi8LG8ReCvAGtSx5iqGVfgyI5jA4qwFjhwWWtSYmw+1GVj3OO8w18vqPnWq37HbubmDUjpfJVMgMzDc0WMiVXat1Ygqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+H8IxYYIa9GO9xurZ2fEGRkp5bA92jEu5XUKX/h7S5M=;
 b=qeGOLX6i7A1PxDVw91iXZDbU2fZeeIa06xpcZckcsHd9x2LVAiOseRt5bMrxZZ6ZvRCAuBTywUVryvJ3IDuKhICbFqSMLB0LFGr5+jwBmRzS0/XQf9xDW2ZaIIGT3CzWRPqoGkklOXnAmNXGw0IvOFhdIzWsSFK85zRbiaADGSI=
Received: from DM6PR02CA0129.namprd02.prod.outlook.com (2603:10b6:5:1b4::31)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 19:23:26 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::30) by DM6PR02CA0129.outlook.office365.com
 (2603:10b6:5:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 19:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 19:23:26 +0000
Received: from kaveri.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 14:23:17 -0500
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
Subject: [PATCH RFC V2 2/9] mm/migrate: revive MIGRATE_NO_COPY in migrate_mode.
Date: Wed, 19 Mar 2025 19:22:05 +0000
Message-ID: <20250319192211.10092-3-shivankg@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 300d8667-9e74-45dd-d7aa-08dd671b85cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kWnrc7ERbG4FxpzsQLmD8IqYETAHyIFAWNK2mLbzvqcLB+73Jj/iorg/oK1k?=
 =?us-ascii?Q?zal4e4nth2qqUCbi4gyccdnMHoFpB2rjZ3OXDpvAwh4AxiLKiwJ5DjD7EwiL?=
 =?us-ascii?Q?6YPS7eAXpcEE7jxAZDgZyQmggTplxGVwZXCgWuQABbapLj8vXdwtjpy4LT7q?=
 =?us-ascii?Q?odl/aqIfnles9xIQVqVZjfXYlzcsQH7pzE0yvkinaTYNy1xrBkK/fvCgufvC?=
 =?us-ascii?Q?92x/w128jlji+CmnE+5I4H7uAhFMNzeNzbRPI5O07vywB6/URGaEY2U+vE6P?=
 =?us-ascii?Q?o4EJFfeB+Mdbd2/8JGZoK8Vsk9JavWPyrwJ9/t3kbfMLZFOE7gOe1Yq3/xEr?=
 =?us-ascii?Q?q7bGXYbO8ebWLav7upT4zrOmCTUluLAqXqHJpvWgEFwhK1PmMWz884eOOwfJ?=
 =?us-ascii?Q?9MtZh+1HM2VJ+2UFfi7nByPFpNGXDfD/VXQGaOElYtvo2xKTL9EKt64c0aDO?=
 =?us-ascii?Q?sNGPv0m2Wvijw0afKMV6Pm6PTmeyOy1PVDhXP5T1VEz2BMw4Cz0S+H7xk/z5?=
 =?us-ascii?Q?1ndKfXeb8n1FKJWi3564Zdn6CvplNuRwOz0MbiCU5rdTpdfYQ31wCKSMMGCK?=
 =?us-ascii?Q?z4TDunMrQQYkX6sK8J16jhYgIEfa2/Hu0+QYieJbehAJxq/oSrb4oGvpp8K2?=
 =?us-ascii?Q?u3Cxt4wLX2a17Ku4UxBb831Zqn/66C0DyMF6+IrwTCun4U3jVpZJNJ92+Wrk?=
 =?us-ascii?Q?lNqBurB/RQ3g6zomdgqBGfL98HUTckSIH14bNNrnrEsOopb8VxEYAceKQ+9g?=
 =?us-ascii?Q?U0OBmA7ei4ojxkEcbjrGoJ3E1vuzaUAR4GH6uYpBYAYnC15vhMTzobsxYUUz?=
 =?us-ascii?Q?X4kjfZMvxLCqlDLvB1TUaJoN75fZ+G6dEkNb4Kjhp6VhL4IG93sNEuTY/L0D?=
 =?us-ascii?Q?FA2TZ+wSkXxj0C9WoSd7VnwkiD8PxM0rczrQRL7nwlsRrFpuXzsuxwsVuxVL?=
 =?us-ascii?Q?+GHveudqjhAPq9xZdx9Ba6GoJhzNoVozQV74SiUYCftChW+KoN4BOnYhBEYj?=
 =?us-ascii?Q?MKpwQuxpP+DVEWSHRtv9SJ/9YpGeGv+j5o+oCFK4huhjJoiS15Jh6uoI6yR8?=
 =?us-ascii?Q?ZpDxa58BxjOs9q/F7WebEyXcJmLD4IXu8hIpOEebZq+9YbBAUoa23MCvSTDw?=
 =?us-ascii?Q?EfoIVARkF01IqXuJOdgQJWxoPPHq2bXYZb15U64bx1/m4A8oKX2LjbxuBr6D?=
 =?us-ascii?Q?jEzNJZq0WIPhFOa51T8vENGLhEcpLjDZRQ63/mpKGOkt07jN8ljFRoZCR5sd?=
 =?us-ascii?Q?BJLlZR0FckmnQSWjp5oKxpUkS9n283MOjf/lUw7X+NOjcCgehAxU5Hnb1Q8j?=
 =?us-ascii?Q?sSexFLR/qB2+AfTnV1Z2v2NwrliCZgW6aUVZdx2l+TKWLwpRuomP8KD48Wzp?=
 =?us-ascii?Q?qizOYzxIW7qTdlFKSIoy1Il9S+DRSAjrxzlNkdJW508SdsSHDsUYKE0RsOLW?=
 =?us-ascii?Q?ao/wyO3Do7X/npGiCYA40kE2UAS3Fxjw/Z/iyV9yo7Q3KxwGt+A85kd/KDJX?=
 =?us-ascii?Q?DUrp8fa231+y0+w=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 19:23:26.1684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 300d8667-9e74-45dd-d7aa-08dd671b85cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356

From: Zi Yan <ziy@nvidia.com>

It is a preparation patch. The added MIGRATE_NO_COPY will be used by the
following patches to implement batched page copy functions by skipping
folio copy process in __migrate_folio() and copying folios in one shot
at the end.

Signed-off-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
---
 include/linux/migrate_mode.h | 2 ++
 mm/migrate.c                 | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/linux/migrate_mode.h b/include/linux/migrate_mode.h
index 265c4328b36a..9af6c949a057 100644
--- a/include/linux/migrate_mode.h
+++ b/include/linux/migrate_mode.h
@@ -7,11 +7,13 @@
  *	on most operations but not ->writepage as the potential stall time
  *	is too significant
  * MIGRATE_SYNC will block when migrating pages
+ * MIGRATE_NO_COPY will not copy page content
  */
 enum migrate_mode {
 	MIGRATE_ASYNC,
 	MIGRATE_SYNC_LIGHT,
 	MIGRATE_SYNC,
+	MIGRATE_NO_COPY,
 };
 
 enum migrate_reason {
diff --git a/mm/migrate.c b/mm/migrate.c
index ce7ddc56e878..0d40ac069cea 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -757,9 +757,11 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-	rc = folio_mc_copy(dst, src);
-	if (unlikely(rc))
-		return rc;
+	if (mode != MIGRATE_NO_COPY) {
+		rc = folio_mc_copy(dst, src);
+		if (unlikely(rc))
+			return rc;
+	}
 
 	rc = __folio_migrate_mapping(mapping, dst, src, expected_count);
 	if (rc != MIGRATEPAGE_SUCCESS)
-- 
2.34.1


