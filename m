Return-Path: <linux-kernel+bounces-428360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E0A9E0DF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5A3B3C9CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2551DF275;
	Mon,  2 Dec 2024 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qowuP2m1"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C11DF247
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172685; cv=fail; b=dyzNfNJNUpP8QGayAjHan8WR1MTAojFmNabiyb6W2taokM1yQCWRAIi8P+UrC15rhaM5PI5WZ5PSL/P0jXLUHkNAK0QbIhhuF7XAMJ/5CFtAq/dNPLsI5pg/M+SfQvJIo3SgZl0167ycvN3t7Kfd/izCEo6hFbsxDN909q5Xxko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172685; c=relaxed/simple;
	bh=7Oe1bonxfp00KBM5i47zkqxGEyjskCzfhC5hmngNTR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JB+bBsqfRv6DzKHDGAqLvQ0B/HW8HSvZPDLKoSnC/gkWgMlW6OwikUr2AMDWBdrtKbU9pJNwmFX8gHhUgif/oV1AIOPzVJZOGIo8fAMP362PAyUyZIRxzDCBwmDTTTS4Iy+MM6zysBXTiupdY9vQdO2dyB6e5S+OuquwUPUDcCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qowuP2m1; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttqeVGOcEszSit0FHhWsG0TthwdL0VcFjI4QfbLLk532u5plJqUtQ1SLnL6qj4p9RgUEeovcbTmbNQL4EO669fyhrYRg0Aa8mg/w8EurbCgIsCLeh0+lnIj4dVvWx+XRvshM7raUkuIhlsVf6k9aCetXRFXgkuvd33SZ8Hg7szwBvuiYkE58si6MJnD1309eBy8uR+nGXzGjN2l/W3rB71aZFUrOb0JoG1o83LG9N6tG1BEDh44Lq89lu2HE3cbVqSORsEcbQk4q9j//odsyBFQX0E25Y8L8hggjjr1IuaXpq8gq4T9YubMeYd17wF9qDkP4/UNon4G8PWLOPdUPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOzXIeKM1bOge4BTH688sMoG15nyV7I2BXgFwl9dafU=;
 b=QIqXC8q2T/K4bhLpem/ewi4qvDHbycR/BGlLOfpm31szpN1NIz6LD7GZjr4EoCEnMs1gb5jioU6CxL9WQPTVA5ruOFMUc4ag2lq6vTi7I4StMWoGJIfIuIFzLxCCz6TCXm50J2NadWEijcBFccFjvk42KM34F/ro5czcchBeibFgZ+GkFkXABlqWHkvYbDyOp4qziZMp6cDCTUTXSJ6wYj8RCR8dqcdnxcxZHeH4PcCN3MeT9bFZu46Gl6BFPPP7Crz65HFyl8KrX8aaKYW9/zMNm4CNPZDzL+dakryyINVYQZPrQQrdj6WTniBXvNf61ddoXqX0YNjwdTaDlQf72g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOzXIeKM1bOge4BTH688sMoG15nyV7I2BXgFwl9dafU=;
 b=qowuP2m13Wo8weoJdV9B/lxVA6kLpzXEmrjQF1kim+fW5+1Zm1O4ukswIXw76dZxgyeemt0by4VbtUhjKS5HtXYcKqmrUBWLHbaeut9x16AZNOBbOMKb5zKeksg0/rSOMf6tB0sqOd0ip4bt7Qc7qdQg8dYLThbsV2IJYF0jYF4=
Received: from SN7PR04CA0094.namprd04.prod.outlook.com (2603:10b6:806:122::9)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 20:51:20 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::fb) by SN7PR04CA0094.outlook.office365.com
 (2603:10b6:806:122::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 20:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 20:51:20 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 14:51:19 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v6 2/8] x86/sev: Add support for the RMPREAD instruction
