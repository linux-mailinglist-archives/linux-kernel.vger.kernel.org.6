Return-Path: <linux-kernel+bounces-432426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E259F9E4B09
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 01:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17AD1653D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 00:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AB4962C;
	Thu,  5 Dec 2024 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E2/RxZYn"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C49679D2
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 00:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357939; cv=fail; b=PF6ah1WT83SJwCNKn3P5VEYJqDvfLBCDjkpyg7IdLh34dio9Gq0yeNf2pnacZMo7I9/rrqIkWW6YpzrgBqUXZYp230UWj+DSwuAPZ6MeZI3v2rkKK1EhCZSogw1h5ZfSdmSs0Vi5tkuAp16WrEEjSyJtnXHT/CWAJf0W665zk24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357939; c=relaxed/simple;
	bh=esKE+xRhOu+Dh3D8Cxb8d7B2EDF2w3JYIMG5/wJ3OQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZzLsAAZx057yjurbjNZArnglA1IEbsWNTb8U87duImX0MQEWpmzfUE8qlWmCYzUUivCVu/y6RV8EUbfxt8vn2a9P8k3M7lcnF+rP4h3h8CVSH7EjhFR2CDPGP1CICmNkV81PfP4oDaMQyMjNAdp9drvTHWlxTTUgX6k3G/n+/iA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E2/RxZYn; arc=fail smtp.client-ip=40.107.94.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+OVIbXjN5L2B/bHf0jy5nPenVtZ/uhnGuTCSpELjN93oQsf88LK/ePL2iH/nlUMpEzE0N06HYbnIv3ZGnQS8IvckPo60nlDgnLA9C60vCzJ3FpWN3HB4znRNYv9EmQNr3xjzGxMoz4c4W63Pcq9qLTgQrOCMXLo7fQAMLVo2Kr+7jMRjd19augOLW+NIoy9S11zZc+xxzIknkFy2BgYUf9bsCQobU6hD2Z7P/02PV8yNauBPEaA+7zALVsuAQsWN0HfXya8Wp1AAQLtsHlzjo4hTk5Z9qvHEnCcVd0utIfdkqw77IOXWhdVpb9yms3WEwE+wp5X4kEqh6W6Kpi6BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxq/htjbbRs6vBjKE+Rb2qk9i5PlZjDkb7fkaknEWEQ=;
 b=pfiFbjnrkmSF16wPMDJRtEeez6Budke2f9L1ceH2u2YIlzOksgKxSPgJhJsmL19/X1a82hdTCXqc6DeMFTN0Fiw1ZZkLqg9DW6wnyTCf26/ivHOdPsk8cYUt5HUr9un/Aa8gAjLx2okSaHk8viDnSwOkJQFXkZ0v0/uk0q2rpLDU/U834hWeoBlB2dVKDFKutG1x5kYspaZxx+Iu9mTn6dNJFQEle3LeQBl9f138gf0oj+BrtRdj0w4stle1Gl+TO5O4aMAHLKsP2qjJGTSpVgOjjAkxDiJqjrI5eykjukES0vbmbrLmUjKP+jiPbqTGgECKGoTm/moI1JXEsDIzrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxq/htjbbRs6vBjKE+Rb2qk9i5PlZjDkb7fkaknEWEQ=;
 b=E2/RxZYnr3DdEs6tTLW8ENyOYHzHY4aC6taZRHsd+MMxUFWfQYnMPvUf1tjiV85Kba4W8x1ITiX7EmTWZxwiksJxL0uwczhR8V6DqolhTh5rkIRB6yLih7UTF2zOdHhunYGcN9g/aBQsYM4sT1L8hNsGOsiGW8lBJAVo18kMrWlI5sGyZtMKFro51pfNX0A6nC/DEh22KJqnqWgGxeUE4VA41Upb23Sq7BsnPff+M9/V72BS5Ttd2CgMnWcAo7a8VzYwUOnG/XN7g1wb3yHUlckC9A++GTfB+Yhm3HidB27tYjK7iPar9cPsCYpbnhOMnuFB4KDfyVyC+6zpWmjJZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 00:18:48 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%6]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 00:18:48 +0000
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
Subject: [PATCH RESEND v3 5/9] mm/huge_memory: add folio_split() to debugfs testing interface.
Date: Wed,  4 Dec 2024 19:18:35 -0500
Message-ID: <20241205001839.2582020-6-ziy@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241205001839.2582020-1-ziy@nvidia.com>
References: <20241205001839.2582020-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:408:ea::17) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|IA1PR12MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: f75e2074-40a4-497c-f60d-08dd14c263df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcvr9gTrsRvR8Rij58+lK1ZYcmV8TaKNXdV6yIYjmS6XwEV/FDNyGtHxiabF?=
 =?us-ascii?Q?52exnnBFygtP+t0K9oSfLaDMmI+izkci0lR2wsQzvj3JvEkYD7AROZPw51M1?=
 =?us-ascii?Q?9e/wwfg79+eXwhhrxZj8f2sTZ/8F8uTqtoVX5yEqyLXI9eb5isknKp280Cwq?=
 =?us-ascii?Q?OAQOJkjs1Yb+a4dwfIL5nt4zUKp/UpuHdMY5hXGe2wMle9bcgc/J2sbVGiQu?=
 =?us-ascii?Q?xLUYP9bGAXrOLT2herAmsW83fxf8qjDQn+uhauPuqgQ4Qi1yM0W1GOOSAqNh?=
 =?us-ascii?Q?wl4EpztRJ6cHfpOYO13GgKPVwrtZO2imiPYgklNfLt7Yr1+1JaB9gTuVNlZz?=
 =?us-ascii?Q?NDEFn8MQ61JDKLvaU1BpLYF9vMlWVZsNjZhJ0ibDgLjd8Etbr24GBLlEfNCu?=
 =?us-ascii?Q?NpvOVOs0g77MgCACsk34GEZn/P84z+VM1xW2Kbd+K/+WEZ249IeJ2MQq4oTz?=
 =?us-ascii?Q?KLlFFuPt+n2x+DGgVXXc7dhSIukda3SvM83jzACksOkAvvPWOS4TpEsEaisT?=
 =?us-ascii?Q?OxfxZOdqW9CbjMIIDyg1jBKPZmSbBD3Hr9xNFj+jLVJNv8++VU3Lwy5fc9g3?=
 =?us-ascii?Q?FSQxdrGqUu7IhLoF9XOuDx7uJrHrE5w1QCfOMbrCdNM0m0A+qtLE753BhBEA?=
 =?us-ascii?Q?VhE0fEYOSAQSwk2eNuFNDMB4ZZN0y6XHXBiUAkd3FgOz6j569uox8ZRQvYam?=
 =?us-ascii?Q?V3sL5as3yX7oMWKj5u08KuKuBa1o3LRx6tbhcLcpxyM0rqJOzPFPWSzUu2hj?=
 =?us-ascii?Q?HT2zPJ1ypkb9ZnaHsc40w7ocelicWWZ54IBEu4U5ORXyMha7AWR3FASVYR/p?=
 =?us-ascii?Q?JHCyu6d8MVyKAMIr4O0bfJcgBsPQW+IP7Vx7i2Kit/2X8K5/cJCQlVchcDui?=
 =?us-ascii?Q?NeQYtO/TI3tYYvGmQmFHuQnrI7kWuEGoLn62DfIH5sdr+mFuOyH8r4YWpiJ+?=
 =?us-ascii?Q?rR6WrLfmC8FaeQPHeWczS/UZxeP+tBH+5CBp1G1jJjsGR2Rwla4bIao84fPe?=
 =?us-ascii?Q?FgfiWCk0mc/qeaYqg4hQEnfx9I3+YcT8fuiIzMsyL20SmIsZz1m+GsX6/g12?=
 =?us-ascii?Q?3FHEKMvt1c4IZ5g4v4VqhTMmMWBJ9LkCeu2BlxrRGeb46cZnnBbh3JsIyxIL?=
 =?us-ascii?Q?TWDhsxRtbjpXJKsSQqB0d2iAa/3yezrydrKmUjeMc1s2ewBdma2iYOl3TmIq?=
 =?us-ascii?Q?57GJ5OghSOKhZ4XEaYIQPowI4ODJREquCb1tWtffniivQqIOacVLsCZKMtA/?=
 =?us-ascii?Q?Y0qmjg5CzLRMPD+7/r04x+GR/IjV9J+VTh2F0/xF9+Di9qnh7+C5EmxIFC8k?=
 =?us-ascii?Q?O/ZRd6L3bwl5J4cSnSwMdFBUTXOUHSfWD8nkZAfvdu1Z7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R0URncAtiweNE7zq9b3E1L/MfmkLFw1u9uethL3oypOuHJxqKYmlAD9ysYGa?=
 =?us-ascii?Q?BqZSbpvS2+o0Ip6aWSkYw3pOKmtyoDskRf6N9Q5iIYgGwe2wfmxaeURf+wmr?=
 =?us-ascii?Q?IseSBFEIJ+DmKD4KDUWdQqaVJyHPH/blNbHs8J+CeXbB5y2QpqUkhFRKRfRh?=
 =?us-ascii?Q?lbw+U6sXZLzJe/Y2VOYn1cvywMnsploFwAHrs3vJII15IvZxU7YEI4r7s9XW?=
 =?us-ascii?Q?/oCAs9s4iwLx7/rtwqjD8W/GXsd2P3SRfdNnki3MJvdWgAQXas48KUdC3b9Q?=
 =?us-ascii?Q?1dsj6nsSlWvgBYpxKzyw3qG58UPLMKw3n+NqTTZpfPVdH7K5dKykbI4Lyii3?=
 =?us-ascii?Q?JLgvr+CyFFh/n5XqW9qvip/pgoBDR3odZvCjIQ3vHi6FZdWrXz7b+irltqAG?=
 =?us-ascii?Q?QueeUbjMfq07addHRErmAcaegLRNcROcVzKKlxv8L52bHx6+QqyoLt+g8rGT?=
 =?us-ascii?Q?JuU5kLY0OaBp6RW1VnwbUkVRHa8oYjxm/EAoqSWxFJI9d4P0Bi5ho2oAlILn?=
 =?us-ascii?Q?C4ucy9f+DF31W+GeMEb7hlJa2XFtIsRUp4xBM6zUuxNMobbg/NTZeCkX0gZM?=
 =?us-ascii?Q?zaFK8qqLMuaJLNyms+WbWdkdTpzUmx3sOtcSBTMf+eIjDucEP8PIfKgXCxG/?=
 =?us-ascii?Q?dbgHkhMdbSSArhtMidVyvKQ/+ubiPm5Xodz3CSBY2lz4FlMMdT7li7mDPK1E?=
 =?us-ascii?Q?dfuI2GBp9MIy49o+jthEck4XGkOAcI03ftyh8JUGxRCvva5xX4hOr92S34xx?=
 =?us-ascii?Q?dnWc5NirPkPSWmJtV/SRev1epZRgHyY28S+10Kiqqni0J6Sx+/sq40Dm3o7A?=
 =?us-ascii?Q?u7Btu5rnnTKf/ssOy0bunoELHj3vNcsoVgKv6oiuPLFp3hBoJpZyN2XKfM5E?=
 =?us-ascii?Q?SMvqQUiHel9T0vVRqilPSnAo2daw3qK9Dsy+5a0syCyXaXSesqxxwQeaWap+?=
 =?us-ascii?Q?iCXr6hgJCfI1TbdGgW97TXijLTKr6zMGNfdgKhcHuq6KECNgRNnaOIqEA0ZD?=
 =?us-ascii?Q?vZb3qaEU4/13EQzGHXhLZ8sCe0Hh17ou0jeYh6CSBfONEznubLta0uahUJCy?=
 =?us-ascii?Q?7QM+vTcx7oIxplzblbdEZ8n5mV+1ls4Igx0X0kyDTkeRH6szihf20v8djclL?=
 =?us-ascii?Q?7WuovjwIdQFSLFjiz85rcrl9lYKRd5lx48Szea1BDnXchk4INyqBrLGIvhww?=
 =?us-ascii?Q?lMTYP/SPdrTOc7N3DH5sc/vUgCzJNZL40rxrVrnHptjN226sO0NEqejUtJfY?=
 =?us-ascii?Q?WWiQCwnpYudeFD1lq2vzBo8/qAuZaG/ovxVG4LF53cKH3LAmjvtXz2OxuZAn?=
 =?us-ascii?Q?hGPCnP0mjB4AFCzCWC1w9noorTYdp93tmrDZDlm+ayBaMJW0eDYOnXOy77u4?=
 =?us-ascii?Q?T/RrT3yRcSfnIj7oLG8vBUDcjK7gE0vZyAu5kcM3VhqSuVlY3Ji680jpXG47?=
 =?us-ascii?Q?o551zqeVP+KOQ04B5uyYWaXw9YM3ZvMA+7Etca3efcAq7FlU7ufzjK5QA1Fx?=
 =?us-ascii?Q?C2+V+pa/lSbg/IA845od+yvYSwU5dx3med+Vuu4WHU7YkalNi0DvJjFOqiBo?=
 =?us-ascii?Q?LWnQgM1VE9QP3Dp8oT7BWt3OPfAmBkfzbxb/NlmH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f75e2074-40a4-497c-f60d-08dd14c263df
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 00:18:48.9246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U7wsB7U+JW9ht2kVHgKFmwX1CR+PitJ3DJ7sFHid+yn9Vl+6kNy9yNmhu8jZl6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589

This allows to test folio_split() by specifying an additional in folio
page offset parameter to split_huge_page debugfs interface.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eed4ff97e235..d6ee18327cae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4141,7 +4141,8 @@ static inline bool vma_not_suitable_for_thp_split(struct vm_area_struct *vma)
 }
 
 static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
-				unsigned long vaddr_end, unsigned int new_order)
+				unsigned long vaddr_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	int ret = 0;
 	struct task_struct *task;
@@ -4225,8 +4226,16 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
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
 
@@ -4249,7 +4258,8 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
 }
 
 static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
-				pgoff_t off_end, unsigned int new_order)
+				pgoff_t off_end, unsigned int new_order,
+				long in_folio_offset)
 {
 	struct filename *file;
 	struct file *candidate;
@@ -4298,8 +4308,15 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
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
@@ -4332,6 +4349,7 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
 	int pid;
 	unsigned long vaddr_start, vaddr_end;
 	unsigned int new_order = 0;
+	long in_folio_offset = -1;
 
 	ret = mutex_lock_interruptible(&split_debug_mutex);
 	if (ret)
@@ -4360,29 +4378,33 @@ static ssize_t split_huge_pages_write(struct file *file, const char __user *buf,
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


