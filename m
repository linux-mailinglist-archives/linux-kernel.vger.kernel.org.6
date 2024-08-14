Return-Path: <linux-kernel+bounces-287093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1109522CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F8A1F2419E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68361BF315;
	Wed, 14 Aug 2024 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PFOjQH4E"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158441AED23
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665065; cv=fail; b=ZYR8p5hGwJMGi4V/TlP3KCLug+TJRsRXlk6i4FWgAuRZ5sLQvlIWGd10WzZ28TPdQ5IF6X7Pun1BhK9eNBwkWQfi4snwNmNcZFFFNjaACh5S7nk+KkAbuX/EToN1YsN/9qZX/wOisZswfVyV424pYkB4tz9Ip2g89fpipMtKLiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665065; c=relaxed/simple;
	bh=MwV05Gr3lEkATUM+Z3skJAmQOe4rGIn/hUTxC08nFf4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSG1D9Njgw/4sm14/rCEdXDGTbKiehVzAao2hEAedCmGS3kk2IEATFQFEPBUNaGmhVZQZEv38iAxH2TamjztnVE0SdY7l7Jt3g5fVkZbA8bKqoPB2IyRJ5HSYOXPTBiWIu2doHT3a1hx1x/x9aswfxDYbFUMdp4YS7A0VQFw0fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PFOjQH4E; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4S+Tkg64189qPdFpgyID5/1HMzHppMhJdtuM2ResspSVMuI11W0/XUw6giq1Hq3waGpTGJGVZpeHjikERB3f7W/S6D+4IacxwuaA0a35Dj9sQKncXzWDgurLIIp42+sKJg11sKjHE0KctflSv3pqTKWS/5hrWcYxBmXKiBDlZ6Ix3+7YNun4G9mFMZEsNSTy/LshzOKDi85t3muEkcGIaX4kGCmYcu6RRNdIvCM7vuwfuMz9qzMj7awmOn/NmciiVUM5VzWHS6hEOXiVVMPSj40OK85PUvGLzq5Mefa8fFLgXnS99v8IqOWePQD4+6RUfoEN1Gc2xXLf6SASVNolQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55nJnnKdgeDx4oUSXrJ9Q+OVSfhHt48p1gn05H5VmsQ=;
 b=ENS3QAfIq8F4Q1ilItiUfhLZkMxOnFj/FHLt0ZuRPu3XpU/lfNg9dKgAPBoRwx82Jb9Wz0Q1kVLmpqbaijQUngj4NLx4n+k81XySKmhzl1iODZX+XKHU/lm1f7lrYvy0vWnit+efHcgIuGd5qUSzPn6C6M0ilfdPbpkZFKYTk3bhyaw2sXnmjO0Q/73dZtCUIQUpEOknFYFTQu86u8DiDJx7nvM8HgUHZVKnSwGGrNwFKDg/hSvk77yI3SLQqJ9M9nEyqznTWBxzi95MuvqY/SFFP34agF3Y2C1408Kk9FOSu/xhhLXRNBVG9CVgt32o+icGksw8f7EVFzUlkQkM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55nJnnKdgeDx4oUSXrJ9Q+OVSfhHt48p1gn05H5VmsQ=;
 b=PFOjQH4E+C7uqEJ9h9uGQTswKzZLLXvvUvvitFu8upS8RaUmsKU52uZFchBLgMCmHuGra/Em2aSUKYTx3QElEg308twoi1hJ62a63zCgG9RB2dSS3hmuJDJXzNnHyiyX6TQUdQ1tSGdpvf6IBMdFj0+5TnYXT4mf6Itl9FL5h7I=
