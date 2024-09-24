Return-Path: <linux-kernel+bounces-336880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749C984206
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 11:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE5B285FA3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DA16F0F0;
	Tue, 24 Sep 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="eIplAb5P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="sKD/UN8e"
Received: from smtpout144.security-mail.net (smtpout144.security-mail.net [85.31.212.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD53156236
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169907; cv=fail; b=B96lXtlVgyNk8jik2RTO37GryukEDoiS7bguUwQHU3F7L862BcWmJwvU9Ck0tC7dwtcJ3GzgpgT0wzoMurclefqZ1541TBsiDeyNn/aRDyC3DuVLSvlX9hpOy+XOXmKoa1e3w9jfQ97np+BOa5Vf0x9r8SD1E6WLK7yTGoe9q4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169907; c=relaxed/simple;
	bh=T5uSHgkmAwvTJQWgMDrPyQnAF/YeHQaaCcpuB+cWki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGPIUM6UAr3HRy1jlcwE9O+XaFjOlRu0d6d7zPdLC02y2o7KeSWPKOae7vqRs0nfW5S2YYvLtzj+sn6aCKx8kGFX4nGzTYzJ+pLTY4FyxQSxXhnzIIwXzEPiuSJ8GZetW0Ei31g+j5ClZWSmupgLt/wFTKWoovsRSW3bwr9rXZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=eIplAb5P; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=sKD/UN8e reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (fx601.security-mail.net [127.0.0.1])
	by fx601.security-mail.net (Postfix) with ESMTP id 5E1553497D3
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1727169782;
	bh=T5uSHgkmAwvTJQWgMDrPyQnAF/YeHQaaCcpuB+cWki0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eIplAb5PYMJiPhM+zEjD09Fe1nc9swQPwUK3u96zyo5CU26dnWpdESlHp+konHPjl
	 wvdnhXoKuBVVfDD8vmXEMMpVdDPJlGAoRzJ+QMykXBVqePasYdRzM4/Zq1v9ut2Nkh
	 +P5D+q38LAzwSIVGvLojwHid1gRqpg7SgHeKKa+U=
Received: from fx601 (fx601.security-mail.net [127.0.0.1]) by
 fx601.security-mail.net (Postfix) with ESMTP id 2EBC134976F; Tue, 24 Sep
 2024 11:23:02 +0200 (CEST)
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp17011025.outbound.protection.outlook.com
 [40.93.76.25]) by fx601.security-mail.net (Postfix) with ESMTPS id
 76B59349570; Tue, 24 Sep 2024 11:23:01 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB3073.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Tue, 24 Sep
 2024 09:23:00 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7982.022; Tue, 24 Sep
 2024 09:23:00 +0000
X-Secumail-id: <16471.66f284f5.74345.0>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR59ryZlXi0NOCk0VgPCx3yhA3ZpWbYdEkZ73RTimncbO+Ur1mugIQGAuyZTucXWbrSDCFa//sGiPdNWyVCgs3Y8bhj2VOme4tLCLWU7axglceAb8yUBTCLKoaAaEl+F6xkHFmCufAoCosi/qwhiWoMsMobU9QGN1A5QYUSiGrUbLhjAFGUUt/1+CL5YE97dWfzFuzkOmeWK7QfecVW7PDoJr9a7iHuMjsLlH6MqBDKgd1QHu3CjiROtW4wVneK2tV0IiPAaot4r+HzPOlaOecj+ptJqlvVtD3ERoB5Pqa/wjgIrdcuCHojuYzj1K66IHIdEc+ffiqtlJFsCh78Tsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap33tf5qZZ62I8NJEWvBds9aSZQ+d7OzAL26H+fuCc8=;
 b=oHVV3G9reGkIsHSea1cr4vwcxmkVETdd6LqBTu4yAGtPbxv0pS7xop0XXhkATC0PGHEN+AfTr+lDeC8S9TmcOH6EvrlaqLrL5StIolVBUExkgjQHj6ayqtUCIqf9tyfGvMwjRbuDZa0bOVyWEjD4RObYM+uvoLj2H0cAW5ZlAhejb8sdtGv6MeXi4tZxytw/+rBUz6cWS0vwhK0WegGVHwTi4Ef4tdX+IMjgD47cVVYu0jsZnwfjAKbsykDi0/4lG9l/LVOG5EQrjdc4a4NyuczYxz2DLBN2hMV2wz/3oImunvt7uQSgXHLfMFHSoHmEpoKoQwPFIZk4Apcb+oo9Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap33tf5qZZ62I8NJEWvBds9aSZQ+d7OzAL26H+fuCc8=;
 b=sKD/UN8elYWrJHK0oreZ4rM1vqb/ihd0ZDcd539hImuqHoWDhv16W0P/V3XAbfdBnHSKnIYNobDoiFvGjhdtpc6WyAk5njsZvivm/1hKRop7OTk4kKrK3XlUzjJyLdbJ3+rGoKHN76Qt4T9R+OlbosLo/H7A4wg+W6VSFQhTczF6QmOFTnHQO3awwsLSod0PEdc488oCCk+cNjWNFmvF1gn+9WeB3f3xpP2+ZS421pxIS+5jU/yfi5ozfFbt3+S1JWPrUrzczdmywovsnRIDhvEQOPef7bvQTNwgtb8jeOANbEImpC3CqJoCmqlpStTsfpoQqiLMw7xFNNCaIlDrKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kalrayinc.com;
From: Julian Vetter <jvetter@kalrayinc.com>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev, Yann Sionneau
 <ysionneau@kalrayinc.com>, Julian Vetter <jvetter@kalrayinc.com>
Subject: [PATCH v4 5/5] Use generic io memcpy functions on the loongarch
 architecture
Date: Tue, 24 Sep 2024 11:22:23 +0200
Message-ID: <20240924092223.534040-6-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924092223.534040-1-jvetter@kalrayinc.com>
References: <20240924092223.534040-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0028.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::20) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB3073:EE_
X-MS-Office365-Filtering-Correlation-Id: 557af0dd-54de-4834-96d1-08dcdc7a7bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: ClE0vi6dd6acGpZk7qmFmvVqn+jN1TesnT5i5M4nxDzFzyuizG6G6tIjesBY5zWKidmCQapMELWW9lnAIkMIpTDZP33SuB0JkhZjIHojs1inTIiVyFLZ84WUS0mDcrn08XkbntLz1QTtbK5aJr/X4+JoNXKT1qG+Hi/ww0xtb1EKpzBMigYe4ieB+7eIUGOYxc1lngwV80Gfm6rZJiTYJmp+MVbqnZeKAoKtXro+jE6ahhj9P4JThJCeEHY4w9SQ8SAiwAEFNXDaNGghEyL8PJkWA6GL/zEUa6vD/sKNBfYhUQzPdv9khoHBoZpGhJK8u9Rw/DkKP5QyIPVMMjgjI0UIixWDzQQtwnOxYCFvGE00tHnrE61dcAJe0mRdwrL+tcSY4qMGf53RWDGVqyF9QMMT76qAsnKnyf8gTWp7iB2YKbQWjpQexKZeyAC9Ml0xURmV0JTueIXMfISyCguAeVoR8azdqiTsrat8W4DZOculJMKC0SSpo4YxxQ4p6GERigXkzd7+xIOxCXEtKsulxhzAdLNQ+We2wfUFJP0njmS5ddo3ovBIQA019m7GGD4sNjmSn36NBohPj+c/SB5Aiqcc6EXpDa5pTrGvN7OvhPfwURvS7jv6COv3n00+2eRcchIL+vv0Q4+Xzt0ePT1dBHS1fC3sF8T/ML20bFSJFFM0iPg0Xt9AL3W9qTzBlhbLOiwnu39fPL9Cjt289VRIugeyTKWNwHJTapndU6VFmTadJ9okqQPNuN1KqeoMjdxSEoRYyyAWPX7tYRaeM0GceE06k1yKt6nr3U94qQTDaIWBcarreCVdbA8PsndBXL8ue62V7WxeovXaD/dNks13YgZHBcAGt5rj40yNMFE8BUuxH3i/71yVmslUIdQzmLdt1anvlflTaozfToeoRs6X/7qJepi8ZBfSTAeHpTlBHhWgKSjSzIDYR0sonFaXfxnzDcL
 mRLmjqY8OCPs9L2fWS3zPaN7/2Btk7mggf21nv0aOSgxtEXrXj48dfHQwwCnulZLhZCqjtDFP0vE+BdU8mD9qJ+esj+YqQYI/AHSnA+sjOJ0JHxFaGZDkAQE2vZnWwBS95MylrbWJFnrGR/nn+xdYkKG2L3iXTgC967VBro+Qsnn8vIMxMx0xmEqt37VfXODapFjFw75FBDW3iuMeN/L8S89V3Kp6QnGRIN38Z7vgMif/07gfqHX9intiumyjiAcFiQ5D1FfFyBLbZBSILMv9xr9GyLF0AYqRUI8xWHarSFmPqDREvgXcy8MLgqfcaYB/gnEGi5gAFaX/YmR3gfRzBrWIRQ6ygMk3UI36XWE+r22my1uMv5mDqYkXvhP5pWax+qg6M+bZcPdAHHWojw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AsHJ9KRUZvnsp6R8TOAgsuT6LUjM1H/t6yUHyAz9odBXCax2RYt5EGowLNpOwjUjtitL/nIuqcmwChI6u90lvjbsoZtngN99D4q+FXTb4r2NzomMDs2nCTun64RPbB88JzOTwWVB3iph1jLpZ+GOaP3bp+HHMGzjMGIRUD4a4IWyo8BglGXqlf9NzKy8XvdN0grfcPUrRmur2B0Ty+43ctqxXWo3jtmXkqsVKtT3Oe/Il4uJ/Amyzak21eKhJk54Vlk12PZIqhbTWjpG60gf8it2hU8pqnuwPQgtssxDOKnWajzX9f+Qz2VnJiCCrWh/uV9FSbD2QDgLw1Uq1aMNAx2NMtOQRwdfk+iV+Q/WrPBTDruwBpdAwqW2+qM9VoeOuWwq0tnl7Dm/c0aEjmdY749044WTCSq3bL8U0s0UB+XAwba0TO4+zyG2LDb43pF42LzqcYV1gZUgzgVGTaJ3AbyOyqaIfFBXciMlNcIM2YZqSkHsxg7zysLB5wmA9PJ19GQRWt4uHGmWqQIT+H0+i70Tp5tntUirNnlDEYbbljlg/HYdrm8l/4Fg41HS5Wo6CJHO/w4U9QtyM9s20XAWwyuKrjkofQARwbfvb0dBmZlT00YQTB5WJH9MGWc0G/sB+jtyqjM3BAMDWCwPbD21xYJr4SIz90kzkqaw6mtRnpH7X8k7qybqG0Cl+rskD5IdPKGVtN1lhUjQgzm+n0n6D5526VjvA+G0wjK12APfg2NEZnARVeAbgd1jS1bIVq88g/P8ogAF007L/kKskAk7VTrpqXO94LQqahbGkIp+8TdpLDxtuueY2H65zF3yoZP8hnL+OyfCRO/3nB9MkDcOrRctpdnkLGeEzpusZaeQgUjxYnY16feUhvEzqjH3zWN+4gRX/oTR3Vanf1MaX5nocnG92hsBXygwSmc+VYSruuOtKl2sbvXG9FimDyUbw1zu
 bHhm2gjMEoY4mNSnYSO2k1kN4i0Zp0Vt7Ei6jT0sIJlFJrOC4Jr11nJNkgemdsW0WIESUARRhkoaaE6K8dSNvgbnH7UPR2abx4i319dGq5p8HPT/kzXOdAUpldfKKfjQ1VD8jTkPfMojFy11jFkm+u5NtByVc0fQKYkn4C/BW1OqhJsRma+0s8zDZBGDin+qP1Hg7S7fB1sw17uec7cmJncS0Qh6d1Niig8L6SQdk52bRZZjPSkQMG8tDt7jc1UW/MsG1L4rXyuakAy4t10rqbCn7eZDHI76BbeY1056XdIZZ+rOXZctnFwR+e/sh3WdVYcBr1NlpNiNLWEcoPl8eAJAykHoPtquWQLuxEhZVM7iUXtmz3jASDUOqV/Bz0xjVryPqRfsvObP0+8Pz7M5Ums/c+BTq4gpuHc6dzJPe6EIkE3WRQBBbGUZVEpJz1Sma7qSp4aAWkwZ8h7rKyhmky5iHw5ODdYOyFxDaJJ4Zg5hA1/3ZnIos7wwXW0b3NnUzZg81W9kGFq6jw1lIrFXhHn+EhgJp7MJSiChOdzxzW7eqfruWTbd+qMMcTiQI0F6KUXjMU3Hi86bQI4xY3tpuQpCw2AsAnuZSvIHyIclMB9vgdNfaKsd9/aBbT2vqPAI
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 557af0dd-54de-4834-96d1-08dcdc7a7bf3
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 09:23:00.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exUCptaH5lhbs5eJudIQlgtkq4fjqEX1fWKXrqtFJX7TLCV1tH8LoZm6n39ff5a8saBwmObIaU7U6TClNb8n3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3073
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

