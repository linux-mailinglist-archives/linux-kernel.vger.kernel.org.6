Return-Path: <linux-kernel+bounces-572046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F6A6C5CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2411B62F16
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC505233D97;
	Fri, 21 Mar 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OFHpTuV+"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C16232376
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595350; cv=fail; b=kDNyANE7LT45Xu4cu+2rNFyukf2fgi4vpI5wKh/fj8ouukXfEjgSEWglu2eb72fUxCg9XAHP403PYBPhb0sB7fQpyes7dNNNPboC3TXURZkk1IwXcQ20atsHxUcZp1k9dOrSt0PZCUvYYKkk6iIeZOzPlxvz8hWCknWZrl9/ymA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595350; c=relaxed/simple;
	bh=1Ch/ZoErVs6fOakBfeUYSAYw2IrBb2QlsQ6pKQLGZSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DFB97Seh1QPHd5jvowFutCcvYZhgYEBhEAB2KJOCgBg9oHaBxIn9WBpB4Ib2l7U/IPK16gdlvxlp7utdbS/welbDAT78yYzemJj/5WVu8yxZKpGDHGx9A07N4FepJG0MeRDC88iDCuxsJfvMvo4RSlr4tWAfrg8ZWqVDdAkY64I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OFHpTuV+; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHsOZHCuyuvUjbAV/Yu4ZiVzJwi5bFEMf0QWDJMqcglQElfXudWdZcBlVFAQ/XFB3ym6d091rjdgpbyhZ3w8fmv9vXst6+xOyXLp0kz25vyoue28CnjOV5dPy4LNNHQkqNjLQHhEzQ0WvKM4EOE8v5PtP/9qkF2WdTJUrrpwJd9K/VaxF7F/BMTpRqyiLS3/CaDReAGIKp4P3Yg9awjkps6lU27P91zNEbxDIlhPRLmMNRGVr7GoozccWTT8spc8lZJszGniDf7EuP6K59HmR9VZX+WPPyHSxbw2OAIvsAyS/ZYIcu+lJqkmQSlq9s1G2O4XmKEcEtBfWDY3Odauyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XEnazbxqVE1UGjyTx6BVvDLYd5whNAOpc7TpFhaA2g=;
 b=q8uFnK+PZg4IOvQ9e4ZHmUyvqKJrd/AkguSeWVb1bkFSxsBpNxJsIVo1Dyrq+pH+58AOEy3LDkgNQtFq3wPXuPCB3xwS4DDFO4nfNgyoaF5kA8KOmW0LyQVGL9ZMQk7Q75bIIocChS9RVCi8aZx2cRWUxx4V+folsc2UuNCUNT4iMQ6sD30OknXM5CQmqrtlS+uy/2WQExFFWwsuCib2HK+O1uIrQUWzlo714mbbO1k8rAy30/W8kVpUx7iYg/ckeihfZB8/hkpJkYXpN14wvHTG+cwFvdh4jK7q9F+ktZZAhnELLPa5hrSCVQxeUDhaPc4RNIftm2VapmF7xThHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XEnazbxqVE1UGjyTx6BVvDLYd5whNAOpc7TpFhaA2g=;
 b=OFHpTuV+ZaHoWS9VlqzcP2CgLFVWCw0ZfsCwoFKhrWRDsdmR9EsRJlaNcRpW/XhGJW+5V38vw+zG3F8t/rz7iZEhjpDejAX9D41faTp17FKblN8Iz4Zz89qjt/qj1l0LkajuoMCsi5CUbsEdmKhz62aFODIiltM1QcaMx5QgbFviO01mSoJ9wRoWIvGj/IzcbL5H0aiJepin9V6FFF0P/SSDN27wjbLJV+T0abF9sSdwvvp/24WObnaYK2XXEyiBDXVGO7cg7iVyMWmPDtelqgcAnSkUY/Ed66Azf100s6QdSBSm5B8wJr75oR38dAH9Hy25D6DEZBnvlt9cHcfD0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 22:15:45 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 22:15:45 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] sched_ext: idle: Deprecate scx_bpf_select_cpu_dfl()
