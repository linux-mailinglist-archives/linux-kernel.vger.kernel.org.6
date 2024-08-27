Return-Path: <linux-kernel+bounces-302987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3579605CB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4D4B23BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC6119FA77;
	Tue, 27 Aug 2024 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dzGUH1Wu"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0F719F499;
	Tue, 27 Aug 2024 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751457; cv=fail; b=fCyHLZAU22VAvNdEoZssuB1ih05uV34bRZKgAturWlOCRhMdlpQSaxpRwGBsFgEdNH5NAroKaovkjlFqcHiP8HLHPrUYVwUnR76AXTPUer9NExajSUc5OidhCZmYkuFKRxuzMG/gy0ZxTEd0BV50YsVxeiX70vDF8A5N+hnJGGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751457; c=relaxed/simple;
	bh=4ZBpuDPMhi1NdNtbM04s1OFlEZS4RjWPGLVrKIG4d9k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+KjE92uvKgQwVLdVhWDFV1eCdQtXqo+lwoARGyc1DFyJSURb/eQZVT0dMU2b6N4sN6iFhjLmNS580OaQPndu6btgolnnDIOB6RdNtohp6KiFqYlk9x5aqsha5S9klGpJKvfNvWuqdYP2hdmuNgrhQSshev8D1mCM6zo2k3B8fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dzGUH1Wu; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM1O7DIAf2US3VyQuGfdpdRFf9hbUJPhYDm54mMS7PdeetKXelO24a7XDNypjvCWupoMP0aYfaxozP8B2/eacoLNybBo+DGya3gpbRn7+rDTIRFrbDrKh5hrBPeKjETUqMMvqFhR6xVg29vWpo/s50ha1uRu1r1SslW6k1GCTuXoDR/IbfAI3S6oSmUL9LwywxH6s2p5GNXkZy3qsjN2UwFriwSMePfigMv2XVVp3Jqy7uC2IUM1OMU1bTmlmL2YG0y1+PSo93p0HJWwtpwx6X5q91rIl2M590X8CXq49zDJ8wfnQ6lIKdUui/UelQfd9STJx3wsMnFFzi+cSI5Mzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vf+mEQFECxmiTxpFNGfZy5gdIT7SPH6AUWoKmSIzgfE=;
 b=q27TRuo3f+iFthiuCYQOwofaSsJlAMQ53VsgQ40qIhL26ddvHgAFJmYI0WNJ/0lyjKMsEzK9kLc7QKHHgAEyji67g+dsmxt+D7SGfGLyxX3b1WsZu01HbQofT80p6AvgoIcaGzvzv1MafTSOgyIkEl4ffLJEy1Oy9rNKbpmq0f3y8Ca3+wQ65dHA2co7tZMoxoxooytkghdPbNok+StLRg4l4qVN6HKfugWzJZv361FXelndZuaM/PNsVGvuaQd766BaHuS1Po6001DWEXdiXQlpISkEFeZvP4dinOh4iNkeA18zOAwU+9bHfqD6f0TfpzGMt67lUKR15/SR2yut4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf+mEQFECxmiTxpFNGfZy5gdIT7SPH6AUWoKmSIzgfE=;
 b=dzGUH1WuXxYC02t+ef4JR8OxvXaR0l4z3Za04NHDsvSLFdnlE/qKDlZ4AgJm3+PLZuTykqwMzuDSPOzFDHwSheYndBIN9kGCGa13jG3c16HRB+AixgLQBm5DZafIgN8//+N4ANraOkBPIN2qCPJ4ptolCfuOiAnd++3o10DO068=