Use the generic __memcpy_{from,to}io and __memset_io functions on the
loongarch processor architecture.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
---
 arch/loongarch/Kconfig         |  1 +
 arch/loongarch/kernel/Makefile |  2 +-
 arch/loongarch/kernel/io.c     | 94 ----------------------------------
 3 files changed, 2 insertions(+), 95 deletions(-)
 delete mode 100644 arch/loongarch/kernel/io.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 70f169210b52..bc97b09efd16 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -84,6 +84,7 @@ config LOONGARCH
 	select GENERIC_CPU_DEVICES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_IO_COPY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_IRQ_PROBE
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index c9bfeda89e40..9497968ee158 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ OBJECT_FILES_NON_STANDARD_head.o := y
 extra-y		:= vmlinux.lds
 
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
-		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
+		   traps.o irq.o idle.o process.o dma.o mem.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
 		   alternative.o unwind.o
 
diff --git a/arch/loongarch/kernel/io.c b/arch/loongarch/kernel/io.c
deleted file mode 100644
index cb85bda5a6ad..000000000000
--- a/arch/loongarch/kernel/io.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
- */
-#include <linux/export.h>
-#include <linux/types.h>
-#include <linux/io.h>
-
-/*
- * Copy data from IO memory space to "real" memory space.
- */
-void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		*(u64 *)to = __raw_readq(from);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		*(u8 *)to = __raw_readb(from);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_fromio);
-
-/*
- * Copy data from "real" memory space to IO memory space.
- */
-void __memcpy_toio(volatile void __iomem *to, const void *from, size_t count)
-{
-	while (count && !IS_ALIGNED((unsigned long)to, 8)) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(*(u64 *)from, to);
-		from += 8;
-		to += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(*(u8 *)from, to);
-		from++;
-		to++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memcpy_toio);
-
-/*
- * "memset" on IO memory space.
- */
-void __memset_io(volatile void __iomem *dst, int c, size_t count)
-{
-	u64 qc = (u8)c;
-
-	qc |= qc << 8;
-	qc |= qc << 16;
-	qc |= qc << 32;
-
-	while (count && !IS_ALIGNED((unsigned long)dst, 8)) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-
-	while (count >= 8) {
-		__raw_writeq(qc, dst);
-		dst += 8;
-		count -= 8;
-	}
-
-	while (count) {
-		__raw_writeb(c, dst);
-		dst++;
-		count--;
-	}
-}
-EXPORT_SYMBOL(__memset_io);
-- 
2.34.1






