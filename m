Return-Path: <linux-kernel+bounces-202822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8E8FD185
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F50B26D45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE274153561;
	Wed,  5 Jun 2024 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pREFzcUy"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05373450EE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 15:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600855; cv=fail; b=df/jvVIJTYEeAQNpQ+GJEVIKE7hPxFctSsNSKg/apy1SWapxT0b82udm+NR25YQo7a+x01006eJjSJOIsYpkFWe0Yl0fu8OIT8x2cuhbMmlFevsTnz2NqaDg7fu0Lwwpoz0AMhEvAz+zNK01H/E2ymvQX5abo8N70GWKPn5IGTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600855; c=relaxed/simple;
	bh=HMlxu65a9MuDXhQyH5a/nRzV9Vx3jWVrs2PdYTw8zN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SWZYjyL0zIs2IpXnbP8o0AeRAz48wi153Ac2PnmUfXBjkY6FYkjR1VR8YX34Wfk24ggMbWAyw2fc4DMQ6dBt4DC6A4dUWE0TR/rsZi+Ra2lwn/zslQkRNu4ezJERvwdQYwiSQdrj6a8OLyz8MGi+iU2I27al7rjiVX5/QLXuaDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pREFzcUy; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kon2jk4BXew4Sp5HSwDoVgnpNVMpilsBjGQutAqM69CkFnKni3ljKR+Woo+dvi6KF7XzlY6RikofjVIucOiOLgABtinmWPuUikcOPerd69iGuAGX71n3ywm8yKtwgGVpH2GPoJHDffRo6aUamIJXZHEqM98KKykkwX1aH9x2wnpUyGl3vDJ+F3B+CPWQdjrl6wASf/5lVzRujD6AMgbUXEUsXOO0SF/fZXsYbs8QS/pnO+MepZp46bHCZHFM1X38Lb8PpzJ0YN7sp/57p1ERof8V4N3sqUxjU4kIewNwpOUZSx9WVCF4Vl61G0Wpl9TEC/celnsp43g4DLHdqboO3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Q2Es/7LVzu/SEJqP++cWwz1ab1f3sNS+C1tBNJ7p2Q=;
 b=LmYKUQAhakX765G1NhyjYpJQh/d8NOLNlKm20gSVlzfOfK+JcYfOS7jdEgwWXXVm/J25Y3xqhMJxNaAvD8c3azL0+BerUncyjCNRIAh+8lDEdDcHzJLXnU+Me1X/KJ+I69NQyvcCRW+j8IEDVdi/pjfRvJUG6PnrC0WVX3X8S/wjPEmwC6RVPD0nZHmkSwbwRvlp3GsrA80PcaznQoN5F1EXq9bcBxjakx+UGcRtlJsUGwCzttAg+3gm/hnbSr8Pr+f2s2v6AVKBQkSLCg84gjmTj/yamwIpvgr5qgvPPSeTsTLq89OLaagtZFCK5Lm0C5ISU9Nw5I9UaMCTD7E1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Q2Es/7LVzu/SEJqP++cWwz1ab1f3sNS+C1tBNJ7p2Q=;
 b=pREFzcUyIL7mYznMNmFOEeuTn6JiGuBxsV9wP9Kb4JX+M0feQl6QV+wWxefvSDxgLL7KC0oA8ZKSNLhwHQIEcg18I3MSrJZzUuhYXjLfpE76owBUjV07GdPG5fVSA7n9HUbOpc2fGmNvxHn0WRiJJ8XlsOSvyCPVPsxSvtlFiP8=
Received: from BN9PR03CA0695.namprd03.prod.outlook.com (2603:10b6:408:ef::10)
 by CY8PR12MB7609.namprd12.prod.outlook.com (2603:10b6:930:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 15:20:43 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:ef:cafe::f6) by BN9PR03CA0695.outlook.office365.com
 (2603:10b6:408:ef::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Wed, 5 Jun 2024 15:20:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Wed, 5 Jun 2024 15:20:43 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 10:20:42 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v5 12/13] x86/sev: Extend the config-fs attestation support for an SVSM
