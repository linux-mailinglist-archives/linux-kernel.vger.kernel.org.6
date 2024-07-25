Return-Path: <linux-kernel+bounces-262429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5467993C700
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 18:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7173BB21DBC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779C19D89F;
	Thu, 25 Jul 2024 16:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gorrHwtE"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8AA19D886;
	Thu, 25 Jul 2024 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923847; cv=fail; b=eItij1yV7omT/QQrA29pzUwHMXsGGg8vDLGFEBv2gVr+9lvWwa5ARHuu6CNpXecD6IyMscbeIAsz5cBb9pYraKG8wwo1U9b0+oEPc0u6jMZ9BiSXnzwkQbWuy+p60wk/rxn9LNDsmeuuCAIQLqneJl15I4XmkZWowapbxpBDtv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923847; c=relaxed/simple;
	bh=yIptKQ9+LxjtityEt8bzGPv4TwD+49ll6Zhq6HVRtw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iqwdB8UBjsXilmAzBYGbPDKYSQyAMh8atoNmjwLdBWNJ8I1+TAl1+FgXGQUdRnfwZaXqEMmd2nV19L21V46DkgQU+9g6hpkfWzKTapUcLcJoLh2Z8Rw2QgXlAMfwRcf1yLpiOy+mNMMqPJZPtWmfkjfZWyQPSEblBKAyGllQ3cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gorrHwtE; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6ePeL3WnwEBYj3O6jnn/FS7l0btSVBREFfz1lH3Fn2mu+wWNNQkxISg42eiIkX6wk+pRYwHO0hwlXxkcaQbQ/tqQNFH7Yb4FwGACA6vsl4ddbcob3DtyM5+fYt22qwDiaqXsgRppq5rja4D8IxLnXMC28i0zmFJZ3GjHC4JDyUYJ/KftqKr0++0D8a94KEJd7otGq/WR+bwhynXKqq7h9G7N7WTbAnTKocGObyu5Xauh187IUTkSHUYx2dN8pgCQ5stn2VS5wMpWlb8xqssUYU0aXOMENn0Wvc5u4TFM8YsjivZnT38soNy4hkZKhNpyOK2yaMlj0QzfpmP+N0qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GX2Dm0FZLsDAuFl+oWdmqcNYtZt907eQ00u9m1llZVE=;
 b=VgSddc8GlaE7QyQhtgQB9ycx8NP8GsqYgGLwk7g3InMM3HQBdQHS/e/qH6lq8fulZkt3GXurldZmRK/f60bBwNU9WwJiEFge5KF26mZkAIgY3IlBJDr4u26A88OQu661bDx0smZshy7+e0YLCHGZnUcLDWhhl6j/y/m8WdBTAW9zvCF+6HQBRhAahlImwyvjzLZhUZNkzU4BJa4hWUbKtvsMl6tlhHgDHSVCtx3jYcwtBFk6zLGqVtGVA6QC2WyK2RlJWU3/y/HwWL0yb5MYlPfNQntY9teh01Po12oT3R9ZaOImNIIeKvhDY3KFKNbZmbScPQ/VuGwRUfHII6NHbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GX2Dm0FZLsDAuFl+oWdmqcNYtZt907eQ00u9m1llZVE=;
 b=gorrHwtE2k+LVNXHVFcBMOjaPeBHKnt4GONk4/SEEZDMKj2Cfx2LE6DZcdfIsYyY/vupDWgaNjB6RlIRnEtRkPIeCWyM7YrHMpuTLW1sz1JzNqCECiFPT5HfAHdaobgb3w3p/g4lwow8MFKoTB+oxc/42TAEt5qDpNkc+YpcauY=