Date: Fri, 21 Mar 2025 23:10:52 +0100
Message-ID: <20250321221454.298202-7-arighi@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321221454.298202-1-arighi@nvidia.com>
References: <20250321221454.298202-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0140.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 5695fd5d-d6dc-476a-cb99-08dd68c5ed29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?daZOo4NklcnOAEe6L8FZzQt5w3Kl0Nz8OPwDo2fmNrc2YRcJQogng7CI6hST?=
 =?us-ascii?Q?LcNv7CUqs8Jz2EerpCVt3nBUVepL6OcQJ/tikHL+n+6fz8wTcMmzOUTHH43q?=
 =?us-ascii?Q?xLdHuqQd4QPpsr8g20PTrV4FliypNTjiczpg8yaztIUoUs78KYFwJjbfeYJq?=
 =?us-ascii?Q?G25kH6vfCvfg5H4W9x2xa+LMddWM8g3JZHYB/MZpMmttTfL3XRmvXQNvf2+v?=
 =?us-ascii?Q?QomGaYg2VNEXgYX6GACtxd6FrtZsQQnlLZ0upkPIaciHTXVjak0MKfsJ5HhW?=
 =?us-ascii?Q?eYEj7vwr8FVihFEjlW3yWxFhTG+H3DQaXfrBILWZ7LNtxNrIj2KgO6wKL4n6?=
 =?us-ascii?Q?SndwwZfmJeJGaZ5W02ryp0Emk4OYeFGidhOQU/xEY3KPJ7pgUv4ZsFSb2J/F?=
 =?us-ascii?Q?Xob6qCJDUi0W0is89Juqn/62CStiIPhFJRTZkxhNBIAjxRA7/IAC24rzjFoa?=
 =?us-ascii?Q?OeLNfSoJORzNrUkk0/d2Wxvx+/gnyI4p2GisHJUiOH9ZFnTgTou2z0N37E6K?=
 =?us-ascii?Q?eCzFQe8mNaVr3uZkRDCbwPyGjkuQhYNY0oI6lE/g/+xDKvl57fBwy/neZaDs?=
 =?us-ascii?Q?eFgG/Z7u62pMZEZj73b3HIYJRlj+HocMT1SIh5XtNlRWRAwfNgKHIYMPNzeW?=
 =?us-ascii?Q?kJYZki0ERKzUx5pHZ1V7vTKQ1c0CQqCaWbk+n+EEbgkGxIPTyx9y3FMFlKaC?=
 =?us-ascii?Q?tyWBehHiDHF0aWSnyCI6f9B5meRv+3XEQVrwJfxL8IbhcZSWKDygQUvApZnO?=
 =?us-ascii?Q?TbOh2otwpNEl6JnbBjdfy8YYPq8ME9t3GjIMp5V9wG9xhorw7FdohrnT3aba?=
 =?us-ascii?Q?cf9SiTxuPX7H/Fo1GEIRsS+RQukG4j3kvtkozs2TYLSMS59jvJwHZ437Cm25?=
 =?us-ascii?Q?65+I+dl5UNkCFdVW1Ujn/S46aZpOOnVxUBzQ4Ks+aFPk3E7TCY2XvlOymOA+?=
 =?us-ascii?Q?W1hHkamzwe3FZOJFzMFKCHtGf4rjJwjBX8UpTLjZBncsNDhalNAILH0V3s8V?=
 =?us-ascii?Q?I62SUHpq0wHD8DSYPf6CcczRGgtp7r+PYoVcPSMK/y09EW0pFqpmSnOeHvdO?=
 =?us-ascii?Q?zxkWPYuL/Aft+aBsdwYkHrnFTRdRBLTLyfAulMSKaeWmrPFN7ET7x8EIB+0p?=
 =?us-ascii?Q?lJVaITpUwkbCAlKiWf+xRVPNGlWkBWXoCtljFADauTIMtWnWofSUMoLfFgsS?=
 =?us-ascii?Q?rjcO7Bg3q0/MofM5nTcdnH/V1TgKlQ94oGxuquU3f+T39nwEoLnArt8DSdp5?=
 =?us-ascii?Q?mrpYOKYSignMeFGbwdoqOQJ75WjePBZl0pBY3CU80hswsA98bVETYE3XotoW?=
 =?us-ascii?Q?UWCIS/SKmtoE2Nfok5c06mudinlkcGiC9xKO8132z4lU06W8h1vI5SYnXwej?=
 =?us-ascii?Q?ty6J5G5X0hpO/mDx4V1ZGOiFEPjVbptmTDJ8rz/PmUb5x9FYyxeDdlHWss2l?=
 =?us-ascii?Q?zGQcKjbnDcM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFVhaKB8mZRSLNVZCzAe5fP60GkPY70PnQENNeM5N7AC0vLKIIReZhyXVce6?=
 =?us-ascii?Q?KQI4axIZzFgRbUtAn3ZObP1sBsPnCssVx5rHoVQvv7z1Ak5m66vBPkpF9NID?=
 =?us-ascii?Q?q9m8lUDxVBz/rDJJKerm4ipgrBGbwllv7cJ0kG7g/m6DblGHTk2Ce/9syziB?=
 =?us-ascii?Q?QmBpyyhPwT/il/ps5BK46mcUjRfVt71hlMayx5TCAXpcWtDLMDWFVvpH74Sk?=
 =?us-ascii?Q?iNrek5DDl2bUZDha+yg2OrlgydiB5OkVGZPbeWgeaTEkpdZrDPTxVsCvsfCv?=
 =?us-ascii?Q?BkPRDgUxcgIyVrCtLhAms/+XI3SlGzmFxV5v0DBt7AUhJZFcI/8VKtcN6sGu?=
 =?us-ascii?Q?NLL/Qsx6U75iNvp5gcWA9ZGXseQ/6FuGc+tn4fqQsZddBJ4VpO+WA3UY1BwE?=
 =?us-ascii?Q?PvKiS+oUnKVp1QS8V5PmpKDvRs5KGLfHTBzTA72puGu79OfcioJ0eN0h+PMs?=
 =?us-ascii?Q?tUKyLuZgm/YzxXnCxjHbVYANZHiKtxbNj6Q8lH4oZqNp4Yqq1CDS3uhJ59nd?=
 =?us-ascii?Q?Ks1XESnTLZIGeVItYdOuvHPtAWIfZFIpTHdPlH2pa47IRa95hd9SQZz3l0Wb?=
 =?us-ascii?Q?KnTmSVweE3SUsDoeKZOA8Dk9hYrkg0cBzfZIJjnz4pXu0P1cAY9J/meehNGK?=
 =?us-ascii?Q?F0jtrrfJaoBSltClqtwjEs+rAxJztpvl2LQhJSsqVZ3tgKTa3I9YG1AkQJbx?=
 =?us-ascii?Q?G9ra7HJHOPSEty1RqpsUnPdRbslwc2oG4hCiqHal7uBfeD87qsHfMHYypgsk?=
 =?us-ascii?Q?+xlZAFrTpTbVeHHNgMcHANhRC78zOeQOZkYxrZgRM9nSvzlX6t67FsYAO28N?=
 =?us-ascii?Q?9V3Si0+tHuOupFCujArgOONYSZpyNYcLoKdqe1iKR2OC9u5mmMp7Zq/+j6nx?=
 =?us-ascii?Q?jNJxmuasYho3EnoALS/9zwFhDwTdyxGu4T+I1Tkt197wTSklpNWKqa91/OS3?=
 =?us-ascii?Q?Bh4Hc6WJETWQhAt4XtwJF9WxcMELsw20lfwb+nuSbOGtIwV7O7DXbpA/AO+D?=
 =?us-ascii?Q?Y78RUWmrFpFSzK87qcQ2lzwlkDLsDubdaecvBqo+zFuWgkGsZVX3Cjk+hQAh?=
 =?us-ascii?Q?8hNMiyXRvSnNJxfqvUR3JTnNiXUc94OYuKqr2pMN01hyzG3jpCcK39VWaVg1?=
 =?us-ascii?Q?bAqTW20IkshoJ9ivCgf84h0mGFbwNTR4uDETL41+ZAE7WqRBtq7GknfTxTb+?=
 =?us-ascii?Q?uR+2vugDYZVHdIpXNc20KxJrzUkfoqOQRhE6agx9eT4KNcE4ukZbfVd2vrOZ?=
 =?us-ascii?Q?pMJn9dM7YyD89eymgCRQ4cXUl/PeURyVK44kpP1nSY6LVQtS5gCBBrPUyzYA?=
 =?us-ascii?Q?TfvVZDb8kCEg8eniC9GdluDZfKycq9f8x98/34vt1keR2wdZCn/r8Axdic6N?=
 =?us-ascii?Q?KioIt0SD98d+FvFAb82SIFD0Uxkbo9NVzkRXEl3kvA0Ft8qjIg0c861BakTd?=
 =?us-ascii?Q?dM4yrj2z8C02SbgDDNgCFXKLSuR6BTw/11hj6m4HF+2l4T48mgI6miSyRYxb?=
 =?us-ascii?Q?zg3TOv5qLA4HZnL7LTajk8yktHYF5Ex9ylQ7vsjDR22kOfOo9aCxXXuUYoAY?=
 =?us-ascii?Q?aVN/hwfIpwv1gBzfxsqd+NUerYkvd/IlsOgjzVyT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5695fd5d-d6dc-476a-cb99-08dd68c5ed29
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 22:15:45.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RgSZO7mo5q8eCN8dTaII1KHEfWQvYeOkjTpv1g+FRpAB3UvKYjYfcpKkEN96xNEeLbD3zmyPtEVmyLhct/WQGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

