Return-Path: <linux-kernel+bounces-413348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE59D17E5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90632827F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675311DF26C;
	Mon, 18 Nov 2024 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XIVlTWxd"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023129.outbound.protection.outlook.com [40.93.201.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE51DF253
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731953864; cv=fail; b=PioAByS+mYHQxo6iqThqrJ+A9NbxZ/0BJRd1ruUCP3ue6fe+//7OqjfFgXOkKM8J2F0kqxunZjfQtCzSNBegWQkOjzdOQniIOkwCrsHd2tmxR9HAwd6/v0QJNAUvC0y9EugJ4AVkI72RtNdp5zabRwfrKc1H5FfWK2AY/yB9zDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731953864; c=relaxed/simple;
	bh=/k9s+npVXX/KLB+rRefuixqagFzXF5hKWdQahJJGkIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNLOHrWn8QC+cCer8wdJKz8s6qPlmq8fFFozhzObYBQsvTwHCDYuspqLhHuC/eoeQurj2B4P3NdO2e9BDOgIPRZL7Ogc8xqcwqTy2kvlZnhL1NVb5kTwewsIxmE/bCCLPCvHqITDU7/LnVs17W7Ls7alVhzb5sypwV6YOsRA5Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XIVlTWxd; arc=fail smtp.client-ip=40.93.201.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejEGfq2MewT4jq3JNJiBitwAzxwHyqQHlBgse3723dx5Nu94JH3KDZk1YVUMq8zvCn8RvygTY/1VxVUnWeERLH4DjnU9pbKPdNKF0JUzKBDAwDHO4KU6RWbEhZZ5be0fPAMQEFzo22s/FnJngh33p1Njke/ALLYEC1M0MEuEjnWpCjKbouzKi/GGDOv57v0nj1xLek5LeSglKsUbzK/q9ujWmGC/lcziLRhofzk5ewgbDpc4OkKeEZVea5ObkrJ8rP9uAFxpBrGx6JPKJ4QXsNeTVpr7eukwWpIDo8ar6c5coaOwDl4qKYPko3TOPO0Re+7+1WQFSz3uOSHqjsBgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnSYudl8LgJnfeoPjXZCrrq6bAGwcihoW/+IO3jYjJw=;
 b=JP//7XOWhnqHzND2FTt2Cg7gjt7UMpKj8aCndkcLDcW3IXQgxekmAYnmec52wlHnWTBN5W8E/JWpwOTABf3Hd2Bq9XFqynTvRHCQxdCvHRLX3nWISGwS/JHHrblFnRMroMuP+ylq3DPgT5z7rbEfJZdVsaxNw2/n99cz0kpu9erJAoK7gl+V8LqgdkQKImHW6iCu7guzobyetbmKoROeetRKAxVaZvl28hsR2IEnoVVCTbLb+9BAvLmyqU6MfmDfvDOKHqLw7FBv9VqxfA6XSRg24OC5U4+6VYYbaCtAHJE/OM6w+idnsgYkfpl+XoWAb6fCy6olhgyHYR8bp57tiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnSYudl8LgJnfeoPjXZCrrq6bAGwcihoW/+IO3jYjJw=;
 b=XIVlTWxdRQux3DoGWx5wQWTLBvkZaCHPN6l8+1w9Oioz8ZWVfA4c7i0Vw98AVU1vv97sH/CTXzdGHKeZiYdsaKAc3NcUx63xi6ypr03GNXz/Hv618lx3yawAGsQnqihT5ArToTWGBx9HHxyctGEJYHx4kZUXo0J9PhTzVYY+7pc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Mon, 18 Nov 2024 18:17:40 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8182.013; Mon, 18 Nov 2024
 18:17:40 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: cl@gentwo.org,
	scott@os.amperecomputing.com,
	yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: cpufeature: detect FEAT_BBM level 2
