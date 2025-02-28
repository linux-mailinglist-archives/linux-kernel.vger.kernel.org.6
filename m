Return-Path: <linux-kernel+bounces-539098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1737CA4A0CF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F451899E48
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F40619993D;
	Fri, 28 Feb 2025 17:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GUZm9bPd"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35FD1F4CB1
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765003; cv=fail; b=u1bwZxYz9SF9DmQiG4qruUjx1Ph9ynQOGv5G7TK3qa5BbjDTAmraiSlVmOaTmwSac1hBsbJpMtr7z8YNbmBTRlmJ+ML2nTh7VfwheRbrNMRZMHCR7Lv/NXD+WxD5LDigfrMTWTwCpLl+5opzF4FTb92krszVxMEfBbw8gku6Vik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765003; c=relaxed/simple;
	bh=CNAzBAG+zQII4LjOfwC5Zf+DQiuQ9iWPLmsEB+Se77U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uhBr6Vvz/KcBBcd1W555qsdEYnu8P4IraGwOiasqez0SVdoXkSH8sAFkREoREssorFNGgFKofapzJ1yn/q4GviTsuR11sZMGhlaBQxBeTfZ/uG3MoRjYFSMb4CIpBc4P8ZA8RNFrYyKi1BeE8dELbigu5P1K05jxwvw+8fk8qRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GUZm9bPd; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzDdTlz5Mo2QHWqifCZdWvEIRdm0LrQkNKoqVHK1+zDQJ2KNb7CKg0cAmzuCO6Vfs/QP+gg2CamW+9fJGxuK8UJaMP8elYNWS9y/FVSua+VyYVWd1w6dWsye5e2sXOQbsWFyODDKOUyZvIMlnIkG6SI/Nkm6C0eAOabKhm7mS4EAq+QSAlnX5eAYWrFlAwqe74ZxMQexmMD2vH8zEUrdHc65SHd3r9kMfTYOCgOXQfRO4sRP83FLDvEBCm2YL6Ww98LiDhWxmbJdGeiZyZLG6KUMqkAHCGqBZzknduE4MUmVGIijaix+8NwVOP16W+PFsFmmll7jGIKbetJQXAAhSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cR8+bIIdLQcn9hdN5ELhP92PrX3p5+U/lRHrt5yWPq4=;
 b=dV1nQ3NFpv+4acigKsUKI9dn31xwOz0jY4SbPDcPOqBObnwCiRXFPj1VFn3Ykh44Z5+8bB5LDWfdhkjTWPW58x550BxXG8u4ls/DAw4lCCXd2/b75XdI3DUX/xrqomKH+DqXz6k2cPidkqX0LgYv8IXwl174mUqgvyLTLBQmK549SIdoHnsh1qydKENnH++CGpnQte360ftp2CTk30tI8QOvZcTk67DTVN5yGXXqx8WLag5BVlK2rU1tcktzN+1cPd4HiTo9OKjlJAEeYsCTXuRO7yvSe/C8xctQ8OiJvIk63E1N3olJDa9JFToVX+MhEyTQ56j6TerQ8EReSgynGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cR8+bIIdLQcn9hdN5ELhP92PrX3p5+U/lRHrt5yWPq4=;
 b=GUZm9bPdhWZlJYckNYuO5s4AN7aKlNrNqXHLDD2sWy8aYBI72BaU/0r8hE7Uxe2dZImlJa5FzpDv4CY6lUGJHPsh1LQh7Scd+4zizb4ZbVlNGqqaYiBS4K0HoQVmedVX1oDDNp3Pd/RkatVpjy2hSToc9npY/xGf+sn14lg4bsCrKrldeMZQZxr+SvaCuHYEDEJxZzVFCwxA3zPjqQ6zk8nIkuRdBizwmgmVcITyYakwOZP0eCtH02JbsI8BYvUSB3nXe9dCXRraXywJOtO6vP5jbDf0DQ2DiHz3zTwVKeRX5R8V6Pxrg2AwsSwbqAmuwQM/E1LGPvZgycxWAA0c7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.22; Fri, 28 Feb 2025 17:49:58 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 17:49:58 +0000
From: Zi Yan <ziy@nvidia.com>
To: Liu Shixin <liushixin2@huawei.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Lance Yang <ioworker0@gmail.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Charan Teja Kalla <quic_charante@quicinc.com>,
	linux-kernel@vger.kernel.org,
	Zi Yan <ziy@nvidia.com>,
	Shivank Garg <shivankg@amd.com>