Date: Wed, 5 Jun 2024 10:18:55 -0500
Message-ID: <965015dce3c76bb8724839d50c5dea4e4b5d598f.1717600736.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1717600736.git.thomas.lendacky@amd.com>
References: <cover.1717600736.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|CY8PR12MB7609:EE_
X-MS-Office365-Filtering-Correlation-Id: 1543787a-9796-4ab5-1d19-08dc85731103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ao+CN3SiV/H8hamUDCRkUPOkwAoQBZ1/W0XXVzFpv1lcOHugkGdojIl0vmnJ?=
 =?us-ascii?Q?K5FwxtEqmNE1ZiK20Tkpw6U20QD9Bq+XYWQ7SJk0TzKAW1C26DMijMAZcOLc?=
 =?us-ascii?Q?MqN5FXlxV3Jt5R9X5zh8eBWXgAb4sxoC7VP7iJHGw94uf8VWXEBbVMpgVa1L?=
 =?us-ascii?Q?cRms/nE2rHiBgOPkl6OozRDAt9CuJRwYKRxSCUn4xd8ekRrOQjKiCR+dg6ih?=
 =?us-ascii?Q?CMH3ZYgt+MbtEgre2gMjcJ0qahiw+Pyw8JyyPkYSPu3oZS9HE3mCYmnHO9+c?=
 =?us-ascii?Q?umpPZ3exJbffzkjiJdHht+e7vrhf+JVNN5y9vBMAgsfZJllCszg4HMDSe8hh?=
 =?us-ascii?Q?YZnwAJM6ishLemtqzwavcC1ouTF1zngPq557hmlBM2+B6N9m6A8fkmi56h7z?=
 =?us-ascii?Q?5+PgLXpkFQ95pPdm3kddXo9RP4XaES+TZJs1EY/PDlp2Q3xGXvvteAz7t5eU?=
 =?us-ascii?Q?0rFPiTbCYMQKUV6IF5kpljJzmuwS/WpnDjCFjjX47zGRqMsZpYL8eDcGZYv5?=
 =?us-ascii?Q?BVD8RJKjTEwNw6KupeCFdO2ScoI3CYwb64LfMU06FH9mV4kxenk9WcWJJ7CJ?=
 =?us-ascii?Q?9gGfAEFLGHP0cuF85tRCdxL9AU1USWksW7KFMwAo3bfq50+ozSAckaEwo6kb?=
 =?us-ascii?Q?a3S8sBDR18mSBAdLR1IK1BVMTHN7Ko/TIBFoe4hiMutE4llXkoRvEItpOeAs?=
 =?us-ascii?Q?8uhxqohDGNl9A11eiJ9lvL9pCEY3QgEt333uXxmkYdJNmL1aYi1na2XTEpyx?=
 =?us-ascii?Q?fakoVU0WBHDN+hwkkH89HjNiK9EqVu8/NZYupcSficFBO9lAhJzY6Q2KKW4W?=
 =?us-ascii?Q?60wxL2m7WX5zm1pfgOKDkuveFHyDjcWDxAu4K3nsKXNfMA62q0NDRakuol0v?=
 =?us-ascii?Q?ONDUmjedAvgEybdr1e5DSzkA1VV1R/p0g2G5bQutz/6TrGuUJ5msNPgctktF?=
 =?us-ascii?Q?XLPsIvIVxk9hCyutvYTwdv1Zxk+adTHkLRJ0MbOGvYWYZbXgGh28KDe7mKjx?=
 =?us-ascii?Q?97oKcAE8ExzIqDmNCY1qavA8n679QfQlBGccYB0aOTXY3amjgO2iCT6+ac3g?=
 =?us-ascii?Q?LkoJEszWGgj0qbnzR0B4Lsa3iOCkl6ATwxu9C5CPNYOOSNq+Sn2c174LN4Us?=
 =?us-ascii?Q?hKmI7GAQUtApi0doUGVvEwRIlkiSx57j5HTw9bHxA8AY01YodW+D8QNQI4MB?=
 =?us-ascii?Q?k0q/RjeIxvpxD8EcRiQD5AS6gkWDFZRM/ZKgQd+ARykLn5WXlXA8cn/k2IN5?=
 =?us-ascii?Q?2wJDUHJVa/mbjXzczQI5a+qYn2S+WtHFY6zrzqC5VoryzhtnAUmQNAWSCs6E?=
 =?us-ascii?Q?9iqldJdtRJ1tNT1Yx7GMpLxo0mZVwYIdlaiHfQsSunIipjPJ2qmkwYg6UpKV?=
 =?us-ascii?Q?/96gUkj6QlUsopwVb3r/glk/8z11?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:20:43.2292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1543787a-9796-4ab5-1d19-08dc85731103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7609

