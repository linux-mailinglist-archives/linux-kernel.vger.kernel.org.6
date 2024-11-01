Return-Path: <linux-kernel+bounces-392427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6489B93F3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 16:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFF191F210CA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027571AA792;
	Fri,  1 Nov 2024 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dz1dhLtT"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CA81ABEAD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473471; cv=fail; b=LCrm78G4Nrj5fGStk7T2YdD5+FO8IHIUppj3N3WwGlibuME+Jmh5pAR37MRY39OB9fWb2B+2yxrFIZGXr4g0kxqV73z3NYQgVY5wH7jEuVgKbuWNtLtPSa0xRy/ISV7ut+8aCFbbDlU2fCkGBXhPDloC/FX3Cs8qmeRpsmsI2TM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473471; c=relaxed/simple;
	bh=1OJszN63K+B8qcqQWeVe+rWUqKFZZV+YE+ClpSrDnew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1w5l1AFrU+xrrIcBVP4lv4vUfpSOsex4i5ipRpkDuWi3qqm3CtwLBpYNX6wLuiPz5uaBqXJJplst2tsyZZkPD8aua6eIBGuwh2OReg+LQGronNkKbTg/7cluipXzo/GDWVQnT4/6mIeOqserPNIz9vjYVytZ1z0wNeUFkKc5D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dz1dhLtT; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQnj7ZDygmp8h/mj30v6Qy/0m6tlq8r6v/4BZ8XjbbtAYKiAfGpKajX+wXRRqvnnKse4xdlZGnmyoYgHC9Wb8m2zsKKEqlU5HXq9Uy2E7uyntXpZwq0WLluuW22X55xImD5K6kb8Pr7RcQwq0cyFS8uxTCeaYB4CB5KcjGSwxWoOPpMCIg6cAMBAcbcyfsBGyGrUm2hhkDMQfa691KAUfO1FeuRhxU2526OD1HOmBk6H2oTM6QAXCO4exS6x3EhqunlsBDD2aJ9lo/0/UB4sMFr1/tPA7ab/h8nBA1bBYHwmuuX2Q/KKxtwVSS919Qcz18E93Fel5RlIKY+CJLiwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBVeuolEa+O1KRTMeV6OyPyYPynOukZYFHHM5jLMtFU=;
 b=StTe88+Mr2y/W0vPEVCmqgleHduGRs66ry10bcatjFC4leLamxrSforYxZlJ97Z7OS/G0picClmlhNHfHimibNI0nEJvJQyPTM0tv9S3GkJPI63Yl3ilpLIebsvbtDjxe9JVS6T2v7OFWyq96bvi+ycz+lkiLqV0CMX+oNFYqadT8zxk54pqjrF1PI8031eMnQKgJnq5BapdT8JgXgvRhPXNl7FkGxgqZOz1tTxsQEePrrtLuboC6t5OhJYoimlMP3KVmrsS82W8m2XUvCGujwRyt1FfH5obw2P+N/Kd04s4W9hhakDiv0Y9zq8dxu7qZTL/iJ+y4qhhx2SQ/Mg/nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBVeuolEa+O1KRTMeV6OyPyYPynOukZYFHHM5jLMtFU=;
 b=Dz1dhLtTXAQTk/dmWI7mA5nFyXAxjI4Q1aouSFwJH4mjE8RjGdzyAPbYEbm91+6yPy7ag3rWpG+U1xegZY8VsKEB8PxXEUixV9IhtGVtDfPsbu/UAfLiIoFI17aMGawHORCURscXNlbW0gIM+j+EIr/Nh5P28f8W39a4827bcdmXJjS/FgjIfkaCghjecGnfs5fTtpa1S7ZNu3dXyemDxz7gadSQOVSUWQ3VSIx/qDz56btcO8VXrJckk6evXaKcPv8yAHBfsqXa42SG9H+eQLIDN6kN3i81Pbe3YlelIGRE/X9Q7xXpAGElMvAoDtXBN+xLYy4d7XH91cOYCeAvGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY5PR12MB6621.namprd12.prod.outlook.com (2603:10b6:930:43::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Fri, 1 Nov 2024 15:04:15 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%7]) with mapi id 15.20.8114.015; Fri, 1 Nov 2024
 15:04:15 +0000