With the introduction of scx_bpf_select_cpu_and(), we can deprecate
scx_bpf_select_cpu_dfl(), as it offers only a subset of features and
it's also more consistent with other idle-related APIs (returning a
negative value when no idle CPU is found).

Therefore, mark scx_bpf_select_cpu_dfl() as deprecated (printing a
warning when it's used), update all the scheduler examples and
kselftests to adopt the new API, and ensure backward (source and binary)
compatibility by providing the necessary macros and hooks.

Support for scx_bpf_select_cpu_dfl() can be maintained until v6.17.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst         | 11 +++---
 kernel/sched/ext.c                            |  3 +-
 kernel/sched/ext_idle.c                       | 18 ++-------
 tools/sched_ext/include/scx/common.bpf.h      |  3 +-
 tools/sched_ext/include/scx/compat.bpf.h      | 37 +++++++++++++++++++
 tools/sched_ext/scx_flatcg.bpf.c              | 12 +++---
 tools/sched_ext/scx_simple.bpf.c              |  9 +++--
 .../sched_ext/enq_select_cpu_fails.bpf.c      | 12 +-----
 .../sched_ext/enq_select_cpu_fails.c          |  2 +-
 tools/testing/selftests/sched_ext/exit.bpf.c  |  6 ++-
 .../sched_ext/select_cpu_dfl_nodispatch.bpf.c | 13 +++----
 .../sched_ext/select_cpu_dfl_nodispatch.c     |  2 +-
 12 files changed, 73 insertions(+), 55 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 0993e41353db7..7f36f4fcf5f31 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -142,15 +142,14 @@ optional. The following modified excerpt is from
                        s32 prev_cpu, u64 wake_flags)
     {
             s32 cpu;
-            /* Need to initialize or the BPF verifier will reject the program */
-            bool direct = false;
 
-            cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &direct);
-
-            if (direct)
+            cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+            if (cpu >= 0)
                     scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+                    return cpu;
