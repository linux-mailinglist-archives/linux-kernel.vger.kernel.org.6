Return-Path: <linux-kernel+bounces-378698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178949AD42D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A392B237C3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825FF1D3590;
	Wed, 23 Oct 2024 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zjPDQ5z3"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8721E7C2C
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708959; cv=fail; b=p6j2gEEw6U39Jp8mCbq6PlWu5Xlj9RSkdK5J3yPiUmzTJYPhHvLsUyW3TS8Dj5LQF7dSHYAi6r8DhR6wRk0uO7IaSXN5nOFbKu4Nx8w9CM8N/IOyBfwjD1omZV+ykP1RPF5dWzIIO+8hDv5lE3vfLt1HtV5CkMawrRTictM6C/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708959; c=relaxed/simple;
	bh=79tBch8UdZK/XBMZsJHm8TC86vCNCq2cWk2w+q7MM+M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwoZYF7ARmjupjdTWyCCRdrW4j/A2hQKTvBqxJIyvU7hUU4UFqrlxBE+WwwRGl4a2os9uIg2kjARInqjsgM5OZ/xziLRYbRN1P+4BTaVz1pkB7fqvOmWZHFJkbtIm49HYSywwd44BBpBGRY3HcKwrGGvAoO5S+TosNTn4Ph3bi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zjPDQ5z3; arc=fail smtp.client-ip=40.107.100.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l9yj6D4d6rrXiM17sSbBqRClI5jSH7sEoOpboKEEKv9Zu56mdQ7ML/XrIpl0WETOSIr4qLZtdZjcuyUiMIW8tLLjepvaBlAK+K6fkXmFzH31Sdnn8TRlkrYmPecPRlhiv51S4TnNkZlkdt67KsuhSlaui04cdh5v+2JtXoZ+tUFxkGSBfJlO5W21MnyfK5t/AKopc65pRDzCcHi92dsxYx2d9Rxc+pBHxf5Wy/UVK8Kptkxq67fzOVImcQwcMFQeyekgn/SqukAmbVE6cvABB8pxm2ReOJebUUuA0x61+leBKlzg3WsMyVvaCBTomMzWjN4DV8wsvMIDccysE+PzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOsH0DxpejhjlH4NVwql6rPk8fnPXDqy193/es3f9rA=;
 b=dnSZbUxffHGWIZz3dinQpNBADowpaeT3vRgOo6W3yDb41Cyj0Uz9XyZZfvfo1Bny09xMIJeoaGQdti76vrrnPhtNwkhkRe1mKRmnChyIZCKdjkKqEWZoAO5yTeqp8b6uBUbAEXmr0pcrouxrPEii4YYzuvvkTGCqE0C5NlKsntSVLd1FrC5aAouJ3HBy3lJIcz+2qoB2bcB8RMy5JAKQYIEUsusLcQIGrIr7GU7xOzixJWxAo2C5xYY3993er0LKPZt5Yh4HBUW1No9xO4vKHamEOWyNhDEn/UWpCFBbDAB16jNK5htljULH3mXaJLjBEYNzHGnBXl19bJKi0qrgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOsH0DxpejhjlH4NVwql6rPk8fnPXDqy193/es3f9rA=;
 b=zjPDQ5z3OW7lGHtYiLanjXAAbzUFZQq6HTgricblGKt8ZC+z/dpD27LFIb4uJeXbG1//Itps2BbLVtNiRkQIhLjN7Gl6NQIWD7lkJY4T6kb4/hV/NohsiwCjZ3BwwCkfXNmJsbtlvcdLvd2//wd094MNW+9IKX79vznHEENZR7I=