When an SVSM is present, the guest can also request attestation reports
from the SVSM. These SVSM attestation reports can be used to attest the
SVSM and any services running within the SVSM.

Extend the config-fs attestation support to allow for an SVSM attestation
report. This involves creating four (4) new config-fs attributes:

  - 'service-provider' (input)
    This attribute is used to determine whether the attestation request
    should be sent to the specified service provider or to the SEV
    firmware. The SVSM service provider is represented by the value
    'svsm'.

  - 'service_guid' (input)
    Used for requesting the attestation of a single service within the
    service provider. A null GUID implies that the SVSM_ATTEST_SERVICES
    call should be used to request the attestation report. A non-null
    GUID implies that the SVSM_ATTEST_SINGLE_SERVICE call should be used.

  - 'service_manifest_version' (input)
    Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
    represents a specific service manifest version be used for the
    attestation report.

  - 'manifestblob' (output)
    Used to return the service manifest associated with the attestation
    report.

Only display these new attributes when running under an SVSM.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/ABI/testing/configfs-tsm  |  63 +++++++++
 arch/x86/include/asm/sev.h              |  31 ++++-
 arch/x86/kernel/sev.c                   |  50 +++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 178 ++++++++++++++++++++++++
 drivers/virt/coco/tsm.c                 |  93 ++++++++++++-
 include/linux/tsm.h                     |  19 +++
 6 files changed, 431 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index dd24202b5ba5..bc8f6efa5d6f 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -31,6 +31,18 @@ Description:
 		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
 		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
 
+What:		/sys/kernel/config/tsm/report/$name/manifestblob
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) Optional supplemental data that a TSM may emit, visibility
+		of this attribute depends on TSM, and may be empty if no
+		manifest data is available.
+
+		See 'service_provider' for information on the format of the
+		manifest blob.
+
 What:		/sys/kernel/config/tsm/report/$name/provider
 Date:		September, 2023
 KernelVersion:	v6.7
@@ -80,3 +92,54 @@ Contact:	linux-coco@lists.linux.dev
 Description:
 		(RO) Indicates the minimum permissible value that can be written
 		to @privlevel.
+
+What:		/sys/kernel/config/tsm/report/$name/service_provider
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports from a service
+		provider for TVMs, like SEV-SNP running under an SVSM.
+		Specifying the service provider via this attribute will create
+		an attestation report as specified by the service provider.
+		Currently supported service-providers are:
+			svsm
+
+		For the "svsm" service provider, see the Secure VM Service Module
+		for SEV-SNP Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+
+What:		/sys/kernel/config/tsm/report/$name/service_guid
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports from a service
+		provider for TVMs, like SEV-SNP running under an SVSM.
+		Specifying an empty/null GUID (00000000-0000-0000-0000-000000)
+		requests all active services within the service provider be
+		part of the attestation report. Specifying a GUID request
+		an attestation report of just the specified service using the
+		manifest form specified by the service_manifest_version
+		attribute.
+
+		See 'service_provider' for information on the format of the
+		service guid.
+
+What:		/sys/kernel/config/tsm/report/$name/service_manifest_version
+Date:		January, 2024
+KernelVersion:	v6.10
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports from a service
+		provider for TVMs, like SEV-SNP running under an SVSM.
+		Indicates the service manifest version requested for the
+		attestation report (default 0). If this field is not set by
+		the user, the default manifest version of the service (the
+		service's initial/first manifest version) is returned.
+
+		See 'service_provider' for information on the format of the
+		service manifest version.
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index f7a966e99a73..96897cd6b9e6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -213,6 +213,27 @@ struct svsm_pvalidate_call {
 					  offsetof(struct svsm_pvalidate_call, entry)) /	\
 					 sizeof(struct svsm_pvalidate_entry))
 
