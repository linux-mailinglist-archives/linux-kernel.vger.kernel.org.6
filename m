Return-Path: <linux-kernel+bounces-436886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5E9E8C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0CB282865
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2D4215176;
	Mon,  9 Dec 2024 07:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pF+pjtgl"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020125.outbound.protection.outlook.com [52.101.56.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E5021516F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728866; cv=fail; b=a5RSIMjR/w5oauVT7ikp7LvNsuYylbkgw7zZx/UEltSzRDzosYK+JuSCC281n+YWUpsBcdrouiTaOsMsMT4K6Q09xLT6i7B1wS28i0r3wY3L1yPI7UxaBfd6lgyPZ9XD1pjOEmamJDrvD0TjFlL5ZfmmHzlJuDhCyn5Wp+COgCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728866; c=relaxed/simple;
	bh=VRo3P7VT58J9rDa1apiwFPCFYg8pIhuUob9V80EptUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rC8Tt3WvMlkeo+cfP1zGawFwaONeTKS8vbqr0e5a1Iiuwr96VYwmof2wA+4/rgscJbuiI0llVirxIAKyD6Va6C3RDvTjMe53C/bWE0krFDyrGkm+MVmoX1RChhGcWYBp+rk0VYyiEgHam5HZWd60IH/Jpc2zyyK6bwB0gNnWIQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pF+pjtgl; arc=fail smtp.client-ip=52.101.56.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bh8f57Rv0YnLwB78STuNEbWVEezHd+boHjUCEX9SgFDvgrxPQYp92G1tOyTVnNRcYBJCdnX63dmdZlz7UhCH1ACWlP31+Q883gPYEne2lOjJyXyP/+mN8VKfuVDqd+K6g/N079uu4oYVrBwjZuhra9/9NRez4LuOFHichUFjvBnEt420vQp1DIgvnLSvmLyBsOkz7Kw6MIOwm/l0HeXxvoqdxD1mmUzYg52U8dPE6j+ZSIP5Ydoi7XR+G1biHUWP/d4svOEnDjw4eiYkbQfWnmHY5MGdir9bBt3nhzzYATU33nPxJA+9N+Gp9iW9a5LQz+VzvzBhySy6kVqtxDsS7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7AL4BcXa+HmHafwP1jO8SG1fRRg2L2Q13y4RXZu+3o=;
 b=DNfCcYCMNhE1P9SNC36NpQUEHESEB8jXnV/EguIMo+jUTL1kzcs9Pdip2mR9z/O8Uvfpv3CYKIX4SSIBeAkkzyLLmA/1HUtqdBGpYeQ8pv93mOcefJyRpjW+xeSl3HMIoDI4DFWAw7QBOpxCiwQf8NIRrX2BfGUWoaVXqmxvzG8roquOXDfaeqx+XaaMpkY88QZTLPGZ3fcNuuSYVaZP7bD+YVyzIJmjXF6JxKk7QEviDb5wfKCn/3Aamut3KtCv+VkH+5t8AuADwHLoP9a7Zl9HPaSbpFmWQN8rzN39tjLklVsyHQER4gTTw5lQwBLEA6Q+xcmkX5oNVcjxL0GP2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7AL4BcXa+HmHafwP1jO8SG1fRRg2L2Q13y4RXZu+3o=;
 b=pF+pjtglaaa8U7M6yY2jbHyyed1C2mkocCUehec0wpfxkcyxNGiqmrgODOcLV0X6/gbQDl+NgRhwVg/DzAsRJGRK2SI++/K/H1NA/GjSMht3VClIr5KJj+1G48sUDvRpcJ/7L2vnzRYXLKsVXWTBh3mxsUbi1KMw8EgfxZ1h5Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 MN0PR01MB7876.prod.exchangelabs.com (2603:10b6:208:383::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.12; Mon, 9 Dec 2024 07:20:58 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Mon, 9 Dec 2024
 07:20:58 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	anshuman.khandual@arm.com,
	corbet@lwn.net
Cc: patches@amperecomputing.com,
	cl@linux.com,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	inux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v3 2/2] arm64: remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
