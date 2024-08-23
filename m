Return-Path: <linux-kernel+bounces-299548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503EE95D61D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 21:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D352C1F23EED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3443419306B;
	Fri, 23 Aug 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OpARkPMA"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A70192B68
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724441807; cv=fail; b=mde5f9SEiB5LDgn1cQcIObiBlhD0ymgL5XQmUGIRjFZ76EXx8UyDIDOa67D9flMur9YmKgToy4RmlwBUit7IYrQG2LR98NG7nftHuIBKvko/DZEMD32gkhtSWojsjspBOt7apYaHk6FBhLbUZsErjUwmR3bLFQTvMh58DtHdF24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724441807; c=relaxed/simple;
	bh=2FzFvosHtwJ3Ohvbho68iW3zK++sKJ+7blGWzs3zOXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFYI08iyyyCp6FOdgVJdRSZSFQ+uDmi6GaySivGnaPqgRH/jjlBVIEyx3O9+YylQ8eCNCe6hg0uunPmmV6L77zKkybY8WDy9o/ZfOBvYKILqFaxYdvcFDPgtJI+JJeG6ykUcKHBDoTMqstQRQdZrOxCaCkBTorMJKaBDYo9gOG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OpARkPMA; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gI4HnmrqD+UJKi1TDmVqqlFkRMKRb5JYcMT5A3AK4fHUyUf/bNwCPOlQOvlmnmOMyzwqtcb9Y3h39ShhlMCDTM5z2AIOWACdsf76L4rqIQCDq9WPGOQQvR18WUnzy41LQhgpd8qQFQh4cS8v5+HVSWXUAISSzlzmWW/W17FeYHTTpzFCDVr/WCq4C74LnFrPTl6S2mpSvVmigvlvjmWQH+3pHE1y0C7iJlybcZAeIwwa42UdZt2AAUDUskBztV3SKaJ8X5ONT5Y5C96hqI2ZWyPIEAzDCdKoP92LnWA4r0r/rUQ2mOczt2eAj/q4dtlCrQneb+ptpWmhWZ7mFtI5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87Cir7MUe+90Zd8HQRFVV15Z21B672vcEXroWazgwgg=;
 b=WRqy621ZsX7veYtjsK9uj3d/oRaukkw3pvP2T6BW/yEX0dlWOG1kaH4qysLPEJW2CIab/ZtdAQE7ZKJIQb77cjfCghavsME8+btwLff2mAFuSVQgnnKmUqwVTmCPHAWX5BrYwhnWX+FaGTvAUNGUokLgiBHCI05MytfgpjSzvUQ07PG7iZ+2NU8thM8YcWIXO3k1Fwvkp0YEebExpJIVutbVIN3z/VQVM5F5ZumNEsuabWnplZKcxpfVNDGSeG17SViWlLBkYYctF1WC44NcTbMilFbjntOd5AucSWXNFFd3EUpdOhf/BFcKwnJG0brjiSHjMM6/EDKCfzombyaa9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87Cir7MUe+90Zd8HQRFVV15Z21B672vcEXroWazgwgg=;
 b=OpARkPMAQRESpBjU2iz82I4pyZga0fqaaK3+0M3NlZzDqBSwdMe2G0++Qyq49hE9guqMCGRkzfSB/a0foCcPQYiiweXeui0SAQ9Kg3vcHWPOMHKi9nHD8+IcKa6okYYKWiuh/wxQjuBbaPI87LhKq5I9imGx5/A0mQ+aFzu/IsM=