Received: from BYAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:c0::17)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Thu, 25 Jul
 2024 16:10:40 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a03:c0:cafe::c) by BYAPR05CA0004.outlook.office365.com
 (2603:10b6:a03:c0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29 via Frontend
 Transport; Thu, 25 Jul 2024 16:10:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 16:10:39 +0000
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 25 Jul 2024 11:10:33 -0500
From: Vignesh Balasubramanian <vigbalas@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-toolchains@vger.kernel.org>
CC: <mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<aneesh.kumar@kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<ebiederm@xmission.com>, <keescook@chromium.org>, <x86@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>, <bpetkov@amd.com>,
	<jinisusan.george@amd.com>, <matz@suse.de>, <binutils@sourceware.org>,
	<jhb@FreeBSD.org>, <felix.willgerodt@intel.com>, <tglx@linutronix.de>,
	Vignesh Balasubramanian <vigbalas@amd.com>
Subject: [PATCH v5 0/1] Add XSAVE layout description to Core files for debuggers to support varying XSAVE layouts
Date: Thu, 25 Jul 2024 21:40:16 +0530
Message-ID: <20240725161017.112111-1-vigbalas@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaef931-fd53-4e67-8211-08dcacc45394
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UeJpGMaOIFtx+bUjh+3NnPq339NahtuFvUlfegiQcZL+hwtlK5THQjC7YlyX?=
 =?us-ascii?Q?SQYcmWac5Bmyy9UBFHb3yAm0imbz+dsG0Qh9jeAQOoK5pjleJ4ynDZD8wJHX?=
 =?us-ascii?Q?ppBlvzMEZcMfDTsQlNmiLP5ibUe2wQj/zcmyA7WgA9yCOmSgZRZr9kZCiDuk?=
 =?us-ascii?Q?em3ZDjlPFMhjhdEUdc8adcK2q9Qs8MIPWxswG58AoXOCqXlHMhQBSCNIiVQc?=
 =?us-ascii?Q?Z6dU5urVXPcSVagsTgGVApBey0rZQCUm51c6d7Wyr+0GiI87ydK/6xrYbOJS?=
 =?us-ascii?Q?qX387JFelXJ23Jf/hlxU3gAB1cxfi0n8OV5Zwo7Bx4qrbM101SgMP4rCAe+h?=
 =?us-ascii?Q?RMOhe0+7twPhkkWP2N6rSeCqPFEEjwkE3pFL8UHA4ubn7haHwpDiqhYkQmeF?=
 =?us-ascii?Q?vsAFWjqp3GBzKNas7xw7vMi00A103/YeLps101DHZ5jEXi/uxFdw2iaaRMmH?=
 =?us-ascii?Q?tHn6wMCW9ibzKJzEmTqCknD6pL0vfrJmTiBUgnmgvHEwUDR1Fb54ccEkPXOn?=
 =?us-ascii?Q?qtMUONV8hx0OK/4Nha3eplwqWQEXmjCo6UXkO1v3VuspRo0JOt+flIi22tAW?=
 =?us-ascii?Q?89MHpqXqmZisCYKe4wGs1VXM1ZBSH6hXzOYv/eWLWItfHp/HFOwzY7J3cZTe?=
 =?us-ascii?Q?FkhZ2wU6neRfWUVStLxvnxyEqO7HdqEKXsqCPtlAU6DY7aZxuQrpj1kK/3Sq?=
 =?us-ascii?Q?VY4WeEvEVUVWYvdLHnrY/M+cbcyZaSUDMeKzMjmi9Suk0u+jj+6a62K4q428?=
 =?us-ascii?Q?zeUYKg0WBsKESpBItNf6lZ2Ll04i0isH+ZTKRbIBfqoZOxZeHDmeSX45MYnR?=
 =?us-ascii?Q?GPXyfqlZDe2dkSiLGmfJmmDhXW7VjbRG5bU/TJFHVtmTlSuoX+aUOiHyG4jw?=
 =?us-ascii?Q?rnt+KcmCcEBGRQ33Tlvjt8HQh57X83YKmVZ6q7ut1nkm7SBCioE3Q43W0Ysv?=
 =?us-ascii?Q?10tdIsc8+L7mHX2EbWCjLGrdnmpBCufIPUKUBUla2TYn/udMjO6ox7mEwnCw?=
 =?us-ascii?Q?0cb1DLiLau8493fYQ0bsDW92LLbFUZN+8YMwote9hVHy198nTDqm3R0omsaq?=
 =?us-ascii?Q?w99A0kB480UlywxcGyxxR3aLCFMoZRTAHMTdGxk6CxSK1wMLhUQHBpH+kkZz?=
 =?us-ascii?Q?XQjIebKzhCXW95h8mp9LdklQkP1kAofEkzjHdWpcQ1HSDhKdiRm7b9zxWiKj?=
 =?us-ascii?Q?/0M5YDpUeV4b2L8aVAogGNdiERBQ8MQojvDiuEh6nrq85Tm775qOsC6EcMGz?=
 =?us-ascii?Q?Ajn/ziLgkw+Obnw/7XMbvXfURJXyC7YT2xQcnd9hYfX2taIE793WKxGFxTpW?=
 =?us-ascii?Q?R6EQ7pfGE3HqE244/Y//LiF1ULmqPfhHRmlCcjbUiijqs4omVNct9ET432qg?=
 =?us-ascii?Q?+aUEaOsXMLtGZfjkHhbN5B1LTo+rvVd0k/PzC9DXwoSS6h76WGke7Xn+x510?=
 =?us-ascii?Q?6ssfNMyLmGiJEcd6PgiydpEvXW+OjhAi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 16:10:39.4014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaef931-fd53-4e67-8211-08dcacc45394
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

This patch proposes to add an extra .note section in the corefile to
dump the CPUID information of a machine.
This is being done to solve the issue of tools like the debuggers
having to deal with coredumps from machines with varying XSAVE
layouts in spite of having the same XCR0 bits.
The new proposed .note section, at this point, consists of an array
of records containing the information of each extended feature that
is present. This provides details about the offsets and the sizes
of the various extended save state components of the machine where
the application crash occurred. Requesting a review for this patch.


Vignesh Balasubramanian (1):
  x86/elf: Add a new .note section containing xfeatures buffer layout
    info to x86 core files

 arch/x86/Kconfig                |  1 +
 arch/x86/include/uapi/asm/elf.h | 17 +++++++
 arch/x86/kernel/fpu/xstate.c    | 89 +++++++++++++++++++++++++++++++++
 fs/binfmt_elf.c                 |  4 +-
 include/uapi/linux/elf.h        |  1 +
 5 files changed, 110 insertions(+), 2 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/elf.h

-- 
2.34.1


