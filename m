Return-Path: <linux-kernel+bounces-428361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6BC9E0D55
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B629282BB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633911DE3B0;
	Mon,  2 Dec 2024 20:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="45Z+USmy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0121DF254
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172692; cv=fail; b=B/r7zZOFQWPoqNdicB3tOhS/dxw1Zn/7VdkqXMkDOCXbckGlhPZL5AL+AOyl0ZZ9GeUMb1kYRSBWVzDL1H2x9dAVHjnv7+VBFwqbe/Zt8HXTX0QumI6Forcgl9p4TBr/P5WzNH+w1z3rjOKtugDqBBo98BMVtw/PesGc8u34pzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172692; c=relaxed/simple;
	bh=yhPgIktYqNR0wimNCSTpaXDhtwRdS3LpeTchlZ1/bF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKYaWcU33OerYM3mZr3Yeb/gdZCbCWgh5YOE7Y+cFQBESfVYgvBIR/i0rBVeVNKratlIymwQKoIrlfUmmJBS3v0+LdzheUbiOMCOfPztrItAQM+ndZFRp1Lx4YCqJup76Kwq7+F/J87Na83+Y2k2RIdVQnidQOYihvv7RU5Q96w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=45Z+USmy; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdRIKEd3GbB3nwzV3eWYkBSv5f1LLVxKPJ7BBhPVxfLK0clA+XUPfPf6IpIUUZKmHA2jK/DGFQ/SQ1Lx7jXwCYVRyFybzdw8Wcfg0pGMYDIYLUcbRW375dyK5BuxlGy439TMNcL8VpfcRgmxFWMHHmoc7nLtyhQeopdxpHsSmfPsyuGnZlWEH0UGss9zgjeoBSrHPZ5NzMC538leKT6kfeDIVyLyhsJkBJ2sXJct70YIavlDmjXSC7IV4HxphlxT2A/QJ77KTnc1OMD51Wa4FaAjea/okJcJHYnVrFDAr5Zhslk9d4xmoal9IumYjpYQfz52vTbF6e+Cg4Ta43BsWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJOuWZ8pkj+GeQeOn7kV0DDIDj/97N3nKBoaS/gwrcQ=;
 b=XSqHcygSIPIT6qZqlq3jxBrYteENpbyN/Xr+1OIbSNJCl/VUrQiHJ/1XTyIETjOtyi3ECLNScu1lYnfxwozEHyXuMybzXqtUCnS17nv0293T2ZCscnOelM0yCXNfmAbCld5VhLQoxPCVu3hl7p9nrJecHeHs3TsWn3U2Kl19GsMD6flKEr4x7Ij3RNvdsyhN59hGlELaLINbDdhRhb20FqgcKGos4I+spA7BypgUQhxviGniwuQ7Ok9Z15eNqBoQe4e+vJbmf7mRM8C8TPn1fv2i0WzBqDo125waDFa2+o2NBW90qAh753AoEDvAFg/U2gd8qPHUETwx2XuolDCh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJOuWZ8pkj+GeQeOn7kV0DDIDj/97N3nKBoaS/gwrcQ=;
 b=45Z+USmyHN+isye2TOKuWAk/4ac5RxoJ1UsJkgn0dpbos78vNbriQcc8Pbu/1xPNLEZqHkw6vkRtnBATO+du9UOvzkfyL4aSVi1itVxwE0kyGCy1GSgyRN3NvirMDBNZHXz82LuQp2caatHKrEDKd5c1dxYdbJ3SgpbD87Lwuz0=
Received: from SA1PR04CA0019.namprd04.prod.outlook.com (2603:10b6:806:2ce::26)
 by MW4PR12MB7192.namprd12.prod.outlook.com (2603:10b6:303:22a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Mon, 2 Dec
 2024 20:51:27 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:2ce:cafe::a2) by SA1PR04CA0019.outlook.office365.com
 (2603:10b6:806:2ce::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 20:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:27 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:26 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 3/8] x86/sev: Require the RMPREAD instruction after Zen4
