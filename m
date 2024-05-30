Return-Path: <linux-kernel+bounces-196036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A48D5653
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE84E1C21BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 23:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4060181CE5;
	Thu, 30 May 2024 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NUfQs9t5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30A3176184
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112233; cv=fail; b=uO67ojM1VkriZGn3Asf/Le/Ia0Kns1fiXwRtw4E3epJQkPyz2klKmSMEmYiC+ZZrng4GbSe9UA0Wp1UCeQRbG69qjFbk3frjmlsB9mPyKUiLDKWP/wVK3yKURuyaLqjjP9DJ4z9tKCFGVAD/5sFx/RRyfZi8mBeOYmVkN0fShRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112233; c=relaxed/simple;
	bh=Z3VIjVK6Bw01toB3mGxu2a0JjdK+11wEvWbLs9xsW0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD4v+1pVNH9+c0YZy+PE4ZvejGcyQ6OcBDGxKkiMFL0OfM0T3U96/OiDysiFPekWFwav03ixfL3r72v5igH4D4s81pweiFrBz/o/JtoPdyvRz7retjdaRxf7qRcezOKQn2Ib/S4tTKrd/kiSRD6En7XoNYy3qIRHsIvd7y1jHHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NUfQs9t5; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8gA6gurBdlQGikON/X4vmg0HoVLNLGvoJDKn7oVF7/uodN4UJpiLf0osQ8sTaZSWu029l+igvbxICK25l2Ar91z8wfqjd6WVfGAZmOr5aAMGml0y2s245HzOjOM/JmoyiYyytta6vEZuJ8e0ppQSacKlhVPJlhDt1brzL8tHgK8dfWJjKl8QgFA+B8dJ4zA8v/YfOYW7l1+uK7CPAhFw4R5kDbC/hvuAOvXC65j8FBQMRqoa1aMa2Ck1Lq/iQ8Pcc0eEh+hapEn+uvGwW8qOXvnTd9HasbLo2T8dLfNCp/5Ahy5kK7Xpo5qiQoHjF0O8CPBjL/4XHgRw0khvmaZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieEefwgUhncIg313683Ilof1zAWY1rVRNtzilGjtXiY=;
 b=jNCsaxJELRZOoELjKo1ZntuevQc5BnxDTaMaFILgqcfUZVsogf3RKvFQPRqvwd5zu390IjcZmHwPFkfS6gabutLpIhYqX+ow0e3QCR8m9kI6OmVU9pBcYkQPsKVkwPo4fWlKFpIhTrTVqYoSE+lP2obFxl68l4Tpd1ig8S74Noxd2ZeSvLWhFKzuMVSkHjYtM31BVycHYoh+OmF7wsTBadFl8WS9r+CyqeymsI2nLR/kdPNSV8zRUsceD19YVQDb0V3BpmTirqGQoblrdAwQ+/SPV4aHrjkNRDJYs7YxfN4Y7yDFeG7Rbm0qR6DeytkhOPjwgwNaF+tH19P3hW12qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieEefwgUhncIg313683Ilof1zAWY1rVRNtzilGjtXiY=;
 b=NUfQs9t5CJd7y+HmoVZ7/5ftH+O8zXriUuYsh/+B6dyOmu21VpfFeKzRb73oUU+9+my8r4h0kRoGwUFAtmDiyfgdWuGqhaUfh33YtiMrXm41bxWk5rKJiRNkY00Rn2h73c58MmzaBlxnpp/DDr0G1ng0rkGX4ZqZhw5Ji6e4Oco=
Received: from BL0PR0102CA0016.prod.exchangelabs.com (2603:10b6:207:18::29) by
 CH3PR12MB8582.namprd12.prod.outlook.com (2603:10b6:610:163::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 23:37:09 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::7a) by BL0PR0102CA0016.outlook.office365.com
 (2603:10b6:207:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 23:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 23:37:08 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 30 May
 2024 18:37:07 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: <rafael@kernel.org>, <hpa@zytor.com>, <peterz@infradead.org>,
	<adrian.hunter@intel.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<jun.nakajima@intel.com>, <rick.p.edgecombe@intel.com>,
	<thomas.lendacky@amd.com>, <michael.roth@amd.com>, <seanjc@google.com>,
	<kai.huang@intel.com>, <bhe@redhat.com>, <kirill.shutemov@linux.intel.com>,
	<bdas@redhat.com>, <vkuznets@redhat.com>, <dionnaglaze@google.com>,
	<anisinha@redhat.com>, <jroedel@suse.de>, <ardb@kernel.org>,
	<kexec@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v7 1/3] efi/x86: Fix EFI memory map corruption with kexec