Received: from MN2PR01CA0059.prod.exchangelabs.com (2603:10b6:208:23f::28) by
 SN7PR12MB7204.namprd12.prod.outlook.com (2603:10b6:806:2ab::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Tue, 27 Aug 2024 09:37:30 +0000
Received: from BL02EPF00021F6B.namprd02.prod.outlook.com
 (2603:10b6:208:23f:cafe::49) by MN2PR01CA0059.outlook.office365.com
 (2603:10b6:208:23f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 09:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6B.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 09:37:30 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 04:37:25 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <hdegoede@redhat.com>, <ilpo.jarvinen@linux.intel.com>,
	<Mario.Limonciello@amd.com>, <Borislav.Petkov@amd.com>,
	<kprateek.nayak@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<bharathprabhu.perdoor@amd.com>, <poonam.aggrwal@amd.com>, <Li.Meng@amd.com>,
	<platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Xiaojian.Du@amd.com>
Subject: [PATCH 04/11] x86/msr-index: define AMD heterogeneous CPU related MSR
Date: Tue, 27 Aug 2024 17:36:52 +0800
Message-ID: <51965506b0b18dac7a64617838602bddac634cfd.1724748733.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724748733.git.perry.yuan@amd.com>
References: <cover.1724748733.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6B:EE_|SN7PR12MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e3309fd-152a-40b8-bb39-08dcc67bdf10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eo5lfZDwwjGtiDJz/TPlSMIda9qlhBotANjBS1zyUT0bKckLIEZwiIwvfPA2?=
 =?us-ascii?Q?FAaB30CVLBle/5mqo+udc4o16NQtujeL8HKDLvmk8P9CNwJPesXQ8cLcMAuL?=
 =?us-ascii?Q?h9lLK9X5tC1P9Y/hpXd1ubGTFhOQQg4KhQlYCxBkxoDptxLfLXZLOLGQc7PJ?=
 =?us-ascii?Q?DMLiMUNO9/cg1iRaJi6Yzc+xhiWiWrjnPjfzgIfAefJKdDfyQZ1YhKMJqe6f?=
 =?us-ascii?Q?sgQs9FymDNN4lX5P1su8y9UdgbaQ5AbsdPnKCligILTyTv1YjP1adfsjGK+W?=
 =?us-ascii?Q?vC38JSs1PhGZ+wl62ZDGuYNPpRHTy/vQffxf1N+VFxW3D9Ogn64MFvCk5JSr?=
 =?us-ascii?Q?nr+ZUPFK0orxuO4GHdyE5W6Xk0qH/5MZHjVbnREK4ncquusvYDe7tgPXex9y?=
 =?us-ascii?Q?GLQGa8J+84/2rS5f+YsphAdtOECyAjV++Nq5WVLI+WX7RyHFPMBnrr9VQ1R5?=
 =?us-ascii?Q?pzSQ81IbgjIOyin7MLRvuCOR8fiyYM60vwCozfN9AsKgeCezez0XbbiLCGdS?=
 =?us-ascii?Q?T94cYfefbRXYkJwC9UeyIzlm068Eu8zFhyV7STlLvD4I3hZqrv9pXZ0bcQ5/?=
 =?us-ascii?Q?ngEG58ePeQh84MV0EQ9JIYTD2OJjcdQ/c095p6cM0yHt0BkH8z8Zfh5Cgpgl?=
 =?us-ascii?Q?19ELkpXyBiYO2eiPwTagKfgOvpnmJ5ProVfnqLnUNItf+L4MBwo9qSj2vRcs?=
 =?us-ascii?Q?Wmr4NbdsrRJsqa552lN5sEffM44FO8jzy0n18A6qKL7eNTpSqAMfrrlyAQ48?=
 =?us-ascii?Q?cO6ni72isVoZBFRmX2WEbreC6gXoj4VUmfuc+hz9QDzB4NboUMgYqaNI2WN3?=
 =?us-ascii?Q?8+DDBhNxCT8Tw7qUOQq/NtOPa/XJF5r9psmztvGNK7v2z9zw1lqIFvz2Gbv9?=
 =?us-ascii?Q?AK6DHmghEd1lzvv1K4TUVCGeUaMYnX37fOzIYUvqymaMynvV9Vn+Kb0fz6H/?=
 =?us-ascii?Q?16HMckfXCDszW0D07WTqEyWtduefmOv43Q4e50w+vz4g+ln8Q6o0bxxOA8sB?=
 =?us-ascii?Q?k7Tn9N8+z6bDB90oarul2thhcgxfWq0NVhb0tY5fjO1PQ5qDSfBHhFay+wnA?=
 =?us-ascii?Q?KcTjbLmOMEEakQiU4mcvUKH80CWA4O6P32hv57CZrmCnyMxye17j18M1cU0x?=
 =?us-ascii?Q?AD46VNUYjxLLL6KlPn7jEbb2k65cVVPYIk4vUD+ZjI990KHXLMc0VKFxvnlW?=
 =?us-ascii?Q?4uMV6lbNvnApLI78yPI7rQ3Fte4tI9G9vZ3oPMNUxQ1f54HmerpT+aYpag+9?=
 =?us-ascii?Q?oEoqtmNFcCjw4Ea1eK3suiZijgjc2F23McWBudkPd2z8sXH+ji4F6q+R0/Ke?=
 =?us-ascii?Q?zF4qzrQVfPXm2x6p5oG6I1VndtmXqqmf+MbxexLrbj9FqM3qBQVfR2GqGL2e?=
 =?us-ascii?Q?eQsCBdm3l6jnBdBQddczewxZ9AS5/a/wKOI5dk2Ej6ZAlMxC7ztapCsYKBiy?=
 =?us-ascii?Q?2+hWJ88lmc4O7EzoM/23C0KMIixPx8N9?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:37:30.4523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e3309fd-152a-40b8-bb39-08dcc67bdf10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7204

Introduces new MSR registers for AMD hardware feedback support.
These registers enable the system to provide workload classification
and configuration capabilities.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 384739d592af..141509ff9cf0 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -682,6 +682,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define AMD_WORKLOAD_CLASS_CONFIG      0xc0000500
+#define AMD_WORKLOAD_CLASS_ID          0xc0000501
+#define AMD_WORKLOAD_HRST              0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
-- 
2.34.1


