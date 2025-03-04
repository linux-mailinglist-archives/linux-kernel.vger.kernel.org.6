Return-Path: <linux-kernel+bounces-545681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC3FA4F014
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85163AC992
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF06277817;
	Tue,  4 Mar 2025 22:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZDBsuHd+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2097.outbound.protection.outlook.com [40.107.237.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BF2777F4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126868; cv=fail; b=QoYya3bygSNBmG9DUraObqrTS+E4KEQWjaTPw4RUzpkkQEsQwjY/TUeIhoHZgThv5zV5PnaUmdv0+x24xMGPFmd4XMqvYLqs2jNQTwLQpahCQITj/sFlVrTDHUnBgeL0BAOeO9jm3WqCdNIHuIz9Mh4KPYYpE73XHd9cYVGWeZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126868; c=relaxed/simple;
	bh=cG1TXKK0riDKhVoG+eoOzE9JMATvhkIfBb1VchdO88w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5T861aOzSfmeEQSbosdD2gbkZRuVGKZb8cJlJOTaYIkqRWJ1iscEEq5lm0Dxmvy43XGCs9dAohp/4UlCALdFA5SXtO8QfXyGy4nPGxtBKLb5gHzxhmnGi7Ii+wsa0FCtSkZmwTaTre3xBOi3I2fz18NBm+68NOApSKzQJdmN28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZDBsuHd+; arc=fail smtp.client-ip=40.107.237.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xvfe0MqKb51Je9wLEh1TiPUjnzHUTGLw1uGIOZ/1CXK8WQ0Fd9x9l6q+vKVSp9LV++KWfJU1cI/NeZCP+PmWCQ/dc/+MQ7VTKO4gmqtxFS3bu//emHO5K351RCcUHNVe7/ugOCfbcHZ+dbzecbdNnM4DCL2a4UNntXqde57+e/TLMRPRETdH3UTe3aFI3tAhL+zGUisYzBTGnCqyjwlMqn3R083KMBH9QLhAoFTFsYr+SCsHaag/vZoexprAfPHISl7/wGAU4tnwm7oIJqzjp+v6H61iG4dWflNAnceqQGp8wUR7Rfn3qA2xcMHWmfb4U91M1nFJO3tGudWKBqIEtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KDHg9m5RQuafqimCOTWucTmGtJk6oGY9o9n630bLHs=;
 b=qno18n2StlAoHY9zoZbZoxZf2Ww9hQrIo2naxABDfzFSj3eOL+Me5h7ohyktT9lbe76x4qwZGaR696lyraRk89XrxOoSZtZcQ3KJfvSSRIsrqdQUTYYSYG+qItE139CYMFv+oKmsK9+FZe5L0xEA3heG0QbjOXLJmfsLeXaH2rCSPV3HibJ87P/dEFyzSXBRIR4Y802wqoJ1z1miesm65WbteKEzDzmm20Dv5NqxrPoI16SEfI4NrWNet880uGpm61oXhRbTG1Z3yYHKvTdwOh/dg/CsesT/f37PT3TQNwEd6CipiH4gLwUklvGXs6W4NC2/Jlsx/Y7uQwLbRGLecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KDHg9m5RQuafqimCOTWucTmGtJk6oGY9o9n630bLHs=;
 b=ZDBsuHd+Lx9aHQ25KfjeHLQ34nBSj05D4Z0L4oMyMYUXczme1Rxy5j2le1EQsLX6qZXLOCY2CzVlDkfTSZAI9Tw/+D49JOjJvH6EXhIn8rIk6F3EaE4a0JUuFoqxAcVuNsIDntrG/CCQVGWMM3G15mZKjbjI8q/05PdVMyxtlPM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MN0PR01MB7803.prod.exchangelabs.com (2603:10b6:208:37e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Tue, 4 Mar 2025 22:20:52 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 22:20:52 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	Miko.Lenczewski@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH 6/6] arm64: mm: split linear mapping if BBML2 is not supported on secondary CPUs
Date: Tue,  4 Mar 2025 14:19:31 -0800
Message-ID: <20250304222018.615808-7-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250304222018.615808-1-yang@os.amperecomputing.com>
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MN0PR01MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ef06aa-5cf6-4201-e18a-08dd5b6ad2f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZyhBeGBfy9khsjwEAStR8dKkd13Ad2jf+MJHqxQvTqH7Xj6LaA3PFpgRmLey?=
 =?us-ascii?Q?uxQL+xkaFR0boyY2dXQoa+8zCIk9rv4swsH6NIDfhW+tRx0R7f+5vbDBcj7j?=
 =?us-ascii?Q?wzEB9buABmL1Go65ZTFY96uM/mygr/+YCZA5d/kbKmtL3I8a3F9BQA3rwhJO?=
 =?us-ascii?Q?q3L5dTROkUlodYsXX373/RKUKwq9thIfWuJsdohruhrSqkzg7pJtQFS7ikuo?=
 =?us-ascii?Q?yGqsBZfdoZXW/u8FKJiQ+xhQYW5Wbkuxs67PzclkJK7SD/KTsrrFLKQ1JXwr?=
 =?us-ascii?Q?WioIXUMb6yT2dr9ltA5FwqKDKDyMBIAecdWqu5oAcGBVzZ9dhpxqrYOyJY5M?=
 =?us-ascii?Q?+zqmtNXGZukYXaknj1IpVIWstl1UWlfN1HPVjERrNvUJiKh4YzTYsjgFKmY2?=
 =?us-ascii?Q?yP+B3DjUdEDuTzwwzMuoa5RaD8uYCF/bOszX8vXF77YQr5t9srXSfEi7b1gV?=
 =?us-ascii?Q?9Ufz1eAihCfCWiONwmzV72xcEm2YU3buPrrhBduJdHqIVF7ZHdrG4cbTtKKm?=
 =?us-ascii?Q?UqUexaXQU/vKxvEwM2QWSG2XEneexvmKAJYJ6+PTUV9dHlgYNY5FwpqzyUCj?=
 =?us-ascii?Q?fEFFuL2JpawuXz/5REHMr2a3RqIQe+eNwaKPYxrSRuoiPhN6OEu0Ggcxm2bF?=
 =?us-ascii?Q?HYTK57vIThKJVf5GsOrU09WI7TviOSfwDU6tKbNGFgfCPoQiJFNTrkn0tiLI?=
 =?us-ascii?Q?BKa+Ndua6SeiW90+Wx739Z/KwhDyhgOxxFmD+0ZAMTtWBIz8vE7sNUUKPW7i?=
 =?us-ascii?Q?74CQuD0HHFsTpRRMXCDHIjc7uA72vz0QUw65nW5rKJK46cJO93LQun7PhTcG?=
 =?us-ascii?Q?jqBV6KsY9F8rbRW3pcdfaP5MObLAfw+gOHWhnPqFHL4zafGswFAL3Z5+VtqJ?=
 =?us-ascii?Q?CleH23/KOMZH5SfLd3LlKYpPHzvnwxyiW1uYFNSgnqY7DHyRKAC8+l6TklEv?=
 =?us-ascii?Q?fD7AEwLbsWEpE+BhwS1yi4CzJLxAE2T+i1ovEgL+QqoqU/g0POaaKDxI7+Zv?=
 =?us-ascii?Q?o3hf5HkUTqc6+1BgzhlnQxiAVb97QIBu3+WHYDRAHdlHXKVID2m6z1PuToHc?=
 =?us-ascii?Q?zv5ezVUHbqsMooHgC5nL5B7MRpZTsCFVeQj8ClodUK5GU+HH8CyjfVLBKV5N?=
 =?us-ascii?Q?oWsgThvd99r5ixtVmoTlOGpt0ZlVGw9BxJ+kZfaAeK1DHEvoq40bfuyNUKe0?=
 =?us-ascii?Q?UUu4LZeHy5lgoBBx9jwxtCSP8+ihsLnA+XBHuXAbQkwpH2u23WMFSIKzwX0C?=
 =?us-ascii?Q?BIy4VBEVqBAhfO/5MlRq0LFoUmx6BdhYFmj0uyXBLPHyTtA52BTCaivoWjPt?=
 =?us-ascii?Q?6F2bkt5ofmO0PRsSth6gAUZXmV3NVoSyDPzemNOWMZzrXo+PbVr20AIDJJFX?=
 =?us-ascii?Q?TbhQ94V+J4FKP6m/9KBwqOzQ5AHL5mMTjrfcAn7OCL07Im9AY26V+KFJbKRH?=
 =?us-ascii?Q?HzjVlWZUh1C9w8PQCZzpxBwda9XnZ1mB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TpBIXw8L9Fv3jCzNUeeVOphRXwzzEZ45VAt7M21AgjkJ6EcdSJma/N8yPDKl?=
 =?us-ascii?Q?YgXTpz9bYkgQj6jsL+rDifeLYs/xO89RLNXEmRlSf8fekJv/cW/cSIi07ADB?=
 =?us-ascii?Q?4LLOJadqZ+yMEEfwTYSxcDdrtox4HuEDImggoZS3+AGjptBKeLWs8nlH8/UD?=
 =?us-ascii?Q?ZTqEER9PkIinTMtgcqAWRGgT13zDUAt51oLe99x3GMZ7t+oYwrhS+btMM0z2?=
 =?us-ascii?Q?4vz14Ted+JjkbvksEBKbwWbYPDEn7+yx7K8Vcs+JnJJN9lQgrB+VHubG3LZp?=
 =?us-ascii?Q?0c0wLgCT/rkydPXhrwrEJoPEPjueJ5v90agfW9gZi+f8WyZuDnsGr0Tjd7tc?=
 =?us-ascii?Q?QdDR8h1k5/IDMe12C8KFVa1cR2mUY/YXLX44YzqmjhNYHEEjO9KGJF6uxHHl?=
 =?us-ascii?Q?ftDy5h4zqdphNYwSp6m4X1cjhPstGfJkhrePyeJMAyPjxFbpYf3Coj4KXwOI?=
 =?us-ascii?Q?JLAqUrTwyRPFIl4Kcr6Tpx6vM2sCjQ3tKAyZr3tvfSrsU5Zwdea/gCaoT54P?=
 =?us-ascii?Q?fG7aAaq0Fqto8auyUQ8x8oMrMN/JOrFSCP8rNI8M1NSpIhWSMoJPo++1VUgA?=
 =?us-ascii?Q?3JJxhbnGPB1mnxv0x9aCZbcxZoEARLfjUzzVwkUbQrP6oqnY3DTpew4jbpHe?=
 =?us-ascii?Q?FMIprLhNPnMjJHH9sdnThHPwVYphiyfkCPAYfLK8f7N+XdQAmSnJB32xONer?=
 =?us-ascii?Q?S4qvClBHiteXMe7jMxPHkJ0dzi+63zKj4Iq8DnANCJO2cNTkl2Lq6tvjuJcT?=
 =?us-ascii?Q?EAOY2feJfoyQ501cRNHPL/g4W3WxvSFjcExOF82+qF0yaLPR22VBUaHSZFbq?=
 =?us-ascii?Q?CTo/FKJ6dx1KLrUgYWQkNYixU0OfHSUkowfnCuRiA2kdtOE1X4O74jautW7f?=
 =?us-ascii?Q?tkQd6d9ve/qcdRNet0g7nwJbd6zNAREP1AKlPmJTyz8put+FMLtePL1Xtdpk?=
 =?us-ascii?Q?UHGGfcQNTB2MbUdLVGFQEsyGwJC52kjsSeQPuI2rP3TpQn/rw5o8NuiMt+pw?=
 =?us-ascii?Q?Aw8Y/NxuJrQCIGyyJz0i0RTGvCZtil5Y0UcfL5T+G+fbwJUlTZFcGYr7j9Gp?=
 =?us-ascii?Q?VKqXmo4zSJGa7RejAiQGkRcV3bxPsiX7NL1KXKzx7LvfN9kjJWH3CZ3SlsLL?=
 =?us-ascii?Q?dg04zkjp0rGaF8WbE79DibXr/CxWcxl78Xl3YD1XuJS0hDiZIZ/mU6Rq1lK2?=
 =?us-ascii?Q?a6SkNP0szaj61iCbni27vhKFCdf2VLxtmoHznryVPNonySUiu7831j41xJEv?=
 =?us-ascii?Q?+U/JxyicYZalPeClAfOGD17CLL5PfmWzL2zuzVz/y8xsL65v33QIEnfbcHaB?=
 =?us-ascii?Q?0JZBGuQjUZ1GznTag5aRFRZMygiWFctlJlnGAYnktUskXkJDcjLBzYeddz0W?=
 =?us-ascii?Q?VqCYAXNQHnkgj6pSFjtQAB74O65oQL22RpRFyEJsYnN8hxYoQC8Anl+795Oi?=
 =?us-ascii?Q?Hig5vvUQtS+whGWX9TE5yv1y511PgoS4wxA2FzSNedFvIpG5eRDg0vPyxAZJ?=
 =?us-ascii?Q?Xch9CGc3tCpMVSqO9bKPDTAzDRPFoTbgZCyQ91jE4r+wo+DxLhBZ+5IfWj4J?=
 =?us-ascii?Q?8b5SXwIBlO+0maZzybMzNi9OW+64XYK0RZxyIk81n//xd+EgXa+d31uF0Gdl?=
 =?us-ascii?Q?tPvwHbXDVt1WEApxai7BHmI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ef06aa-5cf6-4201-e18a-08dd5b6ad2f8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 22:20:52.2224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Ye4M2usk+FDas2CIrPhWIR2rlctS3n02VF3DoPUAPmyY3VbMGNc78aBOTnJ9ULh0zSr/tXfNXDiTF+bKo6mPkem1hV1fLkpXmz5EWYzt4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7803

The kernel linear mapping is painted in very early stage of system boot.
The cpufeature has not been finalized yet at this point.  So the linear
mapping is determined by the capability of boot CPU.  If the boot CPU
supports BBML2, large block mapping will be used for linear mapping.

But the secondary CPUs may not support BBML2, so repaint the linear mapping
if large block mapping is used and the secondary CPUs don't support BBML2
once cpufeature is finalized on all CPUs.

If the boot CPU doesn't support BBML2 or the secondary CPUs have the
same BBML2 capability with the boot CPU, repainting the linear mapping
is not needed.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/include/asm/mmu.h   |  3 +++
 arch/arm64/kernel/cpufeature.c | 24 +++++++++++++++++++
 arch/arm64/mm/mmu.c            | 43 +++++++++++++++++++++++++++++++++-
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index d658a33df266..181649424317 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -56,6 +56,8 @@ typedef struct {
  */
 #define ASID(mm)	(atomic64_read(&(mm)->context.id) & 0xffff)
 
+extern bool block_mapping;
+
 static inline bool arm64_kernel_unmapped_at_el0(void)
 {
 	return alternative_has_cap_unlikely(ARM64_UNMAP_KERNEL_AT_EL0);
@@ -72,6 +74,7 @@ extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
 extern void *fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot);
 extern void mark_linear_text_alias_ro(void);
 extern int split_linear_mapping(unsigned long start, unsigned long end);
+extern int __repaint_linear_mappings(void *__unused);
 
 /*
  * This check is triggered during the early boot before the cpufeature
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d39637d5aeab..ffb797bc2dba 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -85,6 +85,7 @@
 #include <asm/insn.h>
 #include <asm/kvm_host.h>
 #include <asm/mmu_context.h>
+#include <asm/mmu.h>
 #include <asm/mte.h>
 #include <asm/processor.h>
 #include <asm/smp.h>
@@ -1972,6 +1973,28 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 	return 0;
 }
 
+static void __init repaint_linear_mappings(void)
+{
+	struct cpumask bbml2_cpus;
+
+	if (!block_mapping)
+		return;
+
+	if (!rodata_full)
+		return;
+
+	if (system_supports_bbml2_noabort())
+		return;
+
+	/*
+	 * Need to guarantee repainting linear mapping is called on the
+	 * boot CPU since boot CPU supports BBML2.
+	 */
+	cpumask_clear(&bbml2_cpus);
+	cpumask_set_cpu(smp_processor_id(), &bbml2_cpus);
+	stop_machine(__repaint_linear_mappings, NULL, &bbml2_cpus);
+}
+
 static void __init kpti_install_ng_mappings(void)
 {
 	/* Check whether KPTI is going to be used */
@@ -3814,6 +3837,7 @@ void __init setup_system_features(void)
 {
 	setup_system_capabilities();
 
+	repaint_linear_mappings();
 	kpti_install_ng_mappings();
 
 	sve_setup();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d4dfeabc80e9..015b30567ad1 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -209,6 +209,8 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmdval,
 	/* It must be naturally aligned if PMD is leaf */
 	if ((flags & NO_CONT_MAPPINGS) == 0)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+	else
+		prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
 
 	for (i = 0; i < PTRS_PER_PTE; i++, ptep++)
 		__set_pte_nosync(ptep, pfn_pte(pfn + i, prot));
@@ -258,6 +260,8 @@ static int split_pud(pud_t *pudp, pud_t pudval,
 	/* It must be naturally aligned if PUD is leaf */
 	if ((flags & NO_CONT_MAPPINGS) == 0)
 		prot = __pgprot(pgprot_val(prot) | PTE_CONT);
+	else
+		prot = __pgprot(pgprot_val(prot) & ~PTE_CONT);
 
 	for (int i = 0; i < PTRS_PER_PMD; i++, pmdp++) {
 		__set_pmd_nosync(pmdp, pfn_pmd(pfn, prot));
@@ -806,6 +810,37 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+int __init __repaint_linear_mappings(void *__unused)
+{
+	phys_addr_t kernel_start = __pa_symbol(_stext);
+	phys_addr_t kernel_end = __pa_symbol(__init_begin);
+	phys_addr_t start, end;
+	unsigned long vstart, vend;
+	u64 i;
+	int ret;
+
+	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
+	/* Split the whole linear mapping */
+	for_each_mem_range(i, &start, &end) {
+		if (start >= end)
+			return -EINVAL;
+
+		vstart = __phys_to_virt(start);
+		vend = __phys_to_virt(end);
+		ret = __create_pgd_mapping_locked(init_mm.pgd, start,
+					vstart, (end - start), __pgprot(0),
+					__pgd_pgtable_alloc,
+					NO_CONT_MAPPINGS | SPLIT_MAPPINGS);
+		if (ret)
+			panic("Failed to split linear mappings\n");
+
+		flush_tlb_kernel_range(vstart, vend);
+	}
+	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
+
+	return 0;
+}
+
 #ifdef CONFIG_KFENCE
 
 bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
@@ -860,6 +895,8 @@ static inline void arm64_kfence_map_pool(phys_addr_t kfence_pool, pgd_t *pgdp) {
 
 #endif /* CONFIG_KFENCE */
 
+bool block_mapping;
+
 static inline bool force_pte_mapping(void)
 {
 	/*
@@ -888,6 +925,8 @@ static void __init map_mem(pgd_t *pgdp)
 	int flags = NO_EXEC_MAPPINGS;
 	u64 i;
 
+	block_mapping = true;
+
 	/*
 	 * Setting hierarchical PXNTable attributes on table entries covering
 	 * the linear region is only possible if it is guaranteed that no table
@@ -903,8 +942,10 @@ static void __init map_mem(pgd_t *pgdp)
 
 	early_kfence_pool = arm64_kfence_alloc_pool();
 
-	if (force_pte_mapping())
+	if (force_pte_mapping()) {
+		block_mapping = false;
 		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
+	}
 
 	/*
 	 * Take care not to create a writable alias for the
-- 
2.47.1