Date: Thu, 30 May 2024 23:36:55 +0000
Message-ID: <f4be03b8488665f56a1e5c6e6459f447352dfcf5.1717111180.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717111180.git.ashish.kalra@amd.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com> <cover.1717111180.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CH3PR12MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a5d2d1-ebb4-4492-a9fa-08dc81016c13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|7416005|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VP1BIqNrD/5kpbS3/An4a3Zg274n08fY1zsJKCyJVFI96Jol7uF9KtI/0Uy?=
 =?us-ascii?Q?MiYTseMfMT6OFXjt61znD9AHBK9Ntt+GR0WkOyqA6ElDrBQLmpR+bLkjyJQL?=
 =?us-ascii?Q?lE5F4zmamvhiojPzPc/UsA8dnWjVTxtoqr55+ZmBoIqszboBrkh8iY1kydYT?=
 =?us-ascii?Q?D8tuTTpQyopp8v1E7xILDPn5Ykb9MEBwkVHgdd7V6fGc8rDFubeg2/X62KOa?=
 =?us-ascii?Q?mS5CekU6CMQFCQ5+r17xsilzEbtJ9k9DQ3plK5j7Mr46pMRwcExO0XFkC7/6?=
 =?us-ascii?Q?lSyY3nx7Cayhlq1ZQlA9pW90K6Q2Du6ZjcIr61koQhRlvKT5wGKDO7iMBvW9?=
 =?us-ascii?Q?ENnb93asOygIv03jnOT1pAnaZRjYuDlAuyoFwFEfV0NRhFRkAbAd/kYudSo4?=
 =?us-ascii?Q?8lr8M0E7lvZ3wQ8ApBNEbnespSIcSBMf04hxNh0xw7I80dz7EC9a+IDfx17Z?=
 =?us-ascii?Q?gmfsIxVBrtr+4Yf6s2EetUY0xOL9makOKet8O03Gefk877bM5FThqoz2Q57n?=
 =?us-ascii?Q?4xsBEmf8CEazzVCepz3SDPh0sRVLbrKAcLU3zBJZlJHpHjOJA+zHbrflSKmt?=
 =?us-ascii?Q?kootc7Mh+fPLauQt//hqlpnNPNd9Sgm6U8VuuBW0kD2OhjdLTmqKigDm3BAK?=
 =?us-ascii?Q?pmrGFkoZnVdS8a/nCJI1CVQk0CmW6RZSx6IGMlpRbHuOt6FI09WH8N+RYIN0?=
 =?us-ascii?Q?mH6AL8Xwlbwjgqx7E6npD3SjFAKb9XETrcFPU754WtNeIqX94kkbWujr6nRT?=
 =?us-ascii?Q?ARIADg8I1D6wqZp2kN+spUHQO5k/fUIdP7m1DThh0uP1WjVdlcJCyzUTi8k/?=
 =?us-ascii?Q?vfP/SgOe1DlGVrc/0IOvKk43SfrUAD/5bSYUDNUJyTxvmy9Ge0lbiFiDoX2n?=
 =?us-ascii?Q?oBIJYp70UKiRotqtKvukeeCN346c2pdjDGwCHe/uyRM90tIvyxwB2lJsdXA9?=
 =?us-ascii?Q?4cygRjwD5DiRbTciJ9ejws1+0Vn73swyWO4ynHH/ioCH90n5Kn2wL5X1jS7R?=
 =?us-ascii?Q?wY6645NHIqaSIUPT+TVO7jaiWfEBhpu6NQRyZJZMGbSrb8j9MZnUL3dRLj1D?=
 =?us-ascii?Q?J3MJYqPxqBACVVBZomAqocAo1Ots5/TvlWwIivlCYa8jiMdCtH8sclZu8cSv?=
 =?us-ascii?Q?cbXhqXAb7UeVefbruS/Enwn75RYrc2vNDFZrHBbVgN+QeSgRL1Evg9clwlxR?=
 =?us-ascii?Q?oDVs0ehBTh+wfNXoKLsLi9MgKVgoZQFOjjq0Jlj4X1WuLT3mC570KzOKXNOk?=
 =?us-ascii?Q?P6oJ93s7AbvhSas1jckRt8gH8K0AZ9+uJehJnB1o2ziifvaP339CP5ZVmQrs?=
 =?us-ascii?Q?YeBRCuxpEdclCEAdXx1jQI9Wl+T3IV9eov7B1dSSjmVfPdj0Z4j1Jr/DW0Z5?=
 =?us-ascii?Q?2aNHJfXlhTN5nTcR7avscaiknQEQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(7416005)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 23:37:08.7477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a5d2d1-ebb4-4492-a9fa-08dc81016c13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8582

From: Ashish Kalra <ashish.kalra@amd.com>