Date: Mon,  9 Dec 2024 15:20:20 +0800
Message-Id: <20241209072020.4743-3-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241209072020.4743-1-shijie@os.amperecomputing.com>
References: <20241209072020.4743-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|MN0PR01MB7876:EE_
X-MS-Office365-Filtering-Correlation-Id: b398abf3-6905-4243-118b-08dd1822072a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2O8uvrOx873GhmjM9I3AVL3xLoT/8U11kEE+MkWL1fcbxdFuCod1V9/g4XKP?=
 =?us-ascii?Q?1QSJ11LN/aQyrxDmoEfNKwfjvF39s82GWMtGyye2ICf2x2IjD05KSAVtg/Rf?=
 =?us-ascii?Q?JtCzF/g/PDd6oWA765Ul1JOw2YMI705eTV8IzCxOrmc//jmU6qEnhJgW9hxU?=
 =?us-ascii?Q?uLLC5l6z6QrXBFxiGDcTJKM+uqeQCy78v6adlZKSv6gCO4+Eg6A8pZghhGTZ?=
 =?us-ascii?Q?wjzlnPJ96EbdpGIzjHz73XFC6Dm64vsyBaYcKzPcpSnMq8s+X/eqwQJoQG+9?=
 =?us-ascii?Q?EN3IwlWHKNcF2SFXtJr3n9I/vGu65Egz9ZssFScZQ2oWmEK6y/3uw0rE36Ry?=
 =?us-ascii?Q?WmIMLg7I2AHyZrslkPOQf54Uv8DT4rBDEHnr8cQGicfjjcq4wVoXsrZDsQOC?=
 =?us-ascii?Q?iYEUifBgvVqlh4mWciWSRg7WR81d1zxY3lmx05YsoqUI4J9AZW44fGFmMd5w?=
 =?us-ascii?Q?w/y1HjXqjA+Pfgntt22aaDDPP9XvJCgJbNiyc4OiG9WEcUYcsq+Y61rjX8mM?=
 =?us-ascii?Q?oaP2bYrSExSsUhMFl5fc4aH1f/zIgxY8nBWiV0UWTtvxLHQb4Bc2NssXDAKY?=
 =?us-ascii?Q?p8I/QbK1j2uz6DVELdloYJ/Xd9Lzpvv3+Bw3N9u6LmwdBrUMUAIhgS6D5kgM?=
 =?us-ascii?Q?nbOSs+M6hnm1BMeEC7al82Uz6KcVbrJ4OrLB36iOrBrAcBXOb4JsImDPO1D6?=
 =?us-ascii?Q?NKqkdXRl3/rpHNziWhX5wAnwYjQz1yvSBC1Av3Pj4UDFdi9YL+hueFptNeQT?=
 =?us-ascii?Q?vYzHMA2SIldmprzAcaxCr4bxPMzuWKxuGjHERsQS0OjsyMi8TaN6bPc0GaDK?=
 =?us-ascii?Q?M4R+k+BlFg2Y6TJPG4xSW53FiddmiUzioi/Sf+Q3UTISPYpT9lUXNzMeb977?=
 =?us-ascii?Q?bAu8Kh8yIVWzfKVVzT5OgHNhVZd0sk0PDjOe5yIPkS5r1HfOjSEWlQW1b92S?=
 =?us-ascii?Q?4FnyGKP62AFZLdgj1iaDHmQMfIBaetMRl/zEdTR0vYzbpb0WiuK8+VMv7KSJ?=
 =?us-ascii?Q?PmaIUILjZy7lvDh7MLqd00uyyGdbX7wtF1crZTLc4derVRzP9bqF0KKbHTlg?=
 =?us-ascii?Q?vvSvwXJ5Ir4NkREPcI1OzQY6mMrii9xXdPWxZR3Id5rWN4+HsxtifgOykq1C?=
 =?us-ascii?Q?w4jUOkO/E0/uVUWv56WiUdMdxkaq3x8Ngugod/zUnGZEBgH0xc/WFRI0mqwI?=
 =?us-ascii?Q?XxYaYTxX0AuETl9PmWEDGq0MhPfiHWfwGScVOYcGF/prgnL/snXJjJua7zse?=
 =?us-ascii?Q?y7dyxlvVZh6TXuzMM92tc4Y1fjODyHLjk0RcOR6nsUfg3hUc8UagrpzAC5dV?=
 =?us-ascii?Q?yD5c7/TUz1NqesjCFSH2yydmKv93I+pl2yyQKk5t0+XWlhx/qipwqguVI7C2?=
 =?us-ascii?Q?Oz8ypuWGeYfbPTiNC5Amyz672C9j0aibp+4a/uSOj5x2avEySw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YB7YLhgy+i4Rtv4MF7Bgg27RxBjRkQkeUOHwTQHAMBNWcSLEWHxLShZqxYrh?=
 =?us-ascii?Q?Lnf2Bj4wAYmOm3/Tg36qTc/w9OUaNZx3OhPjgz8XHD4MGiLyAbnaAPY2w6Be?=
 =?us-ascii?Q?heBAXWgxFHU0BmK9TJ+qQbiVPVcLMj8FGv0uk5kqsf630XB8933n8Jg0S42V?=
 =?us-ascii?Q?VxWvydS7tR5WnRK86rpG80Z5Th7NasFOAvajXYgBLdZdYF+eF3EiYb8YjzDC?=
 =?us-ascii?Q?PBWHXTi4u7MsQBDj014i1DFl4wOvgK8I2hJStASXHClmEXoVim44Ytz/83Kd?=
 =?us-ascii?Q?UZT/K+OuduCDCQdBIpYT2MWOJKIOI1pnW5jlqRu9tHNV9cSNciM51y3nqt+k?=
 =?us-ascii?Q?3Ohv4RHmPX0FYiW5mEIaUE0b5RLvYfqmHvpJRNKxcMGoeKaW66LfRbjdmNSX?=
 =?us-ascii?Q?QsockmYeSKnOS/nHsiEnhdRs+0CINxwV8GrRJ8+ZEEpvGIN2RP0DZKzKwMa3?=
 =?us-ascii?Q?iYHVGFUi3FZJk3+snl8oIgPvw/yWb6MY7WUtxoL4b/uVsrmKxDfEF94Idl5I?=
 =?us-ascii?Q?+VdV/XNfgj/V1SHAYaVLeZHJvvaswXl4eIuHo2m/F5u3kbDuoWs8LDm0QyDE?=
 =?us-ascii?Q?ekg0AKImKYO2wPACupgfLXxBcL8KXWo7uSFoLNVWcun6+41hThKCdlMmu6QP?=
 =?us-ascii?Q?TSl0nh3hDg3yDAAnEsy7MnJgaaapms8MMt3wZIfE4LRtFpbnNkSY07w98uCn?=
 =?us-ascii?Q?tjS5eRXo9SuRbovnESA1vOzGcxPjAwWvEljrr0+Q8Gsb5f2AH9HSMLVW5tgG?=
 =?us-ascii?Q?Dm0OhdwT/PdJKSYBRjqqNluWQfJ7USIzU1SaRU6fJAbLtmB2jpkgk07BXiT+?=
 =?us-ascii?Q?d3wAuHbtJVSzwLg3So0jLg0oxLEw1I2YykImmyQBe+zVpE3PnLmY0WN07Yh3?=
 =?us-ascii?Q?ljXsfnP9Qo+My2dZGt8z+MNHVup/VZ6TPrqKtWoYBjccwxY+PzPtBbqHb6Bk?=
 =?us-ascii?Q?NGun9vxtB2C3M5BTYqefs+poxjj9Zg8Wi8Er93bOQfqo/xnTdAQDCv/6CZmt?=
 =?us-ascii?Q?o9xs0b3xeLq66A8zg5Y3VZ5DKamWt9AudESQn30T3rw4mUbsNhWIeQnRbavc?=
 =?us-ascii?Q?MOGP9exeGNKRyGWO+v5KlqI7cIB8r6iJUo38PCaINzfM9bRigN3gflt1lzdi?=
 =?us-ascii?Q?kgQKrQLwpq/+3S4aMIq+BPibuGSGsqOXETEBJiPUBfjflZlJmuxJ38viQGA1?=
 =?us-ascii?Q?2PL5W0EsoAFqZ+rmo1A4qPHCqJJXaKPYlRZAnhIXscCi2gJGJmmMkAUjkUpn?=
 =?us-ascii?Q?D2LONHomRTR3bJELPShoe9QaSuxzUW8TMWHVeTT4wy+JCnroNFX1VCYZYNO/?=
 =?us-ascii?Q?rLOYFu1Wb8tDy6KlvF9jYs1GPDKjYhNkcrrsRUFwUmQCpRuNTs7RYCAFvvlp?=
 =?us-ascii?Q?N1/yA9DMY9d+Bf2sv17EPQgJblDSqOu7RDizRP3ElXI608s+upPm1KKmlJn3?=
 =?us-ascii?Q?+TE+ZguIMZ48hxnJ71vcMpGhHmoXVDC10JIyLZ0Z44njRSELs0n3HOEiV88e?=
 =?us-ascii?Q?8Jp4E4oZWzoswupzwOpgVx4gKX8Ggvc5hxvwi97GknLhuaezeO7jeToCt/x3?=
 =?us-ascii?Q?20zIc7lIqJkFWJNnQi7ZPKppxBesK3tyHcGUt1+b25O79ah4HgezoBYEKruG?=
 =?us-ascii?Q?20sLjS2LKmhWiOmMA5vhfDQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b398abf3-6905-4243-118b-08dd1822072a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:20:58.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/9yszKILYt9cpDTlDxw7izD+kBQb79fP9DrsscwFB61cFo0Ypy/4sDqUOYAqfibciX5V+bW6rP5xTbghEWny5jJZOl/1G4jPZPeQRV5lz23NArIcc1aPJwanoMBlu5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7876

