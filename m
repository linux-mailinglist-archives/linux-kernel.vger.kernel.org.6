Return-Path: <linux-kernel+bounces-422040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CE9D93AC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ED9DB25875
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 08:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4E1B21AD;
	Tue, 26 Nov 2024 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="M8YlM5yy"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2127.outbound.protection.outlook.com [40.107.237.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40DF1B0F06;
	Tue, 26 Nov 2024 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611486; cv=fail; b=f+ny4p77yAnoWnutOK5/R9XJO93GEaYlN0OrwxWQBLDFloLFG+ZWb6A8bJbP19dX+EAT0CPl/wrbfmQS+JGSfaV4HL9jOPPqIaaOP2OYPQnCL/ot5V4erCcnoWwWbnNTklmf8A8VRcRZb2TjAfftMYJfYpqB9nUdCTy5hI9u5JY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611486; c=relaxed/simple;
	bh=XKlALcn2/jufqk0ahC9P1N2mxPf+ln17xT9YK1BS6Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sHxn+TxvcvvdP4N43+JWPaeYNM0htdDAsXf9T5VYY01jOekLBkNt8fCP+7Ex2qh0l/e4MzuQ9c+lqujCOTZ+T3teC2aVc2s6zQyVwS+Ta1Bx490AxtKXdekYReuLUopLBjUAeEyTfXWwnToXYjfQYuXPpZJlQMO6RYK0lATSoUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M8YlM5yy; arc=fail smtp.client-ip=40.107.237.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afQBNRtCKKzCyML+D/a72nU3HQNmnsidMWPAT2aJ5MH2FRZeqnn09VNqhCNJzGGOGCZmLckWISLFg6I828xcRlwiEgojlNDTuZMd4NGCVuNoiStUzaXn+uQV6vaT6guM/xDfc2dVQKYj1Ik4UCyEui4aW903ERE3IXpO9KGct+XCVHzTsBn4o5Njf7tHnaRTuKsFMJ8+odF0NrapqLHLdmCrvnqXjg4agSkrlOkGzbHnn+0zHmtnQzD/SSS6vX4mMu3Bc1zkL+HUfVpqKoHDAHy2sR+uAmqACBeQOroAb6lZLpiFa51bo3tbPVNGfdRPABcbrFvx8oaUno2GL6nO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5AzrKavhO1VpmrpbaXWmJbotll9Vr7JY23qALOx3Jg=;
 b=TRRlQ2naupmM+VhYRbeQ7XRg8ZUoeCgUDHsMGdDXkC1x9vYBJFYEPUh2llPlBTfx62SBNV77TCMA4kAL0p/Xd5gyG4wuBJnMyRWluaKJo7wa75nPobtOcZ3uVQm7phhj+zMXfAehq4VCmnFw3Fmi0uP3E3AdmlT3GsZGeI0pDjpzlI3qIG6MNyPs5/sGKqnGnJTTXj9TB3ThfrZ0QqJkirqxnYyM5+YPpIsVJP1Xc/iDhYknoU7lm/19Hbynhs8V8ZcZMfXetAp9sKOR5k7A/sAuilejJqf528mn7UkRUnl4Z8xrcOEJVwu/Rm4Pn5tZnmuXE87IV6TpJNyUokZ2CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5AzrKavhO1VpmrpbaXWmJbotll9Vr7JY23qALOx3Jg=;
 b=M8YlM5yyMOeG+CutSkVibMQORJyBZXAacqGTj/C/X/MFTmn5KN+NboyzIbKKJaEmUh89ftNzbdr8k/8VhbpINM1nM8wzbhXzZPK2RGEUU4zt8AilTiRXFoedZMb94dqh7HrSG1XFiZdFnfljXM4KW7t6iZRTCOImM2wIxEPmzPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 DS1PR01MB8869.prod.exchangelabs.com (2603:10b6:8:222::22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.12; Tue, 26 Nov 2024 08:58:01 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%4]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 08:58:01 +0000
From: Huang Shijie <shijie@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: patches@amperecomputing.com,
	paulmck@kernel.org,
	akpm@linux-foundation.org,
	thuth@redhat.com,
	rostedt@goodmis.org,
	xiongwei.song@windriver.com,
	ardb@kernel.org,
	steven.price@arm.com,
	suzuki.poulose@arm.com,
	mark.rutland@arm.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	cl@os.amperecomputing.com,
	Huang Shijie <shijie@os.amperecomputing.com>
Subject: [PATCH v2 2/4] arm64: remove CONFIG_RODATA_FULL_DEFAULT_ENABLED
Date: Tue, 26 Nov 2024 16:56:45 +0800
Message-Id: <20241126085647.4993-3-shijie@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241126085647.4993-1-shijie@os.amperecomputing.com>
References: <20241126085647.4993-1-shijie@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To PH0PR01MB7975.prod.exchangelabs.com
 (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|DS1PR01MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b5801606-b654-49b5-a25b-08dd0df86e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?en/PWbQI1+HUIQcv41++sJZkN17nJFTRBoiLRq9C6LClyHlv4C4+woSq/1sU?=
 =?us-ascii?Q?MRHfQ22Mfw9KtO42sSgLEqaUFhBmvBLFqs7rQyooF6orQ1Ed57RSesOE5cin?=
 =?us-ascii?Q?2LfPqBC328lLUuBDfjc2e/MuWi1pIU5urwzc2q2TpjcNp7b3agN8Sief/CxY?=
 =?us-ascii?Q?vF8RRJdmJ9gDSbxUI6ncQVv3/JuNOF9+Tn+tHpqMMaly5oOLjref5lK15z3S?=
 =?us-ascii?Q?0hqyr2HPW67Xpk6w29qQs53qWxrRpIlT1nxTlGN4B+nTIpcEsGm6dQ0x7uNo?=
 =?us-ascii?Q?QRq5r5hr55PC4zXyX+d89Xd/C6z2+S+0hvJZ1aL2Ued0y3dNlcgBHWiIavMc?=
 =?us-ascii?Q?YPXpE9gmQBFnC2ccvGDW4gCLddFGdaKWog+ynqkKMwTihQ3/gdoxygifLTV7?=
 =?us-ascii?Q?gJ/rqHMt5Dh4FchKZjotgE6gIKiwXYJtCThqh0xpof9YYmLZzTLpwYlMQfYD?=
 =?us-ascii?Q?MtgS64JaM8CV9Qvd/kMMzwAoViVgWmsAd3ICm0viCitGAYvldVjsPfE0dFDq?=
 =?us-ascii?Q?LUZ9AdTPdwBwKBeBMPDNt3+HW3KHi3AXhu/uHRGs2JEIiA75ePrgb4yJbFJ4?=
 =?us-ascii?Q?5/wfSc2bkTZESuhAX5CTY2yUcWM73h1R9dvOsSrgnY+WLGU9+F31y2aEpR9L?=
 =?us-ascii?Q?YrdfKjaCkvX5yja0dGoa+UsnqyCuNn+DQandH4oAyrRonQBjPH9bu8Tw05h2?=
 =?us-ascii?Q?Sk64eNdWvOCoVnIVBq+0T1B1NSL6onIgtg0y2Jgj2Vt9FLMbWR+kZpbMWKlJ?=
 =?us-ascii?Q?RLBG7NIwsPZqFuLik1idcB2OC8x7kJQSz8Skibc+AEqkBEGWeuStcHxygyQN?=
 =?us-ascii?Q?nlZLlWRlOSG+aDnvF6VGShvRIhYYb0cCl267Vt7roCq9IvmIsSpKMSqEqmne?=
 =?us-ascii?Q?BhhBnR/GMO3dcizQIKrYDzONyyLf9UzwqkeX2dMjqiXCfdnaVSRLcQzXQjju?=
 =?us-ascii?Q?gEUcgMgWwKHoUNXqjclNaxcAA9BrASjT0299HuG+j48/sVbZjvLZbejY2PeL?=
 =?us-ascii?Q?0E8dQdud8yt9nnPrdew830Gc+AV7ayaoFcA/0G49Wz2gV+8mhUdMXJfF0vbF?=
 =?us-ascii?Q?5T34h3m9W45tsQXvnxWBL7j7uMY91Xh6kv6dWsMyHEREyFDztpMslvW4g05G?=
 =?us-ascii?Q?I/mbuC8W9VvwczAsSiUtLCXCJs9YShB+CQhbghV42KCEPy/O7SBH6EoexYEm?=
 =?us-ascii?Q?U6afLDLATwFJtTuKRXz5VnLFQRngKtWWlpRJM0Pyqc5y+8DHTb7z1sF042s4?=
 =?us-ascii?Q?kfifvsEALS2yZF3feOSJiT4D+XdQK74o+UdLKk1NblEjeBZjLnybylU+cIFt?=
 =?us-ascii?Q?IngVBqta/n9YAr/HBbx888V6AdYGB5PGDGIweXTCG0imqvNkV8cEjw4MD8JO?=
 =?us-ascii?Q?iVMBmcQ68UnnnNn4yYCyaK2MlSi2ISaIBS/cWFIEVgMtUF7x+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5sEy4zFiD3/Ll4YdixyqGnGwcxJz+cqjZDT9S+eSYCwujkQ0KqiHr/aG4J6a?=
 =?us-ascii?Q?XyljtFni5qltWO9piOEDbAkkNH/b5vGpbSVT1F/TMK2uIlWGEHOoFv/evuzX?=
 =?us-ascii?Q?hHXAmvJHoARapAMD1iQ1vMJCIEzCxBmVaFEGA6FGz571wNQWsetWgCo0bKVV?=
 =?us-ascii?Q?fLMcXJYD74yH/7fDFzUmLqmcCCtbrdrT7o3+NdAJuwUp8tJAUpyvN06brXC+?=
 =?us-ascii?Q?45C51RQYIQV5IvvmFA+lPXPVsAQNxX2tdVCVWd4amcvfa0qpfIGmVxcLYSeb?=
 =?us-ascii?Q?oOQ+5XBgr2NIwHEwMRhSGc352rXRo1He+HzXKqRS5uBL+WRwM/Z3bAaKdjlB?=
 =?us-ascii?Q?zfeCat412bUnDgVqN/MC9DiZVR4zc7m+n/WuyC7qd34jwRtJm8mbzXrVGaHg?=
 =?us-ascii?Q?xobuTW/9F0DsEqF9D/culODrraTY3hLt1PXykUyThhfUoX5bRscHAPIg0WIe?=
 =?us-ascii?Q?8QZq9D5Eq0rId+monqKOcJlRXc6sXc9thXW4Hpng+H6ytMAPPp48YihJ1DTT?=
 =?us-ascii?Q?xpZyu02kZxqQTJLfbgYAZ1xQY81L/ZKk6GPCQLG6gaDcRDTiwJEF98G9Gd3K?=
 =?us-ascii?Q?qL0DVfuo678pAqgEaJU7ihLb4oYkQv8rzQZIP9bj7w91DueecJqfOuPwuspF?=
 =?us-ascii?Q?LAG1kYbtvZEaHs0PYAPNlmzONEXyCd/H7c2kXtYX1WeLy9sl0u/Dm0j72axJ?=
 =?us-ascii?Q?gWEGQ05mnl9h8mTk6jzjMS/tRVmt2WfGK/MMq7Ae39CCD8r8q39s0VQbhXJa?=
 =?us-ascii?Q?A7I25ZzlwmEBlHm2Nk01chHHYAFpCNUQ4LHOHwDMTZ0opVWdbsuEhou6pBLZ?=
 =?us-ascii?Q?kYmL8T9ypD2yTZeieIlSZIzXiLCUGKSuMnpu1+If88bXkRmEVOfIj0weiYkW?=
 =?us-ascii?Q?VocclRl+/jHvAxyO8+a2EjPsOuVcCL2JPgaug0hPrBYIOGtyMuW15Ri2Hf6F?=
 =?us-ascii?Q?YssUVDqBBoWcCthxq0OpgqTTHiRawch3hi529WtOR4zMI727VjuWWaqOzeWH?=
 =?us-ascii?Q?WzSK7HgDykM3bJ1Ck62pCLe8BDsLOEFwnTQd9qVJueTOT2T7GY8Pc/L6qG9W?=
 =?us-ascii?Q?g1phC68zrcC3jwRmac77EJHKHqdh44Rq3T9f0GQUTFBrYUgJUOK62LUU8T1R?=
 =?us-ascii?Q?gisQTdgQRRbW276voJ0b46bLA/1tcq3Ojt+dgmEhubpxql0s0LdKJ0NpFUQ/?=
 =?us-ascii?Q?Sm05h9MGT2ZKzmYEWCHFJAX+Lu7lICv3m80Up3XrGPLH+tLzViCCKKSU3j47?=
 =?us-ascii?Q?6b+X/OvMbN3oABAx3rIpI/xI7mSAyRnsryeng35JQOdAgEmPp5I9gp1S649A?=
 =?us-ascii?Q?BpIITwec3Nklwh/PpPPKMDr0IAVbFf9dyB+1kQdw6pe5s+VV7kB+iGmHCbnX?=
 =?us-ascii?Q?g9SMM1gECqPXwZM3PKbcI5PsXiqKuiYp7BNvDwc9j0+bPne/yeA3OhHeVxgt?=
 =?us-ascii?Q?modFBc8EGWtLVJah9afzslZZOcdaBhNLjSbc0g17iB3Lt16e2ZKiNVnTvTDV?=
 =?us-ascii?Q?FgpkQHfC7iX61VcrX1gGRvFTxx7Eo7HBAspNpPycX8jCbkvUGpU22USV44cI?=
 =?us-ascii?Q?ewb+NF/9GV8CyBImex5IUFGn0Anfg9wdG03eXGfupUhIrurrjwH6y/KMwR4O?=
 =?us-ascii?Q?ni8XQl/5y+keK1Nl2xWmL3g=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5801606-b654-49b5-a25b-08dd0df86e8f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 08:58:01.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6EMpArw2NA4A16hqRLfkyX4K2FGC1E9/ioIZmKInd31Sw5u7IfuqEtXG+Lh0sZk2VKapXKaV3zmRDvTN7LZrAkAOE53nCq1SUa9HohxRpqsqzkaqeOe6KGede/aEvCd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR01MB8869

The default kernel is rodata=on which means
CONFIG_RODATA_FULL_DEFAULT_ENABLED is always enabled by default.
So we can remove CONFIG_RODATA_FULL_DEFAULT_ENABLED now.

Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
---
 arch/arm64/Kconfig       | 14 --------------
 arch/arm64/mm/pageattr.c |  2 +-
 2 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4316b1fe8bf8..a9ca305a31d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1653,20 +1653,6 @@ config MITIGATE_SPECTRE_BRANCH_HISTORY
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