From: Zi Yan <ziy@nvidia.com>
To: linux-mm@kvack.org,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Yu Zhao <yuzhao@google.com>,
	John Hubbard <jhubbard@nvidia.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 5/6] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Fri,  1 Nov 2024 11:03:56 -0400
Message-ID: <20241101150357.1752726-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241101150357.1752726-1-ziy@nvidia.com>
References: <20241101150357.1752726-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:408:ed::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY5PR12MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: ce708f5e-7615-4d8c-a958-08dcfa86734f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FoyIBZDO7BdEpcDp0twe0uAbBbGRkp874e0tWn9d93XX+qmURgiB9DNT6W60?=
 =?us-ascii?Q?qduPSGb3lrhR+e8U9Cndr3tvpXwee1csazRWSYLhBQy8IUlAXCDYhbK9ohYO?=
 =?us-ascii?Q?HeLim/m772OQ1GSQ3atN3gAQ/FvfC4SkL/FALoSMJ35fNH1OCgQXafpiPgL/?=
 =?us-ascii?Q?0ZRcWLKrNwx9emfW2NWZ+L0I0cme/sf2mRlyOclHgXLfV2ZYWQ+B/dD8aARN?=
 =?us-ascii?Q?DfL11ckK9WRoEH37UVvZAaQ0YJotK+d1O0jVPblYoXxHaPMcM/RGVv2N+pu7?=
 =?us-ascii?Q?uiZ/0gO8PwzYqOC7PhZg2CNzZ1csfsVHDAH91BUxxizymnJ4f7ththtWEd3c?=
 =?us-ascii?Q?Hbs2u0rQ2b5lNI0qjXWCre9a4VoIbuxKtUGnBH/pwh8ksmNCmfITGHz+Y3Mk?=
 =?us-ascii?Q?EMFz7s3ALL1oMj5rL2nRnWayqJIwqFiDOzNXzh6JK9ZYG8WPNSKRp1r2mZoJ?=
 =?us-ascii?Q?2hD/9Kl2G6fkPADqFdbpNsi9JqCDIFAaLOxAx/3UTPKBx/jwDooeJPKhns+C?=
 =?us-ascii?Q?rExXXCnswXGnTHwfylYSO17ai5o1us5fRQD2F2qXmlTAWJXjWWQoPS0RL6GC?=
 =?us-ascii?Q?eEgR2QSI7uj013Pb6n9IYHHKaRcW6tEtC5AT83ks/YX+s7gjRp8+Oen7+59U?=
 =?us-ascii?Q?9Glt8744zuDtT527unnbm2KkIosjUgeOklPZrv64v4dhCaK1/VFYhek+8+GW?=
 =?us-ascii?Q?z5MWi5jJ39z9iQLjjiwpaLeFoECWP0A1NwCRyu0rwAIBQYqoPendOJl/0prH?=
 =?us-ascii?Q?S09AB4AslKhsyZA3l1fJ7wlIVi/+Gc9t1SlmEhWfSHAxTkCoBO6/JEAHPgLJ?=
 =?us-ascii?Q?Kd72v7gPzvYSJnA7elGOBGuat5fMr2tptNDWfoukKA1tOkN6hUo56Gz4yocL?=
 =?us-ascii?Q?FjwqTnDk8UEmZYNIlI+Tt/mwPQhR7Pv54XwC5rXfhWOXgTQx8Bgryg4Cg7Lx?=
 =?us-ascii?Q?sALmVUOmcbL7baBldKm18K511W3Rl2IQhU2NIGO8QosM7yncK1vMyeyhvTD1?=
 =?us-ascii?Q?WErIHmak27Yc1GUZMtY1dut5QPMveoJ9N46rWH4idxqe1UjqvCIVNhCp1PAm?=
 =?us-ascii?Q?zaauN5Rl3DUF6yiJ1r9rFMP1Nnpqyg+BIB9IxkLJIOr2svmXIaX5BaIwB3Wj?=
 =?us-ascii?Q?oUB0aSAxO4CovYvNPDG4VBURphCY0B/4P+nw0irhAGmsFFrfg/GEqHVCZQXf?=
 =?us-ascii?Q?5JwzM2ShQz1zLNmVoHp8LwAHk6U0q96mtgT9wLiAZKgW1ji/nKkmSqAZfHJx?=
 =?us-ascii?Q?gKpm+lz1nUFNXRKac/bH4RsuKcgNdkewPIqPMDxJWYPze9hRb5x8z6blvmJ4?=
 =?us-ascii?Q?xZs2wjpZCMMZjywj9Oe6Dgc9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e+vAXa4ZygGn6rI7M5GWRwVTi+CpxKcUInyzqpuWNy84isFGxmK1W7JYW3u5?=
 =?us-ascii?Q?mEU46+Nd+JXRglpSyQzQz6ZN9Kgb/pkkwB7EZdRSrBJ2jiDsaWueSwAOuEJF?=
 =?us-ascii?Q?LjLyYNGg/Kb7qMs/6AWxpGMRyIq7tMYxXMLLzPuCwA67zVnLbjfSEVnJtFDr?=
 =?us-ascii?Q?lGj5Q1Oo0NmHeBXgZQOVOtUN/MJ86ww+Ue7VjYXFJEbSsnGHTFgvBw5VOVQf?=
 =?us-ascii?Q?KkLdSMCd0ze2BfDGGQPU2vqKlCg3cR7dDSLa+sU6djvG9lxYVyeRlqw3NP6U?=
 =?us-ascii?Q?OseXCndiv5Q37enkLL1wtMAG4x1Me30kqfq49xONjpOgKZj6LkCHY+alEkA6?=
 =?us-ascii?Q?Yy8cbq3rGQb2sP6TpHHZdmChoF1mr2+UQHxMh5owEHMaxOj3k666BS0AAf3V?=
 =?us-ascii?Q?NkI+0n4Pz8EFM0LRypnOSDY+0w3RIqJojwN34ySww4cl7ZCghK+pXlrvPHAR?=
 =?us-ascii?Q?LcfOdwa//5MiCG05+C8dKk39QHFu5grgT+pxE10BZq3ugVbr8v44Qv/wYO6i?=
 =?us-ascii?Q?CuEnD0bEY9WJfvdEqf/gRQExxs/wcNlbFKetFpkx/+FiUpJzsn+zinh7wItJ?=
 =?us-ascii?Q?6P9mYHIwLzHd/Dp8LBo2NU/yyW3OSkr4dD2e+JQE36jemQfpFV4etWrLbkEB?=
 =?us-ascii?Q?/wjlJvvoSsj2MWQzu1w/f8nxtpNrNHSvXH3ilcJb+X9UWv+g17AuAGDVINiJ?=
 =?us-ascii?Q?yI6F2c3okRF/2uo3QASZ8Bo2DEZBc+KSyy4MWhJMLL99LqkCbuwZNYlJw8sX?=
 =?us-ascii?Q?HEKb8+7rLcq/I7ycaExIMS/c+Xu45z228rF7rqMFkw9f9eXV4BexwKNCszUd?=
 =?us-ascii?Q?aWcWZ6cSq4+uOOMxi/Y1O+oQ7qXczI5Y4GXHoB8bDyBBSPwBvyLrnqrt8EJN?=
 =?us-ascii?Q?Vv+Z8TcC4Bdrueo7XasM4/Wq+uG+DpQ2qYUp3zh/wjpPTs7YhtjcZNBEcUb6?=
 =?us-ascii?Q?/NXVP760hoS/jlChUIby69vl+r0WuzVNJ8Uezul67duCQZvG1d35fVtoCxyl?=
 =?us-ascii?Q?ES5R+zXjDETC+/Ketn4W692kWq1iPVu8E/4lFM8riZaGsruziw698Iar34Fl?=
 =?us-ascii?Q?4P7KYoLjsbKk2xawR1WOuyCCDfZwq2f5lUW46fp66ezzdn9teH7nwRELccDz?=
 =?us-ascii?Q?4I9LJhQFc7YFMcSuzuqBOBBO2fUy40huSD/Jr6ZYy9Wl2QURjFrpJtZp0aYY?=
 =?us-ascii?Q?hYSQggvIh+Vz9W5VikBXdlsdB088JF5bZLGViAzcY7bRwOtDAw1mqoXOt9hG?=
 =?us-ascii?Q?EmvsuKIEOQsJMdnjjAdBf7s1A498UhIiT1TnxW5mqtjwO8OYT62Ub6FNPw2L?=
 =?us-ascii?Q?hQOW2MpwXlKHFazF35I1Jfm7nPMtJlginA7tEb0Rxs+36T+dbX23bSyH6Wew?=
 =?us-ascii?Q?byl5AnHC9EevgUKEf+IJLCVJXmPwAzkJ9orntRMUyK3Vv6vfUdmBg2OeT/b2?=
 =?us-ascii?Q?LqwkUqIjP5ks6nixHW6KqdielAihtnaOUzOq+m3kZAHHitquvL8uDiSXGpud?=
 =?us-ascii?Q?H9GG2cJnVCUcOsrnOjwjvJ6z/DluxssHOBlHt/Mc2JbODyATTgZFPB7909nw?=
 =?us-ascii?Q?sjK7SqvUQQQc6wtvqKyXq85lZC/rMwXnyYCTwS3s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce708f5e-7615-4d8c-a958-08dcfa86734f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:04:14.8298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugqISsVnHsr9ItUxg7u1BX/sPEzvHbo3DjH/+B5fhpjUvLTCTY+C8XkOioM3pCQe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6621

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f5094b677bb8..1a2619324736 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4114,7 +4114,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4198,8 +4199,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 		if (!folio_test_anon(folio) && folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 ||
+		    in_folio_offset >= folio_nr_pages(folio)) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 
@@ -4222,7 +4231,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4271,8 +4281,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 		if (folio->mapping != mapping)
 			goto unlock;
 