Received: from BN9PR03CA0612.namprd03.prod.outlook.com (2603:10b6:408:106::17)
 by PH0PR12MB8128.namprd12.prod.outlook.com (2603:10b6:510:294::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Fri, 23 Aug
 2024 19:36:41 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::f4) by BN9PR03CA0612.outlook.office365.com
 (2603:10b6:408:106::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19 via Frontend
 Transport; Fri, 23 Aug 2024 19:36:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Fri, 23 Aug 2024 19:36:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 14:36:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 23 Aug
 2024 14:36:39 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 23 Aug 2024 14:36:38 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Brian Gerst <brgerst@gmail.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Jason
 Andryuk" <jason.andryuk@amd.com>
Subject: [PATCH v3 3/5] x86/pvh: Set phys_base when calling xen_prepare_pvh()
Date: Fri, 23 Aug 2024 15:36:28 -0400
Message-ID: <20240823193630.2583107-4-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823193630.2583107-1-jason.andryuk@amd.com>
References: <20240823193630.2583107-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH0PR12MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 61909554-2875-4dce-f921-08dcc3aae9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KP4L1JWxRIeBpE0EEJO8LpP5IlZX6HTTBy+87aBKiwKesa0foNZXpOPd+2Hd?=
 =?us-ascii?Q?o58fZbj/1bkOQ0/7w2eUfvi3no+csR/v5S1h5IxXiC+zULrTwYxO4rVSj7Ng?=
 =?us-ascii?Q?CBS5L+EbRCdca/+pv9VYd1Dd85ERLMsAA4ypNYvNFMtwmblFpjHIzuf4Zrbq?=
 =?us-ascii?Q?0lpS7nwszZzs4a93u9+HvkLLz528joXOhm2B+WU45K1ymnc8nlqO6TbVIk7x?=
 =?us-ascii?Q?+H7KHH61Szp4VoVJfWyiFx6FPXEiTs/Ie+TZ5yDzhYjefpckFPoBY2ovcAPo?=
 =?us-ascii?Q?lZeG3bfV/dRvWonrZaRVjWPDUPYT0AVjFSr+L++cnODjapESASOqaBDDB7DZ?=
 =?us-ascii?Q?6cskcdTksGlpBXuvgwfpsPTk0uMRtVkWWB1efj9HMa6OzutwqNIxT6S3RjZ1?=
 =?us-ascii?Q?E/LWpEoR7AYhILzdmXseg3M9s0wZt2qTvkdcA2XeE4Z0ndbhPhIYL7TuJXhT?=
 =?us-ascii?Q?8MRsKyJZy2fBnHgDcHDA38g2ObURwu81uPFyWxjE8AA7pncDcOhqR0VvJW1B?=
 =?us-ascii?Q?tsBWo66E+Afvv80PlBUwn6tTWXDMHw62dnz6JOtDMJqmgWv3DJ+gpAzUE3ol?=
 =?us-ascii?Q?kHq0gcQTHA3o27mT7bdQNlwkYnGe+ktEvv2WCAP0rWosncovNasmX8T3rG8z?=
 =?us-ascii?Q?JfeKCpwgUXnDy5Vzc9GN26oCS5jYjV0msCXQ9igCa0kmKb5BramzJTjk0jrg?=
 =?us-ascii?Q?N2e9XYeefoAfp6uV2vlBvJBN5bW84EDPF6oRIibtV3ppKxFqcpClkbHjjtZJ?=
 =?us-ascii?Q?7UTCPii1jrgK2R9o8mv3o+/tX7/3Mkzel3NqWTNzWO3RlTdALh48kNbdkK9R?=
 =?us-ascii?Q?xuZ19cNicF6Mp2EbBuPBqHZr4ywBBQvvIY9JkBtdC7svUOBDddo7U072s8qd?=
 =?us-ascii?Q?pJDchFycruSv1QZYZqWmDXVPDmq4qYAj/4e5HHOLFHd9w8kOpyEDJfs1yEof?=
 =?us-ascii?Q?3Zd5cTuTfpPFlsgrYGfStmiCOMEW3O44bs4Qo6MJivQ5GusiGAB1cZDgElhl?=
 =?us-ascii?Q?rBxSd4BrlPVu2CKLRmSDEqdbeGZW7yFbN/GkKZ5KVnb8w4DG0ct5C4x7EA9S?=
 =?us-ascii?Q?bpNaxjHoaUnm6UTUj5yh8RkN9+61b4BTsZ6A0a7SNMST4VoDdhzb/0NIlFM3?=
 =?us-ascii?Q?RJCGDgARdh2gZQgcDjNoHAIpDpNFFJCGMpsMrFCGQX4E+drVjHc/lA8Rju9f?=
 =?us-ascii?Q?zKis5LYgDsNKN/lz/fTKQiOgm3sTdJ6OM5FPAkp1j9xV2+OurWs04O+ttCYJ?=
 =?us-ascii?Q?ZiSKUnn6z521fzyoc5o/0FgvbJL8GklbR+2t+Z1Z1pNLULBK+ewdVc2ca+C4?=
 =?us-ascii?Q?GrTG/ayHLCHhxtHbcj9B9CvQ0HBr7k9ocMFA2awCdBeG5fhomUF/nxCLsBQO?=
 =?us-ascii?Q?IS7/IH0nc0ZR8ObZfQ4QFdrhoWBJW1D+s/VFzvGKr1EG1kU3DKe//lFD/0SI?=
 =?us-ascii?Q?raPo6OBPdY3eak84qie+VKd9A5kao5HG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 19:36:41.5726
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61909554-2875-4dce-f921-08dcc3aae9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8128

phys_base needs to be set for __pa() to work in xen_pvh_init() when
finding the hypercall page.  Set it before calling into
xen_prepare_pvh(), which calls xen_pvh_init().  Clear it afterward to
avoid __startup_64() adding to it and creating an incorrect value.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
v2:
Fix comment style
Add Juergen's R-b
s/LOAD_PHYSICAL_ADDR/_pa(pvh_start_xen)/ in case they differ
---
 arch/x86/platform/pvh/head.S | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index ba4d0eab4436..14b4345d9bae 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -125,7 +125,20 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
+	/*
+	 * Calculate load offset and store in phys_base.  __pa() needs
+	 * phys_base set to calculate the hypercall page in xen_pvh_init().
+	 */
+	movq %rbp, %rbx
+	subq $_pa(pvh_start_xen), %rbx
+	movq %rbx, phys_base(%rip)
 	call xen_prepare_pvh
+	/*
+	 * Clear phys_base.  __startup_64 will *add* to its value,
+	 * so reset to 0.
+	 */
+	xor  %rbx, %rbx
+	movq %rbx, phys_base(%rip)
 
 	/* startup_64 expects boot_params in %rsi. */
 	lea pvh_bootparams(%rip), %rsi
-- 
2.34.1