Date: Mon, 2 Dec 2024 14:50:48 -0600
Message-ID: <5be0093e091778a151266ea853352f62f838eb99.1733172653.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1733172653.git.thomas.lendacky@amd.com>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW4PR12MB7192:EE_
X-MS-Office365-Filtering-Correlation-Id: f5adfba3-d2da-44c6-5698-08dd13131774
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CyEdB29iRTc4bMNEVSF28hADIcJxlTkDLUGpQi5+QZJQmw14ukasd81blNV6?=
 =?us-ascii?Q?585o0vbSIn8j6MRfSVS2Z+e3ICuPKfLzg/eHCCS9CX+LgSgy89KTfpiqVX5i?=
 =?us-ascii?Q?NoyUTONoFcdmgSKTjTH+efOS9T5F3cb1XW9pawer1s75OrMuVMqEY+ewNcYp?=
 =?us-ascii?Q?nCXspZKfyN+D4GtDQHGr3wyZsvmSLEGb2fnyz/Z5RzyfCYQT+/9QXiXYdTf6?=
 =?us-ascii?Q?BNX3CndacbVh9ONTV2xk8lWcld7Ymfr3d1h5rhfMcWoERmVaMXX/O9uYKiWM?=
 =?us-ascii?Q?N4Z5UEne1VlcPMBtKJ+sFBdOnx2FZ4/Frro4d8KRRt2JB7c+OTSaZWOZGr8T?=
 =?us-ascii?Q?Cmhl76n5LMLdtpuCigDnZoOPe9JDjGZRTrhf0a7Fnw5tX2ujvvo5kdysOcGo?=
 =?us-ascii?Q?THhpfAf78wKG14WbniSUCpj4wNaeRi0sZy6UHxys9YoQwa/5vM07TQCDRzpg?=
 =?us-ascii?Q?cb/NIYKgBqQIQsJUYdWEaqEqK1iyCvAWDRVAbzFnkOoTMesMHWgN54qwap0q?=
 =?us-ascii?Q?KRUi8Xct052+9yREtCMd6idepvxeoRvktunhOY+HFqA9CvQC1p+4Y/4rt1FR?=
 =?us-ascii?Q?J87ApSPo1X8ubPkcNJ+bjkRbh4j8Qj3Zx5Knum8I0STQRJyuKH8mzA1tJAH7?=
 =?us-ascii?Q?GxCslwdxx2cschqQ4nwzF0smr54kVupPSYhJxvso+N49gIq9MP9sgpVO6MIP?=
 =?us-ascii?Q?5970sxsKmAQIk4jmQKEKRMh8swew/7KtAm+lla5qi/HC8PXRPx0mhPv/qLNf?=
 =?us-ascii?Q?mdUN4+5WV+pxpW1LZNv92aSbvHF2hP2EZo6PpYwmVfsADieDt0rD5ryoxm0C?=
 =?us-ascii?Q?GadNJ1vs64Y/jxwXMSeElwNpBGV9iGtWgcYRdLrj1j2JW8WbR8O7R8qXlxJt?=
 =?us-ascii?Q?6j9L/spmtyjxksiq+EA5XwBLsTl2r4mZCeSpRaQ5fNEjWuO6eUdMVCmSZ0uI?=
 =?us-ascii?Q?yX3LUisWrw1Z/rV454NDVcloMVAPRRxnVYpQEWnLdJewqCEGEyUkUywq8lhr?=
 =?us-ascii?Q?k+AebMTcgXS6f26nFeXoez1sTIx5IpNCxSSLMk7RaOqqovQKLP8xZxdNiO6B?=
 =?us-ascii?Q?28iMeMghKn9fXiv2wovh9pO9ZViGIRSYYeERoJ9ZmzQhUB5Kvm2uSOEyJNi5?=
 =?us-ascii?Q?r10AX9n3G3fIyu3x03HwHrj0ZCJXdfyU3yUoLFn/8DV7QffMILnAA5bjf4S4?=
 =?us-ascii?Q?2qaiibcpjXyB7uZmPfnZRE3XonL1FAaw7UGRGXTMErvZ4Gw6QjVWYBg0QJrd?=
 =?us-ascii?Q?WvXNb2RvSxLJXHXEjSVpxocWHVTb73oF+oTBX25+rUHWXl3PlHh1BOpYXHrs?=
 =?us-ascii?Q?VZIZ7GHUWvQILy9+lZ+OJyFomcICJ+/lePsgjq+tgg6wNbsPz0/8jmaNGa+j?=
 =?us-ascii?Q?fqwTdmnxXAhlM/LG7HG04pOEf2vNCZpYBQURJoI2pmIaxxqBuzvJVY7D4jHj?=
 =?us-ascii?Q?L68DTzS8HVKa8ZxGD2oeBFLzCE6YR0Yi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:27.4503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5adfba3-d2da-44c6-5698-08dd13131774
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7192

Limit usage of the non-architectural RMP format to Zen3/Zen4 processors.
The RMPREAD instruction, with architectural defined output, is available
and should be used for RMP access beyond Zen4.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/kernel/cpu/amd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index d8408aafeed9..5f6146299165 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -355,10 +355,15 @@ static void bsp_determine_snp(struct cpuinfo_x86 *c)
 		/*
 		 * RMP table entry format is not architectural and is defined by the
 		 * per-processor PPR. Restrict SNP support on the known CPU models
-		 * for which the RMP table entry format is currently defined for.
+		 * for which the RMP table entry format is currently defined or for
+		 * processors which support the architecturally defined RMPREAD
+		 * instruction.
 		 */
 		if (!cpu_has(c, X86_FEATURE_HYPERVISOR) &&
-		    c->x86 >= 0x19 && snp_probe_rmptable_info()) {
+		    (cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+		     cpu_feature_enabled(X86_FEATURE_ZEN4) ||
+		     cpu_feature_enabled(X86_FEATURE_RMPREAD)) &&
+		    snp_probe_rmptable_info()) {
 			cc_platform_set(CC_ATTR_HOST_SEV_SNP);
 		} else {
 			setup_clear_cpu_cap(X86_FEATURE_SEV_SNP);
-- 
2.46.2