-		if (!split_folio_to_order(folio, target_order))
-			split++;
+		if (in_folio_offset < 0 || in_folio_offset >= nr_pages) {
+			if (!split_folio_to_order(folio, target_order))
+				split++;
+		} else {
+			struct page *split_at = folio_page(folio,
+							   in_folio_offset);
+			if (!folio_split(folio, target_order, split_at, NULL))
+				split++;
+		}
 
 unlock:
 		folio_unlock(folio);
@@ -4305,6 +4322,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4333,29 +4351,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 			goto out;
 		}
 
-		ret = sscanf(buf, "0x%lx,0x%lx,%d", &off_start, &off_end, &new_order);
-		if (ret != 2 && ret != 3) {
+		ret = sscanf(buf, "0x%lx,0x%lx,%d,%ld", &off_start, &off_end,
+				&new_order, &in_folio_offset);
+		if (ret != 2 && ret != 3 && ret != 4) {
 			ret = -EINVAL;
 			goto out;
 		}
-		ret = split_huge_pages_in_file(file_path, off_start, off_end, new_order);
+		ret = split_huge_pages_in_file(file_path, off_start, off_end,
+				new_order, in_folio_offset);
 		if (!ret)
 			ret = input_len;
 
 		goto out;
 	}
 
-	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d", &pid, &vaddr_start, &vaddr_end, &new_order);
+	ret = sscanf(input_buf, "%d,0x%lx,0x%lx,%d,%ld", &pid, &vaddr_start,
+			&vaddr_end, &new_order, &in_folio_offset);
 	if (ret == 1 && pid == 1) {
 		split_huge_pages_all();
 		ret = strlen(input_buf);
 		goto out;
-	} else if (ret != 3 && ret != 4) {
+	} else if (ret != 3 && ret != 4 && ret != 5) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order);
+	ret = split_huge_pages_pid(pid, vaddr_start, vaddr_end, new_order,
+			in_folio_offset);
 	if (!ret)
 		ret = strlen(input_buf);
 out:
-- 
2.45.2