+/*
+ * The SVSM Attestation related structures
+ */
+struct svsm_loc_entry {
+	u64 pa;
+	u32 len;
+	u8 rsvd[4];
+};
+
+struct svsm_attestation_call {
+	struct svsm_loc_entry report_buf;
+	struct svsm_loc_entry nonce;
+	struct svsm_loc_entry manifest_buf;
+	struct svsm_loc_entry certificates_buf;
+
+	/* For attesting a single service */
+	u8 service_guid[16];
+	u32 service_manifest_ver;
+	u8 rsvd[4];
+};
+
 /*
  * SVSM protocol structure
  */
@@ -236,6 +257,10 @@ struct svsm_call {
 #define SVSM_CORE_CREATE_VCPU		2
 #define SVSM_CORE_DELETE_VCPU		3
 
+#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
+#define SVSM_ATTEST_SERVICES		0
+#define SVSM_ATTEST_SINGLE_SERVICE	1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
@@ -318,6 +343,7 @@ bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
 void snp_dmi_setup(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attestation_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
@@ -350,7 +376,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
-
+static inline int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call, struct svsm_attestation_call *input)
+{
+	return -ENOTTY;
+}
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index d09844db2361..f4ae1d037b04 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2384,6 +2384,56 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
+static void update_attest_input(struct svsm_call *call, struct svsm_attestation_call *input)
+{
+	/* If (new) lengths have been returned, propagate them up */
+	if (call->rcx_out != call->rcx)
+		input->manifest_buf.len = call->rcx_out;
+
+	if (call->rdx_out != call->rdx)
+		input->certificates_buf.len = call->rdx_out;
+
+	if (call->r8_out != call->r8)
+		input->report_buf.len = call->r8_out;
+}
+
+int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
+			      struct svsm_attestation_call *input)
+{
+	struct svsm_attestation_call *ac;
+	unsigned long flags;
+	u64 attest_call_pa;
+	int ret;
+
+	if (!snp_vmpl)
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	call->caa = svsm_get_caa();
+
+	ac = (struct svsm_attestation_call *)call->caa->svsm_buffer;
+	attest_call_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	*ac = *input;
+
+	/*
+	 * Set input registers for the request and set RDX and R8 to known
+	 * values in order to detect length values being returned in them.
+	 */
+	call->rax = call_id;
+	call->rcx = attest_call_pa;
+	call->rdx = -1;
+	call->r8 = -1;
+	ret = svsm_perform_call_protocol(call);
+	update_attest_input(call, input);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
+
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 0c70a38c8cc0..655865164705 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -39,6 +39,8 @@
 #define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
 #define SNP_REQ_RETRY_DELAY		(2*HZ)
 
+#define SVSM_MAX_RETRIES		3
+
 struct snp_guest_crypto {
 	struct crypto_aead *tfm;
 	u8 *iv, *authtag;
@@ -791,6 +793,142 @@ struct snp_msg_cert_entry {
 	u32 length;
 };
 
+static int sev_svsm_report_new(struct tsm_report *report, void *data)
+{
+	unsigned int rep_len, man_len, certs_len;
+	struct tsm_desc *desc = &report->desc;
+	struct svsm_attestation_call ac = {};
+	unsigned int retry_count;
+	void *rep, *man, *certs;
+	struct svsm_call call;
+	unsigned int size;
+	bool try_again;
+	void *buffer;
+	u64 call_id;
+	int ret;
+
+	/*
+	 * Allocate pages for the request:
+	 * - Report blob (4K)
+	 * - Manifest blob (4K)
+	 * - Certificate blob (16K)
+	 *
+	 * Above addresses must be 4K aligned
+	 */
+	rep_len = SZ_4K;
+	man_len = SZ_4K;
+	certs_len = SEV_FW_BLOB_MAX_SIZE;
+
+	guard(mutex)(&snp_cmd_mutex);
+
+	if (guid_is_null(&desc->service_guid)) {
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
+	} else {
+		export_guid(ac.service_guid, &desc->service_guid);
+		ac.service_manifest_ver = desc->service_manifest_version;
+
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
+	}
+
+	retry_count = 0;
+
+retry:
+	memset(&call, 0, sizeof(call));
+
+	size = rep_len + man_len + certs_len;
+	buffer = alloc_pages_exact(size, __GFP_ZERO);
+	if (!buffer)
+		return -ENOMEM;
+
+	rep = buffer;
+	ac.report_buf.pa = __pa(rep);
+	ac.report_buf.len = rep_len;
+
+	man = rep + rep_len;
+	ac.manifest_buf.pa = __pa(man);
+	ac.manifest_buf.len = man_len;
+
+	certs = man + man_len;
+	ac.certificates_buf.pa = __pa(certs);
+	ac.certificates_buf.len = certs_len;
+
+	ac.nonce.pa = __pa(desc->inblob);
+	ac.nonce.len = desc->inblob_len;
+
+	ret = snp_issue_svsm_attest_req(call_id, &call, &ac);
+	if (ret) {
+		free_pages_exact(buffer, size);
+
+		switch (call.rax_out) {
+		case SVSM_ERR_INVALID_PARAMETER:
+			try_again = false;
+
+			if (ac.report_buf.len > rep_len) {
+				rep_len = PAGE_ALIGN(ac.report_buf.len);
+				try_again = true;
+			}
+
+			if (ac.manifest_buf.len > man_len) {
+				man_len = PAGE_ALIGN(ac.manifest_buf.len);
+				try_again = true;
+			}
+
+			if (ac.certificates_buf.len > certs_len) {
+				certs_len = PAGE_ALIGN(ac.certificates_buf.len);
+				try_again = true;
+			}
+
+			/* If one of the buffers wasn't large enough, retry the request */
+			if (try_again && retry_count < SVSM_MAX_RETRIES) {
+				retry_count++;
+				goto retry;
+			}
+
+			return -EINVAL;
+		default:
+			pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * Allocate all the blob memory buffers at once so that the cleanup is
+	 * done for errors that occur after the first allocation (i.e. before
+	 * using no_free_ptr()).
+	 */
+	rep_len = ac.report_buf.len;
+	void *rbuf __free(kvfree) = kvzalloc(rep_len, GFP_KERNEL);
+
+	man_len = ac.manifest_buf.len;
+	void *mbuf __free(kvfree) = kvzalloc(man_len, GFP_KERNEL);
+
+	certs_len = ac.certificates_buf.len;
+	void *cbuf __free(kvfree) = certs_len ? kvzalloc(certs_len, GFP_KERNEL) : NULL;
+
+	if (!rbuf || !mbuf || (certs_len && !cbuf)) {
+		free_pages_exact(buffer, size);
+		return -ENOMEM;
+	}
+
+	memcpy(rbuf, rep, rep_len);
+	report->outblob = no_free_ptr(rbuf);
+	report->outblob_len = rep_len;
+
+	memcpy(mbuf, man, man_len);
+	report->manifestblob = no_free_ptr(mbuf);
+	report->manifestblob_len = man_len;
+
+	if (certs_len) {
+		memcpy(cbuf, certs, certs_len);
+		report->auxblob = no_free_ptr(cbuf);
+		report->auxblob_len = certs_len;
+	}
+
+	free_pages_exact(buffer, size);
+
+	return 0;
+}
+
 static int sev_report_new(struct tsm_report *report, void *data)
 {
 	struct snp_msg_cert_entry *cert_table;
@@ -805,6 +943,13 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
 		return -EINVAL;
 
+	if (desc->service_provider) {
+		if (strcmp(desc->service_provider, "svsm"))
+			return -EINVAL;
+
+		return sev_svsm_report_new(report, data);
+	}
+
 	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -893,9 +1038,42 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
+static bool sev_report_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_GENERATION:
+	case TSM_REPORT_PROVIDER:
+	case TSM_REPORT_PRIVLEVEL:
+	case TSM_REPORT_PRIVLEVEL_FLOOR:
+		return true;
+	case TSM_REPORT_SERVICE_PROVIDER:
+	case TSM_REPORT_SERVICE_GUID:
+	case TSM_REPORT_SERVICE_MANIFEST_VER:
+		return snp_vmpl;
+	}
+
+	return false;
+}
+
+static bool sev_report_bin_attr_visible(int n)
+{
+	switch (n) {
+	case TSM_REPORT_INBLOB:
+	case TSM_REPORT_OUTBLOB:
+	case TSM_REPORT_AUXBLOB:
+		return true;
+	case TSM_REPORT_MANIFESTBLOB:
+		return snp_vmpl;
+	}
+
+	return false;
+}
+
 static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
+	.report_attr_visible = sev_report_attr_visible,
+	.report_bin_attr_visible = sev_report_bin_attr_visible,
 };
 
 static void unregister_sev_tsm(void *data)
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index 7db534b63c9f..9432d4e303f1 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -34,7 +34,7 @@ static DECLARE_RWSEM(tsm_rwsem);
  * The attestation report format is TSM provider specific, when / if a standard
  * materializes that can be published instead of the vendor layout. Until then
  * the 'provider' attribute indicates the format of 'outblob', and optionally
- * 'auxblob'.
+ * 'auxblob' and 'manifestblob'.
  */
 
 struct tsm_report_state {
@@ -47,6 +47,7 @@ struct tsm_report_state {
 enum tsm_data_select {
 	TSM_REPORT,
 	TSM_CERTS,
+	TSM_MANIFEST,
 };
 
 static struct tsm_report *to_tsm_report(struct config_item *cfg)
@@ -118,6 +119,74 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
 }
 CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
 
+static ssize_t tsm_report_service_provider_store(struct config_item *cfg,
+						 const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	size_t sp_len;
+	char *sp;
+	int rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+
+	sp_len = (buf[len - 1] != '\n') ? len : len - 1;
+
+	sp = kstrndup(buf, sp_len, GFP_KERNEL);
+	if (!sp)
+		return -ENOMEM;
+	kfree(report->desc.service_provider);
+
+	report->desc.service_provider = sp;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_provider);
+
+static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
+					     const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	int rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+
+	report->desc.service_guid = guid_null;
+
+	rc = guid_parse(buf, &report->desc.service_guid);
+	if (rc)
+		return rc;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_guid);
+
+static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
+							 const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+	report->desc.service_manifest_version = val;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
+
 static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 				       const void *buf, size_t count)
 {
@@ -162,6 +231,9 @@ static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
 	if (select == TSM_REPORT) {
 		out = report->outblob;
 		len = report->outblob_len;
+	} else if (select == TSM_MANIFEST) {
+		out = report->manifestblob;
+		len = report->manifestblob_len;
 	} else {
 		out = report->auxblob;
 		len = report->auxblob_len;
@@ -187,7 +259,7 @@ static ssize_t read_cached_report(struct tsm_report *report, void *buf,
 
 	/*
 	 * A given TSM backend always fills in ->outblob regardless of
-	 * whether the report includes an auxblob or not.
+	 * whether the report includes an auxblob/manifestblob or not.
 	 */
 	if (!report->outblob ||
 	    state->read_generation != state->write_generation)
@@ -223,8 +295,10 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
 
 	kvfree(report->outblob);
 	kvfree(report->auxblob);
+	kvfree(report->manifestblob);
 	report->outblob = NULL;
 	report->auxblob = NULL;
+	report->manifestblob = NULL;
 	rc = ops->report_new(report, provider.data);
 	if (rc < 0)
 		return rc;
@@ -251,11 +325,23 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
+static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
+					    size_t count)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+
+	return tsm_report_read(report, buf, count, TSM_MANIFEST);
+}
+CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+
 static struct configfs_attribute *tsm_report_attrs[] = {
 	[TSM_REPORT_GENERATION] = &tsm_report_attr_generation,
 	[TSM_REPORT_PROVIDER] = &tsm_report_attr_provider,
 	[TSM_REPORT_PRIVLEVEL] = &tsm_report_attr_privlevel,
 	[TSM_REPORT_PRIVLEVEL_FLOOR] = &tsm_report_attr_privlevel_floor,
+	[TSM_REPORT_SERVICE_PROVIDER] = &tsm_report_attr_service_provider,
+	[TSM_REPORT_SERVICE_GUID] = &tsm_report_attr_service_guid,
+	[TSM_REPORT_SERVICE_MANIFEST_VER] = &tsm_report_attr_service_manifest_version,
 	NULL,
 };
 
@@ -263,6 +349,7 @@ static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
 	[TSM_REPORT_INBLOB] = &tsm_report_attr_inblob,
 	[TSM_REPORT_OUTBLOB] = &tsm_report_attr_outblob,
 	[TSM_REPORT_AUXBLOB] = &tsm_report_attr_auxblob,
+	[TSM_REPORT_MANIFESTBLOB] = &tsm_report_attr_manifestblob,
 	NULL,
 };
 
@@ -271,8 +358,10 @@ static void tsm_report_item_release(struct config_item *cfg)
 	struct tsm_report *report = to_tsm_report(cfg);
 	struct tsm_report_state *state = to_state(report);
 
+	kvfree(report->manifestblob);
 	kvfree(report->auxblob);
 	kvfree(report->outblob);
+	kfree(report->desc.service_provider);
 	kfree(state);
 }
 
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 30d9d270b446..11b0c525be30 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -4,6 +4,7 @@
 
 #include <linux/sizes.h>
 #include <linux/types.h>