After patch "arm64: refacotr the rodata=xxx",
the "rodata=on" becomes the default.

     ......................................
	if (!strcmp(arg, "on")) {
		rodata_enabled = rodata_full = true;
		return true;
	}
     ......................................

The rodata_full is always "true" via "rodata=on" and does not
depend on the config RODATA_FULL_DEFAULT_ENABLED anymore,
so it can be dropped.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/Kconfig       | 14 --------------
 arch/arm64/mm/pageattr.c |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cbfd357f94a6..1c69982302ed 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1666,20 +1666,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
 	  When taking an exception from user-space, a sequence of branches
 	  or a firmware call overwrites the branch history.
 
-config RODATA_FULL_DEFAULT_ENABLED
-	bool "Apply r/o permissions of VM areas also to their linear aliases"
-	default y
-	help
-	  Apply read-only attributes of VM areas to the linear alias of
-	  the backing pages as well. This prevents code or read-only data
-	  from being modified (inadvertently or intentionally) via another
-	  mapping of the same memory page. This additional enhancement can
-	  be turned off at runtime by passing rodata=[off|on] (and turned on
-	  with rodata=full if this option is set to 'n')
-
-	  This requires the linear region to be mapped down to pages,
-	  which may adversely affect performance in some cases.
-
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	depends on !KCSAN
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 39fd1f7ff02a..6eef08d8451e 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -20,7 +20,7 @@ struct page_change_data {
 	pgprot_t clear_mask;
 };
 
-bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
+bool rodata_full __ro_after_init = true;
 
 bool can_set_direct_map(void)
 {
-- 
2.40.1