Subject: [PATCH v2] mm/migrate: fix shmem xarray update during migration
Date: Fri, 28 Feb 2025 12:49:53 -0500
Message-ID: <20250228174953.2222831-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:c0::43) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB6659:EE_
X-MS-Office365-Filtering-Correlation-Id: 82dbe63d-f232-4167-0592-08dd58205123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtJbF/YzNifP8aoiFcrfuUhDB+BHwj5/Vv5kkJTLwdsTrygMbaAbWjnDDb7N?=
 =?us-ascii?Q?WyhbE9aEm60zoR2F735Lc6ocdYWdBTFz/EkofMfb+AJ5kFYWn2uBLd3chzCR?=
 =?us-ascii?Q?InG+XzzhtS5MoKmySnlZ23Ch6Pymp7IdbYjq/PM0c7wPKYrVCFpq5oGQBOar?=
 =?us-ascii?Q?nJa/OGuOUsBR1vJ6sVIqqJiHYKb9NWGFqozj/Q6hqrkiLmudmiCpb2B3YSTl?=
 =?us-ascii?Q?U/G1A+xESmJYVT71J9vK0O0D1WJPJ/KMYvjaXy2fKibEVBFfCtEDF3myOxV8?=
 =?us-ascii?Q?AirNIDKzNuFBNN0EItUCfU3A6VkDLMQ/PcuT6/PiLej/nQKLnbeCoZy/AxBQ?=
 =?us-ascii?Q?4n4gUjFflpEoV+S5VAyLBUbVEBUg5oaCdzcoPR1xDlpHARzLmoRiMUHvC12L?=
 =?us-ascii?Q?+kykymc/Lw1oYYP32gDpArZKceSuA5FWmv7GIcAMvLDWnItU8nqYwPyH8VzD?=
 =?us-ascii?Q?Hv5yP7OsY3lHmELFxjWLq5851CBa77OW7isJvK9saxfZTAmc0CuY0VsJjbne?=
 =?us-ascii?Q?KE79X9cFygVS65o3QqJbcWo+mtgRCukf3gBdXE9pkXV5RF3n53cDQnUkoibJ?=
 =?us-ascii?Q?NjEPGYWx8XBJrWQh5fSkx+A5h1TnM39/0MwjyHdW98sfCVE39AV/ZvhNMJ8s?=
 =?us-ascii?Q?uYi3UFLIIJJp4oxcnpiebE7GtNVSmcLlmq1bIU0KjaX3x3wayWh/2KLI5GPL?=
 =?us-ascii?Q?DlIK6ECTjyYrZbJM9SN0H1DQ2IMGjYqJOsHB0Hns1SryQSagdr6JfWcykUn1?=
 =?us-ascii?Q?RpyXzKn6CzzIV9ACEXSQEI6sSRERiHc957QOcPJ6I7o4K08kEkrXtIq8H+ls?=
 =?us-ascii?Q?pkJUioy9eEFqjN00JJS3eRhWCxBBlSzf0t+gtfQ1N+22zNlJiI4thdUgTySd?=
 =?us-ascii?Q?RI/aT/4OxcGlGfdP6ZNvToOpZPD3pOrh/l39nGdtTNMD+hHgPeMO6VL6tVaW?=
 =?us-ascii?Q?b7xcoux577Hkk0Q/PF68UnLE7lMdUq+ATyDnUGRz70jCQB3YvrklWqOJYPKE?=
 =?us-ascii?Q?fcaFIwj1V3aUWRDkUAgwJwk7MAcQGlU7Z0l0I9TPPaLFQA2sIDE6X4XVriJD?=
 =?us-ascii?Q?E8qr4Bvs8vLndlg2tzA90dmUrXs46KAA0nNAevczT4n9AGYTT7b8LGBxozoI?=
 =?us-ascii?Q?ZP0Pw06O0LH78mH+HNVNcuVZUffdjyOuXiYpHZWF87IvLXGLzqIalgAFEiRd?=
 =?us-ascii?Q?uEO5CwIyu9BVN8+8zlAg04sy2UjBdN/uJQkakQSBaN2Bx4/nXQQmoz/1LAqE?=
 =?us-ascii?Q?XTsBYDZ6SRltC+/8omZx3WxrGm9E6IpVzvWtkCTo3LLvyp4Zs4E/1n+EZ1uS?=
 =?us-ascii?Q?xEB9NKshDON7ql1CEchyohxJHSWT0mXhdevfLCRgTzKh6yczW0xdwHdWxJU+?=
 =?us-ascii?Q?ZxrcP0gjjE0qBsLizZP5oZM7ZJdF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d8wp8/1i2w+/A61nz+q4UQTkJLrsBRfJ9EmOj3x2o+MpbuRicKl4nFDJLBeR?=
 =?us-ascii?Q?I5C0bYujx+15whqrUCaB2pN4iMpRPUpNMdu8rPCMR5vWOc/X4ghMm8f72VU0?=
 =?us-ascii?Q?g+z5vFWbgL2/iiQpzTADw/MpUwzwQbB4HjWtCJL+PSSduMjTGJQaf9h0Z0cx?=
 =?us-ascii?Q?2XlCCkCaOm6UxzutZPh99SaAkN6um8oJ+AuX0CYS4P5I+5ipG3zhpWa3qcFA?=
 =?us-ascii?Q?0QP8dZksRQhBwJN6mEfC5Lj2YyOaBFvOBJCSXjKZdnh6s7Olbsan4+eHUy6N?=
 =?us-ascii?Q?aPODMz6s/6Kq1nGVLqPPi6VgxygdgtxROC3TjLTCglbsTtgPsnycHc+dGCEk?=
 =?us-ascii?Q?nTRrIxQ6UoysXfBOjxjnS9PseztwZePG7LrbDjKFXEqydDzjh12R8Rwyc+81?=
 =?us-ascii?Q?+yTeD1ax8/rGSVV+qaYRTJ1H9CxyZAa51kQe32yt0RzLxl725kUgkL2nA7Xo?=
 =?us-ascii?Q?J9zPpzglzgqxEqI6xhVwkCmXhLC6q7XQpJL08Qdmrq2jt9R3yvsYaXxD8q/Z?=
 =?us-ascii?Q?97RH6ji0aFCpTasNpt5S+NWQcRs+hKoABL9BJTcgWWmUsetoG2ElF4V1TClW?=
 =?us-ascii?Q?EsTNPwEWGok9SG9Q5mOhDlnIDgZwDToVVOfcUCJ4K21AXiwmXAiLfpoyTF7H?=
 =?us-ascii?Q?Y4tmHKPXZgv3cr2KD+QEjJz9YegzX/EUgmjBuw1cR4c59gk77mvHSEDcdymn?=
 =?us-ascii?Q?bRBTVD77zHWZLlOzetpbp7dThvUS8eIUlytHmJN4RP0XDZ6cUwLro5FTVW4j?=
 =?us-ascii?Q?OlHgFBNikhx8/LIrKl0RfZQmMGtd0JPWwoZ5+DTq3Id0tqNMyG5DNfTJUl0m?=
 =?us-ascii?Q?vGjx7rcv7iMuMMNbyOdJeOB9RFsQlbwSmEfDTJH4AX+5r8+U00pZv8uHS/p7?=
 =?us-ascii?Q?RPMbCdLrZ1mQui6vhrpvCbik+Cf2WTOBQjTu8JQ/XNUb2wLaThf6t4j45bc0?=
 =?us-ascii?Q?9aor6EbmqmrFOQ1PnAtQXhvm7818wrO5ubW2LQXusjuJVs9TMTleVzc0wbdn?=
 =?us-ascii?Q?J09H7tl+64OzC1cRJ22CLIDKc9A2o/l/o8IIgIDYfPjcZH8x2cqnkZv6VO4+?=
 =?us-ascii?Q?bbhSOl3Y3TfUwNFH1bTOle5cbYLyN8buc+LSc8hopH6ZHOos8ATeMiZKqYmV?=
 =?us-ascii?Q?TNbgEiNA7C6hDCcCiBRWgEn2XNJ4eO7C5jWOu/s5gfKkl4I5i+cjdqYXvqA8?=
 =?us-ascii?Q?kjF4Yehp0MG+tldZN3vHdy2Y2fmcnhfZLjjgl57NzhtTqGvciwJpimPIH9Es?=
 =?us-ascii?Q?VAACICPWQ8FcISszuvu9gkycPAc0cjlx8w52J88lpwflJsFp9dsSs5iz25pX?=
 =?us-ascii?Q?j6Qb4HJNuuEzAIDzKYbqG5ISoMRf6CtbHie/st4gOtfbyGP59rt7RB8B7Oa2?=
 =?us-ascii?Q?8Z555wRgMnR5X4UpLHkoXxfNTxXobHM0PldiwTvuhMgcRXI+BQhpja0EgWq8?=
 =?us-ascii?Q?bIs2qH01LSfCg2CbWz6MakZERZZbbz8/AJZSea9RMZ+PHtDvdfp6TJHkkUHp?=
 =?us-ascii?Q?w+9yy48KEYK4PUAvpTU/ujFO2J34/YXtkjUsMR7HMTESAXhQmZKrlFeMyeao?=
 =?us-ascii?Q?D9haOXWht8gTF9875Sc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dbe63d-f232-4167-0592-08dd58205123
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 17:49:58.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4h0wDzhOeFwKYIFzkkx3/FyA1Q586q48Wi3D22VZhWs+S1LjSkGqOP+FIqTrWJP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659

Pagecache uses multi-index entries for large folio, so does shmem. Only
swap cache still stores multiple entries for a single large folio.
Commit fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
fixed swap cache but got shmem wrong by storing multiple entries for
a large shmem folio. Fix it by storing a single entry for a shmem
folio.

Fixes: fc346d0a70a1 ("mm: migrate high-order folios in swap cache correctly")
Reported-by: Liu Shixin <liushixin2@huawei.com>
Closes: https://lore.kernel.org/all/28546fb4-5210-bf75-16d6-43e1f8646080@huawei.com/
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Shivank Garg <shivankg@amd.com>
---
 mm/migrate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 365c6daa8d1b..2c9669135a38 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -524,7 +524,11 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 			folio_set_swapcache(newfolio);
 			newfolio->private = folio_get_private(folio);
 		}
-		entries = nr;
+		/* shmem uses high-order entry */
+		if (!folio_test_anon(folio))
+			entries = 1;
+		else
+			entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
-- 
2.47.2