Received: from BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 19:51:00 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:f4:cafe::ce) by BYAPR11CA0105.outlook.office365.com
 (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 19:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 19:50:59 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 14:50:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 14:50:58 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 14 Aug 2024 14:50:57 -0500
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
Subject: [PATCH v2 1/5] xen: sync elfnote.h from xen tree
Date: Wed, 14 Aug 2024 15:50:49 -0400
Message-ID: <20240814195053.5564-2-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814195053.5564-1-jason.andryuk@amd.com>
References: <20240814195053.5564-1-jason.andryuk@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ea837-02f2-4b07-c4a1-08dcbc9a6bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lmso1Vq4UOfkPrGq12SvOcPpaE1YAAUg90xVFr0cxmnmBUMC6DvTjqgoQo0y?=
 =?us-ascii?Q?jnW1I1E/lMYYuVrvU67Bt+azdbm+CHQE9v90QUnKfdPiG6Rq1nD9fKcK8WE7?=
 =?us-ascii?Q?pcYo3pwjgDDFg7QCEOVaNK3bO+D0VBVNjT7WhZHB/f6fg86TdnnzcL0sy30o?=
 =?us-ascii?Q?qVKKuEZ8qcTMk9t78p74B7yxMimPq/49/+wObE4BN/rTex4rVRcGBqGJVAXK?=
 =?us-ascii?Q?3EEsC6an8Pm3gtWHQEHqO1yWiliVDULLWIfnwmRVlnDiIp/VsdP571xTveOE?=
 =?us-ascii?Q?SboaboIjBpDRqBqFBVrzA6PHUCh1H4wF+LyIqihq//DzStbVX7Q8fQU12iLt?=
 =?us-ascii?Q?GSySyw5XxVScDRs7GZvOH/i63vSeICtGjTnJ9fTxX168YPdn3oeWs2X3ll1M?=
 =?us-ascii?Q?4ANdLvgpCNwfl264HZK1XXbSoGarcGgsroMZXqt2DNXL/Qkn0rSkmX0gSxms?=
 =?us-ascii?Q?Z7Kn4GAKHn807F5pXO9zqgIwZ1D+zDHHO+Ep4fXIYar9AK7BvtW7hs3OyD7g?=
 =?us-ascii?Q?LUVzIRcmr9jXZAlrUHYRJ7V8uB3QGf2EEisCxJ0qsm73ntg5MCXdwa41PoVl?=
 =?us-ascii?Q?4nlSu3Rn05ya+RVoTmgYSGF2VQjx0JbjB4gcS+cSxyr5BzNY+fQcu1aaJm2h?=
 =?us-ascii?Q?mXIQAqjjgCU9ymv0sqAwkTO6QKOpLyEFSY4wtMpMMC6BfRhGdV1sxStiAac7?=
 =?us-ascii?Q?7A5g2o4nCBrpX0GP97eASOAA21gd2bRRcIdMkg+NhiBsvn42xhrPAWGEKXH6?=
 =?us-ascii?Q?/mK5sKyRt0ZkkUGyWZ45OTnbtT8gjdReqSizPI6kJFN/EFZWrvI02fYWN4cp?=
 =?us-ascii?Q?yaTJyYj6a+PwpOl9XJjEX00L0ykfA261A5QVaMzYNyjK/DV1SXpKRW7mvQDd?=
 =?us-ascii?Q?xENXVGNg1LDpz44tzCQlKxFCbusprBeuHKMriTc5RROElWwzfZDT2ilvFoBR?=
 =?us-ascii?Q?ZEPj6/rJC4gYvykDN+vcvs1oMr70I4JNMVf8S6Mt6rgpZ+nQspuvucpLs+E+?=
 =?us-ascii?Q?YleGC0rLcGaWJ3wpNoQ7lrxSczNiESaSy7f38qW2AmeidHe5Z6IOQs6JdtQP?=
 =?us-ascii?Q?b+vLXhmBxYIh8F3EEFqnRfNeCHFF43KVYiYVvYkp+JGvZHnpxmuQeBe6JJe3?=
 =?us-ascii?Q?6x9d7pb9mSiZuNQ07oyz2QQocOGVfAZch2w8K+kkkbRAbwgW6mySw4UK0+u1?=
 =?us-ascii?Q?O9HcF9zGh5WPm0OLM608Xsx+5ebnA67sRug86k7EKtLyNNH/COMydhLPhoO/?=
 =?us-ascii?Q?A+oG9LHSFCktJemuTC/nMeKFMv6rCCugHI8qUOsibnHsk2FUWzGrV4j0p/9c?=
 =?us-ascii?Q?5v+WOCUwHzi1VH+WnMGgHzmPgdmXE6l959F3VhetowMqnjqh+SO8/josSh73?=
 =?us-ascii?Q?YnC4+T3BQB370QETus6zZ51Wkyvq+135jv232iTH7N9H1La5k6Ar65upTMBE?=
 =?us-ascii?Q?9rrbE0XT+b9rd6wTDQYcMudYIZ1UnHRijzA2GnSPwBKpkqU9PfBUhQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 19:50:59.9990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ea837-02f2-4b07-c4a1-08dcbc9a6bf5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379

Sync Xen's elfnote.h header from xen.git to pull in the
XEN_ELFNOTE_PHYS32_RELOC define.

xen commit dfc9fab00378 ("x86/PVH: Support relocatable dom0 kernels")

This is a copy except for the removal of the emacs editor config at the
end of the file.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 include/xen/interface/elfnote.h | 93 +++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 5 deletions(-)

diff --git a/include/xen/interface/elfnote.h b/include/xen/interface/elfnote.h
index 38deb1214613..918f47d87d7a 100644
--- a/include/xen/interface/elfnote.h
+++ b/include/xen/interface/elfnote.h
@@ -11,7 +11,9 @@
 #define __XEN_PUBLIC_ELFNOTE_H__
 
 /*
- * The notes should live in a SHT_NOTE segment and have "Xen" in the
+ * `incontents 200 elfnotes ELF notes
+ *
+ * The notes should live in a PT_NOTE segment and have "Xen" in the
  * name field.
  *
  * Numeric types are either 4 or 8 bytes depending on the content of
@@ -22,6 +24,8 @@
  *
  * String values (for non-legacy) are NULL terminated ASCII, also known
  * as ASCIZ type.
+ *
+ * Xen only uses ELF Notes contained in x86 binaries.
  */
 
 /*
@@ -52,7 +56,7 @@
 #define XEN_ELFNOTE_VIRT_BASE      3
 
 /*
- * The offset of the ELF paddr field from the acutal required
+ * The offset of the ELF paddr field from the actual required
  * pseudo-physical address (numeric).
  *
  * This is used to maintain backwards compatibility with older kernels
@@ -92,7 +96,12 @@
 #define XEN_ELFNOTE_LOADER         8
 
 /*
- * The kernel supports PAE (x86/32 only, string = "yes" or "no").
+ * The kernel supports PAE (x86/32 only, string = "yes", "no" or
+ * "bimodal").
+ *
+ * For compatibility with Xen 3.0.3 and earlier the "bimodal" setting
+ * may be given as "yes,bimodal" which will cause older Xen to treat
+ * this kernel as PAE.
  *
  * LEGACY: PAE (n.b. The legacy interface included a provision to
  * indicate 'extended-cr3' support allowing L3 page tables to be
@@ -149,7 +158,9 @@
  * The (non-default) location the initial phys-to-machine map should be
  * placed at by the hypervisor (Dom0) or the tools (DomU).
  * The kernel must be prepared for this mapping to be established using
- * large pages, despite such otherwise not being available to guests.
+ * large pages, despite such otherwise not being available to guests. Note
+ * that these large pages may be misaligned in PFN space (they'll obviously
+ * be aligned in MFN and virtual address spaces).
  * The kernel must also be able to handle the page table pages used for
  * this mapping not being accessible through the initial mapping.
  * (Only x86-64 supports this at present.)
@@ -185,9 +196,81 @@
  */
 #define XEN_ELFNOTE_PHYS32_ENTRY 18
 
+/*
+ * Physical loading constraints for PVH kernels
+ *
+ * The presence of this note indicates the kernel supports relocating itself.
+ *
+ * The note may include up to three 32bit values to place constraints on the
+ * guest physical loading addresses and alignment for a PVH kernel.  Values
+ * are read in the following order:
+ *  - a required start alignment (default 0x200000)
+ *  - a minimum address for the start of the image (default 0; see below)
+ *  - a maximum address for the last byte of the image (default 0xffffffff)
+ *
+ * When this note specifies an alignment value, it is used.  Otherwise the
+ * maximum p_align value from loadable ELF Program Headers is used, if it is
+ * greater than or equal to 4k (0x1000).  Otherwise, the default is used.
+ */
+#define XEN_ELFNOTE_PHYS32_RELOC 19
+
 /*
  * The number of the highest elfnote defined.
  */
-#define XEN_ELFNOTE_MAX XEN_ELFNOTE_PHYS32_ENTRY
+#define XEN_ELFNOTE_MAX XEN_ELFNOTE_PHYS32_RELOC
+
+/*
+ * System information exported through crash notes.
+ *
+ * The kexec / kdump code will create one XEN_ELFNOTE_CRASH_INFO
+ * note in case of a system crash. This note will contain various
+ * information about the system, see xen/include/xen/elfcore.h.
+ */
+#define XEN_ELFNOTE_CRASH_INFO 0x1000001
+
+/*
+ * System registers exported through crash notes.
+ *
+ * The kexec / kdump code will create one XEN_ELFNOTE_CRASH_REGS
+ * note per cpu in case of a system crash. This note is architecture
+ * specific and will contain registers not saved in the "CORE" note.
+ * See xen/include/xen/elfcore.h for more information.
+ */
+#define XEN_ELFNOTE_CRASH_REGS 0x1000002
+
+
+/*
+ * xen dump-core none note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_NONE
+ * in its dump file to indicate that the file is xen dump-core
+ * file. This note doesn't have any other information.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_NONE               0x2000000
+
+/*
+ * xen dump-core header note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_HEADER
+ * in its dump file.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_HEADER             0x2000001
+
+/*
+ * xen dump-core xen version note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_XEN_VERSION
+ * in its dump file. It contains the xen version obtained via the
+ * XENVER hypercall.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_XEN_VERSION        0x2000002
+
+/*
+ * xen dump-core format version note.
+ * xm dump-core code will create one XEN_ELFNOTE_DUMPCORE_FORMAT_VERSION
+ * in its dump file. It contains a format version identifier.
+ * See tools/libxc/xc_core.h for more information.
+ */
+#define XEN_ELFNOTE_DUMPCORE_FORMAT_VERSION     0x2000003
 
 #endif /* __XEN_PUBLIC_ELFNOTE_H__ */
-- 
2.34.1