Date: Mon, 18 Nov 2024 10:16:08 -0800
Message-ID: <20241118181711.962576-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20241118181711.962576-1-yang@os.amperecomputing.com>
References: <20241118181711.962576-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:610:b2::13) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 25208b6d-855a-4742-c88a-08dd07fd49b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x0MJm+zd3HCcLtuEQ8BCjbULl1BCHKhNYIYgoDvCy08jP7vx90YBrVZlfIlB?=
 =?us-ascii?Q?w9+a0fD7bpYnC7oC+lRDvUs0khRgowyNT0WcgGY5x02mnrta+ia/rEY4InpF?=
 =?us-ascii?Q?XyaiaSIHVt4hLsLiPQtSMQNMyGgynLIrbJzzyjqni2TmTEv/90yfELvkVIr/?=
 =?us-ascii?Q?rfBcxLnmcW/Kkx7cR7xnsS/BxRKZoQ699xigoM0x4H/kPYXv67EXQWAF3Ngz?=
 =?us-ascii?Q?sxanJVJhhXwvKpteG7AEnkmeqZo7TCg4AvsVBH9/m73v2rZmjVOCkKHkpC7a?=
 =?us-ascii?Q?Egh7r5DrsfGZtOJdETIZH9zkBpn+huXVKOD5EH2pEnOOVFGBcsZgxIeDhVIS?=
 =?us-ascii?Q?vyBcnEo95g8ZKN4vrEG8+L8cKDeYhM5KRMOWz81WOUVH6ko+uo2AonfCq7yS?=
 =?us-ascii?Q?P+bGtf1y50sRYBuREghr5w4ra2zHafQbaXPeU34B7ioNV++AoIK3/pRSXII9?=
 =?us-ascii?Q?M640FJpoM/ndBV8SZE1uERWVlS4S2DDTUrewcqqRea9F/NLdrOzqXWx9JZl2?=
 =?us-ascii?Q?TYbqTTNIn2ZkUxSRAEVxOAjyUSE+TRZAN/RJ+hlEhCvoPnwvs0jMT+nvJTi1?=
 =?us-ascii?Q?xuBV2e6KGzTimxj8/sjdzRmO+EmJUk0ZqfG+bdC/GN1a1tuka+v11kCQ2MAD?=
 =?us-ascii?Q?e7w2mKZXqB9EittyCa8j6dg0+cmUXshPPaDCXssUPUZe1HA1iwkRUUyaVj8H?=
 =?us-ascii?Q?0VrQOeralj4RWU4GYIUETHOd6n1GLfF4DvDaftL4T1ABG2mz6AnhyGV20EGu?=
 =?us-ascii?Q?WZLvMdyMIDO70WO0GPfiYS7Lg0WtYrDTVGI6BlNnTh45LpotwGLSIq/BLNnB?=
 =?us-ascii?Q?szygsYJOa7qzieDt/Ivuzh6CcmIsxHi1mLc2zb7mO4HSTEWv6pzSXkKgLv/d?=
 =?us-ascii?Q?dNLNvPoHi3x2Vrox8M3ulDgIgdzGyi9DGJXkfK066Sn2JFE7cgTox8r9yZQl?=
 =?us-ascii?Q?d27hxNuatKqmE8BJgzJKO84ZyZ8rn5x+3vCjM5SeFqfNSm/n+y0wnMnEvh/D?=
 =?us-ascii?Q?HJnsNG3LEri/uSERBJhbnYS4hZ9w80Go8+vQTjoYNbfQCNJMyLUGPQFMayT+?=
 =?us-ascii?Q?W7pqvY/P5NYb75MTKho3qbjEym3bN7kTV1OgVg2UflJhdqqA5I3YQt2cqyIS?=
 =?us-ascii?Q?EuYaUyLVNIGjaweXEC0NjSzX9FMBtPt2xwyqJHGyGRioBUA18hW5OjG5OlqN?=
 =?us-ascii?Q?mp8WtFSW3WM+x990fUJ6hGZNcg5KrHq/z0vKcZ/qc2bQIf97pLPsz+JLyQE8?=
 =?us-ascii?Q?/AGnF5ejieYPcR9lR0er7MieIJFfB4HzOcuOoAKhWFe01EJCbXoPBqbwKGUg?=
 =?us-ascii?Q?OJOUjQg54BaHB/MuyFtmmtkHtnfJYpl2RGB43ON1U15NUcauo74L/8uQdmV6?=
 =?us-ascii?Q?MBb19jo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HA+NuMCEDTERAKgZcZ0rsi33zbb1DxY6NU4bqPRQST4rksJ9PeEGGBVHk4+1?=
 =?us-ascii?Q?TC8J22+ngWq7GmfDgne9WOJH2mN6WImg4aWwesRVJjlNr/E51IE2CeW9VNzj?=
 =?us-ascii?Q?NbBEHUZv6uo327D0a02WY/NugznQa1TLssWfu/hHk1S1aH7ZrSjZyJ1NVHzz?=
 =?us-ascii?Q?GIqklGEFy04o+9e1qUHUWKrhCqdfaXKHUik6qcS80Q7JOroKTZZLMubtUZPz?=
 =?us-ascii?Q?02iUeyriyVjrOJi6iZLlGyEbUW0n8ESoQ45CjF+4SJIMzpSPn45HqLcHzK44?=
 =?us-ascii?Q?Y9j2sJd/MTU7ThwK8O46XbuH5Fh+t0x9eRSYHo05VnByb0fEwoF5jVMKqOot?=
 =?us-ascii?Q?A/CEc97g1cLsIt3qeii9X2EnHm6DfvcFbsykRTzp5ZuFMdNdKV9RFQAOk1yV?=
 =?us-ascii?Q?Ldh//vvyzyvPBksFDJsFAWcHfgs23YVaTBAWNxvZ1Docw/9BAhzpoLYH9VIK?=
 =?us-ascii?Q?QKV6InDm7rxfKzn0LSfzix0jBr3derMiSW0jkpeFHAruUzrdNh3/9dcT2mno?=
 =?us-ascii?Q?eCs6HFkpg4kbGKo+LdVFPTZpp1HJVXoMEqfJ1bfp13FNqoBuA/HcFvf7RmyD?=
 =?us-ascii?Q?LvZI09PmE3+Vb8pYv8OjytfJtbcDzklGcKA2HjsfSuYgFhXcZRyTn/+9tSOc?=
 =?us-ascii?Q?AKmbrJAU1owNZeA2Iqj26Na3Iwu9gFY5V7P5HOpNOQ3MX4gKf4+BC+kP4EQh?=
 =?us-ascii?Q?QkHfioXE1bd2RtHdQuLmOGwC1kejtHqsSQqtF7yjcHSVnuJiU5IzVRVZvI9G?=
 =?us-ascii?Q?HbhfXYpXVFY8UDgHT2w40Jw24nau4FiA1fQEKxpGKU4Dnc0z7HsChvu8zDlN?=
 =?us-ascii?Q?LUEFhxzvUvgQt5B7wWQjLdgpJLv08iHr6Bm9DXHamlKhHsNgd0sVoD6vU98E?=
 =?us-ascii?Q?wb1AJhanQyEZnsbO0zBnhykmDKmy2M1RZqAjNYSIs+W/S+5K9Le6R01FU/sp?=
 =?us-ascii?Q?ql1scaZJY2zyuypP0k7Qi5H8nSqsAlNsMaxwCEp6yb/+dODioEeNCjUkWmyu?=
 =?us-ascii?Q?+LChRXrqkmod5EoGWrJc7GkFj1l9xNa7/s3tLtEOnKoqy9ODd4iDcyyQU9s3?=
 =?us-ascii?Q?q61CkY0PXT2ocG4zHnVIGISHcZADmGX95Dry+qLIDdu+0M0mkgPg4sbjQyTT?=
 =?us-ascii?Q?zg+iE7FfC5jKIrOmX46jY29jQCUTWjpfJFbZVuq2f1qa9Q5crHCCFMo85flC?=
 =?us-ascii?Q?znUoc53eLswb4mSIe6CSPbpojNlLeR8Q8aeiPOrzzD4DI9yF11juc2+3ws0H?=
 =?us-ascii?Q?ZHR8Vy/EqhstSyajYG9yoFaWecoXX+f/mrrfJD2WPIRNz/Vn24jPjCywGNgu?=
 =?us-ascii?Q?TQH3UFv6XzB+UyWO6BgGmKVLq0kzpvGNqrcPXZzaGoKo4QKiRFnpW5ct1Ujx?=
 =?us-ascii?Q?Pkr2zP3DKKWP7V2N+OSUY59WjqjHZofJ0O9kG3YufAdRb7jV2Z9J5pgsKqrz?=
 =?us-ascii?Q?iTAJd1bgrpVmIWPDAvS/U7AA3+mlUnXW3cnkkMgX21pD9JNfC+RgxezP8Lq8?=
 =?us-ascii?Q?MW/WKdxysIJb2xY10OyXLJ1ogNJHkjzO7ZuuxrjqQ9ro1BU3kb9QFezcgkVy?=
 =?us-ascii?Q?40cvmLQCauuMzQcYmHTla+WNQaRryJA+lXdIKTuyjjbnjmUZQKGizsM9rEPy?=
 =?us-ascii?Q?OHaGd9X1eD4WYqVs8spqhJg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25208b6d-855a-4742-c88a-08dd07fd49b2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 18:17:40.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zQL03NfoA4XCaxHG5FB8ePWSM/2nH1dPxIGm3onmF+CncmVYeK57TFOdmLfHhiGUPvzc4KJKNCUxDlAuUbLu791WhWVmGTugkT5EpU3V+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

