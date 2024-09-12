Return-Path: <linux-kernel+bounces-327148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4379E97713A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959F6B25629
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019831C68BD;
	Thu, 12 Sep 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnI2acEe"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B71C3F39
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168172; cv=fail; b=NbYpDA1Rafajb5RuSleARrzbAACxahbuAtFctOpE7CT1yVDpmUW4uwVZnmeftg9SuLZstvoyg/ykSh9273DfinfHP0yroxNuvK12x2yjRyYukyVO8uHe8ZZlAuAiKnVhnUFzkmLhVsWQdJyqK2KxMAnWpBWpzWh5U5vA1Q4QVcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168172; c=relaxed/simple;
	bh=j6LmaWoXUlRhzads2eXo5hCylwdpiJiH0Ddd+YpNhD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrY96CUPfCzqz3oVNyXLhJympF02CYeWzdPO2wVVt97ovVXJmUOpLG9qAwsr4fTiZLxUbBd/d4gsGm8WfsVOKGXWoR0ZHj9KQpKQRueZLV7uh/2bhXke7i7yYASrOOtyQPKFznwBW0xca0P5yTP4sHkDBBDVXeEHUKMYUSFzcj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnI2acEe; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSN47Bf/FjFXppRgRZwR0P+6NPf4svxwL3/rTiq6DLx+uRHRSAipgjq3JT39SDRcxOwhlGPeuFdTUQeR7SAXoa9BSc06K/REfrycgO6F2oGzRM712GII/7etRuUAFV4FbmQlQnIIGY1qz99vZMfq23HU9uXbfNxcbUhIuojAbBlKP40aZNwig8qN6qWsGr2P8HeA763cNcgFEQazqJhd3hKp25FuVHbKBpm9G9+JoAj+JsLVhfhE4XABMqXuqNjakTmsUmZB7/gB8lvZj77CsKq/e/eOb8hqOLvHArr1RQkD23AgPsf//0q1N1Ca1aR4RgvRAe4S0VV7AE9dZm9DYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3J/Hy2K/8K1m3QhR0KtcDNU8bMjZgt93qddY9s/8ewQ=;
 b=q8Ig7KK13Z+DiLWJcpDxBLKNZfjNpJPR6p23TJA7BhhBJTzATqP42MEZx9C2NzKWgw8hu2DS7szmuAc4up3OfpqMUlbu+WFBCz/PwOkJ9v45CHJmyzq6zzUNmVbPX3e1FDn4RGAoHQ8xXoG+M6sIeUwQ9tIOQqGIyB3AruN3OOpjUOr4hfIdyTNgoRWB0oswqY03R3p+PWjEr1yf9QHfdBr3RnSzc0RJHp0nTMPIttoAXxbt310ztuai8huGAnnlL9fRFW68HUrzE7V/Dv1E/OQoo6ui3F8hQ+0MKbeesougFIGJyseWdqjahT6XjqX9jczBIucedlyfOv/49nPVhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3J/Hy2K/8K1m3QhR0KtcDNU8bMjZgt93qddY9s/8ewQ=;
 b=EnI2acEe0ZJPy2H686zkZW3fMF29HX72fc4x2KOINCSEn8jPKjPeUX/VoF26aSEHk8JL8/n6gR7xxeYxA8DBUdUxRDSpqlT/PufRS4pOLl/l9fQd1TueIugySeDbLSXN+pjsvI8yWtdU6nP56WBZQ7I2cf94ltVcPQfkmk/Xqv8=