Date: Mon, 2 Dec 2024 14:50:47 -0600
Message-ID: <72c734ac8b324bbc0c839b2c093a11af4a8881fa.1733172653.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: 7252f2d1-31d4-4a4f-e46f-08dd1313132a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7p9lMJJTkPcE8cYvtCeLyAq4kZ2eMklIOIFhW1wUiPIyETG/yU3hQlBhT3a2?=
 =?us-ascii?Q?yKg+Ng5XxCPekEIricA7QblLKcNhoJxNz3SoJd0RUZOCr9aKEjYTWxqNEu1U?=
 =?us-ascii?Q?m1ZD00PMjCld8XBcDR5LiMC/IVeFpE0AwtGfGvwpWCEkMJITQXG8Dswyru5b?=
 =?us-ascii?Q?45i301K6zf0EYn/WrFs7qvrf7UZh2vHqtFh3opkYz62sVK3AzAf2SFRhA/TS?=
 =?us-ascii?Q?2/nFSIL8P1mUddlYzIAyoHu32ztdB7zlXVZ5xPWwQPWWpQCEUdnSWmWCtPWo?=
 =?us-ascii?Q?rCxqovWRYhEYk/Bx3ZoyLAYgdzms1ALFqHnlHXPRraQXrfsnlyAx0+dfhr8H?=
 =?us-ascii?Q?k2uij2tOsXSArbSAd9cLbRWUJQwvmQBGi15D+DEXOl8tXJCIpCCSQeSRY35h?=
 =?us-ascii?Q?USYe7+QoIaiyGkTPl+AdVa8Jz+3+C7zIrvIiUhEyRGlWujb/TiBYIJup1hBq?=
 =?us-ascii?Q?WagOff1yWYwV0kvgoKT+Nn/KcDuToYI/wdnMx6mjpNV823Ph9U2qFT9w8RLR?=
 =?us-ascii?Q?HPwky8KOlff/rwRseTDd1Hisy6q4VYhG8c4680/L9e1HzOy2rsfVK/T/qxsU?=
 =?us-ascii?Q?Gk2ISYK89NYjTVz1gwrPLQrPRz8ZPgy9AJkVawjbUmr9KaukSDlvOtkDC/2w?=
 =?us-ascii?Q?5A65eohrhNsYJ4TJuqdnR/S1oSJyVOg2fVF77crsGwS8RZJJcWiOHnFRKnOX?=
 =?us-ascii?Q?FslHgOI/2Woqb7XrdlstlL2ZqmGt4l/TiMdK44f4ROVcDpa3kK2JxbhqYwU4?=
 =?us-ascii?Q?3Jo95XnPALzHusDHfJ+GVEoZMEwUx6HkCBhyQ+e/vJ1ojuvUN1dnJOUM34iF?=
 =?us-ascii?Q?4sOJIAQT8DUBnGR0LxBRhqNMvUEr7/oXYGiio704e9hkeWuIMAzCIJxapW+0?=
 =?us-ascii?Q?skp0CaQ/5y2yU3PbImN+veReTdUalmhyM1jjAmkZTGCdKQUSzPTNtZ3rE6i4?=
 =?us-ascii?Q?jFp7DDL9ccUgG2uQ9c26i8hzl5oRVqFrpal8rFxZ5g6LzjmZ+g/f95ax7r1S?=
 =?us-ascii?Q?AY7EefI2Pb2o4vuSbtNSoJvrOHCy69oBsnzSAndaz6inSYaSMlZQCjISG4m2?=
 =?us-ascii?Q?Xn55VBFKj+WS8ViBBHOdPtbbbiASybXCQ5ValUeEpEi8RC156H3RqP/fW1JB?=
 =?us-ascii?Q?X8s9Q4qzL/A9KzRKdJV9dMLejBsZPvvJuqbUr6839FaSdwibGWtUmdAqZmk2?=
 =?us-ascii?Q?fp/qx030aKQotnq4QELkhjiYGIVi8W4wOvpOutdyZPg485n54LtTU4LatNf6?=
 =?us-ascii?Q?iNNawVu5NVeSJx5ve4uveMP/mE7n/gh3JKNgz2Kmqi0/Xuii7mzn2U5Y6THt?=
 =?us-ascii?Q?mRKsI6KYNd2EwKo48VZPK5WfIp913bDeCi6UfODBZx4HsOmyvfsyWQPmabQn?=
 =?us-ascii?Q?+JypCqrxvLepc9bV15oTWVC7lIs7YDw9qcO5i+vP4BOHHISWgzUVZMBLwGv9?=
 =?us-ascii?Q?DYwG0PvEn+EFlc1O/Hgnplj2JioJ24jT?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 20:51:20.2581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7252f2d1-31d4-4a4f-e46f-08dd1313132a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 17b6590748c0..5535edc6e8d7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -451,6 +451,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index cf64e9384ea0..18191cbd78c5 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -306,6 +306,18 @@ static int get_rmpentry(u64 pfn, struct rmpentry *e)
 {
 	struct rmpentry_raw *e_raw;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		/* Binutils version 2.44 supports the RMPREAD mnemonic. */
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (e)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e_raw = get_raw_rmpentry(pfn);
 	if (IS_ERR(e_raw))
 		return PTR_ERR(e_raw);
-- 
2.46.2