FEAT_BBM level 2 is useful to split large page table without breaking
the page table entry.  The following patch will use to improve
performance.  Detect it in cpufeature and use BOOT_CPU feature for now,
if the late CPU cores have conflict, kernel will not bring them up.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/cpufeature.h | 15 +++++++++++++++
 arch/arm64/kernel/cpufeature.c      | 11 +++++++++++
 arch/arm64/tools/cpucaps            |  1 +
 3 files changed, 27 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 3d261cc123c1..c7ca5f9f88bb 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -838,6 +838,21 @@ static inline bool system_supports_poe(void)
 		alternative_has_cap_unlikely(ARM64_HAS_S1POE);
 }
 
+static inline bool system_supports_bbmlv2(void)
+{
+	return cpus_have_final_boot_cap(ARM64_HAS_BBMLV2);
+}
+
+static inline bool bbmlv2_available(void)
+{
+	u64 mmfr2;
+	u32 bbm;
+
+	mmfr2 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
+	bbm = cpuid_feature_extract_unsigned_field(mmfr2, ID_AA64MMFR2_EL1_BBM_SHIFT);
+	return bbm == ID_AA64MMFR2_EL1_BBM_2;
+}
+
 int do_emulate_mrs(struct pt_regs *regs, u32 sys_reg, u32 rt);
 bool try_emulate_mrs(struct pt_regs *regs, u32 isn);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 718728a85430..cb916747cd31 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1866,6 +1866,11 @@ static bool has_lpa2(const struct arm64_cpu_capabilities *entry, int scope)
 }
 #endif
 
+static bool has_bbmlv2(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	return bbmlv2_available();
+}
+
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
 #define KPTI_NG_TEMP_VA		(-(1UL << PMD_SHIFT))
 
@@ -2890,6 +2895,12 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		ARM64_CPUID_FIELDS(ID_AA64MMFR3_EL1, S1POE, IMP)
 	},
 #endif
+	{
+		.desc = "BBM Level 2",
+		.capability = ARM64_HAS_BBMLV2,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = has_bbmlv2,
+	},
 	{},
 };
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index eedb5acc21ed..175b7eb42b0b 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -14,6 +14,7 @@ HAS_ADDRESS_AUTH_ARCH_QARMA5
 HAS_ADDRESS_AUTH_IMP_DEF
 HAS_AMU_EXTN
 HAS_ARMv8_4_TTL
+HAS_BBMLV2
 HAS_CACHE_DIC
 HAS_CACHE_IDC
 HAS_CNP
-- 
2.41.0