+#include <linux/uuid.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -19,11 +20,17 @@
  * @privlevel: optional privilege level to associate with @outblob
  * @inblob_len: sizeof @inblob
  * @inblob: arbitrary input data
+ * @service_provider: optional name of where to obtain the tsm report blob
+ * @service_guid: optional service-provider service guid to attest
+ * @service_manifest_version: optional service-provider service manifest version requested
  */
 struct tsm_desc {
 	unsigned int privlevel;
 	size_t inblob_len;
 	u8 inblob[TSM_INBLOB_MAX];
+	char *service_provider;
+	guid_t service_guid;
+	unsigned int service_manifest_version;
 };
 
 /**
@@ -33,6 +40,8 @@ struct tsm_desc {
  * @outblob: generated evidence to provider to the attestation agent
  * @auxblob_len: sizeof(@auxblob)
  * @auxblob: (optional) auxiliary data to the report (e.g. certificate data)
+ * @manifestblob_len: sizeof(@manifestblob)
+ * @manifestblob: (optional) manifest data associated with the report
  */
 struct tsm_report {
 	struct tsm_desc desc;
@@ -40,6 +49,8 @@ struct tsm_report {
 	u8 *outblob;
 	size_t auxblob_len;
 	u8 *auxblob;
+	size_t manifestblob_len;
+	u8 *manifestblob;
 };
 
 /**
@@ -48,12 +59,18 @@ struct tsm_report {
  * @TSM_REPORT_PROVIDER: index of the provider name attribute
  * @TSM_REPORT_PRIVLEVEL: index of the desired privilege level attribute
  * @TSM_REPORT_PRIVLEVEL_FLOOR: index of the minimum allowed privileg level attribute
+ * @TSM_REPORT_SERVICE_PROVIDER: index of the service provider identifier attribute
+ * @TSM_REPORT_SERVICE_GUID: index of the service GUID attribute
+ * @TSM_REPORT_SERVICE_MANIFEST_VER: index of the service manifest version attribute
  */
 enum tsm_attr_index {
 	TSM_REPORT_GENERATION,
 	TSM_REPORT_PROVIDER,
 	TSM_REPORT_PRIVLEVEL,
 	TSM_REPORT_PRIVLEVEL_FLOOR,
+	TSM_REPORT_SERVICE_PROVIDER,
+	TSM_REPORT_SERVICE_GUID,
+	TSM_REPORT_SERVICE_MANIFEST_VER,
 };
 
 /**
@@ -61,11 +78,13 @@ enum tsm_attr_index {
  * @TSM_REPORT_INBLOB: index of the binary report input attribute
  * @TSM_REPORT_OUTBLOB: index of the binary report output attribute
  * @TSM_REPORT_AUXBLOB: index of the binary auxiliary data attribute
+ * @TSM_REPORT_MANIFESTBLOB: index of the binary manifest data attribute
  */
 enum tsm_bin_attr_index {
 	TSM_REPORT_INBLOB,
 	TSM_REPORT_OUTBLOB,
 	TSM_REPORT_AUXBLOB,
+	TSM_REPORT_MANIFESTBLOB,
 };
 
 /**
-- 
2.43.2