With SNP guest kexec observe the following efi memmap corruption :

[    0.000000] efi: EFI v2.7 by EDK II
[    0.000000] efi: SMBIOS=0x7e33f000 SMBIOS 3.0=0x7e33d000 ACPI=0x7e57e000 ACPI 2.0=0x7e57e014 MEMATTR=0x7cc3c018 Unaccepted=0x7c09e018
[    0.000000] efi: [Firmware Bug]: Invalid EFI memory map entries:
[    0.000000] efi: mem03: [type=269370880|attr=0x0e42100e42180e41] range=[0x0486200e41038c18-0x200e898a0eee713ac17] (invalid)
[    0.000000] efi: mem04: [type=12336|attr=0x0e410686300e4105] range=[0x100e420000000176-0x8c290f26248d200e175] (invalid)
[    0.000000] efi: mem06: [type=1124304408|attr=0x000030b400000028] range=[0x0e51300e45280e77-0xb44ed2142f460c1e76] (invalid)
[    0.000000] efi: mem08: [type=68|attr=0x300e540583280e41] range=[0x0000011affff3cd8-0x486200e54b38c0bcd7] (invalid)
[    0.000000] efi: mem10: [type=1107529240|attr=0x0e42280e41300e41] range=[0x300e41058c280e42-0x38010ae54c5c328ee41] (invalid)
[    0.000000] efi: mem11: [type=189335566|attr=0x048d200e42038e18] range=[0x0000318c00000048-0xe42029228ce4200047] (invalid)
[    0.000000] efi: mem12: [type=239142534|attr=0x0000002400000b4b] range=[0x0e41380e0a7d700e-0x80f26238f22bfe500d] (invalid)
[    0.000000] efi: mem14: [type=239207055|attr=0x0e41300e43380e0a] range=[0x8c280e42048d200e-0xc70b028f2f27cc0a00d] (invalid)
[    0.000000] efi: mem15: [type=239210510|attr=0x00080e660b47080e] range=[0x0000324c0000001c-0xa78028634ce490001b] (invalid)
[    0.000000] efi: mem16: [type=4294848528|attr=0x0000329400000014] range=[0x0e410286100e4100-0x80f252036a218f20ff] (invalid)
[    0.000000] efi: mem19: [type=2250772033|attr=0x42180e42200e4328] range=[0x41280e0ab9020683-0xe0e538c28b39e62682] (invalid)
[    0.000000] efi: mem20: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x00000008ffff4438-0xffff44340090333c437] (invalid)
[    0.000000] efi: mem22: [Reserved    |attr=0x000000c1ffff4420] range=[0xffff442400003398-0x1033a04240003f397] (invalid)
[    0.000000] efi: mem23: [type=1141080856|attr=0x080e41100e43180e] range=[0x280e66300e4b280e-0x440dc5ee7141f4c080d] (invalid)
[    0.000000] efi: mem25: [Reserved    |attr=0x0000000affff44a0] range=[0xffff44a400003428-0x1034304a400013427] (invalid)
[    0.000000] efi: mem28: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4488-0xffff448400b034bc487] (invalid)
[    0.000000] efi: mem30: [Reserved    |attr=0x0000000affff4470] range=[0xffff447400003518-0x10352047400013517] (invalid)
[    0.000000] efi: mem33: [type=16|   |  |  |  |  |  |  |  |  |   |WB|  |WC|  ] range=[0x0000000affff4458-0xffff445400b035ac457] (invalid)
[    0.000000] efi: mem35: [type=269372416|attr=0x0e42100e42180e41] range=[0x0486200e44038c18-0x200e8b8a0eee823ac17] (invalid)
[    0.000000] efi: mem37: [type=2351435330|attr=0x0e42100e42180e42] range=[0x470783380e410686-0x2002b2a041c2141e685] (invalid)
[    0.000000] efi: mem38: [type=1093668417|attr=0x100e420000000270] range=[0x42100e42180e4220-0xfff366a4e421b78c21f] (invalid)
[    0.000000] efi: mem39: [type=76357646|attr=0x180e42200e42280e] range=[0x0e410686300e4105-0x4130f251a0710ae5104] (invalid)
[    0.000000] efi: mem40: [type=940444268|attr=0x0e42200e42280e41] range=[0x180e42200e42280e-0x300fc71c300b4f2480d] (invalid)
[    0.000000] efi: mem41: [MMIO        |attr=0x8c280e42048d200e] range=[0xffff479400003728-0x42138e0c87820292727] (invalid)
[    0.000000] efi: mem42: [type=1191674680|attr=0x0000004c0000000b] range=[0x300e41380e0a0246-0x470b0f26238f22b8245] (invalid)
[    0.000000] efi: mem43: [type=2010|attr=0x0301f00e4d078338] range=[0x45038e180e42028f-0xe4556bf118f282528e] (invalid)
[    0.000000] efi: mem44: [type=1109921345|attr=0x300e44000000006c] range=[0x44080e42100e4218-0xfff39254e42138ac217] (invalid)
..

