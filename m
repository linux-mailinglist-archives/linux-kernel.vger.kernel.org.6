Return-Path: <linux-kernel+bounces-321487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD5D971B1C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2061F22A98
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9E1B9835;
	Mon,  9 Sep 2024 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="cMQtTE/K";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="GSkxU26e"
Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264BA1B81B3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=85.31.212.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725888747; cv=fail; b=Ml9/GMkf8hZBNwK86t6mobzmbY7Mj8kn1mfn8lEd+gAGyRZEVhrwfdz3ySwG6ntVDIjvGQRVhFMTaatsQHrZ8z70EPjjjB/IOrGguqDujj3rS5iHwgPh8vgO8Jg0PceC4+vzgqbURyfuZ403pKeErljeJQp+8I86BirjUf+BEpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725888747; c=relaxed/simple;
	bh=T5uSHgkmAwvTJQWgMDrPyQnAF/YeHQaaCcpuB+cWki0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ8u9L9li8K5+Zyo+EUOGLrENAwDyyTCjBhQejH6LZFekYRsaEH9MaOPXVjFhy5PN7vGxHK7Po5hn7o3qfYst7/ew2ItEEgqET718iM7bARfTXKwcBiI0rH0xkaqo9nmWPkW7YKvr8Y4OuRIe60uFVDsuSvvd2VzY+wVcw+c7GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=cMQtTE/K; dkim=fail (2048-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=GSkxU26e reason="signature verification failed"; arc=fail smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id 41237C0223
	for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1725888738;
	bh=T5uSHgkmAwvTJQWgMDrPyQnAF/YeHQaaCcpuB+cWki0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cMQtTE/KDaRGCVqNF5utDzSx8C0nYsIQgV/Jm0HSZKm9/UFsihVqepJrnuLwXbqUM
	 WnCt0ORbvrQlwanb5Yv4KptasMJjkojL/KxQeBKwM191j3uFN3MSPA5a11Cdus8/cp
	 DZMNiH5KgaAf/MTMrQsdi4C+KfhbaFisV6yDSIFE=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 1A706C00CF; Mon, 09 Sep 2024 15:32:18 +0200 (CEST)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp17012051.outbound.protection.outlook.com
 [40.93.76.51]) by fx302.security-mail.net (Postfix) with ESMTPS id
 850AFC00CE; Mon, 09 Sep 2024 15:32:16 +0200 (CEST)
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:118::6)
 by MR1P264MB2580.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 13:32:13 +0000