Received: from DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30) by
 SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Wed, 23 Oct 2024 18:42:32 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:296:cafe::25) by DM6PR01CA0025.outlook.office365.com
 (2603:10b6:5:296::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 18:42:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 18:42:31 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 13:42:27 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: [PATCH v4 2/8] x86/sev: Add support for the RMPREAD instruction
Date: Wed, 23 Oct 2024 13:41:56 -0500
Message-ID: <cacc1a3e63a790450e342d08457b52b2d471cca2.1729708922.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1729708922.git.thomas.lendacky@amd.com>
References: <cover.1729708922.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 11cf8ba9-0eb2-49ff-470b-08dcf39273ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F6msTHQ4EcJp+4krU/2OokW/W3433OztcablA4TEi9Gk9dkIDL6lVgDxYvim?=
 =?us-ascii?Q?SuvhKhOjoJagmGmo54MSZisPDhhbOYjGJRDVya9IHcZMbGXb9vWtqA4zkbbr?=
 =?us-ascii?Q?7s/IeRUCg3I983nhTT6W/ihpQ0m2bOlTV5sXmFfKqcaHWkD4JapQG7vCQhr4?=
 =?us-ascii?Q?CxWa2xCDpV5rk6kcU/X5irhD+l0pvTco4/kwrkXcjjYeByw754owKjfUxIps?=
 =?us-ascii?Q?lKnT9i0FvsV+Tdb0nV8SowN2kBhyY28nzAkVNj9P5dBYUbb8KEL/xZfuZQA1?=
 =?us-ascii?Q?D85kG/fz/h1tYv3Bw6PQSKnQ7Vqhbg48j4Rbxn9S1UMOuj/LPyRVb0WUFyC8?=
 =?us-ascii?Q?AZNHl1Iss2/0Z/1m9ZdkBzEzjVkVWrQfM1YUMqAn3LYjpsUS70fZOOEcHzA/?=
 =?us-ascii?Q?CBHe543EnErRahdv769rV5NpgJ/uEpKgS1IlowWEksucrY9P170zl4gn0SMD?=
 =?us-ascii?Q?J/Ilgs467/Gh804XYlTJjUxVLPRPHyWyQ3VhilnJihlSqKIi6QBqKxeckRxM?=
 =?us-ascii?Q?knNBOArZGfMhbKAO0X1Gj3UlXhRyUvGnTw5kZJ90qwkSLbFxo/pxeUTcOBbE?=
 =?us-ascii?Q?TiqwuuaFO41V2ZN2VwZxh61elgd829DjTlhDuz9xJ4QiIiWXvcS1843sIL2R?=
 =?us-ascii?Q?cZNmyTwJmFWg6uFliX0wdse7uZecVVunbKPRy5JNCczXRyaX7p2gZ4p48EVZ?=
 =?us-ascii?Q?saXNA00FoTjyJwaFaF6hwLOiX2eyUxg2RiNFhoTmAjaOe302QyIXnP4CCn8M?=
 =?us-ascii?Q?+Mtv8kqLyumJpMyOljK50yirEKQiYmj2w2MmMfP0FPkf75HR/UwWzW4jZpW5?=
 =?us-ascii?Q?gfFV3InlfOa6f133f1VgyUhCZAQ1jWmiS4jVqRs10MBAUZ0JzDhZu2GKSwsq?=
 =?us-ascii?Q?K2cFVIfIWCOpgyw4ndUWSF7XdXjSpwG7wttNR88wduvxUL3za3RUyDzePfeM?=
 =?us-ascii?Q?gBQW8yN13w454r7TWHqQ0DhYkP/x3sCXXH3wnruOyvJvQzVM7DAm5gqk0XrT?=
 =?us-ascii?Q?ljHjSK3xungTbR/2y0u4LV1UFeu9MhZL1VUA57NAjyxYRpZYXWWIxdk/dty/?=
 =?us-ascii?Q?h1xicQkwMbyRSb4mld9dS2uJ44Ohm3pPWI/SQ73C5wvZgvOx2qC0OfsTQL0W?=
 =?us-ascii?Q?9mDxjlq/8kC4h5qXN8Hx5Sd/MTRHMOC9k0hvqbwIO7onL7wNl2+HuR/HNv3b?=
 =?us-ascii?Q?ENrQTmP/4MDjZv7reFwcqI+edYSLdu0IpqYN8lh6BsfNRt9eTMoP3vxQRI6t?=
 =?us-ascii?Q?FzFwsUVFSJq7zkChNna7QXYLanaAB/AXsXg2ZH4wnwDMbUXhaA8UDeXsi/aX?=
 =?us-ascii?Q?4Z/R34XclmjC+01bY3jhhufVrueG+bpZAbGhnIwI54WplOHyXpS/62mBwzOB?=
 =?us-ascii?Q?/MnFEqld8Cd2PWW34076/jFgCJtpAet9OHoyIR5/D6th5bTxbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 18:42:31.4777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cf8ba9-0eb2-49ff-470b-08dcf39273ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136

The RMPREAD instruction returns an architecture defined format of an
RMP table entry. This is the preferred method for examining RMP entries.

The instruction is advertised in CPUID 0x8000001f_EAX[21]. Use this
instruction when available.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/cpufeatures.h |  1 +
 arch/x86/virt/svm/sev.c            | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 913fd3a7bac6..89c1308cdf54 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -448,6 +448,7 @@
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
 #define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
 #define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 4d095affdb4d..e197610b4eed 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -301,6 +301,17 @@ static int get_rmpentry(u64 pfn, struct rmpread *entry)
 {
 	struct rmpentry *e;
 
+	if (cpu_feature_enabled(X86_FEATURE_RMPREAD)) {
+		int ret;
+
+		asm volatile(".byte 0xf2, 0x0f, 0x01, 0xfd"
+			     : "=a" (ret)
+			     : "a" (pfn << PAGE_SHIFT), "c" (entry)
+			     : "memory", "cc");
+
+		return ret;
+	}
+
 	e = __get_rmpentry(pfn);
 	if (IS_ERR(e))
 		return PTR_ERR(e);
-- 
2.46.2