+            }
 
-            return cpu;
+            return prev_cpu;
     }
 
     /*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 343f066c1185d..d82e9d3cbc0dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -464,13 +464,12 @@ struct sched_ext_ops {
 	 * state. By default, implementing this operation disables the built-in
 	 * idle CPU tracking and the following helpers become unavailable:
 	 *
-	 * - scx_bpf_select_cpu_dfl()
 	 * - scx_bpf_select_cpu_and()
 	 * - scx_bpf_test_and_clear_cpu_idle()
 	 * - scx_bpf_pick_idle_cpu()
 	 *
 	 * The user also must implement ops.select_cpu() as the default
-	 * implementation relies on scx_bpf_select_cpu_dfl().
+	 * implementation relies on scx_bpf_select_cpu_and().
 	 *
 	 * Specify the %SCX_OPS_KEEP_BUILTIN_IDLE flag to keep the built-in idle
 	 * tracking.
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index 220e11cd0ab67..746fd36050045 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -872,26 +872,16 @@ __bpf_kfunc int scx_bpf_cpu_node(s32 cpu)
 #endif
 }
 
-/**
- * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu()
- * @p: task_struct to select a CPU for
- * @prev_cpu: CPU @p was on previously
- * @wake_flags: %SCX_WAKE_* flags
- * @is_idle: out parameter indicating whether the returned CPU is idle
- *
- * Can only be called from ops.select_cpu() if the built-in CPU selection is
- * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
- * @p, @prev_cpu and @wake_flags match ops.select_cpu().
- *
- * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
- * currently idle and thus a good candidate for direct dispatching.
- */
+/* Provided for backward binary compatibility, will be removed in v6.17. */
 __bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu,
 				       u64 wake_flags, bool *is_idle)
 {
 #ifdef CONFIG_SMP
 	s32 cpu;
 #endif
+	printk_deferred_once(KERN_WARNING
+			"sched_ext: scx_bpf_select_cpu_dfl() deprecated in favor of scx_bpf_select_cpu_and()");
+
 	if (!ops_cpu_valid(prev_cpu, NULL))
 		goto prev_cpu;
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 6f1da61cf7f17..1eb790eb90d40 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -47,7 +47,8 @@ static inline void ___vmlinux_h_sanity_check___(void)
 }
 
 s32 scx_bpf_create_dsq(u64 dsq_id, s32 node) __ksym;
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym;
+s32 scx_bpf_select_cpu_dfl(struct task_struct *p,
+			   s32 prev_cpu, u64 wake_flags, bool *is_idle) __ksym __weak;
 s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
 			   const struct cpumask *cpus_allowed, u64 flags) __ksym __weak;
 void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64 slice, u64 enq_flags) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 9252e1a00556f..f9caa7baf356c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -225,6 +225,43 @@ static inline bool __COMPAT_is_enq_cpu_selected(u64 enq_flags)
 	 scx_bpf_pick_any_cpu_node(cpus_allowed, node, flags) :			\
 	 scx_bpf_pick_any_cpu(cpus_allowed, flags))
 