Received: from MW4P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::31)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.27; Thu, 12 Sep
 2024 19:09:24 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::d5) by MW4P222CA0026.outlook.office365.com
 (2603:10b6:303:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 19:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 19:09:24 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 14:09:21 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for spectre_v1
Date: Thu, 12 Sep 2024 14:08:50 -0500
Message-ID: <20240912190857.235849-28-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912190857.235849-1-david.kaplan@amd.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b0e1d8-c5e0-42b4-ba13-08dcd35e6a77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HWfWL56ISWJauGan4jMaTqRgwwDGBEcihu5hGXRXLoLkVx1/AqUtBFD5dJXD?=
 =?us-ascii?Q?XWS9wd1RgCevGtBw/C5uAlIuVfD2Ul9JoKW7CX2tKOm7lnD9g0ShagB/jNwR?=
 =?us-ascii?Q?QZFn/PklguuVRaXImEn2VQIfxATDvz3ArsaIaCYjgPRTAoNdmhVFfaoVk2+B?=
 =?us-ascii?Q?BfIJ6YIM0wsSY40Jtw6IEtgs/gvKDQI0/OYxqGv76H4d8smPBpu51kRMeFvX?=
 =?us-ascii?Q?KQvcf90DiRhpXEFFiMyM1BdPKtKNJQb71g1sniM7CkHK6ZJ4YRRFXsJcWUlR?=
 =?us-ascii?Q?WrTRttHwD1BmtAvfmg2Jcnq6X34cKpTUgiwue123KyuCaqBvDEp1fq4B0Ve8?=
 =?us-ascii?Q?zr2h7XTygynKT8hIWsnfVyyy/9JEVDim1ckC/cd2FKGJzRvjESHzYogHXDUA?=
 =?us-ascii?Q?Jt9tWmxAP+IB/H5OCnIkDfNDqfAM8dHtQVpX8F4QJ0DfGvkX6zh3FtN/mnif?=
 =?us-ascii?Q?we16Aki7D7QVF9yaAg53IjkoTYd+y38/JQ5XxRNjlDgbePcWqqr5hh4fOu9u?=
 =?us-ascii?Q?4D9fcnrVvfc4euP8agcFpy9KrpWbQgfVAGB2BeBpYgch3aDZ9xqiH6AAN7CM?=
 =?us-ascii?Q?63Xib6NZWwDGNLp+RS9fJ+KFuf12zU40ePKsiRFkM9Bj1vi/d7k5hB597ABY?=
 =?us-ascii?Q?eX9op3W+PQF94K0lnyI/XgajwehY+Z+1E4w4Rf8JrIG6UhI/o1aVxU2kwVbc?=
 =?us-ascii?Q?acqDYYAhmgWl6JwcYUiC0aAOa3Kpeiv3DDRHfSwW9SkFr+hHZe03fFm34439?=
 =?us-ascii?Q?GoGThWCq/6SCxnS6s1W2UWIZ5gnDJ5fMPvjHmCJIpke20U0gTGYpry6UUW04?=
 =?us-ascii?Q?qSfgPs/6iPD+k9RO5c0cCwCkSjyv8zkw8jugBwxgOtpvP9fcMbGqJaanmmiR?=
 =?us-ascii?Q?UwXTKSY1kDIVg/YpPS3q/f5xFPsR6C2yZ/0v5K9/k3YnBtROhWdIjXqBWfA8?=
 =?us-ascii?Q?ZitoabIrfASJLSFuEpBhBAeuBRBE/IAiKSJufvLWQ3yabjhkmE5CXdB6x03w?=
 =?us-ascii?Q?52P9Y2FGcHp4BbaRcuq4D3SA84zhmrMso+FPW5wlZcqTCyFuHQuEpmYgaGFK?=
 =?us-ascii?Q?OXm0OM6fQjkZRkmhwrB5lu7z+wH2Jw2DhS3tZsNcG8rwLReM6ve7e11ueGPu?=
 =?us-ascii?Q?SjHr0pFQkqCzrk7KR5lh+F1CAWBs/nobdBa/MLlwOrHCxvJKw6FsL2ZZWDRf?=
 =?us-ascii?Q?frlw88kBKe8KGtNWgPNKT6Fg7JPbHMEu9G/HhBWJwk4TZyDApE/k3ZdJ3IdC?=
 =?us-ascii?Q?4Szq7WkWOoQGrGIGRfRLkH6XgxSNCQSIZU29yrjcS8VghAkHhSyr7LZmjZAo?=
 =?us-ascii?Q?qAJ/60aTT03yjfHHmHJqqL0uDZgrnDC7AAM7UGu149UG8vm0Qf6ugAfsQNNd?=
 =?us-ascii?Q?2wArHUMgrMy6GN94Ac5M/FxANDOtTJSa++U29DsEus33jvJOMqUylgvoT9EQ?=
 =?us-ascii?Q?8zy77GLFXT31BNviD+rZYHcgCHJ8sFPJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:09:24.4666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b0e1d8-c5e0-42b4-ba13-08dcd35e6a77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138

Use attack vector controls to determine if spectre_v1 mitigation is
required.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/cpu/bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 5fbf5a274c9f..d7e154031c93 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1114,6 +1114,9 @@ static void __init spectre_v1_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_SPECTRE_V1) || cpu_mitigations_off())
 		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
+
+	if (!should_mitigate_vuln(SPECTRE_V1))
+		spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
 }
 
 static void __init spectre_v1_apply_mitigation(void)
-- 
2.34.1