Received: from PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626]) by PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 ([fe80::6fc2:2c8c:edc1:f626%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 13:32:13 +0000
X-Secumail-id: <bde6.66def8e0.84114.3>
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vzcEhMzCB5WAqacwPP2ejBm7TLfOnypIDjzf60VGm43A42eaXiQCUuy51wD9l92odRVNckGJg8l8JBX9/OOOiXP0oBBCUxgIYkszx5K4eduGCX2Y4/qJO5VoZLfBgYlMhFJlXAT5Lr1giEFXbopIZIEYm+t56BV/gTrHZUG12DaBBQp8DcAb7OFtR5H0ym2VzgeIT2U1NmvfCoKBCKhjlnFlXX7JlTCXUehs5FnoksMVhOC/h7u8vQnnFPhhRZF1BPjkaLhRg74yFwiArVe98sEGjGu+tx5kJi0qyf1UyELt1LfoAyJHMYJwaEzojTLShNEmiPUNqXCardgJVqPvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microsoft.com; s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ap33tf5qZZ62I8NJEWvBds9aSZQ+d7OzAL26H+fuCc8=;
 b=vUdpZDIsh5ogiKvCtBSiRFczXIXfvxi/b881zRPSlggsuRgZ8KzhZ2str1qHhhUI05urUPoa/4USW4u5qApaqrdSPRL/uhKFb+sFzgrOvQgJxMTbufyx3pGZFFdgRl4xURwfMt550c3yrZXZGyWGrOoAR3oKAdhAdlkEpia4ERSrRYgZoXlw5JfXOUzomUgo9BiG21xwK3YPx/OR1O4KcOMaPo2UZv0B8aFxZ3doqxFnGYXRbisTdTxr1UTcgCxc7l9nxrlmVUt7atT23LfM8Mu9JXr2xUhsQ+NVdx7yHiHmr68Xx0gWkR55ZWAmWvhbZmMMxU4u4wIC2XAm9nShmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kalrayinc.com; dmarc=pass action=none
 header.from=kalrayinc.com; dkim=pass header.d=kalrayinc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalrayinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap33tf5qZZ62I8NJEWvBds9aSZQ+d7OzAL26H+fuCc8=;
 b=GSkxU26eqSm0BB71z4WIZ+D7pGIUj56EINkCMGF/NzY2MvN3E9sQbX8dEtv2Z4xSKwq1ETbAeRYg3pXg99ziQB5iZ09Y+Rox/2O8czOHFQqP7HBRv+Cu1Y/mDzXEZZtjKXS62mlINa0sAELMwL3bejBkcZ7hYMj2mBj72TF4NN1m07Y6ScPbVlMMg65jurJOAQBpITlSDFYsABjSW77RhZr5LsGT+cKi0Pp5mIYl/eUWdk50KyVkRgPnu5pXiIOQ3CAVEx0gtluXuzerdXpehSdvFL5JwEk4KjXPSPELUBm6xjlvEpMWlRaja48+1o3kxtivBcb5LiFpycl52wtC2A==
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
Subject: [PATCH v2 4/4] Use generic io memcpy functions on the loongarch
 architecture
Date: Mon,  9 Sep 2024 15:31:59 +0200
Message-ID: <20240909133159.2024688-5-jvetter@kalrayinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909133159.2024688-1-jvetter@kalrayinc.com>
References: <20240909133159.2024688-1-jvetter@kalrayinc.com>
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:118::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3766:EE_|MR1P264MB2580:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b5ab6c-7f3d-403a-3050-08dcd0d3d08c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: wVbVo21/t8JR9+a733oj8m00H0Lj5AmtVg3fhIsqGJn1iSZrZL3Jgrz1UegBrUD6Yi0XhIUxThjoW4rwcQTC4oA1T2JdKf1Ze2AfwWweCDw6ZNgrRMwMZUT2kvhsi8KudndW8hHdKlZtTnixgGN0bMe6+1nVu/yBJ2TqmtT37+wlpvTMlKcE8ifjOJbbT8mLNrzseBH6ykK0XwWhSwlppZPbV6P6fQYfnDiwUv09PBZ+OpL2aMCKogTnTkcrEivBIc/jB1ZZt9qlCuzZMpjVwT9PNt801GCqL++yywAp3EukXUM915pqWe4AkbTbXOh60ljbhB+8HDaSX+JpmG0N98WtzalfrUjnS2BLm4Q1K8xxmbfIH2EDylQnspkzQQM9EVaTtGuQtRgJbQhCpAOoXtTirAccG36xgGtrqVjMcma0OAQ57yi0p6MZ/8g/OmbQDqI5pHmvrIi2Jjlfk4x8Dz3dKJzxeB6rZx6xw8UnOKyC3wFA4J7KY37FYiEBoNQyw1kdEC9NZ5UxbSYIKDbFbshIcsQIdpKR9eHCzeSnq8JktwzD5LfCAKpsaeHM7YpE4lZh68vFqhHjtKRpYtMmG9szvXhAZKNhUgPmQ5TliHSVt5n8wW2lW86VQM9a+lIkVCA4qO48ADnRTKE0k3mCXeFIs99t5wKzlSWyXfeZfipcZOGVbYH8+lnGyooyApTaunvSBspqjgz2DarDKi1YykcT8+JZuZmlmJa/8hAGBqP1LNheMApiOKcgIqo2bq/3TuaNRr7YybPYqE9W24jHxWojl8JyQrA0R05QImqTFe1/nmiWIaLW88eWIRqf5H7+QohKOiB6gVOCkTsPWaommP1wNF4ylN1reWD9kojq/ethl0hUTQLJzLte2SugSHFGBdvlYR6I1UW7W97vGzIFZD0xQQzOjYKex1Y5thztJwwmQIANDfGW7RdNSKWrej5gbw8
 YolifAwGyU25NQG/7sDNnbwITRh4aaqHwCycCVHgN08g4fetoAuTPgyGDmdYV/yAt9qcAjfKLjGjtZBsOiPpg7WlaTWupIqvY4pTxzR31OBdghtWR0xCgLEGXXxw6Lyf4Z1XHkH1pUoqwxX4SG5+NTr1hWaBtBbmQSO4SblHpnr9i7/em6FaxLQ4GqAGq62s171Du79w1JoeoF1sEtNJrfo0ot6R+DIoWm/vpqq7p6BQPpfqR+iioSUKCDnAkn96v7jNPKQFicSDf5IcE22O+diq5fQxeAa5yi3W3JF4js05RbU/rAtLzbMTQiARFYYGX5HCvLraewpom8MTo5qp37i2+Oo+9kiBTozv+EDxFmasfnJ1u4Uaq1/wnTaLvmCSemDqMTYs1fCE32Jri0+nXx4J+qjzpKu67oZ+5tuqfRmxevOs2x0pd1LBusDFrq8WFseN+oCG9aCDs6UNmaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WQk643TowifeIdn/A88k7w5dPylACgi02tQC9g2gmlpy5YN0/cT4KJ36gxLzcjA/8FCcuqcoIsKbEjsWGJRAjNPXuldcP6mzDIxH/puHgQDjCGHkHttoDvMX0LLAzA5JyLzxH0k91boWWUrCQ0oT0wmC0XRJvoZilp12y7Ol19s1vyVm0DWjZKJliXsl/17vb597CXhJ8dzHVz4oW4ew1IfV5CWfCEZ5kDoJdHWHtbDr57OTgCTlqdT5y64tDD2+t+vzQzdAXKsuMhX5nAHSsfrNP3wWiBZH3BHvx2dqUPNwtLaKfTXIP/s570FKeyzKi1yLqLkzkhBvlmtcs39np4VemKiRj9eypJE5PMx65Te7d7To9r3NtXS5BgHu7k5BxWhJlGEYE9TNfg+AHQxNwDexrMuJfJ61Npzbt+1oL6SO4kUfYmZ7CZlrrzVBwOyiCaFd0IWPEmbzdPymiQCZe5aZgod7ntJJo+UOJbqgJwFgS0ujogGUreIUqEcRhM6NsvIwSfLkKqF02lQA1FU5gRlgBBylnzCuij4CeqAW8/f/JXYhwrIYD+yaTZUQZ9zYMX/FqG3aRRMzOsdFXMjTJDZG4OCqUAqYEWiiE+tBIGYRLzOa8+1iesHXFMbQYF2a0h1CSRWHtfbyTTRPWIea5lud5CowuEntwoweNhOEDfxNzvG3M7ojlbmrZmxeSHABfBG5kRHpD9CRTcKLLk7p5lTwElB0RxzMmd6cKAFUEmwLpIDHA07vqrE7LTFBZ1XVgt8AaaYoVmvy+jClC/I3qe/XAmejloYQIx8HrT7+SvHUZlVmPZTBFXyvoGzRksMkgIKfMeSQ5VsJ6mq3IM0f6lUoLbaW9xCiWcEWWbq4PhuyjCYaMxue7UHUqYyN2bzDMHnxETENLYmqeST8MW8bQRcAfYA3jH8vnOp/25p7PhsEeQcgsVtXNn3o5Xz1dCev
 DsgU3o99BWQ6vDQe6xjsLpyhdYwDHJTEXObwInp5vSDQDk33v3aOXtMRORRfkY/X3b1JXU8ER/9JZ0PNfBQxDrHF0rrdBOWjbbxUbGXCKF9ib1Gw/KS+iQHG+poiQJx94/FtsWtEY4lnSG7zbjyvlMFOXdXkhbDzFqH4vqEFlEqxcb2TW3HfmqH4dOB6ym8CYS3LugeiSMy3aW600yIe4gPSu7yWCghGKJmKFxigY/ieFQxocMJFWld7VbD6i7SYtzBIQ1R+etrUFSx1Ylm11Oo8Y6To2pWdC9sSCoIZv/etTKWd3668vw2CLjnoQj3p9FP8XM5LtFKf9ou0+2F1HMjEWLAnNafehDYoKPJNv7nq0Zy4vAgq1L7+s6iK8YNYVpDax5VInpSpIv9AfaGj2xQN424RHVR23ifcZ7G+BynrarW17FSbrR94JmolVING2a40nCdLJCxZ/nK68K9AOSFrZxafFp0yhkb4MutvMChIVkIxDC5Hc4kAforg60Ob8XlSo7yAMQqcQQFLw0ncmVU/VcDeb4T1wtxLNXPXMk6cpNUO7IkYcnSmaNJ238tQomZuz1B6pEoervjxc+am9EIpku60t3iC6CixSAh2cXtqc2K6KUoaaNPZ4MDDJqgN
X-OriginatorOrg: kalrayinc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b5ab6c-7f3d-403a-3050-08dcd0d3d08c
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3766.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 13:32:13.6467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8931925d-7620-4a64-b7fe-20afd86363d3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H193o0aDcdLCRKRnPq76LxZVU6pCxoTsoVS2EGakDqdRFyPtjS+PrvctZcvbCHFpEEn///ZD3AtUSDdHrpuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2580
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