+/**
+ * scx_bpf_select_cpu_dfl - The default implementation of ops.select_cpu().
+ * We will preserve this compatible helper until v6.17.
+ *
+ * @p: task_struct to select a CPU for
+ * @prev_cpu: CPU @p was on previously
+ * @wake_flags: %SCX_WAKE_* flags
+ * @is_idle: out parameter indicating whether the returned CPU is idle
+ *
+ * Can only be called from ops.select_cpu() if the built-in CPU selection is
+ * enabled - ops.update_idle() is missing or %SCX_OPS_KEEP_BUILTIN_IDLE is set.
+ * @p, @prev_cpu and @wake_flags match ops.select_cpu().
+ *
+ * Returns the picked CPU with *@is_idle indicating whether the picked CPU is
+ * currently idle and thus a good candidate for direct dispatching.
+ */
+#define scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, is_idle)		\
+({										\
+	s32 __cpu;								\
+										\
+	if (bpf_ksym_exists(scx_bpf_select_cpu_and)) {				\
+		__cpu = scx_bpf_select_cpu_and((p), (prev_cpu), (wake_flags),	\
+					       (p)->cpus_ptr, 0);		\
+		if (__cpu >= 0) {						\
+			*(is_idle) = true;					\
+		} else {							\
+			*(is_idle) = false;					\
+			__cpu = (prev_cpu);					\
+		}								\
+	} else {								\
+		__cpu = scx_bpf_select_cpu_dfl((p), (prev_cpu),			\
+					       (wake_flags), (is_idle));	\
+	}									\
+										\
+	__cpu;									\
+})
+
 /*
  * Define sched_ext_ops. This may be expanded to define multiple variants for
  * backward compatibility. See compat.h::SCX_OPS_LOAD/ATTACH().
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 2c720e3ecad59..0075bff928893 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -317,15 +317,12 @@ static void set_bypassed_at(struct task_struct *p, struct fcg_task_ctx *taskc)
 s32 BPF_STRUCT_OPS(fcg_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
 	struct fcg_task_ctx *taskc;
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-
 	taskc = bpf_task_storage_get(&task_ctx, p, 0, 0);
 	if (!taskc) {
 		scx_bpf_error("task_ctx lookup failed");
-		return cpu;
+		return prev_cpu;
 	}
 
 	/*
@@ -333,13 +330,16 @@ s32 BPF_STRUCT_OPS(fcg_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake
 	 * idle. Follow it and charge the cgroup later in fcg_stopping() after
 	 * the fact.
 	 */
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
 		set_bypassed_at(p, taskc);
 		stat_inc(FCG_STAT_LOCAL);
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
 	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(fcg_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/sched_ext/scx_simple.bpf.c b/tools/sched_ext/scx_simple.bpf.c
index e6de99dba7db6..0e48b2e46a683 100644
--- a/tools/sched_ext/scx_simple.bpf.c
+++ b/tools/sched_ext/scx_simple.bpf.c
@@ -54,16 +54,17 @@ static void stat_inc(u32 idx)
 
 s32 BPF_STRUCT_OPS(simple_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
 {
-	bool is_idle = false;
 	s32 cpu;
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
-	if (is_idle) {
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
 		stat_inc(0);	/* count local queueing */
 		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
+
+		return cpu;
 	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(simple_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
index a7cf868d5e311..d3c0716aa79c9 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.bpf.c
@@ -9,10 +9,6 @@
 
 char _license[] SEC("license") = "GPL";
 
-/* Manually specify the signature until the kfunc is added to the scx repo. */
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   bool *found) __ksym;
-
 s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -22,14 +18,8 @@ s32 BPF_STRUCT_OPS(enq_select_cpu_fails_select_cpu, struct task_struct *p,
 void BPF_STRUCT_OPS(enq_select_cpu_fails_enqueue, struct task_struct *p,
 		    u64 enq_flags)
 {
-	/*
-	 * Need to initialize the variable or the verifier will fail to load.
-	 * Improving these semantics is actively being worked on.
-	 */
-	bool found = false;
-
 	/* Can only call from ops.select_cpu() */
-	scx_bpf_select_cpu_dfl(p, 0, 0, &found);
+	scx_bpf_select_cpu_and(p, 0, 0, p->cpus_ptr, 0);
 
 	scx_bpf_dsq_insert(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
 }
diff --git a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
index a80e3a3b3698c..c964444998667 100644
--- a/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
+++ b/tools/testing/selftests/sched_ext/enq_select_cpu_fails.c
@@ -52,7 +52,7 @@ static void cleanup(void *ctx)
 
 struct scx_test enq_select_cpu_fails = {
 	.name = "enq_select_cpu_fails",
-	.description = "Verify we fail to call scx_bpf_select_cpu_dfl() "
+	.description = "Verify we fail to call scx_bpf_select_cpu_and() "
 		       "from ops.enqueue()",
 	.setup = setup,
 	.run = run,
diff --git a/tools/testing/selftests/sched_ext/exit.bpf.c b/tools/testing/selftests/sched_ext/exit.bpf.c
index 4bc36182d3ffc..8122421856c1b 100644
--- a/tools/testing/selftests/sched_ext/exit.bpf.c
+++ b/tools/testing/selftests/sched_ext/exit.bpf.c
@@ -20,12 +20,14 @@ UEI_DEFINE(uei);
 s32 BPF_STRUCT_OPS(exit_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
-	bool found;
+	s32 cpu;
 
 	if (exit_point == EXIT_SELECT_CPU)
 		EXIT_CLEANLY();
 
-	return scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &found);
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+
+	return cpu >= 0 ? cpu : prev_cpu;
 }
 
 void BPF_STRUCT_OPS(exit_enqueue, struct task_struct *p, u64 enq_flags)
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
index 815f1d5d61ac4..4e1b698f710e7 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.bpf.c
@@ -27,10 +27,6 @@ struct {
 	__type(value, struct task_ctx);
 } task_ctx_stor SEC(".maps");
 
-/* Manually specify the signature until the kfunc is added to the scx repo. */
-s32 scx_bpf_select_cpu_dfl(struct task_struct *p, s32 prev_cpu, u64 wake_flags,
-			   bool *found) __ksym;
-
 s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -43,10 +39,13 @@ s32 BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_select_cpu, struct task_struct *p,
 		return -ESRCH;
 	}
 
-	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags,
-				     &tctx->force_local);
+	cpu = scx_bpf_select_cpu_and(p, prev_cpu, wake_flags, p->cpus_ptr, 0);
+	if (cpu >= 0) {
+		tctx->force_local = true;
+		return cpu;
+	}
 
-	return cpu;
+	return prev_cpu;
 }
 
 void BPF_STRUCT_OPS(select_cpu_dfl_nodispatch_enqueue, struct task_struct *p,
diff --git a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
index 9b5d232efb7f6..2f450bb14e8d9 100644
--- a/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
+++ b/tools/testing/selftests/sched_ext/select_cpu_dfl_nodispatch.c
@@ -66,7 +66,7 @@ static void cleanup(void *ctx)
 
 struct scx_test select_cpu_dfl_nodispatch = {
 	.name = "select_cpu_dfl_nodispatch",
-	.description = "Verify behavior of scx_bpf_select_cpu_dfl() in "
+	.description = "Verify behavior of scx_bpf_select_cpu_and() in "
 		       "ops.select_cpu()",
 	.setup = setup,
 	.run = run,
-- 
2.48.1