This EFI memap corruption is happening with efi_arch_mem_reserve() invocation in case of kexec boot.

( efi_arch_mem_reserve() is invoked with the following call-stack: )

[    0.310010]  efi_arch_mem_reserve+0xb1/0x220
[    0.311382]  efi_mem_reserve+0x36/0x60
[    0.311973]  efi_bgrt_init+0x17d/0x1a0
[    0.313265]  acpi_parse_bgrt+0x12/0x20
[    0.313858]  acpi_table_parse+0x77/0xd0
[    0.314463]  acpi_boot_init+0x362/0x630
[    0.315069]  setup_arch+0xa88/0xf80
[    0.315629]  start_kernel+0x68/0xa90
[    0.316194]  x86_64_start_reservations+0x1c/0x30
[    0.316921]  x86_64_start_kernel+0xbf/0x110
[    0.317582]  common_startup_64+0x13e/0x141

efi_arch_mem_reserve() calls efi_memmap_alloc() to allocate memory for
EFI memory map and due to early allocation it uses memblock allocation.

Later during boot, efi_enter_virtual_mode() calls kexec_enter_virtual_mode()
in case of a kexec-ed kernel boot.

This function kexec_enter_virtual_mode() installs the new EFI memory map by
calling efi_memmap_init_late() which remaps the efi_memmap physically allocated
in efi_arch_mem_reserve(), but this remapping is still using memblock allocation.

Subsequently, when memblock is freed later in boot flow, this remapped
efi_memmap will have random corruption (similar to a use-after-free scenario).

The corrupted EFI memory map is then passed to the next kexec-ed kernel
which causes a panic when trying to use the corrupted EFI memory map.

Fix this EFI memory map corruption by skipping efi_arch_mem_reserve() for kexec.

Additionally, efi_mem_reserve() is used to reserve boot service memory
eg. bgrt, but it is not necessary for kexec boot, as there are no
boot services in kexec reboot at all after the first kernel ExitBootServices().

The UEFI memmap passed to kexec kernel includes not only the runtime
service memory map but also the boot service memory ranges which were
reserved by the first kernel with efi_mem_reserve, and those boot service
memory ranges have already been marked "EFI_MEMORY_RUNTIME" attribute.

This is the additional reason why efi_mem_reserve can be skipped
for kexec booting and by checking the set EFI_MEMORY_RUNTIME attribute.

Suggested-by: Dave Young <dyoung@redhat.com>
[Dave Young: checking the md attribute instead of checking the efi_setup]
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/platform/efi/quirks.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..6f398c59278a 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -255,15 +255,39 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 	struct efi_memory_map_data data = { 0 };
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
-	int num_entries;
+	int num_entries, ret;
 	void *new;
 
-	if (efi_mem_desc_lookup(addr, &md) ||
-	    md.type != EFI_BOOT_SERVICES_DATA) {
+	/*
+	 * efi_mem_reserve() is used to reserve boot service memory, eg. bgrt,
+	 * but it is not neccasery for kexec, as there are no boot services in
+	 * kexec reboot at all after the first kernel's ExitBootServices().
+	 *
+	 * Additionally kexec_enter_virtual_mode() during late init will remap
+	 * the efi_memmap physical pages allocated here via memblock & then
+	 * subsequently cause random EFI memmap corruption once memblock is freed.
+	 *
+	 * Therefore, skip efi_mem_reserve for kexec booting by checking the
+	 * EFI_MEMORY_RUNTIME attribute which indicates boot service memory
+	 * ranges reserved by the first kernel using efi_mem_reserve and marked
+	 * with EFI_MEMORY_RUNTIME attribute.
+	 */
+
+	ret = efi_mem_desc_lookup(addr, &md);
+	if (ret) {
 		pr_err("Failed to lookup EFI memory descriptor for %pa\n", &addr);
 		return;
 	}
 
+	if (md.type != EFI_BOOT_SERVICES_DATA) {
+		pr_err("Skip reserving non EFI Boot Service Data memory for %pa\n", &addr);
+		return;
+	}
+
+	/* Kexec copied the efi memmap from the first kernel, thus skip the case */
+	if (md.attribute & EFI_MEMORY_RUNTIME)
+		return;
+
 	if (addr + size > md.phys_addr + (md.num_pages << EFI_PAGE_SHIFT)) {
 		pr_err("Region spans EFI memory descriptors, %pa\n", &addr);
 		return;
-- 
2.34.1


